//
//  Specifier.swift
//  SwiftAE
//
//

import Foundation
import AppKit


/******************************************************************************/
// abstract base class for _all_ specifier and test clause subclasses


public class Selector: CustomStringConvertible, SelfPacking { // TO DO: Equatable?
    
    static let formatter = SpecifierFormatter() // TO DO: how to implement glue-specific hook?
    
    public private(set) var appData: AppData? = nil // TO DO: use ImplicitlyUnwrappedOptional<AppData>?
    var cachedDesc: NSAppleEventDescriptor?
    
    init(appData: AppData?, cachedDesc: NSAppleEventDescriptor?) { // cachedDesc is supplied on unpacking
        self.appData = appData
        self.cachedDesc = cachedDesc
    }
    
    // unpacking
    
    private func unpackParentSpecifiers() {} // ObjectSpecifier overrides this to recursively unpack its 'from' desc only when needed
    
    // packing
    
    public func packSelf(appData: AppData) throws -> NSAppleEventDescriptor {
        if self.cachedDesc == nil {
            if self.appData == nil { // it's an untargeted specifier, so target it by adding AppData object to it
                self.appData = appData
            }
            self.cachedDesc = try self.packSelf()
        }
        return self.cachedDesc!
    }
    
    private func packSelf() throws -> NSAppleEventDescriptor { // subclasses must override this to pack themselves
        throw NotImplementedError()
    }
    
    // misc
    
    public var description: String {
        return self.dynamicType.formatter.format(self)
    }
}


// TO DO: RootSpecifier should subclass Specifier and rely on protocol extensions to supply property, userProperty, elements methods, and test clause support via protocol extensions

/******************************************************************************/
// abstract base class for all object and insertion specifiers
// app-specific glues should subclass this and add command methods via protocol extension (mixin) to it and all of its subclasses too

// TO DO: is it practical to prevent commands appearing on generic specifiers? (it ought to be doable as long as subclasses and mixins can provide the right class hooks; the main issue is how crazy mad the typing gets)


public protocol SpecifierProtocol {
    var appData: AppData? {get}
    var parentSpecifier: Selector {get}
    
    
}

public class Specifier: Selector, SpecifierProtocol {

    // An object specifier is constructed as a linked list of AERecords of typeObjectSpecifier, terminated by a root descriptor (e.g. a null descriptor represents the root node of the app's Apple event object graph). The topmost node may also be an insertion location specifier, represented by an AERecord of typeInsertionLoc. The abstract Specifier class implements functionality common to both object and insertion specifiers.
    
    private var _parentSpecifier: Selector? // note: object specifiers are lazily unpacked for efficiency, so this is nil if Specifier hasn't been fully unpacked yet (or if class is RootSpecifier, in which case it's unused)

    public init(parentSpecifier: Selector?, appData: AppData?, cachedDesc: NSAppleEventDescriptor?) {
        self._parentSpecifier = parentSpecifier
        super.init(appData: appData, cachedDesc: cachedDesc)
    }
    
    public var parentSpecifier: Selector { // 'from' in object specifier, or 'kobj' in insertion specifier
        if self._parentSpecifier == nil {
            self.unpackParentSpecifiers()
        }
        return self._parentSpecifier!
    }
    
    // unpacking
    
    private override func unpackParentSpecifiers() {
        guard let cachedDesc = self.cachedDesc, appData = self.appData else {
            print("Can't unpack parent specifiers as cached AppData and/or AEDesc don't exist (this isn't supposed to happen).") // TO DO: DEBUG; delete
            self._parentSpecifier = RootSpecifier(rootObject: SwiftAEError(code: 1, message: "Can't unpack parent specifiers as cached AppData and/or AEDesc don't exist (this isn't supposed to happen).")) // TO DO: implement ErrorSpecifier subclass that takes error info and always raises on use
            return
        }
        do {
            let parentDesc = cachedDesc.descriptorForKeyword(keyAEContainer)!
            self._parentSpecifier = try appData.unpack(parentDesc, asType: Specifier.self)
            self._parentSpecifier!.unpackParentSpecifiers()
        } catch {
            print("Deferred unpack parent specifier failed: \(error)") // TO DO: DEBUG; delete
            self._parentSpecifier = RootSpecifier(rootObject: (cachedDesc.descriptorForKeyword(keyAEContainer))!) // TO DO: store SwiftAEError that captures and raises error on packing
        }
    }
    
    // convenience methods for sending Apple events using four-char codes // TO DO: any way to genericize these methods, and the methods they call?
    
    // TO DO: any way to support String|OSType sum type without clients having to explicitly construct it? (or is that a 'special case' that Swift only grants to Optional?)
    
    func sendAppleEvent<T>(eventClass: OSType, _ eventID: OSType, _ parameters: [OSType:Any] = [:],
                           waitReply: Bool = true, sendOptions: NSAppleEventSendOptions? = nil,
                           withTimeout: NSTimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        guard let appData = self.appData else { throw SwiftAEError(code: 1, message: "Generic specifiers can't send Apple events.") }
        return try appData.sendAppleEvent(eventClass, eventID: eventID, parentSpecifier: self,
                                          parameters: parameters, waitReply: waitReply, sendOptions: sendOptions,
                                          withTimeout: withTimeout, considering: considering, asType: T.self)
    }
    
    func sendAppleEvent<T>(eventClass: String, _ eventID: String, _ parameters: [String:Any] = [:],
                           waitReply: Bool = true, sendOptions: NSAppleEventSendOptions? = nil,
                            withTimeout: NSTimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        guard let appData = self.appData else { throw SwiftAEError(code: 1, message: "Generic specifiers can't send Apple events.") }
        var params = [OSType:Any]()
        for (k, v) in parameters { params[UTGetOSTypeFromString(k)] = v }
        return try appData.sendAppleEvent(UTGetOSTypeFromString(eventClass), eventID: UTGetOSTypeFromString(eventID), parentSpecifier: self,
                                          parameters: params, waitReply: waitReply, sendOptions: sendOptions,
                                          withTimeout: withTimeout, considering: considering, asType: T.self)
    }
    
    // non-generic version of the above used when T isn't already specified/inferrable, in which case Any! is used // TO DO: use 'Any' or 'Any!'?
    func sendAppleEvent(eventClass: OSType, _ eventID: OSType, _ parameters: [OSType:Any] = [:],
                        waitReply: Bool = true, sendOptions: NSAppleEventSendOptions? = nil,
                        withTimeout: NSTimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        guard let appData = self.appData else { throw SwiftAEError(code: 1, message: "Generic specifiers can't send Apple events.") }
        return try appData.sendAppleEvent(eventClass, eventID: eventID, parentSpecifier: self,
                                          parameters: parameters, waitReply: waitReply, sendOptions: sendOptions,
                                          withTimeout: withTimeout, considering: considering, asType: Any.self)
    }
    
    func sendAppleEvent(eventClass: String, _ eventID: String, _ parameters: [String:Any] = [:],
                        waitReply: Bool = true, sendOptions: NSAppleEventSendOptions? = nil,
                        withTimeout: NSTimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        guard let appData = self.appData else { throw SwiftAEError(code: 1, message: "Generic specifiers can't send Apple events.") }
        var params = [OSType:Any]()
        for (k, v) in parameters { params[UTGetOSTypeFromString(k)] = v }
        return try appData.sendAppleEvent(UTGetOSTypeFromString(eventClass), eventID: UTGetOSTypeFromString(eventID), parentSpecifier: self,
                                          parameters: params, waitReply: waitReply, sendOptions: sendOptions,
                                          withTimeout: withTimeout, considering: considering, asType: Any.self)
    }
}


/******************************************************************************/
// insertion location specifier

public class InsertionSpecifier: Specifier { // packSelf
    
    // 'insl'
    public let insertionLocation: NSAppleEventDescriptor

    required public init(insertionLocation: NSAppleEventDescriptor,
                parentSpecifier: Selector?, appData: AppData?, cachedDesc: NSAppleEventDescriptor?) {
        self.insertionLocation = insertionLocation
        super.init(parentSpecifier: parentSpecifier, appData: appData, cachedDesc: cachedDesc)
    }
    
    private override func packSelf() throws -> NSAppleEventDescriptor {
        let desc = NSAppleEventDescriptor.recordDescriptor().coerceToDescriptorType(typeInsertionLoc)!
        desc.setDescriptor(try self.parentSpecifier.packSelf(self.appData!), forKeyword: keyAEObject)
        desc.setDescriptor(self.insertionLocation, forKeyword: keyAEPosition)
        return desc
    }
}


/******************************************************************************/
// property/single-element specifiers; identifies an attribute/describes a one-to-one relationship between nodes in the app's AEOM graph


public protocol ObjectSpecifierProtocol: SpecifierProtocol {
    var wantType: NSAppleEventDescriptor {get}
    var selectorForm: NSAppleEventDescriptor {get}
    var selectorData: Any {get}
}

public class ObjectSpecifier: Specifier, ObjectSpecifierProtocol { // represents property or single element specifier; adds property+elements vars, relative selectors, insertion specifiers
    
    // 'want', 'form', 'data'
    public let wantType: NSAppleEventDescriptor
    public let selectorForm: NSAppleEventDescriptor
    public let selectorData: Any
    
    // TO DO: ideally want a wantName:String? arg that takes human-readable name, if available, for display purposes (see also previous/next)
    
    required public init(wantType: NSAppleEventDescriptor, selectorForm: NSAppleEventDescriptor, selectorData: Any,
            parentSpecifier: Selector?, appData: AppData?, cachedDesc: NSAppleEventDescriptor?) {
        self.wantType = wantType
        self.selectorForm = selectorForm
        self.selectorData = selectorData
        super.init(parentSpecifier: parentSpecifier, appData: appData, cachedDesc: cachedDesc)
    }
    
    private override func packSelf() throws -> NSAppleEventDescriptor {
        let desc = NSAppleEventDescriptor.recordDescriptor().coerceToDescriptorType(typeObjectSpecifier)!
        desc.setDescriptor(try self.parentSpecifier.packSelf(self.appData!), forKeyword: keyAEContainer)
        desc.setDescriptor(self.wantType, forKeyword: keyAEDesiredClass)
        desc.setDescriptor(self.selectorForm, forKeyword: keyAEKeyForm)
        desc.setDescriptor(try self.appData!.pack(self.selectorData), forKeyword: keyAEKeyData)
        return desc
    }
    
    // note: vars and methods that return new specifier instances must be defined by protocol extension in order to return glue-defined types
    
    // Containment test constructors
    // TO DO: ideally the following should only appear on objects constructed from an Its root; however, this will make the class/protocol hierarchy more complicated, so may be more hassle than it's worth - maybe explore this later, once the current implementation is fully working
    
    func beginsWith(value: Any) -> TestClause {
        return ComparisonTest(operatorType: _BeginsWith, operand1: self, operand2: value, appData: self.appData, cachedDesc: nil)
    }
    func endsWith(value: Any) -> TestClause {
        return ComparisonTest(operatorType: _EndsWith, operand1: self, operand2: value, appData: self.appData, cachedDesc: nil)
    }
    func contains(value: Any) -> TestClause {
        return ComparisonTest(operatorType: _Contains, operand1: self, operand2: value, appData: self.appData, cachedDesc: nil)
    }
    func isIn(value: Any) -> TestClause {
        return ComparisonTest(operatorType: _IsIn, operand1: self, operand2: value, appData: self.appData, cachedDesc: nil)
    }
}


// Comparison test constructors

func <(lhs: ObjectSpecifier, rhs: Any) -> TestClause {
    return ComparisonTest(operatorType: _LT, operand1: lhs, operand2: rhs, appData: lhs.appData, cachedDesc: nil)
}
func <=(lhs: ObjectSpecifier, rhs: Any) -> TestClause {
    return ComparisonTest(operatorType: _LE, operand1: lhs, operand2: rhs, appData: lhs.appData, cachedDesc: nil)
}
func ==(lhs: ObjectSpecifier, rhs: Any) -> TestClause {
    return ComparisonTest(operatorType: _EQ, operand1: lhs, operand2: rhs, appData: lhs.appData, cachedDesc: nil)
}
func !=(lhs: ObjectSpecifier, rhs: Any) -> TestClause {
    return ComparisonTest(operatorType: _NE, operand1: lhs, operand2: rhs, appData: lhs.appData, cachedDesc: nil)
}
func >(lhs: ObjectSpecifier, rhs: Any) -> TestClause {
    return ComparisonTest(operatorType: _GT, operand1: lhs, operand2: rhs, appData: lhs.appData, cachedDesc: nil)
}
func >=(lhs: ObjectSpecifier, rhs: Any) -> TestClause {
    return ComparisonTest(operatorType: _GE, operand1: lhs, operand2: rhs, appData: lhs.appData, cachedDesc: nil)
}


/******************************************************************************/
// Multi-element specifiers; represents a one-to-many relationship between nodes in the app's AEOM graph

public class ElementsSpecifier: ObjectSpecifier { // by range/test/all
// TO DO: now that all implementation has moved to ElementsSpecifierExtension, does this class still serve a purpose, or would it be simpler to delete it and just have glues subclass their own object specifier class?
}


//

public struct RangeSelector: SelfPacking { // holds data for by-range selectors // TO DO: does this need to be public?
    // Start and stop are Con-based (i.e. relative to container) specifiers (App-based specifiers will also work, as 
    // long as they have the same parent specifier as the by-range specifier itself). For convenience, users can also
    // pass non-specifier values (typically Strings and Ints) to represent simple by-name and by-index specifiers of
    // the same element class; these will be converted to specifiers automatically when packed.
    let start: Any
    let stop: Any
    let wantType: NSAppleEventDescriptor
    
    private func packSelector(selectorData: Any, appData: AppData) throws -> NSAppleEventDescriptor {
        var selectorForm: NSAppleEventDescriptor
        switch selectorData {
        case is NSAppleEventDescriptor:
            return selectorData as! NSAppleEventDescriptor
        case is Specifier: // technically, only ObjectSpecifier makes sense here, tho AS prob. doesn't prevent insertion loc or multi-element specifier being passed instead
            return try (selectorData as! Specifier).packSelf(appData)
        default: // pack anything else as a by-name or by-index specifier
            selectorForm = selectorData is String ? _NameForm : _AbsolutePositionForm
            let desc = NSAppleEventDescriptor.recordDescriptor().coerceToDescriptorType(typeObjectSpecifier)!
            desc.setDescriptor(ConRootDesc, forKeyword: keyAEContainer)
            desc.setDescriptor(self.wantType, forKeyword: keyAEDesiredClass)
            desc.setDescriptor(selectorForm, forKeyword: keyAEKeyForm)
            desc.setDescriptor(try appData.pack(selectorData), forKeyword: keyAEKeyData)
            return desc
        }
    }
    
    init(start: Any, stop: Any, wantType: NSAppleEventDescriptor) {
        self.start = start
        self.stop = stop
        self.wantType = wantType
    }
    
    init(appData: AppData, desc: NSAppleEventDescriptor) throws {
        let startDesc = desc.descriptorForKeyword(keyAERangeStart)
        let stopDesc = desc.descriptorForKeyword(keyAERangeStop)
        if startDesc == nil || stopDesc == nil {
            throw UnpackError(appData: appData, descriptor: desc, type: RangeSelector.self, message: "Missing start/stop specifier in by-range specifier.")
        }
        do {
            self.start = try appData.unpack(startDesc!)
            self.stop = try appData.unpack(stopDesc!)
            self.wantType = NSAppleEventDescriptor(typeCode: typeType) // TO DO: wantType is incorrect; in principle this shouldn't matter as start and stop descs _should_ always be object specifiers, but paranoia is best; will need to rethink as it can't be reliably inferred here (since range desc should only appear in by-range object specifier desc, might be simplest just to unpack it directly from there instead of AppData)
        } catch {
            throw UnpackError(appData: appData, descriptor: desc, type: RangeSelector.self, message: "Failed to unpack start/stop specifier in by-range specifier.") // TO DO: or just return RangeSelector containing the original AEDescs?
        }
    }
    
    public func packSelf(appData: AppData) throws -> NSAppleEventDescriptor {
        // note: the returned desc will be cached by the ElementsSpecifier, so no need to cache it here
        let desc = NSAppleEventDescriptor.recordDescriptor().coerceToDescriptorType(typeRangeDescriptor)!
        desc.setDescriptor(try self.packSelector(self.start, appData: appData), forKeyword: keyAERangeStart)
        desc.setDescriptor(try self.packSelector(self.stop, appData: appData), forKeyword: keyAERangeStop)
        return desc
    }
}


/******************************************************************************/
// Test clause; used in by-test specifiers

// note: glues don't define their own TestClause subclasses as tests don't implement any app-specific vars/methods, only the logical operators defined below, and there's little point doing so for static typechecking purposes as any values not handled by ElementsSpecifierExtension's subscript(test:TestClause) are accepted by its subscript(index:Any), so still wouldn't be caught at runtime (OTOH, it'd be worth considering should subscript(test:) need to be replaced with a separate byTest() method for any reason)


// TO DO: currently, TestClauses can be constructed from any root, though only those constructed from Its roots are actually valid; checking this at compile-time would require a more complex class/protocol structure; checking this at runtime would require a Specifier.rootSpecifier getter that recursively walks parent specifiers until it reaches the root specifier and returns that (note: if implementing rootSpecifier var, it'll need to be overridden on ComparisonTest and LogicalTest as they don't have a `parentSpecifier` var but must instead use the appropriate operand; alternatively, might be cleaner just to implement a parentSpecifier getter on TestClause that returns the appropriate operand)

public class TestClause: Selector { // AND, OR, and NOT are implemented as &&, ||, and ! operator overrides
    // TO DO: AND and OR could also be implemented as vararg funcs, but am inclined just to stick to two-arg operators and chain those when unpacking if >2
}

public class ComparisonTest: TestClause {
    
    public let operatorType: NSAppleEventDescriptor, operand1: ObjectSpecifier, operand2: Any
    
    init(operatorType: NSAppleEventDescriptor, operand1: ObjectSpecifier, operand2: Any,
            appData: AppData?, cachedDesc: NSAppleEventDescriptor?) {
        self.operatorType = operatorType
        self.operand1 = operand1
        self.operand2 = operand2
        super.init(appData: appData, cachedDesc: cachedDesc)
    }
    
    private override func packSelf() throws -> NSAppleEventDescriptor {
        if self.operatorType === _NE { // AEM doesn't support a 'kAENotEqual' enum...
            return try (!(self.operand1 == self.operand2)).packSelf(self.appData!) // so convert to kAEEquals+kAENOT
        } else {
            let desc = NSAppleEventDescriptor.recordDescriptor().coerceToDescriptorType(typeCompDescriptor)!
            let opDesc1 = try self.appData!.pack(self.operand1)
            let opDesc2 = try self.appData!.pack(self.operand2)
            if self.operatorType === _IsIn { // AEM doesn't support a 'kAEIsIn' enum...
                desc.setDescriptor(_Contains, forKeyword: keyAECompOperator) // so use kAEContains with operands reversed
                desc.setDescriptor(opDesc2, forKeyword: keyAEObject1)
                desc.setDescriptor(opDesc1, forKeyword: keyAEObject2)
            } else {
                desc.setDescriptor(self.operatorType, forKeyword: keyAECompOperator)
                desc.setDescriptor(opDesc1, forKeyword: keyAEObject1)
                desc.setDescriptor(opDesc1, forKeyword: keyAEObject2)
            }
            return desc
        }
    }
}

public class LogicalTest: TestClause {
    
    public let operatorType: NSAppleEventDescriptor, operands: [TestClause] // note: this doesn't have a 'parent' as such; to walk chain, just use first operand
    
    init(operatorType: NSAppleEventDescriptor, operands: [TestClause], appData: AppData?, cachedDesc: NSAppleEventDescriptor?) {
        self.operatorType = operatorType
        self.operands = operands
        super.init(appData: appData, cachedDesc: cachedDesc)
    }
    
    private override func packSelf() throws -> NSAppleEventDescriptor {
        let desc = NSAppleEventDescriptor.recordDescriptor().coerceToDescriptorType(typeLogicalDescriptor)!
        let opDesc = try self.appData!.pack(self.operands)
        desc.setDescriptor(self.operatorType, forKeyword: keyAELogicalOperator)
        desc.setDescriptor(opDesc, forKeyword: keyAELogicalTerms)
        return desc
    }
}


// Logical test constructors

func &&(lhs: TestClause, rhs: TestClause) -> TestClause {
    return LogicalTest(operatorType: _AND, operands: [lhs, rhs], appData: lhs.appData, cachedDesc: nil)
}
func ||(lhs: TestClause, rhs: TestClause) -> TestClause {
    return LogicalTest(operatorType: _OR, operands: [lhs, rhs], appData: lhs.appData, cachedDesc: nil)
}
prefix func !(lhs: TestClause) -> TestClause {
    return LogicalTest(operatorType: _NOT, operands: [lhs], appData: lhs.appData, cachedDesc: nil)
}



/******************************************************************************/
// Specifier roots (all Specifier chains must be terminated by one of these)

// note: app glues will also define their own generic App, Con, and Its roots

public class RootSpecifier: ObjectSpecifier { // app, con, its, custom root (note: this is a bit sloppy; `con` based specifiers are only for use in by-range selectors, and only `its` based specifiers should support comparison and logic tests; only targeted absolute (app-based/customroot-based) specifiers should implement commands, although single `app` root doesn't distinguish untargeted from targeted since that's determined by absence/presence of AppData object)
    
    convenience init(rootObject: Any, appData: AppData? = nil) {
        // rootObject is either one of the three standard AEDescs indicating app/con/its root, or an arbitrary object supplied by caller (e.g. an AEAddressDesc if constructing a fully qualified specifier)
        self.init(wantType: NSAppleEventDescriptor.nullDescriptor(),
                   selectorForm: NSAppleEventDescriptor.nullDescriptor(), selectorData: rootObject,
                   parentSpecifier: nil, appData: appData, cachedDesc: rootObject as? NSAppleEventDescriptor)
    }

    required public init(wantType: NSAppleEventDescriptor, selectorForm: NSAppleEventDescriptor, selectorData: Any, parentSpecifier: Selector?, appData: AppData?, cachedDesc: NSAppleEventDescriptor?) {
        super.init(wantType: wantType, selectorForm: selectorForm, selectorData: selectorData, parentSpecifier: parentSpecifier, appData: appData, cachedDesc: cachedDesc)
        
    }
    
    override public var parentSpecifier: Selector { return self }
    
    public var rootObject: Any { return self.selectorData }
    
    // TO DO: overriding ObjectSpecifier is kinda risky, since accidental recursion does very bad things
    
    private override func unpackParentSpecifiers() {} // TO DO: temporary; delete once class hierarchy is sorted
    
    public override func packSelf() throws -> NSAppleEventDescriptor {
        return try self.appData!.pack(self.selectorData)
    }
}


// Application root

public let DefaultLaunchOptions: LaunchOptions = .WithoutActivation
public let DefaultRelaunchMode: RelaunchMode = .Limited


public class Application: RootSpecifier {

    class var glueTypes: GlueTypes { // glue-defined subclasses should override this
        return GlueTypes(
                insertionSpecifierType: InsertionSpecifier.self,
                objectSpecifierType: ObjectSpecifier.self,
                elementsSpecifierType: ElementsSpecifier.self,
                rootSpecifierType: RootSpecifier.self,
                symbolType: Symbol.self,
                appRoot: RootSpecifier(rootObject: AppRootDesc, appData: nil),
                conRoot: RootSpecifier(rootObject: ConRootDesc, appData: nil),
                itsRoot: RootSpecifier(rootObject: ItsRootDesc, appData: nil)
        )
    }
    
    private convenience init(target: TargetApplication, launchOptions: LaunchOptions, relaunchMode: RelaunchMode) {
        let appData = AppData(target: target, launchOptions: launchOptions, relaunchMode: relaunchMode, glueTypes: self.dynamicType.glueTypes)
        self.init(rootObject: AppRootDesc, appData: appData)
    }
    
    /* TO DO: app-specific glues should also implement this constructor if app has bundle ID:
    public convenience init(launchOptions: LaunchOptions = DefaultLaunchOptions, relaunchMode: RelaunchMode = DefaultRelaunchMode) {
        self.init(target: .BundleIdentifier("BUNDLE-ID-GOES-HERE"), launchOptions: launchOptions, relaunchMode: relaunchMode)
    }*/
    
    public convenience init(name: String, launchOptions: LaunchOptions = DefaultLaunchOptions, relaunchMode: RelaunchMode = DefaultRelaunchMode) {
        self.init(target: .Name(name), launchOptions: launchOptions, relaunchMode: relaunchMode)
    }
    
    public convenience init(url: NSURL, launchOptions: LaunchOptions = DefaultLaunchOptions, relaunchMode: RelaunchMode = DefaultRelaunchMode) {
        self.init(target: .URL(url), launchOptions: launchOptions, relaunchMode: relaunchMode)
    }
    
    public convenience init(bundleIdentifier: String, launchOptions: LaunchOptions = DefaultLaunchOptions, relaunchMode: RelaunchMode = DefaultRelaunchMode) {
        self.init(target: .BundleIdentifier(bundleIdentifier), launchOptions: launchOptions, relaunchMode: relaunchMode)
    }
    
    public convenience init(processIdentifier: pid_t, launchOptions: LaunchOptions = DefaultLaunchOptions, relaunchMode: RelaunchMode = DefaultRelaunchMode) {
        self.init(target: .ProcessIdentifier(processIdentifier), launchOptions: launchOptions, relaunchMode: relaunchMode)
    }
    
    public convenience init(addressDescriptor: NSAppleEventDescriptor, launchOptions: LaunchOptions = DefaultLaunchOptions, relaunchMode: RelaunchMode = DefaultRelaunchMode) {
        self.init(target: .Descriptor(addressDescriptor), launchOptions: launchOptions, relaunchMode: relaunchMode)
    }
    
    
    public class func currentApplication() -> Self {
        let appData = AppData(target: .Current, launchOptions: DefaultLaunchOptions, relaunchMode: DefaultRelaunchMode, glueTypes: self.glueTypes)
        return self.init(wantType: NSAppleEventDescriptor.nullDescriptor(),
                   selectorForm: NSAppleEventDescriptor.nullDescriptor(), selectorData: AppRootDesc,
                   parentSpecifier: nil, appData: appData, cachedDesc: AppRootDesc)
    }
    
    public func customRoot(object: Any) -> Self { // TO DO: should AppData also provide an option to set default app root object, to be used in building and unpacking _all_ object specifiers?
        return self.dynamicType.init(wantType: NSAppleEventDescriptor.nullDescriptor(),
                   selectorForm: NSAppleEventDescriptor.nullDescriptor(), selectorData: object,
                   parentSpecifier: nil, appData: appData, cachedDesc: nil)
    }
}



/******************************************************************************/
// constants


let _PropertyType = NSAppleEventDescriptor(typeCode: typeProperty)
// selector forms
let _PropertyForm           = NSAppleEventDescriptor(enumCode: formPropertyID) // specifier.NAME or specifier.property(CODE)
let _UserPropertyForm       = NSAppleEventDescriptor(enumCode: formUserPropertyID) // specifier.userProperty(NAME)
let _AbsolutePositionForm   = NSAppleEventDescriptor(enumCode: formAbsolutePosition) // specifier[IDX] or specifier.first/middle/last/any
let _NameForm               = NSAppleEventDescriptor(enumCode: formName) // specifier[NAME] or specifier.named(NAME)
let _UniqueIDForm           = NSAppleEventDescriptor(enumCode: formUniqueID) // specifier.ID(UID)
let _RelativePositionForm   = NSAppleEventDescriptor(enumCode: formRelativePosition) // specifier.before/after(SYMBOL)
let _RangeForm              = NSAppleEventDescriptor(enumCode: formRange) // specifier[FROM,TO]
let _TestForm               = NSAppleEventDescriptor(enumCode: formTest) // specifier[TEST]
// insertion locations
let _Beginning  = NSAppleEventDescriptor(enumCode: kAEBeginning)
let _End        = NSAppleEventDescriptor(enumCode: kAEEnd)
let _Before     = NSAppleEventDescriptor(enumCode: kAEBefore)
let _After      = NSAppleEventDescriptor(enumCode: kAEAfter)
// absolute positions
let _First  = FourCharCodeDescriptor(typeAbsoluteOrdinal, kAEFirst)
let _Middle = FourCharCodeDescriptor(typeAbsoluteOrdinal, kAEMiddle)
let _Last   = FourCharCodeDescriptor(typeAbsoluteOrdinal, kAELast)
let _Any    = FourCharCodeDescriptor(typeAbsoluteOrdinal, kAEAny)
let _All    = FourCharCodeDescriptor(typeAbsoluteOrdinal, kAEAll)
// relative positions
let _Previous   = NSAppleEventDescriptor(enumCode: kAEPrevious)
let _Next       = NSAppleEventDescriptor(enumCode: kAENext)

// AEM doesn't define '!=' or 'in' operators, so define 'temp' codes to represent these
let kSAENotEquals: OSType = 0x00000001
let kSAEIsIn: OSType = 0x00000002

// comparison tests
let _LT = NSAppleEventDescriptor(enumCode: kAELessThan)
let _LE = NSAppleEventDescriptor(enumCode: kAELessThanEquals)
let _EQ = NSAppleEventDescriptor(enumCode: kAEEquals)
let _NE = NSAppleEventDescriptor(enumCode: kSAENotEquals) // pack as !(op1==op2)
let _GT = NSAppleEventDescriptor(enumCode: kAEGreaterThan)
let _GE = NSAppleEventDescriptor(enumCode: kAEGreaterThanEquals)
// containment tests
let _BeginsWith = NSAppleEventDescriptor(enumCode: kAEBeginsWith)
let _EndsWith   = NSAppleEventDescriptor(enumCode: kAEEndsWith)
let _Contains   = NSAppleEventDescriptor(enumCode: kAEContains)
let _IsIn       = NSAppleEventDescriptor(enumCode: kSAEIsIn) // pack d as op2.contains(op1)
// logic tests
let _AND = NSAppleEventDescriptor(enumCode: kAEAND)
let _OR  = NSAppleEventDescriptor(enumCode: kAEOR)
let _NOT = NSAppleEventDescriptor(enumCode: kAENOT)



