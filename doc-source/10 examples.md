# Examples

// TO DO: include corresponding aeglue commands as comments

## Application objects

  // application id "com.apple.Finder"
  let finder = Finder() // (use the glue's default bundle ID)

  // application "Adobe InDesign CS6"
  let indesign = AdobeInDesign(name: "Adobe InDesign CS6")

  // application "Macintosh HD:Applications:TextEdit.app:"
  let textedit = TextEdit(name: "/Applications/TextEdit.app")

  // application "iTunes" of machine "eppc://jsmith@media-mac.local"
  let itunes = ITunes(url: URL(string: "eppc://jsmith@media-mac.local/iTunes"))

  // application id "com.apple.Stickies" // a non-scriptable application
  let stickies = AEApplication(bundleIdentifier: "com.apple.Stickies")

## Property references

  // a reference to startup disk of application "Finder"
  finder.startupDisk

  // a reference to name of folder 1 of home of application "Finder"
  finder.home.folders[1].name

  // a reference to name of every item of home of application "Finder"
  finder.home.items.name

  // a reference to text of every document of application "TextEdit"
  textedit.documents.text

  // a reference to color of character 1 of every paragraph of text ¬
  //     of document 1 of application "TextEdit"
  textedit.documents[1].text.paragraphs.characters[1].color


## All elements references

  // a reference to disks of application "Finder"
  finder.disks

  // a reference to every word of every paragraph ¬
  //     of text of every document of application "TextEdit"
  textedit.documents.text.paragraphs.words


## Single element references

  // a reference to disk 1 of application "Finder"
  finder.disks[1]

  // a reference to file "ReadMe.txt" of folder "Documents" of home of application "Finder"
  finder.home.folders["Documents"].files["ReadMe.txt"]

  // a reference to paragraph -1 of text of document 1 of application "TextEdit"
  textedit.documents[1].text.paragraphs[-1]

  // a reference to middle paragraph of text of last document of application "TextEdit"
  textedit.documents.last.text.paragraphs.middle

  // a reference to any file of home of application "Finder"
  finder.home.files.any


## Relative references

  // a reference to paragraph before paragraph 6 of text of document 1 of application "TextEdit"
  textedit.documents[1].text.paragraphs[6].previous(TED.paragraph)

  // a reference to paragraph after character 30 of document 1 of application "Tex-Edit Plus"
  texeditplus.documents[1].characters[30].next(TEP.paragraph)


## Element range references

  // a reference to words 1 thru 4 of text of document 1 of application "TextEdit"
  textedit.documents[1].text.words[1, 4]


  // a reference to paragraphs 2 thru -1 of text of document 1 of application "TextEdit"
  textedit.documents[1].text.paragraphs[2, -1]

  // a reference to folders "Documents" thru "Music" of home of application "Finder"
  finder.home.folders["Documents", "Music"]

  // a reference to text (word 3) thru (paragraph 7) of document 1 of application "Tex-Edit Plus"
  texeditplus.documents[1].text[TEPCon.words[3], TEPCon.paragraphs[7]]


## Test references

  // a reference to every document of application "TextEdit" whose text is "\n"
  textedit.documents[TEDIts.text == "\n"]

  // a reference to every paragraph of document 1 of application "Tex-Edit Plus" ¬
  //      whose first character is last character
  texeditplus.documents[1].paragraphs[TEPIts.characters.first == TEPIts.characters.last]

  // a reference to every file of folder "Documents" of home of application "Finder" ¬
  //      whose name extension is "txt" and size < 10240
  finder.home.folders["Documents"].files[FINIts.nameExtension == "txt" && FINIts.size < 10240]


## Insertion location references

  // a reference to end of documents of application "TextEdit"
  textedit.documents.end

  // a reference to before paragraph 1 of text of document 1 of application "TextEdit"
  textedit.documents[1].text.paragraphs[1].before


## `open` command

Open a document in TextEdit:

  // tell application "TextEdit" to open (POSIX file "/Users/jsmith/ReadMe.txt")
  try textedit.open(URL(fileURLWithPath: "/Users/jsmith/ReadMe.txt"))
  // TextEdit().documents["ReadMe.txt"]


## `get` command
Get the name of every folder in the user's home folder:

  // tell application "Finder" to get name of every folder of home
  try finder.get(FINApp.home.folders.name)

Or, more concisely:

  try finder.home.folders.name.get()

Remember to declare the command's return type if you intend to use the returned value:

  let folderNames = try finder.home.folders.name.get() as [String]
  print(folderNames.joined(separator: ", "))
  // "Desktop, Documents, Downloads, Movies, ..."


## `set` command

Set the content of a TextEdit document:

  // tell application "TextEdit" to set text of document 1 to "Hello World"
  try textedit.documents[1].text.set(to: "Hello World")


## `count` command

Count the words in a TextEdit document:

  // tell application "TextEdit" to count words of document 1
  try textedit.documents[1].words.count() as Int
  // 42

Count the items in the current user's home folder:

  // tell application "Finder" to count items of home
  try finder.home.count(each: FIN.item) as Int
  // 11

(Note that Finder and many other Carbon applications require the `count` command's `each` parameter to be given. Cocoa-based apps should accept either form.)


## `make` command

Create a new TextEdit document:

  // tell application "TextEdit" to make new document ¬
  //     with properties {text:"Hello World\n"}
  try textedit.make(new: TED.document, 
         withProperties: [TED.text: "Hello World\n"]) as TEDItem
  // TextEdit().documents["Untitled"]

Append text to a TextEdit document:

  // tell application "TextEdit" to make new paragraph ¬
  //     at end of text of document 1 ¬
  //     with properties {text:"Yesterday\nToday\nTomorrow\n"}
  try textedit.make(new: TED.paragraph, 
                     at: TEDApp.documents[1].text.end,
               withData: "Yesterday\nToday\nTomorrow\n")


## `duplicate` command

Duplicate a folder to a disk, replacing an existing item if one exists:

  // tell application "Finder"
  //   duplicate folder "Projects" of home to disk "Work" with replacing
  // end tell
  try finder.home.folders["Projects"].duplicate(to: FINApp.disks["Backup"], replacing: true)
  // Finder().disks["Backup"].folders["Projects"]


## `add` command

Add every person with a known birthday to a group named "Birthdays": 

  // tell application "Contacts"
  //   add every person whose birth date is not missing value to group "Birthdays"
  // end tell
  try contacts.people[CONIts.birthDate != MissingValue].add(to: CONApp.groups["Birthdays"])


## `quit` command

Close every TextEdit document without saving:

  // tell application "TextEdit" to quit saving no
  try textedit.quit(saving: TED.no)

Quit the Stickies app if it's currently running:

  let stickies = AEApplication(bundleIdentifier: "com.apple.Stickies") // default glue
  if stickies.isRunning { try? stickies.quit() }




