//
//  TermTypes.swift
//  SwiftAutomation
//
//

import Foundation



public class TerminologyError: AutomationError {
    public init(_ message: String, cause: Error? = nil) {
        super.init(code: errOSACorruptTerminology, message: message, cause: cause)
    }
}


public protocol ApplicationTerminology { // GlueTable.add() accepts any object that adopts this protocol (normally AETEParser/SDEFParser, but a dynamic bridge could also use this to reimport previously exported tables to which manual corrections have been made)
    var types: [KeywordTerm] {get}
    var enumerators: [KeywordTerm] {get}
    var properties: [KeywordTerm] {get}
    var elements: [KeywordTerm] {get}
    var commands: [CommandTerm] {get}
}


public enum TermType {
    case elementOrType
    case enumerator
    case property
    case command
    case parameter
}


public class Term { // base class for keyword and command definitions

    public var name: String // editable as GlueTable may need to escape names to disambiguate conflicting terms
    public let kind: TermType

    init(name: String, kind: TermType) {
        self.name = name
        self.kind = kind
    }
}


public class KeywordTerm: Term, Hashable, CustomStringConvertible { // type/enumerator/property/element/parameter name

    public let code: OSType
    
    public init(name: String, kind: TermType, code: OSType) {
        self.code = code
        super.init(name: name, kind: kind)
    }
    
    public var hashValue: Int { return Int(self.code) }
    
    public var description: String { return "<\(self.kind):\(self.name)=\(fourCharCode(self.code))>" }
    
    public static func ==(lhs: KeywordTerm, rhs: KeywordTerm) -> Bool {
        return lhs.kind == rhs.kind && lhs.code == rhs.code && lhs.name == rhs.name
    }
}


public class CommandTerm: Term, Hashable, CustomStringConvertible {

    public let eventClass: OSType
    public let eventID: OSType
    
    private(set) var parametersByName: [String: KeywordTerm]
    private(set) var parametersByCode: [OSType: KeywordTerm]
    private(set) var orderedParameters: [KeywordTerm]

    public init(name: String, eventClass: OSType, eventID: OSType) {
        self.eventClass = eventClass
        self.eventID = eventID
        self.parametersByName = [String: KeywordTerm]()
        self.parametersByCode = [OSType: KeywordTerm]()
        self.orderedParameters = [KeywordTerm]()
        super.init(name: name, kind: .command)
    }
    
    public var hashValue: Int { return Int(self.eventClass) - Int(self.eventID)}
    
    public var description: String {
        let params = self.orderedParameters.map({"\($0.name)=\(fourCharCode($0.code))"}).joined(separator: ",")
        return "<Command:\(self.name)=\(fourCharCode(self.eventClass))\(fourCharCode(self.eventID))(\(params))>"
    }
    
    func addParameter(_ name: String, code: OSType) {
        let paramDef = KeywordTerm(name: name, kind: .parameter, code: code)
        self.parametersByName[name] = paramDef
        self.parametersByCode[code] = paramDef
        self.orderedParameters.append(paramDef)
    }
    
    public static func ==(lhs: CommandTerm, rhs: CommandTerm) -> Bool {
        return lhs.eventClass == rhs.eventClass && lhs.eventID == rhs.eventID
            && lhs.name == rhs.name && lhs.parametersByCode == rhs.parametersByCode
    }
}




