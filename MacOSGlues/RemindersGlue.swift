//
//  RemindersGlue.swift
//  Reminders.app 4.0
//  SwiftAutomation.framework 0.1.0
//  `aeglue -S 'Reminders.app'`
//


import Foundation
import SwiftAutomation


/******************************************************************************/
// Create an untargeted AppData instance for use in App, Con, Its roots,
// and in Application initializers to create targeted AppData instances.

private let _specifierFormatter = SwiftAutomation.SpecifierFormatter(applicationClassName: "Reminders",
                                                     classNamePrefix: "REM",
                                                     typeNames: [
                                                                     0x61636374: "account", // "acct"
                                                                     0x616c6973: "alias", // "alis"
                                                                     0x2a2a2a2a: "anything", // "****"
                                                                     0x62756e64: "applicationBundleId", // "bund"
                                                                     0x7369676e: "applicationSignature", // "sign"
                                                                     0x6170726c: "applicationUrl", // "aprl"
                                                                     0x61707220: "April", // "apr\0x20"
                                                                     0x61736b20: "ask", // "ask\0x20"
                                                                     0x61756720: "August", // "aug\0x20"
                                                                     0x62657374: "best", // "best"
                                                                     0x626f6479: "body", // "body"
                                                                     0x626f6f6c: "boolean", // "bool"
                                                                     0x71647274: "boundingRectangle", // "qdrt"
                                                                     0x63617365: "case_", // "case"
                                                                     0x70636c73: "class_", // "pcls"
                                                                     0x636c7274: "colorTable", // "clrt"
                                                                     0x636f6d62: "completed", // "comb"
                                                                     0x636f6d64: "completionDate", // "comd"
                                                                     0x636e7472: "container", // "cntr"
                                                                     0x61736364: "creationDate", // "ascd"
                                                                     0x74646173: "dashStyle", // "tdas"
                                                                     0x74647461: "data", // "tdta"
                                                                     0x6c647420: "date", // "ldt\0x20"
                                                                     0x64656320: "December", // "dec\0x20"
                                                                     0x6465636d: "decimalStruct", // "decm"
                                                                     0x64616374: "defaultAccount", // "dact"
                                                                     0x646c6973: "defaultList", // "dlis"
                                                                     0x64696163: "diacriticals", // "diac"
                                                                     0x636f6d70: "doubleInteger", // "comp"
                                                                     0x64756564: "dueDate", // "dued"
                                                                     0x656e6373: "encodedString", // "encs"
                                                                     0x656e756d: "enumerator", // "enum"
                                                                     0x45505320: "EPSPicture", // "EPS\0x20"
                                                                     0x65787061: "expansion", // "expa"
                                                                     0x65787465: "extendedFloat", // "exte"
                                                                     0x66656220: "February", // "feb\0x20"
                                                                     0x66737266: "fileRef", // "fsrf"
                                                                     0x66737320: "fileSpecification", // "fss\0x20"
                                                                     0x6675726c: "fileUrl", // "furl"
                                                                     0x66697864: "fixed", // "fixd"
                                                                     0x66706e74: "fixedPoint", // "fpnt"
                                                                     0x66726374: "fixedRectangle", // "frct"
                                                                     0x646f7562: "float", // "doub"
                                                                     0x6c64626c: "float128bit", // "ldbl"
                                                                     0x66726920: "Friday", // "fri\0x20"
                                                                     0x47494666: "GIFPicture", // "GIFf"
                                                                     0x63677478: "graphicText", // "cgtx"
                                                                     0x68797068: "hyphens", // "hyph"
                                                                     0x49442020: "id", // "ID\0x20\0x20"
                                                                     0x6c6f6e67: "integer", // "long"
                                                                     0x69747874: "internationalText", // "itxt"
                                                                     0x696e746c: "internationalWritingCode", // "intl"
                                                                     0x636f626a: "item", // "cobj"
                                                                     0x6a616e20: "January", // "jan\0x20"
                                                                     0x4a504547: "JPEGPicture", // "JPEG"
                                                                     0x6a756c20: "July", // "jul\0x20"
                                                                     0x6a756e20: "June", // "jun\0x20"
                                                                     0x6b706964: "kernelProcessId", // "kpid"
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
                                                                     0x61736d6f: "modificationDate", // "asmo"
                                                                     0x6d6f6e20: "Monday", // "mon\0x20"
                                                                     0x706e616d: "name", // "pnam"
                                                                     0x6e6f2020: "no", // "no\0x20\0x20"
                                                                     0x6e6f7620: "November", // "nov\0x20"
                                                                     0x6e756c6c: "null", // "null"
                                                                     0x6e756d65: "numericStrings", // "nume"
                                                                     0x6f637420: "October", // "oct\0x20"
                                                                     0x50494354: "PICTPicture", // "PICT"
                                                                     0x74706d6d: "pixelMapRecord", // "tpmm"
                                                                     0x51447074: "point", // "QDpt"
                                                                     0x7072696f: "priority", // "prio"
                                                                     0x70736e20: "processSerialNumber", // "psn\0x20"
                                                                     0x70414c4c: "properties", // "pALL"
                                                                     0x70726f70: "property_", // "prop"
                                                                     0x70756e63: "punctuation", // "punc"
                                                                     0x7265636f: "record", // "reco"
                                                                     0x6f626a20: "reference", // "obj\0x20"
                                                                     0x72656d69: "reminder", // "remi"
                                                                     0x726d6474: "remindMeDate", // "rmdt"
                                                                     0x74723136: "RGB16Color", // "tr16"
                                                                     0x74723936: "RGB96Color", // "tr96"
                                                                     0x63524742: "RGBColor", // "cRGB"
                                                                     0x74726f74: "rotation", // "trot"
                                                                     0x73617420: "Saturday", // "sat\0x20"
                                                                     0x73637074: "script", // "scpt"
                                                                     0x73657020: "September", // "sep\0x20"
                                                                     0x73696e67: "shortFloat", // "sing"
                                                                     0x73686f72: "shortInteger", // "shor"
                                                                     0x54455854: "string", // "TEXT"
                                                                     0x7374796c: "styledClipboardText", // "styl"
                                                                     0x53545854: "styledText", // "STXT"
                                                                     0x73756e20: "Sunday", // "sun\0x20"
                                                                     0x63747874: "text", // "ctxt"
                                                                     0x74737479: "textStyleInfo", // "tsty"
                                                                     0x74687520: "Thursday", // "thu\0x20"
                                                                     0x54494646: "TIFFPicture", // "TIFF"
                                                                     0x74756520: "Tuesday", // "tue\0x20"
                                                                     0x74797065: "typeClass", // "type"
                                                                     0x75747874: "unicodeText", // "utxt"
                                                                     0x6d61676e: "unsignedInteger", // "magn"
                                                                     0x75743136: "utf16Text", // "ut16"
                                                                     0x75746638: "utf8Text", // "utf8"
                                                                     0x76657273: "version", // "vers"
                                                                     0x77656420: "Wednesday", // "wed\0x20"
                                                                     0x77686974: "whitespace", // "whit"
                                                                     0x70736374: "writingCode", // "psct"
                                                                     0x79657320: "yes", // "yes\0x20"
                                                     ],
                                                     propertyNames: [
                                                                     0x626f6479: "body", // "body"
                                                                     0x70636c73: "class_", // "pcls"
                                                                     0x636f6d62: "completed", // "comb"
                                                                     0x636f6d64: "completionDate", // "comd"
                                                                     0x636e7472: "container", // "cntr"
                                                                     0x61736364: "creationDate", // "ascd"
                                                                     0x64616374: "defaultAccount", // "dact"
                                                                     0x646c6973: "defaultList", // "dlis"
                                                                     0x64756564: "dueDate", // "dued"
                                                                     0x49442020: "id", // "ID\0x20\0x20"
                                                                     0x61736d6f: "modificationDate", // "asmo"
                                                                     0x706e616d: "name", // "pnam"
                                                                     0x7072696f: "priority", // "prio"
                                                                     0x70414c4c: "properties", // "pALL"
                                                                     0x726d6474: "remindMeDate", // "rmdt"
                                                     ],
                                                     elementsNames: [
                                                                     0x61636374: "accounts", // "acct"
                                                                     0x636f626a: "items", // "cobj"
                                                                     0x6c697374: "lists", // "list"
                                                                     0x72656d69: "reminders", // "remi"
                                                     ])

private let _glueClasses = SwiftAutomation.GlueClasses(insertionSpecifierType: REMInsertion.self,
                                       objectSpecifierType: REMItem.self,
                                       multiObjectSpecifierType: REMItems.self,
                                       rootSpecifierType: REMRoot.self,
                                       applicationType: Reminders.self,
                                       symbolType: REMSymbol.self,
                                       formatter: _specifierFormatter)

private let _untargetedAppData = SwiftAutomation.AppData(glueClasses: _glueClasses)


/******************************************************************************/
// Symbol subclass defines static type/enum/property constants based on Reminders.app terminology

public class REMSymbol: SwiftAutomation.Symbol {

    override public var typeAliasName: String {return "REM"}

    public override class func symbol(code: OSType, type: OSType = typeType, descriptor: NSAppleEventDescriptor? = nil) -> REMSymbol {
        switch (code) {
        case 0x61636374: return self.account // "acct"
        case 0x616c6973: return self.alias // "alis"
        case 0x2a2a2a2a: return self.anything // "****"
        case 0x62756e64: return self.applicationBundleId // "bund"
        case 0x7369676e: return self.applicationSignature // "sign"
        case 0x6170726c: return self.applicationUrl // "aprl"
        case 0x61707220: return self.April // "apr\0x20"
        case 0x61736b20: return self.ask // "ask\0x20"
        case 0x61756720: return self.August // "aug\0x20"
        case 0x62657374: return self.best // "best"
        case 0x626f6479: return self.body // "body"
        case 0x626f6f6c: return self.boolean // "bool"
        case 0x71647274: return self.boundingRectangle // "qdrt"
        case 0x63617365: return self.case_ // "case"
        case 0x70636c73: return self.class_ // "pcls"
        case 0x636c7274: return self.colorTable // "clrt"
        case 0x636f6d62: return self.completed // "comb"
        case 0x636f6d64: return self.completionDate // "comd"
        case 0x636e7472: return self.container // "cntr"
        case 0x61736364: return self.creationDate // "ascd"
        case 0x74646173: return self.dashStyle // "tdas"
        case 0x74647461: return self.data // "tdta"
        case 0x6c647420: return self.date // "ldt\0x20"
        case 0x64656320: return self.December // "dec\0x20"
        case 0x6465636d: return self.decimalStruct // "decm"
        case 0x64616374: return self.defaultAccount // "dact"
        case 0x646c6973: return self.defaultList // "dlis"
        case 0x64696163: return self.diacriticals // "diac"
        case 0x636f6d70: return self.doubleInteger // "comp"
        case 0x64756564: return self.dueDate // "dued"
        case 0x656e6373: return self.encodedString // "encs"
        case 0x656e756d: return self.enumerator // "enum"
        case 0x45505320: return self.EPSPicture // "EPS\0x20"
        case 0x65787061: return self.expansion // "expa"
        case 0x65787465: return self.extendedFloat // "exte"
        case 0x66656220: return self.February // "feb\0x20"
        case 0x66737266: return self.fileRef // "fsrf"
        case 0x66737320: return self.fileSpecification // "fss\0x20"
        case 0x6675726c: return self.fileUrl // "furl"
        case 0x66697864: return self.fixed // "fixd"
        case 0x66706e74: return self.fixedPoint // "fpnt"
        case 0x66726374: return self.fixedRectangle // "frct"
        case 0x646f7562: return self.float // "doub"
        case 0x6c64626c: return self.float128bit // "ldbl"
        case 0x66726920: return self.Friday // "fri\0x20"
        case 0x47494666: return self.GIFPicture // "GIFf"
        case 0x63677478: return self.graphicText // "cgtx"
        case 0x68797068: return self.hyphens // "hyph"
        case 0x49442020: return self.id // "ID\0x20\0x20"
        case 0x6c6f6e67: return self.integer // "long"
        case 0x69747874: return self.internationalText // "itxt"
        case 0x696e746c: return self.internationalWritingCode // "intl"
        case 0x636f626a: return self.item // "cobj"
        case 0x6a616e20: return self.January // "jan\0x20"
        case 0x4a504547: return self.JPEGPicture // "JPEG"
        case 0x6a756c20: return self.July // "jul\0x20"
        case 0x6a756e20: return self.June // "jun\0x20"
        case 0x6b706964: return self.kernelProcessId // "kpid"
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
        case 0x61736d6f: return self.modificationDate // "asmo"
        case 0x6d6f6e20: return self.Monday // "mon\0x20"
        case 0x706e616d: return self.name // "pnam"
        case 0x6e6f2020: return self.no // "no\0x20\0x20"
        case 0x6e6f7620: return self.November // "nov\0x20"
        case 0x6e756c6c: return self.null // "null"
        case 0x6e756d65: return self.numericStrings // "nume"
        case 0x6f637420: return self.October // "oct\0x20"
        case 0x50494354: return self.PICTPicture // "PICT"
        case 0x74706d6d: return self.pixelMapRecord // "tpmm"
        case 0x51447074: return self.point // "QDpt"
        case 0x7072696f: return self.priority // "prio"
        case 0x70736e20: return self.processSerialNumber // "psn\0x20"
        case 0x70414c4c: return self.properties // "pALL"
        case 0x70726f70: return self.property_ // "prop"
        case 0x70756e63: return self.punctuation // "punc"
        case 0x7265636f: return self.record // "reco"
        case 0x6f626a20: return self.reference // "obj\0x20"
        case 0x72656d69: return self.reminder // "remi"
        case 0x726d6474: return self.remindMeDate // "rmdt"
        case 0x74723136: return self.RGB16Color // "tr16"
        case 0x74723936: return self.RGB96Color // "tr96"
        case 0x63524742: return self.RGBColor // "cRGB"
        case 0x74726f74: return self.rotation // "trot"
        case 0x73617420: return self.Saturday // "sat\0x20"
        case 0x73637074: return self.script // "scpt"
        case 0x73657020: return self.September // "sep\0x20"
        case 0x73696e67: return self.shortFloat // "sing"
        case 0x73686f72: return self.shortInteger // "shor"
        case 0x54455854: return self.string // "TEXT"
        case 0x7374796c: return self.styledClipboardText // "styl"
        case 0x53545854: return self.styledText // "STXT"
        case 0x73756e20: return self.Sunday // "sun\0x20"
        case 0x63747874: return self.text // "ctxt"
        case 0x74737479: return self.textStyleInfo // "tsty"
        case 0x74687520: return self.Thursday // "thu\0x20"
        case 0x54494646: return self.TIFFPicture // "TIFF"
        case 0x74756520: return self.Tuesday // "tue\0x20"
        case 0x74797065: return self.typeClass // "type"
        case 0x75747874: return self.unicodeText // "utxt"
        case 0x6d61676e: return self.unsignedInteger // "magn"
        case 0x75743136: return self.utf16Text // "ut16"
        case 0x75746638: return self.utf8Text // "utf8"
        case 0x76657273: return self.version // "vers"
        case 0x77656420: return self.Wednesday // "wed\0x20"
        case 0x77686974: return self.whitespace // "whit"
        case 0x70736374: return self.writingCode // "psct"
        case 0x79657320: return self.yes // "yes\0x20"
        default: return super.symbol(code: code, type: type, descriptor: descriptor) as! REMSymbol
        }
    }

    // Types/properties
    public static let account = REMSymbol(name: "account", code: 0x61636374, type: typeType) // "acct"
    public static let alias = REMSymbol(name: "alias", code: 0x616c6973, type: typeType) // "alis"
    public static let anything = REMSymbol(name: "anything", code: 0x2a2a2a2a, type: typeType) // "****"
    public static let applicationBundleId = REMSymbol(name: "applicationBundleId", code: 0x62756e64, type: typeType) // "bund"
    public static let applicationSignature = REMSymbol(name: "applicationSignature", code: 0x7369676e, type: typeType) // "sign"
    public static let applicationUrl = REMSymbol(name: "applicationUrl", code: 0x6170726c, type: typeType) // "aprl"
    public static let April = REMSymbol(name: "April", code: 0x61707220, type: typeType) // "apr\0x20"
    public static let August = REMSymbol(name: "August", code: 0x61756720, type: typeType) // "aug\0x20"
    public static let best = REMSymbol(name: "best", code: 0x62657374, type: typeType) // "best"
    public static let body = REMSymbol(name: "body", code: 0x626f6479, type: typeType) // "body"
    public static let boolean = REMSymbol(name: "boolean", code: 0x626f6f6c, type: typeType) // "bool"
    public static let boundingRectangle = REMSymbol(name: "boundingRectangle", code: 0x71647274, type: typeType) // "qdrt"
    public static let class_ = REMSymbol(name: "class_", code: 0x70636c73, type: typeType) // "pcls"
    public static let colorTable = REMSymbol(name: "colorTable", code: 0x636c7274, type: typeType) // "clrt"
    public static let completed = REMSymbol(name: "completed", code: 0x636f6d62, type: typeType) // "comb"
    public static let completionDate = REMSymbol(name: "completionDate", code: 0x636f6d64, type: typeType) // "comd"
    public static let container = REMSymbol(name: "container", code: 0x636e7472, type: typeType) // "cntr"
    public static let creationDate = REMSymbol(name: "creationDate", code: 0x61736364, type: typeType) // "ascd"
    public static let dashStyle = REMSymbol(name: "dashStyle", code: 0x74646173, type: typeType) // "tdas"
    public static let data = REMSymbol(name: "data", code: 0x74647461, type: typeType) // "tdta"
    public static let date = REMSymbol(name: "date", code: 0x6c647420, type: typeType) // "ldt\0x20"
    public static let December = REMSymbol(name: "December", code: 0x64656320, type: typeType) // "dec\0x20"
    public static let decimalStruct = REMSymbol(name: "decimalStruct", code: 0x6465636d, type: typeType) // "decm"
    public static let defaultAccount = REMSymbol(name: "defaultAccount", code: 0x64616374, type: typeType) // "dact"
    public static let defaultList = REMSymbol(name: "defaultList", code: 0x646c6973, type: typeType) // "dlis"
    public static let doubleInteger = REMSymbol(name: "doubleInteger", code: 0x636f6d70, type: typeType) // "comp"
    public static let dueDate = REMSymbol(name: "dueDate", code: 0x64756564, type: typeType) // "dued"
    public static let encodedString = REMSymbol(name: "encodedString", code: 0x656e6373, type: typeType) // "encs"
    public static let enumerator = REMSymbol(name: "enumerator", code: 0x656e756d, type: typeType) // "enum"
    public static let EPSPicture = REMSymbol(name: "EPSPicture", code: 0x45505320, type: typeType) // "EPS\0x20"
    public static let extendedFloat = REMSymbol(name: "extendedFloat", code: 0x65787465, type: typeType) // "exte"
    public static let February = REMSymbol(name: "February", code: 0x66656220, type: typeType) // "feb\0x20"
    public static let fileRef = REMSymbol(name: "fileRef", code: 0x66737266, type: typeType) // "fsrf"
    public static let fileSpecification = REMSymbol(name: "fileSpecification", code: 0x66737320, type: typeType) // "fss\0x20"
    public static let fileUrl = REMSymbol(name: "fileUrl", code: 0x6675726c, type: typeType) // "furl"
    public static let fixed = REMSymbol(name: "fixed", code: 0x66697864, type: typeType) // "fixd"
    public static let fixedPoint = REMSymbol(name: "fixedPoint", code: 0x66706e74, type: typeType) // "fpnt"
    public static let fixedRectangle = REMSymbol(name: "fixedRectangle", code: 0x66726374, type: typeType) // "frct"
    public static let float = REMSymbol(name: "float", code: 0x646f7562, type: typeType) // "doub"
    public static let float128bit = REMSymbol(name: "float128bit", code: 0x6c64626c, type: typeType) // "ldbl"
    public static let Friday = REMSymbol(name: "Friday", code: 0x66726920, type: typeType) // "fri\0x20"
    public static let GIFPicture = REMSymbol(name: "GIFPicture", code: 0x47494666, type: typeType) // "GIFf"
    public static let graphicText = REMSymbol(name: "graphicText", code: 0x63677478, type: typeType) // "cgtx"
    public static let id = REMSymbol(name: "id", code: 0x49442020, type: typeType) // "ID\0x20\0x20"
    public static let integer = REMSymbol(name: "integer", code: 0x6c6f6e67, type: typeType) // "long"
    public static let internationalText = REMSymbol(name: "internationalText", code: 0x69747874, type: typeType) // "itxt"
    public static let internationalWritingCode = REMSymbol(name: "internationalWritingCode", code: 0x696e746c, type: typeType) // "intl"
    public static let item = REMSymbol(name: "item", code: 0x636f626a, type: typeType) // "cobj"
    public static let January = REMSymbol(name: "January", code: 0x6a616e20, type: typeType) // "jan\0x20"
    public static let JPEGPicture = REMSymbol(name: "JPEGPicture", code: 0x4a504547, type: typeType) // "JPEG"
    public static let July = REMSymbol(name: "July", code: 0x6a756c20, type: typeType) // "jul\0x20"
    public static let June = REMSymbol(name: "June", code: 0x6a756e20, type: typeType) // "jun\0x20"
    public static let kernelProcessId = REMSymbol(name: "kernelProcessId", code: 0x6b706964, type: typeType) // "kpid"
    public static let list = REMSymbol(name: "list", code: 0x6c697374, type: typeType) // "list"
    public static let locationReference = REMSymbol(name: "locationReference", code: 0x696e736c, type: typeType) // "insl"
    public static let longFixed = REMSymbol(name: "longFixed", code: 0x6c667864, type: typeType) // "lfxd"
    public static let longFixedPoint = REMSymbol(name: "longFixedPoint", code: 0x6c667074, type: typeType) // "lfpt"
    public static let longFixedRectangle = REMSymbol(name: "longFixedRectangle", code: 0x6c667263, type: typeType) // "lfrc"
    public static let longPoint = REMSymbol(name: "longPoint", code: 0x6c706e74, type: typeType) // "lpnt"
    public static let longRectangle = REMSymbol(name: "longRectangle", code: 0x6c726374, type: typeType) // "lrct"
    public static let machine = REMSymbol(name: "machine", code: 0x6d616368, type: typeType) // "mach"
    public static let machineLocation = REMSymbol(name: "machineLocation", code: 0x6d4c6f63, type: typeType) // "mLoc"
    public static let machPort = REMSymbol(name: "machPort", code: 0x706f7274, type: typeType) // "port"
    public static let March = REMSymbol(name: "March", code: 0x6d617220, type: typeType) // "mar\0x20"
    public static let May = REMSymbol(name: "May", code: 0x6d617920, type: typeType) // "may\0x20"
    public static let modificationDate = REMSymbol(name: "modificationDate", code: 0x61736d6f, type: typeType) // "asmo"
    public static let Monday = REMSymbol(name: "Monday", code: 0x6d6f6e20, type: typeType) // "mon\0x20"
    public static let name = REMSymbol(name: "name", code: 0x706e616d, type: typeType) // "pnam"
    public static let November = REMSymbol(name: "November", code: 0x6e6f7620, type: typeType) // "nov\0x20"
    public static let null = REMSymbol(name: "null", code: 0x6e756c6c, type: typeType) // "null"
    public static let October = REMSymbol(name: "October", code: 0x6f637420, type: typeType) // "oct\0x20"
    public static let PICTPicture = REMSymbol(name: "PICTPicture", code: 0x50494354, type: typeType) // "PICT"
    public static let pixelMapRecord = REMSymbol(name: "pixelMapRecord", code: 0x74706d6d, type: typeType) // "tpmm"
    public static let point = REMSymbol(name: "point", code: 0x51447074, type: typeType) // "QDpt"
    public static let priority = REMSymbol(name: "priority", code: 0x7072696f, type: typeType) // "prio"
    public static let processSerialNumber = REMSymbol(name: "processSerialNumber", code: 0x70736e20, type: typeType) // "psn\0x20"
    public static let properties = REMSymbol(name: "properties", code: 0x70414c4c, type: typeType) // "pALL"
    public static let property_ = REMSymbol(name: "property_", code: 0x70726f70, type: typeType) // "prop"
    public static let record = REMSymbol(name: "record", code: 0x7265636f, type: typeType) // "reco"
    public static let reference = REMSymbol(name: "reference", code: 0x6f626a20, type: typeType) // "obj\0x20"
    public static let reminder = REMSymbol(name: "reminder", code: 0x72656d69, type: typeType) // "remi"
    public static let remindMeDate = REMSymbol(name: "remindMeDate", code: 0x726d6474, type: typeType) // "rmdt"
    public static let RGB16Color = REMSymbol(name: "RGB16Color", code: 0x74723136, type: typeType) // "tr16"
    public static let RGB96Color = REMSymbol(name: "RGB96Color", code: 0x74723936, type: typeType) // "tr96"
    public static let RGBColor = REMSymbol(name: "RGBColor", code: 0x63524742, type: typeType) // "cRGB"
    public static let rotation = REMSymbol(name: "rotation", code: 0x74726f74, type: typeType) // "trot"
    public static let Saturday = REMSymbol(name: "Saturday", code: 0x73617420, type: typeType) // "sat\0x20"
    public static let script = REMSymbol(name: "script", code: 0x73637074, type: typeType) // "scpt"
    public static let September = REMSymbol(name: "September", code: 0x73657020, type: typeType) // "sep\0x20"
    public static let shortFloat = REMSymbol(name: "shortFloat", code: 0x73696e67, type: typeType) // "sing"
    public static let shortInteger = REMSymbol(name: "shortInteger", code: 0x73686f72, type: typeType) // "shor"
    public static let string = REMSymbol(name: "string", code: 0x54455854, type: typeType) // "TEXT"
    public static let styledClipboardText = REMSymbol(name: "styledClipboardText", code: 0x7374796c, type: typeType) // "styl"
    public static let styledText = REMSymbol(name: "styledText", code: 0x53545854, type: typeType) // "STXT"
    public static let Sunday = REMSymbol(name: "Sunday", code: 0x73756e20, type: typeType) // "sun\0x20"
    public static let textStyleInfo = REMSymbol(name: "textStyleInfo", code: 0x74737479, type: typeType) // "tsty"
    public static let Thursday = REMSymbol(name: "Thursday", code: 0x74687520, type: typeType) // "thu\0x20"
    public static let TIFFPicture = REMSymbol(name: "TIFFPicture", code: 0x54494646, type: typeType) // "TIFF"
    public static let Tuesday = REMSymbol(name: "Tuesday", code: 0x74756520, type: typeType) // "tue\0x20"
    public static let typeClass = REMSymbol(name: "typeClass", code: 0x74797065, type: typeType) // "type"
    public static let unicodeText = REMSymbol(name: "unicodeText", code: 0x75747874, type: typeType) // "utxt"
    public static let unsignedInteger = REMSymbol(name: "unsignedInteger", code: 0x6d61676e, type: typeType) // "magn"
    public static let utf16Text = REMSymbol(name: "utf16Text", code: 0x75743136, type: typeType) // "ut16"
    public static let utf8Text = REMSymbol(name: "utf8Text", code: 0x75746638, type: typeType) // "utf8"
    public static let version = REMSymbol(name: "version", code: 0x76657273, type: typeType) // "vers"
    public static let Wednesday = REMSymbol(name: "Wednesday", code: 0x77656420, type: typeType) // "wed\0x20"
    public static let writingCode = REMSymbol(name: "writingCode", code: 0x70736374, type: typeType) // "psct"

    // Enumerators
    public static let ask = REMSymbol(name: "ask", code: 0x61736b20, type: typeEnumerated) // "ask\0x20"
    public static let case_ = REMSymbol(name: "case_", code: 0x63617365, type: typeEnumerated) // "case"
    public static let diacriticals = REMSymbol(name: "diacriticals", code: 0x64696163, type: typeEnumerated) // "diac"
    public static let expansion = REMSymbol(name: "expansion", code: 0x65787061, type: typeEnumerated) // "expa"
    public static let hyphens = REMSymbol(name: "hyphens", code: 0x68797068, type: typeEnumerated) // "hyph"
    public static let no = REMSymbol(name: "no", code: 0x6e6f2020, type: typeEnumerated) // "no\0x20\0x20"
    public static let numericStrings = REMSymbol(name: "numericStrings", code: 0x6e756d65, type: typeEnumerated) // "nume"
    public static let punctuation = REMSymbol(name: "punctuation", code: 0x70756e63, type: typeEnumerated) // "punc"
    public static let text = REMSymbol(name: "text", code: 0x63747874, type: typeEnumerated) // "ctxt"
    public static let whitespace = REMSymbol(name: "whitespace", code: 0x77686974, type: typeEnumerated) // "whit"
    public static let yes = REMSymbol(name: "yes", code: 0x79657320, type: typeEnumerated) // "yes\0x20"
}

public typealias REM = REMSymbol // allows symbols to be written as (e.g.) REM.name instead of REMSymbol.name


/******************************************************************************/
// Specifier extensions; these add command methods and property/elements getters based on Reminders.app terminology

public protocol REMCommand: SwiftAutomation.SpecifierProtocol {} // provides AE dispatch methods

// Command->Any will be bound when return type can't be inferred, else Command->T

extension REMCommand {
    @discardableResult public func activate(_ directParameter: Any = SwiftAutomation.NoParameter,
            resultType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "activate", eventClass: 0x6d697363, eventID: 0x61637476, // "misc"/"actv"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: resultType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func activate<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            resultType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "activate", eventClass: 0x6d697363, eventID: 0x61637476, // "misc"/"actv"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: resultType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func get(_ directParameter: Any = SwiftAutomation.NoParameter,
            resultType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "get", eventClass: 0x636f7265, eventID: 0x67657464, // "core"/"getd"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: resultType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func get<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            resultType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "get", eventClass: 0x636f7265, eventID: 0x67657464, // "core"/"getd"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: resultType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func GetURL(_ directParameter: Any = SwiftAutomation.NoParameter,
            resultType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "GetURL", eventClass: 0x4755524c, eventID: 0x4755524c, // "GURL"/"GURL"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: resultType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func GetURL<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            resultType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "GetURL", eventClass: 0x4755524c, eventID: 0x4755524c, // "GURL"/"GURL"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: resultType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func open(_ directParameter: Any = SwiftAutomation.NoParameter,
            resultType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "open", eventClass: 0x61657674, eventID: 0x6f646f63, // "aevt"/"odoc"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: resultType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func open<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            resultType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "open", eventClass: 0x61657674, eventID: 0x6f646f63, // "aevt"/"odoc"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: resultType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func openLocation(_ directParameter: Any = SwiftAutomation.NoParameter,
            window: Any = SwiftAutomation.NoParameter,
            resultType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "openLocation", eventClass: 0x4755524c, eventID: 0x4755524c, // "GURL"/"GURL"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("window", 0x57494e44, window), // "WIND"
                ], requestedType: resultType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func openLocation<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            window: Any = SwiftAutomation.NoParameter,
            resultType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "openLocation", eventClass: 0x4755524c, eventID: 0x4755524c, // "GURL"/"GURL"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("window", 0x57494e44, window), // "WIND"
                ], requestedType: resultType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func print(_ directParameter: Any = SwiftAutomation.NoParameter,
            resultType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "print", eventClass: 0x61657674, eventID: 0x70646f63, // "aevt"/"pdoc"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: resultType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func print<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            resultType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "print", eventClass: 0x61657674, eventID: 0x70646f63, // "aevt"/"pdoc"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: resultType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func quit(_ directParameter: Any = SwiftAutomation.NoParameter,
            saving: Any = SwiftAutomation.NoParameter,
            resultType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "quit", eventClass: 0x61657674, eventID: 0x71756974, // "aevt"/"quit"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("saving", 0x7361766f, saving), // "savo"
                ], requestedType: resultType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func quit<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            saving: Any = SwiftAutomation.NoParameter,
            resultType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "quit", eventClass: 0x61657674, eventID: 0x71756974, // "aevt"/"quit"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("saving", 0x7361766f, saving), // "savo"
                ], requestedType: resultType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func reopen(_ directParameter: Any = SwiftAutomation.NoParameter,
            resultType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "reopen", eventClass: 0x61657674, eventID: 0x72617070, // "aevt"/"rapp"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: resultType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func reopen<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            resultType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "reopen", eventClass: 0x61657674, eventID: 0x72617070, // "aevt"/"rapp"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: resultType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func run(_ directParameter: Any = SwiftAutomation.NoParameter,
            resultType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "run", eventClass: 0x61657674, eventID: 0x6f617070, // "aevt"/"oapp"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: resultType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func run<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            resultType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "run", eventClass: 0x61657674, eventID: 0x6f617070, // "aevt"/"oapp"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: resultType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func set(_ directParameter: Any = SwiftAutomation.NoParameter,
            to: Any = SwiftAutomation.NoParameter,
            resultType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "set", eventClass: 0x636f7265, eventID: 0x73657464, // "core"/"setd"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x64617461, to), // "data"
                ], requestedType: resultType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func set<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            to: Any = SwiftAutomation.NoParameter,
            resultType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "set", eventClass: 0x636f7265, eventID: 0x73657464, // "core"/"setd"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x64617461, to), // "data"
                ], requestedType: resultType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func show(_ directParameter: Any = SwiftAutomation.NoParameter,
            resultType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "show", eventClass: 0x72656d69, eventID: 0x73686f77, // "remi"/"show"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: resultType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func show<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            resultType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "show", eventClass: 0x72656d69, eventID: 0x73686f77, // "remi"/"show"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: resultType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
}


public protocol REMObject: SwiftAutomation.ObjectSpecifierExtension, REMCommand {} // provides vars and methods for constructing specifiers

extension REMObject {
    
    // Properties
    public var body: REMItem {return self.property(0x626f6479) as! REMItem} // "body"
    public var class_: REMItem {return self.property(0x70636c73) as! REMItem} // "pcls"
    public var completed: REMItem {return self.property(0x636f6d62) as! REMItem} // "comb"
    public var completionDate: REMItem {return self.property(0x636f6d64) as! REMItem} // "comd"
    public var container: REMItem {return self.property(0x636e7472) as! REMItem} // "cntr"
    public var creationDate: REMItem {return self.property(0x61736364) as! REMItem} // "ascd"
    public var defaultAccount: REMItem {return self.property(0x64616374) as! REMItem} // "dact"
    public var defaultList: REMItem {return self.property(0x646c6973) as! REMItem} // "dlis"
    public var dueDate: REMItem {return self.property(0x64756564) as! REMItem} // "dued"
    public var id: REMItem {return self.property(0x49442020) as! REMItem} // "ID\0x20\0x20"
    public var modificationDate: REMItem {return self.property(0x61736d6f) as! REMItem} // "asmo"
    public var name: REMItem {return self.property(0x706e616d) as! REMItem} // "pnam"
    public var priority: REMItem {return self.property(0x7072696f) as! REMItem} // "prio"
    public var properties: REMItem {return self.property(0x70414c4c) as! REMItem} // "pALL"
    public var remindMeDate: REMItem {return self.property(0x726d6474) as! REMItem} // "rmdt"

    // Elements
    public var accounts: REMItems {return self.elements(0x61636374) as! REMItems} // "acct"
    public var items: REMItems {return self.elements(0x636f626a) as! REMItems} // "cobj"
    public var lists: REMItems {return self.elements(0x6c697374) as! REMItems} // "list"
    public var reminders: REMItems {return self.elements(0x72656d69) as! REMItems} // "remi"
}


/******************************************************************************/
// Specifier subclasses add app-specific extensions

// beginning/end/before/after
public class REMInsertion: SwiftAutomation.InsertionSpecifier, REMCommand {}


// property/by-index/by-name/by-id/previous/next/first/middle/last/any
public class REMItem: SwiftAutomation.ObjectSpecifier, REMObject {
    public typealias InsertionSpecifierType = REMInsertion
    public typealias ObjectSpecifierType = REMItem
    public typealias MultipleObjectSpecifierType = REMItems
}

// by-range/by-test/all
public class REMItems: REMItem, SwiftAutomation.ElementsSpecifierExtension {}

// App/Con/Its
public class REMRoot: SwiftAutomation.RootSpecifier, REMObject, SwiftAutomation.RootSpecifierExtension {
    public typealias InsertionSpecifierType = REMInsertion
    public typealias ObjectSpecifierType = REMItem
    public typealias MultipleObjectSpecifierType = REMItems
    public override class var untargetedAppData: SwiftAutomation.AppData { return _untargetedAppData }
}

// Application
public class Reminders: REMRoot, SwiftAutomation.Application {
    public convenience init(launchOptions: SwiftAutomation.LaunchOptions = SwiftAutomation.DefaultLaunchOptions, relaunchMode: SwiftAutomation.RelaunchMode = SwiftAutomation.DefaultRelaunchMode) {
        self.init(rootObject: SwiftAutomation.AppRootDesc, appData: type(of:self).untargetedAppData.targetedCopy(
                  .bundleIdentifier("com.apple.reminders", true), launchOptions: launchOptions, relaunchMode: relaunchMode))
    }
}

// App/Con/Its root objects used to construct untargeted specifiers; these can be used to construct specifiers for use in commands, though cannot send commands themselves

public let REMApp = _untargetedAppData.app as! REMRoot
public let REMCon = _untargetedAppData.con as! REMRoot
public let REMIts = _untargetedAppData.its as! REMRoot


/******************************************************************************/
// Static types

public typealias REMRecord = [REMSymbol:Any] // default Swift type for AERecordDescs







