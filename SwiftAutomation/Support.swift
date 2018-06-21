//
//  Support.swift
//  SwiftAutomation
//

import Foundation
import AppKit


/******************************************************************************/
// KLUDGE: NSWorkspace provides a good method for launching apps by file URL, and a crap one for launching by bundle ID - unfortunately, only the latter can be used in sandboxed apps. This extension adds a launchApplication(withBundleIdentifier:options:configuration:)throws->NSRunningApplication method that has a good API and the least compromised behavior, insulating TargetApplication code from the crappiness that hides within. If/when Apple adds a real, robust version of this method to NSWorkspace <rdar://29159280>, this extension can (and should) go away.


extension NSWorkspace { 
    
    // caution: the configuration parameter is ignored in sandboxed apps; this is unavoidable
    @objc func launchApplication(withBundleIdentifier bundleID: String, options: NSWorkspace.LaunchOptions = [],
                           configuration: [NSWorkspace.LaunchConfigurationKey : Any]) throws -> NSRunningApplication {
        // if one or more processes with the given bundle ID is already running, return the first one found
        let foundProcesses = NSRunningApplication.runningApplications(withBundleIdentifier: bundleID)
        if foundProcesses.count > 0 {
            return foundProcesses[0]
        }
        // first try to get the app's file URL, as this lets us use the better launchApplication(at:options:configuration:) method…
        if let url = NSWorkspace.shared.urlForApplication(withBundleIdentifier: bundleID) {
            do {
                return try NSWorkspace.shared.launchApplication(at: url, options: options, configuration: configuration)
            } catch {} // for now, we're not sure if urlForApplication(withBundleIdentifier:) will always return nil if blocked by sandbox; if it returns garbage URL instead then hopefully that'll cause launchApplication(at:...) to throw
        }
        // …else fall back to the inferior launchApplication(withBundleIdentifier:options:additionalEventParamDescriptor:launchIdentifier:)
        var options = options
        options.remove(NSWorkspace.LaunchOptions.async)
        if NSWorkspace.shared.launchApplication(withBundleIdentifier: bundleID, options: options,
                                                  additionalEventParamDescriptor: nil, launchIdentifier: nil) {
            // TO DO: confirm that launchApplication() never returns before process is available (otherwise the following will need to be in a loop that blocks until it is available or the loop times out)
            let foundProcesses = NSRunningApplication.runningApplications(withBundleIdentifier: bundleID)
            if foundProcesses.count > 0 {
                return foundProcesses[0]
            }
        }
        throw NSError(domain: NSCocoaErrorDomain, code: 1, userInfo:
                      [NSLocalizedDescriptionKey: "Can't find/launch application \(bundleID.debugDescription)"]) // TO DO: what error to report here, since launchApplication(withBundleIdentifier:options:additionalEventParamDescriptor:launchIdentifier:) doesn't provide any error info itself?
    }
}


/******************************************************************************/
// logging


struct StderrStream: TextOutputStream {
    public mutating func write(_ string: String) { fputs(string, stderr) }
}
var errStream = StderrStream()


/******************************************************************************/
// convert between 4-character strings and OSTypes (use these instead of calling UTGetOSTypeFromString/UTCopyStringFromOSType directly)

// TO DO: any value in making the following functions public?

func fourCharCode(_ string: String) throws -> OSType {
    // convert four-character string containing MacOSRoman characters to OSType
    // (this is safer than using UTGetOSTypeFromString, which silently fails if string is malformed)
    guard let data = string.data(using: .macOSRoman) else {
        throw AutomationError(code: 1, message: "Invalid four-char code (bad encoding): \(string.debugDescription)")
    }
    if (data.count != 4) {
        throw AutomationError(code: 1, message: "Invalid four-char code (wrong length): \(string.debugDescription)")
    }
    var tmp: UInt32 = 0
    (data as NSData).getBytes(&tmp, length: 4)
    return CFSwapInt32HostToBig(tmp)
}

func fourCharCode(_ code: OSType) -> String {
    // convert an OSType to four-character string containing MacOSRoman characters
    return UTCreateStringForOSType(code).takeRetainedValue() as String
}

func eightCharCode(_ eventClass: OSType, _ eventID: OSType) -> UInt64 {
    // used to construct keys for GlueTable.commandsByCode dictionary
    return UInt64(eventClass) << 32 | UInt64(eventID)
}


// misc AEDesc packing functions

extension NSAppleEventDescriptor { // TO DO: how safe/advisable is extending system-defined classes?
    
    @objc convenience init(type: OSType, code: OSType) {
        var data = code
        self.init(descriptorType: type, bytes: &data, length: MemoryLayout<OSType>.size)!
    }
    
    @objc convenience init(uint32 data: UInt32) {
        var data = data
        self.init(descriptorType: _typeUInt32, bytes: &data, length: MemoryLayout<UInt32>.size)!
    }
}


// the following AEDesc types will be mapped to Symbol instances
let symbolDescriptorTypes: Set<DescType> = [typeType, typeEnumerated, typeProperty, typeKeyword]


/******************************************************************************/
// consids/ignores options are defined in ASRegistry.h (they're a crappy design and a complete mess, and most apps completely ignore them, but we support them anyway in order to ensure feature parity with AS)

public enum Considerations {
    case `case`
    case diacritic
    case whiteSpace
    case hyphens
    case expansion
    case punctuation
//  case replies // TO DO: check if this is ever supplied by AS; if it is, might be an idea to add it; if not, delete
    case numericStrings
}

public typealias ConsideringOptions = Set<Considerations>


public typealias SendOptions = NSAppleEventDescriptor.SendOptions


/******************************************************************************/
// launch and relaunch options used in Application initializers

public typealias LaunchOptions = NSWorkspace.LaunchOptions

public let DefaultLaunchOptions: LaunchOptions = NSWorkspace.LaunchOptions.withoutActivation


public enum RelaunchMode { // if [local] target process has terminated, relaunch it automatically when sending next command to it
    case always
    case limited
    case never
}

public let DefaultRelaunchMode: RelaunchMode = .limited


// Indicates omitted command parameter

public enum OptionalParameter {
    case none
}

public let NoParameter = OptionalParameter.none

func parameterExists(_ value: Any) -> Bool {
    return value as? OptionalParameter != NoParameter
}


/******************************************************************************/
// locate/identify target application by name, path, bundle ID, eppc:// URL, etc


// AE errors indicating process unavailable // TO DO: finalize
private let ProcessNotFoundErrorNumbers: Set<Int> = [procNotFound, connectionInvalid, localOnlyErr]

private let LaunchEventSucceededErrorNumbers: Set<Int> = [Int(noErr), errAEEventNotHandled]

private let LaunchEvent = NSAppleEventDescriptor(eventClass: _kASAppleScriptSuite, eventID: _kASLaunchEvent,
                                                 targetDescriptor: NSAppleEventDescriptor.null(), returnID: _kAutoGenerateReturnID,
                                                 transactionID: _kAnyTransactionID)

// Application initializers pass application-identifying information to AppData initializer as enum according to which initializer was called

public enum TargetApplication: CustomReflectable {
    case current
    case name(String) // application's name (.app suffix is optional) or full path
    case url(URL) // "file" or "eppc" URL
    case bundleIdentifier(String, Bool) // bundleID, isDefault
    case processIdentifier(pid_t)
    case Descriptor(NSAppleEventDescriptor) // AEAddressDesc
    case none // used in untargeted AppData instances; sendAppleEvent() will raise ConnectionError if called
    
    // TO DO: implement `description` property and use it in all error messages raised here?
    
    public var description: String {
        return String(describing: self)
    }
    
    public var customMirror: Mirror {
        let children: [Mirror.Child] = [(label: nil, value: self)]
        return Mirror(self, children: children, displayStyle: Mirror.DisplayStyle.`enum`, ancestorRepresentation: .suppressed)
    }
    
    // support functions
    
    private func localRunningApplication(url: URL) throws -> NSRunningApplication? { // TO DO: rename processForLocalApplication
        guard let bundleID = Bundle(url: url)?.bundleIdentifier else {
            throw ConnectionError(target: self, message: "Application not found: \(url)")
        }
        let foundProcesses = NSRunningApplication.runningApplications(withBundleIdentifier: bundleID)
        if foundProcesses.count == 1 {
            return foundProcesses[0]
        } else if foundProcesses.count > 1 {
            for process in foundProcesses {
                if process.bundleURL == url { // TO DO: FIX: need to check for FS equality
                    /*
                     function idForFileURL(url) {
                         const fileIDRef = objc.alloc(objc.NSData, objc.NIL).ref();
                         if (!url('getResourceValue', fileIDRef, 'forKey', objc.NSURLFileResourceIdentifierKey, 'error', null)) {
                             throw new Error(`Can't get NSURLFileResourceIdentifierKey for ${url}`);
                         }
                         return fileIDRef.deref();
                     }
                     */
                    return process
                }
            }
        }
        return nil
    }
    
    private func sendLaunchEvent(processDescriptor: NSAppleEventDescriptor) -> Int {
        do {
            let event = NSAppleEventDescriptor(eventClass: _kASAppleScriptSuite, eventID: _kASLaunchEvent,
                                               targetDescriptor: processDescriptor, returnID: _kAutoGenerateReturnID,
                                               transactionID: _kAnyTransactionID)
            let reply = try event.sendEvent(options: .waitForReply, timeout: 30)
            return Int(reply.paramDescriptor(forKeyword: keyErrorNumber)?.int32Value ?? 0) // application error (errAEEventNotHandled is normal)
        } catch {
            return (error as Error)._code // AEM error
        }
    }
    
    private func processDescriptorForLocalApplication(url: URL, launchOptions: LaunchOptions) throws -> NSAppleEventDescriptor {
        // get a typeKernelProcessID-based AEAddressDesc for the target app, finding and launch it first if not already running;
        // if app can't be found/launched, throws a ConnectionError/NSError instead
        let runningProcess = try (self.localRunningApplication(url: url) ??
            NSWorkspace.shared.launchApplication(at: url, options: launchOptions, configuration: [:]))
        return NSAppleEventDescriptor(processIdentifier: runningProcess.processIdentifier)
    }
    
    private func isRunning(processDescriptor: NSAppleEventDescriptor) -> Bool {
        // check if process is running by sending it a 'noop' event; used by isRunning property
        // this assumes app is running unless it receives an AEM error that explicitly indicates it isn't (a bit crude, but when the only identifying information for the target process is an arbitrary AEAddressDesc there isn't really a better way to check if it's running other than send it an event and see what happens)
        return !ProcessNotFoundErrorNumbers.contains(self.sendLaunchEvent(processDescriptor: processDescriptor))
    }
    
    // get info on this application
    
    public var isRelaunchable: Bool {
        switch self {
        case .name, .bundleIdentifier:
            return true
        case .url(let url):
            return url.isFileURL
        default:
            return false
        }
    }
    
    public var isRunning: Bool {
        switch self {
        case .current:
            return true
        case .name(let name): // application's name (.app suffix is optional) or full path
            if let url = fileURLForLocalApplication(name) {
                return (try? self.localRunningApplication(url: url)) != nil
            }
        case .url(let url): // "file" or "eppc" URL
            if url.isFileURL {
                return (try? self.localRunningApplication(url: url)) != nil
            } else if url.scheme == "eppc" {
                return self.isRunning(processDescriptor: NSAppleEventDescriptor(applicationURL: url))
            }
        case .bundleIdentifier(let bundleID, _):
            return NSRunningApplication.runningApplications(withBundleIdentifier: bundleID).count > 0
        case .processIdentifier(let pid):
            return NSRunningApplication(processIdentifier: pid) != nil
        case .Descriptor(let addressDesc):
            return self.isRunning(processDescriptor: addressDesc)
        case .none: // used in untargeted AppData instances; sendAppleEvent() will raise ConnectionError if called
            ()
        }
        return false
    }
    
    //
    
    private func launch(url: URL) throws {
        try NSWorkspace.shared.launchApplication(at: url, options: [NSWorkspace.LaunchOptions.withoutActivation],
                                                   configuration: [NSWorkspace.LaunchConfigurationKey.appleEvent: LaunchEvent])
    }
    
    // launch this application (equivalent to AppleScript's `launch` command; an obscure corner case that AS users need to fall back onto when sending an event to a Script Editor applet that isn't saved as 'stay open', so only handles the first event it receives then quits when done) // TO DO: is it worth keeping this for 'quirk-for-quirk' compatibility's sake, or just ditch it and tell users to use `NSWorkspace.launchApplication(at:options:configuration:)` with an `NSWorkspaceLaunchConfigurationAppleEvent` if they really need to pass a non-standard first event?

    public func launch() throws { // called by Application.launch()
        // note: in principle an app _could_ implement an AE handler for this event that returns a value, but it probably isn't a good idea to do so (the event is called 'ascr'/'noop' for a reason), so even if a running process does return something (instead of throwing the expected errAEEventNotHandled) we just ignore it for sanity's sake (the flipside being that if the app _isn't_ already running then NSWorkspace.launchApplication() will launch it and pass the 'noop' descriptor as the first Apple event to handle, but doesn't return a result for that event, so to return a result at any other time would be inconsistent)
        if self.isRunning {
            let errorNumber = self.sendLaunchEvent(processDescriptor: try self.descriptor()!)
            if !LaunchEventSucceededErrorNumbers.contains(errorNumber) {
                throw AutomationError(code: errorNumber, message: "Can't launch application.")
            }
        } else {
            switch self {
            case .name(let name):
                if let url = fileURLForLocalApplication(name) {
                    try self.launch(url: url)
                    return
                }
            case .url(let url) where url.isFileURL:
                try self.launch(url: url)
                return
            case .bundleIdentifier(let bundleID, _):
                if let url = NSWorkspace.shared.urlForApplication(withBundleIdentifier: bundleID) {
                    try self.launch(url: url)
                    return
                }
            default:
                ()
            } // fall through on failure
            throw ConnectionError(target: self, message: "Can't launch application.")
        }
    }
    
    // get AEAddressDesc for target application (this is typeKernelProcessID for local processes specified by name/url/bundleID/PID)
    public func descriptor(_ launchOptions: LaunchOptions = DefaultLaunchOptions) throws -> NSAppleEventDescriptor? {
        switch self {
        case .current:
            return NSAppleEventDescriptor.currentProcess()
        case .name(let name): // app name or full path
            guard let url = fileURLForLocalApplication(name) else {
                throw ConnectionError(target: self, message: "Application not found: \(name)")
            }
            return try self.processDescriptorForLocalApplication(url: url, launchOptions: launchOptions)
        case .url(let url): // file/eppc URL
            if url.isFileURL {
                return try self.processDescriptorForLocalApplication(url: url, launchOptions: launchOptions)
            } else if url.scheme == "eppc" {
                return NSAppleEventDescriptor(applicationURL: url)
            } else {
                throw ConnectionError(target: self, message: "Invalid URL scheme (not file/eppc): \(url)")
            }
        case .bundleIdentifier(let bundleID, _):
            do {
                let runningProcess = try NSWorkspace.shared.launchApplication(withBundleIdentifier: bundleID,
                                                                                options: launchOptions, configuration: [:])
                return NSAppleEventDescriptor(processIdentifier: runningProcess.processIdentifier)
            } catch {
                throw ConnectionError(target: self, message: "Can't find/launch application: \(bundleID)", cause: error)
            }
        case .processIdentifier(let pid):
            return NSAppleEventDescriptor(processIdentifier: pid)
        case .Descriptor(let desc):
            return desc
        case .none:
            throw ConnectionError(target: .none, message: "Untargeted specifiers can't send Apple events.")
        }
    }
}


// get file URL for the specified .app bundle (also used by `aeglue`)
// `name` may be full POSIX path (including `.app` suffix), or file name only (`.app` suffix is optional); returns nil if not found
public func fileURLForLocalApplication(_ name: String) -> URL? {
    if name.hasPrefix("/") { // full path (note: path must include .app suffix)
        return URL(fileURLWithPath: name)
    } else { // if name is not full path, look up by name (.app suffix is optional)
        let workspace = NSWorkspace.shared
        guard let path = workspace.fullPath(forApplication: name) ?? workspace.fullPath(forApplication: "\(name).app") else {
            return nil
        }
        return URL(fileURLWithPath: path)
    }
}


/******************************************************************************/
// Apple event descriptors used to terminate nested AERecord (of typeObjectSpecifier, etc) chains

// root descriptor for all absolute object specifiers that do not have a custom root
// e.g. `document 1 of «typeNull»`
public let AppRootDesc = NSAppleEventDescriptor.null()

// root descriptor for an object specifier describing start or end of a range of elements in a by-range specifier
// e.g. `folder (folder 2 of «typeCurrentContainer») thru (folder -1 of «typeCurrentContainer»)`
public let ConRootDesc = NSAppleEventDescriptor(descriptorType: typeCurrentContainer, data: nil)!

// root descriptor for an object specifier describing an element whose state is being compared in a by-test specifier
// e.g. `every track where (rating of «typeObjectBeingExamined» > 50)`
public let ItsRootDesc = NSAppleEventDescriptor(descriptorType: typeObjectBeingExamined, data: nil)!


/******************************************************************************/
// compatibility functions for use with any older Carbon-based applications that still require HFS path strings

// TO DO: are there any situations where the following method calls could return nil? (think they'll always succeed, though the resulting paths may be nonsense); if so, need to throw error on failure (currently these will raise an exception, but that's based on the assumption that they'll never fail in practice: the paths supplied will be arbitrary, so if failures do occur they'll need to be treated as user errors, not implementation bugs)

public func HFSPath(fromFileURL url: URL) -> String {
    return NSAppleEventDescriptor(fileURL: url).coerce(toDescriptorType: typeUnicodeText)!.stringValue!
}

public func fileURL(fromHFSPath path: String) -> URL {
    return NSAppleEventDescriptor(string: path).coerce(toDescriptorType: typeFileURL)!.fileURLValue!
}







