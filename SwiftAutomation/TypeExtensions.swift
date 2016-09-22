//
//  TypeExtensions.swift
//  SwiftAE
//
//

import Foundation


/******************************************************************************/
// Specifier and Symbol subclasses pack themselves
// Set, Array, Dictionary structs pack and unpack themselves
// Optional and MayBeMissing enums pack and unpack themselves

// note that packSelf/unpackSelf protocol methods are mixed in to standard Swift types (Array, Dictionary, etc), hence the `SwiftAutomation_` prefixes for maximum paranoia

public protocol SelfPacking {
    func SwiftAutomation_packSelf(_ appData: AppData) throws -> NSAppleEventDescriptor
}

protocol SelfUnpacking {
    static func SwiftAutomation_unpackSelf(_ desc: NSAppleEventDescriptor, appData: AppData) throws -> Self
}


/******************************************************************************/
// `missing value` constant

// note: this design is not yet finalized (ideally we'd just map cMissingValue to nil, but returning nil for commands whose return type is `Any` is a PITA as all of Swift's normal unboxing techniques break, and the only way to unbox is to cast from Any to Optional<T> first, which in turn requires that T is known in advance, in which case what's the point of returning Any in the first place?)

let missingValueDesc = NSAppleEventDescriptor(typeCode: SwiftAutomation_cMissingValue)


// unlike Swift's `nil` (which is actually an infinite number of values since Optional<T>.none is generic), there is only ever one `MissingValue`, which means it should behave sanely when cast to and from `Any`

public enum MissingValueType: CustomStringConvertible, SelfPacking {
    
    case missingValue
    
    init() { self = .missingValue }
    
    public func SwiftAutomation_packSelf(_ appData: AppData) throws -> NSAppleEventDescriptor {
        return missingValueDesc
    }
    
    public var description: String { return "MissingValue" }
}

public let MissingValue = MissingValueType() // the `missing value` constant, basically an analog of `Optional<T>.none`, aka `nil`, except that it's non-generic so isn't a giant PITA to deal with when cast to/from `Any` // TO DO: not sure about capitalization here; may be best to make exception from standard Swift naming convention for visual clarity


// TO DO: define `==`/`!=` operators that treat MayBeMissing<T>.missing(…) and MissingValue and Optional<T>.none as equivalent? Or get rid of `MayBeMissing` enum and (if possible/practical) support `Optional<T> as? MissingValueType` and vice-versa?

// define a generic type for use in command's return type that allows the value to be missing, e.g. `Contacts().people.birthDate.get() as [MayBeMissing<String>]`

// TO DO: it may be simpler for users if commands always return Optional<T>.none when an Optional return type is specified, and MissingValue when one is not

public enum MayBeMissing<T>: SelfPacking, SelfUnpacking { // TO DO: rename 'MissingOr<T>'? this'd be more in keeping with TypeSupportSpec-generated enum names (e.g. 'IntOrStringOrMissing')
    case value(T)
    case missing
    
    public init(_ value: T) {
        switch value {
        case is MissingValueType:
            self = .missing
        default:
            self = .value(value)
        }
    }
    
    public init() {
        self = .missing
    }
    
    public func SwiftAutomation_packSelf(_ appData: AppData) throws -> NSAppleEventDescriptor {
        switch self {
        case .value(let value):
            return try appData.pack(value)
        case .missing:
            return missingValueDesc
        }
    }
    
    public static func SwiftAutomation_unpackSelf(_ desc: NSAppleEventDescriptor, appData: AppData) throws -> MayBeMissing<T> {
        if isMissingValue(desc) {
            return MayBeMissing<T>.missing
        } else {
            return MayBeMissing<T>.value(try appData.unpack(desc) as T)
        }
    }
    
    public var value: T? { // unbox the actual value, or return `nil` if it was MissingValue; this should allow users to bridge safely from MissingValue to nil
        switch self {
        case .value(let value):
            return value
        case .missing:
            return nil
        }
    }
}


func isMissingValue(_ desc: NSAppleEventDescriptor) -> Bool { // check if the given AEDesc is the `missing value` constant
    return desc.descriptorType == typeType && desc.typeCodeValue == SwiftAutomation_cMissingValue
}

// allow optionals to be used in place of MayBeMissing… arguably, MayBeMissing won't be needed if this works

extension Optional: SelfPacking, SelfUnpacking {
    
    public func SwiftAutomation_packSelf(_ appData: AppData) throws -> NSAppleEventDescriptor {
        switch self {
        case .some(let value):
            return try appData.pack(value)
        case .none:
            return missingValueDesc
        }
    }
    
    public static func SwiftAutomation_unpackSelf(_ desc: NSAppleEventDescriptor, appData: AppData) throws -> Optional<Wrapped> {
        if isMissingValue(desc) {
            return Optional<Wrapped>.none
        } else {
            return Optional<Wrapped>.some(try appData.unpack(desc))
        }
    }
}


/******************************************************************************/
// extend Swift's standard collection types to pack and unpack themselves


extension Set: SelfPacking, SelfUnpacking { // note: AEM doesn't define a standard AE type for Sets, so pack/unpack as typeAEList (we'll assume client code has its own reasons for suppling/requesting Set<T> instead of Array<T>)
    
    public func SwiftAutomation_packSelf(_ appData: AppData) throws -> NSAppleEventDescriptor {
        let desc = NSAppleEventDescriptor.list()
        for item in self { desc.insert(try appData.pack(item), at: 0) }
        return desc
    }
    
    static func SwiftAutomation_unpackSelf(_ desc: NSAppleEventDescriptor, appData: AppData) throws -> Set<Element> {
        var result = Set<Element>()
        switch desc.descriptorType {
        case typeAEList:
            for i in 1..<(desc.numberOfItems+1) { // bug workaround for zero-length range: 1...0 throws error, but 1..<1 doesn't
                do {
                    result.insert(try appData.unpack(desc.atIndex(i)!) as Element)
                } catch {
                    throw UnpackError(appData: appData, descriptor: desc, type: self, message: "Can't unpack item \(i) of list descriptor.")
                }
            }
        default:
            result.insert(try appData.unpack(desc) as Element)
        }
        return result
    }
}


extension Array: SelfPacking, SelfUnpacking {
    
    public func SwiftAutomation_packSelf(_ appData: AppData) throws -> NSAppleEventDescriptor {
        let desc = NSAppleEventDescriptor.list()
        for item in self { desc.insert(try appData.pack(item), at: 0) }
        return desc
    }
    
    static func SwiftAutomation_unpackSelf(_ desc: NSAppleEventDescriptor, appData: AppData) throws -> [Element] {
        switch desc.descriptorType {
        case typeAEList:
            var result = [Element]()
            for i in 1..<(desc.numberOfItems+1) { // bug workaround for zero-length range: 1...0 throws error, but 1..<1 doesn't
                do {
                    result.append(try appData.unpack(desc.atIndex(i)!) as Element)
                } catch {
                    throw UnpackError(appData: appData, descriptor: desc, type: self,
                                      message: "Can't unpack item \(i) of list descriptor.")
                }
            }
            return result
        case typeQDPoint, typeQDRectangle, typeRGBColor: // short[2], short[4], unsigned short[3] (used by older Carbon apps; Cocoa apps use lists)
            // note: coercing these types to typeAEList and unpacking those would be simpler, but while AEM provides coercion handlers for coercing e.g. typeAEList to typeQDPoint, it doesn't provide handlers for the reverse (coercing a typeQDPoint desc to typeAEList merely produces a single-item AEList containing the original typeQDPoint, not a 2-item AEList of typeSInt16)
            if Element.self == Int.self { // common case
                var result = [Element]()
                let data = desc.data
                for i in 0..<([typeQDPoint:2, typeQDRectangle:4, typeRGBColor:3][desc.descriptorType]!) {
                    var n: Int16 = 0
                    (data as NSData).getBytes(&n, range: NSRange(location: i*MemoryLayout<Int16>.size, length: MemoryLayout<Int16>.size))
                    result.append(Int(n) as! Element) // note: can't use Element(n) here as Swift doesn't define integer constructors in IntegerType protocol (but does for FloatingPointType)
                }
                return result
            } else { // for any other Element, unpack as Int then repack as AEList of typeSInt32, and [try to] unpack that as [Element] (bit lazy, but will do)
                let array = try appData.unpack(desc) as [Int]
                return try self.SwiftAutomation_unpackSelf(try appData.pack(array), appData: appData)
            }
        default:
            return [try appData.unpack(desc) as Element]
        }
    }
}


extension Dictionary: SelfPacking, SelfUnpacking {
    
    public func SwiftAutomation_packSelf(_ appData: AppData) throws -> NSAppleEventDescriptor {
        var desc = NSAppleEventDescriptor.record()
        var isCustomRecordType: Bool = false
        if let key = AESymbol(code: SwiftAutomation_pClass) as? Key, let recordClass = self[key] as? Symbol { // TO DO: confirm this works
            if !recordClass.nameOnly {
                desc = desc.coerce(toDescriptorType: recordClass.code)!
                isCustomRecordType = true
            }
        }
        var userProperties: NSAppleEventDescriptor?
        for (key, value) in self {
            guard let keySymbol = key as? Symbol else {
                throw PackError(object: key, message: "Can't pack non-Symbol dictionary key of type: \(type(of: key))")
            }
            if keySymbol.nameOnly {
                if userProperties == nil {
                    userProperties = NSAppleEventDescriptor.list()
                }
                userProperties?.insert(try appData.pack(keySymbol), at: 0)
                userProperties?.insert(try appData.pack(value), at: 0)
            } else if !(keySymbol.code == SwiftAutomation_pClass && isCustomRecordType) {
                desc.setDescriptor(try appData.pack(value), forKeyword: keySymbol.code)
            }
        }
        return desc
    }
    
    static func SwiftAutomation_unpackSelf(_ desc: NSAppleEventDescriptor, appData: AppData) throws -> [Key:Value] {
        if !desc.isRecordDescriptor {
            throw UnpackError(appData: appData, descriptor: desc, type: self, message: "Not a record.")
        }
        var result = [Key:Value]()
        if desc.descriptorType != typeAERecord {
            if let key = appData.glueClasses.symbolType.symbol(code: SwiftAutomation_pClass) as? Key,
                let value = appData.glueClasses.symbolType.symbol(code: desc.descriptorType) as? Value {
                result[key] = value
            }
        }
        for i in 1..<(desc.numberOfItems+1) {
            let property = desc.keywordForDescriptor(at: i)
            if property == SwiftAutomation_keyASUserRecordFields {
                // unpack record properties whose keys are identifiers (represented as AEList of form: [key1,value1,key2,value2,...])
                let userProperties = desc.atIndex(i)!
                if userProperties.descriptorType == typeAEList && userProperties.numberOfItems % 2 == 0 {
                    for j in stride(from:1, to: userProperties.numberOfItems, by: 2) {
                        let keyDesc = userProperties.atIndex(j)!
                        guard let keyString = keyDesc.stringValue else {
                            throw UnpackError(appData: appData, descriptor: desc, type: Key.self, message: "Malformed record key.")
                        }
                        guard let key = appData.glueClasses.symbolType.symbol(string: keyString, descriptor: keyDesc) as? Key else {
                            throw UnpackError(appData: appData, descriptor: desc, type: Key.self,
                                              message: "Can't unpack record keys as non-Symbol type: \(Key.self)")
                        }
                        do {
                            result[key] = try appData.unpack(desc.atIndex(j+1)!) as Value
                        } catch {
                            throw UnpackError(appData: appData, descriptor: desc, type: Value.self,
                                              message: "Can't unpack value of record's \(key) property as Swift type: \(Value.self)")
                        }
                    }
                } else {
                    
                }
            } else {
                // unpack record property whose key is a four-char code (typically corresponding to a dictionary-defined property name)
                guard let key = appData.unpackAEProperty(property) as? Key else {
                    throw UnpackError(appData: appData, descriptor: desc, type: Key.self,
                                      message: "Can't unpack record keys as non-Symbol type: \(Key.self)")
                }
                do {
                    result[key] = try appData.unpack(desc.atIndex(i)!) as Value
                } catch {
                    throw UnpackError(appData: appData, descriptor: desc, type: Value.self,
                                      message: "Can't unpack value of record's \(key) property as Swift type: \(Value.self)")
                }
            }
        }
        return result
    }
}




// specialized return type for use in commands to return the _entire_ reply AppleEvent as a raw AppleEvent descriptor

public struct ReplyEventDescriptor {
    
    let descriptor: NSAppleEventDescriptor // the reply AppleEvent
    
    public var result: NSAppleEventDescriptor? { // the application-returned result value, if any
        return descriptor.paramDescriptor(forKeyword: keyDirectObject)
    }
    
    public var errorNumber: Int { // the application-returned error number, if any; 0 = noErr
        return Int(descriptor.paramDescriptor(forKeyword: keyErrorNumber)?.int32Value ?? 0)
    }
}
