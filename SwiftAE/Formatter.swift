//
//  Formatter.swift
//  SwiftAE
//
//  Generates source code representation of Specifier.
//

import Foundation
import AppKit


// TO DO: create Formatter protocol, allowing formatter class to be completely replaced

// TO DO: when formatting specifiers, what info is needed? appData, isNestedSpecifier; anything else? (note, this data ought to be available throughout; e.g. given a list of specifiers, current nesting flag should be carried over; there is also the question of when to adopt specifier's own appData vs use the one already provided to formatter; furthermore, it might be argued that AppData should do the formatting itself [although that leaves the flag problem])

// TO DO: how to display nested App root as shorthand? (really need separate description(nested:Bool) func, or else use visitor API - note that a simplified api only need replicate constructor calls, not individual specifier+selector method calls; it also gives cleaner approach to glue-specific hooks and dynamic use, and encapsulating general Swift type formatting)

        // problem: static glues need terms for generic specifiers, which don't have AppData, so formatter can't go on AppData - it has to go on Specifier, as per-glue static constant

/******************************************************************************/
// Formatter

// used by a Specifier's description property to render Swift literal representation of itself;
// static glues extend this with application-specific code->name translation tables

class SpecifierFormatter { // TO DO: public
    
    // caution: if sending events to self, processes _must_ useSDEF=true or call this function on a background thread, otherwise SwiftAETranslateAppleEvent will deadlock the main loop when it tries to fetch host app's AETE via ascr/gdte event
    
//    class func formatAppleEvent(event: NSAppleEventDescriptor, useSDEF: Bool = false) throws -> String { // TO DO: implement
//        return try SwiftAETranslateAppleEvent(event, useSDEF: useSDEF)
//    }
    
    
    // note: for dynamic glues, generic specifiers will need to use generic 'recording' class, as in py-appscript; static glues, however, need formatter to be available on all specifier (and symbol?) classes at all times
    
    
    let propertyNames: [OSType:String], elementsNames: [OSType:String] // note: dicts should also used in dynamic appdata to translate attribute names to ostypes
    let applicationClassName: String, classNamePrefix: String
    
    
    required init(propertyNames: [OSType:String] = [:], elementsNames: [OSType:String] = [:],
                  applicationClassName: String = "Application", classNamePrefix: String = "") {
        self.propertyNames = propertyNames
        self.elementsNames = elementsNames
        self.applicationClassName = applicationClassName
        self.classNamePrefix = classNamePrefix
    }
    
    
    func format(object: Any) -> String {
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
    
    func formatSymbol(code: OSType) -> String {
        return self.formatSymbol(Symbol.symbol(code)) // TO DO: hook for glue-specific Symbol subclasses
    }
    
    func formatSymbol(symbol: Symbol) -> String {
        return "\(symbol)" // TO DO: if symbol doesn't have a name, try lookup table; also, what, if any, hooks are needed here? (TBH, prob. don't need any hooks, except for class)
    }
    
    func formatPropertyVar(code: OSType) -> String {
        if let name = self.propertyNames[code] ?? self.elementsNames[code] {
            return ".\(name)"
        } else { // no code->name translation available
            return ".property(\(self.format(UTCreateStringForOSType(code).takeRetainedValue())))"
        }
    }
    
    func formatElementsVar(code: OSType) -> String {
        if let name = self.elementsNames[code] ?? self.propertyNames[code] {
            return ".\(name)"
        } else { // no code->name translation available
            return ".elements(\(self.format(UTCreateStringForOSType(code).takeRetainedValue())))"
        }
    }
    
    // Specifier formatters
    
    func formatRootSpecifier(specifier: RootSpecifier) -> String {
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
        if let appData = specifier.appData { // TO DO: and is not already nested inside another specifier/command; TO DO: currently doesn't work for unpacked specifiers
            switch appData.target { // TO DO: should launch and relaunch flags also be shown, or is that overkill?
            case .Current:
                result += ".currentApplication()"
            case .Name(let name):
                result += "(name: \(self.format(name)))"
            case .URL(let url):
                result += "(url: \(self.format(url)))"
            case .BundleIdentifier(let bundleID):
                result += "(bundleIdentifier: \(self.format(bundleID)))"
            case .ProcessIdentifier(let pid):
                result += "(processIdentifier: \(pid))"
            case .Descriptor(let desc):
                result += "(addressDescriptor: \(desc))"
            }
        } else {
            result = "\(self.classNamePrefix)App"
        }
        if hasCustomRoot {
            result += ".customRoot(\(self.format(specifier.rootObject)))"
        }
        return result
    }
    
    func formatInsertionSpecifier(specifier: InsertionSpecifier) -> String {
        if let name = [kAEBeginning: "beginning",
                       kAEEnd: "end", kAEBefore: "before", kAEAfter: "after"][specifier.insertionLocation.enumCodeValue] {
            return "\(self.format(specifier.parentSpecifier)).\(name)"
        }
        return "<\(specifier.dynamicType)(kpos:\(specifier.insertionLocation),kobj:\(self.format(specifier.parentSpecifier)))>"
    }
    
    func formatObjectSpecifier(specifier: ObjectSpecifier) -> String {
        let form = specifier.selectorForm.enumCodeValue
        var result = self.format(specifier.parentSpecifier)
        switch form {
        case formPropertyID:
            // kludge, seld is either desc or symbol, depending on whether constructed or unpacked; TO DO: eliminate?
            if let desc = specifier.selectorData as? NSAppleEventDescriptor, propertyDesc = desc.coerceToDescriptorType(typeType) {
                return result + formatPropertyVar(propertyDesc.typeCodeValue)
            } else if let symbol = specifier.selectorData as? Symbol {
                return result + formatPropertyVar(symbol.code)
            } // else malformed desc
        case formUserPropertyID:
            return "\(result).userProperty(\(formatValue(specifier.selectorData)))"
        default:
            result += formatElementsVar(specifier.wantType.typeCodeValue)
            if let desc = specifier.selectorData as? NSAppleEventDescriptor where desc.typeCodeValue == kAEAll {
                return result
            }
            switch form {
            case formAbsolutePosition: // specifier[IDX] or specifier.first/middle/last/any
                if let desc = specifier.selectorData as? NSAppleEventDescriptor, // ObjectSpecifier.unpackSelf does not unpack ordinals
                        ordinal = [kAEFirst: "first", kAEMiddle: "middle", kAELast: "last", kAEAny: "any"][desc.enumCodeValue] {
                    return "\(result).\(ordinal)"
                } else {
                    return "\(result)[\(formatValue(specifier.selectorData))]"
                }
            case formName: // specifier[NAME] or specifier.named(NAME)
                return specifier.selectorData is Int ? "\(result).named(\(formatValue(specifier.selectorData)))"
                                                     : "\(result)[\(formatValue(specifier.selectorData))]"
            case formUniqueID: // specifier.ID(UID)
                return "\(result).ID(\(self.format(specifier.selectorData)))"
            case formRelativePosition: // specifier.previous/next(SYMBOL)
                if let seld = specifier.selectorData as? NSAppleEventDescriptor, // ObjectSpecifier.unpackSelf does not unpack ordinals
                    name = [kAEPrevious: "previous", kAENext: "next"][seld.enumCodeValue],
                    parent = specifier.parentSpecifier as? ObjectSpecifier {
                        if specifier.wantType.typeCodeValue == parent.wantType.typeCodeValue {
                            return "\(result).\(name)()" // use shorthand form for neatness
                        } else {
                            return "\(result).\(name)(\(self.formatSymbol(specifier.wantType.typeCodeValue)))"
                        }
                }
            case formRange: // specifier[FROM,TO]
                if let seld = specifier.selectorData as? RangeSelector {
                    return "\(result)[\(self.format(seld.start)), \(self.format(seld.stop))]" // TO DO: app-based specifiers should use generic 'App' root; con-based specifiers should be reduced to minimal representation if their wantType == specifier.wantType
                }
            case formTest: // specifier[TEST]
                return "\(result)[\(self.format(specifier.selectorData))]"
            default:
                break
            }
        }
        return "<\(specifier.dynamicType)(want:\(specifier.wantType),form:\(specifier.selectorForm),seld:\(formatValue(specifier.selectorData)),from:\(self.format(specifier.parentSpecifier)))>"
    }
    
    func formatComparisonTest(specifier: ComparisonTest) -> String {
        let operand1 = formatValue(specifier.operand1), operand2 = formatValue(specifier.operand2)
        let opcode = specifier.operatorType.enumCodeValue
        if let name = [kAELessThan: "<", kAELessThanEquals: "<=", kAEEquals: "==",
                       kSAENotEquals: "!=", kAEGreaterThan: ">", kAEGreaterThanEquals: ">="][opcode] {
            return "\(operand1) \(name) \(operand2)"
        } else if let name = [kAEBeginsWith: "beginsWith", kAEEndsWith: "endsWith",
                              kAEContains: "contains", kSAEIsIn: "isIn"][opcode] {
            return "\(operand1).\(name)(\(operand2))"
        }
        return "<\(specifier.dynamicType)(relo:\(specifier.operatorType),obj1:\(formatValue(operand1)),obj2:\(formatValue(operand2)))>"
    }
    
    func formatLogicalTest(specifier: LogicalTest) -> String {
        let operands = specifier.operands.map({formatValue($0)})
        let opcode = specifier.operatorType.enumCodeValue
        if let name = [kAEAND: "&&", kAEOR: "||"][opcode] {
            if operands.count > 1 {
                return operands.joinWithSeparator(" \(name) ")
            }
        } else if opcode == kAENOT && operands.count == 1 {
            return "!(\(operands[0]))"
        }
        return "<\(specifier.dynamicType)(logc:\(specifier.operatorType),term:\(formatValue(operands)))>"
    }
}





func formatValue(object: Any) -> String {
    // formats AE-bridged Swift types as literal syntax; other Swift types will show their default description
    switch object {
    case let obj as [Any]:
        return "[" + obj.map({formatValue($0)}).joinWithSeparator(", ") + "]"
    case let obj as NSDictionary: // kluge as Swift can't express [AnyHashable:AnyObject]
        return "[" + obj.map({"\(formatValue($0)): \(formatValue($1))"}).joinWithSeparator(", ") + "]"
    case let obj as String:
        let tmp = NSMutableString(string: obj)
        for (from, to) in [("\\", "\\\\"), ("\"", "\\\""), ("\r", "\\r"), ("\n", "\\n"), ("\t", "\\t")] {
            tmp.replaceOccurrencesOfString(from, withString: to, options: .LiteralSearch, range: NSMakeRange(0, tmp.length))
        }
        return "\"\(tmp)\""
    case let obj as NSDate:
        return "NSDate(string:\(formatValue(obj.description)))" // TO DO: fix this representation
    case let obj as NSURL:
        return "NSURL(string:\(formatValue(obj.absoluteString)))"
    case let obj as NSNumber:
        // note: matching Bool, Int, Double types can be glitchy due to Swift's crappy bridging of ObjC's crappy NSNumber class,
        // so just match NSNumber (which also matches corresponding Swift types) and figure out appropriate representation
        if CFBooleanGetTypeID() == CFGetTypeID(obj) { // voodoo: NSNumber class cluster uses __NSCFBoolean
            return obj == 0 ? "false" : "true"
        } else {
            return "\(object)"
        }
    default:
        return "\(object)" // SwiftAE objects (specifiers, symbols) are self-formatting; any other Swift object will use its default description (which may or may not be the same as its literal representation, but that's Swift's problem, not ours)
    }
}


