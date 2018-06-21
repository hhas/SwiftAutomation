//
//  StaticGlueBuilder.swift
//  SwiftAutomation
//
//  Generate SwiftAutomation glue file and SDEF documentation.
//
//

// TO DO: this code is pretty messy; tidy up later (e.g. divide ad-hoc parsing code into lexer + LL(1) parser)

// TO DO: skip any non-significant spaces in format string (currently spaces aren't allowed in format string)

// TO DO: format strings should allow module and nested type names, e.g. 'Foo.Bar'

// TO DO: SDEF converter needs to convert type names (simplest is probably to build dictionary of all original and converted names on first pass, then do second pass using that dictionary to map type names); Q. what about built-in types? (DefaultTerminology should now use same names as AS, simplifying re-mapping to their Swift equivalents; OTOH, not sure how much benefit that really adds - plus there's a lot of ambiguity with `text` due to its overloaded meaning)


import Foundation


/******************************************************************************/
// Additional Swift type system support

// glue renderer consumes the following data structures

public typealias EnumeratedTypeDefinition = (name: String, cases: [(name: String, type: String)])

public typealias RecordStructDefinition = (name: String, className: String, properties: [(name: String, code: OSType, type: String)])

public typealias TypeAliasDefinition = (name: String, type: String)


// the following names are reserved by glue generator
let ReservedGlueTypeNames: Set<String> = ["symbol", "object", "insertion", "item", "items", "root", "record"] // enum/typealias/struct format string parsers will automatically prefix these names with classNamePrefix // TO DO: not sure if 'record' should be included

func isReservedGlueTypeName(_ string: String) -> Bool {
    return ReservedGlueTypeNames.contains(string.lowercased())
}




public class SyntaxError: AutomationError {
    
    init(_ message: String) {
        super.init(code: 1, message: message)
    }
    
    convenience init(found: String, butExpected: String) {
        self.init("Expected \(butExpected) but found \(found) instead.")
    }
    
    convenience init(found: Character?, butExpected: String, after: String? = nil) {
        self.init(found: (found == nil ? "end of text" : "'\(String(found!))'"),
                  butExpected: (after == nil ? butExpected : "\(butExpected) after \(after!)"))
    }
}

///////
// [generic] type name parser

let kOpenChar = Character("<")
let kCloseChar = Character(">")
let kSepChar = Character(",")
let kPairChar = Character(":")
let kBindChar = Character("=")
let kConcatChar = Character("+")


func lowercasedFirstCharacter(_ string: String) -> String {
    let chars = Substring(string)
    return String(chars.first!).lowercased() + String(chars.dropFirst())
}

func sentenceCased(_ string: String) -> String {
    let chars = Substring(string)
    return String(chars.first!).uppercased() + String(chars.dropFirst()).lowercased()
}

// TO DO: skipSpace(_ chars: inout Substring)

func advanceOne(_ chars: inout Substring, character c: Character, after: String) throws {
    if chars.first != c { throw SyntaxError(found: chars.first, butExpected: "'\(c)'", after: after) }
    chars.removeFirst()
}


func parseIdentifier(_ chars: inout Substring) throws -> String {
    // reads a C-identifier, checking it isn't a Swift keyword
    var name = ""
    let c = chars.popFirst()
    if c == nil || !legalFirstChars.contains(c!) { throw SyntaxError(found: c, butExpected: "an identifier") }
    name.append(c!)
    while let c = chars.first {
        if !legalOtherChars.contains(c) { break }
        name.append(chars.popFirst()!)
    }
    if reservedSwiftKeywords.contains(name) {
        throw SyntaxError("Expected an identifier but found reserved keyword '\(name)' instead.")
    }
    return name
}

func parseType(_ chars: inout Substring, classNamePrefix: String, name: String? = nil) throws -> String {
    // reads a C-identifier optionally followed by <TYPE[,TYPE,...]> generic parameters, as used on right side of typealias and struct property definitions; characters are consumed from chars parameter until the name is fully read, then the name is returned as String
    // if the name is one of the base names used by SwiftAutomation (Symbol, Object, etc), a class name prefix is automatically added; this allows the same format string to be reused for multiple glues
    var name = try name ?? parseIdentifier(&chars)
    if isReservedGlueTypeName(name) { name = classNamePrefix + name }
    if chars.first == kOpenChar {
        name += String(chars.popFirst()!)
        var nc: Character?
        repeat { // TO DO: skip any non-significant spaces in format string (currently spaces aren't allowed in format string)
            name += try parseType(&chars, classNamePrefix: classNamePrefix)
            nc = chars.popFirst()
            if nc == kSepChar { name.append(String(kSepChar) + " ") }
        } while nc == kSepChar
        if nc != kCloseChar {
            throw SyntaxError("Expected ',' or '>' after '\(name)' but found '\(nc!)'.")
        }
        name += String(nc!)
    }
    return name
}


func parseProperty(_ chars: inout Substring, classNamePrefix: String) throws -> (String, String) {
    // parse "NAME:TYPE" pair
    let propertyName = try parseIdentifier(&chars)
    // `class` property is a special case that's used to store the AERecord's descriptorType
    if ["class", "class_"].contains(propertyName.lowercased()) { throw SyntaxError("Invalid record property name: \(propertyName)") }
    try advanceOne(&chars, character: kPairChar, after: propertyName)
    return (propertyName, try parseType(&chars, classNamePrefix: classNamePrefix))
}


// typealias format string parser "ALIASNAME=TYPE"

public func parseTypeAliasDefinition(_ string: String, classNamePrefix: String) throws -> TypeAliasDefinition {
    // TO DO: don't bother splitting; just define a skipChar() function that consumes one char and errors if it's not the char expected
    let parts = string.split(maxSplits:1, whereSeparator: {$0=="="})//.map(String.init)
    if parts.count != 2 { throw SyntaxError("Expected 'ALIASNAME=TYPE' format string.") }
    let name = String(parts[0])
    try validateCIdentifier(name)
    if isReservedGlueTypeName(name) { throw SyntaxError("Invalid typealias name: \(name)")}
    var chars = parts[1]
    let value = try parseType(&chars, classNamePrefix: classNamePrefix)
    if !chars.isEmpty { throw SyntaxError("Expected end of text but found \(String(chars)).") }
    return (classNamePrefix + name, value)
}


// enum type format string parser "[ENUMNAME=][CASENAME1:]TYPE1+[CASENAME2:]TYPE2+..."

func parseEnumeratedTypeDefinition(_ string: String, classNamePrefix: String) throws -> EnumeratedTypeDefinition {
    // an enumerated (aka sum/union) type definition is written as a simple format string: "[TYPENAME=]TYPE1+TYPE2+..."
    // note that class name prefixes are added automatically to both "TYPENAME" and (as needed) "TYPEn", allowing a format string to be used over multiple glues, e.g. "URL+Item" -> `enum FINURLOrItem { case URL; case FINItem; ...}`, or "FileObject=URL+Item" -> `enum FINFileObject { case URL; case FINItem; ...}`
    let parts = string.split(maxSplits:1, whereSeparator: {$0=="="})
    var enumName: String = parts.count == 2 ? String(parts[0]) : ""
    var enumNameParts = [String]()
    var chars = parts.last!
    var cases = [(name: String, type: String)]()
    var nc: Character?
    repeat {
        var caseName: String
        var typeName = try parseIdentifier(&chars)
        if chars.first == kPairChar { // "CASENAME:TYPENAME" (a clean lexer + LL(1) parser design would've looked ahead for ":" _before_ parsing the previous token as either identifier or type, but just kludging it for now)
            caseName = typeName
            try advanceOne(&chars, character: ":", after: caseName)
            typeName = try parseType(&chars, classNamePrefix: classNamePrefix) // read actual type name
        } else { // else auto-generate case name from type name
            caseName = lowercasedFirstCharacter(typeName) // e.g. `SomeType` -> `someType`
            typeName = try parseType(&chars, classNamePrefix: classNamePrefix, name: typeName) // read rest of type name
            if typeName.hasSuffix(String(kCloseChar)) { // e.g. "foo<x>" is invalid
                throw SyntaxError("Can't generate case name from parameterized type name: \(typeName)")
            }
        }
        if typeName == "MissingValue" { // for convenience, the format string may also include `MissingValue`, in which case a `.missing(_)` case is also included in the enum; this avoids the need for an extra level of MayBeMissing<> boxing
            cases.insert((name: "missing", type: "MissingValueType"), at: 0) // (ignore any property name caller might have given)
            enumNameParts.append(typeName)
        } else {
            if caseName == "missing" { throw SyntaxError("Invalid case name: \(typeName)") }
            if typeName == caseName { caseName = "_\(caseName)" } // caution: type names _should_ start with uppercase char and case name with lower, but check to be sure and disambiguate if necessary
            if reservedSwiftKeywords.contains(caseName) { caseName += "_" }
            cases.append((name: caseName, type: (isReservedGlueTypeName(typeName) ? (classNamePrefix + typeName) : typeName)))
            if enumName.isEmpty {
                var name = typeName
                if name.hasPrefix(classNamePrefix) { name.removeSubrange(classNamePrefix.startIndex...classNamePrefix.endIndex) }
                enumNameParts.append(name)
            }
        }
        nc = chars.popFirst()
    } while nc == kConcatChar
    if cases.count < 2 { throw SyntaxError("Not a valid enumerated type definition: '\(string)'") }
    if !chars.isEmpty { throw SyntaxError("Expected end of text but found \(String(chars)).") }
    if enumName.isEmpty {
        enumName = enumNameParts.joined(separator: "Or")
        if reservedSwiftKeywords.contains(enumName) { enumName += "_" }
    } else {
        try validateCIdentifier(enumName)
    }
    if isReservedGlueTypeName(enumName) { throw SyntaxError("Invalid enum name: \(enumName)") }
    return (classNamePrefix + enumName, cases)
}


// struct record format string parser "STRUCTNAME[:CLASS]=PROPERTYNAME:TYPE+PROPERTYNAME:TYPE+..."

func parseRecordStructDefinition(_ string: String, classNamePrefix: String,
                                 typesByName: [String: NSAppleEventDescriptor]) throws -> RecordStructDefinition {
    var chars = Substring(string)
    var properties = [(name: String, code: OSType, type: String)]()
    let structName = try parseIdentifier(&chars) + "Record" // e.g. `TEDDocumentRecord`; TO DO: might be twitchy if any application 'class' names end with the word "record" themselves
    if isReservedGlueTypeName(structName) { throw SyntaxError("Invalid record struct name: \(structName)") }
    let className: String
    if chars.first == kPairChar {
        chars.removeFirst()
        className = try parseIdentifier(&chars) // the object's 'class' as defined in app's dictionary
        let desc = typesByName[className]
        if ![typeType, typeProperty].contains(desc?.descriptorType ?? 0) { throw SyntaxError("Invalid record class name: \(className)") }
    } else {
        className = "record"
    }
    try advanceOne(&chars, character: kBindChar, after: "struct name")
    var nc: Character?
    repeat {
        let (propertyName, typeName) = try parseProperty(&chars, classNamePrefix: classNamePrefix)
        guard let propertyCode = typesByName[propertyName]?.typeCodeValue else {
            throw SyntaxError("Unknown property name: \(propertyName)")
        }
        properties.append((propertyName, propertyCode, typeName))
        nc = chars.popFirst()
    } while nc == kConcatChar
    if !chars.isEmpty { throw SyntaxError("Expected end of text but found \(String(chars)).") }
    return (classNamePrefix + structName, className, properties)
}


/******************************************************************************/
// Type support glue specification


public class TypeSupportSpec { // converts custom format strings into enum/struct/typealias type descriptions for use in glue renderer; TO DO: define protocol, allowing type descriptions to be constructed in other ways (e.g. by optimistic parsing of AETE/SDEF's schlonky type data)
    
    public let enumeratedTypeFormats: [String]
    public let recordStructFormats: [String]
    public let typeAliasFormats: [String]
    
    init(enumeratedTypeFormats: [String] = [], recordStructFormats: [String] = [], typeAliasFormats: [String] = []) {
        self.enumeratedTypeFormats = enumeratedTypeFormats
        self.recordStructFormats = recordStructFormats
        self.typeAliasFormats = typeAliasFormats
    }
    
    //
    
    public func enumeratedTypeDefinitions(classNamePrefix: String) throws -> [EnumeratedTypeDefinition] {
        do {
        return try self.enumeratedTypeFormats.map {
            try parseEnumeratedTypeDefinition($0, classNamePrefix: classNamePrefix)
        }
        }catch {
         print(error)
            throw error
        }
    }
    
    public func recordStructDefinitions(classNamePrefix: String,
                                        typesByName: [String: NSAppleEventDescriptor]) throws -> [RecordStructDefinition] {
        return try self.recordStructFormats.map {
            try parseRecordStructDefinition($0, classNamePrefix: classNamePrefix, typesByName: typesByName)
        }
    }
    
    public func typeAliasDefinitions(classNamePrefix: String) throws -> [TypeAliasDefinition] {
        return try self.typeAliasFormats.map {
            try parseTypeAliasDefinition($0, classNamePrefix: classNamePrefix)
        }
    }
}


/******************************************************************************/
// Static glue specification


public class GlueSpec {
    public let applicationURL: URL? // TO DO: any use cases where user would want to use .sdef file rather than .app bundle?
    public let keywordConverter: KeywordConverterProtocol
    public let classNamePrefix: String
    public let applicationClassName: String
    public let useSDEF: Bool
    public let bundleInfo: BundleInfoType
    
    public typealias BundleInfoType = [String:AnyObject]
    
    public var applicationFileName: String? { return self.applicationURL?.lastPathComponent }
    public var applicationName: String? { return self.bundleInfo["CFBundleName"] as? String }
    public var applicationVersion: String? { return self.bundleInfo["CFBundleShortVersionString"] as? String }
    public var bundleIdentifier: String? { return self.bundleInfo["CFBundleIdentifier"] as? String }
    // TO DO: eventually get following values from SwiftAutomation.framework bundle
    public var frameworkName: String { return "SwiftAutomation.framework" }
    public var frameworkVersion: String { return "0.1.0" }
    
    public let typeSupportSpec: TypeSupportSpec?
    
    // create GlueSpec for specified application (applicationURL is typically a file:// URL, or nil to create default glue)
    public init(applicationURL: URL?, keywordConverter: KeywordConverterProtocol = defaultSwiftKeywordConverter,
                classNamePrefix: String? = nil, applicationClassName: String? = nil, useSDEF: Bool = false,
                typeSupportSpec: TypeSupportSpec? = nil) {
        self.applicationURL = applicationURL
        self.keywordConverter = keywordConverter
        self.useSDEF = useSDEF
        let bundleInfo = ((applicationURL == nil) ? [:] : Bundle(url: applicationURL!)?.infoDictionary ?? [:]) as BundleInfoType
        self.bundleInfo = bundleInfo
        self.typeSupportSpec = typeSupportSpec
        if applicationURL == nil {
            self.classNamePrefix = "AE"
            self.applicationClassName = "AEApplication"
        } else {
            var prefix: String
            if let userPrefix = classNamePrefix {
                prefix = keywordConverter.identifierForAppName(userPrefix)
            } else { // autogenerate (note: prefixForAppName always pads/truncates to exactly 3 chars)
                prefix = keywordConverter.prefixForAppName((bundleInfo["CFBundleName"] as? String) ?? "")
            }
            self.classNamePrefix = prefix
            let appName = keywordConverter.identifierForAppName(
                    applicationClassName ?? (bundleInfo["CFBundleName"] as? String) ?? "\(prefix)Application")
            self.applicationClassName = (appName == classNamePrefix) ? keywordConverter.escapeName(appName) : appName
        }
    }

    public func buildGlueTable() throws -> GlueTable { // parse application terminology into
        let glueTable = GlueTable(keywordConverter: self.keywordConverter)
        if let url = self.applicationURL { // if nil, return table containing default terminology only
            if self.useSDEF {
                try glueTable.add(SDEF: url)
            } else {
                try glueTable.add(AETE: AEApplication(url: url).getAETE())
            }
        }
        return glueTable
    }
}


/******************************************************************************/
// Application glue renderer


public class StaticGlueTemplate {
    // Caution: this is not a general-purpose template engine. In particular, «+NAME»...«-NAME» blocks have leaky scope,
    // so replacing «FOO» tags in the top-level scope will replace all «FOO» tags within «+NAME»...«-NAME» blocks too.
    // This makes it easy to (e.g.) replace all «PREFIX» tags throughout the template, but also means nested tags must
    // use different names when unrelated to each other (e.g. «COMMAND_NAME» vs (parameter) «NAME») so that replacing
    // one does not replace them all.
    
    private let _template: NSMutableString
    
    public var string: String { return self._template.copy() as! String }
    
    
    public init(string: String? = nil) {
        self._template = NSMutableString(string: string ?? SwiftGlueTemplate)
    }
    
    private func subRender<T>(_ newContents: T, renderer: (StaticGlueTemplate, T) -> ()) -> String {
        renderer(self, newContents)
        return self.string
    }
    
    private func iterate<T>(block name: String, newContents: [T], emptyContent: String = "",
                            separator: String = "", renderer: (StaticGlueTemplate, T) -> ()) {
        let tagLength = ("«+\(name)»" as NSString).length
        while true { // match each «+NAME»...«-NAME» block and render its contents
            let range = self._template.range(of: "(?s)«\\+\(name)».*?«-\(name)»",
                                             options: .regularExpression, range: NSMakeRange(0, self._template.length))
            if range.length == 0 { return } // no more matches
            let subString = self._template.substring(with: NSMakeRange(range.location+tagLength,range.length-tagLength*2))
            var result = [String]()
            if newContents.count > 0 {
                for newContent in newContents {
                    result.append(StaticGlueTemplate(string: subString).subRender(newContent, renderer: renderer))
                }
            }else {
                result = [emptyContent] // e.g. empty dictionary literals require ':'
            }
            self._template.replaceCharacters(in: range, with: result.joined(separator: separator))
        }
    }
    
    // render tags
    
    // glue classes
    
    public func insertString(_ block: String, _ newContent: String) {
        self._template.replaceOccurrences(of: "«\(block)»", with: newContent,
                                          options: .literal, range: NSMakeRange(0, _template.length))
    }
    
    public func insertOSType(_ block: String, _ code: OSType) { // insert OSType as numeric and/or string literal representations (tag for the latter is name+"_STR")
        self.insertString(block, NSString(format: "0x%08x", code) as String)
        self.insertString("\(block)_STR", formatFourCharCodeString(code))
    }
    
    public func insertKeywords(_ block: String, _ newContents: [KeywordTerm], emptyContent: String = "") {
        self.iterate(block: block, newContents: newContents, emptyContent: emptyContent) {
            $0.insertString("NAME", $1.name)
            $0.insertOSType("CODE", $1.code)
        }
    }
    public func insertKeywords(_ block: String, _ newContents: [(key:OSType, value:String)], emptyContent: String = "") {
        self.iterate(block: block, newContents: newContents, emptyContent: emptyContent) {
            $0.insertString("NAME", $1.1)
            $0.insertOSType("CODE", $1.0)
        }
    }
    
    public func insertCommands(_ block: String, _ newContents: [CommandTerm], emptyContent: String = "") {
        self.iterate(block: block, newContents: newContents, emptyContent: emptyContent) {
            $0.insertString("COMMAND_NAME", $1.name)
            $0.insertOSType("EVENT_CLASS", $1.eventClass)
            $0.insertOSType("EVENT_ID", $1.eventID)
            $0.insertKeywords("PARAMETER", $1.orderedParameters)
        }
    }
    
    // additional types
    
    public func insertEnumeratedTypes(_ block: String, _ enumTypeDefs: [EnumeratedTypeDefinition]) {
        self.iterate(block: block, newContents: enumTypeDefs, emptyContent: "") {
            (subtemplate: StaticGlueTemplate, definition: EnumeratedTypeDefinition) in
            subtemplate.insertString("ENUM_TYPE_NAME", definition.name)
            for blockName in ["CASE_DEFINITION", "INIT_DEFINITION", "PACK_CASE", "UNPACK_CASE"] {
                subtemplate.iterate(block: blockName, newContents: definition.cases, emptyContent: "") {
                    $0.insertString("CASE_NAME", $1.name)
                    $0.insertString("CASE_TYPE", $1.type)
                }
            }
            subtemplate.insertString("ENUM_NO_VALUE",
                 (definition.cases[0].name == "missing" ? "return .missing(MissingValue)" : "throw AutomationError(code: -1708)"))
        }
    }
    
    public func insertRecordStructs(_ block: String, _ recordStructDefs: [RecordStructDefinition]) { // errors if property name not found
        
        // TO DO: class is problematic when passing records to app - some apps require it, some reject it, some ignore it
        
        self.iterate(block: block, newContents: recordStructDefs, emptyContent: "") {
            $0.insertString("STRUCT_NAME", $1.name)
            $0.insertString("CLASS_NAME", $1.className)
            $0.iterate(block: "RECORD_PROPERTY", newContents: $1.properties) {
                $0.insertString("PROPERTY_NAME", $1.name)
                $0.insertString("PROPERTY_TYPE", $1.type)
            }
            for (tag, sep) in [("PACK_PROPERTY", ""), ("UNPACK_PROPERTY", ",")] {
                $0.iterate(block: tag, newContents: $1.properties, separator: sep) {
                    $0.insertString("PROPERTY_NAME", $1.name)
                    $0.insertString("PROPERTY_CODE", String(format: "0x%08x", $1.code))
                }
            }
        }
    }
    
    public func insertTypeAliases(_ block: String, _ typeAliasDefs: [TypeAliasDefinition]) {
        self.iterate(block: block, newContents: typeAliasDefs, emptyContent: "") {
            $0.insertString("ALIAS_NAME", $1.name)
            $0.insertString("TYPE_NAME", $1.type)
        }
    }
    
    public func removeTags(_ name: String, deleteContent: Bool) {
        self._template.replaceOccurrences(of: "(?s)«\\+\(name)»(.*?)«-\(name)»", with: deleteContent ? "" : "$1",
                                          options: .regularExpression, range: NSMakeRange(0, _template.length))
    }
}


/******************************************************************************/
// glue renderer

public func renderStaticGlueTemplate(glueSpec: GlueSpec, typeSupportSpec: TypeSupportSpec? = nil, importFramework: Bool = true,
                                     extraTags: [String:String] = [:], templateString: String? = nil) throws -> String {
    // note: SwiftGlueTemplate requires additional values for extraTags: ["AEGLUE_COMMAND": shellCommand,"GLUE_NAME": glueFileName]
    let glueTable = try glueSpec.buildGlueTable()
    let template = StaticGlueTemplate(string: templateString)
    template.insertString("PREFIX", glueSpec.classNamePrefix)
    template.insertString("IMPORT_SWIFTAE", importFramework ? "import SwiftAutomation" : "")
    template.insertString("SWIFTAE", importFramework ? "SwiftAutomation." : "")
    template.insertString("APPLICATION_CLASS_NAME", glueSpec.applicationClassName)
    template.insertString("FRAMEWORK_NAME", glueSpec.frameworkName)
    template.insertString("FRAMEWORK_VERSION", glueSpec.frameworkVersion)
    // include application info, if relevant
    template.insertString("APPLICATION_NAME", glueSpec.applicationFileName ?? "built-in")
    template.insertString("APPLICATION_VERSION", glueSpec.applicationVersion ?? "")
    template.insertString("BUNDLE_IDENTIFIER", glueSpec.bundleIdentifier ?? "")
    template.removeTags("DEFAULT_INIT", deleteContent: glueSpec.bundleIdentifier == nil)
    // insert name-code mappings
    // note: both by-name and by-code tables are used here to ensure conflicting keywords are represented correctly, e.g. if keyword `foo` is defined as both a type and a property but with different codes for each, it should appear only once in TYPE_SYMBOL (by-name) list but twice in SYMBOL_SWITCH (by-code) list; this [hopefully] emulates the way in which AppleScript resolves these conflicts
    template.insertKeywords("SYMBOL_SWITCH", glueTable.typesByCode.sorted(by: {$0.1.lowercased()<$1.1.lowercased()}))
    let typesByName = glueTable.typesByName.sorted(by: {$0.0.lowercased()<$1.0.lowercased()})
    template.insertKeywords("TYPE_SYMBOL", typesByName.filter({$1.descriptorType != typeEnumerated}).map({(code: $1.typeCodeValue, name: $0)}))
    template.insertKeywords("ENUM_SYMBOL", typesByName.filter({$1.descriptorType == typeEnumerated}).map({(code: $1.enumCodeValue, name: $0)}))
    template.insertKeywords("TYPE_FORMATTER", glueTable.typesByCode.sorted(by: {$0.1.lowercased()<$1.1.lowercased()}), emptyContent: ":")
    template.insertKeywords("PROPERTY_FORMATTER", glueTable.propertiesByCode.sorted(by: {$0.1.lowercased()<$1.1.lowercased()}), emptyContent: ":")
    template.insertKeywords("ELEMENTS_FORMATTER", glueTable.elementsByCode.sorted(by: {$0.1.lowercased()<$1.1.lowercased()}), emptyContent: ":")
    let specifiersByName = glueTable.specifiersByName.values.sorted(by: {$0.name.lowercased()<$1.name.lowercased()})
    template.insertKeywords("PROPERTY_SPECIFIER", specifiersByName.filter({$0.kind == TermType.property}) as! [KeywordTerm])
    template.insertKeywords("ELEMENTS_SPECIFIER", specifiersByName.filter({$0.kind == TermType.elementOrType}) as! [KeywordTerm])
    template.insertCommands("COMMAND", specifiersByName.filter({$0.kind == TermType.command}) as! [CommandTerm])
    // render any additional enum/struct/alias type definitions specified by user
    // these provide the glue file with better integration between AE and Swift type systems
    if let spec = typeSupportSpec {
        template.insertEnumeratedTypes("ENUM_TYPE_DEFINITION", try spec.enumeratedTypeDefinitions(classNamePrefix: glueSpec.classNamePrefix))
        template.insertRecordStructs("RECORD_STRUCT_DEFINITION", try spec.recordStructDefinitions(classNamePrefix: glueSpec.classNamePrefix,
                                                                                                  typesByName: glueTable.typesByName))
        template.insertTypeAliases("TYPEALIAS_DEFINITION", try spec.typeAliasDefinitions(classNamePrefix: glueSpec.classNamePrefix))
    } else {
        for name in ["ENUM_TYPE_DEFINITION", "RECORD_STRUCT_DEFINITION", "TYPEALIAS_DEFINITION", ] { template.removeTags(name, deleteContent: true) }
    }
    for (name, value) in extraTags { template.insertString(name, value) }
    return template.string
}


/******************************************************************************/
// generate quick-n-dirty user documentation by reformatting command, class, property, etc. names in SDEF XML

public func translateScriptingDefinition(_ data: Data, glueSpec: GlueSpec) throws -> Data {
    func convertNode(_ node: XMLElement, _ attributeName: String = "name", symbolPrefix: String = "") {
        if let attribute = node.attribute(forName: attributeName), let value = attribute.stringValue {
            attribute.stringValue = symbolPrefix + glueSpec.keywordConverter.convertSpecifierName(value)
        }
    }
    let xml = try XMLDocument(data: data, options: XMLNode.Options.documentXInclude)
    guard let root = xml.rootElement() else {
        throw TerminologyError("Malformed SDEF resource: missing root.")
    }
    // add attributes to root node indicating SDEF has been translated to SA syntax, including name of Application class (e.g. "ITunes")
    root.setAttributesWith(["apple-event-bridge-name": glueSpec.frameworkName,
                            "apple-event-bridge-version": glueSpec.frameworkVersion,
                            "application-class-name": glueSpec.applicationClassName,
                            "class-name-prefix": glueSpec.classNamePrefix])
    for suite in root.elements(forName: "suite") {
        for key in ["command", "event"] {
            for command in suite.elements(forName: key) {
                convertNode(command)
                for parameter in command.elements(forName: "parameter") {
                    if let attribute = parameter.attribute(forName: "name"), let value = attribute.stringValue {
                        attribute.stringValue = glueSpec.keywordConverter.convertParameterName(value)+":"
                    }
                }
            }
        }
        for key in ["class", "class-extension", "record-type"] {
            for klass in suite.elements(forName: key) {
                convertNode(klass)
                convertNode(klass, "plural")
                convertNode(klass, "inherits")
                for node in klass.elements(forName: "element") { convertNode(node, "type") }
                for node in klass.elements(forName: "property") { convertNode(node) }
                for node in klass.elements(forName: "contents") { convertNode(node) }
                for node in klass.elements(forName: "responds-to") { convertNode(node); convertNode(node, "command") }
            }
        }
        let symbolPrefix = "\(glueSpec.classNamePrefix)."
        for enumeration in suite.elements(forName: "enumeration") {
            for enumerator in enumeration.elements(forName: "enumerator") { convertNode(enumerator, symbolPrefix: symbolPrefix) }
        }
        for valueType in suite.elements(forName: "value-type") { convertNode(valueType) }
    }
    return xml.xmlData(options: XMLNode.Options.documentIncludeContentTypeDeclaration)
}


