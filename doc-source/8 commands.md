# Commands

[TO DO: this chapter is still rough and not fully updated; amongst other things it doesn't discuss how return types work]

## Syntax

All application commands have the same basic structure: a single, optional direct parameter, followed by zero or more named parameters specific to that command, followed by zero or more event attributes that determine how the Apple event is processed:

<pre><code>func <var>commandName</var>&lt;T&gt;(directParameter: Any  = NoParameter,
                 <var>namedParameter1:</var> Any  = NoParameter,
                 <var>namedParameter2:</var> Any  = NoParameter,
                 ...
                 resultType:  Symbol?             = nil,
                 waitReply:   Bool                = true,
                 sendOptions: SendOptions?        = nil,
                 withTimeout: NSTimeInterval?     = nil,
                 considering: ConsideringOptions? = nil) throws -> T</pre>

* `directParameter:` -- An application command can have either zero or one direct parameters. The application's dictionary indicates which commands take a direct parameter, and if it is optional or required.

* `namedParameterN:`An application command can have zero or more named parameters. The application's dictionary describes the named parameters for each command, and if they are optional or required.

* `resultType:` -- Some application commands (e.g. `get`) can return the same result as more than one type. [TO DO: rephrase, making clear that this only indicates the caller's preference as to what type it'd like the command's result to be - a very basic form of content negotiation - there is no guarantee the target app will respect it. Most apps ignore it, and even those that do support it often only do so for `get`.] For example, `Finder().home.get()` normally returns an object specifier, but will return a `URL` value instead if its `resultType:` is `FIN.alias`: `Finder().home.get(resultType: FIN.alias)`. [Note that in AS, `COMMAND as TYPE` does double duty, both indicating its preferred result type to the app _and_ coercing the actual result when it arrives. In SA, `COMMAND as TYPE` only performs the latter; the former is done via `resultType:`.]

* `waitReply:` -- If `true` (the default), the command will block until the application sends a reply or the request times out. If `false`, it will return as soon as the request is sent, ignoring any return values or application errors.

* `sendOptions:` -- May be used instead of `waitReply:` if additional/alternative Apple event send options need to be sent. See the `NSAppleEventDescriptor.SendOptions` documentation for details. (For example, if the `.queueReply` option is used, the command will immediately return the expected reply event's' return ID as `Int`, allowing the client to recognize the target application's reply event when it later arrives in its main event queue.)

* `withTimeout:` -- The number of seconds to wait for the application to reply before raising a timeout error. The default timeout (`DefaultTimeout`) is 120 seconds but this can be changed if necessary; use `NoTimeout` to wait indefinitely. For example, a longer timeout may be needed to prevent a timeout error occurring during a particularly long-running application command. Note: due to a quirk in the Apple Event Manager API, timeout errors may be reported as either error -1712 (the Apple event timed out) or -609 (connection invalid, which is also raised when an application unexpectedly quits while handling a command).

* `considering:` -- Some applications may allow the client to specify text attributes that should be considered when performing string comparisons, e.g. when resolving by-test references. When specifying the attributes to consider, the set should contain zero or more of the following symbols: `AE.case`, `AE.diacriticals`, `AE.numericStrings`, `AE.hyphens`, `AE.punctuation`, `AE.whitespace` [TO DO: and/or use the glue's own prefix code, e.g. `TED.case`]. If omitted, `[AE.case]` is used as the default. Note that most applications currently ignore this setting and always use the default behaviour, which is to ignore case but consider everything else.


For convenience, SwiftAutomation makes application commands available as methods on every object specifier. Due to the technical limitations of application dictionaries, the user must determine for themselves which commands can operate on a particular reference. Some applications document this information separately.



## Examples

  // tell application "TextEdit" to activate
  TextEdit().activate()

  // tell application "TextEdit" to open fileList
  TextEdit().open(fileList)

  // tell application "Finder" to get version
  Finder().version.get()

  // tell application "Finder" to set name of file "foo.txt" of home to "bar.txt"
  Finder().home.files["foo.txt"].name.set(to: "bar.txt")

  // tell application "TextEdit" to count (text of first document) each paragraph
  TextEdit().documents.first.text.count(each: TED.paragraph)

  // tell application "TextEdit" to make new document at end of documents
  TextEdit().documents.end.make(new: TED.document)

  // tell application "Finder" to get items of home as alias list
  Finder().home.items.get(returnType: FIN.alias)


## TO DO: return types

- Any

- generic

- note that some commands

When specifying a command's return type, you may also need tell the application the exact descriptor type (`Symbol.alias`, `Symbol.fileURL`, etc). For example, the Finder normally returns file system references as object specifiers:

  let finder = Finder()

  finder.home.get()
  // Finder().startupDisk.folders["Users"].folders["Users"]

To get the current user's home folder as a `URL` instead:

  finder.home.get(resultType: FIN.fileURL) as URL
  // URL(string:"file:///Users/jsmith")





## Special cases

The following special-case behaviours are implemented for convenience:

* Commands that take a specifier as a direct parameter may be written in the following form:

    specifier.command(namedParameter1: someValue, namedParameter2: someValue, ...)

  The conventional form is also supported should you ever wish (or need) to use it:

    application.command(specifier, namedParameter1: someValue, namedParameter2: someValue, ...)

The two forms are equivalent (SwiftAutomation converts the first form to the second behind the scenes) although the first form is preferred for conciseness. [TO DO: note that the first form only works when specifier has a targeted application object as its root; if the specifier is constructed from an untargeted `App` root, the second form must be used]


* If a command that already has a direct parameter is called on a specifier, i.e.:

    specifier.command(someValue, ...)

the specifier upon which it is called will be packed as the Apple event's "subject" attribute (`keySubjectAttr`).


* If the `make` command is called on an insertion location specifier (`before`/`after`/`beginning`/`end`), SwiftAutomation will pack that specifier as the Apple event's `at:` parameter if it doesn't already have one; i.e.:

    insertionSpecifier.make(new: className)

  is equivalent to:

    application.make(new: className, at: insertionSpecifier)

  If the `make` command is called on an object specifier, SwiftAutomation will pack that specifier as the Apple event's "subject" attribute. Be aware that some applications may not handle this attribute correctly, in which case the specifier should be passed via the `make` command's `at:` parameter. [TO DO: clarify this; also, note again that the convenience form only works when specifier is constructed from a targeted Application object]



## Command errors

If a command fails due to an error raised by the target application or Apple Event Manager, or if a given parameter or attribute was not of a [supported type](type-mappings.html), a `CommandError` containing the following properties is thrown:

* Apple Event Manager/Application error information:

  * `code`: `Int` – the error code, e.g. -1728 = "Can't get reference." Usually a standard `OSStatus` code.
  * `message`: `String?` – the error message (`String`) provided by the application, if any; or a general error description if it's a known error code
  * `expectedType`: `Symbol?` – if the application encountered a coercion error (-1700), the type of value that it required, e.g. `AE.record`
  * `offendingObject`: `Any?` – the parameter that caused the the application to report an error, where relevant

* SwiftAutomation error information: 

  * `cause`: `Error?` – the underlying error that caused the command to fail (e.g. `UnpackError` if the command's result couldn't be unpacked as the specified Swift type)
  * `commandDescription`: `String` – the source code representation of the failed command
  * `description`: `String` – a detailed human-readable description of the error and the reason it occurred


## Note to AppleScript users

Unlike AppleScript, which implicitly sends a `get` command to any unresolved application object references at the end of evaluating an expression, SwiftAutomation only resolves a reference when it receives an appropriate command. For example:

  let o = TextEdit().documents

is _not_ the same as:

  set o to documents of application "TextEdit"

even though the two statements may look equivalent. In the Swift example, the value assigned to `o` is an instance of `TEDSpecifier`, `TextEdit(name:"/Applications/TextEdit.app").documents`, i.e. an _object specifier_. Whereas, in the AppleScript example, the evaluating the `documents of application "TextEdit"` expression not only constructs the same specifier, it _also_ automatically sends a `get` event to the target application in order to retrieve the specified data, then assigns the result of that request to `o`:

<pre><code>set o to documents of application "TextEdit"
-- {document "Untitled" of application "TextEdit", document "Untitled 2" of application "TextEdit"}</code></pre>

This "implicit `get`" behavior is built directly into the AppleScript interpreter itself, and automatically applied to any specifier literal that does not already appear as a parameter to an application command, as a `tell` block target, or as the sole operand to AppleScript's' `a reference to` operator:

<pre><code>set o to <strong>a reference to</strong> documents of application "TextEdit"
-- every document of application "TextEdit"</code></pre>


In contrast, SwiftAutomation has no invisible "magic" behaviors attempting to infer your actual intent: it only ever sends an Apple event when you _explicitly_ instruct it to do so:

<pre><code>let o = TextEdit().documents<strong>.get()</strong>
print(o)
// [TextEdit().documents["Untitled"], TextEdit().documents["Untitled 2"]]</code></pre>

New users coming from AppleScript or OO language backgrounds may find this unintuitive at first, but SwiftAutomation's clean separation between query construction and event dispatch ensures SwiftAutomation's behavior is completely straightforward and predictable, and avoids the hidden gotchas that can bite AppleScript users in various unexpected and confusing ways.

