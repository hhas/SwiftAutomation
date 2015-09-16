//
//  Support.swift
//  SwiftAE
//

import Foundation
import AppKit


// Used in ApplicationExtension initializers

public let DefaultLaunchOptions: LaunchOptions = .WithoutActivation
public let DefaultRelaunchMode: RelaunchMode = .Limited


// Indicates omitted command parameter

public class _NoParameter {}

public let NoParameter = _NoParameter.self // TO DO: what's easiest way to create unique symbol? (i.e. not sure about using nil to indicate omission of directParameter [or any other parameter] in commands, as that can't be distinguished from nil values returned by Cocoa APIs to signal a runtime error; what's recommended current best practice for Swift APIs?)


// Specifiers and Symbols pack themselves

public protocol SelfPacking {
    func packSelf(appData: AppData) throws -> NSAppleEventDescriptor
}


// Application initializers pass application-identifying information to AppData initializer as enum according to which initializer was called

public enum TargetApplication {
    case Current
    case Name(String) // application's name (.app suffix is optional) or full path
    case URL(NSURL) // "file" or "eppc" URL
    case BundleIdentifier(String, Bool) // bundleID, isDefault
    case ProcessIdentifier(pid_t)
    case Descriptor(NSAppleEventDescriptor) // AEAddressDesc
    case None // used in untargeted AppData instances; sendAppleEvent() will raise ConnectionError if called
    
    public var isRelaunchable: Bool {
        switch self {
        case .Name, .BundleIdentifier:
            return true
        case .URL(let url):
            return url.fileURL
        default:
            return false
        }
    }
    
    // get AEAddressDesc for target application (for local processes specified by name, url, bundleID, or PID, this is typeKernelProcessID)
    public func descriptor(launchOptions: LaunchOptions = DefaultLaunchOptions) throws -> NSAppleEventDescriptor? {
        switch self {
        case .Current:
            return nil
        case .Name(let name): // app name or full path
            var url: NSURL
            if name.hasPrefix("/") { // full path (note: path must include .app suffix)
                url = NSURL(fileURLWithPath: name)
            } else { // if name is not full path, look up by name (.app suffix is optional)
                let workspace = NSWorkspace.sharedWorkspace()
                if let path = workspace.fullPathForApplication(name) ?? workspace.fullPathForApplication("\(name).app") {
                    url = NSURL(fileURLWithPath: path)
                } else {
                    throw ConnectionError(target: self, message: "Application not found.")
                }
            }
            return try self.processDescriptorForLocalApplication(url, launchOptions: launchOptions)
        case .URL(let url): // file/eppc URL
            if url.fileURL {
                return try self.processDescriptorForLocalApplication(url, launchOptions: launchOptions)
            } else if url.scheme == "eppc" {
                return NSAppleEventDescriptor(applicationURL: url)
            } else {
                throw ConnectionError(target: self, message: "Invalid URL scheme (not file/eppc).")
            }
        case .BundleIdentifier(let bundleIdentifier, _):
            if let url = NSWorkspace.sharedWorkspace().URLForApplicationWithBundleIdentifier(bundleIdentifier) {
                return try self.processDescriptorForLocalApplication(url, launchOptions: launchOptions)
            } else {
                throw ConnectionError(target: self, message: "Application not found.")
            }
        case .ProcessIdentifier(let pid):
            return NSAppleEventDescriptor(processIdentifier: pid)
        case .Descriptor(let desc):
            return desc
        case .None:
            throw ConnectionError(target: .None, message: "Untargeted specifiers can't send Apple events.")
        }
    }
    
    // support function for above
    public func processDescriptorForLocalApplication(url: NSURL, launchOptions: LaunchOptions) throws -> NSAppleEventDescriptor {
        // get a typeKernelProcessID-based AEAddressDesc for the target app, finding and launch it first if not already running;
        // if app can't be found/launched, throws an NSError instead
        let runningProcess = try NSWorkspace.sharedWorkspace().launchApplicationAtURL(url, options: launchOptions, configuration: [:])
        return NSAppleEventDescriptor(processIdentifier: runningProcess.processIdentifier)
    }
}


// misc AEDesc packing functions; used internally

func FourCharCodeDescriptor(type: OSType, var _ data: OSType) -> NSAppleEventDescriptor {
    return NSAppleEventDescriptor(descriptorType: type, bytes: &data, length: sizeofValue(data))!
}

func UInt32Descriptor(var data: UInt32) -> NSAppleEventDescriptor { // (Swift seems to ignore `const` on 'bytes' arg, so use `var` as workaround)
    return NSAppleEventDescriptor(descriptorType: typeUInt32, bytes: &data, length: sizeofValue(data))!
}


// Apple event descriptors used to terminate nested AERecord (of typeObjectSpecifier, etc) chains

let AppRootDesc = NSAppleEventDescriptor.nullDescriptor() // root descriptor for all object specifiers that do not have a custom root
let ConRootDesc = NSAppleEventDescriptor(descriptorType: typeCurrentContainer, data: nil)!
let ItsRootDesc = NSAppleEventDescriptor(descriptorType: typeObjectBeingExamined, data: nil)!


// launch and relaunch options used in Application initializers

public typealias LaunchOptions = NSWorkspaceLaunchOptions

public enum RelaunchMode { // if [local] target process has terminated, relaunch it automatically when sending next command to it
    case Always
    case Limited
    case Never
}



// consids/ignores options defined in ASRegistry.h (it's crappy design and a complete mess, but what we're stuck with)

public enum Considerations {
    case Case
    case Diacritic
    case WhiteSpace
    case Hyphens
    case Expansion
    case Punctuation
//  case Replies // TO DO: check if this is ever supplied by AS; if it is, might be an idea to add it; if not, delete
    case NumericStrings
}

public typealias ConsideringOptions = Set<Considerations>



func OSTypeFromString(code: NSString) throws -> OSType { // note: use this instead of UTGetOSTypeFromString to get better error reporting
    if (code.length != 4) {
        throw SwiftAEError(code: 1, message: "Invalid four-char code (wrong length): \(formatValue(code))")
    }
    guard let data = code.dataUsingEncoding(NSMacOSRomanStringEncoding) else {
        throw SwiftAEError(code: 1, message: "Invalid four-char code (bad encoding): \(formatValue(code))")
    }
    var tmp: UInt32 = 0
    data.getBytes(&tmp, length: 4)
    return CFSwapInt32HostToBig(tmp)
}


