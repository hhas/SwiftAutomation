//
//  main.swift
//  aeglue
//
//  Generate application-specific glue files for SwiftAE
//


import Foundation
import SwiftAE

let gHelp = [
    "Generate SwiftAE glue classes and SDEF documentation for controlling",
    "an \"AppleScriptable\" application from Swift.",
    "",
    "Usage:",
    "",
    "    aeglue [-n CLASSNAME] [-p PREFIX] [-r] [-s] [--] APPNAME [OUTDIR]",
    "    aeglue -d [-r] [OUTDIR]",
    "    aeglue [-h] [-v]",
    "",
    "APPNAME - Name or path to application.",
    "",
    "OUTDIR - Path to directory in which the glue files will be created;",
    "             if omitted, the current working directory is used.",
    "",
    "On completion, the generated files' paths are written to STDOUT.",
    "",
    "Options:",
    "",
    "    -d             Generate glue using default terminology only.",
    "    -h             Show this help and exit.",
    "    -n CLASSNAME   C-style identifier to use as the Application",
    "                       class's name. Auto-generated if omitted.",
    "    -p PREFIX      Three-character prefix for glue's other classes.",
    "                       Auto-generated if omitted.",
    "    -r             Overwrite existing files.",
    "    -s             Use SDEF terminology instead of AETE, e.g. if",
    "                       application's ascr/gdte handler is broken.",
    "    -v             Output the SwiftAE framework's version and exit.",
    "",
    "Examples:",
    "",
    "    aeglue iTunes",
    "",
    "    aeglue -r -s Finder",
    "",
    "    aeglue -p TE TextEdit ~/Desktop",
    ""].joinWithSeparator("\n")


func writeData(data: NSData, toURL: NSURL, overwriting: Bool) throws {
    // TO DO: writeToURL throws rotten error message if dir not found, e.g. "The folder “FinderGlue.swift” doesn’t exist."
    try data.writeToURL(toURL, options: (overwriting ? .DataWritingAtomic : .DataWritingWithoutOverwriting))
}

// parse ARGV

var applicationClassName: String?
var classNamePrefix: String?
var defaultTermsOnly = false
var canOverwrite = false
var useSDEF = false
var applicationURL: NSURL?
var outDir: NSURL?

// TO DO: would wrapping C getopts() be simpler?
var optArgs = Array(Process.arguments.reverse()) // bug workaround: popping/inserting at start of Array[Slice] is buggy, so reverse it and work from end
let _ = optArgs.popLast() // skip path to this executable

if optArgs.count == 0 {
    print(gHelp) // TO DO: all error messages should be written to STDERR
    exit(0)
}

let shellCommand = "aeglue " + optArgs.reverse().joinWithSeparator(" ")

var arguments = [String]()

// parse options
let gValueOptions = "np".characters // must contain all options that have values
while let opt = optArgs.popLast() {
    switch(opt) {
    case "-d":
        defaultTermsOnly = true
    case "-h":
        print(gHelp) // TO DO: STDERR
        exit(0)
    case "-n":
        applicationClassName = optArgs.popLast()
        if applicationClassName == nil || applicationClassName!.hasPrefix("-") {
            print("Missing value for -n option.")
            exit(1)
        }
    case "-p":
        classNamePrefix = optArgs.popLast()
        if classNamePrefix == nil || classNamePrefix!.hasPrefix("-") {
            print("Missing value for -p option.")
            exit(1)
        }
    case "-r":
        canOverwrite = true
    case "-s":
        useSDEF = true
    case "-v":
        print("0.0.0") // TO DO: print SwiftAE.framework bundle version
        exit(0)
    default: // emulate [hopefully] standard getopt parsing behavior
        if opt == "--" { // explicit options/arguments separator, so treat remaining items as arguments
            arguments = optArgs
            optArgs = []
        } else if opt.hasPrefix("-") { // if it's multiple short option flags, reinsert them as separate options
            var chars = opt.characters
            if chars.count > 2 { // e.g. given "-rs", split into "-r" and "-s", and reinsert
                let _ = chars.popFirst() // skip leading "-"
                while let c = chars.popFirst() {
                    if gValueOptions.contains(c) { // rejoin remaining chars and put back on optArgs as option's value
                        optArgs.append(String(chars))
                        chars = "".characters
                    }
                    optArgs.append("-\(c)")
                }
            } else { // it's an unrecognized option, so report error
                print("Unknown option: \(opt)")
                exit(1)
            }
        } else { // it's not an option, so treat it and remaining items as arguments
            arguments = optArgs+[opt]
            optArgs = []
        }
    }
}

if !defaultTermsOnly { // get application name (required unless -d option was used)
    guard let arg = arguments.popLast() else {
        print("No application specified.")
        exit(1)
    }
    applicationURL = URLForLocalApplication(arg)
    if applicationURL == nil {
        print("Application not found: \(arg)")
        exit(1)
    }
}
if let arg = arguments.popLast() { // get output directory (optional)
    outDir = NSURL(fileURLWithPath: arg)
} else { // use current working directory
    outDir = NSURL(fileURLWithPath: "./").absoluteURL
}
if outDir == nil {
    print("Invalid output directory.")
    exit(1)
}
if arguments.count > 0 {
    print("Too many arguments.")
    exit(1)
}



// create glue spec

let glueSpec = GlueSpec(applicationURL: applicationURL, classNamePrefix: classNamePrefix,
                              applicationClassName: applicationClassName, useSDEF: useSDEF)

let glueFileName = "\(glueSpec.applicationClassName)Glue.swift"

// generate SwiftAE glue file
do {
    let code = try renderStaticGlueTemplate(glueSpec, extraTags: ["AEGLUE_COMMAND": shellCommand,
                                                                  "GLUE_NAME":      glueFileName])
    guard let data = code.dataUsingEncoding(NSUTF8StringEncoding) else {
        throw TerminologyError("Invalid UTF8 data.")
    }
    let outGlueURL = outDir!.URLByAppendingPathComponent(glueFileName)
    try writeData(data, toURL: outGlueURL, overwriting: canOverwrite)
    print(outGlueURL.path!)
} catch {
    print("Couldn't generate glue: \((error as NSError).localizedDescription)") // TO DO: check this works with non-NSErrors too
    exit(Int32(error._code))
}

// generate cheap-n-dirty user documentation
if let appURL = applicationURL {
    do {
        let sdef = try translateScriptingDefinition(try GetScriptingDefinition(appURL), glueSpec: glueSpec)
        let outSDEFURL = outDir!.URLByAppendingPathComponent("\(glueFileName).sdef")
        try writeData(sdef, toURL: outSDEFURL, overwriting: canOverwrite)
        print(outSDEFURL.path!)
    } catch {
        print("Couldn't write SDEF: \((error as NSError).localizedDescription)")
        exit(Int32(error._code))
    }
}


