//
//  Support.swift
//  SwiftAutomation
//

import Foundation
import AppKit


/******************************************************************************/
// Specifier and Symbol subclasses pack themselves
// Set, Array, Dictionary structs pack and unpack themselves

public protocol SelfPacking {
    func SwiftAutomation_packSelf(_ appData: AppData) throws -> NSAppleEventDescriptor
}

protocol SelfUnpacking {
    static func SwiftAutomation_unpackSelf(_ desc: NSAppleEventDescriptor, appData: AppData) throws -> Self
}


/******************************************************************************/
// convert between 4-character strings and OSTypes (use these instead of calling UTGetOSTypeFromString/UTCopyStringFromOSType directly)

func FourCharCodeUnsafe(_ string: String) -> OSType { // note: silently returns 0 if string is invalid; where practical, use throwing version below
    return UTGetOSTypeFromString(string as CFString)
}

func FourCharCode(_ string: NSString) throws -> OSType { // note: use this instead of FourCharCode to get better error reporting
    guard let data = string.data(using: String.Encoding.macOSRoman.rawValue) else {
        throw SwiftAutomationError(code: 1, message: "Invalid four-char code (bad encoding): \(formatValue(string))") // TO DO: what error?
    }
    if (data.count != 4) {
        throw SwiftAutomationError(code: 1, message: "Invalid four-char code (wrong length): \(formatValue(string))")
    }
    var tmp: UInt32 = 0
    (data as NSData).getBytes(&tmp, length: 4)
    return CFSwapInt32HostToBig(tmp)
}

func FourCharCodeString(_ code: OSType) -> String {
    return UTCreateStringForOSType(code).takeRetainedValue() as String
}


// misc AEDesc packing functions

func FourCharCodeDescriptor(_ type: OSType, _ data: OSType) -> NSAppleEventDescriptor {
    var data = data
    return NSAppleEventDescriptor(descriptorType: type, bytes: &data, length: MemoryLayout<OSType>.size)!
}

func UInt32Descriptor(_ data: UInt32) -> NSAppleEventDescriptor {
    var data = data // note: Swift's ObjC bridge appears to ignore the `const` on the `-[NSAppleEventDescriptor initWithDescriptorType:bytes:length:]` method's 'bytes' parameter, so need to rebind to `var` as workaround
    return NSAppleEventDescriptor(descriptorType: SwiftAutomation_typeUInt32, bytes: &data, length: MemoryLayout<UInt32>.size)!
}


// the following AEDesc types will be mapped to Symbol instances
let SymbolTypes: Set<DescType> = [typeType, typeEnumerated, typeProperty, typeKeyword]


/******************************************************************************/
// consids/ignores options defined in ASRegistry.h (it's crappy design and a complete mess, and most apps don't even support it, but what we're stuck with)

public enum Considerations {
    case `case`
    case diacritic
    case whiteSpace
    case hyphens
    case expansion
    case punctuation
    //  case Replies // TO DO: check if this is ever supplied by AS; if it is, might be an idea to add it; if not, delete
    case numericStrings
}

public typealias ConsideringOptions = Set<Considerations>


/******************************************************************************/
// launch and relaunch options used in Application initializers

public typealias LaunchOptions = NSWorkspaceLaunchOptions

public let DefaultLaunchOptions: LaunchOptions = .withoutActivation


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

private let LaunchEvent = NSAppleEventDescriptor(eventClass: SwiftAutomation_kASAppleScriptSuite, eventID: SwiftAutomation_kASLaunchEvent,
                                                 targetDescriptor: NSAppleEventDescriptor.null(),
                                                 returnID: AEReturnID(kAutoGenerateReturnID),
                                                 transactionID: AETransactionID(kAnyTransactionID))

// Application initializers pass application-identifying information to AppData initializer as enum according to which initializer was called

public enum TargetApplication {
    case current
    case name(String) // application's name (.app suffix is optional) or full path
    case url(URL) // "file" or "eppc" URL
    case bundleIdentifier(String, Bool) // bundleID, isDefault
    case processIdentifier(pid_t)
    case Descriptor(NSAppleEventDescriptor) // AEAddressDesc
    case none // used in untargeted AppData instances; sendAppleEvent() will raise ConnectionError if called
    
    // TO DO: implement `description` property and use it in all error messages raised here?
    
    // support functions
    
    private func localRunningApplication(url: URL) throws -> NSRunningApplication? {
        guard let bundleID = Bundle(url: url)?.bundleIdentifier else {
            throw ConnectionError(target: self, message: "Application not found: \(url)")
        }
        let foundProcesses = NSRunningApplication.runningApplications(withBundleIdentifier: bundleID)
        if foundProcesses.count == 1 {
            return foundProcesses[0]
        } else if foundProcesses.count > 1 {
            for process in foundProcesses {
                if process.bundleURL == url { // TO DO: confirm this checks for FS identity, not path string equality; if not, use NSURLFileResourceIdentifierKey
                    return process
                }
            }
        }
        return nil
    }
    
    private func sendLaunchEvent(processDescriptor: NSAppleEventDescriptor) -> Int {
        do {
            let event = NSAppleEventDescriptor(eventClass: SwiftAutomation_kASAppleScriptSuite, eventID: SwiftAutomation_kASLaunchEvent,
                                               targetDescriptor: processDescriptor, returnID: AEReturnID(kAutoGenerateReturnID),
                                               transactionID: AETransactionID(kAnyTransactionID))
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
                NSWorkspace.shared().launchApplication(at: url, options: launchOptions, configuration: [:]))
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
        try NSWorkspace.shared().launchApplication(at: url, options: [.withoutActivation],
                                                   configuration: [NSWorkspaceLaunchConfigurationAppleEvent: LaunchEvent])
    }
    
    // launch this application (equivalent to AppleScript's `launch` command)

    public func launch() throws { // called by ApplicationExtension.launch()
        // note: in principle an app _could_ implement an AE handler for this event that returns a value, but it probably isn't a good idea to do so (the event is called 'ascr'/'noop' for a reason), so even if a running process does return something (instead of throwing the expected errAEEventNotHandled) we just ignore it for sanity's sake (the flipside being that if the app _isn't_ already running then NSWorkspace.launchApplication() will launch it and pass the 'noop' descriptor as the first Apple event to handle, but doesn't return a result for that event, so to return a result at any other time would be inconsistent)
        if self.isRunning {
            let errorNumber = self.sendLaunchEvent(processDescriptor: try self.descriptor()!)
            if !LaunchEventSucceededErrorNumbers.contains(errorNumber) {
                throw SwiftAutomationError(code: errorNumber, message: "Can't launch application.")
            }
        } else {
            switch self {
            case .name(let name):
                if let url = fileURLForLocalApplication(name) { try self.launch(url: url) }
            case .url(let url):
                if url.isFileURL { try self.launch(url: url) }
            case .bundleIdentifier(let bundleID, _):
                NSWorkspace.shared().launchApplication(withBundleIdentifier: bundleID, options: [.withoutActivation],
                                                       additionalEventParamDescriptor: LaunchEvent, launchIdentifier: nil)
            default:
                ()
            }
            throw ConnectionError(target: self, message: "Can't launch application.")
        }
    }
    
    // get AEAddressDesc for target application (this is typeKernelProcessID for local processes specified by name/url/bundleID/PID)
    public func descriptor(_ launchOptions: LaunchOptions = DefaultLaunchOptions) throws -> NSAppleEventDescriptor? {
        switch self {
        case .current:
            return nil
        case .name(let name): // app name or full path
            var url: URL
            if name.hasPrefix("/") { // full path (note: path must include .app suffix)
                url = URL(fileURLWithPath: name)
            } else { // if name is not full path, look up by name (.app suffix is optional)
                guard let tmp = fileURLForLocalApplication(name) else {
                    throw ConnectionError(target: self, message: "Application not found: \(name)")
                }
                url = tmp
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
        case .bundleIdentifier(let bundleIdentifier, _):
            if let url = NSWorkspace.shared().urlForApplication(withBundleIdentifier: bundleIdentifier) {
                return try self.processDescriptorForLocalApplication(url: url, launchOptions: launchOptions)
            } else {
                throw ConnectionError(target: self, message: "Application not found: \(bundleIdentifier)")
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
        let workspace = NSWorkspace.shared()
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



