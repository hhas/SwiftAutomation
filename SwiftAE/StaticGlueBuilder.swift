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
    public let bundleInfo: [String:Any]
    
    public var applicationFileName: String? { return self.applicationURL?.lastPathComponent }
    public var applicationName: String? { return self.bundleInfo["CFBundleName"] as? String }
    public var applicationVersion: String? { return self.bundleInfo["CFBundleShortVersionString"] as? String }
    public var bundleIdentifier: String? { return self.bundleInfo["CFBundleIdentifier"] as? String }
    // TO DO: eventually get following values from SwiftAE.framework bundle
    public var frameworkName: String { return "SwiftAE" }
    public var frameworkVersion: String { return "0.1.0" }
    
    // create StaticGlueSpec for default AEApplication glue
    public init(keywordConverter: KeywordConverterProtocol = gSwiftAEKeywordConverter) {
        self.applicationURL = nil
        self.keywordConverter = keywordConverter
        self.useSDEF = false
        self.bundleInfo = [:]
        self.classNamesPrefix = "AE"
        self.applicationClassName = "AEApplication"
    }
    
    // create StaticGlueSpec for specified application (applicationURL is typically a file:// URL)
    public init(applicationURL: NSURL, keywordConverter: KeywordConverterProtocol,
                classNamesPrefix: String? = nil, applicationClassName: String? = nil, useSDEF: Bool = false) {
        self.applicationURL = applicationURL
        self.keywordConverter = keywordConverter
        self.useSDEF = useSDEF
        let bundleInfo = NSBundle(URL: applicationURL)?.infoDictionary ?? [:] // TO DO: log warning if empty/not found?
        self.bundleInfo = bundleInfo
        let prefix = keywordConverter.prefixForAppName(classNamesPrefix ?? (bundleInfo["CFBundleName"] as? String) ?? "PREFIX")
        self.classNamesPrefix = prefix
        let name = keywordConverter.identifierForAppName(
                applicationClassName ?? (bundleInfo["CFBundleName"] as? String) ?? "\(prefix)Application")
        self.applicationClassName = (name == self.classNamesPrefix) ? keywordConverter.escapeName(name) : name
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
    
    private let tmp: NSMutableString
    
    public init(var string: NSString? = nil) { // if nil, uses SwiftAEGlueTemplate
        if string == nil {
            // TO DO: temp kludge; eventually use NSBundle.pathForResource(_:ofType:inDirectory:) to look up in SwiftAE.framework
            let url = NSURLComponents(string:"SwiftAEGlueTemplate.txt")!.URLRelativeToURL(NSURL.fileURLWithPath(__FILE__))!
            string = try! NSString(contentsOfURL: url, encoding: NSUTF8StringEncoding)
        }
        self.tmp = NSMutableString(string: string!)
    }
    
    // note: following methods would ideally respect nesting of paired tags, but that'd require more complex parsing/rendering, so just make sure unrelated tags' names are always unique throughout the template
    
    // utility functions for rendering tags
    
    public func insert(name: String, _ newContent: String) {
        self.tmp.replaceOccurrencesOfString("«\(name)»", withString: newContent,
                                            options: .LiteralSearch, range: NSMakeRange(0, tmp.length))
    }
    
    public func insertOSType(name: String, _ code: OSType) { // insert OSType as numeric and/or string literal representations (tag for the latter is name+"_STR")
        self.insert(name, NSString(format: "0x%08x", code) as String)
        self.insert("\(name)_STR", FourCharCodeString(code))
    }
    
    public func iterate<T>(name: String, _ newContents: [T], emptyContent: String = "", renderer: (StaticGlueTemplate, T) -> ()) {
        var index: Int = 0
        let tagLength = ("(?s)«\\+\(name)»" as NSString).length
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
            index = range.location + (result as NSString).length
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

private func insertCommand(template: StaticGlueTemplate, term: CommandTerm) {
    template.insert("COMMAND_NAME", term.name)
//    template.insert("CAP_NAME", term.name[0].upper()+term.name[1:]) // TO DO
    template.insertOSType("EVENT_CLASS", term.eventClass)
    template.insertOSType("EVENT_ID", term.eventID)
    template.iterate("PARAMETER", term.orderedParameters, renderer: insertKeyword) // TO DO: fix, as above, use KeywordTerm
}

// main renderer

func renderStaticGlueTemplate(glueSpec: StaticGlueSpec, extraTags: [String:String] = [:], templateString: String? = nil) throws -> String {
    // extra tags for SwiftAEGlueTemplate: ["AEGLUE_COMMAND": shellCommand,"GLUE_NAME": glueFileName]
    let glueTable = try glueSpec.buildGlueTable()
    let template = StaticGlueTemplate(string: templateString)
    template.insert("PREFIX", glueSpec.classNamesPrefix)
    template.insert("APPLICATION_CLASS_NAME", glueSpec.applicationClassName)
    template.insert("FRAMEWORK_NAME", glueSpec.frameworkName)
    template.insert("FRAMEWORK_VERSION", glueSpec.frameworkVersion)
    // include application info, if relevant
    template.insert("APPLICATION_NAME", glueSpec.applicationFileName ?? "")
    template.insert("APPLICATION_VERSION", glueSpec.applicationVersion ?? "")
    template.insert("BUNDLE_IDENTIFIER", glueSpec.bundleIdentifier ?? "")
    template.omit("DEFAULT_INIT", deleteContent: glueSpec.bundleIdentifier == nil)
    // insert name-code mappings
    let propertyTerms = glueTable.propertiesByName.values.sort({$0.name.lowercaseString<$1.name.lowercaseString})
    let elementsTerms = glueTable.elementsByName.values.sort({$0.name.lowercaseString<$1.name.lowercaseString})
    template.iterate("PROPERTY_FORMATTER", propertyTerms, emptyContent: ":", renderer: insertKeyword)
    template.iterate("ELEMENTS_FORMATTER", elementsTerms, emptyContent: ":", renderer: insertKeyword)
    template.iterate("PROPERTY_SPECIFIER", propertyTerms, renderer: insertKeyword)
    template.iterate("ELEMENTS_SPECIFIER", elementsTerms, renderer: insertKeyword)
    template.iterate("COMMAND", glueTable.commandsByName.values.sort({$0.name.lowercaseString<$1.name.lowercaseString}), renderer: insertCommand)
    // note: GlueTable.typeBy... dictionary structure is optimized for dynamic glues, so require extra rejigging
    let typeTerms = glueTable.typesByName
            .map({KeywordTerm(name:$0, kind: ($1.descriptorType == typeEnumerated ? .Enumerator : .ElementOrType), code:$1.typeCodeValue)})
            .sort({$0.name.lowercaseString<$1.name.lowercaseString})
    template.iterate("SYMBOL_SWITCH", typeTerms, renderer: insertKeyword)
    template.iterate("TYPE_SYMBOL", typeTerms.filter({$0.kind == TermType.ElementOrType}), renderer: insertKeyword)
    template.iterate("ENUM_SYMBOL", typeTerms.filter({$0.kind == TermType.Enumerator}), renderer: insertKeyword)
    for (name, value) in extraTags {
        template.insert(name, value)
    }
    return template.string
}


