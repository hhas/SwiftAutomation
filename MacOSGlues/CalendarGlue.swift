//
//  CalendarGlue.swift
//  Calendar.app 11.0
//  SwiftAutomation.framework 0.1.0
//  `aeglue -S 'Calendar.app'`
//


import Foundation
import SwiftAutomation


/******************************************************************************/
// Create an untargeted AppData instance for use in App, Con, Its roots,
// and in Application initializers to create targeted AppData instances.

private let _specifierFormatter = SwiftAutomation.SpecifierFormatter(applicationClassName: "Calendar",
                                                     classNamePrefix: "CAL",
                                                     typeNames: [
                                                                     0x45366170: "accepted", // "E6ap"
                                                                     0x616c6973: "alias", // "alis"
                                                                     0x77726164: "alldayEvent", // "wrad"
                                                                     0x77727033: "allowCancel", // "wrp3"
                                                                     0x2a2a2a2a: "anything", // "****"
                                                                     0x63617070: "application", // "capp"
                                                                     0x62756e64: "applicationBundleID", // "bund"
                                                                     0x7369676e: "applicationSignature", // "sign"
                                                                     0x6170726c: "applicationURL", // "aprl"
                                                                     0x61707220: "April", // "apr\0x20"
                                                                     0x61736b20: "ask", // "ask\0x20"
                                                                     0x77726561: "attendee", // "wrea"
                                                                     0x61756720: "August", // "aug\0x20"
                                                                     0x62657374: "best", // "best"
                                                                     0x626d726b: "bookmarkData", // "bmrk"
                                                                     0x626f6f6c: "boolean", // "bool"
                                                                     0x71647274: "boundingRectangle", // "qdrt"
                                                                     0x70626e64: "bounds", // "pbnd"
                                                                     0x77726573: "calendar", // "wres"
                                                                     0x45346361: "cancelled", // "E4ca"
                                                                     0x63617365: "case_", // "case"
                                                                     0x70636c73: "class_", // "pcls"
                                                                     0x68636c62: "closeable", // "hclb"
                                                                     0x6c77636c: "collating", // "lwcl"
                                                                     0x636f6c72: "color", // "colr"
                                                                     0x636c7274: "colorTable", // "clrt"
                                                                     0x4534636e: "confirmed", // "E4cn"
                                                                     0x656e756d: "constant", // "enum"
                                                                     0x6c776370: "copies", // "lwcp"
                                                                     0x74646173: "dashStyle", // "tdas"
                                                                     0x74647461: "data", // "tdta"
                                                                     0x6c647420: "date", // "ldt\0x20"
                                                                     0x45356461: "dayView", // "E5da"
                                                                     0x64656320: "December", // "dec\0x20"
                                                                     0x6465636d: "decimalStruct", // "decm"
                                                                     0x45366470: "declined", // "E6dp"
                                                                     0x77723132: "description_", // "wr12"
                                                                     0x6c776474: "detailed", // "lwdt"
                                                                     0x64696163: "diacriticals", // "diac"
                                                                     0x77616c31: "displayAlarm", // "wal1"
                                                                     0x77726131: "displayName", // "wra1"
                                                                     0x646f6375: "document", // "docu"
                                                                     0x636f6d70: "doubleInteger", // "comp"
                                                                     0x77726132: "email", // "wra2"
                                                                     0x656e6373: "encodedString", // "encs"
                                                                     0x77723573: "endDate", // "wr5s"
                                                                     0x6c776c70: "endingPage", // "lwlp"
                                                                     0x45505320: "EPSPicture", // "EPS\0x20"
                                                                     0x6c776568: "errorHandling", // "lweh"
                                                                     0x77726576: "event", // "wrev"
                                                                     0x77723273: "excludedDates", // "wr2s"
                                                                     0x65787061: "expansion", // "expa"
                                                                     0x65787465: "extendedReal", // "exte"
                                                                     0x6661786e: "faxNumber", // "faxn"
                                                                     0x66656220: "February", // "feb\0x20"
                                                                     0x66696c65: "file", // "file"
                                                                     0x77616c70: "filepath", // "walp"
                                                                     0x66737266: "fileRef", // "fsrf"
                                                                     0x66737320: "fileSpecification", // "fss\0x20"
                                                                     0x6675726c: "fileURL", // "furl"
                                                                     0x66697864: "fixed", // "fixd"
                                                                     0x66706e74: "fixedPoint", // "fpnt"
                                                                     0x66726374: "fixedRectangle", // "frct"
                                                                     0x66726920: "Friday", // "fri\0x20"
                                                                     0x70697366: "frontmost", // "pisf"
                                                                     0x47494666: "GIFPicture", // "GIFf"
                                                                     0x63677478: "graphicText", // "cgtx"
                                                                     0x74647031: "highPriority", // "tdp1"
                                                                     0x68797068: "hyphens", // "hyph"
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
                                                                     0x77723134: "location", // "wr14"
                                                                     0x696e736c: "locationReference", // "insl"
                                                                     0x6c667864: "longFixed", // "lfxd"
                                                                     0x6c667074: "longFixedPoint", // "lfpt"
                                                                     0x6c667263: "longFixedRectangle", // "lfrc"
                                                                     0x6c706e74: "longPoint", // "lpnt"
                                                                     0x6c726374: "longRectangle", // "lrct"
                                                                     0x74647039: "lowPriority", // "tdp9"
                                                                     0x6d616368: "machine", // "mach"
                                                                     0x6d4c6f63: "machineLocation", // "mLoc"
                                                                     0x706f7274: "machPort", // "port"
                                                                     0x77616c32: "mailAlarm", // "wal2"
                                                                     0x6d617220: "March", // "mar\0x20"
                                                                     0x6d617920: "May", // "may\0x20"
                                                                     0x74647035: "mediumPriority", // "tdp5"
                                                                     0x69736d6e: "miniaturizable", // "ismn"
                                                                     0x706d6e64: "miniaturized", // "pmnd"
                                                                     0x696d6f64: "modified", // "imod"
                                                                     0x6d6f6e20: "Monday", // "mon\0x20"
                                                                     0x45356d6f: "monthView", // "E5mo"
                                                                     0x706e616d: "name", // "pnam"
                                                                     0x6e6f2020: "no", // "no\0x20\0x20"
                                                                     0x45346e6f: "none", // "E4no"
                                                                     0x74647030: "noPriority", // "tdp0"
                                                                     0x6e6f7620: "November", // "nov\0x20"
                                                                     0x6e756c6c: "null", // "null"
                                                                     0x6e756d65: "numericStrings", // "nume"
                                                                     0x6f637420: "October", // "oct\0x20"
                                                                     0x77616c33: "openFileAlarm", // "wal3"
                                                                     0x6c776c61: "pagesAcross", // "lwla"
                                                                     0x6c776c64: "pagesDown", // "lwld"
                                                                     0x77726133: "participationStatus", // "wra3"
                                                                     0x50494354: "PICTPicture", // "PICT"
                                                                     0x74706d6d: "pixelMapRecord", // "tpmm"
                                                                     0x51447074: "point", // "QDpt"
                                                                     0x70736574: "printSettings", // "pset"
                                                                     0x70736e20: "processSerialNumber", // "psn\0x20"
                                                                     0x77727032: "progression", // "wrp2"
                                                                     0x70414c4c: "properties", // "pALL"
                                                                     0x70726f70: "property_", // "prop"
                                                                     0x70756e63: "punctuation", // "punc"
                                                                     0x646f7562: "real", // "doub"
                                                                     0x7265636f: "record", // "reco"
                                                                     0x77723135: "recurrence", // "wr15"
                                                                     0x6f626a20: "reference", // "obj\0x20"
                                                                     0x6c777174: "requestedPrintTime", // "lwqt"
                                                                     0x7072737a: "resizable", // "prsz"
                                                                     0x74723136: "RGB16Color", // "tr16"
                                                                     0x74723936: "RGB96Color", // "tr96"
                                                                     0x63524742: "RGBColor", // "cRGB"
                                                                     0x74726f74: "rotation", // "trot"
                                                                     0x73617420: "Saturday", // "sat\0x20"
                                                                     0x73637074: "script", // "scpt"
                                                                     0x73657020: "September", // "sep\0x20"
                                                                     0x77723133: "sequence", // "wr13"
                                                                     0x73686f72: "shortInteger", // "shor"
                                                                     0x73696e67: "smallReal", // "sing"
                                                                     0x77616c34: "soundAlarm", // "wal4"
                                                                     0x77616c66: "soundFile", // "walf"
                                                                     0x77616c73: "soundName", // "wals"
                                                                     0x77723473: "stampDate", // "wr4s"
                                                                     0x6c777374: "standard", // "lwst"
                                                                     0x77723173: "startDate", // "wr1s"
                                                                     0x6c776670: "startingPage", // "lwfp"
                                                                     0x77726534: "status", // "wre4"
                                                                     0x54455854: "string", // "TEXT"
                                                                     0x7374796c: "styledClipboardText", // "styl"
                                                                     0x53545854: "styledText", // "STXT"
                                                                     0x77723131: "summary", // "wr11"
                                                                     0x73756e20: "Sunday", // "sun\0x20"
                                                                     0x74727072: "targetPrinter", // "trpr"
                                                                     0x45367470: "tentative", // "E6tp"
                                                                     0x45347465: "tentative", // "E4te"
                                                                     0x74737479: "textStyleInfo", // "tsty"
                                                                     0x74687520: "Thursday", // "thu\0x20"
                                                                     0x54494646: "TIFFPicture", // "TIFF"
                                                                     0x77723032: "title", // "wr02"
                                                                     0x77616c65: "triggerDate", // "wale"
                                                                     0x77616c64: "triggerInterval", // "wald"
                                                                     0x74756520: "Tuesday", // "tue\0x20"
                                                                     0x74797065: "typeClass", // "type"
                                                                     0x49442020: "uid", // "ID\0x20\0x20"
                                                                     0x75747874: "UnicodeText", // "utxt"
                                                                     0x45366e61: "unknown", // "E6na"
                                                                     0x75636f6d: "unsignedDoubleInteger", // "ucom"
                                                                     0x6d61676e: "unsignedInteger", // "magn"
                                                                     0x75736872: "unsignedShortInteger", // "ushr"
                                                                     0x77723136: "url", // "wr16"
                                                                     0x75743136: "UTF16Text", // "ut16"
                                                                     0x75746638: "UTF8Text", // "utf8"
                                                                     0x76657273: "version", // "vers"
                                                                     0x70766973: "visible", // "pvis"
                                                                     0x77656420: "Wednesday", // "wed\0x20"
                                                                     0x45357765: "weekView", // "E5we"
                                                                     0x77686974: "whitespace", // "whit"
                                                                     0x6377696e: "window", // "cwin"
                                                                     0x77723035: "writable", // "wr05"
                                                                     0x70736374: "writingCode", // "psct"
                                                                     0x79657320: "yes", // "yes\0x20"
                                                                     0x69737a6d: "zoomable", // "iszm"
                                                                     0x707a756d: "zoomed", // "pzum"
                                                     ],
                                                     propertyNames: [
                                                                     0x77726164: "alldayEvent", // "wrad"
                                                                     0x77727033: "allowCancel", // "wrp3"
                                                                     0x70626e64: "bounds", // "pbnd"
                                                                     0x70636c73: "class_", // "pcls"
                                                                     0x68636c62: "closeable", // "hclb"
                                                                     0x6c77636c: "collating", // "lwcl"
                                                                     0x636f6c72: "color", // "colr"
                                                                     0x6c776370: "copies", // "lwcp"
                                                                     0x77723132: "description_", // "wr12"
                                                                     0x77726131: "displayName", // "wra1"
                                                                     0x646f6375: "document", // "docu"
                                                                     0x77726132: "email", // "wra2"
                                                                     0x77723573: "endDate", // "wr5s"
                                                                     0x6c776c70: "endingPage", // "lwlp"
                                                                     0x6c776568: "errorHandling", // "lweh"
                                                                     0x77723273: "excludedDates", // "wr2s"
                                                                     0x6661786e: "faxNumber", // "faxn"
                                                                     0x66696c65: "file", // "file"
                                                                     0x77616c70: "filepath", // "walp"
                                                                     0x70697366: "frontmost", // "pisf"
                                                                     0x70696478: "index", // "pidx"
                                                                     0x77723134: "location", // "wr14"
                                                                     0x69736d6e: "miniaturizable", // "ismn"
                                                                     0x706d6e64: "miniaturized", // "pmnd"
                                                                     0x696d6f64: "modified", // "imod"
                                                                     0x706e616d: "name", // "pnam"
                                                                     0x6c776c61: "pagesAcross", // "lwla"
                                                                     0x6c776c64: "pagesDown", // "lwld"
                                                                     0x77726133: "participationStatus", // "wra3"
                                                                     0x77727032: "progression", // "wrp2"
                                                                     0x70414c4c: "properties", // "pALL"
                                                                     0x77723135: "recurrence", // "wr15"
                                                                     0x6c777174: "requestedPrintTime", // "lwqt"
                                                                     0x7072737a: "resizable", // "prsz"
                                                                     0x77723133: "sequence", // "wr13"
                                                                     0x77616c66: "soundFile", // "walf"
                                                                     0x77616c73: "soundName", // "wals"
                                                                     0x77723473: "stampDate", // "wr4s"
                                                                     0x77723173: "startDate", // "wr1s"
                                                                     0x6c776670: "startingPage", // "lwfp"
                                                                     0x77726534: "status", // "wre4"
                                                                     0x77723131: "summary", // "wr11"
                                                                     0x74727072: "targetPrinter", // "trpr"
                                                                     0x77723032: "title", // "wr02"
                                                                     0x77616c65: "triggerDate", // "wale"
                                                                     0x77616c64: "triggerInterval", // "wald"
                                                                     0x49442020: "uid", // "ID\0x20\0x20"
                                                                     0x77723136: "url", // "wr16"
                                                                     0x76657273: "version", // "vers"
                                                                     0x70766973: "visible", // "pvis"
                                                                     0x77723035: "writable", // "wr05"
                                                                     0x69737a6d: "zoomable", // "iszm"
                                                                     0x707a756d: "zoomed", // "pzum"
                                                     ],
                                                     elementsNames: [
                                                                     0x63617070: ("application", "applications"), // "capp"
                                                                     0x77726561: ("attendee", "attendees"), // "wrea"
                                                                     0x77726573: ("calendar", "calendars"), // "wres"
                                                                     0x77616c31: ("display alarm", "displayAlarms"), // "wal1"
                                                                     0x646f6375: ("document", "documents"), // "docu"
                                                                     0x77726576: ("event", "events"), // "wrev"
                                                                     0x636f626a: ("item", "items"), // "cobj"
                                                                     0x77616c32: ("mail alarm", "mailAlarms"), // "wal2"
                                                                     0x77616c33: ("open file alarm", "openFileAlarms"), // "wal3"
                                                                     0x77616c34: ("sound alarm", "soundAlarms"), // "wal4"
                                                                     0x6377696e: ("window", "windows"), // "cwin"
                                                     ])

private let _glueClasses = SwiftAutomation.GlueClasses(insertionSpecifierType: CALInsertion.self,
                                       objectSpecifierType: CALItem.self,
                                       multiObjectSpecifierType: CALItems.self,
                                       rootSpecifierType: CALRoot.self,
                                       applicationType: Calendar.self,
                                       symbolType: CALSymbol.self,
                                       formatter: _specifierFormatter)

private let _untargetedAppData = SwiftAutomation.AppData(glueClasses: _glueClasses)


/******************************************************************************/
// Symbol subclass defines static type/enum/property constants based on Calendar.app terminology

public class CALSymbol: SwiftAutomation.Symbol {

    override public var typeAliasName: String {return "CAL"}

    public override class func symbol(code: OSType, type: OSType = typeType, descriptor: NSAppleEventDescriptor? = nil) -> CALSymbol {
        switch (code) {
        case 0x45366170: return self.accepted // "E6ap"
        case 0x616c6973: return self.alias // "alis"
        case 0x77726164: return self.alldayEvent // "wrad"
        case 0x77727033: return self.allowCancel // "wrp3"
        case 0x2a2a2a2a: return self.anything // "****"
        case 0x63617070: return self.application // "capp"
        case 0x62756e64: return self.applicationBundleID // "bund"
        case 0x7369676e: return self.applicationSignature // "sign"
        case 0x6170726c: return self.applicationURL // "aprl"
        case 0x61707220: return self.April // "apr\0x20"
        case 0x61736b20: return self.ask // "ask\0x20"
        case 0x77726561: return self.attendee // "wrea"
        case 0x61756720: return self.August // "aug\0x20"
        case 0x62657374: return self.best // "best"
        case 0x626d726b: return self.bookmarkData // "bmrk"
        case 0x626f6f6c: return self.boolean // "bool"
        case 0x71647274: return self.boundingRectangle // "qdrt"
        case 0x70626e64: return self.bounds // "pbnd"
        case 0x77726573: return self.calendar // "wres"
        case 0x45346361: return self.cancelled // "E4ca"
        case 0x63617365: return self.case_ // "case"
        case 0x70636c73: return self.class_ // "pcls"
        case 0x68636c62: return self.closeable // "hclb"
        case 0x6c77636c: return self.collating // "lwcl"
        case 0x636f6c72: return self.color // "colr"
        case 0x636c7274: return self.colorTable // "clrt"
        case 0x4534636e: return self.confirmed // "E4cn"
        case 0x656e756d: return self.constant // "enum"
        case 0x6c776370: return self.copies // "lwcp"
        case 0x74646173: return self.dashStyle // "tdas"
        case 0x74647461: return self.data // "tdta"
        case 0x6c647420: return self.date // "ldt\0x20"
        case 0x45356461: return self.dayView // "E5da"
        case 0x64656320: return self.December // "dec\0x20"
        case 0x6465636d: return self.decimalStruct // "decm"
        case 0x45366470: return self.declined // "E6dp"
        case 0x77723132: return self.description_ // "wr12"
        case 0x6c776474: return self.detailed // "lwdt"
        case 0x64696163: return self.diacriticals // "diac"
        case 0x77616c31: return self.displayAlarm // "wal1"
        case 0x77726131: return self.displayName // "wra1"
        case 0x646f6375: return self.document // "docu"
        case 0x636f6d70: return self.doubleInteger // "comp"
        case 0x77726132: return self.email // "wra2"
        case 0x656e6373: return self.encodedString // "encs"
        case 0x77723573: return self.endDate // "wr5s"
        case 0x6c776c70: return self.endingPage // "lwlp"
        case 0x45505320: return self.EPSPicture // "EPS\0x20"
        case 0x6c776568: return self.errorHandling // "lweh"
        case 0x77726576: return self.event // "wrev"
        case 0x77723273: return self.excludedDates // "wr2s"
        case 0x65787061: return self.expansion // "expa"
        case 0x65787465: return self.extendedReal // "exte"
        case 0x6661786e: return self.faxNumber // "faxn"
        case 0x66656220: return self.February // "feb\0x20"
        case 0x66696c65: return self.file // "file"
        case 0x77616c70: return self.filepath // "walp"
        case 0x66737266: return self.fileRef // "fsrf"
        case 0x66737320: return self.fileSpecification // "fss\0x20"
        case 0x6675726c: return self.fileURL // "furl"
        case 0x66697864: return self.fixed // "fixd"
        case 0x66706e74: return self.fixedPoint // "fpnt"
        case 0x66726374: return self.fixedRectangle // "frct"
        case 0x66726920: return self.Friday // "fri\0x20"
        case 0x70697366: return self.frontmost // "pisf"
        case 0x47494666: return self.GIFPicture // "GIFf"
        case 0x63677478: return self.graphicText // "cgtx"
        case 0x74647031: return self.highPriority // "tdp1"
        case 0x68797068: return self.hyphens // "hyph"
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
        case 0x77723134: return self.location // "wr14"
        case 0x696e736c: return self.locationReference // "insl"
        case 0x6c667864: return self.longFixed // "lfxd"
        case 0x6c667074: return self.longFixedPoint // "lfpt"
        case 0x6c667263: return self.longFixedRectangle // "lfrc"
        case 0x6c706e74: return self.longPoint // "lpnt"
        case 0x6c726374: return self.longRectangle // "lrct"
        case 0x74647039: return self.lowPriority // "tdp9"
        case 0x6d616368: return self.machine // "mach"
        case 0x6d4c6f63: return self.machineLocation // "mLoc"
        case 0x706f7274: return self.machPort // "port"
        case 0x77616c32: return self.mailAlarm // "wal2"
        case 0x6d617220: return self.March // "mar\0x20"
        case 0x6d617920: return self.May // "may\0x20"
        case 0x74647035: return self.mediumPriority // "tdp5"
        case 0x69736d6e: return self.miniaturizable // "ismn"
        case 0x706d6e64: return self.miniaturized // "pmnd"
        case 0x696d6f64: return self.modified // "imod"
        case 0x6d6f6e20: return self.Monday // "mon\0x20"
        case 0x45356d6f: return self.monthView // "E5mo"
        case 0x706e616d: return self.name // "pnam"
        case 0x6e6f2020: return self.no // "no\0x20\0x20"
        case 0x45346e6f: return self.none // "E4no"
        case 0x74647030: return self.noPriority // "tdp0"
        case 0x6e6f7620: return self.November // "nov\0x20"
        case 0x6e756c6c: return self.null // "null"
        case 0x6e756d65: return self.numericStrings // "nume"
        case 0x6f637420: return self.October // "oct\0x20"
        case 0x77616c33: return self.openFileAlarm // "wal3"
        case 0x6c776c61: return self.pagesAcross // "lwla"
        case 0x6c776c64: return self.pagesDown // "lwld"
        case 0x77726133: return self.participationStatus // "wra3"
        case 0x50494354: return self.PICTPicture // "PICT"
        case 0x74706d6d: return self.pixelMapRecord // "tpmm"
        case 0x51447074: return self.point // "QDpt"
        case 0x70736574: return self.printSettings // "pset"
        case 0x70736e20: return self.processSerialNumber // "psn\0x20"
        case 0x77727032: return self.progression // "wrp2"
        case 0x70414c4c: return self.properties // "pALL"
        case 0x70726f70: return self.property_ // "prop"
        case 0x70756e63: return self.punctuation // "punc"
        case 0x646f7562: return self.real // "doub"
        case 0x7265636f: return self.record // "reco"
        case 0x77723135: return self.recurrence // "wr15"
        case 0x6f626a20: return self.reference // "obj\0x20"
        case 0x6c777174: return self.requestedPrintTime // "lwqt"
        case 0x7072737a: return self.resizable // "prsz"
        case 0x74723136: return self.RGB16Color // "tr16"
        case 0x74723936: return self.RGB96Color // "tr96"
        case 0x63524742: return self.RGBColor // "cRGB"
        case 0x74726f74: return self.rotation // "trot"
        case 0x73617420: return self.Saturday // "sat\0x20"
        case 0x73637074: return self.script // "scpt"
        case 0x73657020: return self.September // "sep\0x20"
        case 0x77723133: return self.sequence // "wr13"
        case 0x73686f72: return self.shortInteger // "shor"
        case 0x73696e67: return self.smallReal // "sing"
        case 0x77616c34: return self.soundAlarm // "wal4"
        case 0x77616c66: return self.soundFile // "walf"
        case 0x77616c73: return self.soundName // "wals"
        case 0x77723473: return self.stampDate // "wr4s"
        case 0x6c777374: return self.standard // "lwst"
        case 0x77723173: return self.startDate // "wr1s"
        case 0x6c776670: return self.startingPage // "lwfp"
        case 0x77726534: return self.status // "wre4"
        case 0x54455854: return self.string // "TEXT"
        case 0x7374796c: return self.styledClipboardText // "styl"
        case 0x53545854: return self.styledText // "STXT"
        case 0x77723131: return self.summary // "wr11"
        case 0x73756e20: return self.Sunday // "sun\0x20"
        case 0x74727072: return self.targetPrinter // "trpr"
        case 0x45367470: return self.tentative // "E6tp"
        case 0x45347465: return self.tentative // "E4te"
        case 0x74737479: return self.textStyleInfo // "tsty"
        case 0x74687520: return self.Thursday // "thu\0x20"
        case 0x54494646: return self.TIFFPicture // "TIFF"
        case 0x77723032: return self.title // "wr02"
        case 0x77616c65: return self.triggerDate // "wale"
        case 0x77616c64: return self.triggerInterval // "wald"
        case 0x74756520: return self.Tuesday // "tue\0x20"
        case 0x74797065: return self.typeClass // "type"
        case 0x49442020: return self.uid // "ID\0x20\0x20"
        case 0x75747874: return self.UnicodeText // "utxt"
        case 0x45366e61: return self.unknown // "E6na"
        case 0x75636f6d: return self.unsignedDoubleInteger // "ucom"
        case 0x6d61676e: return self.unsignedInteger // "magn"
        case 0x75736872: return self.unsignedShortInteger // "ushr"
        case 0x77723136: return self.url // "wr16"
        case 0x75743136: return self.UTF16Text // "ut16"
        case 0x75746638: return self.UTF8Text // "utf8"
        case 0x76657273: return self.version // "vers"
        case 0x70766973: return self.visible // "pvis"
        case 0x77656420: return self.Wednesday // "wed\0x20"
        case 0x45357765: return self.weekView // "E5we"
        case 0x77686974: return self.whitespace // "whit"
        case 0x6377696e: return self.window // "cwin"
        case 0x77723035: return self.writable // "wr05"
        case 0x70736374: return self.writingCode // "psct"
        case 0x79657320: return self.yes // "yes\0x20"
        case 0x69737a6d: return self.zoomable // "iszm"
        case 0x707a756d: return self.zoomed // "pzum"
        default: return super.symbol(code: code, type: type, descriptor: descriptor) as! CALSymbol
        }
    }

    // Types/properties
    public static let alias = CALSymbol(name: "alias", code: 0x616c6973, type: typeType) // "alis"
    public static let alldayEvent = CALSymbol(name: "alldayEvent", code: 0x77726164, type: typeType) // "wrad"
    public static let allowCancel = CALSymbol(name: "allowCancel", code: 0x77727033, type: typeType) // "wrp3"
    public static let anything = CALSymbol(name: "anything", code: 0x2a2a2a2a, type: typeType) // "****"
    public static let application = CALSymbol(name: "application", code: 0x63617070, type: typeType) // "capp"
    public static let applicationBundleID = CALSymbol(name: "applicationBundleID", code: 0x62756e64, type: typeType) // "bund"
    public static let applicationSignature = CALSymbol(name: "applicationSignature", code: 0x7369676e, type: typeType) // "sign"
    public static let applicationURL = CALSymbol(name: "applicationURL", code: 0x6170726c, type: typeType) // "aprl"
    public static let April = CALSymbol(name: "April", code: 0x61707220, type: typeType) // "apr\0x20"
    public static let attendee = CALSymbol(name: "attendee", code: 0x77726561, type: typeType) // "wrea"
    public static let August = CALSymbol(name: "August", code: 0x61756720, type: typeType) // "aug\0x20"
    public static let best = CALSymbol(name: "best", code: 0x62657374, type: typeType) // "best"
    public static let bookmarkData = CALSymbol(name: "bookmarkData", code: 0x626d726b, type: typeType) // "bmrk"
    public static let boolean = CALSymbol(name: "boolean", code: 0x626f6f6c, type: typeType) // "bool"
    public static let boundingRectangle = CALSymbol(name: "boundingRectangle", code: 0x71647274, type: typeType) // "qdrt"
    public static let bounds = CALSymbol(name: "bounds", code: 0x70626e64, type: typeType) // "pbnd"
    public static let calendar = CALSymbol(name: "calendar", code: 0x77726573, type: typeType) // "wres"
    public static let class_ = CALSymbol(name: "class_", code: 0x70636c73, type: typeType) // "pcls"
    public static let closeable = CALSymbol(name: "closeable", code: 0x68636c62, type: typeType) // "hclb"
    public static let collating = CALSymbol(name: "collating", code: 0x6c77636c, type: typeType) // "lwcl"
    public static let color = CALSymbol(name: "color", code: 0x636f6c72, type: typeType) // "colr"
    public static let colorTable = CALSymbol(name: "colorTable", code: 0x636c7274, type: typeType) // "clrt"
    public static let constant = CALSymbol(name: "constant", code: 0x656e756d, type: typeType) // "enum"
    public static let copies = CALSymbol(name: "copies", code: 0x6c776370, type: typeType) // "lwcp"
    public static let dashStyle = CALSymbol(name: "dashStyle", code: 0x74646173, type: typeType) // "tdas"
    public static let data = CALSymbol(name: "data", code: 0x74647461, type: typeType) // "tdta"
    public static let date = CALSymbol(name: "date", code: 0x6c647420, type: typeType) // "ldt\0x20"
    public static let December = CALSymbol(name: "December", code: 0x64656320, type: typeType) // "dec\0x20"
    public static let decimalStruct = CALSymbol(name: "decimalStruct", code: 0x6465636d, type: typeType) // "decm"
    public static let description_ = CALSymbol(name: "description_", code: 0x77723132, type: typeType) // "wr12"
    public static let displayAlarm = CALSymbol(name: "displayAlarm", code: 0x77616c31, type: typeType) // "wal1"
    public static let displayName = CALSymbol(name: "displayName", code: 0x77726131, type: typeType) // "wra1"
    public static let document = CALSymbol(name: "document", code: 0x646f6375, type: typeType) // "docu"
    public static let doubleInteger = CALSymbol(name: "doubleInteger", code: 0x636f6d70, type: typeType) // "comp"
    public static let email = CALSymbol(name: "email", code: 0x77726132, type: typeType) // "wra2"
    public static let encodedString = CALSymbol(name: "encodedString", code: 0x656e6373, type: typeType) // "encs"
    public static let endDate = CALSymbol(name: "endDate", code: 0x77723573, type: typeType) // "wr5s"
    public static let endingPage = CALSymbol(name: "endingPage", code: 0x6c776c70, type: typeType) // "lwlp"
    public static let EPSPicture = CALSymbol(name: "EPSPicture", code: 0x45505320, type: typeType) // "EPS\0x20"
    public static let errorHandling = CALSymbol(name: "errorHandling", code: 0x6c776568, type: typeType) // "lweh"
    public static let event = CALSymbol(name: "event", code: 0x77726576, type: typeType) // "wrev"
    public static let excludedDates = CALSymbol(name: "excludedDates", code: 0x77723273, type: typeType) // "wr2s"
    public static let extendedReal = CALSymbol(name: "extendedReal", code: 0x65787465, type: typeType) // "exte"
    public static let faxNumber = CALSymbol(name: "faxNumber", code: 0x6661786e, type: typeType) // "faxn"
    public static let February = CALSymbol(name: "February", code: 0x66656220, type: typeType) // "feb\0x20"
    public static let file = CALSymbol(name: "file", code: 0x66696c65, type: typeType) // "file"
    public static let filepath = CALSymbol(name: "filepath", code: 0x77616c70, type: typeType) // "walp"
    public static let fileRef = CALSymbol(name: "fileRef", code: 0x66737266, type: typeType) // "fsrf"
    public static let fileSpecification = CALSymbol(name: "fileSpecification", code: 0x66737320, type: typeType) // "fss\0x20"
    public static let fileURL = CALSymbol(name: "fileURL", code: 0x6675726c, type: typeType) // "furl"
    public static let fixed = CALSymbol(name: "fixed", code: 0x66697864, type: typeType) // "fixd"
    public static let fixedPoint = CALSymbol(name: "fixedPoint", code: 0x66706e74, type: typeType) // "fpnt"
    public static let fixedRectangle = CALSymbol(name: "fixedRectangle", code: 0x66726374, type: typeType) // "frct"
    public static let Friday = CALSymbol(name: "Friday", code: 0x66726920, type: typeType) // "fri\0x20"
    public static let frontmost = CALSymbol(name: "frontmost", code: 0x70697366, type: typeType) // "pisf"
    public static let GIFPicture = CALSymbol(name: "GIFPicture", code: 0x47494666, type: typeType) // "GIFf"
    public static let graphicText = CALSymbol(name: "graphicText", code: 0x63677478, type: typeType) // "cgtx"
    public static let id = CALSymbol(name: "id", code: 0x49442020, type: typeType) // "ID\0x20\0x20"
    public static let index = CALSymbol(name: "index", code: 0x70696478, type: typeType) // "pidx"
    public static let integer = CALSymbol(name: "integer", code: 0x6c6f6e67, type: typeType) // "long"
    public static let internationalText = CALSymbol(name: "internationalText", code: 0x69747874, type: typeType) // "itxt"
    public static let internationalWritingCode = CALSymbol(name: "internationalWritingCode", code: 0x696e746c, type: typeType) // "intl"
    public static let item = CALSymbol(name: "item", code: 0x636f626a, type: typeType) // "cobj"
    public static let January = CALSymbol(name: "January", code: 0x6a616e20, type: typeType) // "jan\0x20"
    public static let JPEGPicture = CALSymbol(name: "JPEGPicture", code: 0x4a504547, type: typeType) // "JPEG"
    public static let July = CALSymbol(name: "July", code: 0x6a756c20, type: typeType) // "jul\0x20"
    public static let June = CALSymbol(name: "June", code: 0x6a756e20, type: typeType) // "jun\0x20"
    public static let kernelProcessID = CALSymbol(name: "kernelProcessID", code: 0x6b706964, type: typeType) // "kpid"
    public static let largeReal = CALSymbol(name: "largeReal", code: 0x6c64626c, type: typeType) // "ldbl"
    public static let list = CALSymbol(name: "list", code: 0x6c697374, type: typeType) // "list"
    public static let location = CALSymbol(name: "location", code: 0x77723134, type: typeType) // "wr14"
    public static let locationReference = CALSymbol(name: "locationReference", code: 0x696e736c, type: typeType) // "insl"
    public static let longFixed = CALSymbol(name: "longFixed", code: 0x6c667864, type: typeType) // "lfxd"
    public static let longFixedPoint = CALSymbol(name: "longFixedPoint", code: 0x6c667074, type: typeType) // "lfpt"
    public static let longFixedRectangle = CALSymbol(name: "longFixedRectangle", code: 0x6c667263, type: typeType) // "lfrc"
    public static let longPoint = CALSymbol(name: "longPoint", code: 0x6c706e74, type: typeType) // "lpnt"
    public static let longRectangle = CALSymbol(name: "longRectangle", code: 0x6c726374, type: typeType) // "lrct"
    public static let machine = CALSymbol(name: "machine", code: 0x6d616368, type: typeType) // "mach"
    public static let machineLocation = CALSymbol(name: "machineLocation", code: 0x6d4c6f63, type: typeType) // "mLoc"
    public static let machPort = CALSymbol(name: "machPort", code: 0x706f7274, type: typeType) // "port"
    public static let mailAlarm = CALSymbol(name: "mailAlarm", code: 0x77616c32, type: typeType) // "wal2"
    public static let March = CALSymbol(name: "March", code: 0x6d617220, type: typeType) // "mar\0x20"
    public static let May = CALSymbol(name: "May", code: 0x6d617920, type: typeType) // "may\0x20"
    public static let miniaturizable = CALSymbol(name: "miniaturizable", code: 0x69736d6e, type: typeType) // "ismn"
    public static let miniaturized = CALSymbol(name: "miniaturized", code: 0x706d6e64, type: typeType) // "pmnd"
    public static let modified = CALSymbol(name: "modified", code: 0x696d6f64, type: typeType) // "imod"
    public static let Monday = CALSymbol(name: "Monday", code: 0x6d6f6e20, type: typeType) // "mon\0x20"
    public static let name = CALSymbol(name: "name", code: 0x706e616d, type: typeType) // "pnam"
    public static let November = CALSymbol(name: "November", code: 0x6e6f7620, type: typeType) // "nov\0x20"
    public static let null = CALSymbol(name: "null", code: 0x6e756c6c, type: typeType) // "null"
    public static let October = CALSymbol(name: "October", code: 0x6f637420, type: typeType) // "oct\0x20"
    public static let openFileAlarm = CALSymbol(name: "openFileAlarm", code: 0x77616c33, type: typeType) // "wal3"
    public static let pagesAcross = CALSymbol(name: "pagesAcross", code: 0x6c776c61, type: typeType) // "lwla"
    public static let pagesDown = CALSymbol(name: "pagesDown", code: 0x6c776c64, type: typeType) // "lwld"
    public static let participationStatus = CALSymbol(name: "participationStatus", code: 0x77726133, type: typeType) // "wra3"
    public static let PICTPicture = CALSymbol(name: "PICTPicture", code: 0x50494354, type: typeType) // "PICT"
    public static let pixelMapRecord = CALSymbol(name: "pixelMapRecord", code: 0x74706d6d, type: typeType) // "tpmm"
    public static let point = CALSymbol(name: "point", code: 0x51447074, type: typeType) // "QDpt"
    public static let printSettings = CALSymbol(name: "printSettings", code: 0x70736574, type: typeType) // "pset"
    public static let processSerialNumber = CALSymbol(name: "processSerialNumber", code: 0x70736e20, type: typeType) // "psn\0x20"
    public static let progression = CALSymbol(name: "progression", code: 0x77727032, type: typeType) // "wrp2"
    public static let properties = CALSymbol(name: "properties", code: 0x70414c4c, type: typeType) // "pALL"
    public static let property_ = CALSymbol(name: "property_", code: 0x70726f70, type: typeType) // "prop"
    public static let real = CALSymbol(name: "real", code: 0x646f7562, type: typeType) // "doub"
    public static let record = CALSymbol(name: "record", code: 0x7265636f, type: typeType) // "reco"
    public static let recurrence = CALSymbol(name: "recurrence", code: 0x77723135, type: typeType) // "wr15"
    public static let reference = CALSymbol(name: "reference", code: 0x6f626a20, type: typeType) // "obj\0x20"
    public static let requestedPrintTime = CALSymbol(name: "requestedPrintTime", code: 0x6c777174, type: typeType) // "lwqt"
    public static let resizable = CALSymbol(name: "resizable", code: 0x7072737a, type: typeType) // "prsz"
    public static let RGB16Color = CALSymbol(name: "RGB16Color", code: 0x74723136, type: typeType) // "tr16"
    public static let RGB96Color = CALSymbol(name: "RGB96Color", code: 0x74723936, type: typeType) // "tr96"
    public static let RGBColor = CALSymbol(name: "RGBColor", code: 0x63524742, type: typeType) // "cRGB"
    public static let rotation = CALSymbol(name: "rotation", code: 0x74726f74, type: typeType) // "trot"
    public static let Saturday = CALSymbol(name: "Saturday", code: 0x73617420, type: typeType) // "sat\0x20"
    public static let script = CALSymbol(name: "script", code: 0x73637074, type: typeType) // "scpt"
    public static let September = CALSymbol(name: "September", code: 0x73657020, type: typeType) // "sep\0x20"
    public static let sequence = CALSymbol(name: "sequence", code: 0x77723133, type: typeType) // "wr13"
    public static let shortInteger = CALSymbol(name: "shortInteger", code: 0x73686f72, type: typeType) // "shor"
    public static let smallReal = CALSymbol(name: "smallReal", code: 0x73696e67, type: typeType) // "sing"
    public static let soundAlarm = CALSymbol(name: "soundAlarm", code: 0x77616c34, type: typeType) // "wal4"
    public static let soundFile = CALSymbol(name: "soundFile", code: 0x77616c66, type: typeType) // "walf"
    public static let soundName = CALSymbol(name: "soundName", code: 0x77616c73, type: typeType) // "wals"
    public static let stampDate = CALSymbol(name: "stampDate", code: 0x77723473, type: typeType) // "wr4s"
    public static let startDate = CALSymbol(name: "startDate", code: 0x77723173, type: typeType) // "wr1s"
    public static let startingPage = CALSymbol(name: "startingPage", code: 0x6c776670, type: typeType) // "lwfp"
    public static let status = CALSymbol(name: "status", code: 0x77726534, type: typeType) // "wre4"
    public static let string = CALSymbol(name: "string", code: 0x54455854, type: typeType) // "TEXT"
    public static let styledClipboardText = CALSymbol(name: "styledClipboardText", code: 0x7374796c, type: typeType) // "styl"
    public static let styledText = CALSymbol(name: "styledText", code: 0x53545854, type: typeType) // "STXT"
    public static let summary = CALSymbol(name: "summary", code: 0x77723131, type: typeType) // "wr11"
    public static let Sunday = CALSymbol(name: "Sunday", code: 0x73756e20, type: typeType) // "sun\0x20"
    public static let targetPrinter = CALSymbol(name: "targetPrinter", code: 0x74727072, type: typeType) // "trpr"
    public static let textStyleInfo = CALSymbol(name: "textStyleInfo", code: 0x74737479, type: typeType) // "tsty"
    public static let Thursday = CALSymbol(name: "Thursday", code: 0x74687520, type: typeType) // "thu\0x20"
    public static let TIFFPicture = CALSymbol(name: "TIFFPicture", code: 0x54494646, type: typeType) // "TIFF"
    public static let title = CALSymbol(name: "title", code: 0x77723032, type: typeType) // "wr02"
    public static let triggerDate = CALSymbol(name: "triggerDate", code: 0x77616c65, type: typeType) // "wale"
    public static let triggerInterval = CALSymbol(name: "triggerInterval", code: 0x77616c64, type: typeType) // "wald"
    public static let Tuesday = CALSymbol(name: "Tuesday", code: 0x74756520, type: typeType) // "tue\0x20"
    public static let typeClass = CALSymbol(name: "typeClass", code: 0x74797065, type: typeType) // "type"
    public static let uid = CALSymbol(name: "uid", code: 0x49442020, type: typeType) // "ID\0x20\0x20"
    public static let UnicodeText = CALSymbol(name: "UnicodeText", code: 0x75747874, type: typeType) // "utxt"
    public static let unsignedDoubleInteger = CALSymbol(name: "unsignedDoubleInteger", code: 0x75636f6d, type: typeType) // "ucom"
    public static let unsignedInteger = CALSymbol(name: "unsignedInteger", code: 0x6d61676e, type: typeType) // "magn"
    public static let unsignedShortInteger = CALSymbol(name: "unsignedShortInteger", code: 0x75736872, type: typeType) // "ushr"
    public static let url = CALSymbol(name: "url", code: 0x77723136, type: typeType) // "wr16"
    public static let UTF16Text = CALSymbol(name: "UTF16Text", code: 0x75743136, type: typeType) // "ut16"
    public static let UTF8Text = CALSymbol(name: "UTF8Text", code: 0x75746638, type: typeType) // "utf8"
    public static let version = CALSymbol(name: "version", code: 0x76657273, type: typeType) // "vers"
    public static let visible = CALSymbol(name: "visible", code: 0x70766973, type: typeType) // "pvis"
    public static let Wednesday = CALSymbol(name: "Wednesday", code: 0x77656420, type: typeType) // "wed\0x20"
    public static let window = CALSymbol(name: "window", code: 0x6377696e, type: typeType) // "cwin"
    public static let writable = CALSymbol(name: "writable", code: 0x77723035, type: typeType) // "wr05"
    public static let writingCode = CALSymbol(name: "writingCode", code: 0x70736374, type: typeType) // "psct"
    public static let zoomable = CALSymbol(name: "zoomable", code: 0x69737a6d, type: typeType) // "iszm"
    public static let zoomed = CALSymbol(name: "zoomed", code: 0x707a756d, type: typeType) // "pzum"

    // Enumerators
    public static let accepted = CALSymbol(name: "accepted", code: 0x45366170, type: typeEnumerated) // "E6ap"
    public static let ask = CALSymbol(name: "ask", code: 0x61736b20, type: typeEnumerated) // "ask\0x20"
    public static let cancelled = CALSymbol(name: "cancelled", code: 0x45346361, type: typeEnumerated) // "E4ca"
    public static let case_ = CALSymbol(name: "case_", code: 0x63617365, type: typeEnumerated) // "case"
    public static let confirmed = CALSymbol(name: "confirmed", code: 0x4534636e, type: typeEnumerated) // "E4cn"
    public static let dayView = CALSymbol(name: "dayView", code: 0x45356461, type: typeEnumerated) // "E5da"
    public static let declined = CALSymbol(name: "declined", code: 0x45366470, type: typeEnumerated) // "E6dp"
    public static let detailed = CALSymbol(name: "detailed", code: 0x6c776474, type: typeEnumerated) // "lwdt"
    public static let diacriticals = CALSymbol(name: "diacriticals", code: 0x64696163, type: typeEnumerated) // "diac"
    public static let expansion = CALSymbol(name: "expansion", code: 0x65787061, type: typeEnumerated) // "expa"
    public static let highPriority = CALSymbol(name: "highPriority", code: 0x74647031, type: typeEnumerated) // "tdp1"
    public static let hyphens = CALSymbol(name: "hyphens", code: 0x68797068, type: typeEnumerated) // "hyph"
    public static let lowPriority = CALSymbol(name: "lowPriority", code: 0x74647039, type: typeEnumerated) // "tdp9"
    public static let mediumPriority = CALSymbol(name: "mediumPriority", code: 0x74647035, type: typeEnumerated) // "tdp5"
    public static let monthView = CALSymbol(name: "monthView", code: 0x45356d6f, type: typeEnumerated) // "E5mo"
    public static let no = CALSymbol(name: "no", code: 0x6e6f2020, type: typeEnumerated) // "no\0x20\0x20"
    public static let none = CALSymbol(name: "none", code: 0x45346e6f, type: typeEnumerated) // "E4no"
    public static let noPriority = CALSymbol(name: "noPriority", code: 0x74647030, type: typeEnumerated) // "tdp0"
    public static let numericStrings = CALSymbol(name: "numericStrings", code: 0x6e756d65, type: typeEnumerated) // "nume"
    public static let punctuation = CALSymbol(name: "punctuation", code: 0x70756e63, type: typeEnumerated) // "punc"
    public static let standard = CALSymbol(name: "standard", code: 0x6c777374, type: typeEnumerated) // "lwst"
    public static let tentative = CALSymbol(name: "tentative", code: 0x45367470, type: typeEnumerated) // "E6tp"
    public static let unknown = CALSymbol(name: "unknown", code: 0x45366e61, type: typeEnumerated) // "E6na"
    public static let weekView = CALSymbol(name: "weekView", code: 0x45357765, type: typeEnumerated) // "E5we"
    public static let whitespace = CALSymbol(name: "whitespace", code: 0x77686974, type: typeEnumerated) // "whit"
    public static let yes = CALSymbol(name: "yes", code: 0x79657320, type: typeEnumerated) // "yes\0x20"
}

public typealias CAL = CALSymbol // allows symbols to be written as (e.g.) CAL.name instead of CALSymbol.name


/******************************************************************************/
// Specifier extensions; these add command methods and property/elements getters based on Calendar.app terminology

public protocol CALCommand: SwiftAutomation.SpecifierProtocol {} // provides AE dispatch methods

// Command->Any will be bound when return type can't be inferred, else Command->T

extension CALCommand {
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
    @discardableResult public func createCalendar(_ directParameter: Any = SwiftAutomation.NoParameter,
            withName: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "createCalendar", eventClass: 0x77726274, eventID: 0x61656332, // "wrbt"/"aec2"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("withName", 0x77746e6d, withName), // "wtnm"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func createCalendar<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            withName: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "createCalendar", eventClass: 0x77726274, eventID: 0x61656332, // "wrbt"/"aec2"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("withName", 0x77746e6d, withName), // "wtnm"
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
    @discardableResult public func GetURL(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "GetURL", eventClass: 0x4755524c, eventID: 0x4755524c, // "GURL"/"GURL"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func GetURL<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "GetURL", eventClass: 0x4755524c, eventID: 0x4755524c, // "GURL"/"GURL"
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
    @discardableResult public func reloadCalendars(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "reloadCalendars", eventClass: 0x77726274, eventID: 0x61656338, // "wrbt"/"aec8"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func reloadCalendars<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "reloadCalendars", eventClass: 0x77726274, eventID: 0x61656338, // "wrbt"/"aec8"
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
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "save", eventClass: 0x636f7265, eventID: 0x73617665, // "core"/"save"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func save<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "save", eventClass: 0x636f7265, eventID: 0x73617665, // "core"/"save"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
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
    @discardableResult public func show(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "show", eventClass: 0x77726274, eventID: 0x61656333, // "wrbt"/"aec3"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func show<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "show", eventClass: 0x77726274, eventID: 0x61656333, // "wrbt"/"aec3"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func switchView(_ directParameter: Any = SwiftAutomation.NoParameter,
            to: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "switchView", eventClass: 0x77726274, eventID: 0x61656361, // "wrbt"/"aeca"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x77726535, to), // "wre5"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func switchView<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            to: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "switchView", eventClass: 0x77726274, eventID: 0x61656361, // "wrbt"/"aeca"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x77726535, to), // "wre5"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func viewCalendar(_ directParameter: Any = SwiftAutomation.NoParameter,
            at: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "viewCalendar", eventClass: 0x77726274, eventID: 0x61656339, // "wrbt"/"aec9"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("at", 0x77746474, at), // "wtdt"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func viewCalendar<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            at: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "viewCalendar", eventClass: 0x77726274, eventID: 0x61656339, // "wrbt"/"aec9"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("at", 0x77746474, at), // "wtdt"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
}


public protocol CALObject: SwiftAutomation.ObjectSpecifierExtension, CALCommand {} // provides vars and methods for constructing specifiers

extension CALObject {
    
    // Properties
    public var alldayEvent: CALItem {return self.property(0x77726164) as! CALItem} // "wrad"
    public var allowCancel: CALItem {return self.property(0x77727033) as! CALItem} // "wrp3"
    public var bounds: CALItem {return self.property(0x70626e64) as! CALItem} // "pbnd"
    public var class_: CALItem {return self.property(0x70636c73) as! CALItem} // "pcls"
    public var closeable: CALItem {return self.property(0x68636c62) as! CALItem} // "hclb"
    public var collating: CALItem {return self.property(0x6c77636c) as! CALItem} // "lwcl"
    public var color: CALItem {return self.property(0x636f6c72) as! CALItem} // "colr"
    public var copies: CALItem {return self.property(0x6c776370) as! CALItem} // "lwcp"
    public var description_: CALItem {return self.property(0x77723132) as! CALItem} // "wr12"
    public var displayName: CALItem {return self.property(0x77726131) as! CALItem} // "wra1"
    public var document: CALItem {return self.property(0x646f6375) as! CALItem} // "docu"
    public var email: CALItem {return self.property(0x77726132) as! CALItem} // "wra2"
    public var endDate: CALItem {return self.property(0x77723573) as! CALItem} // "wr5s"
    public var endingPage: CALItem {return self.property(0x6c776c70) as! CALItem} // "lwlp"
    public var errorHandling: CALItem {return self.property(0x6c776568) as! CALItem} // "lweh"
    public var excludedDates: CALItem {return self.property(0x77723273) as! CALItem} // "wr2s"
    public var faxNumber: CALItem {return self.property(0x6661786e) as! CALItem} // "faxn"
    public var file: CALItem {return self.property(0x66696c65) as! CALItem} // "file"
    public var filepath: CALItem {return self.property(0x77616c70) as! CALItem} // "walp"
    public var frontmost: CALItem {return self.property(0x70697366) as! CALItem} // "pisf"
    public var id: CALItem {return self.property(0x49442020) as! CALItem} // "ID\0x20\0x20"
    public var index: CALItem {return self.property(0x70696478) as! CALItem} // "pidx"
    public var location: CALItem {return self.property(0x77723134) as! CALItem} // "wr14"
    public var miniaturizable: CALItem {return self.property(0x69736d6e) as! CALItem} // "ismn"
    public var miniaturized: CALItem {return self.property(0x706d6e64) as! CALItem} // "pmnd"
    public var modified: CALItem {return self.property(0x696d6f64) as! CALItem} // "imod"
    public var name: CALItem {return self.property(0x706e616d) as! CALItem} // "pnam"
    public var pagesAcross: CALItem {return self.property(0x6c776c61) as! CALItem} // "lwla"
    public var pagesDown: CALItem {return self.property(0x6c776c64) as! CALItem} // "lwld"
    public var participationStatus: CALItem {return self.property(0x77726133) as! CALItem} // "wra3"
    public var progression: CALItem {return self.property(0x77727032) as! CALItem} // "wrp2"
    public var properties: CALItem {return self.property(0x70414c4c) as! CALItem} // "pALL"
    public var recurrence: CALItem {return self.property(0x77723135) as! CALItem} // "wr15"
    public var requestedPrintTime: CALItem {return self.property(0x6c777174) as! CALItem} // "lwqt"
    public var resizable: CALItem {return self.property(0x7072737a) as! CALItem} // "prsz"
    public var sequence: CALItem {return self.property(0x77723133) as! CALItem} // "wr13"
    public var soundFile: CALItem {return self.property(0x77616c66) as! CALItem} // "walf"
    public var soundName: CALItem {return self.property(0x77616c73) as! CALItem} // "wals"
    public var stampDate: CALItem {return self.property(0x77723473) as! CALItem} // "wr4s"
    public var startDate: CALItem {return self.property(0x77723173) as! CALItem} // "wr1s"
    public var startingPage: CALItem {return self.property(0x6c776670) as! CALItem} // "lwfp"
    public var status: CALItem {return self.property(0x77726534) as! CALItem} // "wre4"
    public var summary: CALItem {return self.property(0x77723131) as! CALItem} // "wr11"
    public var targetPrinter: CALItem {return self.property(0x74727072) as! CALItem} // "trpr"
    public var title: CALItem {return self.property(0x77723032) as! CALItem} // "wr02"
    public var triggerDate: CALItem {return self.property(0x77616c65) as! CALItem} // "wale"
    public var triggerInterval: CALItem {return self.property(0x77616c64) as! CALItem} // "wald"
    public var uid: CALItem {return self.property(0x49442020) as! CALItem} // "ID\0x20\0x20"
    public var url: CALItem {return self.property(0x77723136) as! CALItem} // "wr16"
    public var version: CALItem {return self.property(0x76657273) as! CALItem} // "vers"
    public var visible: CALItem {return self.property(0x70766973) as! CALItem} // "pvis"
    public var writable: CALItem {return self.property(0x77723035) as! CALItem} // "wr05"
    public var zoomable: CALItem {return self.property(0x69737a6d) as! CALItem} // "iszm"
    public var zoomed: CALItem {return self.property(0x707a756d) as! CALItem} // "pzum"

    // Elements
    public var applications: CALItems {return self.elements(0x63617070) as! CALItems} // "capp"
    public var attendees: CALItems {return self.elements(0x77726561) as! CALItems} // "wrea"
    public var calendars: CALItems {return self.elements(0x77726573) as! CALItems} // "wres"
    public var displayAlarms: CALItems {return self.elements(0x77616c31) as! CALItems} // "wal1"
    public var documents: CALItems {return self.elements(0x646f6375) as! CALItems} // "docu"
    public var events: CALItems {return self.elements(0x77726576) as! CALItems} // "wrev"
    public var items: CALItems {return self.elements(0x636f626a) as! CALItems} // "cobj"
    public var mailAlarms: CALItems {return self.elements(0x77616c32) as! CALItems} // "wal2"
    public var openFileAlarms: CALItems {return self.elements(0x77616c33) as! CALItems} // "wal3"
    public var soundAlarms: CALItems {return self.elements(0x77616c34) as! CALItems} // "wal4"
    public var windows: CALItems {return self.elements(0x6377696e) as! CALItems} // "cwin"
}


/******************************************************************************/
// Specifier subclasses add app-specific extensions

// beginning/end/before/after
public class CALInsertion: SwiftAutomation.InsertionSpecifier, CALCommand {}


// property/by-index/by-name/by-id/previous/next/first/middle/last/any
public class CALItem: SwiftAutomation.ObjectSpecifier, CALObject {
    public typealias InsertionSpecifierType = CALInsertion
    public typealias ObjectSpecifierType = CALItem
    public typealias MultipleObjectSpecifierType = CALItems
}

// by-range/by-test/all
public class CALItems: CALItem, SwiftAutomation.MultipleObjectSpecifierExtension {}

// App/Con/Its
public class CALRoot: SwiftAutomation.RootSpecifier, CALObject, SwiftAutomation.RootSpecifierExtension {
    public typealias InsertionSpecifierType = CALInsertion
    public typealias ObjectSpecifierType = CALItem
    public typealias MultipleObjectSpecifierType = CALItems
    public override class var untargetedAppData: SwiftAutomation.AppData { return _untargetedAppData }
}

// Application
public class Calendar: CALRoot, SwiftAutomation.Application {
    public convenience init(launchOptions: SwiftAutomation.LaunchOptions = SwiftAutomation.DefaultLaunchOptions, relaunchMode: SwiftAutomation.RelaunchMode = SwiftAutomation.DefaultRelaunchMode) {
        self.init(rootObject: SwiftAutomation.AppRootDesc, appData: Swift.type(of:self).untargetedAppData.targetedCopy(
                  .bundleIdentifier("com.apple.iCal", true), launchOptions: launchOptions, relaunchMode: relaunchMode))
    }
}

// App/Con/Its root objects used to construct untargeted specifiers; these can be used to construct specifiers for use in commands, though cannot send commands themselves

public let CALApp = _untargetedAppData.app as! CALRoot
public let CALCon = _untargetedAppData.con as! CALRoot
public let CALIts = _untargetedAppData.its as! CALRoot


/******************************************************************************/
// Static types

public typealias CALRecord = [CALSymbol:Any] // default Swift type for AERecordDescs







