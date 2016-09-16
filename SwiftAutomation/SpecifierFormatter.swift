//
//  Formatter.swift
//  SwiftAutomation
//
//  Generates source code representation of Specifier.
//

import Foundation
import AppKit


// TO DO: when formatting specifiers, what info is needed? appData?, isNestedSpecifier; anything else? (note, this data ought to be available throughout; e.g. given a list of specifiers, current nesting flag should be carried over; there is also the question of when to adopt specifier's own appData vs use the one already provided to formatter; furthermore, it might be argued that AppData should do the formatting itself [although that leaves the flag problem])

// TO DO: how to display nested App root as shorthand? (really need separate description(nested:Bool) func, or else use visitor API - note that a simplified api only need replicate constructor calls, not individual specifier+selector method calls; it also gives cleaner approach to glue-specific hooks and dynamic use, and encapsulating general Swift type formatting)


/******************************************************************************/
// Formatter

// used by a Specifier's description property to render Swift literal representation of itself;
// static glues instantiate this with their own application-specific code->name translation tables

public class SpecifierFormatter {
    
    let applicationClassName: String, classNamePrefix: String // used to render specifier roots (Application, App, Con, Its)
    let propertyNames: [OSType:String], elementsNames: [OSType:String] // note: dicts should also used in dynamic appdata to translate attribute names to ostypes
    
    public required init(applicationClassName: String = "Application", classNamePrefix: String = "",
                         propertyNames: [OSType:String] = [:], elementsNames: [OSType:String] = [:]) {
        self.applicationClassName = applicationClassName
        self.classNamePrefix = classNamePrefix
        self.propertyNames = propertyNames
        self.elementsNames = elementsNames
    }
    
    
    public func format(_ object: Any) -> String {
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
            return formatValue(object)
        }
    }
    
    // hooks
    
    func formatSymbol(_ code: OSType) -> String {
        return self.formatSymbol(Symbol(code: code)) // TO DO: hook for glue-specific Symbol subclasses
    }
    
    func formatSymbol(_ symbol: Symbol) -> String {
        return "\(symbol)" // TO DO: if symbol doesn't have a name, try lookup table; also, what, if any, hooks are needed here? (TBH, prob. don't need any hooks, except for class)
    }
    
    func formatPropertyVar(_ code: OSType) -> String {
        if let name = self.propertyNames[code] ?? self.elementsNames[code] {
            return ".\(name)"
        } else { // no code->name translation available
            return ".property(\(formatFourCharCodeString(code)))"
        }
    }
    
    func formatElementsVar(_ code: OSType) -> String {
        if let name = self.elementsNames[code] ?? self.propertyNames[code] {
            return ".\(name)"
        } else { // no code->name translation available
            return ".elements(\(formatFourCharCodeString(code)))"
        }
    }
    
    // Specifier formatters
    
    func formatRootSpecifier(_ specifier: RootSpecifier) -> String {
        var hasCustomRoot = true
        if let desc = specifier.rootObject as? NSAppleEventDescriptor {
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
        switch specifier.appData.target { // TO DO: specifiers returned by app currently don't display correctly, showing untargeted App root instead of targeted Application root. i.e. AppData unpacks specifiers using untargeted App RootSpecifier as root, so this will _always_ be .None, which defeats the point (in prototype, the AppData instance was captured in a new mutable formatter instance created by the receiving `description` property; this formatter then walked the specifier chain building up representation using that AppData instance, so even though the root specifier object itself was untargeted the full rendered specifier was displayed as having a targeted root, thus accurately reflecting its ability to dispatch events itself. the mutable renderer also rendered nested specifiers more attractively, since it could always display them with an untargeted App root regardless of how they were actually constructed)
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
        if let name = [kAEBeginning: "beginning",
                       kAEEnd: "end", kAEBefore: "before", kAEAfter: "after"][specifier.insertionLocation.enumCodeValue] {
            return "\(self.format(specifier.parentQuery)).\(name)"
        }
        return "<\(type(of: specifier))(kpos:\(specifier.insertionLocation),kobj:\(self.format(specifier.parentQuery)))>"
    }
    
    func formatObjectSpecifier(_ specifier: ObjectSpecifier) -> String {
        let form = specifier.selectorForm.enumCodeValue
        var result = self.format(specifier.parentQuery)
        switch form {
        case SwiftAE_formPropertyID:
            // kludge, seld is either desc or symbol, depending on whether constructed or unpacked; TO DO: eliminate?
            if let desc = specifier.selectorData as? NSAppleEventDescriptor, let propertyDesc = desc.coerce(toDescriptorType: typeType) {
                return result + formatPropertyVar(propertyDesc.typeCodeValue)
            } else if let symbol = specifier.selectorData as? Symbol {
                return result + formatPropertyVar(symbol.code)
            } // else malformed desc
        case SwiftAE_formUserPropertyID:
            return "\(result).userProperty(\(formatValue(specifier.selectorData)))"
        default:
            result += formatElementsVar(specifier.wantType.typeCodeValue)
            if let desc = specifier.selectorData as? NSAppleEventDescriptor, desc.typeCodeValue == SwiftAE_kAEAll { // TO DO: check this is right (replaced `where` with `,`)
                return result
            }
            switch form {
            case SwiftAE_formAbsolutePosition: // specifier[IDX] or specifier.first/middle/last/any
                if let desc = specifier.selectorData as? NSAppleEventDescriptor, // ObjectSpecifier.unpackSelf does not unpack ordinals
                        let ordinal = [SwiftAE_kAEFirst: "first", SwiftAE_kAEMiddle: "middle", SwiftAE_kAELast: "last", SwiftAE_kAEAny: "any"][desc.enumCodeValue] {
                    return "\(result).\(ordinal)"
                } else {
                    return "\(result)[\(formatValue(specifier.selectorData))]"
                }
            case SwiftAE_formName: // specifier[NAME] or specifier.named(NAME)
                return specifier.selectorData is Int ? "\(result).named(\(formatValue(specifier.selectorData)))"
                                                     : "\(result)[\(formatValue(specifier.selectorData))]"
            case SwiftAE_formUniqueID: // specifier.ID(UID)
                return "\(result).ID(\(self.format(specifier.selectorData)))"
            case SwiftAE_formRelativePosition: // specifier.previous/next(SYMBOL)
                if let seld = specifier.selectorData as? NSAppleEventDescriptor, // ObjectSpecifier.unpackSelf does not unpack ordinals
                    let name = [SwiftAE_kAEPrevious: "previous", SwiftAE_kAENext: "next"][seld.enumCodeValue],
                    let parent = specifier.parentQuery as? ObjectSpecifier {
                        if specifier.wantType.typeCodeValue == parent.wantType.typeCodeValue {
                            return "\(result).\(name)()" // use shorthand form for neatness
                        } else {
                            return "\(result).\(name)(\(self.formatSymbol(specifier.wantType.typeCodeValue)))"
                        }
                }
            case SwiftAE_formRange: // specifier[FROM,TO]
                if let seld = specifier.selectorData as? RangeSelector {
                    return "\(result)[\(self.format(seld.start)), \(self.format(seld.stop))]" // TO DO: app-based specifiers should use untargeted 'App' root; con-based specifiers should be reduced to minimal representation if their wantType == specifier.wantType
                }
            case SwiftAE_formTest: // specifier[TEST]
                return "\(result)[\(self.format(specifier.selectorData))]"
            default:
                break
            }
        }
        return "<\(type(of: specifier))(want:\(specifier.wantType),form:\(specifier.selectorForm),seld:\(formatValue(specifier.selectorData)),from:\(self.format(specifier.parentQuery)))>"
    }
    
    func formatComparisonTest(_ specifier: ComparisonTest) -> String {
        let operand1 = formatValue(specifier.operand1), operand2 = formatValue(specifier.operand2)
        let opcode = specifier.operatorType.enumCodeValue
        if let name = [kAELessThan: "<", kAELessThanEquals: "<=", kAEEquals: "==",
                       kSAENotEquals: "!=", kAEGreaterThan: ">", kAEGreaterThanEquals: ">="][opcode] {
            return "\(operand1) \(name) \(operand2)"
        } else if let name = [kAEBeginsWith: "beginsWith", kAEEndsWith: "endsWith",
                              kAEContains: "contains", kSAEIsIn: "isIn"][opcode] {
            return "\(operand1).\(name)(\(operand2))"
        }
        return "<\(type(of: specifier))(relo:\(specifier.operatorType),obj1:\(formatValue(operand1)),obj2:\(formatValue(operand2)))>"
    }
    
    func formatLogicalTest(_ specifier: LogicalTest) -> String {
        let operands = specifier.operands.map({formatValue($0)})
        let opcode = specifier.operatorType.enumCodeValue
        if let name = [SwiftAE_kAEAND: "&&", SwiftAE_kAEOR: "||"][opcode] {
            if operands.count > 1 {
                return operands.joined(separator: " \(name) ")
            }
        } else if opcode == SwiftAE_kAENOT && operands.count == 1 {
            return "!(\(operands[0]))"
        }
        return "<\(type(of: specifier))(logc:\(specifier.operatorType),term:\(formatValue(operands)))>"
    }
}



// general formatting functions

func formatValue(_ value: Any) -> String { // TO DO: while this function can be used standalone, might be cleanest just to make it a member of SpecifierFormatter
    // formats AE-bridged Swift types as literal syntax; other Swift types will show their default description (unfortunately debugDescription doesn't provide usable literal representations - e.g. String doesn't show tabs in escaped form, Cocoa classes return their [non-literal] description string instead, and reliable representations of Bool/Int/Double are a dead loss as soon as NSNumber gets involved)
    
    // TO DO: how practical to use Mirror?
    
    switch value {
    case let obj as NSArray: // HACK; see also AppData.pack()
        return "[" + obj.map({formatValue($0)}).joined(separator: ", ") + "]"
    case let obj as NSDictionary: // HACK; see also AppData.pack()
        return "[" + obj.map({"\(formatValue($0)): \(formatValue($1))"}).joined(separator: ", ") + "]"
    case let obj as String:
        let tmp = NSMutableString(string: obj)
        for (from, to) in [("\\", "\\\\"), ("\"", "\\\""), ("\r", "\\r"), ("\n", "\\n"), ("\t", "\\t")] {
            tmp.replaceOccurrences(of: from, with: to, options: .literal, range: NSMakeRange(0, tmp.length))
        }
        return "\"\(tmp)\""
    case let obj as Date:
        return "NSDate(string:\(formatValue(obj.description)))" // TO DO: fix this representation (not sure what's best; maybe include human-readable date string as inline comment?)
    case let obj as URL:
        return "NSURL(string:\(formatValue(obj.absoluteString)))" // TO DO: fix this representation
    case let obj as NSNumber:
        // note: matching Bool, Int, Double types can be glitchy due to Swift's crappy bridging of ObjC's crappy NSNumber class,
        // so just match NSNumber (which also matches corresponding Swift types) and figure out appropriate representation
        if CFBooleanGetTypeID() == CFGetTypeID(obj) { // voodoo: NSNumber class cluster uses __NSCFBoolean
            return obj == 0 ? "false" : "true"
        } else {
            return "\(value)"
        }
    default:
        return "\(value)" // SwiftAutomation objects (specifiers, symbols) are self-formatting; any other Swift object will use its own default description (which may or may not be the same as its literal representation, but that's Swift's problem, not ours)
    }
}


func formatFourCharCodeString(_ code: OSType) -> String {
    return "\"\(FourCharCodeString(code))\"" // TO DO: unfinished; non-alphanumeric chars should appear as \x00 codes
}




