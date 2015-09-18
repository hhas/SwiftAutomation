//
//  StaticGlueBuilder.swift
//  SwiftAE
//
//

import Foundation


public class StaticGlueSpec {
    public let applicationURL: NSURL? // TO DO: any use cases where user would want to use .sdef file rather than .app bundle?
    public let keywordConverter: KeywordConverterProtocol
    public let classNamesPrefix: String
    public let applicationClassName: String
    public let useSDEF: Bool
    public let bundleInfo: BundleInfoType
    
    public typealias BundleInfoType = [String:AnyObject]
    
    public var applicationFileName: String? { return self.applicationURL?.lastPathComponent }
    public var applicationName: String? { return self.bundleInfo["CFBundleName"] as? String }
    public var applicationVersion: String? { return self.bundleInfo["CFBundleShortVersionString"] as? String }
    public var bundleIdentifier: String? { return self.bundleInfo["CFBundleIdentifier"] as? String }
    // TO DO: eventually get following values from SwiftAE.framework bundle
    public var frameworkName: String { return "SwiftAE" }
    public var frameworkVersion: String { return "0.1.0" }
    
    // create StaticGlueSpec for specified application (applicationURL is typically a file:// URL, or nil to create default glue)
    public init(applicationURL: NSURL?, keywordConverter: KeywordConverterProtocol = gSwiftAEKeywordConverter,
                classNamesPrefix: String? = nil, applicationClassName: String? = nil, useSDEF: Bool = false) {
        self.applicationURL = applicationURL
        self.keywordConverter = keywordConverter
        self.useSDEF = useSDEF
        let bundleInfo: BundleInfoType = (applicationURL == nil) ? [:] : NSBundle(URL: applicationURL!)?.infoDictionary ?? [:]
        self.bundleInfo = bundleInfo
        let prefix = keywordConverter.prefixForAppName(classNamesPrefix ?? (bundleInfo["CFBundleName"] as? String)
                                                                        ?? (applicationURL == nil ? "AE" : "")) // TO DO: check empty string doesn't collide names
        self.classNamesPrefix = prefix
        let appName = keywordConverter.identifierForAppName(
                applicationClassName ?? (bundleInfo["CFBundleName"] as? String) ?? "\(prefix)Application")
        self.applicationClassName = (appName == self.classNamesPrefix) ? keywordConverter.escapeName(appName) : appName
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
    
    private let tmp: NSMutableString
    
    public init(var string: NSString? = nil) { // if nil, uses SwiftAEGlueTemplate
        if string == nil {
            // TO DO: temp kludge; eventually use NSBundle.pathForResource(_:ofType:inDirectory:) to look up in SwiftAE.framework
            let url = NSURLComponents(string:"SwiftAEGlueTemplate.txt")!.URLRelativeToURL(NSURL.fileURLWithPath(__FILE__))!
            string = try! NSString(contentsOfURL: url, encoding: NSUTF8StringEncoding)
        }
        self.tmp = NSMutableString(string: string!)
    }
    
    // utility functions for rendering tags
    
    public func insert(name: String, _ newContent: String) {
        self.tmp.replaceOccurrencesOfString("«\(name)»", withString: newContent,
                                            options: .LiteralSearch, range: NSMakeRange(0, tmp.length))
    }
    
    public func insertOSType(name: String, _ code: OSType) { // insert OSType as numeric and/or string literal representations (tag for the latter is name+"_STR")
        self.insert(name, NSString(format: "0x%08x", code) as String)
        self.insert("\(name)_STR", formatFourCharCodeString(code))
    }
    
    public func iterate<T>(name: String, _ newContents: [T], emptyContent: String = "", renderer: (StaticGlueTemplate, T) -> ()) {
        let tagLength = ("«+\(name)»" as NSString).length
        while true {
            let range = self.tmp.rangeOfString("(?s)«\\+\(name)».*?«-\(name)»",
                                           options: .RegularExpressionSearch, range: NSMakeRange(0, self.tmp.length))
            if range.length == 0 {
                return
            }
            let subString = self.tmp.substringWithRange(NSMakeRange(range.location+tagLength,range.length-tagLength*2))
            self.tmp.deleteCharactersInRange(range)
            var result = ""
            if newContents.count > 0 {
                for newContent in newContents { // TO DO: if newContents is generator, make sure this doesn't exhaust it (as in python)
                    result += StaticGlueTemplate(string: subString).subRender(newContent, renderer: renderer)
                }
            }else {
                result = emptyContent // e.g. empty dictionary literals require ':'
            }
            self.tmp.insertString(result, atIndex: range.location)
        }
    }
    
    public func omit(name: String, deleteContent: Bool) {
        self.tmp.replaceOccurrencesOfString("(?s)«\\+\(name)»(.*?)«-\(name)»", withString: deleteContent ? "" : "$1",
                                            options: .RegularExpressionSearch, range: NSMakeRange(0, tmp.length))
    }
    
    private func subRender<T>(newContents: T, renderer: (StaticGlueTemplate, T) -> ()) -> String {
        renderer(self, newContents)
        return self.string
    }
    
    public var string: String { return self.tmp.copy() as! String }
}


/******************************************************************************/


private func insertKeyword(template: StaticGlueTemplate, content: KeywordTerm) {
    template.insert("NAME", content.name)
    template.insertOSType("CODE", content.code)
}
private func insertKeyword(template: StaticGlueTemplate, content: (code: OSType, name: String)) {
    template.insert("NAME", content.name)
    template.insertOSType("CODE", content.code)
}

private func insertCommand(template: StaticGlueTemplate, term: CommandTerm) {
    template.insert("COMMAND_NAME", term.name)
    template.insertOSType("EVENT_CLASS", term.eventClass)
    template.insertOSType("EVENT_ID", term.eventID)
    template.iterate("PARAMETER", term.orderedParameters, renderer: insertKeyword)
}

// main renderer

func renderStaticGlueTemplate(glueSpec: StaticGlueSpec, extraTags: [String:String] = [:], templateString: String? = nil) throws -> String {
    // note: SwiftAEGlueTemplate requires additional values for extraTags: ["AEGLUE_COMMAND": shellCommand,"GLUE_NAME": glueFileName]
    let glueTable = try glueSpec.buildGlueTable()
    let template = StaticGlueTemplate(string: templateString)
    template.insert("PREFIX", glueSpec.classNamesPrefix)
    template.insert("APPLICATION_CLASS_NAME", glueSpec.applicationClassName)
    template.insert("FRAMEWORK_NAME", glueSpec.frameworkName)
    template.insert("FRAMEWORK_VERSION", glueSpec.frameworkVersion)
    // include application info, if relevant
    template.insert("APPLICATION_NAME", glueSpec.applicationFileName ?? "built-in")
    template.insert("APPLICATION_VERSION", glueSpec.applicationVersion ?? "")
    template.insert("BUNDLE_IDENTIFIER", glueSpec.bundleIdentifier ?? "")
    template.omit("DEFAULT_INIT", deleteContent: glueSpec.bundleIdentifier == nil)
    // insert name-code mappings
    // note: both by-name and by-code tables are used here to ensure conflicting keywords are represented correctly, e.g. if keyword `foo`
    // is defined as both a type and a property but with different codes for each, it should appear only once in TYPE_SYMBOL (by-name) list
    // but twice in SYMBOL_SWITCH (by-code) list; this [hopefully] emulates the way in which AppleScript resolves these conflicts
    template.iterate("SYMBOL_SWITCH", glueTable.typesByCode.sort({$0.1.lowercaseString<$1.1.lowercaseString}), renderer: insertKeyword)
    let typesByName = glueTable.typesByName.sort({$0.0.lowercaseString<$1.0.lowercaseString})
    template.iterate("TYPE_SYMBOL", typesByName.filter({$1.descriptorType != typeEnumerated}).map({(code: $1.typeCodeValue, name: $0)}), renderer: insertKeyword)
    template.iterate("ENUM_SYMBOL", typesByName.filter({$1.descriptorType == typeEnumerated}).map({(code: $1.enumCodeValue, name: $0)}), renderer: insertKeyword)
    template.iterate("PROPERTY_FORMATTER", glueTable.propertiesByCode.sort({$0.1.lowercaseString<$1.1.lowercaseString}), emptyContent: ":", renderer: insertKeyword)
    template.iterate("ELEMENTS_FORMATTER", glueTable.elementsByCode.sort({$0.1.lowercaseString<$1.1.lowercaseString}), emptyContent: ":", renderer: insertKeyword)
    let specifiersByName = glueTable.specifiersByName.values.sort({$0.name.lowercaseString<$1.name.lowercaseString})
    template.iterate("PROPERTY_SPECIFIER", specifiersByName.filter({$0.kind == TermType.Property}) as! [KeywordTerm], renderer: insertKeyword)
    template.iterate("ELEMENTS_SPECIFIER", specifiersByName.filter({$0.kind == TermType.ElementOrType}) as! [KeywordTerm], renderer: insertKeyword)
    template.iterate("COMMAND", specifiersByName.filter({$0.kind == TermType.Command}) as! [CommandTerm], renderer: insertCommand)
    for (name, value) in extraTags { template.insert(name, value) }
    return template.string
}


