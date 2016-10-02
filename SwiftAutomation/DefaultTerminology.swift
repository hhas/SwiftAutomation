//
//  DefaultTerminology.swift
//  SwiftAutomation
//
//  Standard terminology selectively taken from AppleScript's AEUT resource
//
//  Notes: 
//
//  - this list should be updated if/when new terms are added to AS's dictionary
//
//  - old/obsolete terms are retained for sake of compatibility with older Carbon apps' AETEs, which may still use them
//

import Foundation

// TO DO: Would make life easier for users if less useful types aren't listed in introspection APIs, so add a 'legacy' arg to KeywordTerm's init method and flag below so they can be filtered out.

// TO DO: check for any missing terms (e.g. ctxt)


public class DefaultTerminology: ApplicationTerminology {
    
    // note: each client language should create its own DefaultTerminology instance, passing its own keyword converter to init, then pass the resulting DefaultTerminology instance to GlueData constructor // TO DO: would probably be cleaner if KeywordConverter base class automatically created and cached DefaultTerminology instances
    
    public let types: KeywordTerms
    public let enumerators: KeywordTerms
    public let properties: KeywordTerms
    public let elements: KeywordTerms
    public let commands: CommandTerms

    init(keywordConverter: KeywordConverterProtocol) {
        self.types = self._types.map({KeywordTerm(name: keywordConverter.convertSpecifierName($0), kind: .elementOrType, code: $1)})
        self.enumerators = self._enumerators.map({KeywordTerm(name: keywordConverter.convertSpecifierName($0), kind: .enumerator, code: $1)})
        self.properties = self._properties.map({KeywordTerm(name: keywordConverter.convertSpecifierName($0), kind: .property, code: $1)})
        self.elements = self._elements.map({KeywordTerm(name: keywordConverter.convertSpecifierName($0), kind: .elementOrType, code: $1)})
        self.commands = self._commands.map({
            let term = CommandTerm(name: keywordConverter.convertSpecifierName($0), eventClass: $1, eventID: $2)
            for (name, code) in $3 { term.addParameter(keywordConverter.convertParameterName(name), code: code) }
            return term
        })
    }
    
    private typealias Keywords = [(String, OSType)]
    private typealias Commands = [(String, OSType, OSType, [(String, OSType)])]

    // note: AppleScript-style keyword names are automatically converted to the required format using the given keyword converter

    private let _types: Keywords = [("anything", _typeWildCard),
                                    ("boolean", _typeBoolean),
                                    ("short integer", _typeShortInteger),
                                    ("integer", _typeSInt32),
                                    ("unsigned integer", _typeUInt32),
                                    ("double integer", _typeSInt64),
                                    ("fixed", _typeFixed),
                                    ("long fixed", _typeLongFixed),
                                    ("decimal struct", _typeDecimalStruct),
                                    ("short float", _typeShortFloat),
                                    ("float", _typeLongFloat),
                                    ("extended float", _typeExtended),
                                    ("float 128bit", _type128BitFloatingPoint),
                                    ("string", _typeText),
                                    ("styled text", _typeStyledText),
                                    ("text style info", _typeTextStyles),
                                    ("styled clipboard text", _typeScrapStyles),
                                    ("encoded string", _typeEncodedString),
                                    ("writing code", _pScriptTag),
                                    ("international writing code", _typeIntlWritingCode),
                                    ("international text", _typeIntlText),
                                    ("unicode text", _typeUnicodeText),
                                    ("utf8 text", _typeUTF8Text),
                                    ("utf16 text", _typeUTF16ExternalRepresentation),
                                    ("version", _typeVersion),
                                    ("date", _typeLongDateTime),
                                    ("list", _typeUserRecordFields),
                                    ("record", _typeAERecord),
                                    ("data", _typeData),
                                    ("script", _typeScript),
                                    ("location reference", _typeInsertionLoc),
                                    ("reference", _typeObjectSpecifier),
                                    ("alias", _typeAlias),
                                    ("file ref", _typeFSRef),
                                    ("file specification", _typeFSS),
                                    ("file url", _typeFileURL),
                                    ("point", _typeQDPoint),
                                    ("bounding rectangle", _typeQDRectangle),
                                    ("fixed point", _typeFixedPoint),
                                    ("fixed rectangle", _typeFixedRectangle),
                                    ("long point", _typeLongPoint),
                                    ("long rectangle", _typeLongRectangle),
                                    ("long fixed point", _typeLongFixedPoint),
                                    ("long fixed rectangle", _typeLongFixedRectangle),
                                    ("EPS picture", _typeEPS),
                                    ("GIF picture", _typeGIF),
                                    ("JPEG picture", _typeJPEG),
                                    ("PICT picture", _typePict),
                                    ("TIFF picture", _typeTIFF),
                                    ("RGB color", _typeRGBColor),
                                    ("RGB16 color", _typeRGB16),
                                    ("RGB96 color", _typeRGB96),
                                    ("graphic text", _typeGraphicText),
                                    ("color table", _typeColorTable),
                                    ("pixel map record", _typePixMapMinus),
                                    ("best", _typeBest),
                                    ("type class", _typeType),
                                    ("enumerator", _typeEnumeration),
                                    ("property", _typeProperty),
                                    ("mach port", _typeMachPort),
                                    ("kernel process id", _typeKernelProcessID),
                                    ("application bundle id", _typeApplicationBundleID),
                                    ("process serial number", _typeProcessSerialNumber),
                                    ("application signature", _typeApplSignature),
                                    ("application url", _typeApplicationURL),
                                    // ("missing value", _cMissingValue), // represented as MissingValueType, not Symbol
                                    ("null", _typeNull),
                                    ("machine location", _typeMachineLoc),
                                    ("machine", _cMachine),
                                    ("dash style", _typeDashStyle),
                                    ("rotation", _typeRotation),
                                    ("item", _cObject),
                                    ("January", _cJanuary),
                                    ("February", _cFebruary),
                                    ("March", _cMarch),
                                    ("April", _cApril),
                                    ("May", _cMay),
                                    ("June", _cJune),
                                    ("July", _cJuly),
                                    ("August", _cAugust),
                                    ("September", _cSeptember),
                                    ("October", _cOctober),
                                    ("November", _cNovember),
                                    ("December", _cDecember),
                                    ("Sunday", _cSunday),
                                    ("Monday", _cMonday),
                                    ("Tuesday", _cTuesday),
                                    ("Wednesday", _cWednesday),
                                    ("Thursday", _cThursday),
                                    ("Friday", _cFriday),
                                    ("Saturday", _cSaturday),
    ]
    private let _enumerators: Keywords = [("yes", _kAEYes),
                                          ("no", _kAENo),
                                          ("ask", _kAEAsk),
                                          ("case", _kAECase),
                                          ("diacriticals", _kAEDiacritic),
                                          ("expansion", _kAEExpansion),
                                          ("hyphens", _kAEHyphens),
                                          ("punctuation", _kAEPunctuation),
                                          ("whitespace", _kAEWhiteSpace),
                                          ("numeric strings", _kASNumericStrings),
    ]
    private let _properties: Keywords = [("class", _pClass),
                                         ("id", _pID),
                                         ("properties", _pALL),
    ]
    private let _elements: Keywords = [("items", _cObject),
    								   // what about ("text",cText)?
    ]
    private let _commands: Commands = [("run", kCoreEventClass, _kAEOpenApplication, []),
                                       ("open", kCoreEventClass, _kAEOpenDocuments, []),
                                       ("print", kCoreEventClass, _kAEPrintDocuments, []),
                                       ("quit", kCoreEventClass, _kAEQuitApplication, [("saving", _keyAESaveOptions)]),
                                       ("reopen", kCoreEventClass, _kAEReopenApplication, []),
                                       //("launch", _kASAppleScriptSuite, _kASLaunchEvent, []), // this is a hardcoded method
                                       ("activate", _kAEMiscStandards, _kAEActivate, []),
                                       ("open location", _GURL, _GURL, [("window", _WIND)]),
                                       ("get", _kAECoreSuite, _kAEGetData, []),
                                       ("set", _kAECoreSuite, _kAESetData, [("to", _keyAEData)]),
    ]
    
    private static let _GURL = try! fourCharCode("GURL")
    private static let _WIND = try! fourCharCode("WIND")
    private static let _pALL = try! fourCharCode("pALL")
}

