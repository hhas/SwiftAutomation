# Object specifiers

## How object specifiers work

As explained in chapter 3, a property contains either a simple value describing an object attribute (`name`, `class`, `creationDate`, etc.) or an object specifier representing a one-to-one relationship between objects (e.g. `home`, `currentTrack`), while elements represent a one-to-many relationship between objects (`documents`, `folders`, `fileTracks`, etc). [TO DO: document class hierarchy as used in glues; note that PREFIXItem identifies a single property or element while PREFIXItems identifies zero or more elements, and summarize the selectors]

[TO DO: note that all properties and elements appear as read-only properties on glue-defined ObjectSpecifier and RootSpecifier subclasses; users don't instantiate Specifier classes directly but instead construct via chained property/method calls from glue's Application class or untargeted `RootSpecifier` constants (<var>PREFIX</var>App, <var>PREFIX</var>Con, <var>PREFIX</var>Its)]

characters/words/paragraphs of documents by index/relative-position/range/filter
 
 [TO DO: list of supported reference forms, with links to sections below]
 
[TO DO: following sections should include AppleScript syntax equivalents for reference]

## Reference forms

### Property

<pre><code>var PROPERTY: <var>PREFIX</var>Item</code> {get}</pre>

Examples:

<pre><code>textedit.<strong>version</strong>
textedit.documents[1].<strong>text</strong>
finder.<strong>home</strong>.files.<strong>name</strong></code></pre>

Syntax:

<pre><code>specifier<strong>.</strong><var>property</var></code></pre>

### All elements

<pre><code>var ELEMENTS: <var>PREFIX</var>Items {get}</code></pre>

Examples:

<pre><code>finder.home.<strong>folders</strong>
textedit.<strong>documents</strong>
textedit.<strong>documents</strong>.<strong>paragraphs</strong>.<strong>words</strong></code></pre>

Syntax:

<pre><code>specifier<strong>.</strong><var>elements</var></code></pre>


### Element by index

<pre><code>subscript(index: Any) -> <var>PREFIX</var>Item</code></pre>

Examples:

<pre><code>textedit.<strong>documents[1]</strong>
finder.home.<strong>folders[-2]</strong>.<strong>files[1]</strong></code></pre>

Syntax:

<pre><code>elements<strong>[<var>selector</var>]</strong>

    <var>selector</var> : Int | Any -- the object's index (1-indexed), or other identifying value [1]</code></pre>

[1] While element indexes are normally integers, some applications may also accept other types (e.g. Finder's file/folder/disk specifiers also accept alias values). The only exceptions are `String` and <code><var>PREFIX</var>Specifier</code>, which are used to construct by-name and by-test specifiers respectively.

<p class="hilitebox">Be aware that index-based object specifiers always use <em>one-indexing</em> (i.e. the first item is 1, the second is 2, etc.), not zero-indexing as in Swift (where the first item is 0, the second is 1, etc.).</p>


### Element by name

<pre><code>subscript(index: String) -> <var>PREFIX</var>Item
func named(_ name: Any) -> <var>PREFIX</var>Item</code></pre>

Examples:

<pre><code>textedit.<strong>documents["Untitled"]</strong>
finder.home.<strong>folders["Documents"]</strong>.<strong>files["ReadMe.txt"]</strong></code></pre>

Specifies the first element with the given name. (The subscript syntax is preferred; the `named` method would only need used if a non-string value was required.)

Syntax:

<pre><code>elements<strong>[<var>selector</var>]</strong>
        <var>selector</var> : String -- the object's name (as defined in its 'name' property)</code></pre>

<p class="hilitebox">Applications usually treat object names as case-insensitive. Where multiple element have the same name, a by-name specifier only identifies the first element found with that name. (To identify <em>all</em> elements with a particular name, use a by-test specifier instead.)</p>

[TO DO: update once a final decision is made on whether or not to include `named()` method]


### Element by ID

<pre><code>func ID(_ elementID: Any) -> <var>PREFIX</var>Item</code></pre>

Examples:

<pre><code>textedit.<strong>windows.ID(4321)</strong></code></pre>

Syntax:

<pre><code>elements<strong>.ID(<var>selector</var>)</strong>
        <var>selector</var> : Any -- the object's id (as defined in its 'id' property)</code></pre>

### Element by absolute position

<pre><code>var first: <var>PREFIX</var>Item {get}
var middle: <var>PREFIX</var>Item {get}
var last: <var>PREFIX</var>Item {get}
var any: <var>PREFIX</var>Item {get}</code></pre>

Examples:

<pre><code>textedit.<strong>documents.first</strong>.text.<strong>paragraphs.last</strong>
finder.desktop.<strong>files.any</strong></code></pre>

Syntax:

<pre><code>elements<strong>.first</strong> -- first element
elements<strong>.middle</strong> -- middle element
elements<strong>.last</strong> -- last element
elements<strong>.any</strong> -- random element</code></pre>


### Element by relative position

<pre><code>func previous(_ elementClass: Symbol? = nil) -> <var>PREFIX</var>Item
func next(_ elementClass: Symbol? = nil) -> <var>PREFIX</var>Item</code></pre>

Examples:

<pre><code>textedit.documents[1].characters[3].<strong>next()</strong>
textedit.documents[1].paragraphs[-1].<strong>previous(TED.word)</strong></code></pre>

Syntax:

<pre><code>// nearest element of a given class to appear before the specified element:
element.<strong>previous(<var>elementClass</var>)</strong>

// nearest element of a given class to appear after the specified element
element.<strong>next(<var>elementClass</var>)</strong>

        <var>elementClass</var> : Symbol -- the name of the previous/next element's class;
                                 if omitted, the current element's class is used</code></pre>

### Elements by range

<pre><code>subscript(from: Any, to: Any) -> <var>PREFIX</var>Items</code></pre>

Examples:

<pre><code>textedit.<strong>documents[1, 3]</strong>
finder.home.<strong>folders["Documents", "Movies"]</strong>
texeditplus.documents[1].<strong>text[TEPCon.characters[5], TEPCon.words[-2]]</strong></code></pre>

Caution:

By-range specifiers must be constructed as <code>elements[<var>start</var>,<var>end</var>]</code>, <em>not</em> <code>elements[<var>start</var>...<var>end</var>]</code>, as <code>Range&lt;T&gt;</code> types are not supported. 

Syntax:

<pre><code>elements<strong>[<var>start</var>, <var>end</var>]</strong>
        <var>start</var> : Int | String | <var>PREFIX</var>Item -- start of range
        <var>end</var> : Int | String | <var>PREFIX</var>Item -- end of range</code></pre>

Range references select all elements between and including two object specifiers indicating the start and end of the range. The start and end specifiers are normally declared relative to the container of the elements being selected. 

These sub-specifiers are constructed using the glue's <code><var>PREFIX</var>Con</code> constant, e.g. `TEDCon`, as their root. For example, to indicate the third paragraph relative to the currrent container object:

  TEDCon.paragraphs[3]

Thus, to specify all paragraphs from paragraph 3 to paragraph -1:

  paragraphs[TEDCon.paragraphs[3], TEDCon.paragraphs[-1]]

For convenience, sub-specifiers can be written in shorthand form where their element class is the same as the elements being selected; thus the above can be written more concisely as:

  paragraphs[3, -1]

Some applications can handle more complex range references. For example, the following will work in Tex-Edit Plus:

  words[TEPCon.characters[5], TEPCon.paragraphs[-2]]


### Elements by test

<pre><code>subscript(test: TestClause) -> <var>PREFIX</var>Items</code></pre>

Examples:

<pre><code>textedit.<strong>documents[TEDIts.path == MissingValue]</strong>

finder.desktop.<strong>files[FINIts.nameExtension.isIn(["txt", "rtf"]) 
                     && FINIts.modificationDate > (Date()-60*60*24*7)]</strong></code></pre>

Syntax:

A specifier to each element that satisfies one or more conditions specified by a test specifier:

<pre><code>elements<strong>[<var>selector</var>]</strong>
        <var>selector</bar> : <var>PREFIX</var>Specifier -- test specifier</code></pre>

Test expressions consist of the following:

* A test specifier relative to each element being tested. This specifier must be constructed using the glue's '<var>PREFIX</var>Its' root, e.g. `TEDIts`. Its-based references support all valid reference forms, allowing you to construct references to its properties and elements. For example:
    
  TEDIts
  TEDIts.size
  TEDIts.words.first

* One or more conditional/containment tests, implemented as operators/methods on the specifier being tested. The left-hand operand/receiver must be a <code><var>PREFIX</var>Specifier</code> instance. The right-hand operand/argument can be any value; its type is always `Any`.

  Syntax:

  <pre><code>specifier <strong>&lt;</strong> <var>value</var>
specifier <strong>&lt;=</strong> <var>value</var>
specifier <strong>==</strong> <var>value</var>
specifier <strong>!=</strong> <var>value</var>
specifier <strong>&gt;</strong> <var>value</var>
specifier <strong>&gt;=</strong> <var>value</var>
specifier.<strong>beginsWith(</strong><var>value</var><strong>)</strong>
specifier.<strong>endsWith(</strong><var>value</var><strong>)</strong>
specifier.<strong>contains(</strong><var>value</var><strong>)</strong>
specifier.<strong>isIn(</strong><var>value</var><strong>)</strong></code></pre>

  Examples:

    TEDIts == ""
    FINits.size > 1024
    TEDIts.words.first.beginsWith("A")
    TEDIts.characters.first == TEDIts.characters.last

  Caution: if assigning a test specifier to a variable, the variable must be explicitly typed to ensure the compiler uses the correct operator overload, e.g.: [TO DO: this sort of thing should be discouraged in practice; at most, it should be a footnote re. `==` overloading quirk]
  
    let test: TEDSpecifier = TEDIts.color == [0,0,0]
    let query = textedit.documents[1].words[test]

* Zero or more logical tests, implemented as properties/methods on conditional tests. All operands must be conditional/containment and/or logic test specifiers.

  Syntax:

  <pre><code><var>test</var> <strong>&amp;&amp;</strong> <var>test</var>
<var>test</var> <strong>||</strong> <var>test</var>
<strong>!</strong><var>test</var></code></pre>

  Examples:

    !(TEDIts.contains("?"))

    FINIts.size > 1024 && FINIts.size < 10240

    TEDIts.words[1].beginsWith("A") || TEDIts.words[1].contains("ce") || TEDIts.words[2] == "foo"


### Element insertion location

Insertion locations can be specified at the beginning or end of all elements, or before or after a specified element or element range.

<pre><code>var beginning: <var>PREFIX</var>Specifier
var end: <var>PREFIX</var>Specifier
var before: <var>PREFIX</var>Specifier
var after: <var>PREFIX</var>Specifier</code></pre>

Examples:

<pre><code>textedit.documents.<strong>end</strong>
textdit.documents[1].paragraphs[-1].<strong>before</strong></code></pre>

Syntax:

<pre><code>elements<strong>.beginning</strong>
elements<strong>.end</strong>
element<strong>.before</strong>
element<strong>.after</strong></code></pre>

