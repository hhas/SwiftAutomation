//
//  SDEFParser.swift
//  SwiftAE
//
//

import Foundation
import Carbon


public class SDEFError: SwiftAEError {
    init(_ message: String) {
        super.init(code: 1, message: message)
    }
}



public class SDEFParser: NSObject, NSXMLParserDelegate {

    public var types: [KeywordTerm]
    public var enumerators: [KeywordTerm]
    public var properties: [KeywordTerm]
    public var elements: [KeywordTerm]
    private var commandsDict: [String:CommandTerm]
    private var currentCommand: CommandTerm?

    public var commands: [CommandTerm] { return self.commandsDict.map({$1}) }

    public func parseURL(url: NSURL) throws {
        var sdef: Unmanaged<CFData>?
        let err = OSACopyScriptingDefinitionFromURL(url, 0, &sdef)
        if err != 0 {
            throw SwiftAEError(code: Int(err), message: "Can't retrieve SDEF.")
        }
        return try self.parse(sdef!.takeRetainedValue())
    }
    
    public func parse(sdef: NSData) throws {
        let parser = NSXMLParser(data: sdef)
        parser.delegate = self
        if !parser.parse() {
            throw parser.parserError ?? SwiftAEError(code: 1) // TO DO
        }
    }
    
    
    override init() {
        self.types = [KeywordTerm]()
        self.enumerators = [KeywordTerm]()
        self.properties = [KeywordTerm]()
        self.elements = [KeywordTerm]()
        self.commandsDict = [String:CommandTerm]()
        super.init()
    }
    
    // keyword converter // TO DO: this should stay as separate class (terminology parser should be reusable for dynamic bridges too)

    func varName(name: String) -> String {
        return name as String // TO DO
    }
    func funcName(name: String) -> String {
        return self.varName(name)
    }
    func argName(name: String) -> String {
        return name as String // TO DO
    }
    
    // XML parser callback
    
    func parseKeywordTerm(tagName: String, attributes: [String:String]) throws -> (String, OSType) {
        guard let name = attributes["name"], codeString = attributes["code"] else {
            throw SDEFError("Malformed \(tagName) in SDEF: missing 'name' or 'code' attribute.")
        }
        if name == "" {
            throw SDEFError("Malformed \(tagName) in SDEF: empty 'name' attribute.")
        }
        do {
            return (name, try OSTypeFromString(codeString))
        } catch {
            throw SDEFError("Malformed \(tagName) in SDEF: invalid 'code' attribute (\(error)).")
        }
    }
    
    
    public func parser(parser: NSXMLParser, didStartElement tagName: String,
                                                       namespaceURI: String?,
                                                      qualifiedName: String?,
                                                         attributes: [String:String]) {
        // TO DO: better reporting of parse errors due to [e.g.] defects in [unvalidated] SDEF files or bugs in OSACopyScriptingDefinition's AETE-to-SDEF conversion; e.g. gather parse error messages in array which caller can [e.g.] log as warnings once parsing is complete
        do {
            switch tagName {
            case "class", "record-type", "value-type":
                let (name, code) = try self.parseKeywordTerm(tagName, attributes: attributes)
                self.types.append(KeywordTerm(name: self.varName(name), kind: .Type, code: code))
                if tagName == "class" { // use plural class name as elements name (if not given, append "s" to singular name)
                    let plural = attributes["plural"] ?? ""
                    self.elements.append(KeywordTerm(name: self.varName(plural == "" ? "\(name)s" : plural), kind: .Type, code: code))
                }
            case "property":
                let (name, code) = try self.parseKeywordTerm(tagName, attributes: attributes)
                self.properties.append(KeywordTerm(name: self.varName(name), kind: .Property, code: code))
            case "enumerator":
                let (name, code) = try self.parseKeywordTerm(tagName, attributes: attributes)
                self.enumerators.append(KeywordTerm(name: self.varName(name), kind: .Enumerator, code: code))
            case "command":
                guard let name = attributes["name"], codeString: NSString = attributes["code"] else {
                    throw SDEFError("Malformed \(tagName) in SDEF: missing 'name' or 'code' attribute.")
                }
                if name == "" {
                    throw SDEFError("Malformed \(tagName) in SDEF: empty 'name' attribute.")
                }
                if codeString.length != 8 {
                    throw SDEFError("Malformed \(tagName) in SDEF: invalid 'code' attribute (wrong length).")
                }
                var eventClass: OSType, eventID: OSType
                do {
                    eventClass = try OSTypeFromString(codeString.substringToIndex(4))
                    eventID = try OSTypeFromString(codeString.substringFromIndex(4))
                } catch {
                    throw SDEFError("Malformed \(tagName) in SDEF: invalid 'code' attribute (\(error)).")
                }
                // Note: overlapping command definitions (e.g. 'path to') should be processed as follows:
                // - If their names and codes are the same, only the last definition is used; other definitions are ignored
                //   and will not compile.
                // - If their names are the same but their codes are different, only the first definition is used; other
                //   definitions are ignored and will not compile.
                let previousDef = commandsDict[name]
                if previousDef == nil || (previousDef!.eventClass == eventClass && previousDef!.eventID == eventID) {
                    currentCommand = CommandTerm(name: self.funcName(name), eventClass: eventClass, eventID: eventID)
                    commandsDict[name] = currentCommand
                } else {
                    currentCommand = nil
                }
            case "parameter":
                let (name, code) = try self.parseKeywordTerm(tagName, attributes: attributes)
                self.currentCommand?.addParameter(self.argName(name), code: code)
            default:
                ()
            }
        } catch {
             print(error)
        }
    }
}


