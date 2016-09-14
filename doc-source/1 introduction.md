# Introduction

## What is SwiftAE?

SwiftAE allows you to control Apple event-aware ("AppleScriptable") macOS applications from Swift programs.

For example, to get the value of the first paragraph of the topmost document in TextEdit:

    let result = try TextEdit().documents[1].paragraphs[1].get() as! String

This is equivalent to the AppleScript statement:

    tell application id "com.apple.TextEdit" to get paragraph 1 of document 1


## "Hello World!" example

The following example uses SwiftAE to create a new "Hello World!" document in TextEdit:

    let textedit = TextEdit()

    try textedit.make(new: TED.document, withProperties: [TED.text: "Hello World!"])

