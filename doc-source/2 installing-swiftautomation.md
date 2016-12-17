# Installing SwiftAutomation

[[ TO DO: include screenshots? ]]


## Get SwiftAutomation

Run the following command in Terminal to clone the [SwiftAutomation repository](https://bitbucket.org/hhas/swiftae) to your Mac:

  git clone https://bitbucket.org/hhas/swiftae.git

Minimum requirements: macOS 10.11 and Xcode 8.1/Swift 3.0.1.


## Installing for Swift "scripting"

Open the SwiftAE project in Xcode. Select the Product ➞ Scheme ➞ Release menu option followed by Product ➞ Build to build the following three products: `SwiftAutomation.framework`, `aeglue` (this is automatically embedded in the framework), and `MacOSGlues.framework`.

To reveal the folder containing the built products, scroll down to "Products" in the Xcode project window's Project Navigator list, right-click the "SwiftAutomation.framework" entry (its name should now be black, not red), and select Show in Finder from the contextual menu.

Launch Terminal and type the following into a new window:

  cd /Library/Frameworks

Next type the following, with a space after `-s`:

  sudo ln -s
    
then drag `SwiftAutomation.framework` from the Finder window onto Terminal to insert the full path to the framework at the end of the command. On pressing Return, enter an an administrator login to allow the `ln` command to create a symlink in `/Library/Frameworks`. Repeat the process for the `MacOSGlues.framework`. (Do not create Finder aliases as those do not work with command-line tools.)

To confirm this setup works, enter the following Swift "script" into a plain text or code editor of your choice:

  #!/usr/bin/swift -target x86_64-apple-macosx10.12 -F /Library/Frameworks

  import SwiftAutomation
  import MacOSGlues

  print(try Finder().home.name.get()) // output your home folder's name

Save it as `automate.swift` in your home folder, type `cd ~/ && chmod +x test.swift` in Terminal to make it executable, then run it as follows:

  ./automate.swift

All going well, the script should compile and run in well under a second, and print the name of your home folder to `stdout`. Success!

(All not going well, Swift will log an error message describing why it failed. If you cannot troubleshoot it yourself, please get in touch.)

<p class="hilitebox">Remember to rebuild SwiftAE's Release products whenever a new version of Xcode/Swift is installed: until Swift provides a stable ABI, the compiled SwiftAutomation and MacOSGlues frameworks can only be used by scripts compiled with the exact same version of Swift as they were.</p>


## Embedding in GUI apps

Because Swift does not yet provide a stable ABI, it is not possible for a GUI application built by one version of the Swift compiler to link to a framework built by another. Instead, a Swift-based application project must compile all of its Swift framework dependencies and embed those frameworks within its .app bundle as part of its build process. Technical Note TN2435 [Embedding Frameworks In An App](https://developer.apple.com/library/content/technotes/tn2435/_index.html) explains how to embed a third-party Xcode framework project such as SwiftAE inside your own Xcode project.

