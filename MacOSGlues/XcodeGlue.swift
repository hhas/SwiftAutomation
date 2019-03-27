//
//  XcodeGlue.swift
//  Xcode.app 10.2
//  SwiftAutomation.framework 0.1.0
//  `aeglue -S 'Xcode.app'`
//


import Foundation
import SwiftAutomation


/******************************************************************************/
// Create an untargeted AppData instance for use in App, Con, Its roots,
// and in Application initializers to create targeted AppData instances.

private let _specifierFormatter = SwiftAutomation.SpecifierFormatter(applicationClassName: "Xcode",
                                                     classNamePrefix: "XCO",
                                                     typeNames: [
                                                                     0x61727564: "activeRunDestination", // "arud"
                                                                     0x6172756e: "activeScheme", // "arun"
                                                                     0x61776b73: "activeWorkspaceDocument", // "awks"
                                                                     0x616c6973: "alias", // "alis"
                                                                     0x73616169: "analyzerIssue", // "saai"
                                                                     0x2a2a2a2a: "anything", // "****"
                                                                     0x63617070: "application", // "capp"
                                                                     0x62756e64: "applicationBundleID", // "bund"
                                                                     0x7369676e: "applicationSignature", // "sign"
                                                                     0x6170726c: "applicationURL", // "aprl"
                                                                     0x61707220: "April", // "apr\0x20"
                                                                     0x61726368: "architecture", // "arch"
                                                                     0x61736b20: "ask", // "ask\0x20"
                                                                     0x61756720: "August", // "aug\0x20"
                                                                     0x62657374: "best", // "best"
                                                                     0x626d726b: "bookmarkData", // "bmrk"
                                                                     0x626f6f6c: "boolean", // "bool"
                                                                     0x71647274: "boundingRectangle", // "qdrt"
                                                                     0x70626e64: "bounds", // "pbnd"
                                                                     0x62756366: "buildConfiguration", // "bucf"
                                                                     0x73616265: "buildError", // "sabe"
                                                                     0x626c6f67: "buildLog", // "blog"
                                                                     0x61736273: "buildSetting", // "asbs"
                                                                     0x73616277: "buildWarning", // "sabw"
                                                                     0x73727363: "cancelled", // "srsc"
                                                                     0x63617365: "case_", // "case"
                                                                     0x70636c73: "class_", // "pcls"
                                                                     0x68636c62: "closeable", // "hclb"
                                                                     0x636c7274: "colorTable", // "clrt"
                                                                     0x63646576: "companionDevice", // "cdev"
                                                                     0x73617263: "completed", // "sarc"
                                                                     0x656e756d: "constant", // "enum"
                                                                     0x74646173: "dashStyle", // "tdas"
                                                                     0x74647461: "data", // "tdta"
                                                                     0x6c647420: "date", // "ldt\0x20"
                                                                     0x64656320: "December", // "dec\0x20"
                                                                     0x6465636d: "decimalStruct", // "decm"
                                                                     0x64657663: "device", // "devc"
                                                                     0x72646576: "device", // "rdev"
                                                                     0x64766964: "deviceIdentifier", // "dvid"
                                                                     0x64767479: "deviceModel", // "dvty"
                                                                     0x64696163: "diacriticals", // "diac"
                                                                     0x646f6375: "document", // "docu"
                                                                     0x636f6d70: "doubleInteger", // "comp"
                                                                     0x656e6373: "encodedString", // "encs"
                                                                     0x73616563: "endingColumnNumber", // "saec"
                                                                     0x7361656c: "endingLineNumber", // "sael"
                                                                     0x656e7672: "environmentVariable", // "envr"
                                                                     0x45505320: "EPSPicture", // "EPS\0x20"
                                                                     0x73617265: "errorMessage", // "sare"
                                                                     0x73727365: "errorOccurred", // "srse"
                                                                     0x65787061: "expansion", // "expa"
                                                                     0x65787465: "extendedReal", // "exte"
                                                                     0x73727366: "failed", // "srsf"
                                                                     0x66656220: "February", // "feb\0x20"
                                                                     0x66696c65: "file", // "file"
                                                                     0x66696c64: "fileDocument", // "fild"
                                                                     0x73616670: "filePath", // "safp"
                                                                     0x66737266: "fileRef", // "fsrf"
                                                                     0x66737320: "fileSpecification", // "fss\0x20"
                                                                     0x6675726c: "fileURL", // "furl"
                                                                     0x66697864: "fixed", // "fixd"
                                                                     0x66706e74: "fixedPoint", // "fpnt"
                                                                     0x66726374: "fixedRectangle", // "frct"
                                                                     0x66726920: "Friday", // "fri\0x20"
                                                                     0x70697366: "frontmost", // "pisf"
                                                                     0x676e7263: "generic", // "gnrc"
                                                                     0x47494666: "GIFPicture", // "GIFf"
                                                                     0x63677478: "graphicText", // "cgtx"
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
                                                                     0x6c736172: "lastSchemeActionResult", // "lsar"
                                                                     0x6c697374: "list", // "list"
                                                                     0x6c6f6164: "loaded", // "load"
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
                                                                     0x73616d74: "message", // "samt"
                                                                     0x69736d6e: "miniaturizable", // "ismn"
                                                                     0x706d6e64: "miniaturized", // "pmnd"
                                                                     0x696d6f64: "modified", // "imod"
                                                                     0x6d6f6e20: "Monday", // "mon\0x20"
                                                                     0x706e616d: "name", // "pnam"
                                                                     0x6e6f2020: "no", // "no\0x20\0x20"
                                                                     0x776e6f63: "notifiesWhenClosing", // "wnoc"
                                                                     0x7372736e: "notYetStarted", // "srsn"
                                                                     0x6e6f7620: "November", // "nov\0x20"
                                                                     0x6e756c6c: "null", // "null"
                                                                     0x6e756d65: "numericStrings", // "nume"
                                                                     0x6f637420: "October", // "oct\0x20"
                                                                     0x6f737672: "operatingSystemVersion", // "osvr"
                                                                     0x70707468: "path", // "ppth"
                                                                     0x50494354: "PICTPicture", // "PICT"
                                                                     0x74706d6d: "pixelMapRecord", // "tpmm"
                                                                     0x706c6174: "platform", // "plat"
                                                                     0x51447074: "point", // "QDpt"
                                                                     0x70736e20: "processSerialNumber", // "psn\0x20"
                                                                     0x70726f6a: "project", // "proj"
                                                                     0x70414c4c: "properties", // "pALL"
                                                                     0x70726f70: "property_", // "prop"
                                                                     0x70756e63: "punctuation", // "punc"
                                                                     0x646f7562: "real", // "doub"
                                                                     0x7265636f: "record", // "reco"
                                                                     0x6f626a20: "reference", // "obj\0x20"
                                                                     0x7072737a: "resizable", // "prsz"
                                                                     0x61737273: "resolvedBuildSetting", // "asrs"
                                                                     0x74723136: "RGB16Color", // "tr16"
                                                                     0x74723936: "RGB96Color", // "tr96"
                                                                     0x63524742: "RGBColor", // "cRGB"
                                                                     0x74726f74: "rotation", // "trot"
                                                                     0x72756e64: "runDestination", // "rund"
                                                                     0x73727372: "running", // "srsr"
                                                                     0x73617420: "Saturday", // "sat\0x20"
                                                                     0x72756e78: "scheme", // "runx"
                                                                     0x73616973: "schemeActionIssue", // "sais"
                                                                     0x73617274: "schemeActionResult", // "sart"
                                                                     0x73637074: "script", // "scpt"
                                                                     0x78736372: "selectedCharacterRange", // "xscr"
                                                                     0x78737072: "selectedParagraphRange", // "xspr"
                                                                     0x73657020: "September", // "sep\0x20"
                                                                     0x73686f72: "shortInteger", // "shor"
                                                                     0x73696e67: "smallReal", // "sing"
                                                                     0x736f7566: "sourceDocument", // "souf"
                                                                     0x73617363: "startingColumnNumber", // "sasc"
                                                                     0x7361736c: "startingLineNumber", // "sasl"
                                                                     0x73617273: "status", // "sars"
                                                                     0x54455854: "string", // "TEXT"
                                                                     0x7374796c: "styledClipboardText", // "styl"
                                                                     0x53545854: "styledText", // "STXT"
                                                                     0x73727373: "succeeded", // "srss"
                                                                     0x73756e20: "Sunday", // "sun\0x20"
                                                                     0x74617252: "target", // "tarR"
                                                                     0x73617466: "testFailure", // "satf"
                                                                     0x63747874: "text", // "ctxt"
                                                                     0x74657864: "textDocument", // "texd"
                                                                     0x74737479: "textStyleInfo", // "tsty"
                                                                     0x74687520: "Thursday", // "thu\0x20"
                                                                     0x54494646: "TIFFPicture", // "TIFF"
                                                                     0x74756520: "Tuesday", // "tue\0x20"
                                                                     0x74797065: "typeClass", // "type"
                                                                     0x75747874: "UnicodeText", // "utxt"
                                                                     0x75636f6d: "unsignedDoubleInteger", // "ucom"
                                                                     0x6d61676e: "unsignedInteger", // "magn"
                                                                     0x75736872: "unsignedShortInteger", // "ushr"
                                                                     0x75743136: "UTF16Text", // "ut16"
                                                                     0x75746638: "UTF8Text", // "utf8"
                                                                     0x76616c4c: "value", // "valL"
                                                                     0x656e766e: "variableName", // "envn"
                                                                     0x656e7676: "variableValue", // "envv"
                                                                     0x76657273: "version", // "vers"
                                                                     0x70766973: "visible", // "pvis"
                                                                     0x77656420: "Wednesday", // "wed\0x20"
                                                                     0x77686974: "whitespace", // "whit"
                                                                     0x6377696e: "window", // "cwin"
                                                                     0x776b7364: "workspaceDocument", // "wksd"
                                                                     0x70736374: "writingCode", // "psct"
                                                                     0x79657320: "yes", // "yes\0x20"
                                                                     0x69737a6d: "zoomable", // "iszm"
                                                                     0x707a756d: "zoomed", // "pzum"
                                                     ],
                                                     propertyNames: [
                                                                     0x61727564: "activeRunDestination", // "arud"
                                                                     0x6172756e: "activeScheme", // "arun"
                                                                     0x61776b73: "activeWorkspaceDocument", // "awks"
                                                                     0x61726368: "architecture", // "arch"
                                                                     0x70626e64: "bounds", // "pbnd"
                                                                     0x626c6f67: "buildLog", // "blog"
                                                                     0x70636c73: "class_", // "pcls"
                                                                     0x68636c62: "closeable", // "hclb"
                                                                     0x63646576: "companionDevice", // "cdev"
                                                                     0x73617263: "completed", // "sarc"
                                                                     0x72646576: "device", // "rdev"
                                                                     0x64766964: "deviceIdentifier", // "dvid"
                                                                     0x64767479: "deviceModel", // "dvty"
                                                                     0x646f6375: "document", // "docu"
                                                                     0x73616563: "endingColumnNumber", // "saec"
                                                                     0x7361656c: "endingLineNumber", // "sael"
                                                                     0x73617265: "errorMessage", // "sare"
                                                                     0x66696c65: "file", // "file"
                                                                     0x73616670: "filePath", // "safp"
                                                                     0x70697366: "frontmost", // "pisf"
                                                                     0x676e7263: "generic", // "gnrc"
                                                                     0x49442020: "id", // "ID\0x20\0x20"
                                                                     0x70696478: "index", // "pidx"
                                                                     0x6c736172: "lastSchemeActionResult", // "lsar"
                                                                     0x6c6f6164: "loaded", // "load"
                                                                     0x73616d74: "message", // "samt"
                                                                     0x69736d6e: "miniaturizable", // "ismn"
                                                                     0x706d6e64: "miniaturized", // "pmnd"
                                                                     0x696d6f64: "modified", // "imod"
                                                                     0x706e616d: "name", // "pnam"
                                                                     0x776e6f63: "notifiesWhenClosing", // "wnoc"
                                                                     0x6f737672: "operatingSystemVersion", // "osvr"
                                                                     0x70707468: "path", // "ppth"
                                                                     0x706c6174: "platform", // "plat"
                                                                     0x70726f6a: "project", // "proj"
                                                                     0x70414c4c: "properties", // "pALL"
                                                                     0x7072737a: "resizable", // "prsz"
                                                                     0x78736372: "selectedCharacterRange", // "xscr"
                                                                     0x78737072: "selectedParagraphRange", // "xspr"
                                                                     0x73617363: "startingColumnNumber", // "sasc"
                                                                     0x7361736c: "startingLineNumber", // "sasl"
                                                                     0x73617273: "status", // "sars"
                                                                     0x63747874: "text", // "ctxt"
                                                                     0x76616c4c: "value", // "valL"
                                                                     0x656e766e: "variableName", // "envn"
                                                                     0x656e7676: "variableValue", // "envv"
                                                                     0x76657273: "version", // "vers"
                                                                     0x70766973: "visible", // "pvis"
                                                                     0x69737a6d: "zoomable", // "iszm"
                                                                     0x707a756d: "zoomed", // "pzum"
                                                     ],
                                                     elementsNames: [
                                                                     0x73616169: ("analyzer issue", "analyzerIssues"), // "saai"
                                                                     0x63617070: ("application", "applications"), // "capp"
                                                                     0x62756366: ("build configuration", "buildConfigurations"), // "bucf"
                                                                     0x73616265: ("build error", "buildErrors"), // "sabe"
                                                                     0x61736273: ("build setting", "buildSettings"), // "asbs"
                                                                     0x73616277: ("build warning", "buildWarnings"), // "sabw"
                                                                     0x64657663: ("device", "devices"), // "devc"
                                                                     0x646f6375: ("document", "documents"), // "docu"
                                                                     0x66696c64: ("file document", "fileDocuments"), // "fild"
                                                                     0x636f626a: ("item", "items"), // "cobj"
                                                                     0x70726f6a: ("project", "projects"), // "proj"
                                                                     0x61737273: ("resolved build setting", "resolvedBuildSettings"), // "asrs"
                                                                     0x72756e64: ("run destination", "runDestinations"), // "rund"
                                                                     0x73616973: ("scheme action issue", "schemeActionIssues"), // "sais"
                                                                     0x73617274: ("scheme action result", "schemeActionResults"), // "sart"
                                                                     0x72756e78: ("scheme", "schemes"), // "runx"
                                                                     0x736f7566: ("source document", "sourceDocuments"), // "souf"
                                                                     0x74617252: ("target", "targets"), // "tarR"
                                                                     0x73617466: ("test failure", "testFailures"), // "satf"
                                                                     0x74657864: ("text document", "textDocuments"), // "texd"
                                                                     0x6377696e: ("window", "windows"), // "cwin"
                                                                     0x776b7364: ("workspace document", "workspaceDocuments"), // "wksd"
                                                     ])

private let _glueClasses = SwiftAutomation.GlueClasses(insertionSpecifierType: XCOInsertion.self,
                                       objectSpecifierType: XCOItem.self,
                                       multiObjectSpecifierType: XCOItems.self,
                                       rootSpecifierType: XCORoot.self,
                                       applicationType: Xcode.self,
                                       symbolType: XCOSymbol.self,
                                       formatter: _specifierFormatter)

private let _untargetedAppData = SwiftAutomation.AppData(glueClasses: _glueClasses)


/******************************************************************************/
// Symbol subclass defines static type/enum/property constants based on Xcode.app terminology

public class XCOSymbol: SwiftAutomation.Symbol {

    override public var typeAliasName: String {return "XCO"}

    public override class func symbol(code: OSType, type: OSType = typeType, descriptor: NSAppleEventDescriptor? = nil) -> XCOSymbol {
        switch (code) {
        case 0x61727564: return self.activeRunDestination // "arud"
        case 0x6172756e: return self.activeScheme // "arun"
        case 0x61776b73: return self.activeWorkspaceDocument // "awks"
        case 0x616c6973: return self.alias // "alis"
        case 0x73616169: return self.analyzerIssue // "saai"
        case 0x2a2a2a2a: return self.anything // "****"
        case 0x63617070: return self.application // "capp"
        case 0x62756e64: return self.applicationBundleID // "bund"
        case 0x7369676e: return self.applicationSignature // "sign"
        case 0x6170726c: return self.applicationURL // "aprl"
        case 0x61707220: return self.April // "apr\0x20"
        case 0x61726368: return self.architecture // "arch"
        case 0x61736b20: return self.ask // "ask\0x20"
        case 0x61756720: return self.August // "aug\0x20"
        case 0x62657374: return self.best // "best"
        case 0x626d726b: return self.bookmarkData // "bmrk"
        case 0x626f6f6c: return self.boolean // "bool"
        case 0x71647274: return self.boundingRectangle // "qdrt"
        case 0x70626e64: return self.bounds // "pbnd"
        case 0x62756366: return self.buildConfiguration // "bucf"
        case 0x73616265: return self.buildError // "sabe"
        case 0x626c6f67: return self.buildLog // "blog"
        case 0x61736273: return self.buildSetting // "asbs"
        case 0x73616277: return self.buildWarning // "sabw"
        case 0x73727363: return self.cancelled // "srsc"
        case 0x63617365: return self.case_ // "case"
        case 0x70636c73: return self.class_ // "pcls"
        case 0x68636c62: return self.closeable // "hclb"
        case 0x636c7274: return self.colorTable // "clrt"
        case 0x63646576: return self.companionDevice // "cdev"
        case 0x73617263: return self.completed // "sarc"
        case 0x656e756d: return self.constant // "enum"
        case 0x74646173: return self.dashStyle // "tdas"
        case 0x74647461: return self.data // "tdta"
        case 0x6c647420: return self.date // "ldt\0x20"
        case 0x64656320: return self.December // "dec\0x20"
        case 0x6465636d: return self.decimalStruct // "decm"
        case 0x64657663: return self.device // "devc"
        case 0x72646576: return self.device // "rdev"
        case 0x64766964: return self.deviceIdentifier // "dvid"
        case 0x64767479: return self.deviceModel // "dvty"
        case 0x64696163: return self.diacriticals // "diac"
        case 0x646f6375: return self.document // "docu"
        case 0x636f6d70: return self.doubleInteger // "comp"
        case 0x656e6373: return self.encodedString // "encs"
        case 0x73616563: return self.endingColumnNumber // "saec"
        case 0x7361656c: return self.endingLineNumber // "sael"
        case 0x656e7672: return self.environmentVariable // "envr"
        case 0x45505320: return self.EPSPicture // "EPS\0x20"
        case 0x73617265: return self.errorMessage // "sare"
        case 0x73727365: return self.errorOccurred // "srse"
        case 0x65787061: return self.expansion // "expa"
        case 0x65787465: return self.extendedReal // "exte"
        case 0x73727366: return self.failed // "srsf"
        case 0x66656220: return self.February // "feb\0x20"
        case 0x66696c65: return self.file // "file"
        case 0x66696c64: return self.fileDocument // "fild"
        case 0x73616670: return self.filePath // "safp"
        case 0x66737266: return self.fileRef // "fsrf"
        case 0x66737320: return self.fileSpecification // "fss\0x20"
        case 0x6675726c: return self.fileURL // "furl"
        case 0x66697864: return self.fixed // "fixd"
        case 0x66706e74: return self.fixedPoint // "fpnt"
        case 0x66726374: return self.fixedRectangle // "frct"
        case 0x66726920: return self.Friday // "fri\0x20"
        case 0x70697366: return self.frontmost // "pisf"
        case 0x676e7263: return self.generic // "gnrc"
        case 0x47494666: return self.GIFPicture // "GIFf"
        case 0x63677478: return self.graphicText // "cgtx"
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
        case 0x6c736172: return self.lastSchemeActionResult // "lsar"
        case 0x6c697374: return self.list // "list"
        case 0x6c6f6164: return self.loaded // "load"
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
        case 0x73616d74: return self.message // "samt"
        case 0x69736d6e: return self.miniaturizable // "ismn"
        case 0x706d6e64: return self.miniaturized // "pmnd"
        case 0x696d6f64: return self.modified // "imod"
        case 0x6d6f6e20: return self.Monday // "mon\0x20"
        case 0x706e616d: return self.name // "pnam"
        case 0x6e6f2020: return self.no // "no\0x20\0x20"
        case 0x776e6f63: return self.notifiesWhenClosing // "wnoc"
        case 0x7372736e: return self.notYetStarted // "srsn"
        case 0x6e6f7620: return self.November // "nov\0x20"
        case 0x6e756c6c: return self.null // "null"
        case 0x6e756d65: return self.numericStrings // "nume"
        case 0x6f637420: return self.October // "oct\0x20"
        case 0x6f737672: return self.operatingSystemVersion // "osvr"
        case 0x70707468: return self.path // "ppth"
        case 0x50494354: return self.PICTPicture // "PICT"
        case 0x74706d6d: return self.pixelMapRecord // "tpmm"
        case 0x706c6174: return self.platform // "plat"
        case 0x51447074: return self.point // "QDpt"
        case 0x70736e20: return self.processSerialNumber // "psn\0x20"
        case 0x70726f6a: return self.project // "proj"
        case 0x70414c4c: return self.properties // "pALL"
        case 0x70726f70: return self.property_ // "prop"
        case 0x70756e63: return self.punctuation // "punc"
        case 0x646f7562: return self.real // "doub"
        case 0x7265636f: return self.record // "reco"
        case 0x6f626a20: return self.reference // "obj\0x20"
        case 0x7072737a: return self.resizable // "prsz"
        case 0x61737273: return self.resolvedBuildSetting // "asrs"
        case 0x74723136: return self.RGB16Color // "tr16"
        case 0x74723936: return self.RGB96Color // "tr96"
        case 0x63524742: return self.RGBColor // "cRGB"
        case 0x74726f74: return self.rotation // "trot"
        case 0x72756e64: return self.runDestination // "rund"
        case 0x73727372: return self.running // "srsr"
        case 0x73617420: return self.Saturday // "sat\0x20"
        case 0x72756e78: return self.scheme // "runx"
        case 0x73616973: return self.schemeActionIssue // "sais"
        case 0x73617274: return self.schemeActionResult // "sart"
        case 0x73637074: return self.script // "scpt"
        case 0x78736372: return self.selectedCharacterRange // "xscr"
        case 0x78737072: return self.selectedParagraphRange // "xspr"
        case 0x73657020: return self.September // "sep\0x20"
        case 0x73686f72: return self.shortInteger // "shor"
        case 0x73696e67: return self.smallReal // "sing"
        case 0x736f7566: return self.sourceDocument // "souf"
        case 0x73617363: return self.startingColumnNumber // "sasc"
        case 0x7361736c: return self.startingLineNumber // "sasl"
        case 0x73617273: return self.status // "sars"
        case 0x54455854: return self.string // "TEXT"
        case 0x7374796c: return self.styledClipboardText // "styl"
        case 0x53545854: return self.styledText // "STXT"
        case 0x73727373: return self.succeeded // "srss"
        case 0x73756e20: return self.Sunday // "sun\0x20"
        case 0x74617252: return self.target // "tarR"
        case 0x73617466: return self.testFailure // "satf"
        case 0x63747874: return self.text // "ctxt"
        case 0x74657864: return self.textDocument // "texd"
        case 0x74737479: return self.textStyleInfo // "tsty"
        case 0x74687520: return self.Thursday // "thu\0x20"
        case 0x54494646: return self.TIFFPicture // "TIFF"
        case 0x74756520: return self.Tuesday // "tue\0x20"
        case 0x74797065: return self.typeClass // "type"
        case 0x75747874: return self.UnicodeText // "utxt"
        case 0x75636f6d: return self.unsignedDoubleInteger // "ucom"
        case 0x6d61676e: return self.unsignedInteger // "magn"
        case 0x75736872: return self.unsignedShortInteger // "ushr"
        case 0x75743136: return self.UTF16Text // "ut16"
        case 0x75746638: return self.UTF8Text // "utf8"
        case 0x76616c4c: return self.value // "valL"
        case 0x656e766e: return self.variableName // "envn"
        case 0x656e7676: return self.variableValue // "envv"
        case 0x76657273: return self.version // "vers"
        case 0x70766973: return self.visible // "pvis"
        case 0x77656420: return self.Wednesday // "wed\0x20"
        case 0x77686974: return self.whitespace // "whit"
        case 0x6377696e: return self.window // "cwin"
        case 0x776b7364: return self.workspaceDocument // "wksd"
        case 0x70736374: return self.writingCode // "psct"
        case 0x79657320: return self.yes // "yes\0x20"
        case 0x69737a6d: return self.zoomable // "iszm"
        case 0x707a756d: return self.zoomed // "pzum"
        default: return super.symbol(code: code, type: type, descriptor: descriptor) as! XCOSymbol
        }
    }

    // Types/properties
    public static let activeRunDestination = XCOSymbol(name: "activeRunDestination", code: 0x61727564, type: typeType) // "arud"
    public static let activeScheme = XCOSymbol(name: "activeScheme", code: 0x6172756e, type: typeType) // "arun"
    public static let activeWorkspaceDocument = XCOSymbol(name: "activeWorkspaceDocument", code: 0x61776b73, type: typeType) // "awks"
    public static let alias = XCOSymbol(name: "alias", code: 0x616c6973, type: typeType) // "alis"
    public static let analyzerIssue = XCOSymbol(name: "analyzerIssue", code: 0x73616169, type: typeType) // "saai"
    public static let anything = XCOSymbol(name: "anything", code: 0x2a2a2a2a, type: typeType) // "****"
    public static let application = XCOSymbol(name: "application", code: 0x63617070, type: typeType) // "capp"
    public static let applicationBundleID = XCOSymbol(name: "applicationBundleID", code: 0x62756e64, type: typeType) // "bund"
    public static let applicationSignature = XCOSymbol(name: "applicationSignature", code: 0x7369676e, type: typeType) // "sign"
    public static let applicationURL = XCOSymbol(name: "applicationURL", code: 0x6170726c, type: typeType) // "aprl"
    public static let April = XCOSymbol(name: "April", code: 0x61707220, type: typeType) // "apr\0x20"
    public static let architecture = XCOSymbol(name: "architecture", code: 0x61726368, type: typeType) // "arch"
    public static let August = XCOSymbol(name: "August", code: 0x61756720, type: typeType) // "aug\0x20"
    public static let best = XCOSymbol(name: "best", code: 0x62657374, type: typeType) // "best"
    public static let bookmarkData = XCOSymbol(name: "bookmarkData", code: 0x626d726b, type: typeType) // "bmrk"
    public static let boolean = XCOSymbol(name: "boolean", code: 0x626f6f6c, type: typeType) // "bool"
    public static let boundingRectangle = XCOSymbol(name: "boundingRectangle", code: 0x71647274, type: typeType) // "qdrt"
    public static let bounds = XCOSymbol(name: "bounds", code: 0x70626e64, type: typeType) // "pbnd"
    public static let buildConfiguration = XCOSymbol(name: "buildConfiguration", code: 0x62756366, type: typeType) // "bucf"
    public static let buildError = XCOSymbol(name: "buildError", code: 0x73616265, type: typeType) // "sabe"
    public static let buildLog = XCOSymbol(name: "buildLog", code: 0x626c6f67, type: typeType) // "blog"
    public static let buildSetting = XCOSymbol(name: "buildSetting", code: 0x61736273, type: typeType) // "asbs"
    public static let buildWarning = XCOSymbol(name: "buildWarning", code: 0x73616277, type: typeType) // "sabw"
    public static let class_ = XCOSymbol(name: "class_", code: 0x70636c73, type: typeType) // "pcls"
    public static let closeable = XCOSymbol(name: "closeable", code: 0x68636c62, type: typeType) // "hclb"
    public static let colorTable = XCOSymbol(name: "colorTable", code: 0x636c7274, type: typeType) // "clrt"
    public static let companionDevice = XCOSymbol(name: "companionDevice", code: 0x63646576, type: typeType) // "cdev"
    public static let completed = XCOSymbol(name: "completed", code: 0x73617263, type: typeType) // "sarc"
    public static let constant = XCOSymbol(name: "constant", code: 0x656e756d, type: typeType) // "enum"
    public static let dashStyle = XCOSymbol(name: "dashStyle", code: 0x74646173, type: typeType) // "tdas"
    public static let data = XCOSymbol(name: "data", code: 0x74647461, type: typeType) // "tdta"
    public static let date = XCOSymbol(name: "date", code: 0x6c647420, type: typeType) // "ldt\0x20"
    public static let December = XCOSymbol(name: "December", code: 0x64656320, type: typeType) // "dec\0x20"
    public static let decimalStruct = XCOSymbol(name: "decimalStruct", code: 0x6465636d, type: typeType) // "decm"
    public static let device = XCOSymbol(name: "device", code: 0x64657663, type: typeType) // "devc"
    public static let deviceIdentifier = XCOSymbol(name: "deviceIdentifier", code: 0x64766964, type: typeType) // "dvid"
    public static let deviceModel = XCOSymbol(name: "deviceModel", code: 0x64767479, type: typeType) // "dvty"
    public static let document = XCOSymbol(name: "document", code: 0x646f6375, type: typeType) // "docu"
    public static let doubleInteger = XCOSymbol(name: "doubleInteger", code: 0x636f6d70, type: typeType) // "comp"
    public static let encodedString = XCOSymbol(name: "encodedString", code: 0x656e6373, type: typeType) // "encs"
    public static let endingColumnNumber = XCOSymbol(name: "endingColumnNumber", code: 0x73616563, type: typeType) // "saec"
    public static let endingLineNumber = XCOSymbol(name: "endingLineNumber", code: 0x7361656c, type: typeType) // "sael"
    public static let environmentVariable = XCOSymbol(name: "environmentVariable", code: 0x656e7672, type: typeType) // "envr"
    public static let EPSPicture = XCOSymbol(name: "EPSPicture", code: 0x45505320, type: typeType) // "EPS\0x20"
    public static let errorMessage = XCOSymbol(name: "errorMessage", code: 0x73617265, type: typeType) // "sare"
    public static let extendedReal = XCOSymbol(name: "extendedReal", code: 0x65787465, type: typeType) // "exte"
    public static let February = XCOSymbol(name: "February", code: 0x66656220, type: typeType) // "feb\0x20"
    public static let file = XCOSymbol(name: "file", code: 0x66696c65, type: typeType) // "file"
    public static let fileDocument = XCOSymbol(name: "fileDocument", code: 0x66696c64, type: typeType) // "fild"
    public static let filePath = XCOSymbol(name: "filePath", code: 0x73616670, type: typeType) // "safp"
    public static let fileRef = XCOSymbol(name: "fileRef", code: 0x66737266, type: typeType) // "fsrf"
    public static let fileSpecification = XCOSymbol(name: "fileSpecification", code: 0x66737320, type: typeType) // "fss\0x20"
    public static let fileURL = XCOSymbol(name: "fileURL", code: 0x6675726c, type: typeType) // "furl"
    public static let fixed = XCOSymbol(name: "fixed", code: 0x66697864, type: typeType) // "fixd"
    public static let fixedPoint = XCOSymbol(name: "fixedPoint", code: 0x66706e74, type: typeType) // "fpnt"
    public static let fixedRectangle = XCOSymbol(name: "fixedRectangle", code: 0x66726374, type: typeType) // "frct"
    public static let Friday = XCOSymbol(name: "Friday", code: 0x66726920, type: typeType) // "fri\0x20"
    public static let frontmost = XCOSymbol(name: "frontmost", code: 0x70697366, type: typeType) // "pisf"
    public static let generic = XCOSymbol(name: "generic", code: 0x676e7263, type: typeType) // "gnrc"
    public static let GIFPicture = XCOSymbol(name: "GIFPicture", code: 0x47494666, type: typeType) // "GIFf"
    public static let graphicText = XCOSymbol(name: "graphicText", code: 0x63677478, type: typeType) // "cgtx"
    public static let id = XCOSymbol(name: "id", code: 0x49442020, type: typeType) // "ID\0x20\0x20"
    public static let index = XCOSymbol(name: "index", code: 0x70696478, type: typeType) // "pidx"
    public static let integer = XCOSymbol(name: "integer", code: 0x6c6f6e67, type: typeType) // "long"
    public static let internationalText = XCOSymbol(name: "internationalText", code: 0x69747874, type: typeType) // "itxt"
    public static let internationalWritingCode = XCOSymbol(name: "internationalWritingCode", code: 0x696e746c, type: typeType) // "intl"
    public static let item = XCOSymbol(name: "item", code: 0x636f626a, type: typeType) // "cobj"
    public static let January = XCOSymbol(name: "January", code: 0x6a616e20, type: typeType) // "jan\0x20"
    public static let JPEGPicture = XCOSymbol(name: "JPEGPicture", code: 0x4a504547, type: typeType) // "JPEG"
    public static let July = XCOSymbol(name: "July", code: 0x6a756c20, type: typeType) // "jul\0x20"
    public static let June = XCOSymbol(name: "June", code: 0x6a756e20, type: typeType) // "jun\0x20"
    public static let kernelProcessID = XCOSymbol(name: "kernelProcessID", code: 0x6b706964, type: typeType) // "kpid"
    public static let largeReal = XCOSymbol(name: "largeReal", code: 0x6c64626c, type: typeType) // "ldbl"
    public static let lastSchemeActionResult = XCOSymbol(name: "lastSchemeActionResult", code: 0x6c736172, type: typeType) // "lsar"
    public static let list = XCOSymbol(name: "list", code: 0x6c697374, type: typeType) // "list"
    public static let loaded = XCOSymbol(name: "loaded", code: 0x6c6f6164, type: typeType) // "load"
    public static let locationReference = XCOSymbol(name: "locationReference", code: 0x696e736c, type: typeType) // "insl"
    public static let longFixed = XCOSymbol(name: "longFixed", code: 0x6c667864, type: typeType) // "lfxd"
    public static let longFixedPoint = XCOSymbol(name: "longFixedPoint", code: 0x6c667074, type: typeType) // "lfpt"
    public static let longFixedRectangle = XCOSymbol(name: "longFixedRectangle", code: 0x6c667263, type: typeType) // "lfrc"
    public static let longPoint = XCOSymbol(name: "longPoint", code: 0x6c706e74, type: typeType) // "lpnt"
    public static let longRectangle = XCOSymbol(name: "longRectangle", code: 0x6c726374, type: typeType) // "lrct"
    public static let machine = XCOSymbol(name: "machine", code: 0x6d616368, type: typeType) // "mach"
    public static let machineLocation = XCOSymbol(name: "machineLocation", code: 0x6d4c6f63, type: typeType) // "mLoc"
    public static let machPort = XCOSymbol(name: "machPort", code: 0x706f7274, type: typeType) // "port"
    public static let March = XCOSymbol(name: "March", code: 0x6d617220, type: typeType) // "mar\0x20"
    public static let May = XCOSymbol(name: "May", code: 0x6d617920, type: typeType) // "may\0x20"
    public static let message = XCOSymbol(name: "message", code: 0x73616d74, type: typeType) // "samt"
    public static let miniaturizable = XCOSymbol(name: "miniaturizable", code: 0x69736d6e, type: typeType) // "ismn"
    public static let miniaturized = XCOSymbol(name: "miniaturized", code: 0x706d6e64, type: typeType) // "pmnd"
    public static let modified = XCOSymbol(name: "modified", code: 0x696d6f64, type: typeType) // "imod"
    public static let Monday = XCOSymbol(name: "Monday", code: 0x6d6f6e20, type: typeType) // "mon\0x20"
    public static let name = XCOSymbol(name: "name", code: 0x706e616d, type: typeType) // "pnam"
    public static let notifiesWhenClosing = XCOSymbol(name: "notifiesWhenClosing", code: 0x776e6f63, type: typeType) // "wnoc"
    public static let November = XCOSymbol(name: "November", code: 0x6e6f7620, type: typeType) // "nov\0x20"
    public static let null = XCOSymbol(name: "null", code: 0x6e756c6c, type: typeType) // "null"
    public static let October = XCOSymbol(name: "October", code: 0x6f637420, type: typeType) // "oct\0x20"
    public static let operatingSystemVersion = XCOSymbol(name: "operatingSystemVersion", code: 0x6f737672, type: typeType) // "osvr"
    public static let path = XCOSymbol(name: "path", code: 0x70707468, type: typeType) // "ppth"
    public static let PICTPicture = XCOSymbol(name: "PICTPicture", code: 0x50494354, type: typeType) // "PICT"
    public static let pixelMapRecord = XCOSymbol(name: "pixelMapRecord", code: 0x74706d6d, type: typeType) // "tpmm"
    public static let platform = XCOSymbol(name: "platform", code: 0x706c6174, type: typeType) // "plat"
    public static let point = XCOSymbol(name: "point", code: 0x51447074, type: typeType) // "QDpt"
    public static let processSerialNumber = XCOSymbol(name: "processSerialNumber", code: 0x70736e20, type: typeType) // "psn\0x20"
    public static let project = XCOSymbol(name: "project", code: 0x70726f6a, type: typeType) // "proj"
    public static let properties = XCOSymbol(name: "properties", code: 0x70414c4c, type: typeType) // "pALL"
    public static let property_ = XCOSymbol(name: "property_", code: 0x70726f70, type: typeType) // "prop"
    public static let real = XCOSymbol(name: "real", code: 0x646f7562, type: typeType) // "doub"
    public static let record = XCOSymbol(name: "record", code: 0x7265636f, type: typeType) // "reco"
    public static let reference = XCOSymbol(name: "reference", code: 0x6f626a20, type: typeType) // "obj\0x20"
    public static let resizable = XCOSymbol(name: "resizable", code: 0x7072737a, type: typeType) // "prsz"
    public static let resolvedBuildSetting = XCOSymbol(name: "resolvedBuildSetting", code: 0x61737273, type: typeType) // "asrs"
    public static let RGB16Color = XCOSymbol(name: "RGB16Color", code: 0x74723136, type: typeType) // "tr16"
    public static let RGB96Color = XCOSymbol(name: "RGB96Color", code: 0x74723936, type: typeType) // "tr96"
    public static let RGBColor = XCOSymbol(name: "RGBColor", code: 0x63524742, type: typeType) // "cRGB"
    public static let rotation = XCOSymbol(name: "rotation", code: 0x74726f74, type: typeType) // "trot"
    public static let runDestination = XCOSymbol(name: "runDestination", code: 0x72756e64, type: typeType) // "rund"
    public static let Saturday = XCOSymbol(name: "Saturday", code: 0x73617420, type: typeType) // "sat\0x20"
    public static let scheme = XCOSymbol(name: "scheme", code: 0x72756e78, type: typeType) // "runx"
    public static let schemeActionIssue = XCOSymbol(name: "schemeActionIssue", code: 0x73616973, type: typeType) // "sais"
    public static let schemeActionResult = XCOSymbol(name: "schemeActionResult", code: 0x73617274, type: typeType) // "sart"
    public static let script = XCOSymbol(name: "script", code: 0x73637074, type: typeType) // "scpt"
    public static let selectedCharacterRange = XCOSymbol(name: "selectedCharacterRange", code: 0x78736372, type: typeType) // "xscr"
    public static let selectedParagraphRange = XCOSymbol(name: "selectedParagraphRange", code: 0x78737072, type: typeType) // "xspr"
    public static let September = XCOSymbol(name: "September", code: 0x73657020, type: typeType) // "sep\0x20"
    public static let shortInteger = XCOSymbol(name: "shortInteger", code: 0x73686f72, type: typeType) // "shor"
    public static let smallReal = XCOSymbol(name: "smallReal", code: 0x73696e67, type: typeType) // "sing"
    public static let sourceDocument = XCOSymbol(name: "sourceDocument", code: 0x736f7566, type: typeType) // "souf"
    public static let startingColumnNumber = XCOSymbol(name: "startingColumnNumber", code: 0x73617363, type: typeType) // "sasc"
    public static let startingLineNumber = XCOSymbol(name: "startingLineNumber", code: 0x7361736c, type: typeType) // "sasl"
    public static let status = XCOSymbol(name: "status", code: 0x73617273, type: typeType) // "sars"
    public static let string = XCOSymbol(name: "string", code: 0x54455854, type: typeType) // "TEXT"
    public static let styledClipboardText = XCOSymbol(name: "styledClipboardText", code: 0x7374796c, type: typeType) // "styl"
    public static let styledText = XCOSymbol(name: "styledText", code: 0x53545854, type: typeType) // "STXT"
    public static let Sunday = XCOSymbol(name: "Sunday", code: 0x73756e20, type: typeType) // "sun\0x20"
    public static let target = XCOSymbol(name: "target", code: 0x74617252, type: typeType) // "tarR"
    public static let testFailure = XCOSymbol(name: "testFailure", code: 0x73617466, type: typeType) // "satf"
    public static let text = XCOSymbol(name: "text", code: 0x63747874, type: typeType) // "ctxt"
    public static let textDocument = XCOSymbol(name: "textDocument", code: 0x74657864, type: typeType) // "texd"
    public static let textStyleInfo = XCOSymbol(name: "textStyleInfo", code: 0x74737479, type: typeType) // "tsty"
    public static let Thursday = XCOSymbol(name: "Thursday", code: 0x74687520, type: typeType) // "thu\0x20"
    public static let TIFFPicture = XCOSymbol(name: "TIFFPicture", code: 0x54494646, type: typeType) // "TIFF"
    public static let Tuesday = XCOSymbol(name: "Tuesday", code: 0x74756520, type: typeType) // "tue\0x20"
    public static let typeClass = XCOSymbol(name: "typeClass", code: 0x74797065, type: typeType) // "type"
    public static let UnicodeText = XCOSymbol(name: "UnicodeText", code: 0x75747874, type: typeType) // "utxt"
    public static let unsignedDoubleInteger = XCOSymbol(name: "unsignedDoubleInteger", code: 0x75636f6d, type: typeType) // "ucom"
    public static let unsignedInteger = XCOSymbol(name: "unsignedInteger", code: 0x6d61676e, type: typeType) // "magn"
    public static let unsignedShortInteger = XCOSymbol(name: "unsignedShortInteger", code: 0x75736872, type: typeType) // "ushr"
    public static let UTF16Text = XCOSymbol(name: "UTF16Text", code: 0x75743136, type: typeType) // "ut16"
    public static let UTF8Text = XCOSymbol(name: "UTF8Text", code: 0x75746638, type: typeType) // "utf8"
    public static let value = XCOSymbol(name: "value", code: 0x76616c4c, type: typeType) // "valL"
    public static let variableName = XCOSymbol(name: "variableName", code: 0x656e766e, type: typeType) // "envn"
    public static let variableValue = XCOSymbol(name: "variableValue", code: 0x656e7676, type: typeType) // "envv"
    public static let version = XCOSymbol(name: "version", code: 0x76657273, type: typeType) // "vers"
    public static let visible = XCOSymbol(name: "visible", code: 0x70766973, type: typeType) // "pvis"
    public static let Wednesday = XCOSymbol(name: "Wednesday", code: 0x77656420, type: typeType) // "wed\0x20"
    public static let window = XCOSymbol(name: "window", code: 0x6377696e, type: typeType) // "cwin"
    public static let workspaceDocument = XCOSymbol(name: "workspaceDocument", code: 0x776b7364, type: typeType) // "wksd"
    public static let writingCode = XCOSymbol(name: "writingCode", code: 0x70736374, type: typeType) // "psct"
    public static let zoomable = XCOSymbol(name: "zoomable", code: 0x69737a6d, type: typeType) // "iszm"
    public static let zoomed = XCOSymbol(name: "zoomed", code: 0x707a756d, type: typeType) // "pzum"

    // Enumerators
    public static let ask = XCOSymbol(name: "ask", code: 0x61736b20, type: typeEnumerated) // "ask\0x20"
    public static let cancelled = XCOSymbol(name: "cancelled", code: 0x73727363, type: typeEnumerated) // "srsc"
    public static let case_ = XCOSymbol(name: "case_", code: 0x63617365, type: typeEnumerated) // "case"
    public static let diacriticals = XCOSymbol(name: "diacriticals", code: 0x64696163, type: typeEnumerated) // "diac"
    public static let errorOccurred = XCOSymbol(name: "errorOccurred", code: 0x73727365, type: typeEnumerated) // "srse"
    public static let expansion = XCOSymbol(name: "expansion", code: 0x65787061, type: typeEnumerated) // "expa"
    public static let failed = XCOSymbol(name: "failed", code: 0x73727366, type: typeEnumerated) // "srsf"
    public static let hyphens = XCOSymbol(name: "hyphens", code: 0x68797068, type: typeEnumerated) // "hyph"
    public static let no = XCOSymbol(name: "no", code: 0x6e6f2020, type: typeEnumerated) // "no\0x20\0x20"
    public static let notYetStarted = XCOSymbol(name: "notYetStarted", code: 0x7372736e, type: typeEnumerated) // "srsn"
    public static let numericStrings = XCOSymbol(name: "numericStrings", code: 0x6e756d65, type: typeEnumerated) // "nume"
    public static let punctuation = XCOSymbol(name: "punctuation", code: 0x70756e63, type: typeEnumerated) // "punc"
    public static let running = XCOSymbol(name: "running", code: 0x73727372, type: typeEnumerated) // "srsr"
    public static let succeeded = XCOSymbol(name: "succeeded", code: 0x73727373, type: typeEnumerated) // "srss"
    public static let whitespace = XCOSymbol(name: "whitespace", code: 0x77686974, type: typeEnumerated) // "whit"
    public static let yes = XCOSymbol(name: "yes", code: 0x79657320, type: typeEnumerated) // "yes\0x20"
}

public typealias XCO = XCOSymbol // allows symbols to be written as (e.g.) XCO.name instead of XCOSymbol.name


/******************************************************************************/
// Specifier extensions; these add command methods and property/elements getters based on Xcode.app terminology

public protocol XCOCommand: SwiftAutomation.SpecifierProtocol {} // provides AE dispatch methods

// Command->Any will be bound when return type can't be inferred, else Command->T

extension XCOCommand {
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
    @discardableResult public func build(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "build", eventClass: 0x78636f64, eventID: 0x62756c64, // "xcod"/"buld"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func build<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "build", eventClass: 0x78636f64, eventID: 0x62756c64, // "xcod"/"buld"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func clean(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "clean", eventClass: 0x78636f64, eventID: 0x636c656e, // "xcod"/"clen"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func clean<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "clean", eventClass: 0x78636f64, eventID: 0x636c656e, // "xcod"/"clen"
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
    @discardableResult public func hack(_ directParameter: Any = SwiftAutomation.NoParameter,
            document: Any = SwiftAutomation.NoParameter,
            start: Any = SwiftAutomation.NoParameter,
            stop: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "hack", eventClass: 0x70626173, eventID: 0x6861636b, // "pbas"/"hack"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("document", 0x646f6375, document), // "docu"
                    ("start", 0x73746141, start), // "staA"
                    ("stop", 0x73746f54, stop), // "stoT"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func hack<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            document: Any = SwiftAutomation.NoParameter,
            start: Any = SwiftAutomation.NoParameter,
            stop: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "hack", eventClass: 0x70626173, eventID: 0x6861636b, // "pbas"/"hack"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("document", 0x646f6375, document), // "docu"
                    ("start", 0x73746141, start), // "staA"
                    ("stop", 0x73746f54, stop), // "stoT"
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
    @discardableResult public func run_(_ directParameter: Any = SwiftAutomation.NoParameter,
            withCommandLineArguments: Any = SwiftAutomation.NoParameter,
            withEnvironmentVariables: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "run_", eventClass: 0x78636f64, eventID: 0x6572756e, // "xcod"/"erun"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("withCommandLineArguments", 0x636c6167, withCommandLineArguments), // "clag"
                    ("withEnvironmentVariables", 0x656e766c, withEnvironmentVariables), // "envl"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func run_<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            withCommandLineArguments: Any = SwiftAutomation.NoParameter,
            withEnvironmentVariables: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "run_", eventClass: 0x78636f64, eventID: 0x6572756e, // "xcod"/"erun"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("withCommandLineArguments", 0x636c6167, withCommandLineArguments), // "clag"
                    ("withEnvironmentVariables", 0x656e766c, withEnvironmentVariables), // "envl"
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
    @discardableResult public func stop(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "stop", eventClass: 0x78636f64, eventID: 0x73746f70, // "xcod"/"stop"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func stop<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "stop", eventClass: 0x78636f64, eventID: 0x73746f70, // "xcod"/"stop"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func test(_ directParameter: Any = SwiftAutomation.NoParameter,
            withCommandLineArguments: Any = SwiftAutomation.NoParameter,
            withEnvironmentVariables: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "test", eventClass: 0x78636f64, eventID: 0x74657374, // "xcod"/"test"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("withCommandLineArguments", 0x636c6167, withCommandLineArguments), // "clag"
                    ("withEnvironmentVariables", 0x656e766c, withEnvironmentVariables), // "envl"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func test<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            withCommandLineArguments: Any = SwiftAutomation.NoParameter,
            withEnvironmentVariables: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "test", eventClass: 0x78636f64, eventID: 0x74657374, // "xcod"/"test"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("withCommandLineArguments", 0x636c6167, withCommandLineArguments), // "clag"
                    ("withEnvironmentVariables", 0x656e766c, withEnvironmentVariables), // "envl"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
}


public protocol XCOObject: SwiftAutomation.ObjectSpecifierExtension, XCOCommand {} // provides vars and methods for constructing specifiers

extension XCOObject {
    
    // Properties
    public var activeRunDestination: XCOItem {return self.property(0x61727564) as! XCOItem} // "arud"
    public var activeScheme: XCOItem {return self.property(0x6172756e) as! XCOItem} // "arun"
    public var activeWorkspaceDocument: XCOItem {return self.property(0x61776b73) as! XCOItem} // "awks"
    public var architecture: XCOItem {return self.property(0x61726368) as! XCOItem} // "arch"
    public var bounds: XCOItem {return self.property(0x70626e64) as! XCOItem} // "pbnd"
    public var buildLog: XCOItem {return self.property(0x626c6f67) as! XCOItem} // "blog"
    public var class_: XCOItem {return self.property(0x70636c73) as! XCOItem} // "pcls"
    public var closeable: XCOItem {return self.property(0x68636c62) as! XCOItem} // "hclb"
    public var companionDevice: XCOItem {return self.property(0x63646576) as! XCOItem} // "cdev"
    public var completed: XCOItem {return self.property(0x73617263) as! XCOItem} // "sarc"
    public var device: XCOItem {return self.property(0x72646576) as! XCOItem} // "rdev"
    public var deviceIdentifier: XCOItem {return self.property(0x64766964) as! XCOItem} // "dvid"
    public var deviceModel: XCOItem {return self.property(0x64767479) as! XCOItem} // "dvty"
    public var document: XCOItem {return self.property(0x646f6375) as! XCOItem} // "docu"
    public var endingColumnNumber: XCOItem {return self.property(0x73616563) as! XCOItem} // "saec"
    public var endingLineNumber: XCOItem {return self.property(0x7361656c) as! XCOItem} // "sael"
    public var errorMessage: XCOItem {return self.property(0x73617265) as! XCOItem} // "sare"
    public var file: XCOItem {return self.property(0x66696c65) as! XCOItem} // "file"
    public var filePath: XCOItem {return self.property(0x73616670) as! XCOItem} // "safp"
    public var frontmost: XCOItem {return self.property(0x70697366) as! XCOItem} // "pisf"
    public var generic: XCOItem {return self.property(0x676e7263) as! XCOItem} // "gnrc"
    public var id: XCOItem {return self.property(0x49442020) as! XCOItem} // "ID\0x20\0x20"
    public var index: XCOItem {return self.property(0x70696478) as! XCOItem} // "pidx"
    public var lastSchemeActionResult: XCOItem {return self.property(0x6c736172) as! XCOItem} // "lsar"
    public var loaded: XCOItem {return self.property(0x6c6f6164) as! XCOItem} // "load"
    public var message: XCOItem {return self.property(0x73616d74) as! XCOItem} // "samt"
    public var miniaturizable: XCOItem {return self.property(0x69736d6e) as! XCOItem} // "ismn"
    public var miniaturized: XCOItem {return self.property(0x706d6e64) as! XCOItem} // "pmnd"
    public var modified: XCOItem {return self.property(0x696d6f64) as! XCOItem} // "imod"
    public var name: XCOItem {return self.property(0x706e616d) as! XCOItem} // "pnam"
    public var notifiesWhenClosing: XCOItem {return self.property(0x776e6f63) as! XCOItem} // "wnoc"
    public var operatingSystemVersion: XCOItem {return self.property(0x6f737672) as! XCOItem} // "osvr"
    public var path: XCOItem {return self.property(0x70707468) as! XCOItem} // "ppth"
    public var platform: XCOItem {return self.property(0x706c6174) as! XCOItem} // "plat"
    public var project: XCOItem {return self.property(0x70726f6a) as! XCOItem} // "proj"
    public var properties: XCOItem {return self.property(0x70414c4c) as! XCOItem} // "pALL"
    public var resizable: XCOItem {return self.property(0x7072737a) as! XCOItem} // "prsz"
    public var selectedCharacterRange: XCOItem {return self.property(0x78736372) as! XCOItem} // "xscr"
    public var selectedParagraphRange: XCOItem {return self.property(0x78737072) as! XCOItem} // "xspr"
    public var startingColumnNumber: XCOItem {return self.property(0x73617363) as! XCOItem} // "sasc"
    public var startingLineNumber: XCOItem {return self.property(0x7361736c) as! XCOItem} // "sasl"
    public var status: XCOItem {return self.property(0x73617273) as! XCOItem} // "sars"
    public var value: XCOItem {return self.property(0x76616c4c) as! XCOItem} // "valL"
    public var variableName: XCOItem {return self.property(0x656e766e) as! XCOItem} // "envn"
    public var variableValue: XCOItem {return self.property(0x656e7676) as! XCOItem} // "envv"
    public var version: XCOItem {return self.property(0x76657273) as! XCOItem} // "vers"
    public var visible: XCOItem {return self.property(0x70766973) as! XCOItem} // "pvis"
    public var zoomable: XCOItem {return self.property(0x69737a6d) as! XCOItem} // "iszm"
    public var zoomed: XCOItem {return self.property(0x707a756d) as! XCOItem} // "pzum"

    // Elements
    public var analyzerIssues: XCOItems {return self.elements(0x73616169) as! XCOItems} // "saai"
    public var applications: XCOItems {return self.elements(0x63617070) as! XCOItems} // "capp"
    public var buildConfigurations: XCOItems {return self.elements(0x62756366) as! XCOItems} // "bucf"
    public var buildErrors: XCOItems {return self.elements(0x73616265) as! XCOItems} // "sabe"
    public var buildSettings: XCOItems {return self.elements(0x61736273) as! XCOItems} // "asbs"
    public var buildWarnings: XCOItems {return self.elements(0x73616277) as! XCOItems} // "sabw"
    public var devices: XCOItems {return self.elements(0x64657663) as! XCOItems} // "devc"
    public var documents: XCOItems {return self.elements(0x646f6375) as! XCOItems} // "docu"
    public var fileDocuments: XCOItems {return self.elements(0x66696c64) as! XCOItems} // "fild"
    public var items: XCOItems {return self.elements(0x636f626a) as! XCOItems} // "cobj"
    public var projects: XCOItems {return self.elements(0x70726f6a) as! XCOItems} // "proj"
    public var resolvedBuildSettings: XCOItems {return self.elements(0x61737273) as! XCOItems} // "asrs"
    public var runDestinations: XCOItems {return self.elements(0x72756e64) as! XCOItems} // "rund"
    public var schemes: XCOItems {return self.elements(0x72756e78) as! XCOItems} // "runx"
    public var schemeActionIssues: XCOItems {return self.elements(0x73616973) as! XCOItems} // "sais"
    public var schemeActionResults: XCOItems {return self.elements(0x73617274) as! XCOItems} // "sart"
    public var sourceDocuments: XCOItems {return self.elements(0x736f7566) as! XCOItems} // "souf"
    public var targets: XCOItems {return self.elements(0x74617252) as! XCOItems} // "tarR"
    public var testFailures: XCOItems {return self.elements(0x73617466) as! XCOItems} // "satf"
    public var text: XCOItems {return self.elements(0x63747874) as! XCOItems} // "ctxt"
    public var textDocuments: XCOItems {return self.elements(0x74657864) as! XCOItems} // "texd"
    public var windows: XCOItems {return self.elements(0x6377696e) as! XCOItems} // "cwin"
    public var workspaceDocuments: XCOItems {return self.elements(0x776b7364) as! XCOItems} // "wksd"
}


/******************************************************************************/
// Specifier subclasses add app-specific extensions

// beginning/end/before/after
public class XCOInsertion: SwiftAutomation.InsertionSpecifier, XCOCommand {}


// property/by-index/by-name/by-id/previous/next/first/middle/last/any
public class XCOItem: SwiftAutomation.ObjectSpecifier, XCOObject {
    public typealias InsertionSpecifierType = XCOInsertion
    public typealias ObjectSpecifierType = XCOItem
    public typealias MultipleObjectSpecifierType = XCOItems
}

// by-range/by-test/all
public class XCOItems: XCOItem, SwiftAutomation.MultipleObjectSpecifierExtension {}

// App/Con/Its
public class XCORoot: SwiftAutomation.RootSpecifier, XCOObject, SwiftAutomation.RootSpecifierExtension {
    public typealias InsertionSpecifierType = XCOInsertion
    public typealias ObjectSpecifierType = XCOItem
    public typealias MultipleObjectSpecifierType = XCOItems
    public override class var untargetedAppData: SwiftAutomation.AppData { return _untargetedAppData }
}

// Application
public class Xcode: XCORoot, SwiftAutomation.Application {
    public convenience init(launchOptions: SwiftAutomation.LaunchOptions = SwiftAutomation.DefaultLaunchOptions, relaunchMode: SwiftAutomation.RelaunchMode = SwiftAutomation.DefaultRelaunchMode) {
        self.init(rootObject: SwiftAutomation.AppRootDesc, appData: Swift.type(of:self).untargetedAppData.targetedCopy(
                  .bundleIdentifier("com.apple.dt.Xcode", true), launchOptions: launchOptions, relaunchMode: relaunchMode))
    }
}

// App/Con/Its root objects used to construct untargeted specifiers; these can be used to construct specifiers for use in commands, though cannot send commands themselves

public let XCOApp = _untargetedAppData.app as! XCORoot
public let XCOCon = _untargetedAppData.con as! XCORoot
public let XCOIts = _untargetedAppData.its as! XCORoot


/******************************************************************************/
// Static types

public typealias XCORecord = [XCOSymbol:Any] // default Swift type for AERecordDescs







