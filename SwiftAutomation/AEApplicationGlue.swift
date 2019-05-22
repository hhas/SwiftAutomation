//
//  AEApplicationGlue.swift
//  built-in 
//  SwiftAutomation.framework 0.1.0
//  `aeglue -D -e 'Symbol+String' -e 'String+MissingValue'`
//


import Foundation
import AppleEvents



/******************************************************************************/
// Create an untargeted AppData instance for use in App, Con, Its roots,
// and in Application initializers to create targeted AppData instances.

private let _specifierFormatter = SpecifierFormatter(
        applicationClassName: "AEApplication",
        classNamePrefix: "AE",
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

private let _glueClasses = GlueClasses(
                                                insertionSpecifierType: AEInsertion.self,
                                                objectSpecifierType: AEItem.self,
                                                multiObjectSpecifierType: AEItems.self,
                                                rootSpecifierType: AERoot.self,
                                                applicationType: AEApplication.self,
                                                symbolType: AESymbol.self,
                                                formatter: _specifierFormatter)

private let _untargetedAppData = AppData(glueClasses: _glueClasses)


/******************************************************************************/
// Symbol subclass defines static type/enum/property constants based on built-in terminology

public class AESymbol: Symbol {

    override public var typeAliasName: String {return "AE"}

    public override class func symbol(code: OSType, type: OSType = AppleEvents.typeType, descriptor: ScalarDescriptor? = nil) -> AESymbol {
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
        default: return super.symbol(code: code, type: type, descriptor: descriptor) as! AESymbol
        }
    }

    // Types/properties
    public static let alias = AESymbol(name: "alias", code: 0x616c6973, type: AppleEvents.typeType) // "alis"
    public static let anything = AESymbol(name: "anything", code: 0x2a2a2a2a, type: AppleEvents.typeType) // "****"
    public static let applicationBundleID = AESymbol(name: "applicationBundleID", code: 0x62756e64, type: AppleEvents.typeType) // "bund"
    public static let applicationSignature = AESymbol(name: "applicationSignature", code: 0x7369676e, type: AppleEvents.typeType) // "sign"
    public static let applicationURL = AESymbol(name: "applicationURL", code: 0x6170726c, type: AppleEvents.typeType) // "aprl"
    public static let April = AESymbol(name: "April", code: 0x61707220, type: AppleEvents.typeType) // "apr "
    public static let August = AESymbol(name: "August", code: 0x61756720, type: AppleEvents.typeType) // "aug "
    public static let best = AESymbol(name: "best", code: 0x62657374, type: AppleEvents.typeType) // "best"
    public static let bookmarkData = AESymbol(name: "bookmarkData", code: 0x626d726b, type: AppleEvents.typeType) // "bmrk"
    public static let boolean = AESymbol(name: "boolean", code: 0x626f6f6c, type: AppleEvents.typeType) // "bool"
    public static let boundingRectangle = AESymbol(name: "boundingRectangle", code: 0x71647274, type: AppleEvents.typeType) // "qdrt"
    public static let class_ = AESymbol(name: "class_", code: 0x70636c73, type: AppleEvents.typeType) // "pcls"
    public static let colorTable = AESymbol(name: "colorTable", code: 0x636c7274, type: AppleEvents.typeType) // "clrt"
    public static let constant = AESymbol(name: "constant", code: 0x656e756d, type: AppleEvents.typeType) // "enum"
    public static let dashStyle = AESymbol(name: "dashStyle", code: 0x74646173, type: AppleEvents.typeType) // "tdas"
    public static let data = AESymbol(name: "data", code: 0x74647461, type: AppleEvents.typeType) // "tdta"
    public static let date = AESymbol(name: "date", code: 0x6c647420, type: AppleEvents.typeType) // "ldt "
    public static let December = AESymbol(name: "December", code: 0x64656320, type: AppleEvents.typeType) // "dec "
    public static let decimalStruct = AESymbol(name: "decimalStruct", code: 0x6465636d, type: AppleEvents.typeType) // "decm"
    public static let doubleInteger = AESymbol(name: "doubleInteger", code: 0x636f6d70, type: AppleEvents.typeType) // "comp"
    public static let encodedString = AESymbol(name: "encodedString", code: 0x656e6373, type: AppleEvents.typeType) // "encs"
    public static let EPSPicture = AESymbol(name: "EPSPicture", code: 0x45505320, type: AppleEvents.typeType) // "EPS "
    public static let February = AESymbol(name: "February", code: 0x66656220, type: AppleEvents.typeType) // "feb "
    public static let fileRef = AESymbol(name: "fileRef", code: 0x66737266, type: AppleEvents.typeType) // "fsrf"
    public static let fileURL = AESymbol(name: "fileURL", code: 0x6675726c, type: AppleEvents.typeType) // "furl"
    public static let fixed = AESymbol(name: "fixed", code: 0x66697864, type: AppleEvents.typeType) // "fixd"
    public static let fixedPoint = AESymbol(name: "fixedPoint", code: 0x66706e74, type: AppleEvents.typeType) // "fpnt"
    public static let fixedRectangle = AESymbol(name: "fixedRectangle", code: 0x66726374, type: AppleEvents.typeType) // "frct"
    public static let Friday = AESymbol(name: "Friday", code: 0x66726920, type: AppleEvents.typeType) // "fri "
    public static let GIFPicture = AESymbol(name: "GIFPicture", code: 0x47494666, type: AppleEvents.typeType) // "GIFf"
    public static let graphicText = AESymbol(name: "graphicText", code: 0x63677478, type: AppleEvents.typeType) // "cgtx"
    public static let id = AESymbol(name: "id", code: 0x49442020, type: AppleEvents.typeType) // "ID  "
    public static let integer = AESymbol(name: "integer", code: 0x6c6f6e67, type: AppleEvents.typeType) // "long"
    public static let internationalText = AESymbol(name: "internationalText", code: 0x69747874, type: AppleEvents.typeType) // "itxt"
    public static let internationalWritingCode = AESymbol(name: "internationalWritingCode", code: 0x696e746c, type: AppleEvents.typeType) // "intl"
    public static let item = AESymbol(name: "item", code: 0x636f626a, type: AppleEvents.typeType) // "cobj"
    public static let January = AESymbol(name: "January", code: 0x6a616e20, type: AppleEvents.typeType) // "jan "
    public static let JPEGPicture = AESymbol(name: "JPEGPicture", code: 0x4a504547, type: AppleEvents.typeType) // "JPEG"
    public static let July = AESymbol(name: "July", code: 0x6a756c20, type: AppleEvents.typeType) // "jul "
    public static let June = AESymbol(name: "June", code: 0x6a756e20, type: AppleEvents.typeType) // "jun "
    public static let kernelProcessID = AESymbol(name: "kernelProcessID", code: 0x6b706964, type: AppleEvents.typeType) // "kpid"
    public static let largeReal = AESymbol(name: "largeReal", code: 0x6c64626c, type: AppleEvents.typeType) // "ldbl"
    public static let list = AESymbol(name: "list", code: 0x6c697374, type: AppleEvents.typeType) // "list"
    public static let locationReference = AESymbol(name: "locationReference", code: 0x696e736c, type: AppleEvents.typeType) // "insl"
    public static let longFixed = AESymbol(name: "longFixed", code: 0x6c667864, type: AppleEvents.typeType) // "lfxd"
    public static let longFixedPoint = AESymbol(name: "longFixedPoint", code: 0x6c667074, type: AppleEvents.typeType) // "lfpt"
    public static let longFixedRectangle = AESymbol(name: "longFixedRectangle", code: 0x6c667263, type: AppleEvents.typeType) // "lfrc"
    public static let longPoint = AESymbol(name: "longPoint", code: 0x6c706e74, type: AppleEvents.typeType) // "lpnt"
    public static let longRectangle = AESymbol(name: "longRectangle", code: 0x6c726374, type: AppleEvents.typeType) // "lrct"
    public static let machine = AESymbol(name: "machine", code: 0x6d616368, type: AppleEvents.typeType) // "mach"
    public static let machineLocation = AESymbol(name: "machineLocation", code: 0x6d4c6f63, type: AppleEvents.typeType) // "mLoc"
    public static let machPort = AESymbol(name: "machPort", code: 0x706f7274, type: AppleEvents.typeType) // "port"
    public static let March = AESymbol(name: "March", code: 0x6d617220, type: AppleEvents.typeType) // "mar "
    public static let May = AESymbol(name: "May", code: 0x6d617920, type: AppleEvents.typeType) // "may "
    public static let Monday = AESymbol(name: "Monday", code: 0x6d6f6e20, type: AppleEvents.typeType) // "mon "
    public static let November = AESymbol(name: "November", code: 0x6e6f7620, type: AppleEvents.typeType) // "nov "
    public static let null = AESymbol(name: "null", code: 0x6e756c6c, type: AppleEvents.typeType) // "null"
    public static let October = AESymbol(name: "October", code: 0x6f637420, type: AppleEvents.typeType) // "oct "
    public static let PICTPicture = AESymbol(name: "PICTPicture", code: 0x50494354, type: AppleEvents.typeType) // "PICT"
    public static let pixelMapRecord = AESymbol(name: "pixelMapRecord", code: 0x74706d6d, type: AppleEvents.typeType) // "tpmm"
    public static let point = AESymbol(name: "point", code: 0x51447074, type: AppleEvents.typeType) // "QDpt"
    public static let processSerialNumber = AESymbol(name: "processSerialNumber", code: 0x70736e20, type: AppleEvents.typeType) // "psn "
    public static let properties = AESymbol(name: "properties", code: 0x70414c4c, type: AppleEvents.typeType) // "pALL"
    public static let property_ = AESymbol(name: "property_", code: 0x70726f70, type: AppleEvents.typeType) // "prop"
    public static let real = AESymbol(name: "real", code: 0x646f7562, type: AppleEvents.typeType) // "doub"
    public static let record = AESymbol(name: "record", code: 0x7265636f, type: AppleEvents.typeType) // "reco"
    public static let reference = AESymbol(name: "reference", code: 0x6f626a20, type: AppleEvents.typeType) // "obj "
    public static let RGB16Color = AESymbol(name: "RGB16Color", code: 0x74723136, type: AppleEvents.typeType) // "tr16"
    public static let RGB96Color = AESymbol(name: "RGB96Color", code: 0x74723936, type: AppleEvents.typeType) // "tr96"
    public static let RGBColor = AESymbol(name: "RGBColor", code: 0x63524742, type: AppleEvents.typeType) // "cRGB"
    public static let rotation = AESymbol(name: "rotation", code: 0x74726f74, type: AppleEvents.typeType) // "trot"
    public static let Saturday = AESymbol(name: "Saturday", code: 0x73617420, type: AppleEvents.typeType) // "sat "
    public static let script = AESymbol(name: "script", code: 0x73637074, type: AppleEvents.typeType) // "scpt"
    public static let September = AESymbol(name: "September", code: 0x73657020, type: AppleEvents.typeType) // "sep "
    public static let shortInteger = AESymbol(name: "shortInteger", code: 0x73686f72, type: AppleEvents.typeType) // "shor"
    public static let smallReal = AESymbol(name: "smallReal", code: 0x73696e67, type: AppleEvents.typeType) // "sing"
    public static let string = AESymbol(name: "string", code: 0x54455854, type: AppleEvents.typeType) // "TEXT"
    public static let styledClipboardText = AESymbol(name: "styledClipboardText", code: 0x7374796c, type: AppleEvents.typeType) // "styl"
    public static let styledText = AESymbol(name: "styledText", code: 0x53545854, type: AppleEvents.typeType) // "STXT"
    public static let Sunday = AESymbol(name: "Sunday", code: 0x73756e20, type: AppleEvents.typeType) // "sun "
    public static let textStyleInfo = AESymbol(name: "textStyleInfo", code: 0x74737479, type: AppleEvents.typeType) // "tsty"
    public static let Thursday = AESymbol(name: "Thursday", code: 0x74687520, type: AppleEvents.typeType) // "thu "
    public static let TIFFPicture = AESymbol(name: "TIFFPicture", code: 0x54494646, type: AppleEvents.typeType) // "TIFF"
    public static let Tuesday = AESymbol(name: "Tuesday", code: 0x74756520, type: AppleEvents.typeType) // "tue "
    public static let typeClass = AESymbol(name: "typeClass", code: 0x74797065, type: AppleEvents.typeType) // "type"
    public static let UnicodeText = AESymbol(name: "UnicodeText", code: 0x75747874, type: AppleEvents.typeType) // "utxt"
    public static let unsignedDoubleInteger = AESymbol(name: "unsignedDoubleInteger", code: 0x75636f6d, type: AppleEvents.typeType) // "ucom"
    public static let unsignedInteger = AESymbol(name: "unsignedInteger", code: 0x6d61676e, type: AppleEvents.typeType) // "magn"
    public static let unsignedShortInteger = AESymbol(name: "unsignedShortInteger", code: 0x75736872, type: AppleEvents.typeType) // "ushr"
    public static let UTF16Text = AESymbol(name: "UTF16Text", code: 0x75743136, type: AppleEvents.typeType) // "ut16"
    public static let UTF8Text = AESymbol(name: "UTF8Text", code: 0x75746638, type: AppleEvents.typeType) // "utf8"
    public static let version = AESymbol(name: "version", code: 0x76657273, type: AppleEvents.typeType) // "vers"
    public static let Wednesday = AESymbol(name: "Wednesday", code: 0x77656420, type: AppleEvents.typeType) // "wed "
    public static let writingCode = AESymbol(name: "writingCode", code: 0x70736374, type: AppleEvents.typeType) // "psct"

    // Enumerators
    public static let ask = AESymbol(name: "ask", code: 0x61736b20, type: AppleEvents.typeEnumerated) // "ask "
    public static let case_ = AESymbol(name: "case_", code: 0x63617365, type: AppleEvents.typeEnumerated) // "case"
    public static let diacriticals = AESymbol(name: "diacriticals", code: 0x64696163, type: AppleEvents.typeEnumerated) // "diac"
    public static let expansion = AESymbol(name: "expansion", code: 0x65787061, type: AppleEvents.typeEnumerated) // "expa"
    public static let hyphens = AESymbol(name: "hyphens", code: 0x68797068, type: AppleEvents.typeEnumerated) // "hyph"
    public static let no = AESymbol(name: "no", code: 0x6e6f2020, type: AppleEvents.typeEnumerated) // "no  "
    public static let numericStrings = AESymbol(name: "numericStrings", code: 0x6e756d65, type: AppleEvents.typeEnumerated) // "nume"
    public static let punctuation = AESymbol(name: "punctuation", code: 0x70756e63, type: AppleEvents.typeEnumerated) // "punc"
    public static let whitespace = AESymbol(name: "whitespace", code: 0x77686974, type: AppleEvents.typeEnumerated) // "whit"
    public static let yes = AESymbol(name: "yes", code: 0x79657320, type: AppleEvents.typeEnumerated) // "yes "
}

public typealias AE = AESymbol // allows symbols to be written as (e.g.) AE.name instead of AESymbol.name


/******************************************************************************/
// Specifier extensions; these add command methods and property/elements getters based on built-in terminology

public protocol AECommand: SpecifierProtocol {} // provides AE dispatch methods

// Command->Any will be bound when return type can't be inferred, else Command->T

extension AECommand {
    @discardableResult public func activate(_ directParameter: Any = noParameter,
            requestedType: Symbol? = nil, waitReply: Bool = true, sendOptions: SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "activate", event: 0x6d697363_61637476, // "miscactv"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func activate<T>(_ directParameter: Any = noParameter,
            requestedType: Symbol? = nil, waitReply: Bool = true, sendOptions: SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "activate", event: 0x6d697363_61637476, // "miscactv"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func get(_ directParameter: Any = noParameter,
            requestedType: Symbol? = nil, waitReply: Bool = true, sendOptions: SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "get", event: 0x636f7265_67657464, // "coregetd"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func get<T>(_ directParameter: Any = noParameter,
            requestedType: Symbol? = nil, waitReply: Bool = true, sendOptions: SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "get", event: 0x636f7265_67657464, // "coregetd"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func open(_ directParameter: Any = noParameter,
            requestedType: Symbol? = nil, waitReply: Bool = true, sendOptions: SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "open", event: 0x61657674_6f646f63, // "aevtodoc"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func open<T>(_ directParameter: Any = noParameter,
            requestedType: Symbol? = nil, waitReply: Bool = true, sendOptions: SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "open", event: 0x61657674_6f646f63, // "aevtodoc"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func openLocation(_ directParameter: Any = noParameter,
            window: Any = noParameter,
            requestedType: Symbol? = nil, waitReply: Bool = true, sendOptions: SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "openLocation", event: 0x4755524c_4755524c, // "GURLGURL"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("window", 0x57494e44, window), // "WIND"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func openLocation<T>(_ directParameter: Any = noParameter,
            window: Any = noParameter,
            requestedType: Symbol? = nil, waitReply: Bool = true, sendOptions: SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "openLocation", event: 0x4755524c_4755524c, // "GURLGURL"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("window", 0x57494e44, window), // "WIND"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func print(_ directParameter: Any = noParameter,
            requestedType: Symbol? = nil, waitReply: Bool = true, sendOptions: SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "print", event: 0x61657674_70646f63, // "aevtpdoc"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func print<T>(_ directParameter: Any = noParameter,
            requestedType: Symbol? = nil, waitReply: Bool = true, sendOptions: SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "print", event: 0x61657674_70646f63, // "aevtpdoc"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func quit(_ directParameter: Any = noParameter,
            saving: Any = noParameter,
            requestedType: Symbol? = nil, waitReply: Bool = true, sendOptions: SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "quit", event: 0x61657674_71756974, // "aevtquit"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("saving", 0x7361766f, saving), // "savo"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func quit<T>(_ directParameter: Any = noParameter,
            saving: Any = noParameter,
            requestedType: Symbol? = nil, waitReply: Bool = true, sendOptions: SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "quit", event: 0x61657674_71756974, // "aevtquit"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("saving", 0x7361766f, saving), // "savo"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func reopen(_ directParameter: Any = noParameter,
            requestedType: Symbol? = nil, waitReply: Bool = true, sendOptions: SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "reopen", event: 0x61657674_72617070, // "aevtrapp"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func reopen<T>(_ directParameter: Any = noParameter,
            requestedType: Symbol? = nil, waitReply: Bool = true, sendOptions: SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "reopen", event: 0x61657674_72617070, // "aevtrapp"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func run(_ directParameter: Any = noParameter,
            requestedType: Symbol? = nil, waitReply: Bool = true, sendOptions: SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "run", event: 0x61657674_6f617070, // "aevtoapp"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func run<T>(_ directParameter: Any = noParameter,
            requestedType: Symbol? = nil, waitReply: Bool = true, sendOptions: SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "run", event: 0x61657674_6f617070, // "aevtoapp"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func set(_ directParameter: Any = noParameter,
            to: Any = noParameter,
            requestedType: Symbol? = nil, waitReply: Bool = true, sendOptions: SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "set", event: 0x636f7265_73657464, // "coresetd"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x64617461, to), // "data"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func set<T>(_ directParameter: Any = noParameter,
            to: Any = noParameter,
            requestedType: Symbol? = nil, waitReply: Bool = true, sendOptions: SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "set", event: 0x636f7265_73657464, // "coresetd"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x64617461, to), // "data"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
}


public protocol AEObject: ObjectSpecifierExtension, AECommand {} // provides vars and methods for constructing specifiers

extension AEObject {

    // Properties
    public var class_: AEItem {return self.property(0x70636c73) as! AEItem} // "pcls"
    public var id: AEItem {return self.property(0x49442020) as! AEItem} // "ID  "
    public var properties: AEItem {return self.property(0x70414c4c) as! AEItem} // "pALL"

    // Elements
    public var items: AEItems {return self.elements(0x636f626a) as! AEItems} // "cobj"
}


/******************************************************************************/
// Specifier subclasses add app-specific extensions

// beginning/end/before/after
public class AEInsertion: InsertionSpecifier, AECommand {}


// property/by-index/by-name/by-id/previous/next/first/middle/last/any
public class AEItem: ObjectSpecifier, AEObject {
    public typealias InsertionSpecifierType = AEInsertion
    public typealias ObjectSpecifierType = AEItem
    public typealias MultipleObjectSpecifierType = AEItems
}

// by-range/by-test/all
public class AEItems: AEItem, MultipleObjectSpecifierExtension {}

// App/Con/Its
public class AERoot: RootSpecifier, AEObject, RootSpecifierExtension {
    public typealias InsertionSpecifierType = AEInsertion
    public typealias ObjectSpecifierType = AEItem
    public typealias MultipleObjectSpecifierType = AEItems
    public override class var untargetedAppData: AppData { return _untargetedAppData }
}

// Application
public class AEApplication: AERoot, Application {}

// App/Con/Its root objects used to construct untargeted specifiers; these can be used to construct specifiers for use in commands, though cannot send commands themselves

public let AEApp = _untargetedAppData.app as! AERoot
public let AECon = _untargetedAppData.con as! AERoot
public let AEIts = _untargetedAppData.its as! AERoot


/******************************************************************************/
// Static types

public typealias AERecord = [AESymbol:Any] // default Swift type for AERecordDescs




public enum AEymbolOrString: SelfPacking, SelfUnpacking {
    case symbol(AESymbol)
    case string(String)
    
    public init(_ value: AESymbol) { self = .symbol(value) }
    public init(_ value: String) { self = .string(value) }

    public func SwiftAutomation_packSelf(_ appData: AppData) throws -> Descriptor {
        switch self {
        case .symbol(let value): return try appData.pack(value as Any)
        case .string(let value): return try appData.pack(value as Any)
        }
    }
    public static func SwiftAutomation_unpackSelf(_ desc: Descriptor, appData: AppData) throws -> AEymbolOrString {
        do { return .symbol(try appData.unpack(desc) as AESymbol) } catch {}
        do { return .string(try appData.unpack(desc) as String) } catch {}
        throw UnpackError(appData: appData, descriptor: desc, type: AEymbolOrString.self,
                          message: "Can't coerce descriptor to Swift type: \(AEymbolOrString.self)")
    }
    public static func SwiftAutomation_noValue() throws -> AEymbolOrString { throw AutomationError(code: -1708) }
}

public enum AEStringOrMissingValue: SelfPacking, SelfUnpacking {
    case missing(MissingValueType)
    case string(String)
    
    public init(_ value: MissingValueType) { self = .missing(value) }
    public init(_ value: String) { self = .string(value) }

    public func SwiftAutomation_packSelf(_ appData: AppData) throws -> Descriptor {
        switch self {
        case .missing(let value): return try appData.pack(value as Any)
        case .string(let value): return try appData.pack(value as Any)
        }
    }
    public static func SwiftAutomation_unpackSelf(_ desc: Descriptor, appData: AppData) throws -> AEStringOrMissingValue {
        do { return .missing(try appData.unpack(desc) as MissingValueType) } catch {}
        do { return .string(try appData.unpack(desc) as String) } catch {}
        throw UnpackError(appData: appData, descriptor: desc, type: AEStringOrMissingValue.self,
                          message: "Can't coerce descriptor to Swift type: \(AEStringOrMissingValue.self)")
    }
    public static func SwiftAutomation_noValue() throws -> AEStringOrMissingValue { return .missing(MissingValue) }
}



