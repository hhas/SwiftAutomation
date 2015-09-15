# Commands

[TO DO: this chapter is still rough, and there's little commonality between ObjC and Swift text; the ObjC API is also not finalized and may change slightly/drastically in future]

## Syntax

For convenience, SwiftAE makes application commands available as methods on every object specifier. (Note: due to the limitations of aete-based terminology, the user must determine for themselves which commands can operate on a particular reference. Some applications document this information separately.) All application commands have the same basic structure: a single, optional direct parameter, followed by zero or more named parameters specific to that command, followed by zero or more event attributes that determine how the Apple event is processed:

<pre><code>func <var>commandName</var>(directParameter: AnyObject = NoParameter,
                 <var>namedParameter1:</var> AnyObject = NoParameter,
                 <var>namedParameter2:</var> AnyObject = NoParameter,
                 ...
                 waitReply:       Bool                = true,
                 withTimeout:     NSTimeInterval?     = nil,
                 considering:     ConsideringOptions? = nil) throws -> Any</code></pre>

* `directParameter:` -- An application command can have either zero or one direct parameters. The application's dictionary indicates which commands take a direct parameter, and if it is optional or required.

* `namedParameterN:`An application command can have zero or more named parameters. The application's dictionary describes the named parameters for each command, and if they are optional or required.

* `returnType:` -- Some applications may allow the return value's type to be specified for certain commands (typically `get`). For example, the Finder's `get` command returns filesystem references as alias objects if the resulttype is `FIN.alias`. [TO DO: this is preliminary and subject to change]

* `waitReply:` -- If `true` (the default), the command will block until the application sends a reply or the request times out. If `false`, it will return as soon as the request is sent, ignoring any return values or application errors.

* `withTimeout:` -- The number of seconds to wait for the application to reply before raising a timeout error. The default timeout (`DefaultTimeout`) is 120 seconds but this can be changed if necessary; use `NoTimeout` to wait indefinitely. For example, a longer timeout may be needed to prevent a timeout error occurring during a particularly long-running application command. Note: due to a quirk in the Apple Event Manager API, timeout errors may be reported as either error -1712 (the Apple event timed out) or -609 (connection invalid, which is also raised when an application unexpectedly quits while handling a command).

* `considering:` -- Some applications may allow the client to specify text attributes that should be considered when performing string comparisons, e.g. when resolving by-test references. When specifying the attributes to consider, the set should contain zero or more of the following symbols: `AE.case`, `AE.diacriticals`, `AE.numericStrings`, `AE.hyphens`, `AE.punctuation`, `AE.whitespace` [TO DO: and/or use the glue's own prefix code, e.g. `TED.case`]. If omitted, `[AE.case]` is used as the default. Note that most applications currently ignore this setting and always use the default behaviour, which is to ignore case but consider everything else.



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



## Special cases

The following special-case behaviours are implemented for convenience:

* Commands that take a specifier as a direct parameter may be written in the following form:

        specifier.command(namedParameter1: someValue, namedParameter2: someValue, ...)

    The conventional form is also supported should you ever wish (or need) to use it:

        application.command(specifier, namedParameter1: someValue, namedParameter2: someValue, ...)

The two forms are equivalent (SwiftAE converts the first form to the second behind the scenes) although the first form is preferred for conciseness. [TO DO: note that the first form only works when specifier has a targeted application object as its root; if the specifier is constructed from an untargeted `App` root, the second form must be used]


* If a command that already has a direct parameter is called on a specifier, i.e.:

        specifier.command(someValue, ...)

the specifier upon which it is called will be packed as the Apple event's "subject" attribute (`keySubjectAttr`).


* If the `make` command is called on an insertion location specifier (`before`/`after`/`beginning`/`end`), SwiftAE will pack that specifier as the Apple event's `at:` parameter if it doesn't already have one; i.e.:

        insertionSpecifier.make(new: className)

   is equivalent to:

        application.make(new: className, at: insertionSpecifier)

   If the `make` command is called on an object specifier, SwiftAE will pack that specifier as the Apple event's "subject" attribute. Be aware that some applications may not handle this attribute correctly, in which case the specifier should be passed via the `make` command's `at:` parameter. [TO DO: clarify this; also, note again that the convenience form only works when specifier is constructed from a targeted Application object]


## Command errors

[TO DO: Error class implementation is not yet finalized; update this section when done]

If a command fails due to an error raised by the target application or Apple Event Manager, or if a given parameter or attribute was not of a [supported type](objc-ae-type-mappings.html), a `CommandError` is thrown. SwiftAE errors have the domain `SwiftAEErrorDomain`, an error code that is typically an `OSStatus` value or custom value defined by the target application, and a `userInfo` dictionary containing a standard `NSLocalizedDescription` key containing the error description string, plus zero or more of the following SwiftAE-defined keys:

* Standard Apple event/OSA error information:

  * `errorNumber` – the error code (`Int`); this is the same as `NSError.code`
  * `errorMessage` – the error message (`String`) provided by the application, if any, otherwise a default description if the error number is a standard AE error code
  * `errorBriefMessage` – short version of the above; not normally used by applications, but included here for completeness
  * `errorExpectedType` – if a coercion error (-1700) occurred, a `Symbol` describing the type of value that was required
  * `errorOffendingObject` – the parameter (`AnyObject`) that caused the error, where relevant

* Additional error information: 

  * `errorFailedCommandDescription` – the source code `String` representation of the failed command
  * `errorFailedAppleEvent` – the underlying `NSAppleEventDescriptor` instance that was constructed by the Swift glue


## Note to AppleScript users

Unlike AppleScript, which implicitly sends a `get` command to any unresolved application object references at the end of evaluating an expression, SwiftAE only resolves a reference when it receives an appropriate command. For example:

  let o = TextEdit().documents

is _not_ the same as:

  set o to documents of application "TextEdit"

even though the two statements may look equivalent. In the Swift example, the value assigned to `o` is an instance of `TEDSpecifier`, `TextEdit(name:"/Applications/TextEdit.app").documents`, i.e. an _object specifier_. Whereas, in the AppleScript example, the evaluating the `documents of application "TextEdit"` expression not only constructs the same specifier, it _also_ automatically sends a `get` event to the target application in order to retrieve the specified data, then assigns the result of that request to `o`:

<pre><code>set o to documents of application "TextEdit"
-- {document "Untitled" of application "TextEdit", document "Untitled 2" of application "TextEdit"}</code></pre>

This "implicit `get`" behavior is built directly into the AppleScript interpreter itself, and automatically applied to any specifier literal that does not already appear as a parameter to an application command, as a `tell` block target, or as the sole operand to AppleScript's' `a reference to` operator:

<pre><code>set o to <strong>a reference to</strong> documents of application "TextEdit"
-- every document of application "TextEdit"</code></pre>


In contrast, SwiftAE has no invisible "magic" behaviors attempting to infer your actual intent: it only ever sends an Apple event when you _explicitly_ instruct it to do so:

<pre><code>let o = TextEdit().documents<strong>.get()</strong>
print(o)
// [TextEdit().documents["Untitled"], TextEdit().documents["Untitled 2"]]</code></pre>

New users coming from AppleScript or OO language backgrounds may find this unintuitive at first, but SwiftAE's clean separation between query construction and event dispatch ensures SwiftAE's behavior is completely straightforward and predictable, and avoids the hidden gotchas that can bite AppleScript users in various unexpected and confusing ways.

