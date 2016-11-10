//
//  SDEFParser.swift
//  SwiftAutomation
//
//

// TO DO: what about synonym, xref?

// note: GlueTable will resolve any conflicts between built-in and app-defined name+code definitions

import Foundation
import Carbon

// TO DO: the following parseXXXCharCode() functions are currently defined as top level functions rather than private methods of SDEFParser as swift::TypeBase::getCanonicalType() crashes when the method's return type is OSType/UInt32 (though `(OSType,OSType)` works without problem)...another fine example of Swift's "seamless ObjC bridging" at work, no doubt. See if it'll distill down to a simple test case later on and submit bug report, assuming there isn't already one filed.

func parseFourCharCode(_ string: NSString) throws -> OSType { // class, property, enum, param, etc. code
    if string.length == 10 && (string.hasPrefix("0x") || string.hasPrefix("0X")) { // e.g. "0x00000001"
        guard let result = UInt32(string.substring(with: NSRange(location: 2, length: 8)), radix: 16) else {
            throw AutomationError(code: 1, message: "Invalid four-char code (bad representation): \(string.debugDescription)")
        }
        return result
    } else {
        return try fourCharCode(string as String)
    }
}
    
func parseEightCharCode(_ string: NSString) throws -> (OSType, OSType) { // eventClass and eventID code
    if string.length == 8 {
        return (try fourCharCode(string.substring(to: 4)), try fourCharCode(string.substring(from: 4)))
    } else if string.length == 18 && (string.hasPrefix("0x") || string.hasPrefix("0X")) { // e.g. "0x0123456701234567"
        guard let eventClass = UInt32(string.substring(with: NSRange(location: 2, length: 8)), radix: 16),
                let eventID = UInt32(string.substring(with: NSRange(location: 10, length: 8)), radix: 16) else {
            throw AutomationError(code: 1, message: "Invalid four-char code (bad representation): \(string.debugDescription)")
        }
        return (eventClass, eventID)
    } else {
        throw AutomationError(code: 1, message: "Invalid 'code' attribute (wrong length).")
    }
}


public class SDEFParser: NSObject, XMLParserDelegate, ApplicationTerminology {
    
    // SDEF names and codes are parsed into the following tables 
    public private(set) var types: [KeywordTerm] = []
    public private(set) var enumerators: [KeywordTerm] = []
    public private(set) var properties: [KeywordTerm] = []
    public private(set) var elements: [KeywordTerm] = []
    public var commands: [CommandTerm] { return Array(self.commandsDict.values) }
    
    private var commandsDict = [String:CommandTerm]()
    private var currentCommand: CommandTerm?
    private let keywordConverter: KeywordConverterProtocol
    private let errorHandler: (Error)->()
    
    public init(keywordConverter: KeywordConverterProtocol = defaultSwiftKeywordConverter,
                errorHandler: @escaping (Error)->() = { (error: Error) in print(error, to: &errStream) }) {
        self.keywordConverter = keywordConverter
        self.errorHandler = errorHandler
        super.init()
    }
    
    // used by didStartElement callback
    
    private func parseKeywordTerm(attributes: [String:String]) throws -> (String, OSType) {
        guard let name = attributes["name"], let codeString = attributes["code"] as NSString? else {
            throw TerminologyError("Missing 'name'/'code' attribute.")
        }
        if name == "" {
            throw TerminologyError("Empty 'name' attribute.")
        }
        do {
            return (name, try parseFourCharCode(codeString))
        } catch {
            throw TerminologyError("Invalid 'code' attribute (\(error)).")
        }
    }
    
    private func parseCommandTerm(attributes: [String:String]) throws -> (String, OSType, OSType) {
        guard let name = attributes["name"], let codeString = attributes["code"] as NSString? else {
            throw TerminologyError("Missing 'name'/'code' attribute.")
        }
        if name == "" {
            throw TerminologyError("Empty 'name' attribute.")
        }
        do {
            let (eventClass, eventID) = try parseEightCharCode(codeString)
            return (name, eventClass, eventID)
        } catch {
            throw TerminologyError("Invalid 'code' attribute (\(error)).")
        }
    }
    
    // NSXMLParser callbacks
    
    public func parser(_ parser: XMLParser, didStartElement tagName: String,
                       namespaceURI: String?, qualifiedName: String?, attributes: [String:String]) {
        do {
            switch tagName {
            case "class", "record-type", "value-type":
                let (name, code) = try self.parseKeywordTerm(attributes: attributes)
                self.types.append(KeywordTerm(name: self.keywordConverter.convertSpecifierName(name), kind: .elementOrType, code: code))
                if tagName == "class" { // use plural class name as elements name (if not given, append "s" to singular name) // TO DO: check SIG/SDEF spec, as appending 's' doesn't work so well for names already ending in 's' (e.g. 'print settings')
                    let plural = attributes["plural"] ?? ""
                    self.elements.append(KeywordTerm(name: self.keywordConverter.convertSpecifierName(plural == "" ? "\(name)s" : plural), kind: .elementOrType, code: code))
                }
            case "property":
                let (name, code) = try self.parseKeywordTerm(attributes: attributes)
                self.properties.append(KeywordTerm(name: self.keywordConverter.convertSpecifierName(name), kind: .property, code: code))
            case "enumerator":
                let (name, code) = try self.parseKeywordTerm(attributes: attributes)
                self.enumerators.append(KeywordTerm(name: self.keywordConverter.convertSpecifierName(name), kind: .enumerator, code: code))
            case "command", "event":
                let (name, eventClass, eventID) = try parseCommandTerm(attributes: attributes)
                // Note: overlapping command definitions (e.g. 'path to') should be processed as follows:
                // - If their names and codes are the same, only the last definition is used; other definitions are ignored
                //   and will not compile.
                // - If their names are the same but their codes are different, only the first definition is used; other
                //   definitions are ignored and will not compile.
                let previousDef = commandsDict[name]
                if previousDef == nil || (previousDef!.eventClass == eventClass && previousDef!.eventID == eventID) {
                    currentCommand = CommandTerm(name: self.keywordConverter.convertSpecifierName(name), eventClass: eventClass, eventID: eventID)
                    commandsDict[name] = currentCommand
                } else { // ignore duplicate declaration
                    currentCommand = nil
                }
            case "parameter":
                if let command = self.currentCommand {
                    let (name, code) = try self.parseKeywordTerm(attributes: attributes)
                    command.addParameter(self.keywordConverter.convertParameterName(name), code: code)
                }
            default:
                ()
            }
        } catch {
            self.errorHandler(TerminologyError("Malformed \(tagName) in SDEF.", cause: error))
        }
    }
    
    public func parser(_ parser: XMLParser, didEndElement tagName: String,
                       namespaceURI: String?, qualifiedName qName: String?) {
        if tagName == "command" || tagName == "event" { currentCommand = nil }
    }
    
    // parse the given SDEF XML data
    
    public func parse(_ sdef: Data) throws {
        let parser = XMLParser(data: sdef)
        parser.delegate = self
        if !parser.parse() {
            throw TerminologyError("An error occurred while parsing SDEF. \(parser.parserError)")
        }
    }
}


// convenience function

public func GetScriptingDefinition(_ url: URL) throws -> Data {
    var sdef: Unmanaged<CFData>?
    let err = OSACopyScriptingDefinitionFromURL(url as NSURL, 0, &sdef)
    if err != 0 {
        throw AutomationError(code: Int(err), message: "Can't retrieve SDEF.")
    }
    return sdef!.takeRetainedValue() as Data
}


