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
    case None // used in untargeted AppData instances; sendAppleEvent() will raise UntargetedCommandError if called
    
    var isRelaunchable: Bool {
        switch self {
        case .Name, .BundleIdentifier:
            return true
        case .URL(let url):
            return url.fileURL
        default:
            return false
        }
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


// used by AppData.sendAppleEvent() to pack ConsideringOptions as enumConsiderations (old-style) and enumConsidsAndIgnores (new-style) attributes

private let ConsiderationsTable: [(Considerations, NSAppleEventDescriptor, UInt32, UInt32)] = [
    // note: Swift mistranslates considering/ignoring mask constants as Int, not UInt32, so redefine them here
    (.Case,             NSAppleEventDescriptor(enumCode: kAECase),              0x00000001, 0x00010000),
    (.Diacritic,        NSAppleEventDescriptor(enumCode: kAEDiacritic),         0x00000002, 0x00020000),
    (.WhiteSpace,       NSAppleEventDescriptor(enumCode: kAEWhiteSpace),        0x00000004, 0x00040000),
    (.Hyphens,          NSAppleEventDescriptor(enumCode: kAEHyphens),           0x00000008, 0x00080000),
    (.Expansion,        NSAppleEventDescriptor(enumCode: kAEExpansion),         0x00000010, 0x00100000),
    (.Punctuation,      NSAppleEventDescriptor(enumCode: kAEPunctuation),       0x00000020, 0x00200000),
    (.NumericStrings,   NSAppleEventDescriptor(enumCode: kASNumericStrings),    0x00000080, 0x00800000),
]

func packConsideringAndIgnoringFlags(considerations: ConsideringOptions) -> (NSAppleEventDescriptor, NSAppleEventDescriptor) {
    let considerationsListDesc = NSAppleEventDescriptor.listDescriptor()
    var consideringIgnoringFlags: UInt32 = 0
    for (consideration, considerationDesc, consideringMask, ignoringMask) in ConsiderationsTable {
        if considerations.contains(consideration) {
            consideringIgnoringFlags |= consideringMask
            considerationsListDesc.insertDescriptor(considerationDesc, atIndex: 0)
        } else {
            consideringIgnoringFlags |= ignoringMask
        }
    }
    return (considerationsListDesc, UInt32Descriptor(consideringIgnoringFlags)) // old-style flags (list of enums), new-style flags (bitmask)
}



let DefaultLaunchConfiguration = [String:AnyObject]()

func processDescriptorForLocalApplication(url: NSURL, launchOptions: LaunchOptions) throws -> NSAppleEventDescriptor {
    // get a typeKernelProcessID-based AEAddressDesc for the target app, finding and launch it first if not already running;
    // if app can't be found/launched, throws an NSError instead
    let runningProcess = try NSWorkspace.sharedWorkspace().launchApplicationAtURL(url, options: launchOptions, configuration: DefaultLaunchConfiguration)
    return NSAppleEventDescriptor(processIdentifier: runningProcess.processIdentifier)
}


