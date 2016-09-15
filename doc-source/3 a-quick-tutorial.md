# A quick tutorial

[NOTE: this tutorial is incomplete and unfinished, and while it can be read it can't yet be performed as-is due to Swift2's lack of support for building/linking/using 3rd-party frameworks outside of Xcode shared workspaces]

[TO DO: should this chapter come before Apple events chapter?]

[TO DO: TextEdit now returns by-name document specifiers; update code examples accordingly]

The following tutorial provides a practical taste of application scripting with Swift and SwiftAutomation. Later chapters cover the technical details of SwiftAutomation usage that are mostly skimmed over here.

## 'Hello World' tutorial


This tutorial uses SwiftAutomation, TextEdit and the interactive command line `swift` interpreter to perform a simple 'Hello World' exercise.

<p class="hilitebox">Caution: It is recommended that you do not have any other documents open in TextEdit during this tutorial, as accidental modifications are easy to make and changes to existing documents are not undoable.</p>

[TO DO: using interactive `swift` in Terminal will only work if SwiftAutomation framework and static glues can be passed via -framework and -F options; need to see if shared workspace+playground will be a better option.  OTOH, if interactive `swift` is a possibility, it would make sense to wrap it in a custom shell script that passes required options automatically, and also takes a list of scriptable apps for which to generate glues if they don't already exist]

To begin, launch Terminal.app and type `swift` followed by a newline to launch the `swift` interpreter:

    tim$ swift
    Welcome to Apple Swift version 2.0 (700.0.38.1 700.0.53). Type :help for assistance.


### Target TextEdit

[TO DO: first step is to generate the glue; second step is to import it]

The first step is to import the TextEdit glue module. [TO DO: need to figure out how and where to package and place glues for this to work; given that Swift currently sucks for building/importing third-party frameworks, this might be tricky]

    import TEDGlue

Once the glue module is imported, construct a new instance of the `TextEdit` class, identifying the application to be manipulated, and assign it to a variable or constant, `te`, for easy reuse:

    let textedit = TextEdit()

The application may be identified by name, path, bundle ID (the default, if no arguments are given), creator type or, if running remotely, URL. If the application is local and is not already running, it will be launched automatically for you.


### Create a new document

First, create a new TextEdit document by making a new `document` object. This is done using the `make` command, passing it a single named parameter, `new: TED.document`, indicating the type of object to create:

    textedit.make(new: TED.document)
    // TextEdit().documents[1]

Because `document` objects are always elements of the root `application` class, applications such as TextEdit can usually infer the location at which the new `document` object should appear. At other times, you need to supply an `at` parameter that indicates the desired location.

As you can see, the `make` command returns an object specifier identifying the newly-created object. This specifier can be assigned to a variable for easy reuse. Use the `make` command to create another document, this time assigning its result to a variable, `doc`:

    let doc = textedit.make(new: TED.document)


### Set the document's content

The next step is to set the document's content to the string `"Hello World"`. Every TextEdit document has a property, `text`, that represents the entire text of the document. This property is both readable and writeable, allowing you to retrieve and/or modify the document's textual content as unstyled unicode text.

Setting a property's value is done using the `set()` command. The `set()` command is exposed as a method of the root `application` class and has two parameters: a direct (positional) parameter containing an object specifier identifying the property (or properties) to be modified, and a named parameter, `to:`, containing the new value. In this case, the direct parameter is an object specifier identifying the new document's `text` property, `doc.text`, and the `to:` parameter is the string `"Hello World"`:

    textedit.set(doc.text, to: "Hello World")

The front TextEdit document should now contain the text "Hello World".

Because the above expression is a bit unwieldy to write, SwiftAutomation allows it to be written in a more elegant OO-like format as a special case, where the `set()` command is called upon the document's object specifier:

    doc.text.set(to: "Hello World")

Appscript converts this second form to the first form internally, so the end result is exactly the same. Appscript supports several such special cases, and these are described in the chapter on Application Commands. Using these special cases produces more elegant, readable source code, and is recommended.


### Get the document's content

Retrieving the document's text is done using the `get()` command:

    doc.text.get()
    // "Hello World"

This may seem counter-intuitive if you're used to dealing with AppleScript or Swift, where evaluating a literal reference returns the _value_ identified by that reference. However, SwiftAutomation only uses object-oriented references to construct object specifiers, not to resolve them. Always remember that an object specifier is really a first-class query object, so while the syntax may look similar to that of an object-oriented reference, its behavior is very different. For example, when evaluating the literal reference:

    textedit.documents[1].text

the result is an object specifier, `TextEdit().documents[1].text`, not the value being specified (`"Hello World"`). To get the value being specified, you have to pass the object specifier as the direct argument to TextEdit's `get()` command:

    textedit.get(doc.text)
    // "Hello World!"

As before, SwiftAutomation provides alternative convenience forms that allow the above command to be written more neatly as this:

    doc.text.get()


Depending on what sort of attribute(s) the object specifier identifies, `get()` may return a primitive value (number, string, list, dict, etc.), or it may return another object specifier, or list of object specifiers, e.g.:

    doc.text.get()
    // "Hello World!"
    
    textedit.documents[1].get()
    // TextEdit().documents[1]
    
    textedit.documents.get()
    // [TextEdit().documents[1], 
        TextEdit().documents[2]]
        
    textedit.documents.text.get()
    // ["Hello World", ""]


### More on `make()`

The above exercise uses two commands to create a new TextEdit document containing the text "Hello World". It is also possible to perform both operations using the `make()` command alone by passing the value for the new document's `text` property via the `make()` command's optional `withProperties:` parameter: 

    textedit.make(new: TED.document, withProperties=[TED.text: "Hello World"])
    // TextEdit().documents[1]

[TO DO: TextEdit now returns by-name document specifiers; update this paragraph accordingly] Incidentally, you might note that every time the `make()` command is used, it returns an object specifier to document _1_. TextEdit identifies `document` objects according to the stacking order of their windows, with document 1 being frontmost. When the window stacking order changes, whether as a result of a script command or GUI-based interaction, so does the order of their corresponding `document` objects. This means that a previously created object specifier such as `TextEdit().documents[1]` may now identify a different `document` object to before! Some applications prefer to return object specifiers that identify objects by name or unique ID rather than index to reduce or eliminate the potential for confusion, but it's an issue you should be aware of, particularly with long-running scripts where there is greater opportunity for unexpected third-party interactions to throw a spanner in the works.


### More on manipulating `text`

In addition to getting and setting a document's entire text by applying `get()` and `set()` commands to `text` property, it's also possible to manipulate selected sections of a document's text directly. TextEdit's `text` property contains a `text` object, which in turn has `character`, `word` and `paragraph` elements, all of which can be manipulated using a variety of commands - `get()`, `set()`, `make()`, `move`, `delete`, etc. For example, to set the size of the first character of every paragraph of the front document to 24pt:

    textedit.documents[1].text.paragraphs.size.set(to: 24)

Or to insert a new paragraph at the end of the document:

    textedit.make(new: TED.paragraph,
                   at: TEDApp.documents[1].text.paragraphs.end,
             withData: "Hello Again, World\n")

[TO DO: add note that unlike AS, Swift is sensitive to parameter order, so named params must appear in same order as in glue]


