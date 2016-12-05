# Improving type system integration

The `aeglue` tool's `-e`, `-s`, and `-t` options can be used to insert custom Swift enums, structs, and typealiases in the generated glue files for improved integration between Swift's strong, static type system and the Apple Event Manager's weak, dynamic types. Each option may appear any number of times and takes a format string as argument.


## Type aliases

For convenience, all glue files define the following typealias as standard as dictionary type to which Apple event records are mapped by default:

<pre><code>typealias <var>PREFIX</var>Record = [<var>PREFIX</var>Record:Any]</code></pre>

The `aeglue`'s `-t` option can be used to add more typealiases to the glue file if needed. For example, to define a typealias for `Array<String>` named `PREFIXStrings`:

  -t 'Strings=Array<String>'

The `-t` option's format string has the following structure:

  'ALIASNAME=TYPE'

The glue's `PREFIX` is added automatically to `ALIASNAME`, and to any reserved type names that appear within `TYPE`. For example, the following command:

  aeglue -t 'Strings=Array<String>' TextEdit

adds the following typealias to a TextEdit glue:

  typealias TEDStrings = Array<String>


## Enumerated types

Unlike the AppleScript language, which has untyped variables to which any type of value can be assigned at any time, Swift requires all variables' types to be known at compile-time (`Int`, `String`, `Optional<Int>`, `Array<String>`, `SomeClass`, etc). This presents a challenge when sending application commands that return more than one type of value; for example:

    let path = try TextEdit().documents[1].path.get() as Any

may return either a `String` (e.g. `"/Users/jsmith/ReadMe.txt"`) or a `MissingValue` constant, depending on whether or not the document has been saved to disk. Furthermore, the Swift compiler won't allow you to manipulate that value until `path` is cast to a specific type (e.g. `String`). The type-safe solution to this problem is to define an enumerated type (a.k.a. tagged union, or sum type) where each case holds a different type of value. For example, SwiftAutomation's built-in `MayBeMissing<T>` enum can hold either a value of type `T` or a `MissingValue` constant, thus:

    let path = try TextEdit().documents[1].path.get() as MayBeMissing<String>

ensures that the command's result is always a `String` value or `MissingValue`, and subsequent code can easily use a `switch` statement to determine which and extract the value for further use.

The `aeglue` tool's `-e` option makes it easy to include enumerations for other combinations of return types within a generated glue file. For example, if an application command you wish to use is known to return either a `Symbol` or a `String` value, add the following `-e` option to the `aeglue` command:

  -e Symbol+String

The -e option must have the following format (square brackets indicate optional information):

  -e '[ENUMNAME=][CASE1:]TYPE1+[CASE1:]TYPE2+...'

`ENUMNAME` is the name to be given to the enumerated type, e.g. `-e MyType=Symbol+String`will create an enum named <code><var>PREFIX</var>MyType</code>. (Do not include the glue's `PREFIX` in `ENUMNAME` as one will be added automatically.)

If `ENUMNAME` is omitted, a default name is automatically generated, e.g. `-e Symbol+String` will create an enum named <code><var>PREFIX</var>SymbolOrString</code>.

`TYPEn` is the name of an existing Swift type, for example, `String` or a standard SwiftAutomation type: `Symbol`, `Object`, `Insertion`, `Item`, or `Items` (the glue `PREFIX` will be added automatically). `MissingValue` may also be used, in which case a `missing` case is added so that the enumeration can also contain a `MissingValue` constant (see the `Missing Value` section in [Chapter 5](type-mappings.html) for details).

`CASEn` is the name of the case to which values of that type are assigned. If `TYPE` is parameterized, a suitable `CASE` name must be given, e.g. `strings:Array<String>`. Otherwise the `CASE` name can be omitted, in which case a default name is automatically generated; e.g. if `TYPE` is `Int` then the default `CASE` name will be `int`.

Thus, the following command:

  aeglue -e 'Color=Symbol+values:Array<Int>' 'System Events.app'

will generate a glue file for System Events containing an `SEVColor` enum that accepts either a symbol (`SEV.blue`, `SEV.gold`, etc) or an integer array representing an RGB color value (e.g. `[0, 65535, 65535]`):

  enum SEVColor {
    case symbol(SEVSymbol)
    case values(Array<Int>)
  }

which can then be used as follows:

  let color = try SystemEvent().appearancePreferences.highlightColor.get() as SEVColor
  switch color {
  case .symbol(let colorName):
    ...
  case .values(let rgbValues):
    ...
  }

The order in which the enumerated types are declared is significant. SwiftAutomation will attempt to coerce an Apple event descriptor to each type in turn, returning a result as soon as it succeeds, or throwing an error if all coercions failed. The Apple Event Manager defines a variety of single- and bi-directional coercions: for instance, all values can coerce to a list (e.g. `3.14` ➝ `[3.14]`), any number can coerce to a string (e.g. `3.14` ➝ `"3.14"`) but only numeric strings may coerce to a number (e.g. `"3.14"` ➝ `3.14`, but `"forty-two"` will fail); while symbol types will coerce to four-char-code strings (e.g. `TED.document` ➝ `"docu"`), but not vice-versa (and either way is probably not what you intended). For best results, order the types from most specific coercion to least, e.g. `Symbol+String`, not `String+Symbol` (which would always return a string).



## Record structs

While SwiftAutomation packs and unpacks Apple event records  as `Dictionary<PREFIXSymbol:Any>` values as standard, it is also possible to map part or all of a specific record structures to a Swift struct, simplifying member access and improving type safety. While it is not practical to generate these record structs automatically due to the incomplete and often inaccurate nature of application AETE/SDEF resources, `aeglue` does allow individual record structs to be manually defined, in whole or in part, using its `-s` option. For example, consider the following TextEdit command:

  try TextEdit.documents[1].properties.get()
  // [TED.class_: TED.document, TED.name: "Untitled", TED.modified: false, TED.path: MissingValue, TED.text: ""]

By default, SwiftAutomation unpacks Apple event records as Swift dictionary values of type <code>Dictionary&lt;<var>PREFIX</var>Symbol,Any&gt;</code>. To map the TextEdit document's properties record to a Swift struct named `TEDDocumentRecord` instead, first add the following `-s` option to the `aeglue` command:

  -s 'Document:document=name:String+modified:Bool+path:MayBeMissing<String>+text:String'

The `-s` option must have the following format:

  -s 'STRUCTNAME[:CLASS]=NAME1:TYPE1+NAME2:TYPE2+...'

`STRUCTNAME` is the name to be given to the record struct, e.g. `Document` ➝ `TEDDocumentRecord` (the <code><var>PREFIX</var></code> prefix and <code>Record</code> suffix are added automatically). `CLASS` is the record's terminology-defined 'class' name as it appears in the glue's SDEF documentation, e.g. `document`; if omitted, `record` is used.

`NAMEn` is the name of a property to appear on the struct, and `TYPEn` is the property's type; e.g. `name:String` describes a property named `name` which holds a value of type `String`. All record properties are declared as `var`, except for the special `class_` property.

The above format string, when applied to a TextEdit dictionary, defines a struct with the following name and properties:

  struct TEDDocumentRecord {
    let class_ = TED.document
    var name: String
    var modified: Bool
    var path: MayBeMissing<String>
    var text: String
  }

To unpack a TextEdit document's properties record as a `TEDDocumentRecord` struct:

  try TextEdit.documents[1].properties.get() as TEDDocumentRecord
  // TEDDocumentRecord(class_:TED.document, name: "Untitled", modified: false, path: MissingValue, text: "")



## MayBeMissing versus Optional


[TO DO: finish this section once a final decision is made on whether or not to keep `MayBeMissing<T>` and the special `.missing(MissingValue)` case in `aeglue`-generated enums.]

[Note that AEM's `missing value` symbol is roughly analogous to Swift's `nil`; however, advantage of `MissingValue` over `nil` is that it's concrete, not generic, so can be used, compared for equality, etc. even when variable's static type is `Any`. OTOH, `Optional` is idiomatic Swift, so will always be the preferred form used in typed code. SwiftAutomation accepts both when used as command parameters; when command's return type is `Any`, `missing value` descriptor is unpacked as `MissingValue`; when return type is `Optional<T>`, it's unpacked as `Optional<T>.none` instead. `MayBeMissing<T>` unpacks it as `MayBeMissing<T>.missing(MissingValue)`; custom enums that include `MissingValue` in their `-e` format string unpack it as ENUMNAME.missing(MissingValue).]
