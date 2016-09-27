//
//  SpecifierExtensions.swift
//  SwiftAutomation
//
//  Protocol extension-based workaround for generic class bug where SourceKit and swiftc crash when using subclass 
//  types as types parameters.
//
//  Instead of defining ObjectSpecifier, etc. as generic classes that declare all specifier constructors, specifier
//  constructors are defined as protocol extensions that must be mixed in to glue-defined subclasses. This allows
//  glues to specify return types as typealiases instead of generic class parameters. 

//  Main disadvantage is that the standard Specifier classes are no longer self-contained, so code is more complex 
//  and cannot be used standalone but only as part of a glue (a default AEApplicationGlue is included for convenience).
//

// TO DO: remove the `Extension` suffix from the `Application` protocol so that the documentation can refer to `Application` when discussing the root `application` object used to control an[y] application

// TO DO: also define `any` var which would replace the parent ObjSpec [if it's gPropertyForm] with formAbsolutePosition and gAll? (as with `named()`, it would provide parity with AS and cover all eventualities; see also special handling of 'text' keyword in GlueTable.add())


import Foundation


/******************************************************************************/
// Property/single-element specifier; identifies an attribute/describes a one-to-one relationship between nodes in the app's AEOM graph

public protocol ObjectSpecifierExtension: ObjectSpecifierProtocol {
    associatedtype InsertionSpecifierType: InsertionSpecifier
    associatedtype ObjectSpecifierType: ObjectSpecifier
    associatedtype MultipleObjectSpecifierType: ObjectSpecifier
}

public extension ObjectSpecifierExtension {

    public func userProperty(_ name: String) -> Self.ObjectSpecifierType {
        return Self.ObjectSpecifierType(wantType: gPropertyType,
                                        selectorForm: gUserPropertyForm, selectorData: NSAppleEventDescriptor(string: name),
                                        parentQuery: (self as! Query), appData: self.appData, cachedDesc: nil)
    }

    public func property(_ code: OSType) -> Self.ObjectSpecifierType {
		return Self.ObjectSpecifierType(wantType: gPropertyType,
		                                selectorForm: gPropertyForm, selectorData: NSAppleEventDescriptor(typeCode: code),
		                                parentQuery: (self as! Query), appData: self.appData, cachedDesc: nil)
    }
    
    public func property(_ code: String) -> Self.ObjectSpecifierType {
        let data: Any
        do {
            data = NSAppleEventDescriptor(typeCode: try fourCharCode(code))
        } catch {
            data = error
        }
        return Self.ObjectSpecifierType(wantType: gPropertyType,
                                        selectorForm: gPropertyForm, selectorData: data,
                                        parentQuery: (self as! Query), appData: self.appData, cachedDesc: nil)
    }
    
    public func elements(_ code: OSType) -> Self.MultipleObjectSpecifierType {
        return Self.MultipleObjectSpecifierType(wantType: NSAppleEventDescriptor(typeCode: code),
                                                selectorForm: gAbsolutePositionForm, selectorData: gAll,
                                                parentQuery: (self as! Query), appData: self.appData, cachedDesc: nil)
    }
    
    public func elements(_ code: String) -> Self.MultipleObjectSpecifierType {
        let want: NSAppleEventDescriptor, data: Any
        do {
            want = NSAppleEventDescriptor(typeCode: try fourCharCode(code))
            data = gAll
        } catch {
            want = NSAppleEventDescriptor.null()
            data = error
        } 
        return Self.MultipleObjectSpecifierType(wantType: want,
                                                selectorForm: gAbsolutePositionForm, selectorData: data,
                                                parentQuery: (self as! Query), appData: self.appData, cachedDesc: nil)
    }

    
    // relative position selectors
    public func previous(_ elementClass: Symbol? = nil) -> Self.ObjectSpecifierType {
        // TO DO: getting `elementClass!.descriptor` here will be problematic in dynamic glues, where all Symbol instances are name-only and their four-char-codes are looked up dynamically when packing the Apple event, as that's the only time a targeted AppData instance containing the target app's own terminology tables is guaranteed to be available as commands can only be dispatched by object specifiers that have a full Application root (self.appData will be untargeted if the specifier was constructed from an App/Con/Its root)
        return Self.ObjectSpecifierType(wantType: elementClass == nil ? self.wantType : elementClass!.descriptor,
                                        selectorForm: gRelativePositionForm, selectorData: gPrevious,
                                        parentQuery: (self as! Query), appData: self.appData, cachedDesc: nil)
    }
    
    public func next(_ elementClass: Symbol? = nil) -> Self.ObjectSpecifierType {
        return Self.ObjectSpecifierType(wantType: elementClass == nil ? self.wantType : elementClass!.descriptor,
                                        selectorForm: gRelativePositionForm, selectorData: gNext,
                                        parentQuery: (self as! Query), appData: self.appData, cachedDesc: nil)
    }
    
    // insertion specifiers
    public var beginning: Self.InsertionSpecifierType {
        return Self.InsertionSpecifierType(insertionLocation: gBeginning, parentQuery: (self as! Query), appData: self.appData, cachedDesc: nil)
    }
    public var end: Self.InsertionSpecifierType {
        return Self.InsertionSpecifierType(insertionLocation: gEnd, parentQuery: (self as! Query), appData: self.appData, cachedDesc: nil)
    }
    public var before: Self.InsertionSpecifierType {
        return Self.InsertionSpecifierType(insertionLocation: gBefore, parentQuery: (self as! Query), appData: self.appData, cachedDesc: nil)
    }
    public var after: Self.InsertionSpecifierType {
        return Self.InsertionSpecifierType(insertionLocation: gAfter, parentQuery: (self as! Query), appData: self.appData, cachedDesc: nil)
    }
}


/******************************************************************************/
// Multi-element specifier; represents a one-to-many relationship between nodes in the app's AEOM graph

public protocol ElementsSpecifierExtension: ObjectSpecifierExtension {}

extension ElementsSpecifierExtension {

    // Note: calling an element[s] selector on an all-elements specifier effectively replaces its original gAll selector data with the new selector data, instead of extending the specifier chain. This ensures that applying any selector to `elements[all]` produces `elements[selector]` (effectively replacing the existing selector), while applying a second selector to `elements[selector]` produces `elements[selector][selector2]` (appending the second selection to the first) as normal; e.g. `first document whose modified is true` would be written as `documents[Its.modified==true].first`.
    var baseQuery: Query {
        return self.selectorData as? NSAppleEventDescriptor === gAll ? self.parentQuery : (self as! Query)
    } // TO DO: fix (Q. is this TODO still relevant?)
    
    // by-index, by-name, by-test
    public subscript(index: Any) -> Self.ObjectSpecifierType {
        var form: NSAppleEventDescriptor
        switch (index) {
        case is TestClause:
            return self[index as! TestClause]
        case is String:
            form = gNameForm
        default:
            form = gAbsolutePositionForm
        }
        return Self.ObjectSpecifierType(wantType: self.wantType,
                                        selectorForm: form, selectorData: index,
                                        parentQuery: self.baseQuery, appData: self.appData, cachedDesc: nil)
    }

    public subscript(test: TestClause) -> Self.MultipleObjectSpecifierType {
        return Self.MultipleObjectSpecifierType(wantType: self.wantType,
                                                selectorForm: gTestForm, selectorData: test,
                                                parentQuery: self.baseQuery, appData: self.appData, cachedDesc: nil)
    }
    
    // by-name, by-id, by-range
    public func named(_ name: Any) -> Self.ObjectSpecifierType { // use this if name is not a String, else use subscript // TO DO: trying to think of a use case where this has ever been found necessary; DELETE?
        return Self.ObjectSpecifierType(wantType: self.wantType,
                                        selectorForm: gNameForm, selectorData: name,
                                        parentQuery: self.baseQuery, appData: self.appData, cachedDesc: nil)
    }
    public func ID(_ id: Any) -> Self.ObjectSpecifierType {
        return Self.ObjectSpecifierType(wantType: self.wantType,
                                        selectorForm: gUniqueIDForm, selectorData: id,
                                        parentQuery: self.baseQuery, appData: self.appData, cachedDesc: nil)
    }
    public subscript(from: Any, to: Any) -> Self.MultipleObjectSpecifierType {
        // caution: by-range specifiers must be constructed as `elements[from,to]`, NOT `elements[from...to]`, as `Range<T>` types are not supported
        // Note that while the `x...y` form _could_ be supported (via the SelfPacking protocol, since Ranges are generics), the `x..<y` form is problematic as it doesn't have a direct analog in Apple events (which are always inclusive of both start and end points). Automatically mapping `x..<y` to `x...y.previous()` is liable to cause its own set of problems, e.g. some apps may fail to resolve this more complex query correctly/at all), and it's hard to justify the additional complexity of having two different ways of constructing ranges, one of which brings various caveats and limitations, and the more complicated user documentation that will inevitably require.
        // Another concern is that supporting 'standard' Range syntax will further encourage users to lapse into using Swift-style zero-indexing (e.g. `0..<3`) instead of the correct Apple event one-indexing (`1 thru 3`) – it'll be hard enough keeping them right when using the single-element by-index syntax (where `elements[0]` is a common user error, and - worse - one that CocoaScripting intentionally indulges instead of reporting as an error, so that both `elements[0]` and `elements[1]` actually refer to the _same_ element, not consecutive elements as expected).
        return Self.MultipleObjectSpecifierType(wantType: self.wantType,
                                                selectorForm: gRangeForm,
                                                selectorData: RangeSelector(start: from, stop: to, wantType: self.wantType),
                                                parentQuery: self.baseQuery, appData: self.appData, cachedDesc: nil)
    }
    
    // by-ordinal
    public var first: Self.ObjectSpecifierType {
        return Self.ObjectSpecifierType(wantType: self.wantType,
                                        selectorForm: gAbsolutePositionForm, selectorData: gFirst,
                                        parentQuery: self.baseQuery, appData: self.appData, cachedDesc: nil)
    }
    public var middle: Self.ObjectSpecifierType {
        return Self.ObjectSpecifierType(wantType: self.wantType,
                                        selectorForm: gAbsolutePositionForm, selectorData: gMiddle,
                                        parentQuery: self.baseQuery, appData: self.appData, cachedDesc: nil)
    }
    public var last: Self.ObjectSpecifierType {
        return Self.ObjectSpecifierType(wantType: self.wantType,
                                        selectorForm: gAbsolutePositionForm, selectorData: gLast,
                                        parentQuery: self.baseQuery, appData: self.appData, cachedDesc: nil)
    }
    public var any: Self.ObjectSpecifierType {
        return Self.ObjectSpecifierType(wantType: self.wantType,
                                        selectorForm: gAbsolutePositionForm, selectorData: gAny,
                                        parentQuery: self.baseQuery, appData: self.appData, cachedDesc: nil)
    }
}




public protocol RootSpecifierExtension: ObjectSpecifierExtension {
    init(rootObject: Any, appData: AppData)
    static var untargetedAppData: AppData {get}
}


public protocol ApplicationExtension: RootSpecifierExtension {}

extension ApplicationExtension {
    
    // note: users may access Application.appData.target directly for troubleshooting purposes, but are strongly discouraged from using it directly (it is public so that generated glues can use it, but should otherwise be treated as an internal implementation detail)
    
    // Application object constructors
    
    private init(target: TargetApplication, launchOptions: LaunchOptions, relaunchMode: RelaunchMode) {
        let appData = Self.untargetedAppData.targetedCopy(target, launchOptions: launchOptions, relaunchMode: relaunchMode)
        self.init(rootObject: AppRootDesc, appData: appData)
        // TO DO: is there any way to store this new Application object into appData so that it can be returned when unpacking specifier roots, without creating either circular refcounts or expired weakrefs? (the alternative is just for AppData to instantiate Application each time, but to do that it needs to know its exact class… perhaps this can be stored in GlueClasses, which already holds Specifier, Root, etc classes?)
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
    
    public init(addressDescriptor: NSAppleEventDescriptor, launchOptions: LaunchOptions = DefaultLaunchOptions, relaunchMode: RelaunchMode = DefaultRelaunchMode) {
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


