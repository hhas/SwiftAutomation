//
//  Symbol.swift
//  SwiftAE
//
//

import Foundation


// TO DO: implement typeCodeValue, enumCodeValue getters?


public class Symbol: Hashable, Equatable, CustomStringConvertible, SelfPacking {
    
    private var cachedDesc: NSAppleEventDescriptor?
    public let name: String?, code: OSType, type: OSType
    
    var typeAliasName: String {return "Symbol"}
    
    public required init(name: String?, code: OSType, type: OSType = typeType, cachedDesc: NSAppleEventDescriptor? = nil) { // TO DO: optional prefix? or is that something for glue subclasses to do? TO DO: name should also be optional, to allow raw codes; Q. should code be optional, to allow Symbol class to be used as-is in dynamic bridges? (problem here would be that initializer requires one or both; if neither given, an error must be raised; might be safest to provide separate convenience initializers for this, or poss. use a subclass that overrides packSelf for dynamic use; also see TODO on descriptor var below - suggest dynamic bridging is best ignored until it's time to cross it)
        self.name = name
        self.code = code
        self.type = type
        self.cachedDesc = cachedDesc
    }
    
    // convenience constructors for creating Symbols using raw four-char codes
    
    public convenience init(code: String, type: String = "type") {
        self.init(name: nil, code: UTGetOSTypeFromString(code), type: UTGetOSTypeFromString(type))
    }
    
    public convenience init(code: OSType, type: OSType = typeType) {
        self.init(name: nil, code: code, type: type)
    }
    
    // this is called by AppData when unpacking typeType, typeEnumerated, etc; glue-defined symbol subclasses should override to return glue-defined symbols where available
    public class func symbol(_ code: OSType, type: OSType = typeType, descriptor: NSAppleEventDescriptor? = nil) -> Symbol {
        return self.init(name: nil, code: code, type: type, cachedDesc: descriptor)
    }
    
    public var description: String {
        if let name = self.name {
            return "\(self.typeAliasName).\(name)"
        } else {
            return "\(self.dynamicType)(code:\(formatFourCharCodeString(self.code)),type:\(formatFourCharCodeString(self.type)))"
        }
    }
    
    // TO DO: implement overrideable class method for unpacking descs as glue-defined (and/or standard) Symbols
    
    public func packSelf(_ appData: AppData) throws -> NSAppleEventDescriptor {
        return self.descriptor
    }
    
    public var descriptor: NSAppleEventDescriptor { // TO DO: problem is ObjectSpecifier.previous()/.next() methods require a 4CC to construct themselves, so they can't call packSelf as they may not have an AppData object to give, nor can they throw errors themselves if packing fails; a solution might be for prev/next specifiers to cache the original Symbol instance themselves, and use that
        if cachedDesc == nil {
            cachedDesc = FourCharCodeDescriptor(type, code)
        }
        return cachedDesc!
    }
    
    public var hashValue: Int {return Int(self.code)}
    
    //    public let missingValue = Symbol(name: "missingValue", code: cMissingValue, type: typeType) // TO DO: use this or nil? (since this bridge is Swift-only, and idiomatic Swift APIs use Error, not nil, to indicate errors, inclined to use nil)
    
}



public func ==(lhs: Symbol, rhs: Symbol) -> Bool { // TO DO: should this be generic? (if it is, how should it handle cases where one operand is a standard Symbol and other operand is a glue-defined PREFIXSymbol?)
    return lhs.code == rhs.code
}


