//
//  TermTypes.swift
//  SwiftAutomation
//
//

import Foundation
import AppleEvents


public class TerminologyError: AutomationError {
    public init(_ message: String, cause: Error? = nil) {
        super.init(code: errOSACorruptTerminology, message: message, cause: cause)
    }
}


public protocol ApplicationTerminology { // GlueTable.add() accepts any object that adopts this protocol (normally AETEParser/SDEFParser, but a dynamic bridge could also use this to reimport previously exported tables to which manual corrections have been made)
    var types: [KeywordTerm] {get}
    var enumerators: [KeywordTerm] {get}
    var properties: [KeywordTerm] {get}
    var elements: [ClassTerm] {get}
    var commands: [CommandTerm] {get}
}


// TO DO: get rid of Term classes? (problem with using enum/structs is that GlueTable needs to update terms' names in situ when disambiguating conflicting definitions); FWIW, all this compatibility crap is only needed when parsing AETE/SDEF due to lack of rigid spec and verifier tools; superseding these formats with a real IDL would greatly simplify glue generation


public class Term { // base class for keyword and command definitions
    
    public var name: String // editable as GlueTable may need to escape names to disambiguate conflicting terms
    
    init(name: String) {
        self.name = name
    }
}


public class KeywordTerm: Term, Hashable, CustomStringConvertible { // type/enumerator/property/element/parameter name
    
    public let code: OSType
    
    public init(name: String, code: OSType) {
        self.code = code
        super.init(name: name)
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(Int(self.code))
    }
    
    public var description: String { return "<\(type(of:self)):\(self.name)=\(literalFourCharCode(self.code))>" }
    
    public static func ==(lhs: KeywordTerm, rhs: KeywordTerm) -> Bool {
        return lhs.code == rhs.code && lhs.name == rhs.name
    }
}


public class ClassTerm: KeywordTerm {
    
    public var singular: String
    public var plural: String
    
    public init(singular: String, plural: String, code: OSType) {
        self.singular = singular
        self.plural = plural
        super.init(name: self.singular, code: code)
    }
}


public class CommandTerm: Term, Hashable, CustomStringConvertible {

    public let event: EventIdentifier
    public let parameters: [KeywordTerm]

    public init(name: String, event: EventIdentifier, parameters: [KeywordTerm]) {
        self.event = event
        self.parameters = parameters
        super.init(name: name)
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.event)
    }
    
    public static func ==(lhs: CommandTerm, rhs: CommandTerm) -> Bool {
        return lhs.event == rhs.event && lhs.name == rhs.name && lhs.parameters == rhs.parameters // TO DO: ignore parameters?
    }
    
    public var description: String {
        let params = self.parameters.map({"\($0.name)=\(literalFourCharCode($0.code))"}).joined(separator: ",")
        return "<Command:\(self.name)=\(literalEightCharCode(self.event))(\(params))>"
    }
    
    public func parameter(for name: String) -> KeywordTerm? {
        return self.parameters.first{ $0.name == name }
    }
    public func parameter(for code: OSType) -> KeywordTerm? {
        return self.parameters.first{ $0.code == code }
    }
    
}




