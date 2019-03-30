//
//  AppData.swift
//  SwiftAutomation
//
//  Swift-AE type conversion and Apple event dispatch
//

import Foundation
import AppKit
import Carbon

// TO DO: what about applying self-packing protocol/extension to most/all Swift types (as is already done in TypeExtensions.swift for Array, Dictionary, Set), rather than using large `switch` statement in AppData.pack()?

// TO DO: get rid of waitReply: arg and just pass .ignoreReply to sendOptions (if ignore/wait/queue option not given, add .waitForReply by default)

// TO DO: 'considering' arg is misnamed: by default it takes [.case], which is the text attributes to *ignore*; FIX!!! (also need to review the  relevant code and the packed AE attributes against AS's, to see what it's doing; these flags are an absolute mess even without semantic/logic errors creeping into code here)


// TO DO: there are some inbuilt assumptions about `Int` and `UInt` always being 64-bit


let defaultTimeout: TimeInterval = 120 // bug workaround: AEDesc.sendEvent(options:timeout:) method's support for kAEDefaultTimeout=-1 and kNoTimeOut=-2 flags is buggy <rdar://21477694>, so for now the default timeout is hardcoded here as 120sec (same as in AS)

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
    
    private var _targetDescriptor: AEDesc? = nil // targetDescriptor() creates an AEAddressDesc for the target process when dispatching first Apple event, caching it here for subsequent reuse
    
    private var _transactionID = AETransactionID(kAnyTransactionID)
    
    
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
    
    open func pack(_ value: Any) throws -> AEDesc {
        switch value {
        case let val as SelfPacking:
            return try val.SwiftAutomation_packSelf(self)
        case let val as AEDesc: // TO DO: memory management? this API assumes caller takes ownership, so would need to copy
            return val
        case let val as Double: // beware Swift's NSNumber bridging
            return AEDesc(double: val)
        case let val as Int:
            // Note: to maximize application compatibility, always preferentially pack integers as typeSInt32, as that's the traditional integer type recognized by all apps. (In theory, packing as typeSInt64 shouldn't be a problem as apps should coerce to whatever type they actually require before unpacking, but not-so-well-designed Carbon apps sometimes explicitly typecheck instead, so will fail if the descriptor isn't the assumed typeSInt32.)
            if Int(Int32.min) <= val && val <= Int(Int32.max) {
                return AEDesc(int32: Int32(val))
            } else if self.isInt64Compatible {
                return AEDesc(int: val)
            } else {
                return AEDesc(double: Double(val)) // caution: may be some loss of precision
            }
        case let val as Bool:
            return AEDesc(bool: val)
        case let val as String:
            return AEDesc(string: val)
        case let obj as Date:
            return AEDesc(date: obj)
        case let obj as URL:
            return try AEDesc(fileURL: obj) // this will throw if not fileURL
        case let val as UInt:
            if val <= UInt(Int32.max) {
                return AEDesc(int32: Int32(val))
            } else if self.isInt64Compatible {
                return AEDesc(uint: val)
            } else {
                return AEDesc(double: Double(val))
            }
            /*
        case let val as Int8:
            return AEDesc(int32: Int32(val))
        case let val as UInt8:
            return AEDesc(int32: Int32(val))
        case let val as Int16:
            return AEDesc(int32: Int32(val))
        case let val as UInt16:
            return AEDesc(int32: Int32(val))
        case let val as Int32:
            return AEDesc(int32: Int32(val))
        case var val as UInt32:
            if val <= UInt32(Int32.max) {
                return AEDesc(int32: Int32(val))
            } else if self.isInt64Compatible {
                return AEDesc(uint32: val)
            } else {
                return AEDesc(double: Double(val))
            }
        case var val as Int64:
            if val >= Int64(Int32.min) && val <= Int64(Int32.max) {
                return AEDesc(int32: Int32(val))
            } else if self.isInt64Compatible {
                return AEDesc(int64: val)
            } else {
                return AEDesc(double: Double(val)) // caution: may be some loss of precision
            }
        case var val as UInt64:
            if val <= UInt64(Int32.max) {
                return AEDesc(int32: Int32(val))
            } else if self.isInt64Compatible {
                return AEDesc(uint64: val)
            } else {
                return AEDesc(double: Double(val)) // caution: may be some loss of precision
            }
            */
        case let val as Float:
            return AEDesc(double: Double(val))
        case let val as Error:
            throw val // if value is ErrorType, rethrow it as-is; e.g. see ObjectSpecifier.unpackParentSpecifiers(), which needs to report [rare] errors but can't throw itself; this should allow APIs that can't raise errors directly (e.g. specifier constructors) to have those errors raised if/when used in commands (which can throw)
        default:
            ()
        }
        throw PackError(object: value)
    }
    
    /******************************************************************************/
    // Convert an Apple event descriptor to the specified Swift type, coercing it as necessary
    
    open func unpack<T>(_ desc: AEDesc) throws -> T {
        if T.self == Any.self || T.self == AnyObject.self {
            return try self.unpackAsAny(desc) as! T
        } else if let t = T.self as? SelfUnpacking.Type { // note: Symbol, MissingValueType, Array<>, Dictionary<>, Set<>, and Optional<> types unpack the descriptor themselves, as do any custom structs and enums defined in glues
            return try t.SwiftAutomation_unpackSelf(desc, appData: self) as! T
        } else if isMissingValue(desc) {
            throw UnpackError(appData: self, descriptor: desc, type: T.self, message: "Can't coerce 'missing value' descriptor to \(T.self).") // Important: AppData must not unpack a 'missing value' constant as anything except `MissingValue` or `nil` (i.e. the types to which it self-unpacks). AppleScript doesn't have this problem as all descriptors unpack to their own preferred type, but unpack<T>() forces a descriptor to unpack as a specific type or fail trying. While its role is to act as a `nil`-style placeholder when no other value is given, its descriptor type is typeType so left to its own devices it would naturally unpack the same as any other typeType descriptor. e.g. One of AEM's vagaries is that it supports typeType to typeUnicodeText coercions, so while permitting cDocument to coerce to "docu" might be acceptable [if not exactly helpful], allowing cMissingValue to coerce to "msng" would defeat its whole purpose.
        }
        switch T.self {
        case is Bool.Type:
            return try desc.bool() as! T
        case is Int.Type: // TO DO: this assumes Int will _always_ be 64-bit (on macOS); is that safe?
            return try desc.int() as! T
        case is UInt.Type:
            return try desc.uint() as! T
        case is Double.Type:
            return try desc.double() as! T
        case is String.Type:
            return try desc.string() as! T
        case is Query.Type: // note: user typically specifies exact class ([PREFIX][Object|Elements]Specifier)
            if let result = try self.unpackAsAny(desc) as? T { // specifiers can be composed of several AE types, so unpack first then check type
                return result
            }
        case is Symbol.Type:
            if symbolDescriptorTypes.contains(desc.descriptorType) {
                return try self.unpackAsSymbol(desc) as! T
            }
        case is Date.Type:
             return try desc.date() as! T
        case is URL.Type:
             return try desc.fileURL() as! T
            /*
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
            if let doubleDesc = try desc.coerce(to: typeIEEE64BitFloatingPoint),
                    let result = Float(exactly: doubleDesc.doubleValue) {
                return result as! T
            }
 */
        case is AnyHashable.Type: // while records always unpack as [Symbol:TYPE], [AnyHashable:TYPE] is a valid return type too
            if let result = try self.unpackAsAny(desc) as? AnyHashable {
                return result as! T
            }
        case is AEDesc.Type:
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
    
    open func unpackAsAny(_ desc: AEDesc) throws -> Any { // note: this never returns Optionals (i.e. cMissingValue AEDescs always unpack as MissingValue when return type is Any) to avoid dropping user into Optional<T>.some(Optional<U>.none) hell.
        switch desc.descriptorType {
            // common AE types
        case typeTrue, typeFalse, typeBoolean:
            return try desc.bool()
        case typeSInt32, typeSInt16:
            return try desc.int()
        case typeIEEE64BitFloatingPoint, typeIEEE32BitFloatingPoint:
            return try desc.double()
        case type128BitFloatingPoint: // coerce down lossy
            return try unpackFixedSize(desc, as: typeIEEE64BitFloatingPoint) as Double
        case typeChar, typeIntlText, typeUTF8Text, typeUTF16ExternalRepresentation, typeStyledText, typeUnicodeText, typeVersion:
            return try desc.string()
        case typeLongDateTime:
            return try desc.date()
        case typeAEList:
            return try Array.SwiftAutomation_unpackSelf(desc, appData: self) as [Any]
        case typeAERecord:
            return try Dictionary.SwiftAutomation_unpackSelf(desc, appData: self) as [Symbol:Any]
        case typeAlias, typeBookmarkData, typeFileURL, typeFSRef: //, typeFSS: // note: typeFSS is long defunct so shouldn't be encountered unless dealing with exceptionally old 32-bit Carbon apps, while a `file "HFS:PATH:"` object specifier (typeObjectSpecifier of cFile; basically an AppleScript kludge-around to continue supporting the `file [specifier] "HFS:PATH:"` syntax form despite typeFSS going away) is indistinguishable from any other object specifier so will unpack as an explicit `APPLICATION().files["HFS:PATH:"]` or `APPLICATION().elements("file")["HFS:PATH:"]` specifier depending on whether or not the glue defines a `file[s]` keyword (TBH, not sure if there are any apps do return AEDescs that represent file system locations this way.)
            return try desc.fileURL() as URL
        case typeType, typeEnumerated, typeProperty, typeKeyword:
            return isMissingValue(desc) ? MissingValue : try self.unpackAsSymbol(desc)
            // object specifiers
        case typeObjectSpecifier:
            return try self.unpackAsObjectSpecifier(desc)
        case typeInsertionLoc:
            return try self.unpackAsInsertionLoc(desc)
        case typeNull: // null descriptor indicates object specifier root
            return self.application
        case typeCurrentContainer:
            return self.con
        case typeObjectBeingExamined:
            return self.its
        case typeCompDescriptor:
            return try self.unpackAsComparisonDescriptor(desc)
        case typeLogicalDescriptor:
            return try self.unpackAsLogicalDescriptor(desc)
        
            /*
            // less common types
        case typeSInt64:
            return self.unpackAsInt(desc)!
        case typeUInt64, typeUInt32, typeUInt16:
            return self.unpackAsUInt(desc)!
        case typeQDPoint, typeQDRectangle, typeRGBColor:
            return try self.unpack(desc) as [Int]
            // note: while there are also several AEAddressDesc types used to identify applications, these are very rarely used as command results (e.g. the `choose application` OSAX) and there's little point unpacking them anway as the only type they can automatically be mapped to is AEApplication, which has only minimal functionality anyway. Also unsupported are unit types as they only cover a handful of measurement types and in practice aren't really used for anything except measurement conversions in AppleScript.
 */
         default:
            if desc.isRecord {
                return try Dictionary.SwiftAutomation_unpackSelf(desc, appData: self) as [Symbol:Any]
            }
            return desc
        }
    }
    
    // helpers for the above
    /*
    private func unpackAsInt(_ desc: AEDesc) -> Int? {
        // coerce the descriptor (whatever it is - typeSInt16, typeUInt32, typeUnicodeText, etc.) to typeSIn64 (hoping the Apple Event Manager has remembered to install TYPE-to-SInt64 coercion handlers for all these types too), and unpack as Int[64]
        if let intDesc = try desc.coerce(to: typeSInt64) {
            var result: Int64 = 0
            (intDesc.data as NSData).getBytes(&result, length: MemoryLayout<Int64>.size)
            return Int(result) // caution: this assumes Int will always be 64-bit
        } else {
            return nil
        }
    }
    
    private func unpackAsUInt(_ desc: AEDesc) -> UInt? {
            // as above, but for unsigned ints
        if let intDesc = try desc.coerce(to: typeUInt64) {
            var result: UInt64 = 0
            (intDesc.data as NSData).getBytes(&result, length: MemoryLayout<UInt64>.size)
            return UInt(result) // caution: this assumes UInt will always be 64-bit
        } else {
            return nil
        }
    }
    */
    /******************************************************************************/
    // Supporting methods for unpacking symbols and specifiers
    
    
    func recordKey(forCode code: OSType) -> Symbol { // used by Dictionary extension to unpack AERecord's OSType-based keys as glue-defined Symbols
        return self.glueClasses.symbolType.symbol(code: code, type: typeProperty, descriptor: nil)
    }
    
    func unpackAsSymbol(_ desc: AEDesc) throws -> Symbol {
        print("unpackAsSymbol:", desc)
        return self.glueClasses.symbolType.symbol(code: try! desc.fourCharCode(), type: desc.descriptorType, descriptor: desc)
    }
    
    func unpackAsInsertionLoc(_ desc: AEDesc) throws -> Specifier {
        guard let _ = try? desc.parameter(keyAEObject), // only used to check InsertionLoc record is correctly formed
            let insertionLocation = try? desc.parameter(keyAEPosition) else {
                throw UnpackError(appData: self, descriptor: desc, type: self.glueClasses.insertionSpecifierType,
                                  message: "Can't unpack malformed insertion specifier.")
        }
        return self.glueClasses.insertionSpecifierType.init(insertionLocation: insertionLocation,
                                                         parentQuery: nil, appData: self, descriptor: desc)
    }
    
    
    private let _absoluteOrdinalCodes: Set<OSType> = [OSType(kAEFirst), OSType(kAEMiddle), OSType(kAELast), OSType(kAEAny), OSType(kAEAll)]
    private let _relativeOrdinalCodes: Set<OSType> = [OSType(kAEPrevious), OSType(kAENext)]

    
    func unpackAsObjectSpecifier(_ desc: AEDesc) throws -> Specifier {
        guard let parentDesc = try? desc.parameter(AEKeyword(keyAEContainer)), // the 'from' descriptor is normally unused; it's only required in `unpackParentSpecifiers()` when fully unpacking an object specifier (typically to generate a description string), or below if the `fullyUnpackSpecifiers` compatibility flag is set
            let wantType = try? desc.parameter(AEKeyword(keyAEDesiredClass)).typeCode(),
            let selectorForm = try? desc.parameter(AEKeyword(keyAEKeyForm)).typeCode(),
            let selectorDesc = try? desc.parameter(AEKeyword(keyAEKeyData)) else {
                throw UnpackError(appData: self, descriptor: desc, type: self.glueClasses.objectSpecifierType,
                                  message: "Can't unpack malformed object specifier.")
        }
        do { // unpack selectorData, unless it's a property code or absolute/relative ordinal (in which case use its 'prop'/'enum' descriptor as-is)
            var selectorData: Any = selectorDesc // the selector won't be unpacked if it's a property/relative/absolute ordinal
            var objectSpecifierClass = self.glueClasses.objectSpecifierType // most reference forms describe one-to-one relationships
            switch selectorForm {
            case OSType(formPropertyID): // property
                if ![typeType, typeProperty].contains(selectorDesc.descriptorType) {
                    throw UnpackError(appData: self, descriptor: desc, type: self.glueClasses.objectSpecifierType,
                                      message: "Can't unpack malformed object specifier.")
                }
            case OSType(formRelativePosition): // before/after
                if !(selectorDesc.descriptorType == typeEnumerated && self._relativeOrdinalCodes.contains(try! selectorDesc.enumCode())) {
                    throw UnpackError(appData: self, descriptor: desc, type: self.glueClasses.objectSpecifierType,
                                      message: "Can't unpack malformed object specifier.")
                }
            case OSType(formAbsolutePosition): // by-index or first/middle/last/any/all ordinal
                if selectorDesc.descriptorType == typeEnumerated && self._absoluteOrdinalCodes.contains(try! selectorDesc.enumCode()) { // don't unpack ordinals
                    if try! selectorDesc.enumCode() == kAEAll { // `all` ordinal = one-to-many relationship
                        objectSpecifierClass = self.glueClasses.multiObjectSpecifierType
                    }
                } else { // unpack index (normally Int32, though the by-index form can take any type of selector as long as the app understands it)
                    selectorData = try self.unpack(selectorDesc)
                }
            case OSType(formRange): // by-range = one-to-many relationship
                objectSpecifierClass = self.glueClasses.multiObjectSpecifierType
                if selectorDesc.descriptorType != typeRangeDescriptor {
                    throw UnpackError(appData: self, descriptor: selectorDesc, type: RangeSelector.self, message: "Malformed selector in by-range specifier.")
                }
                guard let startDesc = try? selectorDesc.parameter(keyAERangeStart),
                    let stopDesc = try? selectorDesc.parameter(keyAERangeStop) else {
                    throw UnpackError(appData: self, descriptor: selectorDesc, type: RangeSelector.self, message: "Malformed selector in by-range specifier.")
                }
                do {
                    selectorData = RangeSelector(start: try self.unpackAsAny(startDesc), stop: try self.unpackAsAny(stopDesc), wantType: wantType)
                } catch {
                    throw UnpackError(appData: self, descriptor: selectorDesc, type: RangeSelector.self, message: "Couldn't unpack start/stop selector in by-range specifier.")
                }
            case OSType(formTest): // by-range = one-to-many relationship
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
    
    private let _comparisonOperatorCodes: Set<OSType> = [kAELessThan, kAELessThanEquals, kAEEquals,
                                                         kAENotEquals, kAEGreaterThan, kAEGreaterThanEquals,
                                                         kAEBeginsWith, kAEEndsWith, kAEContains, kAEIsIn]
    private let _logicalOperatorCodes: Set<OSType> = [OSType(kAEAND), OSType(kAEOR), OSType(kAENOT)]
    
    func unpackAsComparisonDescriptor(_ desc: AEDesc) throws -> TestClause {
        if let operatorType = try? desc.parameter(AEKeyword(keyAECompOperator)).enumCode(),
            let operand1Desc = try? desc.parameter(AEKeyword(keyAEObject1)),
            let operand2Desc = try? desc.parameter(AEKeyword(keyAEObject2)),
            !self._comparisonOperatorCodes.contains(operatorType) {
                // don't bother with dedicated error reporting here as malformed operand descs that cause the following unpack calls to fail are unlikely in practice, and will still be caught and reported further up the call chain anyway
                let operand1 = try self.unpackAsAny(operand1Desc)
                let operand2 = try self.unpackAsAny(operand2Desc)
                if operatorType == kAEContains && !(operand1 is ObjectSpecifier) {
                    if let op2 = operand2 as? ObjectSpecifier {
                        return ComparisonTest(operatorType: kAEIsIn, operand1: op2, operand2: operand1, appData: self, descriptor: desc)
                    } // else fall through to throw
                } else if let op1 = operand1 as? ObjectSpecifier {
                    return ComparisonTest(operatorType: operatorType, operand1: op1, operand2: operand2, appData: self, descriptor: desc)
                } // else fall through to throw
        }
        throw UnpackError(appData: self, descriptor: desc, type: TestClause.self, message: "Can't unpack comparison test: malformed descriptor.")
    }
    
    func unpackAsLogicalDescriptor(_ desc: AEDesc) throws -> TestClause {
        if let operatorType = try? desc.parameter(AEKeyword(keyAELogicalOperator)).enumCode(),
            let operandsDesc = try? desc.parameter(AEKeyword(keyAEObject)),
            !self._logicalOperatorCodes.contains(operatorType) {
                let operands = try self.unpack(operandsDesc) as [TestClause]
                return LogicalTest(operatorType: operatorType, operands: operands, appData: self, descriptor: desc)
        }
        throw UnpackError(appData: self, descriptor: desc, type: TestClause.self, message: "Can't unpack logical test: malformed descriptor.")
    }
    
    
    /******************************************************************************/
    // get AEAddressDesc for target application
    
    public func targetDescriptor() throws -> AEDesc? {
        if self._targetDescriptor == nil { self._targetDescriptor = try self.target.descriptor(self.launchOptions) }
        return self._targetDescriptor
    }
    
    public func permissionToAutomate(eventClass: AEEventClass, eventID: AEEventID, askUserIfNeeded: Bool = true) -> Int {
        if #available(OSX 10.14, *) {
            guard var desc = self._targetDescriptor else { return procNotFound }
            return Int(AEDeterminePermissionToAutomateTarget(&desc, eventClass, eventID, askUserIfNeeded))
        } else {
            return 0
        }
    }
    
    /******************************************************************************/
    // send an Apple event

    let defaultConsiderations = packConsideringAndIgnoringFlags([.case])
    
    // if target process is no longer running, Apple Event Manager will return an error when an event is sent to it
    let RelaunchableErrorCodes: Set<Int> = [-600, -609]
    // if relaunchMode = .Limited, only 'launch' and 'run' are allowed to restart a local application that's been quit
    let LimitedRelaunchEvents: [(OSType,OSType)] = [(OSType(kCoreEventClass), OSType(kAEOpenApplication)),
                                                    (OSType(kASAppleScriptSuite), OSType(kASLaunchEvent))]
    
    private func send(event: AEDesc, sendMode: SendOptions, timeout: TimeInterval) throws -> AEDesc { // used by sendAppleEvent()
        do {
            return try event.sendEvent(options: sendMode, timeout: timeout) // throws NSError on AEM errors (but not app errors)
        
        // TO DO: this is wrong; -1708 will be in reply event, not in AEM error; FIX
        
        } catch { // 'launch' events normally return 'not handled' errors, so just ignore those
            if (error as NSError).code == -1708
                && (try! event.attribute(keyEventClassAttr).typeCode()) == kASAppleScriptSuite
                && (try! event.attribute(keyEventIDAttr).typeCode()) == kASLaunchEvent {
                    return AEDesc.record() // (not a full AppleEvent desc, but reply event's attributes aren't used so is equivalent to a reply event containing neither error nor result)
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
        var sentEvent: AEDesc?, repliedEvent: AEDesc?
        do {
            // Create a new AppleEvent descriptor (throws ConnectionError if target app isn't found)
            let event = AEDesc(eventClass: eventClass, eventID: eventID, target: try self.targetDescriptor(),
                               returnID: AEReturnID(kAutoGenerateReturnID), transactionID: AETransactionID(kAnyTransactionID))
            // pack its keyword parameters
            for (paramName, code, value) in keywordParameters where parameterExists(value) {
                do {
                    try event.setParameter(code, to: self.pack(value))
                } catch {
                    throw AutomationError(code: error._code, message: "Invalid '\(paramName ?? fourCharCode(code))' parameter.", cause: error)
                }
            }
            // pack event's direct parameter and/or subject attribute
            let hasDirectParameter = parameterExists(directParameter)
            if hasDirectParameter { // if the command includes a direct parameter, pack that normally as its direct param
                try event.setParameter(keyDirectObject, to: self.pack(directParameter))
            }
            // if command method was called on root Application (null) object, the event's subject is also null...
            var subjectDesc = AppRootDesc
            // ... but if the command was called on a Specifier, decide if that specifier should be packed as event's subject
            // or, as a special case, used as event's keyDirectObject/keyAEInsertHere parameter for user's convenience
            if !(parentSpecifier is RootSpecifier) { // technically Application, but there isn't an explicit class for that
                if eventClass == kAECoreSuite && eventID == kAECreateElement { // for user's convenience, `make` command is treated as a special case
                    // if `make` command is called on a specifier, use that specifier as event's `at` parameter if not already given
                    if (try? event.parameter(keyAEInsertHere)) != nil { // an `at` parameter was already given, so pack parent specifier as event's subject attribute
                        subjectDesc = try self.pack(parentSpecifier)
                    } else { // else pack parent specifier as event's `at` parameter and use null as event's subject attribute
                        try event.setParameter(keyAEInsertHere, to: self.pack(parentSpecifier))
                    }
                } else { // for all other commands, check if a direct parameter was already given
                    if hasDirectParameter { // pack the parent specifier as the event's subject attribute
                        subjectDesc = try self.pack(parentSpecifier)
                    } else { // else pack parent specifier as event's direct parameter and use null as event's subject attribute
                        try event.setParameter(keyDirectObject, to: self.pack(parentSpecifier))
                    }
                }
            }
            try event.setAttribute(AEKeyword(keySubjectAttr), to: subjectDesc)
            // pack requested type (`as`) parameter, if specified; note: most apps ignore this, but a few may recognize it (usually in `get` commands)  even if they don't define it in their dictionary (another AppleScript-introduced quirk); e.g. `Finder().home.get(requestedType:FIN.alias) as URL` tells Finder to return a typeAlias descriptor instead of typeObjectSpecifier, which can then be unpacked as URL
            if let type = requestedType {
                try event.setParameter(keyAERequestedType, to: AEDesc(typeCode: type.code))
            }
            // event attributes
            // (note: most apps ignore considering/ignoring attributes, and always ignore case and consider everything else)
            let (considerations, consideringIgnoring) = considering == nil ? self.defaultConsiderations : packConsideringAndIgnoringFlags(considering!)
            try event.setAttribute(AEKeyword(enumConsiderations), to: considerations)
            try event.setAttribute(AEKeyword(enumConsidsAndIgnores), to: consideringIgnoring)
            // send the event
            let sendMode = sendOptions ?? [.canInteract, waitReply ? .waitForReply : .noReply]
            let timeout = withTimeout ?? defaultTimeout
            var replyEvent: AEDesc
            sentEvent = event
            do {
                replyEvent = try self.send(event: event, sendMode: sendMode, timeout: timeout) // throws NSError on AEM error
            } catch { // handle errors raised by Apple Event Manager (e.g. timeout, process not found)
                if RelaunchableErrorCodes.contains((error as NSError).code) && self.target.isRelaunchable && (self.relaunchMode == .always
                        || (self.relaunchMode == .limited && LimitedRelaunchEvents.contains(where: {$0.0 == eventClass && $0.1 == eventID}))) {
                    // event failed as target process has quit since previous event; recreate AppleEvent with new address and resend
                    self._targetDescriptor = nil
                    let event2 = AEDesc(eventClass: eventClass, eventID: eventID,
                                                        target: try self.targetDescriptor(),
                                                        returnID: AEReturnID(kAutoGenerateReturnID),
                                                        transactionID: AETransactionID(kAnyTransactionID))
                    for i in try! 1...event.count() {
                        let (code, desc) = try! event.item(i)
                        try! event2.setParameter(code, to: desc)
                    }
                    for key in [AEKeyword(keySubjectAttr), AEKeyword(enumConsiderations), AEKeyword(enumConsidsAndIgnores)] {
                        try! event2.setAttribute(key, to: event.attribute(key))
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
                } else if (try? replyEvent.parameter(keyErrorNumber).int()) ?? 0 != 0 { // check if an application error occurred
                    throw AutomationError(code: (try? replyEvent.parameter(keyErrorNumber).int()) ?? 1)
                } else if let resultDesc = try? replyEvent.parameter(keyDirectObject) {
                    return try self.unpack(resultDesc) as T
                } // no return value or error, so fall through
            } else if sendMode.contains(.queueReply) { // get the return ID that will be used by the reply event so that client code's main loop can identify that reply event in its own event queue later on
                guard let returnIDDesc = try? event.attribute(keyReturnIDAttr) else { // sanity check
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
        let directParameter = parameters.removeValue(forKey: keyDirectObject) ?? NoParameter
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
        assert(self._transactionID == AETransactionID(kAnyTransactionID), "Transaction \(self._transactionID) already active.")
        self._transactionID = try self.sendAppleEvent(name: nil, eventClass: kAEMiscStandards, eventID: kAEBeginTransaction,
                                                      parentSpecifier: AEApp, directParameter: session as Any) as AETransactionID
        defer {
            self._transactionID = AETransactionID(kAnyTransactionID)
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


let considerationsTable: [(Considerations, AEDesc, UInt32, UInt32)] = [ // also used in AE formatter
    // note: Swift mistranslates considering/ignoring mask constants as Int, not UInt32, so redefine them here
    (.case,             AEDesc(enumCode: OSType(kAECase)),              0x00000001, 0x00010000),
    (.diacritic,        AEDesc(enumCode: OSType(kAEDiacritic)),         0x00000002, 0x00020000),
    (.whiteSpace,       AEDesc(enumCode: OSType(kAEWhiteSpace)),        0x00000004, 0x00040000),
    (.hyphens,          AEDesc(enumCode: OSType(kAEHyphens)),           0x00000008, 0x00080000),
    (.expansion,        AEDesc(enumCode: OSType(kAEExpansion)),         0x00000010, 0x00100000),
    (.punctuation,      AEDesc(enumCode: OSType(kAEPunctuation)),       0x00000020, 0x00200000),
    (.numericStrings,   AEDesc(enumCode: OSType(kASNumericStrings)),    0x00000080, 0x00800000),
]

// TO DO: review this code; is considering attr misnamed?

private func packConsideringAndIgnoringFlags(_ considerations: ConsideringOptions) -> (AEDesc, AEDesc) {
    let considerationsListDesc = AEDesc.list()
    var consideringIgnoringFlags: UInt32 = 0
    for (consideration, considerationDesc, consideringMask, ignoringMask) in considerationsTable {
        if considerations.contains(consideration) {
            consideringIgnoringFlags |= consideringMask
            try! considerationsListDesc.appendItem(considerationDesc)
        } else {
            consideringIgnoringFlags |= ignoringMask
        }
    }
    return (considerationsListDesc, AEDesc(uint32: consideringIgnoringFlags)) // old-style flags (list of enums), new-style flags (bitmask)
}

