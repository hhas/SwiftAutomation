//
//  BluetoothFileExchangeGlue.swift
//  Bluetooth File Exchange.app 6.0.11
//  SwiftAutomation.framework 0.1.0
//  `aeglue 'Bluetooth File Exchange.app'`
//


import Foundation
import AppleEvents
import SwiftAutomation


/******************************************************************************/
// Create an untargeted AppData instance for use in App, Con, Its roots,
// and in Application initializers to create targeted AppData instances.

private let _specifierFormatter = SwiftAutomation.SpecifierFormatter(
        applicationClassName: "BluetoothFileExchange",
        classNamePrefix: "BFE",
        typeNames: [
                0x616c6973: "alias", // "alis"
                0x2a2a2a2a: "anything", // "****"
                0x62756e64: "applicationBundleID", // "bund"
                0x7369676e: "applicationSignature", // "sign"
                0x6170726c: "applicationURL", // "aprl"
                0x61707220: "April", // "apr "
                0x61736b20: "ask", // "ask "
                0x61756720: "August", // "aug "
                0x62657374: "best", // "best"
                0x626d726b: "bookmarkData", // "bmrk"
                0x626f6f6c: "boolean", // "bool"
                0x71647274: "boundingRectangle", // "qdrt"
                0x63617365: "case_", // "case"
                0x70636c73: "class_", // "pcls"
                0x636c7274: "colorTable", // "clrt"
                0x656e756d: "constant", // "enum"
                0x74646173: "dashStyle", // "tdas"
                0x74647461: "data", // "tdta"
                0x6c647420: "date", // "ldt "
                0x64656320: "December", // "dec "
                0x6465636d: "decimalStruct", // "decm"
                0x64696163: "diacriticals", // "diac"
                0x636f6d70: "doubleInteger", // "comp"
                0x656e6373: "encodedString", // "encs"
                0x45505320: "EPSPicture", // "EPS "
                0x65787061: "expansion", // "expa"
                0x66656220: "February", // "feb "
                0x66737266: "fileRef", // "fsrf"
                0x6675726c: "fileURL", // "furl"
                0x66697864: "fixed", // "fixd"
                0x66706e74: "fixedPoint", // "fpnt"
                0x66726374: "fixedRectangle", // "frct"
                0x66726920: "Friday", // "fri "
                0x47494666: "GIFPicture", // "GIFf"
                0x63677478: "graphicText", // "cgtx"
                0x68797068: "hyphens", // "hyph"
                0x49442020: "id", // "ID  "
                0x6c6f6e67: "integer", // "long"
                0x69747874: "internationalText", // "itxt"
                0x696e746c: "internationalWritingCode", // "intl"
                0x636f626a: "item", // "cobj"
                0x6a616e20: "January", // "jan "
                0x4a504547: "JPEGPicture", // "JPEG"
                0x6a756c20: "July", // "jul "
                0x6a756e20: "June", // "jun "
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
                0x6d617220: "March", // "mar "
                0x6d617920: "May", // "may "
                0x6d6f6e20: "Monday", // "mon "
                0x6e6f2020: "no", // "no  "
                0x6e6f7620: "November", // "nov "
                0x6e756c6c: "null", // "null"
                0x6e756d65: "numericStrings", // "nume"
                0x6f637420: "October", // "oct "
                0x50494354: "PICTPicture", // "PICT"
                0x74706d6d: "pixelMapRecord", // "tpmm"
                0x51447074: "point", // "QDpt"
                0x70736e20: "processSerialNumber", // "psn "
                0x70414c4c: "properties", // "pALL"
                0x70726f70: "property_", // "prop"
                0x70756e63: "punctuation", // "punc"
                0x646f7562: "real", // "doub"
                0x7265636f: "record", // "reco"
                0x6f626a20: "reference", // "obj "
                0x74723136: "RGB16Color", // "tr16"
                0x74723936: "RGB96Color", // "tr96"
                0x63524742: "RGBColor", // "cRGB"
                0x74726f74: "rotation", // "trot"
                0x73617420: "Saturday", // "sat "
                0x73637074: "script", // "scpt"
                0x73657020: "September", // "sep "
                0x73686f72: "shortInteger", // "shor"
                0x73696e67: "smallReal", // "sing"
                0x54455854: "string", // "TEXT"
                0x7374796c: "styledClipboardText", // "styl"
                0x53545854: "styledText", // "STXT"
                0x73756e20: "Sunday", // "sun "
                0x74737479: "textStyleInfo", // "tsty"
                0x74687520: "Thursday", // "thu "
                0x54494646: "TIFFPicture", // "TIFF"
                0x74756520: "Tuesday", // "tue "
                0x74797065: "typeClass", // "type"
                0x75747874: "UnicodeText", // "utxt"
                0x75636f6d: "unsignedDoubleInteger", // "ucom"
                0x6d61676e: "unsignedInteger", // "magn"
                0x75736872: "unsignedShortInteger", // "ushr"
                0x75743136: "UTF16Text", // "ut16"
                0x75746638: "UTF8Text", // "utf8"
                0x76657273: "version", // "vers"
                0x77656420: "Wednesday", // "wed "
                0x77686974: "whitespace", // "whit"
                0x70736374: "writingCode", // "psct"
                0x79657320: "yes", // "yes "
        ],
        propertyNames: [
                0x70636c73: "class_", // "pcls"
                0x49442020: "id", // "ID  "
                0x70414c4c: "properties", // "pALL"
        ],
        elementsNames: [
                0x636f626a: ("item", "items"), // "cobj"
        ])

private let _glueClasses = SwiftAutomation.GlueClasses(
                                                insertionSpecifierType: BFEInsertion.self,
                                                objectSpecifierType: BFEItem.self,
                                                multiObjectSpecifierType: BFEItems.self,
                                                rootSpecifierType: BFERoot.self,
                                                applicationType: BluetoothFileExchange.self,
                                                symbolType: BFESymbol.self,
                                                formatter: _specifierFormatter)

private let _untargetedAppData = SwiftAutomation.AppData(glueClasses: _glueClasses)


/******************************************************************************/
// Symbol subclass defines static type/enum/property constants based on Bluetooth File Exchange.app terminology

public class BFESymbol: SwiftAutomation.Symbol {

    override public var typeAliasName: String {return "BFE"}

    public override class func symbol(code: OSType, type: OSType = typeType, descriptor: ScalarDescriptor? = nil) -> BFESymbol {
        switch (code) {
        case 0x616c6973: return self.alias // "alis"
        case 0x2a2a2a2a: return self.anything // "****"
        case 0x62756e64: return self.applicationBundleID // "bund"
        case 0x7369676e: return self.applicationSignature // "sign"
        case 0x6170726c: return self.applicationURL // "aprl"
        case 0x61707220: return self.April // "apr "
        case 0x61736b20: return self.ask // "ask "
        case 0x61756720: return self.August // "aug "
        case 0x62657374: return self.best // "best"
        case 0x626d726b: return self.bookmarkData // "bmrk"
        case 0x626f6f6c: return self.boolean // "bool"
        case 0x71647274: return self.boundingRectangle // "qdrt"
        case 0x63617365: return self.case_ // "case"
        case 0x70636c73: return self.class_ // "pcls"
        case 0x636c7274: return self.colorTable // "clrt"
        case 0x656e756d: return self.constant // "enum"
        case 0x74646173: return self.dashStyle // "tdas"
        case 0x74647461: return self.data // "tdta"
        case 0x6c647420: return self.date // "ldt "
        case 0x64656320: return self.December // "dec "
        case 0x6465636d: return self.decimalStruct // "decm"
        case 0x64696163: return self.diacriticals // "diac"
        case 0x636f6d70: return self.doubleInteger // "comp"
        case 0x656e6373: return self.encodedString // "encs"
        case 0x45505320: return self.EPSPicture // "EPS "
        case 0x65787061: return self.expansion // "expa"
        case 0x66656220: return self.February // "feb "
        case 0x66737266: return self.fileRef // "fsrf"
        case 0x6675726c: return self.fileURL // "furl"
        case 0x66697864: return self.fixed // "fixd"
        case 0x66706e74: return self.fixedPoint // "fpnt"
        case 0x66726374: return self.fixedRectangle // "frct"
        case 0x66726920: return self.Friday // "fri "
        case 0x47494666: return self.GIFPicture // "GIFf"
        case 0x63677478: return self.graphicText // "cgtx"
        case 0x68797068: return self.hyphens // "hyph"
        case 0x49442020: return self.id // "ID  "
        case 0x6c6f6e67: return self.integer // "long"
        case 0x69747874: return self.internationalText // "itxt"
        case 0x696e746c: return self.internationalWritingCode // "intl"
        case 0x636f626a: return self.item // "cobj"
        case 0x6a616e20: return self.January // "jan "
        case 0x4a504547: return self.JPEGPicture // "JPEG"
        case 0x6a756c20: return self.July // "jul "
        case 0x6a756e20: return self.June // "jun "
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
        case 0x6d617220: return self.March // "mar "
        case 0x6d617920: return self.May // "may "
        case 0x6d6f6e20: return self.Monday // "mon "
        case 0x6e6f2020: return self.no // "no  "
        case 0x6e6f7620: return self.November // "nov "
        case 0x6e756c6c: return self.null // "null"
        case 0x6e756d65: return self.numericStrings // "nume"
        case 0x6f637420: return self.October // "oct "
        case 0x50494354: return self.PICTPicture // "PICT"
        case 0x74706d6d: return self.pixelMapRecord // "tpmm"
        case 0x51447074: return self.point // "QDpt"
        case 0x70736e20: return self.processSerialNumber // "psn "
        case 0x70414c4c: return self.properties // "pALL"
        case 0x70726f70: return self.property_ // "prop"
        case 0x70756e63: return self.punctuation // "punc"
        case 0x646f7562: return self.real // "doub"
        case 0x7265636f: return self.record // "reco"
        case 0x6f626a20: return self.reference // "obj "
        case 0x74723136: return self.RGB16Color // "tr16"
        case 0x74723936: return self.RGB96Color // "tr96"
        case 0x63524742: return self.RGBColor // "cRGB"
        case 0x74726f74: return self.rotation // "trot"
        case 0x73617420: return self.Saturday // "sat "
        case 0x73637074: return self.script // "scpt"
        case 0x73657020: return self.September // "sep "
        case 0x73686f72: return self.shortInteger // "shor"
        case 0x73696e67: return self.smallReal // "sing"
        case 0x54455854: return self.string // "TEXT"
        case 0x7374796c: return self.styledClipboardText // "styl"
        case 0x53545854: return self.styledText // "STXT"
        case 0x73756e20: return self.Sunday // "sun "
        case 0x74737479: return self.textStyleInfo // "tsty"
        case 0x74687520: return self.Thursday // "thu "
        case 0x54494646: return self.TIFFPicture // "TIFF"
        case 0x74756520: return self.Tuesday // "tue "
        case 0x74797065: return self.typeClass // "type"
        case 0x75747874: return self.UnicodeText // "utxt"
        case 0x75636f6d: return self.unsignedDoubleInteger // "ucom"
        case 0x6d61676e: return self.unsignedInteger // "magn"
        case 0x75736872: return self.unsignedShortInteger // "ushr"
        case 0x75743136: return self.UTF16Text // "ut16"
        case 0x75746638: return self.UTF8Text // "utf8"
        case 0x76657273: return self.version // "vers"
        case 0x77656420: return self.Wednesday // "wed "
        case 0x77686974: return self.whitespace // "whit"
        case 0x70736374: return self.writingCode // "psct"
        case 0x79657320: return self.yes // "yes "
        default: return super.symbol(code: code, type: type, descriptor: descriptor) as! BFESymbol
        }
    }

    // Types/properties
    public static let alias = BFESymbol(name: "alias", code: 0x616c6973, type: typeType) // "alis"
    public static let anything = BFESymbol(name: "anything", code: 0x2a2a2a2a, type: typeType) // "****"
    public static let applicationBundleID = BFESymbol(name: "applicationBundleID", code: 0x62756e64, type: typeType) // "bund"
    public static let applicationSignature = BFESymbol(name: "applicationSignature", code: 0x7369676e, type: typeType) // "sign"
    public static let applicationURL = BFESymbol(name: "applicationURL", code: 0x6170726c, type: typeType) // "aprl"
    public static let April = BFESymbol(name: "April", code: 0x61707220, type: typeType) // "apr "
    public static let August = BFESymbol(name: "August", code: 0x61756720, type: typeType) // "aug "
    public static let best = BFESymbol(name: "best", code: 0x62657374, type: typeType) // "best"
    public static let bookmarkData = BFESymbol(name: "bookmarkData", code: 0x626d726b, type: typeType) // "bmrk"
    public static let boolean = BFESymbol(name: "boolean", code: 0x626f6f6c, type: typeType) // "bool"
    public static let boundingRectangle = BFESymbol(name: "boundingRectangle", code: 0x71647274, type: typeType) // "qdrt"
    public static let class_ = BFESymbol(name: "class_", code: 0x70636c73, type: typeType) // "pcls"
    public static let colorTable = BFESymbol(name: "colorTable", code: 0x636c7274, type: typeType) // "clrt"
    public static let constant = BFESymbol(name: "constant", code: 0x656e756d, type: typeType) // "enum"
    public static let dashStyle = BFESymbol(name: "dashStyle", code: 0x74646173, type: typeType) // "tdas"
    public static let data = BFESymbol(name: "data", code: 0x74647461, type: typeType) // "tdta"
    public static let date = BFESymbol(name: "date", code: 0x6c647420, type: typeType) // "ldt "
    public static let December = BFESymbol(name: "December", code: 0x64656320, type: typeType) // "dec "
    public static let decimalStruct = BFESymbol(name: "decimalStruct", code: 0x6465636d, type: typeType) // "decm"
    public static let doubleInteger = BFESymbol(name: "doubleInteger", code: 0x636f6d70, type: typeType) // "comp"
    public static let encodedString = BFESymbol(name: "encodedString", code: 0x656e6373, type: typeType) // "encs"
    public static let EPSPicture = BFESymbol(name: "EPSPicture", code: 0x45505320, type: typeType) // "EPS "
    public static let February = BFESymbol(name: "February", code: 0x66656220, type: typeType) // "feb "
    public static let fileRef = BFESymbol(name: "fileRef", code: 0x66737266, type: typeType) // "fsrf"
    public static let fileURL = BFESymbol(name: "fileURL", code: 0x6675726c, type: typeType) // "furl"
    public static let fixed = BFESymbol(name: "fixed", code: 0x66697864, type: typeType) // "fixd"
    public static let fixedPoint = BFESymbol(name: "fixedPoint", code: 0x66706e74, type: typeType) // "fpnt"
    public static let fixedRectangle = BFESymbol(name: "fixedRectangle", code: 0x66726374, type: typeType) // "frct"
    public static let Friday = BFESymbol(name: "Friday", code: 0x66726920, type: typeType) // "fri "
    public static let GIFPicture = BFESymbol(name: "GIFPicture", code: 0x47494666, type: typeType) // "GIFf"
    public static let graphicText = BFESymbol(name: "graphicText", code: 0x63677478, type: typeType) // "cgtx"
    public static let id = BFESymbol(name: "id", code: 0x49442020, type: typeType) // "ID  "
    public static let integer = BFESymbol(name: "integer", code: 0x6c6f6e67, type: typeType) // "long"
    public static let internationalText = BFESymbol(name: "internationalText", code: 0x69747874, type: typeType) // "itxt"
    public static let internationalWritingCode = BFESymbol(name: "internationalWritingCode", code: 0x696e746c, type: typeType) // "intl"
    public static let item = BFESymbol(name: "item", code: 0x636f626a, type: typeType) // "cobj"
    public static let January = BFESymbol(name: "January", code: 0x6a616e20, type: typeType) // "jan "
    public static let JPEGPicture = BFESymbol(name: "JPEGPicture", code: 0x4a504547, type: typeType) // "JPEG"
    public static let July = BFESymbol(name: "July", code: 0x6a756c20, type: typeType) // "jul "
    public static let June = BFESymbol(name: "June", code: 0x6a756e20, type: typeType) // "jun "
    public static let kernelProcessID = BFESymbol(name: "kernelProcessID", code: 0x6b706964, type: typeType) // "kpid"
    public static let largeReal = BFESymbol(name: "largeReal", code: 0x6c64626c, type: typeType) // "ldbl"
    public static let list = BFESymbol(name: "list", code: 0x6c697374, type: typeType) // "list"
    public static let locationReference = BFESymbol(name: "locationReference", code: 0x696e736c, type: typeType) // "insl"
    public static let longFixed = BFESymbol(name: "longFixed", code: 0x6c667864, type: typeType) // "lfxd"
    public static let longFixedPoint = BFESymbol(name: "longFixedPoint", code: 0x6c667074, type: typeType) // "lfpt"
    public static let longFixedRectangle = BFESymbol(name: "longFixedRectangle", code: 0x6c667263, type: typeType) // "lfrc"
    public static let longPoint = BFESymbol(name: "longPoint", code: 0x6c706e74, type: typeType) // "lpnt"
    public static let longRectangle = BFESymbol(name: "longRectangle", code: 0x6c726374, type: typeType) // "lrct"
    public static let machine = BFESymbol(name: "machine", code: 0x6d616368, type: typeType) // "mach"
    public static let machineLocation = BFESymbol(name: "machineLocation", code: 0x6d4c6f63, type: typeType) // "mLoc"
    public static let machPort = BFESymbol(name: "machPort", code: 0x706f7274, type: typeType) // "port"
    public static let March = BFESymbol(name: "March", code: 0x6d617220, type: typeType) // "mar "
    public static let May = BFESymbol(name: "May", code: 0x6d617920, type: typeType) // "may "
    public static let Monday = BFESymbol(name: "Monday", code: 0x6d6f6e20, type: typeType) // "mon "
    public static let November = BFESymbol(name: "November", code: 0x6e6f7620, type: typeType) // "nov "
    public static let null = BFESymbol(name: "null", code: 0x6e756c6c, type: typeType) // "null"
    public static let October = BFESymbol(name: "October", code: 0x6f637420, type: typeType) // "oct "
    public static let PICTPicture = BFESymbol(name: "PICTPicture", code: 0x50494354, type: typeType) // "PICT"
    public static let pixelMapRecord = BFESymbol(name: "pixelMapRecord", code: 0x74706d6d, type: typeType) // "tpmm"
    public static let point = BFESymbol(name: "point", code: 0x51447074, type: typeType) // "QDpt"
    public static let processSerialNumber = BFESymbol(name: "processSerialNumber", code: 0x70736e20, type: typeType) // "psn "
    public static let properties = BFESymbol(name: "properties", code: 0x70414c4c, type: typeType) // "pALL"
    public static let property_ = BFESymbol(name: "property_", code: 0x70726f70, type: typeType) // "prop"
    public static let real = BFESymbol(name: "real", code: 0x646f7562, type: typeType) // "doub"
    public static let record = BFESymbol(name: "record", code: 0x7265636f, type: typeType) // "reco"
    public static let reference = BFESymbol(name: "reference", code: 0x6f626a20, type: typeType) // "obj "
    public static let RGB16Color = BFESymbol(name: "RGB16Color", code: 0x74723136, type: typeType) // "tr16"
    public static let RGB96Color = BFESymbol(name: "RGB96Color", code: 0x74723936, type: typeType) // "tr96"
    public static let RGBColor = BFESymbol(name: "RGBColor", code: 0x63524742, type: typeType) // "cRGB"
    public static let rotation = BFESymbol(name: "rotation", code: 0x74726f74, type: typeType) // "trot"
    public static let Saturday = BFESymbol(name: "Saturday", code: 0x73617420, type: typeType) // "sat "
    public static let script = BFESymbol(name: "script", code: 0x73637074, type: typeType) // "scpt"
    public static let September = BFESymbol(name: "September", code: 0x73657020, type: typeType) // "sep "
    public static let shortInteger = BFESymbol(name: "shortInteger", code: 0x73686f72, type: typeType) // "shor"
    public static let smallReal = BFESymbol(name: "smallReal", code: 0x73696e67, type: typeType) // "sing"
    public static let string = BFESymbol(name: "string", code: 0x54455854, type: typeType) // "TEXT"
    public static let styledClipboardText = BFESymbol(name: "styledClipboardText", code: 0x7374796c, type: typeType) // "styl"
    public static let styledText = BFESymbol(name: "styledText", code: 0x53545854, type: typeType) // "STXT"
    public static let Sunday = BFESymbol(name: "Sunday", code: 0x73756e20, type: typeType) // "sun "
    public static let textStyleInfo = BFESymbol(name: "textStyleInfo", code: 0x74737479, type: typeType) // "tsty"
    public static let Thursday = BFESymbol(name: "Thursday", code: 0x74687520, type: typeType) // "thu "
    public static let TIFFPicture = BFESymbol(name: "TIFFPicture", code: 0x54494646, type: typeType) // "TIFF"
    public static let Tuesday = BFESymbol(name: "Tuesday", code: 0x74756520, type: typeType) // "tue "
    public static let typeClass = BFESymbol(name: "typeClass", code: 0x74797065, type: typeType) // "type"
    public static let UnicodeText = BFESymbol(name: "UnicodeText", code: 0x75747874, type: typeType) // "utxt"
    public static let unsignedDoubleInteger = BFESymbol(name: "unsignedDoubleInteger", code: 0x75636f6d, type: typeType) // "ucom"
    public static let unsignedInteger = BFESymbol(name: "unsignedInteger", code: 0x6d61676e, type: typeType) // "magn"
    public static let unsignedShortInteger = BFESymbol(name: "unsignedShortInteger", code: 0x75736872, type: typeType) // "ushr"
    public static let UTF16Text = BFESymbol(name: "UTF16Text", code: 0x75743136, type: typeType) // "ut16"
    public static let UTF8Text = BFESymbol(name: "UTF8Text", code: 0x75746638, type: typeType) // "utf8"
    public static let version = BFESymbol(name: "version", code: 0x76657273, type: typeType) // "vers"
    public static let Wednesday = BFESymbol(name: "Wednesday", code: 0x77656420, type: typeType) // "wed "
    public static let writingCode = BFESymbol(name: "writingCode", code: 0x70736374, type: typeType) // "psct"

    // Enumerators
    public static let ask = BFESymbol(name: "ask", code: 0x61736b20, type: typeEnumerated) // "ask "
    public static let case_ = BFESymbol(name: "case_", code: 0x63617365, type: typeEnumerated) // "case"
    public static let diacriticals = BFESymbol(name: "diacriticals", code: 0x64696163, type: typeEnumerated) // "diac"
    public static let expansion = BFESymbol(name: "expansion", code: 0x65787061, type: typeEnumerated) // "expa"
    public static let hyphens = BFESymbol(name: "hyphens", code: 0x68797068, type: typeEnumerated) // "hyph"
    public static let no = BFESymbol(name: "no", code: 0x6e6f2020, type: typeEnumerated) // "no  "
    public static let numericStrings = BFESymbol(name: "numericStrings", code: 0x6e756d65, type: typeEnumerated) // "nume"
    public static let punctuation = BFESymbol(name: "punctuation", code: 0x70756e63, type: typeEnumerated) // "punc"
    public static let whitespace = BFESymbol(name: "whitespace", code: 0x77686974, type: typeEnumerated) // "whit"
    public static let yes = BFESymbol(name: "yes", code: 0x79657320, type: typeEnumerated) // "yes "
}

public typealias BFE = BFESymbol // allows symbols to be written as (e.g.) BFE.name instead of BFESymbol.name


/******************************************************************************/
// Specifier extensions; these add command methods and property/elements getters based on Bluetooth File Exchange.app terminology

public protocol BFECommand: SwiftAutomation.SpecifierProtocol {} // provides AE dispatch methods

// Command->Any will be bound when return type can't be inferred, else Command->T

extension BFECommand {
    @discardableResult public func activate(_ directParameter: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "activate", event: 0x6d697363_61637476, // "miscactv"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func activate<T>(_ directParameter: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "activate", event: 0x6d697363_61637476, // "miscactv"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func browse(_ directParameter: Any = SwiftAutomation.noParameter,
            device: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "browse", event: 0x61657674_6f465450, // "aevtoFTP"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("device", 0x62644164, device), // "bdAd"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func browse<T>(_ directParameter: Any = SwiftAutomation.noParameter,
            device: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "browse", event: 0x61657674_6f465450, // "aevtoFTP"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("device", 0x62644164, device), // "bdAd"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func get(_ directParameter: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "get", event: 0x636f7265_67657464, // "coregetd"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func get<T>(_ directParameter: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "get", event: 0x636f7265_67657464, // "coregetd"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func open(_ directParameter: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "open", event: 0x61657674_6f646f63, // "aevtodoc"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func open<T>(_ directParameter: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "open", event: 0x61657674_6f646f63, // "aevtodoc"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func openLocation(_ directParameter: Any = SwiftAutomation.noParameter,
            window: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "openLocation", event: 0x4755524c_4755524c, // "GURLGURL"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("window", 0x57494e44, window), // "WIND"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func openLocation<T>(_ directParameter: Any = SwiftAutomation.noParameter,
            window: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "openLocation", event: 0x4755524c_4755524c, // "GURLGURL"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("window", 0x57494e44, window), // "WIND"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func print(_ directParameter: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "print", event: 0x61657674_70646f63, // "aevtpdoc"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func print<T>(_ directParameter: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "print", event: 0x61657674_70646f63, // "aevtpdoc"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func quit(_ directParameter: Any = SwiftAutomation.noParameter,
            saving: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "quit", event: 0x61657674_71756974, // "aevtquit"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("saving", 0x7361766f, saving), // "savo"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func quit<T>(_ directParameter: Any = SwiftAutomation.noParameter,
            saving: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "quit", event: 0x61657674_71756974, // "aevtquit"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("saving", 0x7361766f, saving), // "savo"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func reopen(_ directParameter: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "reopen", event: 0x61657674_72617070, // "aevtrapp"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func reopen<T>(_ directParameter: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "reopen", event: 0x61657674_72617070, // "aevtrapp"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func run(_ directParameter: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "run", event: 0x61657674_6f617070, // "aevtoapp"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func run<T>(_ directParameter: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "run", event: 0x61657674_6f617070, // "aevtoapp"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func send(_ directParameter: Any = SwiftAutomation.noParameter,
            file: Any = SwiftAutomation.noParameter,
            toDevice: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "send", event: 0x61657674_6f4f5050, // "aevtoOPP"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("file", 0x62744673, file), // "btFs"
                    ("toDevice", 0x62644164, toDevice), // "bdAd"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func send<T>(_ directParameter: Any = SwiftAutomation.noParameter,
            file: Any = SwiftAutomation.noParameter,
            toDevice: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "send", event: 0x61657674_6f4f5050, // "aevtoOPP"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("file", 0x62744673, file), // "btFs"
                    ("toDevice", 0x62644164, toDevice), // "bdAd"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func set(_ directParameter: Any = SwiftAutomation.noParameter,
            to: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "set", event: 0x636f7265_73657464, // "coresetd"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x64617461, to), // "data"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func set<T>(_ directParameter: Any = SwiftAutomation.noParameter,
            to: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "set", event: 0x636f7265_73657464, // "coresetd"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x64617461, to), // "data"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
}


public protocol BFEObject: SwiftAutomation.ObjectSpecifierExtension, BFECommand {} // provides vars and methods for constructing specifiers

extension BFEObject {

    // Properties
    public var class_: BFEItem {return self.property(0x70636c73) as! BFEItem} // "pcls"
    public var id: BFEItem {return self.property(0x49442020) as! BFEItem} // "ID  "
    public var properties: BFEItem {return self.property(0x70414c4c) as! BFEItem} // "pALL"

    // Elements
    public var items: BFEItems {return self.elements(0x636f626a) as! BFEItems} // "cobj"
}


/******************************************************************************/
// Specifier subclasses add app-specific extensions

// beginning/end/before/after
public class BFEInsertion: SwiftAutomation.InsertionSpecifier, BFECommand {}


// property/by-index/by-name/by-id/previous/next/first/middle/last/any
public class BFEItem: SwiftAutomation.ObjectSpecifier, BFEObject {
    public typealias InsertionSpecifierType = BFEInsertion
    public typealias ObjectSpecifierType = BFEItem
    public typealias MultipleObjectSpecifierType = BFEItems
}

// by-range/by-test/all
public class BFEItems: BFEItem, SwiftAutomation.MultipleObjectSpecifierExtension {}

// App/Con/Its
public class BFERoot: SwiftAutomation.RootSpecifier, BFEObject, SwiftAutomation.RootSpecifierExtension {
    public typealias InsertionSpecifierType = BFEInsertion
    public typealias ObjectSpecifierType = BFEItem
    public typealias MultipleObjectSpecifierType = BFEItems
    public override class var untargetedAppData: SwiftAutomation.AppData { return _untargetedAppData }
}

// Application
public class BluetoothFileExchange: BFERoot, SwiftAutomation.Application {
    public convenience init(launchOptions: SwiftAutomation.LaunchOptions = SwiftAutomation.defaultLaunchOptions, relaunchMode: SwiftAutomation.RelaunchMode = SwiftAutomation.defaultRelaunchMode) {
        self.init(rootObject: SwiftAutomation.appRootDesc, appData: Swift.type(of:self).untargetedAppData.targetedCopy(
                  .bundleIdentifier("com.apple.BluetoothFileExchange", true), launchOptions: launchOptions, relaunchMode: relaunchMode))
    }
}

// App/Con/Its root objects used to construct untargeted specifiers; these can be used to construct specifiers for use in commands, though cannot send commands themselves

public let BFEApp = _untargetedAppData.app as! BFERoot
public let BFECon = _untargetedAppData.con as! BFERoot
public let BFEIts = _untargetedAppData.its as! BFERoot


/******************************************************************************/
// Static types

public typealias BFERecord = [BFESymbol:Any] // default Swift type for AERecordDescs






