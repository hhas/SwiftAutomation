//
//  Errors.swift
//  SwiftAutomation
//

import Foundation

// TO DO: how best to compose/chain exceptions?


// TO DO: Swift docs recommend simple Errors are implemented as enums and complex Errors as structs (presumably using protocols instead of inheritance to describe related errors); what if any benefit would this provide over current classes? TBH, except for Application.init() errors, the only error type user should see directly is CommandError (except maybe when a command is called on an untargeted specifier, as that's an obvious implementation error on the client's part); deeper errors such as PackError, UnpackError, and NSErrors thrown by underlying Cocoa APIs (e.g. when an Apple Event Manager error occurs) should be wrapped in that before being returned by the command.

// Note that OSStatus codes are inherent to Apple event IPC and completely arbitrary (since apps are free to define their own codes as well as use the standard Carbon/AE error codes), so cannot be mapped to enums themselves. Client code that needs to know _why_ an error occurred will need to check the CommandError's error number against known error codes to determine the cause. (TO DO: Not sure if there's any way to do this within a do...catch block's own limited pattern matching capabilities, so clients will probably need to catch the error first then pass its code to a switch block to dispatch accordingly.)

// TO DO: could do with utility function that produces readable error string given an NSError (code + localizedDescription) or Error (description)



let gDescriptionForError: [Int:String] = [ // error descriptions from ASLG/MacErrors.h
        // OS errors
        -34: "Disk is full.",
        -35: "Disk wasn't found.",
        -37: "Bad name for file.",
        -38: "File wasn't open.",
        -39: "End of file error.",
        -42: "Too many files open.",
        -43: "File wasn't found.",
        -44: "Disk is write protected.",
        -45: "File is locked.",
        -46: "Disk is locked.",
        -47: "File is busy.",
        -48: "Duplicate file name.",
        -49: "File is already open.",
        -50: "Parameter error.",
        -51: "File reference number error.",
        -61: "File not open with write permission.",
        -108: "Out of memory.",
        -120: "Folder wasn't found.",
        -124: "Disk is disconnected.",
        -128: "User canceled.",
        -192: "A resource wasn't found.",
        -600: "Application isn't running.",
        -601: "Not enough room to launch application with special requirements.",
        -602: "Application is not 32-bit clean.",
        -605: "More memory is needed than is specified in the size resource.",
        -606: "Application is background-only.",
        -607: "Buffer is too small.",
        -608: "No outstanding high-level event.",
        -609: "Connection is invalid.",
        -610: "No user interaction allowed.",
        -904: "Not enough system memory to connect to remote application.",
        -905: "Remote access is not allowed.",
        -906: "Application isn't running or program linking isn't enabled.",
        -915: "Can't find remote machine.",
        -30720: "Invalid date and time.",
        // AE errors
        -1700: "Can't make some data into the expected type.",
        -1701: "Some parameter is missing for command.",
        -1702: "Some data could not be read.",
        -1703: "Some data was the wrong type.",
        -1704: "Some parameter was invalid.",
        -1705: "Operation involving a list item failed.",
        -1706: "Need a newer version of the Apple Event Manager.",
        -1707: "Event isn't an Apple event.",
        -1708: "Application could not handle this command.",
        -1709: "AEResetTimer was passed an invalid reply.",
        -1710: "Invalid sending mode was passed.",
        -1711: "User canceled out of wait loop for reply or receipt.",
        -1712: "Apple event timed out.",
        -1713: "No user interaction allowed.",
        -1714: "Wrong keyword for a special function.",
        -1715: "Some parameter wasn't understood.",
        -1716: "Unknown Apple event address type.",
        -1717: "The handler is not defined.",
        -1718: "Reply has not yet arrived.",
        -1719: "Can't get reference. Invalid index.",
        -1720: "Invalid range.",
        -1721: "Wrong number of parameters for command.",
        -1723: "Can't get reference. Access not allowed.",
        -1725: "Illegal logical operator called.",
        -1726: "Illegal comparison or logical.",
        -1727: "Expected a reference.",
        -1728: "Can't get reference.",
        -1729: "Object counting procedure returned a negative count.",
        -1730: "Container specified was an empty list.",
        -1731: "Unknown object type.",
        -1739: "Attempting to perform an invalid operation on a null descriptor.",
        // Application scripting errors
        -10000: "Apple event handler failed.",
        -10001: "Type error.",
        -10002: "Invalid key form.",
        -10003: "Can't set reference to given value. Access not allowed.",
        -10004: "A privilege violation occurred.",
        -10005: "The read operation wasn't allowed.",
        -10006: "Can't set reference to given value.",
        -10007: "The index of the event is too large to be valid.",
        -10008: "The specified object is a property, not an element.",
        -10009: "Can't supply the requested descriptor type for the data.",
        -10010: "The Apple event handler can't handle objects of this class.",
        -10011: "Couldn't handle this command because it wasn't part of the current transaction.",
        -10012: "The transaction to which this command belonged isn't a valid transaction.",
        -10013: "There is no user selection.",
        -10014: "Handler only handles single objects.",
        -10015: "Can't undo the previous Apple event or user action.",
        -10023: "Enumerated value is not allowed for this property.",
        -10024: "Class can't be an element of container.",
        -10025: "Illegal combination of properties settings."
]

let defaultErrorCode = 1
let packErrorCode = errAECoercionFail
let unpackErrorCode = errAECoercionFail


// errors

public class SwiftAutomationError: Error, CustomStringConvertible { // TO DO: support error chaining // TO DO: rename `AutomationError?`
    public let _domain = "SwiftAutomation"
    public let _code: Int // TO DO: use custom codes for error types, or standard OSStatus codes? // TO DO: should probably have a default code (e.g. 1) for non-OSStatus errors, and otherwise use OSStatus when known
    private let _message: String?
    public let cause: Error?
    
    init(code: Int, message: String? = nil, cause: Error? = nil) {
        self._code = code
        self._message = message
        self.cause = cause
    }
    
    public var message: String? { return self._message }
    
    public var description: String {
        let msg = self.message ?? gDescriptionForError[self._code]
        var string = msg == nil ? "." : ": \(msg!)"
        if let cause = self.cause { string += "\n\(cause)" }
        return "Error \(self._code)\(string)"
    }
}

public class NotImplementedError: SwiftAutomationError {
    convenience init(message: String? = nil) {
        self.init(code: defaultErrorCode, message: "Not Implemented Error" + (message == nil ? "." : ": \(message!)"))
    }
}


public class ConnectionError: SwiftAutomationError {
    
    public let target: TargetApplication
    
    init(target: TargetApplication, message: String = "Can't connect to application.") {
        self.target = target
        super.init(code: defaultErrorCode, message: message)
    }
    
    // TO DO: description?
}


public class PackError: SwiftAutomationError { // TO DO: include AppData? (c.f. UnpackError)
    
    let object: Any
    
    init(object: Any, message: String? = nil) {
        self.object = object
        super.init(code: packErrorCode, message: message) // TO DO: what error code?
    }
    
    public override var description: String {
        return "Error \(self._code): Can't pack value:\n\n\t\(self.object)" + (self.message == nil ? "" : "\n\n\(self.message!)")
    }
}

public class UnpackError: SwiftAutomationError {
    
    let type: Any
    let appData: AppData
    let descriptor: NSAppleEventDescriptor
    
    // TO DO: method for trying to unpack desc as Any; this should be used when constructing full error message (might also be useful to caller)
    init(appData: AppData, descriptor: NSAppleEventDescriptor, type: Any, message: String? = nil) {
        self.appData = appData
        self.descriptor = descriptor
        self.type = type
        super.init(code: unpackErrorCode, message: message) // TO DO: what error code?
    }
    
    public override var description: String { // TO DO: how best to phrase error message?
        var value: Any = self.descriptor
        var msg: String = "Can't unpack value as \(self.type)"
        do {
            value = try self.appData.unpack(self.descriptor)
        } catch {
            msg = "Can't unpack descriptor as \(self.type)" // TO DO: this message is potentially misleading: if it fails here, it's because the descriptor can't be unpacked at all without an error occurring (i.e. the descriptor's a known type but its data is fatally malformed), as opposed to failing because it can't be coerced to the Swift type specified by caller (e.g. caller specified Int but app returned a non-numeric String)
        }
        return "Error \(self._code): \(msg):\n\n\t\(value)" + (self.message == nil ? "" : "\n\n\(self.message!)")
    }
}

public class CommandSubError: SwiftAutomationError {}


public class CommandError: SwiftAutomationError { // note: this should wrap all errors occuring in a command, including pack/unpack (which aren't application errors, but will be easier for user to debug with the additional context)
    
    let commandInfo: CommandDescription // TO DO: this should always be given
    let appData: AppData
    let event: NSAppleEventDescriptor? // non-nil if event was built and send
    let reply: NSAppleEventDescriptor? // non-nil if reply event was received
    
    // TO DO:
    
    init(commandInfo: CommandDescription, appData: AppData,
         event: NSAppleEventDescriptor? = nil, reply: NSAppleEventDescriptor? = nil, cause: Error? = nil) {
        self.appData = appData
        self.event = event
        self.reply = reply
        self.commandInfo = commandInfo
        var errorNumber = 1
        if let error = cause {
//            print("! DEBUG: SwiftAutomation/AppleEventManager error: \(error)")
            errorNumber = error._code
        } else if let replyEvent = reply {
//            print("! DEBUG: App reply event: \(reply)")
            if let appError = replyEvent.forKeyword(_keyErrorNumber) {
                errorNumber = Int(appError.int32Value)
                // TO DO: [lazily] unpack any other available error info
            }
        }
        if errorNumber == 0 { errorNumber = defaultErrorCode } // should never be 0; TO DO: assert?
        super.init(code: errorNumber, cause: cause)
    }
    
    public override var message: String? {
        return (self.reply?.forKeyword(_keyErrorString)?.stringValue
                ?? self.reply?.forKeyword(_kOSAErrorBriefMessage)?.stringValue
                ?? gDescriptionForError[self._code])
    }
    
    public var expectedType: Symbol? {
        if let desc = self.reply?.forKeyword(_kOSAErrorExpectedType) {
            return try? self.appData.unpack(desc) as Symbol
        } else {
            return nil
        }
    }
    
    public var offendingObject: Any? {
        if let desc = self.reply?.forKeyword(_kOSAErrorOffendingObject) {
            return try? self.appData.unpack(desc) as Any
        } else {
            return nil
        }
    }
    
    public override var description: String {
        var string = "CommandError \(self._code): \(self.message ?? "")\n\n\t"
        string += self.appData.formatter.formatCommand(self.commandInfo, applicationObject: self.appData.application)
        // TO DO: expectedType and/or offendingObject, if given
        return string
    }
    
    /*
    let _kOSAErrorApp: OSType = 0x65726170
    let _kOSAErrorArgs: OSType = 0x65727261
    let _kOSAErrorBriefMessage: OSType = 0x65727262
    let _kOSAErrorExpectedType: OSType = 0x65727274
    let _kOSAErrorMessage: OSType = 0x65727273
    let _kOSAErrorNumber: OSType = 0x6572726E
    let _kOSAErrorOffendingObject: OSType = 0x65726F62
    let _kOSAErrorPartialResult: OSType = 0x70746C72
    let _kOSAErrorRange: OSType = 0x65726E67
    */
}

