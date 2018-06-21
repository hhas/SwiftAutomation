//
//  DVDPlayerGlue.swift
//  DVD Player.app 5.8
//  SwiftAutomation.framework 0.1.0
//  `aeglue -S 'DVD Player.app'`
//


import Foundation
import SwiftAutomation


/******************************************************************************/
// Create an untargeted AppData instance for use in App, Con, Its roots,
// and in Application initializers to create targeted AppData instances.

private let _specifierFormatter = SwiftAutomation.SpecifierFormatter(applicationClassName: "DVDPlayer",
                                                     classNamePrefix: "DVD",
                                                     typeNames: [
                                                                     0x70716f6d: "activeDvdMenu", // "pqom"
                                                                     0x616c6973: "alias", // "alis"
                                                                     0x7063616e: "angle", // "pcan"
                                                                     0x65616e67: "angle", // "eang"
                                                                     0x2a2a2a2a: "anything", // "****"
                                                                     0x7061696e: "appInitializing", // "pain"
                                                                     0x63617070: "application", // "capp"
                                                                     0x62756e64: "applicationBundleID", // "bund"
                                                                     0x7369676e: "applicationSignature", // "sign"
                                                                     0x6170726c: "applicationURL", // "aprl"
                                                                     0x61707220: "April", // "apr\0x20"
                                                                     0x61736b20: "ask", // "ask\0x20"
                                                                     0x65617564: "audio", // "eaud"
                                                                     0x70616d75: "audioMuted", // "pamu"
                                                                     0x70636174: "audioTrack", // "pcat"
                                                                     0x7061766c: "audioVolume", // "pavl"
                                                                     0x61756720: "August", // "aug\0x20"
                                                                     0x7061616e: "availableAngles", // "paan"
                                                                     0x70616175: "availableAudioTracks", // "paau"
                                                                     0x706e626b: "availableBookmarks", // "pnbk"
                                                                     0x70616368: "availableChapters", // "pach"
                                                                     0x70617362: "availableSubtitles", // "pasb"
                                                                     0x70617474: "availableTitles", // "patt"
                                                                     0x706e7663: "availableVideoClips", // "pnvc"
                                                                     0x62657374: "best", // "best"
                                                                     0x626d726b: "bookmarkData", // "bmrk"
                                                                     0x70626b6c: "bookmarkList", // "pbkl"
                                                                     0x626f6f6c: "boolean", // "bool"
                                                                     0x71647274: "boundingRectangle", // "qdrt"
                                                                     0x63617365: "case_", // "case"
                                                                     0x70636368: "chapter", // "pcch"
                                                                     0x70636c73: "class_", // "pcls"
                                                                     0x7069636d: "clipMode", // "picm"
                                                                     0x65636c73: "closed", // "ecls"
                                                                     0x7063636f: "closedCaptioning", // "pcco"
                                                                     0x70636374: "closedCaptioningDisplay", // "pcct"
                                                                     0x636c7274: "colorTable", // "clrt"
                                                                     0x656e756d: "constant", // "enum"
                                                                     0x7063626e: "controllerBounds", // "pcbn"
                                                                     0x70636472: "controllerDrawer", // "pcdr"
                                                                     0x70636f72: "controllerOrientation", // "pcor"
                                                                     0x70637073: "controllerPosition", // "pcps"
                                                                     0x70637363: "controllerScreenBounds", // "pcsc"
                                                                     0x70637673: "controllerVisibility", // "pcvs"
                                                                     0x74646173: "dashStyle", // "tdas"
                                                                     0x74647461: "data", // "tdta"
                                                                     0x6c647420: "date", // "ldt\0x20"
                                                                     0x64656320: "December", // "dec\0x20"
                                                                     0x6465636d: "decimalStruct", // "decm"
                                                                     0x64696163: "diacriticals", // "diac"
                                                                     0x7064736d: "disableStatusWindow", // "pdsm"
                                                                     0x70647374: "displayingSubtitle", // "pdst"
                                                                     0x65646273: "double", // "edbs"
                                                                     0x636f6d70: "doubleInteger", // "comp"
                                                                     0x65646e6b: "downArrowKey", // "ednk"
                                                                     0x7071646d: "dvdMenuActive", // "pqdm"
                                                                     0x7073636e: "dvdScanRate", // "pscn"
                                                                     0x70717374: "dvdState", // "pqst"
                                                                     0x7078746d: "elapsedExtendedTime", // "pxtm"
                                                                     0x7065746d: "elapsedTime", // "petm"
                                                                     0x656e6373: "encodedString", // "encs"
                                                                     0x65656e6b: "enterKey", // "eenk"
                                                                     0x45505320: "EPSPicture", // "EPS\0x20"
                                                                     0x65787061: "expansion", // "expa"
                                                                     0x7078626b: "extendedBookmarks", // "pxbk"
                                                                     0x65787465: "extendedReal", // "exte"
                                                                     0x70787663: "extendedVideoClips", // "pxvc"
                                                                     0x66656220: "February", // "feb\0x20"
                                                                     0x66737266: "fileRef", // "fsrf"
                                                                     0x66737320: "fileSpecification", // "fss\0x20"
                                                                     0x6675726c: "fileURL", // "furl"
                                                                     0x66697864: "fixed", // "fixd"
                                                                     0x66706e74: "fixedPoint", // "fpnt"
                                                                     0x66726374: "fixedRectangle", // "frct"
                                                                     0x66726920: "Friday", // "fri\0x20"
                                                                     0x47494666: "GIFPicture", // "GIFf"
                                                                     0x63677478: "graphicText", // "cgtx"
                                                                     0x65686673: "half", // "ehfs"
                                                                     0x7064626b: "hasDefaultBookmark", // "pdbk"
                                                                     0x706c7062: "hasLastPlayBookmark", // "plpb"
                                                                     0x7071686d: "hasMedia", // "pqhm"
                                                                     0x706d7063: "hasMultiplePlaybackChoice", // "pmpc"
                                                                     0x65686f72: "horizontal", // "ehor"
                                                                     0x68797068: "hyphens", // "hyph"
                                                                     0x49442020: "id", // "ID\0x20\0x20"
                                                                     0x65736964: "idle", // "esid"
                                                                     0x7069626e: "infoBounds", // "pibn"
                                                                     0x70697073: "infoPosition", // "pips"
                                                                     0x70697363: "infoScreenBounds", // "pisc"
                                                                     0x70697463: "infoTextColor", // "pitc"
                                                                     0x70696e74: "infoType", // "pint"
                                                                     0x70697673: "infoVisibility", // "pivs"
                                                                     0x6c6f6e67: "integer", // "long"
                                                                     0x706f7672: "interactionOverride", // "povr"
                                                                     0x69747874: "internationalText", // "itxt"
                                                                     0x696e746c: "internationalWritingCode", // "intl"
                                                                     0x636f626a: "item", // "cobj"
                                                                     0x6a616e20: "January", // "jan\0x20"
                                                                     0x4a504547: "JPEGPicture", // "JPEG"
                                                                     0x6a756c20: "July", // "jul\0x20"
                                                                     0x6a756e20: "June", // "jun\0x20"
                                                                     0x6b706964: "kernelProcessID", // "kpid"
                                                                     0x6c64626c: "largeReal", // "ldbl"
                                                                     0x656c666b: "leftArrowKey", // "elfk"
                                                                     0x6c697374: "list", // "list"
                                                                     0x696e736c: "locationReference", // "insl"
                                                                     0x6c667864: "longFixed", // "lfxd"
                                                                     0x6c667074: "longFixedPoint", // "lfpt"
                                                                     0x6c667263: "longFixedRectangle", // "lfrc"
                                                                     0x6c706e74: "longPoint", // "lpnt"
                                                                     0x6c726374: "longRectangle", // "lrct"
                                                                     0x70766c70: "loopVideoClip", // "pvlp"
                                                                     0x6d616368: "machine", // "mach"
                                                                     0x6d4c6f63: "machineLocation", // "mLoc"
                                                                     0x706f7274: "machPort", // "port"
                                                                     0x656d616e: "main", // "eman"
                                                                     0x6d617220: "March", // "mar\0x20"
                                                                     0x656d7873: "max", // "emxs"
                                                                     0x6d617920: "May", // "may\0x20"
                                                                     0x6d6f6e20: "Monday", // "mon\0x20"
                                                                     0x6e6f2020: "no", // "no\0x20\0x20"
                                                                     0x656e6f6e: "none", // "enon"
                                                                     0x656e6d73: "normal", // "enms"
                                                                     0x6e6f7620: "November", // "nov\0x20"
                                                                     0x6e756c6c: "null", // "null"
                                                                     0x6e756d65: "numericStrings", // "nume"
                                                                     0x6f637420: "October", // "oct\0x20"
                                                                     0x656f706e: "open", // "eopn"
                                                                     0x65636376: "overVideo", // "eccv"
                                                                     0x65737061: "paused", // "espa"
                                                                     0x50494354: "PICTPicture", // "PICT"
                                                                     0x74706d6d: "pixelMapRecord", // "tpmm"
                                                                     0x6573706c: "playing", // "espl"
                                                                     0x65737073: "playingStill", // "esps"
                                                                     0x51447074: "point", // "QDpt"
                                                                     0x70646d61: "privateMenuActionTicks", // "pdma"
                                                                     0x7064706d: "privateMenuPaused", // "pdpm"
                                                                     0x70736e20: "processSerialNumber", // "psn\0x20"
                                                                     0x70414c4c: "properties", // "pALL"
                                                                     0x70726f70: "property_", // "prop"
                                                                     0x65707474: "ptt", // "eptt"
                                                                     0x70756e63: "punctuation", // "punc"
                                                                     0x646f7562: "real", // "doub"
                                                                     0x7265636f: "record", // "reco"
                                                                     0x6f626a20: "reference", // "obj\0x20"
                                                                     0x7078726d: "remainingExtendedTime", // "pxrm"
                                                                     0x7072746d: "remainingTime", // "prtm"
                                                                     0x65677274: "returnToDvd", // "egrt"
                                                                     0x74723136: "RGB16Color", // "tr16"
                                                                     0x74723936: "RGB96Color", // "tr96"
                                                                     0x63524742: "RGBColor", // "cRGB"
                                                                     0x6572746b: "rightArrowKey", // "ertk"
                                                                     0x74726f74: "rotation", // "trot"
                                                                     0x73617420: "Saturday", // "sat\0x20"
                                                                     0x65737363: "scanning", // "essc"
                                                                     0x73637074: "script", // "scpt"
                                                                     0x65636377: "separateWindow", // "eccw"
                                                                     0x73657020: "September", // "sep\0x20"
                                                                     0x73686f72: "shortInteger", // "shor"
                                                                     0x73696e67: "smallReal", // "sing"
                                                                     0x65737464: "standard", // "estd"
                                                                     0x65737374: "stopped", // "esst"
                                                                     0x54455854: "string", // "TEXT"
                                                                     0x7374796c: "styledClipboardText", // "styl"
                                                                     0x53545854: "styledText", // "STXT"
                                                                     0x65737562: "subpicture", // "esub"
                                                                     0x70637362: "subtitle", // "pcsb"
                                                                     0x73756e20: "Sunday", // "sun\0x20"
                                                                     0x74737479: "textStyleInfo", // "tsty"
                                                                     0x74687520: "Thursday", // "thu\0x20"
                                                                     0x54494646: "TIFFPicture", // "TIFF"
                                                                     0x70637474: "title", // "pctt"
                                                                     0x65746974: "title", // "etit"
                                                                     0x7078746c: "titleExtendedLength", // "pxtl"
                                                                     0x7074746d: "titleLength", // "pttm"
                                                                     0x6567616e: "toAngleMenu", // "egan"
                                                                     0x65676175: "toAudioMenu", // "egau"
                                                                     0x65676264: "toBeginningOfDisc", // "egbd"
                                                                     0x65676462: "toDefaultBookmark", // "egdb"
                                                                     0x65676c62: "toLastPlayBookmark", // "eglb"
                                                                     0x65676d6d: "toMainMenu", // "egmm"
                                                                     0x65677074: "toPttMenu", // "egpt"
                                                                     0x65677362: "toSubpictureMenu", // "egsb"
                                                                     0x6567746d: "toTitleMenu", // "egtm"
                                                                     0x74756520: "Tuesday", // "tue\0x20"
                                                                     0x74797065: "typeClass", // "type"
                                                                     0x75747874: "UnicodeText", // "utxt"
                                                                     0x75636f6d: "unsignedDoubleInteger", // "ucom"
                                                                     0x6d61676e: "unsignedInteger", // "magn"
                                                                     0x75736872: "unsignedShortInteger", // "ushr"
                                                                     0x6575706b: "upArrowKey", // "eupk"
                                                                     0x75743136: "UTF16Text", // "ut16"
                                                                     0x75746638: "UTF8Text", // "utf8"
                                                                     0x76657273: "version", // "vers"
                                                                     0x70767273: "version_", // "pvrs"
                                                                     0x65766572: "vertical", // "ever"
                                                                     0x7076636c: "videoClipList", // "pvcl"
                                                                     0x7076626e: "viewerBounds", // "pvbn"
                                                                     0x70766673: "viewerFullScreen", // "pvfs"
                                                                     0x70666d6f: "viewerFullScreenMenuOverride", // "pfmo"
                                                                     0x70767073: "viewerPosition", // "pvps"
                                                                     0x70767363: "viewerScreenBounds", // "pvsc"
                                                                     0x7076737a: "viewerSize", // "pvsz"
                                                                     0x70767673: "viewerVisibility", // "pvvs"
                                                                     0x77656420: "Wednesday", // "wed\0x20"
                                                                     0x77686974: "whitespace", // "whit"
                                                                     0x65776964: "wide", // "ewid"
                                                                     0x70736374: "writingCode", // "psct"
                                                                     0x65733136: "x16", // "es16"
                                                                     0x65733278: "x2", // "es2x"
                                                                     0x65733332: "x32", // "es32"
                                                                     0x65733478: "x4", // "es4x"
                                                                     0x65733878: "x8", // "es8x"
                                                                     0x79657320: "yes", // "yes\0x20"
                                                     ],
                                                     propertyNames: [
                                                                     0x70716f6d: "activeDvdMenu", // "pqom"
                                                                     0x7063616e: "angle", // "pcan"
                                                                     0x7061696e: "appInitializing", // "pain"
                                                                     0x70616d75: "audioMuted", // "pamu"
                                                                     0x70636174: "audioTrack", // "pcat"
                                                                     0x7061766c: "audioVolume", // "pavl"
                                                                     0x7061616e: "availableAngles", // "paan"
                                                                     0x70616175: "availableAudioTracks", // "paau"
                                                                     0x706e626b: "availableBookmarks", // "pnbk"
                                                                     0x70616368: "availableChapters", // "pach"
                                                                     0x70617362: "availableSubtitles", // "pasb"
                                                                     0x70617474: "availableTitles", // "patt"
                                                                     0x706e7663: "availableVideoClips", // "pnvc"
                                                                     0x70626b6c: "bookmarkList", // "pbkl"
                                                                     0x70636368: "chapter", // "pcch"
                                                                     0x70636c73: "class_", // "pcls"
                                                                     0x7069636d: "clipMode", // "picm"
                                                                     0x7063636f: "closedCaptioning", // "pcco"
                                                                     0x70636374: "closedCaptioningDisplay", // "pcct"
                                                                     0x7063626e: "controllerBounds", // "pcbn"
                                                                     0x70636472: "controllerDrawer", // "pcdr"
                                                                     0x70636f72: "controllerOrientation", // "pcor"
                                                                     0x70637073: "controllerPosition", // "pcps"
                                                                     0x70637363: "controllerScreenBounds", // "pcsc"
                                                                     0x70637673: "controllerVisibility", // "pcvs"
                                                                     0x7064736d: "disableStatusWindow", // "pdsm"
                                                                     0x70647374: "displayingSubtitle", // "pdst"
                                                                     0x7071646d: "dvdMenuActive", // "pqdm"
                                                                     0x7073636e: "dvdScanRate", // "pscn"
                                                                     0x70717374: "dvdState", // "pqst"
                                                                     0x7078746d: "elapsedExtendedTime", // "pxtm"
                                                                     0x7065746d: "elapsedTime", // "petm"
                                                                     0x7078626b: "extendedBookmarks", // "pxbk"
                                                                     0x70787663: "extendedVideoClips", // "pxvc"
                                                                     0x7064626b: "hasDefaultBookmark", // "pdbk"
                                                                     0x706c7062: "hasLastPlayBookmark", // "plpb"
                                                                     0x7071686d: "hasMedia", // "pqhm"
                                                                     0x706d7063: "hasMultiplePlaybackChoice", // "pmpc"
                                                                     0x49442020: "id", // "ID\0x20\0x20"
                                                                     0x7069626e: "infoBounds", // "pibn"
                                                                     0x70697073: "infoPosition", // "pips"
                                                                     0x70697363: "infoScreenBounds", // "pisc"
                                                                     0x70697463: "infoTextColor", // "pitc"
                                                                     0x70696e74: "infoType", // "pint"
                                                                     0x70697673: "infoVisibility", // "pivs"
                                                                     0x706f7672: "interactionOverride", // "povr"
                                                                     0x70766c70: "loopVideoClip", // "pvlp"
                                                                     0x70646d61: "privateMenuActionTicks", // "pdma"
                                                                     0x7064706d: "privateMenuPaused", // "pdpm"
                                                                     0x70414c4c: "properties", // "pALL"
                                                                     0x7078726d: "remainingExtendedTime", // "pxrm"
                                                                     0x7072746d: "remainingTime", // "prtm"
                                                                     0x70637362: "subtitle", // "pcsb"
                                                                     0x70637474: "title", // "pctt"
                                                                     0x7078746c: "titleExtendedLength", // "pxtl"
                                                                     0x7074746d: "titleLength", // "pttm"
                                                                     0x70767273: "version_", // "pvrs"
                                                                     0x7076636c: "videoClipList", // "pvcl"
                                                                     0x7076626e: "viewerBounds", // "pvbn"
                                                                     0x70766673: "viewerFullScreen", // "pvfs"
                                                                     0x70666d6f: "viewerFullScreenMenuOverride", // "pfmo"
                                                                     0x70767073: "viewerPosition", // "pvps"
                                                                     0x70767363: "viewerScreenBounds", // "pvsc"
                                                                     0x7076737a: "viewerSize", // "pvsz"
                                                                     0x70767673: "viewerVisibility", // "pvvs"
                                                     ],
                                                     elementsNames: [
                                                                     0x63617070: "applications", // "capp"
                                                                     0x636f626a: "items", // "cobj"
                                                     ])

private let _glueClasses = SwiftAutomation.GlueClasses(insertionSpecifierType: DVDInsertion.self,
                                       objectSpecifierType: DVDItem.self,
                                       multiObjectSpecifierType: DVDItems.self,
                                       rootSpecifierType: DVDRoot.self,
                                       applicationType: DVDPlayer.self,
                                       symbolType: DVDSymbol.self,
                                       formatter: _specifierFormatter)

private let _untargetedAppData = SwiftAutomation.AppData(glueClasses: _glueClasses)


/******************************************************************************/
// Symbol subclass defines static type/enum/property constants based on DVD Player.app terminology

public class DVDSymbol: SwiftAutomation.Symbol {

    override public var typeAliasName: String {return "DVD"}

    public override class func symbol(code: OSType, type: OSType = typeType, descriptor: NSAppleEventDescriptor? = nil) -> DVDSymbol {
        switch (code) {
        case 0x70716f6d: return self.activeDvdMenu // "pqom"
        case 0x616c6973: return self.alias // "alis"
        case 0x7063616e: return self.angle // "pcan"
        case 0x65616e67: return self.angle // "eang"
        case 0x2a2a2a2a: return self.anything // "****"
        case 0x7061696e: return self.appInitializing // "pain"
        case 0x63617070: return self.application // "capp"
        case 0x62756e64: return self.applicationBundleID // "bund"
        case 0x7369676e: return self.applicationSignature // "sign"
        case 0x6170726c: return self.applicationURL // "aprl"
        case 0x61707220: return self.April // "apr\0x20"
        case 0x61736b20: return self.ask // "ask\0x20"
        case 0x65617564: return self.audio // "eaud"
        case 0x70616d75: return self.audioMuted // "pamu"
        case 0x70636174: return self.audioTrack // "pcat"
        case 0x7061766c: return self.audioVolume // "pavl"
        case 0x61756720: return self.August // "aug\0x20"
        case 0x7061616e: return self.availableAngles // "paan"
        case 0x70616175: return self.availableAudioTracks // "paau"
        case 0x706e626b: return self.availableBookmarks // "pnbk"
        case 0x70616368: return self.availableChapters // "pach"
        case 0x70617362: return self.availableSubtitles // "pasb"
        case 0x70617474: return self.availableTitles // "patt"
        case 0x706e7663: return self.availableVideoClips // "pnvc"
        case 0x62657374: return self.best // "best"
        case 0x626d726b: return self.bookmarkData // "bmrk"
        case 0x70626b6c: return self.bookmarkList // "pbkl"
        case 0x626f6f6c: return self.boolean // "bool"
        case 0x71647274: return self.boundingRectangle // "qdrt"
        case 0x63617365: return self.case_ // "case"
        case 0x70636368: return self.chapter // "pcch"
        case 0x70636c73: return self.class_ // "pcls"
        case 0x7069636d: return self.clipMode // "picm"
        case 0x65636c73: return self.closed // "ecls"
        case 0x7063636f: return self.closedCaptioning // "pcco"
        case 0x70636374: return self.closedCaptioningDisplay // "pcct"
        case 0x636c7274: return self.colorTable // "clrt"
        case 0x656e756d: return self.constant // "enum"
        case 0x7063626e: return self.controllerBounds // "pcbn"
        case 0x70636472: return self.controllerDrawer // "pcdr"
        case 0x70636f72: return self.controllerOrientation // "pcor"
        case 0x70637073: return self.controllerPosition // "pcps"
        case 0x70637363: return self.controllerScreenBounds // "pcsc"
        case 0x70637673: return self.controllerVisibility // "pcvs"
        case 0x74646173: return self.dashStyle // "tdas"
        case 0x74647461: return self.data // "tdta"
        case 0x6c647420: return self.date // "ldt\0x20"
        case 0x64656320: return self.December // "dec\0x20"
        case 0x6465636d: return self.decimalStruct // "decm"
        case 0x64696163: return self.diacriticals // "diac"
        case 0x7064736d: return self.disableStatusWindow // "pdsm"
        case 0x70647374: return self.displayingSubtitle // "pdst"
        case 0x65646273: return self.double // "edbs"
        case 0x636f6d70: return self.doubleInteger // "comp"
        case 0x65646e6b: return self.downArrowKey // "ednk"
        case 0x7071646d: return self.dvdMenuActive // "pqdm"
        case 0x7073636e: return self.dvdScanRate // "pscn"
        case 0x70717374: return self.dvdState // "pqst"
        case 0x7078746d: return self.elapsedExtendedTime // "pxtm"
        case 0x7065746d: return self.elapsedTime // "petm"
        case 0x656e6373: return self.encodedString // "encs"
        case 0x65656e6b: return self.enterKey // "eenk"
        case 0x45505320: return self.EPSPicture // "EPS\0x20"
        case 0x65787061: return self.expansion // "expa"
        case 0x7078626b: return self.extendedBookmarks // "pxbk"
        case 0x65787465: return self.extendedReal // "exte"
        case 0x70787663: return self.extendedVideoClips // "pxvc"
        case 0x66656220: return self.February // "feb\0x20"
        case 0x66737266: return self.fileRef // "fsrf"
        case 0x66737320: return self.fileSpecification // "fss\0x20"
        case 0x6675726c: return self.fileURL // "furl"
        case 0x66697864: return self.fixed // "fixd"
        case 0x66706e74: return self.fixedPoint // "fpnt"
        case 0x66726374: return self.fixedRectangle // "frct"
        case 0x66726920: return self.Friday // "fri\0x20"
        case 0x47494666: return self.GIFPicture // "GIFf"
        case 0x63677478: return self.graphicText // "cgtx"
        case 0x65686673: return self.half // "ehfs"
        case 0x7064626b: return self.hasDefaultBookmark // "pdbk"
        case 0x706c7062: return self.hasLastPlayBookmark // "plpb"
        case 0x7071686d: return self.hasMedia // "pqhm"
        case 0x706d7063: return self.hasMultiplePlaybackChoice // "pmpc"
        case 0x65686f72: return self.horizontal // "ehor"
        case 0x68797068: return self.hyphens // "hyph"
        case 0x49442020: return self.id // "ID\0x20\0x20"
        case 0x65736964: return self.idle // "esid"
        case 0x7069626e: return self.infoBounds // "pibn"
        case 0x70697073: return self.infoPosition // "pips"
        case 0x70697363: return self.infoScreenBounds // "pisc"
        case 0x70697463: return self.infoTextColor // "pitc"
        case 0x70696e74: return self.infoType // "pint"
        case 0x70697673: return self.infoVisibility // "pivs"
        case 0x6c6f6e67: return self.integer // "long"
        case 0x706f7672: return self.interactionOverride // "povr"
        case 0x69747874: return self.internationalText // "itxt"
        case 0x696e746c: return self.internationalWritingCode // "intl"
        case 0x636f626a: return self.item // "cobj"
        case 0x6a616e20: return self.January // "jan\0x20"
        case 0x4a504547: return self.JPEGPicture // "JPEG"
        case 0x6a756c20: return self.July // "jul\0x20"
        case 0x6a756e20: return self.June // "jun\0x20"
        case 0x6b706964: return self.kernelProcessID // "kpid"
        case 0x6c64626c: return self.largeReal // "ldbl"
        case 0x656c666b: return self.leftArrowKey // "elfk"
        case 0x6c697374: return self.list // "list"
        case 0x696e736c: return self.locationReference // "insl"
        case 0x6c667864: return self.longFixed // "lfxd"
        case 0x6c667074: return self.longFixedPoint // "lfpt"
        case 0x6c667263: return self.longFixedRectangle // "lfrc"
        case 0x6c706e74: return self.longPoint // "lpnt"
        case 0x6c726374: return self.longRectangle // "lrct"
        case 0x70766c70: return self.loopVideoClip // "pvlp"
        case 0x6d616368: return self.machine // "mach"
        case 0x6d4c6f63: return self.machineLocation // "mLoc"
        case 0x706f7274: return self.machPort // "port"
        case 0x656d616e: return self.main // "eman"
        case 0x6d617220: return self.March // "mar\0x20"
        case 0x656d7873: return self.max // "emxs"
        case 0x6d617920: return self.May // "may\0x20"
        case 0x6d6f6e20: return self.Monday // "mon\0x20"
        case 0x6e6f2020: return self.no // "no\0x20\0x20"
        case 0x656e6f6e: return self.none // "enon"
        case 0x656e6d73: return self.normal // "enms"
        case 0x6e6f7620: return self.November // "nov\0x20"
        case 0x6e756c6c: return self.null // "null"
        case 0x6e756d65: return self.numericStrings // "nume"
        case 0x6f637420: return self.October // "oct\0x20"
        case 0x656f706e: return self.open // "eopn"
        case 0x65636376: return self.overVideo // "eccv"
        case 0x65737061: return self.paused // "espa"
        case 0x50494354: return self.PICTPicture // "PICT"
        case 0x74706d6d: return self.pixelMapRecord // "tpmm"
        case 0x6573706c: return self.playing // "espl"
        case 0x65737073: return self.playingStill // "esps"
        case 0x51447074: return self.point // "QDpt"
        case 0x70646d61: return self.privateMenuActionTicks // "pdma"
        case 0x7064706d: return self.privateMenuPaused // "pdpm"
        case 0x70736e20: return self.processSerialNumber // "psn\0x20"
        case 0x70414c4c: return self.properties // "pALL"
        case 0x70726f70: return self.property_ // "prop"
        case 0x65707474: return self.ptt // "eptt"
        case 0x70756e63: return self.punctuation // "punc"
        case 0x646f7562: return self.real // "doub"
        case 0x7265636f: return self.record // "reco"
        case 0x6f626a20: return self.reference // "obj\0x20"
        case 0x7078726d: return self.remainingExtendedTime // "pxrm"
        case 0x7072746d: return self.remainingTime // "prtm"
        case 0x65677274: return self.returnToDvd // "egrt"
        case 0x74723136: return self.RGB16Color // "tr16"
        case 0x74723936: return self.RGB96Color // "tr96"
        case 0x63524742: return self.RGBColor // "cRGB"
        case 0x6572746b: return self.rightArrowKey // "ertk"
        case 0x74726f74: return self.rotation // "trot"
        case 0x73617420: return self.Saturday // "sat\0x20"
        case 0x65737363: return self.scanning // "essc"
        case 0x73637074: return self.script // "scpt"
        case 0x65636377: return self.separateWindow // "eccw"
        case 0x73657020: return self.September // "sep\0x20"
        case 0x73686f72: return self.shortInteger // "shor"
        case 0x73696e67: return self.smallReal // "sing"
        case 0x65737464: return self.standard // "estd"
        case 0x65737374: return self.stopped // "esst"
        case 0x54455854: return self.string // "TEXT"
        case 0x7374796c: return self.styledClipboardText // "styl"
        case 0x53545854: return self.styledText // "STXT"
        case 0x65737562: return self.subpicture // "esub"
        case 0x70637362: return self.subtitle // "pcsb"
        case 0x73756e20: return self.Sunday // "sun\0x20"
        case 0x74737479: return self.textStyleInfo // "tsty"
        case 0x74687520: return self.Thursday // "thu\0x20"
        case 0x54494646: return self.TIFFPicture // "TIFF"
        case 0x70637474: return self.title // "pctt"
        case 0x65746974: return self.title // "etit"
        case 0x7078746c: return self.titleExtendedLength // "pxtl"
        case 0x7074746d: return self.titleLength // "pttm"
        case 0x6567616e: return self.toAngleMenu // "egan"
        case 0x65676175: return self.toAudioMenu // "egau"
        case 0x65676264: return self.toBeginningOfDisc // "egbd"
        case 0x65676462: return self.toDefaultBookmark // "egdb"
        case 0x65676c62: return self.toLastPlayBookmark // "eglb"
        case 0x65676d6d: return self.toMainMenu // "egmm"
        case 0x65677074: return self.toPttMenu // "egpt"
        case 0x65677362: return self.toSubpictureMenu // "egsb"
        case 0x6567746d: return self.toTitleMenu // "egtm"
        case 0x74756520: return self.Tuesday // "tue\0x20"
        case 0x74797065: return self.typeClass // "type"
        case 0x75747874: return self.UnicodeText // "utxt"
        case 0x75636f6d: return self.unsignedDoubleInteger // "ucom"
        case 0x6d61676e: return self.unsignedInteger // "magn"
        case 0x75736872: return self.unsignedShortInteger // "ushr"
        case 0x6575706b: return self.upArrowKey // "eupk"
        case 0x75743136: return self.UTF16Text // "ut16"
        case 0x75746638: return self.UTF8Text // "utf8"
        case 0x76657273: return self.version // "vers"
        case 0x70767273: return self.version_ // "pvrs"
        case 0x65766572: return self.vertical // "ever"
        case 0x7076636c: return self.videoClipList // "pvcl"
        case 0x7076626e: return self.viewerBounds // "pvbn"
        case 0x70766673: return self.viewerFullScreen // "pvfs"
        case 0x70666d6f: return self.viewerFullScreenMenuOverride // "pfmo"
        case 0x70767073: return self.viewerPosition // "pvps"
        case 0x70767363: return self.viewerScreenBounds // "pvsc"
        case 0x7076737a: return self.viewerSize // "pvsz"
        case 0x70767673: return self.viewerVisibility // "pvvs"
        case 0x77656420: return self.Wednesday // "wed\0x20"
        case 0x77686974: return self.whitespace // "whit"
        case 0x65776964: return self.wide // "ewid"
        case 0x70736374: return self.writingCode // "psct"
        case 0x65733136: return self.x16 // "es16"
        case 0x65733278: return self.x2 // "es2x"
        case 0x65733332: return self.x32 // "es32"
        case 0x65733478: return self.x4 // "es4x"
        case 0x65733878: return self.x8 // "es8x"
        case 0x79657320: return self.yes // "yes\0x20"
        default: return super.symbol(code: code, type: type, descriptor: descriptor) as! DVDSymbol
        }
    }

    // Types/properties
    public static let activeDvdMenu = DVDSymbol(name: "activeDvdMenu", code: 0x70716f6d, type: typeType) // "pqom"
    public static let alias = DVDSymbol(name: "alias", code: 0x616c6973, type: typeType) // "alis"
    public static let anything = DVDSymbol(name: "anything", code: 0x2a2a2a2a, type: typeType) // "****"
    public static let appInitializing = DVDSymbol(name: "appInitializing", code: 0x7061696e, type: typeType) // "pain"
    public static let application = DVDSymbol(name: "application", code: 0x63617070, type: typeType) // "capp"
    public static let applicationBundleID = DVDSymbol(name: "applicationBundleID", code: 0x62756e64, type: typeType) // "bund"
    public static let applicationSignature = DVDSymbol(name: "applicationSignature", code: 0x7369676e, type: typeType) // "sign"
    public static let applicationURL = DVDSymbol(name: "applicationURL", code: 0x6170726c, type: typeType) // "aprl"
    public static let April = DVDSymbol(name: "April", code: 0x61707220, type: typeType) // "apr\0x20"
    public static let audioMuted = DVDSymbol(name: "audioMuted", code: 0x70616d75, type: typeType) // "pamu"
    public static let audioTrack = DVDSymbol(name: "audioTrack", code: 0x70636174, type: typeType) // "pcat"
    public static let audioVolume = DVDSymbol(name: "audioVolume", code: 0x7061766c, type: typeType) // "pavl"
    public static let August = DVDSymbol(name: "August", code: 0x61756720, type: typeType) // "aug\0x20"
    public static let availableAngles = DVDSymbol(name: "availableAngles", code: 0x7061616e, type: typeType) // "paan"
    public static let availableAudioTracks = DVDSymbol(name: "availableAudioTracks", code: 0x70616175, type: typeType) // "paau"
    public static let availableBookmarks = DVDSymbol(name: "availableBookmarks", code: 0x706e626b, type: typeType) // "pnbk"
    public static let availableChapters = DVDSymbol(name: "availableChapters", code: 0x70616368, type: typeType) // "pach"
    public static let availableSubtitles = DVDSymbol(name: "availableSubtitles", code: 0x70617362, type: typeType) // "pasb"
    public static let availableTitles = DVDSymbol(name: "availableTitles", code: 0x70617474, type: typeType) // "patt"
    public static let availableVideoClips = DVDSymbol(name: "availableVideoClips", code: 0x706e7663, type: typeType) // "pnvc"
    public static let best = DVDSymbol(name: "best", code: 0x62657374, type: typeType) // "best"
    public static let bookmarkData = DVDSymbol(name: "bookmarkData", code: 0x626d726b, type: typeType) // "bmrk"
    public static let bookmarkList = DVDSymbol(name: "bookmarkList", code: 0x70626b6c, type: typeType) // "pbkl"
    public static let boolean = DVDSymbol(name: "boolean", code: 0x626f6f6c, type: typeType) // "bool"
    public static let boundingRectangle = DVDSymbol(name: "boundingRectangle", code: 0x71647274, type: typeType) // "qdrt"
    public static let chapter = DVDSymbol(name: "chapter", code: 0x70636368, type: typeType) // "pcch"
    public static let class_ = DVDSymbol(name: "class_", code: 0x70636c73, type: typeType) // "pcls"
    public static let clipMode = DVDSymbol(name: "clipMode", code: 0x7069636d, type: typeType) // "picm"
    public static let closedCaptioning = DVDSymbol(name: "closedCaptioning", code: 0x7063636f, type: typeType) // "pcco"
    public static let closedCaptioningDisplay = DVDSymbol(name: "closedCaptioningDisplay", code: 0x70636374, type: typeType) // "pcct"
    public static let colorTable = DVDSymbol(name: "colorTable", code: 0x636c7274, type: typeType) // "clrt"
    public static let constant = DVDSymbol(name: "constant", code: 0x656e756d, type: typeType) // "enum"
    public static let controllerBounds = DVDSymbol(name: "controllerBounds", code: 0x7063626e, type: typeType) // "pcbn"
    public static let controllerDrawer = DVDSymbol(name: "controllerDrawer", code: 0x70636472, type: typeType) // "pcdr"
    public static let controllerOrientation = DVDSymbol(name: "controllerOrientation", code: 0x70636f72, type: typeType) // "pcor"
    public static let controllerPosition = DVDSymbol(name: "controllerPosition", code: 0x70637073, type: typeType) // "pcps"
    public static let controllerScreenBounds = DVDSymbol(name: "controllerScreenBounds", code: 0x70637363, type: typeType) // "pcsc"
    public static let controllerVisibility = DVDSymbol(name: "controllerVisibility", code: 0x70637673, type: typeType) // "pcvs"
    public static let dashStyle = DVDSymbol(name: "dashStyle", code: 0x74646173, type: typeType) // "tdas"
    public static let data = DVDSymbol(name: "data", code: 0x74647461, type: typeType) // "tdta"
    public static let date = DVDSymbol(name: "date", code: 0x6c647420, type: typeType) // "ldt\0x20"
    public static let December = DVDSymbol(name: "December", code: 0x64656320, type: typeType) // "dec\0x20"
    public static let decimalStruct = DVDSymbol(name: "decimalStruct", code: 0x6465636d, type: typeType) // "decm"
    public static let disableStatusWindow = DVDSymbol(name: "disableStatusWindow", code: 0x7064736d, type: typeType) // "pdsm"
    public static let displayingSubtitle = DVDSymbol(name: "displayingSubtitle", code: 0x70647374, type: typeType) // "pdst"
    public static let doubleInteger = DVDSymbol(name: "doubleInteger", code: 0x636f6d70, type: typeType) // "comp"
    public static let dvdMenuActive = DVDSymbol(name: "dvdMenuActive", code: 0x7071646d, type: typeType) // "pqdm"
    public static let dvdScanRate = DVDSymbol(name: "dvdScanRate", code: 0x7073636e, type: typeType) // "pscn"
    public static let dvdState = DVDSymbol(name: "dvdState", code: 0x70717374, type: typeType) // "pqst"
    public static let elapsedExtendedTime = DVDSymbol(name: "elapsedExtendedTime", code: 0x7078746d, type: typeType) // "pxtm"
    public static let elapsedTime = DVDSymbol(name: "elapsedTime", code: 0x7065746d, type: typeType) // "petm"
    public static let encodedString = DVDSymbol(name: "encodedString", code: 0x656e6373, type: typeType) // "encs"
    public static let EPSPicture = DVDSymbol(name: "EPSPicture", code: 0x45505320, type: typeType) // "EPS\0x20"
    public static let extendedBookmarks = DVDSymbol(name: "extendedBookmarks", code: 0x7078626b, type: typeType) // "pxbk"
    public static let extendedReal = DVDSymbol(name: "extendedReal", code: 0x65787465, type: typeType) // "exte"
    public static let extendedVideoClips = DVDSymbol(name: "extendedVideoClips", code: 0x70787663, type: typeType) // "pxvc"
    public static let February = DVDSymbol(name: "February", code: 0x66656220, type: typeType) // "feb\0x20"
    public static let fileRef = DVDSymbol(name: "fileRef", code: 0x66737266, type: typeType) // "fsrf"
    public static let fileSpecification = DVDSymbol(name: "fileSpecification", code: 0x66737320, type: typeType) // "fss\0x20"
    public static let fileURL = DVDSymbol(name: "fileURL", code: 0x6675726c, type: typeType) // "furl"
    public static let fixed = DVDSymbol(name: "fixed", code: 0x66697864, type: typeType) // "fixd"
    public static let fixedPoint = DVDSymbol(name: "fixedPoint", code: 0x66706e74, type: typeType) // "fpnt"
    public static let fixedRectangle = DVDSymbol(name: "fixedRectangle", code: 0x66726374, type: typeType) // "frct"
    public static let Friday = DVDSymbol(name: "Friday", code: 0x66726920, type: typeType) // "fri\0x20"
    public static let GIFPicture = DVDSymbol(name: "GIFPicture", code: 0x47494666, type: typeType) // "GIFf"
    public static let graphicText = DVDSymbol(name: "graphicText", code: 0x63677478, type: typeType) // "cgtx"
    public static let hasDefaultBookmark = DVDSymbol(name: "hasDefaultBookmark", code: 0x7064626b, type: typeType) // "pdbk"
    public static let hasLastPlayBookmark = DVDSymbol(name: "hasLastPlayBookmark", code: 0x706c7062, type: typeType) // "plpb"
    public static let hasMedia = DVDSymbol(name: "hasMedia", code: 0x7071686d, type: typeType) // "pqhm"
    public static let hasMultiplePlaybackChoice = DVDSymbol(name: "hasMultiplePlaybackChoice", code: 0x706d7063, type: typeType) // "pmpc"
    public static let id = DVDSymbol(name: "id", code: 0x49442020, type: typeType) // "ID\0x20\0x20"
    public static let infoBounds = DVDSymbol(name: "infoBounds", code: 0x7069626e, type: typeType) // "pibn"
    public static let infoPosition = DVDSymbol(name: "infoPosition", code: 0x70697073, type: typeType) // "pips"
    public static let infoScreenBounds = DVDSymbol(name: "infoScreenBounds", code: 0x70697363, type: typeType) // "pisc"
    public static let infoTextColor = DVDSymbol(name: "infoTextColor", code: 0x70697463, type: typeType) // "pitc"
    public static let infoType = DVDSymbol(name: "infoType", code: 0x70696e74, type: typeType) // "pint"
    public static let infoVisibility = DVDSymbol(name: "infoVisibility", code: 0x70697673, type: typeType) // "pivs"
    public static let integer = DVDSymbol(name: "integer", code: 0x6c6f6e67, type: typeType) // "long"
    public static let interactionOverride = DVDSymbol(name: "interactionOverride", code: 0x706f7672, type: typeType) // "povr"
    public static let internationalText = DVDSymbol(name: "internationalText", code: 0x69747874, type: typeType) // "itxt"
    public static let internationalWritingCode = DVDSymbol(name: "internationalWritingCode", code: 0x696e746c, type: typeType) // "intl"
    public static let item = DVDSymbol(name: "item", code: 0x636f626a, type: typeType) // "cobj"
    public static let January = DVDSymbol(name: "January", code: 0x6a616e20, type: typeType) // "jan\0x20"
    public static let JPEGPicture = DVDSymbol(name: "JPEGPicture", code: 0x4a504547, type: typeType) // "JPEG"
    public static let July = DVDSymbol(name: "July", code: 0x6a756c20, type: typeType) // "jul\0x20"
    public static let June = DVDSymbol(name: "June", code: 0x6a756e20, type: typeType) // "jun\0x20"
    public static let kernelProcessID = DVDSymbol(name: "kernelProcessID", code: 0x6b706964, type: typeType) // "kpid"
    public static let largeReal = DVDSymbol(name: "largeReal", code: 0x6c64626c, type: typeType) // "ldbl"
    public static let list = DVDSymbol(name: "list", code: 0x6c697374, type: typeType) // "list"
    public static let locationReference = DVDSymbol(name: "locationReference", code: 0x696e736c, type: typeType) // "insl"
    public static let longFixed = DVDSymbol(name: "longFixed", code: 0x6c667864, type: typeType) // "lfxd"
    public static let longFixedPoint = DVDSymbol(name: "longFixedPoint", code: 0x6c667074, type: typeType) // "lfpt"
    public static let longFixedRectangle = DVDSymbol(name: "longFixedRectangle", code: 0x6c667263, type: typeType) // "lfrc"
    public static let longPoint = DVDSymbol(name: "longPoint", code: 0x6c706e74, type: typeType) // "lpnt"
    public static let longRectangle = DVDSymbol(name: "longRectangle", code: 0x6c726374, type: typeType) // "lrct"
    public static let loopVideoClip = DVDSymbol(name: "loopVideoClip", code: 0x70766c70, type: typeType) // "pvlp"
    public static let machine = DVDSymbol(name: "machine", code: 0x6d616368, type: typeType) // "mach"
    public static let machineLocation = DVDSymbol(name: "machineLocation", code: 0x6d4c6f63, type: typeType) // "mLoc"
    public static let machPort = DVDSymbol(name: "machPort", code: 0x706f7274, type: typeType) // "port"
    public static let March = DVDSymbol(name: "March", code: 0x6d617220, type: typeType) // "mar\0x20"
    public static let May = DVDSymbol(name: "May", code: 0x6d617920, type: typeType) // "may\0x20"
    public static let Monday = DVDSymbol(name: "Monday", code: 0x6d6f6e20, type: typeType) // "mon\0x20"
    public static let November = DVDSymbol(name: "November", code: 0x6e6f7620, type: typeType) // "nov\0x20"
    public static let null = DVDSymbol(name: "null", code: 0x6e756c6c, type: typeType) // "null"
    public static let October = DVDSymbol(name: "October", code: 0x6f637420, type: typeType) // "oct\0x20"
    public static let PICTPicture = DVDSymbol(name: "PICTPicture", code: 0x50494354, type: typeType) // "PICT"
    public static let pixelMapRecord = DVDSymbol(name: "pixelMapRecord", code: 0x74706d6d, type: typeType) // "tpmm"
    public static let point = DVDSymbol(name: "point", code: 0x51447074, type: typeType) // "QDpt"
    public static let privateMenuActionTicks = DVDSymbol(name: "privateMenuActionTicks", code: 0x70646d61, type: typeType) // "pdma"
    public static let privateMenuPaused = DVDSymbol(name: "privateMenuPaused", code: 0x7064706d, type: typeType) // "pdpm"
    public static let processSerialNumber = DVDSymbol(name: "processSerialNumber", code: 0x70736e20, type: typeType) // "psn\0x20"
    public static let properties = DVDSymbol(name: "properties", code: 0x70414c4c, type: typeType) // "pALL"
    public static let property_ = DVDSymbol(name: "property_", code: 0x70726f70, type: typeType) // "prop"
    public static let real = DVDSymbol(name: "real", code: 0x646f7562, type: typeType) // "doub"
    public static let record = DVDSymbol(name: "record", code: 0x7265636f, type: typeType) // "reco"
    public static let reference = DVDSymbol(name: "reference", code: 0x6f626a20, type: typeType) // "obj\0x20"
    public static let remainingExtendedTime = DVDSymbol(name: "remainingExtendedTime", code: 0x7078726d, type: typeType) // "pxrm"
    public static let remainingTime = DVDSymbol(name: "remainingTime", code: 0x7072746d, type: typeType) // "prtm"
    public static let RGB16Color = DVDSymbol(name: "RGB16Color", code: 0x74723136, type: typeType) // "tr16"
    public static let RGB96Color = DVDSymbol(name: "RGB96Color", code: 0x74723936, type: typeType) // "tr96"
    public static let RGBColor = DVDSymbol(name: "RGBColor", code: 0x63524742, type: typeType) // "cRGB"
    public static let rotation = DVDSymbol(name: "rotation", code: 0x74726f74, type: typeType) // "trot"
    public static let Saturday = DVDSymbol(name: "Saturday", code: 0x73617420, type: typeType) // "sat\0x20"
    public static let script = DVDSymbol(name: "script", code: 0x73637074, type: typeType) // "scpt"
    public static let September = DVDSymbol(name: "September", code: 0x73657020, type: typeType) // "sep\0x20"
    public static let shortInteger = DVDSymbol(name: "shortInteger", code: 0x73686f72, type: typeType) // "shor"
    public static let smallReal = DVDSymbol(name: "smallReal", code: 0x73696e67, type: typeType) // "sing"
    public static let string = DVDSymbol(name: "string", code: 0x54455854, type: typeType) // "TEXT"
    public static let styledClipboardText = DVDSymbol(name: "styledClipboardText", code: 0x7374796c, type: typeType) // "styl"
    public static let styledText = DVDSymbol(name: "styledText", code: 0x53545854, type: typeType) // "STXT"
    public static let subtitle = DVDSymbol(name: "subtitle", code: 0x70637362, type: typeType) // "pcsb"
    public static let Sunday = DVDSymbol(name: "Sunday", code: 0x73756e20, type: typeType) // "sun\0x20"
    public static let textStyleInfo = DVDSymbol(name: "textStyleInfo", code: 0x74737479, type: typeType) // "tsty"
    public static let Thursday = DVDSymbol(name: "Thursday", code: 0x74687520, type: typeType) // "thu\0x20"
    public static let TIFFPicture = DVDSymbol(name: "TIFFPicture", code: 0x54494646, type: typeType) // "TIFF"
    public static let titleExtendedLength = DVDSymbol(name: "titleExtendedLength", code: 0x7078746c, type: typeType) // "pxtl"
    public static let titleLength = DVDSymbol(name: "titleLength", code: 0x7074746d, type: typeType) // "pttm"
    public static let Tuesday = DVDSymbol(name: "Tuesday", code: 0x74756520, type: typeType) // "tue\0x20"
    public static let typeClass = DVDSymbol(name: "typeClass", code: 0x74797065, type: typeType) // "type"
    public static let UnicodeText = DVDSymbol(name: "UnicodeText", code: 0x75747874, type: typeType) // "utxt"
    public static let unsignedDoubleInteger = DVDSymbol(name: "unsignedDoubleInteger", code: 0x75636f6d, type: typeType) // "ucom"
    public static let unsignedInteger = DVDSymbol(name: "unsignedInteger", code: 0x6d61676e, type: typeType) // "magn"
    public static let unsignedShortInteger = DVDSymbol(name: "unsignedShortInteger", code: 0x75736872, type: typeType) // "ushr"
    public static let UTF16Text = DVDSymbol(name: "UTF16Text", code: 0x75743136, type: typeType) // "ut16"
    public static let UTF8Text = DVDSymbol(name: "UTF8Text", code: 0x75746638, type: typeType) // "utf8"
    public static let version = DVDSymbol(name: "version", code: 0x76657273, type: typeType) // "vers"
    public static let version_ = DVDSymbol(name: "version_", code: 0x70767273, type: typeType) // "pvrs"
    public static let videoClipList = DVDSymbol(name: "videoClipList", code: 0x7076636c, type: typeType) // "pvcl"
    public static let viewerBounds = DVDSymbol(name: "viewerBounds", code: 0x7076626e, type: typeType) // "pvbn"
    public static let viewerFullScreen = DVDSymbol(name: "viewerFullScreen", code: 0x70766673, type: typeType) // "pvfs"
    public static let viewerFullScreenMenuOverride = DVDSymbol(name: "viewerFullScreenMenuOverride", code: 0x70666d6f, type: typeType) // "pfmo"
    public static let viewerPosition = DVDSymbol(name: "viewerPosition", code: 0x70767073, type: typeType) // "pvps"
    public static let viewerScreenBounds = DVDSymbol(name: "viewerScreenBounds", code: 0x70767363, type: typeType) // "pvsc"
    public static let viewerSize = DVDSymbol(name: "viewerSize", code: 0x7076737a, type: typeType) // "pvsz"
    public static let viewerVisibility = DVDSymbol(name: "viewerVisibility", code: 0x70767673, type: typeType) // "pvvs"
    public static let Wednesday = DVDSymbol(name: "Wednesday", code: 0x77656420, type: typeType) // "wed\0x20"
    public static let writingCode = DVDSymbol(name: "writingCode", code: 0x70736374, type: typeType) // "psct"

    // Enumerators
    public static let angle = DVDSymbol(name: "angle", code: 0x65616e67, type: typeEnumerated) // "eang"
    public static let ask = DVDSymbol(name: "ask", code: 0x61736b20, type: typeEnumerated) // "ask\0x20"
    public static let audio = DVDSymbol(name: "audio", code: 0x65617564, type: typeEnumerated) // "eaud"
    public static let case_ = DVDSymbol(name: "case_", code: 0x63617365, type: typeEnumerated) // "case"
    public static let closed = DVDSymbol(name: "closed", code: 0x65636c73, type: typeEnumerated) // "ecls"
    public static let diacriticals = DVDSymbol(name: "diacriticals", code: 0x64696163, type: typeEnumerated) // "diac"
    public static let double = DVDSymbol(name: "double", code: 0x65646273, type: typeEnumerated) // "edbs"
    public static let downArrowKey = DVDSymbol(name: "downArrowKey", code: 0x65646e6b, type: typeEnumerated) // "ednk"
    public static let enterKey = DVDSymbol(name: "enterKey", code: 0x65656e6b, type: typeEnumerated) // "eenk"
    public static let expansion = DVDSymbol(name: "expansion", code: 0x65787061, type: typeEnumerated) // "expa"
    public static let half = DVDSymbol(name: "half", code: 0x65686673, type: typeEnumerated) // "ehfs"
    public static let horizontal = DVDSymbol(name: "horizontal", code: 0x65686f72, type: typeEnumerated) // "ehor"
    public static let hyphens = DVDSymbol(name: "hyphens", code: 0x68797068, type: typeEnumerated) // "hyph"
    public static let idle = DVDSymbol(name: "idle", code: 0x65736964, type: typeEnumerated) // "esid"
    public static let leftArrowKey = DVDSymbol(name: "leftArrowKey", code: 0x656c666b, type: typeEnumerated) // "elfk"
    public static let main = DVDSymbol(name: "main", code: 0x656d616e, type: typeEnumerated) // "eman"
    public static let max = DVDSymbol(name: "max", code: 0x656d7873, type: typeEnumerated) // "emxs"
    public static let no = DVDSymbol(name: "no", code: 0x6e6f2020, type: typeEnumerated) // "no\0x20\0x20"
    public static let none = DVDSymbol(name: "none", code: 0x656e6f6e, type: typeEnumerated) // "enon"
    public static let normal = DVDSymbol(name: "normal", code: 0x656e6d73, type: typeEnumerated) // "enms"
    public static let numericStrings = DVDSymbol(name: "numericStrings", code: 0x6e756d65, type: typeEnumerated) // "nume"
    public static let open = DVDSymbol(name: "open", code: 0x656f706e, type: typeEnumerated) // "eopn"
    public static let overVideo = DVDSymbol(name: "overVideo", code: 0x65636376, type: typeEnumerated) // "eccv"
    public static let paused = DVDSymbol(name: "paused", code: 0x65737061, type: typeEnumerated) // "espa"
    public static let playing = DVDSymbol(name: "playing", code: 0x6573706c, type: typeEnumerated) // "espl"
    public static let playingStill = DVDSymbol(name: "playingStill", code: 0x65737073, type: typeEnumerated) // "esps"
    public static let ptt = DVDSymbol(name: "ptt", code: 0x65707474, type: typeEnumerated) // "eptt"
    public static let punctuation = DVDSymbol(name: "punctuation", code: 0x70756e63, type: typeEnumerated) // "punc"
    public static let returnToDvd = DVDSymbol(name: "returnToDvd", code: 0x65677274, type: typeEnumerated) // "egrt"
    public static let rightArrowKey = DVDSymbol(name: "rightArrowKey", code: 0x6572746b, type: typeEnumerated) // "ertk"
    public static let scanning = DVDSymbol(name: "scanning", code: 0x65737363, type: typeEnumerated) // "essc"
    public static let separateWindow = DVDSymbol(name: "separateWindow", code: 0x65636377, type: typeEnumerated) // "eccw"
    public static let standard = DVDSymbol(name: "standard", code: 0x65737464, type: typeEnumerated) // "estd"
    public static let stopped = DVDSymbol(name: "stopped", code: 0x65737374, type: typeEnumerated) // "esst"
    public static let subpicture = DVDSymbol(name: "subpicture", code: 0x65737562, type: typeEnumerated) // "esub"
    public static let title = DVDSymbol(name: "title", code: 0x65746974, type: typeEnumerated) // "etit"
    public static let toAngleMenu = DVDSymbol(name: "toAngleMenu", code: 0x6567616e, type: typeEnumerated) // "egan"
    public static let toAudioMenu = DVDSymbol(name: "toAudioMenu", code: 0x65676175, type: typeEnumerated) // "egau"
    public static let toBeginningOfDisc = DVDSymbol(name: "toBeginningOfDisc", code: 0x65676264, type: typeEnumerated) // "egbd"
    public static let toDefaultBookmark = DVDSymbol(name: "toDefaultBookmark", code: 0x65676462, type: typeEnumerated) // "egdb"
    public static let toLastPlayBookmark = DVDSymbol(name: "toLastPlayBookmark", code: 0x65676c62, type: typeEnumerated) // "eglb"
    public static let toMainMenu = DVDSymbol(name: "toMainMenu", code: 0x65676d6d, type: typeEnumerated) // "egmm"
    public static let toPttMenu = DVDSymbol(name: "toPttMenu", code: 0x65677074, type: typeEnumerated) // "egpt"
    public static let toSubpictureMenu = DVDSymbol(name: "toSubpictureMenu", code: 0x65677362, type: typeEnumerated) // "egsb"
    public static let toTitleMenu = DVDSymbol(name: "toTitleMenu", code: 0x6567746d, type: typeEnumerated) // "egtm"
    public static let upArrowKey = DVDSymbol(name: "upArrowKey", code: 0x6575706b, type: typeEnumerated) // "eupk"
    public static let vertical = DVDSymbol(name: "vertical", code: 0x65766572, type: typeEnumerated) // "ever"
    public static let whitespace = DVDSymbol(name: "whitespace", code: 0x77686974, type: typeEnumerated) // "whit"
    public static let wide = DVDSymbol(name: "wide", code: 0x65776964, type: typeEnumerated) // "ewid"
    public static let x16 = DVDSymbol(name: "x16", code: 0x65733136, type: typeEnumerated) // "es16"
    public static let x2 = DVDSymbol(name: "x2", code: 0x65733278, type: typeEnumerated) // "es2x"
    public static let x32 = DVDSymbol(name: "x32", code: 0x65733332, type: typeEnumerated) // "es32"
    public static let x4 = DVDSymbol(name: "x4", code: 0x65733478, type: typeEnumerated) // "es4x"
    public static let x8 = DVDSymbol(name: "x8", code: 0x65733878, type: typeEnumerated) // "es8x"
    public static let yes = DVDSymbol(name: "yes", code: 0x79657320, type: typeEnumerated) // "yes\0x20"
}

public typealias DVD = DVDSymbol // allows symbols to be written as (e.g.) DVD.name instead of DVDSymbol.name


/******************************************************************************/
// Specifier extensions; these add command methods and property/elements getters based on DVD Player.app terminology

public protocol DVDCommand: SwiftAutomation.SpecifierProtocol {} // provides AE dispatch methods

// Command->Any will be bound when return type can't be inferred, else Command->T

extension DVDCommand {
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
    @discardableResult public func ejectDvd(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "ejectDvd", eventClass: 0x64766478, eventID: 0x6576656a, // "dvdx"/"evej"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func ejectDvd<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "ejectDvd", eventClass: 0x64766478, eventID: 0x6576656a, // "dvdx"/"evej"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func exitClipMode(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "exitClipMode", eventClass: 0x64766478, eventID: 0x65766563, // "dvdx"/"evec"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func exitClipMode<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "exitClipMode", eventClass: 0x64766478, eventID: 0x65766563, // "dvdx"/"evec"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func fastForwardDvd(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "fastForwardDvd", eventClass: 0x64766478, eventID: 0x65766666, // "dvdx"/"evff"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func fastForwardDvd<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "fastForwardDvd", eventClass: 0x64766478, eventID: 0x65766666, // "dvdx"/"evff"
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
    @discardableResult public func go(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "go", eventClass: 0x64766478, eventID: 0x6576676f, // "dvdx"/"evgo"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func go<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "go", eventClass: 0x64766478, eventID: 0x6576676f, // "dvdx"/"evgo"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func obscureCursor(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "obscureCursor", eventClass: 0x64766478, eventID: 0x65766f63, // "dvdx"/"evoc"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func obscureCursor<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "obscureCursor", eventClass: 0x64766478, eventID: 0x65766f63, // "dvdx"/"evoc"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
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
    @discardableResult public func openDvdVideoFolder(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "openDvdVideoFolder", eventClass: 0x64766478, eventID: 0x6f647666, // "dvdx"/"odvf"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func openDvdVideoFolder<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "openDvdVideoFolder", eventClass: 0x64766478, eventID: 0x6f647666, // "dvdx"/"odvf"
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
    @discardableResult public func openVIDEO_TS(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "openVIDEO_TS", eventClass: 0x64766478, eventID: 0x6f767473, // "dvdx"/"ovts"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func openVIDEO_TS<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "openVIDEO_TS", eventClass: 0x64766478, eventID: 0x6f767473, // "dvdx"/"ovts"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func pauseDvd(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "pauseDvd", eventClass: 0x64766478, eventID: 0x65767073, // "dvdx"/"evps"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func pauseDvd<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "pauseDvd", eventClass: 0x64766478, eventID: 0x65767073, // "dvdx"/"evps"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func playBookmark(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "playBookmark", eventClass: 0x64766478, eventID: 0x6576626b, // "dvdx"/"evbk"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func playBookmark<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "playBookmark", eventClass: 0x64766478, eventID: 0x6576626b, // "dvdx"/"evbk"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func playDvd(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "playDvd", eventClass: 0x64766478, eventID: 0x6576706c, // "dvdx"/"evpl"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func playDvd<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "playDvd", eventClass: 0x64766478, eventID: 0x6576706c, // "dvdx"/"evpl"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func playNamedBookmark(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "playNamedBookmark", eventClass: 0x64766478, eventID: 0x6576626e, // "dvdx"/"evbn"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func playNamedBookmark<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "playNamedBookmark", eventClass: 0x64766478, eventID: 0x6576626e, // "dvdx"/"evbn"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func playNamedVideoClip(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "playNamedVideoClip", eventClass: 0x64766478, eventID: 0x6576636e, // "dvdx"/"evcn"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func playNamedVideoClip<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "playNamedVideoClip", eventClass: 0x64766478, eventID: 0x6576636e, // "dvdx"/"evcn"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func playNextChapter(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "playNextChapter", eventClass: 0x64766478, eventID: 0x65766e63, // "dvdx"/"evnc"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func playNextChapter<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "playNextChapter", eventClass: 0x64766478, eventID: 0x65766e63, // "dvdx"/"evnc"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func playPreviousChapter(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "playPreviousChapter", eventClass: 0x64766478, eventID: 0x65767063, // "dvdx"/"evpc"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func playPreviousChapter<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "playPreviousChapter", eventClass: 0x64766478, eventID: 0x65767063, // "dvdx"/"evpc"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func playVideoClip(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "playVideoClip", eventClass: 0x64766478, eventID: 0x65767663, // "dvdx"/"evvc"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func playVideoClip<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "playVideoClip", eventClass: 0x64766478, eventID: 0x65767663, // "dvdx"/"evvc"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func press(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "press", eventClass: 0x64766478, eventID: 0x65767072, // "dvdx"/"evpr"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func press<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "press", eventClass: 0x64766478, eventID: 0x65767072, // "dvdx"/"evpr"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
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
    @discardableResult public func rewindDvd(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "rewindDvd", eventClass: 0x64766478, eventID: 0x65767277, // "dvdx"/"evrw"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func rewindDvd<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "rewindDvd", eventClass: 0x64766478, eventID: 0x65767277, // "dvdx"/"evrw"
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
    @discardableResult public func stepDvd(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "stepDvd", eventClass: 0x64766478, eventID: 0x65767370, // "dvdx"/"evsp"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func stepDvd<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "stepDvd", eventClass: 0x64766478, eventID: 0x65767370, // "dvdx"/"evsp"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func stopDvd(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "stopDvd", eventClass: 0x64766478, eventID: 0x65767374, // "dvdx"/"evst"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func stopDvd<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "stopDvd", eventClass: 0x64766478, eventID: 0x65767374, // "dvdx"/"evst"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
}


public protocol DVDObject: SwiftAutomation.ObjectSpecifierExtension, DVDCommand {} // provides vars and methods for constructing specifiers

extension DVDObject {
    
    // Properties
    public var activeDvdMenu: DVDItem {return self.property(0x70716f6d) as! DVDItem} // "pqom"
    public var angle: DVDItem {return self.property(0x7063616e) as! DVDItem} // "pcan"
    public var appInitializing: DVDItem {return self.property(0x7061696e) as! DVDItem} // "pain"
    public var audioMuted: DVDItem {return self.property(0x70616d75) as! DVDItem} // "pamu"
    public var audioTrack: DVDItem {return self.property(0x70636174) as! DVDItem} // "pcat"
    public var audioVolume: DVDItem {return self.property(0x7061766c) as! DVDItem} // "pavl"
    public var availableAngles: DVDItem {return self.property(0x7061616e) as! DVDItem} // "paan"
    public var availableAudioTracks: DVDItem {return self.property(0x70616175) as! DVDItem} // "paau"
    public var availableBookmarks: DVDItem {return self.property(0x706e626b) as! DVDItem} // "pnbk"
    public var availableChapters: DVDItem {return self.property(0x70616368) as! DVDItem} // "pach"
    public var availableSubtitles: DVDItem {return self.property(0x70617362) as! DVDItem} // "pasb"
    public var availableTitles: DVDItem {return self.property(0x70617474) as! DVDItem} // "patt"
    public var availableVideoClips: DVDItem {return self.property(0x706e7663) as! DVDItem} // "pnvc"
    public var bookmarkList: DVDItem {return self.property(0x70626b6c) as! DVDItem} // "pbkl"
    public var chapter: DVDItem {return self.property(0x70636368) as! DVDItem} // "pcch"
    public var class_: DVDItem {return self.property(0x70636c73) as! DVDItem} // "pcls"
    public var clipMode: DVDItem {return self.property(0x7069636d) as! DVDItem} // "picm"
    public var closedCaptioning: DVDItem {return self.property(0x7063636f) as! DVDItem} // "pcco"
    public var closedCaptioningDisplay: DVDItem {return self.property(0x70636374) as! DVDItem} // "pcct"
    public var controllerBounds: DVDItem {return self.property(0x7063626e) as! DVDItem} // "pcbn"
    public var controllerDrawer: DVDItem {return self.property(0x70636472) as! DVDItem} // "pcdr"
    public var controllerOrientation: DVDItem {return self.property(0x70636f72) as! DVDItem} // "pcor"
    public var controllerPosition: DVDItem {return self.property(0x70637073) as! DVDItem} // "pcps"
    public var controllerScreenBounds: DVDItem {return self.property(0x70637363) as! DVDItem} // "pcsc"
    public var controllerVisibility: DVDItem {return self.property(0x70637673) as! DVDItem} // "pcvs"
    public var disableStatusWindow: DVDItem {return self.property(0x7064736d) as! DVDItem} // "pdsm"
    public var displayingSubtitle: DVDItem {return self.property(0x70647374) as! DVDItem} // "pdst"
    public var dvdMenuActive: DVDItem {return self.property(0x7071646d) as! DVDItem} // "pqdm"
    public var dvdScanRate: DVDItem {return self.property(0x7073636e) as! DVDItem} // "pscn"
    public var dvdState: DVDItem {return self.property(0x70717374) as! DVDItem} // "pqst"
    public var elapsedExtendedTime: DVDItem {return self.property(0x7078746d) as! DVDItem} // "pxtm"
    public var elapsedTime: DVDItem {return self.property(0x7065746d) as! DVDItem} // "petm"
    public var extendedBookmarks: DVDItem {return self.property(0x7078626b) as! DVDItem} // "pxbk"
    public var extendedVideoClips: DVDItem {return self.property(0x70787663) as! DVDItem} // "pxvc"
    public var hasDefaultBookmark: DVDItem {return self.property(0x7064626b) as! DVDItem} // "pdbk"
    public var hasLastPlayBookmark: DVDItem {return self.property(0x706c7062) as! DVDItem} // "plpb"
    public var hasMedia: DVDItem {return self.property(0x7071686d) as! DVDItem} // "pqhm"
    public var hasMultiplePlaybackChoice: DVDItem {return self.property(0x706d7063) as! DVDItem} // "pmpc"
    public var id: DVDItem {return self.property(0x49442020) as! DVDItem} // "ID\0x20\0x20"
    public var infoBounds: DVDItem {return self.property(0x7069626e) as! DVDItem} // "pibn"
    public var infoPosition: DVDItem {return self.property(0x70697073) as! DVDItem} // "pips"
    public var infoScreenBounds: DVDItem {return self.property(0x70697363) as! DVDItem} // "pisc"
    public var infoTextColor: DVDItem {return self.property(0x70697463) as! DVDItem} // "pitc"
    public var infoType: DVDItem {return self.property(0x70696e74) as! DVDItem} // "pint"
    public var infoVisibility: DVDItem {return self.property(0x70697673) as! DVDItem} // "pivs"
    public var interactionOverride: DVDItem {return self.property(0x706f7672) as! DVDItem} // "povr"
    public var loopVideoClip: DVDItem {return self.property(0x70766c70) as! DVDItem} // "pvlp"
    public var privateMenuActionTicks: DVDItem {return self.property(0x70646d61) as! DVDItem} // "pdma"
    public var privateMenuPaused: DVDItem {return self.property(0x7064706d) as! DVDItem} // "pdpm"
    public var properties: DVDItem {return self.property(0x70414c4c) as! DVDItem} // "pALL"
    public var remainingExtendedTime: DVDItem {return self.property(0x7078726d) as! DVDItem} // "pxrm"
    public var remainingTime: DVDItem {return self.property(0x7072746d) as! DVDItem} // "prtm"
    public var subtitle: DVDItem {return self.property(0x70637362) as! DVDItem} // "pcsb"
    public var title: DVDItem {return self.property(0x70637474) as! DVDItem} // "pctt"
    public var titleExtendedLength: DVDItem {return self.property(0x7078746c) as! DVDItem} // "pxtl"
    public var titleLength: DVDItem {return self.property(0x7074746d) as! DVDItem} // "pttm"
    public var version_: DVDItem {return self.property(0x70767273) as! DVDItem} // "pvrs"
    public var videoClipList: DVDItem {return self.property(0x7076636c) as! DVDItem} // "pvcl"
    public var viewerBounds: DVDItem {return self.property(0x7076626e) as! DVDItem} // "pvbn"
    public var viewerFullScreen: DVDItem {return self.property(0x70766673) as! DVDItem} // "pvfs"
    public var viewerFullScreenMenuOverride: DVDItem {return self.property(0x70666d6f) as! DVDItem} // "pfmo"
    public var viewerPosition: DVDItem {return self.property(0x70767073) as! DVDItem} // "pvps"
    public var viewerScreenBounds: DVDItem {return self.property(0x70767363) as! DVDItem} // "pvsc"
    public var viewerSize: DVDItem {return self.property(0x7076737a) as! DVDItem} // "pvsz"
    public var viewerVisibility: DVDItem {return self.property(0x70767673) as! DVDItem} // "pvvs"

    // Elements
    public var applications: DVDItems {return self.elements(0x63617070) as! DVDItems} // "capp"
    public var items: DVDItems {return self.elements(0x636f626a) as! DVDItems} // "cobj"
}


/******************************************************************************/
// Specifier subclasses add app-specific extensions

// beginning/end/before/after
public class DVDInsertion: SwiftAutomation.InsertionSpecifier, DVDCommand {}


// property/by-index/by-name/by-id/previous/next/first/middle/last/any
public class DVDItem: SwiftAutomation.ObjectSpecifier, DVDObject {
    public typealias InsertionSpecifierType = DVDInsertion
    public typealias ObjectSpecifierType = DVDItem
    public typealias MultipleObjectSpecifierType = DVDItems
}

// by-range/by-test/all
public class DVDItems: DVDItem, SwiftAutomation.MultipleObjectSpecifierExtension {}

// App/Con/Its
public class DVDRoot: SwiftAutomation.RootSpecifier, DVDObject, SwiftAutomation.RootSpecifierExtension {
    public typealias InsertionSpecifierType = DVDInsertion
    public typealias ObjectSpecifierType = DVDItem
    public typealias MultipleObjectSpecifierType = DVDItems
    public override class var untargetedAppData: SwiftAutomation.AppData { return _untargetedAppData }
}

// Application
public class DVDPlayer: DVDRoot, SwiftAutomation.Application {
    public convenience init(launchOptions: SwiftAutomation.LaunchOptions = SwiftAutomation.DefaultLaunchOptions, relaunchMode: SwiftAutomation.RelaunchMode = SwiftAutomation.DefaultRelaunchMode) {
        self.init(rootObject: SwiftAutomation.AppRootDesc, appData: Swift.type(of:self).untargetedAppData.targetedCopy(
                  .bundleIdentifier("com.apple.DVDPlayer", true), launchOptions: launchOptions, relaunchMode: relaunchMode))
    }
}

// App/Con/Its root objects used to construct untargeted specifiers; these can be used to construct specifiers for use in commands, though cannot send commands themselves

public let DVDApp = _untargetedAppData.app as! DVDRoot
public let DVDCon = _untargetedAppData.con as! DVDRoot
public let DVDIts = _untargetedAppData.its as! DVDRoot


/******************************************************************************/
// Static types

public typealias DVDRecord = [DVDSymbol:Any] // default Swift type for AERecordDescs







