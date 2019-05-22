//
//  MessagesGlue.swift
//  Messages.app 12.0
//  SwiftAutomation.framework 0.1.0
//  `aeglue 'Messages.app'`
//


import Foundation
import AppleEvents
import SwiftAutomation


/******************************************************************************/
// Create an untargeted AppData instance for use in App, Con, Its roots,
// and in Application initializers to create targeted AppData instances.

private let _specifierFormatter = SwiftAutomation.SpecifierFormatter(
        applicationClassName: "Messages",
        classNamePrefix: "MES",
        typeNames: [
                0x49434376: "active", // "ICCv"
                0x69616176: "activeAvChat", // "iaav"
                0x616c6973: "alias", // "alis"
                0x2a2a2a2a: "anything", // "****"
                0x63617070: "application", // "capp"
                0x62756e64: "applicationBundleID", // "bund"
                0x7369676e: "applicationSignature", // "sign"
                0x6170726c: "applicationURL", // "aprl"
                0x61707220: "April", // "apr "
                0x61736b20: "ask", // "ask "
                0x61747473: "attachment", // "atts"
                0x63617472: "attributeRun", // "catr"
                0x49434161: "audio", // "ICAa"
                0x61636f6e: "audioChat", // "acon"
                0x61756720: "August", // "aug "
                0x62617271: "authorizationRequest", // "barq"
                0x6176616c: "available", // "aval"
                0x61776179: "away", // "away"
                0x62657374: "best", // "best"
                0x626d726b: "bookmarkData", // "bmrk"
                0x626f6f6c: "boolean", // "bool"
                0x71647274: "boundingRectangle", // "qdrt"
                0x70626e64: "bounds", // "pbnd"
                0x70726573: "buddy", // "pres"
                0x63617073: "capabilities", // "caps"
                0x63617365: "case_", // "case"
                0x63686120: "character", // "cha "
                0x69636374: "chat", // "icct"
                0x49436372: "chatRoom", // "ICcr"
                0x49434374: "chatType", // "ICCt"
                0x70636c73: "class_", // "pcls"
                0x68636c62: "closeable", // "hclb"
                0x63524742: "color", // "cRGB"
                0x636f6c72: "color", // "colr"
                0x636c7274: "colorTable", // "clrt"
                0x49434163: "connected", // "ICAc"
                0x636f6e6e: "connected", // "conn"
                0x636f6e67: "connecting", // "cong"
                0x49434178: "connecting", // "ICAx"
                0x73737461: "connectionStatus", // "ssta"
                0x656e756d: "constant", // "enum"
                0x74646173: "dashStyle", // "tdas"
                0x74647461: "data", // "tdta"
                0x6c647420: "date", // "ldt "
                0x64656320: "December", // "dec "
                0x6465636d: "decimalStruct", // "decm"
                0x64696163: "diacriticals", // "diac"
                0x49436469: "directInstantMessage", // "ICdi"
                0x46546472: "direction", // "FTdr"
                0x64636f6e: "disconnected", // "dcon"
                0x64636e67: "disconnecting", // "dcng"
                0x646f6375: "document", // "docu"
                0x636f6d70: "doubleInteger", // "comp"
                0x656e626c: "enabled", // "enbl"
                0x656e6373: "encodedString", // "encs"
                0x4943416e: "ended", // "ICAn"
                0x45505320: "EPSPicture", // "EPS "
                0x65787061: "expansion", // "expa"
                0x46547365: "failed", // "FTse"
                0x66656220: "February", // "feb "
                0x66747074: "file", // "ftpt"
                0x6174666e: "file", // "atfn"
                0x66696c65: "file", // "file"
                0x46547070: "fileProgress", // "FTpp"
                0x66737266: "fileRef", // "fsrf"
                0x4654707a: "fileSize", // "FTpz"
                0x746e6672: "fileTransfer", // "tnfr"
                0x6675726c: "fileURL", // "furl"
                0x4654737a: "finalizing", // "FTsz"
                0x46547366: "finished", // "FTsf"
                0x7072666e: "firstName", // "prfn"
                0x66697864: "fixed", // "fixd"
                0x66706e74: "fixedPoint", // "fpnt"
                0x66726374: "fixedRectangle", // "frct"
                0x666f6e74: "font", // "font"
                0x66726920: "Friday", // "fri "
                0x70697366: "frontmost", // "pisf"
                0x7072466e: "fullName", // "prFn"
                0x47494666: "GIFPicture", // "GIFf"
                0x63677478: "graphicText", // "cgtx"
                0x686e646c: "handle", // "hndl"
                0x68797068: "hyphens", // "hyph"
                0x49442020: "id", // "ID  "
                0x69646c65: "idle", // "idle"
                0x6964746d: "idleTime", // "idtm"
                0x696d6141: "image", // "imaA"
                0x73696d73: "iMessage", // "sims"
                0x46546963: "incoming", // "FTic"
                0x70696478: "index", // "pidx"
                0x4943696d: "instantMessage", // "ICim"
                0x6c6f6e67: "integer", // "long"
                0x69747874: "internationalText", // "itxt"
                0x696e746c: "internationalWritingCode", // "intl"
                0x696e7673: "invisible", // "invs"
                0x4943696e: "invitation", // "ICin"
                0x4976746d: "invitationMessage", // "Ivtm"
                0x49434169: "invited", // "ICAi"
                0x636f626a: "item", // "cobj"
                0x736a6162: "Jabber", // "sjab"
                0x6a616e20: "January", // "jan "
                0x49434a6a: "joined", // "ICJj"
                0x49434a67: "joining", // "ICJg"
                0x49434a53: "joinState", // "ICJS"
                0x4a504547: "JPEGPicture", // "JPEG"
                0x6a756c20: "July", // "jul "
                0x6a756e20: "June", // "jun "
                0x6b706964: "kernelProcessID", // "kpid"
                0x6c64626c: "largeReal", // "ldbl"
                0x70724c6e: "lastName", // "prLn"
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
                0x69736d6e: "minimizable", // "ismn"
                0x706d6e64: "minimized", // "pmnd"
                0x696d6f64: "modified", // "imod"
                0x6d6f6e20: "Monday", // "mon "
                0x6d776163: "multipersonAudio", // "mwac"
                0x6d777663: "multipersonVideo", // "mwvc"
                0x706e616d: "name", // "pnam"
                0x6e6f2020: "no", // "no  "
                0x49434a63: "notJoined", // "ICJc"
                0x6e6f7620: "November", // "nov "
                0x6e756c6c: "null", // "null"
                0x6e756d65: "numericStrings", // "nume"
                0x6f637420: "October", // "oct "
                0x6f66666c: "offline", // "offl"
                0x46546f67: "outgoing", // "FTog"
                0x63706172: "paragraph", // "cpar"
                0x49437074: "participants", // "ICpt"
                0x50494354: "PICTPicture", // "PICT"
                0x74706d6d: "pixelMapRecord", // "tpmm"
                0x51447074: "point", // "QDpt"
                0x46547370: "preparing", // "FTsp"
                0x70736e20: "processSerialNumber", // "psn "
                0x70414c4c: "properties", // "pALL"
                0x70726f70: "property_", // "prop"
                0x70756e63: "punctuation", // "punc"
                0x646f7562: "real", // "doub"
                0x7265636f: "record", // "reco"
                0x6f626a20: "reference", // "obj "
                0x7072737a: "resizable", // "prsz"
                0x74723136: "RGB16Color", // "tr16"
                0x74723936: "RGB96Color", // "tr96"
                0x72746678: "richText", // "rtfx"
                0x74726f74: "rotation", // "trot"
                0x73617420: "Saturday", // "sat "
                0x73637074: "script", // "scpt"
                0x68616e64: "scriptAccountLegacyName", // "hand"
                0x49434372: "secure", // "ICCr"
                0x73657020: "September", // "sep "
                0x69637376: "service", // "icsv"
                0x73747970: "serviceType", // "styp"
                0x73686f72: "shortInteger", // "shor"
                0x7074737a: "size", // "ptsz"
                0x73696e67: "smallReal", // "sing"
                0x49434343: "started", // "ICCC"
                0x73746174: "status", // "stat"
                0x736d7367: "statusMessage", // "smsg"
                0x54455854: "string", // "TEXT"
                0x7374796c: "styledClipboardText", // "styl"
                0x53545854: "styledText", // "STXT"
                0x49434373: "subject", // "ICCs"
                0x73756e20: "Sunday", // "sun "
                0x69637474: "textChat", // "ictt"
                0x74636f6e: "textChatInvitation", // "tcon"
                0x74737479: "textStyleInfo", // "tsty"
                0x74687520: "Thursday", // "thu "
                0x54494646: "TIFFPicture", // "TIFF"
                0x46547367: "transferring", // "FTsg"
                0x46547066: "transferStatus", // "FTpf"
                0x74756520: "Tuesday", // "tue "
                0x74797065: "typeClass", // "type"
                0x75747874: "UnicodeText", // "utxt"
                0x756e6b6e: "unknown", // "unkn"
                0x75636f6d: "unsignedDoubleInteger", // "ucom"
                0x6d61676e: "unsignedInteger", // "magn"
                0x75736872: "unsignedShortInteger", // "ushr"
                0x49434375: "updated", // "ICCu"
                0x75743136: "UTF16Text", // "ut16"
                0x75746638: "UTF8Text", // "utf8"
                0x76657273: "version", // "vers"
                0x49434176: "video", // "ICAv"
                0x76636f6e: "videoChat", // "vcon"
                0x70766973: "visible", // "pvis"
                0x46547377: "waiting", // "FTsw"
                0x49434177: "waiting", // "ICAw"
                0x77656420: "Wednesday", // "wed "
                0x77686974: "whitespace", // "whit"
                0x6377696e: "window", // "cwin"
                0x63776f72: "word", // "cwor"
                0x70736374: "writingCode", // "psct"
                0x79657320: "yes", // "yes "
                0x69737a6d: "zoomable", // "iszm"
                0x707a756d: "zoomed", // "pzum"
        ],
        propertyNames: [
                0x49434376: "active", // "ICCv"
                0x69616176: "activeAvChat", // "iaav"
                0x70626e64: "bounds", // "pbnd"
                0x70726573: "buddy", // "pres"
                0x63617073: "capabilities", // "caps"
                0x49434374: "chatType", // "ICCt"
                0x70636c73: "class_", // "pcls"
                0x68636c62: "closeable", // "hclb"
                0x636f6c72: "color", // "colr"
                0x73737461: "connectionStatus", // "ssta"
                0x46546472: "direction", // "FTdr"
                0x646f6375: "document", // "docu"
                0x656e626c: "enabled", // "enbl"
                0x6174666e: "file", // "atfn"
                0x66696c65: "file", // "file"
                0x66747074: "file", // "ftpt"
                0x46547070: "fileProgress", // "FTpp"
                0x4654707a: "fileSize", // "FTpz"
                0x7072666e: "firstName", // "prfn"
                0x666f6e74: "font", // "font"
                0x70697366: "frontmost", // "pisf"
                0x7072466e: "fullName", // "prFn"
                0x686e646c: "handle", // "hndl"
                0x49442020: "id", // "ID  "
                0x6964746d: "idleTime", // "idtm"
                0x696d6141: "image", // "imaA"
                0x70696478: "index", // "pidx"
                0x4943696e: "invitation", // "ICin"
                0x4976746d: "invitationMessage", // "Ivtm"
                0x49434a53: "joinState", // "ICJS"
                0x70724c6e: "lastName", // "prLn"
                0x69736d6e: "minimizable", // "ismn"
                0x706d6e64: "minimized", // "pmnd"
                0x696d6f64: "modified", // "imod"
                0x706e616d: "name", // "pnam"
                0x49437074: "participants", // "ICpt"
                0x70414c4c: "properties", // "pALL"
                0x7072737a: "resizable", // "prsz"
                0x68616e64: "scriptAccountLegacyName", // "hand"
                0x49434372: "secure", // "ICCr"
                0x69637376: "service", // "icsv"
                0x73747970: "serviceType", // "styp"
                0x7074737a: "size", // "ptsz"
                0x49434343: "started", // "ICCC"
                0x73746174: "status", // "stat"
                0x736d7367: "statusMessage", // "smsg"
                0x49434373: "subject", // "ICCs"
                0x46547066: "transferStatus", // "FTpf"
                0x49434375: "updated", // "ICCu"
                0x76657273: "version", // "vers"
                0x70766973: "visible", // "pvis"
                0x69737a6d: "zoomable", // "iszm"
                0x707a756d: "zoomed", // "pzum"
        ],
        elementsNames: [
                0x63617070: ("application", "applications"), // "capp"
                0x61747473: ("attachment", "attachments"), // "atts"
                0x63617472: ("attributeRun", "attributeRuns"), // "catr"
                0x62617271: ("authorizationRequest", "authorizationRequests"), // "barq"
                0x70726573: ("buddy", "buddies"), // "pres"
                0x63686120: ("character", "characters"), // "cha "
                0x69636374: ("chat", "chats"), // "icct"
                0x636f6c72: ("color", "colors"), // "colr"
                0x646f6375: ("document", "documents"), // "docu"
                0x746e6672: ("fileTransfer", "fileTransfers"), // "tnfr"
                0x636f626a: ("item", "items"), // "cobj"
                0x63706172: ("paragraph", "paragraphs"), // "cpar"
                0x72746678: ("richText", "richText"), // "rtfx"
                0x69637376: ("service", "services"), // "icsv"
                0x69637474: ("textChat", "textChats"), // "ictt"
                0x6377696e: ("window", "windows"), // "cwin"
                0x63776f72: ("word", "words"), // "cwor"
        ])

private let _glueClasses = SwiftAutomation.GlueClasses(
                                                insertionSpecifierType: MESInsertion.self,
                                                objectSpecifierType: MESItem.self,
                                                multiObjectSpecifierType: MESItems.self,
                                                rootSpecifierType: MESRoot.self,
                                                applicationType: Messages.self,
                                                symbolType: MESSymbol.self,
                                                formatter: _specifierFormatter)

private let _untargetedAppData = SwiftAutomation.AppData(glueClasses: _glueClasses)


/******************************************************************************/
// Symbol subclass defines static type/enum/property constants based on Messages.app terminology

public class MESSymbol: SwiftAutomation.Symbol {

    override public var typeAliasName: String {return "MES"}

    public override class func symbol(code: OSType, type: OSType = AppleEvents.typeType, descriptor: ScalarDescriptor? = nil) -> MESSymbol {
        switch (code) {
        case 0x49434376: return self.active // "ICCv"
        case 0x69616176: return self.activeAvChat // "iaav"
        case 0x616c6973: return self.alias // "alis"
        case 0x2a2a2a2a: return self.anything // "****"
        case 0x63617070: return self.application // "capp"
        case 0x62756e64: return self.applicationBundleID // "bund"
        case 0x7369676e: return self.applicationSignature // "sign"
        case 0x6170726c: return self.applicationURL // "aprl"
        case 0x61707220: return self.April // "apr "
        case 0x61736b20: return self.ask // "ask "
        case 0x61747473: return self.attachment // "atts"
        case 0x63617472: return self.attributeRun // "catr"
        case 0x49434161: return self.audio // "ICAa"
        case 0x61636f6e: return self.audioChat // "acon"
        case 0x61756720: return self.August // "aug "
        case 0x62617271: return self.authorizationRequest // "barq"
        case 0x6176616c: return self.available // "aval"
        case 0x61776179: return self.away // "away"
        case 0x62657374: return self.best // "best"
        case 0x626d726b: return self.bookmarkData // "bmrk"
        case 0x626f6f6c: return self.boolean // "bool"
        case 0x71647274: return self.boundingRectangle // "qdrt"
        case 0x70626e64: return self.bounds // "pbnd"
        case 0x70726573: return self.buddy // "pres"
        case 0x63617073: return self.capabilities // "caps"
        case 0x63617365: return self.case_ // "case"
        case 0x63686120: return self.character // "cha "
        case 0x69636374: return self.chat // "icct"
        case 0x49436372: return self.chatRoom // "ICcr"
        case 0x49434374: return self.chatType // "ICCt"
        case 0x70636c73: return self.class_ // "pcls"
        case 0x68636c62: return self.closeable // "hclb"
        case 0x63524742: return self.color // "cRGB"
        case 0x636f6c72: return self.color // "colr"
        case 0x636c7274: return self.colorTable // "clrt"
        case 0x49434163: return self.connected // "ICAc"
        case 0x636f6e6e: return self.connected // "conn"
        case 0x636f6e67: return self.connecting // "cong"
        case 0x49434178: return self.connecting // "ICAx"
        case 0x73737461: return self.connectionStatus // "ssta"
        case 0x656e756d: return self.constant // "enum"
        case 0x74646173: return self.dashStyle // "tdas"
        case 0x74647461: return self.data // "tdta"
        case 0x6c647420: return self.date // "ldt "
        case 0x64656320: return self.December // "dec "
        case 0x6465636d: return self.decimalStruct // "decm"
        case 0x64696163: return self.diacriticals // "diac"
        case 0x49436469: return self.directInstantMessage // "ICdi"
        case 0x46546472: return self.direction // "FTdr"
        case 0x64636f6e: return self.disconnected // "dcon"
        case 0x64636e67: return self.disconnecting // "dcng"
        case 0x646f6375: return self.document // "docu"
        case 0x636f6d70: return self.doubleInteger // "comp"
        case 0x656e626c: return self.enabled // "enbl"
        case 0x656e6373: return self.encodedString // "encs"
        case 0x4943416e: return self.ended // "ICAn"
        case 0x45505320: return self.EPSPicture // "EPS "
        case 0x65787061: return self.expansion // "expa"
        case 0x46547365: return self.failed // "FTse"
        case 0x66656220: return self.February // "feb "
        case 0x66747074: return self.file // "ftpt"
        case 0x6174666e: return self.file // "atfn"
        case 0x66696c65: return self.file // "file"
        case 0x46547070: return self.fileProgress // "FTpp"
        case 0x66737266: return self.fileRef // "fsrf"
        case 0x4654707a: return self.fileSize // "FTpz"
        case 0x746e6672: return self.fileTransfer // "tnfr"
        case 0x6675726c: return self.fileURL // "furl"
        case 0x4654737a: return self.finalizing // "FTsz"
        case 0x46547366: return self.finished // "FTsf"
        case 0x7072666e: return self.firstName // "prfn"
        case 0x66697864: return self.fixed // "fixd"
        case 0x66706e74: return self.fixedPoint // "fpnt"
        case 0x66726374: return self.fixedRectangle // "frct"
        case 0x666f6e74: return self.font // "font"
        case 0x66726920: return self.Friday // "fri "
        case 0x70697366: return self.frontmost // "pisf"
        case 0x7072466e: return self.fullName // "prFn"
        case 0x47494666: return self.GIFPicture // "GIFf"
        case 0x63677478: return self.graphicText // "cgtx"
        case 0x686e646c: return self.handle // "hndl"
        case 0x68797068: return self.hyphens // "hyph"
        case 0x49442020: return self.id // "ID  "
        case 0x69646c65: return self.idle // "idle"
        case 0x6964746d: return self.idleTime // "idtm"
        case 0x696d6141: return self.image // "imaA"
        case 0x73696d73: return self.iMessage // "sims"
        case 0x46546963: return self.incoming // "FTic"
        case 0x70696478: return self.index // "pidx"
        case 0x4943696d: return self.instantMessage // "ICim"
        case 0x6c6f6e67: return self.integer // "long"
        case 0x69747874: return self.internationalText // "itxt"
        case 0x696e746c: return self.internationalWritingCode // "intl"
        case 0x696e7673: return self.invisible // "invs"
        case 0x4943696e: return self.invitation // "ICin"
        case 0x4976746d: return self.invitationMessage // "Ivtm"
        case 0x49434169: return self.invited // "ICAi"
        case 0x636f626a: return self.item // "cobj"
        case 0x736a6162: return self.Jabber // "sjab"
        case 0x6a616e20: return self.January // "jan "
        case 0x49434a6a: return self.joined // "ICJj"
        case 0x49434a67: return self.joining // "ICJg"
        case 0x49434a53: return self.joinState // "ICJS"
        case 0x4a504547: return self.JPEGPicture // "JPEG"
        case 0x6a756c20: return self.July // "jul "
        case 0x6a756e20: return self.June // "jun "
        case 0x6b706964: return self.kernelProcessID // "kpid"
        case 0x6c64626c: return self.largeReal // "ldbl"
        case 0x70724c6e: return self.lastName // "prLn"
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
        case 0x69736d6e: return self.minimizable // "ismn"
        case 0x706d6e64: return self.minimized // "pmnd"
        case 0x696d6f64: return self.modified // "imod"
        case 0x6d6f6e20: return self.Monday // "mon "
        case 0x6d776163: return self.multipersonAudio // "mwac"
        case 0x6d777663: return self.multipersonVideo // "mwvc"
        case 0x706e616d: return self.name // "pnam"
        case 0x6e6f2020: return self.no // "no  "
        case 0x49434a63: return self.notJoined // "ICJc"
        case 0x6e6f7620: return self.November // "nov "
        case 0x6e756c6c: return self.null // "null"
        case 0x6e756d65: return self.numericStrings // "nume"
        case 0x6f637420: return self.October // "oct "
        case 0x6f66666c: return self.offline // "offl"
        case 0x46546f67: return self.outgoing // "FTog"
        case 0x63706172: return self.paragraph // "cpar"
        case 0x49437074: return self.participants // "ICpt"
        case 0x50494354: return self.PICTPicture // "PICT"
        case 0x74706d6d: return self.pixelMapRecord // "tpmm"
        case 0x51447074: return self.point // "QDpt"
        case 0x46547370: return self.preparing // "FTsp"
        case 0x70736e20: return self.processSerialNumber // "psn "
        case 0x70414c4c: return self.properties // "pALL"
        case 0x70726f70: return self.property_ // "prop"
        case 0x70756e63: return self.punctuation // "punc"
        case 0x646f7562: return self.real // "doub"
        case 0x7265636f: return self.record // "reco"
        case 0x6f626a20: return self.reference // "obj "
        case 0x7072737a: return self.resizable // "prsz"
        case 0x74723136: return self.RGB16Color // "tr16"
        case 0x74723936: return self.RGB96Color // "tr96"
        case 0x72746678: return self.richText // "rtfx"
        case 0x74726f74: return self.rotation // "trot"
        case 0x73617420: return self.Saturday // "sat "
        case 0x73637074: return self.script // "scpt"
        case 0x68616e64: return self.scriptAccountLegacyName // "hand"
        case 0x49434372: return self.secure // "ICCr"
        case 0x73657020: return self.September // "sep "
        case 0x69637376: return self.service // "icsv"
        case 0x73747970: return self.serviceType // "styp"
        case 0x73686f72: return self.shortInteger // "shor"
        case 0x7074737a: return self.size // "ptsz"
        case 0x73696e67: return self.smallReal // "sing"
        case 0x49434343: return self.started // "ICCC"
        case 0x73746174: return self.status // "stat"
        case 0x736d7367: return self.statusMessage // "smsg"
        case 0x54455854: return self.string // "TEXT"
        case 0x7374796c: return self.styledClipboardText // "styl"
        case 0x53545854: return self.styledText // "STXT"
        case 0x49434373: return self.subject // "ICCs"
        case 0x73756e20: return self.Sunday // "sun "
        case 0x69637474: return self.textChat // "ictt"
        case 0x74636f6e: return self.textChatInvitation // "tcon"
        case 0x74737479: return self.textStyleInfo // "tsty"
        case 0x74687520: return self.Thursday // "thu "
        case 0x54494646: return self.TIFFPicture // "TIFF"
        case 0x46547367: return self.transferring // "FTsg"
        case 0x46547066: return self.transferStatus // "FTpf"
        case 0x74756520: return self.Tuesday // "tue "
        case 0x74797065: return self.typeClass // "type"
        case 0x75747874: return self.UnicodeText // "utxt"
        case 0x756e6b6e: return self.unknown // "unkn"
        case 0x75636f6d: return self.unsignedDoubleInteger // "ucom"
        case 0x6d61676e: return self.unsignedInteger // "magn"
        case 0x75736872: return self.unsignedShortInteger // "ushr"
        case 0x49434375: return self.updated // "ICCu"
        case 0x75743136: return self.UTF16Text // "ut16"
        case 0x75746638: return self.UTF8Text // "utf8"
        case 0x76657273: return self.version // "vers"
        case 0x49434176: return self.video // "ICAv"
        case 0x76636f6e: return self.videoChat // "vcon"
        case 0x70766973: return self.visible // "pvis"
        case 0x46547377: return self.waiting // "FTsw"
        case 0x49434177: return self.waiting // "ICAw"
        case 0x77656420: return self.Wednesday // "wed "
        case 0x77686974: return self.whitespace // "whit"
        case 0x6377696e: return self.window // "cwin"
        case 0x63776f72: return self.word // "cwor"
        case 0x70736374: return self.writingCode // "psct"
        case 0x79657320: return self.yes // "yes "
        case 0x69737a6d: return self.zoomable // "iszm"
        case 0x707a756d: return self.zoomed // "pzum"
        default: return super.symbol(code: code, type: type, descriptor: descriptor) as! MESSymbol
        }
    }

    // Types/properties
    public static let active = MESSymbol(name: "active", code: 0x49434376, type: AppleEvents.typeType) // "ICCv"
    public static let activeAvChat = MESSymbol(name: "activeAvChat", code: 0x69616176, type: AppleEvents.typeType) // "iaav"
    public static let alias = MESSymbol(name: "alias", code: 0x616c6973, type: AppleEvents.typeType) // "alis"
    public static let anything = MESSymbol(name: "anything", code: 0x2a2a2a2a, type: AppleEvents.typeType) // "****"
    public static let application = MESSymbol(name: "application", code: 0x63617070, type: AppleEvents.typeType) // "capp"
    public static let applicationBundleID = MESSymbol(name: "applicationBundleID", code: 0x62756e64, type: AppleEvents.typeType) // "bund"
    public static let applicationSignature = MESSymbol(name: "applicationSignature", code: 0x7369676e, type: AppleEvents.typeType) // "sign"
    public static let applicationURL = MESSymbol(name: "applicationURL", code: 0x6170726c, type: AppleEvents.typeType) // "aprl"
    public static let April = MESSymbol(name: "April", code: 0x61707220, type: AppleEvents.typeType) // "apr "
    public static let attachment = MESSymbol(name: "attachment", code: 0x61747473, type: AppleEvents.typeType) // "atts"
    public static let attributeRun = MESSymbol(name: "attributeRun", code: 0x63617472, type: AppleEvents.typeType) // "catr"
    public static let August = MESSymbol(name: "August", code: 0x61756720, type: AppleEvents.typeType) // "aug "
    public static let authorizationRequest = MESSymbol(name: "authorizationRequest", code: 0x62617271, type: AppleEvents.typeType) // "barq"
    public static let best = MESSymbol(name: "best", code: 0x62657374, type: AppleEvents.typeType) // "best"
    public static let bookmarkData = MESSymbol(name: "bookmarkData", code: 0x626d726b, type: AppleEvents.typeType) // "bmrk"
    public static let boolean = MESSymbol(name: "boolean", code: 0x626f6f6c, type: AppleEvents.typeType) // "bool"
    public static let boundingRectangle = MESSymbol(name: "boundingRectangle", code: 0x71647274, type: AppleEvents.typeType) // "qdrt"
    public static let bounds = MESSymbol(name: "bounds", code: 0x70626e64, type: AppleEvents.typeType) // "pbnd"
    public static let buddy = MESSymbol(name: "buddy", code: 0x70726573, type: AppleEvents.typeType) // "pres"
    public static let capabilities = MESSymbol(name: "capabilities", code: 0x63617073, type: AppleEvents.typeType) // "caps"
    public static let character = MESSymbol(name: "character", code: 0x63686120, type: AppleEvents.typeType) // "cha "
    public static let chat = MESSymbol(name: "chat", code: 0x69636374, type: AppleEvents.typeType) // "icct"
    public static let chatType = MESSymbol(name: "chatType", code: 0x49434374, type: AppleEvents.typeType) // "ICCt"
    public static let class_ = MESSymbol(name: "class_", code: 0x70636c73, type: AppleEvents.typeType) // "pcls"
    public static let closeable = MESSymbol(name: "closeable", code: 0x68636c62, type: AppleEvents.typeType) // "hclb"
    public static let color = MESSymbol(name: "color", code: 0x636f6c72, type: AppleEvents.typeType) // "colr"
    public static let colorTable = MESSymbol(name: "colorTable", code: 0x636c7274, type: AppleEvents.typeType) // "clrt"
    public static let connectionStatus = MESSymbol(name: "connectionStatus", code: 0x73737461, type: AppleEvents.typeType) // "ssta"
    public static let constant = MESSymbol(name: "constant", code: 0x656e756d, type: AppleEvents.typeType) // "enum"
    public static let dashStyle = MESSymbol(name: "dashStyle", code: 0x74646173, type: AppleEvents.typeType) // "tdas"
    public static let data = MESSymbol(name: "data", code: 0x74647461, type: AppleEvents.typeType) // "tdta"
    public static let date = MESSymbol(name: "date", code: 0x6c647420, type: AppleEvents.typeType) // "ldt "
    public static let December = MESSymbol(name: "December", code: 0x64656320, type: AppleEvents.typeType) // "dec "
    public static let decimalStruct = MESSymbol(name: "decimalStruct", code: 0x6465636d, type: AppleEvents.typeType) // "decm"
    public static let direction = MESSymbol(name: "direction", code: 0x46546472, type: AppleEvents.typeType) // "FTdr"
    public static let document = MESSymbol(name: "document", code: 0x646f6375, type: AppleEvents.typeType) // "docu"
    public static let doubleInteger = MESSymbol(name: "doubleInteger", code: 0x636f6d70, type: AppleEvents.typeType) // "comp"
    public static let enabled = MESSymbol(name: "enabled", code: 0x656e626c, type: AppleEvents.typeType) // "enbl"
    public static let encodedString = MESSymbol(name: "encodedString", code: 0x656e6373, type: AppleEvents.typeType) // "encs"
    public static let EPSPicture = MESSymbol(name: "EPSPicture", code: 0x45505320, type: AppleEvents.typeType) // "EPS "
    public static let February = MESSymbol(name: "February", code: 0x66656220, type: AppleEvents.typeType) // "feb "
    public static let file = MESSymbol(name: "file", code: 0x66696c65, type: AppleEvents.typeType) // "file"
    public static let fileProgress = MESSymbol(name: "fileProgress", code: 0x46547070, type: AppleEvents.typeType) // "FTpp"
    public static let fileRef = MESSymbol(name: "fileRef", code: 0x66737266, type: AppleEvents.typeType) // "fsrf"
    public static let fileSize = MESSymbol(name: "fileSize", code: 0x4654707a, type: AppleEvents.typeType) // "FTpz"
    public static let fileTransfer = MESSymbol(name: "fileTransfer", code: 0x746e6672, type: AppleEvents.typeType) // "tnfr"
    public static let fileURL = MESSymbol(name: "fileURL", code: 0x6675726c, type: AppleEvents.typeType) // "furl"
    public static let firstName = MESSymbol(name: "firstName", code: 0x7072666e, type: AppleEvents.typeType) // "prfn"
    public static let fixed = MESSymbol(name: "fixed", code: 0x66697864, type: AppleEvents.typeType) // "fixd"
    public static let fixedPoint = MESSymbol(name: "fixedPoint", code: 0x66706e74, type: AppleEvents.typeType) // "fpnt"
    public static let fixedRectangle = MESSymbol(name: "fixedRectangle", code: 0x66726374, type: AppleEvents.typeType) // "frct"
    public static let font = MESSymbol(name: "font", code: 0x666f6e74, type: AppleEvents.typeType) // "font"
    public static let Friday = MESSymbol(name: "Friday", code: 0x66726920, type: AppleEvents.typeType) // "fri "
    public static let frontmost = MESSymbol(name: "frontmost", code: 0x70697366, type: AppleEvents.typeType) // "pisf"
    public static let fullName = MESSymbol(name: "fullName", code: 0x7072466e, type: AppleEvents.typeType) // "prFn"
    public static let GIFPicture = MESSymbol(name: "GIFPicture", code: 0x47494666, type: AppleEvents.typeType) // "GIFf"
    public static let graphicText = MESSymbol(name: "graphicText", code: 0x63677478, type: AppleEvents.typeType) // "cgtx"
    public static let handle = MESSymbol(name: "handle", code: 0x686e646c, type: AppleEvents.typeType) // "hndl"
    public static let id = MESSymbol(name: "id", code: 0x49442020, type: AppleEvents.typeType) // "ID  "
    public static let idleTime = MESSymbol(name: "idleTime", code: 0x6964746d, type: AppleEvents.typeType) // "idtm"
    public static let image = MESSymbol(name: "image", code: 0x696d6141, type: AppleEvents.typeType) // "imaA"
    public static let index = MESSymbol(name: "index", code: 0x70696478, type: AppleEvents.typeType) // "pidx"
    public static let integer = MESSymbol(name: "integer", code: 0x6c6f6e67, type: AppleEvents.typeType) // "long"
    public static let internationalText = MESSymbol(name: "internationalText", code: 0x69747874, type: AppleEvents.typeType) // "itxt"
    public static let internationalWritingCode = MESSymbol(name: "internationalWritingCode", code: 0x696e746c, type: AppleEvents.typeType) // "intl"
    public static let invitation = MESSymbol(name: "invitation", code: 0x4943696e, type: AppleEvents.typeType) // "ICin"
    public static let invitationMessage = MESSymbol(name: "invitationMessage", code: 0x4976746d, type: AppleEvents.typeType) // "Ivtm"
    public static let item = MESSymbol(name: "item", code: 0x636f626a, type: AppleEvents.typeType) // "cobj"
    public static let January = MESSymbol(name: "January", code: 0x6a616e20, type: AppleEvents.typeType) // "jan "
    public static let joinState = MESSymbol(name: "joinState", code: 0x49434a53, type: AppleEvents.typeType) // "ICJS"
    public static let JPEGPicture = MESSymbol(name: "JPEGPicture", code: 0x4a504547, type: AppleEvents.typeType) // "JPEG"
    public static let July = MESSymbol(name: "July", code: 0x6a756c20, type: AppleEvents.typeType) // "jul "
    public static let June = MESSymbol(name: "June", code: 0x6a756e20, type: AppleEvents.typeType) // "jun "
    public static let kernelProcessID = MESSymbol(name: "kernelProcessID", code: 0x6b706964, type: AppleEvents.typeType) // "kpid"
    public static let largeReal = MESSymbol(name: "largeReal", code: 0x6c64626c, type: AppleEvents.typeType) // "ldbl"
    public static let lastName = MESSymbol(name: "lastName", code: 0x70724c6e, type: AppleEvents.typeType) // "prLn"
    public static let list = MESSymbol(name: "list", code: 0x6c697374, type: AppleEvents.typeType) // "list"
    public static let locationReference = MESSymbol(name: "locationReference", code: 0x696e736c, type: AppleEvents.typeType) // "insl"
    public static let longFixed = MESSymbol(name: "longFixed", code: 0x6c667864, type: AppleEvents.typeType) // "lfxd"
    public static let longFixedPoint = MESSymbol(name: "longFixedPoint", code: 0x6c667074, type: AppleEvents.typeType) // "lfpt"
    public static let longFixedRectangle = MESSymbol(name: "longFixedRectangle", code: 0x6c667263, type: AppleEvents.typeType) // "lfrc"
    public static let longPoint = MESSymbol(name: "longPoint", code: 0x6c706e74, type: AppleEvents.typeType) // "lpnt"
    public static let longRectangle = MESSymbol(name: "longRectangle", code: 0x6c726374, type: AppleEvents.typeType) // "lrct"
    public static let machine = MESSymbol(name: "machine", code: 0x6d616368, type: AppleEvents.typeType) // "mach"
    public static let machineLocation = MESSymbol(name: "machineLocation", code: 0x6d4c6f63, type: AppleEvents.typeType) // "mLoc"
    public static let machPort = MESSymbol(name: "machPort", code: 0x706f7274, type: AppleEvents.typeType) // "port"
    public static let March = MESSymbol(name: "March", code: 0x6d617220, type: AppleEvents.typeType) // "mar "
    public static let May = MESSymbol(name: "May", code: 0x6d617920, type: AppleEvents.typeType) // "may "
    public static let minimizable = MESSymbol(name: "minimizable", code: 0x69736d6e, type: AppleEvents.typeType) // "ismn"
    public static let minimized = MESSymbol(name: "minimized", code: 0x706d6e64, type: AppleEvents.typeType) // "pmnd"
    public static let modified = MESSymbol(name: "modified", code: 0x696d6f64, type: AppleEvents.typeType) // "imod"
    public static let Monday = MESSymbol(name: "Monday", code: 0x6d6f6e20, type: AppleEvents.typeType) // "mon "
    public static let name = MESSymbol(name: "name", code: 0x706e616d, type: AppleEvents.typeType) // "pnam"
    public static let November = MESSymbol(name: "November", code: 0x6e6f7620, type: AppleEvents.typeType) // "nov "
    public static let null = MESSymbol(name: "null", code: 0x6e756c6c, type: AppleEvents.typeType) // "null"
    public static let October = MESSymbol(name: "October", code: 0x6f637420, type: AppleEvents.typeType) // "oct "
    public static let paragraph = MESSymbol(name: "paragraph", code: 0x63706172, type: AppleEvents.typeType) // "cpar"
    public static let participants = MESSymbol(name: "participants", code: 0x49437074, type: AppleEvents.typeType) // "ICpt"
    public static let PICTPicture = MESSymbol(name: "PICTPicture", code: 0x50494354, type: AppleEvents.typeType) // "PICT"
    public static let pixelMapRecord = MESSymbol(name: "pixelMapRecord", code: 0x74706d6d, type: AppleEvents.typeType) // "tpmm"
    public static let point = MESSymbol(name: "point", code: 0x51447074, type: AppleEvents.typeType) // "QDpt"
    public static let processSerialNumber = MESSymbol(name: "processSerialNumber", code: 0x70736e20, type: AppleEvents.typeType) // "psn "
    public static let properties = MESSymbol(name: "properties", code: 0x70414c4c, type: AppleEvents.typeType) // "pALL"
    public static let property_ = MESSymbol(name: "property_", code: 0x70726f70, type: AppleEvents.typeType) // "prop"
    public static let real = MESSymbol(name: "real", code: 0x646f7562, type: AppleEvents.typeType) // "doub"
    public static let record = MESSymbol(name: "record", code: 0x7265636f, type: AppleEvents.typeType) // "reco"
    public static let reference = MESSymbol(name: "reference", code: 0x6f626a20, type: AppleEvents.typeType) // "obj "
    public static let resizable = MESSymbol(name: "resizable", code: 0x7072737a, type: AppleEvents.typeType) // "prsz"
    public static let RGB16Color = MESSymbol(name: "RGB16Color", code: 0x74723136, type: AppleEvents.typeType) // "tr16"
    public static let RGB96Color = MESSymbol(name: "RGB96Color", code: 0x74723936, type: AppleEvents.typeType) // "tr96"
    public static let RGBColor = MESSymbol(name: "RGBColor", code: 0x63524742, type: AppleEvents.typeType) // "cRGB"
    public static let richText = MESSymbol(name: "richText", code: 0x72746678, type: AppleEvents.typeType) // "rtfx"
    public static let rotation = MESSymbol(name: "rotation", code: 0x74726f74, type: AppleEvents.typeType) // "trot"
    public static let Saturday = MESSymbol(name: "Saturday", code: 0x73617420, type: AppleEvents.typeType) // "sat "
    public static let script = MESSymbol(name: "script", code: 0x73637074, type: AppleEvents.typeType) // "scpt"
    public static let scriptAccountLegacyName = MESSymbol(name: "scriptAccountLegacyName", code: 0x68616e64, type: AppleEvents.typeType) // "hand"
    public static let secure = MESSymbol(name: "secure", code: 0x49434372, type: AppleEvents.typeType) // "ICCr"
    public static let September = MESSymbol(name: "September", code: 0x73657020, type: AppleEvents.typeType) // "sep "
    public static let service = MESSymbol(name: "service", code: 0x69637376, type: AppleEvents.typeType) // "icsv"
    public static let serviceType = MESSymbol(name: "serviceType", code: 0x73747970, type: AppleEvents.typeType) // "styp"
    public static let shortInteger = MESSymbol(name: "shortInteger", code: 0x73686f72, type: AppleEvents.typeType) // "shor"
    public static let size = MESSymbol(name: "size", code: 0x7074737a, type: AppleEvents.typeType) // "ptsz"
    public static let smallReal = MESSymbol(name: "smallReal", code: 0x73696e67, type: AppleEvents.typeType) // "sing"
    public static let started = MESSymbol(name: "started", code: 0x49434343, type: AppleEvents.typeType) // "ICCC"
    public static let status = MESSymbol(name: "status", code: 0x73746174, type: AppleEvents.typeType) // "stat"
    public static let statusMessage = MESSymbol(name: "statusMessage", code: 0x736d7367, type: AppleEvents.typeType) // "smsg"
    public static let string = MESSymbol(name: "string", code: 0x54455854, type: AppleEvents.typeType) // "TEXT"
    public static let styledClipboardText = MESSymbol(name: "styledClipboardText", code: 0x7374796c, type: AppleEvents.typeType) // "styl"
    public static let styledText = MESSymbol(name: "styledText", code: 0x53545854, type: AppleEvents.typeType) // "STXT"
    public static let subject = MESSymbol(name: "subject", code: 0x49434373, type: AppleEvents.typeType) // "ICCs"
    public static let Sunday = MESSymbol(name: "Sunday", code: 0x73756e20, type: AppleEvents.typeType) // "sun "
    public static let textChat = MESSymbol(name: "textChat", code: 0x69637474, type: AppleEvents.typeType) // "ictt"
    public static let textStyleInfo = MESSymbol(name: "textStyleInfo", code: 0x74737479, type: AppleEvents.typeType) // "tsty"
    public static let Thursday = MESSymbol(name: "Thursday", code: 0x74687520, type: AppleEvents.typeType) // "thu "
    public static let TIFFPicture = MESSymbol(name: "TIFFPicture", code: 0x54494646, type: AppleEvents.typeType) // "TIFF"
    public static let transferStatus = MESSymbol(name: "transferStatus", code: 0x46547066, type: AppleEvents.typeType) // "FTpf"
    public static let Tuesday = MESSymbol(name: "Tuesday", code: 0x74756520, type: AppleEvents.typeType) // "tue "
    public static let typeClass = MESSymbol(name: "typeClass", code: 0x74797065, type: AppleEvents.typeType) // "type"
    public static let UnicodeText = MESSymbol(name: "UnicodeText", code: 0x75747874, type: AppleEvents.typeType) // "utxt"
    public static let unsignedDoubleInteger = MESSymbol(name: "unsignedDoubleInteger", code: 0x75636f6d, type: AppleEvents.typeType) // "ucom"
    public static let unsignedInteger = MESSymbol(name: "unsignedInteger", code: 0x6d61676e, type: AppleEvents.typeType) // "magn"
    public static let unsignedShortInteger = MESSymbol(name: "unsignedShortInteger", code: 0x75736872, type: AppleEvents.typeType) // "ushr"
    public static let updated = MESSymbol(name: "updated", code: 0x49434375, type: AppleEvents.typeType) // "ICCu"
    public static let UTF16Text = MESSymbol(name: "UTF16Text", code: 0x75743136, type: AppleEvents.typeType) // "ut16"
    public static let UTF8Text = MESSymbol(name: "UTF8Text", code: 0x75746638, type: AppleEvents.typeType) // "utf8"
    public static let version = MESSymbol(name: "version", code: 0x76657273, type: AppleEvents.typeType) // "vers"
    public static let visible = MESSymbol(name: "visible", code: 0x70766973, type: AppleEvents.typeType) // "pvis"
    public static let Wednesday = MESSymbol(name: "Wednesday", code: 0x77656420, type: AppleEvents.typeType) // "wed "
    public static let window = MESSymbol(name: "window", code: 0x6377696e, type: AppleEvents.typeType) // "cwin"
    public static let word = MESSymbol(name: "word", code: 0x63776f72, type: AppleEvents.typeType) // "cwor"
    public static let writingCode = MESSymbol(name: "writingCode", code: 0x70736374, type: AppleEvents.typeType) // "psct"
    public static let zoomable = MESSymbol(name: "zoomable", code: 0x69737a6d, type: AppleEvents.typeType) // "iszm"
    public static let zoomed = MESSymbol(name: "zoomed", code: 0x707a756d, type: AppleEvents.typeType) // "pzum"

    // Enumerators
    public static let ask = MESSymbol(name: "ask", code: 0x61736b20, type: AppleEvents.typeEnumerated) // "ask "
    public static let audio = MESSymbol(name: "audio", code: 0x49434161, type: AppleEvents.typeEnumerated) // "ICAa"
    public static let audioChat = MESSymbol(name: "audioChat", code: 0x61636f6e, type: AppleEvents.typeEnumerated) // "acon"
    public static let audioInvitation = MESSymbol(name: "audioInvitation", code: 0x61636f6e, type: AppleEvents.typeEnumerated) // "acon"
    public static let available = MESSymbol(name: "available", code: 0x6176616c, type: AppleEvents.typeEnumerated) // "aval"
    public static let away = MESSymbol(name: "away", code: 0x61776179, type: AppleEvents.typeEnumerated) // "away"
    public static let case_ = MESSymbol(name: "case_", code: 0x63617365, type: AppleEvents.typeEnumerated) // "case"
    public static let chatRoom = MESSymbol(name: "chatRoom", code: 0x49436372, type: AppleEvents.typeEnumerated) // "ICcr"
    public static let connected = MESSymbol(name: "connected", code: 0x636f6e6e, type: AppleEvents.typeEnumerated) // "conn"
    public static let connecting = MESSymbol(name: "connecting", code: 0x636f6e67, type: AppleEvents.typeEnumerated) // "cong"
    public static let diacriticals = MESSymbol(name: "diacriticals", code: 0x64696163, type: AppleEvents.typeEnumerated) // "diac"
    public static let directInstantMessage = MESSymbol(name: "directInstantMessage", code: 0x49436469, type: AppleEvents.typeEnumerated) // "ICdi"
    public static let disconnected = MESSymbol(name: "disconnected", code: 0x64636f6e, type: AppleEvents.typeEnumerated) // "dcon"
    public static let disconnecting = MESSymbol(name: "disconnecting", code: 0x64636e67, type: AppleEvents.typeEnumerated) // "dcng"
    public static let ended = MESSymbol(name: "ended", code: 0x4943416e, type: AppleEvents.typeEnumerated) // "ICAn"
    public static let expansion = MESSymbol(name: "expansion", code: 0x65787061, type: AppleEvents.typeEnumerated) // "expa"
    public static let failed = MESSymbol(name: "failed", code: 0x46547365, type: AppleEvents.typeEnumerated) // "FTse"
    public static let finalizing = MESSymbol(name: "finalizing", code: 0x4654737a, type: AppleEvents.typeEnumerated) // "FTsz"
    public static let finished = MESSymbol(name: "finished", code: 0x46547366, type: AppleEvents.typeEnumerated) // "FTsf"
    public static let hyphens = MESSymbol(name: "hyphens", code: 0x68797068, type: AppleEvents.typeEnumerated) // "hyph"
    public static let idle = MESSymbol(name: "idle", code: 0x69646c65, type: AppleEvents.typeEnumerated) // "idle"
    public static let iMessage = MESSymbol(name: "iMessage", code: 0x73696d73, type: AppleEvents.typeEnumerated) // "sims"
    public static let incoming = MESSymbol(name: "incoming", code: 0x46546963, type: AppleEvents.typeEnumerated) // "FTic"
    public static let instantMessage = MESSymbol(name: "instantMessage", code: 0x4943696d, type: AppleEvents.typeEnumerated) // "ICim"
    public static let invisible = MESSymbol(name: "invisible", code: 0x696e7673, type: AppleEvents.typeEnumerated) // "invs"
    public static let invited = MESSymbol(name: "invited", code: 0x49434169, type: AppleEvents.typeEnumerated) // "ICAi"
    public static let Jabber = MESSymbol(name: "Jabber", code: 0x736a6162, type: AppleEvents.typeEnumerated) // "sjab"
    public static let joined = MESSymbol(name: "joined", code: 0x49434a6a, type: AppleEvents.typeEnumerated) // "ICJj"
    public static let joining = MESSymbol(name: "joining", code: 0x49434a67, type: AppleEvents.typeEnumerated) // "ICJg"
    public static let multipersonAudio = MESSymbol(name: "multipersonAudio", code: 0x6d776163, type: AppleEvents.typeEnumerated) // "mwac"
    public static let multipersonVideo = MESSymbol(name: "multipersonVideo", code: 0x6d777663, type: AppleEvents.typeEnumerated) // "mwvc"
    public static let no = MESSymbol(name: "no", code: 0x6e6f2020, type: AppleEvents.typeEnumerated) // "no  "
    public static let notJoined = MESSymbol(name: "notJoined", code: 0x49434a63, type: AppleEvents.typeEnumerated) // "ICJc"
    public static let numericStrings = MESSymbol(name: "numericStrings", code: 0x6e756d65, type: AppleEvents.typeEnumerated) // "nume"
    public static let offline = MESSymbol(name: "offline", code: 0x6f66666c, type: AppleEvents.typeEnumerated) // "offl"
    public static let outgoing = MESSymbol(name: "outgoing", code: 0x46546f67, type: AppleEvents.typeEnumerated) // "FTog"
    public static let preparing = MESSymbol(name: "preparing", code: 0x46547370, type: AppleEvents.typeEnumerated) // "FTsp"
    public static let punctuation = MESSymbol(name: "punctuation", code: 0x70756e63, type: AppleEvents.typeEnumerated) // "punc"
    public static let textChatInvitation = MESSymbol(name: "textChatInvitation", code: 0x74636f6e, type: AppleEvents.typeEnumerated) // "tcon"
    public static let transferring = MESSymbol(name: "transferring", code: 0x46547367, type: AppleEvents.typeEnumerated) // "FTsg"
    public static let unknown = MESSymbol(name: "unknown", code: 0x756e6b6e, type: AppleEvents.typeEnumerated) // "unkn"
    public static let video = MESSymbol(name: "video", code: 0x49434176, type: AppleEvents.typeEnumerated) // "ICAv"
    public static let videoChat = MESSymbol(name: "videoChat", code: 0x76636f6e, type: AppleEvents.typeEnumerated) // "vcon"
    public static let videoInvitation = MESSymbol(name: "videoInvitation", code: 0x76636f6e, type: AppleEvents.typeEnumerated) // "vcon"
    public static let waiting = MESSymbol(name: "waiting", code: 0x46547377, type: AppleEvents.typeEnumerated) // "FTsw"
    public static let whitespace = MESSymbol(name: "whitespace", code: 0x77686974, type: AppleEvents.typeEnumerated) // "whit"
    public static let yes = MESSymbol(name: "yes", code: 0x79657320, type: AppleEvents.typeEnumerated) // "yes "
}

public typealias MES = MESSymbol // allows symbols to be written as (e.g.) MES.name instead of MESSymbol.name


/******************************************************************************/
// Specifier extensions; these add command methods and property/elements getters based on Messages.app terminology

public protocol MESCommand: SwiftAutomation.SpecifierProtocol {} // provides AE dispatch methods

// Command->Any will be bound when return type can't be inferred, else Command->T

extension MESCommand {
    @discardableResult public func accept(_ directParameter: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "accept", event: 0x69636874_61637074, // "ichtacpt"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func accept<T>(_ directParameter: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "accept", event: 0x69636874_61637074, // "ichtacpt"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
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
    @discardableResult public func activeChatMessageReceived(_ directParameter: Any = SwiftAutomation.noParameter,
            from: Any = SwiftAutomation.noParameter,
            for_: Any = SwiftAutomation.noParameter,
            with: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "activeChatMessageReceived", event: 0x69636874_68653138, // "ichthe18"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("from", 0x68657072, from), // "hepr"
                    ("for_", 0x68656374, for_), // "hect"
                    ("with", 0x68656564, with), // "heed"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func activeChatMessageReceived<T>(_ directParameter: Any = SwiftAutomation.noParameter,
            from: Any = SwiftAutomation.noParameter,
            for_: Any = SwiftAutomation.noParameter,
            with: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "activeChatMessageReceived", event: 0x69636874_68653138, // "ichthe18"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("from", 0x68657072, from), // "hepr"
                    ("for_", 0x68656374, for_), // "hect"
                    ("with", 0x68656564, with), // "heed"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func addressedChatRoomMessageReceived(_ directParameter: Any = SwiftAutomation.noParameter,
            from: Any = SwiftAutomation.noParameter,
            for_: Any = SwiftAutomation.noParameter,
            with: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "addressedChatRoomMessageReceived", event: 0x69636874_68653137, // "ichthe17"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("from", 0x68657072, from), // "hepr"
                    ("for_", 0x68656374, for_), // "hect"
                    ("with", 0x68656564, with), // "heed"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func addressedChatRoomMessageReceived<T>(_ directParameter: Any = SwiftAutomation.noParameter,
            from: Any = SwiftAutomation.noParameter,
            for_: Any = SwiftAutomation.noParameter,
            with: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "addressedChatRoomMessageReceived", event: 0x69636874_68653137, // "ichthe17"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("from", 0x68657072, from), // "hepr"
                    ("for_", 0x68656374, for_), // "hect"
                    ("with", 0x68656564, with), // "heed"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func addressedMessageReceived(_ directParameter: Any = SwiftAutomation.noParameter,
            from: Any = SwiftAutomation.noParameter,
            for_: Any = SwiftAutomation.noParameter,
            with: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "addressedMessageReceived", event: 0x69636874_68653139, // "ichthe19"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("from", 0x68657072, from), // "hepr"
                    ("for_", 0x68656374, for_), // "hect"
                    ("with", 0x68656564, with), // "heed"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func addressedMessageReceived<T>(_ directParameter: Any = SwiftAutomation.noParameter,
            from: Any = SwiftAutomation.noParameter,
            for_: Any = SwiftAutomation.noParameter,
            with: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "addressedMessageReceived", event: 0x69636874_68653139, // "ichthe19"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("from", 0x68657072, from), // "hepr"
                    ("for_", 0x68656374, for_), // "hect"
                    ("with", 0x68656564, with), // "heed"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func avChatEnded(_ directParameter: Any = SwiftAutomation.noParameter,
            with: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "avChatEnded", event: 0x69636874_68653133, // "ichthe13"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("with", 0x68656564, with), // "heed"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func avChatEnded<T>(_ directParameter: Any = SwiftAutomation.noParameter,
            with: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "avChatEnded", event: 0x69636874_68653133, // "ichthe13"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("with", 0x68656564, with), // "heed"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func avChatStarted(_ directParameter: Any = SwiftAutomation.noParameter,
            with: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "avChatStarted", event: 0x69636874_68653039, // "ichthe09"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("with", 0x68656564, with), // "heed"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func avChatStarted<T>(_ directParameter: Any = SwiftAutomation.noParameter,
            with: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "avChatStarted", event: 0x69636874_68653039, // "ichthe09"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("with", 0x68656564, with), // "heed"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func buddyAuthorizationRequested(_ directParameter: Any = SwiftAutomation.noParameter,
            with: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "buddyAuthorizationRequested", event: 0x69636874_68653134, // "ichthe14"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("with", 0x68656564, with), // "heed"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func buddyAuthorizationRequested<T>(_ directParameter: Any = SwiftAutomation.noParameter,
            with: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "buddyAuthorizationRequested", event: 0x69636874_68653134, // "ichthe14"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("with", 0x68656564, with), // "heed"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func buddyBecameAvailable(_ directParameter: Any = SwiftAutomation.noParameter,
            with: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "buddyBecameAvailable", event: 0x69636874_68653032, // "ichthe02"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("with", 0x68656564, with), // "heed"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func buddyBecameAvailable<T>(_ directParameter: Any = SwiftAutomation.noParameter,
            with: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "buddyBecameAvailable", event: 0x69636874_68653032, // "ichthe02"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("with", 0x68656564, with), // "heed"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func buddyBecameUnavailable(_ directParameter: Any = SwiftAutomation.noParameter,
            with: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "buddyBecameUnavailable", event: 0x69636874_68653033, // "ichthe03"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("with", 0x68656564, with), // "heed"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func buddyBecameUnavailable<T>(_ directParameter: Any = SwiftAutomation.noParameter,
            with: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "buddyBecameUnavailable", event: 0x69636874_68653033, // "ichthe03"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("with", 0x68656564, with), // "heed"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func chatRoomMessageReceived(_ directParameter: Any = SwiftAutomation.noParameter,
            from: Any = SwiftAutomation.noParameter,
            for_: Any = SwiftAutomation.noParameter,
            with: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "chatRoomMessageReceived", event: 0x69636874_68653132, // "ichthe12"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("from", 0x68657072, from), // "hepr"
                    ("for_", 0x68656374, for_), // "hect"
                    ("with", 0x68656564, with), // "heed"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func chatRoomMessageReceived<T>(_ directParameter: Any = SwiftAutomation.noParameter,
            from: Any = SwiftAutomation.noParameter,
            for_: Any = SwiftAutomation.noParameter,
            with: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "chatRoomMessageReceived", event: 0x69636874_68653132, // "ichthe12"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("from", 0x68657072, from), // "hepr"
                    ("for_", 0x68656374, for_), // "hect"
                    ("with", 0x68656564, with), // "heed"
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
    @discardableResult public func completedFileTransfer(_ directParameter: Any = SwiftAutomation.noParameter,
            with: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "completedFileTransfer", event: 0x69636874_68653131, // "ichthe11"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("with", 0x68656564, with), // "heed"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func completedFileTransfer<T>(_ directParameter: Any = SwiftAutomation.noParameter,
            with: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "completedFileTransfer", event: 0x69636874_68653131, // "ichthe11"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("with", 0x68656564, with), // "heed"
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
    @discardableResult public func decline(_ directParameter: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "decline", event: 0x69636874_64636c6e, // "ichtdcln"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func decline<T>(_ directParameter: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "decline", event: 0x69636874_64636c6e, // "ichtdcln"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
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
    @discardableResult public func invite(_ directParameter: Any = SwiftAutomation.noParameter,
            to: Any = SwiftAutomation.noParameter,
            withMessage: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "invite", event: 0x69636874_494e5654, // "ichtINVT"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x494e5661, to), // "INVa"
                    ("withMessage", 0x494e566d, withMessage), // "INVm"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func invite<T>(_ directParameter: Any = SwiftAutomation.noParameter,
            to: Any = SwiftAutomation.noParameter,
            withMessage: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "invite", event: 0x69636874_494e5654, // "ichtINVT"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x494e5661, to), // "INVa"
                    ("withMessage", 0x494e566d, withMessage), // "INVm"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func logIn(_ directParameter: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "logIn", event: 0x69636874_6c6f6769, // "ichtlogi"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func logIn<T>(_ directParameter: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "logIn", event: 0x69636874_6c6f6769, // "ichtlogi"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func loginFinished(_ directParameter: Any = SwiftAutomation.noParameter,
            for_: Any = SwiftAutomation.noParameter,
            with: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "loginFinished", event: 0x69636874_68653030, // "ichthe00"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("for_", 0x68656163, for_), // "heac"
                    ("with", 0x68656564, with), // "heed"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func loginFinished<T>(_ directParameter: Any = SwiftAutomation.noParameter,
            for_: Any = SwiftAutomation.noParameter,
            with: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "loginFinished", event: 0x69636874_68653030, // "ichthe00"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("for_", 0x68656163, for_), // "heac"
                    ("with", 0x68656564, with), // "heed"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func logOut(_ directParameter: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "logOut", event: 0x69636874_6c6f676f, // "ichtlogo"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func logOut<T>(_ directParameter: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "logOut", event: 0x69636874_6c6f676f, // "ichtlogo"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func logoutFinished(_ directParameter: Any = SwiftAutomation.noParameter,
            for_: Any = SwiftAutomation.noParameter,
            with: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "logoutFinished", event: 0x69636874_68653031, // "ichthe01"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("for_", 0x68656163, for_), // "heac"
                    ("with", 0x68656564, with), // "heed"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func logoutFinished<T>(_ directParameter: Any = SwiftAutomation.noParameter,
            for_: Any = SwiftAutomation.noParameter,
            with: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "logoutFinished", event: 0x69636874_68653031, // "ichthe01"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("for_", 0x68656163, for_), // "heac"
                    ("with", 0x68656564, with), // "heed"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func make(_ directParameter: Any = SwiftAutomation.noParameter,
            new: Any = SwiftAutomation.noParameter,
            at: Any = SwiftAutomation.noParameter,
            withContents: Any = SwiftAutomation.noParameter,
            withProperties: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "make", event: 0x636f7265_6372656c, // "corecrel"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("new", 0x6b6f636c, new), // "kocl"
                    ("at", 0x696e7368, at), // "insh"
                    ("withContents", 0x64617461, withContents), // "data"
                    ("withProperties", 0x70726474, withProperties), // "prdt"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func make<T>(_ directParameter: Any = SwiftAutomation.noParameter,
            new: Any = SwiftAutomation.noParameter,
            at: Any = SwiftAutomation.noParameter,
            withContents: Any = SwiftAutomation.noParameter,
            withProperties: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "make", event: 0x636f7265_6372656c, // "corecrel"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("new", 0x6b6f636c, new), // "kocl"
                    ("at", 0x696e7368, at), // "insh"
                    ("withContents", 0x64617461, withContents), // "data"
                    ("withProperties", 0x70726474, withProperties), // "prdt"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func messageReceived(_ directParameter: Any = SwiftAutomation.noParameter,
            from: Any = SwiftAutomation.noParameter,
            for_: Any = SwiftAutomation.noParameter,
            with: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "messageReceived", event: 0x69636874_68653034, // "ichthe04"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("from", 0x68657072, from), // "hepr"
                    ("for_", 0x68656374, for_), // "hect"
                    ("with", 0x68656564, with), // "heed"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func messageReceived<T>(_ directParameter: Any = SwiftAutomation.noParameter,
            from: Any = SwiftAutomation.noParameter,
            for_: Any = SwiftAutomation.noParameter,
            with: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "messageReceived", event: 0x69636874_68653034, // "ichthe04"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("from", 0x68657072, from), // "hepr"
                    ("for_", 0x68656374, for_), // "hect"
                    ("with", 0x68656564, with), // "heed"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func messageSent(_ directParameter: Any = SwiftAutomation.noParameter,
            for_: Any = SwiftAutomation.noParameter,
            with: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "messageSent", event: 0x69636874_68653035, // "ichthe05"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("for_", 0x68656374, for_), // "hect"
                    ("with", 0x68656564, with), // "heed"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func messageSent<T>(_ directParameter: Any = SwiftAutomation.noParameter,
            for_: Any = SwiftAutomation.noParameter,
            with: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "messageSent", event: 0x69636874_68653035, // "ichthe05"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("for_", 0x68656374, for_), // "hect"
                    ("with", 0x68656564, with), // "heed"
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
    @discardableResult public func receivedAudioInvitation(_ directParameter: Any = SwiftAutomation.noParameter,
            from: Any = SwiftAutomation.noParameter,
            for_: Any = SwiftAutomation.noParameter,
            with: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "receivedAudioInvitation", event: 0x69636874_68653037, // "ichthe07"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("from", 0x68657072, from), // "hepr"
                    ("for_", 0x68656374, for_), // "hect"
                    ("with", 0x68656564, with), // "heed"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func receivedAudioInvitation<T>(_ directParameter: Any = SwiftAutomation.noParameter,
            from: Any = SwiftAutomation.noParameter,
            for_: Any = SwiftAutomation.noParameter,
            with: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "receivedAudioInvitation", event: 0x69636874_68653037, // "ichthe07"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("from", 0x68657072, from), // "hepr"
                    ("for_", 0x68656374, for_), // "hect"
                    ("with", 0x68656564, with), // "heed"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func receivedFileTransferInvitation(_ directParameter: Any = SwiftAutomation.noParameter,
            with: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "receivedFileTransferInvitation", event: 0x69636874_68653130, // "ichthe10"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("with", 0x68656564, with), // "heed"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func receivedFileTransferInvitation<T>(_ directParameter: Any = SwiftAutomation.noParameter,
            with: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "receivedFileTransferInvitation", event: 0x69636874_68653130, // "ichthe10"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("with", 0x68656564, with), // "heed"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func receivedTextInvitation(_ directParameter: Any = SwiftAutomation.noParameter,
            from: Any = SwiftAutomation.noParameter,
            for_: Any = SwiftAutomation.noParameter,
            with: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "receivedTextInvitation", event: 0x69636874_68653036, // "ichthe06"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("from", 0x68657072, from), // "hepr"
                    ("for_", 0x68656374, for_), // "hect"
                    ("with", 0x68656564, with), // "heed"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func receivedTextInvitation<T>(_ directParameter: Any = SwiftAutomation.noParameter,
            from: Any = SwiftAutomation.noParameter,
            for_: Any = SwiftAutomation.noParameter,
            with: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "receivedTextInvitation", event: 0x69636874_68653036, // "ichthe06"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("from", 0x68657072, from), // "hepr"
                    ("for_", 0x68656374, for_), // "hect"
                    ("with", 0x68656564, with), // "heed"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func receivedVideoInvitation(_ directParameter: Any = SwiftAutomation.noParameter,
            from: Any = SwiftAutomation.noParameter,
            for_: Any = SwiftAutomation.noParameter,
            with: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "receivedVideoInvitation", event: 0x69636874_68653038, // "ichthe08"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("from", 0x68657072, from), // "hepr"
                    ("for_", 0x68656374, for_), // "hect"
                    ("with", 0x68656564, with), // "heed"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func receivedVideoInvitation<T>(_ directParameter: Any = SwiftAutomation.noParameter,
            from: Any = SwiftAutomation.noParameter,
            for_: Any = SwiftAutomation.noParameter,
            with: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "receivedVideoInvitation", event: 0x69636874_68653038, // "ichthe08"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("from", 0x68657072, from), // "hepr"
                    ("for_", 0x68656374, for_), // "hect"
                    ("with", 0x68656564, with), // "heed"
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
    @discardableResult public func requestRecording(_ directParameter: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "requestRecording", event: 0x69636874_73747272, // "ichtstrr"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func requestRecording<T>(_ directParameter: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "requestRecording", event: 0x69636874_73747272, // "ichtstrr"
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
            in_: Any = SwiftAutomation.noParameter,
            as_: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "save", event: 0x636f7265_73617665, // "coresave"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("in_", 0x6b66696c, in_), // "kfil"
                    ("as_", 0x666c7470, as_), // "fltp"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func save<T>(_ directParameter: Any = SwiftAutomation.noParameter,
            in_: Any = SwiftAutomation.noParameter,
            as_: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "save", event: 0x636f7265_73617665, // "coresave"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("in_", 0x6b66696c, in_), // "kfil"
                    ("as_", 0x666c7470, as_), // "fltp"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func send(_ directParameter: Any = SwiftAutomation.noParameter,
            to: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "send", event: 0x69636874_73656e64, // "ichtsend"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x544f2020, to), // "TO  "
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func send<T>(_ directParameter: Any = SwiftAutomation.noParameter,
            to: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "send", event: 0x69636874_73656e64, // "ichtsend"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x544f2020, to), // "TO  "
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
    @discardableResult public func showChatChooser(_ directParameter: Any = SwiftAutomation.noParameter,
            for_: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "showChatChooser", event: 0x69636874_69736363, // "ichtiscc"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("for_", 0x63637072, for_), // "ccpr"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func showChatChooser<T>(_ directParameter: Any = SwiftAutomation.noParameter,
            for_: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "showChatChooser", event: 0x69636874_69736363, // "ichtiscc"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("for_", 0x63637072, for_), // "ccpr"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func stopRecording(_ directParameter: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "stopRecording", event: 0x69636874_73747072, // "ichtstpr"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func stopRecording<T>(_ directParameter: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "stopRecording", event: 0x69636874_73747072, // "ichtstpr"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func storeRecentPicture(_ directParameter: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "storeRecentPicture", event: 0x69636874_73747270, // "ichtstrp"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func storeRecentPicture<T>(_ directParameter: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "storeRecentPicture", event: 0x69636874_73747270, // "ichtstrp"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func takeSnapshot(_ directParameter: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "takeSnapshot", event: 0x69636874_74767370, // "ichttvsp"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func takeSnapshot<T>(_ directParameter: Any = SwiftAutomation.noParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "takeSnapshot", event: 0x69636874_74767370, // "ichttvsp"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
}


public protocol MESObject: SwiftAutomation.ObjectSpecifierExtension, MESCommand {} // provides vars and methods for constructing specifiers

extension MESObject {

    // Properties
    public var active: MESItem {return self.property(0x49434376) as! MESItem} // "ICCv"
    public var activeAvChat: MESItem {return self.property(0x69616176) as! MESItem} // "iaav"
    public var bounds: MESItem {return self.property(0x70626e64) as! MESItem} // "pbnd"
    public var buddy: MESItem {return self.property(0x70726573) as! MESItem} // "pres"
    public var capabilities: MESItem {return self.property(0x63617073) as! MESItem} // "caps"
    public var chatType: MESItem {return self.property(0x49434374) as! MESItem} // "ICCt"
    public var class_: MESItem {return self.property(0x70636c73) as! MESItem} // "pcls"
    public var closeable: MESItem {return self.property(0x68636c62) as! MESItem} // "hclb"
    public var color: MESItem {return self.property(0x636f6c72) as! MESItem} // "colr"
    public var connectionStatus: MESItem {return self.property(0x73737461) as! MESItem} // "ssta"
    public var direction: MESItem {return self.property(0x46546472) as! MESItem} // "FTdr"
    public var document: MESItem {return self.property(0x646f6375) as! MESItem} // "docu"
    public var enabled: MESItem {return self.property(0x656e626c) as! MESItem} // "enbl"
    public var file: MESItem {return self.property(0x66696c65) as! MESItem} // "file"
    public var fileProgress: MESItem {return self.property(0x46547070) as! MESItem} // "FTpp"
    public var fileSize: MESItem {return self.property(0x4654707a) as! MESItem} // "FTpz"
    public var firstName: MESItem {return self.property(0x7072666e) as! MESItem} // "prfn"
    public var font: MESItem {return self.property(0x666f6e74) as! MESItem} // "font"
    public var frontmost: MESItem {return self.property(0x70697366) as! MESItem} // "pisf"
    public var fullName: MESItem {return self.property(0x7072466e) as! MESItem} // "prFn"
    public var handle: MESItem {return self.property(0x686e646c) as! MESItem} // "hndl"
    public var id: MESItem {return self.property(0x49442020) as! MESItem} // "ID  "
    public var idleTime: MESItem {return self.property(0x6964746d) as! MESItem} // "idtm"
    public var image: MESItem {return self.property(0x696d6141) as! MESItem} // "imaA"
    public var index: MESItem {return self.property(0x70696478) as! MESItem} // "pidx"
    public var invitation: MESItem {return self.property(0x4943696e) as! MESItem} // "ICin"
    public var invitationMessage: MESItem {return self.property(0x4976746d) as! MESItem} // "Ivtm"
    public var joinState: MESItem {return self.property(0x49434a53) as! MESItem} // "ICJS"
    public var lastName: MESItem {return self.property(0x70724c6e) as! MESItem} // "prLn"
    public var minimizable: MESItem {return self.property(0x69736d6e) as! MESItem} // "ismn"
    public var minimized: MESItem {return self.property(0x706d6e64) as! MESItem} // "pmnd"
    public var modified: MESItem {return self.property(0x696d6f64) as! MESItem} // "imod"
    public var name: MESItem {return self.property(0x706e616d) as! MESItem} // "pnam"
    public var participants: MESItem {return self.property(0x49437074) as! MESItem} // "ICpt"
    public var properties: MESItem {return self.property(0x70414c4c) as! MESItem} // "pALL"
    public var resizable: MESItem {return self.property(0x7072737a) as! MESItem} // "prsz"
    public var scriptAccountLegacyName: MESItem {return self.property(0x68616e64) as! MESItem} // "hand"
    public var secure: MESItem {return self.property(0x49434372) as! MESItem} // "ICCr"
    public var service: MESItem {return self.property(0x69637376) as! MESItem} // "icsv"
    public var serviceType: MESItem {return self.property(0x73747970) as! MESItem} // "styp"
    public var size: MESItem {return self.property(0x7074737a) as! MESItem} // "ptsz"
    public var started: MESItem {return self.property(0x49434343) as! MESItem} // "ICCC"
    public var status: MESItem {return self.property(0x73746174) as! MESItem} // "stat"
    public var statusMessage: MESItem {return self.property(0x736d7367) as! MESItem} // "smsg"
    public var subject: MESItem {return self.property(0x49434373) as! MESItem} // "ICCs"
    public var transferStatus: MESItem {return self.property(0x46547066) as! MESItem} // "FTpf"
    public var updated: MESItem {return self.property(0x49434375) as! MESItem} // "ICCu"
    public var version: MESItem {return self.property(0x76657273) as! MESItem} // "vers"
    public var visible: MESItem {return self.property(0x70766973) as! MESItem} // "pvis"
    public var zoomable: MESItem {return self.property(0x69737a6d) as! MESItem} // "iszm"
    public var zoomed: MESItem {return self.property(0x707a756d) as! MESItem} // "pzum"

    // Elements
    public var applications: MESItems {return self.elements(0x63617070) as! MESItems} // "capp"
    public var attachments: MESItems {return self.elements(0x61747473) as! MESItems} // "atts"
    public var attributeRuns: MESItems {return self.elements(0x63617472) as! MESItems} // "catr"
    public var authorizationRequests: MESItems {return self.elements(0x62617271) as! MESItems} // "barq"
    public var buddies: MESItems {return self.elements(0x70726573) as! MESItems} // "pres"
    public var characters: MESItems {return self.elements(0x63686120) as! MESItems} // "cha "
    public var chats: MESItems {return self.elements(0x69636374) as! MESItems} // "icct"
    public var colors: MESItems {return self.elements(0x636f6c72) as! MESItems} // "colr"
    public var documents: MESItems {return self.elements(0x646f6375) as! MESItems} // "docu"
    public var fileTransfers: MESItems {return self.elements(0x746e6672) as! MESItems} // "tnfr"
    public var items: MESItems {return self.elements(0x636f626a) as! MESItems} // "cobj"
    public var paragraphs: MESItems {return self.elements(0x63706172) as! MESItems} // "cpar"
    public var richText: MESItems {return self.elements(0x72746678) as! MESItems} // "rtfx"
    public var services: MESItems {return self.elements(0x69637376) as! MESItems} // "icsv"
    public var textChats: MESItems {return self.elements(0x69637474) as! MESItems} // "ictt"
    public var windows: MESItems {return self.elements(0x6377696e) as! MESItems} // "cwin"
    public var words: MESItems {return self.elements(0x63776f72) as! MESItems} // "cwor"
}


/******************************************************************************/
// Specifier subclasses add app-specific extensions

// beginning/end/before/after
public class MESInsertion: SwiftAutomation.InsertionSpecifier, MESCommand {}


// property/by-index/by-name/by-id/previous/next/first/middle/last/any
public class MESItem: SwiftAutomation.ObjectSpecifier, MESObject {
    public typealias InsertionSpecifierType = MESInsertion
    public typealias ObjectSpecifierType = MESItem
    public typealias MultipleObjectSpecifierType = MESItems
}

// by-range/by-test/all
public class MESItems: MESItem, SwiftAutomation.MultipleObjectSpecifierExtension {}

// App/Con/Its
public class MESRoot: SwiftAutomation.RootSpecifier, MESObject, SwiftAutomation.RootSpecifierExtension {
    public typealias InsertionSpecifierType = MESInsertion
    public typealias ObjectSpecifierType = MESItem
    public typealias MultipleObjectSpecifierType = MESItems
    public override class var untargetedAppData: SwiftAutomation.AppData { return _untargetedAppData }
}

// Application
public class Messages: MESRoot, SwiftAutomation.Application {
    public convenience init(launchOptions: SwiftAutomation.LaunchOptions = SwiftAutomation.defaultLaunchOptions, relaunchMode: SwiftAutomation.RelaunchMode = SwiftAutomation.defaultRelaunchMode) {
        self.init(rootObject: SwiftAutomation.appRootDesc, appData: Swift.type(of:self).untargetedAppData.targetedCopy(
                  .bundleIdentifier("com.apple.iChat", true), launchOptions: launchOptions, relaunchMode: relaunchMode))
    }
}

// App/Con/Its root objects used to construct untargeted specifiers; these can be used to construct specifiers for use in commands, though cannot send commands themselves

public let MESApp = _untargetedAppData.app as! MESRoot
public let MESCon = _untargetedAppData.con as! MESRoot
public let MESIts = _untargetedAppData.its as! MESRoot


/******************************************************************************/
// Static types

public typealias MESRecord = [MESSymbol:Any] // default Swift type for AERecordDescs






