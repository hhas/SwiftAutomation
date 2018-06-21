//
//  AppleEventFormatter.swift
//  SwiftAutomation
//
//  Format an AppleEvent descriptor as Swift source code. Enables user tools to translate application commands from AppleScript to Swift syntax simply by installing a custom SendProc into an AS component instance to intercept outgoing AEs, pass them to formatAppleEvent(), and print the result.
//
//

// TO DO: Application object should appear as `APPLICATION()`, not `APPLICATION(name:"/PATH/TO/APP")`, for display in SwiftAutoEdit's command translator -- probably simplest to have a boolean arg to formatAppleEvent that dictates this (since the full version is still useful for debugging work)... might be worth making this an `app/application/fullApplication` enum to cover PREFIXApp case as well

// TO DO: Symbols aren't displaying correctly within arrays/dictionaries/specifiers (currently appear as `Symbol.NAME` instead of `PREFIX.NAME`), e.g. `TextEdit(name: "/Applications/TextEdit.app").make(new: TED.document, withProperties: [Symbol.text: "foo"])`; `tell app "textedit" to document (text)` -> `TextEdit(name: "/Applications/TextEdit.app").documents[Symbol.text].get()` -- note that a custom Symbol subclass won't work as `description` can't be parameterized with prefix name to use; one option might be a Symbol subclass whose init takes the prefix as param when it's unpacked (that probably will work); that said, why isn't Formatter.formatSymbol() doing the job in the first place? (check it has correct prefix) -- it's formatValue() -- when formatting collections, it calls itself and then renders self-formatting objects as-is



import Foundation
import AppKit


public enum TerminologyType {
    case aete // old and nasty, but reliable; can't be obtained from apps with broken `ascr/gdte` event handlers (e.g. Finder)
    case sdef // reliable for Cocoa apps only; may be corrupted when auto-generated for aete-only Carbon apps due to bugs in macOS's AETE-to-SDEF converter and/or limitations in XML/SDEF format (e.g. SDEF format represents OSTypes as four-character strings, but some OSTypes can't be represented as text due to 'unprintable characters', and SDEF format doesn't provide a way to represent those as [e.g.] hex numbers so converter discards them instead)
    case none // use default terminology + raw four-char codes only
}


public func formatAppleEvent(descriptor event: NSAppleEventDescriptor, useTerminology: TerminologyType = .sdef) -> String { // TO DO: return command/reply/error enum, giving caller more choice on how to display
    //  Format an outgoing or reply AppleEvent (if the latter, only the return value/error description is displayed).
    //  Caution: if sending events to self, caller MUST use TerminologyType.SDEF or call formatAppleEvent on a background thread, otherwise formatAppleEvent will deadlock the main loop when it tries to fetch host app's AETE via ascr/gdte event.
    if event.descriptorType != _typeAppleEvent { // sanity check
        return "Can't format Apple event: wrong type: \(formatFourCharCodeString(event.descriptorType))."
    }
    let appData: DynamicAppData
    do {
        appData = try dynamicAppData(forAppleEvent: event, useTerminology: useTerminology)
    } catch {
        return "Can't format Apple event: can't get terminology: \(error)"
    }
    if event.attributeDescriptor(forKeyword: _keyEventClassAttr)!.typeCodeValue == _kCoreEventClass
            && event.attributeDescriptor(forKeyword: _keyEventIDAttr)!.typeCodeValue == _kAEAnswer { // it's a reply event, so format error/return value only
        let errn = event.paramDescriptor(forKeyword: _keyErrorNumber)?.int32Value ?? 0
        if errn != 0 { // format error message
            let errs = event.paramDescriptor(forKeyword: _keyErrorString)?.stringValue
            return AutomationError(code: Int(errn), message: errs).description // TO DO: use CommandError? (need to check it's happy with only replyEvent arg)
        } else if let reply = event.paramDescriptor(forKeyword: _keyDirectObject) { // format return value
            return appData.formatter.format((try? appData.unpackAsAny(reply)) ?? reply)
        } else {
            return MissingValue.description
        }
    } else { // fully format outgoing event
        return appData.formatter.formatCommand(CommandDescription(event: event, appData: appData), applicationObject: appData.application)
    }
}


/******************************************************************************/
// get a DynamicAppData instance for formatting the given AppleEvent

// cache previously parsed terminology for efficiency
private let _cacheMaxLength = 10
private var _cachedTerms = [(NSAppleEventDescriptor, TerminologyType, DynamicAppData)]()


private func dynamicAppData(forAppleEvent event: NSAppleEventDescriptor, useTerminology: TerminologyType) throws -> DynamicAppData {
    let addressDesc = event.attributeDescriptor(forKeyword: _keyAddressAttr)!
    for (desc, terminologyType, appData) in _cachedTerms {
        if desc.descriptorType == addressDesc.descriptorType && desc.data == addressDesc.data && terminologyType == useTerminology {
            return appData
        }
    }
    let appData = try DynamicAppData(applicationURL: applicationURL(forAddressDescriptor: addressDesc), useTerminology: useTerminology) // TO DO: are there any cases where keyAddressArrr won't return correct desc? (also, double-check what reply event uses)
    if _cachedTerms.count > _cacheMaxLength { _cachedTerms.removeFirst() } // TO DO: ideally this should trim least used, not longest cached
    _cachedTerms.append((addressDesc, useTerminology, appData))
    return appData
}

// given the AEAddressDesc for a local process, return the fileURL to its .app bundle
func applicationURL(forAddressDescriptor addressDesc: NSAppleEventDescriptor) throws -> URL {
    var addressDesc = addressDesc
    if addressDesc.descriptorType == _typeProcessSerialNumber { // AppleScript is old school
        addressDesc = addressDesc.coerce(toDescriptorType: _typeKernelProcessID)!
    }
    guard addressDesc.descriptorType == _typeKernelProcessID else { // local processes are generally targeted by PID
        throw TerminologyError("Unsupported address type: \(formatFourCharCodeString(addressDesc.descriptorType))")
    }
    var pid: pid_t = 0
    (addressDesc.data as NSData).getBytes(&pid, length: MemoryLayout<pid_t>.size)
    guard let applicationURL = NSRunningApplication(processIdentifier: pid)?.bundleURL else {
        throw TerminologyError("Can't get path to application bundle (PID: \(pid)).")
    }
    return applicationURL
}


/******************************************************************************/
// extend standard AppData to include terminology translation



public class DynamicAppData: AppData { // TO DO: can this be used as-is/with modifications as base class for dynamic bridges? if so, move to its own file as it's not specific to formatting; if not, rename it
    
    public internal(set) var glueSpec: GlueSpec! // provides glue metadata; TO DO: initializing these is messy, due to AppData.init() being required; any cleaner solution?
    public internal(set) var glueTable: GlueTable! // provides keyword<->FCC translations
    
    
    public required init(target: TargetApplication, launchOptions: LaunchOptions, relaunchMode: RelaunchMode, glueClasses: GlueClasses) {
        super.init(target: target, launchOptions: launchOptions, relaunchMode: relaunchMode, glueClasses: glueClasses)
    }

    
    public required init(target: TargetApplication, launchOptions: LaunchOptions, relaunchMode: RelaunchMode,
                         glueClasses: GlueClasses, glueSpec: GlueSpec, glueTable: GlueTable) {
        self.glueSpec = glueSpec
        self.glueTable = glueTable
        super.init(target: target, launchOptions: launchOptions, relaunchMode: relaunchMode, glueClasses: glueClasses)
    }
    
    // given local application's fileURL, create AppData instance with formatting info // TO DO: this uses app path (to ensure it targets the right process if multiple app versions with same bundle ID are installed) instead of bundle ID, so won't work in sandboxed apps (that said, without AE permissions there probably isn't much it can do inside a sandbox anyway)
    public convenience init(applicationURL: URL, useTerminology: TerminologyType) throws {
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
        let glueClasses = GlueClasses(insertionSpecifierType: AEInsertion.self, objectSpecifierType: AEItem.self,
                                      multiObjectSpecifierType: AEItems.self, rootSpecifierType: AERoot.self,
                                      applicationType: AERoot.self, symbolType: Symbol.self, formatter: specifierFormatter) // TO DO: what applicationType?
        self.init(target: TargetApplication.url(applicationURL), launchOptions: DefaultLaunchOptions,
                  relaunchMode: DefaultRelaunchMode, glueClasses: glueClasses, glueSpec: glueSpec, glueTable: glueTable)
    }
    
    public override func targetedCopy(_ target: TargetApplication, launchOptions: LaunchOptions, relaunchMode: RelaunchMode) -> Self {
        return type(of: self).init(target: target, launchOptions: launchOptions, relaunchMode: relaunchMode,
                                   glueClasses: self.glueClasses, glueSpec: glueSpec, glueTable: glueTable)
    }
    
    override func unpackAsSymbol(_ desc: NSAppleEventDescriptor) -> Symbol {
        return self.glueClasses.symbolType.init(name: self.glueTable.typesByCode[desc.typeCodeValue],
                                                code: desc.typeCodeValue, type: desc.descriptorType, descriptor: desc)
    }
    
    override func recordKey(forCode code: OSType) -> Symbol {
        return self.glueClasses.symbolType.init(name: self.glueTable.typesByCode[code], code: code, type: _typeProperty)
    }
}


/******************************************************************************/
// unpack AppleEvent descriptor's contents into struct, to be consumed by SpecifierFormatter.formatCommand()


public struct CommandDescription {
    
    // note: even when terminology data is available, there's still no guarantee that a command won't have to use raw codes instead (typically due to dodgy terminology; while AS allows mixing of keyword and raw chevron syntax in the same command, it's such a rare defect it's best to stick solely to one or the other)
    public enum Signature {
        case named(name: String, directParameter: Any, keywordParameters: [(String, Any)], requestedType: Symbol?)
        case codes(eventClass: OSType, eventID: OSType, parameters: [OSType:Any])
    }
    
    // name and parameters
    public let signature: Signature // either keywords or four-char codes
    
    // attributes (note that waitReply and withTimeout values are unreliable when extracted from an existing AppleEvent)
    public private(set) var subject: Any? = nil // TO DO: subject or parentSpecifier? (and what, if any, difference does it make?)
    public private(set) var waitReply: Bool = true // note that existing AppleEvent descriptors contain keyReplyRequestedAttr, which could be either SendOptions.waitForReply or .queueReply
    // TO DO: also include sendOptions for completeness
    public private(set) var withTimeout: TimeInterval = defaultTimeout
    public private(set) var considering: ConsideringOptions = [.case]
    
    
    // called by sendAppleEvent with a failed command's details
    public init(name: String?, eventClass: OSType, eventID: OSType, parentSpecifier: Any?,
                directParameter: Any, keywordParameters: [KeywordParameter],
                requestedType: Symbol?, waitReply: Bool, withTimeout: TimeInterval?, considering: ConsideringOptions?) {
        if let commandName = name {
            self.signature = .named(name: commandName, directParameter: directParameter,
                                    keywordParameters: keywordParameters.map { ($0!, $2) }, requestedType: requestedType)
        } else {
            var parameters = [OSType:Any]()
            if parameterExists(directParameter) { parameters[_keyDirectObject] = directParameter }
            for (_, code, value) in keywordParameters where parameterExists(value) { parameters[code] = value }
            if let symbol = requestedType { parameters[_keyAERequestedType] = symbol }
            self.signature = .codes(eventClass: eventClass, eventID: eventID, parameters: parameters)
        }
        self.waitReply = waitReply
        self.subject = parentSpecifier
        if withTimeout != nil { self.withTimeout = withTimeout! }
        if considering != nil { self.considering = considering! }
    }
    
    
    // called by [e.g.] SwiftAutoEdit.app with an intercepted AppleEvent descriptor
    public init(event: NSAppleEventDescriptor, appData: DynamicAppData) { // TO DO: would be more flexible to take AppData + GlueTable as separate params
        // unpack the event's parameters
        var rawParameters = [OSType:Any]()
        for i in 1...event.numberOfItems {
            let desc = event.atIndex(i)!
            rawParameters[event.keywordForDescriptor(at:i)] = (try? appData.unpackAsAny(desc)) ?? desc
        }
        //
        let eventClass = event.attributeDescriptor(forKeyword: _keyEventClassAttr)!.typeCodeValue
        let eventID = event.attributeDescriptor(forKeyword: _keyEventIDAttr)!.typeCodeValue
        if let commandInfo = appData.glueTable.commandsByCode[eightCharCode(eventClass, eventID)] {
            var keywordParameters = [(String, Any)]()
            for paramInfo in commandInfo.orderedParameters { // this ignores parameters that don't have a keyword name; it should also ignore ("as",keyAERequestedType) parameter (this is probably best done by ensuring that command parsers always omit it)
                if let value = rawParameters[paramInfo.code] {
                    keywordParameters.append((paramInfo.name, value))
                }
            }
            let directParameter = rawParameters[_keyDirectObject] ?? NoParameter
            let requestedType = rawParameters[_keyAERequestedType] as? Symbol
            // make sure all keyword parameters have been matched to parameter names
            if rawParameters.count == keywordParameters.count + (parameterExists(directParameter) ? 1 : 0)
                + ((requestedType != nil && commandInfo.parametersByCode[_keyAERequestedType] == nil) ? 1 : 0) { // TO DO: check this logic re. _keyAERequestedType
                self.signature = .named(name: commandInfo.name, directParameter: directParameter,
                                      keywordParameters: keywordParameters, requestedType: requestedType)
            } else {
                self.signature = .codes(eventClass: eventClass, eventID: eventID, parameters: rawParameters)
            }
        } else {
            self.signature = .codes(eventClass: eventClass, eventID: eventID, parameters: rawParameters)
        }
        // unpack subject attribute, if given
        if let desc = event.attributeDescriptor(forKeyword: _keySubjectAttr) {
            if desc.descriptorType != _typeNull { // typeNull = root application object
                self.subject = (try? appData.unpackAsAny(desc)) ?? desc // TO DO: double-check formatter knows how to display descriptor (or any other non-specifier) as customRoot
            }
        }
        // unpack reply requested and timeout attributes (note: these attributes are unreliable since their values are passed via AESendMessage() rather than packed directly into the AppleEvent)
        if let desc = event.attributeDescriptor(forKeyword: _keyReplyRequestedAttr) { // TO DO: attr is unreliable
            // keyReplyRequestedAttr appears to be boolean value encoded as Int32 (1=wait or queue reply; 0=no reply)
            if desc.int32Value == 0 { self.waitReply = false }
        }
        if let timeout = event.attributeDescriptor(forKeyword: _keyTimeoutAttr) { // TO DO: attr is unreliable
            let timeoutInTicks = timeout.int32Value
            if timeoutInTicks == -2 { // NoTimeout // TO DO: ditto
                self.withTimeout = -2
            } else if timeoutInTicks > 0 {
                self.withTimeout = Double(timeoutInTicks) / 60.0
            }
        }
        // considering/ignoring attributes
        if let considersAndIgnoresDesc = event.attributeDescriptor(forKeyword: _enumConsidsAndIgnores) {
            var considersAndIgnores: UInt32 = 0
            (considersAndIgnoresDesc.data as NSData).getBytes(&considersAndIgnores, length: MemoryLayout<UInt32>.size)
            if considersAndIgnores != defaultConsidersIgnoresMask {
                for (option, _, considersFlag, ignoresFlag) in considerationsTable {
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


