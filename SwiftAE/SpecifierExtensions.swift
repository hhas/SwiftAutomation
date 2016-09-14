//
//  SpecifierExtensions.swift
//  SwiftAE
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

import Foundation


// TO DO: would be useful if Application classes could provide information on the current targeted process (full path, PID), esp for troubleshooting (note: it might be sufficient to put these properties on AppData and let users dig it out from there; this would also minimize namespace pollution and reduce the likelihood of conflicts with dictionary-defined vars/funcs added by glue generator)



/******************************************************************************/
// Property/single-element specifier; identifies an attribute/describes a one-to-one relationship between nodes in the app's AEOM graph

public protocol ObjectSpecifierExtension: ObjectSpecifierProtocol {
    associatedtype InsertionSpecifierType: InsertionSpecifier
    associatedtype ObjectSpecifierType: ObjectSpecifier
    associatedtype ElementsSpecifierType: ObjectSpecifier
}

public extension ObjectSpecifierExtension {

    public func userProperty(_ name: String) -> ObjectSpecifierType {
        return ObjectSpecifierType(wantType: gPropertyType,
				selectorForm: gUserPropertyForm, selectorData: NSAppleEventDescriptor(string: name),
				parentSelector: (self as! Selector), appData: self.appData, cachedDesc: nil)
    }

    public func property(_ code: OSType) -> ObjectSpecifierType {
		return ObjectSpecifierType(wantType: gPropertyType,
				selectorForm: gPropertyForm, selectorData: NSAppleEventDescriptor(typeCode: code),
				parentSelector: (self as! Selector), appData: self.appData, cachedDesc: nil)
    }
    
    public func property(_ code: String) -> ObjectSpecifierType { // caution: string must be valid four-char code; if not, 0x00000000 is used
		return self.property(FourCharCodeUnsafe(code)) // TO DO: use FourCharCode()throws, capturing error in custom root specifier to be rethrown if/when specifier is used in a command?
    }
    
    public func elements(_ code: OSType) -> ElementsSpecifierType {
        return ElementsSpecifierType(wantType: NSAppleEventDescriptor(typeCode: code),
                selectorForm: gAbsolutePositionForm, selectorData: gAll,
                parentSelector: (self as! Selector), appData: self.appData, cachedDesc: nil)
    }
    
    public func elements(_ code: String) -> ElementsSpecifierType { // caution: string must be valid four-char code; if not, 0x00000000 is used
        return self.elements(FourCharCodeUnsafe(code)) // TO DO: ditto?
    }

    
    // relative position selectors
    public func previous(_ elementClass: Symbol? = nil) -> ObjectSpecifierType {
        return ObjectSpecifierType(wantType: elementClass == nil ? self.wantType : elementClass!.descriptor,
				selectorForm: gRelativePositionForm, selectorData: gPrevious,
				parentSelector: (self as! Selector), appData: self.appData, cachedDesc: nil)
    }
    
    public func next(_ elementClass: Symbol? = nil) -> ObjectSpecifierType {
        return ObjectSpecifierType(wantType: elementClass == nil ? self.wantType : elementClass!.descriptor,
				selectorForm: gRelativePositionForm, selectorData: gNext,
				parentSelector: (self as! Selector), appData: self.appData, cachedDesc: nil)
    }
    
    // insertion specifiers
    public var beginning: InsertionSpecifierType {
        return InsertionSpecifierType(insertionLocation: gBeginning, parentSelector: (self as! Selector), appData: self.appData, cachedDesc: nil)
    }
    public var end: InsertionSpecifierType {
        return InsertionSpecifierType(insertionLocation: gEnd, parentSelector: (self as! Selector), appData: self.appData, cachedDesc: nil)
    }
    public var before: InsertionSpecifierType {
        return InsertionSpecifierType(insertionLocation: gBefore, parentSelector: (self as! Selector), appData: self.appData, cachedDesc: nil)
    }
    public var after: InsertionSpecifierType {
        return InsertionSpecifierType(insertionLocation: gAfter, parentSelector: (self as! Selector), appData: self.appData, cachedDesc: nil)
    }
}


/******************************************************************************/
// Multi-element specifier; represents a one-to-many relationship between nodes in the app's AEOM graph

public protocol ElementsSpecifierExtension: ObjectSpecifierExtension {}

extension ElementsSpecifierExtension {

    // Note: calling an element[s] selector on an all-elements specifier effectively replaces its original gAll selector data with the new selector data, instead of extending the specifier chain. This ensures that applying any selector to `elements[all]` produces `elements[selector]` (effectively replacing the existing selector), while applying a second selector to `elements[selector]` produces `elements[selector][selector2]` (appending the second selection to the first) as normal; e.g. `first document whose modified is true` would be written as `documents[Its.modified==true].first`.
    var baseQuery: Selector {
        return self.selectorData as? NSAppleEventDescriptor === gAll ? self.parentSelector : (self as! Selector)
    } // TO DO: fix (Q. is this TODO still relevant?)
    
    // by-index, by-name, by-test
    public subscript(index: Any) -> ObjectSpecifierType { // TO DO: make sure this doesn't receive TestClause
        var form: NSAppleEventDescriptor
        switch (index) {
        case is TestClause:
            print("FAIL: TestClause was handled by subscript(index:) instead of subscript(test:)") // make sure this never happens; if it does, will need to rethink design (in theory it shouldn't, since we'd expect Swift to match the _most_ specific overload, not the least specific; in practice...)
            form = gTestForm
        case is String:
            form = gNameForm
        default:
            form = gAbsolutePositionForm
        }
        return ObjectSpecifierType(wantType: self.wantType, selectorForm: form, selectorData: index,
            parentSelector: self.baseQuery, appData: self.appData, cachedDesc: nil)
    }

    public subscript(test: TestClause) -> ElementsSpecifierType {
        return ElementsSpecifierType(wantType: self.wantType, selectorForm: gTestForm, selectorData: test,
            parentSelector: self.baseQuery, appData: self.appData, cachedDesc: nil)
    }
    
    // by-name, by-id, by-range
    public func named(_ name: Any) -> ObjectSpecifierType { // use this if name is not a String, else use subscript // TO DO: trying to think of a use case where this has been found necessary
        return ObjectSpecifierType(wantType: self.wantType, selectorForm: gNameForm, selectorData: name,
            parentSelector: self.baseQuery, appData: self.appData, cachedDesc: nil)
    }
    public func ID(_ id: Any) -> ObjectSpecifierType {
        return ObjectSpecifierType(wantType: self.wantType, selectorForm: gUniqueIDForm, selectorData: id,
            parentSelector: self.baseQuery, appData: self.appData, cachedDesc: nil)
    }
    public subscript(from: Any, to: Any) -> ElementsSpecifierType {
        return ElementsSpecifierType(wantType: self.wantType, selectorForm: gRangeForm,
            selectorData: RangeSelector(start: from, stop: to, wantType: self.wantType),
            parentSelector: self.baseQuery, appData: self.appData, cachedDesc: nil)
    }
    
    // by-ordinal
    public var first: ObjectSpecifierType {
        return ObjectSpecifierType(wantType: self.wantType, selectorForm: gAbsolutePositionForm, selectorData: gFirst,
                parentSelector: self.baseQuery, appData: self.appData, cachedDesc: nil)
    }
    public var middle: ObjectSpecifierType {
        return ObjectSpecifierType(wantType: self.wantType, selectorForm: gAbsolutePositionForm, selectorData: gMiddle,
                parentSelector: self.baseQuery, appData: self.appData, cachedDesc: nil)
    }
    public var last: ObjectSpecifierType {
        return ObjectSpecifierType(wantType: self.wantType, selectorForm: gAbsolutePositionForm, selectorData: gLast,
                parentSelector: self.baseQuery, appData: self.appData, cachedDesc: nil)
    }
    public var any: ObjectSpecifierType {
        return ObjectSpecifierType(wantType: self.wantType, selectorForm: gAbsolutePositionForm, selectorData: gAny,
                parentSelector: self.baseQuery, appData: self.appData, cachedDesc: nil)
    }
}




public protocol RootSpecifierExtension: ObjectSpecifierExtension {
    init(rootObject: Any, appData: AppData)
    static var untargetedAppData: AppData {get}
}


public protocol ApplicationExtension: RootSpecifierExtension {}

extension ApplicationExtension {
    
//    public var targetApplication: TargetApplication {return self.appData.target} // TO DO: include this? (might be useful to user for troubleshooting); what about processID (if local)?
    
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
    
    public func customRoot(_ object: Any) -> Self { // TO DO: should AppData also provide an option to set default app root object, to be used in building and unpacking _all_ object specifiers?
        return type(of: self).init(rootObject: object, appData: self.appData)
    }
}


