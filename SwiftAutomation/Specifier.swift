//
//  Specifier.swift
//  SwiftAutomation
//
//
//  Base classes for constructing AE queries
//
//  Notes: 
//
//  An AE query is represented as a linked list of AEDescs, primarily AERecordDescs of typeObjectSpecifier. Each object specifier record has four properties:
//
//      'want' -- the type of element to identify (or 'prop' when identifying a property)
//      'form', 'seld' -- the reference form and selector data identifying the element(s) or property
//      'from' -- the parent descriptor in the linked list
//
//    For example:
//
//      name of document "ReadMe" [of application "TextEdit"]
//
//    is represented by the following chain of AEDescs:
//
//      {want:'prop', form:'prop', seld:'pnam', from:{want:'docu', form:'name', seld:"ReadMe", from:null}}
//
//    Additional AERecord types (typeInsertionLocation, typeRangeDescriptor, typeCompDescriptor, typeLogicalDescriptor) are also used to construct specialized query forms describing insertion points before/after existing elements, element ranges, and test clauses.
//
//    Atomic AEDescs of typeNull, typeCurrentContainer, and typeObjectBeingExamined are used to terminate the linked list.
//
//
//  [TO DO: developer notes on Apple event query forms and Apple Event Object Model's relational object graphs (objects with attributes, one-to-one relationships, and one-to-many relationships); aka "AE IPC is simple first-class relational queries, not OOP"]
//
//
//  Specifier.swift defines the base classes from which concrete Specifier classes representing each major query form are constructed. These base classes combine with various SpecifierExtensions (which provide by-index, by-name, etc selectors and Application object constructors) and glue-defined Query and Command extensions (which provide property and all-elements selectors, and commands) to form the following concrete classes:
//
//    CLASS                 DESCRIPTION                         CAN CONSTRUCT
//
//    Query                 [base class]
//     ├─PREFIXInsertion    insertion location specifier        ├─commands
//     └─PREFIXObject       [object specifier base protocol]    └─commands, and property and all-elements specifiers
//        ├─PREFIXItem         single-object specifier             ├─previous/next selectors
//        │  └─PREFIXItems     multi-object specifier              │  └─by-index/name/id/ordinal/range/test selectors
//        └─PREFIXRoot         App/Con/Its (untargeted roots)      ├─[1]
//           └─APPLICATION     Application (app-targeted root)     └─initializers
//
//
//    (The above diagram fudges the exact inheritance hierarchy for illustrative purposes. Commands are actually provided by a PREFIXCommand protocol [not shown], which is adopted by APPLICATION and all PREFIX classes except PREFIXRoot [1] - which cannot construct working commands as it has no target information, so omits these methods for clarity. Strictly speaking, the only class which should implement commands is APPLICATION, as Apple event IPC is based on Remote *Procedure* Calls, not OOP; however, they also appear on specifier classes as a convenient shorthand when writing commands whose direct parameter is a specifier. Note that while all specifier classes provide command methods [including those used to construct relative-specifiers in by-range and by-test clauses, as omitting commands from these is more trouble than its worth] they will automatically throw if their root is an untargeted App/Con/Its object.)
//
//    The following classes are also defined for use with Its-based object specifiers in by-test selectors.
//
//    Query
//     └─TestClause         [test clause base class]
//        ├─ComparisonTest     comparison/containment test
//        └─LogicalTest        Boolean logic test
//
//
//    Except for APPLICATION, users do not instantiate any of these classes directly, but instead by chained property/method calls on existing Query instances.
//

import Foundation
import AppKit

// TO DO: underscore/prefix non-public properties and methods to reduce risk of terminology clashes 

// TO DO: make sure KeywordConverter lists _all_ Specifier members

// TO DO: debugDescription that displays raw FCC representation?


/******************************************************************************/
// abstract base class for _all_ specifier and test clause subclasses


open class Query: CustomStringConvertible, SelfPacking { // TO DO: Equatable? (TBH, comparing and hashing Query objects would be of limited use; not sure it's worth the effort as, ultimately, only the target app can know if two queries identify the same object or not)
    
    public let appData: AppData
    internal private(set) var cachedDesc: NSAppleEventDescriptor?
    
    init(appData: AppData, cachedDesc: NSAppleEventDescriptor?) { // cachedDesc is supplied on unpacking
        self.appData = appData
        self.cachedDesc = cachedDesc
    }
    
    // unpacking
    
    func unpackParentSpecifiers() {} // ObjectSpecifier overrides this to recursively unpack its 'from' desc only when needed
    
    // packing
    
    public func SwiftAutomation_packSelf(_ appData: AppData) throws -> NSAppleEventDescriptor {
        if self.cachedDesc == nil {
            self.cachedDesc = try self.SwiftAutomation_packSelf()
        }
        return self.cachedDesc!
    }
    
    func SwiftAutomation_packSelf() throws -> NSAppleEventDescriptor { // subclasses must override this to pack themselves
        fatalError("Query.SwiftAutomation_packSelf() must be overridden by subclasses.")
    }
    
    // misc
    
    // note that parentQuery and rootSpecifier properties are really only intended for internal use when traversing a specifier chain; while there is nothing to prevent client code using these properties the results are not guaranteed to be valid or usable queries (once constructed, object specifiers should be treated as opaque values); the proper way to identify an object's (or objects') container is to ask the application to return a specifier (or list of specifiers) to its `container` property, if it has one, e.g. `let parentFolder:FinItem = someFinderItem.container.get()`
    
    // return the next ObjectSpecifier/TestClause in query chain
    var parentQuery: Query { // subclasses must override this
        fatalError("Query.parentQuery must be overridden by subclasses.")
    }
    
    public var rootSpecifier: RootSpecifier { // subclasses must override this
        fatalError("Query.rootSpecifier must be overridden by subclasses.")
    }
    
    public var description: String { return self.appData.formatter.format(self) }
}


/******************************************************************************/
// abstract base class for all object and insertion specifiers
// app-specific glues should subclass this and add command methods via protocol extension (mixin) to it and all of its subclasses too

// TO DO: is it practical to prevent commands appearing on untargeted specifiers? (it ought to be doable as long as subclasses and mixins can provide the right class hooks; the main issue is how crazy mad the typing gets)


public protocol SpecifierProtocol { // glue-defined Command extensions, and by ObjectSpecifierProtocol
    var appData: AppData {get}
    var parentQuery: Query {get}
    var rootSpecifier: RootSpecifier {get}
}

open class Specifier: Query, SpecifierProtocol {

    // An object specifier is constructed as a linked list of AERecords of typeObjectSpecifier, terminated by a root descriptor (e.g. a null descriptor represents the root node of the app's Apple event object graph). The topmost node may also be an insertion location specifier, represented by an AERecord of typeInsertionLoc. The abstract Specifier class implements functionality common to both object and insertion specifiers.
    
    private var _parentQuery: Query? // note: object specifiers are lazily unpacked for efficiency, so this is nil if Specifier hasn't been fully unpacked yet (or if class is RootSpecifier, in which case it's unused)

    public init(parentQuery: Query?, appData: AppData, cachedDesc: NSAppleEventDescriptor?) {
        self._parentQuery = parentQuery
        super.init(appData: appData, cachedDesc: cachedDesc)
    }
    
    public override var parentQuery: Query { // 'from' in object specifier, or 'kobj' in insertion specifier
        if self._parentQuery == nil {
            self.unpackParentSpecifiers()
        }
        return self._parentQuery!
    }
    
    public override var rootSpecifier: RootSpecifier { return self.parentQuery.rootSpecifier }
    
    // unpacking
    
    override func unpackParentSpecifiers() {
        guard let cachedDesc = self.cachedDesc else { // TO DO: convert this sanity check to assert?
            print("Can't unpack parent specifiers as cached descriptor don't exist (this isn't supposed to happen).") // TO DO: DEBUG; delete
            self._parentQuery = RootSpecifier(rootObject: SwiftAutomationError(code: 1, message: "Can't unpack parent specifiers as cached AppData and/or AEDesc don't exist (this isn't supposed to happen)."), appData: self.appData) // TO DO: implement ErrorSpecifier subclass that takes error info and always raises on use
            return
        }
        do {
            let parentDesc = cachedDesc.forKeyword(SwiftAutomation_keyAEContainer)!
            self._parentQuery = try appData.unpack(parentDesc) as Specifier
            self._parentQuery!.unpackParentSpecifiers()
        } catch {
            print("Deferred unpack parent specifier failed: \(error)") // TO DO: DEBUG; delete
            self._parentQuery = RootSpecifier(rootObject: (cachedDesc.forKeyword(SwiftAutomation_keyAEContainer))!, appData: self.appData) // TO DO: store error in RootSpecifier and raise it on packing
        }
    }
    
    // convenience methods for sending Apple events using four-char codes (either OSTypes or Strings)
    
    public func sendAppleEvent<T>(_ eventClass: OSType, _ eventID: OSType, _ parameters: [OSType:Any] = [:],
                                  waitReply: Bool = true, sendOptions: NSAppleEventDescriptor.SendOptions? = nil,
                                  withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(eventClass: eventClass, eventID: eventID,
                                               parentSpecifier: self, parameters: parameters, waitReply: waitReply,
                                               sendOptions: sendOptions, withTimeout: withTimeout, considering: considering)
    }
    
    public func sendAppleEvent<T>(_ eventClass: String, _ eventID: String, _ parameters: [String:Any] = [:],
                                  waitReply: Bool = true, sendOptions: NSAppleEventDescriptor.SendOptions? = nil,
                                  withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        var params = [OSType:Any]()
        for (k, v) in parameters { params[FourCharCodeUnsafe(k)] = v } // TO DO: use safe FCC converters? (the problem is that while sendAppleEvent() can throw, property() and elements() cannot, so throwing on one but not the other would be inconsistent; the only alternative is for property() and elements() to construct an invalid Specifier instance that capture the exception, e.g. one with an AppData subclass whose sendAppleEvent methods _always_ throw the captured exception when called, but given that four-char-code strings are only intended for low-level users who know what they're doing it's arguable that this is more effort than it's worth and it's simplest just to leave the user to ensure their four-char-code strings are correctly formed and catch and correct any invalid ones in their own testing)
        return try self.appData.sendAppleEvent(eventClass: FourCharCodeUnsafe(eventClass), eventID: FourCharCodeUnsafe(eventID),
                                               parentSpecifier: self, parameters: params, waitReply: waitReply,
                                               sendOptions: sendOptions, withTimeout: withTimeout, considering: considering)
    }
    
    // non-generic versions of the above methods; these are bound when T can't be inferred (either because caller doesn't use the return value or didn't declare a specific type for it, e.g. `let result = cmd.call()`), in which case Any is used
    
    @discardableResult public func sendAppleEvent(_ eventClass: OSType, _ eventID: OSType, _ parameters: [OSType:Any] = [:],
                                                  waitReply: Bool = true, sendOptions: NSAppleEventDescriptor.SendOptions? = nil,
                                                  withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(eventClass: eventClass, eventID: eventID,
                                               parentSpecifier: self, parameters: parameters, waitReply: waitReply,
                                               sendOptions: sendOptions, withTimeout: withTimeout, considering: considering)
    }
    
    @discardableResult public func sendAppleEvent(_ eventClass: String, _ eventID: String, _ parameters: [String:Any] = [:],
                                                  waitReply: Bool = true, sendOptions: NSAppleEventDescriptor.SendOptions? = nil,
                                                  withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        var params = [OSType:Any]()
        for (k, v) in parameters { params[FourCharCodeUnsafe(k)] = v } // TO DO: use safe FCC converters?
        return try self.appData.sendAppleEvent(eventClass: FourCharCodeUnsafe(eventClass), eventID: FourCharCodeUnsafe(eventID),
                                               parentSpecifier: self, parameters: params, waitReply: waitReply,
                                               sendOptions: sendOptions, withTimeout: withTimeout, considering: considering)
    }
}


/******************************************************************************/
// insertion location specifier

open class InsertionSpecifier: Specifier { // SwiftAutomation_packSelf
    
    // 'insl'
    public let insertionLocation: NSAppleEventDescriptor

    required public init(insertionLocation: NSAppleEventDescriptor,
                parentQuery: Query?, appData: AppData, cachedDesc: NSAppleEventDescriptor?) {
        self.insertionLocation = insertionLocation
        super.init(parentQuery: parentQuery, appData: appData, cachedDesc: cachedDesc)
    }
    
    override func SwiftAutomation_packSelf() throws -> NSAppleEventDescriptor {
        let desc = NSAppleEventDescriptor.record().coerce(toDescriptorType: typeInsertionLoc)!
        desc.setDescriptor(try self.parentQuery.SwiftAutomation_packSelf(self.appData), forKeyword: keyAEObject)
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

open class ObjectSpecifier: Specifier, ObjectSpecifierProtocol { // represents property or single element specifier; adds property+elements vars, relative selectors, insertion specifiers
    
    // 'want', 'form', 'data'
    public let wantType: NSAppleEventDescriptor
    public let selectorForm: NSAppleEventDescriptor
    public let selectorData: Any
    
    // TO DO: ideally want a wantName:String? arg that takes human-readable name, if available, for display purposes (see also previous/next)
    
    required public init(wantType: NSAppleEventDescriptor, selectorForm: NSAppleEventDescriptor, selectorData: Any,
            parentQuery: Query?, appData: AppData, cachedDesc: NSAppleEventDescriptor?) {
        self.wantType = wantType
        self.selectorForm = selectorForm
        self.selectorData = selectorData
        super.init(parentQuery: parentQuery, appData: appData, cachedDesc: cachedDesc)
    }
    
    override func SwiftAutomation_packSelf() throws -> NSAppleEventDescriptor {
        let desc = NSAppleEventDescriptor.record().coerce(toDescriptorType: typeObjectSpecifier)!
        desc.setDescriptor(try self.parentQuery.SwiftAutomation_packSelf(self.appData), forKeyword: SwiftAutomation_keyAEContainer)
        desc.setDescriptor(self.wantType, forKeyword: SwiftAutomation_keyAEDesiredClass)
        desc.setDescriptor(self.selectorForm, forKeyword: SwiftAutomation_keyAEKeyForm)
        desc.setDescriptor(try self.appData.pack(self.selectorData), forKeyword: SwiftAutomation_keyAEKeyData)
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
            return try (selectorData as! Specifier).SwiftAutomation_packSelf(appData)
        default: // pack anything else as a by-name or by-index specifier
            selectorForm = selectorData is String ? gNameForm : gAbsolutePositionForm
            let desc = NSAppleEventDescriptor.record().coerce(toDescriptorType: typeObjectSpecifier)!
            desc.setDescriptor(ConRootDesc, forKeyword: SwiftAutomation_keyAEContainer)
            desc.setDescriptor(self.wantType, forKeyword: SwiftAutomation_keyAEDesiredClass)
            desc.setDescriptor(selectorForm, forKeyword: SwiftAutomation_keyAEKeyForm)
            desc.setDescriptor(try appData.pack(selectorData), forKeyword: SwiftAutomation_keyAEKeyData)
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
            self.start = try appData.unpackAny(startDesc)
            self.stop = try appData.unpackAny(stopDesc)
            self.wantType = NSAppleEventDescriptor(typeCode: typeType) // TO DO: wantType is incorrect; in principle this shouldn't matter as start and stop descs _should_ always be object specifiers, but paranoia is best; will need to rethink as it can't be reliably inferred here (since range desc should only appear in by-range object specifier desc, might be simplest just to unpack it directly from there instead of AppData)
        } catch {
            throw UnpackError(appData: appData, descriptor: desc, type: RangeSelector.self, message: "Failed to unpack start/stop specifier in by-range specifier.") // TO DO: or just return RangeSelector containing the original AEDescs?
        }
    }
    
    public func SwiftAutomation_packSelf(_ appData: AppData) throws -> NSAppleEventDescriptor {
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


// note: only TestClauses constructed from Its roots are actually valid; however, enfording this at compile-time would require a more complex class/protocol structure, while checking this at runtime would require calling Query.rootSpecifier.rootObject and checking object is 'its' descriptor. As it's highly unlikely users will use an App or Con root by accident, we'll live recklessly and let the gods of AppleScript punish any user foolish enough to do so.

public class TestClause: Query {
    
    // Logical test constructors
    
    public static func &&(lhs: TestClause, rhs: TestClause) -> TestClause {
        return LogicalTest(operatorType: gAND, operands: [lhs, rhs], appData: lhs.appData, cachedDesc: nil)
    }
    public static func ||(lhs: TestClause, rhs: TestClause) -> TestClause {
        return LogicalTest(operatorType: gOR, operands: [lhs, rhs], appData: lhs.appData, cachedDesc: nil)
    }
    public static prefix func !(lhs: TestClause) -> TestClause {
        return LogicalTest(operatorType: gNOT, operands: [lhs], appData: lhs.appData, cachedDesc: nil)
    }
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
    
    override func SwiftAutomation_packSelf() throws -> NSAppleEventDescriptor {
        if self.operatorType === gNE { // AEM doesn't support a 'kAENotEqual' enum...
            return try (!(self.operand1 == self.operand2)).SwiftAutomation_packSelf(self.appData) // so convert to kAEEquals+kAENOT
        } else {
            let desc = NSAppleEventDescriptor.record().coerce(toDescriptorType: typeCompDescriptor)!
            let opDesc1 = try self.appData.pack(self.operand1)
            let opDesc2 = try self.appData.pack(self.operand2)
            if self.operatorType === gIsIn { // AEM doesn't support a 'kAEIsIn' enum...
                desc.setDescriptor(gContains, forKeyword: SwiftAutomation_keyAECompOperator) // so use kAEContains with operands reversed
                desc.setDescriptor(opDesc2, forKeyword: SwiftAutomation_keyAEObject1)
                desc.setDescriptor(opDesc1, forKeyword: SwiftAutomation_keyAEObject2)
            } else {
                desc.setDescriptor(self.operatorType, forKeyword: SwiftAutomation_keyAECompOperator)
                desc.setDescriptor(opDesc1, forKeyword: SwiftAutomation_keyAEObject1)
                desc.setDescriptor(opDesc2, forKeyword: SwiftAutomation_keyAEObject2)
            }
            return desc
        }
    }
    
    public override var parentQuery: Query {
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
    
    override func SwiftAutomation_packSelf() throws -> NSAppleEventDescriptor {
        let desc = NSAppleEventDescriptor.record().coerce(toDescriptorType: typeLogicalDescriptor)!
        let opDesc = try self.appData.pack(self.operands)
        desc.setDescriptor(self.operatorType, forKeyword: SwiftAutomation_keyAELogicalOperator)
        desc.setDescriptor(opDesc, forKeyword: SwiftAutomation_keyAELogicalTerms)
        return desc
    }
    
    public override var rootSpecifier: RootSpecifier {
        return self.operands[0].rootSpecifier
    }
}



/******************************************************************************/
// Specifier roots (all Specifier chains must originate from a RootSpecifier instance)

// note: app glues will also define their own untargeted App, Con, and Its roots

open class RootSpecifier: ObjectSpecifier { // app, con, its, custom root (note: this is a bit sloppy; `con` based specifiers are only for use in by-range selectors, and only `its` based specifiers should support comparison and logic tests; only targeted absolute (app-based/customroot-based) specifiers should implement commands, although single `app` root doesn't distinguish untargeted from targeted since that's determined by absence/presence of AppData object)
    
    public required init(rootObject: Any, appData: AppData) {
        // rootObject is either one of the three standard AEDescs indicating app/con/its root, or an arbitrary object supplied by caller (e.g. an AEAddressDesc if constructing a fully qualified specifier)
        super.init(wantType: NSAppleEventDescriptor.null(), // wantType and selectorForm are unused here
                   selectorForm: NSAppleEventDescriptor.null(), selectorData: rootObject,
                   parentQuery: nil, appData: appData, cachedDesc: rootObject as? NSAppleEventDescriptor)
    }

    public required init(wantType: NSAppleEventDescriptor, selectorForm: NSAppleEventDescriptor,
                         selectorData: Any, parentQuery: Query?, appData: AppData, cachedDesc: NSAppleEventDescriptor?) {
        super.init(wantType: wantType, selectorForm: selectorForm,
                   selectorData: selectorData, parentQuery: parentQuery, appData: appData, cachedDesc: cachedDesc)
        
    }
    
    public override func SwiftAutomation_packSelf() throws -> NSAppleEventDescriptor {
        return try self.appData.pack(self.selectorData)
    }


    // Query/Specifier/ObjectSpecifier-inherited properties and methods that recursively call their parent specifiers are overridden here to ensure they terminate:
    
    override public var parentQuery: Query { return self }
    
    override public var rootSpecifier: RootSpecifier { return self }
    
    public var rootObject: Any { return self.selectorData } // the objspec chain's terminal 'from' object; this is usually AppRootDesc/ConRootDesc/ItsRootDesc, but not always (e.g. 'fully qualified' specifiers are terminated by an AEAddressDesc)
    
    override func unpackParentSpecifiers() {}
    
    
    // glue-defined root classes must override `untargetedAppData` to return their own untargeted AppData instance
    
    open class var untargetedAppData: AppData { fatalError("RootSpecifier.untargetedAppData must be overridden by subclasses.") }
}


/******************************************************************************/
// constants


// TO DO: fix naming convention, e.g. `propertyTypeDesc`


let gPropertyType = NSAppleEventDescriptor(typeCode: typeProperty)
// selector forms
let gPropertyForm           = NSAppleEventDescriptor(enumCode: SwiftAutomation_formPropertyID) // specifier.NAME or specifier.property(CODE)
let gUserPropertyForm       = NSAppleEventDescriptor(enumCode: SwiftAutomation_formUserPropertyID) // specifier.userProperty(NAME)
let gAbsolutePositionForm   = NSAppleEventDescriptor(enumCode: SwiftAutomation_formAbsolutePosition) // specifier[IDX] or specifier.first/middle/last/any
let gNameForm               = NSAppleEventDescriptor(enumCode: SwiftAutomation_formName) // specifier[NAME] or specifier.named(NAME)
let gUniqueIDForm           = NSAppleEventDescriptor(enumCode: SwiftAutomation_formUniqueID) // specifier.ID(UID)
let gRelativePositionForm   = NSAppleEventDescriptor(enumCode: SwiftAutomation_formRelativePosition) // specifier.before/after(SYMBOL)
let gRangeForm              = NSAppleEventDescriptor(enumCode: SwiftAutomation_formRange) // specifier[FROM,TO]
let gTestForm               = NSAppleEventDescriptor(enumCode: SwiftAutomation_formTest) // specifier[TEST]
// insertion locations
let gBeginning  = NSAppleEventDescriptor(enumCode: kAEBeginning)
let gEnd        = NSAppleEventDescriptor(enumCode: kAEEnd)
let gBefore     = NSAppleEventDescriptor(enumCode: kAEBefore)
let gAfter      = NSAppleEventDescriptor(enumCode: kAEAfter)
// absolute positions
let gFirst  = FourCharCodeDescriptor(typeAbsoluteOrdinal, SwiftAutomation_kAEFirst)
let gMiddle = FourCharCodeDescriptor(typeAbsoluteOrdinal, SwiftAutomation_kAEMiddle)
let gLast   = FourCharCodeDescriptor(typeAbsoluteOrdinal, SwiftAutomation_kAELast)
let gAny    = FourCharCodeDescriptor(typeAbsoluteOrdinal, SwiftAutomation_kAEAny)
let gAll    = FourCharCodeDescriptor(typeAbsoluteOrdinal, SwiftAutomation_kAEAll)
// relative positions
let gPrevious   = NSAppleEventDescriptor(enumCode: SwiftAutomation_kAEPrevious)
let gNext       = NSAppleEventDescriptor(enumCode: SwiftAutomation_kAENext)

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
let gAND = NSAppleEventDescriptor(enumCode: SwiftAutomation_kAEAND)
let gOR  = NSAppleEventDescriptor(enumCode: SwiftAutomation_kAEOR)
let gNOT = NSAppleEventDescriptor(enumCode: SwiftAutomation_kAENOT)



