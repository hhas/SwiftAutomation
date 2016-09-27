//
//  Symbol.swift
//  SwiftAutomation
//
//
//  Represents typeType/typeEnumerated/typeProperty/typeKeyword descriptors. Static glues subclass this to add static vars representing each type/enum/property keyword defined by the application dictionary.
//
//  Also used to represent string-based record keys (where type=0 and name!=nil) when unpacking an AERecord's keyASUserRecordFields property, allowing the resulting dictionary to hold any mixture of terminology- (keyword) and user-defined (string) keys while typed as [Symbol:Any].
//

import Foundation


let noOSType: OSType = 0 // valid OSTypes should always be non-zero, so just use 0 instead of nil to indicate omitted OSType and avoid the extra Optional<OSType> boxing/unboxing


open class Symbol: Hashable, Equatable, CustomStringConvertible, SelfPacking {
    
    private var _descriptor: NSAppleEventDescriptor?
    public let name: String?, code: OSType, type: OSType
    
    open var typeAliasName: String {return "Symbol"} // provides prefix used in description var; glue subclasses override this with their own strings (e.g. "FIN" for Finder)
    
    public required init(name: String?, code: OSType, type: OSType = typeType, descriptor: NSAppleEventDescriptor? = nil) {
        self.name = name
        self.code = code
        self.type = type
        self._descriptor = descriptor
    }
    
    // special constructor for string-based record keys (avoids the need to wrap dictionary keys in a `StringOrSymbol` enum when unpacking)
    // e.g. the AppleScript record `{name:"Bob", isMyUser:true}` maps to the Swift Dictionary `[Symbol.name:"Bob", Symbol("isMyUser"):true]`
    
    public convenience init(_ name: String, descriptor: NSAppleEventDescriptor? = nil) {
        self.init(name: name, code: noOSType, type: noOSType, descriptor: descriptor)
    }
    
    // convenience constructors for creating Symbols using raw four-char codes
    
    public convenience init(code: String, type: String = "type") {
        self.init(name: nil, code: UTGetOSTypeFromString(code as CFString), type: UTGetOSTypeFromString(type as CFString))
    }
    
    public convenience init(code: OSType, type: OSType = typeType) {
        self.init(name: nil, code: code, type: type)
    }
    
    // this is called by AppData when unpacking typeType, typeEnumerated, etc; glue-defined symbol subclasses should override to return glue-defined symbols where available
    open class func symbol(code: OSType, type: OSType = typeType, descriptor: NSAppleEventDescriptor? = nil) -> Symbol {
        return self.init(name: nil, code: code, type: type, descriptor: descriptor)
    }
    
    // this is called by AppData when unpacking string-based record keys
    public class func symbol(string: String, descriptor: NSAppleEventDescriptor? = nil) -> Symbol {
        return self.init(name: string, code: noOSType, type: noOSType, descriptor: descriptor)
    }
    
    //
    
    public var description: String {
        if let name = self.name {
            return self.nameOnly ? "\(self.typeAliasName)(\(quoteString(name)))" : "\(self.typeAliasName).\(name)"
        } else {
            return "\(self.typeAliasName)(code:\(formatFourCharCodeString(self.code)),type:\(formatFourCharCodeString(self.type)))"
        }
    }
    
    public var hashValue: Int {return self.nameOnly ? self.name!.hashValue : Int(self.code)}
    
    public var descriptor: NSAppleEventDescriptor { // used by SwiftAutomation_packSelf and previous()/next() selectors  
        if self._descriptor == nil {
            if self.nameOnly {
                self._descriptor = NSAppleEventDescriptor(string: self.name!)
            } else {
                self._descriptor = NSAppleEventDescriptor(type: self.type, code: self.code)
            }
        }
        return self._descriptor!
    }
    
    // returns true if Symbol contains name but not code (i.e. it represents a string-based record property key)
    public var nameOnly: Bool { return self.type == noOSType && self.name != nil }
        
    public func SwiftAutomation_packSelf(_ appData: AppData) throws -> NSAppleEventDescriptor {
        return self.descriptor
    }
}



public func ==(lhs: Symbol, rhs: Symbol) -> Bool {
    // note: operands are not required to be the same subclass as this compares for AE equality only, e.g.:
    //
    //    TED.document == AESymbol(code: "docu") -> true
    //
    return lhs.nameOnly && rhs.nameOnly ? lhs.name == rhs.name : lhs.code == rhs.code // TO DO: also compare AE types?
}


