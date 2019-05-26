//
//  AppData.swift
//  SwiftAutomation
//
//  Swift-AE type conversion and Apple event dispatch
//

// TO DO: simplify code (AppleEvent.Query types now take care of most of the correctness checks)

import Foundation
import AppleEvents

// while constants defined in AE headers are re-exported via Foundation, constants defined in OpenScripting are not
#if canImport(Carbon)
import Carbon
#endif

#if canImport(AppKit)
import AppKit
#endif


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
    
    private var _targetDescriptor: AddressDescriptor? = nil // targetDescriptor() creates an AEAddressDesc for the target process when dispatching first Apple event, caching it here for subsequent reuse
    
    private var _transactionID = AETransactionID(kAnyTransactionID)
    
    
    public required init(target: TargetApplication, launchOptions: LaunchOptions, relaunchMode: RelaunchMode, glueClasses: GlueClasses) { // should be private, but targetedCopy requires it to be required, which in turn requires it to be public; it should not be called directly, however (if an AppData instance is required for standalone use, instantiate the Application class from the default AEApplicationGlue or an application-specific glue, then get its appData property instead)
        self.target = target
        self.launchOptions = launchOptions
        self.relaunchMode = relaunchMode
        self.glueClasses = glueClasses
    }
    
    
    // create a new untargeted AppData instance for a glue file's private gUntargetedAppData constant (note: this will leak memory each time it's used so users should not call it themselves; instead, use AEApplication.untargetedAppData to return an already-created instance suitable for general programming tasks)
    public convenience init(glueClasses: GlueClasses) {
        self.init(target: .none, launchOptions: defaultLaunchOptions, relaunchMode: .never, glueClasses: glueClasses)
    }
    
    // create a targeted copy of a [typically untargeted] AppData instance; Application inits should always use this to create targeted AppData instances
    public func targetedCopy(_ target: TargetApplication, launchOptions: LaunchOptions, relaunchMode: RelaunchMode) -> Self {
        return type(of: self).init(target: target, launchOptions: launchOptions, relaunchMode: relaunchMode, glueClasses: self.glueClasses)
    }
    
    /******************************************************************************/
    // specifier roots
    
    public var application: RootSpecifier { // returns targeted application object that can build specifiers and send commands
        return self.glueClasses.applicationType.init(rootObject: appRootDesc, appData: self)
    }
    
    public var app: RootSpecifier { // returns untargeted 'application' object that can build specifiers for use in other commands only
        return self.glueClasses.rootSpecifierType.init(rootObject: appRootDesc, appData: self)
    }
    
    public var con: RootSpecifier { // returns untargeted 'container' object used to build specifiers for use in by-range specifiers only
        return self.glueClasses.rootSpecifierType.init(rootObject: conRootDesc, appData: self)
    }
    
    public var its: RootSpecifier { // returns untargeted 'object-to-test' object used to build specifiers for use in by-test specifiers only
        return self.glueClasses.rootSpecifierType.init(rootObject: itsRootDesc, appData: self)
    }
    
    
    /******************************************************************************/
    // Convert a Swift or Cocoa value to an Apple event descriptor
    
    open func pack(_ value: Any) throws -> Descriptor {
        switch value {
        case let val as SelfPacking:
            return try val.SwiftAutomation_packSelf(self)
        case let val as Descriptor:
            return val
        case let val as Double: // beware Swift's NSNumber bridging; this will pack all NSNumbers as Double, on assumption that the receiving app will coerce that to typeBoolean/typeInteger/etc as needed
            return packAsDouble(val)
        case let val as Int:
            // For best application compatibility, always pack integers as typeSInt32 if possible, as that's the traditional integer type used by AppleScript. (In theory, packing as typeSInt64 shouldn't be a problem as apps should coerce to whatever type they actually require before unpacking, but not-so-well-designed Carbon apps sometimes explicitly typecheck instead, so will fail if the descriptor isn't the assumed typeSInt32.)
            if Int(Int32.min) <= val && val <= Int(Int32.max) {
                return packAsInt32(Int32(val))
            } else if self.isInt64Compatible {
                return packAsInt64(Int64(val))
            } else {
                return packAsDouble(Double(val)) // caution: may be some loss of precision
            }
        case let val as Bool:
            return packAsBool(val)
        case let val as String:
            return packAsString(val)
        case let obj as Date:
            return packAsDate(obj)
        case let obj as URL:
            return try packAsFileURL(obj) // this will throw if not fileURL
        case let val as UInt:
            if val <= UInt(Int32.max) {
                return packAsInt32(Int32(val))
            } else if self.isInt64Compatible {
                return packAsUInt64(UInt64(val))
            } else {
                return packAsDouble(Double(val))
            }
        case let val as Int8:
            return packAsInt32(Int32(val))
        case let val as UInt8:
            return packAsInt32(Int32(val))
        case let val as Int16:
            return packAsInt32(Int32(val))
        case let val as UInt16:
            return packAsInt32(Int32(val))
        case let val as Int32:
            return packAsInt32(Int32(val))
        case let val as UInt32:
            if val <= UInt32(Int32.max) {
                return packAsInt32(Int32(val))
            } else if self.isInt64Compatible {
                return packAsUInt32(val)
            } else {
                return packAsDouble(Double(val))
            }
        case let val as Int64:
            if val >= Int64(Int32.min) && val <= Int64(Int32.max) {
                return packAsInt32(Int32(val))
            } else if self.isInt64Compatible {
                return packAsInt64(val)
            } else {
                return packAsDouble(Double(val)) // caution: may be some loss of precision
            }
        case let val as UInt64:
            if val <= UInt64(Int32.max) {
                return packAsInt32(Int32(val))
            } else if self.isInt64Compatible {
                return packAsUInt64(val)
            } else {
                return packAsDouble(Double(val)) // caution: may be some loss of precision
            }
        case let val as Float:
            return packAsDouble(Double(val))
        case let val as Error:
            throw val // if value is ErrorType, rethrow it as-is; e.g. see ObjectSpecifier.unpackParentSpecifiers(), which needs to report [rare] errors but can't throw itself; this should allow APIs that can't raise errors directly (e.g. specifier constructors) to have those errors raised if/when used in commands (which can throw)
        default:
            ()
        }
        throw PackError(object: value)
    }
    
    /******************************************************************************/
    // Convert an Apple event descriptor to the specified Swift type, coercing it as necessary
    
    open func unpack<T>(_ desc: Descriptor) throws -> T {
        if T.self == Any.self || T.self == AnyObject.self {
            return try self.unpackAsAny(desc) as! T // this takes ownership
        } else if let type = T.self as? SelfUnpacking.Type { // note: AppleEventDescriptor, Symbol, MissingValueType, Array<>, Dictionary<>, Set<>, and Optional<> types unpack the descriptor themselves, as do any custom structs and enums defined in glues
            return try type.SwiftAutomation_unpackSelf(desc, appData: self) as! T
        } else if isMissingValue(desc) {
            throw UnpackError(appData: self, desc: desc, type: T.self, message: "Can't coerce 'missing value' descriptor to \(T.self).") // this takes ownership // Important: AppData must not unpack a 'missing value' constant as anything except `MissingValue` or `nil` (i.e. the types to which it self-unpacks). AppleScript doesn't have this problem as all descriptors unpack to their own preferred type, but unpack<T>() forces a descriptor to unpack as a specific type or fail trying. While its role is to act as a `nil`-style placeholder when no other value is given, its descriptor type is typeType so left to its own devices it would naturally unpack the same as any other typeType descriptor. e.g. One of AEM's vagaries is that it supports typeType to typeUnicodeText coercions, so while permitting cDocument to coerce to "docu" might be acceptable [if not exactly helpful], allowing cMissingValue to coerce to "msng" would defeat its whole purpose.
        }
        switch T.self {
        case is Query.Type: // note: user typically specifies exact class ([PREFIX][Object|Elements]Specifier)
            if let result = try self.unpackAsAny(desc) as? T { // specifiers can be composed of several AE types, so unpack first then check its actual type is what user requested
                return result
            }
        case is Symbol.Type where symbolDescriptorTypes.contains(desc.type): // TO DO: why isn't Symbol SelfUnpacking?
            return try self.unpackAsSymbol(desc) as! T
        case is AnyHashable.Type: // while records always unpack as [Symbol:TYPE], [AnyHashable:TYPE] is a valid return type too
            if let result = try self.unpackAsAny(desc) as? AnyHashable { return result as! T }
        case is Descriptor.Type: // for internal use (e.g. getAETE())
            return desc as! T
        case is Bool.Type:
            return try unpackAsBool(desc) as! T
        case is Int.Type: // TO DO: this assumes Int will _always_ be 64-bit (on macOS); is that safe?
            return try unpackAsInt(desc) as! T
        case is UInt.Type:
            return try unpackAsUInt(desc) as! T
        case is Double.Type:
            return try unpackAsDouble(desc) as! T
        case is String.Type:
            return try unpackAsString(desc) as! T
        case is Date.Type:
            return try unpackAsDate(desc) as! T
        case is URL.Type:
            return try unpackAsFileURL(desc) as! T
        case is Int8.Type:
            if let result = Int8(exactly: try unpackAsInt(desc)) { return result as! T }
        case is Int16.Type:
            return try unpackAsInt16(desc) as! T
        case is Int32.Type:
            return try unpackAsInt32(desc) as! T
        case is Int64.Type:
            return try unpackAsInt64(desc) as! T
        case is UInt8.Type:
            if let result = UInt8(exactly: try unpackAsUInt(desc)) { return result as! T }
        case is UInt16.Type:
            return try unpackAsUInt16(desc) as! T
        case is UInt32.Type:
            return try unpackAsUInt32(desc) as! T
        case is UInt64.Type:
            return try unpackAsUInt64(desc) as! T
        case is Float.Type:
            return try unpackAsDouble(desc) as! T
        default:
            ()
        }
        // desc couldn't be coerced to the specified type
        let symbol = self.glueClasses.symbolType.symbol(code: desc.type)
        let typeName = symbol.name ?? literalFourCharCode(symbol.code)
        throw UnpackError(appData: self, desc: desc, type: T.self, message: "Can't coerce \(typeName) descriptor to \(T.self).")
    }
    
    
    /******************************************************************************/
    // Convert an Apple event descriptor to its preferred Swift type, as determined by its descriptorType
    
    open func unpackAsAny(_ desc: AppleEvents.Descriptor) throws -> Any { // note: this never returns Optionals (i.e. cMissingValue AEDescs always unpack as MissingValue when return type is Any) to avoid dropping user into Optional<T>.some(Optional<U>.none) hell.
        switch desc.type {
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
        case typeAEList:
            return try Array.SwiftAutomation_unpackSelf(desc, appData: self) as [Any]
        // common AE types // TO DO: most of these can be unpacked by unpackAsAny
        case typeType, typeEnumerated, typeProperty, typeKeyword:
            if isMissingValue(desc) {
                return MissingValue
            } else {
                return try self.unpackAsSymbol(desc)
            }
        case typeNull: // null descriptor indicates object specifier root
            return self.application
        case typeCurrentContainer:
            return self.con
        case typeObjectBeingExamined:
            return self.its
        // TO DO: what about unpacking
        default:
            // TO DO: see TODOs in AppleEvents
            //if desc.isRecord {
            //    return try Dictionary.SwiftAutomation_unpackSelf(desc, appData: self) as [Symbol:Any]
            //}
            return try AppleEvents.unpackAsAny(desc)
        }
    }
    
    /******************************************************************************/
    // Supporting methods for unpacking symbols and specifiers
    
    
    func recordKey(forCode code: OSType) -> Symbol { // used by Dictionary extension to unpack AERecord's OSType-based keys as glue-defined Symbols
        return self.glueClasses.symbolType.symbol(code: code, type: typeProperty, descriptor: nil)
    }
    
    func unpackAsSymbol(_ desc: Descriptor) throws -> Symbol {
        guard let descriptor = desc as? ScalarDescriptor, let code = try? unpackAsFourCharCode(desc) else {
            throw AppleEventError.unsupportedCoercion
        }
        return self.glueClasses.symbolType.symbol(code: code, type: descriptor.type, descriptor: descriptor)
    }
    
    func unpackAsInsertionLoc(_ desc: Descriptor) throws -> Specifier {
        guard let descriptor = desc as? InsertionLocationDescriptor else {
            throw UnpackError(appData: self, desc: desc, type: self.glueClasses.insertionSpecifierType,
                              message: "Can't unpack malformed insertion specifier.")
        }
        return self.glueClasses.insertionSpecifierType.init(position: descriptor.position,
                                                            parentQuery: nil, appData: self, descriptor: descriptor)
    }
    
    func unpackAsObjectSpecifier(_ desc: Descriptor) throws -> Specifier {
        guard let descriptor = desc as? ObjectSpecifierDescriptor else {
            throw UnpackError(appData: self, desc: desc, type: self.glueClasses.objectSpecifierType,
                              message: "Can't unpack malformed object specifier.")
        }
        let (wantType, parentDesc, selectorForm, selectorDesc) = (descriptor.want, descriptor.from, descriptor.form, descriptor.seld)
        do { // unpack selectorData, unless it's a property code or absolute/relative ordinal (in which case use its 'prop'/'enum' descriptor as-is)
            var selectorData: Any // the selector won't be unpacked if it's a property/relative/absolute ordinal
            var objectSpecifierClass = self.glueClasses.objectSpecifierType // reference forms returned by apps usually describe one-to-one relationships
            switch selectorForm {
            case .property:
                if ![typeType, typeProperty].contains(selectorDesc.type) {
                    throw UnpackError(appData: self, desc: desc, type: self.glueClasses.objectSpecifierType,
                                      message: "Can't unpack malformed object specifier.")
                }
                selectorData = selectorDesc
            case .absolutePosition:
                if let ordinal = try? unpackAsAbsoluteOrdinal(selectorDesc) { // first/middle/last/any/all
                    if ordinal == OSType(kAEAll) { // `all` ordinal = one-to-many relationship
                        objectSpecifierClass = self.glueClasses.multiObjectSpecifierType
                    }
                    selectorData = selectorDesc
                } else { // unpack index (normally Int32, though the by-index form can take any type of selector as long as the app understands it)
                    selectorData = try self.unpack(selectorDesc)
                }
            case .name, .uniqueID:
                selectorData = try self.unpack(selectorDesc)
            case .relativePosition: // before/after
                guard let _ = try? unpackAsRelativeOrdinal(selectorDesc) else {
                    throw UnpackError(appData: self, desc: desc, type: self.glueClasses.objectSpecifierType,
                                      message: "Can't unpack malformed object specifier.")
                }
                selectorData = selectorDesc
            case .range: // by-range = one-to-many relationship
                objectSpecifierClass = self.glueClasses.multiObjectSpecifierType
                guard selectorDesc.type == typeRangeDescriptor,
                    let rangeDesc = selectorDesc as? ObjectSpecifierDescriptor.RangeDescriptor else {
                        throw UnpackError(appData: self, desc: desc, type: RangeSelector.self,
                                          message: "Malformed selector in by-range specifier.")
                }
                do {
                    selectorData = RangeSelector(start:  try self.unpackAsAny(rangeDesc.start), stop: try self.unpackAsAny(rangeDesc.stop), wantType: wantType)
                } catch {
                    throw UnpackError(appData: self, desc: desc, type: RangeSelector.self,
                                      message: "Couldn't unpack start/stop selector in by-range specifier.")
                }
            case .test: // by-range = one-to-many relationship
                objectSpecifierClass = self.glueClasses.multiObjectSpecifierType
                selectorData = try self.unpack(selectorDesc)
                if !(selectorData is Query) {
                    throw UnpackError(appData: self, desc: desc, type: Query.self,
                                      message: "Malformed selector in by-test specifier.")
                }
            case .userProperty:
                selectorData = try self.unpack(selectorDesc)
                if !(selectorData is String) {
                    throw UnpackError(appData: self, desc: desc, type: Query.self,
                                      message: "Malformed selector in by-user-property specifier.")
                }
            }
            return objectSpecifierClass.init(wantType: wantType,
                                             selectorForm: selectorForm, selectorData: selectorData,
                                             parentQuery: (fullyUnpackSpecifiers ? try self.unpack(parentDesc) as Query : nil),
                                             appData: self, descriptor: (fullyUnpackSpecifiers ? nil : desc))
        } catch {
            throw UnpackError(appData: self, desc: desc, type: self.glueClasses.objectSpecifierType,
                              message: "Can't unpack object specifier's selector data.", cause: error)
        }
    }
    
    func unpackAsComparisonDescriptor(_ desc: Descriptor) throws -> TestClause {
        guard let comparisonDesc = desc as? AppleEvents.ComparisonDescriptor else {
            throw UnpackError(appData: self, desc: desc, type: TestClause.self,
                              message: "Can't unpack comparison test: malformed descriptor.")
        }
        return ComparisonTest(operatorType: comparisonDesc.comparison,
                              operand1: try self.unpack(comparisonDesc.object),
                              operand2: try self.unpack(comparisonDesc.value),
                              appData: self, descriptor: desc)
    }
    
    func unpackAsLogicalDescriptor(_ desc: Descriptor) throws -> TestClause {
        guard let logicalDesc = desc as? AppleEvents.LogicalDescriptor else {
            throw UnpackError(appData: self, desc: desc, type: TestClause.self,
                              message: "Can't unpack logical test: malformed descriptor.")
        }
        return LogicalTest(operatorType: logicalDesc.logical,
                           operands: try self.unpack(logicalDesc.operands),
                           appData: self, descriptor: desc)
    }
    
    
    /******************************************************************************/
    // get AEAddressDesc for target application
    
    public func targetDescriptor() throws -> AddressDescriptor? {
        if self._targetDescriptor == nil { self._targetDescriptor = try self.target.descriptor(self.launchOptions) }
        return self._targetDescriptor
    }
    
    public func permissionToAutomate(event: EventIdentifier, askUserIfNeeded: Bool = true) -> Int { // in theory, eventClass or eventID could be a wildcard, but we're really only interested in the events we send, which are EventIdentifiers
        #if canImport(AppKit)
        if #available(OSX 10.14, *) {
            // TO DO: convert AddressDescriptor to AEAddressDesc
            //guard var desc = self._targetDescriptor else { return procNotFound }
            return 0 // return Int(AEDeterminePermissionToAutomateTarget(&desc, eventClass, eventID, askUserIfNeeded))
        } else {
            return 0
        }
        #else
        return 0
        #endif
    }
    
    /******************************************************************************/
    // send an Apple event
    
    let defaultConsiderations = packConsideringAndIgnoringFlags([.case])
    
    let nullReplyEvent = AppleEvents.ReplyEventDescriptor(code:0) // TO DO: this is not ideal; it'd be safer to return something completely immutable
    
    // if target process is no longer running, Apple Event Manager will return an error when an event is sent to it
    let relaunchableErrors: Set<Int> = [-600, -609]
    // if relaunchMode = .limited, only 'launch' and 'run' are allowed to restart a local application that's been quit
    let relaunchableEvents: Set<EventIdentifier> = [eventOpenApplication, miscEventLaunch]
    
    
    private func send(event: AppleEventDescriptor, sendMode: SendOptions, timeout: TimeInterval) throws -> ReplyEventDescriptor { // used by sendAppleEvent()
        let (errorCode, replyEvent) = event.send() //sendEvent(options: sendMode, timeout: timeout)) // TO DO
        if errorCode == 0 {
            return replyEvent ?? nullReplyEvent
        } else if errorCode == -1708 && event.code == miscEventLaunch {
            // TO DO: this is wrong; -1708 will be in reply event, not in AEM error; TO DO: check this
            // 'launch' events normally return 'not handled' errors, so just ignore those
            return self.nullReplyEvent // (not a full AppleEvent desc, but reply event's attributes aren't used so is equivalent to a reply event containing neither error nor result)
        } else {
            throw AutomationError(code: errorCode)
        }
    }
    
    
    public func sendAppleEvent<T>(name: String?, event eventIdentifier: EventIdentifier,
                                  parentSpecifier: Specifier, // the Specifier on which the command method was called; see special-case packing logic below
                                  directParameter: Any = noParameter, // the first (unnamed) parameter to the command method; see special-case packing logic below
                                  keywordParameters: [KeywordParameter] = [], // the remaining named parameters
                                  requestedType: Symbol? = nil, // event's `as` parameter, if any (note: while a `keyAERequestedType` parameter can be supplied via `keywordParameters:`, it will be ignored if `requestedType:` is given)
                                  waitReply: Bool = true, // wait for application to respond before returning?
                                  sendOptions: SendOptions? = nil, // raw send options (these are rarely needed); if given, `waitReply:` is ignored
                                  withTimeout: TimeInterval? = nil, // no. of seconds to wait before raising timeout error (-1712); may also be default/never
                                  considering: ConsideringOptions? = nil) throws -> T { // coerce and unpack result as this type or return raw reply event if T is NSDescriptor; default is Any
        // note: human-readable command and parameter names are only used (if known) in error messages
        // note: all errors occurring within this method are caught and rethrown as CommandError, allowing error message to provide a description of the failed command as well as the error itself
        var sentEvent: AppleEventDescriptor?, repliedEvent: ReplyEventDescriptor?
        do {
            // Create a new AppleEvent descriptor (throws ConnectionError if target app isn't found)
            var event = AppleEventDescriptor(code: eventIdentifier, target: try self.targetDescriptor())
            // pack its keyword parameters
            for (paramName, code, value) in keywordParameters where isParameter(value) {
                do {
                    event.setParameter(code, to: try self.pack(value))
                } catch {
                    throw AutomationError(code: error._code, message: "Invalid \(paramName ?? literalFourCharCode(code)) parameter.", cause: error)
                }
            }
            // pack event's direct parameter and/or subject attribute
            let hasDirectParameter = isParameter(directParameter)
            if hasDirectParameter { // if the command includes a direct parameter, pack that normally as its direct param
                event.setParameter(keyDirectObject, to: try self.pack(directParameter))
            }
            // if command method was called on root Application (null) object, the event's subject is also null...
            var subjectDesc: QueryDescriptor = appRootDesc
            // ... but if the command was called on a Specifier, decide if that specifier should be packed as event's subject
            // or, as a special case, used as event's keyDirectObject/keyAEInsertHere parameter for user's convenience
            if !(parentSpecifier is RootSpecifier) { // technically Application, but there isn't an explicit class for that
                if eventIdentifier == coreEventCreateElement { // for user's convenience, `make` command is treated as a special case
                    // if `make` command is called on a specifier, use that specifier as event's `at` parameter if not already given
                    if event.parameter(keyAEInsertHere) != nil { // an `at` parameter was already given, so pack parent specifier as event's subject attribute
                        let desc = try self.pack(parentSpecifier)
                        subjectDesc = (desc as? QueryDescriptor) ?? RootSpecifierDescriptor(desc)
                    } else { // else pack parent specifier as event's `at` parameter and use null as event's subject attribute
                        event.setParameter(keyAEInsertHere, to: try self.pack(parentSpecifier))
                    }
                } else { // for all other commands, check if a direct parameter was already given
                    if hasDirectParameter { // pack the parent specifier as the event's subject attribute
                        let desc = try self.pack(parentSpecifier)
                        subjectDesc = (desc as? QueryDescriptor) ?? RootSpecifierDescriptor(desc)
                    } else { // else pack parent specifier as event's direct parameter and use null as event's subject attribute
                        event.setParameter(keyDirectObject, to: try self.pack(parentSpecifier))
                    }
                }
            }
            event.setAttribute(AEKeyword(keySubjectAttr), to: subjectDesc)
            // pack requested type (`as`) parameter, if specified; note: most apps ignore this, but a few may recognize it (usually in `get` commands)  even if they don't define it in their dictionary (another AppleScript-introduced quirk); e.g. `Finder().home.get(requestedType:FIN.alias) as URL` tells Finder to return a typeAlias descriptor instead of typeObjectSpecifier, which can then be unpacked as URL
            if let type = requestedType {
                event.setParameter(keyAERequestedType, to: type.descriptor)
            }
            // event attributes
            // (note: most apps ignore considering/ignoring attributes, and always ignore case and consider everything else)
            let (considerations, consideringIgnoring) = considering == nil ? self.defaultConsiderations
                                                                           : packConsideringAndIgnoringFlags(considering!)
            event.setAttribute(OSType(enumConsiderations), to: considerations)
            event.setAttribute(OSType(enumConsidsAndIgnores), to: consideringIgnoring)
            // send the event
            let sendMode = sendOptions ?? [.canInteract, waitReply ? .waitForReply : .noReply]
            let timeout = withTimeout ?? defaultTimeout
            var replyEvent = nullReplyEvent
            sentEvent = event // the completed event, for use in error messages
            do {
                replyEvent = try self.send(event: event, sendMode: sendMode, timeout: timeout) // throws on AEM error
            } catch { // handle errors raised by Apple Event Manager (e.g. timeout, process not found)
                if relaunchableErrors.contains(error._code) && self.target.isRelaunchable &&
                    (self.relaunchMode == .always || (self.relaunchMode == .limited && relaunchableEvents.contains(eventIdentifier))) {
                    // event failed as target process has quit since previous event; recreate AppleEvent with new address and resend
                    self._targetDescriptor = nil
                    guard let target = try self.targetDescriptor() else { throw error }
                    event.target = target
                    replyEvent = try self.send(event: event, sendMode: sendMode, timeout: timeout)
                } else {
                    throw error
                }
            }
            repliedEvent = replyEvent // the received event, for use in error messages
            if sendMode.contains(.waitForReply) {
                if T.self == ReplyEventDescriptor.self { // return the entire reply event as-is
                    return replyEvent as! T
                } else if replyEvent.errorNumber != 0 { // check if an application error occurred
                    throw AutomationError(code: replyEvent.errorNumber)
                } else if let resultDesc = replyEvent.parameter(keyDirectObject) {
                    return try self.unpack(resultDesc) as T
                } // no return value or error, so fall through
            } else if sendMode.contains(.queueReply) { // get the return ID that will be used by the reply event so that client code's main loop can identify that reply event in its own event queue later on
                guard let returnIDDesc = event.attribute(keyReturnIDAttr) else { // sanity check // TO DO: FIX
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
            let commandDescription = CommandDescription(name: name, event: eventIdentifier,
                                                        parentSpecifier: parentSpecifier,
                                                        directParameter: directParameter,
                                                        keywordParameters: keywordParameters,
                                                        requestedType: requestedType, waitReply: waitReply,
                                                        withTimeout: withTimeout, considering: considering)
            throw CommandError(commandInfo: commandDescription, appData: self, event: sentEvent, reply: repliedEvent, cause: error)
        }
    }
    
    
    // convenience shortcut for dispatching events using raw OSType codes only (the above method also requires human-readable command and parameter names to be supplied for error reporting purposes); users should call this via one of the `sendAppleEvent` methods on `AEApplication`/`AEItem`
    
    public func sendAppleEvent<T>(event: EventIdentifier, parentSpecifier: Specifier, parameters: [OSType:Any] = [:],
                                  requestedType: Symbol? = nil, waitReply: Bool = true, sendOptions: SendOptions? = nil,
                                  withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        var parameters = parameters
        let directParameter = parameters.removeValue(forKey: keyDirectObject) ?? noParameter
        let keywordParameters: [KeywordParameter] = parameters.map({(name: nil, code: $0, value: $1)})
        return try self.sendAppleEvent(name: nil, event: event, parentSpecifier: parentSpecifier,
                                       directParameter: directParameter, keywordParameters: keywordParameters,
                                       requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                                       withTimeout: withTimeout, considering: considering)
    }
    
    
    /******************************************************************************/
    // transaction support (in practice, there are few, if any, currently available apps that support transactions, but it's included for completeness)
    
    // TO DO: this uses `AEApp` in sendAppleEvent calls, which couples it to AE glue
    
    /*
    public func doTransaction<T>(session: Any? = nil, closure: () throws -> (T)) throws -> T {
        var mutex = pthread_mutex_t()
        pthread_mutex_init(&mutex, nil)
        pthread_mutex_lock(&mutex)
        defer {
            pthread_mutex_unlock(&mutex)
            pthread_mutex_destroy(&mutex)
        }
        assert(self._transactionID == AETransactionID(kAnyTransactionID), "Transaction \(self._transactionID) already active.")
        self._transactionID = try self.sendAppleEvent(name: nil, event: miscEventBeginTransaction,
                                                      parentSpecifier: AEApp, directParameter: session as Any) as AETransactionID
        defer {
            self._transactionID = AETransactionID(kAnyTransactionID)
        }
        var result: T
        do {
            result = try closure()
        } catch { // abort transaction, then rethrow closure error
            let _ = try? self.sendAppleEvent(name: nil, event: miscEventTransactionTerminated,
                                             parentSpecifier: AEApp) as Any
            throw error
        } // else end transaction
        let _ = try self.sendAppleEvent(name: nil, event: miscEventEndTransaction,
                                        parentSpecifier: AEApp) as Any
        return result
    }
     */
}


/******************************************************************************/
// used by AppData.sendAppleEvent() to pack ConsideringOptions as enumConsiderations (old-style) and enumConsidsAndIgnores (new-style) attributes


let considerationsTable: [(Considerations, Descriptor, UInt32, UInt32)] = [ // also used in AE formatter
    // Swift mistypes considering/ignoring mask constants as Int, not UInt32, so redefine them here
    (.case,             packAsEnum(OSType(kAECase)),              0x00000001, 0x00010000),
    (.diacritic,        packAsEnum(OSType(kAEDiacritic)),         0x00000002, 0x00020000),
    (.whiteSpace,       packAsEnum(OSType(kAEWhiteSpace)),        0x00000004, 0x00040000),
    (.hyphens,          packAsEnum(OSType(kAEHyphens)),           0x00000008, 0x00080000),
    (.expansion,        packAsEnum(OSType(kAEExpansion)),         0x00000010, 0x00100000),
    (.punctuation,      packAsEnum(OSType(kAEPunctuation)),       0x00000020, 0x00200000),
    (.numericStrings,   packAsEnum(OSType(kASNumericStrings)),    0x00000080, 0x00800000),
]

// TO DO: review this code; is considering attr misnamed?

private func packConsideringAndIgnoringFlags(_ considerations: ConsideringOptions) -> (Descriptor, Descriptor) {
    var considerationsList = [Descriptor]()
    var consideringIgnoringFlags: UInt32 = 0
    for (consideration, considerationDesc, consideringMask, ignoringMask) in considerationsTable {
        if considerations.contains(consideration) {
            consideringIgnoringFlags |= consideringMask
            considerationsList.append(considerationDesc)
        } else {
            consideringIgnoringFlags |= ignoringMask
        }
    }
    return (packAsArray(considerationsList, using: packAsDescriptor), // old-style flags (list of enums)
            packAsUInt32(consideringIgnoringFlags)) // new-style flags (bitmask)
}





// TO DO: following struct was created for use in AppleEventFormatter, but is also being used in CommandError to capture name and arguments outgoing command for use in error descriptions

public struct CommandDescription {
    
    // note: even when terminology data is available, there's still no guarantee that a command won't have to use raw codes instead (typically due to dodgy terminology; while AS allows mixing of keyword and raw chevron syntax in the same command, it's such a rare defect it's best to stick solely to one or the other)
    public enum Signature {
        case named(name: String, directParameter: Any, keywordParameters: [(String, Any)], requestedType: Symbol?)
        case codes(event: EventIdentifier, parameters: [OSType:Any])
    }
    
    // name and parameters
    public let signature: Signature // either keywords or four-char codes
    
    // attributes (note that waitReply and withTimeout values are unreliable when extracted from an existing AppleEvent)
    public private(set) var subject: Any? = nil // TO DO: subject or parentSpecifier? (and what, if any, difference does it make?)
    public private(set) var waitReply: Bool = true // note that existing AppleEvent descriptors contain keyReplyRequestedAttr, which could be either SendOptions.waitForReply or .queueReply
    // TO DO: also include sendOptions for completeness
    public private(set) var withTimeout: TimeInterval = defaultTimeout
    public private(set) var considering: ConsideringOptions = [.case]
    
    
    // called by sendAppleEvent with a failed command's details
    public init(name: String?, event: EventIdentifier, parentSpecifier: Any?,
                directParameter: Any, keywordParameters: [KeywordParameter],
                requestedType: Symbol?, waitReply: Bool, withTimeout: TimeInterval?, considering: ConsideringOptions?) {
        if let commandName = name {
            self.signature = .named(name: commandName, directParameter: directParameter,
                                    keywordParameters: keywordParameters.map { ($0!, $2) }, requestedType: requestedType)
        } else {
            var parameters = [UInt32:Any]() // TO DO: keys are OSType, but swiftc gets confused and claims its isn't hashable
            if isParameter(directParameter) { parameters[keyDirectObject] = directParameter }
            for (_, code, value) in keywordParameters where isParameter(value) { parameters[code] = value }
            if let symbol = requestedType { parameters[keyAERequestedType] = symbol }
            self.signature = .codes(event: event, parameters: parameters)
        }
        self.waitReply = waitReply
        self.subject = parentSpecifier
        if withTimeout != nil { self.withTimeout = withTimeout! }
        if considering != nil { self.considering = considering! }
    }

}
