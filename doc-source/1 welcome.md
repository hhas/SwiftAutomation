# Welcome

## What is SwiftAutomation?

SwiftAutomation allows you to control "AppleScriptable" macOS applications using Apple's [Swift](https://swift.org/) language. SwiftAutomation makes Swift a true alternative to AppleScript for automating your Mac.

For example, to get the value of the first paragraph of the topmost document in TextEdit:

  let result = try TextEdit().documents[1].paragraphs[1].get() as String

This is equivalent to the AppleScript statement:

  tell application id "com.apple.TextEdit" to get paragraph 1 of document 1


Or to create a new "Hello World!" document in TextEdit:

  // tell application id "com.apple.TextEdit"
  //   make new document with properties {text:"Hello World!"}
  // end tell

  let textedit = TextEdit()
  try textedit.make(new: TED.document, withProperties: [TED.text: "Hello World!"])


## Before you start...

In order to use SwiftAutomation effectively, you will need to understand the differences between the Apple event and Swift/Cocoa object systems.

In contrast to the familiar object-oriented approach of other inter-process communication systems such as COM and Distributed Objects, Apple event IPC is based on a combination of remote procedure calls and first-class queries - somewhat analogous to using XPath over XML-RPC.

While SwiftAutomation uses an object-oriented-like syntax for conciseness and readability, like AppleScript, it behaves according to Apple event rules. As a result, Swift users will discover that some things work differently in SwiftAutomation from what they're used to. For example:

* Object elements are one-indexed, not zero-indexed like Swift Arrays.

* Referencing a property of an application object does not automatically return the property's value (you need a get command for that).

* Many applications allow a single command to operate on multiple objects at the same time, providing significant performance benefits when manipulating large numbers of application objects. (Conversely, sending lots of commands to manipulate single objects one at a time can severely degrade performance.)

Chapters 2 and 3 of this manual provide further information on how Apple event IPC works and a tutorial-based introduction to the SwiftAutomation bridge. Chapter 4 explains how to generate glue files for controlling specific appications. Chapters 5 through 9 cover the SwiftAutomation API, and chapter 10 discusses techniques for optimising performance.

