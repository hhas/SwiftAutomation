# Apple event type mappings

## Overview

[TO DO: finish updating this chapter]

Standard Apple event descriptor types are mapped to and from Foundation/SwiftAutomation classes as follows:

<table width="100%" summary="AE-Foundation type mappings">
<thead>
<tr><th>AppleScript type</th><th>Descriptor type</th><th>`Symbol` name</th><th>Cocoa class</th></tr>
</thead>
<tbody>
<tr><td>(no data)</td><td><code>typeNull</code></td><td><code>null</code></td><td><code><var>PREFIX</var>App</code></td></tr>
<tr><td><code>boolean</code></td><td><code>typeBoolean</code></td><td><code>boolean</code></td><td><code>Bool</code></tr>
<tr><td><code>integer</code></td><td><code>typeSInt32</code></td><td><code>integer</code></td><td><code>Int</code></td></tr>
<tr><td><code>real</code></td><td><code>typeIEEE64BitFloatingPoint</code></td><td><code>float</code></td><td><code>Double</code></td></tr>
<tr><td><code>text</code> [1]</td><td><code>typeUnicodeText</code></td><td><code>unicodeText</code></td><td><code>String</code></td></tr>
<tr><td><code>list</code></td><td><code>typeAEList</code></td><td><code>list</code></td><td><code>Array</code></td></tr>
<tr><td><code>record</code></td><td><code>typeAERecord</code></td><td><code>record</code></td><td><code>Dictionary</code></td></tr>
<tr><td><code>date</code></td><td><code>typeLongDateTime</code></td><td><code>date</code></td><td><code>Date</code></td></tr>
<tr><td><code>«class bmrk»</code></td><td><code>typeBookmarkData</code></td><td><code>bookmarkData</code></td><td><code>URL</code> [2]</td></tr>
<tr><td><code>alias</code></td><td><code>typeAlias</code></td><td><code>alias</code></td><td><code>URL</code> [2]</td></tr>
<tr><td><code>«class furl»</code></td><td><code>typeFileURL</code></td><td><code>fileURL</code></td><td><code>URL</code> [2]</td></tr>
<tr><td><code>reference</code></td><td><code>typeObjectSpecifier</code></td><td><code>reference</code></td><td><code><var>PREFIX</var>Item</code>/<var>PREFIX</var>Items</code> [3]</td></tr>
<tr><td><code>location reference</code></td><td><code>typeInsertionLoc</code></td><td><code>locationReference</code></td><td><code><var>PREFIX</var>Insertion</code></code> [3]</td></tr>
<tr><td><code>class</code></td><td><code>typeType</code></td><td><code>typeClass</code></td><td><code><var>PREFIX</var>Symbol</code> [3]</td></tr>
<tr><td><code>constant</code></td><td><code>typeEnumerated</code></td><td><code>enumerator</code></td><td><var>PREFIX</var>Symbol</code> [3]</td></tr>
<tr><td><code>property</code></td><td><code>typeProperty</code></td><td><code>property</code></td><td><var>PREFIX</var>Symbol</code> [3]</td></tr>
</tbody>
</table>

[1] While AppleScript now treats `string`, `text`, and `Unicode text` keywords as synonyms for `typeUnicodeText`, the Apple Event Manager still  considers them to be different types (`typeChar`, `cText`, `typeUnicodeText`). When specifying a command's `as` parameter, always use `AE.unicodeText`, which is the standard (UTF16) representation used for Unicode text.

[2] Bookmark, Alias, FSRef, and FileURL descriptors are all currently mapped to Swift `URL` structs. [TO DO: bookmark/alias types identify file system *objects* [e.g. by inode], whereas FSRef/FileURL identify file system locations; however, only NSURL can distinguish the two so for now any Bookmark/Alias information will be lost on conversion to Swift `URL` instances, while `URL` will always pack as typeFileURL. This may change in future depending on how many compatibility issues with older Carbon apps this lack of roundtripping throws up.]

[3] Glue files define their own application-specific `Object` and `Symbol` subclasses [and others...].


## Mapping notes

While AE-Swift type conversions generally work quite seamlessly, it is sometimes useful to know some of the details involved, particularly when troubleshooting code that deals with older or buggy applications. The following sections provide additional information.

[TO DO: type mapping implementations are yet to be finalized; update the following sections when done]


### Boolean

SwiftAutomation normally maps `typeBoolean` descriptors to and from Swift's `Bool` type. 

SwiftAutomation can also unpack descriptors of `typeTrue` and `typeFalse`, although these are not normally returned by applications.


### Numbers

While the Apple Event Manager defines a range of numerical descriptor types with different bit-widths and formats, most applications normally use `typeSInt32` (`int`) and `typeIEEE64BitFloatingPoint` (`double`) only.

When packing a signed integer, SwiftAutomation will pack it either as a 32-bit signed integer (most preferred), 64-bit signed integer, or 64-bit float (least preferred), depending on the value's size. When packing a 32-bit unsigned integer, SwiftAutomation will pack it as a 32-bit signed integer if possible.

If an `NSNumber` instance is supplied as a command parameter, SwiftAutomation will pack it as `typeBoolean` _if_ it can determine it represents a Boolean value, otherwise it will pack it as an integer or floating-point number according to its `objCType` property. (The `NSNumber` class cluster privately represents Boolean values as bridged `CFBoolean` (`__NSCFBoolean`) instances; however, its public `objCType` API does not distinguish between these and `char` values so SwiftAutomation cannot guarantee it will detect the correct type. If in doubt, cast the `NSNumber` to `Bool`/`Int`/`Double` first to ensure it packs as a specific type.)


### Strings

When packing and unpacking `String` values, SwiftAutomation uses the `NSAppleEventDescriptor` class's `+descriptorWithString:` and `-stringValue` methods, both of which use descriptors of `typeUnicodeText`, coercing other types as needed.

Note that while the CoreServices framework's `AEDataModel.h` header states that `typeUnicodeText` is deprecated in favor `typeUTF8Text` and `typeUTF16ExternalRepresentation`, it remains in widespread use; therefore SwiftAutomation continues to use `typeUnicodeText` to ensure the broadest compatibility with existing scriptable applications.

Some older Carbon applications might return text values as descriptors of `typeChar`, `typeIntlText`, or `typeStyledText`. These types are long-deprecated and their use strongly discouraged in macOS. SwiftAutomation will coerce these descriptors to `typeUnicodeText` before unpacking them, or throw an `UnpackError` if the coercion fails.


### File system references

// TO DO: SwiftAutomation currently uses Swift's URL struct, which doesn't provide the extra descriptor caching or explicit coercion methods (it also currently doesn't distinguish between path-style URLs and bookmark-style URLs, and treats everything as typeFileURL, which might cause problems on any older, poorly designed Carbon apps that explicitly typecheck their params as typeAlias instead of coercing them to that type as they're supposed to)

The Apple Event Manager defines a number of modern (`typeFileURL`, `typeBookmarkData`), legacy (`typeAlias`), and deprecated (`typeFSRef`, `typeFSS`) descriptor types for identifying file system objects. (Object specifiers of form `{want:file,from:null,form:name,seld:"HFS:PATH:STRING"}` are also recognized by most applications, though not recommended.) Fortunately, the Apple Event Manager also implements a number of coercion handlers for coercing between these types, so when interacting with most applications you should not need to know or care exactly which of these types are used: the application should coerce supplied values to whichever type(s) it requires.

SwiftAutomation packs `URL` instances containing `file://` URLs as descriptors of `typeFileURL`, which the majority of applications should accept. Non-file URLs are not supported and will result in a `PackError` being thrown. Occasionally, an older Carbon application may not accept file URL descriptor, in which case it may be necessary to convert the `URL` to a different form before passing it to the application command. For example, if an application _requires_ an alias descriptor, then pre-pack the `URL` as a `typeAlias` descriptor as follows:

let myFile = URL(fileURLWithPath: "/Users/jsmith/MyFile.txt")

let myFileDesc = NSAppleEventDescriptor(fileURL: myFile).coerce(toDescriptorType:typeAlias)

Similarly, some older Carbon applications may occasionally use colon-delimited HFS path strings even though macOS has long since deprecated these in favor of standard POSIX paths. SwiftAutomation includes the following compatibility functions for converting to and from HFS path strings where unavoidable:

    HFSPath(fromFileURL: URL) -> String
    fileURL(fromHFSPath: String) -> URL

For example:

    let myFile = URL(fileURLWithPath: "/Users/jsmith/MyFile.txt")
    
    let myHFSPath = HFSPath(fromFileURL: myFile)
    // "Macintosh HD:Users/jsmith/MyFile.txt"

However, be aware that non-existent paths may not convert correctly, and that HFS paths, unlike POSIX paths, cannot distinguish between two mounted volumes which both have the same name (one of the reasons HFS was deprecated).


### Records

The `typeAERecord` AE type is a struct-like data structure containing zero or more properties. SwiftAutomation represents AE records as `Dictionary<Symbol,Any>` instances. The keys in this dictionary are normally instances of `Symbol` or glue-defined subclass representing SwiftAutomation-style property names, e.g. `TEDSymbol.text`. Dictionary keys may also be `Symbol` instances created with raw four-char codes (if no equivalent human-readable terminology exists), e.g. `Symbol(code: "docu")` or `String` instances representing "user-defined" keys (an AppleScript-ism, rarely used by applications).

If a dictionary includes a `Symbol.class_` (or `Symbol(code:"pcls")`) key whose value is also a `Symbol`, SwiftAutomation will pack the other items into an AE record coerced to that value's' type. [TO DO: add example for clarity] Similarly, when unpacking an record-based descriptor that isn't `typeAERecord`, `typeObjectSpecifier` or other known type, SwiftAutomation will unpack it as an `Dictionary` instance with an additional `Symbol.class_` key and `Symbol` value to indicate the descriptor's type.

AERecords can also be packed/unpacked to/from glue-defined record structs; see the discussion of the `aeglue` tool's `-s` option in Chapter 4.


### Types and enumerators

SwiftAutomation represents both standard Apple event type names and application-defined class, property, and enumerator names as instances of the glue's `Symbol` subclass. For example, a standard TextEdit glue defines a `TEDSymbol` subclass, typealiased as `TED` for convenience:

  // Standard Apple event data types
  TED.boolean
  TED.unicodeText
  TED.list
  ...

  // Application-defined class names
  TED.document
  TED.window
  TED.disk
  ...

  // Application-defined property names
  TED.class_
  TED.name
  TED.color
  ...

  // Application-defined enumerators
  TED.yes
  TED.no
  TED.ask
  ...

Descriptors of `typeType`, `typeEnumerated`, and `typeProperty` are unpacked as `Symbol` subclass instances, using raw four-char codes instead of names when the corresponding terminology is not available, e.g.:

  TEDSymbol(code:"abcd")


### Other types

The Apple Event Manager defines many other AE types whose names and codes are defined by SwiftAutomation for completeness. A few of these types are of occasional interest to users, the rest can simply be ignored. In most cases, values of these types will be represented by `NSAppleEventDescriptor` instances as SwiftAutomation doesn't automatically convert them.



