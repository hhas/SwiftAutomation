//
//  SpecifierExtensions.swift
//  SwiftAutomation
//
//  Extensions that add the standard selector vars/methods to each glue's custom Specifier classes.
//  These allow specifiers to be built up via chained calls, e.g.:
//
//     paragraphs 1 thru -2 of text of document "README" of it
//
//     AEApp.elements(cDocument)["README"].property(cText).elements(cParagraph)[1,-2]
//
//


import Foundation
import Carbon


/******************************************************************************/
// Property/single-element specifier; identifies an attribute/describes a one-to-one relationship between nodes in the app's AEOM graph

public protocol ObjectSpecifierExtension: ObjectSpecifierProtocol {
    // each glue defines its concrete specifier classes here; used as the return types for the selector methods below
    associatedtype InsertionSpecifierType: InsertionSpecifier   // e.g. TEDInsertion, FINInsertion
    associatedtype ObjectSpecifierType: ObjectSpecifier         // e.g. TEDItem, FINItem
    associatedtype MultipleObjectSpecifierType: ObjectSpecifier // e.g. TEDItems, FINItems
}

public extension ObjectSpecifierExtension {

    func userProperty(_ name: String) -> Self.ObjectSpecifierType {
        let desc = AEDesc(string: name) // TO DO: ownership
        return Self.ObjectSpecifierType(wantType: typeProperty,
                                        selectorForm: DescType(formUserPropertyID), selectorData: desc,
                                        parentQuery: (self as! Query), appData: self.appData, descriptor: nil)
    }

    func property(_ code: OSType) -> Self.ObjectSpecifierType {
        let desc = AEDesc(typeCode: code) // TO DO: ownership
		return Self.ObjectSpecifierType(wantType: typeProperty,
		                                selectorForm: DescType(formPropertyID), selectorData: desc,
		                                parentQuery: (self as! Query), appData: self.appData, descriptor: nil)
    }
    
    func property(_ code: String) -> Self.ObjectSpecifierType {
        let data: Any
        do {
            data = AEDesc(typeCode: try parseFourCharCode(code)) // TO DO: ownership
        } catch {
            data = error
        }
        return Self.ObjectSpecifierType(wantType: typeProperty,
                                        selectorForm: DescType(formPropertyID), selectorData: data,
                                        parentQuery: (self as! Query), appData: self.appData, descriptor: nil)
    }
    
    func elements(_ code: OSType) -> Self.MultipleObjectSpecifierType {
        return Self.MultipleObjectSpecifierType(wantType: code,
                                                selectorForm: DescType(formAbsolutePosition), selectorData: kAEAllDesc,
                                                parentQuery: (self as! Query), appData: self.appData, descriptor: nil)
    }
    
    func elements(_ code: String) -> Self.MultipleObjectSpecifierType {
        let want: DescType, data: Any
        do {
            want = try parseFourCharCode(code)
            data = kAEAllDesc
        } catch {
            want = typeNull
            data = error
        } 
        return Self.MultipleObjectSpecifierType(wantType: want,
                                                selectorForm: DescType(formAbsolutePosition), selectorData: data,
                                                parentQuery: (self as! Query), appData: self.appData, descriptor: nil)
    }

    
    // relative position selectors
    func previous(_ elementClass: Symbol? = nil) -> Self.ObjectSpecifierType { // passing a name-only Symbol here is really an error, but ignored
        return Self.ObjectSpecifierType(wantType: (elementClass?.code ?? self.wantType),
                                        selectorForm: DescType(formRelativePosition), selectorData: kAEPreviousDesc,
                                        parentQuery: (self as! Query), appData: self.appData, descriptor: nil)
    }
    
    func next(_ elementClass: Symbol? = nil) -> Self.ObjectSpecifierType {
        return Self.ObjectSpecifierType(wantType: (elementClass?.code ?? self.wantType),
                                        selectorForm: DescType(formRelativePosition), selectorData: kAENextDesc,
                                        parentQuery: (self as! Query), appData: self.appData, descriptor: nil)
    }
    
    // insertion specifiers
    var beginning: Self.InsertionSpecifierType {
        return Self.InsertionSpecifierType(position: kAEBeginning, parentQuery: (self as! Query), appData: self.appData, descriptor: nil)
    }
    var end: Self.InsertionSpecifierType {
        return Self.InsertionSpecifierType(position: kAEEnd, parentQuery: (self as! Query), appData: self.appData, descriptor: nil)
    }
    var before: Self.InsertionSpecifierType {
        return Self.InsertionSpecifierType(position: kAEBefore, parentQuery: (self as! Query), appData: self.appData, descriptor: nil)
    }
    var after: Self.InsertionSpecifierType {
        return Self.InsertionSpecifierType(position: kAEAfter, parentQuery: (self as! Query), appData: self.appData, descriptor: nil)
    }
    
    var all: Self.MultipleObjectSpecifierType { // equivalent to `every REFERENCE`; applied to a property specifier, converts it to all-elements (this may be necessary when property and element names are identical, in which case [with exception of `text`] a property specifier is constructed by default); applied to an all-elements specifier, returns it as-is; applying it to any other reference form will throw an error when used
        if self.selectorForm == DescType(formPropertyID) {
            return Self.MultipleObjectSpecifierType(wantType: try! (self.selectorData as! AEDesc).fourCharCode(),
                                                    selectorForm: DescType(formAbsolutePosition), selectorData: kAEAllDesc,
                                                    parentQuery: self.parentQuery, appData: self.appData, descriptor: nil)
        } else if self.selectorForm == DescType(formAbsolutePosition)
                && (try? (self.selectorData as? AEDesc)?.fourCharCode()) == DescType(kAEAll),
                let specifier = self as? Self.MultipleObjectSpecifierType {
            return specifier
        } else {
            let error = AutomationError(code: 1, message: "Invalid specifier: \(self).all")
            return Self.MultipleObjectSpecifierType(wantType: self.wantType,
                                                    selectorForm: DescType(formAbsolutePosition), selectorData: error,
                                                    parentQuery: self.parentQuery, appData: self.appData, descriptor: nil)
        }
    }
}


/******************************************************************************/
// Multi-element specifier; represents a one-to-many relationship between nodes in the app's AEOM graph

public protocol MultipleObjectSpecifierExtension: ObjectSpecifierExtension {}

extension MultipleObjectSpecifierExtension {

    // Note: calling an element[s] selector on an all-elements specifier effectively replaces its original gAll selector data with the new selector data, instead of extending the specifier chain. This ensures that applying any selector to `elements[all]` produces `elements[selector]` (effectively replacing the existing selector), while applying a second selector to `elements[selector]` produces `elements[selector][selector2]` (appending the second selection to the first) as normal; e.g. `first document whose modified is true` would be written as `documents[Its.modified==true].first`.
    var baseQuery: Query {
        if let desc = self.selectorData as? AEDesc,
            desc.descriptorType == DescType(typeAbsoluteOrdinal) && (try? desc.fourCharCode()) == DescType(kAEAll) {
            return self.parentQuery
        } else {
            return self as! Query
        }
    }
    
    // by-index, by-name, by-test
    public subscript(index: Any) -> Self.ObjectSpecifierType {
        var form: DescType
        switch (index) {
        case is TestClause:
            return self[index as! TestClause]
        case is String:
            form = DescType(formName)
        default:
            form = DescType(formAbsolutePosition)
        }
        return Self.ObjectSpecifierType(wantType: self.wantType,
                                        selectorForm: form, selectorData: index,
                                        parentQuery: self.baseQuery, appData: self.appData, descriptor: nil)
    }

    public subscript(test: TestClause) -> Self.MultipleObjectSpecifierType {
        return Self.MultipleObjectSpecifierType(wantType: self.wantType,
                                                selectorForm: DescType(formTest), selectorData: test,
                                                parentQuery: self.baseQuery, appData: self.appData, descriptor: nil)
    }
    
    // by-name, by-id, by-range
    public func named(_ name: Any) -> Self.ObjectSpecifierType { // use this if name is not a String, else use subscript // TO DO: trying to think of a use case where this has ever been found necessary; DELETE? (see also TODOs on whether or not to add an explicit `all` selector property)
        return Self.ObjectSpecifierType(wantType: self.wantType,
                                        selectorForm: DescType(formName), selectorData: name,
                                        parentQuery: self.baseQuery, appData: self.appData, descriptor: nil)
    }
    public func ID(_ id: Any) -> Self.ObjectSpecifierType {
        return Self.ObjectSpecifierType(wantType: self.wantType,
                                        selectorForm: DescType(formUniqueID), selectorData: id,
                                        parentQuery: self.baseQuery, appData: self.appData, descriptor: nil)
    }
    public subscript(from: Any, to: Any) -> Self.MultipleObjectSpecifierType {
        // caution: by-range specifiers must be constructed as `elements[from,to]`, NOT `elements[from...to]`, as `Range<T>` types are not supported
        // Note that while the `x...y` form _could_ be supported (via the SelfPacking protocol, since Ranges are generics), the `x..<y` form is problematic as it doesn't have a direct analog in Apple events (which are always inclusive of both start and end points). Automatically mapping `x..<y` to `x...y.previous()` is liable to cause its own set of problems, e.g. some apps may fail to resolve this more complex query correctly/at all), and it's hard to justify the additional complexity of having two different ways of constructing ranges, one of which brings various caveats and limitations, and the more complicated user documentation that will inevitably require.
        // Another concern is that supporting 'standard' Range syntax will further encourage users to lapse into using Swift-style zero-indexing (e.g. `0..<3`) instead of the correct Apple event one-indexing (`1 thru 3`) – it'll be hard enough keeping them right when using the single-element by-index syntax (where `elements[0]` is a common user error, and - worse - one that CocoaScripting intentionally indulges instead of reporting as an error, so that both `elements[0]` and `elements[1]` actually refer to the _same_ element, not consecutive elements as expected).
        return Self.MultipleObjectSpecifierType(wantType: self.wantType,
                                                selectorForm: DescType(formRange),
                                                selectorData: RangeSelector(start: from, stop: to, wantType: self.wantType),
                                                parentQuery: self.baseQuery, appData: self.appData, descriptor: nil)
    }
    
    // by-ordinal
    public var first: Self.ObjectSpecifierType {
        return Self.ObjectSpecifierType(wantType: self.wantType,
                                        selectorForm: DescType(formAbsolutePosition), selectorData: kAEFirstDesc,
                                        parentQuery: self.baseQuery, appData: self.appData, descriptor: nil)
    }
    public var middle: Self.ObjectSpecifierType {
        return Self.ObjectSpecifierType(wantType: self.wantType,
                                        selectorForm: DescType(formAbsolutePosition), selectorData: kAEMiddleDesc,
                                        parentQuery: self.baseQuery, appData: self.appData, descriptor: nil)
    }
    public var last: Self.ObjectSpecifierType {
        return Self.ObjectSpecifierType(wantType: self.wantType,
                                        selectorForm: DescType(formAbsolutePosition), selectorData: kAELastDesc,
                                        parentQuery: self.baseQuery, appData: self.appData, descriptor: nil)
    }
    public var any: Self.ObjectSpecifierType {
        return Self.ObjectSpecifierType(wantType: self.wantType,
                                        selectorForm: DescType(formAbsolutePosition), selectorData: kAEAnyDesc,
                                        parentQuery: self.baseQuery, appData: self.appData, descriptor: nil)
    }
}




public protocol RootSpecifierExtension: ObjectSpecifierExtension {
    init(rootObject: Any, appData: AppData)
    static var untargetedAppData: AppData {get}
}


public protocol Application: RootSpecifierExtension {}

extension Application {
    
    // note: users may access Application.appData.target directly for troubleshooting purposes, but are strongly discouraged from using it directly (it is public so that generated glues can use it, but should otherwise be treated as an internal implementation detail)
    
    // Application object constructors
    
    private init(target: TargetApplication, launchOptions: LaunchOptions, relaunchMode: RelaunchMode) {
        let appData = Self.untargetedAppData.targetedCopy(target, launchOptions: launchOptions, relaunchMode: relaunchMode)
        self.init(rootObject: AppRootDesc, appData: appData)
    }
    
    public init(name: String, launchOptions: LaunchOptions = DefaultLaunchOptions, relaunchMode: RelaunchMode = DefaultRelaunchMode) {
        self.init(target: .name(name), launchOptions: launchOptions, relaunchMode: relaunchMode)
    }
    
    public init(url: URL, launchOptions: LaunchOptions = DefaultLaunchOptions, relaunchMode: RelaunchMode = DefaultRelaunchMode) {
        self.init(target: .url(url), launchOptions: launchOptions, relaunchMode: relaunchMode)
    }
    
    public init(bundleIdentifier: String, launchOptions: LaunchOptions = DefaultLaunchOptions, relaunchMode: RelaunchMode = DefaultRelaunchMode) {
        self.init(target: .bundleIdentifier(bundleIdentifier, false), launchOptions: launchOptions, relaunchMode: relaunchMode)
    }
    
    public init(processIdentifier: pid_t, launchOptions: LaunchOptions = DefaultLaunchOptions, relaunchMode: RelaunchMode = DefaultRelaunchMode) {
        self.init(target: .processIdentifier(processIdentifier), launchOptions: launchOptions, relaunchMode: relaunchMode)
    }
    
    public init(addressDescriptor: AEDesc, launchOptions: LaunchOptions = DefaultLaunchOptions, relaunchMode: RelaunchMode = DefaultRelaunchMode) {
        self.init(target: .Descriptor(addressDescriptor), launchOptions: launchOptions, relaunchMode: relaunchMode)
    }
    
    
    public static func currentApplication() -> Self {
        let appData = Self.untargetedAppData.targetedCopy(.current, launchOptions: DefaultLaunchOptions, relaunchMode: DefaultRelaunchMode)
        return self.init(rootObject: AppRootDesc, appData: appData)
    }
    
    public func customRoot(_ object: Any) -> Self {
        return type(of: self).init(rootObject: object, appData: self.appData)
    }
    
    // launch this application (equivalent to AppleScript's `launch` command)
    
    public func launch() throws {
        try self.appData.target.launch()
    }
    
    // is the target application currently running?
    
    public var isRunning: Bool {
        return self.appData.target.isRunning
    }
    
    // transaction support
    
    public func doTransaction<T>(session: Any? = nil, closure: () throws -> (T)) throws -> T {
        return try self.appData.doTransaction(session: session, closure: closure)
    }
}


