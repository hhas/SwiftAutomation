//
//  Specifier.swift
//  SwiftAE
//
//

import Foundation
import AppKit

// TO DO: underscore-prefix private/internal properties and methods to reduce risk of terminology clashes

// TO DO: make sure KeywordConverter lists _all_ Specifier members (e.g. `appData` currently isn't included)


/******************************************************************************/
// abstract base class for _all_ specifier and test clause subclasses

private let gUntargetedAppData = AppData() // dummy instance to keep compiler happy; glues will define their own private gUntargetedAppData constants containing an untargeted AppData instance


public class Selector: CustomStringConvertible, SelfPacking { // TO DO: Equatable?
    
    public let appData: AppData
    internal private(set) var cachedDesc: NSAppleEventDescriptor?
    
    init(appData: AppData, cachedDesc: NSAppleEventDescriptor?) { // cachedDesc is supplied on unpacking
        self.appData = appData
        self.cachedDesc = cachedDesc
    }
    
    // unpacking
    
    private func unpackParentSpecifiers() {} // ObjectSpecifier overrides this to recursively unpack its 'from' desc only when needed
    
    // packing
    
    public func packSelf(_ appData: AppData) throws -> NSAppleEventDescriptor {
        if self.cachedDesc == nil {
            self.cachedDesc = try self.packSelf()
        }
        return self.cachedDesc!
    }
    
    private func packSelf() throws -> NSAppleEventDescriptor { // this implementation should never be called; subclasses must override this to pack themselves
        throw NotImplementedError()
    }
    
    // misc
    
    var parentSelector: Selector { return self } // this implementation should never be called; subclasses must override this
    
    public var rootSpecifier: RootSpecifier { return gUntargetedAppData.rootObjects.app } // this implementation should never be called; subclasses must override this
    
    public var description: String { return self.appData.formatter.format(self) }
}


/******************************************************************************/
// abstract base class for all object and insertion specifiers
// app-specific glues should subclass this and add command methods via protocol extension (mixin) to it and all of its subclasses too

// TO DO: is it practical to prevent commands appearing on generic specifiers? (it ought to be doable as long as subclasses and mixins can provide the right class hooks; the main issue is how crazy mad the typing gets)


public protocol SpecifierProtocol {
    var appData: AppData {get}
    var parentSelector: Selector {get}
    var rootSpecifier: RootSpecifier {get}
}

public class Specifier: Selector, SpecifierProtocol {

    // An object specifier is constructed as a linked list of AERecords of typeObjectSpecifier, terminated by a root descriptor (e.g. a null descriptor represents the root node of the app's Apple event object graph). The topmost node may also be an insertion location specifier, represented by an AERecord of typeInsertionLoc. The abstract Specifier class implements functionality common to both object and insertion specifiers.
    
    private var _parentSelector: Selector? // note: object specifiers are lazily unpacked for efficiency, so this is nil if Specifier hasn't been fully unpacked yet (or if class is RootSpecifier, in which case it's unused)

    public init(parentSelector: Selector?, appData: AppData, cachedDesc: NSAppleEventDescriptor?) {
        self._parentSelector = parentSelector
        super.init(appData: appData, cachedDesc: cachedDesc)
    }
    
    public override var parentSelector: Selector { // 'from' in object specifier, or 'kobj' in insertion specifier
        if self._parentSelector == nil {
            self.unpackParentSpecifiers()
        }
        return self._parentSelector!
    }
    
    public override var rootSpecifier: RootSpecifier { return self.parentSelector.rootSpecifier }
    
    // unpacking
    
    private override func unpackParentSpecifiers() {
        guard let cachedDesc = self.cachedDesc else {
            print("Can't unpack parent specifiers as cached descriptor don't exist (this isn't supposed to happen).") // TO DO: DEBUG; delete
            self._parentSelector = RootSpecifier(rootObject: SwiftAEError(code: 1, message: "Can't unpack parent specifiers as cached AppData and/or AEDesc don't exist (this isn't supposed to happen)."), appData: self.appData) // TO DO: implement ErrorSpecifier subclass that takes error info and always raises on use
            return
        }
        do {
            let parentDesc = cachedDesc.forKeyword(keyAEContainer)!
            self._parentSelector = try appData.unpack(parentDesc, returnType: Specifier.self)
            self._parentSelector!.unpackParentSpecifiers()
        } catch {
            print("Deferred unpack parent specifier failed: \(error)") // TO DO: DEBUG; delete
            self._parentSelector = RootSpecifier(rootObject: (cachedDesc.forKeyword(keyAEContainer))!, appData: self.appData) // TO DO: store error in RootSpecifier and raise it on packing
        }
    }
    
    // convenience methods for sending Apple events using four-char codes // TO DO: any way to genericize these methods, and the methods they call?
    
    // TO DO: any way to support String|OSType sum type without clients having to explicitly construct it? (or is that a 'special case' that Swift only grants to Optional?)
    
    func sendAppleEvent<T>(_ eventClass: OSType, _ eventID: OSType, _ parameters: [OSType:Any] = [:],
                           waitReply: Bool = true, sendOptions: NSAppleEventDescriptor.SendOptions? = nil,
                           withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(eventClass, eventID: eventID, parentSpecifier: self,
                                          parameters: parameters, waitReply: waitReply, sendOptions: sendOptions,
                                          withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    
    func sendAppleEvent<T>(_ eventClass: String, _ eventID: String, _ parameters: [String:Any] = [:],
                           waitReply: Bool = true, sendOptions: NSAppleEventDescriptor.SendOptions? = nil,
                            withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        var params = [OSType:Any]()
        for (k, v) in parameters { params[FourCharCodeUnsafe(k)] = v }
        return try self.appData.sendAppleEvent(FourCharCodeUnsafe(eventClass), eventID: FourCharCodeUnsafe(eventID), parentSpecifier: self,
                                          parameters: params, waitReply: waitReply, sendOptions: sendOptions,
                                          withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    
    // non-generic version of the above used when T isn't already specified/inferrable, in which case Any! is used // TO DO: use 'Any' or 'Any!'?
    func sendAppleEvent(_ eventClass: OSType, _ eventID: OSType, _ parameters: [OSType:Any] = [:],
                        waitReply: Bool = true, sendOptions: NSAppleEventDescriptor.SendOptions? = nil,
                        withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(eventClass, eventID: eventID, parentSpecifier: self,
                                          parameters: parameters, waitReply: waitReply, sendOptions: sendOptions,
                                          withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    
    func sendAppleEvent(_ eventClass: String, _ eventID: String, _ parameters: [String:Any] = [:],
                        waitReply: Bool = true, sendOptions: NSAppleEventDescriptor.SendOptions? = nil,
                        withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        var params = [OSType:Any]()
        for (k, v) in parameters { params[FourCharCodeUnsafe(k)] = v }
        return try self.appData.sendAppleEvent(FourCharCodeUnsafe(eventClass), eventID: FourCharCodeUnsafe(eventID), parentSpecifier: self,
                                          parameters: params, waitReply: waitReply, sendOptions: sendOptions,
                                          withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
}


/******************************************************************************/
// insertion location specifier

public class InsertionSpecifier: Specifier { // packSelf
    
    // 'insl'
    public let insertionLocation: NSAppleEventDescriptor

    required public init(insertionLocation: NSAppleEventDescriptor,
                parentSelector: Selector?, appData: AppData, cachedDesc: NSAppleEventDescriptor?) {
        self.insertionLocation = insertionLocation
        super.init(parentSelector: parentSelector, appData: appData, cachedDesc: cachedDesc)
    }
    
    private override func packSelf() throws -> NSAppleEventDescriptor {
        let desc = NSAppleEventDescriptor.record().coerce(toDescriptorType: typeInsertionLoc)!
        desc.setDescriptor(try self.parentSelector.packSelf(self.appData), forKeyword: keyAEObject)
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
            parentSelector: Selector?, appData: AppData, cachedDesc: NSAppleEventDescriptor?) {
        self.wantType = wantType
        self.selectorForm = selectorForm
        self.selectorData = selectorData
        super.init(parentSelector: parentSelector, appData: appData, cachedDesc: cachedDesc)
    }
    
    private override func packSelf() throws -> NSAppleEventDescriptor {
        let desc = NSAppleEventDescriptor.record().coerce(toDescriptorType: typeObjectSpecifier)!
        desc.setDescriptor(try self.parentSelector.packSelf(self.appData), forKeyword: keyAEContainer)
        desc.setDescriptor(self.wantType, forKeyword: keyAEDesiredClass)
        desc.setDescriptor(self.selectorForm, forKeyword: keyAEKeyForm)
        desc.setDescriptor(try self.appData.pack(self.selectorData), forKeyword: keyAEKeyData)
        return desc
    }
        
    // Containment test constructors
    // TO DO: ideally the following should only appear on objects constructed from an Its root; however, this will make the class/protocol hierarchy more complicated, so may be more hassle than it's worth - maybe explore this later, once the current implementation is fully working
    
    func beginsWith(_ value: Any) -> TestClause {
        return ComparisonTest(operatorType: gBeginsWith, operand1: self, operand2: value, appData: self.appData, cachedDesc: nil)
    }
    func endsWith(_ value: Any) -> TestClause {
        return ComparisonTest(operatorType: gEndsWith, operand1: self, operand2: value, appData: self.appData, cachedDesc: nil)
    }
    func contains(_ value: Any) -> TestClause {
        return ComparisonTest(operatorType: gContains, operand1: self, operand2: value, appData: self.appData, cachedDesc: nil)
    }
    func isIn(_ value: Any) -> TestClause {
        return ComparisonTest(operatorType: gIsIn, operand1: self, operand2: value, appData: self.appData, cachedDesc: nil)
    }
}


// Comparison test constructors

func <(lhs: ObjectSpecifier, rhs: Any) -> TestClause {
    return ComparisonTest(operatorType: gLT, operand1: lhs, operand2: rhs, appData: lhs.appData, cachedDesc: nil)
}
func <=(lhs: ObjectSpecifier, rhs: Any) -> TestClause {
    return ComparisonTest(operatorType: gLE, operand1: lhs, operand2: rhs, appData: lhs.appData, cachedDesc: nil)
}
func ==(lhs: ObjectSpecifier, rhs: Any) -> TestClause {
    return ComparisonTest(operatorType: gEQ, operand1: lhs, operand2: rhs, appData: lhs.appData, cachedDesc: nil)
}
func !=(lhs: ObjectSpecifier, rhs: Any) -> TestClause {
    return ComparisonTest(operatorType: gNE, operand1: lhs, operand2: rhs, appData: lhs.appData, cachedDesc: nil)
}
func >(lhs: ObjectSpecifier, rhs: Any) -> TestClause {
    return ComparisonTest(operatorType: gGT, operand1: lhs, operand2: rhs, appData: lhs.appData, cachedDesc: nil)
}
func >=(lhs: ObjectSpecifier, rhs: Any) -> TestClause {
    return ComparisonTest(operatorType: gGE, operand1: lhs, operand2: rhs, appData: lhs.appData, cachedDesc: nil)
}


/******************************************************************************/
// Multi-element specifiers; represents a one-to-many relationship between nodes in the app's AEOM graph

// note: each glue should define an Elements class that subclasses ObjectSpecifier and adopts ElementsSpecifierExtension (which adds by range/test/all selectors)


public struct RangeSelector: SelfPacking { // holds data for by-range selectors // TO DO: does this need to be public?
    // Start and stop are Con-based (i.e. relative to container) specifiers (App-based specifiers will also work, as 
    // long as they have the same parent specifier as the by-range specifier itself). For convenience, users can also
    // pass non-specifier values (typically Strings and Ints) to represent simple by-name and by-index specifiers of
    // the same element class; these will be converted to specifiers automatically when packed.
    let start: Any
    let stop: Any
    let wantType: NSAppleEventDescriptor
    
    private func packSelector(_ selectorData: Any, appData: AppData) throws -> NSAppleEventDescriptor {
        var selectorForm: NSAppleEventDescriptor
        switch selectorData {
        case is NSAppleEventDescriptor:
            return selectorData as! NSAppleEventDescriptor
        case is Specifier: // technically, only ObjectSpecifier makes sense here, tho AS prob. doesn't prevent insertion loc or multi-element specifier being passed instead
            return try (selectorData as! Specifier).packSelf(appData)
        default: // pack anything else as a by-name or by-index specifier
            selectorForm = selectorData is String ? gNameForm : gAbsolutePositionForm
            let desc = NSAppleEventDescriptor.record().coerce(toDescriptorType: typeObjectSpecifier)!
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
        guard let startDesc = desc.forKeyword(keyAERangeStart), let stopDesc = desc.forKeyword(keyAERangeStop) else {
            throw UnpackError(appData: appData, descriptor: desc, type: RangeSelector.self, message: "Missing start/stop specifier in by-range specifier.")
        }
        do {
            self.start = try appData.unpack(startDesc)
            self.stop = try appData.unpack(stopDesc)
            self.wantType = NSAppleEventDescriptor(typeCode: typeType) // TO DO: wantType is incorrect; in principle this shouldn't matter as start and stop descs _should_ always be object specifiers, but paranoia is best; will need to rethink as it can't be reliably inferred here (since range desc should only appear in by-range object specifier desc, might be simplest just to unpack it directly from there instead of AppData)
        } catch {
            throw UnpackError(appData: appData, descriptor: desc, type: RangeSelector.self, message: "Failed to unpack start/stop specifier in by-range specifier.") // TO DO: or just return RangeSelector containing the original AEDescs?
        }
    }
    
    public func packSelf(_ appData: AppData) throws -> NSAppleEventDescriptor {
        // note: the returned desc will be cached by the ElementsSpecifier, so no need to cache it here
        let desc = NSAppleEventDescriptor.record().coerce(toDescriptorType: typeRangeDescriptor)!
        desc.setDescriptor(try self.packSelector(self.start, appData: appData), forKeyword: keyAERangeStart)
        desc.setDescriptor(try self.packSelector(self.stop, appData: appData), forKeyword: keyAERangeStop)
        return desc
    }
}


/******************************************************************************/
// Test clause; used in by-test specifiers

// note: glues don't define their own TestClause subclasses as tests don't implement any app-specific vars/methods, only the logical operators defined below, and there's little point doing so for static typechecking purposes as any values not handled by ElementsSpecifierExtension's subscript(test:TestClause) are accepted by its subscript(index:Any), so still wouldn't be caught at runtime (OTOH, it'd be worth considering should subscript(test:) need to be replaced with a separate byTest() method for any reason)


// TO DO: currently, TestClauses can be constructed from any root, though only those constructed from Its roots are actually valid; checking this at compile-time would require a more complex class/protocol structure; checking this at runtime would require calling Selector.rootSpecifier.rootObject and checking object is 'its' descriptor

public class TestClause: Selector { // AND, OR, and NOT are implemented as &&, ||, and ! operator overrides
    // TO DO: AND and OR could also be implemented as vararg funcs, but am inclined just to stick to two-arg operators and chain those when unpacking if >2
}

public class ComparisonTest: TestClause {
    
    public let operatorType: NSAppleEventDescriptor, operand1: ObjectSpecifier, operand2: Any
    
    init(operatorType: NSAppleEventDescriptor, operand1: ObjectSpecifier, operand2: Any,
            appData: AppData, cachedDesc: NSAppleEventDescriptor?) {
        self.operatorType = operatorType
        self.operand1 = operand1
        self.operand2 = operand2
        super.init(appData: appData, cachedDesc: cachedDesc)
    }
    
    private override func packSelf() throws -> NSAppleEventDescriptor {
        if self.operatorType === gNE { // AEM doesn't support a 'kAENotEqual' enum...
            return try (!(self.operand1 == self.operand2)).packSelf(self.appData) // so convert to kAEEquals+kAENOT
        } else {
            let desc = NSAppleEventDescriptor.record().coerce(toDescriptorType: typeCompDescriptor)!
            let opDesc1 = try self.appData.pack(self.operand1)
            let opDesc2 = try self.appData.pack(self.operand2)
            if self.operatorType === gIsIn { // AEM doesn't support a 'kAEIsIn' enum...
                desc.setDescriptor(gContains, forKeyword: keyAECompOperator) // so use kAEContains with operands reversed
                desc.setDescriptor(opDesc2, forKeyword: keyAEObject1)
                desc.setDescriptor(opDesc1, forKeyword: keyAEObject2)
            } else {
                desc.setDescriptor(self.operatorType, forKeyword: keyAECompOperator)
                desc.setDescriptor(opDesc1, forKeyword: keyAEObject1)
                desc.setDescriptor(opDesc2, forKeyword: keyAEObject2)
            }
            return desc
        }
    }
    
    public override var parentSelector: Selector {
        return self.operand1
    }
    
    public override var rootSpecifier: RootSpecifier {
        return self.operand1.rootSpecifier
    }
}

public class LogicalTest: TestClause {
    
    public let operatorType: NSAppleEventDescriptor, operands: [TestClause] // note: this doesn't have a 'parent' as such; to walk chain, just use first operand
    
    init(operatorType: NSAppleEventDescriptor, operands: [TestClause], appData: AppData, cachedDesc: NSAppleEventDescriptor?) {
        self.operatorType = operatorType
        self.operands = operands
        super.init(appData: appData, cachedDesc: cachedDesc)
    }
    
    private override func packSelf() throws -> NSAppleEventDescriptor {
        let desc = NSAppleEventDescriptor.record().coerce(toDescriptorType: typeLogicalDescriptor)!
        let opDesc = try self.appData.pack(self.operands)
        desc.setDescriptor(self.operatorType, forKeyword: keyAELogicalOperator)
        desc.setDescriptor(opDesc, forKeyword: keyAELogicalTerms)
        return desc
    }
    
    public override var rootSpecifier: RootSpecifier {
        return self.operands[0].rootSpecifier
    }
}


// Logical test constructors

func &&(lhs: TestClause, rhs: TestClause) -> TestClause {
    return LogicalTest(operatorType: gAND, operands: [lhs, rhs], appData: lhs.appData, cachedDesc: nil)
}
func ||(lhs: TestClause, rhs: TestClause) -> TestClause {
    return LogicalTest(operatorType: gOR, operands: [lhs, rhs], appData: lhs.appData, cachedDesc: nil)
}
prefix func !(lhs: TestClause) -> TestClause {
    return LogicalTest(operatorType: gNOT, operands: [lhs], appData: lhs.appData, cachedDesc: nil)
}



/******************************************************************************/
// Specifier roots (all Specifier chains must be terminated by one of these)

// note: app glues will also define their own generic App, Con, and Its roots

public class RootSpecifier: ObjectSpecifier { // app, con, its, custom root (note: this is a bit sloppy; `con` based specifiers are only for use in by-range selectors, and only `its` based specifiers should support comparison and logic tests; only targeted absolute (app-based/customroot-based) specifiers should implement commands, although single `app` root doesn't distinguish untargeted from targeted since that's determined by absence/presence of AppData object)
    
    public required init(rootObject: Any, appData: AppData) {
        // rootObject is either one of the three standard AEDescs indicating app/con/its root, or an arbitrary object supplied by caller (e.g. an AEAddressDesc if constructing a fully qualified specifier)
        super.init(wantType: NSAppleEventDescriptor.null(),
                   selectorForm: NSAppleEventDescriptor.null(), selectorData: rootObject,
                   parentSelector: nil, appData: appData, cachedDesc: rootObject as? NSAppleEventDescriptor)
    }

    public required init(wantType: NSAppleEventDescriptor, selectorForm: NSAppleEventDescriptor, selectorData: Any, parentSelector: Selector?, appData: AppData, cachedDesc: NSAppleEventDescriptor?) {
        super.init(wantType: wantType, selectorForm: selectorForm, selectorData: selectorData, parentSelector: parentSelector, appData: appData, cachedDesc: cachedDesc)
        
    }
    
    public override func packSelf() throws -> NSAppleEventDescriptor {
        return try self.appData.pack(self.selectorData)
    }
    
    // glue-defined root classes must override the following to return their own untargeted AppData instance
    class var untargetedAppData: AppData { return gUntargetedAppData }


    // TO DO: subclassing ObjectSpecifier is slightly risky, since accidental recursion in the following does very bad things, so it's essential that all Selector/Specifier/ObjectSpecifier methods that operate on parent specifier are overridden here:
    
    override public var parentSelector: Selector { return self }
    
    override public var rootSpecifier: RootSpecifier { return self }
    
    public var rootObject: Any { return self.selectorData } // the objspec chain's terminal 'from' object; this is usually AppRootDesc/ConRootDesc/ItsRootDesc, but not always (e.g. 'fully qualified' specifiers are terminated by an AEAddressDesc)
    
    private override func unpackParentSpecifiers() {}
}


/******************************************************************************/
// constants


let gPropertyType = NSAppleEventDescriptor(typeCode: typeProperty)
// selector forms
let gPropertyForm           = NSAppleEventDescriptor(enumCode: formPropertyID) // specifier.NAME or specifier.property(CODE)
let gUserPropertyForm       = NSAppleEventDescriptor(enumCode: formUserPropertyID) // specifier.userProperty(NAME)
let gAbsolutePositionForm   = NSAppleEventDescriptor(enumCode: formAbsolutePosition) // specifier[IDX] or specifier.first/middle/last/any
let gNameForm               = NSAppleEventDescriptor(enumCode: formName) // specifier[NAME] or specifier.named(NAME)
let gUniqueIDForm           = NSAppleEventDescriptor(enumCode: formUniqueID) // specifier.ID(UID)
let gRelativePositionForm   = NSAppleEventDescriptor(enumCode: formRelativePosition) // specifier.before/after(SYMBOL)
let gRangeForm              = NSAppleEventDescriptor(enumCode: formRange) // specifier[FROM,TO]
let gTestForm               = NSAppleEventDescriptor(enumCode: formTest) // specifier[TEST]
// insertion locations
let gBeginning  = NSAppleEventDescriptor(enumCode: kAEBeginning)
let gEnd        = NSAppleEventDescriptor(enumCode: kAEEnd)
let gBefore     = NSAppleEventDescriptor(enumCode: kAEBefore)
let gAfter      = NSAppleEventDescriptor(enumCode: kAEAfter)
// absolute positions
let gFirst  = FourCharCodeDescriptor(typeAbsoluteOrdinal, kAEFirst)
let gMiddle = FourCharCodeDescriptor(typeAbsoluteOrdinal, kAEMiddle)
let gLast   = FourCharCodeDescriptor(typeAbsoluteOrdinal, kAELast)
let gAny    = FourCharCodeDescriptor(typeAbsoluteOrdinal, kAEAny)
let gAll    = FourCharCodeDescriptor(typeAbsoluteOrdinal, kAEAll)
// relative positions
let gPrevious   = NSAppleEventDescriptor(enumCode: kAEPrevious)
let gNext       = NSAppleEventDescriptor(enumCode: kAENext)

// AEM doesn't define '!=' or 'in' operators, so define 'temp' codes to represent these
let kSAENotEquals: OSType = 0x00000001
let kSAEIsIn: OSType = 0x00000002

// comparison tests
let gLT = NSAppleEventDescriptor(enumCode: kAELessThan)
let gLE = NSAppleEventDescriptor(enumCode: kAELessThanEquals)
let gEQ = NSAppleEventDescriptor(enumCode: kAEEquals)
let gNE = NSAppleEventDescriptor(enumCode: kSAENotEquals) // pack as !(op1==op2)
let gGT = NSAppleEventDescriptor(enumCode: kAEGreaterThan)
let gGE = NSAppleEventDescriptor(enumCode: kAEGreaterThanEquals)
// containment tests
let gBeginsWith = NSAppleEventDescriptor(enumCode: kAEBeginsWith)
let gEndsWith   = NSAppleEventDescriptor(enumCode: kAEEndsWith)
let gContains   = NSAppleEventDescriptor(enumCode: kAEContains)
let gIsIn       = NSAppleEventDescriptor(enumCode: kSAEIsIn) // pack d as op2.contains(op1)
// logic tests
let gAND = NSAppleEventDescriptor(enumCode: kAEAND)
let gOR  = NSAppleEventDescriptor(enumCode: kAEOR)
let gNOT = NSAppleEventDescriptor(enumCode: kAENOT)



