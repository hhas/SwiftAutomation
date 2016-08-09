//
//  StaticGlueBuilder.swift
//  SwiftAE
//
//  Generate SwiftAE glue code and documentation.
//
//

import Foundation


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
    // TO DO: eventually get following values from SwiftAE.framework bundle
    public var frameworkName: String { return "SwiftAE.framework" }
    public var frameworkVersion: String { return "0.1.0" }
    
    // create GlueSpec for specified application (applicationURL is typically a file:// URL, or nil to create default glue)
    public init(applicationURL: URL?, keywordConverter: KeywordConverterProtocol = gSwiftAEKeywordConverter,
                classNamePrefix: String? = nil, applicationClassName: String? = nil, useSDEF: Bool = false) {
        self.applicationURL = applicationURL
        self.keywordConverter = keywordConverter
        self.useSDEF = useSDEF
        let bundleInfo: BundleInfoType = (applicationURL == nil) ? [:] : Bundle(url: applicationURL!)?.infoDictionary ?? [:]
        self.bundleInfo = bundleInfo
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
            if let url = self.applicationURL {
            var parser: ApplicationTerminology
            if self.useSDEF {
                parser = SDEFParser(keywordConverter: self.keywordConverter)
                try (parser as! SDEFParser).parse(GetScriptingDefinition(url))
            } else {
                parser = try AEApplication(url: url).parseAETE(self.keywordConverter)
            }
            glueTable.addApplicationTerminology(parser)
        }
        return glueTable
    }
}


/******************************************************************************/


public class StaticGlueTemplate {
    // Note: this is not a general-purpose templating engine. In particular, «+NAME»...«-NAME» blocks have leaky scope,
    // so replacing «FOO» tags in the top-level scope will replace all «FOO» tags within «+NAME»...«-NAME» blocks too.
    // This makes it easy to (e.g.) replace all «PREFIX» tags throughout the template, but also means nested tags must
    // use different names when unrelated to each other (e.g. «COMMAND_NAME» vs (parameter) «NAME») so that replacing
    // one does not replace them all.
    
    private let _template: NSMutableString
    
    public var string: String { return self._template.copy() as! String }
    
    
    public init(string: NSString? = nil) { // if nil, uses SwiftAEGlueTemplate
        var string = string
        if string == nil {
            // TO DO: temp kludge; eventually use NSBundle.pathForResource(_:ofType:inDirectory:) to look up in SwiftAE.framework
            let url = URLComponents(string:"SwiftAEGlueTemplate.txt")!.url(relativeTo: URL(fileURLWithPath: #file))!
            string = try! NSString(contentsOf: url, encoding: String.Encoding.utf8.rawValue)
        }
        self._template = NSMutableString(string: string!)
    }
    
    private func subRender<T>(_ newContents: T, renderer: (StaticGlueTemplate, T) -> ()) -> String {
        renderer(self, newContents)
        return self.string
    }
    
    private func iterate<T>(_ name: String, newContents: [T], emptyContent: String,renderer: (StaticGlueTemplate, T) -> ()) {
        let tagLength = ("«+\(name)»" as NSString).length
        while true {
            let range = self._template.range(of: "(?s)«\\+\(name)».*?«-\(name)»",
                                           options: .regularExpression, range: NSMakeRange(0, self._template.length))
            if range.length == 0 {
                return
            }
            let subString = self._template.substring(with: NSMakeRange(range.location+tagLength,range.length-tagLength*2))
            self._template.deleteCharacters(in: range)
            var result = ""
            if newContents.count > 0 {
                for newContent in newContents { // TO DO: if newContents is generator, make sure this doesn't exhaust it (as in python)
                    result += StaticGlueTemplate(string: subString).subRender(newContent, renderer: renderer)
                }
            }else {
                result = emptyContent // e.g. empty dictionary literals require ':'
            }
            self._template.insert(result, at: range.location)
        }
    }
    
    // render tags
    
    public func insertString(_ name: String, _ newContent: String) {
        self._template.replaceOccurrences(of: "«\(name)»", with: newContent,
            options: .literal, range: NSMakeRange(0, _template.length))
    }
    
    public func insertOSType(_ name: String, _ code: OSType) { // insert OSType as numeric and/or string literal representations (tag for the latter is name+"_STR")
        self.insertString(name, NSString(format: "0x%08x", code) as String)
        self.insertString("\(name)_STR", formatFourCharCodeString(code))
    }
    
    public func insertKeywords(_ name: String, _ newContents: [KeywordTerm], emptyContent: String = "") {
        self.iterate(name, newContents: newContents, emptyContent: emptyContent) {
            $0.insertString("NAME", $1.name)
            $0.insertOSType("CODE", $1.code)
        }
    }
    public func insertKeywords(_ name: String, _ newContents: [(key:OSType, value:String)], emptyContent: String = "") {
        self.iterate(name, newContents: newContents, emptyContent: emptyContent) {
            $0.insertString("NAME", $1.1)
            $0.insertOSType("CODE", $1.0)
        }
    }
    
    public func insertCommands(_ name: String, _ newContents: [CommandTerm], emptyContent: String = "") {
        self.iterate(name, newContents: newContents, emptyContent: emptyContent) {
            $0.insertString("COMMAND_NAME", $1.name)
            $0.insertOSType("EVENT_CLASS", $1.eventClass)
            $0.insertOSType("EVENT_ID", $1.eventID)
            $0.insertKeywords("PARAMETER", $1.orderedParameters)
        }
    }
    
    public func removeTags(_ name: String, deleteContent: Bool) {
        self._template.replaceOccurrences(of: "(?s)«\\+\(name)»(.*?)«-\(name)»", with: deleteContent ? "" : "$1",
                                            options: .regularExpression, range: NSMakeRange(0, _template.length))
    }
}


/******************************************************************************/
// glue renderer

public func renderStaticGlueTemplate(_ glueSpec: GlueSpec, extraTags: [String:String] = [:], templateString: String? = nil) throws -> String {
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
    // note: both by-name and by-code tables are used here to ensure conflicting keywords are represented correctly, e.g. if keyword `foo`
    // is defined as both a type and a property but with different codes for each, it should appear only once in TYPE_SYMBOL (by-name) list
    // but twice in SYMBOL_SWITCH (by-code) list; this [hopefully] emulates the way in which AppleScript resolves these conflicts
    template.insertKeywords("SYMBOL_SWITCH", glueTable.typesByCode.sorted(by: {$0.1.lowercased()<$1.1.lowercased()}))
    let typesByName = glueTable.typesByName.sorted(by: {$0.0.lowercased()<$1.0.lowercased()})
    template.insertKeywords("TYPE_SYMBOL", typesByName.filter({$1.descriptorType != typeEnumerated}).map({(code: $1.typeCodeValue, name: $0)}))
    template.insertKeywords("ENUM_SYMBOL", typesByName.filter({$1.descriptorType == typeEnumerated}).map({(code: $1.enumCodeValue, name: $0)}))
    template.insertKeywords("PROPERTY_FORMATTER", glueTable.propertiesByCode.sorted(by: {$0.1.lowercased()<$1.1.lowercased()}), emptyContent: ":")
    template.insertKeywords("ELEMENTS_FORMATTER", glueTable.elementsByCode.sorted(by: {$0.1.lowercased()<$1.1.lowercased()}), emptyContent: ":")
    let specifiersByName = glueTable.specifiersByName.values.sorted(by: {$0.name.lowercased()<$1.name.lowercased()})
    template.insertKeywords("PROPERTY_SPECIFIER", specifiersByName.filter({$0.kind == TermType.property}) as! [KeywordTerm])
    template.insertKeywords("ELEMENTS_SPECIFIER", specifiersByName.filter({$0.kind == TermType.elementOrType}) as! [KeywordTerm])
    template.insertCommands("COMMAND", specifiersByName.filter({$0.kind == TermType.command}) as! [CommandTerm])
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
    return xml.xmlData(withOptions: (1 << 18)) // XMLNode.Options.nodePrettyPrint|XMLNode.Options.documentIncludeContentTypeDeclaration
}


