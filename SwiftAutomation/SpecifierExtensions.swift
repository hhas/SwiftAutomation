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

// TO DO: should prob. go ahead and implement `all` property, just to ensure it can be done; can always comment out/leave it undocumented

// TO DO: also define `var all: Self.MultipleObjectSpecifierType {...}` which would convert a property specifier [_formPropertyDesc] to an all-elements specifier [_formAbsolutePositionDesc + _kAEAllDesc]? As with `named()`, it would provide parity with AS and cover all eventualities; see also special handling of 'text' keyword in GlueTable.add(), e.g. if `app.document` returns property specifier but an all-elements specifier is needed, `app.document.all` would force it to the latter.
//
//      Note that this sort of confusion shouldn't normally occur, because even when a term (e.g. document) is used as both a class [elements] name and a property name, the class's definition should provide both singular and plural versions, so that the glue uses the singular for the property name (`textedit.windows.document`) and the plural for the elements name (`textedit.documents`).
//
//      Occasionally, however, a singular class name doesn't have a plural (e.g. `text`, `sheep`) so if it's also used as a property name then things get very murky as to whether `ref.sheep` is referring to a `sheep` property or to all `sheep` elements. IIRC, AppleScript defaults to property unless it _knows_ it's an element (e.g. `sheep 1 thru -2`, `every sheep`); with [IIRC2] `text` being an extra-special case as it's already defined as a class name by AppleScript itself and that overrides any application definition so always packs as an element name.
//
//      Some apps - e.g. Illustrator, InDesign - are a bit quirky in not always defining plural class names, e.g. `ref.paragraph[1]` instead of `ref.paragraphs[1]`, or in using the plural as the property name (e.g. `indesign.pasteboardPreferences`) and singular as the class name (`pasteboardPreference`), so there's always some fear of being caught out if the AppleScript API isn't replicated down to the letter (in this case, `NAME.all` = `every NAME`).
//
//      The flipside is to argue that until a concrete need for an `all` selector is demonstrated, it's better to err on the side of simplicity rather than paranoia (since explaining to users how object specifiers work is tough enough already). In which case the same argument should apply to the `named(Any)` selector already defined below, and it should be removed until/unless a concrete need to include it is shown.
//
//      (The third option, of course, is to include both `named` and `all` selectors, but leave them undocumented [at least outside of troubleshooting section] same as AppData's compatibility flags. That way we're covered if some crusty old app does decide to be awkward, but we're not going to confuse users by telling them about obscure 'fallback' features that few, if any, of them will ever need to know/use/care about.)
//


import Foundation


/******************************************************************************/
// Property/single-element specifier; identifies an attribute/describes a one-to-one relationship between nodes in the app's AEOM graph

public protocol ObjectSpecifierExtension: ObjectSpecifierProtocol {
    // each glue defines its concrete specifier classes here; used as the return types for the selector methods below
    associatedtype InsertionSpecifierType: InsertionSpecifier   // e.g. TEDInsertion, FINInsertion
    associatedtype ObjectSpecifierType: ObjectSpecifier         // e.g. TEDItem, FINItem
    associatedtype MultipleObjectSpecifierType: ObjectSpecifier // e.g. TEDItems, FINItems
}

public extension ObjectSpecifierExtension {

    public func userProperty(_ name: String) -> Self.ObjectSpecifierType {
        return Self.ObjectSpecifierType(wantType: _typePropertyDesc,
                                        selectorForm: _formUserPropertyDesc, selectorData: NSAppleEventDescriptor(string: name),
                                        parentQuery: (self as! Query), appData: self.appData, descriptor: nil)
    }

    public func property(_ code: OSType) -> Self.ObjectSpecifierType {
		return Self.ObjectSpecifierType(wantType: _typePropertyDesc,
		                                selectorForm: _formPropertyDesc, selectorData: NSAppleEventDescriptor(typeCode: code),
		                                parentQuery: (self as! Query), appData: self.appData, descriptor: nil)
    }
    
    public func property(_ code: String) -> Self.ObjectSpecifierType {
        let data: Any
        do {
            data = NSAppleEventDescriptor(typeCode: try fourCharCode(code))
        } catch {
            data = error
        }
        return Self.ObjectSpecifierType(wantType: _typePropertyDesc,
                                        selectorForm: _formPropertyDesc, selectorData: data,
                                        parentQuery: (self as! Query), appData: self.appData, descriptor: nil)
    }
    
    public func elements(_ code: OSType) -> Self.MultipleObjectSpecifierType {
        return Self.MultipleObjectSpecifierType(wantType: NSAppleEventDescriptor(typeCode: code),
                                                selectorForm: _formAbsolutePositionDesc, selectorData: _kAEAllDesc,
                                                parentQuery: (self as! Query), appData: self.appData, descriptor: nil)
    }
    
    public func elements(_ code: String) -> Self.MultipleObjectSpecifierType {
        let want: NSAppleEventDescriptor, data: Any
        do {
            want = NSAppleEventDescriptor(typeCode: try fourCharCode(code))
            data = _kAEAllDesc
        } catch {
            want = NSAppleEventDescriptor.null()
            data = error
        } 
        return Self.MultipleObjectSpecifierType(wantType: want,
                                                selectorForm: _formAbsolutePositionDesc, selectorData: data,
                                                parentQuery: (self as! Query), appData: self.appData, descriptor: nil)
    }

    
    // relative position selectors
    public func previous(_ elementClass: Symbol? = nil) -> Self.ObjectSpecifierType {
        return Self.ObjectSpecifierType(wantType: elementClass == nil ? self.wantType : elementClass!.descriptor,
                                        selectorForm: _formRelativePositionDesc, selectorData: _kAEPreviousDesc,
                                        parentQuery: (self as! Query), appData: self.appData, descriptor: nil)
    }
    
    public func next(_ elementClass: Symbol? = nil) -> Self.ObjectSpecifierType {
        return Self.ObjectSpecifierType(wantType: elementClass == nil ? self.wantType : elementClass!.descriptor,
                                        selectorForm: _formRelativePositionDesc, selectorData: _kAENextDesc,
                                        parentQuery: (self as! Query), appData: self.appData, descriptor: nil)
    }
    
    // insertion specifiers
    public var beginning: Self.InsertionSpecifierType {
        return Self.InsertionSpecifierType(insertionLocation: _kAEBeginningDesc,
                                           parentQuery: (self as! Query), appData: self.appData, descriptor: nil)
    }
    public var end: Self.InsertionSpecifierType {
        return Self.InsertionSpecifierType(insertionLocation: _kAEEndDesc,
                                           parentQuery: (self as! Query), appData: self.appData, descriptor: nil)
    }
    public var before: Self.InsertionSpecifierType {
        return Self.InsertionSpecifierType(insertionLocation: _kAEBeforeDesc,
                                           parentQuery: (self as! Query), appData: self.appData, descriptor: nil)
    }
    public var after: Self.InsertionSpecifierType {
        return Self.InsertionSpecifierType(insertionLocation: _kAEAfterDesc,
                                           parentQuery: (self as! Query), appData: self.appData, descriptor: nil)
    }
    
    public var all: Self.MultipleObjectSpecifierType { // TO DO: this is rather nasty; check it works but best not to document it
        if self.selectorForm.typeCodeValue == _formPropertyID {
            return Self.MultipleObjectSpecifierType(wantType: self.selectorData as! NSAppleEventDescriptor,
                                                    selectorForm: _formAbsolutePositionDesc, selectorData: _kAEAllDesc,
                                                    parentQuery: self.parentQuery, appData: self.appData, descriptor: nil)
        } else if self.selectorForm.typeCodeValue == _formAbsolutePosition
                && (self.selectorData as? NSAppleEventDescriptor)?.enumCodeValue == _kAEAll,
                let specifier = self as? Self.MultipleObjectSpecifierType {
            return specifier
        } else {
            let error = AutomationError(code: 1, message: "Invalid specifier: \(self).all")
            return Self.MultipleObjectSpecifierType(wantType: self.wantType,
                                                    selectorForm: _formAbsolutePositionDesc, selectorData: error,
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
        if let desc = self.selectorData as? NSAppleEventDescriptor,
                desc.descriptorType == _typeAbsoluteOrdinal && desc.enumCodeValue == _kAEAll {
            return self.parentQuery
        } else {
            return self as! Query
        }
    }
    
    // by-index, by-name, by-test
    public subscript(index: Any) -> Self.ObjectSpecifierType {
        var form: NSAppleEventDescriptor
        switch (index) {
        case is TestClause:
            return self[index as! TestClause]
        case is String:
            form = _formNameDesc
        default:
            form = _formAbsolutePositionDesc
        }
        return Self.ObjectSpecifierType(wantType: self.wantType,
                                        selectorForm: form, selectorData: index,
                                        parentQuery: self.baseQuery, appData: self.appData, descriptor: nil)
    }

    public subscript(test: TestClause) -> Self.MultipleObjectSpecifierType {
        return Self.MultipleObjectSpecifierType(wantType: self.wantType,
                                                selectorForm: _formTestDesc, selectorData: test,
                                                parentQuery: self.baseQuery, appData: self.appData, descriptor: nil)
    }
    
    // by-name, by-id, by-range
    public func named(_ name: Any) -> Self.ObjectSpecifierType { // use this if name is not a String, else use subscript // TO DO: trying to think of a use case where this has ever been found necessary; DELETE? (see also TODOs on whether or not to add an explicit `all` selector property)
        return Self.ObjectSpecifierType(wantType: self.wantType,
                                        selectorForm: _formNameDesc, selectorData: name,
                                        parentQuery: self.baseQuery, appData: self.appData, descriptor: nil)
    }
    public func ID(_ id: Any) -> Self.ObjectSpecifierType {
        return Self.ObjectSpecifierType(wantType: self.wantType,
                                        selectorForm: _formUniqueIDDesc, selectorData: id,
                                        parentQuery: self.baseQuery, appData: self.appData, descriptor: nil)
    }
    public subscript(from: Any, to: Any) -> Self.MultipleObjectSpecifierType {
        // caution: by-range specifiers must be constructed as `elements[from,to]`, NOT `elements[from...to]`, as `Range<T>` types are not supported
        // Note that while the `x...y` form _could_ be supported (via the SelfPacking protocol, since Ranges are generics), the `x..<y` form is problematic as it doesn't have a direct analog in Apple events (which are always inclusive of both start and end points). Automatically mapping `x..<y` to `x...y.previous()` is liable to cause its own set of problems, e.g. some apps may fail to resolve this more complex query correctly/at all), and it's hard to justify the additional complexity of having two different ways of constructing ranges, one of which brings various caveats and limitations, and the more complicated user documentation that will inevitably require.
        // Another concern is that supporting 'standard' Range syntax will further encourage users to lapse into using Swift-style zero-indexing (e.g. `0..<3`) instead of the correct Apple event one-indexing (`1 thru 3`) – it'll be hard enough keeping them right when using the single-element by-index syntax (where `elements[0]` is a common user error, and - worse - one that CocoaScripting intentionally indulges instead of reporting as an error, so that both `elements[0]` and `elements[1]` actually refer to the _same_ element, not consecutive elements as expected).
        return Self.MultipleObjectSpecifierType(wantType: self.wantType,
                                                selectorForm: _formRangeDesc,
                                                selectorData: RangeSelector(start: from, stop: to, wantType: self.wantType),
                                                parentQuery: self.baseQuery, appData: self.appData, descriptor: nil)
    }
    
    // by-ordinal
    public var first: Self.ObjectSpecifierType {
        return Self.ObjectSpecifierType(wantType: self.wantType,
                                        selectorForm: _formAbsolutePositionDesc, selectorData: _kAEFirstDesc,
                                        parentQuery: self.baseQuery, appData: self.appData, descriptor: nil)
    }
    public var middle: Self.ObjectSpecifierType {
        return Self.ObjectSpecifierType(wantType: self.wantType,
                                        selectorForm: _formAbsolutePositionDesc, selectorData: _kAEMiddleDesc,
                                        parentQuery: self.baseQuery, appData: self.appData, descriptor: nil)
    }
    public var last: Self.ObjectSpecifierType {
        return Self.ObjectSpecifierType(wantType: self.wantType,
                                        selectorForm: _formAbsolutePositionDesc, selectorData: _kAELastDesc,
                                        parentQuery: self.baseQuery, appData: self.appData, descriptor: nil)
    }
    public var any: Self.ObjectSpecifierType {
        return Self.ObjectSpecifierType(wantType: self.wantType,
                                        selectorForm: _formAbsolutePositionDesc, selectorData: _kAEAnyDesc,
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


