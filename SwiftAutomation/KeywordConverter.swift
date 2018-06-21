//
//  KeywordConverter.swift
//  SwiftAutomation
//
//  Convert AETE/SDEF-defined keywords from AppleScript syntax to a form suitable for use in Swift (or other client language)
//

import Foundation


/******************************************************************************/
// Identifiers (legal characters, reserved names, etc)

let uppercaseChars    = Set<Character>("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
let lowercaseChars    = Set<Character>("abcdefghijklmnopqrstuvwxyz")
let numericChars      = Set<Character>("0123456789")
let interstitialChars = Set<Character>("_")
let whitespaceChars   = Set<Character>(" \t\n\r")



let legalFirstChars = uppercaseChars.union(lowercaseChars).union(interstitialChars)
let legalOtherChars = uppercaseChars.union(lowercaseChars).union(interstitialChars).union(numericChars)
let reservedWordSeparators = whitespaceChars.union("-/") // some AETEs may include hyphens and other non-C-identifier/non-space characters in their keyword names, which are problematic in AppleScript (which [e.g.] compiles `trash-object` to `trash - object`) and a PITA in traditionally C-like languages, so we just bite the bullet and treat them all as if they were just simple spaces between words


// TO DO: updated for Swift3, but could be missing some valid keywords - CHECK!!!

let reservedSwiftKeywords: Set<String> = [
    // reserved Swift keywords // TO DO: ideally Swift would provide an API for getting an up-to-date list of all known keywords; for now, we use a hardcoded list of keyword names that needs updated manually each time the language changes and hope we didn't miss any out
    "as", "associatedtype", "autoreleasepool", "break", "case", "catch", "class", "continue", "convenience", "default", "defer", "deinit", "do", "dynamic", "else", "enum", "extension", "fallthrough", "false", "fileprivate", "final", "for", "func", "guard", "if", "import", "in", "infix", "init", "internal", "lazy", "let", "let", "metatype", "mutating", "nil", "nonmutating", "optional", "override", "postfix", "prefix", "private", "protocol", "public", "repeat", "required", "rethrows", "return", "self", "Self", "static", "struct", "subscript", "super", "switch", "throw", "throws", "true", "try", "typealias", "unowned", "var", "var", "weak", "where", "while",

    // "get", "set" are only used in property definitions so shouldn't conflict with apps' get/set commands
    
    // other
    
    "missingValue", // unlike other typeType descriptors, the `missing value` constant (`cMissingValue`) is represented by the `MissingValue` constant (`MissingValueType.missingValue` enum), not a Symbol instance, so that Swift's type system can reliably separate it out when unpacking command results; we reserve its Symbol-based name here purely to stop it appearing on Symbol and confusing users (reserving it here doesn't prevent it being used, should an application's own dictionary define it for some weird reason; it just ensures that it'll include an underscore suffix if it is)
]



// Swift glue methods

public let reservedSpecifierMethods: Set<String> = [ // TO DO: review; some names have changed, others still need to be added
    // custom property/element specifiers
    // Query
    "appData",
    "parentQuery",
    "rootSpecifier",
    "unpackParentSpecifiers",
    "description",
    "debugDescription",
    "customMirror",
    // Specifier
    "property",
    "userProperty",
    "elements",
    "sendAppleEvent",
    // Application
    "currentApplication",
    "customRoot",
    "isRunning",
    "launch",
    "doTransaction",
    // Selectors
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
    "named",
    "all",
    // Test clauses
    "beginsWith",
    "endsWith",
    "contains",
    "isIn",
    // Symbol (class methods only)
    "symbol",
]


public let reservedParameterNames: Set<String> = [
    // standard parameter+attribute names used in SwiftGlueTemplate
    "directParameter",
    "waitReply",
    "withTimeout",
    "considering",
    "resultType",
]


public let reservedPrefixes: Set<String> = ["NS", "AE", "SwiftAutomation"] // TO DO: decide


/******************************************************************************/
// Checks

func isCIdentifier(_ string: String) -> Bool { // returns true if string is a valid C identifier (caution: the client is responsible for checking identifier string won't conflict with known Swift keywords)
    var chars = Substring(string)
    guard let c = chars.first else { return false }
    chars = chars.dropFirst()
    if !legalFirstChars.contains(c) { return false }
    for c in chars { if !legalOtherChars.contains(c) { return false } }
    return true
}


func validateCIdentifier(_ string: String) throws { // throws if not a legal [C-style] identifier in Swift (i.e. contains invalid characters or conflicts with an existing Swift keyword)
    // TO DO: this should really check for valid Swift identifiers, though since all supported stdlib and glue types use C-style names this'll do for now
    if !isCIdentifier(string) || reservedSwiftKeywords.contains(string) {
        throw AutomationError(code: 1, message: "Not a valid identifier: '\(string)'")
    }
}


/******************************************************************************/



public protocol KeywordConverterProtocol {
    
    var defaultTerminology: ApplicationTerminology {get}
    
    func convertSpecifierName(_ s: String) -> String
    func convertParameterName(_ s: String) -> String
    func identifierForAppName(_ appName: String) -> String
    func prefixForAppName(_ appName: String) -> String
    func escapeName(_ s: String) -> String // TO DO: make sure this is always applied correctly (might also be wise to document dos/don'ts for implementing it correctly)
}


public class KeywordConverter {
    
    private var _cache = [String:String]() // cache previously translated keywords for efficiency; TO DO: max size?

    public init() {}
    
    func convertName(_ string: String, reservedWords: Set<String>) -> String { // Convert string to identifier
        if let result = self._cache[string] {
            return result
        } else {
            // convert keyword to camelcase, e.g. "audio CD playlist" -> "audioCDPlaylist"
            // Note that while application dictionaries were originally intended to be multi-language, dialect support was quietly abandoned circa MacOS8 so all dictionaries nowadays use English-language words only. SDEFs in CocoaScripting-based apps restrict each word to C-identifier-safe characters. Occasionally, however, an old-school Carbon app may contain an AETE resource that includes other characters that aren't valid for C-style identifiers; as this is very rare, we mostly just convert these to underscore-delimited hex values.
            var result = ""
            var i = string.startIndex
            var willCapitalize = false
            var charSet = legalFirstChars
            while i < string.endIndex {
                while i < string.endIndex && reservedWordSeparators.contains(string[i]) { // skip whitespace, hyphen, slash
                    i = string.index(after: i)
                }
                while i < string.endIndex {
                    let c = string[i]
                    if charSet.contains(c) {
                        result += (willCapitalize ? String(c).uppercased() : String(c))
                    } else if numericChars.contains(c) { // first character in name is a digit
                        result += "_\(String(c))"
                    } else if c == "&" {
                        result += "And"
                    } else if reservedWordSeparators.contains(c) {
                        break
                    } else {
                        result += String(format: "_U%04X_", String(c).utf16.first!)
                    }
                    i = string.index(after: i)
                    charSet = legalOtherChars
                    willCapitalize = false
                }
                willCapitalize = true
            }
            if reservedWords.contains(result) || result.hasPrefix("_") || result == "" {
                result = self.escapeName(result)
            }
            self._cache[string] = String(result)
            return result
        }
    }
    
    func identifierForAppName(_ appName: String, reservedWords: Set<String>) -> String {
        // auto-generate a glue's Application class name, e.g. "iTunes" -> "ITunes", "System Events" -> "SystemEvents"
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
        
    public func escapeName(_ s: String) -> String { // important: escapeName must always return a non-empty string
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
    
    private let _reservedSpecifierWords = reservedSwiftKeywords.union(reservedSpecifierMethods)
    private let _reservedParameterWords = reservedSwiftKeywords.union(reservedParameterNames)
    private let _reservedPrefixes = reservedSwiftKeywords.union(reservedPrefixes)
    
    public func convertSpecifierName(_ s: String) -> String {
        return self.convertName(s, reservedWords: self._reservedSpecifierWords)
    }
    
    public func convertParameterName(_ s: String) -> String {
        return self.convertName(s, reservedWords: self._reservedParameterWords)
    }
        
    public func identifierForAppName(_ appName: String) -> String {
        return self.identifierForAppName(appName, reservedWords: reservedSwiftKeywords)
    }
    
    public func prefixForAppName(_ appName: String) -> String {
        return self.prefixForAppName(appName, reservedWords: self._reservedPrefixes)
    }

}


public let defaultSwiftKeywordConverter = SwiftKeywordConverter()


