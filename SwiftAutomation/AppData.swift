//
//  AppData.swift
//  SwiftAutomation
//
//  Swift-AE type conversion and Apple event dispatch
//

import Foundation
import AppKit

// TO DO: get rid of waitReply: arg and just pass .ignoreReply to sendOptions (if ignore/wait/queue option not given, add .waitReply by default)

// TO DO: 'considering' arg is misnamed: by default it takes [.case], which is the text attributes to *ignore*; FIX!!! (also need to review the  relevant code and the packed AE attributes against AS's, to see what it's doing; these flags are an absolute mess even without semantic/logic errors creeping into code here)


// TO DO: there are some inbuilt assumptions about `Int` and `UInt` always being 64-bit


let defaultTimeout: TimeInterval = 120 // bug workaround: NSAppleEventDescriptor.sendEvent(options:timeout:) method's support for kAEDefaultTimeout=-1 and kNoTimeOut=-2 flags is buggy <rdar://21477694>, so for now the default timeout is hardcoded here as 120sec (same as in AS)

let defaultConsidering: ConsideringOptions = [.case]

let defaultConsidersIgnoresMask: UInt32 = 0x00010000 // AppleScript ignores case by default



public typealias KeywordParameter = (name: String?, code: OSType, value: Any)



public struct GlueClasses {
    // Glue-defined specifier and symbol classes; AppData.unpack() instantiates these when unpacking the corresponding AEDescs
    let insertionSpecifierType: InsertionSpecifier.Type // PREFIXInsertion
    let objectSpecifierType: ObjectSpecifier.Type       // PREFIXItem
    let multiObjectSpecifierType: ObjectSpecifier.Type  // PREFIXItems
    let rootSpecifierType: RootSpecifier.Type           // PREFIXApp/PREFIXCon/PREFIXIts
    let applicationType: RootSpecifier.Type             // APPLICATION
    let symbolType: Symbol.Type                         // PREFIXSymbol
    let formatter: SpecifierFormatter // used by Query.description to render literal representation of itself
    
    public init(insertionSpecifierType: InsertionSpecifier.Type, objectSpecifierType: ObjectSpecifier.Type,
                multiObjectSpecifierType: ObjectSpecifier.Type, rootSpecifierType: RootSpecifier.Type,
                applicationType: RootSpecifier.Type, symbolType: Symbol.Type, formatter: SpecifierFormatter) {
        self.insertionSpecifierType = insertionSpecifierType
        self.objectSpecifierType = objectSpecifierType
        self.multiObjectSpecifierType = multiObjectSpecifierType
        self.rootSpecifierType = rootSpecifierType // App/Con/Its
        self.applicationType = applicationType
        self.symbolType = symbolType
        self.formatter = formatter
    }
}


/******************************************************************************/
// AppData converts values between Swift and AE types, holds target process information, and provides methods for sending Apple events


open class AppData {
    
    // compatibility flags; these make SwiftAutomation more closely mimic certain AppleScript behaviors that may be expected by a few older apps
    
    public var isInt64Compatible: Bool = true // While AppData.pack() always packs integers within the SInt32.min...SInt32.max range as typeSInt32, if the isInt64Compatible flag is true then it will use typeUInt32/typeSInt64/typeUInt64 for integers outside of that range. Some older Carbon-based apps (e.g. MS Excel) may not accept these larger integer types, so set this flag false when working with those apps to pack large integers as Doubles instead, effectively emulating AppleScript which uses SInt32 and Double only. (Caution: as in AppleScript, integers beyond ±2**52 will lose precision when converted to Double.)
    
    public var fullyUnpackSpecifiers: Bool = false // Unlike AppleScript, which fully unpacks object specifiers returned by an application, SwiftAutomation unpacks only the topmost descriptor and unpacks its parents only if necessary, e.g. when generating a description string; otherwise the descriptor returned by the application is reused to improve performance. Setting this option to true will emulate AppleScript's behavior (the only app known to require this is iView Media Pro, due to a pair of obscure bugs that cause it to reject by-index descriptors it created itself).
    
    // the following properties are mainly for internal use, but SpecifierFormatter may also get them when rendering app roots
    public let target: TargetApplication
    public let launchOptions: LaunchOptions
    public let relaunchMode: RelaunchMode
    
    public var formatter: SpecifierFormatter { return self.glueClasses.formatter } // convenience accessor; used by Query.description
    
    public let glueClasses: GlueClasses // holds all glue-defined Specifier and Symbol classes so unpack() can instantiate them as needed, plus a SpecifierFormatter instance for generating specifiers' description strings; used here and in subclasses
    
    private var _targetDescriptor: NSAppleEventDescriptor? = nil // targetDescriptor() creates an AEAddressDesc for the target process when dispatching first Apple event, caching it here for subsequent reuse
    
    private var _transactionID: AETransactionID = _kAnyTransactionID
    
    
    public required init(target: TargetApplication, launchOptions: LaunchOptions, relaunchMode: RelaunchMode, glueClasses: GlueClasses) { // should be private, but targetedCopy requires it to be required, which in turn requires it to be public; it should not be called directly, however (if an AppData instance is required for standalone use, instantiate the Application class from the default AEApplicationGlue or an application-specific glue, then get its appData property instead)
        self.target = target
        self.launchOptions = launchOptions
        self.relaunchMode = relaunchMode
        self.glueClasses = glueClasses
    }
    
    
    // create a new untargeted AppData instance for a glue file's private gUntargetedAppData constant (note: this will leak memory each time it's used so users should not call it themselves; instead, use AEApplication.untargetedAppData to return an already-created instance suitable for general programming tasks)
    public convenience init(glueClasses: GlueClasses) {
        self.init(target: .none, launchOptions: DefaultLaunchOptions, relaunchMode: .never, glueClasses: glueClasses)
    }
    
    // create a targeted copy of a [typically untargeted] AppData instance; Application inits should always use this to create targeted AppData instances
    public func targetedCopy(_ target: TargetApplication, launchOptions: LaunchOptions, relaunchMode: RelaunchMode) -> Self {
        return type(of: self).init(target: target, launchOptions: launchOptions, relaunchMode: relaunchMode, glueClasses: self.glueClasses)
    }
    
    /******************************************************************************/
    // specifier roots
    
    public var application: RootSpecifier { // returns targeted application object that can build specifiers and send commands
        return self.glueClasses.applicationType.init(rootObject: AppRootDesc, appData: self)
    }
    
    public var app: RootSpecifier { // returns untargeted 'application' object that can build specifiers for use in other commands only
        return self.glueClasses.rootSpecifierType.init(rootObject: AppRootDesc, appData: self)
    }
    
    public var con: RootSpecifier { // returns untargeted 'container' object used to build specifiers for use in by-range specifiers only
        return self.glueClasses.rootSpecifierType.init(rootObject: ConRootDesc, appData: self)
    }
    
    public var its: RootSpecifier { // returns untargeted 'object-to-test' object used to build specifiers for use in by-test specifiers only
        return self.glueClasses.rootSpecifierType.init(rootObject: ItsRootDesc, appData: self)
    }
    
    
    /******************************************************************************/
    // Convert a Swift or Cocoa value to an Apple event descriptor
    
    // Swift's NSNumber bridging is hopelessly ambiguous, so it's not enough to ask if `value is Bool/Int/Double` or to try casting it to Bool/Int/Double, as these ALWAYS succeed for ALL NSNumbers, regardless of what type the NSNumber actually represents, e.g. `NSNumber(value:true) is Bool` returns `true` as expected, but `NSNumber(value:2) is Bool` and `NSNumber(value:3.3) is Bool` return `true` too! Therefore, the only way to determine if `value` is a Swift Bool/Int/Double is to first eliminate the possibility that it's an NSNumber by testing for that first. This is further complicated by NSNumber being a class cluster, not a concrete class, so we can't just test if `type(of: value) == NSNumber.self`; we have to extract the underlying __NSCF… classes and test against those. This makes some assumptions based on established NSNumber implementation; if that implementation should change in future (either in Cocoa itself or in the way that Swift maps it) then these assumptions may break, resulting in incorrect/broken behavior in the pack() method below.
    private let _NSBooleanType = type(of: NSNumber(value: true)) // this assumes Cocoa always represents true/false as __NSCFBoolean
    private let _NSNumberType = type(of: NSNumber(value: 1)) // this assumes Cocoa always represents all integer and FP numbers as __NSCFNumber
    
    
    public func pack(_ value: Any) throws -> NSAppleEventDescriptor {
        // note: Swift's Bool/Int/Double<->NSNumber bridging sucks, so NSNumber instances require special processing to ensure the underlying value's exact type (Bool/Int/Double/etc) isn't lost in translation
        if type(of: value) == self._NSBooleanType { // test for NSNumber(value:true/false)
            // important: 
            // - the first test assumes NSNumber class cluster always returns an instance of __NSCFBooleanType (or at least something that can be distinguished from all other NSNumbers)
            // - `value is Bool/Int/Double` always returns true for any NSNumber, so must not be used; however, checking for BooleanType returns true only for Bool (or other Swift types that implement BooleanType protocol) so should be safe
            return NSAppleEventDescriptor(boolean: value as! Bool)
        } else if type(of: value) == self._NSNumberType { // test for any other NSNumber (but not Swift numeric types as those will be dealt with below)
            let numberObj = value as! NSNumber
            switch numberObj.objCType.pointee as Int8 {
            case 98, 99, 67, 115, 83, 105: // (b, c, C, s, S, i) anything that will fit into SInt32 is packed as typeSInt32 for compatibility
                return NSAppleEventDescriptor(int32: numberObj.int32Value)
            case 73: // (I) UInt32
                var val = numberObj.uint32Value
                if val <= UInt32(Int32.max) {
                    return NSAppleEventDescriptor(int32: Int32(val))
                } else if self.isInt64Compatible {
                    return NSAppleEventDescriptor(descriptorType: typeUInt32, bytes: &val, length: MemoryLayout<UInt32>.size)!
                } // else pack as double
            case 108, 113: // (l, q) SInt64
                var val = numberObj.int64Value
                if val >= Int64(Int32.min) && val <= Int64(Int32.max) {
                    return NSAppleEventDescriptor(int32: Int32(val))
                } else if self.isInt64Compatible {
                    return NSAppleEventDescriptor(descriptorType: typeSInt64, bytes: &val, length: MemoryLayout<Int64>.size)!
                } // else pack as double, possibly with some loss of precision
            case 76, 81: // (L, Q) UInt64
                var val = numberObj.uint64Value
                if val <= UInt64(Int32.max) {
                    return NSAppleEventDescriptor(int32: Int32(val))
                } else if self.isInt64Compatible {
                    return NSAppleEventDescriptor(descriptorType: typeUInt64, bytes: &val, length: MemoryLayout<UInt64>.size)!
                } // else pack as double, possibly with some loss of precision
            default:
                ()
            }
            return NSAppleEventDescriptor(double: numberObj.doubleValue)
        }
        switch value {
        case let val as SelfPacking:
            return try val.SwiftAutomation_packSelf(self)
        case let obj as NSAppleEventDescriptor:
            return obj
        case var val as Int:
            // Note: to maximize application compatibility, always preferentially pack integers as typeSInt32, as that's the traditional integer type recognized by all apps. (In theory, packing as typeSInt64 shouldn't be a problem as apps should coerce to whatever type they actually require before unpacking, but not-so-well-designed Carbon apps sometimes explicitly typecheck instead, so will fail if the descriptor isn't the assumed typeSInt32.)
            if Int(Int32.min) <= val && val <= Int(Int32.max) {
                return NSAppleEventDescriptor(int32: Int32(val))
            } else if self.isInt64Compatible {
                return NSAppleEventDescriptor(descriptorType: _typeSInt64, bytes: &val, length: MemoryLayout<Int>.size)!
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
            if obj.isFileURL {
                return NSAppleEventDescriptor(fileURL: obj)
            }
            
        // Cocoa collection classes don't support SelfPacking (though don't require it either since they're not generics); for now, just cast to Swift type on assumption that these are less common cases and Swift's ObjC bridge won't add significant cost, though they could be packed directly here if preferred
        case let obj as NSSet:
            return try (obj as Set).SwiftAutomation_packSelf(self)
        case let obj as NSArray:
            return try (obj as Array).SwiftAutomation_packSelf(self)
        case let obj as NSDictionary:
            return try (obj as Dictionary).SwiftAutomation_packSelf(self)
            
        
        case var val as UInt:
            if val <= UInt(Int32.max) {
                return NSAppleEventDescriptor(int32: Int32(val))
            } else if self.isInt64Compatible {
                return NSAppleEventDescriptor(descriptorType: _typeUInt32, bytes: &val, length: MemoryLayout<UInt>.size)!
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
            if val <= UInt32(Int32.max) {
                return NSAppleEventDescriptor(int32: Int32(val))
            } else if self.isInt64Compatible {
                return NSAppleEventDescriptor(descriptorType: _typeUInt32, bytes: &val, length: MemoryLayout<UInt32>.size)!
            } else {
                return NSAppleEventDescriptor(double: Double(val))
            }
        case var val as Int64:
            if val >= Int64(Int32.min) && val <= Int64(Int32.max) {
                return NSAppleEventDescriptor(int32: Int32(val))
            } else if self.isInt64Compatible {
                return NSAppleEventDescriptor(descriptorType: _typeSInt64, bytes: &val, length: MemoryLayout<Int64>.size)!
            } else {
                return NSAppleEventDescriptor(double: Double(val)) // caution: may be some loss of precision
            }
        case var val as UInt64:
            if val <= UInt64(Int32.max) {
                return NSAppleEventDescriptor(int32: Int32(val))
            } else if self.isInt64Compatible {
                return NSAppleEventDescriptor(descriptorType: _typeUInt64, bytes: &val, length: MemoryLayout<UInt64>.size)!
            } else {
                return NSAppleEventDescriptor(double: Double(val)) // caution: may be some loss of precision
            }
        case let val as Float:
            return NSAppleEventDescriptor(double: Double(val))
        case let val as Bool: // hopefully Swift hasn't [mis]cast `true` or `false` in one of the above cases
            return NSAppleEventDescriptor(boolean: val)
        case let val as Error:
            throw val // if value is ErrorType, rethrow it as-is; e.g. see ObjectSpecifier.unpackParentSpecifiers(), which needs to report [rare] errors but can't throw itself; this should allow APIs that can't raise errors directly (e.g. specifier constructors) to have those errors raised if/when used in commands (which can throw)
        default:
            ()
        }
        throw PackError(object: value)
    }
    
    /******************************************************************************/
    // Convert an Apple event descriptor to the specified Swift type, coercing it as necessary
    
    public func unpack<T>(_ desc: NSAppleEventDescriptor) throws -> T {
        if T.self == Any.self || T.self == AnyObject.self {
            return try self.unpackAsAny(desc) as! T
        } else if let t = T.self as? SelfUnpacking.Type { // note: Symbol, MissingValueType, Array<>, Dictionary<>, Set<>, and Optional<> types unpack the descriptor themselves, as do any custom structs and enums defined in glues
            return try t.SwiftAutomation_unpackSelf(desc, appData: self) as! T
        } else if isMissingValue(desc) {
            throw UnpackError(appData: self, descriptor: desc, type: T.self, message: "Can't coerce 'missing value' descriptor to \(T.self).") // Important: AppData must not unpack a 'missing value' constant as anything except `MissingValue` or `nil` (i.e. the types to which it self-unpacks). AppleScript doesn't have this problem as all descriptors unpack to their own preferred type, but unpack<T>() forces a descriptor to unpack as a specific type or fail trying. While its role is to act as a `nil`-style placeholder when no other value is given, its descriptor type is typeType so left to its own devices it would naturally unpack the same as any other typeType descriptor. e.g. One of AEM's vagaries is that it supports typeType to typeUnicodeText coercions, so while permitting cDocument to coerce to "docu" might be acceptable [if not exactly helpful], allowing cMissingValue to coerce to "msng" would defeat its whole purpose.
        }
        switch T.self {
        case is Bool.Type:
            return desc.booleanValue as! T
        case is Int.Type: // TO DO: this assumes Int will _always_ be 64-bit (on macOS); is that safe?
            if desc.descriptorType == _typeSInt32 { // shortcut for common case where descriptor is already a standard 32-bit int
                return Int(desc.int32Value) as! T
            } else if let result = self.unpackAsInt(desc) {
                return Int(result) as! T
            }
        case is UInt.Type:
            if let result = self.unpackAsInt(desc) {
                return Int(result) as! T
            }
        case is Double.Type:
            if let doubleDesc = desc.coerce(toDescriptorType: _typeIEEE64BitFloatingPoint) {
                return Double(doubleDesc.doubleValue) as! T
            }
        case is String.Type, is NSString.Type:
            if let result = desc.stringValue {
                return result as! T
            }
        case is Query.Type: // note: user typically specifies exact class ([PREFIX][Object|Elements]Specifier)
            if let result = try self.unpackAsAny(desc) as? T { // specifiers can be composed of several AE types, so unpack first then check type
                return result
            }
        case is Symbol.Type:
            if symbolDescriptorTypes.contains(desc.descriptorType) {
                return self.unpackAsSymbol(desc) as! T
            }
        case is Date.Type, is NSDate.Type:
             if let result = desc.dateValue {
                 return result as! T
             }
        case is URL.Type, is NSURL.Type:
             if let result = desc.fileURLValue { // note: this coerces all file system-related descriptors down to typeFileURL before unpacking them, so typeAlias/typeBookmarkData descriptors (which identify file system objects, not locations) won't round-trip and the resulting URL will only describe the file's location at the time the descriptor was unpacked.
                 return result as! T
            }
        case is Int8.Type: // lack of common protocols on Integer types is a pain
            if let n = self.unpackAsInt(desc), let result = Int8(exactly: n) {
                return result as! T
            }
        case is Int16.Type:
            if let n = self.unpackAsInt(desc), let result = Int16(exactly: n) {
                return result as! T
            }
        case is Int32.Type:
            if let n = self.unpackAsInt(desc), let result = Int32(exactly: n) {
                return result as! T
            }
        case is Int64.Type:
            if let n = self.unpackAsInt(desc), let result = Int64(exactly: n) {
                return result as! T
            }
        case is UInt8.Type:
            if let n = self.unpackAsUInt(desc), let result = UInt8(exactly: n) {
                return result as! T
            }
        case is UInt16.Type:
            if let n = self.unpackAsUInt(desc), let result = UInt16(exactly: n) {
                return result as! T
            }
        case is UInt32.Type:
            if let n = self.unpackAsUInt(desc), let result = UInt32(exactly: n) {
                return result as! T
            }
        case is UInt64.Type:
            if let n = self.unpackAsUInt(desc), let result = UInt64(exactly: n) {
                return result as! T
            }
        case is Float.Type:
            if let doubleDesc = desc.coerce(toDescriptorType: _typeIEEE64BitFloatingPoint),
                    let result = Float(exactly: doubleDesc.doubleValue) {
                return result as! T
            }
        case is AnyHashable.Type: // while records always unpack as [Symbol:TYPE], [AnyHashable:TYPE] is a valid return type too
            if let result = try self.unpackAsAny(desc) as? AnyHashable {
                return result as! T
            }
        case is NSNumber.Type:
            switch desc.descriptorType {
            case _typeBoolean, _typeTrue, _typeFalse:
                return NSNumber(value: desc.booleanValue) as! T
            case _typeSInt32, _typeSInt16:
                return NSNumber(value: desc.int32Value) as! T
            case _typeIEEE64BitFloatingPoint, _typeIEEE32BitFloatingPoint, _type128BitFloatingPoint:
                return NSNumber(value: desc.doubleValue) as! T
            case _typeSInt64:
                return NSNumber(value: self.unpackAsInt(desc)!) as! T
            case _typeUInt32, _typeUInt16, _typeUInt64:
                return NSNumber(value: self.unpackAsUInt(desc)!) as! T
            default: // not a number, e.g. a string, so preferentially coerce and unpack as Int64 or else Double, falling through on failure
                if let doubleDesc = desc.coerce(toDescriptorType: _typeIEEE64BitFloatingPoint) {
                    let d = doubleDesc.doubleValue
                    if d.truncatingRemainder(dividingBy: 1) == 0, let i = self.unpackAsInt(desc) {
                        return NSNumber(value: i) as! T
                    } else {
                        return NSNumber(value: doubleDesc.doubleValue) as! T
                    }
                }
            }
        case is NSArray.Type:
            return try self.unpack(desc) as Array<Any> as! T
        case is NSSet.Type:
            return try self.unpack(desc) as Set<AnyHashable> as! T
        case is NSDictionary.Type:
            return try self.unpack(desc) as Dictionary<Symbol,Any> as! T
        case is NSAppleEventDescriptor.Type:
            return desc as! T
        default:
            ()
        }
        // desc couldn't be coerced to the specified type
        let symbol = self.glueClasses.symbolType.symbol(code: desc.descriptorType)
        let typeName = symbol.name == nil ? fourCharCode(symbol.code) : symbol.name!
        throw UnpackError(appData: self, descriptor: desc, type: T.self, message: "Can't coerce \(typeName) descriptor to \(T.self).")
    }
    
    
    /******************************************************************************/
    // Convert an Apple event descriptor to its preferred Swift type, as determined by its descriptorType
    
    public func unpackAsAny(_ desc: NSAppleEventDescriptor) throws -> Any { // note: this never returns Optionals (i.e. cMissingValue AEDescs always unpack as MissingValue when return type is Any) to avoid dropping user into Optional<T>.some(Optional<U>.none) hell.
        switch desc.descriptorType {
            // common AE types
        case _typeTrue, _typeFalse, _typeBoolean:
            return desc.booleanValue
        case _typeSInt32, _typeSInt16:
            return desc.int32Value
        case _typeIEEE64BitFloatingPoint, _typeIEEE32BitFloatingPoint:
            return desc.doubleValue
        case _type128BitFloatingPoint: // coerce down lossy
            guard let doubleDesc = desc.coerce(toDescriptorType: _typeIEEE64BitFloatingPoint) else {
                throw UnpackError(appData: self, descriptor: desc, type: Any.self, message: "Can't coerce 128-bit float to double.")
            }
            return doubleDesc.doubleValue
        case _typeChar, _typeIntlText, _typeUTF8Text, _typeUTF16ExternalRepresentation, _typeStyledText, _typeUnicodeText, _typeVersion:
            guard let result = desc.stringValue else { // this should never fail unless the AEDesc contains mis-encoded text data (e.g. claims to be typeUTF8Text but contains non-UTF8 byte sequences)
                throw UnpackError(appData: self, descriptor: desc, type: Any.self, message: "Corrupt descriptor.")
            }
            return result
        case _typeLongDateTime:
            guard let result = desc.dateValue else { // this should never fail unless the AEDesc contains bad data
                throw UnpackError(appData: self, descriptor: desc, type: Any.self, message: "Corrupt descriptor.")
            }
            return result
        case _typeAEList:
            return try Array.SwiftAutomation_unpackSelf(desc, appData: self) as [Any]
        case _typeAERecord:
            return try Dictionary.SwiftAutomation_unpackSelf(desc, appData: self) as [Symbol:Any]
        case _typeAlias, _typeBookmarkData, _typeFileURL, _typeFSRef, _typeFSS: // note: typeFSS is long defunct so shouldn't be encountered unless dealing with exceptionally old 32-bit Carbon apps, while a `file "HFS:PATH:"` object specifier (typeObjectSpecifier of cFile; basically an AppleScript kludge-around to continue supporting the `file [specifier] "HFS:PATH:"` syntax form despite typeFSS going away) is indistinguishable from any other object specifier so will unpack as an explicit `APPLICATION().files["HFS:PATH:"]` or `APPLICATION().elements("file")["HFS:PATH:"]` specifier depending on whether or not the glue defines a `file[s]` keyword (TBH, not sure if there are any apps do return AEDescs that represent file system locations this way.)
            guard let result = desc.fileURLValue else { // ditto
                throw UnpackError(appData: self, descriptor: desc, type: Any.self, message: "Corrupt descriptor.")
            }
            return result
        case _typeType, _typeEnumerated, _typeProperty, _typeKeyword:
            return isMissingValue(desc) ? MissingValue : self.unpackAsSymbol(desc)
            // object specifiers
        case _typeObjectSpecifier:
            return try self.unpackAsObjectSpecifier(desc)
        case _typeInsertionLoc:
            return try self.unpackAsInsertionLoc(desc)
        case _typeNull: // null descriptor indicates object specifier root
            return self.application
        case _typeCurrentContainer:
            return self.con
        case _typeObjectBeingExamined:
            return self.its
        case _typeCompDescriptor:
            return try self.unpackAsComparisonDescriptor(desc)
        case _typeLogicalDescriptor:
            return try self.unpackAsLogicalDescriptor(desc)
            
            // less common types
        case _typeSInt64:
            return self.unpackAsInt(desc)!
        case _typeUInt64, _typeUInt32, _typeUInt16:
            return self.unpackAsUInt(desc)!
        case _typeQDPoint, _typeQDRectangle, _typeRGBColor:
            return try self.unpack(desc) as [Int]
            // note: while there are also several AEAddressDesc types used to identify applications, these are very rarely used as command results (e.g. the `choose application` OSAX) and there's little point unpacking them anway as the only type they can automatically be mapped to is AEApplication, which has only minimal functionality anyway. Also unsupported are unit types as they only cover a handful of measurement types and in practice aren't really used for anything except measurement conversions in AppleScript.
        default:
            if desc.isRecordDescriptor {
                return try Dictionary.SwiftAutomation_unpackSelf(desc, appData: self) as [Symbol:Any]
            }
            return desc
        }
    }
    
    // helpers for the above
    
    private func unpackAsInt(_ desc: NSAppleEventDescriptor) -> Int? {
        // coerce the descriptor (whatever it is - typeSInt16, typeUInt32, typeUnicodeText, etc.) to typeSIn64 (hoping the Apple Event Manager has remembered to install TYPE-to-SInt64 coercion handlers for all these types too), and unpack as Int[64]
        if let intDesc = desc.coerce(toDescriptorType: _typeSInt64) {
            var result: Int64 = 0
            (intDesc.data as NSData).getBytes(&result, length: MemoryLayout<Int64>.size)
            return Int(result) // caution: this assumes Int will always be 64-bit
        } else {
            return nil
        }
    }
    
    private func unpackAsUInt(_ desc: NSAppleEventDescriptor) -> UInt? {
            // as above, but for unsigned ints
        if let intDesc = desc.coerce(toDescriptorType: _typeUInt64) {
            var result: UInt64 = 0
            (intDesc.data as NSData).getBytes(&result, length: MemoryLayout<UInt64>.size)
            return UInt(result) // caution: this assumes UInt will always be 64-bit
        } else {
            return nil
        }
    }
    
    /******************************************************************************/
    // Supporting methods for unpacking symbols and specifiers
    
    
    func recordKey(forCode code: OSType) -> Symbol { // used by Dictionary extension to unpack AERecord's OSType-based keys as glue-defined Symbols
        return self.glueClasses.symbolType.symbol(code: code, type: _typeProperty, descriptor: nil)
    }
    
    func unpackAsSymbol(_ desc: NSAppleEventDescriptor) -> Symbol {
        return self.glueClasses.symbolType.symbol(code: desc.typeCodeValue, type: desc.descriptorType, descriptor: desc)
    }
    
    func unpackAsInsertionLoc(_ desc: NSAppleEventDescriptor) throws -> Specifier {
        guard let _ = desc.forKeyword(_keyAEObject), // only used to check InsertionLoc record is correctly formed
            let insertionLocation = desc.forKeyword(_keyAEPosition) else {
                throw UnpackError(appData: self, descriptor: desc, type: self.glueClasses.insertionSpecifierType,
                                  message: "Can't unpack malformed insertion specifier.")
        }
        return self.glueClasses.insertionSpecifierType.init(insertionLocation: insertionLocation,
                                                         parentQuery: nil, appData: self, descriptor: desc)
    }
    
    
    private let _absoluteOrdinalCodes: Set<OSType> = [_kAEFirst, _kAEMiddle, _kAELast, _kAEAny, _kAEAll]
    private let _relativeOrdinalCodes: Set<OSType> = [_kAEPrevious, _kAENext]

    
    func unpackAsObjectSpecifier(_ desc: NSAppleEventDescriptor) throws -> Specifier {
        guard let parentDesc = desc.forKeyword(_keyAEContainer), // the 'from' descriptor is normally unused; it's only required in `unpackParentSpecifiers()` when fully unpacking an object specifier (typically to generate a description string), or below if the `fullyUnpackSpecifiers` compatibility flag is set
            let wantType = desc.forKeyword(_keyAEDesiredClass),
            let selectorForm = desc.forKeyword(_keyAEKeyForm),
            let selectorDesc = desc.forKeyword(_keyAEKeyData) else {
                throw UnpackError(appData: self, descriptor: desc, type: self.glueClasses.objectSpecifierType,
                                  message: "Can't unpack malformed object specifier.")
        }
        do { // unpack selectorData, unless it's a property code or absolute/relative ordinal (in which case use its 'prop'/'enum' descriptor as-is)
            var selectorData: Any = selectorDesc // the selector won't be unpacked if it's a property/relative/absolute ordinal
            var objectSpecifierClass = self.glueClasses.objectSpecifierType // most reference forms describe one-to-one relationships
            switch selectorForm.enumCodeValue {
            case _formPropertyID: // property
                if ![_typeType, _typeProperty].contains(selectorDesc.descriptorType) {
                    throw UnpackError(appData: self, descriptor: desc, type: self.glueClasses.objectSpecifierType,
                                      message: "Can't unpack malformed object specifier.")
                }
            case _formRelativePosition: // before/after
                if !(selectorDesc.descriptorType == _typeEnumerated && self._relativeOrdinalCodes.contains(selectorDesc.enumCodeValue)) {
                    throw UnpackError(appData: self, descriptor: desc, type: self.glueClasses.objectSpecifierType,
                                      message: "Can't unpack malformed object specifier.")
                }
            case _formAbsolutePosition: // by-index or first/middle/last/any/all ordinal
                if selectorDesc.descriptorType == _typeEnumerated && self._absoluteOrdinalCodes.contains(selectorDesc.enumCodeValue) { // don't unpack ordinals
                    if selectorDesc.enumCodeValue == _kAEAll { // `all` ordinal = one-to-many relationship
                        objectSpecifierClass = self.glueClasses.multiObjectSpecifierType
                    }
                } else { // unpack index (normally Int32, though the by-index form can take any type of selector as long as the app understands it)
                    selectorData = try self.unpack(selectorDesc)
                }
            case _formRange: // by-range = one-to-many relationship
                objectSpecifierClass = self.glueClasses.multiObjectSpecifierType
                if selectorDesc.descriptorType != _typeRangeDescriptor {
                    throw UnpackError(appData: self, descriptor: selectorDesc, type: RangeSelector.self, message: "Malformed selector in by-range specifier.")
                }
                guard let startDesc = selectorDesc.forKeyword(_keyAERangeStart), let stopDesc = selectorDesc.forKeyword(_keyAERangeStop) else {
                    throw UnpackError(appData: self, descriptor: selectorDesc, type: RangeSelector.self, message: "Malformed selector in by-range specifier.")
                }
                do {
                    selectorData = RangeSelector(start: try self.unpackAsAny(startDesc), stop: try self.unpackAsAny(stopDesc), wantType: wantType)
                } catch {
                    throw UnpackError(appData: self, descriptor: selectorDesc, type: RangeSelector.self, message: "Couldn't unpack start/stop selector in by-range specifier.")
                }
            case _formTest: // by-range = one-to-many relationship
                objectSpecifierClass = self.glueClasses.multiObjectSpecifierType
                selectorData = try self.unpack(selectorDesc)
                if !(selectorData is Query) {
                    throw UnpackError(appData: self, descriptor: selectorDesc, type: Query.self, message: "Malformed selector in by-test specifier.")
                }
            default: // by-name or by-ID
                selectorData = try self.unpack(selectorDesc)
            }
            return objectSpecifierClass.init(wantType: wantType,
                                             selectorForm: selectorForm, selectorData: selectorData,
                                             parentQuery: (fullyUnpackSpecifiers ? try self.unpack(parentDesc) as Query : nil),
                                             appData: self, descriptor: (fullyUnpackSpecifiers ? nil : desc))
        } catch {
            throw UnpackError(appData: self, descriptor: desc, type: self.glueClasses.objectSpecifierType,
                              message: "Can't unpack object specifier's selector data.", cause: error)
        }
    }
    
    private let _comparisonOperatorCodes: Set<OSType> = [_kAELessThan, _kAELessThanEquals, _kAEEquals,
                                                         _kAENotEquals, _kAEGreaterThan, _kAEGreaterThanEquals,
                                                         _kAEBeginsWith, _kAEEndsWith, _kAEContains, _kAEIsIn]
    private let _logicalOperatorCodes: Set<OSType> = [_kAEAND, _kAEOR, _kAENOT]
    
    func unpackAsComparisonDescriptor(_ desc: NSAppleEventDescriptor) throws -> TestClause {
        if let operatorType = desc.forKeyword(_keyAECompOperator),
            let operand1Desc = desc.forKeyword(_keyAEObject1),
            let operand2Desc = desc.forKeyword(_keyAEObject2),
            !self._comparisonOperatorCodes.contains(operatorType.enumCodeValue) {
                // don't bother with dedicated error reporting here as malformed operand descs that cause the following unpack calls to fail are unlikely in practice, and will still be caught and reported further up the call chain anyway
                let operand1 = try self.unpackAsAny(operand1Desc)
                let operand2 = try self.unpackAsAny(operand2Desc)
                if operatorType.typeCodeValue == _kAEContains && !(operand1 is ObjectSpecifier) {
                    if let op2 = operand2 as? ObjectSpecifier {
                        return ComparisonTest(operatorType: _kAEIsInDesc, operand1: op2, operand2: operand1, appData: self, descriptor: desc)
                    } // else fall through to throw
                } else if let op1 = operand1 as? ObjectSpecifier {
                    return ComparisonTest(operatorType: operatorType, operand1: op1, operand2: operand2, appData: self, descriptor: desc)
                } // else fall through to throw
        }
        throw UnpackError(appData: self, descriptor: desc, type: TestClause.self, message: "Can't unpack comparison test: malformed descriptor.")
    }
    
    func unpackAsLogicalDescriptor(_ desc: NSAppleEventDescriptor) throws -> TestClause {
        if let operatorType = desc.forKeyword(_keyAELogicalOperator),
            let operandsDesc = desc.forKeyword(_keyAEObject),
            !self._logicalOperatorCodes.contains(operatorType.enumCodeValue) {
                let operands = try self.unpack(operandsDesc) as [TestClause]
                return LogicalTest(operatorType: operatorType, operands: operands, appData: self, descriptor: desc)
        }
        throw UnpackError(appData: self, descriptor: desc, type: TestClause.self, message: "Can't unpack logical test: malformed descriptor.")
    }
    
    
    /******************************************************************************/
    // get AEAddressDesc for target application
    
    public func targetDescriptor() throws -> NSAppleEventDescriptor? {
        if self._targetDescriptor == nil { self._targetDescriptor = try self.target.descriptor(self.launchOptions) }
        return self._targetDescriptor
    }
    
    
    /******************************************************************************/
    // send an Apple event

    let defaultSendMode = SendOptions.canSwitchLayer
    let defaultConsiderations = packConsideringAndIgnoringFlags([.case])
    
    // if target process is no longer running, Apple Event Manager will return an error when an event is sent to it
    let RelaunchableErrorCodes: Set<Int> = [-600, -609]
    // if relaunchMode = .Limited, only 'launch' and 'run' are allowed to restart a local application that's been quit
    let LimitedRelaunchEvents: [(OSType,OSType)] = [(_kCoreEventClass, _kAEOpenApplication), (_kASAppleScriptSuite, _kASLaunchEvent)]
    
    private func send(event: NSAppleEventDescriptor, sendMode: SendOptions, timeout: TimeInterval) throws -> NSAppleEventDescriptor { // used by sendAppleEvent()
        do {
            return try event.sendEvent(options: sendMode, timeout: timeout) // throws NSError on AEM errors (but not app errors)
        
        // TO DO: this is wrong; -1708 will be in reply event, not in AEM error; FIX
        
        } catch { // 'launch' events normally return 'not handled' errors, so just ignore those
            if (error as NSError).code == -1708
                && event.attributeDescriptor(forKeyword: _keyEventClassAttr)!.typeCodeValue == _kASAppleScriptSuite
                && event.attributeDescriptor(forKeyword: _keyEventIDAttr)!.typeCodeValue == _kASLaunchEvent {
                    return NSAppleEventDescriptor.record() // (not a full AppleEvent desc, but reply event's attributes aren't used so is equivalent to a reply event containing neither error nor result)
            } else {
                throw error
            }
        }
    }
    
    
    public func sendAppleEvent<T>(name: String?, eventClass: OSType, eventID: OSType,
                                  parentSpecifier: Specifier, // the Specifier on which the command method was called; see special-case packing logic below
                                  directParameter: Any = NoParameter, // the first (unnamed) parameter to the command method; see special-case packing logic below
                                  keywordParameters: [KeywordParameter] = [], // the remaining named parameters
                                  requestedType: Symbol? = nil, // event's `as` parameter, if any (note: while a `keyAERequestedType` parameter can be supplied via `keywordParameters:`, it will be ignored if `requestedType:` is given)
                                  waitReply: Bool = true, // wait for application to respond before returning?
                                  sendOptions: SendOptions? = nil, // raw send options (these are rarely needed); if given, `waitReply:` is ignored
                                  withTimeout: TimeInterval? = nil, // no. of seconds to wait before raising timeout error (-1712); may also be default/never
                                  considering: ConsideringOptions? = nil) throws -> T { // coerce and unpack result as this type or return raw reply event if T is NSDescriptor; default is Any
        // note: human-readable command and parameter names are only used (if known) in error messages
        // note: all errors occurring within this method are caught and rethrown as CommandError, allowing error message to provide a description of the failed command as well as the error itself
        var sentEvent: NSAppleEventDescriptor?, repliedEvent: NSAppleEventDescriptor?
        do {
            // Create a new AppleEvent descriptor (throws ConnectionError if target app isn't found)
            let event = NSAppleEventDescriptor(eventClass: eventClass, eventID: eventID, targetDescriptor: try self.targetDescriptor(),
                                               returnID: _kAutoGenerateReturnID, transactionID: _kAnyTransactionID)
            // pack its keyword parameters
            for (paramName, code, value) in keywordParameters where parameterExists(value) {
                do {
                    event.setDescriptor(try self.pack(value), forKeyword: code)
                } catch {
                    throw AutomationError(code: error._code, message: "Invalid '\(paramName ?? fourCharCode(code))' parameter.", cause: error)
                }
            }
            // pack event's direct parameter and/or subject attribute
            let hasDirectParameter = parameterExists(directParameter)
            if hasDirectParameter { // if the command includes a direct parameter, pack that normally as its direct param
                event.setParam(try self.pack(directParameter), forKeyword: _keyDirectObject)
            }
            // if command method was called on root Application (null) object, the event's subject is also null...
            var subjectDesc = AppRootDesc
            // ... but if the command was called on a Specifier, decide if that specifier should be packed as event's subject
            // or, as a special case, used as event's keyDirectObject/keyAEInsertHere parameter for user's convenience
            if !(parentSpecifier is RootSpecifier) { // technically Application, but there isn't an explicit class for that
                if eventClass == _kAECoreSuite && eventID == _kAECreateElement { // for user's convenience, `make` command is treated as a special case
                    // if `make` command is called on a specifier, use that specifier as event's `at` parameter if not already given
                    if event.paramDescriptor(forKeyword: _keyAEInsertHere) != nil { // an `at` parameter was already given, so pack parent specifier as event's subject attribute
                        subjectDesc = try self.pack(parentSpecifier)
                    } else { // else pack parent specifier as event's `at` parameter and use null as event's subject attribute
                        event.setParam(try self.pack(parentSpecifier), forKeyword: _keyAEInsertHere)
                    }
                } else { // for all other commands, check if a direct parameter was already given
                    if hasDirectParameter { // pack the parent specifier as the event's subject attribute
                        subjectDesc = try self.pack(parentSpecifier)
                    } else { // else pack parent specifier as event's direct parameter and use null as event's subject attribute
                        event.setParam(try self.pack(parentSpecifier), forKeyword: _keyDirectObject)
                    }
                }
            }
            event.setAttribute(subjectDesc, forKeyword: _keySubjectAttr)
            // pack requested type (`as`) parameter, if specified; note: most apps ignore this, but a few may recognize it (usually in `get` commands)  even if they don't define it in their dictionary (another AppleScript-introduced quirk); e.g. `Finder().home.get(requestedType:FIN.alias) as URL` tells Finder to return a typeAlias descriptor instead of typeObjectSpecifier, which can then be unpacked as URL
            if let type = requestedType {
                event.setDescriptor(NSAppleEventDescriptor(typeCode: type.code), forKeyword: _keyAERequestedType)
            }
            // event attributes
            // (note: most apps ignore considering/ignoring attributes, and always ignore case and consider everything else)
            let (considerations, consideringIgnoring) = considering == nil ? self.defaultConsiderations : packConsideringAndIgnoringFlags(considering!)
            event.setAttribute(considerations, forKeyword: _enumConsiderations)
            event.setAttribute(consideringIgnoring, forKeyword: _enumConsidsAndIgnores)
            // send the event
            let sendMode = sendOptions ?? self.defaultSendMode.union(waitReply ? .waitForReply : .noReply)
            let timeout = withTimeout ?? defaultTimeout
            var replyEvent: NSAppleEventDescriptor
            sentEvent = event
            do {
                replyEvent = try self.send(event: event, sendMode: sendMode, timeout: timeout) // throws NSError on AEM error
            } catch { // handle errors raised by Apple Event Manager (e.g. timeout, process not found)
                if RelaunchableErrorCodes.contains((error as NSError).code) && self.target.isRelaunchable && (self.relaunchMode == .always
                        || (self.relaunchMode == .limited && LimitedRelaunchEvents.contains(where: {$0.0 == eventClass && $0.1 == eventID}))) {
                    // event failed as target process has quit since previous event; recreate AppleEvent with new address and resend
                    self._targetDescriptor = nil
                    let event2 = NSAppleEventDescriptor(eventClass: eventClass, eventID: eventID, targetDescriptor: try self.targetDescriptor(),
                                                        returnID: _kAutoGenerateReturnID, transactionID: _kAnyTransactionID)
                    for i in 1...event.numberOfItems {
                        event2.setParam(event.atIndex(i)!, forKeyword: event.keywordForDescriptor(at: i))
                    }
                    for key in [_keySubjectAttr, _enumConsiderations, _enumConsidsAndIgnores] {
                        event2.setAttribute(event.attributeDescriptor(forKeyword: key)!, forKeyword: key)
                    }
                    replyEvent = try self.send(event: event2, sendMode: sendMode, timeout: timeout)
                } else {
                    throw error
                }
            }
            repliedEvent = replyEvent
            if sendMode.contains(.waitForReply) {
                if T.self == ReplyEventDescriptor.self { // return the entire reply event as-is
                    return ReplyEventDescriptor(descriptor: replyEvent) as! T
                } else if replyEvent.paramDescriptor(forKeyword: _keyErrorNumber)?.int32Value ?? 0 != 0 { // check if an application error occurred
                    throw AutomationError(code: Int(replyEvent.paramDescriptor(forKeyword: _keyErrorNumber)!.int32Value))
                } else if let resultDesc = replyEvent.paramDescriptor(forKeyword: _keyDirectObject) {
                    return try self.unpack(resultDesc) as T
                } // no return value or error, so fall through
            } else if sendMode.contains(.queueReply) { // get the return ID that will be used by the reply event so that client code's main loop can identify that reply event in its own event queue later on
                guard let returnIDDesc = event.attributeDescriptor(forKeyword: _keyReturnIDAttr) else { // sanity check
                    throw AutomationError(code: defaultErrorCode, message: "Can't get keyReturnIDAttr.")
                }
                return try self.unpack(returnIDDesc)
            }
            // note that some Apple event handlers intentionally return a void result (e.g. `set`, `quit`), and now and again a crusty old Carbon app will forget to supply a return value where one is expected; however, rather than add `COMMAND()->void` methods to glue files (which would only cover the first case), it's simplest just to return an 'empty' value which covers both use cases
            if let result = MissingValue as? T { // this will succeed when T is Any (which it always will be when the caller ignores the command's result)
                return result
            } else if let t = T.self as? SelfUnpacking.Type { // cover the crusty Carbon app case in a type-safe way (e.g. if the command usually returns a list, the caller will naturally expect it _always_ to return one so T will be Array<>, in which case return an empty array; OTOH, if the command usually returns a string, the user will _have_ to specify MayBeMissing<String>/Optional<String> or else they'll get an UnpackError)
                do { return try t.SwiftAutomation_noValue() as! T } catch {} // fallthrough if T can't provide an 'empty' representation of itself
            }
            throw AutomationError(code: defaultErrorCode, message: "Caller requested \(T.self) result but application didn't return anything.")
        } catch {
            let commandDescription = CommandDescription(name: name, eventClass: eventClass, eventID: eventID, parentSpecifier: parentSpecifier,
                                                        directParameter: directParameter, keywordParameters: keywordParameters,
                                                        requestedType: requestedType, waitReply: waitReply,
                                                        withTimeout: withTimeout, considering: considering)
            throw CommandError(commandInfo: commandDescription, appData: self, event: sentEvent, reply: repliedEvent, cause: error)
        }
    }
    
    
    // convenience shortcut for dispatching events using raw OSType codes only (the above method also requires human-readable command and parameter names to be supplied for error reporting purposes); users should call this via one of the `sendAppleEvent` methods on `AEApplication`/`AEItem`
    
    public func sendAppleEvent<T>(eventClass: OSType, eventID: OSType, parentSpecifier: Specifier, parameters: [OSType:Any] = [:],
                                  requestedType: Symbol? = nil, waitReply: Bool = true, sendOptions: SendOptions? = nil,
                                  withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        var parameters = parameters
        let directParameter = parameters.removeValue(forKey: _keyDirectObject) ?? NoParameter
        let keywordParameters: [KeywordParameter] = parameters.map({(name: nil, code: $0, value: $1)})
        return try self.sendAppleEvent(name: nil, eventClass: eventClass, eventID: eventID, parentSpecifier: parentSpecifier,
                                       directParameter: directParameter, keywordParameters: keywordParameters,
                                       requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                                       withTimeout: withTimeout, considering: considering)
    }
    
    
    /******************************************************************************/
    // transaction support (in practice, there are few, if any, currently available apps that support transactions, but it's included for completeness)
    
    public func doTransaction<T>(session: Any? = nil, closure: () throws -> (T)) throws -> T {
        var mutex = pthread_mutex_t()
        pthread_mutex_init(&mutex, nil)
        pthread_mutex_lock(&mutex)
        defer {
            pthread_mutex_unlock(&mutex)
            pthread_mutex_destroy(&mutex)
        }
        assert(self._transactionID == _kAnyTransactionID, "Transaction \(self._transactionID) already active.")
        self._transactionID = try self.sendAppleEvent(name: nil, eventClass: _kAEMiscStandards, eventID: _kAEBeginTransaction,
                                                      parentSpecifier: AEApp, directParameter: session as Any) as AETransactionID
        defer {
            self._transactionID = _kAnyTransactionID
        }
        var result: T
        do {
            result = try closure()
        } catch { // abort transaction, then rethrow closure error
            let _ = try? self.sendAppleEvent(name: nil, eventClass: _kAEMiscStandards, eventID: _kAETransactionTerminated,
                                             parentSpecifier: AEApp) as Any
            throw error
        } // else end transaction
        let _ = try self.sendAppleEvent(name: nil, eventClass: _kAEMiscStandards, eventID: _kAEEndTransaction,
                                        parentSpecifier: AEApp) as Any
        return result
    }
}


/******************************************************************************/
// used by AppData.sendAppleEvent() to pack ConsideringOptions as enumConsiderations (old-style) and enumConsidsAndIgnores (new-style) attributes


let considerationsTable: [(Considerations, NSAppleEventDescriptor, UInt32, UInt32)] = [ // also used in AE formatter
    // note: Swift mistranslates considering/ignoring mask constants as Int, not UInt32, so redefine them here
    (.case,             NSAppleEventDescriptor(enumCode: _kAECase),              0x00000001, 0x00010000),
    (.diacritic,        NSAppleEventDescriptor(enumCode: _kAEDiacritic),         0x00000002, 0x00020000),
    (.whiteSpace,       NSAppleEventDescriptor(enumCode: _kAEWhiteSpace),        0x00000004, 0x00040000),
    (.hyphens,          NSAppleEventDescriptor(enumCode: _kAEHyphens),           0x00000008, 0x00080000),
    (.expansion,        NSAppleEventDescriptor(enumCode: _kAEExpansion),         0x00000010, 0x00100000),
    (.punctuation,      NSAppleEventDescriptor(enumCode: _kAEPunctuation),       0x00000020, 0x00200000),
    (.numericStrings,   NSAppleEventDescriptor(enumCode: _kASNumericStrings),    0x00000080, 0x00800000),
]

// TO DO: review this code; is considering attr misnamed?

private func packConsideringAndIgnoringFlags(_ considerations: ConsideringOptions) -> (NSAppleEventDescriptor, NSAppleEventDescriptor) {
    let considerationsListDesc = NSAppleEventDescriptor.list()
    var consideringIgnoringFlags: UInt32 = 0
    for (consideration, considerationDesc, consideringMask, ignoringMask) in considerationsTable {
        if considerations.contains(consideration) {
            consideringIgnoringFlags |= consideringMask
            considerationsListDesc.insert(considerationDesc, at: 0)
        } else {
            consideringIgnoringFlags |= ignoringMask
        }
    }
    return (considerationsListDesc, NSAppleEventDescriptor(uint32: consideringIgnoringFlags)) // old-style flags (list of enums), new-style flags (bitmask)
}

