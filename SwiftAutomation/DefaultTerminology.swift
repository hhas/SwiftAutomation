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

    private let _types: Keywords = [("anything", typeWildCard),
                                    ("boolean", typeBoolean),
                                    ("short integer", SwiftAE_typeShortInteger),
                                    ("integer", typeSInt32),
                                    ("unsigned integer", typeUInt32),
                                    ("double integer", typeSInt64),
                                    ("fixed", typeFixed),
                                    ("long fixed", typeLongFixed),
                                    ("decimal struct", typeDecimalStruct),
                                    ("short float", SwiftAE_typeShortFloat),
                                    ("float", SwiftAE_typeLongFloat),
                                    ("extended float", SwiftAE_typeExtended),
                                    ("float 128bit", type128BitFloatingPoint),
                                    ("string", typeText),
                                    ("styled text", typeStyledText),
                                    ("text style info", typeTextStyles),
                                    ("styled clipboard text", typeScrapStyles),
                                    ("encoded string", typeEncodedString),
                                    ("writing code", pScriptTag),
                                    ("international writing code", typeIntlWritingCode),
                                    ("international text", typeIntlText),
                                    ("unicode text", typeUnicodeText),
                                    ("utf8 text", typeUTF8Text),
                                    ("utf16 text", typeUTF16ExternalRepresentation),
                                    ("version", typeVersion),
                                    ("date", typeLongDateTime),
                                    ("list", SwiftAE_typeUserRecordFields),
                                    ("record", typeAERecord),
                                    ("data", typeData),
                                    ("script", typeScript),
                                    ("location reference", typeInsertionLoc),
                                    ("reference", typeObjectSpecifier),
                                    ("alias", typeAlias),
                                    ("file ref", typeFSRef),
                                    ("file specification", SwiftAE_typeFSS),
                                    ("file url", typeFileURL),
                                    ("point", typeQDPoint),
                                    ("bounding rectangle", typeQDRectangle),
                                    ("fixed point", typeFixedPoint),
                                    ("fixed rectangle", typeFixedRectangle),
                                    ("long point", typeLongPoint),
                                    ("long rectangle", typeLongRectangle),
                                    ("long fixed point", typeLongFixedPoint),
                                    ("long fixed rectangle", typeLongFixedRectangle),
                                    ("EPS picture", typeEPS),
                                    ("GIF picture", typeGIF),
                                    ("JPEG picture", typeJPEG),
                                    ("PICT picture", typePict),
                                    ("TIFF picture", typeTIFF),
                                    ("RGB color", typeRGBColor),
                                    ("RGB16 color", typeRGB16),
                                    ("RGB96 color", typeRGB96),
                                    ("graphic text", typeGraphicText),
                                    ("color table", typeColorTable),
                                    ("pixel map record", typePixMapMinus),
                                    ("best", typeBest),
                                    ("type class", typeType),
                                    ("enumerator", typeEnumeration),
                                    ("property", typeProperty),
                                    ("mach port", typeMachPort),
                                    ("kernel process id", typeKernelProcessID),
                                    ("application bundle id", typeApplicationBundleID),
                                    ("process serial number", typeProcessSerialNumber),
                                    ("application signature", typeApplSignature),
                                    ("application url", typeApplicationURL),
                                    ("missing value", SwiftAE_cMissingValue),
                                    ("null", typeNull),
                                    ("machine location", typeMachineLoc),
                                    ("machine", SwiftAE_cMachine),
                                    ("dash style", typeDashStyle),
                                    ("rotation", typeRotation),
                                    ("item", cObject),
                                    ("January", SwiftAE_cJanuary),
                                    ("February", SwiftAE_cFebruary),
                                    ("March", SwiftAE_cMarch),
                                    ("April", SwiftAE_cApril),
                                    ("May", SwiftAE_cMay),
                                    ("June", SwiftAE_cJune),
                                    ("July", SwiftAE_cJuly),
                                    ("August", SwiftAE_cAugust),
                                    ("September", SwiftAE_cSeptember),
                                    ("October", SwiftAE_cOctober),
                                    ("November", SwiftAE_cNovember),
                                    ("December", SwiftAE_cDecember),
                                    ("Sunday", SwiftAE_cSunday),
                                    ("Monday", SwiftAE_cMonday),
                                    ("Tuesday", SwiftAE_cTuesday),
                                    ("Wednesday", SwiftAE_cWednesday),
                                    ("Thursday", SwiftAE_cThursday),
                                    ("Friday", SwiftAE_cFriday),
                                    ("Saturday", SwiftAE_cSaturday),
    ]
    private let _enumerators: Keywords = [("yes", kAEYes),
                                          ("no", kAENo),
                                          ("ask", kAEAsk),
                                          ("case", SwiftAE_kAECase),
                                          ("diacriticals", SwiftAE_kAEDiacritic),
                                          ("expansion", SwiftAE_kAEExpansion),
                                          ("hyphens", SwiftAE_kAEHyphens),
                                          ("punctuation", SwiftAE_kAEPunctuation),
                                          ("whitespace", SwiftAE_kAEWhiteSpace),
                                          ("numeric strings", SwiftAE_kASNumericStrings),
    ]
    private let _properties: Keywords = [("class", pClass),
                                         ("id", pID),
                                         ("properties", _pALL),
    ]
    private let _elements: Keywords = [("items", cObject),
    								   // what about ("text",cText)?
    ]
    private let _commands: Commands = [("run", kCoreEventClass, kAEOpenApplication, []),
                                       ("open", kCoreEventClass, kAEOpenDocuments, []),
                                       ("print", kCoreEventClass, kAEPrintDocuments, []),
                                       ("quit", kCoreEventClass, kAEQuitApplication, [("saving", keyAESaveOptions)]),
                                       ("reopen", kCoreEventClass, kAEReopenApplication, []),
                                       ("launch", SwiftAE_kASAppleScriptSuite, SwiftAE_kASLaunchEvent, []),
                                       ("activate", kAEMiscStandards, kAEActivate, []),
                                       ("open location", _GURL, _GURL, [("window", _WIND)]),
                                       ("get", kAECoreSuite, kAEGetData, []),
                                       ("set", kAECoreSuite, kAESetData, [("to", keyAEData)]),
    ]
    
    private static let _GURL = try! FourCharCode("GURL")
    private static let _WIND = try! FourCharCode("WIND")
    private static let _pALL = try! FourCharCode("pALL")
}

