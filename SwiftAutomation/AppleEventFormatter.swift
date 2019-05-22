//
//  AppleEventFormatter.swift
//  SwiftAutomation
//
//  Format an AppleEvent descriptor as Swift source code. Enables user tools to translate application commands from AppleScript to Swift syntax simply by installing a custom SendProc into an AS component instance to intercept outgoing AEs, pass them to formatAppleEvent(), and print the result.
//

// TO DO: if keeping this in framework, need to sort out its public API

// TO DO: Application object should appear as `APPLICATION()`, not `APPLICATION(name:"/PATH/TO/APP")`, for display in SwiftAutoEdit's command translator -- probably simplest to have a boolean arg to formatAppleEvent that dictates this (since the full version is still useful for debugging work)... might be worth making this an `app/application/fullApplication` enum to cover PREFIXApp case as well

// TO DO: Symbols aren't displaying correctly within arrays/dictionaries/specifiers (currently appear as `Symbol.NAME` instead of `PREFIX.NAME`), e.g. `TextEdit(name: "/Applications/TextEdit.app").make(new: TED.document, withProperties: [Symbol.text: "foo"])`; `tell app "textedit" to document (text)` -> `TextEdit(name: "/Applications/TextEdit.app").documents[Symbol.text].get()` -- note that a custom Symbol subclass won't work as `description` can't be parameterized with prefix name to use; one option might be a Symbol subclass whose init takes the prefix as param when it's unpacked (that probably will work); that said, why isn't Formatter.formatSymbol() doing the job in the first place? (check it has correct prefix) -- it's formatValue() -- when formatting collections, it calls itself and then renders self-formatting objects as-is

import Foundation
import AppleEvents

#if canImport(AppKit)
import AppKit
#endif


public enum TerminologyType {
    case aete // old and nasty, but reliable; can't be obtained from apps with broken `ascr/gdte` event handlers (e.g. Finder)
    case sdef // reliable for Cocoa apps only; may be corrupted when auto-generated for aete-only Carbon apps due to bugs in macOS's AETE-to-SDEF converter and/or limitations in XML/SDEF format (e.g. SDEF format represents OSTypes as four-character strings, but some OSTypes can't be represented as text due to 'unprintable characters', and SDEF format doesn't provide a way to represent those as [e.g.] hex numbers so converter discards them instead)
    case none // use default terminology + raw four-char codes only
}


public func formatAppleEvent(descriptor event: AppleEventDescriptor, useTerminology: TerminologyType = .sdef) -> String { // TO DO: return command/reply/error enum, giving caller more choice on how to display
    //  Format an outgoing or reply AppleEvent (if the latter, only the return value/error description is displayed).
    //  Caution: if sending events to self, caller MUST use TerminologyType.SDEF or call formatAppleEvent on a background thread, otherwise formatAppleEvent will deadlock the main loop when it tries to fetch host app's AETE via ascr/gdte event.
    if event.type != AppleEvents.typeAppleEvent { // sanity check
        return "Can't format Apple event: wrong type: \(literalFourCharCode(event.type))."
    }
    let appData: DynamicAppData
    do {
        appData = try dynamicAppData(for: event.target!, useTerminology: useTerminology)
    } catch {
        return "Can't format Apple event: can't get terminology: \(error)"
    }
    if event.code == eventAnswer { // it's a reply event, so format error/return value only
        let errn = event.errorNumber
        if errn != 0 { // format error message
            return AutomationError(code: Int(errn), message: event.errorMessage).description // TO DO: use CommandError? (need to check it's happy with only replyEvent arg)
        } else if let reply = event.parameter(AppleEvents.keyDirectObject) { // format return value
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
private var _cachedTerms = [(AddressDescriptor, TerminologyType, DynamicAppData)]()


private func dynamicAppData(for addressDesc: AddressDescriptor, useTerminology: TerminologyType) throws -> DynamicAppData {
    for (desc, terminologyType, appData) in _cachedTerms {
        if desc.type == addressDesc.type && desc.data == addressDesc.data && terminologyType == useTerminology {
            return appData
        }
    }
    let appData = try DynamicAppData(applicationURL: applicationURL(for: addressDesc), useTerminology: useTerminology) // TO DO: are there any cases where keyAddressArrr won't return correct desc? (also, double-check what reply event uses)
    if _cachedTerms.count > _cacheMaxLength { _cachedTerms.removeFirst() } // TO DO: ideally this should trim least used, not longest cached
    _cachedTerms.append((addressDesc, useTerminology, appData))
    return appData
}

// given the AEAddressDesc for a local process, return the fileURL to its .app bundle
func applicationURL(for addressDesc: AddressDescriptor) throws -> URL {
    #if canImport(AppKit)
    // AppleScript uses old typeProcessSerialNumber, but this should coerce to modern typeKernelProcessID
    guard let pid = try? addressDesc.processIdentifier() else { // local processes are generally targeted by PID
        throw TerminologyError("Unsupported address type: \(literalFourCharCode(addressDesc.type))")
    }
    guard let applicationURL = NSRunningApplication(processIdentifier: pid)?.bundleURL else {
        throw TerminologyError("Can't get path to application bundle (PID: \(pid)).")
    }
    return applicationURL
    #else
    throw AutomationError(code: 1, message: "AppKit not available")
    #endif
}


/******************************************************************************/
// extend standard AppData to include terminology translation



open class DynamicAppData: AppData { // TO DO: rename this and make `public` as it's only useful for rendering AEs to SwiftAutomation syntax, not for implementing dynamic language bridges (also see notes on CommandDescription initializer, as it's possible this subclass could be eliminated entirely)

    
    public internal(set) var glueSpec: GlueSpec! // provides glue metadata; TO DO: initializing these is messy, due to incomplete AppData initializer below being 'required'; any cleaner solution than using `!`?
    public internal(set) var glueTable: GlueTable! // provides keyword<->FCC translations
    
    
    public required init(target: TargetApplication, launchOptions: LaunchOptions, relaunchMode: RelaunchMode, glueClasses: GlueClasses) { // subclass has to re-implement this AppData initializer due to it being 'required'; however, the resulting AppData instance won't contain glueSpec/glueTable values so will crash if those are subsequently used // TO DO: should this initializer always throw fatalError() here? or is it possible to rework AppData implementation to avoid this redeclaration in first place?
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
        self.init(target: TargetApplication.url(applicationURL), launchOptions: defaultLaunchOptions,
                  relaunchMode: defaultRelaunchMode, glueClasses: glueClasses, glueSpec: glueSpec, glueTable: glueTable)
    }
    
    public override func targetedCopy(_ target: TargetApplication, launchOptions: LaunchOptions, relaunchMode: RelaunchMode) -> Self {
        return type(of: self).init(target: target, launchOptions: launchOptions, relaunchMode: relaunchMode,
                                   glueClasses: self.glueClasses, glueSpec: glueSpec, glueTable: glueTable)
    }
    
    override func unpackAsSymbol(_ desc: Descriptor) -> Symbol {
        return self.glueClasses.symbolType.init(name: self.glueTable.typesByCode[try! unpackAsFourCharCode(desc)],
                                                code: try! unpackAsFourCharCode(desc), type: desc.type, descriptor: desc as? ScalarDescriptor)
    }
    
    override func recordKey(forCode code: OSType) -> Symbol {
        return self.glueClasses.symbolType.init(name: self.glueTable.typesByCode[code], code: code, type: AppleEvents.typeProperty)
    }
}


/******************************************************************************/
// unpack AppleEvent descriptor's contents into struct, to be consumed by SpecifierFormatter.formatCommand()


public extension CommandDescription {
    
    // called by [e.g.] SwiftAutoEdit.app with an intercepted AppleEvent descriptor
    init(event: AppleEventDescriptor, appData: DynamicAppData) { // TO DO: would be more flexible to take AppData + GlueTable as separate params
        // unpack the event's parameters
        
        fatalError("TO DO")
        /*
        
        var rawParameters = [OSType:Any]()
        for (key, desc) in event.parameters {
            rawParameters[key] = (try? appData.unpackAsAny(desc)) ?? desc
        }
        //
        if let commandInfo = appData.glueTable.commandsByCode[event.code] {
            var keywordParameters = [(String, Any)]()
            for paramInfo in commandInfo.parameters { // this ignores parameters that don't have a keyword name; it should also ignore ("as",keyAERequestedType) parameter (this is probably best done by ensuring that command parsers always omit it)
                if let value = rawParameters[paramInfo.code] {
                    keywordParameters.append((paramInfo.name, value))
                }
            }
            let directParameter = rawParameters[keyDirectObject] ?? noParameter
            let requestedType = rawParameters[keyAERequestedType] as? Symbol
            // make sure all keyword parameters have been matched to parameter names
            if rawParameters.count == keywordParameters.count + (isParameter(directParameter) ? 1 : 0)
                + ((requestedType != nil && commandInfo.parameter(for: keyAERequestedType) == nil) ? 1 : 0) { // TO DO: check this logic re. keyAERequestedType
                self.signature = .named(name: commandInfo.name, directParameter: directParameter,
                                      keywordParameters: keywordParameters, requestedType: requestedType)
            } else {
                self.signature = .codes(event: event.code, parameters: rawParameters)
            }
        } else {
            self.signature = .codes(event: event.code, parameters: rawParameters)
        }
        // unpack subject attribute, if given
        if let desc = try? event.attribute(AEKeyword(keySubjectAttr)) {
            if desc.type != typeNull { // typeNull = root application object
                self.subject = (try? appData.unpackAsAny(desc)) ?? desc // TO DO: double-check formatter knows how to display descriptor (or any other non-specifier) as customRoot
            }
        }
        // unpack reply requested and timeout attributes (note: these attributes are unreliable since their values are passed via AESendMessage() rather than packed directly into the AppleEvent)
        if let replyRequested: Int32 = try? event.decodeFixedWidthValueAttribute(keyReplyRequestedAttr, as: typeSInt32) {
            // keyReplyRequestedAttr appears to be a boolean value encoded as Int32 (1=wait or queue reply; 0=no reply)
            if replyRequested == 0 { self.waitReply = false }
        }
        if let timeoutInTicks: Int32 = try? event.decodeFixedWidthValueAttribute(keyTimeoutAttr, as: typeSInt32) {
            if timeoutInTicks == -2 { // NoTimeout // TO DO: ditto
                self.withTimeout = -2
            } else if timeoutInTicks > 0 {
                self.withTimeout = Double(timeoutInTicks) / 60.0
            }
        }
        // considering/ignoring attributes
        if let considersAndIgnores: UInt32 = try? event.decodeFixedWidthValueAttribute(AEKeyword(enumConsidsAndIgnores), as: typeUInt32) {
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
 */
    }
}


