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
//  and cannot be used standalone but only as part of a glue (a default AEGlue is included for convenience).
//

import Foundation


/******************************************************************************/
// Property/single-element specifier; identifies an attribute/describes a one-to-one relationship between nodes in the app's AEOM graph

public protocol ObjectSpecifierExtension: ObjectSpecifierProtocol {
    typealias InsertionSpecifierType: InsertionSpecifier
    typealias ObjectSpecifierType: ObjectSpecifier
    typealias ElementsSpecifierType: ObjectSpecifier
}

public extension ObjectSpecifierExtension {

    public func userProperty(name: String) -> ObjectSpecifierType {
        return ObjectSpecifierType(wantType: _PropertyType,
				selectorForm: _UserPropertyForm, selectorData: NSAppleEventDescriptor(string: name),
				parentSelector: (self as! Selector), appData: self.appData, cachedDesc: nil)
    }

    public func property(code: OSType) -> ObjectSpecifierType {
		return ObjectSpecifierType(wantType: _PropertyType,
				selectorForm: _PropertyForm, selectorData: NSAppleEventDescriptor(typeCode: code),
				parentSelector: (self as! Selector), appData: self.appData, cachedDesc: nil)
    }
    
    public func property(code: String) -> ObjectSpecifierType { // caution: string must be valid four-char code; if not, 0x00000000 is used
		return self.property(UTGetOSTypeFromString(code))
    }
    
    public func elements(code: OSType) -> ElementsSpecifierType {
        return ElementsSpecifierType(wantType: NSAppleEventDescriptor(typeCode: code),
                selectorForm: _AbsolutePositionForm, selectorData: _All,
                parentSelector: (self as! Selector), appData: self.appData, cachedDesc: nil)
    }
    
    public func elements(code: String) -> ElementsSpecifierType { // caution: string must be valid four-char code; if not, 0x00000000 is used
        return self.elements(UTGetOSTypeFromString(code))
    }

    
    // relative position selectors
    public func previous(elementClass: Symbol? = nil) -> ObjectSpecifierType {
        return ObjectSpecifierType(wantType: elementClass == nil ? self.wantType : elementClass!.descriptor,
				selectorForm: _RelativePositionForm, selectorData: _Previous,
				parentSelector: (self as! Selector), appData: self.appData, cachedDesc: nil)
    }
    
    public func next(elementClass: Symbol? = nil) -> ObjectSpecifierType {
        return ObjectSpecifierType(wantType: elementClass == nil ? self.wantType : elementClass!.descriptor,
				selectorForm: _RelativePositionForm, selectorData: _Next,
				parentSelector: (self as! Selector), appData: self.appData, cachedDesc: nil)
    }
    
    // insertion specifiers
    public var beginning: InsertionSpecifierType {
        return InsertionSpecifierType(insertionLocation: _Beginning, parentSelector: (self as! Selector), appData: self.appData, cachedDesc: nil)
    }
    public var end: InsertionSpecifierType {
        return InsertionSpecifierType(insertionLocation: _End, parentSelector: (self as! Selector), appData: self.appData, cachedDesc: nil)
    }
    public var before: InsertionSpecifierType {
        return InsertionSpecifierType(insertionLocation: _Before, parentSelector: (self as! Selector), appData: self.appData, cachedDesc: nil)
    }
    public var after: InsertionSpecifierType {
        return InsertionSpecifierType(insertionLocation: _After, parentSelector: (self as! Selector), appData: self.appData, cachedDesc: nil)
    }
}


/******************************************************************************/
// Multi-element specifier; represents a one-to-many relationship between nodes in the app's AEOM graph

public protocol ElementsSpecifierExtension: ObjectSpecifierExtension {}

extension ElementsSpecifierExtension {

    // Note: calling an element[s] selector on an all-elements specifier effectively replaces its original _All selector data with the new selector data, instead of extending the specifier chain. This ensures that applying any selector to `elements[all]` produces `elements[selector]` (effectively replacing the existing selector), while applying a second selector to `elements[selector]` produces `elements[selector][selector2]` (appending the second selection to the first) as normal; e.g. `first document whose modified is true` would be written as `documents[Its.modified==true].first`.
    var baseQuery: Selector { return self.selectorData as? AnyObject === _All ? self.parentSelector : (self as! Selector) } // TO DO: fix (Q. is this TODO still relevant?)
    
    // by-index, by-name, by-test
    public subscript(index: Any) -> ObjectSpecifierType { // TO DO: make sure this doesn't receive TestClause
        var form: NSAppleEventDescriptor
        switch (index) {
        case is TestClause:
            print("FAIL: TestClause was handled by subscript(index:) instead of subscript(test:)") // make sure this never happens; if it does, will need to rethink design (in theory it shouldn't, since we'd expect Swift to match the _most_ specific overload, not the least specific; in practice...)
            form = _TestForm
        case is String:
            form = _NameForm
        default:
            form = _AbsolutePositionForm
        }
        return ObjectSpecifierType(wantType: self.wantType, selectorForm: form, selectorData: index,
            parentSelector: self.baseQuery, appData: self.appData, cachedDesc: nil)
    }

    public subscript(test: TestClause) -> ElementsSpecifierType {
        return ElementsSpecifierType(wantType: self.wantType, selectorForm: _TestForm, selectorData: test,
            parentSelector: self.baseQuery, appData: self.appData, cachedDesc: nil)
    }
    
    // by-name, by-id, by-range
    public func named(name: Any) -> ObjectSpecifierType { // use this if name is not a String, else use subscript // TO DO: trying to think of a use case where this has been found necessary
        return ObjectSpecifierType(wantType: self.wantType, selectorForm: _NameForm, selectorData: name,
            parentSelector: self.baseQuery, appData: self.appData, cachedDesc: nil)
    }
    public func ID(id: Any) -> ObjectSpecifierType {
        return ObjectSpecifierType(wantType: self.wantType, selectorForm: _UniqueIDForm, selectorData: id,
            parentSelector: self.baseQuery, appData: self.appData, cachedDesc: nil)
    }
    public subscript(from: Any, to: Any) -> ElementsSpecifierType {
        return ElementsSpecifierType(wantType: self.wantType, selectorForm: _RangeForm,
            selectorData: RangeSelector(start: from, stop: to, wantType: self.wantType),
            parentSelector: self.baseQuery, appData: self.appData, cachedDesc: nil)
    }
    
    // by-ordinal
    public var first: ObjectSpecifierType {
        return ObjectSpecifierType(wantType: self.wantType, selectorForm: _AbsolutePositionForm, selectorData: _First,
                parentSelector: self.baseQuery, appData: self.appData, cachedDesc: nil)
    }
    public var middle: ObjectSpecifierType {
        return ObjectSpecifierType(wantType: self.wantType, selectorForm: _AbsolutePositionForm, selectorData: _Middle,
                parentSelector: self.baseQuery, appData: self.appData, cachedDesc: nil)
    }
    public var last: ObjectSpecifierType {
        return ObjectSpecifierType(wantType: self.wantType, selectorForm: _AbsolutePositionForm, selectorData: _Last,
                parentSelector: self.baseQuery, appData: self.appData, cachedDesc: nil)
    }
    public var any: ObjectSpecifierType {
        return ObjectSpecifierType(wantType: self.wantType, selectorForm: _AbsolutePositionForm, selectorData: _Any,
                parentSelector: self.baseQuery, appData: self.appData, cachedDesc: nil)
    }
}


