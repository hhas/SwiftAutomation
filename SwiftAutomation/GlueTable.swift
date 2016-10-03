//
//  GlueTable.swift
//  SwiftAutomation
//
//  Combines default and application-specific terminology into lookup tables used
//  by AE bridge.
//
//  The `aeglue` tool uses these tables to add properties and methods to a glue's
//  Symbol subclass and Query and Command protocol extensions; formatAppleEvent()
//  uses them to translate typeAppleEvent descriptors to SwiftAutomation syntax.
//
//  May also be used by dynamic AE bridges.
//

import Foundation


// helper function; used to construct keys for commandsByCode dictionary
public func CommandTermKey(_ eventClass: OSType, _ eventID: OSType) -> UInt64 {
    return UInt64(eventClass) << 32 | UInt64(eventID)
}


// TO DO: add `var description: String {...}` that returns pretty-printed literal representation that can be written directly to file as a static keyword<->FCC table, which users can modify manually in order to correct for defective terms? (might be better leaving it to a `format()` method that can be customized for different languages, or else export in a generic data format (e.g. JSON) that is trivial to edit and parse back in)

public class GlueTable {
    // provides lookup tables used by language-specific bridges to pack/unpack/format symbols, specifiers, and commands
    // note: dictionary structures are optimized for dynamic bridges, but are also usable
    // by static glue generators (which aren't performance-sensitive anyway)
    
    public private(set) var typesByName:      [String:NSAppleEventDescriptor] = [:] // Symbol members (properties, types, and enums)
    public private(set) var typesByCode:      [OSType:String]      = [:]
    
    public private(set) var elementsByName:   [String:KeywordTerm] = [:]
    public private(set) var elementsByCode:   [OSType:String]      = [:]
    
    public private(set) var propertiesByName: [String:KeywordTerm] = [:] // e.g. AERecord keys
    public private(set) var propertiesByCode: [OSType:String]      = [:]
    
    public private(set) var commandsByName:   [String:CommandTerm] = [:]
    public private(set) var commandsByCode:   [UInt64:CommandTerm] = [:] // key is eventClass<<32|eventID
    
    private var _specifiersByName:            [String:Term]?
    
    // get property/elements/command by name; this eliminates duplicate (e.g. property+elements) names,
    // according [hopefully] to the same internal rules used by AppleScript; note, however, that AS does
    // still allow elements names masked by property names to be used by adding `every` keyword;
    // TO DO: add an `ObjectSpecifier.all` property to do the same (also, review special-case handling of
    // `text` property/element - it's probably correct since AS defines `text` as an element name itself,
    // but best be safe)
    public var specifiersByName: [String:Term] {
        if self._specifiersByName == nil {
            self._specifiersByName = [String:Term]()
            for termsByName in [elementsByName, propertiesByName, commandsByName] as [[String:Term]] {
                for (key, value) in termsByName { self._specifiersByName![key] = value }
            }
        }
        return self._specifiersByName!
    }
    
    // copies of SwiftAE's built-in terms, used to disambiguate any conflicting app-defined names
    private var defaultTypesByName: [String:NSAppleEventDescriptor] = [:]
    // TO DO: what about built-in property [and elements] names?
    private var defaultCommandsByName: [String:CommandTerm] = [:]
    
    private let keywordConverter: KeywordConverterProtocol
    
    public init(keywordConverter: KeywordConverterProtocol = defaultSwiftKeywordConverter) {
        self.keywordConverter = keywordConverter
        self.add(terminology: keywordConverter.defaultTerminology)
        // retain copies of default type and command terms; these will be used to disambiguate
        // any conflicting application-defined terms added later
        self.defaultTypesByName = self.typesByName
        self.defaultCommandsByName = self.commandsByName
    }

    private func add(symbolKeywords keywords: KeywordTerms, descriptorType: OSType) {
        let len = keywords.count
        for i in 0..<len {
            // add a definition to typeByCode table
            // to handle synonyms, if same code appears more than once then use name from last definition in list
            do {
                let term = keywords[i]
                var name = term.name
                let code = term.code
                if !(name == "missing value" && code == _cMissingValue) { // (`missing value` is special case)
                    // escape definitions that semi-overlap default definitions
                    if let desc = self.defaultTypesByName[name] {
                        if desc.typeCodeValue != code {
                            name = self.keywordConverter.escapeName(name)
                            term.name = name
                        }
                    }
                    // add item
                    self.typesByCode[code] = name
                }
            }
            // add a definition to typeByName table
            // to handle synonyms, if same name appears more than once then use code from first definition in list
            do {
                let term = keywords[len - 1 - i]
                var name = term.name
                var code = term.code // actually constant, but NSAppleEventDescriptor constructor below insists on var
                if !(name == "missing value" && code == _cMissingValue) { // (`missing value` is special case)
                    // escape definitions that semi-overlap default definitions
                    if let desc = self.defaultTypesByName[name] {
                        if desc.typeCodeValue != code {
                            name = self.keywordConverter.escapeName(name)
                            term.name = name
                        }
                    }
                }
                // add item
                self.typesByName[name] = NSAppleEventDescriptor(descriptorType: descriptorType, bytes: &code, length: MemoryLayout<OSType>.size)
            }
        }
    }

    private func add(specifierKeywords keywords: KeywordTerms,
                     nameTable: inout [String:KeywordTerm], codeTable: inout [OSType:String]) {
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

    private func add(commandKeywords commands: [CommandTerm]) {
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

    // called by parseAETE/parseSDEF 
    // (note: default terminology is added automatically when GlueTable is instantiated; users should not add it themselves)
    public func add(terminology terms: ApplicationTerminology) {
        // build type tables
        self.add(symbolKeywords: terms.properties, descriptorType: typeType) // technically typeProperty, but typeType is prob. safest
        self.add(symbolKeywords: terms.enumerators, descriptorType: typeEnumerated)
        self.add(symbolKeywords: terms.types, descriptorType: typeType)
        // build specifier tables
        self.add(specifierKeywords: terms.elements, nameTable: &self.elementsByName, codeTable: &self.elementsByCode)
        self.add(specifierKeywords: terms.properties, nameTable: &self.propertiesByName, codeTable: &self.propertiesByCode)
        // build command table
        self.add(commandKeywords: terms.commands)
        // special case: if property table contains a 'text' definition, move it to element table
        // (AppleScript always packs 'text of...' as an all-elements specifier, not a property specifier)
        // TO DO: should check if this rule only applies to 'text', or other ambiguous property/element names too
        if let specialTerm = self.propertiesByName["text"] {
            self.elementsByName["text"] = KeywordTerm(name: specialTerm.name, kind: .elementOrType, code: specialTerm.code)
            self.propertiesByName.removeValue(forKey: "text")
        }
        self._specifiersByName = nil
    }
    
    //
    
    public func add(AETE descriptor: NSAppleEventDescriptor) throws {
        // use `try AEApplication(url: url).getAETE()` to retrieve typeAETE descriptor via an 'ascr'/'gdte' Apple event
        // use `OSAGetSysTerminology()` to get typeAEUT (language component)'s AETE/AEUT resource (e.g. for AppleScript's built-in terminology)
        let parser = AETEParser(keywordConverter: self.keywordConverter)
        try parser.parse(descriptor)
        self.add(terminology: parser)
    }
    
    public func add(SDEF data: Data) throws {
        let parser = SDEFParser(keywordConverter: self.keywordConverter)
        try parser.parse(data)
        self.add(terminology: parser)       
    }
    
    public func add(SDEF url: URL) throws { // url may be file:// (for .sdef resource) or eppc:// (assuming OSACopyScriptingDefinitionFromURL works right now)
        try self.add(SDEF: GetScriptingDefinition(url))
    }
}

