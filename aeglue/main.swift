//
//  main.swift
//  aeglue
//
//  Generate application-specific glue files for SwiftAutomation.
//
//  Note: the undocumented `-D` option is used to [re]generate the SwiftAutomation framework's AEApplicationGlue.swift file.
//

//  TO DO: would it be simpler just to generate default glue if no apps specified? (if so, -e, -n, -p, etc options should be allowed, so users can create their own default glues which they can then hack on as they like, and undocumented -D option can be discarded)

// TO DO: add an -x option for excluding the `import SwiftAutomation` line from glue? (Currently, CLI apps have to bake everything directly into the executable as Swift can't yet import third-party frameworks outside of an .app bundle.)

// TO DO: what about adding an option for building glues as importable modules? (this can always be added later, once general packaging and distribution issues are all worked out)

// TO DO: change -S option to -A (i.e. use SDEF by default)? (Caution: while using SDEF by default would seem the obvious choice, it is actually less reliable since macOS's AETE-to-SDEF converter can introduce various subtle, hard-to-debug defects during the conversion process; whereas AETEs will always produce valid glues unless the app's 'ascr'/'gdte' handler fails, in which case the glue file will be mostly unusable and the need to switch to SDEF obvious to the user. [Of course, since these failures tend to occur in Carbon apps, there is no guarantee the SDEF-generated glue won't include some of the aforementioned subtle defects, but that's between the user, Apple, and the application vendor to sort out.])

// TO DO: add -t (-a?) option for typealiases, -s option for record structs


import Foundation
//import SwiftAutomation // TO DO: the `aeglue` target currently bakes everything into CLI executable; if/when Swift finally supports dynamic framework linking, use import instead



let optionsWithArguments = Set<Character>("npeo".characters) // this MUST contain all options that also require arguments (used to separate option key from value if not explicitly separated by whitespace, e.g. '-pABC' -> '-p ABC')


let helpText = [
    "Generate SwiftAutomation glue classes and SDEF documentation for",
    " controllingan \"AppleScriptable\" application from Swift.",
    "",
    "Usage:",
    "",
    "    aeglue [-n CLASSNAME] [-p PREFIX] [-rS]",
    "           [-est FORMAT ...] [-o OUTDIR] APPNAME ...",
    "    aeglue [-hv]",
    "",
    "APPNAME - Name or path to application. If -n and -p options are",
    "              omitted, multiple applications may be specified.",
    "",
    "On completion, the generated files' paths are written to STDOUT.",
    "",
    "Options:",
    "",
    "    -e FORMAT      An enumerated type definition; see Type Support.",
    "    -h             Show this help and exit.",
    "    -o OUTDIR      Path to directory in which the glue files will",
    "                       be created; if omitted, the current working",
    "                       directory is used.",
    "    -n CLASSNAME   C-style identifier to use as the Application",
    "                       class's name. Auto-generated if omitted.",
    "    -p PREFIX      Three-character prefix for glue's other classes.",
    "                       Auto-generated if omitted.",
    "    -r             Overwrite existing files.",
    "    -S             Use SDEF terminology instead of AETE, e.g. if",
    "                       application's ascr/gdte handler is broken.",
    "    -s FORMAT      A record struct definition; see Type Support.",
    "    -t FORMAT      A type alias definition; see Type Support.",
    "    -v             Output the SwiftAutomation framework's version",
    "                       and exit.",
    "",
    "Examples:",
    "",
    "    aeglue iTunes",
    "",
    "    aeglue -r -S Finder",
    "",
    "    aeglue -p TE TextEdit ~/Desktop",
    "",
    "Type Support:",
    "",
    "If an application command returns multiple types (for example,",
    "a Symbol OR an Int OR a String), the -e option can be used to",
    "add the corresponding enumerated type to the glue, providing",
    "a type-safe alternative to the Any return type.",
    "",
    "The -e option's argument must have the following format:",
    "",
    "    [TYPENAME=]TYPE1+TYPE2+...",
    "",
    "TYPENAME is the name to be given to the enumerated type, e.g.",
    "MyType. If omitted, a default name is automatically generated.",
    "",
    "TYPEn is the name of an existing Swift type, e.g. String or a",
    "standard SwiftAutomation type: Symbol, Object, Insertion, Item,",
    "or Items (the glue PREFIX will be added automatically).",
    "",
    "For example, to define an enum named MASymbolOrIntOrString", // TO DO: a real-world example would be better
    "which can represent a Symbol, Int, or String:",
    "",
    "    aeglue -e Symbol+Int+String -p MA 'My App'",
    // TO DO: document struct and typealias format strings too
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
        throw NSError(domain: NSCocoaErrorDomain, code: error._code,
                      userInfo: [NSLocalizedDescriptionKey: "Can't write file: \(toURL.path). \((error as NSError).localizedDescription)"])
    }
}

public struct StderrStream: TextOutputStream {
    public mutating func write(_ string: String) { fputs(string, stderr) }
}
public var errStream = StderrStream()


// parsed options

var frameworkImport = "import SwiftAutomation"
var applicationClassName: String?
var classNamePrefix: String?
var writeDefaultGlue = false
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
        writeDefaultGlue = true
        frameworkImport = ""
        foundOpts.append(opt)
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
            var chars = opt.characters
            if chars.count > 2 { // e.g. given "-rS", split into "-r" and "-S", and reinsert
                chars.removeFirst() // skip leading "-"
                var tmp: [String] = []
                while let c = chars.popFirst() {
                    tmp.append("-\(c)")
                    if optionsWithArguments.contains(c) && chars.count > 0 { // rejoin remaining chars and put back on optArgs as option's value
                        tmp.append(String(chars))
                        chars = "".characters
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
if writeDefaultGlue {
    applicationURLs.append(nil)
} else if applicationURLs.count == 0 {
        print("No application specified.", to: &errStream)
        exit(1)
}

// render glue file and documentation for each app

for applicationURL in applicationURLs {
    let glueSpec = GlueSpec(applicationURL: applicationURL, classNamePrefix: classNamePrefix,
                            applicationClassName: applicationClassName, useSDEF: useSDEF)
    let typeSupportSpec = TypeSupportSpec(enumeratedTypeFormats: enumeratedTypeFormats,
                                          recordStructFormats: recordStructFormats, typeAliasFormats: typeAliasFormats)
    let shellCommand = "aeglue " + (foundOpts +
            (applicationURL == nil ? [] : [quoteForShell(applicationURL!.lastPathComponent)])).joined(separator: " ")
    let glueFileName = "\(glueSpec.applicationClassName)Glue.swift"
    // generate SwiftAutomation glue file
    do {
        let extraTags = ["AEGLUE_COMMAND": shellCommand, "GLUE_NAME": glueFileName, "IMPORT_SWIFTAE": frameworkImport]
        let code = try renderStaticGlueTemplate(glueSpec: glueSpec, typeSupportSpec: typeSupportSpec, extraTags: extraTags)
        guard let data = code.data(using: String.Encoding.utf8) else { throw TerminologyError("Invalid UTF8 data.") }
        let outGlueURL = outDir!.appendingPathComponent(glueFileName)
        try writeData(data as NSData, toURL: outGlueURL, overwriting: canOverwrite)
        print(outGlueURL.path)
    } catch {
        print("Couldn't generate glue: \(error.localizedDescription)", to: &errStream) // TO DO: check this works with non-NSErrors too
        exit(Int32(error._code))
    }
    // generate cheap-n-dirty user documentation
    if let appURL = applicationURL {
        do {
            let sdef = try translateScriptingDefinition(try GetScriptingDefinition(appURL), glueSpec: glueSpec)
            let outSDEFURL = outDir!.appendingPathComponent("\(glueFileName).sdef")
            try writeData(sdef as NSData, toURL: outSDEFURL, overwriting: canOverwrite)
            print(outSDEFURL.path)
        } catch {
            print("Couldn't write SDEF: \(error.localizedDescription)", to: &errStream)
            exit(Int32(error._code))
        }
    }
}

