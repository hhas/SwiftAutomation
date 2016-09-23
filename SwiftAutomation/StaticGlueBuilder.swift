//
//  StaticGlueBuilder.swift
//  SwiftAutomation
//
//  Generate SwiftAutomation glue file and SDEF documentation.
//
//

// TO DO: how difficult would it be to auto-generate enum/struct/typealias type definitions from an app's AETE/SDEF? (bearing in mind that AETE/SDEF-supplied type info is frequently vague, ambiguous, incomplete, and/or wrong, so a manual option will always be required as well); this basically falls into same camp as how to auto-generate struct-based record definitions as a more static-friendly alternative to AppData's standard AERecordDesc<->[Symbol:Any] mapping; may be worth exploring later (and will need a manual format string option as well, e.g. "STRUCTNAME=PROPERTY1:TYPE1+PROPERTY2:TYPE2+..."). 
//
// ANSWER: it'd be doable, but practically useless. Incomplete/incorrect type info is commoner than muck in app dictionaries - even the `path` property of Standard Suite's `document` class is wrong, declaring its type as `text` when it's really `text or missing value`; furthermore, because most Cocoa apps use `text` for both cText and typeUnicodeText, it's impossible to know which of these a given property actually holds. (Note: this also buggers up dictionary viewers and AEOM browsers by making it impossible to distinguish a property that represents an object attribute from a property that represents a one-to-one relationship with another object. Meantime, if the `text` property was declared correctly as a reference, getting document's properties as a record struct would break because the app automatically resolves the request to return text, not a reference.) 
//
// In other words, generating correct glue classes is impossible without additional manual correction; if Apple's own devs can't get this information right in CocoaScripting's standard terminology and CocoaScripting lets them away with it too, what chance have Cocoa app developers of getting their app-specific terms correct; never mind Carbon apps which don't care about or use crappy AETE (or SDEF) type info at all? 
//
// FWIW, if a pure-Swift AEOM handler framework ever gets built, it could address all these issues by radically simplifying and comprehensively prescribing the AEOM spec, then generate a formal IDL from the implementation which could be used to generate a robust glue (not to mention much more detailed user documentation, free test suites, and reliable implementation). Until then, the only value in auto-generating these definitions (as format strings only, not as Swift code) would be to give users a starting point from which to make their own corrections; and under the circumstances it'd simpler for them just to write minimal format strings for the bits of records they'll actually use, or just use the standard [Symbol:Any] dictionaries and do their own checking/casting of property values as needed. (Though if SwiftAutomation ever catches on then app developers might consider creating and distributing ready-to-use glue modules themselves, saving users the hassle of generating their own, at which point more powerful tools might be of some advantage).

// TO DO: parseEnumeratedTypeDefinition needs special-case handling for "Missing" (basically, pull it out of the typeNames list and set a flag that adds `case missing` to the enum) [note: don't need special support for "Optional", but probably should report it as an error just to remind users to typealias it themselves; ditto for "Array", "Dictionary", "Set" as generics aren't [yet] supported directly]

// TO DO: this code is pretty messy; tidy up later


import Foundation



/******************************************************************************/
// Additional Swift type system support

// glue renderer consumes the following data structures

public typealias EnumeratedTypeDefinition = (name: String, cases: [(name: String, type: String)]) // TO DO: add `mayBeMissing: Bool`? alternatively, just map "MissingValue" to case missing(MissingValueType), and include an `init(_ value: MissingValueType=MissingValue)` in enum, thereby avoiding the need to parse and format "MissingValue" as special case (TO DO: for consistency, the `MayBeMissing<T>` enum should probably have the same structure - currently it uses `case missing` without the MissingValue argument; alternatively, could ditch `MayBeMissing<T>` altogether and just require users to specify all of the enums they'll need - basically convenience [in the common case] vs consistency [we wouldn't need to code-generate enums at all if T could be a vararg. but that's not going to happen without a decent macro system])

public typealias RecordStructDefinition = (name: String, className: String, properties: [(name: String, code: OSType, type: String)])

public typealias TypeAliasDefinition = (name: String, type: String)


// the following names are reserved by glue generator
let ReservedGlueTypeNames: Set<String> = ["symbol", "object", "insertion", "item", "items", "root", "record"] // enum/typealias/struct format string parsers will automatically prefix these names with classNamePrefix // TO DO: should probably be on glueSpec.keywordConverter

func isReservedGlueTypeName(_ string: String) -> Bool {
    return ReservedGlueTypeNames.contains(string.lowercased())
}




class SyntaxError: SwiftAutomationError {
    
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


// TO DO: skipSpace(_ chars: inout String.CharacterView)

func advanceOne(_ chars: inout String.CharacterView, character c: Character, after: String) throws {
    if chars.first != c { throw SyntaxError(found: chars.first, butExpected: "'\(c)'", after: after) }
    chars.removeFirst()
}


func parseIdentifier(_ chars: inout String.CharacterView) throws -> String {
    // reads a C-identifier, checking it isn't a Swift keyword
    var foundChars = String.CharacterView()
    let c = chars.popFirst()
    if c == nil || !kLegalFirstChars.contains(c!) { throw SyntaxError(found: c, butExpected: "an identifier") }
    foundChars.append(c!)
    while let c = chars.first {
        if !kLegalOtherChars.contains(c) { break }
        foundChars.append(chars.popFirst()!)
    }
    let name = String(foundChars)
    if kSwiftKeywords.contains(name) {
        throw SyntaxError("Expected an identifier but found reserved keyword '\(name)' instead.")
    }
    return name
}

func parseType(_ chars: inout String.CharacterView, classNamePrefix: String) throws -> String {
    // reads a C-identifier optionally followed by <TYPE[,TYPE,...]> generic parameters, as used on right side of typealias and struct property definitions; characters are consumed from chars parameter until the name is fully read, then the name is returned as String
    // if the name is one of the base names used by SwiftAutomation (Symbol, Object, etc), a class name prefix is automatically added; this allows the same format string to be reused for multiple glues
    var name = try parseIdentifier(&chars)
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


func parseProperty(_ chars: inout String.CharacterView, classNamePrefix: String) throws -> (String, String) {
    // parse "NAME:TYPE" pair
    let propertyName = try parseIdentifier(&chars)
    try advanceOne(&chars, character: kPairChar, after: propertyName)
    return (propertyName, try parseType(&chars, classNamePrefix: classNamePrefix))
}


// typealias format string parser

public func parseTypeAliasDefinition(_ string: String, classNamePrefix: String) throws -> TypeAliasDefinition {
    // TO DO: don't bother splitting; just define a skipChar() function that consumes one char and errors if it's not the char expected
    let parts = string.characters.split(maxSplits:1, whereSeparator: {$0=="="})//.map(String.init)
    if parts.count != 2 { throw SyntaxError("Expected 'ALIASNAME=TYPE' format string.") }
    let name = String(parts[0])
    try validateCIdentifier(name)
    if isReservedGlueTypeName(name) { throw SyntaxError("Invalid typealias name: \(name)")}
    var chars = parts[1]
    let value = try parseType(&chars, classNamePrefix: classNamePrefix)
    if !chars.isEmpty { throw SyntaxError("Expected end of text but found \(String(chars)).") }
    return (classNamePrefix + name, value)
}


// enum type format string parser "[TYPENAME=]TYPE1+TYPE2+..."

func parseEnumeratedTypeDefinition(_ string: String, classNamePrefix: String) throws -> EnumeratedTypeDefinition {
    // an enumerated (aka sum/union) type definition is written as a simple format string: "[TYPENAME=]TYPE1+TYPE2+..."
    // note that class name prefixes are added automatically to both "TYPENAME" and (as needed) "TYPEn", allowing a format string to be used over multiple glues, e.g. "URL+Item" -> `enum FINURLOrItem { case URL; case FINItem; ...}`, or "FileObject=URL+Item" -> `enum FINFileObject { case URL; case FINItem; ...}`
    
    // TO DO: allow this to take generic types on RHS on condition that an enumName is specified (since autogenerating names for Array/Dictionary/Set/Optional generic types is a bit too complicated)
    
    // TO DO: also needs to support 'MissingValue' as a special case, e.g. 'Int+String+MissingValue' would include a `case missing`, similar to MayBeMissing<T> enum but flattened out (since MayBeMissing)
    
    let parts = string.characters.split(maxSplits:1, whereSeparator: {$0=="="})
    let typeNames = try parts.last!.split(whereSeparator: {$0=="+"}).map {
        (chars: String.CharacterView) throws -> (String, String, String) in
        let typeName = String(chars)
        try validateCIdentifier(typeName)
        var caseName = typeName.lowercased()
        if !UPPERCHAR.contains(typeName[typeName.startIndex]) { caseName = "_\(caseName)" }
        if kSwiftKeywords.contains(caseName) { caseName += "_" }
        return (caseName, (isReservedGlueTypeName(typeName) ? (classNamePrefix + typeName) : typeName), typeName)
    }
    if typeNames.count < 2 { throw SyntaxError("Not a valid enumerated type definition: '\(string)'") }
    var enumName: String
    if parts.count == 2 {
        enumName = String(parts[0])
        try validateCIdentifier(enumName)
    } else { // auto-generate from typeNames
        enumName = typeNames.map {
            (_, _, name: String) -> String in
            var chars = name.characters
            let c = chars.popFirst()!
            return String(c).uppercased() + String(chars).lowercased()
            }.joined(separator: "Or")
        if kSwiftKeywords.contains(enumName) { enumName += "_" }
    }
    if isReservedGlueTypeName(enumName) { throw SyntaxError("Invalid enum name: \(enumName)") }
    return (classNamePrefix + enumName, typeNames.map { (caseName, typeName, _) in return (caseName, typeName) })
}


// struct record format string parser "STRUCTNAME[:CLASS]=PROPERTYNAME:TYPE+PROPERTYNAME:TYPE+..."

func parseRecordStructDefinition(_ string: String, classNamePrefix: String,
                                 typesByName: [String: NSAppleEventDescriptor]) throws -> RecordStructDefinition {
    var chars = string.characters
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
    repeat { // TO DO: skip any non-significant spaces in format string (currently spaces aren't allowed in format string)
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

// TO DO: refactor parse methods for better code reuse

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
        return try self.enumeratedTypeFormats.map {
            try parseEnumeratedTypeDefinition($0, classNamePrefix: classNamePrefix)
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
    public init(applicationURL: URL?, keywordConverter: KeywordConverterProtocol = gSwiftAEKeywordConverter,
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
    // Note: this is not a general-purpose templating engine. In particular, «+NAME»...«-NAME» blocks have leaky scope,
    // so replacing «FOO» tags in the top-level scope will replace all «FOO» tags within «+NAME»...«-NAME» blocks too.
    // This makes it easy to (e.g.) replace all «PREFIX» tags throughout the template, but also means nested tags must
    // use different names when unrelated to each other (e.g. «COMMAND_NAME» vs (parameter) «NAME») so that replacing
    // one does not replace them all.
    
    private let _template: NSMutableString
    
    public var string: String { return self._template.copy() as! String }
    
    
    public init(string: String = SwiftAEGlueTemplate) {
        self._template = NSMutableString(string: string)
    }
    
    private func subRender<T>(_ newContents: T, renderer: (StaticGlueTemplate, T) -> ()) -> String {
        renderer(self, newContents)
        return self.string
    }
    
    private func iterate<T>(block name: String, newContents: [T], emptyContent: String = "",
                            separator: String = "", renderer: (StaticGlueTemplate, T) -> ()) {
        let tagLength = ("«+\(name)»" as NSString).length
        while true {
            let range = self._template.range(of: "(?s)«\\+\(name)».*?«-\(name)»",
                                             options: .regularExpression, range: NSMakeRange(0, self._template.length))
            if range.length == 0 {
                return
            }
            let subString = self._template.substring(with: NSMakeRange(range.location+tagLength,range.length-tagLength*2))
            self._template.deleteCharacters(in: range)
            var result = [String]()
            if newContents.count > 0 {
                for newContent in newContents {
                    result.append(StaticGlueTemplate(string: subString).subRender(newContent, renderer: renderer))
                }
            }else {
                result = [emptyContent] // e.g. empty dictionary literals require ':'
            }
            self._template.insert(result.joined(separator: separator), at: range.location)
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

public func renderStaticGlueTemplate(glueSpec: GlueSpec, typeSupportSpec: TypeSupportSpec? = nil,
                                     extraTags: [String:String] = [:], templateString: String = SwiftAEGlueTemplate) throws -> String {
    // note: SwiftAEGlueTemplate requires additional values for extraTags: ["AEGLUE_COMMAND": shellCommand,"GLUE_NAME": glueFileName]
    let glueTable = try glueSpec.buildGlueTable()
    let template = StaticGlueTemplate(string: templateString)
    template.insertString("PREFIX", glueSpec.classNamePrefix)
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


// generate quick-n-dirty user documentation by reformatting command, class, property, etc. names in SDEF XML

public func translateScriptingDefinition(_ data: Data, glueSpec: GlueSpec) throws -> Data {
    func convertNode(_ node: XMLElement, _ attributeName: String = "name", symbolPrefix: String = "") {
        if let attribute = node.attribute(forName: attributeName) {
            if let value = attribute.stringValue {
                attribute.stringValue = symbolPrefix + glueSpec.keywordConverter.convertSpecifierName(value)
            }
        }
    }
    let xml = try XMLDocument(data: data, options: 0)
    guard let root = xml.rootElement() else {
        throw TerminologyError("Malformed SDEF resource: missing root.")
    }
    for suite in root.elements(forName: "suite") {
        for key in ["command", "event"] {
            for command in suite.elements(forName: key) {
                convertNode(command)
                for parameter in command.elements(forName: "parameter") {
                    if let attribute = parameter.attribute(forName: "name") {
                        if let value = attribute.stringValue {
                            attribute.stringValue = glueSpec.keywordConverter.convertParameterName(value)+":" // TO DO: formatting of param names should ideally be parameterized for reusability; maybe add `formatCommandName`, `formatParamName`, `formatEnum`, etc. methods to keywordConverter, and call those instead of `convert...`?
                        }
                    }
                }
            }
        }
        for key in ["class", "class-extension", "record-type"] {
            for klass in suite.elements(forName: key) {
                convertNode(klass)
                convertNode(klass, "plural")
                for node in klass.elements(forName: "element") { convertNode(node, "type") }
                for node in klass.elements(forName: "property") { convertNode(node) }
                for node in klass.elements(forName: "contents") { convertNode(node) }
                for node in klass.elements(forName: "responds-to") { convertNode(node); convertNode(node, "command") }
            }
        }
        let symbolPrefix = "\(glueSpec.classNamePrefix)."
        for enumeration in suite.elements(forName: "enumeration") {
            for enumerator in enumeration.elements(forName: "enumerator") { convertNode(enumerator, symbolPrefix: symbolPrefix) } // TO DO: as above, enum formatting should ideally be parameterized
        }
        for valueType in suite.elements(forName: "value-type") { convertNode(valueType) }
    }
    return xml.xmlData(withOptions: (1 << 17 | 1 << 18)) // [XMLNode.Options.nodePrettyPrint,XMLNode.Options.documentIncludeContentTypeDeclaration]
}


