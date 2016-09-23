//
//  AppData.swift
//  SwiftAutomation
//
//  Swift-AE type conversion and Apple event dispatch
//

import Foundation
import AppKit


// TO DO: add `var fullyUnpackSpecifiers: Bool = false` compatibility flag; note that the simplest and safest (if not the most efficient) way to do this is to call the specifier's `unpackParentSpecifiers(clearCachedDesc:true)` method immediately after unpacking it, though since this option should almost never be needed (an app should always accept object specifiers it created) efficiency isn't a concern (the unpack...Specifier methods could also unroll the specifier chain, of course, but then there'd be two code paths for doing the same thing which isn't ideal maintenance-wise). (The only known app that requires this compatibility flag is iView Media Pro, which has an amusing pair of bugs that [#1] cause it to return by-index specifiers with a non-standard though still acceptable selector type [typeUInt32, IIRC], but requires by-index specifers passed as parameters to use typeSInt32 selectors and [#2] throws an error if given any other type instead of coercing it to the required type itself. AppleScript masks these because it _always_ fully unpacks and repacks each specifier, coercing indexes to typeSInt32 as it does. However, converting Specifiers<->NSAppleEventDescriptors in SwiftAutomation takes longer than the equivalent reference<->AEDesc conversions in AppleScript, so the only way to match AS for speed is to avoid full unpacking unless/until actually needed [for display purposes].)

// TO DO: file system specifiers (typeAlias, typeFileURL, typeFSRef, etc) currently don't roundtrip (they all get coerced down to typeFileURL, regardless of their original type, and URL instances always pack as typeFileURL); this may or may not be a problem when dealing with older Carbon apps. One solution may be an `isFileURLCompatible` flag that, if set to false, packs URLs as as typeAlias if the path identifies an existing FS object and typeFileURL if it does not. (Packing as typeFSRef is redundant and typeFSSpec is defunct, so those should not need supported. The only other use case is HFS path strings and `file` object specifiers [which also take an HFS path as selector data]; the former is still used by some older Carbon apps as a replacement to typeFSSpec; the latter is understood by Cocoa apps but is grossly inferior to typeFileURL so packing as that should never be needed.)


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


private let absoluteOrdinalCodes = [SwiftAutomation_kAEFirst, SwiftAutomation_kAEMiddle, SwiftAutomation_kAELast, SwiftAutomation_kAEAny, SwiftAutomation_kAEAll]


open class AppData {
        
    public var isInt64Compatible: Bool = true // While AppData.pack() always packs integers within the SInt32.min...SInt32.max range as typeSInt32, if the isInt64Compatible flag is true then it will use typeUInt32/typeSInt64/typeUInt64 for integers outside of that range. Some older Carbon-based apps (e.g. MS Excel) may not accept these larger integer types, so set this flag false when working with those apps to pack large integers as Doubles instead, effectively emulating AppleScript which uses SInt32 and Double only. (Caution: as in AppleScript, integers beyond ±2**52 will lose precision when converted to Double.)
    
    // the following properties are mainly for internal use, but SpecifierFormatter may also them when rendering app roots
    public let target: TargetApplication
    public let launchOptions: LaunchOptions // TO DO: should launchOptions and relaunchMode move to TargetApplication?
    public let relaunchMode: RelaunchMode
    
    public let glueClasses: GlueClasses // holds all glue-defined Specifier and Symbol classes so unpack() can instantiate them as needed (also contains SpecifierFormatter, though since only one formatter instance is needed it's already instantiated for convenience)
    
    private var _targetDescriptor: NSAppleEventDescriptor? = nil // targetDescriptor() creates an AEAddressDesc for the target process when dispatching first Apple event, caching it here for subsequent reuse
    
    private var transactionID: Int = kAnyTransactionID
    
    public var formatter: SpecifierFormatter { return self.glueClasses.formatter } // convenience accessor
    
    
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
    
    public var application: RootSpecifier {
        return self.glueClasses.applicationType.init(rootObject: AppRootDesc, appData: self)
    }
    
    public var app: RootSpecifier {
        return self.glueClasses.rootSpecifierType.init(rootObject: AppRootDesc, appData: self)
    }
    
    public var con: RootSpecifier {
        return self.glueClasses.rootSpecifierType.init(rootObject: ConRootDesc, appData: self)
    }
    
    public var its: RootSpecifier {
        return self.glueClasses.rootSpecifierType.init(rootObject: ItsRootDesc, appData: self)
    }
    
    
    /******************************************************************************/
    // Convert a Swift value to an Apple event descriptor
    
    private let kNSBooleanType = type(of: NSNumber(value: true))
    private let kNSNumberType = type(of: NSNumber(value: 1))
    
    
    public func pack(_ value: Any) throws -> NSAppleEventDescriptor {
        // note: Swift's Bool/Int/Double<->NSNumber bridging sucks, so NSNumber instances require special processing to ensure the underlying value's exact type (Bool/Int/Double/etc) isn't lost in translation
        if type(of: value) == self.kNSBooleanType || value is DarwinBoolean { // test for NSNumber(bool:) or Swift Bool (true/false)
            // important: 
            // - the first test assumes NSNumber class cluster always returns an instance of __NSCFBooleanType (or at least something that can be distinguished from all other NSNumbers)
            // - `value is Bool/Int/Double` always returns true for any NSNumber, so must not be used; however, checking for BooleanType returns true only for Bool (or other Swift types that implement BooleanType protocol) so should be safe
            return NSAppleEventDescriptor(boolean: value as! Bool)
        } else if type(of: value) == self.kNSNumberType { // test for any other NSNumber (but not Swift numeric types as those will be dealt with below)
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
            if obj.isFileURL {
             // TO DO: what about packing as typeAlias if it's a bookmark URL? PROBLEM: Unlike Cocoa's NSURL, Swift's URL struct doesn't implement isFileReferenceURL(), so either need to coerce to NSURL in order to determine whether to pack as typeAlias or typeFileURL, or else cross fingers and hope that always packing as typeFileURL won't cause various crusty/flaky/elderly (Carbon) apps to puke because they're expecting typeAlias and don't have the wits to coerce the given descriptor to that type before trying to unpack it. Ideally we'd cache the original AEDesc within the unpacked Swift value (c.f. Specifier), but we can't do that without subclassing, and URL is a struct so we'd have to subclass NSURL (see AppleEventBridge's AEMURL.m for existing implementation of this), but what happens when that gets coerced to a Swift URL? (Seamless Cocoa-Swift integration my arse...).
                return NSAppleEventDescriptor(fileURL: obj)
            }
            
        // TO DO: will following cases still be needed? (depends on how transparent Swift's ObjC bridging is; if the SelfPacking protocol test matches Swift collections but not their Cocoa equivalents then yes)
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
            if val <= UInt32(Int32.max) {
                return NSAppleEventDescriptor(int32: Int32(val))
            } else if self.isInt64Compatible {
                return NSAppleEventDescriptor(descriptorType: typeUInt32, bytes: &val, length: MemoryLayout<UInt32>.size)!
            } else {
                return NSAppleEventDescriptor(double: Double(val))
            }
        case var val as Int64:
            if val >= Int64(Int32.min) && val <= Int64(Int32.max) {
                return NSAppleEventDescriptor(int32: Int32(val))
            } else if self.isInt64Compatible {
                return NSAppleEventDescriptor(descriptorType: typeSInt64, bytes: &val, length: MemoryLayout<Int64>.size)!
            } else {
                return NSAppleEventDescriptor(double: Double(val)) // caution: may be some loss of precision
            }
        case var val as UInt64:
            if val <= UInt64(Int32.max) {
                return NSAppleEventDescriptor(int32: Int32(val))
            } else if self.isInt64Compatible {
                return NSAppleEventDescriptor(descriptorType: typeUInt64, bytes: &val, length: MemoryLayout<UInt64>.size)!
            } else {
                return NSAppleEventDescriptor(double: Double(val)) // caution: may be some loss of precision
            }
        case let val as Float:
            return NSAppleEventDescriptor(double: Double(val))
        default:
            ()
            // TO DO: if value is ErrorType, either rethrow it as-is, or poss. chain it to PackError; e.g. see ObjectSpecifier.unpackParentSpecifiers(), which needs to report [rare] errors but can't throw itself; this should allow APIs that can't raise errors directly (e.g. specifier constructors) to have those errors raised if/when used in commands (which can throw)
        }
        throw PackError(object: value)
    }
    
    /******************************************************************************/
    // Convert an Apple event descriptor to the specified Swift type, coercing it as necessary
    
    public func unpack<T>(_ desc: NSAppleEventDescriptor) throws -> T {
        
        // TO DO: also have to allow for possibility of Optional<T> in case client requests that? (the optional should be ignored); one benefit of this is it allows results to be assigned to an existing var of type Optional<T>; currently user would need to explicitly cast the command's result to T first; the problem here is that it's impossible to test if T is an Optional (same problem as with Array<T> and other generic types); thus the solution would be to extend Optional with SelfPacking and SelfUnpacking (same as for Array, etc above)
        
        // TO DO: will these tests also match NSString, NSDate, NSArray, etc, or do those need tested for separately?
        
        if T.self == Any.self || T.self == AnyObject.self {
            return try self.unpackAny(desc) as! T
        } else if let t = T.self as? SelfUnpacking.Type { // Array, Dictionary
            return try t.SwiftAutomation_unpackSelf(desc, appData: self) as! T
        } else if isMissingValue(desc) {
            // TO DO: ALWAYS handle `missing value` as special case; DON'T allow it to coerce to any other type (e.g. typeUnicodeText) even if AEM allows it
            throw UnpackError(appData: self, descriptor: desc, type: T.self, message: "Can't coerce 'missing value' descriptor to Swift type (not a supported sum type): \(T.self)") // TO DO: raise a MissingValueError instead? that'd make it easier to distinguish errors caused by app returning 'missing value' when client wants a normal value (e.g. string)? or is it better to force user to be a good type citizen and always state exactly what they want, e.g. StringOrMissingValue?
        } else if T.self == Bool.self {
            return desc.booleanValue as! T
        } else if T.self == Int.self { // TO DO: this assumes Int will _always_ be 64-bit (on macOS); is that safe?
            if desc.descriptorType == typeSInt32 { // shortcut for common case where descriptor is already a standard 32-bit int
                return Int(desc.int32Value) as! T
            } else if let result = self.unpackInt(desc) {
                return Int(result) as! T
            }
        } else if T.self == UInt.self {
            if let result = self.unpackInt(desc) {
                return Int(result) as! T
            }
        } else if T.self == Double.self {
            if let doubleDesc = desc.coerce(toDescriptorType: typeIEEE64BitFloatingPoint) {
                return Double(doubleDesc.doubleValue) as! T
            }
        } else if T.self == String.self {
            if let result = desc.stringValue { // TO DO: fail if desc is typeType, typeEnumerated, etc.? or convert to name [if known] and return that? (i.e. typeType, etc. can always coerce to typeUnicodeText, but this is misleading and could cause problems e.g. when a value may be string or missingValue)
                return result as! T
            }
        } else if T.self is Query.Type { // note: user typically specifies exact class ([PREFIX][Object|Elements]Specifier)
            if let result = try self.unpackAny(desc) as? T { // specifiers can be composed of several AE types, so unpack first then check type
                return result
            }
        } else if T.self is Symbol.Type {
            if symbolDescriptorTypes.contains(desc.descriptorType) {
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
        } else if T.self == Int8.self { // lack of common protocols on Integer types is a pain
            if let n = self.unpackInt(desc), let result = Int8(exactly: n) {
                return result as! T
            }
        } else if T.self == Int16.self {
            if let n = self.unpackInt(desc), let result = Int16(exactly: n) {
                return result as! T
            }
        } else if T.self == Int32.self {
            if let n = self.unpackInt(desc), let result = Int32(exactly: n) {
                return result as! T
            }
        } else if T.self == Int64.self {
            if let n = self.unpackInt(desc), let result = Int64(exactly: n) {
                return result as! T
            }
        } else if T.self == UInt8.self {
            if let n = self.unpackUInt(desc), let result = UInt8(exactly: n) {
                return result as! T
            }
        } else if T.self == UInt16.self {
            if let n = self.unpackUInt(desc), let result = UInt16(exactly: n) {
                return result as! T
            }
        } else if T.self == UInt32.self {
            if let n = self.unpackUInt(desc), let result = UInt32(exactly: n) {
                return result as! T
            }
        } else if T.self == UInt64.self {
            if let n = self.unpackUInt(desc), let result = UInt64(exactly: n) {
                return result as! T
            }
        } else if T.self == Float.self {
            if let doubleDesc = desc.coerce(toDescriptorType: typeIEEE64BitFloatingPoint),
                    let result = Float(exactly: doubleDesc.doubleValue) {
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
    
    // TO DO: rename the following unpack methods as `unpackAsTYPE(_)`?
    
    public func unpackAny(_ desc: NSAppleEventDescriptor) throws -> Any { // TO DO: double-check that Optional<T>.some(VALUE)/Optional<T>.none are never returned here (i.e. cMissingValue AEDescs must always unpack as non-generic MissingValue when return type is Any to avoid dropping user into Optional<T>.some(nil) hell, and only unpack as Optional<T>.none when caller has specified an exact type for T, in which case `unpack<T>(_)->T` will be unpack it itself.)
        switch desc.descriptorType {
            // common AE types
        case typeTrue, typeFalse, typeBoolean:
            return desc.booleanValue
        case typeSInt32, typeSInt16:
            return desc.int32Value
        case typeIEEE64BitFloatingPoint, typeIEEE32BitFloatingPoint, type128BitFloatingPoint:
            return desc.doubleValue
        case typeChar, typeIntlText, typeUTF8Text, typeUTF16ExternalRepresentation, typeStyledText, typeUnicodeText, typeVersion:
            guard let result = desc.stringValue else { //  this should never fail unless the AEDesc contains mis-encoded text data (e.g. claims to be typeUTF8Text but contains non-UTF8 byte sequences)
                throw UnpackError(appData: self, descriptor: desc, type: Any.self, message: "Corrupt descriptor.")
            }
            return result
        case typeLongDateTime:
            guard let result = desc.dateValue else { // ditto
                throw UnpackError(appData: self, descriptor: desc, type: Any.self, message: "Corrupt descriptor.")
            }
            return result
        case typeAEList:
            return try Array.SwiftAutomation_unpackSelf(desc, appData: self) as [Any]
        case typeAERecord:
            return try Dictionary.SwiftAutomation_unpackSelf(desc, appData: self) as [Symbol:Any]
        case typeAlias, typeBookmarkData, typeFileURL, typeFSRef, SwiftAutomation_typeFSS: // note that typeFSS is long defunct so shouldn't be encountered unless dealing with exceptionally old 32-bit Carbon apps, while a `file "HFS:PATH:"` object specifier (typeObjectSpecifier of cFile; basically an AppleScript kludge-around to continue supporting the `file [specifier] "HFS:PATH:"` syntax form despite typeFSS going away) is indistinguishable from any other object specifier so will unpack as an explicit `APPLICATION().files["HFS:PATH:"]` or `APPLICATION().elements("file")["HFS:PATH:"]` specifier depending on whether or not the glue defines a `file[s]` keyword (TBH, not sure if there are any apps do return AEDescs that represent file system locations this way.)
            guard let result = desc.fileURLValue else { // ditto
                throw UnpackError(appData: self, descriptor: desc, type: Any.self, message: "Corrupt descriptor.")
            }
            return result
        case typeType, typeEnumerated, typeProperty, typeKeyword:
            return isMissingValue(desc) ? MissingValue : self.unpackSymbol(desc)
            // object specifiers
        case typeObjectSpecifier:
            return try self.unpackObjectSpecifier(desc)
        case typeInsertionLoc:
            return try self.unpackInsertionLoc(desc)
        case typeRangeDescriptor:
            return try self.unpackRangeDescriptor(desc)
        case typeNull: // null descriptor indicates object specifier root
            return self.application
        case typeCurrentContainer:
            return self.con
        case typeObjectBeingExamined:
            return self.its
        case typeCompDescriptor:
            return try self.unpackCompDescriptor(desc)
        case typeLogicalDescriptor:
            return try self.unpackLogicalDescriptor(desc)
            
            // less common types
        case typeSInt64:
            return self.unpackInt(desc)!
        case typeUInt64, typeUInt32, typeUInt16:
            return self.unpackUInt(desc)!
        case typeQDPoint, typeQDRectangle, typeRGBColor:
            return try self.unpack(desc) as [Int]
        default:
            if desc.isRecordDescriptor {
                return try Dictionary.SwiftAutomation_unpackSelf(desc, appData: self) as [Symbol:Any]
            }
            return desc
        }
    }
    
    // helpers for the above
    
    private func unpackInt(_ desc: NSAppleEventDescriptor) -> Int? {
        // coerce the descriptor (whatever it is - typeSInt16, typeUInt32, typeUnicodeText, etc.) to typeSIn64 (hoping the Apple Event Manager has remembered to install TYPE-to-SInt64 coercion handlers for all these types too), and unpack as Int[64]
        if let intDesc = desc.coerce(toDescriptorType: typeSInt64) {
            var result: Int64 = 0
            (intDesc.data as NSData).getBytes(&result, length: MemoryLayout<Int64>.size)
            return Int(result)
        } else {
            return nil
        }
    }
    
    private func unpackUInt(_ desc: NSAppleEventDescriptor) -> UInt? {
            // same as above, except for unsigned
        if let intDesc = desc.coerce(toDescriptorType: typeUInt64) {
            var result: UInt64 = 0
            (intDesc.data as NSData).getBytes(&result, length: MemoryLayout<UInt64>.size)
            return UInt(result)
        } else {
            return nil
        }
    }
    
    /******************************************************************************/
    // Supporting methods for unpacking symbols and specifiers
    
    func unpackSymbol(_ desc: NSAppleEventDescriptor) -> Symbol {
        return self.glueClasses.symbolType.symbol(code: desc.typeCodeValue, type: desc.descriptorType, descriptor: desc)
    }
    
    func unpackAEProperty(_ code: OSType) -> Symbol { // used by Dictionary extension to unpack AERecord's OSType-based keys as glue-defined Symbols
        return self.glueClasses.symbolType.symbol(code: code, type: typeProperty, descriptor: nil) // TO DO: confirm using `typeProperty` here won't cause any problems (AppleScript/AEM can be a bit loose on which DescTypes to use on AEDescs that hold OSType data, tending to use typeType for everything that isn't typeEnumerated)
    }
    
    func unpackInsertionLoc(_ desc: NSAppleEventDescriptor) throws -> Specifier {
        guard let _ = desc.forKeyword(keyAEObject), // only used to check InsertionLoc record is correctly formed // TO DO: in unlikely event of receiving a malformed record, would be simpler for unpackParentSpecifiers to use a RootSpecifier that throws error on use, avoiding need for extra check here
            let insertionLocation = desc.forKeyword(keyAEPosition) else {
                throw UnpackError(appData: self, descriptor: desc, type: self.glueClasses.insertionSpecifierType,
                                  message: "Can't unpack malformed insertion specifier.")
        }
        return self.glueClasses.insertionSpecifierType.init(insertionLocation: insertionLocation,
                                                         parentQuery: nil, appData: self, cachedDesc: desc)
    }
    
    func unpackObjectSpecifier(_ desc: NSAppleEventDescriptor) throws -> Specifier {
        guard let _ = desc.forKeyword(SwiftAutomation_keyAEContainer), // container desc is only used in unpackParentSpecifiers, but confirm its existence
            let wantType = desc.forKeyword(SwiftAutomation_keyAEDesiredClass),
            let selectorForm = desc.forKeyword(SwiftAutomation_keyAEKeyForm),
            let selectorDesc = desc.forKeyword(SwiftAutomation_keyAEKeyData) else {
                throw UnpackError(appData: self, descriptor: desc, type: self.glueClasses.objectSpecifierType,
                                  message: "Can't unpack malformed object specifier.")
        }
        do {
            let formCode = selectorForm.enumCodeValue
            // unpack selectorData, unless it's a property code or absolute/relative ordinal (in which case use its prop/enum descriptor as-is)
            let selectorData = (formCode == SwiftAutomation_formPropertyID
                || formCode == SwiftAutomation_formRelativePosition // TO DO: shouldn't this check seld is prev/next, same as abs. ordinals?
                || formCode == SwiftAutomation_formAbsolutePosition
                && selectorDesc.descriptorType == typeEnumerated
                && absoluteOrdinalCodes.contains(selectorDesc.enumCodeValue)) ? selectorDesc : try self.unpackAny(selectorDesc)
            // TO DO: need 'strict AS emulation' option to fully unpack and repack specifiers, re-setting cachedDesc (TBH, only app that ever had this problem was iView Media Pro, since it takes a double whammy of app bugs to cause an app to puke on receiving objspecs it previously created itself)
            if formCode == SwiftAutomation_formRange || formCode == SwiftAutomation_formTest
                || (formCode == SwiftAutomation_formAbsolutePosition && selectorDesc.enumCodeValue == SwiftAutomation_kAEAll) {
                return self.glueClasses.multiObjectSpecifierType.init(wantType: wantType, selectorForm: selectorForm, selectorData: selectorData,
                                                                      parentQuery: nil, appData: self, cachedDesc: desc)
            } else {
                return self.glueClasses.objectSpecifierType.init(wantType: wantType, selectorForm: selectorForm, selectorData: selectorData,
                                                                 parentQuery: nil, appData: self, cachedDesc: desc)
            }
        } catch {
            throw UnpackError(appData: self, descriptor: desc, type: self.glueClasses.objectSpecifierType,
                              message: "Can't unpack object specifier's selector data.") // TO DO: need to chain errors
        }
    }
    
    func unpackRangeDescriptor(_ desc: NSAppleEventDescriptor) throws -> RangeSelector {
        return try RangeSelector(appData: self, desc: desc)
    }
    
    func unpackCompDescriptor(_ desc: NSAppleEventDescriptor) throws -> TestClause {
        if let operatorType = desc.forKeyword(SwiftAutomation_keyAECompOperator),
            let operand1Desc = desc.forKeyword(SwiftAutomation_keyAEObject1),
            let operand2Desc = desc.forKeyword(SwiftAutomation_keyAEObject2) {
                // TO DO: sanity-check that operatorType is valid (kAELessThan, etc)?
                // TO DO: if the following fail, catch and rethrow with the full comparison descriptor for context? or is this just getting overly paranoid for non-user errors that'll never occur in practice
                let operand1 = try self.unpackAny(operand1Desc)
                let operand2 = try self.unpackAny(operand2Desc)
                if operatorType.typeCodeValue == kAEContains && !(operand1 is ObjectSpecifier) {
                    if let op2 = operand2 as? ObjectSpecifier {
                        return ComparisonTest(operatorType: gIsIn, operand1: op2, operand2: operand1, appData: self, cachedDesc: desc)
                    } // else fall through to throw
                } else if let op1 = operand1 as? ObjectSpecifier {
                    return ComparisonTest(operatorType: operatorType, operand1: op1, operand2: operand2, appData: self, cachedDesc: desc)
                } // else fall through to throw
        }
        throw UnpackError(appData: self, descriptor: desc, type: TestClause.self, message: "Can't unpack comparison test: malformed descriptor.")
        
    }
    
    func unpackLogicalDescriptor(_ desc: NSAppleEventDescriptor) throws -> TestClause {
        if let operatorType = desc.forKeyword(SwiftAutomation_keyAELogicalOperator),
            let operandsDesc = desc.forKeyword(keyAEObject) {
                // TO DO: also check operatorType is valid?
                let operands = try self.unpack(operandsDesc) as [TestClause] // TO DO: catch and rethrow with additional details
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

    let DefaultSendMode = SendOptions.canSwitchLayer
    let DefaultConsiderations = packConsideringAndIgnoringFlags([.case])
    
    let NoResult = MissingValue // returned by commands that have no return value (since returning `void` will be an even bigger PITA)
    
    // if target process is no longer running, Apple Event Manager will return an error when an event is sent to it
    let RelaunchableErrorCodes: Set<Int> = [-600, -609]
    // if relaunchMode = .Limited, only 'launch' and 'run' are allowed to restart a local application that's been quit
    let LimitedRelaunchEvents: [(OSType,OSType)] = [(kCoreEventClass, kAEOpenApplication), (SwiftAutomation_kASAppleScriptSuite, SwiftAutomation_kASLaunchEvent)]
    
    private func send(event: NSAppleEventDescriptor, sendMode: SendOptions, timeout: TimeInterval) throws -> NSAppleEventDescriptor { // used by sendAppleEvent()
        do {
            return try event.sendEvent(options: sendMode, timeout: timeout) // throws NSError on AEM errors (but not app errors)
        } catch { // 'launch' events normally return 'not handled' errors, so just ignore those
            if (error as NSError).code == -1708
                && event.attributeDescriptor(forKeyword: keyEventClassAttr)!.typeCodeValue == SwiftAutomation_kASAppleScriptSuite
                && event.attributeDescriptor(forKeyword: keyEventIDAttr)!.typeCodeValue == SwiftAutomation_kASLaunchEvent {
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
                                  requestedType: Symbol? = nil, // event's `as` parameter, if any; note: if given, any `keyAERequestedType` parameter supplied via `keywordParameters:` will be ignored
                                  waitReply: Bool = true, // wait for application to respond before returning?
                                  sendOptions: SendOptions? = nil, // raw send options (these are rarely needed); if given, `waitReply:` is ignored
                                  withTimeout: TimeInterval? = nil, // no. of seconds to wait before raising timeout error (-1712); may also be default/never
                        //        returnID: AEReturnID, // TO DO: need to check correct procedure for this; should send return auto-generated returnID?
                                  considering: ConsideringOptions? = nil) throws -> T { // coerce and unpack result as this type or return raw reply event if T is NSDescriptor; default is Any
        // note: human-readable command and parameter names are only used (if known) in error messages
        // TO DO: all errors occurring within this method should be caught and rethrown as CommandError, allowing error message to include a description of the failed command as well as the error that occurred
        // Create a new AppleEvent descriptor (throws ConnectionError if target app isn't found)
        let event = NSAppleEventDescriptor(eventClass: eventClass, eventID: eventID, targetDescriptor: try self.targetDescriptor(),
                                           returnID: AEReturnID(kAutoGenerateReturnID), transactionID: AETransactionID(kAnyTransactionID)) // workarounds: Carbon constants are incorrectly mapped to Int, and NSAppleEventDescriptor.h currently doesn't define its own
        // pack its keyword parameters
        for (_, code, value) in keywordParameters {
            if parameterExists(value) {
                // TO DO: catch pack errors and report (simplest to capture all input and error info in CommandError, and only process/format if displayed)
                event.setDescriptor(try self.pack(value), forKeyword: code)
            }
        }
        // pack event's direct parameter and/or subject attribute
        let hasDirectParameter = parameterExists(directParameter)
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
        event.setAttribute(subjectDesc, forKeyword: SwiftAutomation_keySubjectAttr)
        // pack requested type (`as`) parameter, if specified; note: most apps ignore this, but a few may recognize it (usually in `get` commands)  even if they don't define it in their dictionary (another AppleScript-introduced quirk); e.g. `Finder().home.get(resultType:FIN.alias) as URL` tells Finder to return a typeAlias descriptor instead of typeObjectSpecifier, which can then be unpacked as URL
        if let type = requestedType {
            event.setDescriptor(NSAppleEventDescriptor(typeCode: type.code), forKeyword: keyAERequestedType)
        }
        // event attributes
        // (note: most apps ignore considering/ignoring attributes, and always ignore case and consider everything else)
        let (considerations, consideringIgnoring) = considering == nil ? DefaultConsiderations : packConsideringAndIgnoringFlags(considering!)
        event.setAttribute(considerations, forKeyword: SwiftAutomation_enumConsiderations)
        event.setAttribute(consideringIgnoring, forKeyword: SwiftAutomation_enumConsidsAndIgnores)
        // send the event
        let sendMode = sendOptions ?? DefaultSendMode.union(waitReply ? .waitForReply : .noReply) // TO DO: finalize
        let timeout = withTimeout ?? 120 // TO DO: -sendEvent method's default/no timeout options are currently busted (rdar://21477694)
        var replyEvent: NSAppleEventDescriptor
        do {
            replyEvent = try self.send(event: event, sendMode: sendMode, timeout: timeout) // throws NSError on AEM error
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
                for key in [SwiftAutomation_keySubjectAttr, SwiftAutomation_enumConsiderations, SwiftAutomation_enumConsidsAndIgnores] {
                    event.setAttribute(event.attributeDescriptor(forKeyword: key)!, forKeyword: key)
                }
                do {
                    replyEvent = try self.send(event: event, sendMode: sendMode, timeout: timeout)
                } catch {
                    throw CommandError(appData: self, event: event, parentError: error)
                }
            } else {
                throw CommandError(appData: self, event: event, parentError: error)
            }
        }
        if sendMode.contains(.waitForReply) {
            if T.self == ReplyEventDescriptor.self { // return the entire reply event as-is
                return ReplyEventDescriptor(descriptor: replyEvent) as! T
            } else if replyEvent.paramDescriptor(forKeyword: keyErrorNumber)?.int32Value ?? 0 != 0 { // check if an application error occurred
                throw CommandError(appData: self, event: event, replyEvent: replyEvent)
            } else if let resultDesc = replyEvent.paramDescriptor(forKeyword: keyDirectObject) {
                do {
                    return try self.unpack(resultDesc) as T // TO DO: if this fails, rethrow as CommandError
                } catch {
                    throw CommandError(appData: self, event: event, replyEvent: replyEvent, parentError: error)
                }
            } // no return value or error, so fall through
        } else if sendMode.contains(.queueReply) { // get the return ID that will be used by the reply event so that client code's main loop can identify that reply event in its own event queue later on
            guard let returnIDDesc = event.attributeDescriptor(forKeyword: keyReturnIDAttr) else { // sanity check
                throw CommandError(appData: self, event: event, message: "Can't get keyReturnIDAttr.")
            }
            return try self.unpack(returnIDDesc)
        }
        if let result = NoResult as? T { // while some Apple events return a void result (either intentionally, as in `set`, or accidentally, as in crusty old Carbon apps that normally pack a return value but sometimes forget), rather than include `COMMAND()->void` glue methods in addition to `COMMAND<T>()->T` and `COMMAND()->Any`, it's simplest just to return the standard `MissingValue` constant (since client code normally ignores any return value when invoking such commands, T will be Any in which case the `NoResult as? T` cast will always succeed)
            return result
        } else {
            throw CommandError(appData: self, event: event, message: "No result.")
        }
    }
    
    
    // convenience shortcut for dispatching events using raw OSType codes only (the above method also requires human-readable command and parameter names to be supplied for error reporting purposes); users should call this via one of the `sendAppleEvent` methods on `AEApplication`/`AEItem`
    
    public func sendAppleEvent<T>(eventClass: OSType, eventID: OSType, parentSpecifier: Specifier, parameters: [OSType:Any] = [:],
                                  requestedType: Symbol? = nil, waitReply: Bool = true, sendOptions: SendOptions? = nil,
                                  withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T
    {
        var parameters = parameters
        let directParameter = parameters.removeValue(forKey: keyDirectObject) ?? NoParameter
        let keywordParameters: [KeywordParameter] = parameters.map({(name: nil, code: $0, value: $1)})
        return try self.sendAppleEvent(name: nil, eventClass: eventClass, eventID: eventID,
                                       parentSpecifier: parentSpecifier, directParameter: directParameter,
                                       keywordParameters: keywordParameters, requestedType: requestedType, waitReply: waitReply,
                                       sendOptions: sendOptions, withTimeout: withTimeout, considering: considering)
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
        assert(self.transactionID == kAnyTransactionID, "Transaction \(self.transactionID) already active.") 
        transactionID = try self.sendAppleEvent(name:nil, eventClass: kAEMiscStandards, eventID: kAEBeginTransaction,
                                                parentSpecifier: AEApp, directParameter: session) as Int
        defer {
            self.transactionID = kAnyTransactionID
        }
        var result: T
        do {
            result = try closure()
        } catch { // abort transaction, then rethrow closure error
            let _ = try? self.sendAppleEvent(name: nil, eventClass: kAEMiscStandards, eventID: kAETransactionTerminated,
                                             parentSpecifier: AEApp) as Any
            throw error
        } // else end transaction
        let _ = try self.sendAppleEvent(name: nil, eventClass: kAEMiscStandards, eventID: kAEEndTransaction,
                                        parentSpecifier: AEApp) as Any
        return result
    }
}



/******************************************************************************/
// used by AppData.sendAppleEvent() to pack ConsideringOptions as enumConsiderations (old-style) and enumConsidsAndIgnores (new-style) attributes


let considerationsTable: [(Considerations, NSAppleEventDescriptor, UInt32, UInt32)] = [
    // note: Swift mistranslates considering/ignoring mask constants as Int, not UInt32, so redefine them here
    (.case,             NSAppleEventDescriptor(enumCode: SwiftAutomation_kAECase),              0x00000001, 0x00010000),
    (.diacritic,        NSAppleEventDescriptor(enumCode: SwiftAutomation_kAEDiacritic),         0x00000002, 0x00020000),
    (.whiteSpace,       NSAppleEventDescriptor(enumCode: SwiftAutomation_kAEWhiteSpace),        0x00000004, 0x00040000),
    (.hyphens,          NSAppleEventDescriptor(enumCode: SwiftAutomation_kAEHyphens),           0x00000008, 0x00080000),
    (.expansion,        NSAppleEventDescriptor(enumCode: SwiftAutomation_kAEExpansion),         0x00000010, 0x00100000),
    (.punctuation,      NSAppleEventDescriptor(enumCode: SwiftAutomation_kAEPunctuation),       0x00000020, 0x00200000),
    (.numericStrings,   NSAppleEventDescriptor(enumCode: SwiftAutomation_kASNumericStrings),    0x00000080, 0x00800000),
]

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
    return (considerationsListDesc, UInt32Descriptor(consideringIgnoringFlags)) // old-style flags (list of enums), new-style flags (bitmask)
}

