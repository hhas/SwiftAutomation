//
//  ContactsGlue.swift
//  Contacts.app 12.0
//  SwiftAutomation.framework 0.1.0
//  `aeglue 'Contacts.app'`
//


import Foundation
import AppleEvents
import SwiftAutomation


/******************************************************************************/
// Create an untargeted AppData instance for use in App, Con, Its roots,
// and in Application initializers to create targeted AppData instances.

private let _specifierFormatter = SwiftAutomation.SpecifierFormatter(
        applicationClassName: "Contacts",
        classNamePrefix: "CON",
        typeNames: [
                0x617a3237: "address", // "az27"
                0x617a3835: "AIM", // "az85"
                0x617a3232: "AIMHandle", // "az22"
                0x616c6973: "alias", // "alis"
                0x2a2a2a2a: "anything", // "****"
                0x63617070: "application", // "capp"
                0x62756e64: "applicationBundleID", // "bund"
                0x7369676e: "applicationSignature", // "sign"
                0x6170726c: "applicationURL", // "aprl"
                0x61707220: "April", // "apr "
                0x61626275: "archive", // "abbu"
                0x61736b20: "ask", // "ask "
                0x61756720: "August", // "aug "
                0x62657374: "best", // "best"
                0x617a3131: "birthDate", // "az11"
                0x626d726b: "bookmarkData", // "bmrk"
                0x626f6f6c: "boolean", // "bool"
                0x71647274: "boundingRectangle", // "qdrt"
                0x70626e64: "bounds", // "pbnd"
                0x63617365: "case_", // "case"
                0x617a3239: "city", // "az29"
                0x70636c73: "class_", // "pcls"
                0x68636c62: "closeable", // "hclb"
                0x6c77636c: "collating", // "lwcl"
                0x636c7274: "colorTable", // "clrt"
                0x617a3531: "company", // "az51"
                0x656e756d: "constant", // "enum"
                0x617a3136: "contactInfo", // "az16"
                0x6c776370: "copies", // "lwcp"
                0x617a3332: "country", // "az32"
                0x617a3333: "countryCode", // "az33"
                0x617a3335: "creationDate", // "az35"
                0x617a3532: "customDate", // "az52"
                0x74646173: "dashStyle", // "tdas"
                0x74647461: "data", // "tdta"
                0x6c647420: "date", // "ldt "
                0x64656320: "December", // "dec "
                0x6465636d: "decimalStruct", // "decm"
                0x617a3633: "defaultCountryCode", // "az63"
                0x617a3535: "department", // "az55"
                0x6c776474: "detailed", // "lwdt"
                0x64696163: "diacriticals", // "diac"
                0x646f6375: "document", // "docu"
                0x636f6d70: "doubleInteger", // "comp"
                0x617a3231: "email", // "az21"
                0x656e6373: "encodedString", // "encs"
                0x6c776c70: "endingPage", // "lwlp"
                0x617a6636: "entry", // "azf6"
                0x45505320: "EPSPicture", // "EPS "
                0x6c776568: "errorHandling", // "lweh"
                0x65787061: "expansion", // "expa"
                0x617a3934: "Facebook", // "az94"
                0x6661786e: "faxNumber", // "faxn"
                0x66656220: "February", // "feb "
                0x66696c65: "file", // "file"
                0x66737266: "fileRef", // "fsrf"
                0x6675726c: "fileURL", // "furl"
                0x617a6637: "firstName", // "azf7"
                0x66697864: "fixed", // "fixd"
                0x66706e74: "fixedPoint", // "fpnt"
                0x66726374: "fixedRectangle", // "frct"
                0x617a3635: "formattedAddress", // "az65"
                0x66726920: "Friday", // "fri "
                0x70697366: "frontmost", // "pisf"
                0x617a3836: "GaduGadu", // "az86"
                0x47494666: "GIFPicture", // "GIFf"
                0x617a3837: "GoogleTalk", // "az87"
                0x63677478: "graphicText", // "cgtx"
                0x617a6635: "group", // "azf5"
                0x617a3133: "homePage", // "az13"
                0x68797068: "hyphens", // "hyph"
                0x617a3838: "ICQ", // "az88"
                0x617a3236: "ICQHandle", // "az26"
                0x49442020: "id", // "ID  "
                0x617a3530: "image", // "az50"
                0x70696478: "index", // "pidx"
                0x617a3830: "instantMessage", // "az80"
                0x6c6f6e67: "integer", // "long"
                0x69747874: "internationalText", // "itxt"
                0x696e746c: "internationalWritingCode", // "intl"
                0x636f626a: "item", // "cobj"
                0x617a3839: "Jabber", // "az89"
                0x617a3233: "JabberHandle", // "az23"
                0x6a616e20: "January", // "jan "
                0x617a3132: "jobTitle", // "az12"
                0x4a504547: "JPEGPicture", // "JPEG"
                0x6a756c20: "July", // "jul "
                0x6a756e20: "June", // "jun "
                0x6b706964: "kernelProcessID", // "kpid"
                0x617a3138: "label", // "az18"
                0x6c64626c: "largeReal", // "ldbl"
                0x617a6638: "lastName", // "azf8"
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
                0x617a3432: "maidenName", // "az42"
                0x6d617220: "March", // "mar "
                0x6d617920: "May", // "may "
                0x617a3430: "middleName", // "az40"
                0x69736d6e: "miniaturizable", // "ismn"
                0x706d6e64: "miniaturized", // "pmnd"
                0x617a3334: "modificationDate", // "az34"
                0x696d6f64: "modified", // "imod"
                0x6d6f6e20: "Monday", // "mon "
                0x617a3930: "MSN", // "az90"
                0x617a3234: "MSNHandle", // "az24"
                0x617a3534: "myCard", // "az54"
                0x706e616d: "name", // "pnam"
                0x617a3433: "nickname", // "az43"
                0x6e6f2020: "no", // "no  "
                0x617a3337: "note", // "az37"
                0x6e6f7620: "November", // "nov "
                0x6e756c6c: "null", // "null"
                0x6e756d65: "numericStrings", // "nume"
                0x6f637420: "October", // "oct "
                0x617a3338: "organization", // "az38"
                0x6c776c61: "pagesAcross", // "lwla"
                0x6c776c64: "pagesDown", // "lwld"
                0x617a6634: "person", // "azf4"
                0x617a3230: "phone", // "az20"
                0x617a6639: "phoneticFirstName", // "azf9"
                0x617a3130: "phoneticLastName", // "az10"
                0x617a3536: "phoneticMiddleName", // "az56"
                0x50494354: "PICTPicture", // "PICT"
                0x74706d6d: "pixelMapRecord", // "tpmm"
                0x51447074: "point", // "QDpt"
                0x70736574: "printSettings", // "pset"
                0x70736e20: "processSerialNumber", // "psn "
                0x70414c4c: "properties", // "pALL"
                0x70726f70: "property_", // "prop"
                0x70756e63: "punctuation", // "punc"
                0x617a3931: "QQ", // "az91"
                0x646f7562: "real", // "doub"
                0x7265636f: "record", // "reco"
                0x6f626a20: "reference", // "obj "
                0x617a3533: "relatedName", // "az53"
                0x6c777174: "requestedPrintTime", // "lwqt"
                0x7072737a: "resizable", // "prsz"
                0x74723136: "RGB16Color", // "tr16"
                0x74723936: "RGB96Color", // "tr96"
                0x63524742: "RGBColor", // "cRGB"
                0x74726f74: "rotation", // "trot"
                0x73617420: "Saturday", // "sat "
                0x73637074: "script", // "scpt"
                0x73656c45: "selected", // "selE"
                0x617a3438: "selection", // "az48"
                0x73657020: "September", // "sep "
                0x617a3831: "serviceName", // "az81"
                0x617a3832: "serviceType", // "az82"
                0x73686f72: "shortInteger", // "shor"
                0x617a3932: "Skype", // "az92"
                0x73696e67: "smallReal", // "sing"
                0x73703031: "socialProfile", // "sp01"
                0x6c777374: "standard", // "lwst"
                0x6c776670: "startingPage", // "lwfp"
                0x617a3330: "state", // "az30"
                0x617a3238: "street", // "az28"
                0x54455854: "string", // "TEXT"
                0x7374796c: "styledClipboardText", // "styl"
                0x53545854: "styledText", // "STXT"
                0x617a3431: "suffix", // "az41"
                0x73756e20: "Sunday", // "sun "
                0x74727072: "targetPrinter", // "trpr"
                0x74737479: "textStyleInfo", // "tsty"
                0x74687520: "Thursday", // "thu "
                0x54494646: "TIFFPicture", // "TIFF"
                0x617a3339: "title", // "az39"
                0x74756520: "Tuesday", // "tue "
                0x74797065: "typeClass", // "type"
                0x75747874: "UnicodeText", // "utxt"
                0x617a6632: "unsaved", // "azf2"
                0x75636f6d: "unsignedDoubleInteger", // "ucom"
                0x6d61676e: "unsignedInteger", // "magn"
                0x75736872: "unsignedShortInteger", // "ushr"
                0x617a3730: "url", // "az70"
                0x73707572: "url", // "spur"
                0x73706964: "userIdentifier", // "spid"
                0x617a3833: "userName", // "az83"
                0x75743136: "UTF16Text", // "ut16"
                0x75746638: "UTF8Text", // "utf8"
                0x617a3137: "value", // "az17"
                0x617a3439: "vcard", // "az49"
                0x76657273: "version", // "vers"
                0x70766973: "visible", // "pvis"
                0x77656420: "Wednesday", // "wed "
                0x77686974: "whitespace", // "whit"
                0x6377696e: "window", // "cwin"
                0x70736374: "writingCode", // "psct"
                0x617a3933: "Yahoo", // "az93"
                0x617a3235: "YahooHandle", // "az25"
                0x79657320: "yes", // "yes "
                0x617a3331: "zip", // "az31"
                0x69737a6d: "zoomable", // "iszm"
                0x707a756d: "zoomed", // "pzum"
        ],
        propertyNames: [
                0x617a3131: "birthDate", // "az11"
                0x70626e64: "bounds", // "pbnd"
                0x617a3239: "city", // "az29"
                0x70636c73: "class_", // "pcls"
                0x68636c62: "closeable", // "hclb"
                0x6c77636c: "collating", // "lwcl"
                0x617a3531: "company", // "az51"
                0x6c776370: "copies", // "lwcp"
                0x617a3332: "country", // "az32"
                0x617a3333: "countryCode", // "az33"
                0x617a3335: "creationDate", // "az35"
                0x617a3633: "defaultCountryCode", // "az63"
                0x617a3535: "department", // "az55"
                0x646f6375: "document", // "docu"
                0x6c776c70: "endingPage", // "lwlp"
                0x6c776568: "errorHandling", // "lweh"
                0x6661786e: "faxNumber", // "faxn"
                0x66696c65: "file", // "file"
                0x617a6637: "firstName", // "azf7"
                0x617a3635: "formattedAddress", // "az65"
                0x70697366: "frontmost", // "pisf"
                0x617a3133: "homePage", // "az13"
                0x49442020: "id", // "ID  "
                0x617a3530: "image", // "az50"
                0x70696478: "index", // "pidx"
                0x617a3132: "jobTitle", // "az12"
                0x617a3138: "label", // "az18"
                0x617a6638: "lastName", // "azf8"
                0x617a3432: "maidenName", // "az42"
                0x617a3430: "middleName", // "az40"
                0x69736d6e: "miniaturizable", // "ismn"
                0x706d6e64: "miniaturized", // "pmnd"
                0x617a3334: "modificationDate", // "az34"
                0x696d6f64: "modified", // "imod"
                0x617a3534: "myCard", // "az54"
                0x706e616d: "name", // "pnam"
                0x617a3433: "nickname", // "az43"
                0x617a3337: "note", // "az37"
                0x617a3338: "organization", // "az38"
                0x6c776c61: "pagesAcross", // "lwla"
                0x6c776c64: "pagesDown", // "lwld"
                0x617a6639: "phoneticFirstName", // "azf9"
                0x617a3130: "phoneticLastName", // "az10"
                0x617a3536: "phoneticMiddleName", // "az56"
                0x70414c4c: "properties", // "pALL"
                0x6c777174: "requestedPrintTime", // "lwqt"
                0x7072737a: "resizable", // "prsz"
                0x73656c45: "selected", // "selE"
                0x617a3438: "selection", // "az48"
                0x617a3831: "serviceName", // "az81"
                0x617a3832: "serviceType", // "az82"
                0x6c776670: "startingPage", // "lwfp"
                0x617a3330: "state", // "az30"
                0x617a3238: "street", // "az28"
                0x617a3431: "suffix", // "az41"
                0x74727072: "targetPrinter", // "trpr"
                0x617a3339: "title", // "az39"
                0x617a6632: "unsaved", // "azf2"
                0x73707572: "url", // "spur"
                0x73706964: "userIdentifier", // "spid"
                0x617a3833: "userName", // "az83"
                0x617a3137: "value", // "az17"
                0x617a3439: "vcard", // "az49"
                0x76657273: "version", // "vers"
                0x70766973: "visible", // "pvis"
                0x617a3331: "zip", // "az31"
                0x69737a6d: "zoomable", // "iszm"
                0x707a756d: "zoomed", // "pzum"
        ],
        elementsNames: [
                0x617a3237: ("address", "addresses"), // "az27"
                0x617a3232: ("AIMHandle", "AIMHandles"), // "az22"
                0x63617070: ("application", "applications"), // "capp"
                0x617a3136: ("contactInfo", "contactInfos"), // "az16"
                0x617a3532: ("customDate", "customDates"), // "az52"
                0x646f6375: ("document", "documents"), // "docu"
                0x617a3231: ("email", "emails"), // "az21"
                0x617a6636: ("entry", "entries"), // "azf6"
                0x617a6635: ("group", "groups"), // "azf5"
                0x617a3236: ("ICQHandle", "ICQHandles"), // "az26"
                0x617a3830: ("instantMessage", "instantMessages"), // "az80"
                0x636f626a: ("item", "items"), // "cobj"
                0x617a3233: ("JabberHandle", "JabberHandles"), // "az23"
                0x617a3234: ("MSNHandle", "MSNHandles"), // "az24"
                0x617a6634: ("person", "people"), // "azf4"
                0x617a3230: ("phone", "phones"), // "az20"
                0x617a3533: ("relatedName", "relatedNames"), // "az53"
                0x73703031: ("socialProfile", "socialProfiles"), // "sp01"
                0x617a3730: ("url", "urls"), // "az70"
                0x6377696e: ("window", "windows"), // "cwin"
                0x617a3235: ("YahooHandle", "YahooHandles"), // "az25"
        ])

private let _glueClasses = SwiftAutomation.GlueClasses(
                                                insertionSpecifierType: CONInsertion.self,
                                                objectSpecifierType: CONItem.self,
                                                multiObjectSpecifierType: CONItems.self,
                                                rootSpecifierType: CONRoot.self,
                                                applicationType: Contacts.self,
                                                symbolType: CONSymbol.self,
                                                formatter: _specifierFormatter)

private let _untargetedAppData = SwiftAutomation.AppData(glueClasses: _glueClasses)


/******************************************************************************/
// Symbol subclass defines static type/enum/property constants based on Contacts.app terminology

public class CONSymbol: SwiftAutomation.Symbol {

    override public var typeAliasName: String {return "CON"}

    public override class func symbol(code: OSType, type: OSType = AppleEvents.typeType, descriptor: ScalarDescriptor? = nil) -> CONSymbol {
        switch (code) {
        case 0x617a3237: return self.address // "az27"
        case 0x617a3835: return self.AIM // "az85"
        case 0x617a3232: return self.AIMHandle // "az22"
        case 0x616c6973: return self.alias // "alis"
        case 0x2a2a2a2a: return self.anything // "****"
        case 0x63617070: return self.application // "capp"
        case 0x62756e64: return self.applicationBundleID // "bund"
        case 0x7369676e: return self.applicationSignature // "sign"
        case 0x6170726c: return self.applicationURL // "aprl"
        case 0x61707220: return self.April // "apr "
        case 0x61626275: return self.archive // "abbu"
        case 0x61736b20: return self.ask // "ask "
        case 0x61756720: return self.August // "aug "
        case 0x62657374: return self.best // "best"
        case 0x617a3131: return self.birthDate // "az11"
        case 0x626d726b: return self.bookmarkData // "bmrk"
        case 0x626f6f6c: return self.boolean // "bool"
        case 0x71647274: return self.boundingRectangle // "qdrt"
        case 0x70626e64: return self.bounds // "pbnd"
        case 0x63617365: return self.case_ // "case"
        case 0x617a3239: return self.city // "az29"
        case 0x70636c73: return self.class_ // "pcls"
        case 0x68636c62: return self.closeable // "hclb"
        case 0x6c77636c: return self.collating // "lwcl"
        case 0x636c7274: return self.colorTable // "clrt"
        case 0x617a3531: return self.company // "az51"
        case 0x656e756d: return self.constant // "enum"
        case 0x617a3136: return self.contactInfo // "az16"
        case 0x6c776370: return self.copies // "lwcp"
        case 0x617a3332: return self.country // "az32"
        case 0x617a3333: return self.countryCode // "az33"
        case 0x617a3335: return self.creationDate // "az35"
        case 0x617a3532: return self.customDate // "az52"
        case 0x74646173: return self.dashStyle // "tdas"
        case 0x74647461: return self.data // "tdta"
        case 0x6c647420: return self.date // "ldt "
        case 0x64656320: return self.December // "dec "
        case 0x6465636d: return self.decimalStruct // "decm"
        case 0x617a3633: return self.defaultCountryCode // "az63"
        case 0x617a3535: return self.department // "az55"
        case 0x6c776474: return self.detailed // "lwdt"
        case 0x64696163: return self.diacriticals // "diac"
        case 0x646f6375: return self.document // "docu"
        case 0x636f6d70: return self.doubleInteger // "comp"
        case 0x617a3231: return self.email // "az21"
        case 0x656e6373: return self.encodedString // "encs"
        case 0x6c776c70: return self.endingPage // "lwlp"
        case 0x617a6636: return self.entry // "azf6"
        case 0x45505320: return self.EPSPicture // "EPS "
        case 0x6c776568: return self.errorHandling // "lweh"
        case 0x65787061: return self.expansion // "expa"
        case 0x617a3934: return self.Facebook // "az94"
        case 0x6661786e: return self.faxNumber // "faxn"
        case 0x66656220: return self.February // "feb "
        case 0x66696c65: return self.file // "file"
        case 0x66737266: return self.fileRef // "fsrf"
        case 0x6675726c: return self.fileURL // "furl"
        case 0x617a6637: return self.firstName // "azf7"
        case 0x66697864: return self.fixed // "fixd"
        case 0x66706e74: return self.fixedPoint // "fpnt"
        case 0x66726374: return self.fixedRectangle // "frct"
        case 0x617a3635: return self.formattedAddress // "az65"
        case 0x66726920: return self.Friday // "fri "
        case 0x70697366: return self.frontmost // "pisf"
        case 0x617a3836: return self.GaduGadu // "az86"
        case 0x47494666: return self.GIFPicture // "GIFf"
        case 0x617a3837: return self.GoogleTalk // "az87"
        case 0x63677478: return self.graphicText // "cgtx"
        case 0x617a6635: return self.group // "azf5"
        case 0x617a3133: return self.homePage // "az13"
        case 0x68797068: return self.hyphens // "hyph"
        case 0x617a3838: return self.ICQ // "az88"
        case 0x617a3236: return self.ICQHandle // "az26"
        case 0x49442020: return self.id // "ID  "
        case 0x617a3530: return self.image // "az50"
        case 0x70696478: return self.index // "pidx"
        case 0x617a3830: return self.instantMessage // "az80"
        case 0x6c6f6e67: return self.integer // "long"
        case 0x69747874: return self.internationalText // "itxt"
        case 0x696e746c: return self.internationalWritingCode // "intl"
        case 0x636f626a: return self.item // "cobj"
        case 0x617a3839: return self.Jabber // "az89"
        case 0x617a3233: return self.JabberHandle // "az23"
        case 0x6a616e20: return self.January // "jan "
        case 0x617a3132: return self.jobTitle // "az12"
        case 0x4a504547: return self.JPEGPicture // "JPEG"
        case 0x6a756c20: return self.July // "jul "
        case 0x6a756e20: return self.June // "jun "
        case 0x6b706964: return self.kernelProcessID // "kpid"
        case 0x617a3138: return self.label // "az18"
        case 0x6c64626c: return self.largeReal // "ldbl"
        case 0x617a6638: return self.lastName // "azf8"
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
        case 0x617a3432: return self.maidenName // "az42"
        case 0x6d617220: return self.March // "mar "
        case 0x6d617920: return self.May // "may "
        case 0x617a3430: return self.middleName // "az40"
        case 0x69736d6e: return self.miniaturizable // "ismn"
        case 0x706d6e64: return self.miniaturized // "pmnd"
        case 0x617a3334: return self.modificationDate // "az34"
        case 0x696d6f64: return self.modified // "imod"
        case 0x6d6f6e20: return self.Monday // "mon "
        case 0x617a3930: return self.MSN // "az90"
        case 0x617a3234: return self.MSNHandle // "az24"
        case 0x617a3534: return self.myCard // "az54"
        case 0x706e616d: return self.name // "pnam"
        case 0x617a3433: return self.nickname // "az43"
        case 0x6e6f2020: return self.no // "no  "
        case 0x617a3337: return self.note // "az37"
        case 0x6e6f7620: return self.November // "nov "
        case 0x6e756c6c: return self.null // "null"
        case 0x6e756d65: return self.numericStrings // "nume"
        case 0x6f637420: return self.October // "oct "
        case 0x617a3338: return self.organization // "az38"
        case 0x6c776c61: return self.pagesAcross // "lwla"
        case 0x6c776c64: return self.pagesDown // "lwld"
        case 0x617a6634: return self.person // "azf4"
        case 0x617a3230: return self.phone // "az20"
        case 0x617a6639: return self.phoneticFirstName // "azf9"
        case 0x617a3130: return self.phoneticLastName // "az10"
        case 0x617a3536: return self.phoneticMiddleName // "az56"
        case 0x50494354: return self.PICTPicture // "PICT"
        case 0x74706d6d: return self.pixelMapRecord // "tpmm"
        case 0x51447074: return self.point // "QDpt"
        case 0x70736574: return self.printSettings // "pset"
        case 0x70736e20: return self.processSerialNumber // "psn "
        case 0x70414c4c: return self.properties // "pALL"
        case 0x70726f70: return self.property_ // "prop"
        case 0x70756e63: return self.punctuation // "punc"
        case 0x617a3931: return self.QQ // "az91"
        case 0x646f7562: return self.real // "doub"
        case 0x7265636f: return self.record // "reco"
        case 0x6f626a20: return self.reference // "obj "
        case 0x617a3533: return self.relatedName // "az53"
        case 0x6c777174: return self.requestedPrintTime // "lwqt"
        case 0x7072737a: return self.resizable // "prsz"
        case 0x74723136: return self.RGB16Color // "tr16"
        case 0x74723936: return self.RGB96Color // "tr96"
        case 0x63524742: return self.RGBColor // "cRGB"
        case 0x74726f74: return self.rotation // "trot"
        case 0x73617420: return self.Saturday // "sat "
        case 0x73637074: return self.script // "scpt"
        case 0x73656c45: return self.selected // "selE"
        case 0x617a3438: return self.selection // "az48"
        case 0x73657020: return self.September // "sep "
        case 0x617a3831: return self.serviceName // "az81"
        case 0x617a3832: return self.serviceType // "az82"
        case 0x73686f72: return self.shortInteger // "shor"
        case 0x617a3932: return self.Skype // "az92"
        case 0x73696e67: return self.smallReal // "sing"
        case 0x73703031: return self.socialProfile // "sp01"
        case 0x6c777374: return self.standard // "lwst"
        case 0x6c776670: return self.startingPage // "lwfp"
        case 0x617a3330: return self.state // "az30"
        case 0x617a3238: return self.street // "az28"
        case 0x54455854: return self.string // "TEXT"
        case 0x7374796c: return self.styledClipboardText // "styl"
        case 0x53545854: return self.styledText // "STXT"
        case 0x617a3431: return self.suffix // "az41"
        case 0x73756e20: return self.Sunday // "sun "
        case 0x74727072: return self.targetPrinter // "trpr"
        case 0x74737479: return self.textStyleInfo // "tsty"
        case 0x74687520: return self.Thursday // "thu "
        case 0x54494646: return self.TIFFPicture // "TIFF"
        case 0x617a3339: return self.title // "az39"
        case 0x74756520: return self.Tuesday // "tue "
        case 0x74797065: return self.typeClass // "type"
        case 0x75747874: return self.UnicodeText // "utxt"
        case 0x617a6632: return self.unsaved // "azf2"
        case 0x75636f6d: return self.unsignedDoubleInteger // "ucom"
        case 0x6d61676e: return self.unsignedInteger // "magn"
        case 0x75736872: return self.unsignedShortInteger // "ushr"
        case 0x617a3730: return self.url // "az70"
        case 0x73707572: return self.url // "spur"
        case 0x73706964: return self.userIdentifier // "spid"
        case 0x617a3833: return self.userName // "az83"
        case 0x75743136: return self.UTF16Text // "ut16"
        case 0x75746638: return self.UTF8Text // "utf8"
        case 0x617a3137: return self.value // "az17"
        case 0x617a3439: return self.vcard // "az49"
        case 0x76657273: return self.version // "vers"
        case 0x70766973: return self.visible // "pvis"
        case 0x77656420: return self.Wednesday // "wed "
        case 0x77686974: return self.whitespace // "whit"
        case 0x6377696e: return self.window // "cwin"
        case 0x70736374: return self.writingCode // "psct"
        case 0x617a3933: return self.Yahoo // "az93"
        case 0x617a3235: return self.YahooHandle // "az25"
        case 0x79657320: return self.yes // "yes "
        case 0x617a3331: return self.zip // "az31"
        case 0x69737a6d: return self.zoomable // "iszm"
        case 0x707a756d: return self.zoomed // "pzum"
        default: return super.symbol(code: code, type: type, descriptor: descriptor) as! CONSymbol
        }
    }

    // Types/properties
    public static let address = CONSymbol(name: "address", code: 0x617a3237, type: AppleEvents.typeType) // "az27"
    public static let AIMHandle = CONSymbol(name: "AIMHandle", code: 0x617a3232, type: AppleEvents.typeType) // "az22"
    public static let alias = CONSymbol(name: "alias", code: 0x616c6973, type: AppleEvents.typeType) // "alis"
    public static let anything = CONSymbol(name: "anything", code: 0x2a2a2a2a, type: AppleEvents.typeType) // "****"
    public static let application = CONSymbol(name: "application", code: 0x63617070, type: AppleEvents.typeType) // "capp"
    public static let applicationBundleID = CONSymbol(name: "applicationBundleID", code: 0x62756e64, type: AppleEvents.typeType) // "bund"
    public static let applicationSignature = CONSymbol(name: "applicationSignature", code: 0x7369676e, type: AppleEvents.typeType) // "sign"
    public static let applicationURL = CONSymbol(name: "applicationURL", code: 0x6170726c, type: AppleEvents.typeType) // "aprl"
    public static let April = CONSymbol(name: "April", code: 0x61707220, type: AppleEvents.typeType) // "apr "
    public static let August = CONSymbol(name: "August", code: 0x61756720, type: AppleEvents.typeType) // "aug "
    public static let best = CONSymbol(name: "best", code: 0x62657374, type: AppleEvents.typeType) // "best"
    public static let birthDate = CONSymbol(name: "birthDate", code: 0x617a3131, type: AppleEvents.typeType) // "az11"
    public static let bookmarkData = CONSymbol(name: "bookmarkData", code: 0x626d726b, type: AppleEvents.typeType) // "bmrk"
    public static let boolean = CONSymbol(name: "boolean", code: 0x626f6f6c, type: AppleEvents.typeType) // "bool"
    public static let boundingRectangle = CONSymbol(name: "boundingRectangle", code: 0x71647274, type: AppleEvents.typeType) // "qdrt"
    public static let bounds = CONSymbol(name: "bounds", code: 0x70626e64, type: AppleEvents.typeType) // "pbnd"
    public static let city = CONSymbol(name: "city", code: 0x617a3239, type: AppleEvents.typeType) // "az29"
    public static let class_ = CONSymbol(name: "class_", code: 0x70636c73, type: AppleEvents.typeType) // "pcls"
    public static let closeable = CONSymbol(name: "closeable", code: 0x68636c62, type: AppleEvents.typeType) // "hclb"
    public static let collating = CONSymbol(name: "collating", code: 0x6c77636c, type: AppleEvents.typeType) // "lwcl"
    public static let colorTable = CONSymbol(name: "colorTable", code: 0x636c7274, type: AppleEvents.typeType) // "clrt"
    public static let company = CONSymbol(name: "company", code: 0x617a3531, type: AppleEvents.typeType) // "az51"
    public static let constant = CONSymbol(name: "constant", code: 0x656e756d, type: AppleEvents.typeType) // "enum"
    public static let contactInfo = CONSymbol(name: "contactInfo", code: 0x617a3136, type: AppleEvents.typeType) // "az16"
    public static let copies = CONSymbol(name: "copies", code: 0x6c776370, type: AppleEvents.typeType) // "lwcp"
    public static let country = CONSymbol(name: "country", code: 0x617a3332, type: AppleEvents.typeType) // "az32"
    public static let countryCode = CONSymbol(name: "countryCode", code: 0x617a3333, type: AppleEvents.typeType) // "az33"
    public static let creationDate = CONSymbol(name: "creationDate", code: 0x617a3335, type: AppleEvents.typeType) // "az35"
    public static let customDate = CONSymbol(name: "customDate", code: 0x617a3532, type: AppleEvents.typeType) // "az52"
    public static let dashStyle = CONSymbol(name: "dashStyle", code: 0x74646173, type: AppleEvents.typeType) // "tdas"
    public static let data = CONSymbol(name: "data", code: 0x74647461, type: AppleEvents.typeType) // "tdta"
    public static let date = CONSymbol(name: "date", code: 0x6c647420, type: AppleEvents.typeType) // "ldt "
    public static let December = CONSymbol(name: "December", code: 0x64656320, type: AppleEvents.typeType) // "dec "
    public static let decimalStruct = CONSymbol(name: "decimalStruct", code: 0x6465636d, type: AppleEvents.typeType) // "decm"
    public static let defaultCountryCode = CONSymbol(name: "defaultCountryCode", code: 0x617a3633, type: AppleEvents.typeType) // "az63"
    public static let department = CONSymbol(name: "department", code: 0x617a3535, type: AppleEvents.typeType) // "az55"
    public static let document = CONSymbol(name: "document", code: 0x646f6375, type: AppleEvents.typeType) // "docu"
    public static let doubleInteger = CONSymbol(name: "doubleInteger", code: 0x636f6d70, type: AppleEvents.typeType) // "comp"
    public static let email = CONSymbol(name: "email", code: 0x617a3231, type: AppleEvents.typeType) // "az21"
    public static let encodedString = CONSymbol(name: "encodedString", code: 0x656e6373, type: AppleEvents.typeType) // "encs"
    public static let endingPage = CONSymbol(name: "endingPage", code: 0x6c776c70, type: AppleEvents.typeType) // "lwlp"
    public static let entry = CONSymbol(name: "entry", code: 0x617a6636, type: AppleEvents.typeType) // "azf6"
    public static let EPSPicture = CONSymbol(name: "EPSPicture", code: 0x45505320, type: AppleEvents.typeType) // "EPS "
    public static let errorHandling = CONSymbol(name: "errorHandling", code: 0x6c776568, type: AppleEvents.typeType) // "lweh"
    public static let faxNumber = CONSymbol(name: "faxNumber", code: 0x6661786e, type: AppleEvents.typeType) // "faxn"
    public static let February = CONSymbol(name: "February", code: 0x66656220, type: AppleEvents.typeType) // "feb "
    public static let file = CONSymbol(name: "file", code: 0x66696c65, type: AppleEvents.typeType) // "file"
    public static let fileRef = CONSymbol(name: "fileRef", code: 0x66737266, type: AppleEvents.typeType) // "fsrf"
    public static let fileURL = CONSymbol(name: "fileURL", code: 0x6675726c, type: AppleEvents.typeType) // "furl"
    public static let firstName = CONSymbol(name: "firstName", code: 0x617a6637, type: AppleEvents.typeType) // "azf7"
    public static let fixed = CONSymbol(name: "fixed", code: 0x66697864, type: AppleEvents.typeType) // "fixd"
    public static let fixedPoint = CONSymbol(name: "fixedPoint", code: 0x66706e74, type: AppleEvents.typeType) // "fpnt"
    public static let fixedRectangle = CONSymbol(name: "fixedRectangle", code: 0x66726374, type: AppleEvents.typeType) // "frct"
    public static let formattedAddress = CONSymbol(name: "formattedAddress", code: 0x617a3635, type: AppleEvents.typeType) // "az65"
    public static let Friday = CONSymbol(name: "Friday", code: 0x66726920, type: AppleEvents.typeType) // "fri "
    public static let frontmost = CONSymbol(name: "frontmost", code: 0x70697366, type: AppleEvents.typeType) // "pisf"
    public static let GIFPicture = CONSymbol(name: "GIFPicture", code: 0x47494666, type: AppleEvents.typeType) // "GIFf"
    public static let graphicText = CONSymbol(name: "graphicText", code: 0x63677478, type: AppleEvents.typeType) // "cgtx"
    public static let group = CONSymbol(name: "group", code: 0x617a6635, type: AppleEvents.typeType) // "azf5"
    public static let homePage = CONSymbol(name: "homePage", code: 0x617a3133, type: AppleEvents.typeType) // "az13"
    public static let ICQHandle = CONSymbol(name: "ICQHandle", code: 0x617a3236, type: AppleEvents.typeType) // "az26"
    public static let id = CONSymbol(name: "id", code: 0x49442020, type: AppleEvents.typeType) // "ID  "
    public static let image = CONSymbol(name: "image", code: 0x617a3530, type: AppleEvents.typeType) // "az50"
    public static let index = CONSymbol(name: "index", code: 0x70696478, type: AppleEvents.typeType) // "pidx"
    public static let instantMessage = CONSymbol(name: "instantMessage", code: 0x617a3830, type: AppleEvents.typeType) // "az80"
    public static let integer = CONSymbol(name: "integer", code: 0x6c6f6e67, type: AppleEvents.typeType) // "long"
    public static let internationalText = CONSymbol(name: "internationalText", code: 0x69747874, type: AppleEvents.typeType) // "itxt"
    public static let internationalWritingCode = CONSymbol(name: "internationalWritingCode", code: 0x696e746c, type: AppleEvents.typeType) // "intl"
    public static let item = CONSymbol(name: "item", code: 0x636f626a, type: AppleEvents.typeType) // "cobj"
    public static let JabberHandle = CONSymbol(name: "JabberHandle", code: 0x617a3233, type: AppleEvents.typeType) // "az23"
    public static let January = CONSymbol(name: "January", code: 0x6a616e20, type: AppleEvents.typeType) // "jan "
    public static let jobTitle = CONSymbol(name: "jobTitle", code: 0x617a3132, type: AppleEvents.typeType) // "az12"
    public static let JPEGPicture = CONSymbol(name: "JPEGPicture", code: 0x4a504547, type: AppleEvents.typeType) // "JPEG"
    public static let July = CONSymbol(name: "July", code: 0x6a756c20, type: AppleEvents.typeType) // "jul "
    public static let June = CONSymbol(name: "June", code: 0x6a756e20, type: AppleEvents.typeType) // "jun "
    public static let kernelProcessID = CONSymbol(name: "kernelProcessID", code: 0x6b706964, type: AppleEvents.typeType) // "kpid"
    public static let label = CONSymbol(name: "label", code: 0x617a3138, type: AppleEvents.typeType) // "az18"
    public static let largeReal = CONSymbol(name: "largeReal", code: 0x6c64626c, type: AppleEvents.typeType) // "ldbl"
    public static let lastName = CONSymbol(name: "lastName", code: 0x617a6638, type: AppleEvents.typeType) // "azf8"
    public static let list = CONSymbol(name: "list", code: 0x6c697374, type: AppleEvents.typeType) // "list"
    public static let locationReference = CONSymbol(name: "locationReference", code: 0x696e736c, type: AppleEvents.typeType) // "insl"
    public static let longFixed = CONSymbol(name: "longFixed", code: 0x6c667864, type: AppleEvents.typeType) // "lfxd"
    public static let longFixedPoint = CONSymbol(name: "longFixedPoint", code: 0x6c667074, type: AppleEvents.typeType) // "lfpt"
    public static let longFixedRectangle = CONSymbol(name: "longFixedRectangle", code: 0x6c667263, type: AppleEvents.typeType) // "lfrc"
    public static let longPoint = CONSymbol(name: "longPoint", code: 0x6c706e74, type: AppleEvents.typeType) // "lpnt"
    public static let longRectangle = CONSymbol(name: "longRectangle", code: 0x6c726374, type: AppleEvents.typeType) // "lrct"
    public static let machine = CONSymbol(name: "machine", code: 0x6d616368, type: AppleEvents.typeType) // "mach"
    public static let machineLocation = CONSymbol(name: "machineLocation", code: 0x6d4c6f63, type: AppleEvents.typeType) // "mLoc"
    public static let machPort = CONSymbol(name: "machPort", code: 0x706f7274, type: AppleEvents.typeType) // "port"
    public static let maidenName = CONSymbol(name: "maidenName", code: 0x617a3432, type: AppleEvents.typeType) // "az42"
    public static let March = CONSymbol(name: "March", code: 0x6d617220, type: AppleEvents.typeType) // "mar "
    public static let May = CONSymbol(name: "May", code: 0x6d617920, type: AppleEvents.typeType) // "may "
    public static let middleName = CONSymbol(name: "middleName", code: 0x617a3430, type: AppleEvents.typeType) // "az40"
    public static let miniaturizable = CONSymbol(name: "miniaturizable", code: 0x69736d6e, type: AppleEvents.typeType) // "ismn"
    public static let miniaturized = CONSymbol(name: "miniaturized", code: 0x706d6e64, type: AppleEvents.typeType) // "pmnd"
    public static let modificationDate = CONSymbol(name: "modificationDate", code: 0x617a3334, type: AppleEvents.typeType) // "az34"
    public static let modified = CONSymbol(name: "modified", code: 0x696d6f64, type: AppleEvents.typeType) // "imod"
    public static let Monday = CONSymbol(name: "Monday", code: 0x6d6f6e20, type: AppleEvents.typeType) // "mon "
    public static let MSNHandle = CONSymbol(name: "MSNHandle", code: 0x617a3234, type: AppleEvents.typeType) // "az24"
    public static let myCard = CONSymbol(name: "myCard", code: 0x617a3534, type: AppleEvents.typeType) // "az54"
    public static let name = CONSymbol(name: "name", code: 0x706e616d, type: AppleEvents.typeType) // "pnam"
    public static let nickname = CONSymbol(name: "nickname", code: 0x617a3433, type: AppleEvents.typeType) // "az43"
    public static let note = CONSymbol(name: "note", code: 0x617a3337, type: AppleEvents.typeType) // "az37"
    public static let November = CONSymbol(name: "November", code: 0x6e6f7620, type: AppleEvents.typeType) // "nov "
    public static let null = CONSymbol(name: "null", code: 0x6e756c6c, type: AppleEvents.typeType) // "null"
    public static let October = CONSymbol(name: "October", code: 0x6f637420, type: AppleEvents.typeType) // "oct "
    public static let organization = CONSymbol(name: "organization", code: 0x617a3338, type: AppleEvents.typeType) // "az38"
    public static let pagesAcross = CONSymbol(name: "pagesAcross", code: 0x6c776c61, type: AppleEvents.typeType) // "lwla"
    public static let pagesDown = CONSymbol(name: "pagesDown", code: 0x6c776c64, type: AppleEvents.typeType) // "lwld"
    public static let person = CONSymbol(name: "person", code: 0x617a6634, type: AppleEvents.typeType) // "azf4"
    public static let phone = CONSymbol(name: "phone", code: 0x617a3230, type: AppleEvents.typeType) // "az20"
    public static let phoneticFirstName = CONSymbol(name: "phoneticFirstName", code: 0x617a6639, type: AppleEvents.typeType) // "azf9"
    public static let phoneticLastName = CONSymbol(name: "phoneticLastName", code: 0x617a3130, type: AppleEvents.typeType) // "az10"
    public static let phoneticMiddleName = CONSymbol(name: "phoneticMiddleName", code: 0x617a3536, type: AppleEvents.typeType) // "az56"
    public static let PICTPicture = CONSymbol(name: "PICTPicture", code: 0x50494354, type: AppleEvents.typeType) // "PICT"
    public static let pixelMapRecord = CONSymbol(name: "pixelMapRecord", code: 0x74706d6d, type: AppleEvents.typeType) // "tpmm"
    public static let point = CONSymbol(name: "point", code: 0x51447074, type: AppleEvents.typeType) // "QDpt"
    public static let printSettings = CONSymbol(name: "printSettings", code: 0x70736574, type: AppleEvents.typeType) // "pset"
    public static let processSerialNumber = CONSymbol(name: "processSerialNumber", code: 0x70736e20, type: AppleEvents.typeType) // "psn "
    public static let properties = CONSymbol(name: "properties", code: 0x70414c4c, type: AppleEvents.typeType) // "pALL"
    public static let property_ = CONSymbol(name: "property_", code: 0x70726f70, type: AppleEvents.typeType) // "prop"
    public static let real = CONSymbol(name: "real", code: 0x646f7562, type: AppleEvents.typeType) // "doub"
    public static let record = CONSymbol(name: "record", code: 0x7265636f, type: AppleEvents.typeType) // "reco"
    public static let reference = CONSymbol(name: "reference", code: 0x6f626a20, type: AppleEvents.typeType) // "obj "
    public static let relatedName = CONSymbol(name: "relatedName", code: 0x617a3533, type: AppleEvents.typeType) // "az53"
    public static let requestedPrintTime = CONSymbol(name: "requestedPrintTime", code: 0x6c777174, type: AppleEvents.typeType) // "lwqt"
    public static let resizable = CONSymbol(name: "resizable", code: 0x7072737a, type: AppleEvents.typeType) // "prsz"
    public static let RGB16Color = CONSymbol(name: "RGB16Color", code: 0x74723136, type: AppleEvents.typeType) // "tr16"
    public static let RGB96Color = CONSymbol(name: "RGB96Color", code: 0x74723936, type: AppleEvents.typeType) // "tr96"
    public static let RGBColor = CONSymbol(name: "RGBColor", code: 0x63524742, type: AppleEvents.typeType) // "cRGB"
    public static let rotation = CONSymbol(name: "rotation", code: 0x74726f74, type: AppleEvents.typeType) // "trot"
    public static let Saturday = CONSymbol(name: "Saturday", code: 0x73617420, type: AppleEvents.typeType) // "sat "
    public static let script = CONSymbol(name: "script", code: 0x73637074, type: AppleEvents.typeType) // "scpt"
    public static let selected = CONSymbol(name: "selected", code: 0x73656c45, type: AppleEvents.typeType) // "selE"
    public static let selection = CONSymbol(name: "selection", code: 0x617a3438, type: AppleEvents.typeType) // "az48"
    public static let September = CONSymbol(name: "September", code: 0x73657020, type: AppleEvents.typeType) // "sep "
    public static let serviceName = CONSymbol(name: "serviceName", code: 0x617a3831, type: AppleEvents.typeType) // "az81"
    public static let serviceType = CONSymbol(name: "serviceType", code: 0x617a3832, type: AppleEvents.typeType) // "az82"
    public static let shortInteger = CONSymbol(name: "shortInteger", code: 0x73686f72, type: AppleEvents.typeType) // "shor"
    public static let smallReal = CONSymbol(name: "smallReal", code: 0x73696e67, type: AppleEvents.typeType) // "sing"
    public static let socialProfile = CONSymbol(name: "socialProfile", code: 0x73703031, type: AppleEvents.typeType) // "sp01"
    public static let startingPage = CONSymbol(name: "startingPage", code: 0x6c776670, type: AppleEvents.typeType) // "lwfp"
    public static let state = CONSymbol(name: "state", code: 0x617a3330, type: AppleEvents.typeType) // "az30"
    public static let street = CONSymbol(name: "street", code: 0x617a3238, type: AppleEvents.typeType) // "az28"
    public static let string = CONSymbol(name: "string", code: 0x54455854, type: AppleEvents.typeType) // "TEXT"
    public static let styledClipboardText = CONSymbol(name: "styledClipboardText", code: 0x7374796c, type: AppleEvents.typeType) // "styl"
    public static let styledText = CONSymbol(name: "styledText", code: 0x53545854, type: AppleEvents.typeType) // "STXT"
    public static let suffix = CONSymbol(name: "suffix", code: 0x617a3431, type: AppleEvents.typeType) // "az41"
    public static let Sunday = CONSymbol(name: "Sunday", code: 0x73756e20, type: AppleEvents.typeType) // "sun "
    public static let targetPrinter = CONSymbol(name: "targetPrinter", code: 0x74727072, type: AppleEvents.typeType) // "trpr"
    public static let textStyleInfo = CONSymbol(name: "textStyleInfo", code: 0x74737479, type: AppleEvents.typeType) // "tsty"
    public static let Thursday = CONSymbol(name: "Thursday", code: 0x74687520, type: AppleEvents.typeType) // "thu "
    public static let TIFFPicture = CONSymbol(name: "TIFFPicture", code: 0x54494646, type: AppleEvents.typeType) // "TIFF"
    public static let title = CONSymbol(name: "title", code: 0x617a3339, type: AppleEvents.typeType) // "az39"
    public static let Tuesday = CONSymbol(name: "Tuesday", code: 0x74756520, type: AppleEvents.typeType) // "tue "
    public static let typeClass = CONSymbol(name: "typeClass", code: 0x74797065, type: AppleEvents.typeType) // "type"
    public static let UnicodeText = CONSymbol(name: "UnicodeText", code: 0x75747874, type: AppleEvents.typeType) // "utxt"
    public static let unsaved = CONSymbol(name: "unsaved", code: 0x617a6632, type: AppleEvents.typeType) // "azf2"
    public static let unsignedDoubleInteger = CONSymbol(name: "unsignedDoubleInteger", code: 0x75636f6d, type: AppleEvents.typeType) // "ucom"
    public static let unsignedInteger = CONSymbol(name: "unsignedInteger", code: 0x6d61676e, type: AppleEvents.typeType) // "magn"
    public static let unsignedShortInteger = CONSymbol(name: "unsignedShortInteger", code: 0x75736872, type: AppleEvents.typeType) // "ushr"
    public static let url = CONSymbol(name: "url", code: 0x617a3730, type: AppleEvents.typeType) // "az70"
    public static let userIdentifier = CONSymbol(name: "userIdentifier", code: 0x73706964, type: AppleEvents.typeType) // "spid"
    public static let userName = CONSymbol(name: "userName", code: 0x617a3833, type: AppleEvents.typeType) // "az83"
    public static let UTF16Text = CONSymbol(name: "UTF16Text", code: 0x75743136, type: AppleEvents.typeType) // "ut16"
    public static let UTF8Text = CONSymbol(name: "UTF8Text", code: 0x75746638, type: AppleEvents.typeType) // "utf8"
    public static let value = CONSymbol(name: "value", code: 0x617a3137, type: AppleEvents.typeType) // "az17"
    public static let vcard = CONSymbol(name: "vcard", code: 0x617a3439, type: AppleEvents.typeType) // "az49"
    public static let version = CONSymbol(name: "version", code: 0x76657273, type: AppleEvents.typeType) // "vers"
    public static let visible = CONSymbol(name: "visible", code: 0x70766973, type: AppleEvents.typeType) // "pvis"
    public static let Wednesday = CONSymbol(name: "Wednesday", code: 0x77656420, type: AppleEvents.typeType) // "wed "
    public static let window = CONSymbol(name: "window", code: 0x6377696e, type: AppleEvents.typeType) // "cwin"
    public static let writingCode = CONSymbol(name: "writingCode", code: 0x70736374, type: AppleEvents.typeType) // "psct"
    public static let YahooHandle = CONSymbol(name: "YahooHandle", code: 0x617a3235, type: AppleEvents.typeType) // "az25"
    public static let zip = CONSymbol(name: "zip", code: 0x617a3331, type: AppleEvents.typeType) // "az31"
    public static let zoomable = CONSymbol(name: "zoomable", code: 0x69737a6d, type: AppleEvents.typeType) // "iszm"
    public static let zoomed = CONSymbol(name: "zoomed", code: 0x707a756d, type: AppleEvents.typeType) // "pzum"

    // Enumerators
    public static let AIM = CONSymbol(name: "AIM", code: 0x617a3835, type: AppleEvents.typeEnumerated) // "az85"
    public static let archive = CONSymbol(name: "archive", code: 0x61626275, type: AppleEvents.typeEnumerated) // "abbu"
    public static let ask = CONSymbol(name: "ask", code: 0x61736b20, type: AppleEvents.typeEnumerated) // "ask "
    public static let case_ = CONSymbol(name: "case_", code: 0x63617365, type: AppleEvents.typeEnumerated) // "case"
    public static let detailed = CONSymbol(name: "detailed", code: 0x6c776474, type: AppleEvents.typeEnumerated) // "lwdt"
    public static let diacriticals = CONSymbol(name: "diacriticals", code: 0x64696163, type: AppleEvents.typeEnumerated) // "diac"
    public static let expansion = CONSymbol(name: "expansion", code: 0x65787061, type: AppleEvents.typeEnumerated) // "expa"
    public static let Facebook = CONSymbol(name: "Facebook", code: 0x617a3934, type: AppleEvents.typeEnumerated) // "az94"
    public static let GaduGadu = CONSymbol(name: "GaduGadu", code: 0x617a3836, type: AppleEvents.typeEnumerated) // "az86"
    public static let GoogleTalk = CONSymbol(name: "GoogleTalk", code: 0x617a3837, type: AppleEvents.typeEnumerated) // "az87"
    public static let hyphens = CONSymbol(name: "hyphens", code: 0x68797068, type: AppleEvents.typeEnumerated) // "hyph"
    public static let ICQ = CONSymbol(name: "ICQ", code: 0x617a3838, type: AppleEvents.typeEnumerated) // "az88"
    public static let Jabber = CONSymbol(name: "Jabber", code: 0x617a3839, type: AppleEvents.typeEnumerated) // "az89"
    public static let MSN = CONSymbol(name: "MSN", code: 0x617a3930, type: AppleEvents.typeEnumerated) // "az90"
    public static let no = CONSymbol(name: "no", code: 0x6e6f2020, type: AppleEvents.typeEnumerated) // "no  "
    public static let numericStrings = CONSymbol(name: "numericStrings", code: 0x6e756d65, type: AppleEvents.typeEnumerated) // "nume"
    public static let punctuation = CONSymbol(name: "punctuation", code: 0x70756e63, type: AppleEvents.typeEnumerated) // "punc"
    public static let QQ = CONSymbol(name: "QQ", code: 0x617a3931, type: AppleEvents.typeEnumerated) // "az91"
    public static let Skype = CONSymbol(name: "Skype", code: 0x617a3932, type: AppleEvents.typeEnumerated) // "az92"
    public static let standard = CONSymbol(name: "standard", code: 0x6c777374, type: AppleEvents.typeEnumerated) // "lwst"
    public static let whitespace = CONSymbol(name: "whitespace", code: 0x77686974, type: AppleEvents.typeEnumerated) // "whit"
    public static let Yahoo = CONSymbol(name: "Yahoo", code: 0x617a3933, type: AppleEvents.typeEnumerated) // "az93"
    public static let yes = CONSymbol(name: "yes", code: 0x79657320, type: AppleEvents.typeEnumerated) // "yes "
}

public typealias CON = CONSymbol // allows symbols to be written as (e.g.) CON.name instead of CONSymbol.name


/******************************************************************************/
// Specifier extensions; these add command methods and property/elements getters based on Contacts.app terminology

public protocol CONCommand: SwiftAutomation.SpecifierProtocol {} // provides AE dispatch methods

// Command->Any will be bound when return type can't be inferred, else Command->T

extension CONCommand {
    @discardableResult public func actionProperty(_ directParameter: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "actionProperty", event: 0x617a3030_617a3537, // "az00az57"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func actionProperty<T>(_ directParameter: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "actionProperty", event: 0x617a3030_617a3537, // "az00az57"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func actionTitle(_ directParameter: Any = SwiftAutomation.noParameter,
            with: Any = SwiftAutomation.noParameter,
            for_: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "actionTitle", event: 0x617a3030_617a3538, // "az00az58"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("with", 0x617a3632, with), // "az62"
                    ("for_", 0x617a3631, for_), // "az61"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func actionTitle<T>(_ directParameter: Any = SwiftAutomation.noParameter,
            with: Any = SwiftAutomation.noParameter,
            for_: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "actionTitle", event: 0x617a3030_617a3538, // "az00az58"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("with", 0x617a3632, with), // "az62"
                    ("for_", 0x617a3631, for_), // "az61"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
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
    @discardableResult public func add(_ directParameter: Any = SwiftAutomation.noParameter,
            to: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "add", event: 0x617a3030_617a3434, // "az00az44"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x617a3435, to), // "az45"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func add<T>(_ directParameter: Any = SwiftAutomation.noParameter,
            to: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "add", event: 0x617a3030_617a3434, // "az00az44"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x617a3435, to), // "az45"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func close(_ directParameter: Any = SwiftAutomation.noParameter,
            saving: Any = SwiftAutomation.noParameter,
            savingIn: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "close", event: 0x636f7265_636c6f73, // "coreclos"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("saving", 0x7361766f, saving), // "savo"
                    ("savingIn", 0x6b66696c, savingIn), // "kfil"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func close<T>(_ directParameter: Any = SwiftAutomation.noParameter,
            saving: Any = SwiftAutomation.noParameter,
            savingIn: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "close", event: 0x636f7265_636c6f73, // "coreclos"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("saving", 0x7361766f, saving), // "savo"
                    ("savingIn", 0x6b66696c, savingIn), // "kfil"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func count(_ directParameter: Any = SwiftAutomation.noParameter,
            each: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "count", event: 0x636f7265_636e7465, // "corecnte"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("each", 0x6b6f636c, each), // "kocl"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func count<T>(_ directParameter: Any = SwiftAutomation.noParameter,
            each: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "count", event: 0x636f7265_636e7465, // "corecnte"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("each", 0x6b6f636c, each), // "kocl"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func delete(_ directParameter: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "delete", event: 0x636f7265_64656c6f, // "coredelo"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func delete<T>(_ directParameter: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "delete", event: 0x636f7265_64656c6f, // "coredelo"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func duplicate(_ directParameter: Any = SwiftAutomation.noParameter,
            to: Any = SwiftAutomation.noParameter,
            withProperties: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "duplicate", event: 0x636f7265_636c6f6e, // "coreclon"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x696e7368, to), // "insh"
                    ("withProperties", 0x70726474, withProperties), // "prdt"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func duplicate<T>(_ directParameter: Any = SwiftAutomation.noParameter,
            to: Any = SwiftAutomation.noParameter,
            withProperties: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "duplicate", event: 0x636f7265_636c6f6e, // "coreclon"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x696e7368, to), // "insh"
                    ("withProperties", 0x70726474, withProperties), // "prdt"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func exists(_ directParameter: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "exists", event: 0x636f7265_646f6578, // "coredoex"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func exists<T>(_ directParameter: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "exists", event: 0x636f7265_646f6578, // "coredoex"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
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
    @discardableResult public func make(_ directParameter: Any = SwiftAutomation.noParameter,
            new: Any = SwiftAutomation.noParameter,
            at: Any = SwiftAutomation.noParameter,
            withData: Any = SwiftAutomation.noParameter,
            withProperties: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "make", event: 0x636f7265_6372656c, // "corecrel"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("new", 0x6b6f636c, new), // "kocl"
                    ("at", 0x696e7368, at), // "insh"
                    ("withData", 0x64617461, withData), // "data"
                    ("withProperties", 0x70726474, withProperties), // "prdt"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func make<T>(_ directParameter: Any = SwiftAutomation.noParameter,
            new: Any = SwiftAutomation.noParameter,
            at: Any = SwiftAutomation.noParameter,
            withData: Any = SwiftAutomation.noParameter,
            withProperties: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "make", event: 0x636f7265_6372656c, // "corecrel"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("new", 0x6b6f636c, new), // "kocl"
                    ("at", 0x696e7368, at), // "insh"
                    ("withData", 0x64617461, withData), // "data"
                    ("withProperties", 0x70726474, withProperties), // "prdt"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func move(_ directParameter: Any = SwiftAutomation.noParameter,
            to: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "move", event: 0x636f7265_6d6f7665, // "coremove"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x696e7368, to), // "insh"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func move<T>(_ directParameter: Any = SwiftAutomation.noParameter,
            to: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "move", event: 0x636f7265_6d6f7665, // "coremove"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x696e7368, to), // "insh"
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
    @discardableResult public func performAction(_ directParameter: Any = SwiftAutomation.noParameter,
            with: Any = SwiftAutomation.noParameter,
            for_: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "performAction", event: 0x617a3030_617a3630, // "az00az60"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("with", 0x617a3632, with), // "az62"
                    ("for_", 0x617a3631, for_), // "az61"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func performAction<T>(_ directParameter: Any = SwiftAutomation.noParameter,
            with: Any = SwiftAutomation.noParameter,
            for_: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "performAction", event: 0x617a3030_617a3630, // "az00az60"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("with", 0x617a3632, with), // "az62"
                    ("for_", 0x617a3631, for_), // "az61"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func print(_ directParameter: Any = SwiftAutomation.noParameter,
            withProperties: Any = SwiftAutomation.noParameter,
            printDialog: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "print", event: 0x61657674_70646f63, // "aevtpdoc"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("withProperties", 0x70726474, withProperties), // "prdt"
                    ("printDialog", 0x70646c67, printDialog), // "pdlg"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func print<T>(_ directParameter: Any = SwiftAutomation.noParameter,
            withProperties: Any = SwiftAutomation.noParameter,
            printDialog: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "print", event: 0x61657674_70646f63, // "aevtpdoc"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("withProperties", 0x70726474, withProperties), // "prdt"
                    ("printDialog", 0x70646c67, printDialog), // "pdlg"
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
    @discardableResult public func remove(_ directParameter: Any = SwiftAutomation.noParameter,
            from: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "remove", event: 0x617a3030_617a3436, // "az00az46"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("from", 0x617a3437, from), // "az47"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func remove<T>(_ directParameter: Any = SwiftAutomation.noParameter,
            from: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "remove", event: 0x617a3030_617a3436, // "az00az46"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("from", 0x617a3437, from), // "az47"
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
    @discardableResult public func save(_ directParameter: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "save", event: 0x636f7265_73617665, // "coresave"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func save<T>(_ directParameter: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "save", event: 0x636f7265_73617665, // "coresave"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
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
    @discardableResult public func shouldEnableAction(_ directParameter: Any = SwiftAutomation.noParameter,
            with: Any = SwiftAutomation.noParameter,
            for_: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "shouldEnableAction", event: 0x617a3030_617a3539, // "az00az59"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("with", 0x617a3632, with), // "az62"
                    ("for_", 0x617a3631, for_), // "az61"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func shouldEnableAction<T>(_ directParameter: Any = SwiftAutomation.noParameter,
            with: Any = SwiftAutomation.noParameter,
            for_: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "shouldEnableAction", event: 0x617a3030_617a3539, // "az00az59"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("with", 0x617a3632, with), // "az62"
                    ("for_", 0x617a3631, for_), // "az61"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
}


public protocol CONObject: SwiftAutomation.ObjectSpecifierExtension, CONCommand {} // provides vars and methods for constructing specifiers

extension CONObject {

    // Properties
    public var birthDate: CONItem {return self.property(0x617a3131) as! CONItem} // "az11"
    public var bounds: CONItem {return self.property(0x70626e64) as! CONItem} // "pbnd"
    public var city: CONItem {return self.property(0x617a3239) as! CONItem} // "az29"
    public var class_: CONItem {return self.property(0x70636c73) as! CONItem} // "pcls"
    public var closeable: CONItem {return self.property(0x68636c62) as! CONItem} // "hclb"
    public var collating: CONItem {return self.property(0x6c77636c) as! CONItem} // "lwcl"
    public var company: CONItem {return self.property(0x617a3531) as! CONItem} // "az51"
    public var copies: CONItem {return self.property(0x6c776370) as! CONItem} // "lwcp"
    public var country: CONItem {return self.property(0x617a3332) as! CONItem} // "az32"
    public var countryCode: CONItem {return self.property(0x617a3333) as! CONItem} // "az33"
    public var creationDate: CONItem {return self.property(0x617a3335) as! CONItem} // "az35"
    public var defaultCountryCode: CONItem {return self.property(0x617a3633) as! CONItem} // "az63"
    public var department: CONItem {return self.property(0x617a3535) as! CONItem} // "az55"
    public var document: CONItem {return self.property(0x646f6375) as! CONItem} // "docu"
    public var endingPage: CONItem {return self.property(0x6c776c70) as! CONItem} // "lwlp"
    public var errorHandling: CONItem {return self.property(0x6c776568) as! CONItem} // "lweh"
    public var faxNumber: CONItem {return self.property(0x6661786e) as! CONItem} // "faxn"
    public var file: CONItem {return self.property(0x66696c65) as! CONItem} // "file"
    public var firstName: CONItem {return self.property(0x617a6637) as! CONItem} // "azf7"
    public var formattedAddress: CONItem {return self.property(0x617a3635) as! CONItem} // "az65"
    public var frontmost: CONItem {return self.property(0x70697366) as! CONItem} // "pisf"
    public var homePage: CONItem {return self.property(0x617a3133) as! CONItem} // "az13"
    public var id: CONItem {return self.property(0x49442020) as! CONItem} // "ID  "
    public var image: CONItem {return self.property(0x617a3530) as! CONItem} // "az50"
    public var index: CONItem {return self.property(0x70696478) as! CONItem} // "pidx"
    public var jobTitle: CONItem {return self.property(0x617a3132) as! CONItem} // "az12"
    public var label: CONItem {return self.property(0x617a3138) as! CONItem} // "az18"
    public var lastName: CONItem {return self.property(0x617a6638) as! CONItem} // "azf8"
    public var maidenName: CONItem {return self.property(0x617a3432) as! CONItem} // "az42"
    public var middleName: CONItem {return self.property(0x617a3430) as! CONItem} // "az40"
    public var miniaturizable: CONItem {return self.property(0x69736d6e) as! CONItem} // "ismn"
    public var miniaturized: CONItem {return self.property(0x706d6e64) as! CONItem} // "pmnd"
    public var modificationDate: CONItem {return self.property(0x617a3334) as! CONItem} // "az34"
    public var modified: CONItem {return self.property(0x696d6f64) as! CONItem} // "imod"
    public var myCard: CONItem {return self.property(0x617a3534) as! CONItem} // "az54"
    public var name: CONItem {return self.property(0x706e616d) as! CONItem} // "pnam"
    public var nickname: CONItem {return self.property(0x617a3433) as! CONItem} // "az43"
    public var note: CONItem {return self.property(0x617a3337) as! CONItem} // "az37"
    public var organization: CONItem {return self.property(0x617a3338) as! CONItem} // "az38"
    public var pagesAcross: CONItem {return self.property(0x6c776c61) as! CONItem} // "lwla"
    public var pagesDown: CONItem {return self.property(0x6c776c64) as! CONItem} // "lwld"
    public var phoneticFirstName: CONItem {return self.property(0x617a6639) as! CONItem} // "azf9"
    public var phoneticLastName: CONItem {return self.property(0x617a3130) as! CONItem} // "az10"
    public var phoneticMiddleName: CONItem {return self.property(0x617a3536) as! CONItem} // "az56"
    public var properties: CONItem {return self.property(0x70414c4c) as! CONItem} // "pALL"
    public var requestedPrintTime: CONItem {return self.property(0x6c777174) as! CONItem} // "lwqt"
    public var resizable: CONItem {return self.property(0x7072737a) as! CONItem} // "prsz"
    public var selected: CONItem {return self.property(0x73656c45) as! CONItem} // "selE"
    public var selection: CONItem {return self.property(0x617a3438) as! CONItem} // "az48"
    public var serviceName: CONItem {return self.property(0x617a3831) as! CONItem} // "az81"
    public var serviceType: CONItem {return self.property(0x617a3832) as! CONItem} // "az82"
    public var startingPage: CONItem {return self.property(0x6c776670) as! CONItem} // "lwfp"
    public var state: CONItem {return self.property(0x617a3330) as! CONItem} // "az30"
    public var street: CONItem {return self.property(0x617a3238) as! CONItem} // "az28"
    public var suffix: CONItem {return self.property(0x617a3431) as! CONItem} // "az41"
    public var targetPrinter: CONItem {return self.property(0x74727072) as! CONItem} // "trpr"
    public var title: CONItem {return self.property(0x617a3339) as! CONItem} // "az39"
    public var unsaved: CONItem {return self.property(0x617a6632) as! CONItem} // "azf2"
    public var url: CONItem {return self.property(0x73707572) as! CONItem} // "spur"
    public var userIdentifier: CONItem {return self.property(0x73706964) as! CONItem} // "spid"
    public var userName: CONItem {return self.property(0x617a3833) as! CONItem} // "az83"
    public var value: CONItem {return self.property(0x617a3137) as! CONItem} // "az17"
    public var vcard: CONItem {return self.property(0x617a3439) as! CONItem} // "az49"
    public var version: CONItem {return self.property(0x76657273) as! CONItem} // "vers"
    public var visible: CONItem {return self.property(0x70766973) as! CONItem} // "pvis"
    public var zip: CONItem {return self.property(0x617a3331) as! CONItem} // "az31"
    public var zoomable: CONItem {return self.property(0x69737a6d) as! CONItem} // "iszm"
    public var zoomed: CONItem {return self.property(0x707a756d) as! CONItem} // "pzum"

    // Elements
    public var addresses: CONItems {return self.elements(0x617a3237) as! CONItems} // "az27"
    public var AIMHandles: CONItems {return self.elements(0x617a3232) as! CONItems} // "az22"
    public var applications: CONItems {return self.elements(0x63617070) as! CONItems} // "capp"
    public var contactInfos: CONItems {return self.elements(0x617a3136) as! CONItems} // "az16"
    public var customDates: CONItems {return self.elements(0x617a3532) as! CONItems} // "az52"
    public var documents: CONItems {return self.elements(0x646f6375) as! CONItems} // "docu"
    public var emails: CONItems {return self.elements(0x617a3231) as! CONItems} // "az21"
    public var entries: CONItems {return self.elements(0x617a6636) as! CONItems} // "azf6"
    public var groups: CONItems {return self.elements(0x617a6635) as! CONItems} // "azf5"
    public var ICQHandles: CONItems {return self.elements(0x617a3236) as! CONItems} // "az26"
    public var instantMessages: CONItems {return self.elements(0x617a3830) as! CONItems} // "az80"
    public var items: CONItems {return self.elements(0x636f626a) as! CONItems} // "cobj"
    public var JabberHandles: CONItems {return self.elements(0x617a3233) as! CONItems} // "az23"
    public var MSNHandles: CONItems {return self.elements(0x617a3234) as! CONItems} // "az24"
    public var people: CONItems {return self.elements(0x617a6634) as! CONItems} // "azf4"
    public var phones: CONItems {return self.elements(0x617a3230) as! CONItems} // "az20"
    public var relatedNames: CONItems {return self.elements(0x617a3533) as! CONItems} // "az53"
    public var socialProfiles: CONItems {return self.elements(0x73703031) as! CONItems} // "sp01"
    public var urls: CONItems {return self.elements(0x617a3730) as! CONItems} // "az70"
    public var windows: CONItems {return self.elements(0x6377696e) as! CONItems} // "cwin"
    public var YahooHandles: CONItems {return self.elements(0x617a3235) as! CONItems} // "az25"
}


/******************************************************************************/
// Specifier subclasses add app-specific extensions

// beginning/end/before/after
public class CONInsertion: SwiftAutomation.InsertionSpecifier, CONCommand {}


// property/by-index/by-name/by-id/previous/next/first/middle/last/any
public class CONItem: SwiftAutomation.ObjectSpecifier, CONObject {
    public typealias InsertionSpecifierType = CONInsertion
    public typealias ObjectSpecifierType = CONItem
    public typealias MultipleObjectSpecifierType = CONItems
}

// by-range/by-test/all
public class CONItems: CONItem, SwiftAutomation.MultipleObjectSpecifierExtension {}

// App/Con/Its
public class CONRoot: SwiftAutomation.RootSpecifier, CONObject, SwiftAutomation.RootSpecifierExtension {
    public typealias InsertionSpecifierType = CONInsertion
    public typealias ObjectSpecifierType = CONItem
    public typealias MultipleObjectSpecifierType = CONItems
    public override class var untargetedAppData: SwiftAutomation.AppData { return _untargetedAppData }
}

// Application
public class Contacts: CONRoot, SwiftAutomation.Application {
    public convenience init(launchOptions: SwiftAutomation.LaunchOptions = SwiftAutomation.defaultLaunchOptions, relaunchMode: SwiftAutomation.RelaunchMode = SwiftAutomation.defaultRelaunchMode) {
        self.init(rootObject: SwiftAutomation.appRootDesc, appData: Swift.type(of:self).untargetedAppData.targetedCopy(
                  .bundleIdentifier("com.apple.AddressBook", true), launchOptions: launchOptions, relaunchMode: relaunchMode))
    }
}

// App/Con/Its root objects used to construct untargeted specifiers; these can be used to construct specifiers for use in commands, though cannot send commands themselves

public let CONApp = _untargetedAppData.app as! CONRoot
public let CONCon = _untargetedAppData.con as! CONRoot
public let CONIts = _untargetedAppData.its as! CONRoot


/******************************************************************************/
// Static types

public typealias CONRecord = [CONSymbol:Any] // default Swift type for AERecordDescs






