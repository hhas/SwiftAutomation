//
//  AEDesc.swift
//  SwiftAutomation
//
//

import Carbon

// TO DO: memory management options: AppData.pack() may return new or cached AEDesc; if former, caller should dispose; if latter, owner (Symbol/Specifier) will dispose; one way to distinguish is by defining new AEDesc value type that includes 'cached:Bool' slot; calling its 'dispose' func will be no-op if cached; another option is to define new AEDesc as reference-backed value type (c.f. String, Array, etc) where AppleEventDescriptor instance provides shared backing store (bit leery about this as we generally *don't* want AEDescs using copy-on-write semantics, at least not internally); alternative is to use AppleEventDescriptor instances throughout, although refcounting increases runtime overheads



extension AEDesc: CustomDebugStringConvertible {
    
    func dispose() { // free the AEDesc's dataHandle
        var desc = self
        AEDisposeDesc(&desc)
    }
    
    public var debugDescription: String {
        return "<AEDesc \(formatFourCharCodeLiteral(self.descriptorType))>" // TO DO: AEPrintDescToHandle() depends on deprecated Carbon Handle
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
    
    static var null: AEDesc { return AEDesc(descriptorType: typeNull, dataHandle: nil) }
}


public extension AEDesc {
    
    func bool() throws -> Bool {
        switch self.descriptorType {
        case typeTrue:
            return true
        case typeFalse:
            return false
        case typeBoolean:
            var result: Bool = false
            // TO DO: validate desc size? (this code assumes it's same size as Swift Bool, 1 byte)
            var desc = self
            try throwIfError(AEGetDescData(&desc, &result, MemoryLayout<Bool>.size))
            return result
        default:
            return try self.unpackFixedSize(as: typeBoolean)
        }
    }
    
    func int32() throws -> Int32 {
        return try self.unpackFixedSize(as: typeSInt32)
    }
    
    func uint32() throws -> UInt32 {
        return try self.unpackFixedSize(as: typeUInt32)
    }
    
    func int64() throws -> Int64 {
        switch self.descriptorType {
        case typeSInt32:
            return try Int64(self.int32()) // TO DO: is this any faster than having AEM always coerce to SInt64?
        default:
            return try self.unpackFixedSize(as: typeSInt64)
        }
    }
    
    func uint64() throws -> UInt64 {
        switch self.descriptorType {
        case typeSInt32:
            return try UInt64(self.int32())
        default:
            return try self.unpackFixedSize(as: typeUInt64)
        }
    }
    
    func int() throws -> Int {
        return try Int(self.int64()) // TO DO: this assumes a 64-bit machine
    }
    
    func uint() throws -> UInt {
        return try UInt(self.uint64()) // TO DO: this assumes a 64-bit machine
    }
    
    func double() throws -> Double {
        return try self.unpackFixedSize(as: typeIEEE64BitFloatingPoint)
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
            let buffer = UnsafeMutableRawPointer.allocate(byteCount: size, alignment: 0) // TO DO: fix alignments (see MemoryLayout<T>)
            try throwIfError(AEGetDescData(&desc, buffer, size))
            if let result = String(bytesNoCopy: buffer, length: size, encoding: encoding, freeWhenDone: true) { // TO DO: avoid using bridged Foundation methods
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
        let delta: TimeInterval
        switch self.descriptorType {
        case typeLongDateTime: // assumes data handle is valid for descriptor type
            var result: Int64!
            var desc = self
            try throwIfError(AEGetDescData(&desc, &result, MemoryLayout<Int64>.size))
            delta = TimeInterval(result)
        default:
            delta = TimeInterval(try self.unpackFixedSize(as: typeLongDateTime) as Int64)
        }
        return Date(timeIntervalSinceReferenceDate: delta + epochDelta)
    }
    
    func fileURL() throws -> URL { // file:// URL
        var desc = self
        switch desc.descriptorType {
        case typeFileURL:
            let size = AEGetDescDataSize(&desc)
            let buffer = UnsafeMutablePointer<Int8>.allocate(capacity: size)
            defer { buffer.deallocate() }
            try throwIfError(AEGetDescData(&desc, buffer, size))
            return URL(fileURLWithFileSystemRepresentation: buffer, isDirectory: false, relativeTo: nil) // confirm this does not take ownership
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
        return Data(bytesNoCopy: buffer, count: size, deallocator: .free) // takes ownership
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
            return try self.unpackFixedSize(as: typeType)
        }
    }
    
    func enumCode() throws -> OSType {
        return try self.unpackFixedSize(as: typeEnumerated)
    }
    
    func fourCharCode() throws -> OSType {
        switch self.descriptorType {
        case typeType, typeEnumerated, typeProperty, typeKeyword:
            return try self.unpackFixedSize(as: self.descriptorType)
        default:
            return try self.unpackFixedSize(as: typeType)
        }
    }
    
    func processIdentifier() throws -> pid_t {
        return self.unpackFixedSize(as: typeKernelProcessID)
    }
}



public extension AEDesc { // query components
    
    // caution: constructors should not take ownership of supplied AEDescs
    
    init(desiredClass: DescType, container: AEDesc, keyForm: DescType, keyData: AEDesc) {
        var container = container, keyData = keyData, desc = nullDescriptor
        try! throwIfError(CreateObjSpecifier(desiredClass, &container, keyForm, &keyData, false, &desc))
        self = desc
    }
    
    init(insertionLocation position: DescType, container: AEDesc) {
        let desc = AEDesc.record(as: typeInsertionLoc)
        try! desc.setParameter(keyAEObject, to: container)
        try! desc.packFixedSizeParameter(keyAEPosition, value: position, as: typeEnumerated)
        self = desc
    }
    
    init(rangeStart: AEDesc, rangeStop: AEDesc) {
        var rangeStart = rangeStart, rangeStop = rangeStop, desc = nullDescriptor
        try! throwIfError(CreateRangeDescriptor(&rangeStart, &rangeStop, false, &desc))
        self = desc
    }
    
    init(comparisonTest: DescType, operand1: AEDesc, operand2: AEDesc) {
        var operand1 = operand1, operand2 = operand2, desc = nullDescriptor
        try! throwIfError(CreateCompDescriptor(comparisonTest, &operand1, &operand2, false, &desc))
        self = desc

    }
    init(logicalTest: DescType, operands: AEDescList) {
        var operands = operands, desc = nullDescriptor
        try! throwIfError(CreateLogicalDescriptor(&operands, logicalTest, false, &desc))
        self = desc
    }
    
    // caution: calling code has ownership of returned AEDescs so must ensure their disposal once no longer needed
    // these methods should only throw if called on wrong AEDesc type, or if descriptor is malformed
    
    func objectSpecifier() throws -> (desiredClass: DescType, container: AEDesc, keyForm: DescType, keyData: AEDesc) {
        var container = nullDescriptor
        do {
            let desiredClass = try self.unpackFixedSizeParameter(AEKeyword(keyAEDesiredClass), as: typeType) as DescType
            let keyForm = try self.unpackFixedSizeParameter(AEKeyword(keyAEKeyForm), as: typeEnumerated) as DescType
            container = try self.parameter(AEKeyword(keyAEContainer))
            return (desiredClass, container, keyForm, try self.parameter(AEKeyword(keyAEKeyData)))
        } catch {
            container.dispose()
            throw error
        }
    }
    
    func insertionLocation() throws -> (container: AEDesc, position: DescType) {
        let position = try self.unpackFixedSizeParameter(keyAEPosition, as: typeEnumerated) as DescType
        return (try self.parameter(keyAEObject), position)
    }
    
    func rangeDescriptor() throws -> (rangeStart: AEDesc, rangeStop: AEDesc) {
        var rangeStart = nullDescriptor
        do {
            rangeStart = try self.parameter(AEKeyword(keyAERangeStart)) // TO DO: `as: typeObjSpecifier`?
            return (rangeStart, try self.parameter(AEKeyword(keyAERangeStop))) // TO DO: `as: typeObjSpecifier`?
        } catch {
            rangeStart.dispose()
            throw error
        }
    }
    
    func comparisonTest() throws -> (operator: DescType, operand1: AEDesc, operand2: AEDesc) {
        // TO DO: how much validation should these methods perform? (see also notes in AppData)
        var operand1 = nullDescriptor
        do {
            let op = try self.unpackFixedSizeParameter(AEKeyword(keyAECompOperator), as: typeEnumerated) as DescType
            operand1 = try self.parameter(AEKeyword(keyAEObject1))
            return (op, operand1, try self.parameter(AEKeyword(keyAEObject2)))
        } catch {
            operand1.dispose()
            throw error
        }
    }
    
    func logicalTest() throws -> (operator: DescType, operands: AEDescList) {
        let op = try self.unpackFixedSizeParameter(AEKeyword(keyAELogicalOperator), as: typeEnumerated) as DescType
        return (op, try self.parameter(AEKeyword(keyAEObject), as: typeAEList))
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
    
    var eventClass: AEEventClass {
        return (try? self.unpackFixedSizeAttribute(AEEventClass(keyEventClassAttr), as: typeType)) ?? noOSType
    }
    var eventID: AEEventID {
        return (try? self.unpackFixedSizeAttribute(AEEventID(keyEventIDAttr), as: typeType)) ?? noOSType
    }
    
    //kAEDefaultTimeout = -1
    //kNoTimeOut = -2

    func sendEvent(options: SendOptions = .defaultOptions, timeout: TimeInterval = -1) -> (reply: AEDesc, code: Int) { // TO DO: how to provide .neverTimeout, .defaultTimeout constants? (probably best to define timeout arg as enum) // TO DO: return (AEDesc,OSStatus) instead of throwing
        var appleEvent = self
        var replyEvent = nullDescriptor
        let errorCode = AESendMessage(&appleEvent, &replyEvent, options.rawValue, Int(timeout > 0 ? timeout * 60 : timeout)) // timeout in ticks // TO DO: if timeout > 0 && timeout < 1/60 then round up to 1 tick
        return (replyEvent, Int(errorCode))
    }
    
    var errorNumber: Int {
        return (try? self.unpackFixedSizeParameter(keyErrorNumber, as: typeSInt64)) ?? 0
    }
    
    var errorMessage: String? {
        if let desc = try? self.parameter(keyErrorString) {
            defer { desc.dispose() }
            return try? desc.string()
        }
        return nil
    }
}


    
public extension AEDesc {
    
    func coerce(to descriptorType: DescType) throws -> AEDesc { // caller takes ownership of returned AEDesc
        var result = nullDescriptor
        var desc = self
        try throwIfError(AECoerceDesc(&desc, descriptorType, &result))
        return result
    }
    
    func copy() -> AEDesc {
        var result = nullDescriptor
        var desc = self
        try! throwIfError(AEDuplicateDesc(&desc, &result))
        return result
    }
    
    var isRecord: Bool {
        var desc = self
        return AECheckIsRecord(&desc)
    }
}
    //
    
    
public extension AEDesc { // use on AEDescList/AERecord/AppleEvent only; atomic AEDescs will throw errAEWrongDataType
    
    // caller takes ownership of returned AEDescs
    
    func parameter(_ keyword: AEKeyword, as descriptorType: DescType = typeWildCard) throws -> AEDesc {
        var result = nullDescriptor
        var recordDesc = self
        try throwIfError(AEGetParamDesc(&recordDesc, keyword, descriptorType, &result))
        return result
    }
    
    func setParameter(_ key: AEKeyword, to value: AEDesc) throws {
        var recordDesc = self
        var value = value
        try throwIfError(AEPutParamDesc(&recordDesc, key, &value))
    }
    
    func deleteParameter(_ key: AEKeyword) throws {
        var recordDesc = self
        try throwIfError(AEDeleteParam(&recordDesc, key))
    }
    
    func attribute(_ key: AEKeyword, as descriptorType: DescType = typeWildCard) throws -> AEDesc {
        var result = nullDescriptor
        var appleEvent = self
        try throwIfError(AEGetAttributeDesc(&appleEvent, key, descriptorType, &result))
        return result
    }
    
    func setAttribute(_ key: AEKeyword, to value: AEDesc) throws {
        var appleEvent = self
        var value = value
        try throwIfError(AEPutAttributeDesc(&appleEvent, key, &value)) // (Apple docs) throws if value desc is wrong type for known attribute
    }
    
    //
    
    func count() throws -> Int { // throws errAEWrongDataType if not a list or record; TO DO: use `try!` or `try?` returning 0 (or -1?)?
        var result = 0
        var listDesc = self
        try throwIfError(AECountItems(&listDesc, &result))
        return result
    }
    
    // TO DO: separate methods for getting record property (key+value) vs list item (value only)
    // TO DO: implement iterators? (we can't add IteratorProtocol conformance directly to AEDesc, so iterators would need to be exposed via `var items: AEDescListIterator`)
    // TO DO: should these APIs use zero-indexing (it simplifies math when using them)
    func item(_ index: Int, as descriptorType: DescType = typeWildCard) throws -> (key: AEKeyword, value: AEDesc) {
        var key: AEKeyword = 0
        var result = nullDescriptor
        var listDesc = self
        try throwIfError(AEGetNthDesc(&listDesc, index, typeWildCard, &key, &result)) // errors if index < 1 or index > count
        return (key, result)
    }
    
    func setItem(_ index: Int, to value: AEDesc) throws {
        var listDesc = self
        var value = value
        try throwIfError(AEPutDesc(&listDesc, index, &value)) // errors if index < 0 or index > count; TO DO: confirm this throws if not a valid list desc
    }
    
    func appendItem(_ value: AEDesc) throws {
        try self.setItem(0, to: value)
    }
    
    func deleteItem(_ index: Int) throws {
        var listDesc = self
        try throwIfError(AEDeleteItem(&listDesc, index)) // errors if index < 1 or index > count
    }

    
    
}


internal extension AEDesc {
    
    func packFixedSizeParameter<T>(_ key: AEKeyword, value: T, as descType: DescType) throws {
        var desc = self
        var value = value
        try throwIfError(AEPutParamPtr(&desc, key, descType, &value, MemoryLayout<T>.size))
    }
 
    func unpackFixedSizeParameter<T>(_ key: AEKeyword, as descType: DescType) throws -> T {
        var desc = self
        let ptr = UnsafeMutablePointer<T>.allocate(capacity: 1)
        defer { ptr.deallocate() }
        var size = 0
        try throwIfError(AEGetParamPtr(&desc, key, descType, nil, ptr, MemoryLayout<T>.size, &size))
        return ptr.pointee
    }
    
    func unpackFixedSizeAttribute<T>(_ key: AEKeyword, as descType: DescType) throws -> T {
        var desc = self
        let ptr = UnsafeMutablePointer<T>.allocate(capacity: 1)
        defer { ptr.deallocate() }
        var size = 0
        try throwIfError(AEGetAttributePtr(&desc, key, descType, nil, ptr, MemoryLayout<T>.size, &size))
        return ptr.pointee
    }
    
    func unpackFixedSize<T>(as descType: DescType) throws -> T { // coerces to specified type before unpacking
        var result: T
        var desc = self
        let size = MemoryLayout<T>.size
        var ptr = UnsafeMutablePointer<T>.allocate(capacity: 1)
        defer { ptr.deallocate() }
        if AEGetDescDataSize(&desc) != size { // this assumes Swift types are same byte size as C types
            throw AutomationError(code: errAECorruptData, message: "Error unpacking <AEDesc \(formatFourCharCodeLiteral(desc.descriptorType))> as \(T.self): expected \(size) bytes but found \(AEGetDescDataSize(&desc))")
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
        return ptr.pointee
    }
    
    func unpackFixedArray<T: FixedWidthInteger>(of itemType: T.Type, inOrder indexes: [Int]) throws -> [Int] {
        // used by Array extension to unpack typeQDPoint, typeQDRectangle, typeRGBColor descriptors
        // TO DO: implement initializers and accessors for these structures; these should use fixed type+size lists, with transparent backwards compatibility for old QD types
        var desc = self
        let size = MemoryLayout<T>.size * indexes.count
        if AEGetDescDataSize(&desc) != size { // this assumes Swift types are same byte size as C types
            throw AutomationError(code: errAECorruptData, message: "Error unpacking <AEDesc \(formatFourCharCodeLiteral(desc.descriptorType))> as \(T.self): expected \(size) bytes but found \(AEGetDescDataSize(&desc))")
        }
        var result = [Int]()
        let ptr = UnsafeMutablePointer<T>.allocate(capacity: indexes.count)
        defer { ptr.deallocate() }
        try throwIfError(AEGetDescData(&desc, ptr, size))
        for i in indexes { // QDPoint is YX, so swap to give [X,Y]
            result.append(Int(ptr[i])) // note: can't use Element(n) here as Swift doesn't define integer constructors in IntegerType protocol (but does for FloatingPointType)
        }
        return result
    }
}



// support

// typeLongDateTime = no. of seconds before/since classic Mac OS epoch (beginning of first leap year of 20th century)
internal let epochDelta: TimeInterval = 35430.0 * 24 * 3600; // 1/1/1904 -> 1/1/2001
internal let cMissingValue: DescType = 0x6D736E67 // 'msng'


internal let nullDescriptor = AEDesc(descriptorType: typeNull, dataHandle: nil)
internal let trueDescriptor = AEDesc(descriptorType: typeTrue, dataHandle: nil)
internal let falseDescriptor = AEDesc(descriptorType: typeFalse, dataHandle: nil)


internal func packFixedSize<T>(_ value: T, as descType: DescType) -> AEDesc {
    var desc = nullDescriptor
    var value = value
    try! throwIfError(AECreateDesc(descType, &value, MemoryLayout.size(ofValue: value), &desc))
    return desc
}


internal func throwIfError<T: SignedInteger>(_ error: T, loc: String = #function) throws { // throws if Carbon function returned error code (OSErr/OSStatus/Int)
    if error != 0 {
        throw AutomationError(code: Int(error))
    }
}

internal var isLittleEndianHost: Bool {
    let n: UInt16 = 1
    return n.littleEndian == n
}





