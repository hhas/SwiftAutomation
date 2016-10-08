# Notes

// TO DO: update

## Security issues

If including user names and/or passwords in remote application URLs, please note that <code><var>XX</var>Application</code> and <code><var>XX</var>Specifier</code> objects will retain those URL strings over their entire lifetime. Security here is the developer's responsibility, as it's their code that creates and retains these objects.


## GUI Scripting

Non-scriptable applications may in some cases be controlled from SwiftAutomation by using System Events to manipulate their graphical user interface. Note that the "Enable access for assistive devices" checkbox must be selected in the Universal Access system preferences pane for GUI Scripting to work.


## Type bridging limitations

Some applications (e.g. QuarkXpress) may return values which SwiftAutomation cannot convert to equivalent Cocoa types. These values are usually of types which are defined, used and understood only by that particular application, and will be represented in Objective-C as `NSAppleEventDescriptor` instances which should generally be treated as opaque values.

A few standard but rarely used AE types are also currently unbridged with Cocoa counterparts, such as image types (`typePict`, `typeTIFF`, etc.). Client code should perform any necessary conversions itself.



## SwiftAutomation and threads

SwiftAutomation is thread-safe and events can be sent (and their replies received) from any thread.


## Credits

Many thanks to all those who have contributed comments, suggestions and bug reports.

