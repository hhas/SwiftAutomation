//
//  AppData.swift
//  SwiftAutomation
//
//  Swift-AE type conversion and Apple event dispatch
//

// TO DO: AEDesc memory management: client code should always work with memory-managed instances of AppleEventDescriptor class, while AEDesc structs (which require a single owner and explicit disposal) are used internally:
//
// - AppData.pack(Any) callers take ownership of returned AEDescs and are responsible for calling AEDesc.dispose() -- TO DO: what about cached descs? (may be safest for SelfPacking objects to return copy of cached AEDesc; alternatively, use AEManagedDesc with isOwner slot to prevent cached desc being disposed by non-owner)
// - AppData.unpack…(AEDesc) methods always take ownership of AEDesc (even when throwing errors)


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
    
    open func pack(_ value: Any) throws -> AEDesc { // important: caller takes ownership of returned AEDesc
        switch value {
        case let val as SelfPacking:
            return try val.SwiftAutomation_packSelf(self)
        case let val as AEDesc: // TO DO: memory management? this API assumes caller takes ownership, so would need to copy
            return val
        case let val as Double: // beware Swift's NSNumber bridging; this will pack NSNumber as Double
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
        case let val as UInt32:
            if val <= UInt32(Int32.max) {
                return AEDesc(int32: Int32(val))
            } else if self.isInt64Compatible {
                return AEDesc(uint32: val)
            } else {
                return AEDesc(double: Double(val))
            }
        case let val as Int64:
            if val >= Int64(Int32.min) && val <= Int64(Int32.max) {
                return AEDesc(int32: Int32(val))
            } else if self.isInt64Compatible {
                return AEDesc(int64: val)
            } else {
                return AEDesc(double: Double(val)) // caution: may be some loss of precision
            }
        case let val as UInt64:
            if val <= UInt64(Int32.max) {
                return AEDesc(int32: Int32(val))
            } else if self.isInt64Compatible {
                return AEDesc(uint64: val)
            } else {
                return AEDesc(double: Double(val)) // caution: may be some loss of precision
            }
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
    
    open func unpack<T>(_ desc: AEDesc) throws -> T { // important: this takes ownership of AEDesc and will cache or dispose it before returning
        if T.self == Any.self || T.self == AnyObject.self {
            return try self.unpackAsAny(desc) as! T // this takes ownership
        } else if let type = T.self as? SelfUnpacking.Type { // note: AppleEventDescriptor, Symbol, MissingValueType, Array<>, Dictionary<>, Set<>, and Optional<> types unpack the descriptor themselves, as do any custom structs and enums defined in glues
            return try type.SwiftAutomation_unpackSelf(desc, appData: self) as! T // this takes ownership
        } else if isMissingValue(desc) {
            throw UnpackError(appData: self, desc: desc, type: T.self, message: "Can't coerce 'missing value' descriptor to \(T.self).") // this takes ownership // Important: AppData must not unpack a 'missing value' constant as anything except `MissingValue` or `nil` (i.e. the types to which it self-unpacks). AppleScript doesn't have this problem as all descriptors unpack to their own preferred type, but unpack<T>() forces a descriptor to unpack as a specific type or fail trying. While its role is to act as a `nil`-style placeholder when no other value is given, its descriptor type is typeType so left to its own devices it would naturally unpack the same as any other typeType descriptor. e.g. One of AEM's vagaries is that it supports typeType to typeUnicodeText coercions, so while permitting cDocument to coerce to "docu" might be acceptable [if not exactly helpful], allowing cMissingValue to coerce to "msng" would defeat its whole purpose.
        }
        switch T.self {
        case is Query.Type: // note: user typically specifies exact class ([PREFIX][Object|Elements]Specifier)
            if let result = try self.unpackAsAny(desc) as? T { // specifiers can be composed of several AE types, so unpack first then check its actual type is what user requested
                return result
            }
        case is Symbol.Type where symbolDescriptorTypes.contains(desc.descriptorType): // TO DO: why isn't Symbol SelfUnpacking?
            return try self.unpackAsSymbol(desc) as! T
        case is AnyHashable.Type: // while records always unpack as [Symbol:TYPE], [AnyHashable:TYPE] is a valid return type too
            if let result = try self.unpackAsAny(desc) as? AnyHashable { return result as! T }
        case is AEDesc.Type: // for internal use (e.g. getAETE()); caller takes ownership of returned AEDesc
            return desc as! T
        default: ()
        }
        // TO DO: sort error reporting (use do/catch)
        defer { desc.dispose() }
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
        case is Date.Type:
             return try desc.date() as! T
        case is URL.Type:
             return try desc.fileURL() as! T
        case is Int8.Type:
            if let n = try? desc.int32(), let result = Int8(exactly: n) { return result as! T }
        case is Int16.Type:
            if let n = try? desc.int32(), let result = Int16(exactly: n) { return result as! T }
        case is Int32.Type:
            return try desc.int32() as! T
        case is Int64.Type:
            if let n = try? desc.int64(), let result = Int64(exactly: n) { return result as! T }
        case is UInt8.Type:
            if let n = try? desc.uint32(), let result = UInt8(exactly: n) { return result as! T }
        case is UInt16.Type:
            if let n = try? desc.uint32(), let result = UInt16(exactly: n) { return result as! T }
        case is UInt32.Type:
            return try desc.uint32() as! T
        case is UInt64.Type:
            return try desc.uint64() as! T
        case is Float.Type:
            if let result = Float(exactly: try desc.double()) { return result as! T }
        default:
            ()
        }
        // desc couldn't be coerced to the specified type
        let symbol = self.glueClasses.symbolType.symbol(code: desc.descriptorType)
        let typeName = symbol.name ?? formatFourCharCodeLiteral(symbol.code)
        throw UnpackError(appData: self, desc: desc.copy(), type: T.self, message: "Can't coerce \(typeName) descriptor to \(T.self).")
    }
    
    
    /******************************************************************************/
    // Convert an Apple event descriptor to its preferred Swift type, as determined by its descriptorType
    
    open func unpackAsAny(_ desc: AEDesc) throws -> Any { // important: this takes ownership of AEDesc and will cache/dispose it before returning // note: this never returns Optionals (i.e. cMissingValue AEDescs always unpack as MissingValue when return type is Any) to avoid dropping user into Optional<T>.some(Optional<U>.none) hell.
        if desc.isRecord {
            switch desc.descriptorType {
            case typeAERecord:
                return try Dictionary.SwiftAutomation_unpackSelf(desc, appData: self) as [Symbol:Any]
            case typeObjectSpecifier:
                return try self.unpackAsObjectSpecifier(desc)
            case typeInsertionLoc:
                return try self.unpackAsInsertionLoc(desc)
            case typeCompDescriptor:
                return try self.unpackAsComparisonDescriptor(desc)
            case typeLogicalDescriptor:
                return try self.unpackAsLogicalDescriptor(desc)
            default:
                return try Dictionary.SwiftAutomation_unpackSelf(desc, appData: self) as [Symbol:Any]
            }
        }
        var dispose = true
        defer { if dispose { desc.dispose() } }
        switch desc.descriptorType {
        case typeAEList:
            dispose = false
            return try Array.SwiftAutomation_unpackSelf(desc, appData: self) as [Any]
            // common AE types
        case typeTrue, typeFalse, typeBoolean:
            return try desc.bool()
        case typeIEEE64BitFloatingPoint, typeIEEE32BitFloatingPoint, type128BitFloatingPoint: // 128-bit will be lossily coerced to 64-bit
            return try desc.double()
        case typeChar, typeIntlText, typeUTF8Text, typeUTF16ExternalRepresentation, typeStyledText, typeUnicodeText, typeVersion:
            return try desc.string()
        case typeLongDateTime:
            return try desc.date()
        case typeAlias, typeBookmarkData, typeFileURL, typeFSRef: //, typeFSS: // note: typeFSS is long defunct so shouldn't be encountered unless dealing with exceptionally old 32-bit Carbon apps, while a `file "HFS:PATH:"` object specifier (typeObjectSpecifier of cFile; basically an AppleScript kludge-around to continue supporting the `file [specifier] "HFS:PATH:"` syntax form despite typeFSS going away) is indistinguishable from any other object specifier so will unpack as an explicit `APPLICATION().files["HFS:PATH:"]` or `APPLICATION().elements("file")["HFS:PATH:"]` specifier depending on whether or not the glue defines a `file[s]` keyword (TBH, not sure if there are any apps do return AEDescs that represent file system locations this way.)
            return try desc.fileURL() as URL
        case typeType, typeEnumerated, typeProperty, typeKeyword:
            if isMissingValue(desc) {
                return MissingValue
            } else {
                dispose = false
                return try self.unpackAsSymbol(desc)
            }
        case typeNull: // null descriptor indicates object specifier root
            return self.application
        case typeCurrentContainer:
            return self.con
        case typeObjectBeingExamined:
            return self.its
        case typeUInt64, typeUInt32, typeUInt16:
            return try desc.uint()
        case typeQDPoint, typeQDRectangle, typeRGBColor:
            return try self.unpack(desc) as [Int]
        // TO DO: what about unpacking
         default:
            dispose = false
            return AppleEventDescriptor(desc: desc)
        }
    }
    
    /******************************************************************************/
    // Supporting methods for unpacking symbols and specifiers
    
    
    func recordKey(forCode code: OSType) -> Symbol { // used by Dictionary extension to unpack AERecord's OSType-based keys as glue-defined Symbols
        return self.glueClasses.symbolType.symbol(code: code, type: typeProperty, descriptor: nil)
    }
    
    func unpackAsSymbol(_ desc: AEDesc) throws -> Symbol { // this takes ownership
        return self.glueClasses.symbolType.symbol(code: try! desc.fourCharCode(), type: desc.descriptorType, descriptor: desc)
    }
    
    func unpackAsInsertionLoc(_ desc: AEDesc) throws -> Specifier {
        guard let (container, position) = try? desc.insertionLocation() else {
                throw UnpackError(appData: self, desc: desc, type: self.glueClasses.insertionSpecifierType,
                                  message: "Can't unpack malformed insertion specifier.")
        }
        container.dispose() // only used to check InsertionLoc record is correctly formed // TO DO:
        return self.glueClasses.insertionSpecifierType.init(position: position, parentQuery: nil, appData: self, descriptor: desc)
    }
    
    
    private let _absoluteOrdinalCodes: Set<OSType> = [OSType(kAEFirst), OSType(kAEMiddle), OSType(kAELast), OSType(kAEAny), OSType(kAEAll)]
    private let _relativeOrdinalCodes: Set<OSType> = [OSType(kAEPrevious), OSType(kAENext)]

    
    func unpackAsObjectSpecifier(_ desc: AEDesc) throws -> Specifier {
        let (wantType, parentDesc, selectorForm, selectorDesc) = try desc.objectSpecifier() // TO DO: catch and rethrow with more detailed error? // TO DO: ownership
        do { // unpack selectorData, unless it's a property code or absolute/relative ordinal (in which case use its 'prop'/'enum' descriptor as-is)
            var selectorData: Any // the selector won't be unpacked if it's a property/relative/absolute ordinal
            var objectSpecifierClass = self.glueClasses.objectSpecifierType // reference forms returned by apps usually describe one-to-one relationships
            switch selectorForm {
            case OSType(formPropertyID): // property
                if ![typeType, typeProperty].contains(selectorDesc.descriptorType) {
                    selectorDesc.dispose()
                    throw UnpackError(appData: self, desc: desc, type: self.glueClasses.objectSpecifierType,
                                      message: "Can't unpack malformed object specifier.")
                }
                selectorData = AppleEventDescriptor(desc: selectorDesc)
            case OSType(formAbsolutePosition): // by-index or first/middle/last/any/all ordinal
                if let ordinal = try? selectorDesc.enumCode(), self._absoluteOrdinalCodes.contains(ordinal) { // don't unpack ordinals
                    if ordinal == kAEAll { // `all` ordinal = one-to-many relationship
                        objectSpecifierClass = self.glueClasses.multiObjectSpecifierType
                    }
                    selectorData = AppleEventDescriptor(desc: selectorDesc)
                } else { // unpack index (normally Int32, though the by-index form can take any type of selector as long as the app understands it)
                    selectorData = try self.unpack(selectorDesc)
                }
            case OSType(formName), OSType(formUniqueID):
                selectorData = try self.unpack(selectorDesc)
            case OSType(formRelativePosition): // before/after
                guard let code = try? selectorDesc.enumCode(), self._relativeOrdinalCodes.contains(code) else {
                    selectorDesc.dispose()
                    throw UnpackError(appData: self, desc: desc, type: self.glueClasses.objectSpecifierType,
                                      message: "Can't unpack malformed object specifier.")
                }
                selectorData = AppleEventDescriptor(desc: selectorDesc)
            case OSType(formRange): // by-range = one-to-many relationship
                //
                defer { selectorDesc.dispose() }
                objectSpecifierClass = self.glueClasses.multiObjectSpecifierType
                guard selectorDesc.descriptorType == typeRangeDescriptor,
                    let (startDesc, stopDesc) = try? selectorDesc.rangeDescriptor() else {
                        throw UnpackError(appData: self, desc: desc, type: RangeSelector.self,
                                          message: "Malformed selector in by-range specifier.")
                }
                do {
                    let startRange: Any
                    do {
                        startRange = try self.unpackAsAny(startDesc)
                    } catch {
                        stopDesc.dispose()
                        throw error
                    }
                    selectorData = RangeSelector(start: startRange, stop: try self.unpackAsAny(stopDesc), wantType: wantType)
                } catch {
                    startDesc.dispose()
                    stopDesc.dispose()
                    throw UnpackError(appData: self, desc: desc, type: RangeSelector.self,
                                      message: "Couldn't unpack start/stop selector in by-range specifier.")
                }
            case OSType(formTest): // by-range = one-to-many relationship
                objectSpecifierClass = self.glueClasses.multiObjectSpecifierType
                selectorData = try self.unpack(selectorDesc)
                if !(selectorData is Query) {
                    throw UnpackError(appData: self, desc: desc, type: Query.self,
                                      message: "Malformed selector in by-test specifier.")
                }
            default:
                throw UnpackError(appData: self, desc: desc, type: Query.self,
                                  message: "Unknown reference form: \(formatFourCharCodeLiteral(selectorForm)).")
            }
            return objectSpecifierClass.init(wantType: wantType,
                                             selectorForm: selectorForm, selectorData: selectorData,
                                             parentQuery: (fullyUnpackSpecifiers ? try self.unpack(parentDesc) as Query : nil),
                                             appData: self, descriptor: (fullyUnpackSpecifiers ? nil : desc))
        } catch {
            parentDesc.dispose()
            selectorDesc.dispose()
            throw UnpackError(appData: self, desc: desc, type: self.glueClasses.objectSpecifierType,
                              message: "Can't unpack object specifier's selector data.", cause: error)
        }
    }
    
    private let _comparisonOperatorCodes: Set<OSType> = [kAELessThan, kAELessThanEquals, kAEEquals,
                                                         kAENotEquals, kAEGreaterThan, kAEGreaterThanEquals,
                                                         kAEBeginsWith, kAEEndsWith, kAEContains, kAEIsIn]
    private let _logicalOperatorCodes: Set<OSType> = [OSType(kAEAND), OSType(kAEOR), OSType(kAENOT)]
    
    func unpackAsComparisonDescriptor(_ desc: AEDesc) throws -> TestClause { // takes ownership
        if let (operatorType, operand1Desc, operand2Desc) = try? desc.comparisonTest() {
            if self._comparisonOperatorCodes.contains(operatorType) { // TO DO: move validation to AEDesc.comparisonTest()?
                let operand1: Any
                do {
                    operand1 = try self.unpackAsAny(operand1Desc)
                } catch {
                    operand2Desc.dispose()
                    throw error
                }
                let operand2 = try self.unpackAsAny(operand2Desc)
                if let op1 = operand1 as? ObjectSpecifier {
                    return ComparisonTest(operatorType: operatorType, operand1: op1, operand2: operand2, appData: self, descriptor: desc)
                } else if operatorType == kAEContains, let op2 = operand2 as? ObjectSpecifier {
                    return ComparisonTest(operatorType: kAEIsIn, operand1: op2, operand2: operand1, appData: self, descriptor: desc)
                } // else fall through to throw
            } else {
                operand1Desc.dispose()
                operand2Desc.dispose()
            }
        }
        throw UnpackError(appData: self, desc: desc, type: TestClause.self, message: "Can't unpack comparison test: malformed descriptor.")
    }
    
    func unpackAsLogicalDescriptor(_ desc: AEDesc) throws -> TestClause {
        if let (operatorType, operandsDesc) = try? desc.logicalTest() {
            if self._logicalOperatorCodes.contains(operatorType) { // TO DO: as above
                let operands = try self.unpack(operandsDesc) as [TestClause]
                return LogicalTest(operatorType: operatorType, operands: operands, appData: self, descriptor: desc)
            } else {
                operandsDesc.dispose()
            }
        }
        throw UnpackError(appData: self, desc: desc, type: TestClause.self, message: "Can't unpack logical test: malformed descriptor.")
    }
    
    
    /******************************************************************************/
    // get AEAddressDesc for target application
    
    public func targetDescriptor() throws -> AEDesc? { // caution: AEDesc is borrowed; caller should not retain it
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
        let (replyEvent, errorCode) = event.sendEvent(options: sendMode, timeout: timeout)
        if errorCode == 0 {
            return replyEvent
        } else if errorCode == -1708 && event.eventClass == kASAppleScriptSuite && event.eventID == kASLaunchEvent {
            // TO DO: this is wrong; -1708 will be in reply event, not in AEM error; TO DO: check this
            // 'launch' events normally return 'not handled' errors, so just ignore those
            return AEDesc.record() // (not a full AppleEvent desc, but reply event's attributes aren't used so is equivalent to a reply event containing neither error nor result)
        } else {
            throw AutomationError(code: errorCode)
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
            defer { event.dispose() }
            // pack its keyword parameters
            for (paramName, code, value) in keywordParameters where isParameter(value) {
                do {
                    let tmp = try self.pack(value)
                    defer { tmp.dispose() }
                    try event.setParameter(code, to: tmp)
                } catch {
                    throw AutomationError(code: error._code, message: "Invalid \(paramName ?? formatFourCharCodeLiteral(code)) parameter.", cause: error)
                }
            }
            // pack event's direct parameter and/or subject attribute
            let hasDirectParameter = isParameter(directParameter)
            if hasDirectParameter { // if the command includes a direct parameter, pack that normally as its direct param
                let tmp = try self.pack(directParameter)
                defer { tmp.dispose() }
                try event.setParameter(keyDirectObject, to: tmp)
            }
            // if command method was called on root Application (null) object, the event's subject is also null...
            var subjectDesc = AppRootDesc
            defer {subjectDesc.dispose() } // check this
            // ... but if the command was called on a Specifier, decide if that specifier should be packed as event's subject
            // or, as a special case, used as event's keyDirectObject/keyAEInsertHere parameter for user's convenience
            if !(parentSpecifier is RootSpecifier) { // technically Application, but there isn't an explicit class for that
                if eventClass == kAECoreSuite && eventID == kAECreateElement { // for user's convenience, `make` command is treated as a special case
                    // if `make` command is called on a specifier, use that specifier as event's `at` parameter if not already given
                    if let tmp = try? event.parameter(keyAEInsertHere) { // an `at` parameter was already given, so pack parent specifier as event's subject attribute
                        tmp.dispose()
                        subjectDesc = try self.pack(parentSpecifier)
                    } else { // else pack parent specifier as event's `at` parameter and use null as event's subject attribute
                        let tmp = try self.pack(parentSpecifier)
                        defer { tmp.dispose() }
                        try event.setParameter(keyAEInsertHere, to: tmp)
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
                try event.packFixedSizeParameter(keyAERequestedType, value: type.code, as: typeType)
            }
            // event attributes
            // (note: most apps ignore considering/ignoring attributes, and always ignore case and consider everything else)
            if considering == nil {
                let (considerations, consideringIgnoring) = self.defaultConsiderations
                try event.setAttribute(AEKeyword(enumConsiderations), to: considerations)
                try event.setAttribute(AEKeyword(enumConsidsAndIgnores), to: consideringIgnoring)
            } else {
                let (considerations, consideringIgnoring) = packConsideringAndIgnoringFlags(considering!)
                defer { considerations.dispose(); consideringIgnoring.dispose() }
                try event.setAttribute(AEKeyword(enumConsiderations), to: considerations)
                try event.setAttribute(AEKeyword(enumConsidsAndIgnores), to: consideringIgnoring)
            }
            // send the event
            let sendMode = sendOptions ?? [.canInteract, waitReply ? .waitForReply : .noReply]
            let timeout = withTimeout ?? defaultTimeout
            var replyEvent = nullDescriptor
            defer { replyEvent.dispose() }
            sentEvent = event // the completed event, for use in error messages
            do {
                replyEvent = try self.send(event: event, sendMode: sendMode, timeout: timeout) // throws on AEM error
            } catch { // handle errors raised by Apple Event Manager (e.g. timeout, process not found)
                if RelaunchableErrorCodes.contains((error as NSError).code) && self.target.isRelaunchable && (self.relaunchMode == .always
                        || (self.relaunchMode == .limited && LimitedRelaunchEvents.contains(where: {$0.0 == eventClass && $0.1 == eventID}))) {
                    // event failed as target process has quit since previous event; recreate AppleEvent with new address and resend
                    self._targetDescriptor?.dispose()
                    self._targetDescriptor = nil
                    try event.setAttribute(keyAddressAttr, to: try self.targetDescriptor()!)
                    replyEvent = try self.send(event: event, sendMode: sendMode, timeout: timeout)
                } else {
                    throw error
                }
            }
            repliedEvent = replyEvent // the received event, for use in error messages
            if sendMode.contains(.waitForReply) {
                if T.self == ReplyAppleEvent.self { // return the entire reply event as-is
                    return ReplyAppleEvent(desc: replyEvent.copy()) as! T
                } else if replyEvent.errorNumber != 0 { // check if an application error occurred
                    throw AutomationError(code: replyEvent.errorNumber)
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
            throw CommandError(commandInfo: commandDescription, appData: self, event: sentEvent?.copy(), reply: repliedEvent?.copy(), cause: error)
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
    // Swift mistypes considering/ignoring mask constants as Int, not UInt32, so redefine them here
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

