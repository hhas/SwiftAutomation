//
//  TypeExtensions.swift
//  SwiftAutomation
//
//  Extends Swift's generic Optional and collection types so that they pack and unpack themselves (since Swift lacks the dynamic introspection capabilities for AppData to determine how to pack and unpack them itself)
//

import Foundation
import Carbon


/******************************************************************************/
// Specifier and Symbol subclasses pack themselves
// Set, Array, Dictionary structs pack and unpack themselves
// Optional and MayBeMissing enums pack and unpack themselves

// note that packSelf/unpackSelf protocol methods are mixed in to standard Swift types (Array, Dictionary, etc), hence the `SwiftAutomation_` prefixes for maximum paranoia

public protocol SelfPacking {
    func SwiftAutomation_packSelf(_ appData: AppData) throws -> AEDesc // caller takes ownership
}

public protocol SelfUnpacking {
    static func SwiftAutomation_unpackSelf(_ desc: AEDesc, appData: AppData) throws -> Self // TO DO: takes ownership? (probably makes sense to do so: descs are thrown away otherwise)
    static func SwiftAutomation_noValue() throws -> Self
}


public protocol SelfFormatting {
    func SwiftAutomation_formatSelf(_ formatter: SpecifierFormatter) -> String
}


/******************************************************************************/
// `missing value` constant

// note: this design is not yet finalized (ideally we'd just map cMissingValue to nil, but returning nil for commands whose return type is `Any` is a PITA as all of Swift's normal unboxing techniques break, and the only way to unbox is to cast from Any to Optional<T> first, which in turn requires that T is known in advance, in which case what's the point of returning Any in the first place?)

let missingValueDesc = AEDesc(typeCode: DescType(cMissingValue))


// unlike Swift's `nil` (which is actually an infinite number of values since Optional<T>.none is generic), there is only ever one `MissingValue`, which means it should behave sanely when cast to and from `Any`

public enum MissingValueType: CustomStringConvertible, SelfPacking, SelfUnpacking {
    
    case missingValue
    
    init() { self = .missingValue }
    
    public func SwiftAutomation_packSelf(_ appData: AppData) throws -> AEDesc {
        return missingValueDesc.copy()
    }
    
    public static func SwiftAutomation_unpackSelf(_ desc: AEDesc, appData: AppData) throws -> MissingValueType {
        desc.dispose()
        return MissingValue
    }
    
    public static func SwiftAutomation_noValue() throws -> MissingValueType { return MissingValueType() }
    
    public var description: String { return "MissingValue" }
}

public let MissingValue = MissingValueType() // the `missing value` constant; serves a similar purpose to `Optional<T>.none` (`nil`), except that it's non-generic so isn't a giant PITA to deal with when casting to/from `Any`


// TO DO: define `==`/`!=` operators that treat MayBeMissing<T>.missing(…) and MissingValue and Optional<T>.none as equivalent? Or get rid of `MayBeMissing` enum and (if possible/practical) support `Optional<T> as? MissingValueType` and vice-versa?

// define a generic type for use in command's return type that allows the value to be missing, e.g. `Contacts().people.birthDate.get() as [MayBeMissing<String>]`

// TO DO: it may be simpler for users if commands always return Optional<T>.none when an Optional return type is specified, and MissingValue when one is not

public enum MayBeMissing<T>: SelfPacking, SelfUnpacking { // TO DO: rename 'MissingOr<T>'? this'd be more in keeping with TypeSupportSpec-generated enum names (e.g. 'IntOrStringOrMissing')
    case value(T)
    case missing(MissingValueType)
    
    public init(_ value: T) {
        switch value {
        case is MissingValueType:
            self = .missing(MissingValue)
        default:
            self = .value(value)
        }
    }
    
    public init() {
        self = .missing(MissingValue)
    }
    
    public func SwiftAutomation_packSelf(_ appData: AppData) throws -> AEDesc {
        switch self {
        case .value(let value):
            return try appData.pack(value)
        case .missing(_):
            return missingValueDesc.copy()
        }
    }
    
    public static func SwiftAutomation_unpackSelf(_ desc: AEDesc, appData: AppData) throws -> MayBeMissing<T> {
        if isMissingValue(desc) {
            desc.dispose()
            return MayBeMissing<T>.missing(MissingValue)
        } else {
            return MayBeMissing<T>.value(try appData.unpack(desc) as T) // unpack takes ownership
        }
    }
    
    public static func SwiftAutomation_noValue() throws -> MayBeMissing<T> { return MayBeMissing<T>() }
    
    public var value: T? { // unbox the actual value, or return `nil` if it was MissingValue; this should allow users to bridge safely from MissingValue to nil
        switch self {
        case .value(let value):
            return value
        case .missing(_):
            return nil
        }
    }
}


func isMissingValue(_ desc: AEDesc) -> Bool { // check if the given AEDesc is the `missing value` constant
    return desc.descriptorType == typeType && (try? desc.fourCharCode()) == DescType(cMissingValue)
}

// allow optionals to be used in place of MayBeMissing… arguably, MayBeMissing won't be needed if this works

extension Optional: SelfPacking, SelfUnpacking {
    
    public func SwiftAutomation_packSelf(_ appData: AppData) throws -> AEDesc {
        switch self {
        case .some(let value):
            return try appData.pack(value)
        case .none:
            return missingValueDesc.copy()
        }
    }
    
    public static func SwiftAutomation_unpackSelf(_ desc: AEDesc, appData: AppData) throws -> Optional<Wrapped> {
        if isMissingValue(desc) {
            desc.dispose()
            return Optional<Wrapped>.none
        } else {
            return Optional<Wrapped>.some(try appData.unpack(desc)) // unpack takes ownership
        }
    }
    
    public static func SwiftAutomation_noValue() throws -> Optional<Wrapped> { return Optional<Wrapped>.none }
}


/******************************************************************************/
// extend Swift's standard collection types to pack and unpack themselves


extension Set: SelfPacking, SelfUnpacking, SelfFormatting { // note: AEM doesn't define a standard AE type for Sets, so pack/unpack as typeAEList (we'll assume client code has its own reasons for suppling/requesting Set<T> instead of Array<T>)
    
    public func SwiftAutomation_formatSelf(_ formatter: SpecifierFormatter) -> String {
        return "[\(self.map{ formatter.format($0) }.joined(separator: ", "))]"
    }
    
    public func SwiftAutomation_packSelf(_ appData: AppData) throws -> AEDesc {
        let desc = AEDesc.list()
        do {
            for item in self {
                let tmp = try appData.pack(item)
                defer { tmp.dispose() }
                try desc.appendItem(tmp)
            }
        } catch {
            desc.dispose()
            throw error
        }
        return desc
    }
    
    public static func SwiftAutomation_unpackSelf(_ desc: AEDesc, appData: AppData) throws -> Set<Element> {
        var result = Set<Element>()
        switch desc.descriptorType {
        case typeAEList:
            for i in 1..<(try! desc.count()+1) {
                do {
                    result.insert(try appData.unpack(desc.item(i).value) as Element) // unpack takes ownership
                } catch {
                    throw UnpackError(appData: appData, desc: desc, type: self, message: "Can't unpack item \(i) as \(Element.self).")
                }
            }
            desc.dispose()
        default:
            result.insert(try appData.unpack(desc) as Element)
        }
        return result
    }
    
    public static func SwiftAutomation_noValue() throws -> Set<Element> { return Set<Element>() }
}


extension Array: SelfPacking, SelfUnpacking, SelfFormatting {
    
    public func SwiftAutomation_formatSelf(_ formatter: SpecifierFormatter) -> String {
        return "[\(self.map{ formatter.format($0) }.joined(separator: ", "))]"
    }
    
    public func SwiftAutomation_packSelf(_ appData: AppData) throws -> AEDesc {
        let listDesc = AEDesc.list()
        do {
            for item in self {
                let itemDesc = try appData.pack(item)
                defer { itemDesc.dispose() }
                try listDesc.appendItem(itemDesc)
            }
        } catch {
            listDesc.dispose()
            throw error
        }
        return listDesc
    }
    
    private static func unpackAsFixedArray<T: FixedWidthInteger>(_ desc: AEDesc, appData: AppData, of itemType: T.Type, inOrder indexes: [Int]) throws -> [Element] { // takes ownership
        let value = try desc.unpackFixedArray(of: T.self, inOrder: indexes)
        desc.dispose()
        if let result = value as? [Element] { // [Int] common case
            return result
        } else { // for any other Element, repack and unpack
            return try self.SwiftAutomation_unpackSelf(try appData.pack(value), appData: appData)
        }
    }
    
    public static func SwiftAutomation_unpackSelf(_ desc: AEDesc, appData: AppData) throws -> [Element] {
        switch desc.descriptorType {
        case typeAEList:
            var result = [Element]()
            for i in 1..<(try! desc.count()+1) { // bug workaround for zero-length range: 1...0 throws error, but 1..<1 doesn't
                do {
                    result.append(try appData.unpack(desc.item(i).value) as Element)
                } catch {
                    // this takes ownership of desc
                    throw UnpackError(appData: appData, desc: desc, type: self, message: "Can't unpack item \(i) as \(Element.self).")
                }
            }
            desc.dispose()
            return result
            // note: coercing QD types to typeAEList and unpacking those would be simpler, but while AEM provides coercion handlers for coercing e.g. typeAEList to typeQDPoint, it doesn't provide handlers for the reverse (coercing a typeQDPoint desc to typeAEList merely produces a single-item AEList containing the original typeQDPoint, not a 2-item AEList of typeSInt16)
        case typeQDPoint: // SInt16[2]
            return try self.unpackAsFixedArray(desc, appData: appData, of: Int16.self, inOrder: [1,0]) // QDPoint is YX; swap to give [X,Y]
        case typeQDRectangle: // SInt16[4]
            return try self.unpackAsFixedArray(desc, appData: appData, of: Int16.self, inOrder: [1,0,3,2]) // QDPoint is Y0X0Y1X1; swap to give [X0,Y0,X1,Y1]
        case typeRGBColor: // UInt16[3] (used by older Carbon apps; Cocoa apps use lists)
            return try self.unpackAsFixedArray(desc, appData: appData, of: UInt16.self, inOrder: [0,1,2])
        default:
            return [try appData.unpack(desc) as Element]
        }
    }
    
    public static func SwiftAutomation_noValue() throws -> Array<Element> { return Array<Element>() }
}


extension Dictionary: SelfPacking, SelfUnpacking, SelfFormatting {
    
    public func SwiftAutomation_formatSelf(_ formatter: SpecifierFormatter) -> String {
        return self.count == 0 ? "[:]" : "[\(self.map{ "\(formatter.format($0)): \(formatter.format($1))" }.joined(separator: ", "))]"
    }
    
    public func SwiftAutomation_packSelf(_ appData: AppData) throws -> AEDesc {
        var recordDesc = AEDesc.record()
        var isCustomRecordType: Bool = false
        if let key = AESymbol(code: pClass) as? Key, let recordClass = self[key] as? Symbol { // TO DO: confirm this works
            if !recordClass.isNameOnly {
                recordDesc.descriptorType = recordClass.code
                isCustomRecordType = true
            }
        }
        var userProperties: AEDesc?
        defer {
            if let listDesc = userProperties {
                try! recordDesc.setParameter(DescType(keyASUserRecordFields), to: listDesc)
                listDesc.dispose()
            }
        }
        for (key, value) in self {
            guard let keySymbol = key as? Symbol else {
                throw PackError(object: key, message: "Can't pack non-Symbol dictionary key of type: \(type(of: key))")
            }
            if keySymbol.isNameOnly {
                if userProperties == nil { userProperties = AEDesc.list() }
                let keyDesc = try appData.pack(keySymbol)
                defer { keyDesc.dispose() }
                try userProperties!.appendItem(keyDesc)
                let valueDesc = try appData.pack(value)
                defer { valueDesc.dispose() }
                try userProperties!.appendItem(valueDesc)
            } else if !(keySymbol.code == pClass && isCustomRecordType) {
                let tmp = try appData.pack(value)
                defer { tmp.dispose() }
                try! recordDesc.setParameter(keySymbol.code, to: tmp)
            }
        }
        return recordDesc
    }
    
    public static func SwiftAutomation_unpackSelf(_ desc: AEDesc, appData: AppData) throws -> [Key:Value] {
        if !desc.isRecord {
            throw UnpackError(appData: appData, desc: desc, type: self, message: "Not a record.")
        }
        var result = [Key:Value]()
        if desc.descriptorType != typeAERecord {
            if let key = appData.glueClasses.symbolType.symbol(code: pClass) as? Key,
                let value = appData.glueClasses.symbolType.symbol(code: desc.descriptorType) as? Value {
                result[key] = value
            }
        }
        for i in 1..<(try! desc.count()+1) {
            let (property, itemDesc) = try! desc.item(i)
            defer { itemDesc.dispose() }
            if property == keyASUserRecordFields {
                // unpack record properties whose keys are identifiers (represented as AEList of form: [key1,value1,key2,value2,...])
                let userProperties = itemDesc
                if userProperties.descriptorType == typeAEList && (try! userProperties.count()) % 2 == 0 {
                    for j in stride(from:1, to: try! userProperties.count(), by: 2) {
                        let keyDesc = try! userProperties.item(j).value
                        guard let keyString = try? keyDesc.string() else {
                            throw UnpackError(appData: appData, desc: desc, type: Key.self, message: "Malformed record key.")
                        }
                        guard let key = appData.glueClasses.symbolType.symbol(string: keyString, descriptor: keyDesc) as? Key else {
                            throw UnpackError(appData: appData, desc: desc, type: Key.self,
                                              message: "Can't unpack record keys as non-Symbol type: \(Key.self)")
                        }
                        do {
                            result[key] = try appData.unpack(desc.item(j+1).value) as Value
                        } catch {
                            throw UnpackError(appData: appData, desc: desc, type: Value.self,
                                              message: "Can't unpack value of record's \(key) property as Swift type: \(Value.self)")
                        }
                    }
                } else { // TO DO: not sure what AS's behavior is; does it unpack as single property or report as error? check and amend if needed (main rationale for throwing is that returned record would vary wildly in structure depending the property's value; which is not to say AS wouldn't do it, but it'd be poor design if it did; plus we already throw if odd items aren't strings)
                    throw UnpackError(appData: appData, desc: desc, type: Value.self,
                                      message: "Can't unpack record: malformed keyASUserRecordFields value.")
                }
            } else {
                // unpack record property whose key is a four-char code (typically corresponding to a dictionary-defined property name)
                guard let key = appData.recordKey(forCode: property) as? Key else {
                    throw UnpackError(appData: appData, desc: desc, type: Key.self,
                                      message: "Can't unpack record keys as non-Symbol type: \(Key.self)")
                }
                do {
                    result[key] = try appData.unpack(itemDesc) as Value
                } catch {
                    throw UnpackError(appData: appData, desc: desc, type: Value.self,
                                      message: "Can't unpack value of record's \(key) property as Swift type: \(Value.self)")
                }
            }
        }
        desc.dispose()
        return result
    }
    
    public static func SwiftAutomation_noValue() throws -> Dictionary<Key,Value> { return Dictionary<Key,Value>() }
}




// specialized return type for use in commands to return the _entire_ reply AppleEvent as a raw AppleEvent descriptor (to return just the result as descriptor, use AppleEventDescriptor as return type)

public class ReplyAppleEvent: AppleEventDescriptor {
    
    public var result: AppleEventDescriptor? { // the application-returned result value, if any
        return try? AppleEventDescriptor(desc: self.desc.parameter(keyDirectObject))
    }
    
    public var errorNumber: Int { // the application-returned error number, if any; 0 = noErr
        return self.desc.errorNumber
    }
}

