//
//  Errors.swift
//  SwiftAutomation
//

import Foundation


// TO DO: currently Errors are mostly opaque to client code (even inits are internal only); what (if any) properties should be made public?


/******************************************************************************/
// error descriptions from ASLG/MacErrors.h

private let descriptionForError: [Int:String] = [
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


/******************************************************************************/


let defaultErrorCode = 1
let packErrorCode = errAECoercionFail
let unpackErrorCode = errAECoercionFail


func errorMessage(_ err: Any) -> String {
    switch err {
    case let e as AutomationError:
        return e.message ?? "Error \(e.code)."
    case is NSError:
        return (err as! NSError).localizedDescription
    default:
        return String(describing: err)
    }
}


/******************************************************************************/
// error classes

// base class for all SwiftAutomation-raised errors (not including NSErrors raised by underlying Cocoa APIs)
public class AutomationError: Error, CustomStringConvertible {
    public let _domain = "SwiftAutomation"
    public let _code: Int // the OSStatus if known, or generic error code if not
    public let cause: Error? // the error that triggered this failure, if any
    
    let _message: String?
    
    public init(code: Int, message: String? = nil, cause: Error? = nil) {
        self._code = code
        self._message = message
        self.cause = cause
    }
    
    public var code: Int { return self._code }
    public var message: String? { return self._message } // TO DO: make non-optional?
    
    func description(_ previousCode: Int, separator: String = " ") -> String {
        let msg = self.message ?? descriptionForError[self._code]
        var string = self._code == previousCode ? "" : "Error \(self._code)\(msg == nil ? "." : ": ")"
        if msg != nil { string += msg! }
        if let error = self.cause as? AutomationError {
            string += "\(separator)\(error.description(self._code))"
        } else if let error = self.cause {
            string += "\(separator)\(error)"
        }
        return string
    }

    public var description: String {
        return self.description(0)
    }
}


public class ConnectionError: AutomationError {
    
    public let target: TargetApplication
    
    public init(target: TargetApplication, message: String, cause: Error? = nil) {
        self.target = target
        super.init(code: defaultErrorCode, message: message, cause: cause)
    }
    
    // TO DO: include target description in message?
}


public class PackError: AutomationError {
    
    let object: Any
    
    public init(object: Any, message: String? = nil, cause: Error? = nil) {
        self.object = object
        super.init(code: packErrorCode, message: message, cause: cause)
    }
    
    public override var message: String? {
        return "Can't pack unsupported \(type(of: self.object)) value:\n\n\t\(self.object)"
                + (self._message != nil ? "\n\n\(self._message!)" : "")
    }
}

public class UnpackError: AutomationError {
    
    let type: Any.Type
    let appData: AppData
    let descriptor: NSAppleEventDescriptor
    
    public init(appData: AppData, descriptor: NSAppleEventDescriptor, type: Any.Type, message: String? = nil, cause: Error? = nil) {
        self.appData = appData
        self.descriptor = descriptor
        self.type = type
        super.init(code: unpackErrorCode, message: message, cause: cause)
    }
    
    // TO DO: worth including a method for trying to unpack desc as Any; this should be used when constructing full error message (might also be useful to caller); or what about a var that returns the type it would unpack as? (caveat: that probably won't work so well for AEList/AERecord descs due to their complexity and the obvious challenges of fabricating generic type objects on the fly)
    
    public override var message: String? { // TO DO: how best to phrase error message?
        var value: Any = self.descriptor
        var string = "Can't unpack value as \(self.type)"
        do {
            value = try self.appData.unpackAsAny(self.descriptor)
        } catch {
            string = "Can't unpack malformed descriptor"
        }
        return "\(string):\n\n\t\(value)" + (self._message != nil ? "\n\n\(self._message!)" : "")
    }
}


/******************************************************************************/
// standard command error


public class CommandError: AutomationError { // raised whenever an application command fails
    
    let commandInfo: CommandDescription // TO DO: this should always be given
    let appData: AppData
    let event: NSAppleEventDescriptor? // non-nil if event was built and send
    let reply: NSAppleEventDescriptor? // non-nil if reply event was received
    
    public init(commandInfo: CommandDescription, appData: AppData,
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
                ?? descriptionForError[self._code])
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
    
    public var partialResult: Any? {
        if let desc = self.reply?.forKeyword(_kOSAErrorPartialResult) {
            return try? self.appData.unpack(desc) as Any
        } else {
            return nil
        }
    }
    
    public var commandDescription: String {
        return self.appData.formatter.formatCommand(self.commandInfo, applicationObject: self.appData.application)
    }
    
    public override var description: String {
        var string = "CommandError \(self._code): \(self.message ?? "")\n\n\t\(self.commandDescription)"
        if let expectedType = self.expectedType { string += "\n\n\tExpected type: \(expectedType)" }
        if let offendingObject = self.offendingObject { string += "\n\n\tOffending object: \(offendingObject)" }
        if let error = self.cause as? AutomationError {
            string += "\n\n" + error.description(self._code, separator: "\n\n")
        } else if let error = self.cause {
            string += "\n\n\(error)"
        }
        return string
    }
}

