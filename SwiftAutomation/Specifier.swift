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

import Carbon
import Foundation

#if canImport(AppKit)
import AppKit
#endif

// TO DO: underscore/prefix non-public properties and methods to reduce risk of terminology clashes 

// TO DO: make sure KeywordConverter lists _all_ Specifier members

// TO DO: debugDescription that displays raw FCC representation?


/******************************************************************************/
// abstract base class for _all_ specifier and test clause subclasses


open class Query: CustomStringConvertible, CustomDebugStringConvertible, CustomReflectable, SelfPacking {
    // note: Equatable isn't implemented here as 1. it's rarely necessary to compare two specifiers, and 2. only the target app can know if two queries identify the same object or not, e.g. `Finder().folders["foo"]`, `Finder().desktop.folders["FOO"]`, and `Finder().home.folders["Desktop:Foo"]` all refer to same object (a folder named "foo" on user's desktop) while `Finder.disks["Bar"]` and `Finder.disks["bar"]` do not (since disk names are case-sensitive)
    
    public let appData: AppData
    internal private(set) var _cachedDescriptor: AEDesc?
    
    init(appData: AppData, descriptor: AEDesc?) { // descriptor is supplied on unpacking
        self.appData = appData
        self._cachedDescriptor = descriptor
    }
    
    deinit {
        self._cachedDescriptor?.dispose()
    }
    
    // unpacking
    
    func unpackParentSpecifiers() { } // ObjectSpecifier overrides this to recursively unpack its 'from' desc only when needed
    
    // packing
    
    public func SwiftAutomation_packSelf(_ appData: AppData) throws -> AEDesc {
        if self._cachedDescriptor == nil { self._cachedDescriptor = try self._packSelf() }
        return self._cachedDescriptor!.copy() // caller takes ownership of returned desc, so copy cached desc
    }
    
    func _packSelf() throws -> AEDesc { // subclasses must override this to pack themselves; called on first use
        fatalError("Query._packSelf() must be overridden by subclasses.")
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
    
    public var debugDescription: String { return self.description }
    
    public var customMirror: Mirror {
        let children: [Mirror.Child] = [(label: "description", value: self.description),
                                        (label: "descriptor", value: self._cachedDescriptor as Any),
                                        (label: "target", value: self.appData.target)]
        return Mirror(self, children: children, displayStyle: Mirror.DisplayStyle.`class`, ancestorRepresentation: .suppressed)
    }
    
}


/******************************************************************************/
// abstract base class for all object and insertion specifiers
// app-specific glues should subclass this and add command methods via protocol extension (mixin) to it and all of its subclasses too
// note: while application commands will be mixed-in on both targeted and untargeted specifiers, they will always throw if called on the latter; while it would be possible to differentiate the two it would complicate the implementation while failing to provide any real benefit to users, who are unlikely to make such a mistake in the first place


public protocol SpecifierProtocol { // glue-defined Command extensions, and by ObjectSpecifierProtocol
    var appData: AppData {get}
    var parentQuery: Query {get}
    var rootSpecifier: RootSpecifier {get}
}

open class Specifier: Query, SpecifierProtocol {

    var _parentDescKey: OSType { return OSType(keyAEContainer) }
    
    // An object specifier is constructed as a linked list of AERecords of typeObjectSpecifier, terminated by a root descriptor (e.g. a null descriptor represents the root node of the app's Apple event object graph). The topmost node may also be an insertion location specifier, represented by an AERecord of typeInsertionLoc. The abstract Specifier class implements functionality common to both object and insertion specifiers.
    
    private var _parentQuery: Query? // note: object specifiers are lazily unpacked for efficiency, so this is nil if Specifier hasn't been fully unpacked yet (or if class is RootSpecifier, in which case it's unused)

    public init(parentQuery: Query?, appData: AppData, descriptor: AEDesc?) {
        self._parentQuery = parentQuery
        super.init(appData: appData, descriptor: descriptor)
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
        do {
            // TO DO: ownership/disposal
            guard let descriptor = self._cachedDescriptor, let parentDesc = try? descriptor.parameter(self._parentDescKey) else { // note: self._cachedDescriptor should never be nil (if it is, it's an implementation bug), and parentDesc should never be nil (or else cached descriptor is malformed)
                throw AutomationError(code: 1, message: "Can't unpack parent specifiers due to internal error or malformed descriptor.")
            }
            self._parentQuery = try appData.unpack(parentDesc) as Specifier
            self._parentQuery!.unpackParentSpecifiers()
        } catch {
            self._parentQuery = RootSpecifier(rootObject: error, appData: self.appData) // store error in RootSpecifier and raise it on packing
        }
    }
    
    // convenience methods for sending Apple events using four-char codes (either OSTypes or Strings)
    
    public func sendAppleEvent<T>(_ eventClass: OSType, _ eventID: OSType, _ parameters: [OSType:Any] = [:],
                                  requestedType: Symbol? = nil, waitReply: Bool = true, sendOptions: SendOptions? = nil,
                                  withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(eventClass: eventClass, eventID: eventID,
                                               parentSpecifier: self, parameters: parameters,
                                               requestedType: requestedType, waitReply: waitReply,
                                               sendOptions: sendOptions, withTimeout: withTimeout, considering: considering)
    }
    
    public func sendAppleEvent<T>(_ eventClass: String, _ eventID: String, _ parameters: [String:Any] = [:],
                                  requestedType: Symbol? = nil, waitReply: Bool = true, sendOptions: SendOptions? = nil,
                                  withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        var params = [OSType:Any]()
        for (k, v) in parameters { params[try parseFourCharCode(k)] = v }
        return try self.appData.sendAppleEvent(eventClass: try parseFourCharCode(eventClass), eventID: try parseFourCharCode(eventID),
                                               parentSpecifier: self, parameters: params,
                                               requestedType: requestedType, waitReply: waitReply,
                                               sendOptions: sendOptions, withTimeout: withTimeout, considering: considering)
    }
    
    // non-generic versions of the above methods; these are bound when T can't be inferred (either because caller doesn't use the return value or didn't declare a specific type for it, e.g. `let result = cmd.call()`), in which case Any is used
    
    @discardableResult public func sendAppleEvent(_ eventClass: OSType, _ eventID: OSType, _ parameters: [OSType:Any] = [:],
                                                  requestedType: Symbol? = nil, waitReply: Bool = true, sendOptions: SendOptions? = nil,
                                                  withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(eventClass: eventClass, eventID: eventID,
                                               parentSpecifier: self, parameters: parameters,
                                               requestedType: requestedType, waitReply: waitReply,
                                               sendOptions: sendOptions, withTimeout: withTimeout, considering: considering)
    }
    
    @discardableResult public func sendAppleEvent(_ eventClass: String, _ eventID: String, _ parameters: [String:Any] = [:],
                                                  requestedType: Symbol? = nil, waitReply: Bool = true, sendOptions: SendOptions? = nil,
                                                  withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        var params = [OSType:Any]()
        for (k, v) in parameters { params[try parseFourCharCode(k)] = v }
        return try self.appData.sendAppleEvent(eventClass: try parseFourCharCode(eventClass), eventID: try parseFourCharCode(eventID),
                                               parentSpecifier: self, parameters: params,
                                               requestedType: requestedType, waitReply: waitReply,
                                               sendOptions: sendOptions, withTimeout: withTimeout, considering: considering)
    }
}


/******************************************************************************/
// insertion location specifier

open class InsertionSpecifier: Specifier { // SwiftAutomation_packSelf
    
    public let position: DescType
    
    override var _parentDescKey: OSType { return keyAEObject }

    required public init(position: DescType, parentQuery: Query?, appData: AppData, descriptor: AEDesc?) {
        self.position = position
        super.init(parentQuery: parentQuery, appData: appData, descriptor: descriptor)
    }
    
    override func _packSelf() throws -> AEDesc {
        return AEDesc(insertionLocation: self.position, container: try self.parentQuery.SwiftAutomation_packSelf(self.appData))
    }
}


/******************************************************************************/
// property/single-element specifiers; identifies an attribute/describes a one-to-one relationship between nodes in the app's AEOM graph


public protocol ObjectSpecifierProtocol: SpecifierProtocol {
    var wantType: DescType {get}
    var selectorForm: DescType {get}
    var selectorData: Any {get}
}

open class ObjectSpecifier: Specifier, ObjectSpecifierProtocol { // represents property or single element specifier; adds property+elements vars, relative selectors, insertion specifiers
    
    // 'want', 'form', 'data'
    public let wantType: DescType
    public let selectorForm: DescType
    public let selectorData: Any
    
    required public init(wantType: DescType, selectorForm: DescType, selectorData: Any,
                         parentQuery: Query?, appData: AppData, descriptor: AEDesc?) {
        self.wantType = wantType
        self.selectorForm = selectorForm
        self.selectorData = selectorData
        super.init(parentQuery: parentQuery, appData: appData, descriptor: descriptor)
    }
    
    override func _packSelf() throws -> AEDesc {
        let container = try self.parentQuery.SwiftAutomation_packSelf(self.appData)
        let keyData = try self.appData.pack(self.selectorData)
        // TO DO: disposal; simpler if it's done here, not in AEDesc.init; note: if caching returned AEDesc here, container desc will already be managed by parentQuery
        return AEDesc(desiredClass: self.wantType, container: container, keyForm: self.selectorForm, keyData: keyData) // TO DO: cache this desc?
    }

    // Comparison test constructors

    public static func <(lhs: ObjectSpecifier, rhs: Any) -> TestClause {
        return ComparisonTest(operatorType: kAELessThan, operand1: lhs, operand2: rhs, appData: lhs.appData, descriptor: nil)
    }
    public static func <=(lhs: ObjectSpecifier, rhs: Any) -> TestClause {
        return ComparisonTest(operatorType: kAELessThanEquals, operand1: lhs, operand2: rhs, appData: lhs.appData, descriptor: nil)
    }
    public static func ==(lhs: ObjectSpecifier, rhs: Any) -> TestClause {
        return ComparisonTest(operatorType: kAEEquals, operand1: lhs, operand2: rhs, appData: lhs.appData, descriptor: nil)
    }
    public static func !=(lhs: ObjectSpecifier, rhs: Any) -> TestClause {
        return ComparisonTest(operatorType: kAENotEquals, operand1: lhs, operand2: rhs, appData: lhs.appData, descriptor: nil)
    }
    public static func >(lhs: ObjectSpecifier, rhs: Any) -> TestClause {
        return ComparisonTest(operatorType: kAEGreaterThan, operand1: lhs, operand2: rhs, appData: lhs.appData, descriptor: nil)
    }
    public static func >=(lhs: ObjectSpecifier, rhs: Any) -> TestClause {
        return ComparisonTest(operatorType: kAEGreaterThanEquals, operand1: lhs, operand2: rhs, appData: lhs.appData, descriptor: nil)
    }
        
    // Containment test constructors
    
    // note: ideally the following would only appear on objects constructed from an Its root; however, this would complicate the implementation while failing to provide any real benefit to users, who are unlikely to make such a mistake in the first place
    
    public func beginsWith(_ value: Any) -> TestClause {
        return ComparisonTest(operatorType: kAEBeginsWith, operand1: self, operand2: value, appData: self.appData, descriptor: nil)
    }
    public func endsWith(_ value: Any) -> TestClause {
        return ComparisonTest(operatorType: kAEEndsWith, operand1: self, operand2: value, appData: self.appData, descriptor: nil)
    }
    public func contains(_ value: Any) -> TestClause {
        return ComparisonTest(operatorType: kAEContains, operand1: self, operand2: value, appData: self.appData, descriptor: nil)
    }
    public func isIn(_ value: Any) -> TestClause {
        return ComparisonTest(operatorType: kAEIsIn, operand1: self, operand2: value, appData: self.appData, descriptor: nil)
    }
}


/******************************************************************************/
// Multi-element specifiers; represents a one-to-many relationship between nodes in the app's AEOM graph

// note: each glue should define an Elements class that subclasses ObjectSpecifier and adopts MultipleObjectSpecifierExtension (which adds by range/test/all selectors)

// note: by-range selector doesn't confirm APP/CON-based roots for start+stop specifiers; as with ITS-based roots this would add significant complexity to class hierarchy in order to detect mistakes that are unlikely to be made in practice (most errors are likely to be made further down the chain, e.g. getting the 'containment' hierarchy for more complex specifiers incorrect)



struct RangeSelector: SelfPacking { // holds data for by-range selectors
    // Start and stop are Con-based (i.e. relative to container) specifiers (App-based specifiers will also work, as 
    // long as they have the same parent specifier as the by-range specifier itself). For convenience, users can also
    // pass non-specifier values (typically Strings and Ints) to represent simple by-name and by-index specifiers of
    // the same element class; these will be converted to specifiers automatically when packed.
    let start: Any
    let stop: Any
    let wantType: DescType
    
    init(start: Any, stop: Any, wantType: DescType) {
        self.start = start
        self.stop = stop
        self.wantType = wantType
    }
    
    private func packSelector(_ selectorData: Any, appData: AppData) throws -> AEDesc {
        switch selectorData {
        case is AEDesc:
            return selectorData as! AEDesc
        case is Specifier: // technically, only ObjectSpecifier makes sense here, tho AS prob. doesn't prevent insertion loc or multi-element specifier being passed instead
            return try (selectorData as! Specifier).SwiftAutomation_packSelf(appData)
        default: // pack anything else as a by-name or by-index specifier
            let form = selectorData is String ? DescType(formName) : DescType(formAbsolutePosition)
            let seld = try appData.pack(selectorData) // TO DO: disposal
            return AEDesc(desiredClass: self.wantType, container: ConRootDesc, keyForm: form, keyData: seld)
        }
    }
    
    func SwiftAutomation_packSelf(_ appData: AppData) throws -> AEDesc {
        // note: the returned desc will be cached by the MultipleObjectSpecifier, so no need to cache it here
        var rangeStart = try self.packSelector(self.start, appData: appData)
        var rangeStop = try self.packSelector(self.stop, appData: appData)
        var desc = nullDescriptor
        try throwIfError(CreateRangeDescriptor(&rangeStart, &rangeStop, false, &desc))
        return desc
    }
}


/******************************************************************************/
// Test clause; used in by-test specifiers

// note: glues don't define their own TestClause subclasses as tests don't implement any app-specific vars/methods, only the logical operators defined below, and there's little point doing so for static typechecking purposes as any values not handled by MultipleObjectSpecifierExtension's subscript(test:TestClause) are accepted by its subscript(index:Any), so still wouldn't be caught at runtime (OTOH, it'd be worth considering should subscript(test:) need to be replaced with a separate byTest() method for any reason)


// note: only TestClauses constructed from Its roots are actually valid; however, enfording this at compile-time would require a more complex class/protocol structure, while checking this at runtime would require calling Query.rootSpecifier.rootObject and checking object is 'its' descriptor. As it's highly unlikely users will use an App or Con root by accident, we'll live recklessly and let the gods of AppleScript punish any user foolish enough to do so.

public class TestClause: Query {
    
    // Logical test constructors
    
    public static func &&(lhs: TestClause, rhs: TestClause) -> TestClause {
        return LogicalTest(operatorType: DescType(kAEAND), operands: [lhs, rhs], appData: lhs.appData, descriptor: nil)
    }
    public static func ||(lhs: TestClause, rhs: TestClause) -> TestClause {
        return LogicalTest(operatorType: DescType(kAEOR), operands: [lhs, rhs], appData: lhs.appData, descriptor: nil)
    }
    public static prefix func !(lhs: TestClause) -> TestClause {
        return LogicalTest(operatorType: DescType(kAENOT), operands: [lhs], appData: lhs.appData, descriptor: nil)
    }
}


public class ComparisonTest: TestClause {
    
    public let operatorType: DescType, operand1: ObjectSpecifier, operand2: Any
    
    init(operatorType: DescType, operand1: ObjectSpecifier, operand2: Any, appData: AppData, descriptor: AEDesc?) {
        self.operatorType = operatorType
        self.operand1 = operand1
        self.operand2 = operand2
        super.init(appData: appData, descriptor: descriptor)
    }
    
    override func _packSelf() throws -> AEDesc {
        if self.operatorType == kAENotEquals { // AEM doesn't support a 'kAENotEqual' enum, so convert to kAEEquals+kAENOT
            return try (!(self.operand1 == self.operand2)).SwiftAutomation_packSelf(self.appData)
        } else {
            var operatorType = self.operatorType
            var operandDesc1 = try self.appData.pack(self.operand1)
            var operandDesc2 = try self.appData.pack(self.operand2)
            if self.operatorType == kAEIsIn { // AEM doesn't support a 'kAEIsIn' enum,  so use kAEContains with operands reversed
                (operatorType, operandDesc1, operandDesc2) = (kAEContains, operandDesc2, operandDesc1)
            }
            var desc = nullDescriptor
            try throwIfError(CreateCompDescriptor(operatorType, &operandDesc1, &operandDesc2, false, &desc))
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
    
    public let operatorType: DescType, operands: [TestClause] // note: this doesn't have a 'parent' as such; to walk chain, just use first operand
    
    init(operatorType: DescType, operands: [TestClause], appData: AppData, descriptor: AEDesc?) {
        self.operatorType = operatorType
        self.operands = operands
        super.init(appData: appData, descriptor: descriptor)
    }
    
    override func _packSelf() throws -> AEDesc {
        var desc = nullDescriptor
        var operandsDesc = try self.appData.pack(self.operands)
        try throwIfError(CreateLogicalDescriptor(&operandsDesc, self.operatorType, false, &desc))
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
        super.init(wantType: typeNull, // wantType and selectorForm are unused here
                   selectorForm: typeNull, selectorData: rootObject,
                   parentQuery: nil, appData: appData, descriptor: rootObject as? AEDesc)
    }

    public required init(wantType: DescType, selectorForm: DescType,
                         selectorData: Any, parentQuery: Query?, appData: AppData, descriptor: AEDesc?) {
        super.init(wantType: wantType, selectorForm: selectorForm,
                   selectorData: selectorData, parentQuery: parentQuery, appData: appData, descriptor: descriptor)
        
    }
    
    public override func _packSelf() throws -> AEDesc {
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


