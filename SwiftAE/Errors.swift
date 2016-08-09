//
//  Errors.swift
//  SwiftAE
//

import Foundation

// TO DO: how best to compose/chain exceptions?


// TO DO: can/should Errors be implemented as enums? TBH, only error user should see directly is CommandError (though currently sendAppleEvent throws non-CommandError if called on generic specifier); specific errors (which may be SwiftAE or NSError [sub]classes) should be encapsulated in that, and are really only included for informational purposes. Any specialized error handling would be decided according to OSStatus code (which cannot be defined as an enum as it's completely arbitrary) so will require a switch block instead.


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


// errors

public class SwiftAEError: Error, CustomStringConvertible { // TO DO: should all errors be chained? or just CommandError?
    public let _domain = "SwiftAE"
    public let _code: Int // TO DO: use custom codes for error types, or standard OSStatus codes?
    public let message: String?
    
    init(code: Int, message: String? = nil) {
        self._code = code
        self.message = message
    }
    
    public var description: String {
        let msg = self.message ?? gDescriptionForError[self._code]
        return msg == nil ? "Error \(self._code)." : "Error \(self._code): \(msg!)"
    }
}

public class NotImplementedError: SwiftAEError {
    convenience init(message: String? = nil) {
        self.init(code: 1, message: "Not Implemented Error" + (message == nil ? "." : ": \(message!)"))
    }
}


public class ConnectionError: SwiftAEError {
    init(target: TargetApplication, message: String = "Can't connect to application.") { // TO DO: target should be TargetApplication
        super.init(code: 1, message: message)
    }
}


public class PackError: SwiftAEError { // TO DO: include AppData? (c.f. UnpackError)
    
    let object: Any
    
    init(object: Any, message: String? = nil) {
        self.object = object
        super.init(code: -1700, message: message) // TO DO: what error code?
    }
    
    public override var description: String {
        return "Error \(self._code): Can't pack value:\n\n\t\(self.object)" + (self.message == nil ? "" : "\n\n\(self.message!)")
    }
}

public class UnpackError: SwiftAEError {
    
    let type: Any
    let appData: AppData
    let descriptor: NSAppleEventDescriptor
    
    // TO DO: method for trying to unpack desc as Any; this should be used when constructing full error message (might also be useful to caller)
    init(appData: AppData, descriptor: NSAppleEventDescriptor, type: Any, message: String? = nil) {
        self.appData = appData
        self.descriptor = descriptor
        self.type = type
        super.init(code: -1700, message: message) // TO DO: what error code?
    }
    
    public override var description: String { // TO DO: how best to phrase error message?
        var value: Any = self.descriptor
        var msg: String = "Can't unpack value as \(self.type)"
        do {
            value = try self.appData.unpack(self.descriptor)
        } catch {
            msg = "Can't unpack descriptor as \(self.type)"
        }
        return "Error \(self._code): \(msg):\n\n\t\(value)" + (self.message == nil ? "" : "\n\n\(self.message!)")
    }
}

public class CommandError: SwiftAEError {
    
    let appData: AppData
    let event: NSAppleEventDescriptor?
    let replyEvent: NSAppleEventDescriptor?
    let commandInfo: Any? // TO DO
    let parentError: Error?
    
    init(appData: AppData,
            event: NSAppleEventDescriptor? = nil,
            replyEvent: NSAppleEventDescriptor? = nil,
            commandInfo: Any? = nil,
            parentError: Error? = nil, // TO DO: rename
            message: String = "Command failed.")
    {
        var message = message
        self.appData = appData
        self.event = event
        self.replyEvent = replyEvent
        self.commandInfo = commandInfo
        self.parentError = parentError
        message += " " + ((parentError as NSError?)?.localizedDescription ?? "") // TO DO: fix
        
        var errorNumber = 0
        if let error = parentError {
            print("SwiftAE/AEM error: \(error)")
            errorNumber = error._code
        } else if let reply = replyEvent {
            print("App reply event: \(reply)")
            if let appError = reply.forKeyword(keyErrorNumber) {
                errorNumber = Int(appError.int32Value)
                // TO DO: [lazily] unpack any other available error info
            }
        }
        // if errorNumber == 0, report as 'unknown' error? (what code?)
        
        
        super.init(code: errorNumber, message: message) // TO DO: implement
    }


    /* TO DO: update and incorporate this error message construction code (taken from AppleEventBridge)

    let aemError = error as NSError // an AEBCommand-supplied NSError containing (none/some/all?) standard AE error keys in its userInfo dict; these should be replaced by public constants (note that the 'expectedType' value is a typeType descriptor supplied by the application where appropriate, and not to be confused with the Swift Type supplied by the caller via the returnType: argument nor the typeType descriptor supplied via the requestedType: arg)
    
    
    var args = [String]()
    for param in parameters {
        if param.value as? AnyObject !== NoParameter {
            args.append((param.name != nil ? "\(param.name): " : "") + "\(SwiftAEFormatObject(param.value))")
        }
    }
    for (name, value) in [("returnType", returnType), ("waitReply", waitReply as Bool?),
        ("withTimeout", withTimeout), ("considering", considering), ("ignoring", ignoring)] {
            if value != nil {
                args.append("\(name): \(SwiftAEFormatObject(value))")
            }
    }
    let failedCommandDescription = "\(self).\(name)(" + ", ".join(args) + ")"
    var errorDescription = "Application command failed:\n\n\(failedCommandDescription)"
    var info: [NSObject: Any] = [AEBErrorNumber:aemError.code, AEBErrorFailedCommandDescription: failedCommandDescription]
    let errorMessage = aemError.userInfo[kAEMErrorStringKey] ?? AEMDescriptionForError(Int32(aemError.code))
    if errorMessage != nil {
        info[AEBErrorMessage] = errorMessage!
        errorDescription += "\n\nError \(aemError.code): \(errorMessage!)"
    } else {
        errorDescription += "\n\nError \(aemError.code)."
    }
    info[NSLocalizedDescriptionKey] = errorDescription
    if let briefMessage = aemError.userInfo[kAEMErrorBriefMessageKey] {
        info[AEBErrorBriefMessage] = briefMessage
    }
    if let expectedType = aemError.userInfo[kAEMErrorExpectedTypeKey] {
        info[AEBErrorExpectedType] = expectedType // TO DO: also include in message? // TO DO: check if unpacked as AEM or AEB object
    }
    if let offendingObject = aemError.userInfo[kAEMErrorOffendingObjectKey] {
        info[AEBErrorOffendingObject] = offendingObject // TO DO: also include in message? // TO DO: check if unpacked as AEM or AEB object
    }
    if let failedAEMEvent = aemError.userInfo[kAEMErrorFailedEvent] {
        info[AEBErrorFailedAEMEvent] = failedAEMEvent
    }
    throw SwiftAECommandError(domain: kAEMErrorDomain, code: aemError.code, userInfo: info)
    }

    */

    
}

