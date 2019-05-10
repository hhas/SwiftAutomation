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
import AppleEvents



open class Symbol: Hashable, Equatable, CustomStringConvertible, CustomDebugStringConvertible, CustomReflectable, SelfPacking {
    
    private var desc: ScalarDescriptor
    public let name: String?, type: DescType, code: OSType
    
    open var typeAliasName: String { return "Symbol" } // provides prefix used in description var; glue subclasses override this with their own strings (e.g. "FIN" for Finder)
    
    public required init(name: String?, code: OSType, type: OSType = AppleEvents.typeType, descriptor: ScalarDescriptor? = nil) {
        self.name = name
        self.code = code
        self.type = type
        self.desc = descriptor ?? (type == noOSType && name != nil ? packAsString(name!) : packAsFourCharCode(type: type, code: code))
    }

    // special constructor for string-based record keys (avoids the need to wrap dictionary keys in a `StringOrSymbol` enum when unpacking)
    // e.g. the AppleScript record `{name:"Bob", isMyUser:true}` maps to the Swift Dictionary `[Symbol.name:"Bob", Symbol("isMyUser"):true]`
    
    public convenience init(_ name: String) {
        self.init(name: name, code: noOSType, type: noOSType, descriptor: nil)
    }
    
    internal convenience init(_ name: String, descriptor: ScalarDescriptor) { // TO DO: needed?
        self.init(name: name, code: noOSType, type: noOSType, descriptor: descriptor)
    }
    
    // convenience constructors for creating Symbols using raw four-char codes
    
    public convenience init(code: String, type: String = "type") { // TO DO: use parseFourCharCode() instead, and make this throwing? (Q. why is 'type' a string, rather than enum/OSType?); might be better split into init(typeCode:String) and init(enumCode:String)
        self.init(name: nil, code: UTGetOSTypeFromString(code as CFString), type: UTGetOSTypeFromString(type as CFString)) // caution: UTGetOSTypeFromString silently fails (returns 0) for invalid strings
    }
    
    public convenience init(code: OSType, type: OSType = AppleEvents.typeType) {
        self.init(name: nil, code: code, type: type)
    }
    
    // this is called by AppData when unpacking typeType, typeEnumerated, etc; glue-defined symbol subclasses should override to return glue-defined symbols where available
    open class func symbol(code: OSType, type: OSType = AppleEvents.typeType, descriptor: ScalarDescriptor? = nil) -> Symbol {
        return self.init(name: nil, code: code, type: type, descriptor: descriptor)
    }
    
    // this is called by AppData when unpacking string-based record keys
    public class func symbol(string: String, descriptor: ScalarDescriptor? = nil) -> Symbol {
        return self.init(name: string, code: noOSType, type: noOSType, descriptor: descriptor)
    }
    
    // display
    
    public var description: String {
        if let name = self.name {
            return self.isNameOnly ? "\(self.typeAliasName)(\(name.debugDescription))" : "\(self.typeAliasName).\(name)"
        } else {
            return "\(self.typeAliasName)(code:\(literalFourCharCode(self.code)),type:\(literalFourCharCode(self.type)))"
        }
    }
    
    public var debugDescription: String { return self.description }
    
    public var customMirror: Mirror {
        let children: [Mirror.Child] = [(label: "description", value: self.description),
                                        (label: "name", value: self.name ?? ""),
                                        (label: "code", value: formatFourCharCode(self.code)),
                                        (label: "type", value: formatFourCharCode(self.type))]
        return Mirror(self, children: children, displayStyle: .`class`, ancestorRepresentation: .suppressed)
    }
    
    // packing
    
    public var descriptor: ScalarDescriptor { return self.desc } // TO DO: needed?
    
    // returns true if Symbol contains name but not code (i.e. it represents a string-based record property key)
    public var isNameOnly: Bool { return self.type == noOSType && self.name != nil }
    
    public func SwiftAutomation_packSelf(_ appData: AppData) throws -> Descriptor { // caller always takes ownership of pack() result
        return self.desc
    }
    
    // equatable, hashable
    
    public func hash(into hasher: inout Hasher) { // see also comments in `==()` below
        hasher.combine(self.isNameOnly ? self.name!.hashValue : Int(self.code))
    }

    
    public static func ==(lhs: Symbol, rhs: Symbol) -> Bool {
        // note: operands are not required to be the same subclass as this compares for AE equality only, e.g.:
        //
        //    TED.document == AESymbol(code: "docu") -> true
        //
        // note: AE types are also ignored on the [reasonable] assumption that any differences in descriptor type (e.g. typeType vs typeProperty) are irrelevant as apps will only care about the code itself
        return lhs.isNameOnly && rhs.isNameOnly ? lhs.name == rhs.name : lhs.code == rhs.code
    }
}




