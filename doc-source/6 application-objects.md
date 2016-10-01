# Application objects

[TO DO: The name/path/bundleID/fileURL options all currently rely on NSWorkspace's launchApplication(at:URL,...), so can't be used in a sandboxed app. In theory, the bundleID option (both explicit and default) would use launchApplication(withBundleIdentifier:,...), which avoids running into sandbox restrictions, but that method's a piece of crap so got pulled out before the sandboxing problem was known about. Once a workable solution for the latter is found, the bundleID option should work everywhere, though the by-name/path/fileURL options will need to be documented as only available for use within non-sandboxed apps]

[TO DO: add a brief section on using SwiftAutomation within a sandboxed app, to ensure users are aware they'll need entitlements in order to talk to other apps. (Might also want to note that there's a potential security hole any time a non-sandboxed app can be send a run script/do script/do shell script/etc command that enables execution of arbitrary code; not sure how thoroughly plugged these are, and there's nothing to stop apps defining AE handlers that may deliberately/accidentally allow execution of arbitrary code/commands outside a sandbox. NSUserAppleScriptTask explicitly allows it, of course, though that's on the assumption that the scripts it runs will always and only be supplied by the user, i.e. scripts they've written themselves and/or scripts from a - hopefully! - trusted source that they've intentionally installed for their own use.)]

## Creating application objects

Before you can communicate with a scriptable application you must create an application object. When targeting local applications, the glue's own default constructor, which locates the application by bundle identifier, is usually the best choice. For example, to target TextEdit:

  let textedit = TextEdit()

This uses the bundle identifier of the application from which the glue was originally generated (in this case "com.apple.TextEdit"). If you have more than one version of the application installed, or wish to control the same application on another machine (via Remote Apple Events), use one of the following initializers to target it precisely:

  // application's name or full path (`.app` suffix is optional)
  Application(name: String, ...)
  
  // application's bundle ID
  Application(bundleIdentifier: String, ...)

  // `file:` URL for local application or `eppc:` URL for remote process
  Application(url: URL, ...)

  // Unix process id
  Application(processIdentifier: pid_t, ...)

  // AEAddressDesc
  Application(descriptor: NSAppleEventDescriptor, ...)

  // current (i.e. host) process
  Application.currentApplication()

For example, to target a specific version of Adobe InDesign by its name:

  let indesign = AdobeInDesign(name: "Adobe InDesign CS6.app")

Or to control a copy of iTunes running on another machine:

  let itunes = ITunes(url: URL(string: "eppc://media-mac.local/iTunes")!)

Except for `currentApplication()`, the above initializers can also accept the following optional arguments:

* `launchOptions: NSWorkspaceLaunchOptions` – determines behavior when launching a local application; if omitted, the `NSWorkspaceLaunchOptions.WithoutActivation` option is used. See AppKit's `NSWorkspaceLaunchOptions` documentation for a list of available options.

* `relaunchMode: RelaunchMode` - determines behavior if the target process no longer exists; see Restarting applications section below. If omitted, `RelaunchMode.Limited` is used.

Note that local applications will be launched if not already running when the `Application()`, `Application(name:)`, `Application(bundleIdentifier:)` or `Application(url:)` constructors are invoked, and events will be sent to the running application according to its process ID. If the process is later terminated, that process ID is no longer valid and events sent subsequently using this application object will fail as application objects currently don't provide a 'reconnect' facility.

If the `Application(url:)` constructor is invoked with an `eppc://` URL, or if the `Application(processIdentifier:)` or `Application(descriptor:)` constructors are used, the caller is responsible for ensuring the target application is running before sending any events to it.


## Basic commands

All applications should respond to the following commands, which are added to all glue files by default:

  run()      // Run an application

  activate() // Bring the application to the front

  reopen()   // Reactivate a running application

  open(Any)  // Open the specified file(s) (typically URL or Array<URL>)

  print(Any) // Print the specified file(s) (typically URL or Array<URL>)

  quit( [ saving: AE.yes | AE.ask | AE.no ] )
             // Quit an application, optionally saving any open documents first

Some applications may provide their own definitions of some or all of these commands, so check their terminology before use. For example, many applications' `open` command will also return a `Specifier` or `Array<Specifier>` value identifying the newly opened documents.

Standard `get` and `set` commands are also included as most scriptable applications' dictionaries don't define these commands themselves, though are only applicable to applications that define an Apple Event Object Model:

  get(Specifier) -> Any   // Get the value of the given object specifier

  set(Specifier, to: Any) // Set the value of the given object specifier to the new value

<div class="hilitebox">

<p>Be aware that all glue-defined application commands come in two standard forms, one with a generic return type and one with an `Any` return type:</p>

<pre><code><var>commandName</var>&lt;T&gt;([_ directParameter: Any,][<var>keywordParameter</var>: Any,...]) throws -> T

<var>commandName</var>([_ directParameter: Any,][<var>keywordParameter</var>: Any,...]) throws -> Any</code></pre>

<p>For brevity, this documentation omits the `throws` keyword and only indicates a return type for application commands that are expected to return a result.</p>

<p>Also be aware that all command parameters are typed as `Any` – it is the caller's responsibility to supply values of appropriate types for a given command. (While application dictionaries may suggest appropriate parameter types, this information is neither complete nor accurate enough for the glue generator to be any more specific.)</p>

</div>


## Transaction support

Application objects implement a `doTransaction(session:closure:)` method that allow a sequence of commands to be handled atomically by applications that support transactions, e.g. FileMaker Pro.

[TO DO: document this, once it's tested (_if_ it can be tested... this is a massively neglected corner of AE handling; not even sure if FMP supports it any more, never mind any newer apps)]


## Local application launching notes

Note: the following information only applies to local applications as SwiftAutomation cannot directly launch applications on a remote Mac. To control a remote application, the application must be running beforehand or else launched indirectly (e.g. by using the remote Mac's Finder to open it).


### How applications are identified

When you create an Application object by application name, bundle id or creator type, SwiftAutomation uses LaunchServices to locate an application matching that description. If you have more than one copy of the same application installed, you can identify the one you want by providing its full path, otherwise LaunchServices will identify the newest copy for you.

SwiftAutomation targets local running applications by process ID, so it's possible to have multiple copies/versions of an application running at the same time if their Application objects are created using process IDs (or `eppc://` URLs that include pid).


### Checking if an application is running

You can check if the target application is currently running by getting the value of its `isRunning` Boolean property:

  Finder().isRunning

For example, SwiftAutomation will automatically launch a non-running application the first time it sends a command, so if you don't want to interact with that application unless it is already running, enclose all of its commands in a conditional block that only executes if its `isRunning` property is `true`:

  let iTunes = iTunes()
  
  // Only perform iTunes-related commands if it's already running:
  if iTunes.isRunning {
    // all iTunes-related commands go here...
  }


### Launching applications via `launch()`

When SwiftAutomation launches a non-running application, it normally sends it a `run` command as part of the launching process. If you wish to avoid this, you should start the application by sending it a `launch` command before doing anything else. This is useful when you want to start an application without it going through its normal startup procedure, and is equivalent to the using AppleScript's `launch` command. For example, to launch TextEdit without causing it to display a new, empty document (its usual behaviour):

  textedit = TextEdit()
  try textedit.launch()
  // other TextEdit-related code goes here...


### Restarting applications

As soon as you start to construct a reference or command using a newly created Application objects, if the application is not already running then SwiftAutomation will automatically launch it in order to obtain its terminology.

Be default, if the target application has stopped running since the Application object was created, trying to send it a command using that Application object will result in an invalid connection error (-609), unless that command is `run` or `launch`. This restriction prevents SwiftAutomation accidentally restarting an application that has unexpectedly quit while a script is controlling it. You can restart an application by sending an explicit `run` or `launch` command, or by creating a new Application object for it. 

To change this relaunch behavior, use one of the following `RelaunchMode` values as the initializer's `relaunchMode:` argument:

* `.never` -- prevent the Application object automatically relaunching the application, even for a `run` or `launch` command
* `.limited` -- allow the Application object to relaunch the application before sending a `run` or `launch` command (SwiftAutomation's default behavior)
* `.always` -- allow the Application object to relaunch the application before sending any command (AppleScript's behavior)

For example:

  let illustrator = AdobeIllustrator(relaunchMode: .never) 

Note that you can still use Application objects to control applications that have been quit _and_ restarted since the Application object was created. SwiftAutomation will automatically update the Application object's process ID information as needed. [TO DO: check this is correct; also check how it behaves when .never is used]


<p class="hilitebox">There is a known problem with quitting and immediately relaunching an application via SwiftAutomation, where the relaunch instruction is sent to the application before it has actually quit. This timing issue appears to be macOS's fault; one workaround is to send the `quit` command, wait until `isRunning` returns `false`, then send the `run`/`launch` command.</p>


