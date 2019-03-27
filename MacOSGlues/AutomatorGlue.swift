//
//  AutomatorGlue.swift
//  Automator.app 2.9
//  SwiftAutomation.framework 0.1.0
//  `aeglue -S 'Automator.app'`
//


import Foundation
import SwiftAutomation


/******************************************************************************/
// Create an untargeted AppData instance for use in App, Con, Its roots,
// and in Application initializers to create targeted AppData instances.

private let _specifierFormatter = SwiftAutomation.SpecifierFormatter(applicationClassName: "Automator",
                                                     classNamePrefix: "AUT",
                                                     typeNames: [
                                                                     0x616c6973: "alias", // "alis"
                                                                     0x2a2a2a2a: "anything", // "****"
                                                                     0x63617070: "application", // "capp"
                                                                     0x62756e64: "applicationBundleID", // "bund"
                                                                     0x7369676e: "applicationSignature", // "sign"
                                                                     0x6170726c: "applicationURL", // "aprl"
                                                                     0x61707220: "April", // "apr\0x20"
                                                                     0x61736b20: "ask", // "ask\0x20"
                                                                     0x61747473: "attachment", // "atts"
                                                                     0x63617472: "attributeRun", // "catr"
                                                                     0x61756720: "August", // "aug\0x20"
                                                                     0x6163747a: "AutomatorAction", // "actz"
                                                                     0x62657374: "best", // "best"
                                                                     0x626d726b: "bookmarkData", // "bmrk"
                                                                     0x626f6f6c: "boolean", // "bool"
                                                                     0x71647274: "boundingRectangle", // "qdrt"
                                                                     0x70626e64: "bounds", // "pbnd"
                                                                     0x626e6964: "bundleId", // "bnid"
                                                                     0x63617365: "case_", // "case"
                                                                     0x63746779: "category", // "ctgy"
                                                                     0x63686120: "character", // "cha\0x20"
                                                                     0x70636c73: "class_", // "pcls"
                                                                     0x68636c62: "closeable", // "hclb"
                                                                     0x6c77636c: "collating", // "lwcl"
                                                                     0x636f6c72: "color", // "colr"
                                                                     0x636c7274: "colorTable", // "clrt"
                                                                     0x636f6d74: "comment", // "comt"
                                                                     0x656e756d: "constant", // "enum"
                                                                     0x6c776370: "copies", // "lwcp"
                                                                     0x63616374: "currentAction", // "cact"
                                                                     0x74646173: "dashStyle", // "tdas"
                                                                     0x74647461: "data", // "tdta"
                                                                     0x6c647420: "date", // "ldt\0x20"
                                                                     0x64656320: "December", // "dec\0x20"
                                                                     0x6465636d: "decimalStruct", // "decm"
                                                                     0x6476616c: "defaultValue", // "dval"
                                                                     0x6c776474: "detailed", // "lwdt"
                                                                     0x64696163: "diacriticals", // "diac"
                                                                     0x646f6375: "document", // "docu"
                                                                     0x636f6d70: "doubleInteger", // "comp"
                                                                     0x656e6142: "enabled", // "enaB"
                                                                     0x656e6373: "encodedString", // "encs"
                                                                     0x6c776c70: "endingPage", // "lwlp"
                                                                     0x45505320: "EPSPicture", // "EPS\0x20"
                                                                     0x6c776568: "errorHandling", // "lweh"
                                                                     0x7865726d: "executionErrorMessage", // "xerm"
                                                                     0x7865726e: "executionErrorNumber", // "xern"
                                                                     0x78696478: "executionId", // "xidx"
                                                                     0x7872736c: "executionResult", // "xrsl"
                                                                     0x65787061: "expansion", // "expa"
                                                                     0x65787465: "extendedReal", // "exte"
                                                                     0x6661786e: "faxNumber", // "faxn"
                                                                     0x66656220: "February", // "feb\0x20"
                                                                     0x6174666e: "fileName", // "atfn"
                                                                     0x66737266: "fileRef", // "fsrf"
                                                                     0x66737320: "fileSpecification", // "fss\0x20"
                                                                     0x6675726c: "fileURL", // "furl"
                                                                     0x66697864: "fixed", // "fixd"
                                                                     0x66706e74: "fixedPoint", // "fpnt"
                                                                     0x66726374: "fixedRectangle", // "frct"
                                                                     0x6973666c: "floating", // "isfl"
                                                                     0x666f6e74: "font", // "font"
                                                                     0x66726920: "Friday", // "fri\0x20"
                                                                     0x70697366: "frontmost", // "pisf"
                                                                     0x47494666: "GIFPicture", // "GIFf"
                                                                     0x63677478: "graphicText", // "cgtx"
                                                                     0x68797068: "hyphens", // "hyph"
                                                                     0x69636e6d: "iconName", // "icnm"
                                                                     0x49442020: "id", // "ID\0x20\0x20"
                                                                     0x6967696e: "ignoresInput", // "igin"
                                                                     0x70696478: "index", // "pidx"
                                                                     0x696e7479: "inputTypes", // "inty"
                                                                     0x6c6f6e67: "integer", // "long"
                                                                     0x69747874: "internationalText", // "itxt"
                                                                     0x696e746c: "internationalWritingCode", // "intl"
                                                                     0x69727276: "irreversible", // "irrv"
                                                                     0x636f626a: "item", // "cobj"
                                                                     0x6a616e20: "January", // "jan\0x20"
                                                                     0x4a504547: "JPEGPicture", // "JPEG"
                                                                     0x6a756c20: "July", // "jul\0x20"
                                                                     0x6a756e20: "June", // "jun\0x20"
                                                                     0x6b706964: "kernelProcessID", // "kpid"
                                                                     0x6b797764: "keywords", // "kywd"
                                                                     0x6b696e64: "kind", // "kind"
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
                                                                     0x706e616d: "name", // "pnam"
                                                                     0x6e6f2020: "no", // "no\0x20\0x20"
                                                                     0x6e6f6e65: "none", // "none"
                                                                     0x6e6f7620: "November", // "nov\0x20"
                                                                     0x6e756c6c: "null", // "null"
                                                                     0x6e756d65: "numericStrings", // "nume"
                                                                     0x6f637420: "October", // "oct\0x20"
                                                                     0x6f757479: "outputTypes", // "outy"
                                                                     0x6c776c61: "pagesAcross", // "lwla"
                                                                     0x6c776c64: "pagesDown", // "lwld"
                                                                     0x63706172: "paragraph", // "cpar"
                                                                     0x70776b66: "parentWorkflow", // "pwkf"
                                                                     0x70707468: "path", // "ppth"
                                                                     0x50494354: "PICTPicture", // "PICT"
                                                                     0x74706d6d: "pixelMapRecord", // "tpmm"
                                                                     0x51447074: "point", // "QDpt"
                                                                     0x70736574: "printSettings", // "pset"
                                                                     0x70736e20: "processSerialNumber", // "psn\0x20"
                                                                     0x70414c4c: "properties", // "pALL"
                                                                     0x70726f70: "property_", // "prop"
                                                                     0x70756e63: "punctuation", // "punc"
                                                                     0x646f7562: "real", // "doub"
                                                                     0x7265636f: "record", // "reco"
                                                                     0x6f626a20: "reference", // "obj\0x20"
                                                                     0x6c777174: "requestedPrintTime", // "lwqt"
                                                                     0x72657172: "requiredResource", // "reqr"
                                                                     0x7072737a: "resizable", // "prsz"
                                                                     0x72737263: "resource", // "rsrc"
                                                                     0x7276626c: "reversible", // "rvbl"
                                                                     0x74723136: "RGB16Color", // "tr16"
                                                                     0x74723936: "RGB96Color", // "tr96"
                                                                     0x63524742: "RGBColor", // "cRGB"
                                                                     0x74726f74: "rotation", // "trot"
                                                                     0x73617420: "Saturday", // "sat\0x20"
                                                                     0x73637074: "script", // "scpt"
                                                                     0x73657020: "September", // "sep\0x20"
                                                                     0x7374626c: "settable", // "stbl"
                                                                     0x73746e67: "setting", // "stng"
                                                                     0x73686f72: "shortInteger", // "shor"
                                                                     0x73687772: "showActionWhenRun", // "shwr"
                                                                     0x7074737a: "size", // "ptsz"
                                                                     0x73696e67: "smallReal", // "sing"
                                                                     0x6c777374: "standard", // "lwst"
                                                                     0x6c776670: "startingPage", // "lwfp"
                                                                     0x54455854: "string", // "TEXT"
                                                                     0x7374796c: "styledClipboardText", // "styl"
                                                                     0x53545854: "styledText", // "STXT"
                                                                     0x73756e20: "Sunday", // "sun\0x20"
                                                                     0x74617070: "targetApplication", // "tapp"
                                                                     0x74727072: "targetPrinter", // "trpr"
                                                                     0x63747874: "text", // "ctxt"
                                                                     0x74737479: "textStyleInfo", // "tsty"
                                                                     0x74687520: "Thursday", // "thu\0x20"
                                                                     0x54494646: "TIFFPicture", // "TIFF"
                                                                     0x70746974: "titled", // "ptit"
                                                                     0x74756520: "Tuesday", // "tue\0x20"
                                                                     0x74797065: "typeClass", // "type"
                                                                     0x75747874: "UnicodeText", // "utxt"
                                                                     0x75636f6d: "unsignedDoubleInteger", // "ucom"
                                                                     0x6d61676e: "unsignedInteger", // "magn"
                                                                     0x75736872: "unsignedShortInteger", // "ushr"
                                                                     0x75743136: "UTF16Text", // "ut16"
                                                                     0x75746638: "UTF8Text", // "utf8"
                                                                     0x7076616c: "value", // "pval"
                                                                     0x76617269: "variable", // "vari"
                                                                     0x76657273: "version", // "vers"
                                                                     0x70766973: "visible", // "pvis"
                                                                     0x77616374: "warningAction", // "wact"
                                                                     0x776c6576: "warningLevel", // "wlev"
                                                                     0x776d7367: "warningMessage", // "wmsg"
                                                                     0x77656420: "Wednesday", // "wed\0x20"
                                                                     0x77686974: "whitespace", // "whit"
                                                                     0x6377696e: "window", // "cwin"
                                                                     0x63776f72: "word", // "cwor"
                                                                     0x776b6677: "workflow", // "wkfw"
                                                                     0x70736374: "writingCode", // "psct"
                                                                     0x79657320: "yes", // "yes\0x20"
                                                                     0x69737a6d: "zoomable", // "iszm"
                                                                     0x707a756d: "zoomed", // "pzum"
                                                     ],
                                                     propertyNames: [
                                                                     0x70626e64: "bounds", // "pbnd"
                                                                     0x626e6964: "bundleId", // "bnid"
                                                                     0x63746779: "category", // "ctgy"
                                                                     0x70636c73: "class_", // "pcls"
                                                                     0x68636c62: "closeable", // "hclb"
                                                                     0x6c77636c: "collating", // "lwcl"
                                                                     0x636f6c72: "color", // "colr"
                                                                     0x636f6d74: "comment", // "comt"
                                                                     0x6c776370: "copies", // "lwcp"
                                                                     0x63616374: "currentAction", // "cact"
                                                                     0x6476616c: "defaultValue", // "dval"
                                                                     0x646f6375: "document", // "docu"
                                                                     0x656e6142: "enabled", // "enaB"
                                                                     0x6c776c70: "endingPage", // "lwlp"
                                                                     0x6c776568: "errorHandling", // "lweh"
                                                                     0x7865726d: "executionErrorMessage", // "xerm"
                                                                     0x7865726e: "executionErrorNumber", // "xern"
                                                                     0x78696478: "executionId", // "xidx"
                                                                     0x7872736c: "executionResult", // "xrsl"
                                                                     0x6661786e: "faxNumber", // "faxn"
                                                                     0x6174666e: "fileName", // "atfn"
                                                                     0x6973666c: "floating", // "isfl"
                                                                     0x666f6e74: "font", // "font"
                                                                     0x70697366: "frontmost", // "pisf"
                                                                     0x69636e6d: "iconName", // "icnm"
                                                                     0x49442020: "id", // "ID\0x20\0x20"
                                                                     0x6967696e: "ignoresInput", // "igin"
                                                                     0x70696478: "index", // "pidx"
                                                                     0x696e7479: "inputTypes", // "inty"
                                                                     0x6b797764: "keywords", // "kywd"
                                                                     0x6b696e64: "kind", // "kind"
                                                                     0x69736d6e: "miniaturizable", // "ismn"
                                                                     0x706d6e64: "miniaturized", // "pmnd"
                                                                     0x706d6f64: "modal", // "pmod"
                                                                     0x696d6f64: "modified", // "imod"
                                                                     0x706e616d: "name", // "pnam"
                                                                     0x6f757479: "outputTypes", // "outy"
                                                                     0x6c776c61: "pagesAcross", // "lwla"
                                                                     0x6c776c64: "pagesDown", // "lwld"
                                                                     0x70776b66: "parentWorkflow", // "pwkf"
                                                                     0x70707468: "path", // "ppth"
                                                                     0x70414c4c: "properties", // "pALL"
                                                                     0x6c777174: "requestedPrintTime", // "lwqt"
                                                                     0x7072737a: "resizable", // "prsz"
                                                                     0x72737263: "resource", // "rsrc"
                                                                     0x7374626c: "settable", // "stbl"
                                                                     0x73687772: "showActionWhenRun", // "shwr"
                                                                     0x7074737a: "size", // "ptsz"
                                                                     0x6c776670: "startingPage", // "lwfp"
                                                                     0x74617070: "targetApplication", // "tapp"
                                                                     0x74727072: "targetPrinter", // "trpr"
                                                                     0x70746974: "titled", // "ptit"
                                                                     0x7076616c: "value", // "pval"
                                                                     0x76657273: "version", // "vers"
                                                                     0x70766973: "visible", // "pvis"
                                                                     0x77616374: "warningAction", // "wact"
                                                                     0x776c6576: "warningLevel", // "wlev"
                                                                     0x776d7367: "warningMessage", // "wmsg"
                                                                     0x69737a6d: "zoomable", // "iszm"
                                                                     0x707a756d: "zoomed", // "pzum"
                                                     ],
                                                     elementsNames: [
                                                                     0x63617070: ("application", "applications"), // "capp"
                                                                     0x61747473: ("attachment", "attachments"), // "atts"
                                                                     0x63617472: ("attribute run", "attributeRuns"), // "catr"
                                                                     0x6163747a: ("Automator action", "AutomatorActions"), // "actz"
                                                                     0x63686120: ("character", "characters"), // "cha\0x20"
                                                                     0x636f6c72: ("color", "colors"), // "colr"
                                                                     0x646f6375: ("document", "documents"), // "docu"
                                                                     0x636f626a: ("item", "items"), // "cobj"
                                                                     0x63706172: ("paragraph", "paragraphs"), // "cpar"
                                                                     0x70736574: ("print settings", "printSettings"), // "pset"
                                                                     0x72657172: ("required resource", "requiredResources"), // "reqr"
                                                                     0x73746e67: ("setting", "settings"), // "stng"
                                                                     0x63747874: ("text", "text"), // "ctxt"
                                                                     0x76617269: ("variable", "variables"), // "vari"
                                                                     0x6377696e: ("window", "windows"), // "cwin"
                                                                     0x63776f72: ("word", "words"), // "cwor"
                                                                     0x776b6677: ("workflow", "workflows"), // "wkfw"
                                                     ])

private let _glueClasses = SwiftAutomation.GlueClasses(insertionSpecifierType: AUTInsertion.self,
                                       objectSpecifierType: AUTItem.self,
                                       multiObjectSpecifierType: AUTItems.self,
                                       rootSpecifierType: AUTRoot.self,
                                       applicationType: Automator.self,
                                       symbolType: AUTSymbol.self,
                                       formatter: _specifierFormatter)

private let _untargetedAppData = SwiftAutomation.AppData(glueClasses: _glueClasses)


/******************************************************************************/
// Symbol subclass defines static type/enum/property constants based on Automator.app terminology

public class AUTSymbol: SwiftAutomation.Symbol {

    override public var typeAliasName: String {return "AUT"}

    public override class func symbol(code: OSType, type: OSType = typeType, descriptor: NSAppleEventDescriptor? = nil) -> AUTSymbol {
        switch (code) {
        case 0x616c6973: return self.alias // "alis"
        case 0x2a2a2a2a: return self.anything // "****"
        case 0x63617070: return self.application // "capp"
        case 0x62756e64: return self.applicationBundleID // "bund"
        case 0x7369676e: return self.applicationSignature // "sign"
        case 0x6170726c: return self.applicationURL // "aprl"
        case 0x61707220: return self.April // "apr\0x20"
        case 0x61736b20: return self.ask // "ask\0x20"
        case 0x61747473: return self.attachment // "atts"
        case 0x63617472: return self.attributeRun // "catr"
        case 0x61756720: return self.August // "aug\0x20"
        case 0x6163747a: return self.AutomatorAction // "actz"
        case 0x62657374: return self.best // "best"
        case 0x626d726b: return self.bookmarkData // "bmrk"
        case 0x626f6f6c: return self.boolean // "bool"
        case 0x71647274: return self.boundingRectangle // "qdrt"
        case 0x70626e64: return self.bounds // "pbnd"
        case 0x626e6964: return self.bundleId // "bnid"
        case 0x63617365: return self.case_ // "case"
        case 0x63746779: return self.category // "ctgy"
        case 0x63686120: return self.character // "cha\0x20"
        case 0x70636c73: return self.class_ // "pcls"
        case 0x68636c62: return self.closeable // "hclb"
        case 0x6c77636c: return self.collating // "lwcl"
        case 0x636f6c72: return self.color // "colr"
        case 0x636c7274: return self.colorTable // "clrt"
        case 0x636f6d74: return self.comment // "comt"
        case 0x656e756d: return self.constant // "enum"
        case 0x6c776370: return self.copies // "lwcp"
        case 0x63616374: return self.currentAction // "cact"
        case 0x74646173: return self.dashStyle // "tdas"
        case 0x74647461: return self.data // "tdta"
        case 0x6c647420: return self.date // "ldt\0x20"
        case 0x64656320: return self.December // "dec\0x20"
        case 0x6465636d: return self.decimalStruct // "decm"
        case 0x6476616c: return self.defaultValue // "dval"
        case 0x6c776474: return self.detailed // "lwdt"
        case 0x64696163: return self.diacriticals // "diac"
        case 0x646f6375: return self.document // "docu"
        case 0x636f6d70: return self.doubleInteger // "comp"
        case 0x656e6142: return self.enabled // "enaB"
        case 0x656e6373: return self.encodedString // "encs"
        case 0x6c776c70: return self.endingPage // "lwlp"
        case 0x45505320: return self.EPSPicture // "EPS\0x20"
        case 0x6c776568: return self.errorHandling // "lweh"
        case 0x7865726d: return self.executionErrorMessage // "xerm"
        case 0x7865726e: return self.executionErrorNumber // "xern"
        case 0x78696478: return self.executionId // "xidx"
        case 0x7872736c: return self.executionResult // "xrsl"
        case 0x65787061: return self.expansion // "expa"
        case 0x65787465: return self.extendedReal // "exte"
        case 0x6661786e: return self.faxNumber // "faxn"
        case 0x66656220: return self.February // "feb\0x20"
        case 0x6174666e: return self.fileName // "atfn"
        case 0x66737266: return self.fileRef // "fsrf"
        case 0x66737320: return self.fileSpecification // "fss\0x20"
        case 0x6675726c: return self.fileURL // "furl"
        case 0x66697864: return self.fixed // "fixd"
        case 0x66706e74: return self.fixedPoint // "fpnt"
        case 0x66726374: return self.fixedRectangle // "frct"
        case 0x6973666c: return self.floating // "isfl"
        case 0x666f6e74: return self.font // "font"
        case 0x66726920: return self.Friday // "fri\0x20"
        case 0x70697366: return self.frontmost // "pisf"
        case 0x47494666: return self.GIFPicture // "GIFf"
        case 0x63677478: return self.graphicText // "cgtx"
        case 0x68797068: return self.hyphens // "hyph"
        case 0x69636e6d: return self.iconName // "icnm"
        case 0x49442020: return self.id // "ID\0x20\0x20"
        case 0x6967696e: return self.ignoresInput // "igin"
        case 0x70696478: return self.index // "pidx"
        case 0x696e7479: return self.inputTypes // "inty"
        case 0x6c6f6e67: return self.integer // "long"
        case 0x69747874: return self.internationalText // "itxt"
        case 0x696e746c: return self.internationalWritingCode // "intl"
        case 0x69727276: return self.irreversible // "irrv"
        case 0x636f626a: return self.item // "cobj"
        case 0x6a616e20: return self.January // "jan\0x20"
        case 0x4a504547: return self.JPEGPicture // "JPEG"
        case 0x6a756c20: return self.July // "jul\0x20"
        case 0x6a756e20: return self.June // "jun\0x20"
        case 0x6b706964: return self.kernelProcessID // "kpid"
        case 0x6b797764: return self.keywords // "kywd"
        case 0x6b696e64: return self.kind // "kind"
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
        case 0x706e616d: return self.name // "pnam"
        case 0x6e6f2020: return self.no // "no\0x20\0x20"
        case 0x6e6f6e65: return self.none // "none"
        case 0x6e6f7620: return self.November // "nov\0x20"
        case 0x6e756c6c: return self.null // "null"
        case 0x6e756d65: return self.numericStrings // "nume"
        case 0x6f637420: return self.October // "oct\0x20"
        case 0x6f757479: return self.outputTypes // "outy"
        case 0x6c776c61: return self.pagesAcross // "lwla"
        case 0x6c776c64: return self.pagesDown // "lwld"
        case 0x63706172: return self.paragraph // "cpar"
        case 0x70776b66: return self.parentWorkflow // "pwkf"
        case 0x70707468: return self.path // "ppth"
        case 0x50494354: return self.PICTPicture // "PICT"
        case 0x74706d6d: return self.pixelMapRecord // "tpmm"
        case 0x51447074: return self.point // "QDpt"
        case 0x70736574: return self.printSettings // "pset"
        case 0x70736e20: return self.processSerialNumber // "psn\0x20"
        case 0x70414c4c: return self.properties // "pALL"
        case 0x70726f70: return self.property_ // "prop"
        case 0x70756e63: return self.punctuation // "punc"
        case 0x646f7562: return self.real // "doub"
        case 0x7265636f: return self.record // "reco"
        case 0x6f626a20: return self.reference // "obj\0x20"
        case 0x6c777174: return self.requestedPrintTime // "lwqt"
        case 0x72657172: return self.requiredResource // "reqr"
        case 0x7072737a: return self.resizable // "prsz"
        case 0x72737263: return self.resource // "rsrc"
        case 0x7276626c: return self.reversible // "rvbl"
        case 0x74723136: return self.RGB16Color // "tr16"
        case 0x74723936: return self.RGB96Color // "tr96"
        case 0x63524742: return self.RGBColor // "cRGB"
        case 0x74726f74: return self.rotation // "trot"
        case 0x73617420: return self.Saturday // "sat\0x20"
        case 0x73637074: return self.script // "scpt"
        case 0x73657020: return self.September // "sep\0x20"
        case 0x7374626c: return self.settable // "stbl"
        case 0x73746e67: return self.setting // "stng"
        case 0x73686f72: return self.shortInteger // "shor"
        case 0x73687772: return self.showActionWhenRun // "shwr"
        case 0x7074737a: return self.size // "ptsz"
        case 0x73696e67: return self.smallReal // "sing"
        case 0x6c777374: return self.standard // "lwst"
        case 0x6c776670: return self.startingPage // "lwfp"
        case 0x54455854: return self.string // "TEXT"
        case 0x7374796c: return self.styledClipboardText // "styl"
        case 0x53545854: return self.styledText // "STXT"
        case 0x73756e20: return self.Sunday // "sun\0x20"
        case 0x74617070: return self.targetApplication // "tapp"
        case 0x74727072: return self.targetPrinter // "trpr"
        case 0x63747874: return self.text // "ctxt"
        case 0x74737479: return self.textStyleInfo // "tsty"
        case 0x74687520: return self.Thursday // "thu\0x20"
        case 0x54494646: return self.TIFFPicture // "TIFF"
        case 0x70746974: return self.titled // "ptit"
        case 0x74756520: return self.Tuesday // "tue\0x20"
        case 0x74797065: return self.typeClass // "type"
        case 0x75747874: return self.UnicodeText // "utxt"
        case 0x75636f6d: return self.unsignedDoubleInteger // "ucom"
        case 0x6d61676e: return self.unsignedInteger // "magn"
        case 0x75736872: return self.unsignedShortInteger // "ushr"
        case 0x75743136: return self.UTF16Text // "ut16"
        case 0x75746638: return self.UTF8Text // "utf8"
        case 0x7076616c: return self.value // "pval"
        case 0x76617269: return self.variable // "vari"
        case 0x76657273: return self.version // "vers"
        case 0x70766973: return self.visible // "pvis"
        case 0x77616374: return self.warningAction // "wact"
        case 0x776c6576: return self.warningLevel // "wlev"
        case 0x776d7367: return self.warningMessage // "wmsg"
        case 0x77656420: return self.Wednesday // "wed\0x20"
        case 0x77686974: return self.whitespace // "whit"
        case 0x6377696e: return self.window // "cwin"
        case 0x63776f72: return self.word // "cwor"
        case 0x776b6677: return self.workflow // "wkfw"
        case 0x70736374: return self.writingCode // "psct"
        case 0x79657320: return self.yes // "yes\0x20"
        case 0x69737a6d: return self.zoomable // "iszm"
        case 0x707a756d: return self.zoomed // "pzum"
        default: return super.symbol(code: code, type: type, descriptor: descriptor) as! AUTSymbol
        }
    }

    // Types/properties
    public static let alias = AUTSymbol(name: "alias", code: 0x616c6973, type: typeType) // "alis"
    public static let anything = AUTSymbol(name: "anything", code: 0x2a2a2a2a, type: typeType) // "****"
    public static let application = AUTSymbol(name: "application", code: 0x63617070, type: typeType) // "capp"
    public static let applicationBundleID = AUTSymbol(name: "applicationBundleID", code: 0x62756e64, type: typeType) // "bund"
    public static let applicationSignature = AUTSymbol(name: "applicationSignature", code: 0x7369676e, type: typeType) // "sign"
    public static let applicationURL = AUTSymbol(name: "applicationURL", code: 0x6170726c, type: typeType) // "aprl"
    public static let April = AUTSymbol(name: "April", code: 0x61707220, type: typeType) // "apr\0x20"
    public static let attachment = AUTSymbol(name: "attachment", code: 0x61747473, type: typeType) // "atts"
    public static let attributeRun = AUTSymbol(name: "attributeRun", code: 0x63617472, type: typeType) // "catr"
    public static let August = AUTSymbol(name: "August", code: 0x61756720, type: typeType) // "aug\0x20"
    public static let AutomatorAction = AUTSymbol(name: "AutomatorAction", code: 0x6163747a, type: typeType) // "actz"
    public static let best = AUTSymbol(name: "best", code: 0x62657374, type: typeType) // "best"
    public static let bookmarkData = AUTSymbol(name: "bookmarkData", code: 0x626d726b, type: typeType) // "bmrk"
    public static let boolean = AUTSymbol(name: "boolean", code: 0x626f6f6c, type: typeType) // "bool"
    public static let boundingRectangle = AUTSymbol(name: "boundingRectangle", code: 0x71647274, type: typeType) // "qdrt"
    public static let bounds = AUTSymbol(name: "bounds", code: 0x70626e64, type: typeType) // "pbnd"
    public static let bundleId = AUTSymbol(name: "bundleId", code: 0x626e6964, type: typeType) // "bnid"
    public static let category = AUTSymbol(name: "category", code: 0x63746779, type: typeType) // "ctgy"
    public static let character = AUTSymbol(name: "character", code: 0x63686120, type: typeType) // "cha\0x20"
    public static let class_ = AUTSymbol(name: "class_", code: 0x70636c73, type: typeType) // "pcls"
    public static let closeable = AUTSymbol(name: "closeable", code: 0x68636c62, type: typeType) // "hclb"
    public static let collating = AUTSymbol(name: "collating", code: 0x6c77636c, type: typeType) // "lwcl"
    public static let color = AUTSymbol(name: "color", code: 0x636f6c72, type: typeType) // "colr"
    public static let colorTable = AUTSymbol(name: "colorTable", code: 0x636c7274, type: typeType) // "clrt"
    public static let comment = AUTSymbol(name: "comment", code: 0x636f6d74, type: typeType) // "comt"
    public static let constant = AUTSymbol(name: "constant", code: 0x656e756d, type: typeType) // "enum"
    public static let copies = AUTSymbol(name: "copies", code: 0x6c776370, type: typeType) // "lwcp"
    public static let currentAction = AUTSymbol(name: "currentAction", code: 0x63616374, type: typeType) // "cact"
    public static let dashStyle = AUTSymbol(name: "dashStyle", code: 0x74646173, type: typeType) // "tdas"
    public static let data = AUTSymbol(name: "data", code: 0x74647461, type: typeType) // "tdta"
    public static let date = AUTSymbol(name: "date", code: 0x6c647420, type: typeType) // "ldt\0x20"
    public static let December = AUTSymbol(name: "December", code: 0x64656320, type: typeType) // "dec\0x20"
    public static let decimalStruct = AUTSymbol(name: "decimalStruct", code: 0x6465636d, type: typeType) // "decm"
    public static let defaultValue = AUTSymbol(name: "defaultValue", code: 0x6476616c, type: typeType) // "dval"
    public static let document = AUTSymbol(name: "document", code: 0x646f6375, type: typeType) // "docu"
    public static let doubleInteger = AUTSymbol(name: "doubleInteger", code: 0x636f6d70, type: typeType) // "comp"
    public static let enabled = AUTSymbol(name: "enabled", code: 0x656e6142, type: typeType) // "enaB"
    public static let encodedString = AUTSymbol(name: "encodedString", code: 0x656e6373, type: typeType) // "encs"
    public static let endingPage = AUTSymbol(name: "endingPage", code: 0x6c776c70, type: typeType) // "lwlp"
    public static let EPSPicture = AUTSymbol(name: "EPSPicture", code: 0x45505320, type: typeType) // "EPS\0x20"
    public static let errorHandling = AUTSymbol(name: "errorHandling", code: 0x6c776568, type: typeType) // "lweh"
    public static let executionErrorMessage = AUTSymbol(name: "executionErrorMessage", code: 0x7865726d, type: typeType) // "xerm"
    public static let executionErrorNumber = AUTSymbol(name: "executionErrorNumber", code: 0x7865726e, type: typeType) // "xern"
    public static let executionId = AUTSymbol(name: "executionId", code: 0x78696478, type: typeType) // "xidx"
    public static let executionResult = AUTSymbol(name: "executionResult", code: 0x7872736c, type: typeType) // "xrsl"
    public static let extendedReal = AUTSymbol(name: "extendedReal", code: 0x65787465, type: typeType) // "exte"
    public static let faxNumber = AUTSymbol(name: "faxNumber", code: 0x6661786e, type: typeType) // "faxn"
    public static let February = AUTSymbol(name: "February", code: 0x66656220, type: typeType) // "feb\0x20"
    public static let fileName = AUTSymbol(name: "fileName", code: 0x6174666e, type: typeType) // "atfn"
    public static let fileRef = AUTSymbol(name: "fileRef", code: 0x66737266, type: typeType) // "fsrf"
    public static let fileSpecification = AUTSymbol(name: "fileSpecification", code: 0x66737320, type: typeType) // "fss\0x20"
    public static let fileURL = AUTSymbol(name: "fileURL", code: 0x6675726c, type: typeType) // "furl"
    public static let fixed = AUTSymbol(name: "fixed", code: 0x66697864, type: typeType) // "fixd"
    public static let fixedPoint = AUTSymbol(name: "fixedPoint", code: 0x66706e74, type: typeType) // "fpnt"
    public static let fixedRectangle = AUTSymbol(name: "fixedRectangle", code: 0x66726374, type: typeType) // "frct"
    public static let floating = AUTSymbol(name: "floating", code: 0x6973666c, type: typeType) // "isfl"
    public static let font = AUTSymbol(name: "font", code: 0x666f6e74, type: typeType) // "font"
    public static let Friday = AUTSymbol(name: "Friday", code: 0x66726920, type: typeType) // "fri\0x20"
    public static let frontmost = AUTSymbol(name: "frontmost", code: 0x70697366, type: typeType) // "pisf"
    public static let GIFPicture = AUTSymbol(name: "GIFPicture", code: 0x47494666, type: typeType) // "GIFf"
    public static let graphicText = AUTSymbol(name: "graphicText", code: 0x63677478, type: typeType) // "cgtx"
    public static let iconName = AUTSymbol(name: "iconName", code: 0x69636e6d, type: typeType) // "icnm"
    public static let id = AUTSymbol(name: "id", code: 0x49442020, type: typeType) // "ID\0x20\0x20"
    public static let ignoresInput = AUTSymbol(name: "ignoresInput", code: 0x6967696e, type: typeType) // "igin"
    public static let index = AUTSymbol(name: "index", code: 0x70696478, type: typeType) // "pidx"
    public static let inputTypes = AUTSymbol(name: "inputTypes", code: 0x696e7479, type: typeType) // "inty"
    public static let integer = AUTSymbol(name: "integer", code: 0x6c6f6e67, type: typeType) // "long"
    public static let internationalText = AUTSymbol(name: "internationalText", code: 0x69747874, type: typeType) // "itxt"
    public static let internationalWritingCode = AUTSymbol(name: "internationalWritingCode", code: 0x696e746c, type: typeType) // "intl"
    public static let item = AUTSymbol(name: "item", code: 0x636f626a, type: typeType) // "cobj"
    public static let January = AUTSymbol(name: "January", code: 0x6a616e20, type: typeType) // "jan\0x20"
    public static let JPEGPicture = AUTSymbol(name: "JPEGPicture", code: 0x4a504547, type: typeType) // "JPEG"
    public static let July = AUTSymbol(name: "July", code: 0x6a756c20, type: typeType) // "jul\0x20"
    public static let June = AUTSymbol(name: "June", code: 0x6a756e20, type: typeType) // "jun\0x20"
    public static let kernelProcessID = AUTSymbol(name: "kernelProcessID", code: 0x6b706964, type: typeType) // "kpid"
    public static let keywords = AUTSymbol(name: "keywords", code: 0x6b797764, type: typeType) // "kywd"
    public static let kind = AUTSymbol(name: "kind", code: 0x6b696e64, type: typeType) // "kind"
    public static let largeReal = AUTSymbol(name: "largeReal", code: 0x6c64626c, type: typeType) // "ldbl"
    public static let list = AUTSymbol(name: "list", code: 0x6c697374, type: typeType) // "list"
    public static let locationReference = AUTSymbol(name: "locationReference", code: 0x696e736c, type: typeType) // "insl"
    public static let longFixed = AUTSymbol(name: "longFixed", code: 0x6c667864, type: typeType) // "lfxd"
    public static let longFixedPoint = AUTSymbol(name: "longFixedPoint", code: 0x6c667074, type: typeType) // "lfpt"
    public static let longFixedRectangle = AUTSymbol(name: "longFixedRectangle", code: 0x6c667263, type: typeType) // "lfrc"
    public static let longPoint = AUTSymbol(name: "longPoint", code: 0x6c706e74, type: typeType) // "lpnt"
    public static let longRectangle = AUTSymbol(name: "longRectangle", code: 0x6c726374, type: typeType) // "lrct"
    public static let machine = AUTSymbol(name: "machine", code: 0x6d616368, type: typeType) // "mach"
    public static let machineLocation = AUTSymbol(name: "machineLocation", code: 0x6d4c6f63, type: typeType) // "mLoc"
    public static let machPort = AUTSymbol(name: "machPort", code: 0x706f7274, type: typeType) // "port"
    public static let March = AUTSymbol(name: "March", code: 0x6d617220, type: typeType) // "mar\0x20"
    public static let May = AUTSymbol(name: "May", code: 0x6d617920, type: typeType) // "may\0x20"
    public static let miniaturizable = AUTSymbol(name: "miniaturizable", code: 0x69736d6e, type: typeType) // "ismn"
    public static let miniaturized = AUTSymbol(name: "miniaturized", code: 0x706d6e64, type: typeType) // "pmnd"
    public static let modal = AUTSymbol(name: "modal", code: 0x706d6f64, type: typeType) // "pmod"
    public static let modified = AUTSymbol(name: "modified", code: 0x696d6f64, type: typeType) // "imod"
    public static let Monday = AUTSymbol(name: "Monday", code: 0x6d6f6e20, type: typeType) // "mon\0x20"
    public static let name = AUTSymbol(name: "name", code: 0x706e616d, type: typeType) // "pnam"
    public static let November = AUTSymbol(name: "November", code: 0x6e6f7620, type: typeType) // "nov\0x20"
    public static let null = AUTSymbol(name: "null", code: 0x6e756c6c, type: typeType) // "null"
    public static let October = AUTSymbol(name: "October", code: 0x6f637420, type: typeType) // "oct\0x20"
    public static let outputTypes = AUTSymbol(name: "outputTypes", code: 0x6f757479, type: typeType) // "outy"
    public static let pagesAcross = AUTSymbol(name: "pagesAcross", code: 0x6c776c61, type: typeType) // "lwla"
    public static let pagesDown = AUTSymbol(name: "pagesDown", code: 0x6c776c64, type: typeType) // "lwld"
    public static let paragraph = AUTSymbol(name: "paragraph", code: 0x63706172, type: typeType) // "cpar"
    public static let parentWorkflow = AUTSymbol(name: "parentWorkflow", code: 0x70776b66, type: typeType) // "pwkf"
    public static let path = AUTSymbol(name: "path", code: 0x70707468, type: typeType) // "ppth"
    public static let PICTPicture = AUTSymbol(name: "PICTPicture", code: 0x50494354, type: typeType) // "PICT"
    public static let pixelMapRecord = AUTSymbol(name: "pixelMapRecord", code: 0x74706d6d, type: typeType) // "tpmm"
    public static let point = AUTSymbol(name: "point", code: 0x51447074, type: typeType) // "QDpt"
    public static let printSettings = AUTSymbol(name: "printSettings", code: 0x70736574, type: typeType) // "pset"
    public static let processSerialNumber = AUTSymbol(name: "processSerialNumber", code: 0x70736e20, type: typeType) // "psn\0x20"
    public static let properties = AUTSymbol(name: "properties", code: 0x70414c4c, type: typeType) // "pALL"
    public static let property_ = AUTSymbol(name: "property_", code: 0x70726f70, type: typeType) // "prop"
    public static let real = AUTSymbol(name: "real", code: 0x646f7562, type: typeType) // "doub"
    public static let record = AUTSymbol(name: "record", code: 0x7265636f, type: typeType) // "reco"
    public static let reference = AUTSymbol(name: "reference", code: 0x6f626a20, type: typeType) // "obj\0x20"
    public static let requestedPrintTime = AUTSymbol(name: "requestedPrintTime", code: 0x6c777174, type: typeType) // "lwqt"
    public static let requiredResource = AUTSymbol(name: "requiredResource", code: 0x72657172, type: typeType) // "reqr"
    public static let resizable = AUTSymbol(name: "resizable", code: 0x7072737a, type: typeType) // "prsz"
    public static let resource = AUTSymbol(name: "resource", code: 0x72737263, type: typeType) // "rsrc"
    public static let RGB16Color = AUTSymbol(name: "RGB16Color", code: 0x74723136, type: typeType) // "tr16"
    public static let RGB96Color = AUTSymbol(name: "RGB96Color", code: 0x74723936, type: typeType) // "tr96"
    public static let RGBColor = AUTSymbol(name: "RGBColor", code: 0x63524742, type: typeType) // "cRGB"
    public static let rotation = AUTSymbol(name: "rotation", code: 0x74726f74, type: typeType) // "trot"
    public static let Saturday = AUTSymbol(name: "Saturday", code: 0x73617420, type: typeType) // "sat\0x20"
    public static let script = AUTSymbol(name: "script", code: 0x73637074, type: typeType) // "scpt"
    public static let September = AUTSymbol(name: "September", code: 0x73657020, type: typeType) // "sep\0x20"
    public static let settable = AUTSymbol(name: "settable", code: 0x7374626c, type: typeType) // "stbl"
    public static let setting = AUTSymbol(name: "setting", code: 0x73746e67, type: typeType) // "stng"
    public static let shortInteger = AUTSymbol(name: "shortInteger", code: 0x73686f72, type: typeType) // "shor"
    public static let showActionWhenRun = AUTSymbol(name: "showActionWhenRun", code: 0x73687772, type: typeType) // "shwr"
    public static let size = AUTSymbol(name: "size", code: 0x7074737a, type: typeType) // "ptsz"
    public static let smallReal = AUTSymbol(name: "smallReal", code: 0x73696e67, type: typeType) // "sing"
    public static let startingPage = AUTSymbol(name: "startingPage", code: 0x6c776670, type: typeType) // "lwfp"
    public static let string = AUTSymbol(name: "string", code: 0x54455854, type: typeType) // "TEXT"
    public static let styledClipboardText = AUTSymbol(name: "styledClipboardText", code: 0x7374796c, type: typeType) // "styl"
    public static let styledText = AUTSymbol(name: "styledText", code: 0x53545854, type: typeType) // "STXT"
    public static let Sunday = AUTSymbol(name: "Sunday", code: 0x73756e20, type: typeType) // "sun\0x20"
    public static let targetApplication = AUTSymbol(name: "targetApplication", code: 0x74617070, type: typeType) // "tapp"
    public static let targetPrinter = AUTSymbol(name: "targetPrinter", code: 0x74727072, type: typeType) // "trpr"
    public static let text = AUTSymbol(name: "text", code: 0x63747874, type: typeType) // "ctxt"
    public static let textStyleInfo = AUTSymbol(name: "textStyleInfo", code: 0x74737479, type: typeType) // "tsty"
    public static let Thursday = AUTSymbol(name: "Thursday", code: 0x74687520, type: typeType) // "thu\0x20"
    public static let TIFFPicture = AUTSymbol(name: "TIFFPicture", code: 0x54494646, type: typeType) // "TIFF"
    public static let titled = AUTSymbol(name: "titled", code: 0x70746974, type: typeType) // "ptit"
    public static let Tuesday = AUTSymbol(name: "Tuesday", code: 0x74756520, type: typeType) // "tue\0x20"
    public static let typeClass = AUTSymbol(name: "typeClass", code: 0x74797065, type: typeType) // "type"
    public static let UnicodeText = AUTSymbol(name: "UnicodeText", code: 0x75747874, type: typeType) // "utxt"
    public static let unsignedDoubleInteger = AUTSymbol(name: "unsignedDoubleInteger", code: 0x75636f6d, type: typeType) // "ucom"
    public static let unsignedInteger = AUTSymbol(name: "unsignedInteger", code: 0x6d61676e, type: typeType) // "magn"
    public static let unsignedShortInteger = AUTSymbol(name: "unsignedShortInteger", code: 0x75736872, type: typeType) // "ushr"
    public static let UTF16Text = AUTSymbol(name: "UTF16Text", code: 0x75743136, type: typeType) // "ut16"
    public static let UTF8Text = AUTSymbol(name: "UTF8Text", code: 0x75746638, type: typeType) // "utf8"
    public static let value = AUTSymbol(name: "value", code: 0x7076616c, type: typeType) // "pval"
    public static let variable = AUTSymbol(name: "variable", code: 0x76617269, type: typeType) // "vari"
    public static let version = AUTSymbol(name: "version", code: 0x76657273, type: typeType) // "vers"
    public static let visible = AUTSymbol(name: "visible", code: 0x70766973, type: typeType) // "pvis"
    public static let warningAction = AUTSymbol(name: "warningAction", code: 0x77616374, type: typeType) // "wact"
    public static let warningLevel = AUTSymbol(name: "warningLevel", code: 0x776c6576, type: typeType) // "wlev"
    public static let warningMessage = AUTSymbol(name: "warningMessage", code: 0x776d7367, type: typeType) // "wmsg"
    public static let Wednesday = AUTSymbol(name: "Wednesday", code: 0x77656420, type: typeType) // "wed\0x20"
    public static let window = AUTSymbol(name: "window", code: 0x6377696e, type: typeType) // "cwin"
    public static let word = AUTSymbol(name: "word", code: 0x63776f72, type: typeType) // "cwor"
    public static let workflow = AUTSymbol(name: "workflow", code: 0x776b6677, type: typeType) // "wkfw"
    public static let writingCode = AUTSymbol(name: "writingCode", code: 0x70736374, type: typeType) // "psct"
    public static let zoomable = AUTSymbol(name: "zoomable", code: 0x69737a6d, type: typeType) // "iszm"
    public static let zoomed = AUTSymbol(name: "zoomed", code: 0x707a756d, type: typeType) // "pzum"

    // Enumerators
    public static let ask = AUTSymbol(name: "ask", code: 0x61736b20, type: typeEnumerated) // "ask\0x20"
    public static let case_ = AUTSymbol(name: "case_", code: 0x63617365, type: typeEnumerated) // "case"
    public static let detailed = AUTSymbol(name: "detailed", code: 0x6c776474, type: typeEnumerated) // "lwdt"
    public static let diacriticals = AUTSymbol(name: "diacriticals", code: 0x64696163, type: typeEnumerated) // "diac"
    public static let expansion = AUTSymbol(name: "expansion", code: 0x65787061, type: typeEnumerated) // "expa"
    public static let hyphens = AUTSymbol(name: "hyphens", code: 0x68797068, type: typeEnumerated) // "hyph"
    public static let irreversible = AUTSymbol(name: "irreversible", code: 0x69727276, type: typeEnumerated) // "irrv"
    public static let no = AUTSymbol(name: "no", code: 0x6e6f2020, type: typeEnumerated) // "no\0x20\0x20"
    public static let none = AUTSymbol(name: "none", code: 0x6e6f6e65, type: typeEnumerated) // "none"
    public static let numericStrings = AUTSymbol(name: "numericStrings", code: 0x6e756d65, type: typeEnumerated) // "nume"
    public static let punctuation = AUTSymbol(name: "punctuation", code: 0x70756e63, type: typeEnumerated) // "punc"
    public static let reversible = AUTSymbol(name: "reversible", code: 0x7276626c, type: typeEnumerated) // "rvbl"
    public static let standard = AUTSymbol(name: "standard", code: 0x6c777374, type: typeEnumerated) // "lwst"
    public static let whitespace = AUTSymbol(name: "whitespace", code: 0x77686974, type: typeEnumerated) // "whit"
    public static let yes = AUTSymbol(name: "yes", code: 0x79657320, type: typeEnumerated) // "yes\0x20"
}

public typealias AUT = AUTSymbol // allows symbols to be written as (e.g.) AUT.name instead of AUTSymbol.name


/******************************************************************************/
// Specifier extensions; these add command methods and property/elements getters based on Automator.app terminology

public protocol AUTCommand: SwiftAutomation.SpecifierProtocol {} // provides AE dispatch methods

// Command->Any will be bound when return type can't be inferred, else Command->T

extension AUTCommand {
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
            atIndex: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "add", eventClass: 0x6f74746f, eventID: 0x61646420, // "otto"/"add\0x20"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x696e7368, to), // "insh"
                    ("atIndex", 0x61742049, atIndex), // "at\0x20I"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func add<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            to: Any = SwiftAutomation.NoParameter,
            atIndex: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "add", eventClass: 0x6f74746f, eventID: 0x61646420, // "otto"/"add\0x20"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x696e7368, to), // "insh"
                    ("atIndex", 0x61742049, atIndex), // "at\0x20I"
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
    @discardableResult public func execute(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "execute", eventClass: 0x6f74746f, eventID: 0x65786563, // "otto"/"exec"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func execute<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "execute", eventClass: 0x6f74746f, eventID: 0x65786563, // "otto"/"exec"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
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
            printDialog: Any = SwiftAutomation.NoParameter,
            withProperties: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "print", eventClass: 0x61657674, eventID: 0x70646f63, // "aevt"/"pdoc"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("printDialog", 0x70646c67, printDialog), // "pdlg"
                    ("withProperties", 0x70726474, withProperties), // "prdt"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func print<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            printDialog: Any = SwiftAutomation.NoParameter,
            withProperties: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "print", eventClass: 0x61657674, eventID: 0x70646f63, // "aevt"/"pdoc"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("printDialog", 0x70646c67, printDialog), // "pdlg"
                    ("withProperties", 0x70726474, withProperties), // "prdt"
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
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "remove", eventClass: 0x6f74746f, eventID: 0x72656d76, // "otto"/"remv"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func remove<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "remove", eventClass: 0x6f74746f, eventID: 0x72656d76, // "otto"/"remv"
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
            as_: Any = SwiftAutomation.NoParameter,
            in_: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "save", eventClass: 0x636f7265, eventID: 0x73617665, // "core"/"save"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("as_", 0x666c7470, as_), // "fltp"
                    ("in_", 0x6b66696c, in_), // "kfil"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func save<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            as_: Any = SwiftAutomation.NoParameter,
            in_: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "save", eventClass: 0x636f7265, eventID: 0x73617665, // "core"/"save"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("as_", 0x666c7470, as_), // "fltp"
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


public protocol AUTObject: SwiftAutomation.ObjectSpecifierExtension, AUTCommand {} // provides vars and methods for constructing specifiers

extension AUTObject {
    
    // Properties
    public var bounds: AUTItem {return self.property(0x70626e64) as! AUTItem} // "pbnd"
    public var bundleId: AUTItem {return self.property(0x626e6964) as! AUTItem} // "bnid"
    public var category: AUTItem {return self.property(0x63746779) as! AUTItem} // "ctgy"
    public var class_: AUTItem {return self.property(0x70636c73) as! AUTItem} // "pcls"
    public var closeable: AUTItem {return self.property(0x68636c62) as! AUTItem} // "hclb"
    public var collating: AUTItem {return self.property(0x6c77636c) as! AUTItem} // "lwcl"
    public var color: AUTItem {return self.property(0x636f6c72) as! AUTItem} // "colr"
    public var comment: AUTItem {return self.property(0x636f6d74) as! AUTItem} // "comt"
    public var copies: AUTItem {return self.property(0x6c776370) as! AUTItem} // "lwcp"
    public var currentAction: AUTItem {return self.property(0x63616374) as! AUTItem} // "cact"
    public var defaultValue: AUTItem {return self.property(0x6476616c) as! AUTItem} // "dval"
    public var document: AUTItem {return self.property(0x646f6375) as! AUTItem} // "docu"
    public var enabled: AUTItem {return self.property(0x656e6142) as! AUTItem} // "enaB"
    public var endingPage: AUTItem {return self.property(0x6c776c70) as! AUTItem} // "lwlp"
    public var errorHandling: AUTItem {return self.property(0x6c776568) as! AUTItem} // "lweh"
    public var executionErrorMessage: AUTItem {return self.property(0x7865726d) as! AUTItem} // "xerm"
    public var executionErrorNumber: AUTItem {return self.property(0x7865726e) as! AUTItem} // "xern"
    public var executionId: AUTItem {return self.property(0x78696478) as! AUTItem} // "xidx"
    public var executionResult: AUTItem {return self.property(0x7872736c) as! AUTItem} // "xrsl"
    public var faxNumber: AUTItem {return self.property(0x6661786e) as! AUTItem} // "faxn"
    public var fileName: AUTItem {return self.property(0x6174666e) as! AUTItem} // "atfn"
    public var floating: AUTItem {return self.property(0x6973666c) as! AUTItem} // "isfl"
    public var font: AUTItem {return self.property(0x666f6e74) as! AUTItem} // "font"
    public var frontmost: AUTItem {return self.property(0x70697366) as! AUTItem} // "pisf"
    public var iconName: AUTItem {return self.property(0x69636e6d) as! AUTItem} // "icnm"
    public var id: AUTItem {return self.property(0x49442020) as! AUTItem} // "ID\0x20\0x20"
    public var ignoresInput: AUTItem {return self.property(0x6967696e) as! AUTItem} // "igin"
    public var index: AUTItem {return self.property(0x70696478) as! AUTItem} // "pidx"
    public var inputTypes: AUTItem {return self.property(0x696e7479) as! AUTItem} // "inty"
    public var keywords: AUTItem {return self.property(0x6b797764) as! AUTItem} // "kywd"
    public var kind: AUTItem {return self.property(0x6b696e64) as! AUTItem} // "kind"
    public var miniaturizable: AUTItem {return self.property(0x69736d6e) as! AUTItem} // "ismn"
    public var miniaturized: AUTItem {return self.property(0x706d6e64) as! AUTItem} // "pmnd"
    public var modal: AUTItem {return self.property(0x706d6f64) as! AUTItem} // "pmod"
    public var modified: AUTItem {return self.property(0x696d6f64) as! AUTItem} // "imod"
    public var name: AUTItem {return self.property(0x706e616d) as! AUTItem} // "pnam"
    public var outputTypes: AUTItem {return self.property(0x6f757479) as! AUTItem} // "outy"
    public var pagesAcross: AUTItem {return self.property(0x6c776c61) as! AUTItem} // "lwla"
    public var pagesDown: AUTItem {return self.property(0x6c776c64) as! AUTItem} // "lwld"
    public var parentWorkflow: AUTItem {return self.property(0x70776b66) as! AUTItem} // "pwkf"
    public var path: AUTItem {return self.property(0x70707468) as! AUTItem} // "ppth"
    public var properties: AUTItem {return self.property(0x70414c4c) as! AUTItem} // "pALL"
    public var requestedPrintTime: AUTItem {return self.property(0x6c777174) as! AUTItem} // "lwqt"
    public var resizable: AUTItem {return self.property(0x7072737a) as! AUTItem} // "prsz"
    public var resource: AUTItem {return self.property(0x72737263) as! AUTItem} // "rsrc"
    public var settable: AUTItem {return self.property(0x7374626c) as! AUTItem} // "stbl"
    public var showActionWhenRun: AUTItem {return self.property(0x73687772) as! AUTItem} // "shwr"
    public var size: AUTItem {return self.property(0x7074737a) as! AUTItem} // "ptsz"
    public var startingPage: AUTItem {return self.property(0x6c776670) as! AUTItem} // "lwfp"
    public var targetApplication: AUTItem {return self.property(0x74617070) as! AUTItem} // "tapp"
    public var targetPrinter: AUTItem {return self.property(0x74727072) as! AUTItem} // "trpr"
    public var titled: AUTItem {return self.property(0x70746974) as! AUTItem} // "ptit"
    public var value: AUTItem {return self.property(0x7076616c) as! AUTItem} // "pval"
    public var version: AUTItem {return self.property(0x76657273) as! AUTItem} // "vers"
    public var visible: AUTItem {return self.property(0x70766973) as! AUTItem} // "pvis"
    public var warningAction: AUTItem {return self.property(0x77616374) as! AUTItem} // "wact"
    public var warningLevel: AUTItem {return self.property(0x776c6576) as! AUTItem} // "wlev"
    public var warningMessage: AUTItem {return self.property(0x776d7367) as! AUTItem} // "wmsg"
    public var zoomable: AUTItem {return self.property(0x69737a6d) as! AUTItem} // "iszm"
    public var zoomed: AUTItem {return self.property(0x707a756d) as! AUTItem} // "pzum"

    // Elements
    public var applications: AUTItems {return self.elements(0x63617070) as! AUTItems} // "capp"
    public var attachments: AUTItems {return self.elements(0x61747473) as! AUTItems} // "atts"
    public var attributeRuns: AUTItems {return self.elements(0x63617472) as! AUTItems} // "catr"
    public var AutomatorActions: AUTItems {return self.elements(0x6163747a) as! AUTItems} // "actz"
    public var characters: AUTItems {return self.elements(0x63686120) as! AUTItems} // "cha\0x20"
    public var colors: AUTItems {return self.elements(0x636f6c72) as! AUTItems} // "colr"
    public var documents: AUTItems {return self.elements(0x646f6375) as! AUTItems} // "docu"
    public var items: AUTItems {return self.elements(0x636f626a) as! AUTItems} // "cobj"
    public var paragraphs: AUTItems {return self.elements(0x63706172) as! AUTItems} // "cpar"
    public var printSettings: AUTItems {return self.elements(0x70736574) as! AUTItems} // "pset"
    public var requiredResources: AUTItems {return self.elements(0x72657172) as! AUTItems} // "reqr"
    public var settings: AUTItems {return self.elements(0x73746e67) as! AUTItems} // "stng"
    public var text: AUTItems {return self.elements(0x63747874) as! AUTItems} // "ctxt"
    public var variables: AUTItems {return self.elements(0x76617269) as! AUTItems} // "vari"
    public var windows: AUTItems {return self.elements(0x6377696e) as! AUTItems} // "cwin"
    public var words: AUTItems {return self.elements(0x63776f72) as! AUTItems} // "cwor"
    public var workflows: AUTItems {return self.elements(0x776b6677) as! AUTItems} // "wkfw"
}


/******************************************************************************/
// Specifier subclasses add app-specific extensions

// beginning/end/before/after
public class AUTInsertion: SwiftAutomation.InsertionSpecifier, AUTCommand {}


// property/by-index/by-name/by-id/previous/next/first/middle/last/any
public class AUTItem: SwiftAutomation.ObjectSpecifier, AUTObject {
    public typealias InsertionSpecifierType = AUTInsertion
    public typealias ObjectSpecifierType = AUTItem
    public typealias MultipleObjectSpecifierType = AUTItems
}

// by-range/by-test/all
public class AUTItems: AUTItem, SwiftAutomation.MultipleObjectSpecifierExtension {}

// App/Con/Its
public class AUTRoot: SwiftAutomation.RootSpecifier, AUTObject, SwiftAutomation.RootSpecifierExtension {
    public typealias InsertionSpecifierType = AUTInsertion
    public typealias ObjectSpecifierType = AUTItem
    public typealias MultipleObjectSpecifierType = AUTItems
    public override class var untargetedAppData: SwiftAutomation.AppData { return _untargetedAppData }
}

// Application
public class Automator: AUTRoot, SwiftAutomation.Application {
    public convenience init(launchOptions: SwiftAutomation.LaunchOptions = SwiftAutomation.DefaultLaunchOptions, relaunchMode: SwiftAutomation.RelaunchMode = SwiftAutomation.DefaultRelaunchMode) {
        self.init(rootObject: SwiftAutomation.AppRootDesc, appData: Swift.type(of:self).untargetedAppData.targetedCopy(
                  .bundleIdentifier("com.apple.Automator", true), launchOptions: launchOptions, relaunchMode: relaunchMode))
    }
}

// App/Con/Its root objects used to construct untargeted specifiers; these can be used to construct specifiers for use in commands, though cannot send commands themselves

public let AUTApp = _untargetedAppData.app as! AUTRoot
public let AUTCon = _untargetedAppData.con as! AUTRoot
public let AUTIts = _untargetedAppData.its as! AUTRoot


/******************************************************************************/
// Static types

public typealias AUTRecord = [AUTSymbol:Any] // default Swift type for AERecordDescs







