//
//  AEHandler.swift
//  SwiftAutomation
//

import Foundation

// TO DO: how should next layer above AppleEventHandler look? presumably we need some sort of app-specific glue to map Swift functions with native parameter and return types onto AppleEventHandler callbacks; should Swift functions use standardized naming conventions, allowing them to be auto-detected by glue generator and signatures mapped to 'SDEF' definitions (note: we want to architect a new, comprehensive IDL dictionary format, with basic SDEFs generated for backwards compatibility; the IDL should, as much as possible, be auto-generated from the Swift implementation)

public typealias AppleEventHandler = (inout AppleEvent) throws -> AEDesc? // essentially (parameters_record)->result/error (although); TO DO: think `inout` is used here solely to keep Swift compiler happy when dealing with C pointer-based APIs; the receiving func probably should not attempt to modify the AppleEvent descriptor (need to review this; omitting the `inout` qualifier won't really make a difference safey-wise as the AE's dataHandler is still shared and mutable)


private let genericEventHandlerUPP: AEEventHandlerUPP = { (request, reply, refcon) -> OSErr in
    let callback = refcon!.load(as: AppleEventHandler.self)
    var request: AppleEvent = request!.pointee
    var reply: AppleEvent = reply!.pointee
    // TO DO: this might be too low-level for error reporting, as all Swift values landing here must be packed as AEDescs which might require app-defined pack funcs
    do {
        if var result = try callback(&request) {
            AEPutParamDesc(&reply, keyAEResult, &result)
        }
    } catch let e as AutomationError { // TO DO: decide how best to implement application error reporting (standard errors - e.g. 'coercion failed', 'object not found' - might be provided as enum [this would also take any necessary message, failed object, params]; this would be based on standard 'AppleEventError' protocol, allowing apps to define their own error structs/classes should they need to report custom errors as well)
        reply.packFixedSizeParameter(keyErrorNumber, Int32(e.code), typeSInt32) // TO DO: move this implementation onto AEDesc and have it accept Int for ease of use? (error codes should be OSStatus, aka Int32, so should still pack as typeSInt32; Q. if code is out of 32-bit range, pack as typeSInt64? or throw/log console warning and return 32-bit error code? apart from anything else, AppleScript can't handle 64-bit numbers so returning an out-of-range code will break that)
    } catch {
        reply.packFixedSizeParameter(keyErrorNumber, Int32(error._code), typeSInt32)
    }
    return 0 // TO DO: when to return non-zero code?
}

public func installEventHandler(eventClass: AEEventClass, eventID: AEEventID, callback: @escaping AppleEventHandler) throws {
    var callback = callback
    try throwing(AEInstallEventHandler(eventClass, eventID, genericEventHandlerUPP, &callback, false))
}

public func removeEventHandler(eventClass: AEEventClass, eventID: AEEventID) {
    AERemoveEventHandler(eventClass, eventID, nil, false)
}

// TO DO: suspend/resume current event? (what use-cases require this?)

