//
//  main.swift
//  aeglue
//
//  Generate application-specific glue files for SwiftAutomation.
//
//  Note: the undocumented -d option is used to [re]generate the SwiftAutomation framework's AEApplicationGlue.swift file.
//  TO DO: would it be simpler just to generate default glue if no apps specified? (if so, -np options should be allowed, so users can create their own default glues)
//


import Foundation
//import SwiftAutomation // note: the `aeglue` target currently bakes everything into CLI executable


// TO DO: need option for excluding `import SwiftAutomation` from glue?

// TO DO: what about adding an option for building glues as importable modules?


let gHelp = [
    "Generate SwiftAutomation glue classes and SDEF documentation for",
    " controllingan \"AppleScriptable\" application from Swift.",
    "",
    "Usage:",
    "",
    "    aeglue [-n CLASSNAME] [-p PREFIX] [-rs] [-o OUTDIR] APPNAME ...",
    "    aeglue [-hv]",
    "",
    "APPNAME - Name or path to application. If -n and -p options are",
    "              omitted, multiple applications may be specified.",
    "",
    "On completion, the generated files' paths are written to STDOUT.",
    "",
    "Options:",
    "",
    "    -h             Show this help and exit.",
    "    -o OUTDIR      Path to directory in which the glue files will",
    "                       be created; if omitted, the current working ",
    "                       directory is used.",
    "    -n CLASSNAME   C-style identifier to use as the Application",
    "                       class's name. Auto-generated if omitted.",
    "    -p PREFIX      Three-character prefix for glue's other classes.",
    "                       Auto-generated if omitted.",
    "    -r             Overwrite existing files.",
    "    -s             Use SDEF terminology instead of AETE, e.g. if",
    "                       application's ascr/gdte handler is broken.",
    "    -v             Output the SwiftAutomation framework's version",
    "                       and exit.",
    "",
    "Examples:",
    "",
    "    aeglue iTunes",
    "",
    "    aeglue -r -s Finder",
    "",
    "    aeglue -p TE TextEdit ~/Desktop",
    ""].joined(separator: "\n")


func writeData(_ data: NSData, toURL: URL, overwriting: Bool) throws {
    // TO DO: writeToURL throws rotten error message if dir not found, e.g. "The folder “FinderGlue.swift” doesn’t exist."
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


// parse ARGV

var frameworkImport = "import SwiftAutomation"
var applicationClassName: String?
var classNamePrefix: String?
var writeDefaultGlue = false
var canOverwrite = false
var useSDEF = false
var applicationURLs: [URL?] = []
var outDir: URL?

var optArgs = ProcessInfo.processInfo.arguments.reversed() as [String] // bug workaround: popping/inserting at start of Array[Slice] is buggy, so reverse it and work from end

let _ = optArgs.popLast() // skip path to this executable

if optArgs.count == 0 {
    print(gHelp, to: &errStream)
    exit(0)
}

var foundOpts = Array(optArgs.reversed()) // used to create string representation of shell command that will appear in glue
var applicationPaths = [String]() // application name/path arguments

// parse options
let gValueOptions = "onp".characters // must contain all options that have values; used to separate option key from value if not explicitly separated by whitespace
while let opt = optArgs.popLast() {
    switch(opt) {
    case "-d":
        writeDefaultGlue = true
        frameworkImport = ""
    case "-h":
        print(gHelp, to: &errStream)
        exit(0)
    case "-n":
        applicationClassName = optArgs.popLast()
        if applicationClassName == nil || applicationClassName!.hasPrefix("-") {
            print("Missing value for -n option.", to: &errStream)
            exit(1)
        }
    case "-o":
        let path = optArgs.popLast()
        if path == nil || path!.hasPrefix("-") {
            print("Missing value for -o option.", to: &errStream)
            exit(1)
        }
        outDir = URL(fileURLWithPath: path!)
        if outDir == nil { // TO DO: also check is dir?
            print("Invalid output directory path: \(path!)", to: &errStream)
            exit(1)
        }
    case "-p":
        classNamePrefix = optArgs.popLast()
        if classNamePrefix == nil || classNamePrefix!.hasPrefix("-") {
            print("Missing value for -p option.", to: &errStream)
            exit(1)
        }
    case "-r":
        canOverwrite = true
    case "-s":
        useSDEF = true
    case "-v":
        print("0.0.0") // TO DO: print SwiftAutomation.framework bundle version
        exit(0)
    case "--": // explicit options/arguments separator, so treat remaining items as arguments
        applicationPaths = optArgs
        optArgs = []
    default: // emulate [hopefully] standard getopt parsing behavior
        if opt.hasPrefix("-") { // if it's multiple short option flags, reinsert them as separate options
            var chars = opt.characters
            if chars.count > 2 { // e.g. given "-rs", split into "-r" and "-s", and reinsert
                let _ = chars.popFirst() // skip leading "-"
                var tmp: [String] = []
                while let c = chars.popFirst() {
                    tmp.append("-\(c)")
                    if gValueOptions.contains(c) && chars.count > 0 { // rejoin remaining chars and put back on optArgs as option's value
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
while let arg = applicationPaths.popLast() { // get application name[s] (required unless -d option was used)
    guard let applicationURL = URLForLocalApplication(arg) else {
        print("Application not found: \(arg)", to: &errStream)
        exit(1)
    }
    applicationURLs.append(applicationURL)
    foundOpts.removeLast()
}
if writeDefaultGlue {
    applicationURLs.append(nil)
} else if applicationURLs.count == 0 {
        print("No application specified.", to: &errStream)
        exit(1)
}

// create glue spec

    
for applicationURL in applicationURLs {
    let glueSpec = GlueSpec(applicationURL: applicationURL, classNamePrefix: classNamePrefix,
                            applicationClassName: applicationClassName, useSDEF: useSDEF)
    let shellCommand = "aeglue " + (foundOpts + (applicationURL == nil ? [] : [applicationURL!.lastPathComponent])).joined(separator: " ")
    let glueFileName = "\(glueSpec.applicationClassName)Glue.swift"
    // generate SwiftAutomation glue file
    do {
        let code = try renderStaticGlueTemplate(glueSpec, extraTags: ["AEGLUE_COMMAND": shellCommand,
                                                                      "GLUE_NAME":      glueFileName,
                                                                      "IMPORT_SWIFTAE": frameworkImport])
        guard let data = code.data(using: String.Encoding.utf8) else {
            throw TerminologyError("Invalid UTF8 data.")
        }
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

