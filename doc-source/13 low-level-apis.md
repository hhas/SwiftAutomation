# Using the low-level `AEApplication` glue

While glue files' terminology-based properties and methods are recommended for controlling individual "AppleScriptable" applications, SwiftAutomation also includes lower-level APIs for interacting with "non-scriptable" "applications that do not include an AETE/SDEF terminology resource, or whose terminology contains defects that render some or all of the generated glue unusable, or when sending standard commands that do not require an application-specific glue. These low-level APIs are present on all generated glues' `Application` and `ObjectSpecifier` classes if needed, and also on the default `AEApplicationGlue` that is included in SwiftAutomation as standard.


## Sending standard Apple events

The following commands are defined on all `Application` and `Specifier` classes, including the default `AEApplication`, and are recognized by most/all macOS applications:

  run()
  reopen()
  launch()
  activate()
  open(Array<URL>) // list of file URLs
  openLocation(String) // a URL string (e.g. "http://apple.com")
  print(Array<URL>) // list of file URLs
  quit( [ saving: AE.yes|AE.no|AE.ask ] )

(Standard `get` and `set` commands are also defined, but will only work in apps that implement an AEOM.)

As with application-specific commands, standard commands will throw a `CommandError` on failure, so remember to prefix with `try`.

For example, to open a file:

  // tell application id "com.apple.TextEdit" to open (POSIX file "/Users/jsmith/ReadMe.txt")
  let textedit = AEApplication(bundleIdentifier: "com.apple.TextEdit")
  try textedit.open(URL(fileURLWithPath: "/Users/jsmith/ReadMe.txt"))

Or to quit multiple applications without saving changes to any open documents:

  for appName in ["TextEdit", "Preview", "Script Editor"] {
    let app = AEApplication(name: appName)
    if app.isRunning { try? app.quit(saving: AE.no) }
  }


## Sending Apple events using four-char codes

All specifiers implement a low-level `sendAppleEvent(...)` method, allowing Apple events to be built and sent using four-char codes (a.k.a. OSTypes):

  sendAppleEvent(_ eventClass: OSType/String, _ eventID: OSType/String, _ parameters: [OSType/String:Any] = [:],
                 requestedType: Symbol? = nil, waitReply: Bool = true, sendOptions: SendOptions? = nil,
                 withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T/Any

Four-char codes may be given as `OSType` (`UInt32`) values or as `OSType`-encodable `String` values containing exactly four MacRoman characters. Invalid strings will cause `sendAppleEvent()` to throw a `CommandError`.

For example:

  // tell application id "com.apple.TextEdit" to open (POSIX file "/Users/jsmith/ReadMe.txt")
  // tell application id "com.apple.TextEdit" to «event aevtodoc» (POSIX file "/Users/jsmith/ReadMe.txt")
  let textedit = AEApplication(bundleIdentifier: "com.apple.TextEdit")
  try textedit.sendAppleEvent("aevt", "odoc", ["----": URL(fileURLWithPath: "/Users/jsmith/ReadMe.txt")])

  // tell application id "com.apple.TextEdit" to quit saving no
  // tell application id "com.apple.TextEdit" to «event aevtquit» given «class savo»: «constant ****ask »
  try textedit.sendAppleEvent("aevt", "quit", ["savo": AE.ask])

<p class="hilitebox">While the Carbon AE headers define constants for common four-char codes, e.g. <code>cDocument</code> = <code>'docu'</code> = <code>0x646f6375</code>, as of Swift3/Xcode8/macOS10.12 some constants are incorrectly mapped to <code>Int</code> (<code>SInt64</code>) instead of <code>OSType</code> (<code>UInt32</code>), so their use is best avoided.</p>


## Constructing object specifiers using four-char codes

All object specifiers implement low-level methods for constructing property and all-elements specifiers

  * userProperty(_ name: String) -- user-defined identifier, e.g. `someProperty` (note: case-[in]sensitivity rules are target-specific)

  * property(_ code: OSType/String) -- four-char code, either as OSType (UInt32) or four-char string, e.g. `cDocument`/`"docu"`

  * elements(_ code: OSType/String) -- ditto

The default `AEApplicationGlue` defines `AEApp`, `AECon`, and `AEIts` roots for constructing untargeted specifiers using four-char codes only. 

Insertion and element selectors are the same as in application-specific glues; see [Chapter 7](object-specifiers.html) for details.


For example:

  // every paragraph of text of document 1 [of it]
  // every «class cpar» of «property ctxt» of «class docu» [of it]
  AEApp.elements("docu")[1].property("ctxt").elements("cpar")
  AEApp.elements(0x646f6375)[1].property(0x63747874).elements(0x63706172)


## Constructing symbols using four-char codes

The default `AEApplicationGlue` defines an `AESymbol` class, type aliased as `AE`, for constructing `Symbol` instances using four-char codes:

  AESymbol(code: OSType/String, type: OSType/String = typeType/"type")

For example:

  // document
  // «class docu»
  AE(code: "docu")
  AE(code: 0x646f6375)

  // name
  // «property pnam»
  AE(code: "pnam", type: "prop") // (note: "type" is more commonly used than "prop")
  AE(code: 0x706e616d, type: 0x70726f70)

  // ask
  // «constant ****ask »
  AE(code: "ask ", type: "enum")
  AE(code: 0x61736b20, type: 0x656e756d)

`AESymbol` instances can be used interchangeably with glue-defined <code><var>PREFIX</var>Symbol</code> classes. SwiftAutomation only compares `Symbol` instances' `code` and `type` properties when comparing for equality; thus the following equality test returns true:

  AE(code: "docu") == TED.document


## Using symbols as AERecord keys

AppleScript records can contain any combination of keyword- and/or identifier-based keys, so the `Symbol` class also defines an `init(_ name: String)` initializer, allowing identifier-based record keys to be constructed as well:

  // {name: "Sam", age: 32, isSingle: true}
  [AE(code:"pnam"): "Sam", AE("age"): 32, AE("issingle"): true]

Be aware that case-[in]sensitivity rules for identifier strings can vary depending on how and where the record is used; for case-insensitivity, use all-lowercase.

To determine if a `Symbol` instance represents a keyword or an identifier:

  AE(code:"pnam").nameOnly // false 
  AE("issingle").nameOnly  // true

Scriptable applications do not normally use identifier-based keys in records; however, they may be used by AppleScript-based applets and in `NSAppleScript`/`NSUserAppleScriptTask` calls.


