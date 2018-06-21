//
//  main.swift
//  aeglue
//
//  Generate application-specific glue files for SwiftAutomation.
//
//


// TO DO: add `-c` option for converting an existing SDEF (passed as stdin/file) from AS to SA format


import Foundation
//import SwiftAutomation // TO DO: the `aeglue` target currently bakes everything into CLI executable; if/when Swift finally supports dynamic framework linking, use import instead



let optionsWithArguments = Set<Character>("npeo") // this MUST contain all options that also require arguments (used to separate option key from value if not explicitly separated by whitespace, e.g. '-pABC' -> '-p ABC')

// TO DO: only include ANSI styles when writing to console; pull out char seqs into separate constants, and toggle according to stdout type

let helpText = [
    "Generate SwiftAutomation glue classes and SDEF documentation for",
    " controlling an \"AppleScriptable\" application from Swift.",
    "",
    "\u{1B}[1mUSAGE\u{1B}[m", // TO DO: only use ANSI control chars if connected to tty
    "",
    "    aeglue [-DdrS] [-n CLASSNAME] [-p PREFIX]",
    "           [-est FORMAT ...] [-o OUTDIR] [APPNAME ...]",
    "    aeglue [-hv]",
    "",
    "APPNAME - Name or path to application. If -n and -p options are",
    "              omitted, multiple applications may be specified.",
    "              If APPNAME is omitted, a default glue is generated.",
    "",
    "On completion, the generated files' paths are written to STDOUT.",
    "",
    "\u{1B}[1mOPTIONS\u{1B}[m",
    "",
    "    -d             Do not generate an SDEF documentation file.",
    "    -D             Do not import the SwiftAutomation framework.",
    "    -e FORMAT      An enumerated type definition; see Type Support.",
    "    -h             Show this help and exit.",
    "    -n CLASSNAME   C-style identifier to use as the Application",
    "                       class's name. Auto-generated if omitted.",
    "    -o OUTDIR      Path to directory in which the glue files will",
    "                       be created; if omitted, the current working",
    "                       directory is used.",
    "    -p PREFIX      Three-character prefix for glue's other classes.",
    "                       Auto-generated if omitted.",
    "    -r             Overwrite existing files.",
    "    -s FORMAT      A record struct definition; see Type Support.",
    "    -S             Use SDEF terminology instead of AETE, e.g. if",
    "                       application's ascr/gdte handler is broken.",
    "    -t FORMAT      A type alias definition; see Type Support.",
    "    -v             Output the SwiftAutomation framework's version",
    "                       and exit.",
    "",
    "\u{1B}[1mEXAMPLES\u{1B}[m",
    "",
    "    aeglue iTunes",
    "",
    "    aeglue -r -S Finder",
    "",
    "    aeglue -p TE TextEdit ~/Desktop",
    "",
    "\u{1B}[1mTYPE SUPPORT\u{1B}[m",
    
    // TO DO: finish
    // TO DO: the full details would probably be better covered in the documentation's 'Creating glues' chapter, with only the format string structures shown here
    
    "",
    "The -e, -s, and -t options can be used to add custom Swift enums,",
    "structs, and typealiases into the generated glue files, providing",
    "better integration between Swift's strong, static type system and",
    "the Apple Event Manager's weak, dynamic types. Each option may",
    "appear any number of times and takes a format string as argument.",
    "",
    "\u{1B}[4mEnumerated types\u{1B}[m",
    "",
    "Enumerated types enable commands whose results can have multiple",
    "types to return those values in a type-safe way.",
    "",
    "For example, if a command can return a Symbol \u{1B}[1mor\u{1B}[m a String, include",
    "the following -e option in the aeglue command:",
    "",
    "    -e Symbol+String",
    "",
    "The -e option's argument must have the following format:",
    "",
    "    [ENUMNAME=][CASE1:]TYPE1+[CASE1:]TYPE2+...",
    "",
    "ENUMNAME is the name to be given to the enumerated type, e.g.",
    "MyType. If omitted, a default name is automatically generated.",
    "",
    "TYPEn is the name of an existing Swift type, e.g. String or a",
    "standard SwiftAutomation type: Symbol, Object, Insertion, Item,",
    "or Items (the glue PREFIX will be added automatically). CASEn is",
    "the name of the case to which values of that type are assigned.",
    "If the TYPE is parameterized, e.g. Array<String>, the CASE name",
    "must also be given, otherwise it can be omitted and a default",
    "name will be derived from the TYPE name, e.g. Int -> int.",
    "",
    "For example, to define an enum named MASymbolOrIntOrString", // TO DO: a real-world example would be better
    "which can represent a Symbol, Int, or String:",
    "",
    "    aeglue -e Symbol+Int+String -p MA 'My App'",
    // TO DO: note that `Symbol` must come before `String`, to avoid type/enum codes being coerced to four-char-code strings (which AEM allows)
    "",
    "\u{1B}[4mRecord structs\u{1B}[m",
    // TO DO: document struct and typealias format strings too
    "",
    "While SwiftAutomation packs and unpacks Apple event records",
    "Dictionary<PREFIXSymbol:Any> values as standard, it is also",
    "possible to map part or all of a specific record structures to",
    "a Swift struct, simplifying property access and improving type ",
    "safety.",
    "",
    "\u{1B}[4mType aliases\u{1B}[m",
    "",
    "The -t option adds a typealias to the glue file. For example,",
    "to define a typealias for Array<String> named PREFIXStrings:",
    "",
    "    -t 'Strings=Array<String>'",
    "",
    "The -t option's format string has the following structure:",
    "",
    "    ALIASNAME=TYPE",
    "",
    "The glue's PREFIX is added automatically to ALIASNAME, and to",
    "any reserved type names that appear within TYPE.",
    "",
    ""].joined(separator: "\n")


// utility functions

func validateOption(opt: String, arg: String?) {
    if arg == nil || arg!.hasPrefix("-") {
        print("Missing value for \(opt) option.", to: &errStream)
        exit(1)
    }
}

func quoteForShell(_ string: String) -> String { // single-quote string for use in shell
    return "'" + string.replacingOccurrences(of: "'", with: "'\\''") + "'"
}

func writeData(_ data: NSData, toURL: URL, overwriting: Bool) throws {
    // TO DO: writeToURL throws rotten error message if dir not found, e.g. "The folder “FinderGlue.swift” doesn’t exist." when the destination folder is missing
    do {
        try data.write(to: toURL as URL, options: (overwriting ? .atomic : .withoutOverwriting))
    } catch {
        throw AutomationError(code: error._code, message: "Can't write file: \(toURL.path). \(error)")
    }
}


// parsed options

var importFramework = true
var generateDocumentation = true
var applicationClassName: String?
var classNamePrefix: String?
var canOverwrite = false
var useSDEF = false
var applicationURLs: [URL?] = []
var outDir: URL?

var enumeratedTypeFormats: [String] = []
var recordStructFormats: [String] = []
var typeAliasFormats: [String] = []

var foundOpts = [String]() // used to create string representation of shell command that will appear in glue
var applicationPaths = [String]() // application name/path arguments


// parse ARGV

var optArgs = ProcessInfo.processInfo.arguments.reversed() as [String] // bug workaround: popping/inserting at start of Array[Slice] is buggy, so reverse it and work from end
optArgs.removeLast() // skip path to this executable
if optArgs.count == 0 {
    print(helpText, to: &errStream)
    exit(0)
}
while let opt = optArgs.popLast() {
    switch(opt) {
    case "-D":
        importFramework = false
        foundOpts.append(opt)
    case "-d":
        generateDocumentation = false
    case "-e":
        let enumeratedTypeFormat = optArgs.popLast()
        validateOption(opt: opt, arg: enumeratedTypeFormat)
        enumeratedTypeFormats.append(enumeratedTypeFormat!)
        foundOpts.append("\(opt) \(quoteForShell(enumeratedTypeFormat!))")
    case "-h":
        print(helpText, to: &errStream)
        exit(0)
    case "-n":
        applicationClassName = optArgs.popLast()
        validateOption(opt: opt, arg: applicationClassName)
        foundOpts.append("\(opt) \(applicationClassName!)")
    case "-o":
        let path = optArgs.popLast()
        validateOption(opt: opt, arg: path)
        outDir = URL(fileURLWithPath: path!).absoluteURL // TO DO: check path exists and is dir? // TO DO: Swift/Foundation is being janky and not always expanding to absolute path when given relative to CWD or ~; need to find canonical shell path expansion and use that
    case "-p":
        classNamePrefix = optArgs.popLast()
        validateOption(opt: opt, arg: classNamePrefix)
        foundOpts.append("\(opt) \(classNamePrefix!)")
    case "-r":
        canOverwrite = true
    case "-S":
        useSDEF = true
        foundOpts.append(opt)
    case "-s":
        let recordStructFormat = optArgs.popLast()
        validateOption(opt: opt, arg: recordStructFormat)
        recordStructFormats.append(recordStructFormat!)
        foundOpts.append("\(opt) \(quoteForShell(recordStructFormat!))")
    case "-t":
        let typeAliasFormat = optArgs.popLast()
        validateOption(opt: opt, arg: typeAliasFormat)
        typeAliasFormats.append(typeAliasFormat!)
        foundOpts.append("\(opt) \(quoteForShell(typeAliasFormat!))")
    case "-v":
        print("0.0.0") // TO DO: print SwiftAutomation.framework bundle version
        exit(0)
    case "--": // explicit options/arguments separator, so treat remaining items as arguments
        applicationPaths = optArgs
        optArgs = []
        foundOpts.append(opt)
    default: // emulate [hopefully] standard getopt parsing behavior
        if opt.hasPrefix("-") { // if it's multiple short option flags, reinsert them as separate options
            var chars = opt
            if chars.count > 2 { // e.g. given "-rS", split into "-r" and "-S", and reinsert
                chars.removeFirst() // skip leading "-"
                var tmp: [String] = []
                while let c = chars.first {
                    chars.removeFirst()
                    tmp.append("-\(c)")
                    if optionsWithArguments.contains(c) && chars.count > 0 { // rejoin remaining chars and put back on optArgs as option's value
                        tmp.append(chars)
                        chars = ""
                    }
                }
                optArgs += tmp.reversed()
            } else { // it's an unrecognized option, so report error
                print("Unknown option: \(opt)", to: &errStream)
                exit(1)
            }
        } else { // it's not an option, so treat it and remaining items as arguments
            applicationPaths = optArgs+[opt]
            optArgs = []
        }
    }
}
if outDir == nil { // use current working directory by default
    outDir = URL(fileURLWithPath: "./").absoluteURL
}
while let arg = applicationPaths.popLast() { // get application name[s] (required unless -D option was used)
    guard let applicationURL = fileURLForLocalApplication(arg) else {
        print("Application not found: \(arg)", to: &errStream)
        exit(1)
    }
    applicationURLs.append(applicationURL)
}
if applicationURLs.count == 0 { // write default glue
    applicationURLs.append(nil)
} else if (classNamePrefix != nil || applicationClassName != nil) && applicationURLs.count > 1 {
    print("Only one application may be given when -n/-p options are used: \(applicationURLs)", to: &errStream)
    exit(1)
}

// render glue file and documentation for each app

for applicationURL in applicationURLs {
    let glueSpec = GlueSpec(applicationURL: applicationURL, classNamePrefix: classNamePrefix,
                            applicationClassName: applicationClassName, useSDEF: useSDEF)
    let typeSupportSpec = TypeSupportSpec(enumeratedTypeFormats: enumeratedTypeFormats,
                                          recordStructFormats: recordStructFormats, typeAliasFormats: typeAliasFormats)
    let glueFileName = "\(glueSpec.applicationClassName)Glue.swift"
    var shellCommand = ["aeglue"] + foundOpts
    if applicationURL != nil { shellCommand.append(quoteForShell(applicationURL!.lastPathComponent)) }
    let extraTags = ["GLUE_NAME": glueFileName, "AEGLUE_COMMAND": shellCommand.joined(separator: " ")]
    // generate SwiftAutomation glue file
    do {
        let code = try renderStaticGlueTemplate(glueSpec: glueSpec, typeSupportSpec: typeSupportSpec,
                                                importFramework: importFramework, extraTags: extraTags)
        guard let data = code.data(using: .utf8) else { throw TerminologyError("Invalid UTF8 data.") }
        let outGlueURL = outDir!.appendingPathComponent(glueFileName)
        try writeData(data as NSData, toURL: outGlueURL, overwriting: canOverwrite)
        print(outGlueURL.path)
    } catch {
        print("Error \(error._code): Couldn't generate glue for \(applicationURL?.path ?? "default terminology"): \(error)", to: &errStream)
    }
    // generate cheap-n-dirty user documentation
    if let appURL = applicationURL, generateDocumentation {
        do {
            let sdef = try translateScriptingDefinition(try GetScriptingDefinition(appURL), glueSpec: glueSpec)
            let outSDEFURL = outDir!.appendingPathComponent("\(glueFileName).sdef")
            try writeData(sdef as NSData, toURL: outSDEFURL, overwriting: canOverwrite)
            print(outSDEFURL.path)
        } catch {
            print("Error \(error._code): Couldn't write SDEF for \(applicationURL?.path ?? "default terminology"): \(error)", to: &errStream)
        }
    }
}

