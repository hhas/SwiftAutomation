//
//  TerminalGlue.swift
//  Terminal.app 2.9.4
//  SwiftAutomation.framework 0.1.0
//  `aeglue -S 'Terminal.app'`
//


import Foundation
import SwiftAutomation


/******************************************************************************/
// Create an untargeted AppData instance for use in App, Con, Its roots,
// and in Application initializers to create targeted AppData instances.

private let _specifierFormatter = SwiftAutomation.SpecifierFormatter(applicationClassName: "Terminal",
                                                     classNamePrefix: "TER",
                                                     typeNames: [
                                                                     0x616c6973: "alias", // "alis"
                                                                     0x2a2a2a2a: "anything", // "****"
                                                                     0x63617070: "application", // "capp"
                                                                     0x62756e64: "applicationBundleID", // "bund"
                                                                     0x7369676e: "applicationSignature", // "sign"
                                                                     0x6170726c: "applicationURL", // "aprl"
                                                                     0x61707220: "April", // "apr\0x20"
                                                                     0x61736b20: "ask", // "ask\0x20"
                                                                     0x61756720: "August", // "aug\0x20"
                                                                     0x7062636c: "backgroundColor", // "pbcl"
                                                                     0x62657374: "best", // "best"
                                                                     0x70627463: "boldTextColor", // "pbtc"
                                                                     0x626d726b: "bookmarkData", // "bmrk"
                                                                     0x626f6f6c: "boolean", // "bool"
                                                                     0x71647274: "boundingRectangle", // "qdrt"
                                                                     0x70626e64: "bounds", // "pbnd"
                                                                     0x62757379: "busy", // "busy"
                                                                     0x63617365: "case_", // "case"
                                                                     0x70636c73: "class_", // "pcls"
                                                                     0x74636c6e: "cleanCommands", // "tcln"
                                                                     0x68636c62: "closeable", // "hclb"
                                                                     0x6c77636c: "collating", // "lwcl"
                                                                     0x63524742: "color", // "cRGB"
                                                                     0x636c7274: "colorTable", // "clrt"
                                                                     0x656e756d: "constant", // "enum"
                                                                     0x70636e74: "contents", // "pcnt"
                                                                     0x6c776370: "copies", // "lwcp"
                                                                     0x74637374: "currentSettings", // "tcst"
                                                                     0x70637563: "cursorColor", // "pcuc"
                                                                     0x7469746c: "customTitle", // "titl"
                                                                     0x74646173: "dashStyle", // "tdas"
                                                                     0x74647461: "data", // "tdta"
                                                                     0x6c647420: "date", // "ldt\0x20"
                                                                     0x64656320: "December", // "dec\0x20"
                                                                     0x6465636d: "decimalStruct", // "decm"
                                                                     0x74647072: "defaultSettings", // "tdpr"
                                                                     0x6c776474: "detailed", // "lwdt"
                                                                     0x64696163: "diacriticals", // "diac"
                                                                     0x636f6d70: "doubleInteger", // "comp"
                                                                     0x656e6373: "encodedString", // "encs"
                                                                     0x6c776c70: "endingPage", // "lwlp"
                                                                     0x45505320: "EPSPicture", // "EPS\0x20"
                                                                     0x6c776568: "errorHandling", // "lweh"
                                                                     0x65787061: "expansion", // "expa"
                                                                     0x65787465: "extendedReal", // "exte"
                                                                     0x6661786e: "faxNumber", // "faxn"
                                                                     0x66656220: "February", // "feb\0x20"
                                                                     0x66737266: "fileRef", // "fsrf"
                                                                     0x66737320: "fileSpecification", // "fss\0x20"
                                                                     0x6675726c: "fileURL", // "furl"
                                                                     0x66697864: "fixed", // "fixd"
                                                                     0x66706e74: "fixedPoint", // "fpnt"
                                                                     0x66726374: "fixedRectangle", // "frct"
                                                                     0x70616e78: "fontAntialiasing", // "panx"
                                                                     0x666f6e74: "fontName", // "font"
                                                                     0x7074737a: "fontSize", // "ptsz"
                                                                     0x70667261: "frame", // "pfra"
                                                                     0x66726920: "Friday", // "fri\0x20"
                                                                     0x70697366: "frontmost", // "pisf"
                                                                     0x47494666: "GIFPicture", // "GIFf"
                                                                     0x63677478: "graphicText", // "cgtx"
                                                                     0x68697374: "history", // "hist"
                                                                     0x68797068: "hyphens", // "hyph"
                                                                     0x49442020: "id", // "ID\0x20\0x20"
                                                                     0x70696478: "index", // "pidx"
                                                                     0x6c6f6e67: "integer", // "long"
                                                                     0x69747874: "internationalText", // "itxt"
                                                                     0x696e746c: "internationalWritingCode", // "intl"
                                                                     0x636f626a: "item", // "cobj"
                                                                     0x6a616e20: "January", // "jan\0x20"
                                                                     0x4a504547: "JPEGPicture", // "JPEG"
                                                                     0x6a756c20: "July", // "jul\0x20"
                                                                     0x6a756e20: "June", // "jun\0x20"
                                                                     0x6b706964: "kernelProcessID", // "kpid"
                                                                     0x6c64626c: "largeReal", // "ldbl"
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
                                                                     0x6d617220: "March", // "mar\0x20"
                                                                     0x6d617920: "May", // "may\0x20"
                                                                     0x69736d6e: "miniaturizable", // "ismn"
                                                                     0x706d6e64: "miniaturized", // "pmnd"
                                                                     0x6d6f6e20: "Monday", // "mon\0x20"
                                                                     0x706e616d: "name", // "pnam"
                                                                     0x6e6f2020: "no", // "no\0x20\0x20"
                                                                     0x70747863: "normalTextColor", // "ptxc"
                                                                     0x6e6f7620: "November", // "nov\0x20"
                                                                     0x6e756c6c: "null", // "null"
                                                                     0x63636f6c: "numberOfColumns", // "ccol"
                                                                     0x63726f77: "numberOfRows", // "crow"
                                                                     0x6e756d65: "numericStrings", // "nume"
                                                                     0x6f637420: "October", // "oct\0x20"
                                                                     0x706f7269: "origin", // "pori"
                                                                     0x6c776c61: "pagesAcross", // "lwla"
                                                                     0x6c776c64: "pagesDown", // "lwld"
                                                                     0x50494354: "PICTPicture", // "PICT"
                                                                     0x74706d6d: "pixelMapRecord", // "tpmm"
                                                                     0x51447074: "point", // "QDpt"
                                                                     0x70706f73: "position", // "ppos"
                                                                     0x70736574: "printSettings", // "pset"
                                                                     0x70726373: "processes", // "prcs"
                                                                     0x70736e20: "processSerialNumber", // "psn\0x20"
                                                                     0x70414c4c: "properties", // "pALL"
                                                                     0x70726f70: "property_", // "prop"
                                                                     0x70756e63: "punctuation", // "punc"
                                                                     0x646f7562: "real", // "doub"
                                                                     0x7265636f: "record", // "reco"
                                                                     0x6f626a20: "reference", // "obj\0x20"
                                                                     0x7072737a: "resizable", // "prsz"
                                                                     0x74723136: "RGB16Color", // "tr16"
                                                                     0x74723936: "RGB96Color", // "tr96"
                                                                     0x74726f74: "rotation", // "trot"
                                                                     0x73617420: "Saturday", // "sat\0x20"
                                                                     0x73637074: "script", // "scpt"
                                                                     0x7462736c: "selected", // "tbsl"
                                                                     0x73657020: "September", // "sep\0x20"
                                                                     0x74707266: "settingsSet", // "tprf"
                                                                     0x73686f72: "shortInteger", // "shor"
                                                                     0x7073697a: "size", // "psiz"
                                                                     0x73696e67: "smallReal", // "sing"
                                                                     0x6c777374: "standard", // "lwst"
                                                                     0x6c776670: "startingPage", // "lwfp"
                                                                     0x74737072: "startupSettings", // "tspr"
                                                                     0x54455854: "string", // "TEXT"
                                                                     0x7374796c: "styledClipboardText", // "styl"
                                                                     0x53545854: "styledText", // "STXT"
                                                                     0x73756e20: "Sunday", // "sun\0x20"
                                                                     0x74746162: "tab", // "ttab"
                                                                     0x74727072: "targetPrinter", // "trpr"
                                                                     0x74737479: "textStyleInfo", // "tsty"
                                                                     0x74687520: "Thursday", // "thu\0x20"
                                                                     0x54494646: "TIFFPicture", // "TIFF"
                                                                     0x74646374: "titleDisplaysCustomTitle", // "tdct"
                                                                     0x7464646e: "titleDisplaysDeviceName", // "tddn"
                                                                     0x7464666e: "titleDisplaysFileName", // "tdfn"
                                                                     0x7464736e: "titleDisplaysSettingsName", // "tdsn"
                                                                     0x74647370: "titleDisplaysShellPath", // "tdsp"
                                                                     0x74647773: "titleDisplaysWindowSize", // "tdws"
                                                                     0x74747479: "tty", // "ttty"
                                                                     0x74756520: "Tuesday", // "tue\0x20"
                                                                     0x74797065: "typeClass", // "type"
                                                                     0x75747874: "UnicodeText", // "utxt"
                                                                     0x75636f6d: "unsignedDoubleInteger", // "ucom"
                                                                     0x6d61676e: "unsignedInteger", // "magn"
                                                                     0x75736872: "unsignedShortInteger", // "ushr"
                                                                     0x75743136: "UTF16Text", // "ut16"
                                                                     0x75746638: "UTF8Text", // "utf8"
                                                                     0x76657273: "version", // "vers"
                                                                     0x70766973: "visible", // "pvis"
                                                                     0x77656420: "Wednesday", // "wed\0x20"
                                                                     0x77686974: "whitespace", // "whit"
                                                                     0x6377696e: "window", // "cwin"
                                                                     0x70736374: "writingCode", // "psct"
                                                                     0x79657320: "yes", // "yes\0x20"
                                                                     0x69737a6d: "zoomable", // "iszm"
                                                                     0x707a756d: "zoomed", // "pzum"
                                                     ],
                                                     propertyNames: [
                                                                     0x7062636c: "backgroundColor", // "pbcl"
                                                                     0x70627463: "boldTextColor", // "pbtc"
                                                                     0x70626e64: "bounds", // "pbnd"
                                                                     0x62757379: "busy", // "busy"
                                                                     0x70636c73: "class_", // "pcls"
                                                                     0x74636c6e: "cleanCommands", // "tcln"
                                                                     0x68636c62: "closeable", // "hclb"
                                                                     0x6c77636c: "collating", // "lwcl"
                                                                     0x70636e74: "contents", // "pcnt"
                                                                     0x6c776370: "copies", // "lwcp"
                                                                     0x74637374: "currentSettings", // "tcst"
                                                                     0x70637563: "cursorColor", // "pcuc"
                                                                     0x7469746c: "customTitle", // "titl"
                                                                     0x74647072: "defaultSettings", // "tdpr"
                                                                     0x6c776c70: "endingPage", // "lwlp"
                                                                     0x6c776568: "errorHandling", // "lweh"
                                                                     0x6661786e: "faxNumber", // "faxn"
                                                                     0x70616e78: "fontAntialiasing", // "panx"
                                                                     0x666f6e74: "fontName", // "font"
                                                                     0x7074737a: "fontSize", // "ptsz"
                                                                     0x70667261: "frame", // "pfra"
                                                                     0x70697366: "frontmost", // "pisf"
                                                                     0x68697374: "history", // "hist"
                                                                     0x49442020: "id", // "ID\0x20\0x20"
                                                                     0x70696478: "index", // "pidx"
                                                                     0x69736d6e: "miniaturizable", // "ismn"
                                                                     0x706d6e64: "miniaturized", // "pmnd"
                                                                     0x706e616d: "name", // "pnam"
                                                                     0x70747863: "normalTextColor", // "ptxc"
                                                                     0x63636f6c: "numberOfColumns", // "ccol"
                                                                     0x63726f77: "numberOfRows", // "crow"
                                                                     0x706f7269: "origin", // "pori"
                                                                     0x6c776c61: "pagesAcross", // "lwla"
                                                                     0x6c776c64: "pagesDown", // "lwld"
                                                                     0x70706f73: "position", // "ppos"
                                                                     0x70726373: "processes", // "prcs"
                                                                     0x70414c4c: "properties", // "pALL"
                                                                     0x7072737a: "resizable", // "prsz"
                                                                     0x7462736c: "selected", // "tbsl"
                                                                     0x7073697a: "size", // "psiz"
                                                                     0x6c776670: "startingPage", // "lwfp"
                                                                     0x74737072: "startupSettings", // "tspr"
                                                                     0x74727072: "targetPrinter", // "trpr"
                                                                     0x74646374: "titleDisplaysCustomTitle", // "tdct"
                                                                     0x7464646e: "titleDisplaysDeviceName", // "tddn"
                                                                     0x7464666e: "titleDisplaysFileName", // "tdfn"
                                                                     0x7464736e: "titleDisplaysSettingsName", // "tdsn"
                                                                     0x74647370: "titleDisplaysShellPath", // "tdsp"
                                                                     0x74647773: "titleDisplaysWindowSize", // "tdws"
                                                                     0x74747479: "tty", // "ttty"
                                                                     0x76657273: "version", // "vers"
                                                                     0x70766973: "visible", // "pvis"
                                                                     0x69737a6d: "zoomable", // "iszm"
                                                                     0x707a756d: "zoomed", // "pzum"
                                                     ],
                                                     elementsNames: [
                                                                     0x63617070: ("application", "applications"), // "capp"
                                                                     0x636f626a: ("item", "items"), // "cobj"
                                                                     0x74707266: ("settings set", "settingsSets"), // "tprf"
                                                                     0x74746162: ("tab", "tabs"), // "ttab"
                                                                     0x6377696e: ("window", "windows"), // "cwin"
                                                     ])

private let _glueClasses = SwiftAutomation.GlueClasses(insertionSpecifierType: TERInsertion.self,
                                       objectSpecifierType: TERItem.self,
                                       multiObjectSpecifierType: TERItems.self,
                                       rootSpecifierType: TERRoot.self,
                                       applicationType: Terminal.self,
                                       symbolType: TERSymbol.self,
                                       formatter: _specifierFormatter)

private let _untargetedAppData = SwiftAutomation.AppData(glueClasses: _glueClasses)


/******************************************************************************/
// Symbol subclass defines static type/enum/property constants based on Terminal.app terminology

public class TERSymbol: SwiftAutomation.Symbol {

    override public var typeAliasName: String {return "TER"}

    public override class func symbol(code: OSType, type: OSType = typeType, descriptor: NSAppleEventDescriptor? = nil) -> TERSymbol {
        switch (code) {
        case 0x616c6973: return self.alias // "alis"
        case 0x2a2a2a2a: return self.anything // "****"
        case 0x63617070: return self.application // "capp"
        case 0x62756e64: return self.applicationBundleID // "bund"
        case 0x7369676e: return self.applicationSignature // "sign"
        case 0x6170726c: return self.applicationURL // "aprl"
        case 0x61707220: return self.April // "apr\0x20"
        case 0x61736b20: return self.ask // "ask\0x20"
        case 0x61756720: return self.August // "aug\0x20"
        case 0x7062636c: return self.backgroundColor // "pbcl"
        case 0x62657374: return self.best // "best"
        case 0x70627463: return self.boldTextColor // "pbtc"
        case 0x626d726b: return self.bookmarkData // "bmrk"
        case 0x626f6f6c: return self.boolean // "bool"
        case 0x71647274: return self.boundingRectangle // "qdrt"
        case 0x70626e64: return self.bounds // "pbnd"
        case 0x62757379: return self.busy // "busy"
        case 0x63617365: return self.case_ // "case"
        case 0x70636c73: return self.class_ // "pcls"
        case 0x74636c6e: return self.cleanCommands // "tcln"
        case 0x68636c62: return self.closeable // "hclb"
        case 0x6c77636c: return self.collating // "lwcl"
        case 0x63524742: return self.color // "cRGB"
        case 0x636c7274: return self.colorTable // "clrt"
        case 0x656e756d: return self.constant // "enum"
        case 0x70636e74: return self.contents // "pcnt"
        case 0x6c776370: return self.copies // "lwcp"
        case 0x74637374: return self.currentSettings // "tcst"
        case 0x70637563: return self.cursorColor // "pcuc"
        case 0x7469746c: return self.customTitle // "titl"
        case 0x74646173: return self.dashStyle // "tdas"
        case 0x74647461: return self.data // "tdta"
        case 0x6c647420: return self.date // "ldt\0x20"
        case 0x64656320: return self.December // "dec\0x20"
        case 0x6465636d: return self.decimalStruct // "decm"
        case 0x74647072: return self.defaultSettings // "tdpr"
        case 0x6c776474: return self.detailed // "lwdt"
        case 0x64696163: return self.diacriticals // "diac"
        case 0x636f6d70: return self.doubleInteger // "comp"
        case 0x656e6373: return self.encodedString // "encs"
        case 0x6c776c70: return self.endingPage // "lwlp"
        case 0x45505320: return self.EPSPicture // "EPS\0x20"
        case 0x6c776568: return self.errorHandling // "lweh"
        case 0x65787061: return self.expansion // "expa"
        case 0x65787465: return self.extendedReal // "exte"
        case 0x6661786e: return self.faxNumber // "faxn"
        case 0x66656220: return self.February // "feb\0x20"
        case 0x66737266: return self.fileRef // "fsrf"
        case 0x66737320: return self.fileSpecification // "fss\0x20"
        case 0x6675726c: return self.fileURL // "furl"
        case 0x66697864: return self.fixed // "fixd"
        case 0x66706e74: return self.fixedPoint // "fpnt"
        case 0x66726374: return self.fixedRectangle // "frct"
        case 0x70616e78: return self.fontAntialiasing // "panx"
        case 0x666f6e74: return self.fontName // "font"
        case 0x7074737a: return self.fontSize // "ptsz"
        case 0x70667261: return self.frame // "pfra"
        case 0x66726920: return self.Friday // "fri\0x20"
        case 0x70697366: return self.frontmost // "pisf"
        case 0x47494666: return self.GIFPicture // "GIFf"
        case 0x63677478: return self.graphicText // "cgtx"
        case 0x68697374: return self.history // "hist"
        case 0x68797068: return self.hyphens // "hyph"
        case 0x49442020: return self.id // "ID\0x20\0x20"
        case 0x70696478: return self.index // "pidx"
        case 0x6c6f6e67: return self.integer // "long"
        case 0x69747874: return self.internationalText // "itxt"
        case 0x696e746c: return self.internationalWritingCode // "intl"
        case 0x636f626a: return self.item // "cobj"
        case 0x6a616e20: return self.January // "jan\0x20"
        case 0x4a504547: return self.JPEGPicture // "JPEG"
        case 0x6a756c20: return self.July // "jul\0x20"
        case 0x6a756e20: return self.June // "jun\0x20"
        case 0x6b706964: return self.kernelProcessID // "kpid"
        case 0x6c64626c: return self.largeReal // "ldbl"
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
        case 0x6d617220: return self.March // "mar\0x20"
        case 0x6d617920: return self.May // "may\0x20"
        case 0x69736d6e: return self.miniaturizable // "ismn"
        case 0x706d6e64: return self.miniaturized // "pmnd"
        case 0x6d6f6e20: return self.Monday // "mon\0x20"
        case 0x706e616d: return self.name // "pnam"
        case 0x6e6f2020: return self.no // "no\0x20\0x20"
        case 0x70747863: return self.normalTextColor // "ptxc"
        case 0x6e6f7620: return self.November // "nov\0x20"
        case 0x6e756c6c: return self.null // "null"
        case 0x63636f6c: return self.numberOfColumns // "ccol"
        case 0x63726f77: return self.numberOfRows // "crow"
        case 0x6e756d65: return self.numericStrings // "nume"
        case 0x6f637420: return self.October // "oct\0x20"
        case 0x706f7269: return self.origin // "pori"
        case 0x6c776c61: return self.pagesAcross // "lwla"
        case 0x6c776c64: return self.pagesDown // "lwld"
        case 0x50494354: return self.PICTPicture // "PICT"
        case 0x74706d6d: return self.pixelMapRecord // "tpmm"
        case 0x51447074: return self.point // "QDpt"
        case 0x70706f73: return self.position // "ppos"
        case 0x70736574: return self.printSettings // "pset"
        case 0x70726373: return self.processes // "prcs"
        case 0x70736e20: return self.processSerialNumber // "psn\0x20"
        case 0x70414c4c: return self.properties // "pALL"
        case 0x70726f70: return self.property_ // "prop"
        case 0x70756e63: return self.punctuation // "punc"
        case 0x646f7562: return self.real // "doub"
        case 0x7265636f: return self.record // "reco"
        case 0x6f626a20: return self.reference // "obj\0x20"
        case 0x7072737a: return self.resizable // "prsz"
        case 0x74723136: return self.RGB16Color // "tr16"
        case 0x74723936: return self.RGB96Color // "tr96"
        case 0x74726f74: return self.rotation // "trot"
        case 0x73617420: return self.Saturday // "sat\0x20"
        case 0x73637074: return self.script // "scpt"
        case 0x7462736c: return self.selected // "tbsl"
        case 0x73657020: return self.September // "sep\0x20"
        case 0x74707266: return self.settingsSet // "tprf"
        case 0x73686f72: return self.shortInteger // "shor"
        case 0x7073697a: return self.size // "psiz"
        case 0x73696e67: return self.smallReal // "sing"
        case 0x6c777374: return self.standard // "lwst"
        case 0x6c776670: return self.startingPage // "lwfp"
        case 0x74737072: return self.startupSettings // "tspr"
        case 0x54455854: return self.string // "TEXT"
        case 0x7374796c: return self.styledClipboardText // "styl"
        case 0x53545854: return self.styledText // "STXT"
        case 0x73756e20: return self.Sunday // "sun\0x20"
        case 0x74746162: return self.tab // "ttab"
        case 0x74727072: return self.targetPrinter // "trpr"
        case 0x74737479: return self.textStyleInfo // "tsty"
        case 0x74687520: return self.Thursday // "thu\0x20"
        case 0x54494646: return self.TIFFPicture // "TIFF"
        case 0x74646374: return self.titleDisplaysCustomTitle // "tdct"
        case 0x7464646e: return self.titleDisplaysDeviceName // "tddn"
        case 0x7464666e: return self.titleDisplaysFileName // "tdfn"
        case 0x7464736e: return self.titleDisplaysSettingsName // "tdsn"
        case 0x74647370: return self.titleDisplaysShellPath // "tdsp"
        case 0x74647773: return self.titleDisplaysWindowSize // "tdws"
        case 0x74747479: return self.tty // "ttty"
        case 0x74756520: return self.Tuesday // "tue\0x20"
        case 0x74797065: return self.typeClass // "type"
        case 0x75747874: return self.UnicodeText // "utxt"
        case 0x75636f6d: return self.unsignedDoubleInteger // "ucom"
        case 0x6d61676e: return self.unsignedInteger // "magn"
        case 0x75736872: return self.unsignedShortInteger // "ushr"
        case 0x75743136: return self.UTF16Text // "ut16"
        case 0x75746638: return self.UTF8Text // "utf8"
        case 0x76657273: return self.version // "vers"
        case 0x70766973: return self.visible // "pvis"
        case 0x77656420: return self.Wednesday // "wed\0x20"
        case 0x77686974: return self.whitespace // "whit"
        case 0x6377696e: return self.window // "cwin"
        case 0x70736374: return self.writingCode // "psct"
        case 0x79657320: return self.yes // "yes\0x20"
        case 0x69737a6d: return self.zoomable // "iszm"
        case 0x707a756d: return self.zoomed // "pzum"
        default: return super.symbol(code: code, type: type, descriptor: descriptor) as! TERSymbol
        }
    }

    // Types/properties
    public static let alias = TERSymbol(name: "alias", code: 0x616c6973, type: typeType) // "alis"
    public static let anything = TERSymbol(name: "anything", code: 0x2a2a2a2a, type: typeType) // "****"
    public static let application = TERSymbol(name: "application", code: 0x63617070, type: typeType) // "capp"
    public static let applicationBundleID = TERSymbol(name: "applicationBundleID", code: 0x62756e64, type: typeType) // "bund"
    public static let applicationSignature = TERSymbol(name: "applicationSignature", code: 0x7369676e, type: typeType) // "sign"
    public static let applicationURL = TERSymbol(name: "applicationURL", code: 0x6170726c, type: typeType) // "aprl"
    public static let April = TERSymbol(name: "April", code: 0x61707220, type: typeType) // "apr\0x20"
    public static let August = TERSymbol(name: "August", code: 0x61756720, type: typeType) // "aug\0x20"
    public static let backgroundColor = TERSymbol(name: "backgroundColor", code: 0x7062636c, type: typeType) // "pbcl"
    public static let best = TERSymbol(name: "best", code: 0x62657374, type: typeType) // "best"
    public static let boldTextColor = TERSymbol(name: "boldTextColor", code: 0x70627463, type: typeType) // "pbtc"
    public static let bookmarkData = TERSymbol(name: "bookmarkData", code: 0x626d726b, type: typeType) // "bmrk"
    public static let boolean = TERSymbol(name: "boolean", code: 0x626f6f6c, type: typeType) // "bool"
    public static let boundingRectangle = TERSymbol(name: "boundingRectangle", code: 0x71647274, type: typeType) // "qdrt"
    public static let bounds = TERSymbol(name: "bounds", code: 0x70626e64, type: typeType) // "pbnd"
    public static let busy = TERSymbol(name: "busy", code: 0x62757379, type: typeType) // "busy"
    public static let class_ = TERSymbol(name: "class_", code: 0x70636c73, type: typeType) // "pcls"
    public static let cleanCommands = TERSymbol(name: "cleanCommands", code: 0x74636c6e, type: typeType) // "tcln"
    public static let closeable = TERSymbol(name: "closeable", code: 0x68636c62, type: typeType) // "hclb"
    public static let collating = TERSymbol(name: "collating", code: 0x6c77636c, type: typeType) // "lwcl"
    public static let color = TERSymbol(name: "color", code: 0x63524742, type: typeType) // "cRGB"
    public static let colorTable = TERSymbol(name: "colorTable", code: 0x636c7274, type: typeType) // "clrt"
    public static let constant = TERSymbol(name: "constant", code: 0x656e756d, type: typeType) // "enum"
    public static let contents = TERSymbol(name: "contents", code: 0x70636e74, type: typeType) // "pcnt"
    public static let copies = TERSymbol(name: "copies", code: 0x6c776370, type: typeType) // "lwcp"
    public static let currentSettings = TERSymbol(name: "currentSettings", code: 0x74637374, type: typeType) // "tcst"
    public static let cursorColor = TERSymbol(name: "cursorColor", code: 0x70637563, type: typeType) // "pcuc"
    public static let customTitle = TERSymbol(name: "customTitle", code: 0x7469746c, type: typeType) // "titl"
    public static let dashStyle = TERSymbol(name: "dashStyle", code: 0x74646173, type: typeType) // "tdas"
    public static let data = TERSymbol(name: "data", code: 0x74647461, type: typeType) // "tdta"
    public static let date = TERSymbol(name: "date", code: 0x6c647420, type: typeType) // "ldt\0x20"
    public static let December = TERSymbol(name: "December", code: 0x64656320, type: typeType) // "dec\0x20"
    public static let decimalStruct = TERSymbol(name: "decimalStruct", code: 0x6465636d, type: typeType) // "decm"
    public static let defaultSettings = TERSymbol(name: "defaultSettings", code: 0x74647072, type: typeType) // "tdpr"
    public static let doubleInteger = TERSymbol(name: "doubleInteger", code: 0x636f6d70, type: typeType) // "comp"
    public static let encodedString = TERSymbol(name: "encodedString", code: 0x656e6373, type: typeType) // "encs"
    public static let endingPage = TERSymbol(name: "endingPage", code: 0x6c776c70, type: typeType) // "lwlp"
    public static let EPSPicture = TERSymbol(name: "EPSPicture", code: 0x45505320, type: typeType) // "EPS\0x20"
    public static let errorHandling = TERSymbol(name: "errorHandling", code: 0x6c776568, type: typeType) // "lweh"
    public static let extendedReal = TERSymbol(name: "extendedReal", code: 0x65787465, type: typeType) // "exte"
    public static let faxNumber = TERSymbol(name: "faxNumber", code: 0x6661786e, type: typeType) // "faxn"
    public static let February = TERSymbol(name: "February", code: 0x66656220, type: typeType) // "feb\0x20"
    public static let fileRef = TERSymbol(name: "fileRef", code: 0x66737266, type: typeType) // "fsrf"
    public static let fileSpecification = TERSymbol(name: "fileSpecification", code: 0x66737320, type: typeType) // "fss\0x20"
    public static let fileURL = TERSymbol(name: "fileURL", code: 0x6675726c, type: typeType) // "furl"
    public static let fixed = TERSymbol(name: "fixed", code: 0x66697864, type: typeType) // "fixd"
    public static let fixedPoint = TERSymbol(name: "fixedPoint", code: 0x66706e74, type: typeType) // "fpnt"
    public static let fixedRectangle = TERSymbol(name: "fixedRectangle", code: 0x66726374, type: typeType) // "frct"
    public static let fontAntialiasing = TERSymbol(name: "fontAntialiasing", code: 0x70616e78, type: typeType) // "panx"
    public static let fontName = TERSymbol(name: "fontName", code: 0x666f6e74, type: typeType) // "font"
    public static let fontSize = TERSymbol(name: "fontSize", code: 0x7074737a, type: typeType) // "ptsz"
    public static let frame = TERSymbol(name: "frame", code: 0x70667261, type: typeType) // "pfra"
    public static let Friday = TERSymbol(name: "Friday", code: 0x66726920, type: typeType) // "fri\0x20"
    public static let frontmost = TERSymbol(name: "frontmost", code: 0x70697366, type: typeType) // "pisf"
    public static let GIFPicture = TERSymbol(name: "GIFPicture", code: 0x47494666, type: typeType) // "GIFf"
    public static let graphicText = TERSymbol(name: "graphicText", code: 0x63677478, type: typeType) // "cgtx"
    public static let history = TERSymbol(name: "history", code: 0x68697374, type: typeType) // "hist"
    public static let id = TERSymbol(name: "id", code: 0x49442020, type: typeType) // "ID\0x20\0x20"
    public static let index = TERSymbol(name: "index", code: 0x70696478, type: typeType) // "pidx"
    public static let integer = TERSymbol(name: "integer", code: 0x6c6f6e67, type: typeType) // "long"
    public static let internationalText = TERSymbol(name: "internationalText", code: 0x69747874, type: typeType) // "itxt"
    public static let internationalWritingCode = TERSymbol(name: "internationalWritingCode", code: 0x696e746c, type: typeType) // "intl"
    public static let item = TERSymbol(name: "item", code: 0x636f626a, type: typeType) // "cobj"
    public static let January = TERSymbol(name: "January", code: 0x6a616e20, type: typeType) // "jan\0x20"
    public static let JPEGPicture = TERSymbol(name: "JPEGPicture", code: 0x4a504547, type: typeType) // "JPEG"
    public static let July = TERSymbol(name: "July", code: 0x6a756c20, type: typeType) // "jul\0x20"
    public static let June = TERSymbol(name: "June", code: 0x6a756e20, type: typeType) // "jun\0x20"
    public static let kernelProcessID = TERSymbol(name: "kernelProcessID", code: 0x6b706964, type: typeType) // "kpid"
    public static let largeReal = TERSymbol(name: "largeReal", code: 0x6c64626c, type: typeType) // "ldbl"
    public static let list = TERSymbol(name: "list", code: 0x6c697374, type: typeType) // "list"
    public static let locationReference = TERSymbol(name: "locationReference", code: 0x696e736c, type: typeType) // "insl"
    public static let longFixed = TERSymbol(name: "longFixed", code: 0x6c667864, type: typeType) // "lfxd"
    public static let longFixedPoint = TERSymbol(name: "longFixedPoint", code: 0x6c667074, type: typeType) // "lfpt"
    public static let longFixedRectangle = TERSymbol(name: "longFixedRectangle", code: 0x6c667263, type: typeType) // "lfrc"
    public static let longPoint = TERSymbol(name: "longPoint", code: 0x6c706e74, type: typeType) // "lpnt"
    public static let longRectangle = TERSymbol(name: "longRectangle", code: 0x6c726374, type: typeType) // "lrct"
    public static let machine = TERSymbol(name: "machine", code: 0x6d616368, type: typeType) // "mach"
    public static let machineLocation = TERSymbol(name: "machineLocation", code: 0x6d4c6f63, type: typeType) // "mLoc"
    public static let machPort = TERSymbol(name: "machPort", code: 0x706f7274, type: typeType) // "port"
    public static let March = TERSymbol(name: "March", code: 0x6d617220, type: typeType) // "mar\0x20"
    public static let May = TERSymbol(name: "May", code: 0x6d617920, type: typeType) // "may\0x20"
    public static let miniaturizable = TERSymbol(name: "miniaturizable", code: 0x69736d6e, type: typeType) // "ismn"
    public static let miniaturized = TERSymbol(name: "miniaturized", code: 0x706d6e64, type: typeType) // "pmnd"
    public static let Monday = TERSymbol(name: "Monday", code: 0x6d6f6e20, type: typeType) // "mon\0x20"
    public static let name = TERSymbol(name: "name", code: 0x706e616d, type: typeType) // "pnam"
    public static let normalTextColor = TERSymbol(name: "normalTextColor", code: 0x70747863, type: typeType) // "ptxc"
    public static let November = TERSymbol(name: "November", code: 0x6e6f7620, type: typeType) // "nov\0x20"
    public static let null = TERSymbol(name: "null", code: 0x6e756c6c, type: typeType) // "null"
    public static let numberOfColumns = TERSymbol(name: "numberOfColumns", code: 0x63636f6c, type: typeType) // "ccol"
    public static let numberOfRows = TERSymbol(name: "numberOfRows", code: 0x63726f77, type: typeType) // "crow"
    public static let October = TERSymbol(name: "October", code: 0x6f637420, type: typeType) // "oct\0x20"
    public static let origin = TERSymbol(name: "origin", code: 0x706f7269, type: typeType) // "pori"
    public static let pagesAcross = TERSymbol(name: "pagesAcross", code: 0x6c776c61, type: typeType) // "lwla"
    public static let pagesDown = TERSymbol(name: "pagesDown", code: 0x6c776c64, type: typeType) // "lwld"
    public static let PICTPicture = TERSymbol(name: "PICTPicture", code: 0x50494354, type: typeType) // "PICT"
    public static let pixelMapRecord = TERSymbol(name: "pixelMapRecord", code: 0x74706d6d, type: typeType) // "tpmm"
    public static let point = TERSymbol(name: "point", code: 0x51447074, type: typeType) // "QDpt"
    public static let position = TERSymbol(name: "position", code: 0x70706f73, type: typeType) // "ppos"
    public static let printSettings = TERSymbol(name: "printSettings", code: 0x70736574, type: typeType) // "pset"
    public static let processes = TERSymbol(name: "processes", code: 0x70726373, type: typeType) // "prcs"
    public static let processSerialNumber = TERSymbol(name: "processSerialNumber", code: 0x70736e20, type: typeType) // "psn\0x20"
    public static let properties = TERSymbol(name: "properties", code: 0x70414c4c, type: typeType) // "pALL"
    public static let property_ = TERSymbol(name: "property_", code: 0x70726f70, type: typeType) // "prop"
    public static let real = TERSymbol(name: "real", code: 0x646f7562, type: typeType) // "doub"
    public static let record = TERSymbol(name: "record", code: 0x7265636f, type: typeType) // "reco"
    public static let reference = TERSymbol(name: "reference", code: 0x6f626a20, type: typeType) // "obj\0x20"
    public static let resizable = TERSymbol(name: "resizable", code: 0x7072737a, type: typeType) // "prsz"
    public static let RGB16Color = TERSymbol(name: "RGB16Color", code: 0x74723136, type: typeType) // "tr16"
    public static let RGB96Color = TERSymbol(name: "RGB96Color", code: 0x74723936, type: typeType) // "tr96"
    public static let RGBColor = TERSymbol(name: "RGBColor", code: 0x63524742, type: typeType) // "cRGB"
    public static let rotation = TERSymbol(name: "rotation", code: 0x74726f74, type: typeType) // "trot"
    public static let Saturday = TERSymbol(name: "Saturday", code: 0x73617420, type: typeType) // "sat\0x20"
    public static let script = TERSymbol(name: "script", code: 0x73637074, type: typeType) // "scpt"
    public static let selected = TERSymbol(name: "selected", code: 0x7462736c, type: typeType) // "tbsl"
    public static let September = TERSymbol(name: "September", code: 0x73657020, type: typeType) // "sep\0x20"
    public static let settingsSet = TERSymbol(name: "settingsSet", code: 0x74707266, type: typeType) // "tprf"
    public static let shortInteger = TERSymbol(name: "shortInteger", code: 0x73686f72, type: typeType) // "shor"
    public static let size = TERSymbol(name: "size", code: 0x7073697a, type: typeType) // "psiz"
    public static let smallReal = TERSymbol(name: "smallReal", code: 0x73696e67, type: typeType) // "sing"
    public static let startingPage = TERSymbol(name: "startingPage", code: 0x6c776670, type: typeType) // "lwfp"
    public static let startupSettings = TERSymbol(name: "startupSettings", code: 0x74737072, type: typeType) // "tspr"
    public static let string = TERSymbol(name: "string", code: 0x54455854, type: typeType) // "TEXT"
    public static let styledClipboardText = TERSymbol(name: "styledClipboardText", code: 0x7374796c, type: typeType) // "styl"
    public static let styledText = TERSymbol(name: "styledText", code: 0x53545854, type: typeType) // "STXT"
    public static let Sunday = TERSymbol(name: "Sunday", code: 0x73756e20, type: typeType) // "sun\0x20"
    public static let tab = TERSymbol(name: "tab", code: 0x74746162, type: typeType) // "ttab"
    public static let targetPrinter = TERSymbol(name: "targetPrinter", code: 0x74727072, type: typeType) // "trpr"
    public static let textStyleInfo = TERSymbol(name: "textStyleInfo", code: 0x74737479, type: typeType) // "tsty"
    public static let Thursday = TERSymbol(name: "Thursday", code: 0x74687520, type: typeType) // "thu\0x20"
    public static let TIFFPicture = TERSymbol(name: "TIFFPicture", code: 0x54494646, type: typeType) // "TIFF"
    public static let titleDisplaysCustomTitle = TERSymbol(name: "titleDisplaysCustomTitle", code: 0x74646374, type: typeType) // "tdct"
    public static let titleDisplaysDeviceName = TERSymbol(name: "titleDisplaysDeviceName", code: 0x7464646e, type: typeType) // "tddn"
    public static let titleDisplaysFileName = TERSymbol(name: "titleDisplaysFileName", code: 0x7464666e, type: typeType) // "tdfn"
    public static let titleDisplaysSettingsName = TERSymbol(name: "titleDisplaysSettingsName", code: 0x7464736e, type: typeType) // "tdsn"
    public static let titleDisplaysShellPath = TERSymbol(name: "titleDisplaysShellPath", code: 0x74647370, type: typeType) // "tdsp"
    public static let titleDisplaysWindowSize = TERSymbol(name: "titleDisplaysWindowSize", code: 0x74647773, type: typeType) // "tdws"
    public static let tty = TERSymbol(name: "tty", code: 0x74747479, type: typeType) // "ttty"
    public static let Tuesday = TERSymbol(name: "Tuesday", code: 0x74756520, type: typeType) // "tue\0x20"
    public static let typeClass = TERSymbol(name: "typeClass", code: 0x74797065, type: typeType) // "type"
    public static let UnicodeText = TERSymbol(name: "UnicodeText", code: 0x75747874, type: typeType) // "utxt"
    public static let unsignedDoubleInteger = TERSymbol(name: "unsignedDoubleInteger", code: 0x75636f6d, type: typeType) // "ucom"
    public static let unsignedInteger = TERSymbol(name: "unsignedInteger", code: 0x6d61676e, type: typeType) // "magn"
    public static let unsignedShortInteger = TERSymbol(name: "unsignedShortInteger", code: 0x75736872, type: typeType) // "ushr"
    public static let UTF16Text = TERSymbol(name: "UTF16Text", code: 0x75743136, type: typeType) // "ut16"
    public static let UTF8Text = TERSymbol(name: "UTF8Text", code: 0x75746638, type: typeType) // "utf8"
    public static let version = TERSymbol(name: "version", code: 0x76657273, type: typeType) // "vers"
    public static let visible = TERSymbol(name: "visible", code: 0x70766973, type: typeType) // "pvis"
    public static let Wednesday = TERSymbol(name: "Wednesday", code: 0x77656420, type: typeType) // "wed\0x20"
    public static let window = TERSymbol(name: "window", code: 0x6377696e, type: typeType) // "cwin"
    public static let writingCode = TERSymbol(name: "writingCode", code: 0x70736374, type: typeType) // "psct"
    public static let zoomable = TERSymbol(name: "zoomable", code: 0x69737a6d, type: typeType) // "iszm"
    public static let zoomed = TERSymbol(name: "zoomed", code: 0x707a756d, type: typeType) // "pzum"

    // Enumerators
    public static let ask = TERSymbol(name: "ask", code: 0x61736b20, type: typeEnumerated) // "ask\0x20"
    public static let case_ = TERSymbol(name: "case_", code: 0x63617365, type: typeEnumerated) // "case"
    public static let detailed = TERSymbol(name: "detailed", code: 0x6c776474, type: typeEnumerated) // "lwdt"
    public static let diacriticals = TERSymbol(name: "diacriticals", code: 0x64696163, type: typeEnumerated) // "diac"
    public static let expansion = TERSymbol(name: "expansion", code: 0x65787061, type: typeEnumerated) // "expa"
    public static let hyphens = TERSymbol(name: "hyphens", code: 0x68797068, type: typeEnumerated) // "hyph"
    public static let no = TERSymbol(name: "no", code: 0x6e6f2020, type: typeEnumerated) // "no\0x20\0x20"
    public static let numericStrings = TERSymbol(name: "numericStrings", code: 0x6e756d65, type: typeEnumerated) // "nume"
    public static let punctuation = TERSymbol(name: "punctuation", code: 0x70756e63, type: typeEnumerated) // "punc"
    public static let standard = TERSymbol(name: "standard", code: 0x6c777374, type: typeEnumerated) // "lwst"
    public static let whitespace = TERSymbol(name: "whitespace", code: 0x77686974, type: typeEnumerated) // "whit"
    public static let yes = TERSymbol(name: "yes", code: 0x79657320, type: typeEnumerated) // "yes\0x20"
}

public typealias TER = TERSymbol // allows symbols to be written as (e.g.) TER.name instead of TERSymbol.name


/******************************************************************************/
// Specifier extensions; these add command methods and property/elements getters based on Terminal.app terminology

public protocol TERCommand: SwiftAutomation.SpecifierProtocol {} // provides AE dispatch methods

// Command->Any will be bound when return type can't be inferred, else Command->T

extension TERCommand {
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
    @discardableResult public func close(_ directParameter: Any = SwiftAutomation.NoParameter,
            saving: Any = SwiftAutomation.NoParameter,
            savingIn: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "close", eventClass: 0x636f7265, eventID: 0x636c6f73, // "core"/"clos"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("saving", 0x7361766f, saving), // "savo"
                    ("savingIn", 0x6b66696c, savingIn), // "kfil"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func close<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            saving: Any = SwiftAutomation.NoParameter,
            savingIn: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "close", eventClass: 0x636f7265, eventID: 0x636c6f73, // "core"/"clos"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("saving", 0x7361766f, saving), // "savo"
                    ("savingIn", 0x6b66696c, savingIn), // "kfil"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func count(_ directParameter: Any = SwiftAutomation.NoParameter,
            each: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "count", eventClass: 0x636f7265, eventID: 0x636e7465, // "core"/"cnte"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("each", 0x6b6f636c, each), // "kocl"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func count<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            each: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "count", eventClass: 0x636f7265, eventID: 0x636e7465, // "core"/"cnte"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("each", 0x6b6f636c, each), // "kocl"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func delete(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "delete", eventClass: 0x636f7265, eventID: 0x64656c6f, // "core"/"delo"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func delete<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "delete", eventClass: 0x636f7265, eventID: 0x64656c6f, // "core"/"delo"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func doScript(_ directParameter: Any = SwiftAutomation.NoParameter,
            withCommand: Any = SwiftAutomation.NoParameter,
            in_: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "doScript", eventClass: 0x636f7265, eventID: 0x646f7363, // "core"/"dosc"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("withCommand", 0x636d6e64, withCommand), // "cmnd"
                    ("in_", 0x6b66696c, in_), // "kfil"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func doScript<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            withCommand: Any = SwiftAutomation.NoParameter,
            in_: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "doScript", eventClass: 0x636f7265, eventID: 0x646f7363, // "core"/"dosc"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("withCommand", 0x636d6e64, withCommand), // "cmnd"
                    ("in_", 0x6b66696c, in_), // "kfil"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func duplicate(_ directParameter: Any = SwiftAutomation.NoParameter,
            to: Any = SwiftAutomation.NoParameter,
            withProperties: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "duplicate", eventClass: 0x636f7265, eventID: 0x636c6f6e, // "core"/"clon"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x696e7368, to), // "insh"
                    ("withProperties", 0x70726474, withProperties), // "prdt"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func duplicate<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            to: Any = SwiftAutomation.NoParameter,
            withProperties: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "duplicate", eventClass: 0x636f7265, eventID: 0x636c6f6e, // "core"/"clon"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x696e7368, to), // "insh"
                    ("withProperties", 0x70726474, withProperties), // "prdt"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func exists(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "exists", eventClass: 0x636f7265, eventID: 0x646f6578, // "core"/"doex"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func exists<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "exists", eventClass: 0x636f7265, eventID: 0x646f6578, // "core"/"doex"
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
    @discardableResult public func getURL(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "getURL", eventClass: 0x4755524c, eventID: 0x4755524c, // "GURL"/"GURL"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func getURL<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "getURL", eventClass: 0x4755524c, eventID: 0x4755524c, // "GURL"/"GURL"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func make(_ directParameter: Any = SwiftAutomation.NoParameter,
            new: Any = SwiftAutomation.NoParameter,
            at: Any = SwiftAutomation.NoParameter,
            withData: Any = SwiftAutomation.NoParameter,
            withProperties: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "make", eventClass: 0x636f7265, eventID: 0x6372656c, // "core"/"crel"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("new", 0x6b6f636c, new), // "kocl"
                    ("at", 0x696e7368, at), // "insh"
                    ("withData", 0x64617461, withData), // "data"
                    ("withProperties", 0x70726474, withProperties), // "prdt"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func make<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            new: Any = SwiftAutomation.NoParameter,
            at: Any = SwiftAutomation.NoParameter,
            withData: Any = SwiftAutomation.NoParameter,
            withProperties: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "make", eventClass: 0x636f7265, eventID: 0x6372656c, // "core"/"crel"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("new", 0x6b6f636c, new), // "kocl"
                    ("at", 0x696e7368, at), // "insh"
                    ("withData", 0x64617461, withData), // "data"
                    ("withProperties", 0x70726474, withProperties), // "prdt"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func move(_ directParameter: Any = SwiftAutomation.NoParameter,
            to: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "move", eventClass: 0x636f7265, eventID: 0x6d6f7665, // "core"/"move"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x696e7368, to), // "insh"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func move<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            to: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "move", eventClass: 0x636f7265, eventID: 0x6d6f7665, // "core"/"move"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x696e7368, to), // "insh"
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
    @discardableResult public func print(_ directParameter: Any = SwiftAutomation.NoParameter,
            withProperties: Any = SwiftAutomation.NoParameter,
            printDialog: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "print", eventClass: 0x61657674, eventID: 0x70646f63, // "aevt"/"pdoc"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("withProperties", 0x70726474, withProperties), // "prdt"
                    ("printDialog", 0x70646c67, printDialog), // "pdlg"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func print<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            withProperties: Any = SwiftAutomation.NoParameter,
            printDialog: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "print", eventClass: 0x61657674, eventID: 0x70646f63, // "aevt"/"pdoc"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("withProperties", 0x70726474, withProperties), // "prdt"
                    ("printDialog", 0x70646c67, printDialog), // "pdlg"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func quit(_ directParameter: Any = SwiftAutomation.NoParameter,
            saving: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "quit", eventClass: 0x61657674, eventID: 0x71756974, // "aevt"/"quit"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("saving", 0x7361766f, saving), // "savo"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func quit<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            saving: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "quit", eventClass: 0x61657674, eventID: 0x71756974, // "aevt"/"quit"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("saving", 0x7361766f, saving), // "savo"
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
            in_: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "save", eventClass: 0x636f7265, eventID: 0x73617665, // "core"/"save"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("in_", 0x6b66696c, in_), // "kfil"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func save<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            in_: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "save", eventClass: 0x636f7265, eventID: 0x73617665, // "core"/"save"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("in_", 0x6b66696c, in_), // "kfil"
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


public protocol TERObject: SwiftAutomation.ObjectSpecifierExtension, TERCommand {} // provides vars and methods for constructing specifiers

extension TERObject {
    
    // Properties
    public var backgroundColor: TERItem {return self.property(0x7062636c) as! TERItem} // "pbcl"
    public var boldTextColor: TERItem {return self.property(0x70627463) as! TERItem} // "pbtc"
    public var bounds: TERItem {return self.property(0x70626e64) as! TERItem} // "pbnd"
    public var busy: TERItem {return self.property(0x62757379) as! TERItem} // "busy"
    public var class_: TERItem {return self.property(0x70636c73) as! TERItem} // "pcls"
    public var cleanCommands: TERItem {return self.property(0x74636c6e) as! TERItem} // "tcln"
    public var closeable: TERItem {return self.property(0x68636c62) as! TERItem} // "hclb"
    public var collating: TERItem {return self.property(0x6c77636c) as! TERItem} // "lwcl"
    public var contents: TERItem {return self.property(0x70636e74) as! TERItem} // "pcnt"
    public var copies: TERItem {return self.property(0x6c776370) as! TERItem} // "lwcp"
    public var currentSettings: TERItem {return self.property(0x74637374) as! TERItem} // "tcst"
    public var cursorColor: TERItem {return self.property(0x70637563) as! TERItem} // "pcuc"
    public var customTitle: TERItem {return self.property(0x7469746c) as! TERItem} // "titl"
    public var defaultSettings: TERItem {return self.property(0x74647072) as! TERItem} // "tdpr"
    public var endingPage: TERItem {return self.property(0x6c776c70) as! TERItem} // "lwlp"
    public var errorHandling: TERItem {return self.property(0x6c776568) as! TERItem} // "lweh"
    public var faxNumber: TERItem {return self.property(0x6661786e) as! TERItem} // "faxn"
    public var fontAntialiasing: TERItem {return self.property(0x70616e78) as! TERItem} // "panx"
    public var fontName: TERItem {return self.property(0x666f6e74) as! TERItem} // "font"
    public var fontSize: TERItem {return self.property(0x7074737a) as! TERItem} // "ptsz"
    public var frame: TERItem {return self.property(0x70667261) as! TERItem} // "pfra"
    public var frontmost: TERItem {return self.property(0x70697366) as! TERItem} // "pisf"
    public var history: TERItem {return self.property(0x68697374) as! TERItem} // "hist"
    public var id: TERItem {return self.property(0x49442020) as! TERItem} // "ID\0x20\0x20"
    public var index: TERItem {return self.property(0x70696478) as! TERItem} // "pidx"
    public var miniaturizable: TERItem {return self.property(0x69736d6e) as! TERItem} // "ismn"
    public var miniaturized: TERItem {return self.property(0x706d6e64) as! TERItem} // "pmnd"
    public var name: TERItem {return self.property(0x706e616d) as! TERItem} // "pnam"
    public var normalTextColor: TERItem {return self.property(0x70747863) as! TERItem} // "ptxc"
    public var numberOfColumns: TERItem {return self.property(0x63636f6c) as! TERItem} // "ccol"
    public var numberOfRows: TERItem {return self.property(0x63726f77) as! TERItem} // "crow"
    public var origin: TERItem {return self.property(0x706f7269) as! TERItem} // "pori"
    public var pagesAcross: TERItem {return self.property(0x6c776c61) as! TERItem} // "lwla"
    public var pagesDown: TERItem {return self.property(0x6c776c64) as! TERItem} // "lwld"
    public var position: TERItem {return self.property(0x70706f73) as! TERItem} // "ppos"
    public var processes: TERItem {return self.property(0x70726373) as! TERItem} // "prcs"
    public var properties: TERItem {return self.property(0x70414c4c) as! TERItem} // "pALL"
    public var resizable: TERItem {return self.property(0x7072737a) as! TERItem} // "prsz"
    public var selected: TERItem {return self.property(0x7462736c) as! TERItem} // "tbsl"
    public var size: TERItem {return self.property(0x7073697a) as! TERItem} // "psiz"
    public var startingPage: TERItem {return self.property(0x6c776670) as! TERItem} // "lwfp"
    public var startupSettings: TERItem {return self.property(0x74737072) as! TERItem} // "tspr"
    public var targetPrinter: TERItem {return self.property(0x74727072) as! TERItem} // "trpr"
    public var titleDisplaysCustomTitle: TERItem {return self.property(0x74646374) as! TERItem} // "tdct"
    public var titleDisplaysDeviceName: TERItem {return self.property(0x7464646e) as! TERItem} // "tddn"
    public var titleDisplaysFileName: TERItem {return self.property(0x7464666e) as! TERItem} // "tdfn"
    public var titleDisplaysSettingsName: TERItem {return self.property(0x7464736e) as! TERItem} // "tdsn"
    public var titleDisplaysShellPath: TERItem {return self.property(0x74647370) as! TERItem} // "tdsp"
    public var titleDisplaysWindowSize: TERItem {return self.property(0x74647773) as! TERItem} // "tdws"
    public var tty: TERItem {return self.property(0x74747479) as! TERItem} // "ttty"
    public var version: TERItem {return self.property(0x76657273) as! TERItem} // "vers"
    public var visible: TERItem {return self.property(0x70766973) as! TERItem} // "pvis"
    public var zoomable: TERItem {return self.property(0x69737a6d) as! TERItem} // "iszm"
    public var zoomed: TERItem {return self.property(0x707a756d) as! TERItem} // "pzum"

    // Elements
    public var applications: TERItems {return self.elements(0x63617070) as! TERItems} // "capp"
    public var items: TERItems {return self.elements(0x636f626a) as! TERItems} // "cobj"
    public var settingsSets: TERItems {return self.elements(0x74707266) as! TERItems} // "tprf"
    public var tabs: TERItems {return self.elements(0x74746162) as! TERItems} // "ttab"
    public var windows: TERItems {return self.elements(0x6377696e) as! TERItems} // "cwin"
}


/******************************************************************************/
// Specifier subclasses add app-specific extensions

// beginning/end/before/after
public class TERInsertion: SwiftAutomation.InsertionSpecifier, TERCommand {}


// property/by-index/by-name/by-id/previous/next/first/middle/last/any
public class TERItem: SwiftAutomation.ObjectSpecifier, TERObject {
    public typealias InsertionSpecifierType = TERInsertion
    public typealias ObjectSpecifierType = TERItem
    public typealias MultipleObjectSpecifierType = TERItems
}

// by-range/by-test/all
public class TERItems: TERItem, SwiftAutomation.MultipleObjectSpecifierExtension {}

// App/Con/Its
public class TERRoot: SwiftAutomation.RootSpecifier, TERObject, SwiftAutomation.RootSpecifierExtension {
    public typealias InsertionSpecifierType = TERInsertion
    public typealias ObjectSpecifierType = TERItem
    public typealias MultipleObjectSpecifierType = TERItems
    public override class var untargetedAppData: SwiftAutomation.AppData { return _untargetedAppData }
}

// Application
public class Terminal: TERRoot, SwiftAutomation.Application {
    public convenience init(launchOptions: SwiftAutomation.LaunchOptions = SwiftAutomation.DefaultLaunchOptions, relaunchMode: SwiftAutomation.RelaunchMode = SwiftAutomation.DefaultRelaunchMode) {
        self.init(rootObject: SwiftAutomation.AppRootDesc, appData: Swift.type(of:self).untargetedAppData.targetedCopy(
                  .bundleIdentifier("com.apple.Terminal", true), launchOptions: launchOptions, relaunchMode: relaunchMode))
    }
}

// App/Con/Its root objects used to construct untargeted specifiers; these can be used to construct specifiers for use in commands, though cannot send commands themselves

public let TERApp = _untargetedAppData.app as! TERRoot
public let TERCon = _untargetedAppData.con as! TERRoot
public let TERIts = _untargetedAppData.its as! TERRoot


/******************************************************************************/
// Static types

public typealias TERRecord = [TERSymbol:Any] // default Swift type for AERecordDescs







