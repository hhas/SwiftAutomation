//
//  VoiceOverGlue.swift
//  VoiceOver.app 9
//  SwiftAutomation.framework 0.1.0
//  `aeglue -S 'VoiceOver.app'`
//


import Foundation
import SwiftAutomation


/******************************************************************************/
// Create an untargeted AppData instance for use in App, Con, Its roots,
// and in Application initializers to create targeted AppData instances.

private let _specifierFormatter = SwiftAutomation.SpecifierFormatter(applicationClassName: "VoiceOver",
                                                     classNamePrefix: "VOV",
                                                     typeNames: [
                                                                     0x616c6973: "alias", // "alis"
                                                                     0x616c7053: "alphabeticSpelling", // "alpS"
                                                                     0x616e6e48: "announcementHistory", // "annH"
                                                                     0x2a2a2a2a: "anything", // "****"
                                                                     0x63617070: "application", // "capp"
                                                                     0x62756e64: "applicationBundleID", // "bund"
                                                                     0x7369676e: "applicationSignature", // "sign"
                                                                     0x61707073: "applicationsMenu", // "apps"
                                                                     0x6170726c: "applicationURL", // "aprl"
                                                                     0x61707220: "April", // "apr\0x20"
                                                                     0x61736b20: "ask", // "ask\0x20"
                                                                     0x61756720: "August", // "aug\0x20"
                                                                     0x62657374: "best", // "best"
                                                                     0x626d726b: "bookmarkData", // "bmrk"
                                                                     0x626f6f6c: "boolean", // "bool"
                                                                     0x71647274: "boundingRectangle", // "qdrt"
                                                                     0x70626e64: "bounds", // "pbnd"
                                                                     0x62727061: "brailleWindow", // "brpa"
                                                                     0x6272704f: "brailleWindowObject", // "brpO"
                                                                     0x63617061: "captionWindow", // "capa"
                                                                     0x6361704f: "captionWindowObject", // "capO"
                                                                     0x63617365: "case_", // "case"
                                                                     0x70636c73: "class_", // "pcls"
                                                                     0x636c7274: "colorTable", // "clrt"
                                                                     0x636d6d64: "commander", // "cmmd"
                                                                     0x636d6d4f: "commanderObject", // "cmmO"
                                                                     0x636d6473: "commandsMenu", // "cmds"
                                                                     0x656e756d: "constant", // "enum"
                                                                     0x6c707478: "content", // "lptx"
                                                                     0x6374786d: "contextualMenu", // "ctxm"
                                                                     0x74646173: "dashStyle", // "tdas"
                                                                     0x74647461: "data", // "tdta"
                                                                     0x6c647420: "date", // "ldt\0x20"
                                                                     0x64656320: "December", // "dec\0x20"
                                                                     0x6465636d: "decimalStruct", // "decm"
                                                                     0x64657356: "desktop", // "desV"
                                                                     0x64696163: "diacriticals", // "diac"
                                                                     0x646f6356: "dock", // "docV"
                                                                     0x636f6d70: "doubleInteger", // "comp"
                                                                     0x646f7756: "down", // "dowV"
                                                                     0x63776f6e: "enabled", // "cwon"
                                                                     0x70766973: "enabled", // "pvis"
                                                                     0x656e6373: "encodedString", // "encs"
                                                                     0x45505320: "EPSPicture", // "EPS\0x20"
                                                                     0x65787061: "expansion", // "expa"
                                                                     0x65787465: "extendedReal", // "exte"
                                                                     0x66656220: "February", // "feb\0x20"
                                                                     0x66737266: "fileRef", // "fsrf"
                                                                     0x66737320: "fileSpecification", // "fss\0x20"
                                                                     0x6675726c: "fileURL", // "furl"
                                                                     0x46697256: "firstItem", // "FirV"
                                                                     0x66697864: "fixed", // "fixd"
                                                                     0x66706e74: "fixedPoint", // "fpnt"
                                                                     0x66726374: "fixedRectangle", // "frct"
                                                                     0x66726920: "Friday", // "fri\0x20"
                                                                     0x47494666: "GIFPicture", // "GIFf"
                                                                     0x63677478: "graphicText", // "cgtx"
                                                                     0x68656c70: "helpMenu", // "help"
                                                                     0x68797068: "hyphens", // "hyph"
                                                                     0x49442020: "id", // "ID\0x20\0x20"
                                                                     0x6c6f6e67: "integer", // "long"
                                                                     0x69747874: "internationalText", // "itxt"
                                                                     0x696e746c: "internationalWritingCode", // "intl"
                                                                     0x696e2056: "intoItem", // "in\0x20V"
                                                                     0x636f626a: "item", // "cobj"
                                                                     0x6974656d: "itemChooser", // "item"
                                                                     0x6a616e20: "January", // "jan\0x20"
                                                                     0x4a504547: "JPEGPicture", // "JPEG"
                                                                     0x6a756c20: "July", // "jul\0x20"
                                                                     0x6a756e20: "June", // "jun\0x20"
                                                                     0x6b706964: "kernelProcessID", // "kpid"
                                                                     0x6b626375: "keyboardCursor", // "kbcu"
                                                                     0x6b62634f: "keyboardCursorObject", // "kbcO"
                                                                     0x6c64626c: "largeReal", // "ldbl"
                                                                     0x4c617356: "lastItem", // "LasV"
                                                                     0x6c617072: "lastPhrase", // "lapr"
                                                                     0x6c61704f: "lastPhraseObject", // "lapO"
                                                                     0x6c656656: "left", // "lefV"
                                                                     0x6c656674: "leftButton", // "left"
                                                                     0x6c696e56: "linkedItem", // "linV"
                                                                     0x6c697374: "list", // "list"
                                                                     0x696e736c: "locationReference", // "insl"
                                                                     0x6c667864: "longFixed", // "lfxd"
                                                                     0x6c667074: "longFixedPoint", // "lfpt"
                                                                     0x6c667263: "longFixedRectangle", // "lfrc"
                                                                     0x6c706e74: "longPoint", // "lpnt"
                                                                     0x6c726374: "longRectangle", // "lrct"
                                                                     0x6d616368: "machine", // "mach"
                                                                     0x6d4c6f63: "machineLocation", // "mLoc"
                                                                     0x706f7274: "machPort", // "port"
                                                                     0x764d6167: "magnification", // "vMag"
                                                                     0x6d617220: "March", // "mar\0x20"
                                                                     0x6d617920: "May", // "may\0x20"
                                                                     0x6d656e56: "menubar", // "menV"
                                                                     0x6d656556: "menuExtras", // "meeV"
                                                                     0x6d6f6e20: "Monday", // "mon\0x20"
                                                                     0x6d6f6375: "mouseCursor", // "mocu"
                                                                     0x6d6f634f: "mouseCursorObject", // "mocO"
                                                                     0x6d6f7355: "mouseSummary", // "mosU"
                                                                     0x6e6f2020: "no", // "no\0x20\0x20"
                                                                     0x6e6f7620: "November", // "nov\0x20"
                                                                     0x6e756c6c: "null", // "null"
                                                                     0x6e756d65: "numericStrings", // "nume"
                                                                     0x6f637420: "October", // "oct\0x20"
                                                                     0x6f6e6365: "once", // "once"
                                                                     0x6f757456: "outOfItem", // "outV"
                                                                     0x70686f53: "phoneticSpelling", // "phoS"
                                                                     0x50494354: "PICTPicture", // "PICT"
                                                                     0x74706d6d: "pixelMapRecord", // "tpmm"
                                                                     0x51447074: "point", // "QDpt"
                                                                     0x706f7369: "position", // "posi"
                                                                     0x70736e20: "processSerialNumber", // "psn\0x20"
                                                                     0x70414c4c: "properties", // "pALL"
                                                                     0x70726f70: "property_", // "prop"
                                                                     0x70756e63: "punctuation", // "punc"
                                                                     0x7175696b: "quickstart", // "quik"
                                                                     0x646f7562: "real", // "doub"
                                                                     0x7265636f: "record", // "reco"
                                                                     0x6f626a20: "reference", // "obj\0x20"
                                                                     0x74723136: "RGB16Color", // "tr16"
                                                                     0x74723936: "RGB96Color", // "tr96"
                                                                     0x63524742: "RGBColor", // "cRGB"
                                                                     0x72696756: "right", // "rigV"
                                                                     0x72696768: "rightButton", // "righ"
                                                                     0x74726f74: "rotation", // "trot"
                                                                     0x73617420: "Saturday", // "sat\0x20"
                                                                     0x73637074: "script", // "scpt"
                                                                     0x73657020: "September", // "sep\0x20"
                                                                     0x73686f72: "shortInteger", // "shor"
                                                                     0x73696e67: "smallReal", // "sing"
                                                                     0x73706f56: "spotlight", // "spoV"
                                                                     0x54455854: "string", // "TEXT"
                                                                     0x7374796c: "styledClipboardText", // "styl"
                                                                     0x53545854: "styledText", // "STXT"
                                                                     0x73756e20: "Sunday", // "sun\0x20"
                                                                     0x74737479: "textStyleInfo", // "tsty"
                                                                     0x766f7478: "textUnderCursor", // "votx"
                                                                     0x74687269: "thrice", // "thri"
                                                                     0x74687520: "Thursday", // "thu\0x20"
                                                                     0x54494646: "TIFFPicture", // "TIFF"
                                                                     0x74756520: "Tuesday", // "tue\0x20"
                                                                     0x74776963: "twice", // "twic"
                                                                     0x74797065: "typeClass", // "type"
                                                                     0x75747874: "UnicodeText", // "utxt"
                                                                     0x75636f6d: "unsignedDoubleInteger", // "ucom"
                                                                     0x6d61676e: "unsignedInteger", // "magn"
                                                                     0x75736872: "unsignedShortInteger", // "ushr"
                                                                     0x75702056: "up", // "up\0x20V"
                                                                     0x75743136: "UTF16Text", // "ut16"
                                                                     0x75746638: "UTF8Text", // "utf8"
                                                                     0x7574696c: "utility", // "util"
                                                                     0x76657273: "version", // "vers"
                                                                     0x766f6375: "voCursor", // "vocu"
                                                                     0x766f634f: "voCursorObject", // "vocO"
                                                                     0x7668656c: "VoiceOverHelp", // "vhel"
                                                                     0x7765626d: "webMenu", // "webm"
                                                                     0x7765624f: "webOverview", // "webO"
                                                                     0x77656420: "Wednesday", // "wed\0x20"
                                                                     0x77686974: "whitespace", // "whit"
                                                                     0x77696e4f: "windowOverview", // "winO"
                                                                     0x77696e64: "windowsMenu", // "wind"
                                                                     0x776f7253: "workspaceOverview", // "worS"
                                                                     0x70736374: "writingCode", // "psct"
                                                                     0x79657320: "yes", // "yes\0x20"
                                                     ],
                                                     propertyNames: [
                                                                     0x70626e64: "bounds", // "pbnd"
                                                                     0x62727061: "brailleWindow", // "brpa"
                                                                     0x63617061: "captionWindow", // "capa"
                                                                     0x70636c73: "class_", // "pcls"
                                                                     0x636d6d64: "commander", // "cmmd"
                                                                     0x6c707478: "content", // "lptx"
                                                                     0x63776f6e: "enabled", // "cwon"
                                                                     0x70766973: "enabled", // "pvis"
                                                                     0x49442020: "id", // "ID\0x20\0x20"
                                                                     0x6b626375: "keyboardCursor", // "kbcu"
                                                                     0x6c617072: "lastPhrase", // "lapr"
                                                                     0x764d6167: "magnification", // "vMag"
                                                                     0x6d6f6375: "mouseCursor", // "mocu"
                                                                     0x706f7369: "position", // "posi"
                                                                     0x70414c4c: "properties", // "pALL"
                                                                     0x766f7478: "textUnderCursor", // "votx"
                                                                     0x766f6375: "voCursor", // "vocu"
                                                     ],
                                                     elementsNames: [
                                                                     0x63617070: ("application", "applications"), // "capp"
                                                                     0x6272704f: ("braille window object", "brailleWindowObjects"), // "brpO"
                                                                     0x6361704f: ("caption window object", "captionWindowObjects"), // "capO"
                                                                     0x636d6d4f: ("commander object", "commanderObjects"), // "cmmO"
                                                                     0x636f626a: ("item", "items"), // "cobj"
                                                                     0x6b62634f: ("keyboard cursor object", "keyboardCursorObjects"), // "kbcO"
                                                                     0x6c61704f: ("last phrase object", "lastPhraseObjects"), // "lapO"
                                                                     0x6d6f634f: ("mouse cursor object", "mouseCursorObjects"), // "mocO"
                                                                     0x766f634f: ("vo cursor object", "voCursorObject"), // "vocO"
                                                     ])

private let _glueClasses = SwiftAutomation.GlueClasses(insertionSpecifierType: VOVInsertion.self,
                                       objectSpecifierType: VOVItem.self,
                                       multiObjectSpecifierType: VOVItems.self,
                                       rootSpecifierType: VOVRoot.self,
                                       applicationType: VoiceOver.self,
                                       symbolType: VOVSymbol.self,
                                       formatter: _specifierFormatter)

private let _untargetedAppData = SwiftAutomation.AppData(glueClasses: _glueClasses)


/******************************************************************************/
// Symbol subclass defines static type/enum/property constants based on VoiceOver.app terminology

public class VOVSymbol: SwiftAutomation.Symbol {

    override public var typeAliasName: String {return "VOV"}

    public override class func symbol(code: OSType, type: OSType = typeType, descriptor: NSAppleEventDescriptor? = nil) -> VOVSymbol {
        switch (code) {
        case 0x616c6973: return self.alias // "alis"
        case 0x616c7053: return self.alphabeticSpelling // "alpS"
        case 0x616e6e48: return self.announcementHistory // "annH"
        case 0x2a2a2a2a: return self.anything // "****"
        case 0x63617070: return self.application // "capp"
        case 0x62756e64: return self.applicationBundleID // "bund"
        case 0x7369676e: return self.applicationSignature // "sign"
        case 0x61707073: return self.applicationsMenu // "apps"
        case 0x6170726c: return self.applicationURL // "aprl"
        case 0x61707220: return self.April // "apr\0x20"
        case 0x61736b20: return self.ask // "ask\0x20"
        case 0x61756720: return self.August // "aug\0x20"
        case 0x62657374: return self.best // "best"
        case 0x626d726b: return self.bookmarkData // "bmrk"
        case 0x626f6f6c: return self.boolean // "bool"
        case 0x71647274: return self.boundingRectangle // "qdrt"
        case 0x70626e64: return self.bounds // "pbnd"
        case 0x62727061: return self.brailleWindow // "brpa"
        case 0x6272704f: return self.brailleWindowObject // "brpO"
        case 0x63617061: return self.captionWindow // "capa"
        case 0x6361704f: return self.captionWindowObject // "capO"
        case 0x63617365: return self.case_ // "case"
        case 0x70636c73: return self.class_ // "pcls"
        case 0x636c7274: return self.colorTable // "clrt"
        case 0x636d6d64: return self.commander // "cmmd"
        case 0x636d6d4f: return self.commanderObject // "cmmO"
        case 0x636d6473: return self.commandsMenu // "cmds"
        case 0x656e756d: return self.constant // "enum"
        case 0x6c707478: return self.content // "lptx"
        case 0x6374786d: return self.contextualMenu // "ctxm"
        case 0x74646173: return self.dashStyle // "tdas"
        case 0x74647461: return self.data // "tdta"
        case 0x6c647420: return self.date // "ldt\0x20"
        case 0x64656320: return self.December // "dec\0x20"
        case 0x6465636d: return self.decimalStruct // "decm"
        case 0x64657356: return self.desktop // "desV"
        case 0x64696163: return self.diacriticals // "diac"
        case 0x646f6356: return self.dock // "docV"
        case 0x636f6d70: return self.doubleInteger // "comp"
        case 0x646f7756: return self.down // "dowV"
        case 0x63776f6e: return self.enabled // "cwon"
        case 0x70766973: return self.enabled // "pvis"
        case 0x656e6373: return self.encodedString // "encs"
        case 0x45505320: return self.EPSPicture // "EPS\0x20"
        case 0x65787061: return self.expansion // "expa"
        case 0x65787465: return self.extendedReal // "exte"
        case 0x66656220: return self.February // "feb\0x20"
        case 0x66737266: return self.fileRef // "fsrf"
        case 0x66737320: return self.fileSpecification // "fss\0x20"
        case 0x6675726c: return self.fileURL // "furl"
        case 0x46697256: return self.firstItem // "FirV"
        case 0x66697864: return self.fixed // "fixd"
        case 0x66706e74: return self.fixedPoint // "fpnt"
        case 0x66726374: return self.fixedRectangle // "frct"
        case 0x66726920: return self.Friday // "fri\0x20"
        case 0x47494666: return self.GIFPicture // "GIFf"
        case 0x63677478: return self.graphicText // "cgtx"
        case 0x68656c70: return self.helpMenu // "help"
        case 0x68797068: return self.hyphens // "hyph"
        case 0x49442020: return self.id // "ID\0x20\0x20"
        case 0x6c6f6e67: return self.integer // "long"
        case 0x69747874: return self.internationalText // "itxt"
        case 0x696e746c: return self.internationalWritingCode // "intl"
        case 0x696e2056: return self.intoItem // "in\0x20V"
        case 0x636f626a: return self.item // "cobj"
        case 0x6974656d: return self.itemChooser // "item"
        case 0x6a616e20: return self.January // "jan\0x20"
        case 0x4a504547: return self.JPEGPicture // "JPEG"
        case 0x6a756c20: return self.July // "jul\0x20"
        case 0x6a756e20: return self.June // "jun\0x20"
        case 0x6b706964: return self.kernelProcessID // "kpid"
        case 0x6b626375: return self.keyboardCursor // "kbcu"
        case 0x6b62634f: return self.keyboardCursorObject // "kbcO"
        case 0x6c64626c: return self.largeReal // "ldbl"
        case 0x4c617356: return self.lastItem // "LasV"
        case 0x6c617072: return self.lastPhrase // "lapr"
        case 0x6c61704f: return self.lastPhraseObject // "lapO"
        case 0x6c656656: return self.left // "lefV"
        case 0x6c656674: return self.leftButton // "left"
        case 0x6c696e56: return self.linkedItem // "linV"
        case 0x6c697374: return self.list // "list"
        case 0x696e736c: return self.locationReference // "insl"
        case 0x6c667864: return self.longFixed // "lfxd"
        case 0x6c667074: return self.longFixedPoint // "lfpt"
        case 0x6c667263: return self.longFixedRectangle // "lfrc"
        case 0x6c706e74: return self.longPoint // "lpnt"
        case 0x6c726374: return self.longRectangle // "lrct"
        case 0x6d616368: return self.machine // "mach"
        case 0x6d4c6f63: return self.machineLocation // "mLoc"
        case 0x706f7274: return self.machPort // "port"
        case 0x764d6167: return self.magnification // "vMag"
        case 0x6d617220: return self.March // "mar\0x20"
        case 0x6d617920: return self.May // "may\0x20"
        case 0x6d656e56: return self.menubar // "menV"
        case 0x6d656556: return self.menuExtras // "meeV"
        case 0x6d6f6e20: return self.Monday // "mon\0x20"
        case 0x6d6f6375: return self.mouseCursor // "mocu"
        case 0x6d6f634f: return self.mouseCursorObject // "mocO"
        case 0x6d6f7355: return self.mouseSummary // "mosU"
        case 0x6e6f2020: return self.no // "no\0x20\0x20"
        case 0x6e6f7620: return self.November // "nov\0x20"
        case 0x6e756c6c: return self.null // "null"
        case 0x6e756d65: return self.numericStrings // "nume"
        case 0x6f637420: return self.October // "oct\0x20"
        case 0x6f6e6365: return self.once // "once"
        case 0x6f757456: return self.outOfItem // "outV"
        case 0x70686f53: return self.phoneticSpelling // "phoS"
        case 0x50494354: return self.PICTPicture // "PICT"
        case 0x74706d6d: return self.pixelMapRecord // "tpmm"
        case 0x51447074: return self.point // "QDpt"
        case 0x706f7369: return self.position // "posi"
        case 0x70736e20: return self.processSerialNumber // "psn\0x20"
        case 0x70414c4c: return self.properties // "pALL"
        case 0x70726f70: return self.property_ // "prop"
        case 0x70756e63: return self.punctuation // "punc"
        case 0x7175696b: return self.quickstart // "quik"
        case 0x646f7562: return self.real // "doub"
        case 0x7265636f: return self.record // "reco"
        case 0x6f626a20: return self.reference // "obj\0x20"
        case 0x74723136: return self.RGB16Color // "tr16"
        case 0x74723936: return self.RGB96Color // "tr96"
        case 0x63524742: return self.RGBColor // "cRGB"
        case 0x72696756: return self.right // "rigV"
        case 0x72696768: return self.rightButton // "righ"
        case 0x74726f74: return self.rotation // "trot"
        case 0x73617420: return self.Saturday // "sat\0x20"
        case 0x73637074: return self.script // "scpt"
        case 0x73657020: return self.September // "sep\0x20"
        case 0x73686f72: return self.shortInteger // "shor"
        case 0x73696e67: return self.smallReal // "sing"
        case 0x73706f56: return self.spotlight // "spoV"
        case 0x54455854: return self.string // "TEXT"
        case 0x7374796c: return self.styledClipboardText // "styl"
        case 0x53545854: return self.styledText // "STXT"
        case 0x73756e20: return self.Sunday // "sun\0x20"
        case 0x74737479: return self.textStyleInfo // "tsty"
        case 0x766f7478: return self.textUnderCursor // "votx"
        case 0x74687269: return self.thrice // "thri"
        case 0x74687520: return self.Thursday // "thu\0x20"
        case 0x54494646: return self.TIFFPicture // "TIFF"
        case 0x74756520: return self.Tuesday // "tue\0x20"
        case 0x74776963: return self.twice // "twic"
        case 0x74797065: return self.typeClass // "type"
        case 0x75747874: return self.UnicodeText // "utxt"
        case 0x75636f6d: return self.unsignedDoubleInteger // "ucom"
        case 0x6d61676e: return self.unsignedInteger // "magn"
        case 0x75736872: return self.unsignedShortInteger // "ushr"
        case 0x75702056: return self.up // "up\0x20V"
        case 0x75743136: return self.UTF16Text // "ut16"
        case 0x75746638: return self.UTF8Text // "utf8"
        case 0x7574696c: return self.utility // "util"
        case 0x76657273: return self.version // "vers"
        case 0x766f6375: return self.voCursor // "vocu"
        case 0x766f634f: return self.voCursorObject // "vocO"
        case 0x7668656c: return self.VoiceOverHelp // "vhel"
        case 0x7765626d: return self.webMenu // "webm"
        case 0x7765624f: return self.webOverview // "webO"
        case 0x77656420: return self.Wednesday // "wed\0x20"
        case 0x77686974: return self.whitespace // "whit"
        case 0x77696e4f: return self.windowOverview // "winO"
        case 0x77696e64: return self.windowsMenu // "wind"
        case 0x776f7253: return self.workspaceOverview // "worS"
        case 0x70736374: return self.writingCode // "psct"
        case 0x79657320: return self.yes // "yes\0x20"
        default: return super.symbol(code: code, type: type, descriptor: descriptor) as! VOVSymbol
        }
    }

    // Types/properties
    public static let alias = VOVSymbol(name: "alias", code: 0x616c6973, type: typeType) // "alis"
    public static let anything = VOVSymbol(name: "anything", code: 0x2a2a2a2a, type: typeType) // "****"
    public static let application = VOVSymbol(name: "application", code: 0x63617070, type: typeType) // "capp"
    public static let applicationBundleID = VOVSymbol(name: "applicationBundleID", code: 0x62756e64, type: typeType) // "bund"
    public static let applicationSignature = VOVSymbol(name: "applicationSignature", code: 0x7369676e, type: typeType) // "sign"
    public static let applicationURL = VOVSymbol(name: "applicationURL", code: 0x6170726c, type: typeType) // "aprl"
    public static let April = VOVSymbol(name: "April", code: 0x61707220, type: typeType) // "apr\0x20"
    public static let August = VOVSymbol(name: "August", code: 0x61756720, type: typeType) // "aug\0x20"
    public static let best = VOVSymbol(name: "best", code: 0x62657374, type: typeType) // "best"
    public static let bookmarkData = VOVSymbol(name: "bookmarkData", code: 0x626d726b, type: typeType) // "bmrk"
    public static let boolean = VOVSymbol(name: "boolean", code: 0x626f6f6c, type: typeType) // "bool"
    public static let boundingRectangle = VOVSymbol(name: "boundingRectangle", code: 0x71647274, type: typeType) // "qdrt"
    public static let bounds = VOVSymbol(name: "bounds", code: 0x70626e64, type: typeType) // "pbnd"
    public static let brailleWindow = VOVSymbol(name: "brailleWindow", code: 0x62727061, type: typeType) // "brpa"
    public static let brailleWindowObject = VOVSymbol(name: "brailleWindowObject", code: 0x6272704f, type: typeType) // "brpO"
    public static let captionWindow = VOVSymbol(name: "captionWindow", code: 0x63617061, type: typeType) // "capa"
    public static let captionWindowObject = VOVSymbol(name: "captionWindowObject", code: 0x6361704f, type: typeType) // "capO"
    public static let class_ = VOVSymbol(name: "class_", code: 0x70636c73, type: typeType) // "pcls"
    public static let colorTable = VOVSymbol(name: "colorTable", code: 0x636c7274, type: typeType) // "clrt"
    public static let commander = VOVSymbol(name: "commander", code: 0x636d6d64, type: typeType) // "cmmd"
    public static let commanderObject = VOVSymbol(name: "commanderObject", code: 0x636d6d4f, type: typeType) // "cmmO"
    public static let constant = VOVSymbol(name: "constant", code: 0x656e756d, type: typeType) // "enum"
    public static let content = VOVSymbol(name: "content", code: 0x6c707478, type: typeType) // "lptx"
    public static let dashStyle = VOVSymbol(name: "dashStyle", code: 0x74646173, type: typeType) // "tdas"
    public static let data = VOVSymbol(name: "data", code: 0x74647461, type: typeType) // "tdta"
    public static let date = VOVSymbol(name: "date", code: 0x6c647420, type: typeType) // "ldt\0x20"
    public static let December = VOVSymbol(name: "December", code: 0x64656320, type: typeType) // "dec\0x20"
    public static let decimalStruct = VOVSymbol(name: "decimalStruct", code: 0x6465636d, type: typeType) // "decm"
    public static let doubleInteger = VOVSymbol(name: "doubleInteger", code: 0x636f6d70, type: typeType) // "comp"
    public static let enabled = VOVSymbol(name: "enabled", code: 0x63776f6e, type: typeType) // "cwon"
    public static let encodedString = VOVSymbol(name: "encodedString", code: 0x656e6373, type: typeType) // "encs"
    public static let EPSPicture = VOVSymbol(name: "EPSPicture", code: 0x45505320, type: typeType) // "EPS\0x20"
    public static let extendedReal = VOVSymbol(name: "extendedReal", code: 0x65787465, type: typeType) // "exte"
    public static let February = VOVSymbol(name: "February", code: 0x66656220, type: typeType) // "feb\0x20"
    public static let fileRef = VOVSymbol(name: "fileRef", code: 0x66737266, type: typeType) // "fsrf"
    public static let fileSpecification = VOVSymbol(name: "fileSpecification", code: 0x66737320, type: typeType) // "fss\0x20"
    public static let fileURL = VOVSymbol(name: "fileURL", code: 0x6675726c, type: typeType) // "furl"
    public static let fixed = VOVSymbol(name: "fixed", code: 0x66697864, type: typeType) // "fixd"
    public static let fixedPoint = VOVSymbol(name: "fixedPoint", code: 0x66706e74, type: typeType) // "fpnt"
    public static let fixedRectangle = VOVSymbol(name: "fixedRectangle", code: 0x66726374, type: typeType) // "frct"
    public static let Friday = VOVSymbol(name: "Friday", code: 0x66726920, type: typeType) // "fri\0x20"
    public static let GIFPicture = VOVSymbol(name: "GIFPicture", code: 0x47494666, type: typeType) // "GIFf"
    public static let graphicText = VOVSymbol(name: "graphicText", code: 0x63677478, type: typeType) // "cgtx"
    public static let id = VOVSymbol(name: "id", code: 0x49442020, type: typeType) // "ID\0x20\0x20"
    public static let integer = VOVSymbol(name: "integer", code: 0x6c6f6e67, type: typeType) // "long"
    public static let internationalText = VOVSymbol(name: "internationalText", code: 0x69747874, type: typeType) // "itxt"
    public static let internationalWritingCode = VOVSymbol(name: "internationalWritingCode", code: 0x696e746c, type: typeType) // "intl"
    public static let item = VOVSymbol(name: "item", code: 0x636f626a, type: typeType) // "cobj"
    public static let January = VOVSymbol(name: "January", code: 0x6a616e20, type: typeType) // "jan\0x20"
    public static let JPEGPicture = VOVSymbol(name: "JPEGPicture", code: 0x4a504547, type: typeType) // "JPEG"
    public static let July = VOVSymbol(name: "July", code: 0x6a756c20, type: typeType) // "jul\0x20"
    public static let June = VOVSymbol(name: "June", code: 0x6a756e20, type: typeType) // "jun\0x20"
    public static let kernelProcessID = VOVSymbol(name: "kernelProcessID", code: 0x6b706964, type: typeType) // "kpid"
    public static let keyboardCursor = VOVSymbol(name: "keyboardCursor", code: 0x6b626375, type: typeType) // "kbcu"
    public static let keyboardCursorObject = VOVSymbol(name: "keyboardCursorObject", code: 0x6b62634f, type: typeType) // "kbcO"
    public static let largeReal = VOVSymbol(name: "largeReal", code: 0x6c64626c, type: typeType) // "ldbl"
    public static let lastPhrase = VOVSymbol(name: "lastPhrase", code: 0x6c617072, type: typeType) // "lapr"
    public static let lastPhraseObject = VOVSymbol(name: "lastPhraseObject", code: 0x6c61704f, type: typeType) // "lapO"
    public static let list = VOVSymbol(name: "list", code: 0x6c697374, type: typeType) // "list"
    public static let locationReference = VOVSymbol(name: "locationReference", code: 0x696e736c, type: typeType) // "insl"
    public static let longFixed = VOVSymbol(name: "longFixed", code: 0x6c667864, type: typeType) // "lfxd"
    public static let longFixedPoint = VOVSymbol(name: "longFixedPoint", code: 0x6c667074, type: typeType) // "lfpt"
    public static let longFixedRectangle = VOVSymbol(name: "longFixedRectangle", code: 0x6c667263, type: typeType) // "lfrc"
    public static let longPoint = VOVSymbol(name: "longPoint", code: 0x6c706e74, type: typeType) // "lpnt"
    public static let longRectangle = VOVSymbol(name: "longRectangle", code: 0x6c726374, type: typeType) // "lrct"
    public static let machine = VOVSymbol(name: "machine", code: 0x6d616368, type: typeType) // "mach"
    public static let machineLocation = VOVSymbol(name: "machineLocation", code: 0x6d4c6f63, type: typeType) // "mLoc"
    public static let machPort = VOVSymbol(name: "machPort", code: 0x706f7274, type: typeType) // "port"
    public static let magnification = VOVSymbol(name: "magnification", code: 0x764d6167, type: typeType) // "vMag"
    public static let March = VOVSymbol(name: "March", code: 0x6d617220, type: typeType) // "mar\0x20"
    public static let May = VOVSymbol(name: "May", code: 0x6d617920, type: typeType) // "may\0x20"
    public static let Monday = VOVSymbol(name: "Monday", code: 0x6d6f6e20, type: typeType) // "mon\0x20"
    public static let mouseCursor = VOVSymbol(name: "mouseCursor", code: 0x6d6f6375, type: typeType) // "mocu"
    public static let mouseCursorObject = VOVSymbol(name: "mouseCursorObject", code: 0x6d6f634f, type: typeType) // "mocO"
    public static let November = VOVSymbol(name: "November", code: 0x6e6f7620, type: typeType) // "nov\0x20"
    public static let null = VOVSymbol(name: "null", code: 0x6e756c6c, type: typeType) // "null"
    public static let October = VOVSymbol(name: "October", code: 0x6f637420, type: typeType) // "oct\0x20"
    public static let PICTPicture = VOVSymbol(name: "PICTPicture", code: 0x50494354, type: typeType) // "PICT"
    public static let pixelMapRecord = VOVSymbol(name: "pixelMapRecord", code: 0x74706d6d, type: typeType) // "tpmm"
    public static let point = VOVSymbol(name: "point", code: 0x51447074, type: typeType) // "QDpt"
    public static let position = VOVSymbol(name: "position", code: 0x706f7369, type: typeType) // "posi"
    public static let processSerialNumber = VOVSymbol(name: "processSerialNumber", code: 0x70736e20, type: typeType) // "psn\0x20"
    public static let properties = VOVSymbol(name: "properties", code: 0x70414c4c, type: typeType) // "pALL"
    public static let property_ = VOVSymbol(name: "property_", code: 0x70726f70, type: typeType) // "prop"
    public static let real = VOVSymbol(name: "real", code: 0x646f7562, type: typeType) // "doub"
    public static let record = VOVSymbol(name: "record", code: 0x7265636f, type: typeType) // "reco"
    public static let reference = VOVSymbol(name: "reference", code: 0x6f626a20, type: typeType) // "obj\0x20"
    public static let RGB16Color = VOVSymbol(name: "RGB16Color", code: 0x74723136, type: typeType) // "tr16"
    public static let RGB96Color = VOVSymbol(name: "RGB96Color", code: 0x74723936, type: typeType) // "tr96"
    public static let RGBColor = VOVSymbol(name: "RGBColor", code: 0x63524742, type: typeType) // "cRGB"
    public static let rotation = VOVSymbol(name: "rotation", code: 0x74726f74, type: typeType) // "trot"
    public static let Saturday = VOVSymbol(name: "Saturday", code: 0x73617420, type: typeType) // "sat\0x20"
    public static let script = VOVSymbol(name: "script", code: 0x73637074, type: typeType) // "scpt"
    public static let September = VOVSymbol(name: "September", code: 0x73657020, type: typeType) // "sep\0x20"
    public static let shortInteger = VOVSymbol(name: "shortInteger", code: 0x73686f72, type: typeType) // "shor"
    public static let smallReal = VOVSymbol(name: "smallReal", code: 0x73696e67, type: typeType) // "sing"
    public static let string = VOVSymbol(name: "string", code: 0x54455854, type: typeType) // "TEXT"
    public static let styledClipboardText = VOVSymbol(name: "styledClipboardText", code: 0x7374796c, type: typeType) // "styl"
    public static let styledText = VOVSymbol(name: "styledText", code: 0x53545854, type: typeType) // "STXT"
    public static let Sunday = VOVSymbol(name: "Sunday", code: 0x73756e20, type: typeType) // "sun\0x20"
    public static let textStyleInfo = VOVSymbol(name: "textStyleInfo", code: 0x74737479, type: typeType) // "tsty"
    public static let textUnderCursor = VOVSymbol(name: "textUnderCursor", code: 0x766f7478, type: typeType) // "votx"
    public static let Thursday = VOVSymbol(name: "Thursday", code: 0x74687520, type: typeType) // "thu\0x20"
    public static let TIFFPicture = VOVSymbol(name: "TIFFPicture", code: 0x54494646, type: typeType) // "TIFF"
    public static let Tuesday = VOVSymbol(name: "Tuesday", code: 0x74756520, type: typeType) // "tue\0x20"
    public static let typeClass = VOVSymbol(name: "typeClass", code: 0x74797065, type: typeType) // "type"
    public static let UnicodeText = VOVSymbol(name: "UnicodeText", code: 0x75747874, type: typeType) // "utxt"
    public static let unsignedDoubleInteger = VOVSymbol(name: "unsignedDoubleInteger", code: 0x75636f6d, type: typeType) // "ucom"
    public static let unsignedInteger = VOVSymbol(name: "unsignedInteger", code: 0x6d61676e, type: typeType) // "magn"
    public static let unsignedShortInteger = VOVSymbol(name: "unsignedShortInteger", code: 0x75736872, type: typeType) // "ushr"
    public static let UTF16Text = VOVSymbol(name: "UTF16Text", code: 0x75743136, type: typeType) // "ut16"
    public static let UTF8Text = VOVSymbol(name: "UTF8Text", code: 0x75746638, type: typeType) // "utf8"
    public static let version = VOVSymbol(name: "version", code: 0x76657273, type: typeType) // "vers"
    public static let voCursor = VOVSymbol(name: "voCursor", code: 0x766f6375, type: typeType) // "vocu"
    public static let voCursorObject = VOVSymbol(name: "voCursorObject", code: 0x766f634f, type: typeType) // "vocO"
    public static let Wednesday = VOVSymbol(name: "Wednesday", code: 0x77656420, type: typeType) // "wed\0x20"
    public static let writingCode = VOVSymbol(name: "writingCode", code: 0x70736374, type: typeType) // "psct"

    // Enumerators
    public static let alphabeticSpelling = VOVSymbol(name: "alphabeticSpelling", code: 0x616c7053, type: typeEnumerated) // "alpS"
    public static let announcementHistory = VOVSymbol(name: "announcementHistory", code: 0x616e6e48, type: typeEnumerated) // "annH"
    public static let applicationsMenu = VOVSymbol(name: "applicationsMenu", code: 0x61707073, type: typeEnumerated) // "apps"
    public static let ask = VOVSymbol(name: "ask", code: 0x61736b20, type: typeEnumerated) // "ask\0x20"
    public static let case_ = VOVSymbol(name: "case_", code: 0x63617365, type: typeEnumerated) // "case"
    public static let commandsMenu = VOVSymbol(name: "commandsMenu", code: 0x636d6473, type: typeEnumerated) // "cmds"
    public static let contextualMenu = VOVSymbol(name: "contextualMenu", code: 0x6374786d, type: typeEnumerated) // "ctxm"
    public static let desktop = VOVSymbol(name: "desktop", code: 0x64657356, type: typeEnumerated) // "desV"
    public static let diacriticals = VOVSymbol(name: "diacriticals", code: 0x64696163, type: typeEnumerated) // "diac"
    public static let dock = VOVSymbol(name: "dock", code: 0x646f6356, type: typeEnumerated) // "docV"
    public static let down = VOVSymbol(name: "down", code: 0x646f7756, type: typeEnumerated) // "dowV"
    public static let expansion = VOVSymbol(name: "expansion", code: 0x65787061, type: typeEnumerated) // "expa"
    public static let firstItem = VOVSymbol(name: "firstItem", code: 0x46697256, type: typeEnumerated) // "FirV"
    public static let helpMenu = VOVSymbol(name: "helpMenu", code: 0x68656c70, type: typeEnumerated) // "help"
    public static let hyphens = VOVSymbol(name: "hyphens", code: 0x68797068, type: typeEnumerated) // "hyph"
    public static let intoItem = VOVSymbol(name: "intoItem", code: 0x696e2056, type: typeEnumerated) // "in\0x20V"
    public static let itemChooser = VOVSymbol(name: "itemChooser", code: 0x6974656d, type: typeEnumerated) // "item"
    public static let lastItem = VOVSymbol(name: "lastItem", code: 0x4c617356, type: typeEnumerated) // "LasV"
    public static let left = VOVSymbol(name: "left", code: 0x6c656656, type: typeEnumerated) // "lefV"
    public static let leftButton = VOVSymbol(name: "leftButton", code: 0x6c656674, type: typeEnumerated) // "left"
    public static let linkedItem = VOVSymbol(name: "linkedItem", code: 0x6c696e56, type: typeEnumerated) // "linV"
    public static let menubar = VOVSymbol(name: "menubar", code: 0x6d656e56, type: typeEnumerated) // "menV"
    public static let menuExtras = VOVSymbol(name: "menuExtras", code: 0x6d656556, type: typeEnumerated) // "meeV"
    public static let mouseSummary = VOVSymbol(name: "mouseSummary", code: 0x6d6f7355, type: typeEnumerated) // "mosU"
    public static let no = VOVSymbol(name: "no", code: 0x6e6f2020, type: typeEnumerated) // "no\0x20\0x20"
    public static let numericStrings = VOVSymbol(name: "numericStrings", code: 0x6e756d65, type: typeEnumerated) // "nume"
    public static let once = VOVSymbol(name: "once", code: 0x6f6e6365, type: typeEnumerated) // "once"
    public static let outOfItem = VOVSymbol(name: "outOfItem", code: 0x6f757456, type: typeEnumerated) // "outV"
    public static let phoneticSpelling = VOVSymbol(name: "phoneticSpelling", code: 0x70686f53, type: typeEnumerated) // "phoS"
    public static let punctuation = VOVSymbol(name: "punctuation", code: 0x70756e63, type: typeEnumerated) // "punc"
    public static let quickstart = VOVSymbol(name: "quickstart", code: 0x7175696b, type: typeEnumerated) // "quik"
    public static let right = VOVSymbol(name: "right", code: 0x72696756, type: typeEnumerated) // "rigV"
    public static let rightButton = VOVSymbol(name: "rightButton", code: 0x72696768, type: typeEnumerated) // "righ"
    public static let spotlight = VOVSymbol(name: "spotlight", code: 0x73706f56, type: typeEnumerated) // "spoV"
    public static let thrice = VOVSymbol(name: "thrice", code: 0x74687269, type: typeEnumerated) // "thri"
    public static let twice = VOVSymbol(name: "twice", code: 0x74776963, type: typeEnumerated) // "twic"
    public static let up = VOVSymbol(name: "up", code: 0x75702056, type: typeEnumerated) // "up\0x20V"
    public static let utility = VOVSymbol(name: "utility", code: 0x7574696c, type: typeEnumerated) // "util"
    public static let VoiceOverHelp = VOVSymbol(name: "VoiceOverHelp", code: 0x7668656c, type: typeEnumerated) // "vhel"
    public static let webMenu = VOVSymbol(name: "webMenu", code: 0x7765626d, type: typeEnumerated) // "webm"
    public static let webOverview = VOVSymbol(name: "webOverview", code: 0x7765624f, type: typeEnumerated) // "webO"
    public static let whitespace = VOVSymbol(name: "whitespace", code: 0x77686974, type: typeEnumerated) // "whit"
    public static let windowOverview = VOVSymbol(name: "windowOverview", code: 0x77696e4f, type: typeEnumerated) // "winO"
    public static let windowsMenu = VOVSymbol(name: "windowsMenu", code: 0x77696e64, type: typeEnumerated) // "wind"
    public static let workspaceOverview = VOVSymbol(name: "workspaceOverview", code: 0x776f7253, type: typeEnumerated) // "worS"
    public static let yes = VOVSymbol(name: "yes", code: 0x79657320, type: typeEnumerated) // "yes\0x20"
}

public typealias VOV = VOVSymbol // allows symbols to be written as (e.g.) VOV.name instead of VOVSymbol.name


/******************************************************************************/
// Specifier extensions; these add command methods and property/elements getters based on VoiceOver.app terminology

public protocol VOVCommand: SwiftAutomation.SpecifierProtocol {} // provides AE dispatch methods

// Command->Any will be bound when return type can't be inferred, else Command->T

extension VOVCommand {
    @discardableResult public func activate(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "activate", eventClass: 0x6d697363, eventID: 0x61637476, // "misc"/"actv"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func activate<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "activate", eventClass: 0x6d697363, eventID: 0x61637476, // "misc"/"actv"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func click(_ directParameter: Any = SwiftAutomation.NoParameter,
            with: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "click", eventClass: 0x564f4153, eventID: 0x636c696b, // "VOAS"/"clik"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("with", 0x77697468, with), // "with"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func click<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            with: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "click", eventClass: 0x564f4153, eventID: 0x636c696b, // "VOAS"/"clik"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("with", 0x77697468, with), // "with"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func closeMenu(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "closeMenu", eventClass: 0x564f4153, eventID: 0x636c6f73, // "VOAS"/"clos"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func closeMenu<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "closeMenu", eventClass: 0x564f4153, eventID: 0x636c6f73, // "VOAS"/"clos"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func copyToPasteboard(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "copyToPasteboard", eventClass: 0x564f4153, eventID: 0x636f7079, // "VOAS"/"copy"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func copyToPasteboard<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "copyToPasteboard", eventClass: 0x564f4153, eventID: 0x636f7079, // "VOAS"/"copy"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func get(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "get", eventClass: 0x636f7265, eventID: 0x67657464, // "core"/"getd"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func get<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "get", eventClass: 0x636f7265, eventID: 0x67657464, // "core"/"getd"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func grabScreenshot(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "grabScreenshot", eventClass: 0x564f4153, eventID: 0x73686f74, // "VOAS"/"shot"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func grabScreenshot<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "grabScreenshot", eventClass: 0x564f4153, eventID: 0x73686f74, // "VOAS"/"shot"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func move(_ directParameter: Any = SwiftAutomation.NoParameter,
            to: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "move", eventClass: 0x636f7265, eventID: 0x6d6f7665, // "core"/"move"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x746f2020, to), // "to\0x20\0x20"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func move<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            to: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "move", eventClass: 0x636f7265, eventID: 0x6d6f7665, // "core"/"move"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x746f2020, to), // "to\0x20\0x20"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func open(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "open", eventClass: 0x61657674, eventID: 0x6f646f63, // "aevt"/"odoc"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func open<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "open", eventClass: 0x61657674, eventID: 0x6f646f63, // "aevt"/"odoc"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func open_(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "open_", eventClass: 0x564f4153, eventID: 0x6f70656e, // "VOAS"/"open"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func open_<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "open_", eventClass: 0x564f4153, eventID: 0x6f70656e, // "VOAS"/"open"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func openLocation(_ directParameter: Any = SwiftAutomation.NoParameter,
            window: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "openLocation", eventClass: 0x4755524c, eventID: 0x4755524c, // "GURL"/"GURL"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("window", 0x57494e44, window), // "WIND"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func openLocation<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            window: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "openLocation", eventClass: 0x4755524c, eventID: 0x4755524c, // "GURL"/"GURL"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("window", 0x57494e44, window), // "WIND"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func output(_ directParameter: Any = SwiftAutomation.NoParameter,
            with: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "output", eventClass: 0x564f4153, eventID: 0x6f757470, // "VOAS"/"outp"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("with", 0x77697468, with), // "with"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func output<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            with: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "output", eventClass: 0x564f4153, eventID: 0x6f757470, // "VOAS"/"outp"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("with", 0x77697468, with), // "with"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func performAction(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "performAction", eventClass: 0x564f4153, eventID: 0x70657261, // "VOAS"/"pera"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func performAction<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "performAction", eventClass: 0x564f4153, eventID: 0x70657261, // "VOAS"/"pera"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func performCommand(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "performCommand", eventClass: 0x564f4153, eventID: 0x70657243, // "VOAS"/"perC"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func performCommand<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "performCommand", eventClass: 0x564f4153, eventID: 0x70657243, // "VOAS"/"perC"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func press(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "press", eventClass: 0x564f4153, eventID: 0x70726573, // "VOAS"/"pres"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func press<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "press", eventClass: 0x564f4153, eventID: 0x70726573, // "VOAS"/"pres"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func print(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "print", eventClass: 0x61657674, eventID: 0x70646f63, // "aevt"/"pdoc"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func print<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "print", eventClass: 0x61657674, eventID: 0x70646f63, // "aevt"/"pdoc"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func quit(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "quit", eventClass: 0x61657674, eventID: 0x71756974, // "aevt"/"quit"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func quit<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "quit", eventClass: 0x61657674, eventID: 0x71756974, // "aevt"/"quit"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func release(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "release", eventClass: 0x564f4153, eventID: 0x72656c65, // "VOAS"/"rele"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func release<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "release", eventClass: 0x564f4153, eventID: 0x72656c65, // "VOAS"/"rele"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func reopen(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "reopen", eventClass: 0x61657674, eventID: 0x72617070, // "aevt"/"rapp"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func reopen<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "reopen", eventClass: 0x61657674, eventID: 0x72617070, // "aevt"/"rapp"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func run(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "run", eventClass: 0x61657674, eventID: 0x6f617070, // "aevt"/"oapp"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func run<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "run", eventClass: 0x61657674, eventID: 0x6f617070, // "aevt"/"oapp"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func save(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "save", eventClass: 0x564f4153, eventID: 0x73617665, // "VOAS"/"save"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func save<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "save", eventClass: 0x564f4153, eventID: 0x73617665, // "VOAS"/"save"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func select(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "select", eventClass: 0x564f4153, eventID: 0x73656c65, // "VOAS"/"sele"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func select<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "select", eventClass: 0x564f4153, eventID: 0x73656c65, // "VOAS"/"sele"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func set(_ directParameter: Any = SwiftAutomation.NoParameter,
            to: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "set", eventClass: 0x636f7265, eventID: 0x73657464, // "core"/"setd"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x64617461, to), // "data"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func set<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            to: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "set", eventClass: 0x636f7265, eventID: 0x73657464, // "core"/"setd"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x64617461, to), // "data"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
}


public protocol VOVObject: SwiftAutomation.ObjectSpecifierExtension, VOVCommand {} // provides vars and methods for constructing specifiers

extension VOVObject {
    
    // Properties
    public var bounds: VOVItem {return self.property(0x70626e64) as! VOVItem} // "pbnd"
    public var brailleWindow: VOVItem {return self.property(0x62727061) as! VOVItem} // "brpa"
    public var captionWindow: VOVItem {return self.property(0x63617061) as! VOVItem} // "capa"
    public var class_: VOVItem {return self.property(0x70636c73) as! VOVItem} // "pcls"
    public var commander: VOVItem {return self.property(0x636d6d64) as! VOVItem} // "cmmd"
    public var content: VOVItem {return self.property(0x6c707478) as! VOVItem} // "lptx"
    public var enabled: VOVItem {return self.property(0x63776f6e) as! VOVItem} // "cwon"
    public var id: VOVItem {return self.property(0x49442020) as! VOVItem} // "ID\0x20\0x20"
    public var keyboardCursor: VOVItem {return self.property(0x6b626375) as! VOVItem} // "kbcu"
    public var lastPhrase: VOVItem {return self.property(0x6c617072) as! VOVItem} // "lapr"
    public var magnification: VOVItem {return self.property(0x764d6167) as! VOVItem} // "vMag"
    public var mouseCursor: VOVItem {return self.property(0x6d6f6375) as! VOVItem} // "mocu"
    public var position: VOVItem {return self.property(0x706f7369) as! VOVItem} // "posi"
    public var properties: VOVItem {return self.property(0x70414c4c) as! VOVItem} // "pALL"
    public var textUnderCursor: VOVItem {return self.property(0x766f7478) as! VOVItem} // "votx"
    public var voCursor: VOVItem {return self.property(0x766f6375) as! VOVItem} // "vocu"

    // Elements
    public var applications: VOVItems {return self.elements(0x63617070) as! VOVItems} // "capp"
    public var brailleWindowObjects: VOVItems {return self.elements(0x6272704f) as! VOVItems} // "brpO"
    public var captionWindowObjects: VOVItems {return self.elements(0x6361704f) as! VOVItems} // "capO"
    public var commanderObjects: VOVItems {return self.elements(0x636d6d4f) as! VOVItems} // "cmmO"
    public var items: VOVItems {return self.elements(0x636f626a) as! VOVItems} // "cobj"
    public var keyboardCursorObjects: VOVItems {return self.elements(0x6b62634f) as! VOVItems} // "kbcO"
    public var lastPhraseObjects: VOVItems {return self.elements(0x6c61704f) as! VOVItems} // "lapO"
    public var mouseCursorObjects: VOVItems {return self.elements(0x6d6f634f) as! VOVItems} // "mocO"
    public var voCursorObject: VOVItems {return self.elements(0x766f634f) as! VOVItems} // "vocO"
}


/******************************************************************************/
// Specifier subclasses add app-specific extensions

// beginning/end/before/after
public class VOVInsertion: SwiftAutomation.InsertionSpecifier, VOVCommand {}


// property/by-index/by-name/by-id/previous/next/first/middle/last/any
public class VOVItem: SwiftAutomation.ObjectSpecifier, VOVObject {
    public typealias InsertionSpecifierType = VOVInsertion
    public typealias ObjectSpecifierType = VOVItem
    public typealias MultipleObjectSpecifierType = VOVItems
}

// by-range/by-test/all
public class VOVItems: VOVItem, SwiftAutomation.MultipleObjectSpecifierExtension {}

// App/Con/Its
public class VOVRoot: SwiftAutomation.RootSpecifier, VOVObject, SwiftAutomation.RootSpecifierExtension {
    public typealias InsertionSpecifierType = VOVInsertion
    public typealias ObjectSpecifierType = VOVItem
    public typealias MultipleObjectSpecifierType = VOVItems
    public override class var untargetedAppData: SwiftAutomation.AppData { return _untargetedAppData }
}

// Application
public class VoiceOver: VOVRoot, SwiftAutomation.Application {
    public convenience init(launchOptions: SwiftAutomation.LaunchOptions = SwiftAutomation.DefaultLaunchOptions, relaunchMode: SwiftAutomation.RelaunchMode = SwiftAutomation.DefaultRelaunchMode) {
        self.init(rootObject: SwiftAutomation.AppRootDesc, appData: Swift.type(of:self).untargetedAppData.targetedCopy(
                  .bundleIdentifier("com.apple.VoiceOver", true), launchOptions: launchOptions, relaunchMode: relaunchMode))
    }
}

// App/Con/Its root objects used to construct untargeted specifiers; these can be used to construct specifiers for use in commands, though cannot send commands themselves

public let VOVApp = _untargetedAppData.app as! VOVRoot
public let VOVCon = _untargetedAppData.con as! VOVRoot
public let VOVIts = _untargetedAppData.its as! VOVRoot


/******************************************************************************/
// Static types

public typealias VOVRecord = [VOVSymbol:Any] // default Swift type for AERecordDescs







