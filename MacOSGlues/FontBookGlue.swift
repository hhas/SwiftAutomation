//
//  FontBookGlue.swift
//  Font Book.app 9.0
//  SwiftAutomation.framework 0.1.0
//  `aeglue -S 'Font Book.app'`
//


import Foundation
import SwiftAutomation


/******************************************************************************/
// Create an untargeted AppData instance for use in App, Con, Its roots,
// and in Application initializers to create targeted AppData instances.

private let _specifierFormatter = SwiftAutomation.SpecifierFormatter(applicationClassName: "FontBook",
                                                     classNamePrefix: "FBO",
                                                     typeNames: [
                                                                     0x616c6973: "alias", // "alis"
                                                                     0x66626166: "AllFontsLibraryObject", // "fbaf"
                                                                     0x2a2a2a2a: "anything", // "****"
                                                                     0x63617070: "application", // "capp"
                                                                     0x62756e64: "applicationBundleID", // "bund"
                                                                     0x7369676e: "applicationSignature", // "sign"
                                                                     0x6170726c: "applicationURL", // "aprl"
                                                                     0x61707220: "April", // "apr\0x20"
                                                                     0x61736b20: "ask", // "ask\0x20"
                                                                     0x61756720: "August", // "aug\0x20"
                                                                     0x62657374: "best", // "best"
                                                                     0x626d726b: "bookmarkData", // "bmrk"
                                                                     0x626f6f6c: "boolean", // "bool"
                                                                     0x71647274: "boundingRectangle", // "qdrt"
                                                                     0x70626e64: "bounds", // "pbnd"
                                                                     0x63617365: "case_", // "case"
                                                                     0x70636c73: "class_", // "pcls"
                                                                     0x68636c62: "closeable", // "hclb"
                                                                     0x636f6c72: "color", // "colr"
                                                                     0x636c7274: "colorTable", // "clrt"
                                                                     0x656e756d: "constant", // "enum"
                                                                     0x66626372: "copyright", // "fbcr"
                                                                     0x74646173: "dashStyle", // "tdas"
                                                                     0x74647461: "data", // "tdta"
                                                                     0x6c647420: "date", // "ldt\0x20"
                                                                     0x64656320: "December", // "dec\0x20"
                                                                     0x6465636d: "decimalStruct", // "decm"
                                                                     0x64696163: "diacriticals", // "diac"
                                                                     0x646e616d: "displayedName", // "dnam"
                                                                     0x646f6375: "document", // "docu"
                                                                     0x636f6d70: "doubleInteger", // "comp"
                                                                     0x66626964: "duplicated", // "fbid"
                                                                     0x6662656e: "enabled", // "fben"
                                                                     0x656e6373: "encodedString", // "encs"
                                                                     0x45505320: "EPSPicture", // "EPS\0x20"
                                                                     0x65787061: "expansion", // "expa"
                                                                     0x65787465: "extendedReal", // "exte"
                                                                     0x6662666e: "familyName", // "fbfn"
                                                                     0x66656220: "February", // "feb\0x20"
                                                                     0x66737266: "fileRef", // "fsrf"
                                                                     0x66626673: "files", // "fbfs"
                                                                     0x66737320: "fileSpecification", // "fss\0x20"
                                                                     0x6675726c: "fileURL", // "furl"
                                                                     0x66697864: "fixed", // "fixd"
                                                                     0x66706e74: "fixedPoint", // "fpnt"
                                                                     0x66726374: "fixedRectangle", // "frct"
                                                                     0x6973666c: "floating", // "isfl"
                                                                     0x6662636c: "fontCollection", // "fbcl"
                                                                     0x66626374: "fontContainer", // "fbct"
                                                                     0x6662646f: "fontDomain", // "fbdo"
                                                                     0x6662666d: "fontFamily", // "fbfm"
                                                                     0x66626c72: "fontLibrary", // "fblr"
                                                                     0x66626c62: "fontsLibrary", // "fblb"
                                                                     0x66626674: "fontType", // "fbft"
                                                                     0x66726920: "Friday", // "fri\0x20"
                                                                     0x70697366: "frontmost", // "pisf"
                                                                     0x47494666: "GIFPicture", // "GIFf"
                                                                     0x63677478: "graphicText", // "cgtx"
                                                                     0x68797068: "hyphens", // "hyph"
                                                                     0x49442020: "ID_", // "ID\0x20\0x20"
                                                                     0x70696478: "index", // "pidx"
                                                                     0x66626974: "installationTarget", // "fbit"
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
                                                                     0x706d6f64: "modal", // "pmod"
                                                                     0x696d6f64: "modified", // "imod"
                                                                     0x6d6f6e20: "Monday", // "mon\0x20"
                                                                     0x66626d66: "MyFontsLibrary", // "fbmf"
                                                                     0x706e616d: "name", // "pnam"
                                                                     0x6e6f2020: "no", // "no\0x20\0x20"
                                                                     0x6e6f7620: "November", // "nov\0x20"
                                                                     0x6e756c6c: "null", // "null"
                                                                     0x6e756d65: "numericStrings", // "nume"
                                                                     0x6f637420: "October", // "oct\0x20"
                                                                     0x70707468: "path", // "ppth"
                                                                     0x50494354: "PICTPicture", // "PICT"
                                                                     0x74706d6d: "pixelMapRecord", // "tpmm"
                                                                     0x51447074: "point", // "QDpt"
                                                                     0x66627073: "PostScriptName", // "fbps"
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
                                                                     0x63524742: "RGBColor", // "cRGB"
                                                                     0x74726f74: "rotation", // "trot"
                                                                     0x73617420: "Saturday", // "sat\0x20"
                                                                     0x73637074: "script", // "scpt"
                                                                     0x66626363: "selectedCollections", // "fbcc"
                                                                     0x66626666: "selectedFontFamilies", // "fbff"
                                                                     0x73656c63: "selection", // "selc"
                                                                     0x73657020: "September", // "sep\0x20"
                                                                     0x73686f72: "shortInteger", // "shor"
                                                                     0x73696e67: "smallReal", // "sing"
                                                                     0x54455854: "string", // "TEXT"
                                                                     0x7374796c: "styledClipboardText", // "styl"
                                                                     0x53545854: "styledText", // "STXT"
                                                                     0x6662736e: "styleName", // "fbsn"
                                                                     0x73756e20: "Sunday", // "sun\0x20"
                                                                     0x74737479: "textStyleInfo", // "tsty"
                                                                     0x74687520: "Thursday", // "thu\0x20"
                                                                     0x54494646: "TIFFPicture", // "TIFF"
                                                                     0x70746974: "titled", // "ptit"
                                                                     0x74756520: "Tuesday", // "tue\0x20"
                                                                     0x74797065: "typeClass", // "type"
                                                                     0x66626663: "typeface", // "fbfc"
                                                                     0x66626173: "typefaceAdditionalInfo", // "fbas"
                                                                     0x75747874: "UnicodeText", // "utxt"
                                                                     0x75636f6d: "unsignedDoubleInteger", // "ucom"
                                                                     0x6d61676e: "unsignedInteger", // "magn"
                                                                     0x75736872: "unsignedShortInteger", // "ushr"
                                                                     0x75743136: "UTF16Text", // "ut16"
                                                                     0x75746638: "UTF8Text", // "utf8"
                                                                     0x66627666: "validateFontsBeforeInstalling", // "fbvf"
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
                                                                     0x70626e64: "bounds", // "pbnd"
                                                                     0x70636c73: "class_", // "pcls"
                                                                     0x68636c62: "closeable", // "hclb"
                                                                     0x66626372: "copyright", // "fbcr"
                                                                     0x646e616d: "displayedName", // "dnam"
                                                                     0x6662646f: "domain", // "fbdo"
                                                                     0x66626964: "duplicated", // "fbid"
                                                                     0x6662656e: "enabled", // "fben"
                                                                     0x6662666e: "familyName", // "fbfn"
                                                                     0x66626673: "files", // "fbfs"
                                                                     0x6973666c: "floating", // "isfl"
                                                                     0x66626374: "fontContainer", // "fbct"
                                                                     0x6662666d: "fontFamily", // "fbfm"
                                                                     0x66626c62: "fontsLibrary", // "fblb"
                                                                     0x66626674: "fontType", // "fbft"
                                                                     0x70697366: "frontmost", // "pisf"
                                                                     0x49442020: "ID_", // "ID\0x20\0x20"
                                                                     0x70696478: "index", // "pidx"
                                                                     0x66626974: "installationTarget", // "fbit"
                                                                     0x69736d6e: "miniaturizable", // "ismn"
                                                                     0x706d6e64: "miniaturized", // "pmnd"
                                                                     0x706d6f64: "modal", // "pmod"
                                                                     0x696d6f64: "modified", // "imod"
                                                                     0x706e616d: "name", // "pnam"
                                                                     0x70707468: "path", // "ppth"
                                                                     0x66627073: "PostScriptName", // "fbps"
                                                                     0x70414c4c: "properties", // "pALL"
                                                                     0x7072737a: "resizable", // "prsz"
                                                                     0x66626363: "selectedCollections", // "fbcc"
                                                                     0x66626666: "selectedFontFamilies", // "fbff"
                                                                     0x73656c63: "selection", // "selc"
                                                                     0x6662736e: "styleName", // "fbsn"
                                                                     0x70746974: "titled", // "ptit"
                                                                     0x66626173: "typefaceAdditionalInfo", // "fbas"
                                                                     0x66627666: "validateFontsBeforeInstalling", // "fbvf"
                                                                     0x76657273: "version", // "vers"
                                                                     0x70766973: "visible", // "pvis"
                                                                     0x69737a6d: "zoomable", // "iszm"
                                                                     0x707a756d: "zoomed", // "pzum"
                                                     ],
                                                     elementsNames: [
                                                                     0x66626166: ("All Fonts library object", "AllFontsLibraryObjects"), // "fbaf"
                                                                     0x63617070: ("application", "applications"), // "capp"
                                                                     0x636f6c72: ("color", "colors"), // "colr"
                                                                     0x646f6375: ("document", "documents"), // "docu"
                                                                     0x6662636c: ("font collection", "fontCollections"), // "fbcl"
                                                                     0x66626374: ("font container", "fontContainers"), // "fbct"
                                                                     0x6662646f: ("font domain", "fontDomains"), // "fbdo"
                                                                     0x6662666d: ("font family", "fontFamilies"), // "fbfm"
                                                                     0x66626c72: ("font library", "fontLibraries"), // "fblr"
                                                                     0x636f626a: ("item", "items"), // "cobj"
                                                                     0x66626d66: ("MyFonts library", "MyFontsFontLibraries"), // "fbmf"
                                                                     0x66626663: ("typeface", "typefaces"), // "fbfc"
                                                                     0x6377696e: ("window", "windows"), // "cwin"
                                                     ])

private let _glueClasses = SwiftAutomation.GlueClasses(insertionSpecifierType: FBOInsertion.self,
                                       objectSpecifierType: FBOItem.self,
                                       multiObjectSpecifierType: FBOItems.self,
                                       rootSpecifierType: FBORoot.self,
                                       applicationType: FontBook.self,
                                       symbolType: FBOSymbol.self,
                                       formatter: _specifierFormatter)

private let _untargetedAppData = SwiftAutomation.AppData(glueClasses: _glueClasses)


/******************************************************************************/
// Symbol subclass defines static type/enum/property constants based on Font Book.app terminology

public class FBOSymbol: SwiftAutomation.Symbol {

    override public var typeAliasName: String {return "FBO"}

    public override class func symbol(code: OSType, type: OSType = typeType, descriptor: NSAppleEventDescriptor? = nil) -> FBOSymbol {
        switch (code) {
        case 0x616c6973: return self.alias // "alis"
        case 0x66626166: return self.AllFontsLibraryObject // "fbaf"
        case 0x2a2a2a2a: return self.anything // "****"
        case 0x63617070: return self.application // "capp"
        case 0x62756e64: return self.applicationBundleID // "bund"
        case 0x7369676e: return self.applicationSignature // "sign"
        case 0x6170726c: return self.applicationURL // "aprl"
        case 0x61707220: return self.April // "apr\0x20"
        case 0x61736b20: return self.ask // "ask\0x20"
        case 0x61756720: return self.August // "aug\0x20"
        case 0x62657374: return self.best // "best"
        case 0x626d726b: return self.bookmarkData // "bmrk"
        case 0x626f6f6c: return self.boolean // "bool"
        case 0x71647274: return self.boundingRectangle // "qdrt"
        case 0x70626e64: return self.bounds // "pbnd"
        case 0x63617365: return self.case_ // "case"
        case 0x70636c73: return self.class_ // "pcls"
        case 0x68636c62: return self.closeable // "hclb"
        case 0x636f6c72: return self.color // "colr"
        case 0x636c7274: return self.colorTable // "clrt"
        case 0x656e756d: return self.constant // "enum"
        case 0x66626372: return self.copyright // "fbcr"
        case 0x74646173: return self.dashStyle // "tdas"
        case 0x74647461: return self.data // "tdta"
        case 0x6c647420: return self.date // "ldt\0x20"
        case 0x64656320: return self.December // "dec\0x20"
        case 0x6465636d: return self.decimalStruct // "decm"
        case 0x64696163: return self.diacriticals // "diac"
        case 0x646e616d: return self.displayedName // "dnam"
        case 0x646f6375: return self.document // "docu"
        case 0x636f6d70: return self.doubleInteger // "comp"
        case 0x66626964: return self.duplicated // "fbid"
        case 0x6662656e: return self.enabled // "fben"
        case 0x656e6373: return self.encodedString // "encs"
        case 0x45505320: return self.EPSPicture // "EPS\0x20"
        case 0x65787061: return self.expansion // "expa"
        case 0x65787465: return self.extendedReal // "exte"
        case 0x6662666e: return self.familyName // "fbfn"
        case 0x66656220: return self.February // "feb\0x20"
        case 0x66737266: return self.fileRef // "fsrf"
        case 0x66626673: return self.files // "fbfs"
        case 0x66737320: return self.fileSpecification // "fss\0x20"
        case 0x6675726c: return self.fileURL // "furl"
        case 0x66697864: return self.fixed // "fixd"
        case 0x66706e74: return self.fixedPoint // "fpnt"
        case 0x66726374: return self.fixedRectangle // "frct"
        case 0x6973666c: return self.floating // "isfl"
        case 0x6662636c: return self.fontCollection // "fbcl"
        case 0x66626374: return self.fontContainer // "fbct"
        case 0x6662646f: return self.fontDomain // "fbdo"
        case 0x6662666d: return self.fontFamily // "fbfm"
        case 0x66626c72: return self.fontLibrary // "fblr"
        case 0x66626c62: return self.fontsLibrary // "fblb"
        case 0x66626674: return self.fontType // "fbft"
        case 0x66726920: return self.Friday // "fri\0x20"
        case 0x70697366: return self.frontmost // "pisf"
        case 0x47494666: return self.GIFPicture // "GIFf"
        case 0x63677478: return self.graphicText // "cgtx"
        case 0x68797068: return self.hyphens // "hyph"
        case 0x49442020: return self.ID_ // "ID\0x20\0x20"
        case 0x70696478: return self.index // "pidx"
        case 0x66626974: return self.installationTarget // "fbit"
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
        case 0x706d6f64: return self.modal // "pmod"
        case 0x696d6f64: return self.modified // "imod"
        case 0x6d6f6e20: return self.Monday // "mon\0x20"
        case 0x66626d66: return self.MyFontsLibrary // "fbmf"
        case 0x706e616d: return self.name // "pnam"
        case 0x6e6f2020: return self.no // "no\0x20\0x20"
        case 0x6e6f7620: return self.November // "nov\0x20"
        case 0x6e756c6c: return self.null // "null"
        case 0x6e756d65: return self.numericStrings // "nume"
        case 0x6f637420: return self.October // "oct\0x20"
        case 0x70707468: return self.path // "ppth"
        case 0x50494354: return self.PICTPicture // "PICT"
        case 0x74706d6d: return self.pixelMapRecord // "tpmm"
        case 0x51447074: return self.point // "QDpt"
        case 0x66627073: return self.PostScriptName // "fbps"
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
        case 0x63524742: return self.RGBColor // "cRGB"
        case 0x74726f74: return self.rotation // "trot"
        case 0x73617420: return self.Saturday // "sat\0x20"
        case 0x73637074: return self.script // "scpt"
        case 0x66626363: return self.selectedCollections // "fbcc"
        case 0x66626666: return self.selectedFontFamilies // "fbff"
        case 0x73656c63: return self.selection // "selc"
        case 0x73657020: return self.September // "sep\0x20"
        case 0x73686f72: return self.shortInteger // "shor"
        case 0x73696e67: return self.smallReal // "sing"
        case 0x54455854: return self.string // "TEXT"
        case 0x7374796c: return self.styledClipboardText // "styl"
        case 0x53545854: return self.styledText // "STXT"
        case 0x6662736e: return self.styleName // "fbsn"
        case 0x73756e20: return self.Sunday // "sun\0x20"
        case 0x74737479: return self.textStyleInfo // "tsty"
        case 0x74687520: return self.Thursday // "thu\0x20"
        case 0x54494646: return self.TIFFPicture // "TIFF"
        case 0x70746974: return self.titled // "ptit"
        case 0x74756520: return self.Tuesday // "tue\0x20"
        case 0x74797065: return self.typeClass // "type"
        case 0x66626663: return self.typeface // "fbfc"
        case 0x66626173: return self.typefaceAdditionalInfo // "fbas"
        case 0x75747874: return self.UnicodeText // "utxt"
        case 0x75636f6d: return self.unsignedDoubleInteger // "ucom"
        case 0x6d61676e: return self.unsignedInteger // "magn"
        case 0x75736872: return self.unsignedShortInteger // "ushr"
        case 0x75743136: return self.UTF16Text // "ut16"
        case 0x75746638: return self.UTF8Text // "utf8"
        case 0x66627666: return self.validateFontsBeforeInstalling // "fbvf"
        case 0x76657273: return self.version // "vers"
        case 0x70766973: return self.visible // "pvis"
        case 0x77656420: return self.Wednesday // "wed\0x20"
        case 0x77686974: return self.whitespace // "whit"
        case 0x6377696e: return self.window // "cwin"
        case 0x70736374: return self.writingCode // "psct"
        case 0x79657320: return self.yes // "yes\0x20"
        case 0x69737a6d: return self.zoomable // "iszm"
        case 0x707a756d: return self.zoomed // "pzum"
        default: return super.symbol(code: code, type: type, descriptor: descriptor) as! FBOSymbol
        }
    }

    // Types/properties
    public static let alias = FBOSymbol(name: "alias", code: 0x616c6973, type: typeType) // "alis"
    public static let AllFontsLibraryObject = FBOSymbol(name: "AllFontsLibraryObject", code: 0x66626166, type: typeType) // "fbaf"
    public static let anything = FBOSymbol(name: "anything", code: 0x2a2a2a2a, type: typeType) // "****"
    public static let application = FBOSymbol(name: "application", code: 0x63617070, type: typeType) // "capp"
    public static let applicationBundleID = FBOSymbol(name: "applicationBundleID", code: 0x62756e64, type: typeType) // "bund"
    public static let applicationSignature = FBOSymbol(name: "applicationSignature", code: 0x7369676e, type: typeType) // "sign"
    public static let applicationURL = FBOSymbol(name: "applicationURL", code: 0x6170726c, type: typeType) // "aprl"
    public static let April = FBOSymbol(name: "April", code: 0x61707220, type: typeType) // "apr\0x20"
    public static let August = FBOSymbol(name: "August", code: 0x61756720, type: typeType) // "aug\0x20"
    public static let best = FBOSymbol(name: "best", code: 0x62657374, type: typeType) // "best"
    public static let bookmarkData = FBOSymbol(name: "bookmarkData", code: 0x626d726b, type: typeType) // "bmrk"
    public static let boolean = FBOSymbol(name: "boolean", code: 0x626f6f6c, type: typeType) // "bool"
    public static let boundingRectangle = FBOSymbol(name: "boundingRectangle", code: 0x71647274, type: typeType) // "qdrt"
    public static let bounds = FBOSymbol(name: "bounds", code: 0x70626e64, type: typeType) // "pbnd"
    public static let class_ = FBOSymbol(name: "class_", code: 0x70636c73, type: typeType) // "pcls"
    public static let closeable = FBOSymbol(name: "closeable", code: 0x68636c62, type: typeType) // "hclb"
    public static let color = FBOSymbol(name: "color", code: 0x636f6c72, type: typeType) // "colr"
    public static let colorTable = FBOSymbol(name: "colorTable", code: 0x636c7274, type: typeType) // "clrt"
    public static let constant = FBOSymbol(name: "constant", code: 0x656e756d, type: typeType) // "enum"
    public static let copyright = FBOSymbol(name: "copyright", code: 0x66626372, type: typeType) // "fbcr"
    public static let dashStyle = FBOSymbol(name: "dashStyle", code: 0x74646173, type: typeType) // "tdas"
    public static let data = FBOSymbol(name: "data", code: 0x74647461, type: typeType) // "tdta"
    public static let date = FBOSymbol(name: "date", code: 0x6c647420, type: typeType) // "ldt\0x20"
    public static let December = FBOSymbol(name: "December", code: 0x64656320, type: typeType) // "dec\0x20"
    public static let decimalStruct = FBOSymbol(name: "decimalStruct", code: 0x6465636d, type: typeType) // "decm"
    public static let displayedName = FBOSymbol(name: "displayedName", code: 0x646e616d, type: typeType) // "dnam"
    public static let displayName = FBOSymbol(name: "displayName", code: 0x646e616d, type: typeType) // "dnam"
    public static let document = FBOSymbol(name: "document", code: 0x646f6375, type: typeType) // "docu"
    public static let domain = FBOSymbol(name: "domain", code: 0x6662646f, type: typeType) // "fbdo"
    public static let doubleInteger = FBOSymbol(name: "doubleInteger", code: 0x636f6d70, type: typeType) // "comp"
    public static let duplicated = FBOSymbol(name: "duplicated", code: 0x66626964, type: typeType) // "fbid"
    public static let enabled = FBOSymbol(name: "enabled", code: 0x6662656e, type: typeType) // "fben"
    public static let encodedString = FBOSymbol(name: "encodedString", code: 0x656e6373, type: typeType) // "encs"
    public static let EPSPicture = FBOSymbol(name: "EPSPicture", code: 0x45505320, type: typeType) // "EPS\0x20"
    public static let extendedReal = FBOSymbol(name: "extendedReal", code: 0x65787465, type: typeType) // "exte"
    public static let familyName = FBOSymbol(name: "familyName", code: 0x6662666e, type: typeType) // "fbfn"
    public static let February = FBOSymbol(name: "February", code: 0x66656220, type: typeType) // "feb\0x20"
    public static let fileRef = FBOSymbol(name: "fileRef", code: 0x66737266, type: typeType) // "fsrf"
    public static let files = FBOSymbol(name: "files", code: 0x66626673, type: typeType) // "fbfs"
    public static let fileSpecification = FBOSymbol(name: "fileSpecification", code: 0x66737320, type: typeType) // "fss\0x20"
    public static let fileURL = FBOSymbol(name: "fileURL", code: 0x6675726c, type: typeType) // "furl"
    public static let fixed = FBOSymbol(name: "fixed", code: 0x66697864, type: typeType) // "fixd"
    public static let fixedPoint = FBOSymbol(name: "fixedPoint", code: 0x66706e74, type: typeType) // "fpnt"
    public static let fixedRectangle = FBOSymbol(name: "fixedRectangle", code: 0x66726374, type: typeType) // "frct"
    public static let floating = FBOSymbol(name: "floating", code: 0x6973666c, type: typeType) // "isfl"
    public static let fontCollection = FBOSymbol(name: "fontCollection", code: 0x6662636c, type: typeType) // "fbcl"
    public static let fontContainer = FBOSymbol(name: "fontContainer", code: 0x66626374, type: typeType) // "fbct"
    public static let fontDomain = FBOSymbol(name: "fontDomain", code: 0x6662646f, type: typeType) // "fbdo"
    public static let fontFamily = FBOSymbol(name: "fontFamily", code: 0x6662666d, type: typeType) // "fbfm"
    public static let fontLibrary = FBOSymbol(name: "fontLibrary", code: 0x66626c72, type: typeType) // "fblr"
    public static let fontsLibrary = FBOSymbol(name: "fontsLibrary", code: 0x66626c62, type: typeType) // "fblb"
    public static let fontType = FBOSymbol(name: "fontType", code: 0x66626674, type: typeType) // "fbft"
    public static let Friday = FBOSymbol(name: "Friday", code: 0x66726920, type: typeType) // "fri\0x20"
    public static let frontmost = FBOSymbol(name: "frontmost", code: 0x70697366, type: typeType) // "pisf"
    public static let GIFPicture = FBOSymbol(name: "GIFPicture", code: 0x47494666, type: typeType) // "GIFf"
    public static let graphicText = FBOSymbol(name: "graphicText", code: 0x63677478, type: typeType) // "cgtx"
    public static let id = FBOSymbol(name: "id", code: 0x49442020, type: typeType) // "ID\0x20\0x20"
    public static let ID_ = FBOSymbol(name: "ID_", code: 0x49442020, type: typeType) // "ID\0x20\0x20"
    public static let index = FBOSymbol(name: "index", code: 0x70696478, type: typeType) // "pidx"
    public static let installationTarget = FBOSymbol(name: "installationTarget", code: 0x66626974, type: typeType) // "fbit"
    public static let integer = FBOSymbol(name: "integer", code: 0x6c6f6e67, type: typeType) // "long"
    public static let internationalText = FBOSymbol(name: "internationalText", code: 0x69747874, type: typeType) // "itxt"
    public static let internationalWritingCode = FBOSymbol(name: "internationalWritingCode", code: 0x696e746c, type: typeType) // "intl"
    public static let item = FBOSymbol(name: "item", code: 0x636f626a, type: typeType) // "cobj"
    public static let January = FBOSymbol(name: "January", code: 0x6a616e20, type: typeType) // "jan\0x20"
    public static let JPEGPicture = FBOSymbol(name: "JPEGPicture", code: 0x4a504547, type: typeType) // "JPEG"
    public static let July = FBOSymbol(name: "July", code: 0x6a756c20, type: typeType) // "jul\0x20"
    public static let June = FBOSymbol(name: "June", code: 0x6a756e20, type: typeType) // "jun\0x20"
    public static let kernelProcessID = FBOSymbol(name: "kernelProcessID", code: 0x6b706964, type: typeType) // "kpid"
    public static let largeReal = FBOSymbol(name: "largeReal", code: 0x6c64626c, type: typeType) // "ldbl"
    public static let list = FBOSymbol(name: "list", code: 0x6c697374, type: typeType) // "list"
    public static let locationReference = FBOSymbol(name: "locationReference", code: 0x696e736c, type: typeType) // "insl"
    public static let longFixed = FBOSymbol(name: "longFixed", code: 0x6c667864, type: typeType) // "lfxd"
    public static let longFixedPoint = FBOSymbol(name: "longFixedPoint", code: 0x6c667074, type: typeType) // "lfpt"
    public static let longFixedRectangle = FBOSymbol(name: "longFixedRectangle", code: 0x6c667263, type: typeType) // "lfrc"
    public static let longPoint = FBOSymbol(name: "longPoint", code: 0x6c706e74, type: typeType) // "lpnt"
    public static let longRectangle = FBOSymbol(name: "longRectangle", code: 0x6c726374, type: typeType) // "lrct"
    public static let machine = FBOSymbol(name: "machine", code: 0x6d616368, type: typeType) // "mach"
    public static let machineLocation = FBOSymbol(name: "machineLocation", code: 0x6d4c6f63, type: typeType) // "mLoc"
    public static let machPort = FBOSymbol(name: "machPort", code: 0x706f7274, type: typeType) // "port"
    public static let March = FBOSymbol(name: "March", code: 0x6d617220, type: typeType) // "mar\0x20"
    public static let May = FBOSymbol(name: "May", code: 0x6d617920, type: typeType) // "may\0x20"
    public static let miniaturizable = FBOSymbol(name: "miniaturizable", code: 0x69736d6e, type: typeType) // "ismn"
    public static let miniaturized = FBOSymbol(name: "miniaturized", code: 0x706d6e64, type: typeType) // "pmnd"
    public static let modal = FBOSymbol(name: "modal", code: 0x706d6f64, type: typeType) // "pmod"
    public static let modified = FBOSymbol(name: "modified", code: 0x696d6f64, type: typeType) // "imod"
    public static let Monday = FBOSymbol(name: "Monday", code: 0x6d6f6e20, type: typeType) // "mon\0x20"
    public static let MyFontsLibrary = FBOSymbol(name: "MyFontsLibrary", code: 0x66626d66, type: typeType) // "fbmf"
    public static let name = FBOSymbol(name: "name", code: 0x706e616d, type: typeType) // "pnam"
    public static let November = FBOSymbol(name: "November", code: 0x6e6f7620, type: typeType) // "nov\0x20"
    public static let null = FBOSymbol(name: "null", code: 0x6e756c6c, type: typeType) // "null"
    public static let October = FBOSymbol(name: "October", code: 0x6f637420, type: typeType) // "oct\0x20"
    public static let path = FBOSymbol(name: "path", code: 0x70707468, type: typeType) // "ppth"
    public static let PICTPicture = FBOSymbol(name: "PICTPicture", code: 0x50494354, type: typeType) // "PICT"
    public static let pixelMapRecord = FBOSymbol(name: "pixelMapRecord", code: 0x74706d6d, type: typeType) // "tpmm"
    public static let point = FBOSymbol(name: "point", code: 0x51447074, type: typeType) // "QDpt"
    public static let PostScriptName = FBOSymbol(name: "PostScriptName", code: 0x66627073, type: typeType) // "fbps"
    public static let processSerialNumber = FBOSymbol(name: "processSerialNumber", code: 0x70736e20, type: typeType) // "psn\0x20"
    public static let properties = FBOSymbol(name: "properties", code: 0x70414c4c, type: typeType) // "pALL"
    public static let property_ = FBOSymbol(name: "property_", code: 0x70726f70, type: typeType) // "prop"
    public static let real = FBOSymbol(name: "real", code: 0x646f7562, type: typeType) // "doub"
    public static let record = FBOSymbol(name: "record", code: 0x7265636f, type: typeType) // "reco"
    public static let reference = FBOSymbol(name: "reference", code: 0x6f626a20, type: typeType) // "obj\0x20"
    public static let resizable = FBOSymbol(name: "resizable", code: 0x7072737a, type: typeType) // "prsz"
    public static let RGB16Color = FBOSymbol(name: "RGB16Color", code: 0x74723136, type: typeType) // "tr16"
    public static let RGB96Color = FBOSymbol(name: "RGB96Color", code: 0x74723936, type: typeType) // "tr96"
    public static let RGBColor = FBOSymbol(name: "RGBColor", code: 0x63524742, type: typeType) // "cRGB"
    public static let rotation = FBOSymbol(name: "rotation", code: 0x74726f74, type: typeType) // "trot"
    public static let Saturday = FBOSymbol(name: "Saturday", code: 0x73617420, type: typeType) // "sat\0x20"
    public static let script = FBOSymbol(name: "script", code: 0x73637074, type: typeType) // "scpt"
    public static let selectedCollections = FBOSymbol(name: "selectedCollections", code: 0x66626363, type: typeType) // "fbcc"
    public static let selectedFontFamilies = FBOSymbol(name: "selectedFontFamilies", code: 0x66626666, type: typeType) // "fbff"
    public static let selection = FBOSymbol(name: "selection", code: 0x73656c63, type: typeType) // "selc"
    public static let September = FBOSymbol(name: "September", code: 0x73657020, type: typeType) // "sep\0x20"
    public static let shortInteger = FBOSymbol(name: "shortInteger", code: 0x73686f72, type: typeType) // "shor"
    public static let smallReal = FBOSymbol(name: "smallReal", code: 0x73696e67, type: typeType) // "sing"
    public static let string = FBOSymbol(name: "string", code: 0x54455854, type: typeType) // "TEXT"
    public static let styledClipboardText = FBOSymbol(name: "styledClipboardText", code: 0x7374796c, type: typeType) // "styl"
    public static let styledText = FBOSymbol(name: "styledText", code: 0x53545854, type: typeType) // "STXT"
    public static let styleName = FBOSymbol(name: "styleName", code: 0x6662736e, type: typeType) // "fbsn"
    public static let Sunday = FBOSymbol(name: "Sunday", code: 0x73756e20, type: typeType) // "sun\0x20"
    public static let textStyleInfo = FBOSymbol(name: "textStyleInfo", code: 0x74737479, type: typeType) // "tsty"
    public static let Thursday = FBOSymbol(name: "Thursday", code: 0x74687520, type: typeType) // "thu\0x20"
    public static let TIFFPicture = FBOSymbol(name: "TIFFPicture", code: 0x54494646, type: typeType) // "TIFF"
    public static let titled = FBOSymbol(name: "titled", code: 0x70746974, type: typeType) // "ptit"
    public static let Tuesday = FBOSymbol(name: "Tuesday", code: 0x74756520, type: typeType) // "tue\0x20"
    public static let typeClass = FBOSymbol(name: "typeClass", code: 0x74797065, type: typeType) // "type"
    public static let typeface = FBOSymbol(name: "typeface", code: 0x66626663, type: typeType) // "fbfc"
    public static let typefaceAdditionalInfo = FBOSymbol(name: "typefaceAdditionalInfo", code: 0x66626173, type: typeType) // "fbas"
    public static let UnicodeText = FBOSymbol(name: "UnicodeText", code: 0x75747874, type: typeType) // "utxt"
    public static let unsignedDoubleInteger = FBOSymbol(name: "unsignedDoubleInteger", code: 0x75636f6d, type: typeType) // "ucom"
    public static let unsignedInteger = FBOSymbol(name: "unsignedInteger", code: 0x6d61676e, type: typeType) // "magn"
    public static let unsignedShortInteger = FBOSymbol(name: "unsignedShortInteger", code: 0x75736872, type: typeType) // "ushr"
    public static let UTF16Text = FBOSymbol(name: "UTF16Text", code: 0x75743136, type: typeType) // "ut16"
    public static let UTF8Text = FBOSymbol(name: "UTF8Text", code: 0x75746638, type: typeType) // "utf8"
    public static let validateFontsBeforeInstalling = FBOSymbol(name: "validateFontsBeforeInstalling", code: 0x66627666, type: typeType) // "fbvf"
    public static let version = FBOSymbol(name: "version", code: 0x76657273, type: typeType) // "vers"
    public static let visible = FBOSymbol(name: "visible", code: 0x70766973, type: typeType) // "pvis"
    public static let Wednesday = FBOSymbol(name: "Wednesday", code: 0x77656420, type: typeType) // "wed\0x20"
    public static let window = FBOSymbol(name: "window", code: 0x6377696e, type: typeType) // "cwin"
    public static let writingCode = FBOSymbol(name: "writingCode", code: 0x70736374, type: typeType) // "psct"
    public static let zoomable = FBOSymbol(name: "zoomable", code: 0x69737a6d, type: typeType) // "iszm"
    public static let zoomed = FBOSymbol(name: "zoomed", code: 0x707a756d, type: typeType) // "pzum"

    // Enumerators
    public static let ask = FBOSymbol(name: "ask", code: 0x61736b20, type: typeEnumerated) // "ask\0x20"
    public static let case_ = FBOSymbol(name: "case_", code: 0x63617365, type: typeEnumerated) // "case"
    public static let diacriticals = FBOSymbol(name: "diacriticals", code: 0x64696163, type: typeEnumerated) // "diac"
    public static let expansion = FBOSymbol(name: "expansion", code: 0x65787061, type: typeEnumerated) // "expa"
    public static let hyphens = FBOSymbol(name: "hyphens", code: 0x68797068, type: typeEnumerated) // "hyph"
    public static let no = FBOSymbol(name: "no", code: 0x6e6f2020, type: typeEnumerated) // "no\0x20\0x20"
    public static let numericStrings = FBOSymbol(name: "numericStrings", code: 0x6e756d65, type: typeEnumerated) // "nume"
    public static let punctuation = FBOSymbol(name: "punctuation", code: 0x70756e63, type: typeEnumerated) // "punc"
    public static let whitespace = FBOSymbol(name: "whitespace", code: 0x77686974, type: typeEnumerated) // "whit"
    public static let yes = FBOSymbol(name: "yes", code: 0x79657320, type: typeEnumerated) // "yes\0x20"
}

public typealias FBO = FBOSymbol // allows symbols to be written as (e.g.) FBO.name instead of FBOSymbol.name


/******************************************************************************/
// Specifier extensions; these add command methods and property/elements getters based on Font Book.app terminology

public protocol FBOCommand: SwiftAutomation.SpecifierProtocol {} // provides AE dispatch methods

// Command->Any will be bound when return type can't be inferred, else Command->T

extension FBOCommand {
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
    @discardableResult public func add(_ directParameter: Any = SwiftAutomation.NoParameter,
            to: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "add", eventClass: 0x66626f6b, eventID: 0x66626164, // "fbok"/"fbad"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x6662746f, to), // "fbto"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func add<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            to: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "add", eventClass: 0x66626f6b, eventID: 0x66626164, // "fbok"/"fbad"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x6662746f, to), // "fbto"
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
    @discardableResult public func duplicate(_ directParameter: Any = SwiftAutomation.NoParameter,
            to: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "duplicate", eventClass: 0x636f7265, eventID: 0x636c6f6e, // "core"/"clon"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x696e7368, to), // "insh"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func duplicate<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            to: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "duplicate", eventClass: 0x636f7265, eventID: 0x636c6f6e, // "core"/"clon"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x696e7368, to), // "insh"
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
    @discardableResult public func export(_ directParameter: Any = SwiftAutomation.NoParameter,
            to: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "export", eventClass: 0x66626f6b, eventID: 0x66626578, // "fbok"/"fbex"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x6662746f, to), // "fbto"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func export<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            to: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "export", eventClass: 0x66626f6b, eventID: 0x66626578, // "fbok"/"fbex"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x6662746f, to), // "fbto"
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
    @discardableResult public func remove(_ directParameter: Any = SwiftAutomation.NoParameter,
            from: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "remove", eventClass: 0x66626f6b, eventID: 0x6662726d, // "fbok"/"fbrm"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("from", 0x66627363, from), // "fbsc"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func remove<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            from: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "remove", eventClass: 0x66626f6b, eventID: 0x6662726d, // "fbok"/"fbrm"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("from", 0x66627363, from), // "fbsc"
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
            as_: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "save", eventClass: 0x636f7265, eventID: 0x73617665, // "core"/"save"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("in_", 0x6b66696c, in_), // "kfil"
                    ("as_", 0x666c7470, as_), // "fltp"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func save<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            in_: Any = SwiftAutomation.NoParameter,
            as_: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "save", eventClass: 0x636f7265, eventID: 0x73617665, // "core"/"save"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("in_", 0x6b66696c, in_), // "kfil"
                    ("as_", 0x666c7470, as_), // "fltp"
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
    @discardableResult public func validateFontFile(_ directParameter: Any = SwiftAutomation.NoParameter,
            generatingSummaryOnly: Any = SwiftAutomation.NoParameter,
            ignorringErrors: Any = SwiftAutomation.NoParameter,
            dynamicChecking: Any = SwiftAutomation.NoParameter,
            withProperties: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "validateFontFile", eventClass: 0x66626f6b, eventID: 0x6662766c, // "fbok"/"fbvl"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("generatingSummaryOnly", 0x66626773, generatingSummaryOnly), // "fbgs"
                    ("ignorringErrors", 0x66626965, ignorringErrors), // "fbie"
                    ("dynamicChecking", 0x66626464, dynamicChecking), // "fbdd"
                    ("withProperties", 0x70726474, withProperties), // "prdt"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func validateFontFile<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            generatingSummaryOnly: Any = SwiftAutomation.NoParameter,
            ignorringErrors: Any = SwiftAutomation.NoParameter,
            dynamicChecking: Any = SwiftAutomation.NoParameter,
            withProperties: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "validateFontFile", eventClass: 0x66626f6b, eventID: 0x6662766c, // "fbok"/"fbvl"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("generatingSummaryOnly", 0x66626773, generatingSummaryOnly), // "fbgs"
                    ("ignorringErrors", 0x66626965, ignorringErrors), // "fbie"
                    ("dynamicChecking", 0x66626464, dynamicChecking), // "fbdd"
                    ("withProperties", 0x70726474, withProperties), // "prdt"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
}


public protocol FBOObject: SwiftAutomation.ObjectSpecifierExtension, FBOCommand {} // provides vars and methods for constructing specifiers

extension FBOObject {
    
    // Properties
    public var bounds: FBOItem {return self.property(0x70626e64) as! FBOItem} // "pbnd"
    public var class_: FBOItem {return self.property(0x70636c73) as! FBOItem} // "pcls"
    public var closeable: FBOItem {return self.property(0x68636c62) as! FBOItem} // "hclb"
    public var copyright: FBOItem {return self.property(0x66626372) as! FBOItem} // "fbcr"
    public var displayedName: FBOItem {return self.property(0x646e616d) as! FBOItem} // "dnam"
    public var displayName: FBOItem {return self.property(0x646e616d) as! FBOItem} // "dnam"
    public var domain: FBOItem {return self.property(0x6662646f) as! FBOItem} // "fbdo"
    public var duplicated: FBOItem {return self.property(0x66626964) as! FBOItem} // "fbid"
    public var enabled: FBOItem {return self.property(0x6662656e) as! FBOItem} // "fben"
    public var familyName: FBOItem {return self.property(0x6662666e) as! FBOItem} // "fbfn"
    public var files: FBOItem {return self.property(0x66626673) as! FBOItem} // "fbfs"
    public var floating: FBOItem {return self.property(0x6973666c) as! FBOItem} // "isfl"
    public var fontContainer: FBOItem {return self.property(0x66626374) as! FBOItem} // "fbct"
    public var fontFamily: FBOItem {return self.property(0x6662666d) as! FBOItem} // "fbfm"
    public var fontsLibrary: FBOItem {return self.property(0x66626c62) as! FBOItem} // "fblb"
    public var fontType: FBOItem {return self.property(0x66626674) as! FBOItem} // "fbft"
    public var frontmost: FBOItem {return self.property(0x70697366) as! FBOItem} // "pisf"
    public var id: FBOItem {return self.property(0x49442020) as! FBOItem} // "ID\0x20\0x20"
    public var ID_: FBOItem {return self.property(0x49442020) as! FBOItem} // "ID\0x20\0x20"
    public var index: FBOItem {return self.property(0x70696478) as! FBOItem} // "pidx"
    public var installationTarget: FBOItem {return self.property(0x66626974) as! FBOItem} // "fbit"
    public var miniaturizable: FBOItem {return self.property(0x69736d6e) as! FBOItem} // "ismn"
    public var miniaturized: FBOItem {return self.property(0x706d6e64) as! FBOItem} // "pmnd"
    public var modal: FBOItem {return self.property(0x706d6f64) as! FBOItem} // "pmod"
    public var modified: FBOItem {return self.property(0x696d6f64) as! FBOItem} // "imod"
    public var name: FBOItem {return self.property(0x706e616d) as! FBOItem} // "pnam"
    public var path: FBOItem {return self.property(0x70707468) as! FBOItem} // "ppth"
    public var PostScriptName: FBOItem {return self.property(0x66627073) as! FBOItem} // "fbps"
    public var properties: FBOItem {return self.property(0x70414c4c) as! FBOItem} // "pALL"
    public var resizable: FBOItem {return self.property(0x7072737a) as! FBOItem} // "prsz"
    public var selectedCollections: FBOItem {return self.property(0x66626363) as! FBOItem} // "fbcc"
    public var selectedFontFamilies: FBOItem {return self.property(0x66626666) as! FBOItem} // "fbff"
    public var selection: FBOItem {return self.property(0x73656c63) as! FBOItem} // "selc"
    public var styleName: FBOItem {return self.property(0x6662736e) as! FBOItem} // "fbsn"
    public var titled: FBOItem {return self.property(0x70746974) as! FBOItem} // "ptit"
    public var typefaceAdditionalInfo: FBOItem {return self.property(0x66626173) as! FBOItem} // "fbas"
    public var validateFontsBeforeInstalling: FBOItem {return self.property(0x66627666) as! FBOItem} // "fbvf"
    public var version: FBOItem {return self.property(0x76657273) as! FBOItem} // "vers"
    public var visible: FBOItem {return self.property(0x70766973) as! FBOItem} // "pvis"
    public var zoomable: FBOItem {return self.property(0x69737a6d) as! FBOItem} // "iszm"
    public var zoomed: FBOItem {return self.property(0x707a756d) as! FBOItem} // "pzum"

    // Elements
    public var AllFontsLibraryObjects: FBOItems {return self.elements(0x66626166) as! FBOItems} // "fbaf"
    public var applications: FBOItems {return self.elements(0x63617070) as! FBOItems} // "capp"
    public var colors: FBOItems {return self.elements(0x636f6c72) as! FBOItems} // "colr"
    public var documents: FBOItems {return self.elements(0x646f6375) as! FBOItems} // "docu"
    public var fontCollections: FBOItems {return self.elements(0x6662636c) as! FBOItems} // "fbcl"
    public var fontContainers: FBOItems {return self.elements(0x66626374) as! FBOItems} // "fbct"
    public var fontDomains: FBOItems {return self.elements(0x6662646f) as! FBOItems} // "fbdo"
    public var fontFamilies: FBOItems {return self.elements(0x6662666d) as! FBOItems} // "fbfm"
    public var fontLibraries: FBOItems {return self.elements(0x66626c72) as! FBOItems} // "fblr"
    public var items: FBOItems {return self.elements(0x636f626a) as! FBOItems} // "cobj"
    public var MyFontsFontLibraries: FBOItems {return self.elements(0x66626d66) as! FBOItems} // "fbmf"
    public var typefaces: FBOItems {return self.elements(0x66626663) as! FBOItems} // "fbfc"
    public var windows: FBOItems {return self.elements(0x6377696e) as! FBOItems} // "cwin"
}


/******************************************************************************/
// Specifier subclasses add app-specific extensions

// beginning/end/before/after
public class FBOInsertion: SwiftAutomation.InsertionSpecifier, FBOCommand {}


// property/by-index/by-name/by-id/previous/next/first/middle/last/any
public class FBOItem: SwiftAutomation.ObjectSpecifier, FBOObject {
    public typealias InsertionSpecifierType = FBOInsertion
    public typealias ObjectSpecifierType = FBOItem
    public typealias MultipleObjectSpecifierType = FBOItems
}

// by-range/by-test/all
public class FBOItems: FBOItem, SwiftAutomation.MultipleObjectSpecifierExtension {}

// App/Con/Its
public class FBORoot: SwiftAutomation.RootSpecifier, FBOObject, SwiftAutomation.RootSpecifierExtension {
    public typealias InsertionSpecifierType = FBOInsertion
    public typealias ObjectSpecifierType = FBOItem
    public typealias MultipleObjectSpecifierType = FBOItems
    public override class var untargetedAppData: SwiftAutomation.AppData { return _untargetedAppData }
}

// Application
public class FontBook: FBORoot, SwiftAutomation.Application {
    public convenience init(launchOptions: SwiftAutomation.LaunchOptions = SwiftAutomation.DefaultLaunchOptions, relaunchMode: SwiftAutomation.RelaunchMode = SwiftAutomation.DefaultRelaunchMode) {
        self.init(rootObject: SwiftAutomation.AppRootDesc, appData: Swift.type(of:self).untargetedAppData.targetedCopy(
                  .bundleIdentifier("com.apple.FontBook", true), launchOptions: launchOptions, relaunchMode: relaunchMode))
    }
}

// App/Con/Its root objects used to construct untargeted specifiers; these can be used to construct specifiers for use in commands, though cannot send commands themselves

public let FBOApp = _untargetedAppData.app as! FBORoot
public let FBOCon = _untargetedAppData.con as! FBORoot
public let FBOIts = _untargetedAppData.its as! FBORoot


/******************************************************************************/
// Static types

public typealias FBORecord = [FBOSymbol:Any] // default Swift type for AERecordDescs







