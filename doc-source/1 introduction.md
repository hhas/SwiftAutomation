# Introduction

## What is SwiftAutomation?

SwiftAutomation allows you to control "AppleScriptable" macOS applications using Apple's [Swift](https://swift.org/) language. SwiftAutomation makes Swift a true alternative to AppleScript for automating your Mac.

For example, to get the value of the first paragraph of the topmost document in TextEdit:

    let result = try TextEdit().documents[1].paragraphs[1].get() as String

This is equivalent to the AppleScript statement:

    tell application id "com.apple.TextEdit" to get paragraph 1 of document 1


Or to create a new "Hello World!" document in TextEdit:

    // tell application id "com.apple.TextEdit"
    //    make new document with properties {text:"Hello World!"}
    // end tell

    let textedit = TextEdit()
    try textedit.make(new: TED.document, withProperties: [TED.text: "Hello World!"])


[[TO DO: precis of Apple events' novel RPC+Query interaction model vs Swift/Cocoa's traditional OOP model]]
