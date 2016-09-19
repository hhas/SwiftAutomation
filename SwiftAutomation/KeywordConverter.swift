//
//  KeywordConverter.swift
//  SwiftAutomation
//
//

import Foundation

// TO DO: finalize API, implementation


let UPPERCHAR = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
let LOWERCHAR = "abcdefghijklmnopqrstuvwxyz"
let NUMERIC   = "0123456789"
let OTHER     = "_"


let kLegalFirstChars = CharacterSet(charactersIn: UPPERCHAR + LOWERCHAR + OTHER)
let kLegalOtherChars = CharacterSet(charactersIn: UPPERCHAR + LOWERCHAR + OTHER + NUMERIC)


let kSwiftKeywords: Set<String> = [ // Swift 2.0
    // Keywords used in declarations:
    "class", "deinit", "enum", "extension", "func", "import", "init", "internal", "let", "operator",
    "private", "protocol", "public", "static", "struct", "subscript", "typealias", "var",
    // Keywords used in statements:
    "break", "case", "continue", "default", "do", "else", "fallthrough", "for", "if", "in", "return",
    "switch", "where", "while",
    // Keywords used in expressions and types:
    "as", "dynamicType", "false", "is", "nil", "self", "Self", "super", "true",
    "__COLUMN__", "__FILE__", "__FUNCTION__", "__LINE__",
    // Keywords reserved in particular contexts:
    "associativity", "convenience", "dynamic", "didSet", "final", "infix", "inout", "lazy", "left",
    "mutating", "none", "nonmutating",
    "optional", "override", "postfix", "precedence", "prefix", "Protocol", "required", "right",
    "Type", "unowned", "weak", "willSet",
    // "get"/"set" only used in defining getters/setters so shouldn't conflict with apps' get/set commands
    
    // misc
    
    "missingValue", // represented as MissingValueType, not Symbol
]

// Swift glue methods

public let kSwiftAESpecifierMethods: Set<String> = [ // TO DO: review; some names have changed, others still need to be added
    // custom property/element specifiers
    // Query
    "appData",
    "cachedDesc",
    "parentQuery",
    "rootSpecifier",
    // Specifier
    "property",
    "userProperty",
    "elements",
    "sendAppleEvent",
    // ApplicationExtension
    "currentApplication",
    "customRoot",
    // element(s) selectors
    "ID",
    "beginning",
    "end",
    "before",
    "after",
    "previous",
    "next",
    "first",
    "middle",
    "last",
    "any",
    // test clause constructors
    "beginsWith",
    "endsWith",
    "contains",
    "isIn",
    // currently unused
    "help", // TO DO: uppercase?
    "its", // TO DO: unused?
    // miscellaneous
    "isRunning",
    "launch",
    "doTransaction",
]


public let kSwiftAEParameterNames: Set<String> = [
    // standard parameter+attribute names used in SwiftGlueTemplate
    "directParameter",
    "waitReply",
    "withTimeout",
    "considering",
    "resultType",
]


public let kReservedPrefixes: Set<String> = ["NS", "AE", "SwiftAutomation_"] // TO DO: decide


public let kWordSeparators = CharacterSet(charactersIn: " -/")



public protocol KeywordConverterProtocol {
    
    var defaultTerminology: ApplicationTerminology {get}
    
    func convertSpecifierName(_ s: String) -> String
    func convertParameterName(_ s: String) -> String
    func identifierForAppName(_ appName: String) -> String
    func prefixForAppName(_ appName: String) -> String
    func escapeName(_ s: String) -> String // TO DO: make sure this is always applied correctly (might also be wise to document dos/don'ts for implementing it correctly)
}


public class KeywordConverter {
    
    private var cache = [String:String]() // cache previously translated keywords for efficiency; TO DO: max size?

    public init() {}
    
    func convertName(_ s: String, reservedWords: Set<String>) -> String { // Convert string to identifier
        var s = s
        var result: String! = self.cache[s]
        if result == nil {
            s = s.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            if s == "" { return "_" } // sanity check
            let tmp = NSMutableString(string: s)
            // convert keyword to camelcase, e.g. "audio CD playlist" -> "audioCDPlaylist"
            for i in (0..<tmp.length).reversed() {
                let c = tmp.character(at: i)
                if !kLegalOtherChars.contains(UnicodeScalar(c)!) {
                    if kWordSeparators.contains(UnicodeScalar(c)!) { // remove word separator character and capitalize next word
                        tmp.replaceCharacters(in: NSMakeRange(i,2), with: tmp.substring(with: NSMakeRange(i+1,1)).uppercased())
                    } else if c == 38 { // replace "&" with "And"
                        tmp.replaceCharacters(in: NSMakeRange(i,1), with: "And")
                    } else { // replace character with "0xXX" hex code // TO DO: use Swift's backtick identifier quoting where possible?
                        tmp.replaceCharacters(in: NSMakeRange(i,1), with: NSString(format: "0x%2.2X", c) as String)
                    }
                }
            }
            // sanity check: if first character is digit (which it shouldn't ever be), prefix with underscore
            if !kLegalFirstChars.contains(UnicodeScalar(tmp.character(at: 0))!) {
                tmp.insert("_", at: 0)
            }
            result = tmp.copy() as! String // TO DO: check
            if reservedWords.contains(result) || result.hasPrefix("_") || result == "" {
                result = self.escapeName(result)
            }
            self.cache[s] = result
        }
        return result!
    }
    
    func identifierForAppName(_ appName: String, reservedWords: Set<String>) -> String {
        // TO DO: see how well this does in practice
        // TO DO: decide if first letter should always be capitalized (currently it is, e.g. iTunes->ITunes, which is consistent with standard class naming practices, though less visually appealing)
        let tmp = NSMutableString(string: self.convertName(appName, reservedWords: reservedWords))
        tmp.replaceCharacters(in: NSMakeRange(0, 1), with: tmp.substring(with: NSMakeRange(0, 1)).uppercased())
        let result = tmp.copy() as! String
        return reservedWords.contains(result) ? self.escapeName(result) : result
    }
        
    func prefixForAppName(_ appName: String, reservedWords: Set<String>) -> String {
        // Auto-generate a reasonable default classname prefix from an application name.
        // Only A-Z/a-z characters are used, so is most effective when app's name is mostly composed of those characters.
        // Split name into 'words' based on existing word separator characters (space, underscore, hyphen) and intercaps, if any
        let tmp = NSMutableString(string: appName.decomposedStringWithCanonicalMapping)
        tmp.replaceOccurrences(of: "[^A-Za-z _-]", with: "",
                                       options: .regularExpression, range: NSMakeRange(0, tmp.length))
        tmp.replaceOccurrences(of: "([A-Z])", with: " $1", // TO DO: check backwards compatibility (pre Xcode6?)
                                        options: .regularExpression, range: NSMakeRange(0, tmp.length))
        tmp.replaceOccurrences(of: "[ _-]+", with: " ",
                                        options: .regularExpression, range: NSMakeRange(0, tmp.length))
        let words = tmp.trimmingCharacters(in: CharacterSet.whitespaces).components(separatedBy: " ") as [NSString]
        // assemble 3-character prefix, padding with 'X's if fewer than 3 suitable characters are found
        var result: String
        if words.count == 1 { // use first 3 chars of word, e.g. Finder->FIN
            let word = words[0]
            result = word.substring(to: min(3, word.length))
        } else if (words.count == 2) {
            let word1 = words[0], word2 = words[1]
            if word2.length == 1 { // use first 2 chars of first word + only char of second word, e.g. FooB->FOB
                result = word1.substring(to: min(2, word1.length)) + word2.substring(to: 1)
            } else { // use first char of first word + first 2 chars of second word, e.g. TextEdit->TED
                result = word1.substring(to: 1) + word2.substring(to: 2)
            }
        } else { // use first char of first 3 words, e.g. Adobe InDesign->AID
            let word1 = words[0], word2 = words[1], word3 = words[2]
            result = (word1.substring(to: 1) + word2.substring(to: 1)) + word3.substring(to: 1)
        }
        if (result as NSString).length < 3 {
            result = result.padding(toLength: 3, withPad: "X", startingAt: 0)
        }
        result = result.uppercased()
        if reservedWords.contains(result) || result.hasPrefix("_") || result == "" {
            result = self.escapeName(result)
        }
        return result
    }
        
    public func escapeName(_ s: String) -> String {
        return "\(s)_"
    }
}





public class SwiftKeywordConverter: KeywordConverter, KeywordConverterProtocol {
    
    private static var _defaultTerminology: ApplicationTerminology?
    
    public var defaultTerminology: ApplicationTerminology { // initialized on first use
        if type(of: self)._defaultTerminology == nil {
            type(of: self)._defaultTerminology = DefaultTerminology(keywordConverter: self)
        }
        return type(of: self)._defaultTerminology!
    }
    
    private let reservedSpecifierWords = kSwiftKeywords.union(kSwiftAESpecifierMethods)
    private let reservedParameterWords = kSwiftKeywords.union(kSwiftAEParameterNames)
    private let reservedPrefixes = kSwiftKeywords.union(kReservedPrefixes)
    
    public func convertSpecifierName(_ s: String) -> String {
        return self.convertName(s, reservedWords: self.reservedSpecifierWords)
    }
    
    public func convertParameterName(_ s: String) -> String {
        return self.convertName(s, reservedWords: self.reservedParameterWords)
    }
        
    public func identifierForAppName(_ appName: String) -> String {
        return self.identifierForAppName(appName, reservedWords: kSwiftKeywords)
    }
    
    public func prefixForAppName(_ appName: String) -> String {
        return self.prefixForAppName(appName, reservedWords: self.reservedPrefixes)
    }

}


public let gSwiftAEKeywordConverter = SwiftKeywordConverter()


