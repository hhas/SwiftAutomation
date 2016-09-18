//
//  AppleEventFormatter.swift
//  SwiftAutomation
//
//  Format an AppleEvent descriptor as Swift source code. Enables user tools
//  to translate application commands from AppleScript to Swift syntax simply
//  by installing a custom SendProc into an AS component instance to intercept
//  outgoing AEs, pass them to formatAppleEvent(), and print the result.
//
//

//  TO DO: code's a bit gnarly: leaks some memory each time it's used (due to AppData-RootSpecifier coupling) and is not yet sufficiently decoupled to allow reuse over other languages (although that's something that can/should be sorted out once there are other languages than Swift to support)


// TO DO: Application object should hide url arg for display purposes

// TO DO: Symbols aren't displaying correctly (currently appear as `Symbol.NAME` instead of `PREFIX.NAME`)

// TO DO: Symbols currently appear quoted in commands, e.g. `TextEdit(name: "/Applications/TextEdit.app").documents.close(saving: "Symbol.no")`


import Foundation
import AppKit


public enum TerminologyType {
    case aete
    case sdef
    case none // use default terminology + raw four-char codes only
}


public func formatAppleEvent(descriptor event: NSAppleEventDescriptor, useTerminology: TerminologyType = .sdef) -> String {
    //  Format an outgoing or reply AppleEvent (if the latter, only the return value/error description is displayed).
    //  Caution: if sending events to self, caller MUST use TerminologyType.SDEF or call
    //  formatAppleEvent on a background thread, otherwise formatAppleEvent will deadlock
    //  the main loop when it tries to fetch host app's AETE via ascr/gdte event.
    if event.descriptorType != typeAppleEvent { // sanity check
        return "Can't format Apple event: wrong type: \(formatFourCharCodeString(event.descriptorType))."
    }
    let appData: DynamicAppData
    do {
        appData = try appDataForAppleEvent(event, useTerminology: useTerminology)
    } catch {
        return "Can't format Apple event: can't get terminology: \(error)"
    }
    if event.attributeDescriptor(forKeyword: keyEventClassAttr)!.typeCodeValue == kCoreEventClass
            && event.attributeDescriptor(forKeyword: keyEventIDAttr)!.typeCodeValue == kAEAnswer { // it's a reply event, so format error/return value only
        let errn = event.paramDescriptor(forKeyword: keyErrorNumber)?.int32Value ?? 0
        if errn != 0 { // format error message
            let errs = event.paramDescriptor(forKeyword: keyErrorString)?.stringValue
            return SwiftAutomationError(code: Int(errn), message: errs).description // TO DO: use CommandError? (need to check it's happy with only replyEvent arg)
        } else if let reply = event.paramDescriptor(forKeyword: keyDirectObject) { // format return value
            return formatValue((try? appData.unpackAny(reply)) ?? reply)
        } else {
            return "<noreply>" // TO DO: what to return?
        }
    } else { // fully format outgoing event
        let eventDescription = AppleEventDescription(event: event, appData: appData)
        return appData.formatter.formatAppleEvent(eventDescription, applicationObject: appData.targetedAppRoot)
    }
}


/******************************************************************************/
// cache previously parsed terminology for efficiency

private let gCacheMaxLength = 10
private var gCache = [(NSAppleEventDescriptor, TerminologyType, DynamicAppData)]()

private func appDataForAppleEvent(_ event: NSAppleEventDescriptor, useTerminology: TerminologyType) throws -> DynamicAppData {
    let addressDesc = event.attributeDescriptor(forKeyword: keyAddressAttr)!
    for (desc, terminologyType, appData) in gCache {
        if desc.descriptorType == addressDesc.descriptorType && desc.data == addressDesc.data && terminologyType == useTerminology {
            return appData
        }
    }
    let appData = try DynamicAppData.dynamicAppDataForAddress(addressDesc, useTerminology: useTerminology) // TO DO: are there any cases where keyAddressArrr won't return correct desc? (also, double-check what reply event uses)
    if gCache.count > gCacheMaxLength { gCache.removeFirst() } // TO DO: ideally this should trim least used, not longest cached
    gCache.append((addressDesc, useTerminology, appData))
    return appData
}


/******************************************************************************/
// extend standard AppData to include terminology translation


public class DynamicAppData: AppData { // TO DO: can this be used as-is/with modifications as base class for dynamic bridges? if so, move to its own file as it's not specific to formatting; if not, rename it
    
    public internal(set) var glueSpec: GlueSpec! // provides glue metadata; TO DO: initializing these is messy, due to AppData.init() being required; any cleaner solution?
    public internal(set) var glueTable: GlueTable! // provides keyword<->FCC translations
    
    // given AppleEvent's address descriptor, create AppData instance with formatting info
    // TO DO: ought to be an init, but AppData.init() is already required, which makes overriding problematic
    public class func dynamicAppDataForAddress(_ addressDesc: NSAppleEventDescriptor, useTerminology: TerminologyType) throws -> Self {
        var addressDesc = addressDesc
        if addressDesc.descriptorType == typeProcessSerialNumber { // AppleScript is old school
            addressDesc = addressDesc.coerce(toDescriptorType: typeKernelProcessID)!
        }
        guard addressDesc.descriptorType == typeKernelProcessID else { // local processes are generally targeted by PID
            throw TerminologyError("Unsupported address type: \(formatFourCharCodeString(addressDesc.descriptorType))")
        }
        var pid: pid_t = 0
        (addressDesc.data as NSData).getBytes(&pid, length: MemoryLayout<pid_t>.size)
        guard let applicationURL = NSRunningApplication(processIdentifier: pid)?.bundleURL else {
            throw TerminologyError("Can't get path to application bundle (PID: \(pid)).")
        }
        let glueSpec = GlueSpec(applicationURL: applicationURL, useSDEF: useTerminology == .sdef)
        var specifierFormatter: SpecifierFormatter
        var glueTable: GlueTable
        if useTerminology == .none {
            glueTable = GlueTable(keywordConverter: glueSpec.keywordConverter) // default terms only
            specifierFormatter = SpecifierFormatter(applicationClassName: "AEApplication", classNamePrefix: "AE")
        } else {
            glueTable = try glueSpec.buildGlueTable()
            specifierFormatter = SpecifierFormatter(applicationClassName: glueSpec.applicationClassName,
                                                    classNamePrefix: glueSpec.classNamePrefix,
                                                    typeNames: glueTable.typesByCode,
                                                    propertyNames: glueTable.propertiesByCode,
                                                    elementsNames: glueTable.elementsByCode)
        }
        let glueInfo = GlueInfo(insertionSpecifierType: AEInsertion.self, objectSpecifierType: AEItem.self,
                                multiObjectSpecifierType: AEItems.self, rootSpecifierType: AERoot.self,
                                symbolType: Symbol.self, formatter: specifierFormatter)
        // TO DO: this is going to leak memory on root objects; how to clean up? (explicit 'releaseRoots' method?)
        let appData = self.init(target: TargetApplication.url(applicationURL), launchOptions: DefaultLaunchOptions,
                                relaunchMode: DefaultRelaunchMode, glueInfo: glueInfo, rootObjects: nil)
        appData.glueSpec = glueSpec
        appData.glueTable = glueTable
        return appData
    }
    
    public override func targetedCopy(_ target: TargetApplication, launchOptions: LaunchOptions, relaunchMode: RelaunchMode) -> Self {
        let appData = type(of: self).init(target: target, launchOptions: launchOptions, relaunchMode: relaunchMode,
                                          glueInfo: self.glueInfo, rootObjects: self.rootObjects)
        appData.glueSpec = self.glueSpec
        appData.glueTable = self.glueTable
        return appData      
    }
    
    override func unpackSymbol(_ desc: NSAppleEventDescriptor) -> Symbol {
        return self.glueInfo.symbolType.init(name: self.glueTable.typesByCode[desc.typeCodeValue],
                                             code: desc.typeCodeValue, type: desc.descriptorType, cachedDesc: desc)
    }
    
    override func unpackAEProperty(_ code: OSType) -> Symbol {
        return self.glueInfo.symbolType.init(name: self.glueTable.typesByCode[code],
                                             code: code, type: typeProperty, cachedDesc: nil)
    }
}


/******************************************************************************/
// unpack AppleEvent descriptor's contents into struct, to be consumed by SpecifierFormatter.formatAppleEvent()


private let gDefaultTimeout: TimeInterval = 120 // TO DO: -sendEvent method's default/no timeout options are currently busted <rdar://21477694>; see also AppData.sendAppleEvent()

private let gDefaultConsidering: ConsideringOptions = [.case]

private let gDefaultConsidersIgnoresMask: UInt32 = 0x00010000 // AppleScript ignores case by default


// parsed Apple event

public struct AppleEventDescription { // TO DO: split AE unpacking from CommandTerm processing; put the latter in a function that takes glueTable as arg; that'll allow init to take any AppData instance, which gives more flexibility
    
    public let eventClass: OSType
    public let eventID: OSType
    public private(set) var name: String? = nil // nil if terminology unavailable (use eventClass+eventID instead)
    
    public private(set) var subject: Any? = nil
    public private(set) var directParameter: Any = NoParameter
    public private(set) var keywordParameters: [(String, String)]? = nil // [(name,value),...], or nil if terminology unavailable (use rawParameters instead)
    public private(set) var rawParameters: [OSType:Any] = [:] // TO DO: should this omit direct and `as` params? (A. no, e.g. `make` cmd may have different reqs., so formatter should decide what to include)
    
    public private(set) var requestedType: Any? = nil
    public private(set) var waitReply: Bool = true // really wantsReply (which could be either wait/queue reply)
    public private(set) var withTimeout: TimeInterval = gDefaultTimeout // TO DO: sort constant
    public private(set) var considering: ConsideringOptions = [.case]
    
    public init(event: NSAppleEventDescriptor, appData: DynamicAppData) {
        // unpack event attributes
        let eventClass = event.attributeDescriptor(forKeyword: keyEventClassAttr)!.typeCodeValue
        let eventID = event.attributeDescriptor(forKeyword: keyEventIDAttr)!.typeCodeValue
        self.eventClass = eventClass
        self.eventID = eventID
        var commandInfo = appData.glueTable.commandsByCode[CommandTermKey(eventClass, eventID)]
        // unpack subject attribute and/or direct parameter, if given
        if let desc = event.attributeDescriptor(forKeyword: SwiftAutomation_keySubjectAttr) {
            if desc.descriptorType != typeNull { // typeNull = root application object
                self.subject = (try? appData.unpackAny(desc)) ?? desc
            }
        }
        if let desc = event.paramDescriptor(forKeyword: keyDirectObject) {
            self.directParameter = (try? appData.unpackAny(desc)) ?? desc
        }
        // unpack `as` parameter, if given // TO DO: this needs to appear as resultType: arg
        if let desc = event.paramDescriptor(forKeyword: keyAERequestedType) {
            self.requestedType = (try? appData.unpackAny(desc)) ?? desc
        }
        // unpack keyword parameters
        if commandInfo != nil {
            self.keywordParameters = []
            for paramInfo in commandInfo!.orderedParameters { // this ignores parameters that don't have a keyword name; it should also ignore ("as",keyAERequestedType) parameter (this is probably best done by ensuring that command parsers always omit it)
                if let desc = event.paramDescriptor(forKeyword: paramInfo.code) {
                    let value = formatValue((try? appData.unpackAny(desc)) ?? desc)
                    self.keywordParameters!.append((paramInfo.name, value))
                }
            }
            if event.numberOfItems > self.keywordParameters!.count + (parameterExists(self.directParameter) ? 1 : 0)
                    + ((self.requestedType != nil && commandInfo!.parametersByCode[keyAERequestedType] == nil) ? 1 : 0) { // TO DO: update (see above)
                self.keywordParameters = nil
                commandInfo = nil
            }
        }
        if commandInfo == nil {
            for i in 1..<(event.numberOfItems+1) {
                let desc = event.atIndex(i)!
                //if ![keyDirectObject, keyAERequestedType].contains(desc.descriptorType) {
                self.rawParameters[event.keywordForDescriptor(at: i)] = (try? appData.unpackAny(desc)) ?? desc
                //}
            }
        } else {
            self.name = commandInfo!.name
        }
        // command's attributes
        if let desc = event.attributeDescriptor(forKeyword: keyReplyRequestedAttr) { // TO DO: attr is unreliable
            // keyReplyRequestedAttr appears to be boolean value encoded as Int32 (1=wait or queue reply; 0=no reply)
            if desc.int32Value == 0 { self.waitReply = false }
        }
        if let timeout = event.attributeDescriptor(forKeyword: keyTimeoutAttr) { // TO DO: attr is unreliable
            let timeoutInTicks = timeout.int32Value
            if timeoutInTicks == -2 { // NoTimeout // TO DO: ditto
                self.withTimeout = -2
            } else if timeoutInTicks > 0 {
                self.withTimeout = Double(timeoutInTicks) / 60.0
            }
        }
        if let considersAndIgnoresDesc = event.attributeDescriptor(forKeyword: SwiftAutomation_enumConsidsAndIgnores) {
            var considersAndIgnores: UInt32 = 0
            (considersAndIgnoresDesc.data as NSData).getBytes(&considersAndIgnores, length: MemoryLayout<UInt32>.size)
            if considersAndIgnores != gDefaultConsidersIgnoresMask {
                for (option, _, considersFlag, ignoresFlag) in gConsiderationsTable {
                    if option == .case {
                        if considersAndIgnores & ignoresFlag > 0 { self.considering.remove(option) }
                    } else {
                        if considersAndIgnores & considersFlag > 0 { self.considering.insert(option) }
                    }
                }
            }
        }
    }
}


/******************************************************************************/
// extend the standard SpecifierFormatter class so it can also format AppleEvent descriptors


extension SpecifierFormatter {
    
    public func formatAppleEvent(_ eventDescription: AppleEventDescription, applicationObject: RootSpecifier) -> String {
        var parentSpecifier = String(describing: applicationObject)
        var args: [String] = []
        if let commandName = eventDescription.name {
            if eventDescription.subject != nil && parameterExists(eventDescription.directParameter) {
                parentSpecifier = self.format(eventDescription.subject!)
                args.append(self.format(eventDescription.directParameter))
            //} else if eventClass == kAECoreSuite && eventID == kAECreateElement { // TO DO: format make command as special case (for convenience, AEBCommand allows user to call `make` directly on a specifier, in which case the specifier is used as its `at` parameter if not already given)
            } else if eventDescription.subject == nil && parameterExists(eventDescription.directParameter) {
                parentSpecifier = self.format(eventDescription.directParameter)
            } else if eventDescription.subject != nil && !parameterExists(eventDescription.directParameter) {
                parentSpecifier = self.format(eventDescription.subject!)
            }
            parentSpecifier += ".\(commandName)"
            for (key, value) in eventDescription.keywordParameters ?? [] {
                args.append("\(key): \(self.format(value))")
            }
        } else { // use raw codes
            if eventDescription.subject != nil {
                parentSpecifier = self.format(eventDescription.subject!)
            }
            parentSpecifier += ".sendAppleEvent"
            args.append("\(formatFourCharCodeString(eventDescription.eventClass)), \(formatFourCharCodeString(eventDescription.eventID))")
            if eventDescription.rawParameters.count > 0 {
                let params = eventDescription.rawParameters.map({ "\(formatFourCharCodeString($0)): \(self.format($1)))" }).joined(separator: ", ")
                args.append("[\(params)]")
            }
        }
        // TO DO: AE's representation of AESendMessage args (waitReply and withTimeout) is unreliable; may be best to ignore these entirely
        /*
        if !eventDescription.waitReply {
            args.append("waitReply: false")
        }
        //sendOptions: NSAppleEventSendOptions? = nil
        if eventDescription.withTimeout != gDefaultTimeout {
            args.append("withTimeout: \(eventDescription.withTimeout)") // TO DO: if -2, use NoTimeout constant (except 10.11 hasn't defined one yet, and is still buggy in any case)
        }
        */
        if eventDescription.considering != gDefaultConsidering {
            args.append("considering: \(eventDescription.considering)")
        }
        return parentSpecifier + "(" + args.joined(separator: ", ") + ")"
    }
}


