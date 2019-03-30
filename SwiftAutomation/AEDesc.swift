//
//  AEDesc.swift
//  SwiftAutomation
//
//

/*
     final class Ref<T> {
      var val : T
      init(_ v : T) {val = v}
    }

    struct Box<T> {
        var ref : Ref<T>
        init(_ x : T) { ref = Ref(x) }

        var value: T {
            get { return ref.val }
            set {
              if (!isKnownUniquelyReferenced(&ref)) {
                ref = Ref(newValue)
                return
              }
              ref.val = newValue
            }
        }
    }
 */

import Foundation
import AppKit
import Carbon



class AEDescriptor: CustomDebugStringConvertible { // memory-managed AEDesc; use `AEDescriptor.desc` to access underlying AEDesc

    var debugDescription: String {
        return "<AEDescriptor \(formatFourCharCode(self.desc.descriptorType))>"
    }
    
    private(set) var desc = nullDescriptor
    private let owner: Bool
    
    convenience init() {
        self.init(desc: nullDescriptor, owner: false) // no disposal needed as dataHandle is nil
    }
    
    required init(desc: AEDesc, owner: Bool = true) {
        self.desc = desc
        self.owner = owner
    }
    
    deinit {
        if self.owner { AEDisposeDesc(&self.desc) }
    }
    
    // TO DO: what, if any, methods should be implemented here?
    
    func coerce(to descriptorType: DescType) throws -> AEDescriptor {
        return try type(of: self).init(desc: self.desc.coerce(to: descriptorType))
    }
}


//

    
extension AEDesc: CustomStringConvertible, CustomDebugStringConvertible {
    
    public var description: String {
        return "<AEDesc \(formatFourCharCode(self.descriptorType))>"
    }
    public var debugDescription: String {
        return "<AEDesc \(formatFourCharCode(self.descriptorType))>"
    }
}
    
public extension AEDesc {
    
    init(bool value: Bool) {
        self = value ? trueDescriptor : falseDescriptor
    }
    
    init(int32 value: Int32) {
        self = packFixedSize(value, as: typeSInt32)
    }
    init(uint32 value: UInt32) {
        self = packFixedSize(value, as: typeUInt32)
    }
    
    init(int64 value: Int64) {
        self = packFixedSize(value, as: typeSInt64)
    }
    init(uint64 value: UInt64) {
        self = packFixedSize(value, as: typeUInt64)
    }
    
    init(int value: Int) { // caution: this assumes Int/UInt is always 64-bit
        self.init(int64: Int64(value))
    }
    init(uint value: UInt) { // ditto
        self.init(uint64: UInt64(value))
    }
    
    init(double value: Double) {
        self = packFixedSize(value, as: typeIEEE64BitFloatingPoint)
    }
    
    init(string value: String) {
        self = nullDescriptor
        // TO DO: withCString isn't really safe to use here, as nul chars are possible
        value.withCString { try! throwIfError(AECreateDesc(typeUTF8Text, $0, value.utf8.count, &self)) }
    }
    
    init(date value: Date) {
        var delta = Int64(value.timeIntervalSinceReferenceDate - epochDelta)
        self = nullDescriptor
        try! throwIfError(AECreateDesc(typeLongDateTime, &delta, MemoryLayout.size(ofValue: delta), &self))
    }
    
    init(fileURL value: URL) throws {
        if !value.isFileURL { throw AutomationError(code: errAECoercionFail) }
        self = try value.withUnsafeFileSystemRepresentation {
            var desc = nullDescriptor
            try throwIfError(AECreateDesc(typeFileURL, $0, strlen($0!)+1, &desc))
            return desc
        }
    }
    
    init(typeCode code: OSType) {
        self = packFixedSize(code, as: typeType)
    }
    
    init(enumCode code: OSType) {
        self = packFixedSize(code, as: typeEnumerated)
    }
    
    init(type: DescType, code: OSType) { // other four-char codes
        self = packFixedSize(code, as: type)
    }
    
    static func list() -> AEDesc {
        var desc = nullDescriptor
        AECreateList(nil, 0, false, &desc)
        return desc
    }
    
    static func record(as descriptorType: DescType = typeAERecord) -> AEDesc {
        var desc = nullDescriptor
        AECreateList(nil, 0, true, &desc)
        desc.descriptorType = descriptorType
        return desc
    }
    
    static var currentProcess: AEDesc {
        let value = ProcessSerialNumber(highLongOfPSN: 0, lowLongOfPSN: UInt32(kCurrentProcess))
        return packFixedSize(value, as: typeProcessSerialNumber)
    }
    
    init(processIdentifier value: pid_t) {
        self = packFixedSize(value, as: typeKernelProcessID)
    }
    
    init(applicationURL value: URL) throws { // TO DO: check URL is valid
        self = try value.absoluteString.utf8CString.withUnsafeBufferPointer {
            var desc = nullDescriptor
            try throwIfError(AECreateDesc(typeApplicationURL, $0.baseAddress!, strlen($0.baseAddress!)+1, &desc))
            return desc
        }
    }
}


public extension AEDesc {
    
    func bool() throws -> Bool {
        var desc = self
        switch desc.descriptorType {
        case typeTrue:
            return true
        case typeFalse:
            return false
        case typeBoolean:
            var result: Bool = false
            // TO DO: validate desc size? (this code assumes it's same size as Swift Bool, 1 byte)
            try throwIfError(AEGetDescData(&desc, &result, MemoryLayout<Bool>.size))
            return result
        default:
            return try unpackFixedSize(desc, as: typeBoolean)
        }
    }
    
    func int32() throws -> Int32 {
        return try unpackFixedSize(self, as: typeSInt32)
    }
    
    func uint32() throws -> UInt32 {
        return try unpackFixedSize(self, as: typeUInt32)
    }
    
    func int() throws -> Int {
        switch self.descriptorType {
        case typeSInt32:
            return try Int(self.int32())
        default:
            return try Int(unpackFixedSize(self, as: typeSInt64) as Int64) // TO DO: this assumes a 64-bit machine
        }
    }
    
    func uint() throws -> UInt {
        switch self.descriptorType {
        case typeSInt32:
            return try UInt(self.int32())
        default:
            return try UInt(unpackFixedSize(self, as: typeUInt64) as UInt64) // TO DO: this assumes a 64-bit machine
        }
    }
    
    func double() throws -> Double {
        return try unpackFixedSize(self, as: typeIEEE64BitFloatingPoint)
    }
    
    func string() throws -> String {
        // TO DO: Swift 5 uses UTF8 internally; Carbon/Cocoa apps use typeUnicodeText; what's most efficient approach to use here?
        var desc = self
        switch desc.descriptorType {
            // typeUnicodeText: native endian UTF16 with optional BOM (deprecated, but still in common use)
            // typeUTF16ExternalRepresentation: big-endian 16 bit unicode with optional byte-order-mark,
        //                                  or little-endian 16 bit unicode with required byte-order-mark
        case typeUnicodeText, typeUTF16ExternalRepresentation: // UTF-16 BE/LE
            let size = AEGetDescDataSize(&desc)
            if size < 2 { return "" } // can't be anything except empty string (or malformed UTF16)…
            var bom: UInt16 = 0 // …else check for BOM before decoding
            let encoding: String.Encoding
            try throwIfError(AEGetDescData(&desc, &bom, MemoryLayout.size(ofValue: bom)))
            switch bom {
            case 0xFEFF:
                encoding = .utf16BigEndian
            case 0xFFFE:
                encoding = .utf16LittleEndian
            default: // no BOM; if typeUnicodeText use platform endianness, else it's big-endian typeUTF16ExternalRepresentation
                encoding = (desc.descriptorType == typeUnicodeText && isLittleEndianHost) ? .utf16LittleEndian : .utf16BigEndian
            }
            let buffer = UnsafeMutableRawPointer.allocate(byteCount: size, alignment: 0)
            try throwIfError(AEGetDescData(&desc, buffer, size))
            if let result = String(bytesNoCopy: buffer, length: size, encoding: encoding, freeWhenDone: true) {
                return result
            }
        case typeUTF8Text:
            let size = AEGetDescDataSize(&desc)
            let buffer = UnsafeMutableRawPointer.allocate(byteCount: size, alignment: 0)
            try throwIfError(AEGetDescData(&desc, buffer, size))
            if let result = String(bytesNoCopy: buffer, length: size, encoding: .utf8, freeWhenDone: true) {
                return result
            }
        default:
            var newDesc = try desc.coerce(to: typeUTF8Text)
            defer { AEDisposeDesc(&newDesc) }
            let size = AEGetDescDataSize(&newDesc)
            let buffer = UnsafeMutableRawPointer.allocate(byteCount: size, alignment: 0)
            try throwIfError(AEGetDescData(&newDesc, buffer, size))
            if let result = String(bytesNoCopy: buffer, length: size, encoding: .utf8, freeWhenDone: true) {
                return result
            }
        }
        throw AutomationError(code: errAECoercionFail)
    }
    
    func date() throws -> Date {
        var desc = self
        let delta: TimeInterval
        switch desc.descriptorType {
        case typeLongDateTime: // assumes data handle is valid for descriptor type
            var result: Int64!
            try throwIfError(AEGetDescData(&desc, &result, MemoryLayout<Int64>.size))
            delta = TimeInterval(result)
        default:
            delta = TimeInterval(try unpackFixedSize(desc, as: typeLongDateTime) as Int64)
        }
        return Date(timeIntervalSinceReferenceDate: delta + epochDelta)
    }
    
    func fileURL() throws -> URL { // file:// URL
        var desc = self
        switch desc.descriptorType {
        case typeFileURL:
            let size = AEGetDescDataSize(&desc)
            let buffer = UnsafeMutablePointer<Int8>.allocate(capacity: size)
            try throwIfError(AEGetDescData(&desc, buffer, size))
            return URL(fileURLWithFileSystemRepresentation: buffer, isDirectory: false, relativeTo: nil)
        default:
            var newDesc = nullDescriptor
            try throwIfError(AECoerceDesc(&desc, typeFileURL, &newDesc))
            defer { AEDisposeDesc(&newDesc) }
            return try newDesc.fileURL()
        }
    }
    
    var data: Data {
        var desc = self
        let size = AEGetDescDataSize(&desc)
        let buffer = UnsafeMutableRawPointer.allocate(byteCount: size, alignment: 0)
        try! throwIfError(AEGetDescData(&desc, buffer, size))
        return Data(bytesNoCopy: buffer, count: size, deallocator: .free)
    }
    
    // TO DO: combine typeCode and enumCode into fourCharCode?
    
    func typeCode() throws -> OSType {
        var desc = self
        switch desc.descriptorType {
        case typeType, typeProperty, typeKeyword:
            var result: OSType = 0
            try throwIfError(AEGetDescData(&desc, &result, MemoryLayout<OSType>.size))
            return result
        default:
            return try unpackFixedSize(desc, as: typeType)
        }
    }
    
    func enumCode() throws -> OSType {
        return try unpackFixedSize(self, as: typeEnumerated)
    }
    
    func fourCharCode() throws -> OSType {
        switch self.descriptorType {
        case typeType, typeEnumerated, typeProperty, typeKeyword:
            return try unpackFixedSize(self, as: self.descriptorType)
        default:
            return try unpackFixedSize(self, as: typeType)
        }
    }
}


public extension AEDesc {
    
    struct SendOptions: OptionSet {
        
        public let rawValue: AESendMode
        
        public static let noReply                = SendOptions(rawValue: 0x00000001) /* sender doesn't want a reply to event */
        public static let queueReply             = SendOptions(rawValue: 0x00000002) /* sender wants a reply but won't wait */
        public static let waitForReply           = SendOptions(rawValue: 0x00000003) /* sender wants a reply and will wait */
    //  public static let dontReconnect          = SendOptions(rawValue: 0x00000080 /* don't reconnect if there is a sessClosedErr from PPCToolbox */
    //  public static let wantReceipt            = SendOptions(rawValue: 0x00000200 /* (nReturnReceipt) sender wants a receipt of message */
        public static let neverInteract          = SendOptions(rawValue: 0x00000010) /* server should not interact with user */
        public static let canInteract            = SendOptions(rawValue: 0x00000020) /* server may try to interact with user */
        public static let alwaysInteract         = SendOptions(rawValue: 0x00000030) /* server should always interact with user where appropriate */
        public static let canSwitchLayer         = SendOptions(rawValue: 0x00000040) /* interaction may switch layer */
        public static let dontRecord             = SendOptions(rawValue: 0x00001000) /* don't record this event - available only in vers 1.0.1 and greater */
        public static let dontExecute            = SendOptions(rawValue: 0x00002000) /* don't send the event for recording */
        public static let processNonReplyEvents  = SendOptions(rawValue: 0x00008000) /* allow processing of non-reply events while awaiting synchronous AppleEvent reply */
        public static let dontAnnotate           = SendOptions(rawValue: 0x00010000) /* if set, don't automatically add any sandbox or other annotations to the event */
        public static let defaultOptions         = SendOptions(rawValue: 0x00000023) // [.waitForReply, .canInteract]
        
        public init(rawValue: AESendMode) { self.rawValue = rawValue }
    }
    
    init(eventClass: AEEventClass, eventID: AEEventID, target: AEDesc? = nil,
         returnID: AEReturnID = AEReturnID(kAutoGenerateReturnID),
         transactionID: AETransactionID = AETransactionID(kAnyTransactionID)) {
        var appleEvent = nullDescriptor
        var address = target ?? nullDescriptor
        try! throwIfError(AECreateAppleEvent(eventClass, eventID, &address, returnID, transactionID, &appleEvent))
        self = appleEvent
    }
    
    
    //kAEDefaultTimeout = -1
    //kNoTimeOut = -2

    func sendEvent(options: SendOptions = .defaultOptions, timeout: TimeInterval = -1) throws -> AEDesc { // TO DO: how to provide .neverTimeout, .defaultTimeout constants? (probably best to define timeout arg as enum)
        var appleEvent = self
        var replyEvent = nullDescriptor
        try throwIfError(AESendMessage(&appleEvent, &replyEvent, options.rawValue, Int(timeout > 0 ? timeout * 60 : timeout))) // timeout in ticks // TO DO: if timeout > 0 && timeout < 1/60 then round up to 1 tick
        return replyEvent
    }
}


    
public extension AEDesc {
    
    func coerce(to descriptorType: DescType) throws -> AEDesc { // caller takes ownership of returned AEDesc
        var newDesc = nullDescriptor
        var desc = self
        try throwIfError(AECoerceDesc(&desc, descriptorType, &newDesc))
        return newDesc
    }
    
    var isRecord: Bool {
        var desc = self
        return AECheckIsRecord(&desc)
    }
    
    //
    
    // TO DO: setParameter() shouldn't need to throw; what about deleteParam?
    
    func parameter(_ keyword: AEKeyword, as descriptorType: DescType = typeWildCard) throws -> AEDesc {
        var result = nullDescriptor
        var desc = self
        try throwIfError(AEGetParamDesc(&desc, keyword, descriptorType, &result))
        return result
    }
    
    func setParameter(_ keyword: AEKeyword, to valueDesc: AEDesc) throws {
        var desc = self
        var valueDesc = valueDesc
        try throwIfError(AEPutParamDesc(&desc, keyword, &valueDesc))
    }
    
    func deleteParameter(_ keyword: AEKeyword) throws {
        var desc = self
        try throwIfError(AEDeleteParam(&desc, keyword))
    }
    
    func attribute(_ keyword: AEKeyword, as descriptorType: DescType = typeWildCard) throws -> AEDesc {
        var result = nullDescriptor
        var desc = self
        try throwIfError(AEGetAttributeDesc(&desc, keyword, descriptorType, &result))
        return result
    }
    
    func setAttribute(_ keyword: AEKeyword, to valueDesc: AEDesc) throws {
        var desc = self
        var valueDesc = valueDesc
        try throwIfError(AEPutAttributeDesc(&desc, keyword, &valueDesc)) // throws if valueDesc is wrong type
    }
    
    //
    
    func count() throws -> Int {
        var result = 0
        var desc = self
        try throwIfError(AECountItems(&desc, &result)) // TO DO: confirm this throws if not list/record
        return result
    }
    
    func item(_ index: Int, as descriptorType: DescType = typeWildCard) throws -> (key: AEKeyword, value: AEDesc) {
        var keyword: AEKeyword = 0
        var result = nullDescriptor
        var desc = self
        try throwIfError(AEGetNthDesc(&desc, index, typeWildCard, &keyword, &result)) // errors if index < 1 or index > count
        return (keyword, result)
    }
    
    func setItem(_ index: Int, to valueDesc: AEDesc) throws {
        var desc = self
        var valueDesc = valueDesc
        try throwIfError(AEPutDesc(&desc, index, &valueDesc)) // errors if index < 0 or index > count; TO DO: confirm this throws if not a valid list desc
    }
    
    func appendItem(_ valueDesc: AEDesc) throws {
        try self.setItem(0, to: valueDesc)
    }
    
    func deleteItem(_ index: Int) throws {
        var desc = self
        try throwIfError(AEDeleteItem(&desc, index)) // errors if index < 1 or index > count
    }

    
    
}




// support

func formatFourCharCode(_ code: OSType) -> String {
    var bigCode = CFSwapInt32HostToBig(code)
    var result = ""
    for _ in 0..<MemoryLayout.size(ofValue: code) {
        let c = bigCode % 256
        if c < 32 || c > 126 || c == 0x27 || c == 0x5c { // backslash, single quote
            return String(format: "0x%08x", code)
        }
        result += String(format: "%c", c)
        bigCode >>= 8
    }
    return "'\(result)'"
}


let nullDescriptor = AEDesc(descriptorType: typeNull, dataHandle: nil)

let trueDescriptor = AEDesc(descriptorType: typeTrue, dataHandle: nil)
let falseDescriptor = AEDesc(descriptorType: typeFalse, dataHandle: nil)


internal func unpackFixedSize<T>(_ desc: AEDesc, as descType: DescType) throws -> T { // coerces to specified type before unpacking
    var result: T
    var desc = desc
    let size = MemoryLayout<T>.size
    var ptr = UnsafeMutablePointer<T>.allocate(capacity: 1)
    if AEGetDescDataSize(&desc) != size { // this assumes Swift types are same byte size as C types
        throw AutomationError(code: errAECorruptData, message: "Error unpacking <AEDesc \(formatFourCharCode(desc.descriptorType))> as \(T.self): expected \(size) bytes but found \(AEGetDescDataSize(&desc))")
    }
    if desc.descriptorType == descType {
        try throwIfError(AEGetDescData(&desc, ptr, size))
    } else {
        var newDesc = nullDescriptor
        try throwIfError(AECoerceDesc(&desc, descType, &newDesc))
        defer { AEDisposeDesc(&newDesc) }
        try throwIfError(AEGetDescData(&newDesc, ptr, size))
    }
    result = ptr.pointee
    print("unpack \(desc) as \(formatFourCharCode(descType)) returned: \(result as Any)")
    return ptr.pointee
}

internal func packFixedSize<T>(_ value: T, as descType: DescType) -> AEDesc {
    var desc = nullDescriptor
    var value = value
    try! throwIfError(AECreateDesc(descType, &value, MemoryLayout.size(ofValue: value), &desc))
    return desc
}

internal func throwIfError<T: SignedInteger>(_ error: T, loc: String = #function) throws { // throws if Carbon function returned error code (OSErr/OSStatus/Int)
    if error != 0 {
        print(loc, "throwIfError:", error) // DEBUG // TO DO: delete
        throw AutomationError(code: Int(error))
    }
}

internal var isLittleEndianHost: Bool {
    let n: UInt16 = 1
    return n.littleEndian == n
}

// typeLongDateTime = no. of seconds before/since classic Mac OS epoch (beginning of first leap year of 20th century)
internal let epochDelta: TimeInterval = 35430.0 * 24 * 3600; // 1/1/1904 -> 1/1/2001

internal let cMissingValue: DescType = 0x6D736E67 // 'msng'





//
/*

extension AEError {
    // convenience constructors
 
    static var userCanceled               : AEError { return self.init(-128) } // "User canceled.",
    static var resourceNotFound           : AEError { return self.init(-192) } // "A resource wasn't found.",
    static var processNotFound            : AEError { return self.init(-600) } // "Application isn't running.",
    static var appIsDaemon                : AEError { return self.init(-606) } // "Application is background-only.",
    static var connectionInvalid          : AEError { return self.init(-609) } // "Connection is invalid.",
    static var noUserInteractionAllowed   : AEError { return self.init(-610) } // "No user interaction allowed.",
    static var remoteAccessNotAllowed     : AEError { return self.init(-905) } // "Remote access is not allowed.",
    static var remoteProcessNotFound      : AEError { return self.init(-906) } // "Application isn't running or program linking isn't enabled.",
    static var remoteMachineNotFound      : AEError { return self.init(-915) } // "Can't find remote machine.",
    static var invalidDateTime            : AEError { return self.init(-30720) } // "Invalid date and time.",
    // AE errors
    static var coercionFailed             : AEError { return self.init(-1700) } // errAECoercionFail
    static var parameterNotFound          : AEError { return self.init(-1701) } // errAEDescNotFound
    static var corruptData                : AEError { return self.init(-1702) } // errAECorruptData
    static var wrongDataType              : AEError { return self.init(-1703) } // errAEWrongDataType
    static var invalidParameter           : AEError { return self.init(-1704) } // errAENotAEDesc
    static var listItemNotFound           : AEError { return self.init(-1705) } // errAEBadListItem
    static var invalidAppleEvent          : AEError { return self.init(-1706) } // errAENotAppleEvent
    static var eventNotHandled            : AEError { return self.init(-1708) } // errAEEventNotHandled
    //errAEReplyNotValid            = -1709, /* AEResetTimer was passed an invalid reply parameter */
    //errAEUnknownSendMode          = -1710, /* mode wasn't NoReply, WaitReply, or QueueReply or Interaction level is unknown */
    static var eventTimedOut              : AEError { return self.init(-1712) } // errAETimeout
    static var userInteractionNotAllowed  : AEError { return self.init(-1713) } // errAENoUserInteraction
    //errAENotASpecialFunction      = -1714, /* there is no special function for/with this keyword */
    //errAEParamMissed              = -1715, /* a required parameter was not accessed */
    //errAEUnknownAddressType       = -1716, /* the target address type is not known */
    //errAEHandlerNotFound          = -1717, /* no handler in the dispatch tables fits the parameters to AEGetEventHandler or AEGetCoercionHandler */
    //errAEReplyNotArrived          = -1718, /* the contents of the reply you are accessing have not arrived yet */
    static var invalidIndex               : AEError { return self.init(-1719) } // errAEIllegalIndex
    static var invalidRange               : AEError { return self.init(-1720) } // errAEImpossibleRange /* A range like 3rd to 2nd, or 1st to all. */
    //errAEWrongNumberArgs          = -1721, /* Logical op kAENOT used with other than 1 term */
    //errAEAccessorNotFound         = -1723, /* Accessor proc matching wantClass and containerType or wildcards not found */
    //errAENoSuchLogical            = -1725, /* Something other than AND, OR, or NOT */
    //errAEBadTestKey               = -1726, /* Test is neither typeLogicalDescriptor nor typeCompDescriptor */
    //errAENotAnObjSpec             = -1727, /* Param to AEResolve not of type 'obj ' */
    static var objectNotFound             : AEError { return self.init(-1728) } // errAENoSuchObject /* e.g.,: specifier asked for the 3rd, but there are only 2. Basically, this indicates a run-time resolution error. */
    //errAENegativeCount            = -1729, /* CountProc returned negative value */
    //errAEEmptyListContainer       = -1730, /* Attempt to pass empty list as container to accessor */
    //errAEUnknownObjectType        = -1731, /* available only in version 1.0.1 or greater */
    //errAERecordingIsAlreadyOn     = -1732, /* available only in version 1.0.1 or greater */
    //errAEReceiveTerminate         = -1733, /* break out of all levels of AEReceive to the topmost (1.1 or greater) */
    //errAEReceiveEscapeCurrent     = -1734, /* break out of only lowest level of AEReceive (1.1 or greater) */
    //errAEEventFiltered            = -1735, /* event has been filtered, and should not be propogated (1.1 or greater) */
    //errAEDuplicateHandler         = -1736, /* attempt to install handler in table for identical class and id (1.1 or greater) */
    //errAEStreamBadNesting         = -1737, /* nesting violation while streaming */
    //errAEStreamAlreadyConverted   = -1738, /* attempt to convert a stream that has already been converted */
    //errAEDescIsNull               = -1739, /* attempting to perform an invalid operation on a null descriptor */
    //errAEBuildSyntaxError         = -1740, /* AEBuildDesc and friends detected a syntax error */
    //errAEBufferTooSmall           = -1741 /* buffer for AEFlattenDesc too small */
    
    static var userPermissionDenied       : AEError { return self.init(-1743) } // errAEEventNotPermitted
    static var userPermissionRequired     : AEError { return self.init(-1744) } // errAEEventWouldRequireUserConsent
    /*
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
     */
    
    //static func coercionError
}

*/
