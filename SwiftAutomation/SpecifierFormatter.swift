//
//  Formatter.swift
//  SwiftAutomation
//
//  Generates source code representation of Specifier.
//

import Foundation
import AppKit
import Carbon


// TO DO: when formatting specifiers, what info is needed? appData?, isNestedSpecifier; anything else? (note, this data ought to be available throughout; e.g. given a list of specifiers, current nesting flag should be carried over; there is also the question of when to adopt specifier's own appData vs use the one already provided to formatter; furthermore, it might be argued that AppData should do the formatting itself [although that leaves the flag problem])

// TO DO: how to display nested App root as shorthand? (really need separate description(nested:Bool) func, or else use visitor API - note that a simplified api only need replicate constructor calls, not individual specifier+selector method calls; it also gives cleaner approach to glue-specific hooks and dynamic use, and encapsulating general Swift type formatting)

// note: using an external formatter class allows different formatters to be swapped in for other languages

// TO DO: when displaying by-range specifier's start and stop, simplify by-index/by-name representations where appropriate, e.g. `TextEdit().documents[TEDCon.documents[1], TEDCon.documents[-2]]` should display as `TextEdit().documents[1, -2]`




/******************************************************************************/
// Formatter

// used by a Specifier's description property to render Swift literal representation of itself;
// static glues instantiate this with their own application-specific code->name translation tables

// TO DO: either make this class fully open so it can be overridden (e.g. to generate representations for other languages), or make its format() method part of a Formatter protocol

public class SpecifierFormatter {
    
    let applicationClassName: String, classNamePrefix: String // used to render specifier roots (Application, App, Con, Its)
    let typeNames: [OSType:String], propertyNames: [OSType:String], elementsNames: [OSType: (singular: String, plural: String)]
    
    public required init(applicationClassName: String = "Application", classNamePrefix: String = "", typeNames: [OSType:String] = [:],
                         propertyNames: [OSType:String] = [:], elementsNames: [OSType: (singular: String, plural: String)] = [:]) {
        self.applicationClassName = applicationClassName
        self.classNamePrefix = classNamePrefix
        self.typeNames = typeNames
        self.propertyNames = propertyNames
        self.elementsNames = elementsNames
    }
    
    // TO DO: improve naming conventions, e.g. `format(object: Any)`, `format(symbol:Symbol)`
    
    public func format(_ object: Any) -> String { // TO DO: optional `nested: Bool = false` parameter
        // formats Specifier, Symbol as literals
        switch object {
            // TO DO: this isn't right yet: specifiers with different formatter should use that formatter (think we're getting tied in knots here regarding static vs dynamic - and since dynamic requires a completely different appdata+formatter it's kinda academic)
        case let obj as RootSpecifier:
            return self.formatRootSpecifier(obj)
        case let obj as InsertionSpecifier:
            return self.formatInsertionSpecifier(obj)
        case let obj as ObjectSpecifier:
            return self.formatObjectSpecifier(obj)
        case let obj as ComparisonTest:
            return self.formatComparisonTest(obj)
        case let obj as LogicalTest:
            return self.formatLogicalTest(obj)
        case let obj as Symbol:
            return self.formatSymbol(obj)
        default:
            return self.formatValue(object)
        }
    }
    
    // hooks
    
    func formatSymbol(_ symbol: Symbol) -> String {
        return self.formatSymbol(name: symbol.name, code: symbol.code, type: symbol.type)
    }
    
    func formatSymbol(name: String?, code: OSType, type: OSType) -> String {
        if name != nil { // either a string-based record key or a standard symbol
            return "\(self.classNamePrefix)" + (type == noOSType ? "(\(self.formatValue(name!)))" : ".\(name!)")
        } else if let typeName = self.typeNames[code] {
            return "\(self.classNamePrefix).\(typeName)"
        } else {
            return "\(self.classNamePrefix)(code:\(formatFourCharCodeLiteral(code)),type:\(formatFourCharCodeLiteral(type)))"
        }
    }
    
    func formatPropertyVar(_ code: OSType) -> String {
        if let name = self.propertyNames[code] ?? self.elementsNames[code]?.plural {
            return ".\(name)"
        } else { // no code->name translation available
            return ".property(\(formatFourCharCodeLiteral(code)))"
        }
    }
    
    func formatElementsVar(_ code: OSType) -> String {
        if let name = self.elementsNames[code]?.plural ?? self.propertyNames[code] {
            return ".\(name)"
        } else { // no code->name translation available
            return ".elements(\(formatFourCharCodeLiteral(code)))"
        }
    }
    
    // Specifier formatters
    
    func formatRootSpecifier(_ specifier: RootSpecifier) -> String {
        var hasCustomRoot = true
        if let desc = specifier.rootObject as? AEDesc {
            switch desc.descriptorType {
            case typeCurrentContainer:
                return "\(self.classNamePrefix)Con"
            case typeObjectBeingExamined:
                return "\(self.classNamePrefix)Its"
            case typeNull:
                hasCustomRoot = false
            default:
                break
            }
        }
        var result  = applicationClassName
        switch specifier.appData.target {
        case .none:
            result = "\(self.classNamePrefix)App"
        case .current:
            result += ".currentApplication()"
        case .name(let name):
            result += "(name: \(self.format(name)))"
        case .url(let url):
            result += url.isFileURL ? "(name: \(self.format(url.path)))" : "(url: \(self.format(url)))"
        case .bundleIdentifier(let bundleID, let isDefault):
            result += isDefault ? "()" : "(bundleIdentifier: \(self.format(bundleID)))"
        case .processIdentifier(let pid):
            result += "(processIdentifier: \(pid))"
        case .Descriptor(let desc):
            result += "(addressDescriptor: \(desc))"
        // TO DO: should launch and relaunch flags also be shown, or is that overkill? (might show them if they're non-default values, but no point showing them when they're defaults)
        }
        if hasCustomRoot {
            result += ".customRoot(\(self.format(specifier.rootObject)))"
        }
        return result
    }
    
    func formatInsertionSpecifier(_ specifier: InsertionSpecifier) -> String {
        if let name = [kAEBeginning: "beginning", kAEEnd: "end", kAEBefore: "before", kAEAfter: "after"][specifier.position] {
            return "\(self.format(specifier.parentQuery)).\(name)"
        } else { // unknown (bad) position
            return "<\(type(of: specifier))(kpos:\(specifier.position),kobj:\(self.format(specifier.parentQuery)))>"
        }
    }
    
    func formatObjectSpecifier(_ specifier: ObjectSpecifier) -> String {
        let form = specifier.selectorForm
        var result = self.format(specifier.parentQuery)
        switch form {
        case OSType(formPropertyID):
            // kludge, seld is either desc or symbol, depending on whether constructed or unpacked; TO DO: eliminate?
            if let desc = specifier.selectorData as? AEDesc, let prop = try? desc.fourCharCode() {
                return result + formatPropertyVar(prop)
            } else if let symbol = specifier.selectorData as? Symbol {
                return result + formatPropertyVar(symbol.code)
            } // else malformed desc
        case OSType(formUserPropertyID):
            return "\(result).userProperty(\(self.formatValue(specifier.selectorData)))"
        case OSType(formRelativePosition): // specifier.previous/next(SYMBOL)
            if let seld = specifier.selectorData as? AEDesc, // ObjectSpecifier.unpackSelf does not unpack ordinals
                    let name = [kAEPrevious: "previous", kAENext: "next"][try! seld.fourCharCode()],
                    let parent = specifier.parentQuery as? ObjectSpecifier {
                if specifier.wantType == parent.wantType {
                    return "\(result).\(name)()" // use shorthand form for neatness
                } else {
                    let element = self.formatSymbol(name: nil, code: specifier.wantType, type: typeType)
                    return "\(result).\(name)(\(element))"
                }
            }
        default:
            result += formatElementsVar(specifier.wantType)
            if let desc = specifier.selectorData as? AEDesc, (try? desc.fourCharCode()) == DescType(kAEAll) { // TO DO: check this is right (replaced `where` with `,`)
                return result
            }
            switch form {
            case OSType(formAbsolutePosition): // specifier[IDX] or specifier.first/middle/last/any
                if let code = try? (specifier.selectorData as? AEDesc)?.fourCharCode(), // ObjectSpecifier.unpackSelf does not unpack ordinals
                    let ordinal = [DescType(kAEFirst): "first", DescType(kAEMiddle): "middle",
                                   DescType(kAELast): "last", DescType(kAEAny): "any"][code] {
                    return "\(result).\(ordinal)"
                } else {
                    return "\(result)[\(self.formatValue(specifier.selectorData))]"
                }
            case OSType(formName): // specifier[NAME] or specifier.named(NAME)
                return specifier.selectorData is Int ? "\(result).named(\(self.formatValue(specifier.selectorData)))"
                                                     : "\(result)[\(self.formatValue(specifier.selectorData))]"
            case OSType(formUniqueID): // specifier.ID(UID)
                return "\(result).ID(\(self.format(specifier.selectorData)))"
            case OSType(formRange): // specifier[FROM,TO]
                if let seld = specifier.selectorData as? RangeSelector {
                    return "\(result)[\(self.format(seld.start)), \(self.format(seld.stop))]" // TO DO: app-based specifiers should use untargeted 'App' root; con-based specifiers should be reduced to minimal representation if their wantType == specifier.wantType
                }
            case OSType(formTest): // specifier[TEST]
                return "\(result)[\(self.format(specifier.selectorData))]"
            default:
                break
            }
        }
        return "<\(type(of: specifier))(want:\(specifier.wantType),form:\(specifier.selectorForm),seld:\(self.formatValue(specifier.selectorData)),from:\(self.format(specifier.parentQuery)))>"
    }
    
    private let _comparisonOperators = [OSType(kAELessThan): "<", OSType(kAELessThanEquals): "<=", OSType(kAEEquals): "==",
                                        OSType(kAENotEquals): "!=", OSType(kAEGreaterThan): ">", OSType(kAEGreaterThanEquals): ">="]
    private let _logicalOperators = [OSType(kAEBeginsWith): "beginsWith", OSType(kAEEndsWith): "endsWith",
                                     OSType(kAEContains): "contains", OSType(kAEIsIn): "isIn"]
    
    func formatComparisonTest(_ specifier: ComparisonTest) -> String {
        let operand1 = self.formatValue(specifier.operand1), operand2 = self.formatValue(specifier.operand2)
        if let name = self._comparisonOperators[specifier.operatorType] {
            return "\(operand1) \(name) \(operand2)"
        } else if let name = self._logicalOperators[specifier.operatorType] {
            return "\(operand1).\(name)(\(operand2))"
        }
        return "<\(type(of: specifier))(relo:\(specifier.operatorType),obj1:\(self.formatValue(operand1)),obj2:\(self.formatValue(operand2)))>"
    }
    
    func formatLogicalTest(_ specifier: LogicalTest) -> String {
        let operands = specifier.operands.map({self.formatValue($0)})
        if let name = [kAEAND: "&&", kAEOR: "||"][specifier.operatorType] {
            if operands.count > 1 {
                return operands.joined(separator: " \(name) ")
            }
        } else if specifier.operatorType == kAENOT && operands.count == 1 {
            return "!(\(operands[0]))"
        }
        return "<\(type(of: specifier))(logc:\(specifier.operatorType),term:\(self.formatValue(operands)))>"
    }

    // general formatting functions

    func formatValue(_ value: Any) -> String { // TO DO: this should probably be a method on SpecifierFormatter so that it can be overridden to generate representations for other languages
        switch value {
        case let obj as SelfFormatting:
            return obj.SwiftAutomation_formatSelf(self)
        case let obj as String:
            return obj.debugDescription
        case let obj as Date:
            return "Date(timeIntervalSinceReferenceDate:\(obj.timeIntervalSinceReferenceDate)) /*\(obj.description)*/"
        case let obj as URL:
            if obj.isFileURL {
                return "URL(fileURLWithPath:\(self.formatValue(obj.path)))"
            } else {
                return "URL(string:\(self.formatValue(obj.absoluteString)))"
            }
        // bridged ObjC classes
        case let obj as NSArray:
            return "[" + obj.map({self.formatValue($0)}).joined(separator: ", ") + "]"
        case let obj as NSSet:
            return "[" + obj.map({self.formatValue($0)}).joined(separator: ", ") + "]"
        case let obj as NSDictionary:
            return obj.count == 0 ? "[:]" : "[\(obj.map({"\(self.formatValue($0)): \(self.formatValue($1))"}).joined(separator: ", "))]"
        case let obj as NSNumber where CFBooleanGetTypeID() == CFGetTypeID(obj):
            // note: matching Bool, Int, Double types can be glitchy due to Swift's crappy bridging of ObjC's crappy NSNumber class,
            // so just match NSNumber (which also matches corresponding Swift types) and figure out appropriate representation
            return obj == 0 ? "false" : "true"
        default:
            return "\(value)" // SwiftAutomation objects (specifiers, symbols) are self-formatting; any other value will use its own default description (which may or may not be the same as its literal representation, but that's Swift's problem, not ours)
        }
    }
    
    public func formatCommand(_ description: CommandDescription, applicationObject: RootSpecifier? = nil) -> String {
        var parentSpecifier = applicationObject != nil ? String(describing: applicationObject!) : "\(self.applicationClassName)()"
        var args: [String] = []
        switch description.signature {
        case .named(let name, let directParameter, let keywordParameters, let requestedType):
            if description.subject != nil && isParameter(directParameter) {
                parentSpecifier = self.format(description.subject!)
                args.append(self.format(directParameter))
                //} else if eventClass == kAECoreSuite && eventID == kAECreateElement { // TO DO: format make command as special case (for convenience, sendAppleEvent should allow user to call `make` directly on a specifier, in which case the specifier is used as its `at` parameter if not already given)
            } else if description.subject == nil && isParameter(directParameter) {
                parentSpecifier = self.format(directParameter)
            } else if description.subject != nil && !isParameter(directParameter) {
                parentSpecifier = self.format(description.subject!)
            }
            parentSpecifier += ".\(name)"
            for (key, value) in keywordParameters { args.append("\(key): \(self.format(value))") }
            if let symbol = requestedType { args.append("requestedType: \(symbol)") }
        case .codes(let eventClass, let eventID, let parameters):
            if let subject = description.subject {
                parentSpecifier = self.format(subject)
            }
            parentSpecifier += ".sendAppleEvent"
            args.append("\(formatFourCharCodeLiteral(eventClass)), \(formatFourCharCodeLiteral(eventID))")
            if parameters.count > 0 {
                let params = parameters.map({ "\(formatFourCharCode($0)): \(self.format($1)))" }).joined(separator: ", ")
                args.append("[\(params)]")
            }
        }
        // TO DO: AE's representation of AESendMessage args (waitReply and withTimeout) is unreliable; may be best to ignore these entirely
        /*
         if !eventDescription.waitReply {
         args.append("waitReply: false")
         }
         //sendOptions: NSAppleEventSendOptions? = nil
         if eventDescription.withTimeout != defaultTimeout {
         args.append("withTimeout: \(eventDescription.withTimeout)") // TO DO: if -2, use NoTimeout constant (except 10.11 hasn't defined one yet, and is still buggy in any case)
         }
         */
        if description.considering != defaultConsidering {
            args.append("considering: \(description.considering)")
        }
        return "try \(parentSpecifier)(\(args.joined(separator: ", ")))"
    }
}

