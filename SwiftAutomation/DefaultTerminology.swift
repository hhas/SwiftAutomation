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
//  - old/obsolete terms are retained for sake of compatibility with older Carbon apps' AETEs, which may still use them // TO DO: identify these and separate into legacy section which can be macro-d out
//

import Foundation
import AppleEvents

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
            return CommandTerm(name: keywordConverter.convertSpecifierName($0), event: $1,
                               parameters: $2.map{ KeywordTerm(name: keywordConverter.convertParameterName($0), code: $1) })
        })
    }
    
    private typealias Keywords = [(String, OSType)]
    private typealias Elements = [(String, String, OSType)]
    private typealias Commands = [(String, EventIdentifier, [(String, OSType)])]

    // note: AppleScript-style keyword names are automatically converted to the required format using the given keyword converter
    
    // TO DO: review list against current AppleScript AEUT
    
    private let _types: Keywords = [("anything", AppleEvents.typeWildCard),
                                    ("boolean", AppleEvents.typeBoolean),
                                    ("short integer", AppleEvents.typeSInt16),
                                    ("integer", AppleEvents.typeSInt32),
                                    ("double integer", AppleEvents.typeSInt64),
                                    ("unsigned short integer", AppleEvents.typeUInt16), // no AS keyword
                                    ("unsigned integer", AppleEvents.typeUInt32),
                                    ("unsigned double integer", AppleEvents.typeUInt64), // no AS keyword
                                    ("fixed", AppleEvents.typeFixed),
                                    ("long fixed", AppleEvents.typeLongFixed),
                                    ("decimal struct", AppleEvents.typeDecimalStruct), // no AS keyword
                                    ("small real", AppleEvents.typeIEEE32BitFloatingPoint),
                                    ("real", AppleEvents.typeIEEE64BitFloatingPoint),
                                    //("extended real", AppleEvents.typeExtended),
                                    ("large real", AppleEvents.type128BitFloatingPoint), // no AS keyword
                                    ("string", AppleEvents.typeText),
                                    ("styled text", AppleEvents.typeStyledText),
                                    ("text style info", AppleEvents.typeTextStyles),
                                    ("styled clipboard text", AppleEvents.typeScrapStyles),
                                    ("encoded string", AppleEvents.typeEncodedString),
                                    ("writing code", AppleEvents.pScriptTag),
                                    ("international writing code", AppleEvents.typeIntlWritingCode),
                                    ("international text", AppleEvents.typeIntlText),
                                    ("Unicode text", AppleEvents.typeUnicodeText),
                                    ("UTF8 text", AppleEvents.typeUTF8Text), // no AS keyword
                                    ("UTF16 text", AppleEvents.typeUTF16ExternalRepresentation), // no AS keyword
                                    ("version", AppleEvents.typeVersion),
                                    ("date", AppleEvents.typeLongDateTime),
                                    ("list", AppleEvents.typeAEList),
                                    ("record", AppleEvents.typeAERecord),
                                    ("data", AppleEvents.typeData),
                                    ("script", AppleEvents.typeScript),
                                    ("location reference", AppleEvents.typeInsertionLoc),
                                    ("reference", AppleEvents.typeObjectSpecifier),
                                    ("alias", AppleEvents.typeAlias),
                                    ("file ref", AppleEvents.typeFSRef), // no AS keyword
                                    //("file specification", AppleEvents.typeFSS),
                                    ("bookmark data", AppleEvents.typeBookmarkData), // no AS keyword
                                    ("file URL", AppleEvents.typeFileURL), // no AS keyword
                                    ("point", AppleEvents.typeQDPoint),
                                    ("bounding rectangle", AppleEvents.typeQDRectangle),
                                    ("fixed point", AppleEvents.typeFixedPoint),
                                    ("fixed rectangle", AppleEvents.typeFixedRectangle),
                                    ("long point", AppleEvents.typeLongPoint),
                                    ("long rectangle", AppleEvents.typeLongRectangle),
                                    ("long fixed point", AppleEvents.typeLongFixedPoint),
                                    ("long fixed rectangle", AppleEvents.typeLongFixedRectangle),
                                    ("EPS picture", AppleEvents.typeEPS),
                                    ("GIF picture", AppleEvents.typeGIF),
                                    ("JPEG picture", AppleEvents.typeJPEG),
                                    ("PICT picture", AppleEvents.typePict),
                                    ("TIFF picture", AppleEvents.typeTIFF),
                                    ("RGB color", AppleEvents.typeRGBColor),
                                    ("RGB16 color", AppleEvents.typeRGB16),
                                    ("RGB96 color", AppleEvents.typeRGB96),
                                    ("graphic text", AppleEvents.typeGraphicText),
                                    ("color table", AppleEvents.typeColorTable),
                                    ("pixel map record", AppleEvents.typePixMapMinus),
                                    ("best", AppleEvents.typeBest),
                                    ("type class", AppleEvents.typeType),
                                    ("constant", AppleEvents.typeEnumeration),
                                    ("property", AppleEvents.typeProperty),
                                    ("mach port", AppleEvents.typeMachPort), // no AS keyword
                                    ("kernel process ID", AppleEvents.typeKernelProcessID), // no AS keyword
                                    ("application bundle ID", AppleEvents.typeApplicationBundleID), // no AS keyword
                                    ("process serial number", AppleEvents.typeProcessSerialNumber), // no AS keyword
                                    ("application signature", AppleEvents.typeApplSignature), // no AS keyword
                                    ("application URL", AppleEvents.typeApplicationURL), // no AS keyword
                                    // ("missing value", cMissingValue), // represented as MissingValue constant, not Symbol instance
                                    ("null", AppleEvents.typeNull),
                                    ("machine location", AppleEvents.typeMachineLoc),
                                    ("machine", AppleEvents.cMachine), // OpenScripting/ASRegistry.h
                                    ("dash style", AppleEvents.typeDashStyle),
                                    ("rotation", AppleEvents.typeRotation),
                                    ("item", AppleEvents.cObject),
                                    // more OpenScripting terms
                                    ("January", AppleEvents.cJanuary),
                                    ("February", AppleEvents.cFebruary),
                                    ("March", AppleEvents.cMarch),
                                    ("April", AppleEvents.cApril),
                                    ("May", AppleEvents.cMay),
                                    ("June", AppleEvents.cJune),
                                    ("July", AppleEvents.cJuly),
                                    ("August", AppleEvents.cAugust),
                                    ("September", AppleEvents.cSeptember),
                                    ("October", AppleEvents.cOctober),
                                    ("November", AppleEvents.cNovember),
                                    ("December", AppleEvents.cDecember),
                                    ("Sunday", AppleEvents.cSunday),
                                    ("Monday", AppleEvents.cMonday),
                                    ("Tuesday", AppleEvents.cTuesday),
                                    ("Wednesday", AppleEvents.cWednesday),
                                    ("Thursday", AppleEvents.cThursday),
                                    ("Friday", AppleEvents.cFriday),
                                    ("Saturday", AppleEvents.cSaturday),
 
    ]
    private let _enumerators: Keywords = [("yes", AppleEvents.kAEYes),
                                          ("no", AppleEvents.kAENo),
                                          ("ask", AppleEvents.kAEAsk),
                                          ("case", AppleEvents.kAECase),
                                          ("diacriticals", AppleEvents.kAEDiacritic),
                                          ("expansion", AppleEvents.kAEExpansion),
                                          ("hyphens", AppleEvents.kAEHyphens),
                                          ("punctuation", AppleEvents.kAEPunctuation),
                                          ("whitespace", AppleEvents.kAEWhiteSpace),
                                          ("numeric strings", AppleEvents.kASNumericStrings),
    ]
    private let _properties: Keywords = [("class", AppleEvents.pClass),
                                         ("id", AppleEvents.pID),
                                         ("properties", _pALL),
    ]
    private let _elements: Elements = [("item", "items", AppleEvents.cObject),
    								   // what about ("text",cText)?
    ]
    private let _commands: Commands = [("run", AppleEvents.eventOpenApplication, []),
                                       ("open", AppleEvents.eventOpenDocuments, []),
                                       ("print", AppleEvents.eventPrintDocuments, []),
                                       ("quit", AppleEvents.eventQuitApplication, [("saving", AppleEvents.keyAESaveOptions)]),
                                       ("reopen", AppleEvents.eventReopenApplication, []),
                                       //("launch", _kASAppleScriptSuite, _kASLaunchEvent, []), // this is a hardcoded method
                                       ("activate", AppleEvents.miscEventActivate, []),
                                       ("open location", AppleEvents.miscEventGetURL, [("window", _WIND)]),
                                       ("get", AppleEvents.coreEventGetData, []),
                                       ("set", AppleEvents.coreEventSetData, [("to", AppleEvents.keyAEData)]),
    ]
    
    private static let _WIND = try! parseFourCharCode("WIND")
    private static let _pALL = try! parseFourCharCode("pALL")
}

