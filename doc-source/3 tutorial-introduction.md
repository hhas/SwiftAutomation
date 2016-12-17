# A tutorial introduction

This chapter provides a practical taste of application scripting with Swift and SwiftAutomation. Later chapters cover the technical details of SwiftAutomation usage that are mostly skimmed over here.

The following tutorial uses SwiftAutomation and SwiftAutoEdit.app to perform a simple 'Hello World' exercise in TextEdit.

[Note: SwiftAutoEdit is a work in progress; a ready-built .app will be provided once it is more complete. Until then, the Xcode project can be obtained from https://bitbucket.org/hhas/swiftautoedit; see its README file for instructions on how to build and install it.]

[[ TO DO: include screenshots? ]]


<p class="hilitebox">Caution: It is recommended that you do not have any other documents open in TextEdit during this tutorial, as accidental alterations to existing documents are easy to make and may not be undoable.</p>

## Create a new Swift "script"

Create a new Swift document in SwiftAutoEdit (File ➝ New ➝ Script) and save it as `tutorial.swift`.

The first step is to import the SwiftAutomation framework along with the glue classes that we'll use to control TextEdit:

  import SwiftAutomation
  import MacOSGlues

The MacOSGlues framework contains ready-to-use glues for many of the "AppleScriptable" applications provided by macOS, including Finder, iTunes, and TextEdit. Each glue file defines all the Swift classes you need to control an application using human-readable property and method names.

Next, create a new `Application` object for controlling TextEdit:

  let textedit = TextEdit()

By default, the new `Application` object will use the bundle identifier of the application from which the glue was created, in this case `"com.apple.TextEdit"`. Applications may also be targeted by name (e.g. "TextEdit"), full path ("/Applications/TextEdit.app"), process ID, and even remote URL ("eppc://my-other-mac.local/TextEdit"), but for most tasks the default behavior is sufficient.

Now type the following line, then save and run the script (Script ➝ Run, or Command-Return):

  try textedit.make(new: TED.document)

This will launch TextEdit (if it isn't already running) and create a new "Untitled" document within it. (Note that TextEdit may automatically create a new, empty document when launched, in which case this script will create a second empty document named "Untitled 2".) 

<p class="hilitebox">All application commands throw errors upon failure, so don't forget to insert a <code>try</code> keyword before an application command or Swift will refuse to compile it.</p>


## Get TextEdit's documents

Mac applications normally present "scriptable" state as a tree-like data structure called the _Apple Event Object Model_, or "AEOM".

[ TO DO: next para is too long and detailed; it belongs in next chapter. Need one sentence to say it's query-driven, not OO, and move onto the examples which make that point. - could say AEOM is unusual in that its interaction model comes from relational database world rather than traditional OO of DOM, etc (a View-Controller layer that describes a relational graph of real and/or abstract 'objects' presenting a user-friendly view onto data in app's Model layer) ]

Unlike traditional object-oriented models (e.g. web browser's DOM) which are thin abstractions over the corresponding object in the application's Model layer', AEOM is a much thicker abstraction that presents the application's state as a queryable relational graph. Depending on how a scriptable application is internally implemented, each node, or "object", within that graph may represent a corresponding implementation object or may be a further abstraction over more complex or dynamically calculated application state. For example, TextEdit's `document` and `window` objects map directly to the underlying `NSDocument` and `NSWindow` instances, whereas `characters`, `words`, and `paragraphs` all provide different views onto the same character data within an `NSTextStorage` buffer that make it easy for the user to query and manipulate that text data in a range of useful ways. Chapter 4 provides a detailed discussion of how AEOM queries and relationships work; for now, we'll just talk about objects "containing" other objects, and "referring" to objects.

For instance, to refer to all of the `document` objects currently contained by TextEdit's root `Application` object, you would write:

  textedit.documents

Type the following into your script and run it:

  print(textedit.documents)

The printed result may surprise you:

  ➝ TextEdit().documents

[TO DO: following still too long and rambling; need to make the key point: it's a query-driven world - bam! - and move on]

In a traditional DOM, evaluating this literal reference would typically return an array of Document instances. In AEOM, however, executing a literal reference merely returns a SwiftAutomation object _representing_ that reference, as a quick check of its dynamic type reveals:

  print(type(of: textedit.documents))
  ➝ TEDItems

`TEDItems` is one of the glue classes imported from MacOSGlues that enables you to interact with TextEdit using ordinary Swift property and method names. A `TEDItems` instance decribes a _one-to-many relationship_ between an object and zero or more other objects contained by it; in this case TextEdit's '`Application` object and all of the `document` objects—or _elements_—that it contains.

In order to do useful work with this reference, you have to send it as a _parameter_ to an application _command_. For example, to get a list of current TextEdit documents, pass the `textedit.documents` reference as the direct parameter to TextEdit's `get` command:

  print(try textedit.get(textedit.documents))

This time the result looks much more familiar:

  ➝ [TextEdit().documents["Untitled"], TextEdit().documents["Untitled 2"], ...]

However, don't forget we're communicating between two completely unrelated processes here: the `swift` process running our script and the `TextEdit` process. While simple values such as integers, strings, and arrays may be passed-by-copy between processes, complex internal application state cannot leave the process in which it is defined; therefore what we're actually seeing here is an array of yet more SwiftAutomation objects (this time of class `TEDItem`), each of which describes a _one-to-one relationship_ between TextEdit's `Application` object and one of its `document` objects. 

[ TO DO: while the above document specifiers are represented by an instance of the TextEdit glue's `TEDItem` class, the user can't observe this directly because the returned array's dynamic type is `Array<Any>`]

Don't worry if the AEOM's way of working isn't immediately clear to you: its novel approach to IPC can take some getting used to, especially if you're coming from a traditional object-oriented background, though you'll find it surprisingly logical and elegant once you do. 

Still, while AEOM semantics may be unusual, SwiftAutomation makes the syntax as pleasantly familiar as it can; providing a number of convenient "shorthand" forms for writing object references, or _specifiers_, and commands in a more Swift-like way. For instance, if an application command does not already include a direct parameter, SwiftAutomation automatically uses the reference upon which that command was called, thus:

  print(try textedit.get(textedit.documents))

can be written much more neatly as:

  print(try textedit.documents.get())


[ TO DO: worth introducing simple by-index, by-name specifiers here ]


## Manipulate the document's contents

  try textedit.documents[1].text.set(to: "Hello!")


## Create a new TextEdit document

[[ TO DO: order of material here is wrong: need to discuss document object structure before looking at how to pre-populate its properties in `make` ]]

[[ TO DO: also, some of the following discussion now occurs in new text above, so can be trimmed below ]]

Before we explore TextEdit's object model more deeply, let's look at how to create new objects. 

In a traditional DOM-style API, you would typically instantiate its `Node` class, assign the new instance to a temporary variable while you assign its properties, and finally insert it into the `var subNodes: Array<Node>` property of an existing `Node` object. However, Apple event IPC deals with _remote_ objects, not local ones, meaning you cannot create or store application objects in your own code as they exist in a completely separate process. Apple events can only manipulate application objects that already exist, and application objects can only exist as part of an existing application object model.

(In fact, even basic OO concepts such as "classes" and "objects" don't really apply to the Apple event world, which tends to reuse familiar terminology for convenience—at the cost of some confusion.)

[need a sentence about changing app state by manipulating object graph, as opposed to more familiar Cocoa approach of instantiating classes and inserting objects into an array]

First, create a new TextEdit document by making a new `document` object. This is done using the `make` command, passing it a single named parameter, `new:`, indicating the type of object to create; in this case `TED.document`:

  try textedit.make(new: TED.document)

If the application is not already running, it will be launched automatically the first time you send it a command.

On success, TextEdit's `make` command returns an _object specifier_ that identifies the newly created object, for example:

  TextEdit().documents["Untitled"]

This particular object specifier represents one-to-one relationship between TextEdit's main application object and a document object named "Untitled.txt". (In AppleScript jargon, the document object named "Untitled.txt" is an _element_ of the application object named "TextEdit".)

[TO DO: how best to show an example of a one-to-many relationship? Having the user write `TextEdit().documents.paragraphs` might be a good choice as it emphasizes how queries describe abstract relationships rather than literal containment.]


This specifier can be assigned to a constant or variable for easy reuse. Use the `make` command to create another document, this time assigning its result to a variable named `doc` as shown:

  let doc = try textedit.make(new: TED.document) as TEDItem

Declaring the command's return type (`TEDItem`) is not essential, but greatly improves both usability and reliability. Without it, the Swift compiler will infer the `doc` variable's type to be `Any`, allowing it to hold any value that the application might return. However, you won't be able to use the returned value's properties and methods until you cast it to a more specific type. Casting the command's return value directly not only allows the Swift compiler to infer the `doc` variable's exact type, it also tells SwiftAutomation to coerce whatever value the application returns to that type before unpacking it, or else throw an error if that conversion isn't supported. For instance, if an application command returns an integer, you would normally cast it to `Int`; however you could also cast it to `String`, in which case SwiftAutomation will perform that coercion automatically and return a string instead. This provides robust yet flexible type-safe bridging between Apple event's weak, dynamic type system and Swift's strong, static one.

[TO DO: don't say what TEDItem actually means...when should that be clarified?]

The above `make` command simply creates a new, blank document in TextEdit and returns a reference to it (`TextEdit().documents["Untitled"]`). To create a new document with custom content, use the `make` command's optional `withProperties:` parameter to specify the initial values for one or more of the document object's properties:

  let doc = try textedit.make(new: TED.document, withProperties: [TED.text:"Hello World!"]) as TEDItem

Here we tell TextEdit to create a new document object containing the text "Hello World!". [TO DO: SDEF would help here]


[TO DO: this will work better if the above `make` command is expanded to include `withProperties: [TED.text:"Hello World!"]`]. The next task will be to `get()` that document's text, which makes the point that object specifiers are only used to construct _queries_; to actually get a value from the application you _have_ to use a command, e.g. `get()`. (Kinda like the difference between putting together a file path, e.g. "/Users/jsmith/" + "TODO.txt", that describes the location of some data, and passing that path to a `read()` command to actually obtain the data from that location.) Once getting is covered, the `set()` example can show how to change that content to something else. In addition, the `get()` example can explain the shorthand form that allows the command's direct parameter to be used as its subject for conciseness, i.e. `textedit.get(doc.text)` -> `doc.text.get()]


[TO DO: open TextEdit's SDEF documentation in SwiftAutoEdit.app and summarize its contents and organization]

[TO DO: note that get/set aren't normally documented in app dictionaries]



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

  try doc.text.get()




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


## Writing a standalone 'script'

[TO DO: add note on writing and running 'scripts' using the following hashbang]

<pre><code>#!/usr/bin/swift -target x86_64-apple-macosx10.11 -F /Library/Frameworks</code></pre>


For example, the following Swift 'script' file, when saved to disk and made executable (`chmod +x /path/to/script`), returns the path to the folder shown in the frontmost Finder window (if any): [TO DO: rephrase as step-by-step exercise]

  #!/usr/bin/swift -target x86_64-apple-macosx10.12 -F /Library/Frameworks

  // Output path to frontmost Finder window (or a selected folder within).

  import Foundation
  import SwiftAutomation
  import MacOSGlues

  public struct StderrStream: TextOutputStream {
    public mutating func write(_ string: String) { fputs(string, stderr) }
  }
  public var errStream = StderrStream()

  do {
    let finder = Finder()
    let selection: [FINItem] = try finder.selection.get()
    let frontFolder: FINItem
    if selection.count > 0 {
      let item = selection[0]
      frontFolder = [FIN.disk, FIN.folder].contains(try item.class_.get()) ? item : try item.container.get()
    } else if try finder.FinderWindows[1].exists() {
      // TO DO: this doesn't work if Computer/Trash window
      frontFolder = try finder.FinderWindows[1].target.get()
    } else {
      frontFolder = finder.desktop
    }
    let fileURL: URL = try frontFolder.get(requestedType: FIN.fileURL)
    print(fileURL.path)
  } catch {
    print(error, to: &errStream)
    exit(1)
  }



