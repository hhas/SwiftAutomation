//
//  Symbol.swift
//  SwiftAutomation
//
//

import Foundation


// TO DO: one disadvantage of using class rather than enum is that dictionary keys have to be written longhand, e.g. `FIN.name` rather than `.name`; the flipside is that enums are ostensibly finite whereas AE types/enums/properties can be any OSType; that said, non-glue-defined AE types could be represented by parameterized cases, e.g. `.custom(String)`, `.code(OSType)`


let noOSType: OSType = 0 // valid OSTypes should always be non-zero, so just use 0 instead of nil to indicate omitted OSType and avoid the extra Optional<OSType> boxing/unboxing


open class Symbol: Hashable, Equatable, CustomStringConvertible, SelfPacking {
    
    private var cachedDesc: NSAppleEventDescriptor?
    public let name: String?, code: OSType, type: OSType
    
    open var typeAliasName: String {return "Symbol"} // provides prefix used in description var; glue subclasses override this with their own strings (e.g. "FIN" for Finder)
    
    // important: if type=0 and name!=nil, treat as name-only symbol (used to represent a string-based record key)
    
    public required init(name: String?, code: OSType, type: OSType = typeType, cachedDesc: NSAppleEventDescriptor? = nil) { // TO DO: for naming consistency, rename cachedDesc: to descriptor:
        self.name = name
        self.code = code
        self.type = type
        self.cachedDesc = cachedDesc
    }
    
    // special constructor for string-based record keys (avoids the need to wrap dictionary keys in a `StringOrSymbol` enum when unpacking)
    // e.g. the AppleScript record `{name:"Bob", isMyUser:true}` maps to the Swift Dictionary `[Symbol.name:"Bob", Symbol("isMyUser"):true]`
    
    public convenience init(_ name: String, cachedDesc: NSAppleEventDescriptor? = nil) {
        self.init(name: name, code: noOSType, type: noOSType, cachedDesc: cachedDesc)
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
        return self.init(name: nil, code: code, type: type, cachedDesc: descriptor)
    }
    
    // this is called by AppData when unpacking string-based record keys
    public class func symbol(string: String, descriptor: NSAppleEventDescriptor? = nil) -> Symbol {
        return self.init(name: string, code: noOSType, type: noOSType, cachedDesc: descriptor)
    }
    
    public var hashValue: Int {return self.nameOnly ? self.name!.hashValue : Int(self.code)}
    
    public var description: String {
        if let name = self.name {
            return self.nameOnly ? "\(self.typeAliasName)(\(quoteString(name)))" : "\(self.typeAliasName).\(name)"
        } else {
            return "\(self.typeAliasName)(code:\(formatFourCharCodeString(self.code)),type:\(formatFourCharCodeString(self.type)))"
        }
    }
    
    // returns true if Symbol contains name but not code (i.e. it represents a string-based record property key)
    public var nameOnly: Bool { return self.type == noOSType && self.name != nil }
    
    // TO DO: implement overrideable SwiftAutomation_unpackSelf static method for unpacking descs as glue-defined (and/or standard) Symbols? (Q. what benefit would this provide? glue-specific Symbol subclasses already have to be stored in AppData.glueClasses)
    
    public func SwiftAutomation_packSelf(_ appData: AppData) throws -> NSAppleEventDescriptor {
        return self.descriptor
    }
    
    public var descriptor: NSAppleEventDescriptor { // TO DO: problem is ObjectSpecifier.previous()/.next() methods require a 4CC to construct themselves, so they can't call SwiftAutomation_packSelf as they may not have an AppData object to give, nor can they throw errors themselves if packing fails; a solution might be for prev/next specifiers to cache the original Symbol instance themselves, and use that
        if self.cachedDesc == nil {
            if self.nameOnly {
                self.cachedDesc = NSAppleEventDescriptor(string: self.name!)
            } else {
                self.cachedDesc = FourCharCodeDescriptor(self.type, self.code)
            }
        }
        return self.cachedDesc!
    }
}



public func ==(lhs: Symbol, rhs: Symbol) -> Bool { // TO DO: should this be generic? (if it is, how should it handle cases where one operand is a standard Symbol and other operand is a glue-defined PREFIXSymbol?)
    return lhs.nameOnly && rhs.nameOnly ? lhs.name == rhs.name : lhs.code == rhs.code
}


