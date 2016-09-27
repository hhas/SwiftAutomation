//
//  SDEFParser.swift
//  SwiftAutomation
//
//

import Foundation
import Carbon

// TO DO: neither parser has been thoroughly tested to ensure correct results when multiple terminologies are given (e.g. if app also has scriptable plugins)



// TO DO: does getting sdef via (ascr/gsdf?) Apple event work now?



public class SDEFParser: NSObject, XMLParserDelegate, ApplicationTerminology {

    public private(set) var types: KeywordTerms = []
    public private(set) var enumerators: KeywordTerms = []
    public private(set) var properties: KeywordTerms = []
    public private(set) var elements: KeywordTerms = []
    public var commands: CommandTerms { return Array(self.commandsDict.values) }
    
    private var commandsDict = [String:CommandTerm]()
    private var currentCommand: CommandTerm?
    private let keywordConverter: KeywordConverterProtocol
    
    public init(keywordConverter: KeywordConverterProtocol = gSwiftAEKeywordConverter) {
        self.keywordConverter = keywordConverter
        super.init()
    }
    
    // parse the given SDEF XML data
    
    public func parse(_ sdef: Data) throws {
        let parser = XMLParser(data: sdef)
        parser.delegate = self
        if !parser.parse() {
            throw TerminologyError("An error occurred while parsing SDEF. \(parser.parserError)")
        }
    }
    
    // NSXMLParser callback; users should not call this directly
    
    public func parser(_ parser: XMLParser, didStartElement tagName: String,
                                                       namespaceURI: String?,
                                                      qualifiedName: String?,
                                                         attributes: [String:String]) {
        // TO DO: better reporting of parse errors due to [e.g.] defects in [unvalidated] SDEF files or bugs in OSACopyScriptingDefinition's AETE-to-SDEF conversion; e.g. gather parse error messages in array which caller can [e.g.] log as warnings once parsing is complete
        do {
            switch tagName {
            case "class", "record-type", "value-type":
                let (name, code) = try self.parseKeywordTerm(tagName, attributes: attributes)
                self.types.append(KeywordTerm(name: self.keywordConverter.convertSpecifierName(name), kind: .elementOrType, code: code))
                if tagName == "class" { // use plural class name as elements name (if not given, append "s" to singular name) // TO DO: check SIG/SDEF spec, as appending 's' doesn't work so well for names already ending in 's' (e.g. 'print settings')
                    let plural = attributes["plural"] ?? ""
                    self.elements.append(KeywordTerm(name: self.keywordConverter.convertSpecifierName(plural == "" ? "\(name)s" : plural), kind: .elementOrType, code: code))
                }
            case "property":
                let (name, code) = try self.parseKeywordTerm(tagName, attributes: attributes)
                self.properties.append(KeywordTerm(name: self.keywordConverter.convertSpecifierName(name), kind: .property, code: code))
            case "enumerator":
                let (name, code) = try self.parseKeywordTerm(tagName, attributes: attributes)
                self.enumerators.append(KeywordTerm(name: self.keywordConverter.convertSpecifierName(name), kind: .enumerator, code: code))
            case "command":
                guard let name = attributes["name"], let codeString = attributes["code"] as NSString? else {
                    throw TerminologyError("Malformed \(tagName) in SDEF: missing 'name' or 'code' attribute.")
                }
                if name == "" {
                    throw TerminologyError("Malformed \(tagName) in SDEF: empty 'name' attribute.")
                }
                if codeString.length != 8 {
                    throw TerminologyError("Malformed \(tagName) in SDEF: invalid 'code' attribute (wrong length).")
                }
                var eventClass: OSType, eventID: OSType
                do {
                    eventClass = try fourCharCode(codeString.substring(to: 4))
                    eventID = try fourCharCode(codeString.substring(from: 4))
                } catch {
                    throw TerminologyError("Malformed \(tagName) in SDEF: invalid 'code' attribute (\(error)).")
                }
                // Note: overlapping command definitions (e.g. 'path to') should be processed as follows:
                // - If their names and codes are the same, only the last definition is used; other definitions are ignored
                //   and will not compile.
                // - If their names are the same but their codes are different, only the first definition is used; other
                //   definitions are ignored and will not compile.
                let previousDef = commandsDict[name]
                if previousDef == nil || (previousDef!.eventClass == eventClass && previousDef!.eventID == eventID) {
                    currentCommand = CommandTerm(name: self.keywordConverter.convertSpecifierName(name), eventClass: eventClass, eventID: eventID)
                    commandsDict[name] = currentCommand
                } else {
                    currentCommand = nil
                }
            case "parameter":
                if let command = self.currentCommand {
                    let (name, code) = try self.parseKeywordTerm(tagName, attributes: attributes)
                    command.addParameter(self.keywordConverter.convertParameterName(name), code: code)
                }
            default:
                ()
            }
        } catch {
             print(error)
        }
    }
    
    // used by parser() callback
    func parseKeywordTerm(_ tagName: String, attributes: [String:String]) throws -> (String, OSType) {
        guard let name = attributes["name"], let codeString = attributes["code"] else {
            throw TerminologyError("Malformed \(tagName) in SDEF: missing 'name' or 'code' attribute.")
        }
        if name == "" {
            throw TerminologyError("Malformed \(tagName) in SDEF: empty 'name' attribute.")
        }
        do {
            return (name, try fourCharCode(codeString))
        } catch {
            throw TerminologyError("Malformed \(tagName) in SDEF: invalid 'code' attribute (\(error)).")
        }
    }
}


// convenience function

public func GetScriptingDefinition(_ url: URL) throws -> Data {
    var sdef: Unmanaged<CFData>?
    let err = OSACopyScriptingDefinitionFromURL(url as NSURL, 0, &sdef)
    if err != 0 {
        throw SwiftAutomationError(code: Int(err), message: "Can't retrieve SDEF.")
    }
    return sdef!.takeRetainedValue() as Data
}


