//
//  SDEFParser.swift
//  SwiftAutomation
//
//

// TO DO: what about synonym, xref?

// note: GlueTable will resolve any conflicts between built-in and app-defined name+code definitions


// TO DO: see if rewriting to use NSXMLDocument will take care of XInclude (there doesn't seem to be a convenience API for handling includes in SAX parser, and while adding support for simple includes shouldn't be hard some SDEF includes like to use xpointers as well, just to make the things even more insanely complex than they already are)


import Foundation
import Carbon



public class SDEFParser: ApplicationTerminology {
    
    // SDEF names and codes are parsed into the following tables
    public private(set) var types: [KeywordTerm] = []
    public private(set) var enumerators: [KeywordTerm] = []
    public private(set) var properties: [KeywordTerm] = []
    public private(set) var elements: [KeywordTerm] = []
    public var commands: [CommandTerm] { return Array(self.commandsDict.values) }
    
    private var commandsDict = [String:CommandTerm]()
    private let keywordConverter: KeywordConverterProtocol
    private let errorHandler: (Error)->()
    
    public init(keywordConverter: KeywordConverterProtocol = defaultSwiftKeywordConverter,
                errorHandler: @escaping (Error)->()) {
        self.keywordConverter = keywordConverter
        self.errorHandler = errorHandler // TO DO: currently unused (currently parse methods always throw); also, errorHandler should probably be throwable
    }
    
    // parse an OSType given as 4/8-character "MacRoman" string, or 10/18-character hex string
    
    func parse(fourCharCode string: NSString) throws -> OSType { // class, property, enum, param, etc. code
        if string.length == 10 && (string.hasPrefix("0x") || string.hasPrefix("0X")) { // e.g. "0x00000001"
            guard let result = UInt32(string.substring(with: NSRange(location: 2, length: 8)), radix: 16) else {
                throw AutomationError(code: 1, message: "Invalid four-char code (bad representation): \(string.debugDescription)")
            }
            return result
        } else {
            return try fourCharCode(string as String)
        }
    }
    
    func parse(eightCharCode string: NSString) throws -> (OSType, OSType) { // eventClass and eventID code
        if string.length == 8 {
            return (try fourCharCode(string.substring(to: 4)), try fourCharCode(string.substring(from: 4)))
        } else if string.length == 18 && (string.hasPrefix("0x") || string.hasPrefix("0X")) { // e.g. "0x0123456701234567"
            guard let eventClass = UInt32(string.substring(with: NSRange(location: 2, length: 8)), radix: 16),
                let eventID = UInt32(string.substring(with: NSRange(location: 10, length: 8)), radix: 16) else {
                    throw AutomationError(code: 1, message: "Invalid eight-char code (bad representation): \(string.debugDescription)")
            }
            return (eventClass, eventID)
        } else {
            throw AutomationError(code: 1, message: "Invalid eight-char code (wrong length): \((string as String).debugDescription)")
        }
    }
    
    // extract name and code attributes from a class/enumerator/command/etc XML element
    
    private func attribute(_ name: String, of element: XMLElement) -> String? {
        return element.attribute(forName: name)?.stringValue
    }
    
    private func parse(keywordElement element: XMLElement) throws -> (String, OSType) {
        guard let name = self.attribute("name", of: element), let codeString = self.attribute("code", of: element), name != "" else {
            throw TerminologyError("Missing 'name'/'code' attribute.")
        }
        return (name, try self.parse(fourCharCode: codeString as NSString))
    }
    
    private func parse(commandElement element: XMLElement) throws -> (String, OSType, OSType) {
        guard let name = self.attribute("name", of: element), let codeString = self.attribute("code", of: element), name != "" else {
            throw TerminologyError("Missing 'name'/'code' attribute.")
        }
        let (eventClass, eventID) = try self.parse(eightCharCode: codeString as NSString)
        return (name, eventClass, eventID)
    }
    
    //
    
    private func parse(typeOfElement element: XMLElement) throws -> (String, OSType) { // class, record-type, value-type
        let (name, code) = try self.parse(keywordElement: element)
        self.types.append(KeywordTerm(name: self.keywordConverter.convertSpecifierName(name), kind: .elementOrType, code: code))
        return (name, code)
    }
    
    private func parse(propertiesOfElement element: XMLElement) throws { // class, class-extension, record-value
        for element in element.elements(forName: "property") {
            let (name, code) = try self.parse(keywordElement: element)
            self.properties.append(KeywordTerm(name: self.keywordConverter.convertSpecifierName(name), kind: .property, code: code))
        }
    }
    
    // parse a class/enumerator/command/etc element of a dictionary suite
    
    func parse(definition node: XMLNode) throws {
        if let element = node as? XMLElement, let tagName = element.name {
            switch tagName {
            case "class":
                let (name, code) = try self.parse(typeOfElement: element)
                try self.parse(propertiesOfElement: element)
                // use plural class name as elements name (if not given, append "s" to singular name)
                // (note: record and value types also define plurals, but we only use plurals for element names and elements should always be classes, so we ignore those)
                let plural = element.attribute(forName: "plural")?.stringValue ?? "\(name)s" // note: the spec says to append 's' to name when plural attribute isn't given; in practice, appending 's' doesn't work so well for names already ending in 's' (e.g. 'print settings'), but that's the SDEF's problem
                self.elements.append(KeywordTerm(name: self.keywordConverter.convertSpecifierName(plural), kind: .elementOrType, code: code))
            case "class-extension":
                try self.parse(propertiesOfElement: element)
            case "record-type":
                let _ = try self.parse(typeOfElement: element)
                try self.parse(propertiesOfElement: element)
            case "value-type":
                let _ = try self.parse(typeOfElement: element)
            case "enumeration":
                for element in element.elements(forName: "enumerator") {
                    let (name, code) = try self.parse(keywordElement: element)
                    self.enumerators.append(KeywordTerm(name: self.keywordConverter.convertSpecifierName(name), kind: .enumerator, code: code))
                }
            case "command", "event":
                let (name, eventClass, eventID) = try self.parse(commandElement: element)
                // Note: overlapping command definitions (e.g. 'path to') should be processed as follows:
                // - If their names and codes are the same, only the last definition is used; other definitions are ignored
                //   and will not compile.
                // - If their names are the same but their codes are different, only the first definition is used; other
                //   definitions are ignored and will not compile.
                let previousDef = self.commandsDict[name]
                if previousDef == nil || (previousDef!.eventClass == eventClass && previousDef!.eventID == eventID) {
                    let command = CommandTerm(name: self.keywordConverter.convertSpecifierName(name), eventClass: eventClass, eventID: eventID)
                    self.commandsDict[name] = command
                    for element in element.elements(forName: "parameter") {
                        let (name, code) = try self.parse(keywordElement: element)
                        command.addParameter(self.keywordConverter.convertParameterName(name), code: code)
                    }
                } // else ignore duplicate declaration
            default: ()
            }
        }
    }
    
    // parse the given SDEF XML data
    
    public func parse(_ sdef: Data) throws {
        do {
            let parser = try XMLDocument(data: sdef, options: XMLNode.Options.documentXInclude)
            guard let dictionary = parser.rootElement() else { throw TerminologyError("Missing `dictionary` element.") }
            for suite in dictionary.elements(forName: "suite") {
                if let nodes = suite.children {
                    for node in nodes { try self.parse(definition: node) }
                }
            }
        } catch {
            throw TerminologyError("An error occurred while parsing SDEF. \(error)")
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


