//
//  GlueBuilder.swift
//  SwiftAE
//
//

import Foundation



// TO DO: port aeglue classes (replace aeglue with a minimal executable)



public func CommandTermKey(eventClass: OSType, _ eventID: OSType) -> UInt64 { // creates keys for use in commandsByCode table
    return UInt64(eventClass) << 32 | UInt64(eventID)
}


public class GlueTables { // used by aeglue and SwiftFormatter.formatAppleEvent()

    // lookup tables used by language-specific bridges to pack/unpack/format keywords and object specifiers
    
    // note: when looking up Specifier members, always search tables in order: elementsByName, propertiesByName, commandsByName
    
    // TO DO: should values always be Terms? (the current arrangement is optimized for dynamic bridges)
    public private(set) var typesByName:      [String:NSAppleEventDescriptor] = [:] // Symbol members (properties, types, and enums)
    public private(set) var typesByCode:      [OSType:String]      = [:]
    
    public private(set) var elementsByName:   [String:KeywordTerm] = [:]
    public private(set) var elementsByCode:   [OSType:String]      = [:]
    
    public private(set) var propertiesByName: [String:KeywordTerm] = [:] // e.g. AERecord keys
    public private(set) var propertiesByCode: [OSType:String]      = [:]
    
    public private(set) var commandsByName:   [String:CommandTerm] = [:]
    public private(set) var commandsByCode:   [UInt64:CommandTerm] = [:] // key is eventClass<<32|eventID
    
    // copies of SwiftAE's built-in terms, used to disambiguate any conflicting app-defined names
    private var defaultTypesByName: [String:NSAppleEventDescriptor] = [:]
    // TO DO: what about built-in property [and elements] names?
    private var defaultCommandsByName: [String:CommandTerm] = [:]
    
    private let keywordConverter: KeywordConverterProtocol

    
    public init(keywordConverter: KeywordConverterProtocol = gSwiftAEKeywordConverter,
                defaultTerminology: ApplicationTerminology = gSwiftAEDefaultTerminology) {
        self.keywordConverter = keywordConverter
        // retain copies of default type and command terms; these will be used to disambiguate
        // any conflicting application-defined terms added later
        self.addApplicationTerminology(defaultTerminology)
        self.defaultTypesByName = self.typesByName
        self.defaultCommandsByName = self.commandsByName
    }

    private func addTypes(keywords: KeywordTerms, descriptorType: OSType) { // descriptor type is used to create AEDescs for typesByName
        let len = keywords.count
        for i in 0..<len {
            // add a definition to typeByCode table
            // to handle synonyms, if same code appears more than once then use name from last definition in list
            do {
                let term = keywords[i]
                var name = term.name
                let code = term.code
                // escape definitions that semi-overlap default definitions
                if let desc = self.defaultTypesByName[name] {
                    if desc.typeCodeValue != code {
                        term.name = self.keywordConverter.escapeName(name)
                        name = term.name
                    }
                }
                // add item
                self.typesByCode[code] = name
            }
            // add a definition to typeByName table
            // to handle synonyms, if same name appears more than once then use code from first definition in list
            do {
                let term = keywords[len - 1 - i]
                var name = term.name
                var code = term.code // actually constant, but NSAppleEventDescriptor constructor below insists on var
                // escape definitions that semi-overlap default definitions
                if let desc = self.defaultTypesByName[name] {
                    if desc.typeCodeValue != code {
                        name = self.keywordConverter.escapeName(name)
                        name = term.name
                    }
                }
                // add item
                self.typesByName[name] = NSAppleEventDescriptor(descriptorType: descriptorType, bytes: &code, length: sizeofValue(code))
            }
        }
    }

    // TO DO: confirm tables are passed by ref
    private func addSpecifiers(keywords: KeywordTerms, inout nameTable: [String:KeywordTerm], inout codeTable: [OSType:String]) {
        let len = keywords.count
        for i in 0..<len {
            // add a definition to the byCode table
            // to handle synonyms, if same code appears more than once then use name from last definition in list
            do {
                let term = keywords[i]
                codeTable[term.code] = term.name
            }
            // TO DO: escape definitions that semi-overlap default definitions? (see TODO at top)
            // add a definition to the byName table
            // to handle synonyms, if same name appears more than once then use code from first definition in list
            do {
                let term = keywords[len - 1 - i]
                nameTable[term.name] = term
            }
        }
    }

    private func addCommands(commands: [CommandTerm]) {
        // To handle synonyms, if two commands have same name but different codes, only the first
        // definition should be used (iterating array in reverse ensures this)
        let len = commands.count
        for i in 0..<len {
            let term = commands[len - 1 - i]
            var name = term.name;
            let eventClass = term.eventClass
            let eventID = term.eventID
            // Avoid collisions between default commands and application-defined commands with same name
            // but different code (e.g. 'get' and 'set' in InDesign CS2):
            if let existingCommandDef = self.defaultCommandsByName[name] {
                if existingCommandDef.eventClass != eventClass || existingCommandDef.eventID != eventID {
                    term.name = keywordConverter.escapeName(name)
                    name = term.name
                }
            }
            // add item
            self.commandsByName[name] = term
            self.commandsByCode[CommandTermKey(eventClass, eventID)] = term
        }
    }

    // add data from AETEParser, SDEFParser or equivalent
    public func addApplicationTerminology(terms: ApplicationTerminology) {
        // build type tables
        self.addTypes(terms.properties, descriptorType: typeType) // technically typeProperty, but typeType is prob. safest
        self.addTypes(terms.enumerators, descriptorType: typeEnumerated)
        self.addTypes(terms.types, descriptorType: typeType)
        // build specifier tables
        self.addSpecifiers(terms.elements, nameTable: &self.elementsByName, codeTable: &self.elementsByCode)
        self.addSpecifiers(terms.properties, nameTable: &self.propertiesByName, codeTable: &self.propertiesByCode)
        // build command table
        self.addCommands(terms.commands)
        // special case: if property table contains a 'text' definition, move it to element table
        // (AppleScript always packs 'text of...' as an all-elements specifier, not a property specifier)
        // TO DO: should check if this rule only applies to 'text', or other ambiguous property/element names too
        if let specialTerm = self.propertiesByName["text"] {
            self.elementsByName["text"] = KeywordTerm(name: specialTerm.name, kind: .Type, code: specialTerm.code)
            self.propertiesByName.removeValueForKey("text")
        }
    }
}
