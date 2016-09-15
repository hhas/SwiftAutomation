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
    func SwiftAE_packSelf(_ appData: AppData) throws -> NSAppleEventDescriptor
}

protocol SelfUnpacking {
    static func SwiftAE_unpackSelf(_ desc: NSAppleEventDescriptor, appData: AppData) throws -> Self
}


/******************************************************************************/
// convert between 4-character strings and OSTypes (use these instead of calling UTGetOSTypeFromString/UTCopyStringFromOSType directly)

func FourCharCodeUnsafe(_ string: String) -> OSType { // note: silently returns 0 if string is invalid; where practical, use throwing version below
    return UTGetOSTypeFromString(string as CFString)
}

func FourCharCode(_ string: NSString) throws -> OSType { // note: use this instead of FourCharCode to get better error reporting
    guard let data = string.data(using: String.Encoding.macOSRoman.rawValue) else {
        throw SwiftAEError(code: 1, message: "Invalid four-char code (bad encoding): \(formatValue(string))") // TO DO: what error?
    }
    if (data.count != 4) {
        throw SwiftAEError(code: 1, message: "Invalid four-char code (wrong length): \(formatValue(string))")
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
    return NSAppleEventDescriptor(descriptorType: SwiftAE_typeUInt32, bytes: &data, length: MemoryLayout<UInt32>.size)!
}


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

public enum Parameters {
    case none
}

public let NoParameter = Parameters.none // TO DO: what's easiest way to create unique symbol? (i.e. not sure about using nil to indicate omission of directParameter [or any other parameter] in commands, as that can't be distinguished from nil values returned by Cocoa APIs to signal a runtime error; what's recommended current best practice for Swift APIs?) // TO DO: actually, could use nil as long as glue commands don't accept it (caveat: raw 4CC APIs must reject it)


/******************************************************************************/
// locate/identify target application by name, path, bundle ID, eppc:// URL, etc


public func URLForLocalApplication(_ name: String) -> URL? { // returns nil if not found
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

// Application initializers pass application-identifying information to AppData initializer as enum according to which initializer was called

public enum TargetApplication {
    case current
    case name(String) // application's name (.app suffix is optional) or full path
    case url(Foundation.URL) // "file" or "eppc" URL
    case bundleIdentifier(String, Bool) // bundleID, isDefault
    case processIdentifier(pid_t)
    case Descriptor(NSAppleEventDescriptor) // AEAddressDesc
    case none // used in untargeted AppData instances; sendAppleEvent() will raise ConnectionError if called
    
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
    
    // get AEAddressDesc for target application (for local processes specified by name, url, bundleID, or PID, this is typeKernelProcessID)
    public func descriptor(_ launchOptions: LaunchOptions = DefaultLaunchOptions) throws -> NSAppleEventDescriptor? {
        switch self {
        case .current:
            return nil
        case .name(let name): // app name or full path
            var url: Foundation.URL
            if name.hasPrefix("/") { // full path (note: path must include .app suffix)
                url = Foundation.URL(fileURLWithPath: name)
            } else { // if name is not full path, look up by name (.app suffix is optional)
                guard let tmp = URLForLocalApplication(name) else {
                    throw ConnectionError(target: self, message: "Application not found: \(name)")
                }
                url = tmp
            }
            return try self.processDescriptorForLocalApplication(url, launchOptions: launchOptions)
        case .url(let url): // file/eppc URL
            if url.isFileURL {
                return try self.processDescriptorForLocalApplication(url, launchOptions: launchOptions)
            } else if url.scheme == "eppc" {
                return NSAppleEventDescriptor(applicationURL: url)
            } else {
                throw ConnectionError(target: self, message: "Invalid URL scheme (not file/eppc): \(url)")
            }
        case .bundleIdentifier(let bundleIdentifier, _):
            if let url = NSWorkspace.shared().urlForApplication(withBundleIdentifier: bundleIdentifier) {
                return try self.processDescriptorForLocalApplication(url, launchOptions: launchOptions)
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
    
    // support function for above
    public func processDescriptorForLocalApplication(_ url: Foundation.URL, launchOptions: LaunchOptions) throws -> NSAppleEventDescriptor {
        // get a typeKernelProcessID-based AEAddressDesc for the target app, finding and launch it first if not already running;
        // if app can't be found/launched, throws an NSError instead
        
        // TO DO: this tends to activate app
        
        guard let bundleID = Bundle(url: url)?.bundleIdentifier else {
            throw ConnectionError(target: self, message: "Application not found: \(url)")
        }
        let foundProcesses = NSRunningApplication.runningApplications(withBundleIdentifier: bundleID)
        // note: while it'd be simpler always to call launchApplication, some apps (e.g. iTunes) will automatically open a window if already running, which is annoying to user
        var runningProcess: NSRunningApplication? = nil
        if foundProcesses.count == 1 {
            runningProcess = foundProcesses[0]
        } else if foundProcesses.count > 1 {
            for process in foundProcesses {
                if process.bundleURL == url {
                    runningProcess = process
                    break
                }
            }
        }
        if runningProcess == nil {
            runningProcess = try NSWorkspace.shared().launchApplication(at: url, options: launchOptions, configuration: [:])
        }
        return NSAppleEventDescriptor(processIdentifier: runningProcess!.processIdentifier)
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



