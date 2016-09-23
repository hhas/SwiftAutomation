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

// TO DO: Application object should appear as `APPLICATION()`, not `APPLICATION(name:"/PATH/TO/APP")`, for display in AppleScriptToSwift translator app -- probably simplest to have a boolean arg to formatAppleEvent that dictates this (since the full version is still useful for debugging work)... might be worth making this an `app/application/fullApplication` enum to cover PREFIXApp case as well

// TO DO: Symbols aren't displaying correctly within arrays/dictionaries/specifiers (currently appear as `Symbol.NAME` instead of `PREFIX.NAME`), e.g. `TextEdit(name: "/Applications/TextEdit.app").make(new: TED.document, withProperties: [Symbol.text: "foo"])`; `tell app "textedit" to document (text)` -> `TextEdit(name: "/Applications/TextEdit.app").documents[Symbol.text].get()`

//  TO DO: ensure specifier, symbol, and value formatting is fully decoupled from Swift-specific representation to allow reuse over other languages (although that's something that can/should be sorted out once there are other languages than Swift to support)


import Foundation
import AppKit


public enum TerminologyType {
    case aete // old and nasty, but reliable; can't be obtained from apps with broken `ascr/gdte` event handlers (e.g. Finder)
    case sdef // reliable for Cocoa apps only; may be corrupted when auto-generated for aete-only Carbon apps due to bugs in macOS's AETE-to-SDEF converter and/or limitations in XML/SDEF format (e.g. SDEF format represents OSTypes as four-character strings, but some OSTypes can't be represented as text due to 'unprintable characters', and SDEF format doesn't provide a way to represent those as [e.g.] hex numbers so converter discards them instead)
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
            return appData.formatter.format((try? appData.unpackAny(reply)) ?? reply)
        } else {
            return "<noreply>" // TO DO: what to return?
        }
    } else { // fully format outgoing event
        let eventDescription = AppleEventDescription(event: event, appData: appData)
        return appData.formatter.formatAppleEvent(eventDescription, applicationObject: appData.application)
    }
}


/******************************************************************************/
// cache previously parsed terminology for efficiency

private let cacheMaxLength = 10
private var cachedTerms = [(NSAppleEventDescriptor, TerminologyType, DynamicAppData)]()

private func appDataForAppleEvent(_ event: NSAppleEventDescriptor, useTerminology: TerminologyType) throws -> DynamicAppData {
    let addressDesc = event.attributeDescriptor(forKeyword: keyAddressAttr)!
    for (desc, terminologyType, appData) in cachedTerms {
        if desc.descriptorType == addressDesc.descriptorType && desc.data == addressDesc.data && terminologyType == useTerminology {
            return appData
        }
    }
    let appData = try DynamicAppData.dynamicAppDataForAddress(addressDesc, useTerminology: useTerminology) // TO DO: are there any cases where keyAddressArrr won't return correct desc? (also, double-check what reply event uses)
    if cachedTerms.count > cacheMaxLength { cachedTerms.removeFirst() } // TO DO: ideally this should trim least used, not longest cached
    cachedTerms.append((addressDesc, useTerminology, appData))
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
        let glueClasses = GlueClasses(insertionSpecifierType: AEInsertion.self, objectSpecifierType: AEItem.self,
                                      multiObjectSpecifierType: AEItems.self, rootSpecifierType: AERoot.self,
                                      applicationType: AERoot.self, symbolType: Symbol.self, formatter: specifierFormatter) // TO DO: what applicationType?
        let appData = self.init(target: TargetApplication.url(applicationURL), launchOptions: DefaultLaunchOptions,
                                relaunchMode: DefaultRelaunchMode, glueClasses: glueClasses) // TO DO: because this uses app path (to ensure it targets the right process if multiple app versions with same bundle ID are installed) instead of bundle ID, SpecifierFormatter will display as "APPLICATION(name:...)" instead of "APPLICATION()", which is best for debugging AEs (since it provides the most information) but not ideal for AppleScriptToSwift translations (which are usually best using idiomatic representation and leaving user to customize the Application constructor syntax according to their own needs)
        appData.glueSpec = glueSpec // TO DO: why initialize DynamicppData and then assign glueSpec and glueTable to it, instead of overriding init and passing glueSpec and glueTable as args? (see above TODO on why this constructor is a class method - it can't be right)
        appData.glueTable = glueTable
        return appData
    }
    
    public override func targetedCopy(_ target: TargetApplication, launchOptions: LaunchOptions, relaunchMode: RelaunchMode) -> Self {
        let appData = type(of: self).init(target: target, launchOptions: launchOptions,
                                          relaunchMode: relaunchMode, glueClasses: self.glueClasses)
        appData.glueSpec = self.glueSpec
        appData.glueTable = self.glueTable
        return appData      
    }
    
    override func unpackSymbol(_ desc: NSAppleEventDescriptor) -> Symbol {
        return self.glueClasses.symbolType.init(name: self.glueTable.typesByCode[desc.typeCodeValue],
                                                code: desc.typeCodeValue, type: desc.descriptorType, cachedDesc: desc)
    }
    
    override func unpackAEProperty(_ code: OSType) -> Symbol {
        return self.glueClasses.symbolType.init(name: self.glueTable.typesByCode[code],
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
    public private(set) var keywordParameters: [(String, Any)]? = nil // [(name,value),...], or nil if terminology unavailable (use rawParameters instead)
    public private(set) var rawParameters: [OSType:Any] = [:] // TO DO: should this omit direct and `as` params? (A. no, e.g. `make` cmd may have different reqs., so formatter should decide what to include)
    
    public private(set) var requestedType: Any? = nil
    public private(set) var waitReply: Bool = true // really wantsReply (which could be either wait/queue reply) // TO DO: currently unused by formatAppleEvent() as it's problematic; delete?
    public private(set) var withTimeout: TimeInterval = gDefaultTimeout // TO DO: sort constant // TO DO: currently unused by formatAppleEvent() as it's problematic; delete?
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
                    self.keywordParameters!.append((paramInfo.name, ((try? appData.unpackAny(desc)) ?? desc)))
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


/******************************************************************************/
// extend the standard SpecifierFormatter class so it can also format AppleEvent descriptors

/*
// TO DO: problem with extending SpecifierFormatter is it can't be subclassed to modify its formatting behavior, e.g.:

override func formatRootSpecifier(_ specifier: RootSpecifier) -> String {
    if (specifier.rootObject as? NSAppleEventDescriptor)?.descriptorType == typeNull {
        return APPLICATION-CLASS-NAME
    } else {
        return super.formatRootSpecifier(specifier)
    }
}
 
 -- however, this particular issue will go away if formatter has instance var/param for specifying how absolute specifiers should be represented (APPLICATION(...), APPLICATION(), or PREFIXApp)
 */

extension SpecifierFormatter {
    
    // note: only reason this code isn't folded into top-level formatAppleEvent() function above is to allow subclasses of SpecifierFormatter to override in order to generate representations for other languages
    
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


