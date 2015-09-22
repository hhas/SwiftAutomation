//
//  AppData.swift
//  SwiftAE
//
//  Swift-AE type conversion and Apple event dispatch
//

import Foundation
import AppKit



// TO DO: fix packing of Arrays and Dictionarys; currently pack() casts to NSArray/NSDictionary, but this fails when object's dynamicType is (e.g.) [Any] (only [AnyObject] is allowed), and screws up type information on Bool, Int, Double values (since Swift's NSNumber bridging is dreadful)


// TO DO: explicit 'as' parameter? (suspect it can't always be inferred from return type, plus it should prob. only be passed when user explicitly states it); note that while some apps may explicitly define `as` param for `get` command, it's something AS will add regardless (TODO: need to check this is true), so it might make more sense to make it a fixed param in glue (so that it appears on _all_ commands) and ignore it in commandInfo (so that it doesn't appear more than once)


// TO DO: split into untargeted and targeted classes? or is current arrangement good enough? (mostly it's about returning appropriate app root in unpack)


// TO DO: how to allow mixed Symbol/String keys in Dictionarys? (simplest would be for Symbol to represent both, e.g. with [Code]Symbol and UserSymbol subclasses, although that's not entirely elegant)


// TO DO: arrays and dicts aren't unpacking properly when asType: is given; need to figure out how swift prioritizes generic vs non-generic overloads


// TO DO: when unpacking specifiers, may want to use Application instance, not generic AppRoot, as their app root (while ObjSpec, etc. instances contain AppData, AppRoot does not, so won't display itself as Application and can't be extracted and used as-is); this will require Application to pass itself as weak-ref to AppData's init


// TO DO: what about an option to unpack AERecords as glue-defined structs? (this would be fragile, since dictionary-defined class info isn't accurate, but even if it only works half the time it might be useful enough to justify having it as an option on glue generator)

// TO DO: implement NullAppBridge (for use in generic specifiers) that throws errors if sendEvent (or pack/unpack) is called? (alternatively, could add a TargetApplication.None option to throw upon)

// TO DO: how to support sum types? (suspect this will require better type introspection support in Swift); for now, client code will have to use `Any` and switch on type itself - one possibility would be to define a standard enum that's a sum of all supported types, then use type info to determine which of those cases are allowed when unpacking (that does, however, create a problem where T arg != T result, since enums don't support generics; it would have to be done using a class, but that creates question of how to do varargs); another possibility might be to have an explicit arg that takes set of accepted types, ensuring result's type is always one of those, then return Any; Q. could a user-defined enum that adheres to a framework defined protocol do it? (again, we'd still need to introspect, unless it calls unpack<T> itself - although that prob. wouldn't help since we don't want to coerce unless we have to, otherwise typeType descs could end up as Strings)

// TO DO: option for caller to pass their own 'customUnpack' func via command, to be called when standard unpack fails (either due to unrecognized AE type or inability to coerce to specified Swift type)


public typealias KeywordParameters = [(name: String?, code: OSType, value: Any)]

public typealias RootObjects = (app: RootSpecifier, con: RootSpecifier, its: RootSpecifier)


public struct GlueInfo { // Glue-defined specifier, symbol, and formatter classes; used in (e.g.) AppData.unpack()
    let insertionSpecifierType: InsertionSpecifier.Type
    let objectSpecifierType: ObjectSpecifier.Type
    let elementsSpecifierType: ObjectSpecifier.Type
    let rootSpecifierType: RootSpecifier.Type
    let symbolType: Symbol.Type
    let formatter: SpecifierFormatter
}


/******************************************************************************/


public class AppData {
    
    // note: SpecifierFormatter can use the following when rendering app roots
    public let target: TargetApplication
    public let launchOptions: LaunchOptions
    public let relaunchMode: RelaunchMode
    
    private var _targetDescriptor: NSAppleEventDescriptor? = nil // targetDescriptor() creates an AEAddressDesc for the target process when dispatching first Apple event, caching it here for subsequent reuse; do not access directly
    
    public let glueInfo: GlueInfo // glue-defined specifier and symbol classes, and standard root objects
    
    public var formatter: SpecifierFormatter { return self.glueInfo.formatter }
    
    public private(set) var rootObjects: RootObjects! // note: this will be set by main initializer, but needs to be [implicitly] optional var otherwise compiler will complain about self being used before it's fully initialized
    
    public required init(target: TargetApplication,
                         launchOptions: LaunchOptions, relaunchMode: RelaunchMode, glueInfo: GlueInfo, rootObjects: RootObjects?) { // should be private, but targetedCopy requires it to be required, which in turn requires it to be public
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
                                     elementsSpecifierType: ObjectSpecifier.self, rootSpecifierType: RootSpecifier.self,
                                     symbolType: Symbol.self, formatter: SpecifierFormatter()))
    }
    
    // create a new untargeted AppData instance for a glue file's private gUntargetedAppData constant (note: this will leak memory each time it's used so users should not call it themselves; instead, use AEApplication.untargetedAppData to return an already-created instance suitable for general programming tasks)
    public convenience init(glueInfo: GlueInfo) {
        self.init(target: .None, launchOptions: DefaultLaunchOptions, relaunchMode: .Never, glueInfo: glueInfo, rootObjects: nil)
    }
    
    // create a targeted copy of a [typically untargeted] AppData instance; Application inits should always use this to create targeted AppData instances
    public func targetedCopy(target: TargetApplication, launchOptions: LaunchOptions, relaunchMode: RelaunchMode) -> Self {
        return self.dynamicType.init(target: target, launchOptions: launchOptions, relaunchMode: relaunchMode,
                                                        glueInfo: self.glueInfo, rootObjects: self.rootObjects)
    }
    
    
    /******************************************************************************/
    // Convert a Swift value to an Apple event descriptor
    
    let MissingValueDesc = NSAppleEventDescriptor(typeCode: cMissingValue)
    
    // TO DO: using AnyObject causes Bool to become NSNumber, losing correct type
    
    // TO DO: what if object is nil?
    
    public func pack(value: Any) throws -> NSAppleEventDescriptor { // TO DO: optional allowedRoots:Set<RootSpecifier> arg? (that wouldn't really help, since cachedDescs would need to be pulled apart to check); also, should packing specifiers with fully qualified root be an option? (inclined to say no, since only Automator uses those, and Automator is moribund junk; plus, again, cachedDescs would need to be pulled apart and rebuilt)
//        print("PACKING: \(object) \(object.dynamicType)")
        switch value {
        // what to use for date, file? NSDate, NSURL/SwiftAEURL?
        // what to use for typeNull? (don't want to use nil; NSNull?) Q. is there any use case where passing AEApp (which always packs itself as typeNull and should always be included in SwiftAE) wouldn't be sufficient?
        // what about cMissingValue? (currently Symbol) (TBH, deciding optimal representation for 'missing value' is a somewhat intractable problem since app commands that return Any? will be much more annoying than if they return Any - which is already annoying enough)
        case let obj as NSAppleEventDescriptor:
            return obj
        case let val as SelfPacking:
            return try val.packSelf(self)
        case let val as Bool: // TO DO: this is not reliable; ObjC bridge tends to convert Bools, Ints, Doubles to NSNumbers, requiring specific tests; see AppleEventBridge implementation for details
            return NSAppleEventDescriptor(boolean: val)
        case let val as Int: // TO DO: Int8, etc (e.g. convert toIntMax)
            if Int(Int32.min) <= val && val <= Int(Int32.max) {
                return NSAppleEventDescriptor(int32: Int32(val))
            } else {
                return NSAppleEventDescriptor(double: Double(val)) // TO DO: 64-bit compatibility option
            }
        case let val as Double:
            return NSAppleEventDescriptor(double: val)
        case let val as String:
            return NSAppleEventDescriptor(string: val)
        case let obj as NSDate:
          return NSAppleEventDescriptor(date: obj)
        case let obj as NSURL:
          return NSAppleEventDescriptor(fileURL: obj)
        case let obj as NSArray: // HACK; TO DO: 'let obj as [Any]' doesn't work (Swift refuses to cast from Any to [Any] for some reason); note: casting to NSArray/NSDictionary will screw up Bool/Int/Double representations (which get bridged to NSNumber), and will fail to match if object's dynamic type is `[Any]` (since non-objects can't cross Swift-ObjC bridge), so this isn't a permanent solution
            let desc = NSAppleEventDescriptor.listDescriptor()
            for item in obj { desc.insertDescriptor(try self.pack(item), atIndex: 0) }
            return desc
        case let obj as NSDictionary: // HACK; TO DO: `let obj as [Symbol:Any]` doesn't won't work either
            let desc = NSAppleEventDescriptor.recordDescriptor()
            for (key, value) in obj {
                if let keySymbol = key as? Symbol {
                    desc.setDescriptor(try self.pack(value), forKeyword: keySymbol.code)
                } else {
                    throw NotImplementedError() // for now, only Symbol keys are supported (still to decide how string keys should be dealt with)
                }
            }
            return desc
        default: // TO DO: if value is ErrorType, either rethrow it as-is, or poss. chain it to PackError; e.g. see ObjectSpecifier.unpackParentSpecifiers(), which needs to report [rare] errors but can't throw itself; this should allow APIs that can't raise errors directly (e.g. specifier constructors) to have those errors raised if/when used in commands (which can throw)
            throw PackError(object: value)
        }
    }
    
    /******************************************************************************/
    // Supporting methods for unpacking symbols and specifiers

    func unpackSymbol(desc: NSAppleEventDescriptor) -> Symbol {
        return self.glueInfo.symbolType.symbol(desc.typeCodeValue, type: desc.descriptorType, descriptor: desc)
    }
    
    func unpackAEProperty(code: OSType) -> Symbol { // used to unpack AERecord keys as Dictionary keys
        return self.glueInfo.symbolType.symbol(code, type: typeProperty, descriptor: nil) // TO DO: use typeType? (TBH, am tempted to use it throughout, leaving AEM to coerce as necessary, as it'd simplify implementation a bit; also, note that type and property names can often overlap, e.g. `TED.document` may be either)
    }
    
    var appRoot: RootSpecifier { return self.rootObjects.app } // TO DO: use original Application instance? when unpacking an objspec chain, it would be best if targeted AppData unpacks its main root as Application, and any nested objspecs' roots as App. Main problem is that storing Application instance inside AppData would create cyclic reference, with no obvious way to weakref it. Alternatively, since chain is lazily unpacked, it'd be possible for unpackParentSpecifiers() to instantiate a new Application object at the time (this would mean changing the way that unpackParentSpecifiers works). For now, might be simplest just to instantiate a new Application instance here each time - although that's not ideal for unpacking sub-specifiers (but they might be better unpacked using untargetedAppData); poss. just add an optional arg to unpack() that allows callers to specify which root to use, but picking the right AppData class with which to unpack a nested desc would be cleaner)
    
    func unpackInsertionLoc(desc: NSAppleEventDescriptor) throws -> Specifier {
        guard let _ = desc.descriptorForKeyword(keyAEObject), // only used to check InsertionLoc record is correctly formed // TO DO: in unlikely event of receiving a malformed record, would be simpler for unpackParentSpecifiers to use a RootSpecifier that throws error on use, avoiding need for extra check here
                insertionLocation = desc.descriptorForKeyword(keyAEPosition) else {
            throw UnpackError(appData: self, descriptor: desc, type: self.glueInfo.insertionSpecifierType,
                                message: "Can't unpack malformed insertion specifier.")
        }
        return self.glueInfo.insertionSpecifierType.init(insertionLocation: insertionLocation, parentSelector: nil, appData: self, cachedDesc: desc)
    }
    
    func unpackObjectSpecifier(desc: NSAppleEventDescriptor) throws -> Specifier {
        guard let _ = desc.descriptorForKeyword(keyAEContainer), // container desc is only used in unpackParentSpecifiers, but confirm its existence
                wantType = desc.descriptorForKeyword(keyAEDesiredClass),
                selectorForm = desc.descriptorForKeyword(keyAEKeyForm),
                selectorDesc = desc.descriptorForKeyword(keyAEKeyData) else {
            throw UnpackError(appData: self, descriptor: desc, type: self.glueInfo.objectSpecifierType,
                               message: "Can't unpack malformed object specifier.")
        }
        do {
            let formCode = selectorForm.enumCodeValue
            // unpack selectorData, unless it's a property code or absolute/relative ordinal
            let selectorData = (formCode == formPropertyID || formCode == formRelativePosition
                                || (formCode == formAbsolutePosition && selectorDesc.descriptorType == typeEnumerated
                                    && [kAEFirst, kAEMiddle, kAELast, kAEAny, kAEAll].contains(selectorDesc.enumCodeValue)))
                               ? selectorDesc : try self.unpack(selectorDesc)
            // TO DO: need 'strict AS emulation' option to fully unpack and repack specifiers, re-setting cachedDesc (TBH, only app that ever had this problem was iView Media Pro, since it takes a double whammy of app bugs to cause an app to puke on receiving objspecs it previously created itself)
            if formCode == formRange || formCode == formTest || (formCode == formAbsolutePosition && selectorDesc.enumCodeValue == kAEAll) {
                return self.glueInfo.elementsSpecifierType.init(wantType: wantType, selectorForm: selectorForm, selectorData: selectorData,
                                                                 parentSelector: nil, appData: self, cachedDesc: desc)
            } else {
                return self.glueInfo.objectSpecifierType.init(wantType: wantType, selectorForm: selectorForm, selectorData: selectorData,
                                                               parentSelector: nil, appData: self, cachedDesc: desc)
            }
        } catch {
            throw UnpackError(appData: self, descriptor: desc, type: self.glueInfo.objectSpecifierType,
                              message: "Can't unpack object specifier's selector data.") // TO DO: need to chain errors
        }
    }
    
    func unpackRangeDescriptor(desc: NSAppleEventDescriptor) throws -> RangeSelector {
        return try RangeSelector(appData: self, desc: desc)
    }
    
    func unpackCompDescriptor(desc: NSAppleEventDescriptor) throws -> TestClause {
        if let operatorType = desc.descriptorForKeyword(keyAECompOperator),
                operand1Desc = desc.descriptorForKeyword(keyAEObject1),
                operand2Desc = desc.descriptorForKeyword(keyAEObject2) {
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
    
    func unpackLogicalDescriptor(desc: NSAppleEventDescriptor) throws -> TestClause {
        if let operatorType = desc.descriptorForKeyword(keyAELogicalOperator),
                operandsDesc = desc.descriptorForKeyword(keyAEObject) {
            // TO DO: also check operatorType is valid?
            let operands = try self.unpack(operandsDesc, asType: [TestClause].self) // TO DO: catch and rethrow with additional details
            return LogicalTest(operatorType: operatorType, operands: operands, appData: self, cachedDesc: desc)
        }
        throw UnpackError(appData: self, descriptor: desc, type: TestClause.self, message: "Can't unpack logical test: malformed descriptor.")
    }
    
    /******************************************************************************/
    // Convert an Apple event descriptor to the specified Swift type, coercing it as necessary
    
    
    // TO DO: the following generic code doesn't work, as swiftc seems to choose the least-specific method instead of the most-specific, thus when caller requests e.g. Array<…>, the compiler dispatches to `unpack<T>(desc: NSAppleEventDescriptor, asType: T.Type) throws -> T` instead of `unpack<T>(desc: NSAppleEventDescriptor, asType: [T].Type) throws -> [T]` as intended.
    
    // (note: dispatching based solely on methods' overloaded return types might also be a bit cheesy, hence use of `asType:` parameters here; although Specifier.sendAppleEvent() and glue-defined command methods currently try to use it as it looks better from user's POV - however, will need to test _very_ thoroughly before committing to it)
    
    
    // TO DO: how best to compose/chain exceptions?
    public func unpack<T>(desc: NSAppleEventDescriptor, asType: [T].Type) throws -> [T] { // unpack desc as Array // TO DO: hack; name is temporary
        switch desc.descriptorType {
        case typeAEList:
            var result = [T]()
            for i in 1...desc.numberOfItems {
                do {
                    result.append(try self.unpack(desc.descriptorAtIndex(i)!, asType: T.self))
                } catch {
                    throw UnpackError(appData: self, descriptor: desc, type: [T].self, message: "Can't unpack item \(index).")
                }
            }
            return result
        case typeQDPoint, typeQDRectangle, typeRGBColor: // short[2], short[4], unsigned short[3] (used by older Carbon apps; Cocoa apps use lists)
            // note: coercing these types to typeAEList and unpacking those would be simpler, but while AEM provides coercion handlers for coercing e.g. typeAEList to typeQDPoint, it doesn't provide handlers for the reverse (coercing a typeQDPoint desc to typeAEList merely produces a single-item AEList containing the original typeQDPoint, not a 2-item AEList of typeSInt16)
            if T.self == Int.self { // common case
                var result = [T]()
                let data = desc.data
                for i in 0..<([typeQDPoint:2, typeQDRectangle:4, typeRGBColor:3][desc.descriptorType]!) {
                    var n: Int16 = 0
                    data.getBytes(&n, range: NSRange(location: i*sizeofValue(n), length: sizeofValue(n)))
                    result.append(Int(n) as! T) // note: can't use T(n) here as Swift doesn't define integer constructors in IntegerType protocol (but does for FloatingPointType)
                }
                return result
            } else { // for any other T, repack as AEList of typeSInt32, and [try to] unpack that as [T]
                return try unpack(try pack(try unpack(desc, asType: [Int].self)), asType: [T].self)
            }
        default:
            return [try self.unpack(desc, asType: T.self)]
        }
    }
    
    public func unpack<T>(desc: NSAppleEventDescriptor, asType: [Symbol:T]) throws -> [Symbol:T] { // unpack desc as Dictionary; TO DO: how to handle String keys as well (e.g. define an AERecord<T> type specifically for the task)?
        if let recordDesc = desc.coerceToDescriptorType(typeAERecord) {
            var result = [Symbol:T]()
            for i in 1...recordDesc.numberOfItems {
                let key = self.unpackAEProperty(recordDesc.keywordForDescriptorAtIndex(i))
                do {
                    result[key] = try self.unpack(recordDesc.descriptorAtIndex(i)!, asType: T.self)
                } catch {
                    throw UnpackError(appData: self, descriptor: desc, type: [T].self, message: "Can't unpack item \(index).")
                }
            }
            return result
        } else {
            throw UnpackError(appData: self, descriptor: desc, type: [Symbol:T].self, message: "Not a record.")
        }
    }
    
    // TO DO: what about 'missing value'? for a pure Swift bridge, might be better to use nil rather than Symbol.missingValue; following won't work as compiler regards it as ambiguous; OTOH, it would require all command results to be optionals, or else define all commands twice, once with optional result, once with non-optional (unpacking arrays would remain a problem though)
    // TO DO: also, what about supporting arbitrary sum types, e.g. if a command returns either a number or a string? (note that this is much less common than returning missing value; so may be simplest just to unpack as Any)
    
    //    public func unpack<T>(desc: NSAppleEventDescriptor, asType: Optional<T.Type>) throws -> Optional<T> {
    //        return desc.descriptorType == typeType && desc.typeCodeValue == cMissingValue ? nil : (try self.unpack(desc, asType: T.self))
    //    }
    
    public func unpack<T>(desc: NSAppleEventDescriptor, asType: T.Type) throws -> T { // unpack desc as atomic type (Int, String, Specifier, etc)
        if T.self == Any.self || T.self == AnyObject.self {
            return try self.unpack(desc) as! T
        } else if T.self == Bool.self {
            return desc.booleanValue as! T
        } else if T.self == Int.self { // TO DO: what about sized types (Int8, Int16, Int32, Int64); what about UInts?
            if desc.descriptorType == typeSInt32 {
                return Int(desc.int32Value) as! T
            } else if let intDesc = desc.coerceToDescriptorType(typeSInt64) {
                var result: Int64 = 0
                intDesc.data.getBytes(&result, length: sizeofValue(result))
                return Int(result) as! T
            }
        } else if T.self == Double.self { // TO DO: what about Float (typeIEEE32BitFloatingPoint)?
             if let doubleDesc = desc.coerceToDescriptorType(typeIEEE64BitFloatingPoint) {
                 return Double(doubleDesc.doubleValue) as! T
             }
        } else if T.self == String.self {
            if let result = desc.stringValue { // TO DO: fail if desc is typeType, typeEnumerated, etc.? or convert to name [if known] and return that? (i.e. typeType, etc. can always coerce to typeUnicodeText, but this is misleading and could cause problems e.g. when a value may be string or missingValue)
                return result as! T
            }
        } else if T.self is Selector.Type { // note: user typically specifies exact class ([PREFIX][Object|Elements]Specifier)
            if let result = try self.unpack(desc) as? T { // specifiers can be composed of several AE types, so unpack first then check type
                return result
            }
        } else if T.self is Symbol.Type {
            if desc.coerceToDescriptorType(typeType) != nil { // AEM happily coerces between typeType, typeEnum, typeProperty, etc., so use that to check suitability rather than check for specific hardcoded descriptorTypes
                return self.unpackSymbol(desc) as! T
            }
        } else if T.self == NSDate.self {
             if let result = desc.dateValue {
                 return result as! T
             }
        } else if T.self == NSURL.self {
             if let result = desc.fileURLValue { // TO DO: roundtripping of typeAlias, typeBookmarkData, etc? (as in AppleEventBridge, this'd require a custom NSURL subclass to cache the original descriptor and return it again when repacked)
                 return result as! T
             }
        } else if T.self == NSAppleEventDescriptor.self {
            return desc as! T
        } else {
//            print(T.self)
            throw UnpackError(appData: self, descriptor: desc, type: T.self, message: "SwiftAE doesn't recognize this Swift type.")
        }
        throw UnpackError(appData: self, descriptor: desc, type: T.self) // desc couldn't be coerced to the specified type
    }
    
    
    /******************************************************************************/
    // Convert an Apple event descriptor to it preferred Swift type, as determined by its descriptorType
    
    public func unpack(desc: NSAppleEventDescriptor) throws -> Any { // TO DO: make sure Optional(VALUE) isn't returned, as that allows the possibility of .None (i.e. nil) as well; whereas nil should only be returned if 'cMissingValue' is mapped to nil (and that has yet to be decided on); e.g. use Any!, or will that mess up type signatures elsewhere?
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
            return try unpack(desc, asType: [Any].self)
        case typeAERecord:
            return try unpack(desc, asType: [Symbol:Any].self)
        case typeAlias, typeBookmarkData, typeFileURL, typeFSRef, typeFSS:
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
            desc.data.getBytes(&result, length: sizeofValue(result))
            return Int(result)
        case typeUInt64, typeUInt32, typeUInt16:
            var result: UInt64 = 0
            desc.coerceToDescriptorType(typeUInt64)!.data.getBytes(&result, length: sizeofValue(result))
            return UInt(result)
        case typeQDPoint, typeQDRectangle, typeRGBColor:
            return try self.unpack(desc, asType: [Int].self)
        default:
            return desc
        }
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
    let NoTimeout: NSTimeInterval = -2
    let DefaultTimeout: NSTimeInterval = -1

    let DefaultSendMode = NSAppleEventSendOptions.CanSwitchLayer
    let DefaultConsiderations = packConsideringAndIgnoringFlags([.Case])
    
    let NoResult = Symbol(name: "missingValue", code: cMissingValue)
    
    // if target process is no longer running, Apple Event Manager will return an error when an event is sent to it
    let RelaunchableErrorCodes: Set<Int> = [-600, -609]
    // if relaunchMode = .Limited, only 'launch' and 'run' are allowed to restart a local application that's been quit
    let LimitedRelaunchEvents: [(OSType,OSType)] = [(kCoreEventClass, kAEOpenApplication), (kASAppleScriptSuite, kASLaunchEvent)]
    
    private func send(event: NSAppleEventDescriptor, sendMode: NSAppleEventSendOptions, timeout: NSTimeInterval) throws -> NSAppleEventDescriptor { // used by sendAppleEvent()
        do {
            return try event.sendEventWithOptions(sendMode, timeout: timeout) // throws NSError on AEM errors (but not app errors)
        } catch { // 'launch' events normally return 'not handled' errors, so just ignore those
            if (error as NSError).code == -1708
                && event.attributeDescriptorForKeyword(keyEventClassAttr)!.typeCodeValue == kASAppleScriptSuite
                && event.attributeDescriptorForKeyword(keyEventIDAttr)!.typeCodeValue == kASLaunchEvent {
                    return NSAppleEventDescriptor.recordDescriptor() // (not a full AppleEvent desc, but reply event's attributes aren't used so is equivalent to a reply event containing neither error nor result)
            } else {
                throw error
            }
        }
    }
    
    func sendAppleEvent<T>(name: String?, eventClass: OSType, eventID: OSType, // note: human-readable command and parameter names are only used (if known) in error messages
                           parentSpecifier: Specifier, // the Specifier on which the command method was called; see special-case packing logic below
                           directParameter: Any, // the first (unnamed) parameter to the command method; see special-case packing logic below
                           keywordParameters: KeywordParameters, // the remaining named parameters
                           requestedType: Symbol?, // event's `as` parameter, if any
                           waitReply: Bool, // wait for application to respond before returning? (default is true)
                           sendOptions: NSAppleEventSendOptions?, // raw send options (if given, waitReply arg is ignored); default is nil
                           withTimeout: NSTimeInterval?, // no. of seconds to wait before raising timeout error (-1712); may also be default/never
                 //        returnID: AEReturnID, // TO DO: need to check correct procedure for this; should send return auto-generated returnID?
                 //        transactionID: AETransactionID,
                           considering: ConsideringOptions?,
                           asType: T.Type) throws -> T // coerce and unpack result as this type or return raw reply event if T is NSDescriptor; default is Any
    {
        // TO DO: all errors occurring within this method should be caught and rethrown as CommandError, allowing error message to include a description of the failed command as well as the error that occurred
        // Create a new AppleEvent descriptor (throws ConnectionError if target app isn't found)
        let event = NSAppleEventDescriptor(eventClass: eventClass, eventID: eventID, targetDescriptor: try self.targetDescriptor(),
                                           returnID: AEReturnID(kAutoGenerateReturnID), transactionID: AETransactionID(kAnyTransactionID)) // workarounds: Carbon constants are incorrectly mapped to Int, and NSAppleEventDescriptor.h currently doesn't define its own
        // pack its keyword parameters
        for (_, code, value) in keywordParameters {
            if value as? AnyObject !== NoParameter {
                // TO DO: catch pack errors and report (simplest to capture all input and error info in CommandError, and only process/format if displayed)
                event.setDescriptor(try self.pack(value), forKeyword: code)
            }
        }
        // pack event's direct parameter and/or subject attribute
        let hasDirectParameter = (directParameter as? AnyObject) !== NoParameter
        if hasDirectParameter { // if the command includes a direct parameter, pack that normally as its direct param
            event.setParamDescriptor(try self.pack(directParameter), forKeyword: keyDirectObject)
        }
        // if command method was called on root Application (null) object, the event's subject is also null...
        var subjectDesc = AppRootDesc
        // ... but if the command was called on a Specifier, decide if that specifier should be packed as event's subject
        // or, as a special case, used as event's keyDirectObject/keyAEInsertHere parameter for user's convenience
        if !(parentSpecifier is RootSpecifier) { // technically Application, but there isn't an explicit class for that
            if eventClass == kAECoreSuite && eventID == kAECreateElement { // for user's convenience, `make` command is treated as a special case
                // if `make` command is called on a specifier, use that specifier as event's `at` parameter if not already given
                if event.paramDescriptorForKeyword(keyAEInsertHere) != nil { // an `at` parameter was already given, so pack parent specifier as event's subject attribute
                    subjectDesc = try self.pack(parentSpecifier)
                } else { // else pack parent specifier as event's `at` parameter and use null as event's subject attribute
                    event.setParamDescriptor(try self.pack(parentSpecifier), forKeyword: keyAEInsertHere)
                }
            } else { // for all other commands, check if a direct parameter was already given
                if hasDirectParameter { // pack the parent specifier as the event's subject attribute
                    subjectDesc = try self.pack(parentSpecifier)
                } else { // else pack parent specifier as event's direct parameter and use null as event's subject attribute
                    event.setParamDescriptor(try self.pack(parentSpecifier), forKeyword: keyDirectObject)
                }
            }
        }
        event.setAttributeDescriptor(subjectDesc, forKeyword: keySubjectAttr)
        // pack requested type (`as`) parameter, if specified; note: most apps ignore this, but a few may recognize it (usually in `get` commands)  even if they don't define it in their dictionary (another AppleScript-introduced quirk)
        if let type = requestedType {
            event.setDescriptor(NSAppleEventDescriptor(typeCode: type.code), forKeyword: keyAERequestedType)
        } else {
            // TO DO: else determine this from asType (Q. could including `as` param in all commands break stuff? while event handlers are supposed to ignore unrecognized parameters, this doesn't mean they actually will; might be wise to check exactly if/when AS does it; might need an additional option to toggle between 'auto' and 'off', although that's not ideal as it dumps the problem on user)
        }
        // event attributes
        // (note: most apps ignore considering/ignoring attributes, and always ignore case and consider everything else)
        let (considerations, consideringIgnoring) = considering == nil ? DefaultConsiderations : packConsideringAndIgnoringFlags(considering!)
        event.setAttributeDescriptor(considerations, forKeyword: enumConsiderations)
        event.setAttributeDescriptor(consideringIgnoring, forKeyword: enumConsidsAndIgnores)
        // send the event
        let sendMode = sendOptions ?? DefaultSendMode.union(waitReply ? .WaitForReply : .NoReply) // TO DO: finalize
        let timeout = withTimeout ?? 120 // TO DO: -sendEvent method's default/no timeout options are currently busted (rdar://21477694)
        
//        defer { print("SENT: \(formatAppleEvent(event, useTerminology: .SDEF))") } // TEST
        var replyEvent: NSAppleEventDescriptor
        do {
//            print("SENDING: \(event)")
            replyEvent = try self.send(event, sendMode: sendMode, timeout: timeout) // throws NSError on AEM error
//            print("REPLIED: \(replyEvent)\n")
        } catch { // handle errors raised by Apple Event Manager (e.g. timeout, process not found)
            if RelaunchableErrorCodes.contains((error as NSError).code) && self.target.isRelaunchable && (self.relaunchMode == .Always
                    || (self.relaunchMode == .Limited && LimitedRelaunchEvents.contains({$0.0 == eventClass && $0.1 == eventID}))) {
                // event failed as target process has quit since previous event; recreate AppleEvent with new address and resend
                self._targetDescriptor = nil
                let event = NSAppleEventDescriptor(eventClass: eventClass, eventID: eventID, targetDescriptor: try self.targetDescriptor(),
                                                    returnID: AEReturnID(kAutoGenerateReturnID), transactionID: AETransactionID(kAnyTransactionID))
                for i in 1...event.numberOfItems {
                    event.setParamDescriptor(event.descriptorAtIndex(i)!, forKeyword: event.keywordForDescriptorAtIndex(i))
                }
                for key in [keySubjectAttr, enumConsiderations, enumConsidsAndIgnores] {
                    event.setAttributeDescriptor(event.attributeDescriptorForKeyword(key)!, forKeyword: key)
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
        if sendMode.contains(.WaitForReply) {
            // if rawReply && (T.self is NSAppleEventDescriptor.Type || T.self is Any.Type) { // TO DO: need explicit 'rawReply' arg/flag
            //    return replyEvent as! T
            // }
            if replyEvent.paramDescriptorForKeyword(keyErrorNumber) ?? 0 != 0 { // check if an application error occurred
                throw CommandError(appData: self, event: event, replyEvent: replyEvent)
            } else if let resultDesc = replyEvent.paramDescriptorForKeyword(keyDirectObject) {
                do {
                    return try self.unpack(resultDesc, asType: T.self) // TO DO: if this fails, rethrow as CommandError
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
    
    func sendAppleEvent<T>(eventClass: OSType, eventID: OSType, parentSpecifier: Specifier,
                           var parameters: [OSType:Any] = [:], waitReply: Bool, sendOptions: NSAppleEventSendOptions?,
                           withTimeout: NSTimeInterval?, considering: ConsideringOptions?, asType: T.Type) throws -> T
    {
        let directParameter = parameters.removeValueForKey(keyDirectObject) ?? NoParameter
        let keywordParameters: KeywordParameters = parameters.map({(name: nil, code: $0, value: $1)})
        return try self.sendAppleEvent(nil, eventClass: eventClass, eventID: eventID,
            parentSpecifier: parentSpecifier, directParameter: directParameter,
            keywordParameters: keywordParameters, requestedType: nil, waitReply: waitReply,
            sendOptions: sendOptions, withTimeout: withTimeout, considering: considering, asType: T.self)
    }

}



/******************************************************************************/
// used by AppData.sendAppleEvent() to pack ConsideringOptions as enumConsiderations (old-style) and enumConsidsAndIgnores (new-style) attributes // TO DO: move to AppData?

let gConsiderationsTable: [(Considerations, NSAppleEventDescriptor, UInt32, UInt32)] = [
    // note: Swift mistranslates considering/ignoring mask constants as Int, not UInt32, so redefine them here
    (.Case,             NSAppleEventDescriptor(enumCode: kAECase),              0x00000001, 0x00010000),
    (.Diacritic,        NSAppleEventDescriptor(enumCode: kAEDiacritic),         0x00000002, 0x00020000),
    (.WhiteSpace,       NSAppleEventDescriptor(enumCode: kAEWhiteSpace),        0x00000004, 0x00040000),
    (.Hyphens,          NSAppleEventDescriptor(enumCode: kAEHyphens),           0x00000008, 0x00080000),
    (.Expansion,        NSAppleEventDescriptor(enumCode: kAEExpansion),         0x00000010, 0x00100000),
    (.Punctuation,      NSAppleEventDescriptor(enumCode: kAEPunctuation),       0x00000020, 0x00200000),
    (.NumericStrings,   NSAppleEventDescriptor(enumCode: kASNumericStrings),    0x00000080, 0x00800000),
]

private func packConsideringAndIgnoringFlags(considerations: ConsideringOptions) -> (NSAppleEventDescriptor, NSAppleEventDescriptor) {
    let considerationsListDesc = NSAppleEventDescriptor.listDescriptor()
    var consideringIgnoringFlags: UInt32 = 0
    for (consideration, considerationDesc, consideringMask, ignoringMask) in gConsiderationsTable {
        if considerations.contains(consideration) {
            consideringIgnoringFlags |= consideringMask
            considerationsListDesc.insertDescriptor(considerationDesc, atIndex: 0)
        } else {
            consideringIgnoringFlags |= ignoringMask
        }
    }
    return (considerationsListDesc, UInt32Descriptor(consideringIgnoringFlags)) // old-style flags (list of enums), new-style flags (bitmask)
}

