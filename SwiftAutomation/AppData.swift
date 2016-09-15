//
//  AppData.swift
//  SwiftAutomation
//
//  Swift-AE type conversion and Apple event dispatch
//

import Foundation
import AppKit



// TO DO: what about 'missing value'? for a pure Swift bridge, might be better to use nil rather than Symbol.missingValue; note that Swift's compile-time/run-time treatment of `Any` and `nil` is inconsistent (either flawed or buggy). Q. How will this affect pack/unpack; presumably Optional will need extended same as collections to do its own unpacking?

// TO DO: split into untargeted and targeted classes? or is current arrangement good enough? (mostly it's about returning appropriate app root in unpack)

// TO DO: when unpacking specifiers, may want to use Application instance, not untargeted AppRoot, as their app root (while ObjSpec, etc. instances contain AppData, AppRoot does not, so won't display itself as Application and can't be extracted and used as-is); this will require Application to pass itself as weak-ref to AppData's init

// TO DO: option for caller to pass their own 'customUnpack' func via command, to be called when standard unpack fails (either due to unrecognized AE type or inability to coerce to specified Swift type); this would prob. be done as trailing closure, which takes an AEDesc, required Type, and AppData as arguments and throws or returns value of that type (note that when unpacking list/record, this may be called multiple times, e.g. for the list/record and/or for each item in it)

// TO DO: add `var unpackParentSpecifiers: Bool = false` compatibility flag; note that the simplest and safest (if not the most efficient) way to do this is to call the specifier's `unpackParentSpecifiers(clearCachedDesc:true)` method immediately after unpacking it, though since this option should almost never be needed efficiency isn't a concern (the unpack...Specifier methods could also unroll the specifier chain, of course, but then there'd be two code paths for doing the same thing which isn't ideal maintenance-wise)



public typealias KeywordParameters = [(name: String?, code: OSType, value: Any)]

public typealias RootObjects = (app: RootSpecifier, con: RootSpecifier, its: RootSpecifier)


public struct GlueInfo { // Glue-defined specifier, symbol, and formatter classes; used in (e.g.) AppData.unpack()
    let insertionSpecifierType: InsertionSpecifier.Type
    let objectSpecifierType: ObjectSpecifier.Type
    let multiObjectSpecifierType: ObjectSpecifier.Type
    let rootSpecifierType: RootSpecifier.Type
    let symbolType: Symbol.Type
    let formatter: SpecifierFormatter
    
    public init(insertionSpecifierType: InsertionSpecifier.Type,
                objectSpecifierType: ObjectSpecifier.Type, multiObjectSpecifierType: ObjectSpecifier.Type,
                rootSpecifierType: RootSpecifier.Type, symbolType: Symbol.Type, formatter: SpecifierFormatter) {
    self.insertionSpecifierType = insertionSpecifierType
    self.objectSpecifierType = objectSpecifierType
    self.multiObjectSpecifierType = multiObjectSpecifierType
    self.rootSpecifierType = rootSpecifierType
    self.symbolType = symbolType
    self.formatter = formatter

    }
}


/******************************************************************************/
// extend Swift's standard collection types to pack and unpack themselves


extension Set : SelfPacking, SelfUnpacking {
    
    public func SwiftAE_packSelf(_ appData: AppData) throws -> NSAppleEventDescriptor {
        let desc = NSAppleEventDescriptor.list()
        for item in self { desc.insert(try appData.pack(item), at: 0) }
        return desc
    }
    
    static func SwiftAE_unpackSelf(_ desc: NSAppleEventDescriptor, appData: AppData) throws -> Set<Element> {
        var result = Set<Element>()
        switch desc.descriptorType {
        case typeAEList:
            for i in 1..<(desc.numberOfItems+1) { // bug workaround for zero-length range: 1...0 throws error, but 1..<1 doesn't
                do {
                    result.insert(try appData.unpack(desc.atIndex(i)!, returnType: Element.self))
                } catch {
                    throw UnpackError(appData: appData, descriptor: desc, type: self, message: "Can't unpack item \(i) of list descriptor.")
                }
            }
        default:
            result.insert(try appData.unpack(desc, returnType: Element.self))
        }
        return result
    }
}


extension Array : SelfPacking, SelfUnpacking {
    
    public func SwiftAE_packSelf(_ appData: AppData) throws -> NSAppleEventDescriptor {
        let desc = NSAppleEventDescriptor.list()
        for item in self { desc.insert(try appData.pack(item), at: 0) }
        return desc
    }
    
    static func SwiftAE_unpackSelf(_ desc: NSAppleEventDescriptor, appData: AppData) throws -> [Element] {
        switch desc.descriptorType {
        case typeAEList:
            var result = [Element]()
            for i in 1..<(desc.numberOfItems+1) { // bug workaround for zero-length range: 1...0 throws error, but 1..<1 doesn't
                do {
                    result.append(try appData.unpack(desc.atIndex(i)!, returnType: Element.self))
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
                let array = try appData.unpack(desc, returnType: [Int].self)
                return try self.SwiftAE_unpackSelf(try appData.pack(array), appData: appData)
            }
        default:
            return [try appData.unpack(desc, returnType: Element.self)]
        }
    }
}


extension Dictionary : SelfPacking, SelfUnpacking {
    
    public func SwiftAE_packSelf(_ appData: AppData) throws -> NSAppleEventDescriptor {
        var desc = NSAppleEventDescriptor.record()
        var isCustomRecordType: Bool = false
        if let key = AESymbol(code: SwiftAE_pClass) as? Key, let recordClass = self[key] as? Symbol { // TO DO: confirm this works
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
            } else if !(keySymbol.code == SwiftAE_pClass && isCustomRecordType) {
                desc.setDescriptor(try appData.pack(value), forKeyword: keySymbol.code)
            }
        }
        return desc
    }
    
    static func SwiftAE_unpackSelf(_ desc: NSAppleEventDescriptor, appData: AppData) throws -> [Key:Value] {
        if !desc.isRecordDescriptor {
            throw UnpackError(appData: appData, descriptor: desc, type: self, message: "Not a record.")
        }
        var result = [Key:Value]()
        if desc.descriptorType != typeAERecord {
            if let key = appData.glueInfo.symbolType.symbol(code: SwiftAE_pClass) as? Key,
                    let value = appData.glueInfo.symbolType.symbol(code: desc.descriptorType) as? Value {
                result[key] = value
            }
        }
        for i in 1..<(desc.numberOfItems+1) {
            let property = desc.keywordForDescriptor(at: i)
            if property == SwiftAE_keyASUserRecordFields {
                // unpack record properties whose keys are identifiers (represented as AEList of form: [key1,value1,key2,value2,...])
                let userProperties = desc.atIndex(i)!
                if userProperties.descriptorType == typeAEList && userProperties.numberOfItems % 2 == 0 {
                    for j in stride(from:1, to: userProperties.numberOfItems, by: 2) {
                        let keyDesc = userProperties.atIndex(j)!
                        guard let keyString = keyDesc.stringValue else {
                            throw UnpackError(appData: appData, descriptor: desc, type: Key.self, message: "Malformed record key.")
                        }
                        guard let key = appData.glueInfo.symbolType.symbol(string: keyString, descriptor: keyDesc) as? Key else {
                            throw UnpackError(appData: appData, descriptor: desc, type: Key.self,
                                              message: "Can't unpack record keys as non-Symbol type: \(Key.self)")
                        }
                        do {
                            result[key] = try appData.unpack(desc.atIndex(j+1)!, returnType: Value.self)
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
                    result[key] = try appData.unpack(desc.atIndex(i)!, returnType: Value.self)
                } catch {
                    throw UnpackError(appData: appData, descriptor: desc, type: Value.self,
                                      message: "Can't unpack value of record's \(key) property as Swift type: \(Value.self)")
                }
            }
        }
        return result
    }
}


/******************************************************************************/
// AppData converts values between Swift and AE types, holds target process information, and provides methods for sending Apple events


open class AppData {
    
    // Note: the `isInt64Compatible` flag is currently `true` by default on the assumption that most apps will do the right thing upon receiving `typeUInt32`/`typeSInt64`/`typeUInt64` descriptors (i.e. coerce them to whatever type[s] they actually need), and apps like Excel which only accept `SInt32` and `Double` (which are what AppleScript uses) and fail on anything else are in the minority. If that assumption turns out to be wrong, this flag will need to be made `false` by default (i.e. emulate AppleScript's behavior).
    
    public var isInt64Compatible: Bool = true // some older apps don't accept Int64 (e.g. MS Excel), so set this to false when working with those to pack integers as SInt32/Double only
    
    // note: SpecifierFormatter can use the following when rendering app roots
    public let target: TargetApplication
    public let launchOptions: LaunchOptions
    public let relaunchMode: RelaunchMode
    
    private var _targetDescriptor: NSAppleEventDescriptor? = nil // targetDescriptor() creates an AEAddressDesc for the target process when dispatching first Apple event, caching it here for subsequent reuse; do not access directly
    
    public let glueInfo: GlueInfo // glue-defined specifier and symbol classes, and standard root objects
    
    public var formatter: SpecifierFormatter { return self.glueInfo.formatter }
    
    public private(set) var rootObjects: RootObjects! // note: this will be set by main initializer, but needs to be [implicitly] optional var otherwise compiler will complain about self being used before it's fully initialized
    
    public required init(target: TargetApplication, launchOptions: LaunchOptions,
                         relaunchMode: RelaunchMode, glueInfo: GlueInfo, rootObjects: RootObjects?) { // should be private, but targetedCopy requires it to be required, which in turn requires it to be public; it should not be called directly, however (if an AppData instance is required for standalone use, instantiate the Application class from the default AEApplicationGlue or an application-specific glue, then get its appData property instead)
        self.target = target
        self.launchOptions = launchOptions
        self.relaunchMode = relaunchMode
        self.glueInfo = glueInfo
        // Create untargeted App/Con/Its root specifiers (note that storing these RootSpecifier instances in this AppData instance this creates an uncollectable refcycle between them, but since these objects are only created once per glue and used as global constants, it isn't an issue in practice)
        self.rootObjects = rootObjects ?? (app: glueInfo.rootSpecifierType.init(rootObject: AppRootDesc, appData: self),
                                           con: glueInfo.rootSpecifierType.init(rootObject: ConRootDesc, appData: self),
                                           its: glueInfo.rootSpecifierType.init(rootObject: ItsRootDesc, appData: self))
    }
    
    public convenience init() { // used in Specifier file to keep compiler happy (note: this will leak memory each time it's used, and returned Specifiers will be minimally functional; for general programming tasks, use AEApplication.untargetedAppData instead)
        self.init(glueInfo: GlueInfo(insertionSpecifierType: InsertionSpecifier.self, objectSpecifierType: ObjectSpecifier.self,
                                     multiObjectSpecifierType: ObjectSpecifier.self, rootSpecifierType: RootSpecifier.self,
                                     symbolType: Symbol.self, formatter: SpecifierFormatter())) // TO DO: use AE classes?
    }
    
    // create a new untargeted AppData instance for a glue file's private gUntargetedAppData constant (note: this will leak memory each time it's used so users should not call it themselves; instead, use AEApplication.untargetedAppData to return an already-created instance suitable for general programming tasks)
    public convenience init(glueInfo: GlueInfo) {
        self.init(target: .none, launchOptions: DefaultLaunchOptions, relaunchMode: .never, glueInfo: glueInfo, rootObjects: nil)
    }
    
    // create a targeted copy of a [typically untargeted] AppData instance; Application inits should always use this to create targeted AppData instances
    public func targetedCopy(_ target: TargetApplication, launchOptions: LaunchOptions, relaunchMode: RelaunchMode) -> Self {
        return type(of: self).init(target: target, launchOptions: launchOptions, relaunchMode: relaunchMode,
                                                        glueInfo: self.glueInfo, rootObjects: self.rootObjects)
    }
    
    
    /******************************************************************************/
    // Convert a Swift value to an Apple event descriptor
    
    let MissingValueDesc = NSAppleEventDescriptor(typeCode: SwiftAE_cMissingValue)
    
    private let nsBooleanType = type(of: NSNumber(value: true))
    private let nsNumberType = type(of: NSNumber(value: 1))
    
   
    
    public func pack(_ value: Any) throws -> NSAppleEventDescriptor { // TO DO: what if value is nil? treat as error or pack as missing value? (note that Swift is annoyingly inconsistent on whether nil is/isn't a member of Any, giving compiler error when assigning a nil literal but none when assigning var of type `Whatever?` to `Any`)
//        print("PACKING: \(object) \(object.dynamicType)")
        
        // note: Swift's Bool/Int/Double<->NSNumber bridging sucks, so if an NSNumber instance is received it must be dealt with specially
        if type(of: value) == self.nsBooleanType || value is DarwinBoolean { // test for NSNumber(bool:) or Swift Bool (true/false)
            // important: 
            // - the first test assumes NSNumber class cluster always returns an instance of __NSCFBooleanType (or at least something that can be distinguished from all other NSNumbers)
            // - `value is Bool/Int/Double` always returns true for any NSNumber, so must not be used; however, checking for BooleanType returns true only for Bool (or other Swift types that implement BooleanType protocol) so should be safe
            return NSAppleEventDescriptor(boolean: value as! Bool)
        } else if type(of: value) == self.nsNumberType { // test for any other NSNumber (but not Swift numeric types as those will be dealt with below)
            let numberObj = value as! NSNumber
            switch numberObj.objCType.pointee as Int8 {
            case 98, 99, 67, 115, 83, 105: // (b, c, C, s, S, i) anything that will fit into SInt32 is packed as typeSInt32 for compatibility
                return NSAppleEventDescriptor(int32: numberObj.int32Value)
            case 73: // (I) UInt32
                var val = numberObj.uint32Value
                if self.isInt64Compatible {
                    return NSAppleEventDescriptor(descriptorType: typeUInt32, bytes: &val, length: MemoryLayout<UInt32>.size)!
                } else if val <= UInt32(Int32.max) {
                    return NSAppleEventDescriptor(int32: Int32(val))
                } // else pack as double
            case 108, 113: // (l, q) SInt64
                var val = numberObj.int64Value
                if self.isInt64Compatible {
                    return NSAppleEventDescriptor(descriptorType: typeSInt64, bytes: &val, length: MemoryLayout<Int64>.size)!
                } else if val >= Int64(Int32.min) && val <= Int64(Int32.max) {
                    return NSAppleEventDescriptor(int32: Int32(val))
                } // else pack as double, possibly with some loss of precision
            case 76, 81: // (L, Q) UInt64
                var val = numberObj.uint64Value
                if self.isInt64Compatible {
                    return NSAppleEventDescriptor(descriptorType: typeUInt64, bytes: &val, length: MemoryLayout<UInt64>.size)!
                } else if val <= UInt64(Int32.max) {
                    return NSAppleEventDescriptor(int32: Int32(val))
                } // else pack as double, possibly with some loss of precision
            default:
                ()
            }
            return NSAppleEventDescriptor(double: numberObj.doubleValue)
        }
        switch value {
        // what to use for date, file? NSDate, NSURL/SwiftAEURL?
        // what to use for typeNull? (don't want to use nil; NSNull?) Q. is there any use case where passing AEApp (which always packs itself as typeNull and should always be included in SwiftAutomation) wouldn't be sufficient?
        // what about cMissingValue? (currently Symbol) (TBH, deciding optimal representation for 'missing value' is a somewhat intractable problem since app commands that return Any? will be much more annoying than if they return Any - which is already annoying enough)
        case let obj as NSAppleEventDescriptor:
            return obj
        case let val as SelfPacking:
            return try val.SwiftAE_packSelf(self)
        case var val as Int:
            if Int(Int32.min) <= val && val <= Int(Int32.max) {
                return NSAppleEventDescriptor(int32: Int32(val))
            } else if self.isInt64Compatible {
                return NSAppleEventDescriptor(descriptorType: typeSInt64, bytes: &val, length: MemoryLayout<Int>.size)!
            } else {
                return NSAppleEventDescriptor(double: Double(val)) // caution: may be some loss of precision
            }
        case let val as Double:
            return NSAppleEventDescriptor(double: val)
        case let val as String:
            return NSAppleEventDescriptor(string: val)
        case let obj as Date:
          return NSAppleEventDescriptor(date: obj)
        case let obj as URL:
          return NSAppleEventDescriptor(fileURL: obj) // TO DO: what about packing as typeAlias if it's a bookmark URL?
            
            
        // TO DO: will following cases still be needed? (depends on how transparent Swift's ObjC bridging is)
        case let obj as NSArray:
            return try (obj as Array).SwiftAE_packSelf(self)
        case let obj as NSDictionary:
            return try (obj as Dictionary).SwiftAE_packSelf(self)
            
        
        case var val as UInt:
            if val <= UInt(Int32.max) {
                return NSAppleEventDescriptor(int32: Int32(val))
            } else if self.isInt64Compatible {
                return NSAppleEventDescriptor(descriptorType: typeUInt32, bytes: &val, length: MemoryLayout<UInt>.size)!
            } else {
                return NSAppleEventDescriptor(double: Double(val))
            }
        case let val as Int8:
            return NSAppleEventDescriptor(int32: Int32(val))
        case let val as UInt8:
            return NSAppleEventDescriptor(int32: Int32(val))
        case let val as Int16:
            return NSAppleEventDescriptor(int32: Int32(val))
        case let val as UInt16:
            return NSAppleEventDescriptor(int32: Int32(val))
        case let val as Int32:
            return NSAppleEventDescriptor(int32: Int32(val))
        case var val as UInt32:
            if self.isInt64Compatible {
                return NSAppleEventDescriptor(descriptorType: typeUInt32, bytes: &val, length: MemoryLayout<UInt32>.size)!
            } else if val <= UInt32(Int32.max) {
                return NSAppleEventDescriptor(int32: Int32(val))
            } else {
                return NSAppleEventDescriptor(double: Double(val))
            }
        case var val as Int64:
            if self.isInt64Compatible {
                return NSAppleEventDescriptor(descriptorType: typeSInt64, bytes: &val, length: MemoryLayout<Int64>.size)!
            } else if val >= Int64(Int32.min) && val <= Int64(Int32.max) {
                return NSAppleEventDescriptor(int32: Int32(val))
            } else {
                return NSAppleEventDescriptor(double: Double(val)) // caution: may be some loss of precision
            }
        case var val as UInt64:
            if self.isInt64Compatible {
                return NSAppleEventDescriptor(descriptorType: typeUInt64, bytes: &val, length: MemoryLayout<UInt64>.size)!
            } else if val <= UInt64(Int32.max) {
                return NSAppleEventDescriptor(int32: Int32(val))
            } else {
                return NSAppleEventDescriptor(double: Double(val)) // caution: may be some loss of precision
            }
        case let val as Float:
            return NSAppleEventDescriptor(double: Double(val))
        default: // TO DO: if value is ErrorType, either rethrow it as-is, or poss. chain it to PackError; e.g. see ObjectSpecifier.unpackParentSpecifiers(), which needs to report [rare] errors but can't throw itself; this should allow APIs that can't raise errors directly (e.g. specifier constructors) to have those errors raised if/when used in commands (which can throw)
            throw PackError(object: value)
        }
    }
    
    /******************************************************************************/
    // Convert an Apple event descriptor to the specified Swift type, coercing it as necessary
    
    public func unpack<T>(_ desc: NSAppleEventDescriptor, returnType: T.Type) throws -> T {
        // TO DO: will these tests also match NSString, NSDate, NSArray, etc, or do those need tested for separately?
        if T.self == Any.self || T.self == AnyObject.self {
            return try self.unpack(desc) as! T
        } else if T.self == Bool.self {
            return desc.booleanValue as! T
        } else if T.self == Int.self { // TO DO: what about sized types (Int8, Int16, Int32, Int64); what about UInts?
            if desc.descriptorType == typeSInt32 {
                return Int(desc.int32Value) as! T
            } else if let intDesc = desc.coerce(toDescriptorType: typeSInt64) {
                var result: Int64 = 0
                (intDesc.data as NSData).getBytes(&result, length: MemoryLayout<Int64>.size)
                return Int(result) as! T
            }
        } else if T.self == Double.self { // TO DO: what about Float (typeIEEE32BitFloatingPoint)?
             if let doubleDesc = desc.coerce(toDescriptorType: typeIEEE64BitFloatingPoint) {
                 return Double(doubleDesc.doubleValue) as! T
             }
        } else if T.self == String.self {
            if let result = desc.stringValue { // TO DO: fail if desc is typeType, typeEnumerated, etc.? or convert to name [if known] and return that? (i.e. typeType, etc. can always coerce to typeUnicodeText, but this is misleading and could cause problems e.g. when a value may be string or missingValue)
                return result as! T
            }
        } else if let t = T.self as? SelfUnpacking.Type { // Array, Dictionary
            return try t.SwiftAE_unpackSelf(desc, appData: self) as! T
        } else if T.self is Query.Type { // note: user typically specifies exact class ([PREFIX][Object|Elements]Specifier)
            if let result = try self.unpack(desc) as? T { // specifiers can be composed of several AE types, so unpack first then check type
                return result
            }
        } else if T.self is Symbol.Type {
            if SymbolTypes.contains(desc.descriptorType) {
                return self.unpackSymbol(desc) as! T
            }
        } else if T.self == Date.self {
             if let result = desc.dateValue {
                 return result as! T
             }
        } else if T.self == URL.self {
             if let result = desc.fileURLValue { // TO DO: roundtripping of typeAlias, typeBookmarkData, etc? (as in AppleEventBridge, this'd require a custom NSURL subclass to cache the original descriptor and return it again when repacked)
                 return result as! T
             }
        } else if T.self == NSAppleEventDescriptor.self {
            return desc as! T
        }
        // desc couldn't be coerced to the specified type
        throw UnpackError(appData: self, descriptor: desc, type: T.self, message: "Can't coerce descriptor to Swift type: \(T.self)")
    }
    
    
    /******************************************************************************/
    // Convert an Apple event descriptor to its preferred Swift type, as determined by its descriptorType
    
    public func unpack(_ desc: NSAppleEventDescriptor) throws -> Any { // TO DO: make sure Optional(VALUE) isn't returned, as that allows the possibility of .None (i.e. nil) as well; whereas nil should only be returned if 'cMissingValue' is mapped to nil (and that has yet to be decided on); e.g. use Any!, or will that mess up type signatures elsewhere?
        switch desc.descriptorType {
            // common AE types
        case typeTrue, typeFalse, typeBoolean:
            return desc.booleanValue
        case typeSInt32, typeSInt16:
            return desc.int32Value
        case typeIEEE64BitFloatingPoint, typeIEEE32BitFloatingPoint, type128BitFloatingPoint:
            return desc.doubleValue
        case typeChar, typeIntlText, typeUTF8Text, typeUTF16ExternalRepresentation, typeStyledText, typeUnicodeText, typeVersion:
            return desc.stringValue ?? desc // TO DO: NSAEDesc returns nil on failure (which should only happen here if the desc data is corrupt); return [problematic] desc or throw UnpackError("corrupt data") error? (e.g. unpackable objspecs currently throw rather than return defective desc, and users relying on type system will be confused as to why requesting String fails while Any returns NSDesc)
        case typeLongDateTime:
            return desc.dateValue ?? desc // ditto
        case typeAEList:
            return try Array.SwiftAE_unpackSelf(desc, appData: self) as [Any]
        case typeAERecord:
            return try Dictionary.SwiftAE_unpackSelf(desc, appData: self) as [Symbol:Any]
        case typeAlias, typeBookmarkData, typeFileURL, typeFSRef, SwiftAE_typeFSS:
            return desc.fileURLValue ?? desc // ditto
        case typeType, typeEnumerated, typeProperty, typeKeyword:
            return self.unpackSymbol(desc)
            // object specifiers
        case typeObjectSpecifier:
            return try self.unpackObjectSpecifier(desc)
        case typeInsertionLoc:
            return try self.unpackInsertionLoc(desc)
        case typeRangeDescriptor:
            return try self.unpackRangeDescriptor(desc)
        case typeNull: // null descriptor indicates object specifier root
            return self.appRoot
        case typeCurrentContainer:
            return self.rootObjects.con
        case typeObjectBeingExamined:
            return self.rootObjects.its
        case typeCompDescriptor:
            return try self.unpackCompDescriptor(desc)
        case typeLogicalDescriptor:
            return try self.unpackLogicalDescriptor(desc)
            // less common types
        case typeSInt64:
            var result: Int64 = 0
            (desc.data as NSData).getBytes(&result, length: MemoryLayout<Int64>.size)
            return Int(result)
        case typeUInt64, typeUInt32, typeUInt16:
            var result: UInt64 = 0
            (desc.coerce(toDescriptorType: typeUInt64)!.data as NSData).getBytes(&result, length: MemoryLayout<UInt64>.size)
            return UInt(result)
        case typeQDPoint, typeQDRectangle, typeRGBColor:
            return try self.unpack(desc, returnType: [Int].self)
        default:
            if desc.isRecordDescriptor {
                return try Dictionary.SwiftAE_unpackSelf(desc, appData: self) as [Symbol:Any]
            }
            return desc
        }
    }
    
    
    /******************************************************************************/
    // Supporting methods for unpacking symbols and specifiers
    
    func unpackSymbol(_ desc: NSAppleEventDescriptor) -> Symbol {
        return self.glueInfo.symbolType.symbol(code: desc.typeCodeValue, type: desc.descriptorType, descriptor: desc)
    }
    
    func unpackAEProperty(_ code: OSType) -> Symbol { // used to unpack AERecord keys as Dictionary keys
        return self.glueInfo.symbolType.symbol(code: code, type: typeProperty, descriptor: nil) // TO DO: use typeType? (TBH, am tempted to use it throughout, leaving AEM to coerce as necessary, as it'd simplify implementation a bit; also, note that type and property names can often overlap, e.g. `TED.document` may be either)
    }
    
    var appRoot: RootSpecifier { return self.rootObjects.app } // TO DO: use original Application instance? when unpacking an objspec chain, it would be best if targeted AppData unpacks its main root as Application, and any nested objspecs' roots as App. Main problem is that storing Application instance inside AppData would create cyclic reference, with no obvious way to weakref it. Alternatively, since chain is lazily unpacked, it'd be possible for unpackParentSpecifiers() to instantiate a new Application object at the time (this would mean changing the way that unpackParentSpecifiers works). For now, might be simplest just to instantiate a new Application instance here each time - although that's not ideal for unpacking sub-specifiers (but they might be better unpacked using untargetedAppData); poss. just add an optional arg to unpack() that allows callers to specify which root to use, but picking the right AppData class with which to unpack a nested desc would be cleaner)
    
    func unpackInsertionLoc(_ desc: NSAppleEventDescriptor) throws -> Specifier {
        guard let _ = desc.forKeyword(keyAEObject), // only used to check InsertionLoc record is correctly formed // TO DO: in unlikely event of receiving a malformed record, would be simpler for unpackParentSpecifiers to use a RootSpecifier that throws error on use, avoiding need for extra check here
            let insertionLocation = desc.forKeyword(keyAEPosition) else {
                throw UnpackError(appData: self, descriptor: desc, type: self.glueInfo.insertionSpecifierType,
                    message: "Can't unpack malformed insertion specifier.")
        }
        return self.glueInfo.insertionSpecifierType.init(insertionLocation: insertionLocation, parentQuery: nil, appData: self, cachedDesc: desc)
    }
    
    // TO DO: compatibility option for fully unpacking and repacking object specifiers without caching original desc (i.e. mimic AS behavior exactly)
    func unpackObjectSpecifier(_ desc: NSAppleEventDescriptor) throws -> Specifier {
        guard let _ = desc.forKeyword(SwiftAE_keyAEContainer), // container desc is only used in unpackParentSpecifiers, but confirm its existence
            let wantType = desc.forKeyword(SwiftAE_keyAEDesiredClass),
            let selectorForm = desc.forKeyword(SwiftAE_keyAEKeyForm),
            let selectorDesc = desc.forKeyword(SwiftAE_keyAEKeyData) else {
                throw UnpackError(appData: self, descriptor: desc, type: self.glueInfo.objectSpecifierType,
                    message: "Can't unpack malformed object specifier.")
        }
        do {
            let formCode = selectorForm.enumCodeValue
            // unpack selectorData, unless it's a property code or absolute/relative ordinal
            let selectorData = (formCode == SwiftAE_formPropertyID || formCode == SwiftAE_formRelativePosition
                || (formCode == SwiftAE_formAbsolutePosition && selectorDesc.descriptorType == typeEnumerated
                    && [SwiftAE_kAEFirst, SwiftAE_kAEMiddle, SwiftAE_kAELast, SwiftAE_kAEAny, SwiftAE_kAEAll].contains(selectorDesc.enumCodeValue)))
                ? selectorDesc : try self.unpack(selectorDesc)
            // TO DO: need 'strict AS emulation' option to fully unpack and repack specifiers, re-setting cachedDesc (TBH, only app that ever had this problem was iView Media Pro, since it takes a double whammy of app bugs to cause an app to puke on receiving objspecs it previously created itself)
            if formCode == SwiftAE_formRange || formCode == SwiftAE_formTest || (formCode == SwiftAE_formAbsolutePosition && selectorDesc.enumCodeValue == SwiftAE_kAEAll) {
                return self.glueInfo.multiObjectSpecifierType.init(wantType: wantType, selectorForm: selectorForm, selectorData: selectorData,
                    parentQuery: nil, appData: self, cachedDesc: desc)
            } else {
                return self.glueInfo.objectSpecifierType.init(wantType: wantType, selectorForm: selectorForm, selectorData: selectorData,
                    parentQuery: nil, appData: self, cachedDesc: desc)
            }
        } catch {
            throw UnpackError(appData: self, descriptor: desc, type: self.glueInfo.objectSpecifierType,
                message: "Can't unpack object specifier's selector data.") // TO DO: need to chain errors
        }
    }
    
    func unpackRangeDescriptor(_ desc: NSAppleEventDescriptor) throws -> RangeSelector {
        return try RangeSelector(appData: self, desc: desc)
    }
    
    func unpackCompDescriptor(_ desc: NSAppleEventDescriptor) throws -> TestClause {
        if let operatorType = desc.forKeyword(SwiftAE_keyAECompOperator),
            let operand1Desc = desc.forKeyword(SwiftAE_keyAEObject1),
            let operand2Desc = desc.forKeyword(SwiftAE_keyAEObject2) {
                // TO DO: also check operatorType is valid?
                let operand1 = try self.unpack(operand1Desc), operand2 = try self.unpack(operand2Desc) // TO DO: catch and rethrow with additional details
                if operatorType.typeCodeValue == kAEContains && !(operand1 is ObjectSpecifier) {
                    if let op2 = operand2 as? ObjectSpecifier {
                        return ComparisonTest(operatorType: gIsIn, operand1: op2, operand2: operand1, appData: self, cachedDesc: desc)
                    }
                } else if let op1 = operand1 as? ObjectSpecifier {
                    return ComparisonTest(operatorType: operatorType, operand1: op1, operand2: operand2, appData: self, cachedDesc: desc)
                }
        }
        throw UnpackError(appData: self, descriptor: desc, type: TestClause.self, message: "Can't unpack comparison test: malformed descriptor.")
        
    }
    
    func unpackLogicalDescriptor(_ desc: NSAppleEventDescriptor) throws -> TestClause {
        if let operatorType = desc.forKeyword(SwiftAE_keyAELogicalOperator),
            let operandsDesc = desc.forKeyword(keyAEObject) {
                // TO DO: also check operatorType is valid?
                let operands = try self.unpack(operandsDesc, returnType: [TestClause].self) // TO DO: catch and rethrow with additional details
                return LogicalTest(operatorType: operatorType, operands: operands, appData: self, cachedDesc: desc)
        }
        throw UnpackError(appData: self, descriptor: desc, type: TestClause.self, message: "Can't unpack logical test: malformed descriptor.")
    }
    
    
    /******************************************************************************/
    // get AEAddressDesc for target application
    
    public func targetDescriptor() throws -> NSAppleEventDescriptor? {
        if self._targetDescriptor == nil {
            self._targetDescriptor = try self.target.descriptor(self.launchOptions)
        }
        return self._targetDescriptor!
    }
    
    
    /******************************************************************************/
    // send an Apple event
    
    // timeout constants
    let NoTimeout: TimeInterval = -2
    let DefaultTimeout: TimeInterval = -1

    let DefaultSendMode = NSAppleEventDescriptor.SendOptions.canSwitchLayer
    let DefaultConsiderations = packConsideringAndIgnoringFlags([.case])
    
    let NoResult = Symbol(name: "missingValue", code: SwiftAE_cMissingValue) // TO DO: get rid of this if mapping cMissingValue to nil
    
    // if target process is no longer running, Apple Event Manager will return an error when an event is sent to it
    let RelaunchableErrorCodes: Set<Int> = [-600, -609]
    // if relaunchMode = .Limited, only 'launch' and 'run' are allowed to restart a local application that's been quit
    let LimitedRelaunchEvents: [(OSType,OSType)] = [(kCoreEventClass, kAEOpenApplication), (SwiftAE_kASAppleScriptSuite, SwiftAE_kASLaunchEvent)]
    
    private func send(_ event: NSAppleEventDescriptor, sendMode: NSAppleEventDescriptor.SendOptions, timeout: TimeInterval) throws -> NSAppleEventDescriptor { // used by sendAppleEvent()
        do {
            return try event.sendEvent(options: sendMode, timeout: timeout) // throws NSError on AEM errors (but not app errors)
        } catch { // 'launch' events normally return 'not handled' errors, so just ignore those
            if (error as NSError).code == -1708
                && event.attributeDescriptor(forKeyword: keyEventClassAttr)!.typeCodeValue == SwiftAE_kASAppleScriptSuite
                && event.attributeDescriptor(forKeyword: keyEventIDAttr)!.typeCodeValue == SwiftAE_kASLaunchEvent {
                    return NSAppleEventDescriptor.record() // (not a full AppleEvent desc, but reply event's attributes aren't used so is equivalent to a reply event containing neither error nor result)
            } else {
                throw error
            }
        }
    }
    
    public func sendAppleEvent<T>(_ name: String?, eventClass: OSType, eventID: OSType, // note: human-readable command and parameter names are only used (if known) in error messages
                                  parentSpecifier: Specifier, // the Specifier on which the command method was called; see special-case packing logic below
                                  directParameter: Any, // the first (unnamed) parameter to the command method; see special-case packing logic below
                                  keywordParameters: KeywordParameters, // the remaining named parameters
                                  requestedType: Symbol?, // event's `as` parameter, if any
                                  waitReply: Bool, // wait for application to respond before returning? (default is true)
                                  sendOptions: NSAppleEventDescriptor.SendOptions?, // raw send options (if given, waitReply arg is ignored); default is nil
                                  withTimeout: TimeInterval?, // no. of seconds to wait before raising timeout error (-1712); may also be default/never
                        //        returnID: AEReturnID, // TO DO: need to check correct procedure for this; should send return auto-generated returnID?
                        //        transactionID: AETransactionID,
                                  considering: ConsideringOptions?,
                                  returnType: T.Type) throws -> T // coerce and unpack result as this type or return raw reply event if T is NSDescriptor; default is Any
    {
        // TO DO: all errors occurring within this method should be caught and rethrown as CommandError, allowing error message to include a description of the failed command as well as the error that occurred
        // Create a new AppleEvent descriptor (throws ConnectionError if target app isn't found)
        let event = NSAppleEventDescriptor(eventClass: eventClass, eventID: eventID, targetDescriptor: try self.targetDescriptor(),
                                           returnID: AEReturnID(kAutoGenerateReturnID), transactionID: AETransactionID(kAnyTransactionID)) // workarounds: Carbon constants are incorrectly mapped to Int, and NSAppleEventDescriptor.h currently doesn't define its own
        // pack its keyword parameters
        for (_, code, value) in keywordParameters {
            if value as? Parameters != NoParameter {
                // TO DO: catch pack errors and report (simplest to capture all input and error info in CommandError, and only process/format if displayed)
                event.setDescriptor(try self.pack(value), forKeyword: code)
            }
        }
        // pack event's direct parameter and/or subject attribute
        let hasDirectParameter = directParameter as? Parameters != NoParameter
        if hasDirectParameter { // if the command includes a direct parameter, pack that normally as its direct param
            event.setParam(try self.pack(directParameter), forKeyword: keyDirectObject)
        }
        // if command method was called on root Application (null) object, the event's subject is also null...
        var subjectDesc = AppRootDesc
        // ... but if the command was called on a Specifier, decide if that specifier should be packed as event's subject
        // or, as a special case, used as event's keyDirectObject/keyAEInsertHere parameter for user's convenience
        if !(parentSpecifier is RootSpecifier) { // technically Application, but there isn't an explicit class for that
            if eventClass == kAECoreSuite && eventID == kAECreateElement { // for user's convenience, `make` command is treated as a special case
                // if `make` command is called on a specifier, use that specifier as event's `at` parameter if not already given
                if event.paramDescriptor(forKeyword: keyAEInsertHere) != nil { // an `at` parameter was already given, so pack parent specifier as event's subject attribute
                    subjectDesc = try self.pack(parentSpecifier)
                } else { // else pack parent specifier as event's `at` parameter and use null as event's subject attribute
                    event.setParam(try self.pack(parentSpecifier), forKeyword: keyAEInsertHere)
                }
            } else { // for all other commands, check if a direct parameter was already given
                if hasDirectParameter { // pack the parent specifier as the event's subject attribute
                    subjectDesc = try self.pack(parentSpecifier)
                } else { // else pack parent specifier as event's direct parameter and use null as event's subject attribute
                    event.setParam(try self.pack(parentSpecifier), forKeyword: keyDirectObject)
                }
            }
        }
        event.setAttribute(subjectDesc, forKeyword: SwiftAE_keySubjectAttr)
        // pack requested type (`as`) parameter, if specified; note: most apps ignore this, but a few may recognize it (usually in `get` commands)  even if they don't define it in their dictionary (another AppleScript-introduced quirk)
        if let type = requestedType {
            event.setDescriptor(NSAppleEventDescriptor(typeCode: type.code), forKeyword: keyAERequestedType)
        } else {
            // TO DO: else determine this from returnType (Q. could including `as` param in all commands break stuff? while event handlers are supposed to ignore unrecognized parameters, this doesn't mean they actually will; might be wise to check exactly if/when AS does it; might need an additional option to toggle between 'auto' and 'off', although that's not ideal as it dumps the problem on user)
        }
        // event attributes
        // (note: most apps ignore considering/ignoring attributes, and always ignore case and consider everything else)
        let (considerations, consideringIgnoring) = considering == nil ? DefaultConsiderations : packConsideringAndIgnoringFlags(considering!)
        event.setAttribute(considerations, forKeyword: SwiftAE_enumConsiderations)
        event.setAttribute(consideringIgnoring, forKeyword: SwiftAE_enumConsidsAndIgnores)
        // send the event
        let sendMode = sendOptions ?? DefaultSendMode.union(waitReply ? .waitForReply : .noReply) // TO DO: finalize
        let timeout = withTimeout ?? 120 // TO DO: -sendEvent method's default/no timeout options are currently busted (rdar://21477694)
        
//        defer { print("SENT: \(formatAppleEvent(event, useTerminology: .SDEF))") } // TEST
        var replyEvent: NSAppleEventDescriptor
        do {
//            print("SENDING: \(event)")
            replyEvent = try self.send(event, sendMode: sendMode, timeout: timeout) // throws NSError on AEM error
//            print("REPLIED: \(replyEvent)\n")
        } catch { // handle errors raised by Apple Event Manager (e.g. timeout, process not found)
            if RelaunchableErrorCodes.contains((error as NSError).code) && self.target.isRelaunchable && (self.relaunchMode == .always
                    || (self.relaunchMode == .limited && LimitedRelaunchEvents.contains(where: {$0.0 == eventClass && $0.1 == eventID}))) {
                // event failed as target process has quit since previous event; recreate AppleEvent with new address and resend
                self._targetDescriptor = nil
                let event = NSAppleEventDescriptor(eventClass: eventClass, eventID: eventID, targetDescriptor: try self.targetDescriptor(),
                                                    returnID: AEReturnID(kAutoGenerateReturnID), transactionID: AETransactionID(kAnyTransactionID))
                for i in 1..<(event.numberOfItems+1) {
                    event.setParam(event.atIndex(i)!, forKeyword: event.keywordForDescriptor(at: i))
                }
                for key in [SwiftAE_keySubjectAttr, SwiftAE_enumConsiderations, SwiftAE_enumConsidsAndIgnores] {
                    event.setAttribute(event.attributeDescriptor(forKeyword: key)!, forKeyword: key)
                }
                do {
                    replyEvent = try self.send(event, sendMode: sendMode, timeout: timeout)
                } catch {
                    throw CommandError(appData: self, event: event, parentError: error)
                }
            } else {
                throw CommandError(appData: self, event: event, parentError: error)
            }
        }
        if sendMode.contains(.waitForReply) {
            // if rawReply && (T.self is NSAppleEventDescriptor.Type || T.self is Any.Type) { // TO DO: need explicit 'rawReply' arg/flag
            //    return replyEvent as! T
            // }
            if replyEvent.paramDescriptor(forKeyword: keyErrorNumber)?.int32Value ?? 0 != 0 { // check if an application error occurred
                throw CommandError(appData: self, event: event, replyEvent: replyEvent)
            } else if let resultDesc = replyEvent.paramDescriptor(forKeyword: keyDirectObject) {
                do {
                    return try self.unpack(resultDesc, returnType: T.self) // TO DO: if this fails, rethrow as CommandError
                } catch {
                    throw CommandError(appData: self, event: event, replyEvent: replyEvent, parentError: error)
                }
            }
        }
        if let result = NoResult as? T {
            return result
        } else {
            throw CommandError(appData: self, event: event, message: "No result.")
        }
    }
    
    // convenience shortcut for dispatching events using raw OSType codes only
    
    public func sendAppleEvent<T>(_ eventClass: OSType, eventID: OSType, parentSpecifier: Specifier,
                                  parameters: [OSType:Any] = [:], waitReply: Bool, sendOptions: NSAppleEventDescriptor.SendOptions?,
                                  withTimeout: TimeInterval?, considering: ConsideringOptions?, returnType: T.Type) throws -> T
    {
        var parameters = parameters
        let directParameter = parameters.removeValue(forKey: keyDirectObject) ?? NoParameter
        let keywordParameters: KeywordParameters = parameters.map({(name: nil, code: $0, value: $1)})
        return try self.sendAppleEvent(nil, eventClass: eventClass, eventID: eventID,
            parentSpecifier: parentSpecifier, directParameter: directParameter,
            keywordParameters: keywordParameters, requestedType: nil, waitReply: waitReply,
            sendOptions: sendOptions, withTimeout: withTimeout, considering: considering, returnType: T.self)
    }

}



/******************************************************************************/
// used by AppData.sendAppleEvent() to pack ConsideringOptions as enumConsiderations (old-style) and enumConsidsAndIgnores (new-style) attributes // TO DO: move to AppData?

let gConsiderationsTable: [(Considerations, NSAppleEventDescriptor, UInt32, UInt32)] = [
    // note: Swift mistranslates considering/ignoring mask constants as Int, not UInt32, so redefine them here
    (.case,             NSAppleEventDescriptor(enumCode: SwiftAE_kAECase),              0x00000001, 0x00010000),
    (.diacritic,        NSAppleEventDescriptor(enumCode: SwiftAE_kAEDiacritic),         0x00000002, 0x00020000),
    (.whiteSpace,       NSAppleEventDescriptor(enumCode: SwiftAE_kAEWhiteSpace),        0x00000004, 0x00040000),
    (.hyphens,          NSAppleEventDescriptor(enumCode: SwiftAE_kAEHyphens),           0x00000008, 0x00080000),
    (.expansion,        NSAppleEventDescriptor(enumCode: SwiftAE_kAEExpansion),         0x00000010, 0x00100000),
    (.punctuation,      NSAppleEventDescriptor(enumCode: SwiftAE_kAEPunctuation),       0x00000020, 0x00200000),
    (.numericStrings,   NSAppleEventDescriptor(enumCode: SwiftAE_kASNumericStrings),    0x00000080, 0x00800000),
]

private func packConsideringAndIgnoringFlags(_ considerations: ConsideringOptions) -> (NSAppleEventDescriptor, NSAppleEventDescriptor) {
    let considerationsListDesc = NSAppleEventDescriptor.list()
    var consideringIgnoringFlags: UInt32 = 0
    for (consideration, considerationDesc, consideringMask, ignoringMask) in gConsiderationsTable {
        if considerations.contains(consideration) {
            consideringIgnoringFlags |= consideringMask
            considerationsListDesc.insert(considerationDesc, at: 0)
        } else {
            consideringIgnoringFlags |= ignoringMask
        }
    }
    return (considerationsListDesc, UInt32Descriptor(consideringIgnoringFlags)) // old-style flags (list of enums), new-style flags (bitmask)
}

