//
//  AEApplicationGlue.swift
//  built-in 
//  SwiftAutomation.framework 0.1.0
//  `aeglue -o /Users/has -d`
//


import Foundation



/******************************************************************************/
// Untargeted AppData instance used in App, Con, Its roots; also used by Application constructors to create their own targeted AppData instances

private let gUntargetedAppData = AppData(glueInfo: GlueInfo(insertionSpecifierType: AEInsertion.self,
                                                            objectSpecifierType: AEItem.self,
                                                            multiObjectSpecifierType: AEItems.self,
                                                            rootSpecifierType: AERoot.self,
                                                            symbolType: AESymbol.self,
                                                            formatter: gSpecifierFormatter))


/******************************************************************************/
// Specifier formatter

private let gSpecifierFormatter = SpecifierFormatter(applicationClassName: "AEApplication",
                                                     classNamePrefix: "AE",
                                                     propertyNames: [
                                                                     0x70636c73: "class_", // "pcls"
                                                                     0x49442020: "id", // "ID  "
                                                                     0x70414c4c: "properties", // "pALL"
                                                     ],
                                                     elementsNames: [
                                                                     0x636f626a: "items", // "cobj"
                                                     ])


/******************************************************************************/
// Symbol subclass defines static type/enum/property constants based on built-in terminology

public class AESymbol: Symbol {

    override public var typeAliasName: String {return "AE"}

    public override class func symbol(code: OSType, type: OSType = typeType, descriptor: NSAppleEventDescriptor? = nil) -> AESymbol {
        switch (code) {
        case 0x616c6973: return self.alias // "alis"
        case 0x2a2a2a2a: return self.anything // "****"
        case 0x62756e64: return self.applicationBundleId // "bund"
        case 0x7369676e: return self.applicationSignature // "sign"
        case 0x6170726c: return self.applicationUrl // "aprl"
        case 0x61707220: return self.April // "apr "
        case 0x61736b20: return self.ask // "ask "
        case 0x61756720: return self.August // "aug "
        case 0x62657374: return self.best // "best"
        case 0x626f6f6c: return self.boolean // "bool"
        case 0x71647274: return self.boundingRectangle // "qdrt"
        case 0x63617365: return self.case_ // "case"
        case 0x70636c73: return self.class_ // "pcls"
        case 0x636c7274: return self.colorTable // "clrt"
        case 0x74646173: return self.dashStyle // "tdas"
        case 0x74647461: return self.data // "tdta"
        case 0x6c647420: return self.date // "ldt "
        case 0x64656320: return self.December // "dec "
        case 0x6465636d: return self.decimalStruct // "decm"
        case 0x64696163: return self.diacriticals // "diac"
        case 0x636f6d70: return self.doubleInteger // "comp"
        case 0x656e6373: return self.encodedString // "encs"
        case 0x656e756d: return self.enumerator // "enum"
        case 0x45505320: return self.EPSPicture // "EPS "
        case 0x65787061: return self.expansion // "expa"
        case 0x65787465: return self.extendedFloat // "exte"
        case 0x66656220: return self.February // "feb "
        case 0x66737266: return self.fileRef // "fsrf"
        case 0x66737320: return self.fileSpecification // "fss "
        case 0x6675726c: return self.fileUrl // "furl"
        case 0x66697864: return self.fixed // "fixd"
        case 0x66706e74: return self.fixedPoint // "fpnt"
        case 0x66726374: return self.fixedRectangle // "frct"
        case 0x646f7562: return self.float // "doub"
        case 0x6c64626c: return self.float128bit // "ldbl"
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
        case 0x6d617220: return self.March // "mar "
        case 0x6d617920: return self.May // "may "
        case 0x6d736e67: return self.missingValue // "msng"
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
        case 0x7265636f: return self.record // "reco"
        case 0x6f626a20: return self.reference // "obj "
        case 0x74723136: return self.RGB16Color // "tr16"
        case 0x74723936: return self.RGB96Color // "tr96"
        case 0x63524742: return self.RGBColor // "cRGB"
        case 0x74726f74: return self.rotation // "trot"
        case 0x73617420: return self.Saturday // "sat "
        case 0x73637074: return self.script // "scpt"
        case 0x73657020: return self.September // "sep "
        case 0x73696e67: return self.shortFloat // "sing"
        case 0x73686f72: return self.shortInteger // "shor"
        case 0x54455854: return self.string // "TEXT"
        case 0x7374796c: return self.styledClipboardText // "styl"
        case 0x53545854: return self.styledText // "STXT"
        case 0x73756e20: return self.Sunday // "sun "
        case 0x74737479: return self.textStyleInfo // "tsty"
        case 0x74687520: return self.Thursday // "thu "
        case 0x54494646: return self.TIFFPicture // "TIFF"
        case 0x74756520: return self.Tuesday // "tue "
        case 0x74797065: return self.typeClass // "type"
        case 0x75747874: return self.unicodeText // "utxt"
        case 0x6d61676e: return self.unsignedInteger // "magn"
        case 0x75743136: return self.utf16Text // "ut16"
        case 0x75746638: return self.utf8Text // "utf8"
        case 0x76657273: return self.version // "vers"
        case 0x77656420: return self.Wednesday // "wed "
        case 0x77686974: return self.whitespace // "whit"
        case 0x70736374: return self.writingCode // "psct"
        case 0x79657320: return self.yes // "yes "
        default: return super.symbol(code: code, type: type, descriptor: descriptor) as! AESymbol
        }
    }

    // Types/properties
    public static let alias = AESymbol(name: "alias", code: 0x616c6973, type: typeType) // "alis"
    public static let anything = AESymbol(name: "anything", code: 0x2a2a2a2a, type: typeType) // "****"
    public static let applicationBundleId = AESymbol(name: "applicationBundleId", code: 0x62756e64, type: typeType) // "bund"
    public static let applicationSignature = AESymbol(name: "applicationSignature", code: 0x7369676e, type: typeType) // "sign"
    public static let applicationUrl = AESymbol(name: "applicationUrl", code: 0x6170726c, type: typeType) // "aprl"
    public static let April = AESymbol(name: "April", code: 0x61707220, type: typeType) // "apr "
    public static let August = AESymbol(name: "August", code: 0x61756720, type: typeType) // "aug "
    public static let best = AESymbol(name: "best", code: 0x62657374, type: typeType) // "best"
    public static let boolean = AESymbol(name: "boolean", code: 0x626f6f6c, type: typeType) // "bool"
    public static let boundingRectangle = AESymbol(name: "boundingRectangle", code: 0x71647274, type: typeType) // "qdrt"
    public static let class_ = AESymbol(name: "class_", code: 0x70636c73, type: typeType) // "pcls"
    public static let colorTable = AESymbol(name: "colorTable", code: 0x636c7274, type: typeType) // "clrt"
    public static let dashStyle = AESymbol(name: "dashStyle", code: 0x74646173, type: typeType) // "tdas"
    public static let data = AESymbol(name: "data", code: 0x74647461, type: typeType) // "tdta"
    public static let date = AESymbol(name: "date", code: 0x6c647420, type: typeType) // "ldt "
    public static let December = AESymbol(name: "December", code: 0x64656320, type: typeType) // "dec "
    public static let decimalStruct = AESymbol(name: "decimalStruct", code: 0x6465636d, type: typeType) // "decm"
    public static let doubleInteger = AESymbol(name: "doubleInteger", code: 0x636f6d70, type: typeType) // "comp"
    public static let encodedString = AESymbol(name: "encodedString", code: 0x656e6373, type: typeType) // "encs"
    public static let enumerator = AESymbol(name: "enumerator", code: 0x656e756d, type: typeType) // "enum"
    public static let EPSPicture = AESymbol(name: "EPSPicture", code: 0x45505320, type: typeType) // "EPS "
    public static let extendedFloat = AESymbol(name: "extendedFloat", code: 0x65787465, type: typeType) // "exte"
    public static let February = AESymbol(name: "February", code: 0x66656220, type: typeType) // "feb "
    public static let fileRef = AESymbol(name: "fileRef", code: 0x66737266, type: typeType) // "fsrf"
    public static let fileSpecification = AESymbol(name: "fileSpecification", code: 0x66737320, type: typeType) // "fss "
    public static let fileUrl = AESymbol(name: "fileUrl", code: 0x6675726c, type: typeType) // "furl"
    public static let fixed = AESymbol(name: "fixed", code: 0x66697864, type: typeType) // "fixd"
    public static let fixedPoint = AESymbol(name: "fixedPoint", code: 0x66706e74, type: typeType) // "fpnt"
    public static let fixedRectangle = AESymbol(name: "fixedRectangle", code: 0x66726374, type: typeType) // "frct"
    public static let float = AESymbol(name: "float", code: 0x646f7562, type: typeType) // "doub"
    public static let float128bit = AESymbol(name: "float128bit", code: 0x6c64626c, type: typeType) // "ldbl"
    public static let Friday = AESymbol(name: "Friday", code: 0x66726920, type: typeType) // "fri "
    public static let GIFPicture = AESymbol(name: "GIFPicture", code: 0x47494666, type: typeType) // "GIFf"
    public static let graphicText = AESymbol(name: "graphicText", code: 0x63677478, type: typeType) // "cgtx"
    public static let id = AESymbol(name: "id", code: 0x49442020, type: typeType) // "ID  "
    public static let integer = AESymbol(name: "integer", code: 0x6c6f6e67, type: typeType) // "long"
    public static let internationalText = AESymbol(name: "internationalText", code: 0x69747874, type: typeType) // "itxt"
    public static let internationalWritingCode = AESymbol(name: "internationalWritingCode", code: 0x696e746c, type: typeType) // "intl"
    public static let item = AESymbol(name: "item", code: 0x636f626a, type: typeType) // "cobj"
    public static let January = AESymbol(name: "January", code: 0x6a616e20, type: typeType) // "jan "
    public static let JPEGPicture = AESymbol(name: "JPEGPicture", code: 0x4a504547, type: typeType) // "JPEG"
    public static let July = AESymbol(name: "July", code: 0x6a756c20, type: typeType) // "jul "
    public static let June = AESymbol(name: "June", code: 0x6a756e20, type: typeType) // "jun "
    public static let kernelProcessId = AESymbol(name: "kernelProcessId", code: 0x6b706964, type: typeType) // "kpid"
    public static let list = AESymbol(name: "list", code: 0x6c697374, type: typeType) // "list"
    public static let locationReference = AESymbol(name: "locationReference", code: 0x696e736c, type: typeType) // "insl"
    public static let longFixed = AESymbol(name: "longFixed", code: 0x6c667864, type: typeType) // "lfxd"
    public static let longFixedPoint = AESymbol(name: "longFixedPoint", code: 0x6c667074, type: typeType) // "lfpt"
    public static let longFixedRectangle = AESymbol(name: "longFixedRectangle", code: 0x6c667263, type: typeType) // "lfrc"
    public static let longPoint = AESymbol(name: "longPoint", code: 0x6c706e74, type: typeType) // "lpnt"
    public static let longRectangle = AESymbol(name: "longRectangle", code: 0x6c726374, type: typeType) // "lrct"
    public static let machine = AESymbol(name: "machine", code: 0x6d616368, type: typeType) // "mach"
    public static let machineLocation = AESymbol(name: "machineLocation", code: 0x6d4c6f63, type: typeType) // "mLoc"
    public static let machPort = AESymbol(name: "machPort", code: 0x706f7274, type: typeType) // "port"
    public static let March = AESymbol(name: "March", code: 0x6d617220, type: typeType) // "mar "
    public static let May = AESymbol(name: "May", code: 0x6d617920, type: typeType) // "may "
    public static let missingValue = AESymbol(name: "missingValue", code: 0x6d736e67, type: typeType) // "msng"
    public static let Monday = AESymbol(name: "Monday", code: 0x6d6f6e20, type: typeType) // "mon "
    public static let November = AESymbol(name: "November", code: 0x6e6f7620, type: typeType) // "nov "
    public static let null = AESymbol(name: "null", code: 0x6e756c6c, type: typeType) // "null"
    public static let October = AESymbol(name: "October", code: 0x6f637420, type: typeType) // "oct "
    public static let PICTPicture = AESymbol(name: "PICTPicture", code: 0x50494354, type: typeType) // "PICT"
    public static let pixelMapRecord = AESymbol(name: "pixelMapRecord", code: 0x74706d6d, type: typeType) // "tpmm"
    public static let point = AESymbol(name: "point", code: 0x51447074, type: typeType) // "QDpt"
    public static let processSerialNumber = AESymbol(name: "processSerialNumber", code: 0x70736e20, type: typeType) // "psn "
    public static let properties = AESymbol(name: "properties", code: 0x70414c4c, type: typeType) // "pALL"
    public static let property_ = AESymbol(name: "property_", code: 0x70726f70, type: typeType) // "prop"
    public static let record = AESymbol(name: "record", code: 0x7265636f, type: typeType) // "reco"
    public static let reference = AESymbol(name: "reference", code: 0x6f626a20, type: typeType) // "obj "
    public static let RGB16Color = AESymbol(name: "RGB16Color", code: 0x74723136, type: typeType) // "tr16"
    public static let RGB96Color = AESymbol(name: "RGB96Color", code: 0x74723936, type: typeType) // "tr96"
    public static let RGBColor = AESymbol(name: "RGBColor", code: 0x63524742, type: typeType) // "cRGB"
    public static let rotation = AESymbol(name: "rotation", code: 0x74726f74, type: typeType) // "trot"
    public static let Saturday = AESymbol(name: "Saturday", code: 0x73617420, type: typeType) // "sat "
    public static let script = AESymbol(name: "script", code: 0x73637074, type: typeType) // "scpt"
    public static let September = AESymbol(name: "September", code: 0x73657020, type: typeType) // "sep "
    public static let shortFloat = AESymbol(name: "shortFloat", code: 0x73696e67, type: typeType) // "sing"
    public static let shortInteger = AESymbol(name: "shortInteger", code: 0x73686f72, type: typeType) // "shor"
    public static let string = AESymbol(name: "string", code: 0x54455854, type: typeType) // "TEXT"
    public static let styledClipboardText = AESymbol(name: "styledClipboardText", code: 0x7374796c, type: typeType) // "styl"
    public static let styledText = AESymbol(name: "styledText", code: 0x53545854, type: typeType) // "STXT"
    public static let Sunday = AESymbol(name: "Sunday", code: 0x73756e20, type: typeType) // "sun "
    public static let textStyleInfo = AESymbol(name: "textStyleInfo", code: 0x74737479, type: typeType) // "tsty"
    public static let Thursday = AESymbol(name: "Thursday", code: 0x74687520, type: typeType) // "thu "
    public static let TIFFPicture = AESymbol(name: "TIFFPicture", code: 0x54494646, type: typeType) // "TIFF"
    public static let Tuesday = AESymbol(name: "Tuesday", code: 0x74756520, type: typeType) // "tue "
    public static let typeClass = AESymbol(name: "typeClass", code: 0x74797065, type: typeType) // "type"
    public static let unicodeText = AESymbol(name: "unicodeText", code: 0x75747874, type: typeType) // "utxt"
    public static let unsignedInteger = AESymbol(name: "unsignedInteger", code: 0x6d61676e, type: typeType) // "magn"
    public static let utf16Text = AESymbol(name: "utf16Text", code: 0x75743136, type: typeType) // "ut16"
    public static let utf8Text = AESymbol(name: "utf8Text", code: 0x75746638, type: typeType) // "utf8"
    public static let version = AESymbol(name: "version", code: 0x76657273, type: typeType) // "vers"
    public static let Wednesday = AESymbol(name: "Wednesday", code: 0x77656420, type: typeType) // "wed "
    public static let writingCode = AESymbol(name: "writingCode", code: 0x70736374, type: typeType) // "psct"

    // Enumerators
    public static let ask = AESymbol(name: "ask", code: 0x61736b20, type: typeEnumerated) // "ask "
    public static let case_ = AESymbol(name: "case_", code: 0x63617365, type: typeEnumerated) // "case"
    public static let diacriticals = AESymbol(name: "diacriticals", code: 0x64696163, type: typeEnumerated) // "diac"
    public static let expansion = AESymbol(name: "expansion", code: 0x65787061, type: typeEnumerated) // "expa"
    public static let hyphens = AESymbol(name: "hyphens", code: 0x68797068, type: typeEnumerated) // "hyph"
    public static let no = AESymbol(name: "no", code: 0x6e6f2020, type: typeEnumerated) // "no  "
    public static let numericStrings = AESymbol(name: "numericStrings", code: 0x6e756d65, type: typeEnumerated) // "nume"
    public static let punctuation = AESymbol(name: "punctuation", code: 0x70756e63, type: typeEnumerated) // "punc"
    public static let whitespace = AESymbol(name: "whitespace", code: 0x77686974, type: typeEnumerated) // "whit"
    public static let yes = AESymbol(name: "yes", code: 0x79657320, type: typeEnumerated) // "yes "
}

public typealias AE = AESymbol // allows symbols to be written as (e.g.) AE.name instead of AESymbol.name



/******************************************************************************/
// Specifier extensions; these add command methods and property/elements getters based on built-in terminology

public protocol AECommand: SpecifierProtocol {} // provides AE dispatch methods

// Command->Any will be bound when return type can't be inferred, else Command->T

extension AECommand {
    @discardableResult public func activate(_ directParameter: Any = NoParameter,
            resultType: Symbol? = nil, waitReply: Bool = true,
            withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "activate", eventClass: 0x6d697363, eventID: 0x61637476, // "misc"/"actv"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: resultType, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering)
    }
    public func activate<T>(_ directParameter: Any = NoParameter,
            resultType: Symbol? = nil, waitReply: Bool = true,
            withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "activate", eventClass: 0x6d697363, eventID: 0x61637476, // "misc"/"actv"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: resultType, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func get(_ directParameter: Any = NoParameter,
            resultType: Symbol? = nil, waitReply: Bool = true,
            withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "get", eventClass: 0x636f7265, eventID: 0x67657464, // "core"/"getd"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: resultType, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering)
    }
    public func get<T>(_ directParameter: Any = NoParameter,
            resultType: Symbol? = nil, waitReply: Bool = true,
            withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "get", eventClass: 0x636f7265, eventID: 0x67657464, // "core"/"getd"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: resultType, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func open(_ directParameter: Any = NoParameter,
            resultType: Symbol? = nil, waitReply: Bool = true,
            withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "open", eventClass: 0x61657674, eventID: 0x6f646f63, // "aevt"/"odoc"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: resultType, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering)
    }
    public func open<T>(_ directParameter: Any = NoParameter,
            resultType: Symbol? = nil, waitReply: Bool = true,
            withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "open", eventClass: 0x61657674, eventID: 0x6f646f63, // "aevt"/"odoc"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: resultType, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func openLocation(_ directParameter: Any = NoParameter,
            window: Any = NoParameter,
            resultType: Symbol? = nil, waitReply: Bool = true,
            withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "openLocation", eventClass: 0x4755524c, eventID: 0x4755524c, // "GURL"/"GURL"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("window", 0x57494e44, window), // "WIND"
                ], requestedType: resultType, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering)
    }
    public func openLocation<T>(_ directParameter: Any = NoParameter,
            window: Any = NoParameter,
            resultType: Symbol? = nil, waitReply: Bool = true,
            withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "openLocation", eventClass: 0x4755524c, eventID: 0x4755524c, // "GURL"/"GURL"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("window", 0x57494e44, window), // "WIND"
                ], requestedType: resultType, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func print(_ directParameter: Any = NoParameter,
            resultType: Symbol? = nil, waitReply: Bool = true,
            withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "print", eventClass: 0x61657674, eventID: 0x70646f63, // "aevt"/"pdoc"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: resultType, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering)
    }
    public func print<T>(_ directParameter: Any = NoParameter,
            resultType: Symbol? = nil, waitReply: Bool = true,
            withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "print", eventClass: 0x61657674, eventID: 0x70646f63, // "aevt"/"pdoc"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: resultType, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func quit(_ directParameter: Any = NoParameter,
            saving: Any = NoParameter,
            resultType: Symbol? = nil, waitReply: Bool = true,
            withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "quit", eventClass: 0x61657674, eventID: 0x71756974, // "aevt"/"quit"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("saving", 0x7361766f, saving), // "savo"
                ], requestedType: resultType, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering)
    }
    public func quit<T>(_ directParameter: Any = NoParameter,
            saving: Any = NoParameter,
            resultType: Symbol? = nil, waitReply: Bool = true,
            withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "quit", eventClass: 0x61657674, eventID: 0x71756974, // "aevt"/"quit"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("saving", 0x7361766f, saving), // "savo"
                ], requestedType: resultType, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func reopen(_ directParameter: Any = NoParameter,
            resultType: Symbol? = nil, waitReply: Bool = true,
            withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "reopen", eventClass: 0x61657674, eventID: 0x72617070, // "aevt"/"rapp"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: resultType, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering)
    }
    public func reopen<T>(_ directParameter: Any = NoParameter,
            resultType: Symbol? = nil, waitReply: Bool = true,
            withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "reopen", eventClass: 0x61657674, eventID: 0x72617070, // "aevt"/"rapp"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: resultType, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func run(_ directParameter: Any = NoParameter,
            resultType: Symbol? = nil, waitReply: Bool = true,
            withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "run", eventClass: 0x61657674, eventID: 0x6f617070, // "aevt"/"oapp"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: resultType, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering)
    }
    public func run<T>(_ directParameter: Any = NoParameter,
            resultType: Symbol? = nil, waitReply: Bool = true,
            withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "run", eventClass: 0x61657674, eventID: 0x6f617070, // "aevt"/"oapp"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: resultType, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func set(_ directParameter: Any = NoParameter,
            to: Any = NoParameter,
            resultType: Symbol? = nil, waitReply: Bool = true,
            withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "set", eventClass: 0x636f7265, eventID: 0x73657464, // "core"/"setd"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x64617461, to), // "data"
                ], requestedType: resultType, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering)
    }
    public func set<T>(_ directParameter: Any = NoParameter,
            to: Any = NoParameter,
            resultType: Symbol? = nil, waitReply: Bool = true,
            withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "set", eventClass: 0x636f7265, eventID: 0x73657464, // "core"/"setd"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x64617461, to), // "data"
                ], requestedType: resultType, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering)
    }
}


public protocol AEQuery: ObjectSpecifierExtension, AECommand {} // provides vars and methods for constructing specifiers

extension AEQuery {
    
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


// by index/name/id/previous/next
// first/middle/last/any
public class AEItem: ObjectSpecifier, AEQuery {
    public typealias InsertionSpecifierType = AEInsertion
    public typealias ObjectSpecifierType = AEItem
    public typealias MultipleObjectSpecifierType = AEItems
}

// by range/test
// all
public class AEItems: AEItem, ElementsSpecifierExtension {}

// App/Con/Its
public class AERoot: RootSpecifier, AEQuery, RootSpecifierExtension {
    public typealias InsertionSpecifierType = AEInsertion
    public typealias ObjectSpecifierType = AEItem
    public typealias MultipleObjectSpecifierType = AEItems
    public override class var untargetedAppData: AppData { return gUntargetedAppData }
}

// application
public class AEApplication: AERoot, ApplicationExtension {}

// App/Con/Its root objects used to construct untargeted specifiers; these can be used to construct specifiers for use in commands, though cannot send commands themselves

public let AEApp = gUntargetedAppData.rootObjects.app as! AERoot
public let AECon = gUntargetedAppData.rootObjects.con as! AERoot
public let AEIts = gUntargetedAppData.rootObjects.its as! AERoot

