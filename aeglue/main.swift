//
//  main.swift
//  aeglue
//
//  Generate application-specific glue files for SwiftAE
//

// TO DO: options parsing currently doesn't handle common shell shorthand (e.g. using `-rs` instead of `-r -s` currently fails)

import Foundation
import SwiftAE

let gHelp = [
    "Generate SwiftAE glue classes and SDEF documentation for controlling",
    "an \"AppleScriptable\" application from Swift.",
    "",
    "Usage:",
    "",
    "    aeglue [-n CLASSNAME] [-p PREFIX] [-r] [-s] APPNAME [OUTDIR]",
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
    "    -n CLASSNAME   Application class name as a C-style identifier;",
    "                       if omitted, a default name is auto-generated.",
    "    -p PREFIX      Class names prefix; if omitted, a 3-character",
    "                       prefix is auto-generated.",
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


var applicationURL: NSURL?
var outDir: NSURL?

var applicationClassName: String?
var classNamesPrefix: String?
var defaultTermsOnly = false
var canOverwrite = false
var useSDEF = false

// parse ARGV

var args: ArraySlice<String> = ArraySlice(Process.arguments)
let _ = args.popFirst()
let shellCommand = "aeglue "+args.joinWithSeparator(" ")
if args.count == 0 {
    print(gHelp) // TO DO: STDERR
    exit(0)
}
while let opt = args.popFirst() {
    switch(opt) {
    case "-d":
        defaultTermsOnly = true
    case "-h":
        print(gHelp) // TO DO: STDERR
        exit(0)
    case "-n":
        applicationClassName = args.popFirst()
        if applicationClassName == nil || applicationClassName!.hasPrefix("-") {
            print("Missing value for -n option.")
            exit(1)
        }
    case "-p":
        classNamesPrefix = args.popFirst()
        if classNamesPrefix == nil || classNamesPrefix!.hasPrefix("-") {
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
    default:
        if !defaultTermsOnly {
            guard let url = URLForLocalApplication(opt) else {
                print("Application not found: \(opt)")
                exit(1)
            }
            applicationURL = url
        }
        if let tmp = args.popFirst() {
            outDir = NSURL(fileURLWithPath: tmp)
        } else {
            outDir = NSURL(fileURLWithPath: "./").absoluteURL // check this gives cwd
        }
        if args.count > 0 {
            print("Too many arguments.")
            exit(1)
        }
    }
}


func writeData(data: NSData, toURL: NSURL, overwriting: Bool) throws {
    try data.writeToURL(toURL, options: (overwriting ? .DataWritingAtomic : .DataWritingWithoutOverwriting))
}

let glueSpec = StaticGlueSpec(applicationURL: applicationURL, classNamesPrefix: classNamesPrefix,
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


