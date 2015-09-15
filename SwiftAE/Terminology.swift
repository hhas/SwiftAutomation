//
//  Terminology.swift
//  SwiftAE
//
//

import Foundation


public enum TermType {
    case Type // type or element name
    case Enumerator
    case Property
    case Command
    case Parameter
}


// TO DO: use structs?

public class Term {

    public let name: String
    public let kind: TermType

    init(name: String, kind: TermType) {
        self.name = name
        self.kind = kind
    }
}

// TO DO: CustomStringConvertible (for debugging purposes)

public class KeywordTerm: Term, Hashable { // type/enumerator/property/element/parameter name

    public let code: OSType
    
    init(name: String, kind: TermType, code: OSType) {
        self.code = code
        super.init(name: name, kind: kind)
    }
    
    public var hashValue: Int { return Int(code) }
    
//    public var description: String { return "KeywordTerm" }

}

public func ==(lhs: KeywordTerm, rhs: KeywordTerm) -> Bool {
    return lhs.kind == rhs.kind && lhs.code == rhs.code && lhs.name == rhs.name
}



public class CommandTerm : Term {

    public let eventClass: OSType
    public let eventID: OSType
    
    private(set) var parametersByName: [String: KeywordTerm]
    private(set) var parametersByCode: [OSType: KeywordTerm]
    private(set) var orderedParameters: [KeywordTerm]

    init(name: String, eventClass: OSType, eventID: OSType) {
        self.eventClass = eventClass
        self.eventID = eventID
        self.parametersByName = [String: KeywordTerm]()
        self.parametersByCode = [OSType: KeywordTerm]()
        self.orderedParameters = [KeywordTerm]()
        super.init(name: name, kind: .Command)
    }
    
    public var hashValue: Int { return Int(eventClass) - Int(eventID)}
    
//    var description: String { return "CommandTerm" } // self.name, (eventClass), (eventID), self.parameters
    
    func addParameter(name: String, code: OSType) {
        let paramDef = KeywordTerm(name: name, kind: .Parameter, code: code)
        self.parametersByName[name] = paramDef
        self.parametersByCode[code] = paramDef
        self.orderedParameters.append(paramDef)
    }
}

func ==(lhs: CommandTerm, rhs: CommandTerm) -> Bool {
    return lhs.eventClass == rhs.eventClass && lhs.eventID == rhs.eventID
        && lhs.name == rhs.name && lhs.orderedParameters == rhs.orderedParameters
}


