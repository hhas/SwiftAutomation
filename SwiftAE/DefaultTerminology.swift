//
//  DefaultTerminology.swift
//  SwiftAE
//
//  Standard terminology selectively taken from AppleScript's AEUT resource
//

import Foundation

// note: this uses AS-style names and converts them on instantiation (i.e. each language creates its own DefaultTerminology instance, passing its own keyword converter to init, then passes the result to terminology table builder every time it gets an apps' terms)

// TO DO: Would make life easier for users if less useful types aren't listed in introspection APIs, so add a 'legacy' arg to KeywordTerm's init method and flag below so they can be filtered out.

// TO DO: check for any missing terms (e.g. ctxt)



public class DefaultTerminology: ApplicationTerminology {
    
    public let types: KeywordTerms
    public let enumerators: KeywordTerms
    public let properties: KeywordTerms
    public let elements: KeywordTerms
    public let commands: CommandTerms

    init(keywordConverter: KeywordConverterProtocol) {
        self.types = self._types.map({KeywordTerm(name: keywordConverter.convertSpecifierName($0), kind: .Type, code: $1)})
        self.enumerators = self._enumerators.map({KeywordTerm(name: keywordConverter.convertSpecifierName($0), kind: .Enumerator, code: $1)})
        self.properties = self._properties.map({KeywordTerm(name: keywordConverter.convertSpecifierName($0), kind: .Property, code: $1)})
        self.elements = self._elements.map({KeywordTerm(name: keywordConverter.convertSpecifierName($0), kind: .Type, code: $1)})
        self.commands = self._commands.map({
            let term = CommandTerm(name: keywordConverter.convertSpecifierName($0), eventClass: $1, eventID: $2)
            for (name, code) in $3 { term.addParameter(keywordConverter.convertParameterName(name), code: code) }
            return term
        })
    }
    
    private typealias Keywords = [(String, OSType)]
    private typealias Commands = [(String, OSType, OSType, [(String, OSType)])]

    private let _types: Keywords = [("anything", typeWildCard),
                                    ("boolean", typeBoolean),
                                    ("short integer", typeShortInteger),
                                    ("integer", typeSInt32),
                                    ("unsigned integer", typeUInt32),
                                    ("double integer", typeSInt64),
                                    ("fixed", typeFixed),
                                    ("long fixed", typeLongFixed),
                                    ("decimal struct", typeDecimalStruct),
                                    ("short float", typeShortFloat),
                                    ("float", typeLongFloat),
                                    ("extended float", typeExtended),
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
                                    ("list", typeUserRecordFields),
                                    ("record", typeAERecord),
                                    ("data", typeData),
                                    ("script", typeScript),
                                    ("location reference", typeInsertionLoc),
                                    ("reference", typeObjectSpecifier),
                                    ("alias", typeAlias),
                                    ("file ref", typeFSRef),
                                    ("file specification", typeFSS),
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
                                    ("missing value", cMissingValue),
                                    ("null", typeNull),
                                    ("machine location", typeMachineLoc),
                                    ("machine", cMachine),
                                    ("dash style", typeDashStyle),
                                    ("rotation", typeRotation),
                                    ("suite info", typeSuiteInfo),
                                    ("class info", typeClassInfo),
                                    ("property info", typePropInfo),
                                    ("element info", typeElemInfo),
                                    ("event info", typeEventInfo),
                                    ("parameter info", typeParamInfo),
                                    ("item", cObject),
                                    ("centimeters", typeCentimeters),
                                    ("meters", typeMeters),
                                    ("kilometers", typeKilometers),
                                    ("inches", typeInches),
                                    ("feet", typeFeet),
                                    ("yards", typeYards),
                                    ("miles", typeMiles),
                                    ("square meters", typeSquareMeters),
                                    ("square kilometers", typeSquareKilometers),
                                    ("square feet", typeSquareFeet),
                                    ("square yards", typeSquareYards),
                                    ("square miles", typeSquareMiles),
                                    ("cubic centimeters", typeCubicCentimeter),
                                    ("cubic meters", typeCubicMeters),
                                    ("cubic inches", typeCubicInches),
                                    ("cubic feet", typeCubicFeet),
                                    ("cubic yards", typeCubicYards),
                                    ("liters", typeLiters),
                                    ("quarts", typeQuarts),
                                    ("gallons", typeGallons),
                                    ("grams", typeGrams),
                                    ("kilograms", typeKilograms),
                                    ("ounces", typeOunces),
                                    ("pounds", typePounds),
                                    ("degrees Celsius", typeDegreesC),
                                    ("degrees Fahrenheit", typeDegreesF),
                                    ("degrees Kelvin", typeDegreesK),
                                    ("January", cJanuary),
                                    ("February", cFebruary),
                                    ("March", cMarch),
                                    ("April", cApril),
                                    ("May", cMay),
                                    ("June", cJune),
                                    ("July", cJuly),
                                    ("August", cAugust),
                                    ("September", cSeptember),
                                    ("October", cOctober),
                                    ("November", cNovember),
                                    ("December", cDecember),
                                    ("Sunday", cSunday),
                                    ("Monday", cMonday),
                                    ("Tuesday", cTuesday),
                                    ("Wednesday", cWednesday),
                                    ("Thursday", cThursday),
                                    ("Friday", cFriday),
                                    ("Saturday", cSaturday),
    ]
    private let _enumerators: Keywords = [("yes", kAEYes),
                                          ("no", kAENo),
                                          ("ask", kAEAsk),
                                          ("case", kAECase),
                                          ("diacriticals", kAEDiacritic),
                                          ("expansion", kAEExpansion),
                                          ("hyphens", kAEHyphens),
                                          ("punctuation", kAEPunctuation),
                                          ("whitespace", kAEWhiteSpace),
                                          ("numeric strings", kASNumericStrings),
    ]
    private let _properties: Keywords = [("class", pClass),
                                         ("id", pID),
    ]
    private let _elements: Keywords = [
    ]
    private let _commands: Commands = [("run", kCoreEventClass, kAEOpenApplication, []),
                                       ("open", kCoreEventClass, kAEOpenDocuments, []),
                                       ("print", kCoreEventClass, kAEPrintDocuments, []),
                                       ("quit", kCoreEventClass, kAEQuitApplication, [("saving", keyAESaveOptions)]),
                                       ("reopen", kCoreEventClass, kAEReopenApplication, []),
                                       ("launch", kASAppleScriptSuite, kASLaunchEvent, []),
                                       ("activate", kAEMiscStandards, kAEActivate, []),
                                       ("open location", UTGetOSTypeFromString("GURL"), UTGetOSTypeFromString("GURL"),
                                                                                        [("window", UTGetOSTypeFromString("WIND"))]),
                                       ("get", kAECoreSuite, kAEGetData, []),
                                       ("set", kAECoreSuite, kAESetData, [("to", keyAEData)]),
    ]
}


public let gSwiftAEDefaultTerminology = DefaultTerminology(keywordConverter: gSwiftAEKeywordConverter)

