# Creating and using static glues

The SwiftAutomation framework includes a command line `aeglue` tool for generating static glue files. Glues enable you to control "AppleScriptable" applications using human-readable property and method names derived from their built-in terminology resources.


## Generating a glue

For convenience, add the following shortcut to your `~/.bash_profile`:

  alias aeglue=/Library/Frameworks/SwiftAutomation.framework/Resources/bin/aeglue

To view the `aeglue` tool's full documentation:

  aeglue -h

Glue files follow a standard <code><var>NAME</var>Glue.swift</code> naming convention, where <var>NAME</var> is the name of the glue's `Application` class. The following command generates a `TextEditGlue.swift` glue file in your current working directory:

  aeglue TextEdit

If an identically named file already exists at the same location, `aeglue` will normally fail with a "path already exists" error. To overwrite the existing file with no warning, add an `-r` option:

  aeglue -r TextEdit

To write the file to a different directory, use the `-o` option. For example, to create a new `iTunesGlue.swift` file on your desktop:

  aeglue -o ~/Desktop TextEdit


## Getting application documentation

In addition to generating the glue file, the `aeglue` tool also creates a <code><var>NAME</var>Glue.swift.sdef</code> file containing the application dictionary (interface documentation), reformatted for use with SwiftAutomation. For example, to view the `TextEditGlue.swift` terminology in Script Editor: 

  open -a 'Script Editor' TextEditGlue.swift.sdef

Refer to this documentation when using SwiftAutomation glues in your own code, as it shows element, property, command, etc. names as they appear in the generated glue classes. (Make sure Script Editor's dictionary viewer is set to the "AppleScript" language option for it to display correctly.) 

Be aware that only 'keyword' definitions are displayed in Swift syntax; 'type' names are unchanged from their AppleScript representation, as are AppleScript terms and sample code that appear in descriptions. SDEF-based documentation is always written for AppleScript users, so unless the application developer provides external documentation for other programming languages some manual translation is required. Furthermore, most applications' SDEF documentation is far from exhaustive, and frequently lacks both detail and accuracy; for instance, the SDEF format doesn't descript  precisely what types and combinations of parameters are/aren't accepted by each command, while the documented 'types' of properties, parameters, and return values may be incomplete or wrong. Supplementary documentation, example code, AppleScript user forums, educated guesswork, and trial-and-error experimentation may also be required.

The SwiftAutoEdit application includes a File ➝ New ➝ Command Translator menu option that can also help when the correct AppleScript syntax for a command is already known, and all that is needed is some assistance in constructing its Swift equivalent.


## How glues are structured

Each glue file contains the following classes:

* <code><var>Application</var></code> -- represents the root application object used to send commands, e.g. `TextEdit`

* <code><code><var>PREFIX</var>Item</code>, <code><var>PREFIX</var>Items</code>, <var>PREFIX</var>Insertion</code>, <code><var>PREFIX</var>Root</code> -- represents the various forms of Apple Event Object Model queries, a.k.a. _object specifiers_, e.g. `TEDItem`

* <code><var>PREFIX</var>Symbol</code> -- represents Apple event type, enumerator, and property names, e.g. `TEDSymbol`

`aeglue` automatically disambiguates each glue's class names by adding a three-letter <var>PREFIX</var> derived from the application's name (e.g. `TextEdit` ➝ `TED`). Thus the standard `TextEditGlue.swift` glue defines `TextEdit`, `TEDItem`, `TEDItems`, `TEDInsertion`, `TEDRoot`, and `TEDSymbol` classes, while `FinderGlue.swift` defines `Finder`, `FINItem`, `FINItems`, and so on. (Different prefixes allow multiple glues to be imported into a program without the need to fully qualify all references to those classes with the full glue name, i.e. `TEDItem` is easier to write than `TextEditGlue.Item`.)

Each glue also defines:

* <code><var>PREFIX</var>App</code>, <code><var>PREFIX</var>Con</code> and <code><var>PREFIX</var>Its</code> constants for constructing certain kinds of object specifiers

* a <code><var>PREFIX</var>Record</code> typealias as a convenient shorthand for <code>Dictionary&lt;<var>PREFIX</var>Symbol:Any&gt;</code>, which is the default type to which Apple event records are mapped.

* a <code><var>PREFIX</var></code> typealias as a convenient shorthand for <code><var>PREFIX</var>Symbol</code>.

Glue files may also include custom `typealias`, `enum`, and `struct` definitions that improve integration between Swift and Apple event type systems. [Chapter 10](advanced-type-support.html) explains how to add and use these features.


## Customizing glues

If the default three-letter prefix is unsuitable for use, use the `-p` option to specify a custom prefix. The following command creates a new `TextEditGlue.swift` file that uses the class name prefix `TE`:

  aeglue -p TE TextEdit

For compatibility, `aeglue` normally sends the application an `ascr/gdte` event to retrieve its terminology in AETE format. However, some Carbon-based applications (e.g. Finder) may have buggy `ascr/gdte` event handlers that return Cocoa Scripting's default terminology instead of the application's own. To work around this, add an `-S` option to retrieve the terminology in SDEF format instead:

  aeglue -S Finder

The `-S` option may be quicker when generating glues for CocoaScripting-based apps which already contain SDEF resources. When using the `-S` option to work around buggy `ascr/gdte` event handlers in AETE-based Carbon apps, be aware that macOS's AETE-to-SDEF converter is not 100% reliable. For example, four-char code strings containing non-printing characters fail to appear in the generated SDEF XML, in which case `aeglue` will warn of their omission and you'll have to correct the glue files manually or use SwiftAutomation's lower-level `OSType`-based APIs in order to access the affected objects/commands.


<div class="hilitebox">
<p>Tip: When getting started, a quick way to generate standard glues for all scriptable applications in <code>/Applications</code>, including those in subfolders, is to run the following commands:</p>

<pre><code>mkdir AllGlues && cd AllGlues && aeglue -S /Applications/*.app /Applications/*/*.app</code></pre>

<p><code>aeglue</code> will log error messages for problematic applications (e.g. those without dictionaries or whose dictionaries contain significant flaws). Any glues that are unsatisfactory or require extra customization can then be manually regenerated one at a time with the appropriate options.</p>
</div>


## Using a glue

To include the generated glue file in your project:

1. Right-click in the Project Navigator pane of the Xcode project window, and select Add Files to <var>PROJECT</var>... from the contextual menu.

2. Select the generated glue file (e.g. `TextEditGlue.swift`) and click Add.

3. In the following sheet, check the "Copy items into destination group's folder", and click Add.


<p class="hilitebox">Subsequent code examples in this manual assume a standard glue file has already been generated and imported; e.g. TextEdit-based examples use a TextEdit glue with the prefix <code>TED</code>, Finder-based examples use a Finder glue with the prefix <code>FIN</code>, etc.</p>


## How keywords are converted

Because scriptable applications' terminology resources supply class, property, command, etc. names in AppleScript keyword format, `aeglue` must convert these terms to valid Swift identifiers when generating the glue file and accompanying `.sdef` documentation. For reference, here are the main conversion rules used:

* Characters `a-z`, `A-Z`, `0-9`, and underscores (`_`) are preserved.

* Spaces, hyphens (`-`), and forward slashes (`/`) are removed, and the first character of all but the first word are capitalized, e.g. `document file` ➝ `documentFile`, `Finder window` ➝ `FinderWindow`.

* Any names that match Swift keywords or properties/methods already defined by SwiftAutomation classes have an underscore (`_`) appended to avoid conflict, e.g. `class` ➝ `class_`.


Some rarely encountered corner cases are dealt with by the following conversion rules:

* Ampersands (`&`) are replaced by the word 'And'.

* Any other characters are converted to `_0x00_`-style hexadecimal representations.

* Names that begin with an underscore (`_`) have an underscore appended too.

* SwiftAutomation provides default terminology for standard type classes such as `integer` and `unicodeText`, and standard commands such as `open` and `quit`. If an application-defined name matches a built-in name but has a _different Apple event code_, SwiftAutomation will append an underscore to the application-defined name to avoid conflict.

