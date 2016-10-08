# A tutorial introduction

[CAUTION: This tutorial is incomplete and unfinished, and while it can be read it can't be performed until/unless SwiftAutomation.framework and TextEditGlue.swift can be imported into `/usr/bin/swift`. While the Xcode project does include a playground, this is unsuitable as, unlike the `swift` REPL, it re-evaluates ALL lines of code each time a new line is entered; thus, for example, a `make` command will create multiple new objects while the user is working, while repeated `delete` commands could unintentionally destroy user data.]

[[TO DO: need to figure out how to import SwiftAutomation.framework and TextEditGlue.swift into `/usr/bin/swift` session, and package this into a simple shell script that configures and launches a tutorial session automatically (for bonus points, the script should also take an optional list of app names and generate and import glues for those too).]

[TO DO: TextEdit now returns by-name document specifiers; update code examples accordingly]

[TO DO: could probably do with getting user to open sdef in Script Editor for an overview of how API docs are structured]

This chapter provides a practical taste of application scripting with Swift and SwiftAutomation. Later chapters cover the technical details of SwiftAutomation usage that are mostly skimmed over here.

The following tutorial uses SwiftAutomation, TextEdit and the interactive command line `swift` interpreter to perform a simple 'Hello World' exercise. 

<p class="hilitebox">Caution: It is recommended that you do not have any other documents open in TextEdit during this tutorial, as accidental alterations to existing documents are easy to make and may not be undoable.</p>

To begin, build the SwiftAE project's MacOSGlues target then launch the `swift` interpreter in Terminal, replacing <code><var>/path/to/products</var></code> with the path to the directory containing the newly built `SwiftAutomation.framework` and `MacOSGlues.framework` bundles:

<pre><code><strong>jsmith$ swift -F <var>/path/to/products</var></strong>
<span style="color:gray;">Welcome to Apple Swift version 2.0 (700.0.38.1 700.0.53). Type :help for assistance.
  1&gt;</span></code></pre>



## Target TextEdit

The first step is to import the Swift glue file for TextEdit:

  import SwiftAutomation; import MacOSGlues

The `MacOSGlues.framework` contains ready-to-use glues for many of the "AppleScriptable" applications found in macOS, including Finder, iTunes, and TextEdit. Each glue file defines the Swift classes needed to control one particular application – in this case TextEdit – using human-readable code.

(Glues for other applications can be created using SwiftAutomation's `aeglue` tool; see chapter 4 for details.) 

Next, create a new `Application` object for controlling TextEdit:

  let textedit = TextEdit()

By default, the new `Application` object will use the bundle identifier of the application from which the glue was created; in this case `"com.apple.TextEdit"`. Other ways in which applications can be identified include by name (e.g. `"TextEdit"`), full path (`"/Applications/TextEdit.app"`), and even remote URL (`eppc://my-other-mac.local/TextEdit`), but for most tasks the default behavior is sufficient.

To test, send TextEdit a standard `activate` command:

  try textedit.activate()

This should make TextEdit the currently active (frontmost) application, automatically launching it if it isn't already running. All application commands throw on failure, so don't forget to type Swift's `try` keyword before the command or `swift` will refuse to compile it.

[TO DO: open TextEdit's SDEF documentation in Script Editor and summarize its contents and organization]

[TO DO: note that get/set aren't usually documented]

## Create a new document

First, create a new TextEdit document by making a new `document` object. This is done using the `make` command, passing it a single named parameter, `new:`, indicating the type of object to create; in this case `TED.document`:

  try textedit.make(new: TED.document)

If the application is not already running, it will be launched automatically the first time you send it a command.

On success, TextEdit's `make` command returns an _object specifier_ that identifies the newly created object, for example:

  TextEdit().documents["Untitled"]

This particular object specifier represents one-to-one relationship between TextEdit's main application object and a document object named "Untitled.txt". (In AppleScript jargon, the document object named "Untitled.txt" is an _element_ of the application object named "TextEdit".)

[TO DO: how best to show an example of a one-to-many relationship? Having the user write `TextEdit().documents.paragraphs` might be a good choice as it emphasizes how queries describe abstract relationships rather than literal containment.]


This specifier can be assigned to a constant or variable for easy reuse. Use the `make` command to create another document, this time assigning its result to a variable named `doc` as shown:

  let doc = try textedit.make(new: TED.document) as TEDItem

Declaring the command's return type (`TEDItem`) is not essential, but greatly improves both usability and reliability. Without it, the Swift compiler will infer the `doc` variable's type to be `Any`, allowing it to hold any value that the application might return. However, you won't be able to use the returned value's properties and methods until you cast that variable to a more specific type. Applying the cast directly to the command's result not only allows the Swift compiler to infer the `doc` variable's exact type, it also instructs SwiftAutomation to convert whatever result the application returns to that exact type or else throw an error if that conversion isn't supported. This provides robust yet flexible type-safe bridging between Apple event's weak, dynamic type system and Swift's strong, static one.

[TO DO: don't say what TEDItem actually means...when should that be clarified?]

The above `make` command simply creates a new, blank document in TextEdit and returns a reference to it (`TextEdit().documents["Untitled"]`). To create a new document with custom content, use the `make` command's optional `withProperties:` parameter to specify the initial values for one or more of the document object's properties:

  let doc = try textedit.make(new: TED.document, withProperties: [TED.text:"Hello World!"]) as TEDItem

Here we tell TextEdit to create a new document object containing the text "Hello World!". [TO DO: SDEF would help here]


[TO DO: this will work better if the above `make` command is expanded to include `withProperties: [TED.text:"Hello World!"]`]. The next task will be to `get()` that document's text, which makes the point that object specifiers are only used to construct _queries_; to actually get a value from the application you _have_ to use a command, e.g. `get()`. (Kinda like the difference between putting together a file path, e.g. "/Users/jsmith/" + "TODO.txt", that describes the location of some data, and passing that path to a `read()` command to actually obtain the data from that location.) Once getting is covered, the `set()` example can show how to change that content to something else. In addition, the `get()` example can explain the shorthand form that allows the command's direct parameter to be used as its subject for conciseness, i.e. `textedit.get(doc.text)` -> `doc.text.get()]



## Get the document's content

Retrieving the document's text is done using the `get()` command:

  try doc.text.get()
  // "Hello World"

[TO DO: rephrase/replace] This may seem counter-intuitive, where evaluating a literal reference returns the _value_ identified by that reference. However, SwiftAutomation only uses object-oriented references to construct object specifiers, not to resolve them. Always remember that an object specifier is really a first-class query object, so while the syntax may look similar to that of an object-oriented reference, its behavior is very different. For example, when evaluating the literal reference:

  textedit.documents[1].text

the result is an object specifier, `TextEdit().documents[1].text`, not the value being specified (`"Hello World"`). To get the value being specified, you have to pass the object specifier as the direct argument to TextEdit's `get()` command:

  try textedit.get(doc.text)
  // "Hello World!"

As before, SwiftAutomation provides alternative convenience forms that allow the above command to be written more neatly as this:

  doc.text.get()




## Set the document's content

The next step is to set the document's content to the string `"Hello World"`. Every TextEdit document has a property, `text`, that represents the entire text of the document. This property is both readable and writeable, allowing you to retrieve and/or modify the document's textual content as unstyled text.

Setting a property's value is done using the application's '`set()` command, which is represented as an instance method on the `TextEditGlue.swift` file's `TextEdit` class. The `set()` command takes two parameters: a direct (unnamed) parameter, and a named parameter, `to:`. The direct parameter must be an object specifier (represented by the TextEdit glue's `TEDItem` and `TEDItems` classes) that identifies the property or properties to be modified, while the `to:` parameter supplies the new value to assign to that property – in this case a `String`.

As we've already stored an object specifier for our target document in the `doc` variable, we'll use that to contruct a new object specifier that identifies that document's `text` property: `doc.text`. Evaluating this expression is evaluated, the result will 



In this case, the direct parameter is an object specifier identifying the new document's `text` property, `doc.text`, and the `to:` parameter is the string `"Hello World"`:

  try textedit.set(doc.text, to: "Hello World")

The front TextEdit document should now contain the text "Hello World".

Because the above expression is a bit unwieldy to write, SwiftAutomation allows it to be written in a more elegant OO-like format as a special case, where the `set()` command is called upon the document's object specifier:

  try doc.text.set(to: "Hello World")

SwiftAutomation converts this second form to the first form internally, so the end result is exactly the same. SwiftAutomation supports several such special cases, and these are described in the chapter on Application Commands. Using these special cases produces more elegant, readable source code, and is recommended.



## More on using commands type-safely 

Depending on what sort of attribute(s) the object specifier identifies, `get()` may return a primitive value (number, string, list, dict, etc.), or it may return another object specifier, or list of object specifiers, e.g.:

  try doc.text.get()
  // "Hello World!"
  
  try textedit.documents[1].get()
  // TextEdit().documents["Untitled"]
  
  try textedit.documents.get()
  // [TextEdit().documents["Untitled"], 
      TextEdit().documents["Untitled 2"]]
      
  try textedit.documents.text.get()
  // ["Hello World", ""]


## More on `make()`

The above exercise uses two commands to create a new TextEdit document containing the text "Hello World". It is also possible to perform both operations using the `make()` command alone by passing the value for the new document's `text` property via the `make()` command's optional `withProperties:` parameter: 

[TO DO: Rephrase and insert in this section: "because `document` objects are elements of the root `application` class, applications such as TextEdit can usually infer the location at which the new `document` object should appear. At other times, you need to supply an `at` parameter that indicates the desired location."]


  try textedit.make(new: TED.document, withProperties=[TED.text: "Hello World"])
  // TextEdit().documents[1]

[TO DO: TextEdit now returns by-name document specifiers; update this paragraph accordingly] Incidentally, you might note that every time the `make()` command is used, it returns an object specifier to document _1_. TextEdit identifies `document` objects according to the stacking order of their windows, with document 1 being frontmost. When the window stacking order changes, whether as a result of a script command or GUI-based interaction, so does the order of their corresponding `document` objects. This means that a previously created object specifier such as `TextEdit().documents[1]` may now identify a different `document` object to before! Some applications prefer to return object specifiers that identify objects by name or unique ID rather than index to reduce or eliminate the potential for confusion, but it's an issue you should be aware of, particularly with long-running scripts where there is greater opportunity for unexpected third-party interactions to throw a spanner in the works.


## More on manipulating `text`

In addition to getting and setting a document's entire text by applying `get()` and `set()` commands to `text` property, it's also possible to manipulate selected sections of a document's text directly. TextEdit's `text` property contains a `text` object, which in turn has `character`, `word` and `paragraph` elements, all of which can be manipulated using a variety of commands - `get()`, `set()`, `make()`, `move`, `delete`, etc. For example, to set the size of the first character of every paragraph of the front document to 24pt:

  try textedit.documents[1].text.paragraphs.size.set(to: 24)

Or to insert a new paragraph at the end of the document:

  try textedit.make(new: TED.paragraph,
                     at: TEDApp.documents[1].text.paragraphs.end,
               withData: "Hello Again, World\n")

[TO DO: add note that unlike AS, Swift is sensitive to parameter order, so named params must appear in same order as in glue]

