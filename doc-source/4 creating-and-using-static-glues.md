# Creating and using static glues

## Generating a glue

The SwiftAE framework bundle includes an `aeglue` tool for generating static glue files containing high-level terminology-based APIs.

To put `aeglue` on your Bash shell's search path, add the following line to your `~/.bash_profile` (modify the path to `SwiftAE.framework` as needed):

    export $PATH="$PATH:/Library/Frameworks/SwiftAE.framework/Resources/bin"

To view the `aeglue` tool's full documentation:

    aeglue -h

The following example generates a glue for the TextEdit application, using an auto-generated class name prefix (in this case `TED`), creating a new `TextEditGlue.swift` file in your current working directory:

    aeglue TextEdit

while the following command uses a custom class name prefix, `TE`, and creates the new `TextEditGlue.swift` file in your home directory's "Documents" folder:

    aeglue -p TE TextEdit ~/Documents

The `aeglue` tool also creates an `.sdef` file containing the application's dictionary (interface documentation) in Swift format. For example, to view the `TextEditGlue.swift` terminology in Script Editor: 

    open -a 'Script Editor' ~/Documents/TEGlue/TextEditGlue.swift.sdef

Refer to this documentation when using SwiftAE glues in your own code, as it shows element, property, command, etc. names as they appear in the generated glue classes. (Make sure Script Editor's dictionary viewer is set to "AppleScript" language; other formats are for use with OS X's Scripting Bridge/JavaScript for Automation bridges only.)

If an identically named folder already exists at the same location, `aeglue` will normally fail with a "path already exists" error. If you wish to force it to overwrite the existing folder without warning, add an `-r` option:

    aeglue -r TextEdit

For compatibility, `aeglue` normally sends the application an `ascr/gdte` event to retrieve its terminology in AETE format. However, some Carbon-based applications (e.g. Finder) may have buggy `ascr/gdte` event handlers that return Cocoa Scripting's default terminology instead of the application's own. To work around this, add an `-s` option to retrieve the terminology in SDEF format instead:

    aeglue -s Finder

(Be aware that OS X's AETE-to-SDEF converter is not 100% reliable; for example, some four-char codes may fail to translate, in which case `aeglue` will warn of their omission. You'll have to correct the glue files manually should you need to use the affected features, or use SwiftAE's' `OSType`-based APIs instead.)


## Using a glue

To include the generated glue file in your project:

1. Right-click on the Classes group in the left-hand Groups &amp; Files pane of the Xcode project window, and select Add &gt; Existing Files... from the contextual menu.

2. Select the generated glue file (e.g. `TextEditGlue.swift`) and click Add.

3. In the following sheet, check the "Copy items into destination group's folder" and "Recursively create groups for any added folders" options, and click Add.

Each glue contains the following classes:

* `<var>PREFIX</var>Symbol` -- represents Apple event type, enumerator, and property names, e.g. `TEDSymbol`

* `<var>PREFIX</var>Insertion`, `<var>PREFIX</var>Object`, `<var>PREFIX</var>Elements`, `<var>PREFIX</var>Root` -- represents the various forms of Apple Event Object Model queries (a.k.a. object specifiers), e.g. `TEDObject`

* `<var>APPNAME</var>` -- represents an application to which you can send commands, e.g. `TextEdit`


Each glue also provides three predefined constants - `<var>PREFIX</var>App`, `<var>PREFIX</var>Con` and `<var>PREFIX</var>Its` - for use in constructing object specifiers.


<p class="hilitebox">Note that subsequent code examples in this manual assume the presence of suitable glues; e.g. TextEdit-based examples assume a TextEdit glue with the prefix `TED`, Finder-based examples assume a Finder glue with the prefix `FIN`, etc.</p>



## How keywords are converted

[TO DO: review this once terminology parser is ported]

Because scriptable applications' terminology resources supply class, property, command, etc. names in AppleScript keyword format, `aeglue` must convert these terms to valid Swift identifiers when generating the glue files and accompanying `.sdef` documentation file. For reference, here are the conversion rules used:

* Characters a-z, A-Z, 0-9 and underscores (_) are preserved.

* Spaces, hyphens (-) and forward slashes (/) are removed, and the first character of all but the first word is capitalised, e.g. `document file` is converted to `documentFile`.

* Ampersands (&amp;) are replaced by the word 'And'.

* All other characters are converted to 0x00-style hexadecimal representations.

* Names that begin with '_' have an underscore appended.

* Names that match Swift keywords or properties/methods already defined on SwiftAE classes have an underscore appended.

* SwiftAE provides default terminology for standard type classes such as `integer` and `unicodeText`, and standard commands such as `open` and `quit`. If an application-defined name matches a built-in name but has a different Apple event code, SwiftAE will append an underscore to the application-defined name.

