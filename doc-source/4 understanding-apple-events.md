# Understanding Apple events

This chapter introduces the main concepts behind Apple event-based application scripting.

## What are Apple events?

Apple events are a high-level message-based form of Interprocess Communication (IPC), used to communicate between local or remote application processes (and, in some cases, within the same process).

An Apple event contains:

* several predefined _attributes_ describing how the event should be handled, such as the event's 'name' (specified by two `OSType` values [<a href="#f1">1</a>]) and whether or not a reply is required

* zero or more _parameters_ to the event handler that receives the event.

For example, when the user drag-n-drops one or more files onto TextEdit.app in the Finder, the Finder commands TextEdit to open that file by sending it an `aevt/odoc` event with a list of file identifiers as its direct parameter:

![Sending Apple event from Finder to TextEdit](finder_to_textedit_event.gif)

With suitable bindings, programming languages can also create and send Apple events. For example, when the code `iTunes().play()` is executed by a client application, a `hook/Play` event is sent from the client application to iTunes, instructing it to start playing:

![Sending Apple event from client application to iTunes](client_app_to_itunes_event.gif)

Applications may respond to an incoming Apple event by sending a reply event back to the client application. The reply event may contain either a return value, if there is one, or an error description if it was unable to handle the event as requested. For example, executing the command `TextEdit().name.get()` in a client appliation sends TextEdit a `core/getd` event containing an object specifier identifying the `name` property of its root `application` object. TextEdit processes this event, then sends a reply event containing the string "TextEdit" back to the client application, where it is returned as the command's result. This exchange is usually performed synchronously, appearing to the user as a simple remote procedure call. Asynchronous messaging is also supported, though is not normally used for desktop automation.



## What is a scriptable application?

A scriptable (or 'AppleScriptable') application is an application that provides an Apple event interface intended for third-party (e.g. end-user) use. The application implements one or more event handlers that respond to corresponding events, and may also support the Apple Event Object Model. While this interface may be regarded as an API, the emphasis is on providing a high-level _user interface_ that is peer to other users interfaces the application may have (GUI, CLI, web, etc.) and accessible to end-users as much as developers.

For example, iTunes.app implements two user interfaces, one graphical and one Apple event-based, that provide access to to much the same functionality but in very different ways:

![Application with Graphical and Apple event interfaces](application_architecture.gif)

A scriptable application also contains a built-in definition of its scripting interface in the form of an AETE or SDEF resource. This resource can be obtained programmatically and used:

* to support automatic translation of human-readable terminology to four-letter codes in high-level bridges such as AppleScript and SwiftAutomation

* to generate basic human-readable documentation by applications such as AppleScript Editor.


(Be aware that the AETE and SDEF formats do not provide an exhaustive description of the application's scripting interface, and additional documentation is usually required - if not always provided - to form a complete understanding of that interface and how to use it effectively.)



## What is the Apple Event Object Model?

The Apple Event Object Model (AEOM) is a [TO DO: 'relational graph'] View-Controller layer that provides an idealized, user-friendly representation of the application's internal data, allowing clients to identify and manipulate parts of that structure via Apple events. An incoming Apple event representing a particular command (get, set, move, etc.) is unpacked, and any object specifiers in its parameter list are evaluated against the application's AEOM to identify the user-level object(s) upon which the command should act. The command is then applied these objects, with the AEOM translating this into operations upon the application's implementation-level objects. These implementation-level objects are mostly user-data objects in the application's Model layer, plus a few GUI View objects of interest to scripters (such as those representing document windows). The internal architecture of a typical scriptable desktop application might look something like this:

![Internal architecture of application with Graphical and Apple event interfaces](application_architecture2.gif)

* The AEOM represents user data as an object graph (nominally tree-shaped) whose nodes are connected via one-to-one and/or one-to-many relationships.

* AEOM objects are identified by high-level queries (comparable to XPath or CSS selectors), not low-level chained method calls.

* Commands operate upon objects, so a single command may invoke multiple method calls upon multiple implementation objects in order to perform relatively complex tasks.

* Where a query specifies multiple objects, the command should perform the same action on each of them [<a href="#f2">2</a>].

* AEOM objects never move across the bridge. Where a command identifies one or more AEOM objects as its result, the return value is a query (or queries) that will [hopefully] identify those objects in future, not the AEOM objects themselves.

(While the Apple Event Object Model is sometimes described by third-parties as being similar to DOM, this is inaccurate as AEOM operates at a much higher level of abstraction than DOM.)



## How does the AEOM work?

[TO DO: might be worth drawing comparison between an AEOM 'class' and a Swift protocol, in that AEOM classes don't actually [have to] describe distinct types of objects, but rather describe how you can interact with them - e.g. `paragraph`]

The AEOM is a tree-like structure made up of objects. These objects may contain descriptive attributes such as class, name, id, size, or bounds; for example:

  finder.version
  itunes.playerState
  textedit.frontmost

and may 'contain' other objects:

  finder.home
  textedit.documents
  itunes.playlists

However, unlike other object models such as DOM, objects within the AEOM are associated with one another by _relationships_ rather than simple physical containment. Think of AEOM as combining aspects of procedural RPC, object-oriented object model and relational database mechanics.

Relationships between objects may be one-to-one:

  finder.home
  itunes.currentTrack

or one-to-many:

  finder.folders
  itunes.playlists

While relationships often follow the containment structure of the underlying data structures:

  textedit.documents

this is not always the case. For example, the following object specifiers all identify the same objects (files on the user's desktop):

  finder.disks["Macintosh HD"].folders["Users"].folders["jsmith"].folders["Desktop"].files

  finder.desktop.files

  finder.files

though only the first specifier describes the files' location by physical containment; the other two use other relationships provided by the application as convenient shortcuts. Some applications can be surprisingly flexible in interpreting and evaluating queries against this relational object graph:

  finder.home.folders["Desktop"].files

  finder.startupDisk.folders["Users:jsmith:Desktop:"].files

  finder.items[URL(string:"file:///Users/jsmith/Desktop")].files

Some specifiers may identify different objects at different times, according to changes in the application's state:

  itunes.currentTrack

Some specifiers may identify data that doesn't exist as distinct objects within the application's underlying Model layer, but instead describe how to find content within other internal data structures such as a character buffer or SQLite backing store. For instance:

  textedit.documents[1].text.characters

  textedit.documents[1].text.words

  textedit.documents[1].text.paragraphs

do not identify actual `character`, `word`, or `paragraph` object instances, but instead describe how to locate a range of data within a single `NSTextStorage` instance. This decoupling of the AEOM from the Model layer's structure allows applications to present data in a way that is convenient to the user, i.e. easy and intuitive to understand and use.

Finally, one-to-many relationships may be selective in identifying a subset of related elements according to their individual class or shared superclasses. For example:

  finder.items

identifies all objects that are a subclass of class 'item' (i.e. disks, folders, document files, alias files, etc.).

  finder.files

identifies all objects that are a subclass of class 'file' (i.e. document files, alias files, etc.).

  finder.documentFiles

identifies all objects of class 'document file' only.


Understanding the structure of an application's AEOM is key to successfully manipulating it. To illustrate the above concepts, here is the AEOM for a simple hypothetical text editor:

![AEOM relationships in an simple text editor](relationships_example.gif)

The program has an application object as its root, which in turn has one-to-many relationships with its document and window objects.

Each document object has one-to-many relationships to the characters, words and paragraphs of the text it contains, each of which in turn has one-to-many relationships to the characters, words and paragraphs of the text it contains, and so on to infinity.

Finally, each window object has a one-to-one relationship to the document object whose content it displays.



## How SwiftAutomation works

SwiftAutomation is a high-level pure-Swift wrapper for macOS's lower-level Apple Event Manager APIs (`NSAppleEventDescriptor`). 

The SwiftAutomation architecture consists of two parts:

* a collection of abstract classes and protocol extensions, providing an object-oriented API for building relational AEOM queries (object specifiers) and dispatching Apple events (commands)

* a command-line code generation tool, `aeglue`, that combines these abstract components into concrete classes that can be used to construct object specifiers and send commands. 

In addition, `aeglue` can use the target application's dictionary (AETE/SDEF resource) to add human-readable properties and methods to these classes, creating a user-friendly high-level interface over the cryptic four-char codes (`OSType`) used by the Apple Event Manager itself.


For example, the following AppleScript sets the size of the first character of every non-empty paragraph in every document of TextEdit to 24 pt:

  tell application id "com.apple.TextEdit"
    set size of character 1 of (every paragraph where it ≠ "\n") of every document to 24
  end tell

Here is the equivalent Swift code using SwiftAutomation's default `AE` glue:

  let textedit = AEApplication(bundleIdentifier: "com.apple.TextEdit")

  let specifier = AEApp.elements("docu")
                       .property("ctxt")
                       .elements("cpar")[AEIts != "\n"]
                       .elements("cha ")[1]
                       .property("ptsz")
  try textedit.sendAppleEvent("core", "getd", ["----": specifier, "data": 24])

and using glue classes generated specifically for TextEdit:

  let textedit = TextEdit()

  try textedit.documents.text.paragraphs[TEDIts != "\n"].characters[1].size.set(to: 24)

-------

<a name="f1"></a>[1] `OSType`: a 32-bit value, often represented as a 4-character C literal, a.k.a. "four-char code". Used in Carbon APIs such as the Apple Event Manager. Mnemonic values are preferred, e.g. '<tt>docu</tt>' = 'document'.

<a name="f2"></a>[2] Assuming a well-implemented AEOM; in practice most AEOM implementations suffer varying degrees of limitations in their ability to operate successfully on complex multi-object specifiers. These limitations are generally not documented but discovered through trial and error.

