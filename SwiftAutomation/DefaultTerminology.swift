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
import Carbon


// TO DO: check for any missing terms (e.g. ctxt)


public class DefaultTerminology: ApplicationTerminology {
    
    // note: each client language should create its own DefaultTerminology instance, passing its own keyword converter to init, then pass the resulting DefaultTerminology instance to GlueData constructor // TO DO: would probably be cleaner if KeywordConverter base class automatically created and cached DefaultTerminology instances
    
    public let types: [KeywordTerm]
    public let enumerators: [KeywordTerm]
    public let properties: [KeywordTerm]
    public let elements: [ClassTerm]
    public let commands: [CommandTerm]

    public init(keywordConverter: KeywordConverterProtocol) {
        self.types = self._types.map{ KeywordTerm(name: keywordConverter.convertSpecifierName($0), code: $1) }
        self.enumerators = self._enumerators.map{ KeywordTerm(name: keywordConverter.convertSpecifierName($0), code: $1) }
        self.properties = self._properties.map{ KeywordTerm(name: keywordConverter.convertSpecifierName($0), code: $1) }
        self.elements = self._elements.map{ ClassTerm(singular: keywordConverter.convertSpecifierName($0),
                                                        plural: keywordConverter.convertSpecifierName($1), code: $2) }
        self.commands = self._commands.map({
            return CommandTerm(name: keywordConverter.convertSpecifierName($0), eventClass: $1, eventID: $2,
                               parameters: $3.map{ KeywordTerm(name: keywordConverter.convertParameterName($0), code: $1) })
        })
    }
    
    private typealias Keywords = [(String, OSType)]
    private typealias Elements = [(String, String, OSType)]
    private typealias Commands = [(String, OSType, OSType, [(String, OSType)])]

    // note: AppleScript-style keyword names are automatically converted to the required format using the given keyword converter
    
    // TO DO: review list against current AppleScript AEUT
    
    private let _types: Keywords = [("anything", typeWildCard),
                                    ("boolean", typeBoolean),
                                    ("short integer", typeSInt16),
                                    ("integer", typeSInt32),
                                    ("double integer", typeSInt64),
                                    ("unsigned short integer", typeUInt16), // no AS keyword
                                    ("unsigned integer", typeUInt32),
                                    ("unsigned double integer", typeUInt64), // no AS keyword
                                    ("fixed", typeFixed),
                                    ("long fixed", typeLongFixed),
                                    ("decimal struct", typeDecimalStruct), // no AS keyword
                                    ("small real", typeIEEE32BitFloatingPoint),
                                    ("real", typeIEEE64BitFloatingPoint),
                                    //("extended real", typeExtended),
                                    ("large real", type128BitFloatingPoint), // no AS keyword
                                    ("string", typeText),
                                    ("styled text", typeStyledText),
                                    ("text style info", typeTextStyles),
                                    ("styled clipboard text", typeScrapStyles),
                                    ("encoded string", typeEncodedString),
                                    ("writing code", pScriptTag),
                                    ("international writing code", typeIntlWritingCode),
                                    ("international text", typeIntlText),
                                    ("Unicode text", typeUnicodeText),
                                    ("UTF8 text", typeUTF8Text), // no AS keyword
                                    ("UTF16 text", typeUTF16ExternalRepresentation), // no AS keyword
                                    ("version", typeVersion),
                                    ("date", typeLongDateTime),
                                    ("list", typeAEList),
                                    ("record", typeAERecord),
                                    ("data", typeData),
                                    ("script", typeScript),
                                    ("location reference", typeInsertionLoc),
                                    ("reference", typeObjectSpecifier),
                                    ("alias", typeAlias),
                                    ("file ref", typeFSRef), // no AS keyword
                                    //("file specification", typeFSS),
                                    ("bookmark data", typeBookmarkData), // no AS keyword
                                    ("file URL", typeFileURL), // no AS keyword
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
                                    ("constant", typeEnumeration),
                                    ("property", typeProperty),
                                    ("mach port", typeMachPort), // no AS keyword
                                    ("kernel process ID", typeKernelProcessID), // no AS keyword
                                    ("application bundle ID", typeApplicationBundleID), // no AS keyword
                                    ("process serial number", typeProcessSerialNumber), // no AS keyword
                                    ("application signature", typeApplSignature), // no AS keyword
                                    ("application URL", typeApplicationURL), // no AS keyword
                                    // ("missing value", cMissingValue), // represented as MissingValue constant, not Symbol instance
                                    ("null", typeNull),
                                    ("machine location", typeMachineLoc),
                                    ("machine", OSType(cMachine)), // OpenScripting/ASRegistry.h
                                    ("dash style", typeDashStyle),
                                    ("rotation", typeRotation),
                                    ("item", cObject),
                                    // more OpenScripting terms
                                    ("January", OSType(cJanuary)),
                                    ("February", OSType(cFebruary)),
                                    ("March", OSType(cMarch)),
                                    ("April", OSType(cApril)),
                                    ("May", OSType(cMay)),
                                    ("June", OSType(cJune)),
                                    ("July", OSType(cJuly)),
                                    ("August", OSType(cAugust)),
                                    ("September", OSType(cSeptember)),
                                    ("October", OSType(cOctober)),
                                    ("November", OSType(cNovember)),
                                    ("December", OSType(cDecember)),
                                    ("Sunday", OSType(cSunday)),
                                    ("Monday", OSType(cMonday)),
                                    ("Tuesday", OSType(cTuesday)),
                                    ("Wednesday", OSType(cWednesday)),
                                    ("Thursday", OSType(cThursday)),
                                    ("Friday", OSType(cFriday)),
                                    ("Saturday", OSType(cSaturday)),
 
    ]
    private let _enumerators: Keywords = [("yes", kAEYes),
                                          ("no", kAENo),
                                          ("ask", kAEAsk),
                                          ("case", OSType(kAECase)),
                                          ("diacriticals", OSType(kAEDiacritic)),
                                          ("expansion", OSType(kAEExpansion)),
                                          ("hyphens", OSType(kAEHyphens)),
                                          ("punctuation", OSType(kAEPunctuation)),
                                          ("whitespace", OSType(kAEWhiteSpace)),
                                          ("numeric strings", OSType(kASNumericStrings)),
    ]
    private let _properties: Keywords = [("class", pClass),
                                         ("id", pID),
                                         ("properties", _pALL),
    ]
    private let _elements: Elements = [("item", "items", cObject),
    								   // what about ("text",cText)?
    ]
    private let _commands: Commands = [("run", kCoreEventClass, kAEOpenApplication, []),
                                       ("open", kCoreEventClass, kAEOpenDocuments, []),
                                       ("print", kCoreEventClass, kAEPrintDocuments, []),
                                       ("quit", kCoreEventClass, kAEQuitApplication, [("saving", keyAESaveOptions)]),
                                       ("reopen", kCoreEventClass, kAEReopenApplication, []),
                                       //("launch", _kASAppleScriptSuite, _kASLaunchEvent, []), // this is a hardcoded method
                                       ("activate", kAEMiscStandards, kAEActivate, []),
                                       ("open location", _GURL, _GURL, [("window", _WIND)]),
                                       ("get", kAECoreSuite, kAEGetData, []),
                                       ("set", kAECoreSuite, kAESetData, [("to", keyAEData)]),
    ]
    
    private static let _GURL = try! parseFourCharCode("GURL")
    private static let _WIND = try! parseFourCharCode("WIND")
    private static let _pALL = try! parseFourCharCode("pALL")
}

