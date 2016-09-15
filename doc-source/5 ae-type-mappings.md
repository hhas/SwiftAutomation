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
<tr><td><code>date</code></td><td><code>typeLongDateTime</code></td><td><code>date</code></td><td><code>NSDate</code></td></tr>
<tr><td><code>«class bmrk»</code></td><td><code>typeBookmarkData</code></td><td><code>bookmarkData</code></td><td><code>NSURL</code> [2]</td></tr>
<tr><td><code>alias</code></td><td><code>typeAlias</code></td><td><code>alias</code></td><td><code>NSURL</code> [2]</td></tr>
<tr><td><code>«class furl»</code></td><td><code>typeFileURL</code></td><td><code>fileURL</code></td><td><code>NSURL</code> [2]</td></tr>
<tr><td><code>reference</code></td><td><code>typeObjectSpecifier</code></td><td><code>reference</code></td><td><code><var>PREFIX</var>Item</code>/<var>PREFIX</var>Items</code> [3]</td></tr>
<tr><td><code>location reference</code></td><td><code>typeInsertionLoc</code></td><td><code>locationReference</code></td><td><code><var>PREFIX</var>Insertion</code></code> [3]</td></tr>
<tr><td><code>class</code></td><td><code>typeType</code></td><td><code>typeClass</code></td><td><code><var>PREFIX</var>Symbol</code> [3]</td></tr>
<tr><td><code>constant</code></td><td><code>typeEnumerated</code></td><td><code>enumerator</code></td><td><var>PREFIX</var>Symbol</code> [3]</td></tr>
<tr><td><code>property</code></td><td><code>typeProperty</code></td><td><code>property</code></td><td><var>PREFIX</var>Symbol</code> [3]</td></tr>
</tbody>
</table>

[1] While AppleScript now treats `string`, `text`, and `Unicode text` keywords as synonyms for `typeUnicodeText`, the Apple Event Manager still  considers them to be different types (`typeChar`, `cText`, `typeUnicodeText`). When specifying a command's `as` parameter, always use `AE.unicodeText`, which is the standard (UTF16) representation used for Unicode text.

[2] Bookmark, alias, and file URL descriptors are actually unpacked as `AEURL`, which extends the standard `NSURL` class to provide better round-tripping of data. [TO DO: not currently implemented; need to decide how best to do this]

[3] Glue files define their own application-specific `Specifier` and `Symbol` subclasses.


## Mapping notes

While AE-Swift type conversions generally work quite seamlessly, it is sometimes useful to know some of the details involved, particularly when troubleshooting code that deals with older or buggy applications. The following sections provide additional information.

[TO DO: type mapping implementations are yet to be finalized; update the following sections when done]


### Boolean

SwiftAutomation maps `typeBoolean` descriptors to and from `NSNumber`, based on the assumption that the `NSNumber` class cluster internally represents Boolean values as bridged `CFBoolean` (`__NSCFBoolean`) instances.

(SwiftAutomation can also unpack descriptors of `typeTrue` and `typeFalse`, although these are not normally returned by applications.)


### Numbers

While the Apple Event Manager defines a range of numerical descriptor types with different bit-widths and formats, most applications normally use `typeSInt32` (`int`) and `typeIEEE64BitFloatingPoint` (`double`) only.

When packing a signed integer, SwiftAutomation will pack it either as a 32-bit signed integer (most preferred), 64-bit signed integer, or 64-bit float (least preferred), depending on the value's size. When packing a 32-bit unsigned integer, SwiftAutomation will pack it as a 32-bit signed integer if possible.


### Strings

When packing and unpacking `String` values, SwiftAutomation uses the `NSAppleEventDescriptor` class's `+descriptorWithString:` and `-stringValue` methods, both of which use descriptors of `typeUnicodeText`, coercing other types as needed.

Note that while the CoreServices framework's `AEDataModel.h` header states that `typeUnicodeText` is deprecated in favor `typeUTF8Text` and `typeUTF16ExternalRepresentation`, it remains in widespread use; therefore SwiftAutomation continues to use `typeUnicodeText` to ensure the broadest compatibility with existing scriptable applications.

Some older applications may return text values as descriptors of `typeChar`, `typeIntlText`, or `typeStyledText`. These types are long-deprecated and their use strongly discouraged in macOS. SwiftAutomation will coerce these descriptors to `typeUnicodeText` before unpacking them, or throw an `UnpackError` if the coercion fails.


### File system references

// TO DO: SwiftAutomation currently uses Swift's URL struct, which doesn't provide the extra descriptor caching or explicit coercion methods (it also currently doesn't distinguish between path-style URLs and bookmark-style URLs, and treats everything as typeFileURL, which might cause problems on any older, poorly designed Carbon apps that explicitly typecheck their params as typeAlias instead of coercing them to that type as they're supposed to)

The Apple Event Manager defines a number of modern (`typeFileURL`, `typeBookmarkData`), legacy (`typeAlias`), and deprecated (`typeFSRef`, `typeFSS`) descriptor types for identifying file system objects. Object specifiers of form `{want:file,from:null,form:name,seld:"HFS:PATH:STRING"}` (an AppleScript-ism) are also recognized by most applications. Fortunately, the Apple Event Manager also implements a number of coercion handlers for coercing between these types, so when interacting with most applications you should not need to know or care exactly which of these types are used: the application should coerce supplied values to whichever type(s) it requires.

SwiftAutomation always packs `NSURL` instances containing `file://` URLs as descriptors of `typeFileURL`, which the majority of applications should accept.

SwiftAutomation unpacks all file system descriptors as `AEURL` instances. SwiftAutomation defines `AEURL` as  a subclass of `NSURL`, so `AEURL` instances should be accepted by any Cocoa API that uses `NSURL`. Unlike `NSURL`, however, an `AEURL` instance retains the original Apple event descriptor from which it was created, allowing descriptors to be fully round-tripped. For example, if an application comman returns a `typeAlias` descriptor, then the resulting `AEURL` will re-pack as the same `typeAlias` descriptor when used in another command.

While macOS has deprecated HFS path strings in favor of POSIX, some older Carbon applications may still occasionally require these. `AEURL` provides the following compatibility methods for converting to and from HFS path strings:

  init(HFSPath: String)
  var HFSPath {get}

`AEURL` also defines the following method in case the underlying descriptor needs to be coerced to a specific AE type:

  - (instancetype)coerceToDescriptorType:(DescType)descType;

The `descType` argument should be one of the following: `typeAlias`, `typeFileURL`, `typeObjectSpecifier`, or `typeBookmarkData`. (`typeFSRef` or `typeFSS` may also be used, but as these are deprecated/not fully supported they are not guaranteed to work correctly).

For example, if an application requires a `typeAlias` descriptor but doesn't coerce the given value itself:

  let url = AEMURL(path:"/path/to...").coerce(toDescriptorType:typeAlias)

Be aware when specifying a command's required/result type, you must specify the exact AE type (`AEMSymbol.alias`/`typeAlias`, `AEMSymbol.fileURL`/`typeFileURL`, etc). For example, the Finder normally returns file system references as object specifiers:

  let finder = Finder()
  let objSpec = finder.home.get()
  // Finder().startupDisk.folders["Users"].folders["Users"]

 To get the current user's home folder as an `NSURL` instead:

  let url = finder.home.get(as: AESymbol.fileURL)
  // NSURL(string:"///Users/jsmith")


### Records

The `typeAERecord` AE type is a struct-like data structure containing zero or more properties. SwiftAutomation represents AE records as `Dictionary` instances. The keys in this dictionary are normally instances of `Symbol` or glue-defined subclass representing SwiftAutomation-style property names, e.g. `TEDSymbol.text`. Dictionary keys may also be `Symbol` instances created with raw four-char codes (if no equivalent human-readable terminology exists), e.g. `Symbol(code: "docu")` or `String` instances representing "user-defined" keys (an AppleScript-ism, rarely used by applications).

If a dictionary includes a `Symbol.class_` (or `Symbol(code:"pcls")`) key containing a `Symbol` value, SwiftAutomation will pack the other items into an AE record coerced to that value's' type. Similarly, when unpacking an record-based descriptor that isn't `typeAERecord`, `typeObjectSpecifier` or other known type, SwiftAutomation will unpack it as an `Dictionary` instance with an additional `Symbol.class_` key and `Symbol` value to indicate the descriptor's type.


### Types and enumerators

For your convenience, SwiftAutomation represents Apple event type names and application-specific class and enumerator names as instances of the glue's `Symbol` subclass. For example, a standard TextEdit glue defines a `TEDSymbol` subclass, along with a `TED` typealias as a convenient shorthand. Examples:

  // AEM-defined data types
  TED.boolean // a.k.a. TEDSymbol.boolean
  TED.unicodeText
  TED.list

  // Application-defined class names
  TED.document
  TED.window
  TED.disk

  // Application-defined enumerators
  TED.yes
  TED.no
  TED.ask

Descriptors of `typeType`, `typeEnumerated`, and `typeProperty` are unpacked as `AESymbol` subclass instances, using raw four-char codes instead of names when the corresponding terminology is not available, e.g.:

  Symbol(code:"abcd")


### Other types

The Apple Event Manager defines many other AE types whose names and codes are defined by SwiftAutomation for completeness. A few of these types are of occasional interest to users, the rest can simply be ignored. In most cases, values of these types will be represented by `NSAppleEventDescriptor` instances as SwiftAutomation doesn't automatically convert them.



