//
//  TextEditGlue.swift
//  TextEdit.app 1.11
//  SwiftAE 0.1.0
//  `aeglue -r TextEdit`
//


import Foundation


/******************************************************************************/
// Untargeted AppData instance used in App, Con, Its roots; also used by Application constructors to create their own targeted AppData instances

private let gNullAppData = AppData(glueInfo: GlueInfo(insertionSpecifierType: TEDInsertion.self, objectSpecifierType: TEDObject.self,
                                                      elementsSpecifierType: TEDElements.self, rootSpecifierType: TEDRoot.self,
                                                      symbolType: Symbol.self, formatter: gSpecifierFormatter))


/******************************************************************************/
// Specifier formatter

private let gSpecifierFormatter = SpecifierFormatter(applicationClassName: "TextEdit",
                                                     classNamePrefix: "TED",
                                                     propertyNames: [
                                                                     0x70626e64: "bounds", // "pbnd"
                                                                     0x70636c73: "class_", // "pcls"
                                                                     0x68636c62: "closeable", // "hclb"
                                                                     0x6c77636c: "collating", // "lwcl"
                                                                     0x636f6c72: "color", // "colr"
                                                                     0x6c776370: "copies", // "lwcp"
                                                                     0x646f6375: "document", // "docu"
                                                                     0x6c776c70: "endingPage", // "lwlp"
                                                                     0x6c776568: "errorHandling", // "lweh"
                                                                     0x6661786e: "faxNumber", // "faxn"
                                                                     0x6174666e: "fileName", // "atfn"
                                                                     0x6973666c: "floating", // "isfl"
                                                                     0x666f6e74: "font", // "font"
                                                                     0x70697366: "frontmost", // "pisf"
                                                                     0x49442020: "id", // "ID  "
                                                                     0x70696478: "index", // "pidx"
                                                                     0x69736d6e: "miniaturizable", // "ismn"
                                                                     0x706d6e64: "miniaturized", // "pmnd"
                                                                     0x706d6f64: "modal", // "pmod"
                                                                     0x696d6f64: "modified", // "imod"
                                                                     0x706e616d: "name", // "pnam"
                                                                     0x6c776c61: "pagesAcross", // "lwla"
                                                                     0x6c776c64: "pagesDown", // "lwld"
                                                                     0x70707468: "path", // "ppth"
                                                                     0x70414c4c: "properties", // "pALL"
                                                                     0x6c777174: "requestedPrintTime", // "lwqt"
                                                                     0x7072737a: "resizable", // "prsz"
                                                                     0x7074737a: "size", // "ptsz"
                                                                     0x6c776670: "startingPage", // "lwfp"
                                                                     0x74727072: "targetPrinter", // "trpr"
                                                                     0x63747874: "text", // "ctxt"
                                                                     0x70746974: "titled", // "ptit"
                                                                     0x76657273: "version", // "vers"
                                                                     0x70766973: "visible", // "pvis"
                                                                     0x69737a6d: "zoomable", // "iszm"
                                                                     0x707a756d: "zoomed", // "pzum"
                                                     ],
                                                     elementsNames: [
                                                                     0x63617070: "applications", // "capp"
                                                                     0x61747473: "attachment", // "atts"
                                                                     0x63617472: "attributeRuns", // "catr"
                                                                     0x63686120: "characters", // "cha "
                                                                     0x636f6c72: "colors", // "colr"
                                                                     0x646f6375: "documents", // "docu"
                                                                     0x636f626a: "items", // "cobj"
                                                                     0x63706172: "paragraphs", // "cpar"
                                                                     0x70736574: "printSettings", // "pset"
                                                                     0x63747874: "text", // "ctxt"
                                                                     0x6377696e: "windows", // "cwin"
                                                                     0x63776f72: "words", // "cwor"
                                                     ])


/******************************************************************************/
// Symbol subclass defines static type/enum/property constants based on TextEdit.app terminology

public class TEDSymbol: Symbol {

    override var typeAliasName: String {return "TED"}

    public override class func symbol(code: OSType, type: OSType = typeType, descriptor: NSAppleEventDescriptor? = nil) -> TEDSymbol {
        switch (code) {
        case 0x616c6973: return self.alias // "alis"
        case 0x2a2a2a2a: return self.anything // "****"
        case 0x63617070: return self.application // "capp"
        case 0x62756e64: return self.applicationBundleId // "bund"
        case 0x7369676e: return self.applicationSignature // "sign"
        case 0x6170726c: return self.applicationUrl // "aprl"
        case 0x61707220: return self.April // "apr "
        case 0x61736b20: return self.ask // "ask "
        case 0x61747473: return self.attachment // "atts"
        case 0x63617472: return self.attributeRun // "catr"
        case 0x61756720: return self.August // "aug "
        case 0x62657374: return self.best // "best"
        case 0x626f6f6c: return self.boolean // "bool"
        case 0x71647274: return self.boundingRectangle // "qdrt"
        case 0x70626e64: return self.bounds // "pbnd"
        case 0x63617365: return self.case_ // "case"
        case 0x636d7472: return self.centimeters // "cmtr"
        case 0x63686120: return self.character // "cha "
        case 0x70636c73: return self.class_ // "pcls"
        case 0x67636c69: return self.classInfo // "gcli"
        case 0x68636c62: return self.closeable // "hclb"
        case 0x6c77636c: return self.collating // "lwcl"
        case 0x636f6c72: return self.color // "colr"
        case 0x636c7274: return self.colorTable // "clrt"
        case 0x6c776370: return self.copies // "lwcp"
        case 0x63636d74: return self.cubicCentimeters // "ccmt"
        case 0x63666574: return self.cubicFeet // "cfet"
        case 0x6375696e: return self.cubicInches // "cuin"
        case 0x636d6574: return self.cubicMeters // "cmet"
        case 0x63797264: return self.cubicYards // "cyrd"
        case 0x74646173: return self.dashStyle // "tdas"
        case 0x74647461: return self.data // "tdta"
        case 0x6c647420: return self.date // "ldt "
        case 0x64656320: return self.December // "dec "
        case 0x6465636d: return self.decimalStruct // "decm"
        case 0x64656763: return self.degreesCelsius // "degc"
        case 0x64656766: return self.degreesFahrenheit // "degf"
        case 0x6465676b: return self.degreesKelvin // "degk"
        case 0x6c776474: return self.detailed // "lwdt"
        case 0x64696163: return self.diacriticals // "diac"
        case 0x646f6375: return self.document // "docu"
        case 0x636f6d70: return self.doubleInteger // "comp"
        case 0x656c696e: return self.elementInfo // "elin"
        case 0x656e6373: return self.encodedString // "encs"
        case 0x6c776c70: return self.endingPage // "lwlp"
        case 0x656e756d: return self.enumerator // "enum"
        case 0x45505320: return self.EPSPicture // "EPS "
        case 0x6c776568: return self.errorHandling // "lweh"
        case 0x6576696e: return self.eventInfo // "evin"
        case 0x65787061: return self.expansion // "expa"
        case 0x65787465: return self.extendedFloat // "exte"
        case 0x6661786e: return self.faxNumber // "faxn"
        case 0x66656220: return self.February // "feb "
        case 0x66656574: return self.feet // "feet"
        case 0x6174666e: return self.fileName // "atfn"
        case 0x66737266: return self.fileRef // "fsrf"
        case 0x66737320: return self.fileSpecification // "fss "
        case 0x6675726c: return self.fileUrl // "furl"
        case 0x66697864: return self.fixed // "fixd"
        case 0x66706e74: return self.fixedPoint // "fpnt"
        case 0x66726374: return self.fixedRectangle // "frct"
        case 0x646f7562: return self.float // "doub"
        case 0x6c64626c: return self.float128bit // "ldbl"
        case 0x6973666c: return self.floating // "isfl"
        case 0x666f6e74: return self.font // "font"
        case 0x66726920: return self.Friday // "fri "
        case 0x70697366: return self.frontmost // "pisf"
        case 0x67616c6e: return self.gallons // "galn"
        case 0x47494666: return self.GIFPicture // "GIFf"
        case 0x6772616d: return self.grams // "gram"
        case 0x63677478: return self.graphicText // "cgtx"
        case 0x68797068: return self.hyphens // "hyph"
        case 0x49442020: return self.id // "ID  "
        case 0x696e6368: return self.inches // "inch"
        case 0x70696478: return self.index // "pidx"
        case 0x6c6f6e67: return self.integer // "long"
        case 0x69747874: return self.internationalText // "itxt"
        case 0x696e746c: return self.internationalWritingCode // "intl"
        case 0x636f626a: return self.item // "cobj"
        case 0x6a616e20: return self.January // "jan "
        case 0x4a504547: return self.JPEGPicture // "JPEG"
        case 0x6a756c20: return self.July // "jul "
        case 0x6a756e20: return self.June // "jun "
        case 0x6b706964: return self.kernelProcessId // "kpid"
        case 0x6b67726d: return self.kilograms // "kgrm"
        case 0x6b6d7472: return self.kilometers // "kmtr"
        case 0x6c697374: return self.list // "list"
        case 0x6c697472: return self.liters // "litr"
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
        case 0x6d657472: return self.meters // "metr"
        case 0x6d696c65: return self.miles // "mile"
        case 0x69736d6e: return self.miniaturizable // "ismn"
        case 0x706d6e64: return self.miniaturized // "pmnd"
        case 0x6d736e67: return self.missingValue // "msng"
        case 0x706d6f64: return self.modal // "pmod"
        case 0x696d6f64: return self.modified // "imod"
        case 0x6d6f6e20: return self.Monday // "mon "
        case 0x706e616d: return self.name // "pnam"
        case 0x6e6f2020: return self.no // "no  "
        case 0x6e6f7620: return self.November // "nov "
        case 0x6e756c6c: return self.null // "null"
        case 0x6e756d65: return self.numericStrings // "nume"
        case 0x6f637420: return self.October // "oct "
        case 0x6f7a7320: return self.ounces // "ozs "
        case 0x6c776c61: return self.pagesAcross // "lwla"
        case 0x6c776c64: return self.pagesDown // "lwld"
        case 0x63706172: return self.paragraph // "cpar"
        case 0x706d696e: return self.parameterInfo // "pmin"
        case 0x70707468: return self.path // "ppth"
        case 0x50494354: return self.PICTPicture // "PICT"
        case 0x74706d6d: return self.pixelMapRecord // "tpmm"
        case 0x51447074: return self.point // "QDpt"
        case 0x6c627320: return self.pounds // "lbs "
        case 0x70736574: return self.printSettings // "pset"
        case 0x70736e20: return self.processSerialNumber // "psn "
        case 0x70414c4c: return self.properties // "pALL"
        case 0x70726f70: return self.property_ // "prop"
        case 0x70696e66: return self.propertyInfo // "pinf"
        case 0x70756e63: return self.punctuation // "punc"
        case 0x71727473: return self.quarts // "qrts"
        case 0x7265636f: return self.record // "reco"
        case 0x6f626a20: return self.reference // "obj "
        case 0x6c777174: return self.requestedPrintTime // "lwqt"
        case 0x7072737a: return self.resizable // "prsz"
        case 0x74723136: return self.RGB16Color // "tr16"
        case 0x74723936: return self.RGB96Color // "tr96"
        case 0x63524742: return self.RGBColor // "cRGB"
        case 0x74726f74: return self.rotation // "trot"
        case 0x73617420: return self.Saturday // "sat "
        case 0x73637074: return self.script // "scpt"
        case 0x73657020: return self.September // "sep "
        case 0x73696e67: return self.shortFloat // "sing"
        case 0x73686f72: return self.shortInteger // "shor"
        case 0x7074737a: return self.size // "ptsz"
        case 0x73716674: return self.squareFeet // "sqft"
        case 0x73716b6d: return self.squareKilometers // "sqkm"
        case 0x7371726d: return self.squareMeters // "sqrm"
        case 0x73716d69: return self.squareMiles // "sqmi"
        case 0x73717964: return self.squareYards // "sqyd"
        case 0x6c777374: return self.standard // "lwst"
        case 0x6c776670: return self.startingPage // "lwfp"
        case 0x54455854: return self.string // "TEXT"
        case 0x7374796c: return self.styledClipboardText // "styl"
        case 0x53545854: return self.styledText // "STXT"
        case 0x7375696e: return self.suiteInfo // "suin"
        case 0x73756e20: return self.Sunday // "sun "
        case 0x74727072: return self.targetPrinter // "trpr"
        case 0x63747874: return self.text // "ctxt"
        case 0x74737479: return self.textStyleInfo // "tsty"
        case 0x74687520: return self.Thursday // "thu "
        case 0x54494646: return self.TIFFPicture // "TIFF"
        case 0x70746974: return self.titled // "ptit"
        case 0x74756520: return self.Tuesday // "tue "
        case 0x74797065: return self.typeClass // "type"
        case 0x75747874: return self.unicodeText // "utxt"
        case 0x6d61676e: return self.unsignedInteger // "magn"
        case 0x75743136: return self.utf16Text // "ut16"
        case 0x75746638: return self.utf8Text // "utf8"
        case 0x76657273: return self.version // "vers"
        case 0x70766973: return self.visible // "pvis"
        case 0x77656420: return self.Wednesday // "wed "
        case 0x77686974: return self.whitespace // "whit"
        case 0x6377696e: return self.window // "cwin"
        case 0x63776f72: return self.word // "cwor"
        case 0x70736374: return self.writingCode // "psct"
        case 0x79617264: return self.yards // "yard"
        case 0x79657320: return self.yes // "yes "
        case 0x69737a6d: return self.zoomable // "iszm"
        case 0x707a756d: return self.zoomed // "pzum"
        default: return super.symbol(code, type: type, descriptor: descriptor) as! TEDSymbol
        }
    }

    // Types/properties
    public static let alias = TEDSymbol(name: "alias", code: 0x616c6973, type: typeType) // "alis"
    public static let anything = TEDSymbol(name: "anything", code: 0x2a2a2a2a, type: typeType) // "****"
    public static let application = TEDSymbol(name: "application", code: 0x63617070, type: typeType) // "capp"
    public static let applicationBundleId = TEDSymbol(name: "applicationBundleId", code: 0x62756e64, type: typeType) // "bund"
    public static let applicationSignature = TEDSymbol(name: "applicationSignature", code: 0x7369676e, type: typeType) // "sign"
    public static let applicationUrl = TEDSymbol(name: "applicationUrl", code: 0x6170726c, type: typeType) // "aprl"
    public static let April = TEDSymbol(name: "April", code: 0x61707220, type: typeType) // "apr "
    public static let attachment = TEDSymbol(name: "attachment", code: 0x61747473, type: typeType) // "atts"
    public static let attributeRun = TEDSymbol(name: "attributeRun", code: 0x63617472, type: typeType) // "catr"
    public static let August = TEDSymbol(name: "August", code: 0x61756720, type: typeType) // "aug "
    public static let best = TEDSymbol(name: "best", code: 0x62657374, type: typeType) // "best"
    public static let boolean = TEDSymbol(name: "boolean", code: 0x626f6f6c, type: typeType) // "bool"
    public static let boundingRectangle = TEDSymbol(name: "boundingRectangle", code: 0x71647274, type: typeType) // "qdrt"
    public static let bounds = TEDSymbol(name: "bounds", code: 0x70626e64, type: typeType) // "pbnd"
    public static let centimeters = TEDSymbol(name: "centimeters", code: 0x636d7472, type: typeType) // "cmtr"
    public static let character = TEDSymbol(name: "character", code: 0x63686120, type: typeType) // "cha "
    public static let class_ = TEDSymbol(name: "class_", code: 0x70636c73, type: typeType) // "pcls"
    public static let classInfo = TEDSymbol(name: "classInfo", code: 0x67636c69, type: typeType) // "gcli"
    public static let closeable = TEDSymbol(name: "closeable", code: 0x68636c62, type: typeType) // "hclb"
    public static let collating = TEDSymbol(name: "collating", code: 0x6c77636c, type: typeType) // "lwcl"
    public static let color = TEDSymbol(name: "color", code: 0x636f6c72, type: typeType) // "colr"
    public static let colorTable = TEDSymbol(name: "colorTable", code: 0x636c7274, type: typeType) // "clrt"
    public static let copies = TEDSymbol(name: "copies", code: 0x6c776370, type: typeType) // "lwcp"
    public static let cubicCentimeters = TEDSymbol(name: "cubicCentimeters", code: 0x63636d74, type: typeType) // "ccmt"
    public static let cubicFeet = TEDSymbol(name: "cubicFeet", code: 0x63666574, type: typeType) // "cfet"
    public static let cubicInches = TEDSymbol(name: "cubicInches", code: 0x6375696e, type: typeType) // "cuin"
    public static let cubicMeters = TEDSymbol(name: "cubicMeters", code: 0x636d6574, type: typeType) // "cmet"
    public static let cubicYards = TEDSymbol(name: "cubicYards", code: 0x63797264, type: typeType) // "cyrd"
    public static let dashStyle = TEDSymbol(name: "dashStyle", code: 0x74646173, type: typeType) // "tdas"
    public static let data = TEDSymbol(name: "data", code: 0x74647461, type: typeType) // "tdta"
    public static let date = TEDSymbol(name: "date", code: 0x6c647420, type: typeType) // "ldt "
    public static let December = TEDSymbol(name: "December", code: 0x64656320, type: typeType) // "dec "
    public static let decimalStruct = TEDSymbol(name: "decimalStruct", code: 0x6465636d, type: typeType) // "decm"
    public static let degreesCelsius = TEDSymbol(name: "degreesCelsius", code: 0x64656763, type: typeType) // "degc"
    public static let degreesFahrenheit = TEDSymbol(name: "degreesFahrenheit", code: 0x64656766, type: typeType) // "degf"
    public static let degreesKelvin = TEDSymbol(name: "degreesKelvin", code: 0x6465676b, type: typeType) // "degk"
    public static let document = TEDSymbol(name: "document", code: 0x646f6375, type: typeType) // "docu"
    public static let doubleInteger = TEDSymbol(name: "doubleInteger", code: 0x636f6d70, type: typeType) // "comp"
    public static let elementInfo = TEDSymbol(name: "elementInfo", code: 0x656c696e, type: typeType) // "elin"
    public static let encodedString = TEDSymbol(name: "encodedString", code: 0x656e6373, type: typeType) // "encs"
    public static let endingPage = TEDSymbol(name: "endingPage", code: 0x6c776c70, type: typeType) // "lwlp"
    public static let enumerator = TEDSymbol(name: "enumerator", code: 0x656e756d, type: typeType) // "enum"
    public static let EPSPicture = TEDSymbol(name: "EPSPicture", code: 0x45505320, type: typeType) // "EPS "
    public static let errorHandling = TEDSymbol(name: "errorHandling", code: 0x6c776568, type: typeType) // "lweh"
    public static let eventInfo = TEDSymbol(name: "eventInfo", code: 0x6576696e, type: typeType) // "evin"
    public static let extendedFloat = TEDSymbol(name: "extendedFloat", code: 0x65787465, type: typeType) // "exte"
    public static let faxNumber = TEDSymbol(name: "faxNumber", code: 0x6661786e, type: typeType) // "faxn"
    public static let February = TEDSymbol(name: "February", code: 0x66656220, type: typeType) // "feb "
    public static let feet = TEDSymbol(name: "feet", code: 0x66656574, type: typeType) // "feet"
    public static let fileName = TEDSymbol(name: "fileName", code: 0x6174666e, type: typeType) // "atfn"
    public static let fileRef = TEDSymbol(name: "fileRef", code: 0x66737266, type: typeType) // "fsrf"
    public static let fileSpecification = TEDSymbol(name: "fileSpecification", code: 0x66737320, type: typeType) // "fss "
    public static let fileUrl = TEDSymbol(name: "fileUrl", code: 0x6675726c, type: typeType) // "furl"
    public static let fixed = TEDSymbol(name: "fixed", code: 0x66697864, type: typeType) // "fixd"
    public static let fixedPoint = TEDSymbol(name: "fixedPoint", code: 0x66706e74, type: typeType) // "fpnt"
    public static let fixedRectangle = TEDSymbol(name: "fixedRectangle", code: 0x66726374, type: typeType) // "frct"
    public static let float = TEDSymbol(name: "float", code: 0x646f7562, type: typeType) // "doub"
    public static let float128bit = TEDSymbol(name: "float128bit", code: 0x6c64626c, type: typeType) // "ldbl"
    public static let floating = TEDSymbol(name: "floating", code: 0x6973666c, type: typeType) // "isfl"
    public static let font = TEDSymbol(name: "font", code: 0x666f6e74, type: typeType) // "font"
    public static let Friday = TEDSymbol(name: "Friday", code: 0x66726920, type: typeType) // "fri "
    public static let frontmost = TEDSymbol(name: "frontmost", code: 0x70697366, type: typeType) // "pisf"
    public static let gallons = TEDSymbol(name: "gallons", code: 0x67616c6e, type: typeType) // "galn"
    public static let GIFPicture = TEDSymbol(name: "GIFPicture", code: 0x47494666, type: typeType) // "GIFf"
    public static let grams = TEDSymbol(name: "grams", code: 0x6772616d, type: typeType) // "gram"
    public static let graphicText = TEDSymbol(name: "graphicText", code: 0x63677478, type: typeType) // "cgtx"
    public static let id = TEDSymbol(name: "id", code: 0x49442020, type: typeType) // "ID  "
    public static let inches = TEDSymbol(name: "inches", code: 0x696e6368, type: typeType) // "inch"
    public static let index = TEDSymbol(name: "index", code: 0x70696478, type: typeType) // "pidx"
    public static let integer = TEDSymbol(name: "integer", code: 0x6c6f6e67, type: typeType) // "long"
    public static let internationalText = TEDSymbol(name: "internationalText", code: 0x69747874, type: typeType) // "itxt"
    public static let internationalWritingCode = TEDSymbol(name: "internationalWritingCode", code: 0x696e746c, type: typeType) // "intl"
    public static let item = TEDSymbol(name: "item", code: 0x636f626a, type: typeType) // "cobj"
    public static let January = TEDSymbol(name: "January", code: 0x6a616e20, type: typeType) // "jan "
    public static let JPEGPicture = TEDSymbol(name: "JPEGPicture", code: 0x4a504547, type: typeType) // "JPEG"
    public static let July = TEDSymbol(name: "July", code: 0x6a756c20, type: typeType) // "jul "
    public static let June = TEDSymbol(name: "June", code: 0x6a756e20, type: typeType) // "jun "
    public static let kernelProcessId = TEDSymbol(name: "kernelProcessId", code: 0x6b706964, type: typeType) // "kpid"
    public static let kilograms = TEDSymbol(name: "kilograms", code: 0x6b67726d, type: typeType) // "kgrm"
    public static let kilometers = TEDSymbol(name: "kilometers", code: 0x6b6d7472, type: typeType) // "kmtr"
    public static let list = TEDSymbol(name: "list", code: 0x6c697374, type: typeType) // "list"
    public static let liters = TEDSymbol(name: "liters", code: 0x6c697472, type: typeType) // "litr"
    public static let locationReference = TEDSymbol(name: "locationReference", code: 0x696e736c, type: typeType) // "insl"
    public static let longFixed = TEDSymbol(name: "longFixed", code: 0x6c667864, type: typeType) // "lfxd"
    public static let longFixedPoint = TEDSymbol(name: "longFixedPoint", code: 0x6c667074, type: typeType) // "lfpt"
    public static let longFixedRectangle = TEDSymbol(name: "longFixedRectangle", code: 0x6c667263, type: typeType) // "lfrc"
    public static let longPoint = TEDSymbol(name: "longPoint", code: 0x6c706e74, type: typeType) // "lpnt"
    public static let longRectangle = TEDSymbol(name: "longRectangle", code: 0x6c726374, type: typeType) // "lrct"
    public static let machine = TEDSymbol(name: "machine", code: 0x6d616368, type: typeType) // "mach"
    public static let machineLocation = TEDSymbol(name: "machineLocation", code: 0x6d4c6f63, type: typeType) // "mLoc"
    public static let machPort = TEDSymbol(name: "machPort", code: 0x706f7274, type: typeType) // "port"
    public static let March = TEDSymbol(name: "March", code: 0x6d617220, type: typeType) // "mar "
    public static let May = TEDSymbol(name: "May", code: 0x6d617920, type: typeType) // "may "
    public static let meters = TEDSymbol(name: "meters", code: 0x6d657472, type: typeType) // "metr"
    public static let miles = TEDSymbol(name: "miles", code: 0x6d696c65, type: typeType) // "mile"
    public static let miniaturizable = TEDSymbol(name: "miniaturizable", code: 0x69736d6e, type: typeType) // "ismn"
    public static let miniaturized = TEDSymbol(name: "miniaturized", code: 0x706d6e64, type: typeType) // "pmnd"
    public static let missingValue = TEDSymbol(name: "missingValue", code: 0x6d736e67, type: typeType) // "msng"
    public static let modal = TEDSymbol(name: "modal", code: 0x706d6f64, type: typeType) // "pmod"
    public static let modified = TEDSymbol(name: "modified", code: 0x696d6f64, type: typeType) // "imod"
    public static let Monday = TEDSymbol(name: "Monday", code: 0x6d6f6e20, type: typeType) // "mon "
    public static let name = TEDSymbol(name: "name", code: 0x706e616d, type: typeType) // "pnam"
    public static let November = TEDSymbol(name: "November", code: 0x6e6f7620, type: typeType) // "nov "
    public static let null = TEDSymbol(name: "null", code: 0x6e756c6c, type: typeType) // "null"
    public static let October = TEDSymbol(name: "October", code: 0x6f637420, type: typeType) // "oct "
    public static let ounces = TEDSymbol(name: "ounces", code: 0x6f7a7320, type: typeType) // "ozs "
    public static let pagesAcross = TEDSymbol(name: "pagesAcross", code: 0x6c776c61, type: typeType) // "lwla"
    public static let pagesDown = TEDSymbol(name: "pagesDown", code: 0x6c776c64, type: typeType) // "lwld"
    public static let paragraph = TEDSymbol(name: "paragraph", code: 0x63706172, type: typeType) // "cpar"
    public static let parameterInfo = TEDSymbol(name: "parameterInfo", code: 0x706d696e, type: typeType) // "pmin"
    public static let path = TEDSymbol(name: "path", code: 0x70707468, type: typeType) // "ppth"
    public static let PICTPicture = TEDSymbol(name: "PICTPicture", code: 0x50494354, type: typeType) // "PICT"
    public static let pixelMapRecord = TEDSymbol(name: "pixelMapRecord", code: 0x74706d6d, type: typeType) // "tpmm"
    public static let point = TEDSymbol(name: "point", code: 0x51447074, type: typeType) // "QDpt"
    public static let pounds = TEDSymbol(name: "pounds", code: 0x6c627320, type: typeType) // "lbs "
    public static let printSettings = TEDSymbol(name: "printSettings", code: 0x70736574, type: typeType) // "pset"
    public static let processSerialNumber = TEDSymbol(name: "processSerialNumber", code: 0x70736e20, type: typeType) // "psn "
    public static let properties = TEDSymbol(name: "properties", code: 0x70414c4c, type: typeType) // "pALL"
    public static let property_ = TEDSymbol(name: "property_", code: 0x70726f70, type: typeType) // "prop"
    public static let propertyInfo = TEDSymbol(name: "propertyInfo", code: 0x70696e66, type: typeType) // "pinf"
    public static let quarts = TEDSymbol(name: "quarts", code: 0x71727473, type: typeType) // "qrts"
    public static let record = TEDSymbol(name: "record", code: 0x7265636f, type: typeType) // "reco"
    public static let reference = TEDSymbol(name: "reference", code: 0x6f626a20, type: typeType) // "obj "
    public static let requestedPrintTime = TEDSymbol(name: "requestedPrintTime", code: 0x6c777174, type: typeType) // "lwqt"
    public static let resizable = TEDSymbol(name: "resizable", code: 0x7072737a, type: typeType) // "prsz"
    public static let RGB16Color = TEDSymbol(name: "RGB16Color", code: 0x74723136, type: typeType) // "tr16"
    public static let RGB96Color = TEDSymbol(name: "RGB96Color", code: 0x74723936, type: typeType) // "tr96"
    public static let RGBColor = TEDSymbol(name: "RGBColor", code: 0x63524742, type: typeType) // "cRGB"
    public static let rotation = TEDSymbol(name: "rotation", code: 0x74726f74, type: typeType) // "trot"
    public static let Saturday = TEDSymbol(name: "Saturday", code: 0x73617420, type: typeType) // "sat "
    public static let script = TEDSymbol(name: "script", code: 0x73637074, type: typeType) // "scpt"
    public static let September = TEDSymbol(name: "September", code: 0x73657020, type: typeType) // "sep "
    public static let shortFloat = TEDSymbol(name: "shortFloat", code: 0x73696e67, type: typeType) // "sing"
    public static let shortInteger = TEDSymbol(name: "shortInteger", code: 0x73686f72, type: typeType) // "shor"
    public static let size = TEDSymbol(name: "size", code: 0x7074737a, type: typeType) // "ptsz"
    public static let squareFeet = TEDSymbol(name: "squareFeet", code: 0x73716674, type: typeType) // "sqft"
    public static let squareKilometers = TEDSymbol(name: "squareKilometers", code: 0x73716b6d, type: typeType) // "sqkm"
    public static let squareMeters = TEDSymbol(name: "squareMeters", code: 0x7371726d, type: typeType) // "sqrm"
    public static let squareMiles = TEDSymbol(name: "squareMiles", code: 0x73716d69, type: typeType) // "sqmi"
    public static let squareYards = TEDSymbol(name: "squareYards", code: 0x73717964, type: typeType) // "sqyd"
    public static let startingPage = TEDSymbol(name: "startingPage", code: 0x6c776670, type: typeType) // "lwfp"
    public static let string = TEDSymbol(name: "string", code: 0x54455854, type: typeType) // "TEXT"
    public static let styledClipboardText = TEDSymbol(name: "styledClipboardText", code: 0x7374796c, type: typeType) // "styl"
    public static let styledText = TEDSymbol(name: "styledText", code: 0x53545854, type: typeType) // "STXT"
    public static let suiteInfo = TEDSymbol(name: "suiteInfo", code: 0x7375696e, type: typeType) // "suin"
    public static let Sunday = TEDSymbol(name: "Sunday", code: 0x73756e20, type: typeType) // "sun "
    public static let targetPrinter = TEDSymbol(name: "targetPrinter", code: 0x74727072, type: typeType) // "trpr"
    public static let text = TEDSymbol(name: "text", code: 0x63747874, type: typeType) // "ctxt"
    public static let textStyleInfo = TEDSymbol(name: "textStyleInfo", code: 0x74737479, type: typeType) // "tsty"
    public static let Thursday = TEDSymbol(name: "Thursday", code: 0x74687520, type: typeType) // "thu "
    public static let TIFFPicture = TEDSymbol(name: "TIFFPicture", code: 0x54494646, type: typeType) // "TIFF"
    public static let titled = TEDSymbol(name: "titled", code: 0x70746974, type: typeType) // "ptit"
    public static let Tuesday = TEDSymbol(name: "Tuesday", code: 0x74756520, type: typeType) // "tue "
    public static let typeClass = TEDSymbol(name: "typeClass", code: 0x74797065, type: typeType) // "type"
    public static let unicodeText = TEDSymbol(name: "unicodeText", code: 0x75747874, type: typeType) // "utxt"
    public static let unsignedInteger = TEDSymbol(name: "unsignedInteger", code: 0x6d61676e, type: typeType) // "magn"
    public static let utf16Text = TEDSymbol(name: "utf16Text", code: 0x75743136, type: typeType) // "ut16"
    public static let utf8Text = TEDSymbol(name: "utf8Text", code: 0x75746638, type: typeType) // "utf8"
    public static let version = TEDSymbol(name: "version", code: 0x76657273, type: typeType) // "vers"
    public static let visible = TEDSymbol(name: "visible", code: 0x70766973, type: typeType) // "pvis"
    public static let Wednesday = TEDSymbol(name: "Wednesday", code: 0x77656420, type: typeType) // "wed "
    public static let window = TEDSymbol(name: "window", code: 0x6377696e, type: typeType) // "cwin"
    public static let word = TEDSymbol(name: "word", code: 0x63776f72, type: typeType) // "cwor"
    public static let writingCode = TEDSymbol(name: "writingCode", code: 0x70736374, type: typeType) // "psct"
    public static let yards = TEDSymbol(name: "yards", code: 0x79617264, type: typeType) // "yard"
    public static let zoomable = TEDSymbol(name: "zoomable", code: 0x69737a6d, type: typeType) // "iszm"
    public static let zoomed = TEDSymbol(name: "zoomed", code: 0x707a756d, type: typeType) // "pzum"

    // Enumerators
    public static let ask = TEDSymbol(name: "ask", code: 0x61736b20, type: typeEnumerated) // "ask "
    public static let case_ = TEDSymbol(name: "case_", code: 0x63617365, type: typeEnumerated) // "case"
    public static let detailed = TEDSymbol(name: "detailed", code: 0x6c776474, type: typeEnumerated) // "lwdt"
    public static let diacriticals = TEDSymbol(name: "diacriticals", code: 0x64696163, type: typeEnumerated) // "diac"
    public static let expansion = TEDSymbol(name: "expansion", code: 0x65787061, type: typeEnumerated) // "expa"
    public static let hyphens = TEDSymbol(name: "hyphens", code: 0x68797068, type: typeEnumerated) // "hyph"
    public static let no = TEDSymbol(name: "no", code: 0x6e6f2020, type: typeEnumerated) // "no  "
    public static let numericStrings = TEDSymbol(name: "numericStrings", code: 0x6e756d65, type: typeEnumerated) // "nume"
    public static let punctuation = TEDSymbol(name: "punctuation", code: 0x70756e63, type: typeEnumerated) // "punc"
    public static let standard = TEDSymbol(name: "standard", code: 0x6c777374, type: typeEnumerated) // "lwst"
    public static let whitespace = TEDSymbol(name: "whitespace", code: 0x77686974, type: typeEnumerated) // "whit"
    public static let yes = TEDSymbol(name: "yes", code: 0x79657320, type: typeEnumerated) // "yes "
}

public typealias TED = TEDSymbol // allows symbols to be written as (e.g.) TED.name instead of TEDSymbol.name



/******************************************************************************/
// Specifier extensions; these add command methods and property/elements getters based on TextEdit.app terminology

public protocol TEDCommand: SpecifierProtocol {} // provides AE dispatch methods

extension TEDCommand {
    public func activate(directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: NSTimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("activate", eventClass: 0x6d697363, eventID: 0x61637476, // '"misc""actv"'
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, asType: Any.self)
    }
    public func close(directParameter: Any = NoParameter,
            saving: Any = NoParameter,
            savingIn: Any = NoParameter,
            waitReply: Bool = true, withTimeout: NSTimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("close", eventClass: 0x636f7265, eventID: 0x636c6f73, // '"core""clos"'
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("saving", 0x7361766f, saving), // "savo"
                    ("savingIn", 0x6b66696c, savingIn), // "kfil"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, asType: Any.self)
    }
    public func count(directParameter: Any = NoParameter,
            each: Any = NoParameter,
            waitReply: Bool = true, withTimeout: NSTimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("count", eventClass: 0x636f7265, eventID: 0x636e7465, // '"core""cnte"'
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("each", 0x6b6f636c, each), // "kocl"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, asType: Any.self)
    }
    public func delete(directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: NSTimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("delete", eventClass: 0x636f7265, eventID: 0x64656c6f, // '"core""delo"'
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, asType: Any.self)
    }
    public func duplicate(directParameter: Any = NoParameter,
            to: Any = NoParameter,
            withProperties: Any = NoParameter,
            waitReply: Bool = true, withTimeout: NSTimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("duplicate", eventClass: 0x636f7265, eventID: 0x636c6f6e, // '"core""clon"'
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x696e7368, to), // "insh"
                    ("withProperties", 0x70726474, withProperties), // "prdt"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, asType: Any.self)
    }
    public func exists(directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: NSTimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("exists", eventClass: 0x636f7265, eventID: 0x646f6578, // '"core""doex"'
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, asType: Any.self)
    }
    public func get(directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: NSTimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("get", eventClass: 0x636f7265, eventID: 0x67657464, // '"core""getd"'
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, asType: Any.self)
    }
    public func launch(directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: NSTimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("launch", eventClass: 0x61736372, eventID: 0x6e6f6f70, // '"ascr""noop"'
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, asType: Any.self)
    }
    public func make(directParameter: Any = NoParameter,
            new: Any = NoParameter,
            at: Any = NoParameter,
            withData: Any = NoParameter,
            withProperties: Any = NoParameter,
            waitReply: Bool = true, withTimeout: NSTimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("make", eventClass: 0x636f7265, eventID: 0x6372656c, // '"core""crel"'
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("new", 0x6b6f636c, new), // "kocl"
                    ("at", 0x696e7368, at), // "insh"
                    ("withData", 0x64617461, withData), // "data"
                    ("withProperties", 0x70726474, withProperties), // "prdt"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, asType: Any.self)
    }
    public func move(directParameter: Any = NoParameter,
            to: Any = NoParameter,
            waitReply: Bool = true, withTimeout: NSTimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("move", eventClass: 0x636f7265, eventID: 0x6d6f7665, // '"core""move"'
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x696e7368, to), // "insh"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, asType: Any.self)
    }
    public func open(directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: NSTimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("open", eventClass: 0x61657674, eventID: 0x6f646f63, // '"aevt""odoc"'
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, asType: Any.self)
    }
    public func openLocation(directParameter: Any = NoParameter,
            window: Any = NoParameter,
            waitReply: Bool = true, withTimeout: NSTimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("openLocation", eventClass: 0x4755524c, eventID: 0x4755524c, // '"GURL""GURL"'
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("window", 0x57494e44, window), // "WIND"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, asType: Any.self)
    }
    public func print(directParameter: Any = NoParameter,
            printDialog: Any = NoParameter,
            withProperties: Any = NoParameter,
            waitReply: Bool = true, withTimeout: NSTimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("print", eventClass: 0x61657674, eventID: 0x70646f63, // '"aevt""pdoc"'
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("printDialog", 0x70646c67, printDialog), // "pdlg"
                    ("withProperties", 0x70726474, withProperties), // "prdt"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, asType: Any.self)
    }
    public func quit(directParameter: Any = NoParameter,
            saving: Any = NoParameter,
            waitReply: Bool = true, withTimeout: NSTimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("quit", eventClass: 0x61657674, eventID: 0x71756974, // '"aevt""quit"'
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("saving", 0x7361766f, saving), // "savo"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, asType: Any.self)
    }
    public func reopen(directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: NSTimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("reopen", eventClass: 0x61657674, eventID: 0x72617070, // '"aevt""rapp"'
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, asType: Any.self)
    }
    public func run(directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: NSTimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("run", eventClass: 0x61657674, eventID: 0x6f617070, // '"aevt""oapp"'
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, asType: Any.self)
    }
    public func save(directParameter: Any = NoParameter,
            as_: Any = NoParameter,
            in_: Any = NoParameter,
            waitReply: Bool = true, withTimeout: NSTimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("save", eventClass: 0x636f7265, eventID: 0x73617665, // '"core""save"'
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("as_", 0x666c7470, as_), // "fltp"
                    ("in_", 0x6b66696c, in_), // "kfil"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, asType: Any.self)
    }
    public func set(directParameter: Any = NoParameter,
            to: Any = NoParameter,
            waitReply: Bool = true, withTimeout: NSTimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("set", eventClass: 0x636f7265, eventID: 0x73657464, // '"core""setd"'
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x64617461, to), // "data"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, asType: Any.self)
    }
}


public protocol TEDQuery: ObjectSpecifierExtension, TEDCommand {} // provides vars and methods for constructing specifiers

extension TEDQuery {
    
    // Properties
    public var bounds: TEDObject {return self.property(0x70626e64) as! TEDObject} // "pbnd"
    public var class_: TEDObject {return self.property(0x70636c73) as! TEDObject} // "pcls"
    public var closeable: TEDObject {return self.property(0x68636c62) as! TEDObject} // "hclb"
    public var collating: TEDObject {return self.property(0x6c77636c) as! TEDObject} // "lwcl"
    public var color: TEDObject {return self.property(0x636f6c72) as! TEDObject} // "colr"
    public var copies: TEDObject {return self.property(0x6c776370) as! TEDObject} // "lwcp"
    public var document: TEDObject {return self.property(0x646f6375) as! TEDObject} // "docu"
    public var endingPage: TEDObject {return self.property(0x6c776c70) as! TEDObject} // "lwlp"
    public var errorHandling: TEDObject {return self.property(0x6c776568) as! TEDObject} // "lweh"
    public var faxNumber: TEDObject {return self.property(0x6661786e) as! TEDObject} // "faxn"
    public var fileName: TEDObject {return self.property(0x6174666e) as! TEDObject} // "atfn"
    public var floating: TEDObject {return self.property(0x6973666c) as! TEDObject} // "isfl"
    public var font: TEDObject {return self.property(0x666f6e74) as! TEDObject} // "font"
    public var frontmost: TEDObject {return self.property(0x70697366) as! TEDObject} // "pisf"
    public var id: TEDObject {return self.property(0x49442020) as! TEDObject} // "ID  "
    public var index: TEDObject {return self.property(0x70696478) as! TEDObject} // "pidx"
    public var miniaturizable: TEDObject {return self.property(0x69736d6e) as! TEDObject} // "ismn"
    public var miniaturized: TEDObject {return self.property(0x706d6e64) as! TEDObject} // "pmnd"
    public var modal: TEDObject {return self.property(0x706d6f64) as! TEDObject} // "pmod"
    public var modified: TEDObject {return self.property(0x696d6f64) as! TEDObject} // "imod"
    public var name: TEDObject {return self.property(0x706e616d) as! TEDObject} // "pnam"
    public var pagesAcross: TEDObject {return self.property(0x6c776c61) as! TEDObject} // "lwla"
    public var pagesDown: TEDObject {return self.property(0x6c776c64) as! TEDObject} // "lwld"
    public var path: TEDObject {return self.property(0x70707468) as! TEDObject} // "ppth"
    public var properties: TEDObject {return self.property(0x70414c4c) as! TEDObject} // "pALL"
    public var requestedPrintTime: TEDObject {return self.property(0x6c777174) as! TEDObject} // "lwqt"
    public var resizable: TEDObject {return self.property(0x7072737a) as! TEDObject} // "prsz"
    public var size: TEDObject {return self.property(0x7074737a) as! TEDObject} // "ptsz"
    public var startingPage: TEDObject {return self.property(0x6c776670) as! TEDObject} // "lwfp"
    public var targetPrinter: TEDObject {return self.property(0x74727072) as! TEDObject} // "trpr"
    public var titled: TEDObject {return self.property(0x70746974) as! TEDObject} // "ptit"
    public var version: TEDObject {return self.property(0x76657273) as! TEDObject} // "vers"
    public var visible: TEDObject {return self.property(0x70766973) as! TEDObject} // "pvis"
    public var zoomable: TEDObject {return self.property(0x69737a6d) as! TEDObject} // "iszm"
    public var zoomed: TEDObject {return self.property(0x707a756d) as! TEDObject} // "pzum"

    // Elements
    public var applications: TEDElements {return self.elements(0x63617070) as! TEDElements} // "capp"
    public var attachment: TEDElements {return self.elements(0x61747473) as! TEDElements} // "atts"
    public var attributeRuns: TEDElements {return self.elements(0x63617472) as! TEDElements} // "catr"
    public var characters: TEDElements {return self.elements(0x63686120) as! TEDElements} // "cha "
    public var colors: TEDElements {return self.elements(0x636f6c72) as! TEDElements} // "colr"
    public var documents: TEDElements {return self.elements(0x646f6375) as! TEDElements} // "docu"
    public var items: TEDElements {return self.elements(0x636f626a) as! TEDElements} // "cobj"
    public var paragraphs: TEDElements {return self.elements(0x63706172) as! TEDElements} // "cpar"
    public var printSettings: TEDElements {return self.elements(0x70736574) as! TEDElements} // "pset"
    public var text: TEDElements {return self.elements(0x63747874) as! TEDElements} // "ctxt"
    public var windows: TEDElements {return self.elements(0x6377696e) as! TEDElements} // "cwin"
    public var words: TEDElements {return self.elements(0x63776f72) as! TEDElements} // "cwor"
}


/******************************************************************************/
// Specifier subclasses add app-specific extensions

public class TEDInsertion: InsertionSpecifier, TEDCommand {}

public class TEDObject: ObjectSpecifier, TEDQuery {
    public typealias InsertionSpecifierType = TEDInsertion
    public typealias ObjectSpecifierType = TEDObject
    public typealias ElementsSpecifierType = TEDElements
}

public class TEDElements: TEDObject, ElementsSpecifierExtension {}

public class TEDRoot: RootSpecifier, TEDQuery, RootSpecifierExtension {
    public typealias InsertionSpecifierType = TEDInsertion
    public typealias ObjectSpecifierType = TEDObject
    public typealias ElementsSpecifierType = TEDElements
    public override class var nullAppData: AppData { return gNullAppData }
}

public class TextEdit: TEDRoot, ApplicationExtension {
    public convenience init(launchOptions: LaunchOptions = DefaultLaunchOptions, relaunchMode: RelaunchMode = DefaultRelaunchMode) {
        self.init(rootObject: AppRootDesc, appData: self.dynamicType.nullAppData.targetCopy(
                                .BundleIdentifier("com.apple.TextEdit", true), launchOptions: launchOptions, relaunchMode: relaunchMode))
    }
}

// App/Con/Its root objects used to construct untargeted specifiers; these can be used to construct specifiers for use in commands, though cannot send commands themselves

public let TEDApp = gNullAppData.rootObjects.app as! TEDRoot
public let TEDCon = gNullAppData.rootObjects.con as! TEDRoot
public let TEDIts = gNullAppData.rootObjects.its as! TEDRoot

