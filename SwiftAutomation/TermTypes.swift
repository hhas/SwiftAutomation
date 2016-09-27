//
//  TermTypes.swift
//  SwiftAutomation
//
//

import Foundation



public class TerminologyError: SwiftAutomationError {
    public init(_ message: String) {
        super.init(code: errOSACorruptTerminology, message: message)
    }
}


public typealias KeywordTerms = [KeywordTerm] // note: semi-conflicting terms are disambiguated based on order of appearance
public typealias CommandTerms = [CommandTerm]

public protocol ApplicationTerminology {
    var types: KeywordTerms {get}
    var enumerators: KeywordTerms {get}
    var properties: KeywordTerms {get}
    var elements: KeywordTerms {get}
    var commands: CommandTerms {get}
}




public enum TermType {
    case elementOrType
    case enumerator
    case property
    case command
    case parameter
}


// TO DO: use structs?

public class Term {

    public var name: String // editable as clients may need to escape names to disambiguate conflicting terms // TO DO: safer solution?
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
}

public func ==(lhs: KeywordTerm, rhs: KeywordTerm) -> Bool {
    return lhs.kind == rhs.kind && lhs.code == rhs.code && lhs.name == rhs.name
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
}

public func ==(lhs: CommandTerm, rhs: CommandTerm) -> Bool {
    return lhs.eventClass == rhs.eventClass && lhs.eventID == rhs.eventID
        && lhs.name == rhs.name && lhs.parametersByCode == rhs.parametersByCode
}


