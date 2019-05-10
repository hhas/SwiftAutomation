//
//  ITunesGlue.swift
//  iTunes.app 12.9.4
//  SwiftAutomation.framework 0.1.0
//  `aeglue 'iTunes.app'`
//


import Foundation
import AppleEvents
import SwiftAutomation


/******************************************************************************/
// Create an untargeted AppData instance for use in App, Con, Its roots,
// and in Application initializers to create targeted AppData instances.

private let _specifierFormatter = SwiftAutomation.SpecifierFormatter(
        applicationClassName: "ITunes",
        classNamePrefix: "ITU",
        typeNames: [
                0x70416374: "active", // "pAct"
                0x7055524c: "address", // "pURL"
                0x6b41504f: "AirPlayDevice", // "kAPO"
                0x63415044: "AirPlayDevice", // "cAPD"
                0x70415045: "AirPlayEnabled", // "pAPE"
                0x6b415058: "AirPortExpress", // "kAPX"
                0x70416c62: "album", // "pAlb"
                0x70416c41: "albumArtist", // "pAlA"
                0x70414874: "albumDisliked", // "pAHt"
                0x6b416c62: "albumListing", // "kAlb"
                0x70414c76: "albumLoved", // "pALv"
                0x70416c52: "albumRating", // "pAlR"
                0x7041526b: "albumRatingKind", // "pARk"
                0x6b536841: "albums", // "kShA"
                0x6b53724c: "albums", // "kSrL"
                0x6b4d644c: "alertTone", // "kMdL"
                0x616c6973: "alias", // "alis"
                0x6b416c6c: "all_", // "kAll"
                0x2a2a2a2a: "anything", // "****"
                0x6b415054: "AppleTV", // "kAPT"
                0x63617070: "application", // "capp"
                0x62756e64: "applicationBundleID", // "bund"
                0x7369676e: "applicationSignature", // "sign"
                0x6170726c: "applicationURL", // "aprl"
                0x61707220: "April", // "apr "
                0x70417274: "artist", // "pArt"
                0x6b537252: "artists", // "kSrR"
                0x63417274: "artwork", // "cArt"
                0x61736b20: "ask", // "ask "
                0x6b4d6441: "audiobook", // "kMdA"
                0x6b414344: "audioCD", // "kACD"
                0x63434450: "audioCDPlaylist", // "cCDP"
                0x63434454: "audioCDTrack", // "cCDT"
                0x61756720: "August", // "aug "
                0x70417661: "available", // "pAva"
                0x70455131: "band1", // "pEQ1"
                0x70455130: "band10", // "pEQ0"
                0x70455132: "band2", // "pEQ2"
                0x70455133: "band3", // "pEQ3"
                0x70455134: "band4", // "pEQ4"
                0x70455135: "band5", // "pEQ5"
                0x70455136: "band6", // "pEQ6"
                0x70455137: "band7", // "pEQ7"
                0x70455138: "band8", // "pEQ8"
                0x70455139: "band9", // "pEQ9"
                0x62657374: "best", // "best"
                0x70425274: "bitRate", // "pBRt"
                0x6b415042: "BluetoothDevice", // "kAPB"
                0x6b4d6442: "book", // "kMdB"
                0x70426b74: "bookmark", // "pBkt"
                0x70426b6d: "bookmarkable", // "pBkm"
                0x626d726b: "bookmarkData", // "bmrk"
                0x6b537041: "Books", // "kSpA"
                0x626f6f6c: "boolean", // "bool"
                0x71647274: "boundingRectangle", // "qdrt"
                0x70626e64: "bounds", // "pbnd"
                0x7042504d: "bpm", // "pBPM"
                0x63427257: "browserWindow", // "cBrW"
                0x63617061: "capacity", // "capa"
                0x63617365: "case_", // "case"
                0x70436174: "category", // "pCat"
                0x6b434469: "cdInsert", // "kCDi"
                0x70636c73: "class_", // "pcls"
                0x68636c62: "closeable", // "hclb"
                0x70436c53: "cloudStatus", // "pClS"
                0x70575368: "collapseable", // "pWSh"
                0x77736864: "collapsed", // "wshd"
                0x6c77636c: "collating", // "lwcl"
                0x636c7274: "colorTable", // "clrt"
                0x70436d74: "comment", // "pCmt"
                0x70416e74: "compilation", // "pAnt"
                0x70436d70: "composer", // "pCmp"
                0x6b537243: "composers", // "kSrC"
                0x6b527443: "computed", // "kRtC"
                0x6b415043: "computer", // "kAPC"
                0x656e756d: "constant", // "enum"
                0x63746e72: "container", // "ctnr"
                0x70436e76: "converting", // "pCnv"
                0x6c776370: "copies", // "lwcp"
                0x70415044: "currentAirPlayDevices", // "pAPD"
                0x70456e63: "currentEncoder", // "pEnc"
                0x70455150: "currentEQPreset", // "pEQP"
                0x70506c61: "currentPlaylist", // "pPla"
                0x70537454: "currentStreamTitle", // "pStT"
                0x70537455: "currentStreamURL", // "pStU"
                0x7054726b: "currentTrack", // "pTrk"
                0x70566973: "currentVisual", // "pVis"
                0x74646173: "dashStyle", // "tdas"
                0x74647461: "data", // "tdta"
                0x70504354: "data_", // "pPCT"
                0x70444944: "databaseID", // "pDID"
                0x6c647420: "date", // "ldt "
                0x70416464: "dateAdded", // "pAdd"
                0x64656320: "December", // "dec "
                0x6465636d: "decimalStruct", // "decm"
                0x70446573: "description_", // "pDes"
                0x6c776474: "detailed", // "lwdt"
                0x64696163: "diacriticals", // "diac"
                0x70447343: "discCount", // "pDsC"
                0x7044734e: "discNumber", // "pDsN"
                0x70486174: "disliked", // "pHat"
                0x6b537256: "displayed", // "kSrV"
                0x636f6d70: "doubleInteger", // "comp"
                0x70446c41: "downloaded", // "pDlA"
                0x70444149: "downloaderAppleID", // "pDAI"
                0x70444e6d: "downloaderName", // "pDNm"
                0x6b447570: "duplicate", // "kDup"
                0x70447572: "duration", // "pDur"
                0x656e626c: "enabled", // "enbl"
                0x656e6373: "encodedString", // "encs"
                0x63456e63: "encoder", // "cEnc"
                0x6c776c70: "endingPage", // "lwlp"
                0x70457044: "episodeID", // "pEpD"
                0x7045704e: "episodeNumber", // "pEpN"
                0x45505320: "EPSPicture", // "EPS "
                0x70455170: "EQ", // "pEQp"
                0x70455120: "EQEnabled", // "pEQ "
                0x63455150: "EQPreset", // "cEQP"
                0x63455157: "EQWindow", // "cEQW"
                0x6b457272: "error", // "kErr"
                0x6c776568: "errorHandling", // "lweh"
                0x65787061: "expansion", // "expa"
                0x6b505346: "fastForwarding", // "kPSF"
                0x6661786e: "faxNumber", // "faxn"
                0x66656220: "February", // "feb "
                0x66737266: "fileRef", // "fsrf"
                0x63466c54: "fileTrack", // "cFlT"
                0x6675726c: "fileURL", // "furl"
                0x70537470: "finish", // "pStp"
                0x66697864: "fixed", // "fixd"
                0x70466978: "fixedIndexing", // "pFix"
                0x66706e74: "fixedPoint", // "fpnt"
                0x66726374: "fixedRectangle", // "frct"
                0x6b537046: "folder", // "kSpF"
                0x63466f50: "folderPlaylist", // "cFoP"
                0x70466d74: "format", // "pFmt"
                0x66727370: "freeSpace", // "frsp"
                0x66726920: "Friday", // "fri "
                0x70697366: "frontmost", // "pisf"
                0x70465363: "fullScreen", // "pFSc"
                0x7047706c: "gapless", // "pGpl"
                0x6b537047: "Genius", // "kSpG"
                0x70476e73: "genius", // "pGns"
                0x7047656e: "genre", // "pGen"
                0x47494666: "GIFPicture", // "GIFf"
                0x63677478: "graphicText", // "cgtx"
                0x70477270: "grouping", // "pGrp"
                0x6b536847: "groupings", // "kShG"
                0x6b415048: "HomePod", // "kAPH"
                0x6b566448: "homeVideo", // "kVdH"
                0x68797068: "hyphens", // "hyph"
                0x49442020: "id", // "ID  "
                0x70696478: "index", // "pidx"
                0x6b52656a: "ineligible", // "kRej"
                0x6c6f6e67: "integer", // "long"
                0x69747874: "internationalText", // "itxt"
                0x696e746c: "internationalWritingCode", // "intl"
                0x6b506f64: "iPod", // "kPod"
                0x636f626a: "item", // "cobj"
                0x6b495453: "iTunesStore", // "kITS"
                0x6b537055: "iTunesU", // "kSpU"
                0x6b4d6449: "iTunesU", // "kMdI"
                0x6a616e20: "January", // "jan "
                0x4a504547: "JPEGPicture", // "JPEG"
                0x6a756c20: "July", // "jul "
                0x6a756e20: "June", // "jun "
                0x6b706964: "kernelProcessID", // "kpid"
                0x704b6e64: "kind", // "pKnd"
                0x6b56534c: "large", // "kVSL"
                0x6c64626c: "largeReal", // "ldbl"
                0x6b53704c: "Library", // "kSpL"
                0x6b4c6962: "library", // "kLib"
                0x634c6950: "libraryPlaylist", // "cLiP"
                0x6c697374: "list", // "list"
                0x704c6f63: "location", // "pLoc"
                0x696e736c: "locationReference", // "insl"
                0x704c6473: "longDescription", // "pLds"
                0x6c667864: "longFixed", // "lfxd"
                0x6c667074: "longFixedPoint", // "lfpt"
                0x6c667263: "longFixedRectangle", // "lfrc"
                0x6c706e74: "longPoint", // "lpnt"
                0x6c726374: "longRectangle", // "lrct"
                0x704c6f76: "loved", // "pLov"
                0x704c7972: "lyrics", // "pLyr"
                0x6d616368: "machine", // "mach"
                0x6d4c6f63: "machineLocation", // "mLoc"
                0x706f7274: "machPort", // "port"
                0x6d617220: "March", // "mar "
                0x6b4d6174: "matched", // "kMat"
                0x6d617920: "May", // "may "
                0x704d644b: "mediaKind", // "pMdK"
                0x6b56534d: "medium", // "kVSM"
                0x634d5057: "miniplayerWindow", // "cMPW"
                0x704d6f64: "modifiable", // "pMod"
                0x61736d6f: "modificationDate", // "asmo"
                0x6d6f6e20: "Monday", // "mon "
                0x704d4e6d: "movement", // "pMNm"
                0x704d7643: "movementCount", // "pMvC"
                0x704d764e: "movementNumber", // "pMvN"
                0x6b56644d: "movie", // "kVdM"
                0x6b537049: "Movies", // "kSpI"
                0x6b4d4344: "MP3CD", // "kMCD"
                0x6b53705a: "Music", // "kSpZ"
                0x6b566456: "musicVideo", // "kVdV"
                0x704d7574: "mute", // "pMut"
                0x706e616d: "name", // "pnam"
                0x704d4143: "networkAddress", // "pMAC"
                0x6e6f2020: "no", // "no  "
                0x6b526576: "noLongerAvailable", // "kRev"
                0x6b4e6f6e: "none", // "kNon"
                0x6b557050: "notUploaded", // "kUpP"
                0x6e6f7620: "November", // "nov "
                0x6e756c6c: "null", // "null"
                0x6e756d65: "numericStrings", // "nume"
                0x6f637420: "October", // "oct "
                0x6b52704f: "off", // "kRpO"
                0x6b527031: "one", // "kRp1"
                0x6c776c61: "pagesAcross", // "lwla"
                0x6c776c64: "pagesDown", // "lwld"
                0x70506c50: "parent", // "pPlP"
                0x6b505370: "paused", // "kPSp"
                0x70504953: "persistentID", // "pPIS"
                0x50494354: "picture", // "PICT"
                0x74706d6d: "pixelMapRecord", // "tpmm"
                0x70506c43: "playedCount", // "pPlC"
                0x70506c44: "playedDate", // "pPlD"
                0x70506f73: "playerPosition", // "pPos"
                0x70506c53: "playerState", // "pPlS"
                0x6b505350: "playing", // "kPSP"
                0x63506c79: "playlist", // "cPly"
                0x63506c57: "playlistWindow", // "cPlW"
                0x6b4d6450: "podcast", // "kMdP"
                0x6b537050: "Podcasts", // "kSpP"
                0x51447074: "point", // "QDpt"
                0x70706f73: "position", // "ppos"
                0x70455141: "preamp", // "pEQA"
                0x6c777066: "printerFeatures", // "lwpf"
                0x70736574: "printSettings", // "pset"
                0x70736e20: "processSerialNumber", // "psn "
                0x70414c4c: "properties", // "pALL"
                0x70726f70: "property_", // "prop"
                0x7050726f: "protected", // "pPro"
                0x70756e63: "punctuation", // "punc"
                0x6b507572: "purchased", // "kPur"
                0x6b53704d: "PurchasedMusic", // "kSpM"
                0x70504149: "purchaserAppleID", // "pPAI"
                0x70504e6d: "purchaserName", // "pPNm"
                0x6b54756e: "radioTuner", // "kTun"
                0x63525450: "radioTunerPlaylist", // "cRTP"
                0x70527465: "rating", // "pRte"
                0x7052746b: "ratingKind", // "pRtk"
                0x70526177: "rawData", // "pRaw"
                0x646f7562: "real", // "doub"
                0x7265636f: "record", // "reco"
                0x6f626a20: "reference", // "obj "
                0x70526c44: "releaseDate", // "pRlD"
                0x6b52656d: "removed", // "kRem"
                0x6c777174: "requestedPrintTime", // "lwqt"
                0x7072737a: "resizable", // "prsz"
                0x6b505352: "rewinding", // "kPSR"
                0x74723136: "RGB16Color", // "tr16"
                0x74723936: "RGB96Color", // "tr96"
                0x63524742: "RGBColor", // "cRGB"
                0x6b4d6452: "ringtone", // "kMdR"
                0x74726f74: "rotation", // "trot"
                0x70535274: "sampleRate", // "pSRt"
                0x73617420: "Saturday", // "sat "
                0x73637074: "script", // "scpt"
                0x7053654e: "seasonNumber", // "pSeN"
                0x73656c63: "selected", // "selc"
                0x73656c65: "selection", // "sele"
                0x73657020: "September", // "sep "
                0x70536872: "shared", // "pShr"
                0x6b536864: "sharedLibrary", // "kShd"
                0x63536854: "sharedTrack", // "cShT"
                0x73686f72: "shortInteger", // "shor"
                0x70536877: "show", // "pShw"
                0x70536661: "shufflable", // "pSfa"
                0x70536866: "shuffle", // "pShf"
                0x70536845: "shuffleEnabled", // "pShE"
                0x7053684d: "shuffleMode", // "pShM"
                0x7053697a: "size", // "pSiz"
                0x70536b43: "skippedCount", // "pSkC"
                0x70536b44: "skippedDate", // "pSkD"
                0x6b565353: "small", // "kVSS"
                0x73696e67: "smallReal", // "sing"
                0x70536d74: "smart", // "pSmt"
                0x6b4d6453: "song", // "kMdS"
                0x70527074: "songRepeat", // "pRpt"
                0x6b536853: "songs", // "kShS"
                0x6b537253: "songs", // "kSrS"
                0x7053416c: "sortAlbum", // "pSAl"
                0x70534141: "sortAlbumArtist", // "pSAA"
                0x70534172: "sortArtist", // "pSAr"
                0x7053436d: "sortComposer", // "pSCm"
                0x70534e6d: "sortName", // "pSNm"
                0x7053534e: "sortShow", // "pSSN"
                0x70566f6c: "soundVolume", // "pVol"
                0x63537263: "source", // "cSrc"
                0x7053704b: "specialKind", // "pSpK"
                0x6c777374: "standard", // "lwst"
                0x70537472: "start", // "pStr"
                0x6c776670: "startingPage", // "lwfp"
                0x6b505353: "stopped", // "kPSS"
                0x54455854: "string", // "TEXT"
                0x7374796c: "styledClipboardText", // "styl"
                0x53545854: "styledText", // "STXT"
                0x6b537562: "subscription", // "kSub"
                0x63537550: "subscriptionPlaylist", // "cSuP"
                0x73756e20: "Sunday", // "sun "
                0x70417564: "supportsAudio", // "pAud"
                0x70566964: "supportsVideo", // "pVid"
                0x74727072: "targetPrinter", // "trpr"
                0x74737479: "textStyleInfo", // "tsty"
                0x74687520: "Thursday", // "thu "
                0x54494646: "TIFFPicture", // "TIFF"
                0x7054696d: "time", // "pTim"
                0x6354726b: "track", // "cTrk"
                0x70547243: "trackCount", // "pTrC"
                0x6b54726b: "trackListing", // "kTrk"
                0x7054724e: "trackNumber", // "pTrN"
                0x74756520: "Tuesday", // "tue "
                0x6b566454: "TVShow", // "kVdT"
                0x6b537054: "TVShows", // "kSpT"
                0x74797065: "typeClass", // "type"
                0x75747874: "UnicodeText", // "utxt"
                0x6b415055: "unknown", // "kAPU"
                0x6b556e6b: "unknown", // "kUnk"
                0x70556e70: "unplayed", // "pUnp"
                0x75636f6d: "unsignedDoubleInteger", // "ucom"
                0x6d61676e: "unsignedInteger", // "magn"
                0x75736872: "unsignedShortInteger", // "ushr"
                0x70555443: "updateTracks", // "pUTC"
                0x6b55706c: "uploaded", // "kUpl"
                0x63555254: "URLTrack", // "cURT"
                0x6b527455: "user", // "kRtU"
                0x63557350: "userPlaylist", // "cUsP"
                0x75743136: "UTF16Text", // "ut16"
                0x75746638: "UTF8Text", // "utf8"
                0x76657273: "version", // "vers"
                0x7056644b: "videoKind", // "pVdK"
                0x634e5057: "videoWindow", // "cNPW"
                0x70506c79: "view", // "pPly"
                0x70766973: "visible", // "pvis"
                0x63566973: "visual", // "cVis"
                0x70567345: "visualsEnabled", // "pVsE"
                0x7056537a: "visualSize", // "pVSz"
                0x6b4d644f: "voiceMemo", // "kMdO"
                0x7041646a: "volumeAdjustment", // "pAdj"
                0x77656420: "Wednesday", // "wed "
                0x77686974: "whitespace", // "whit"
                0x6377696e: "window", // "cwin"
                0x7057726b: "work", // "pWrk"
                0x70736374: "writingCode", // "psct"
                0x70597220: "year", // "pYr "
                0x79657320: "yes", // "yes "
                0x69737a6d: "zoomable", // "iszm"
                0x707a756d: "zoomed", // "pzum"
        ],
        propertyNames: [
                0x70416374: "active", // "pAct"
                0x7055524c: "address", // "pURL"
                0x70415045: "AirPlayEnabled", // "pAPE"
                0x70416c62: "album", // "pAlb"
                0x70416c41: "albumArtist", // "pAlA"
                0x70414874: "albumDisliked", // "pAHt"
                0x70414c76: "albumLoved", // "pALv"
                0x70416c52: "albumRating", // "pAlR"
                0x7041526b: "albumRatingKind", // "pARk"
                0x70417274: "artist", // "pArt"
                0x70417661: "available", // "pAva"
                0x70455131: "band1", // "pEQ1"
                0x70455130: "band10", // "pEQ0"
                0x70455132: "band2", // "pEQ2"
                0x70455133: "band3", // "pEQ3"
                0x70455134: "band4", // "pEQ4"
                0x70455135: "band5", // "pEQ5"
                0x70455136: "band6", // "pEQ6"
                0x70455137: "band7", // "pEQ7"
                0x70455138: "band8", // "pEQ8"
                0x70455139: "band9", // "pEQ9"
                0x70425274: "bitRate", // "pBRt"
                0x70426b74: "bookmark", // "pBkt"
                0x70426b6d: "bookmarkable", // "pBkm"
                0x70626e64: "bounds", // "pbnd"
                0x7042504d: "bpm", // "pBPM"
                0x63617061: "capacity", // "capa"
                0x70436174: "category", // "pCat"
                0x70636c73: "class_", // "pcls"
                0x68636c62: "closeable", // "hclb"
                0x70436c53: "cloudStatus", // "pClS"
                0x70575368: "collapseable", // "pWSh"
                0x77736864: "collapsed", // "wshd"
                0x6c77636c: "collating", // "lwcl"
                0x70436d74: "comment", // "pCmt"
                0x70416e74: "compilation", // "pAnt"
                0x70436d70: "composer", // "pCmp"
                0x63746e72: "container", // "ctnr"
                0x70436e76: "converting", // "pCnv"
                0x6c776370: "copies", // "lwcp"
                0x70415044: "currentAirPlayDevices", // "pAPD"
                0x70456e63: "currentEncoder", // "pEnc"
                0x70455150: "currentEQPreset", // "pEQP"
                0x70506c61: "currentPlaylist", // "pPla"
                0x70537454: "currentStreamTitle", // "pStT"
                0x70537455: "currentStreamURL", // "pStU"
                0x7054726b: "currentTrack", // "pTrk"
                0x70566973: "currentVisual", // "pVis"
                0x70504354: "data_", // "pPCT"
                0x70444944: "databaseID", // "pDID"
                0x70416464: "dateAdded", // "pAdd"
                0x70446573: "description_", // "pDes"
                0x70447343: "discCount", // "pDsC"
                0x7044734e: "discNumber", // "pDsN"
                0x70486174: "disliked", // "pHat"
                0x70446c41: "downloaded", // "pDlA"
                0x70444149: "downloaderAppleID", // "pDAI"
                0x70444e6d: "downloaderName", // "pDNm"
                0x70447572: "duration", // "pDur"
                0x656e626c: "enabled", // "enbl"
                0x6c776c70: "endingPage", // "lwlp"
                0x70457044: "episodeID", // "pEpD"
                0x7045704e: "episodeNumber", // "pEpN"
                0x70455170: "EQ", // "pEQp"
                0x70455120: "EQEnabled", // "pEQ "
                0x6c776568: "errorHandling", // "lweh"
                0x6661786e: "faxNumber", // "faxn"
                0x70537470: "finish", // "pStp"
                0x70466978: "fixedIndexing", // "pFix"
                0x70466d74: "format", // "pFmt"
                0x66727370: "freeSpace", // "frsp"
                0x70697366: "frontmost", // "pisf"
                0x70465363: "fullScreen", // "pFSc"
                0x7047706c: "gapless", // "pGpl"
                0x70476e73: "genius", // "pGns"
                0x7047656e: "genre", // "pGen"
                0x70477270: "grouping", // "pGrp"
                0x49442020: "id", // "ID  "
                0x70696478: "index", // "pidx"
                0x704b6e64: "kind", // "pKnd"
                0x704c6f63: "location", // "pLoc"
                0x704c6473: "longDescription", // "pLds"
                0x704c6f76: "loved", // "pLov"
                0x704c7972: "lyrics", // "pLyr"
                0x704d644b: "mediaKind", // "pMdK"
                0x704d6f64: "modifiable", // "pMod"
                0x61736d6f: "modificationDate", // "asmo"
                0x704d4e6d: "movement", // "pMNm"
                0x704d7643: "movementCount", // "pMvC"
                0x704d764e: "movementNumber", // "pMvN"
                0x704d7574: "mute", // "pMut"
                0x706e616d: "name", // "pnam"
                0x704d4143: "networkAddress", // "pMAC"
                0x6c776c61: "pagesAcross", // "lwla"
                0x6c776c64: "pagesDown", // "lwld"
                0x70506c50: "parent", // "pPlP"
                0x70504953: "persistentID", // "pPIS"
                0x70506c43: "playedCount", // "pPlC"
                0x70506c44: "playedDate", // "pPlD"
                0x70506f73: "playerPosition", // "pPos"
                0x70506c53: "playerState", // "pPlS"
                0x70706f73: "position", // "ppos"
                0x70455141: "preamp", // "pEQA"
                0x6c777066: "printerFeatures", // "lwpf"
                0x70414c4c: "properties", // "pALL"
                0x7050726f: "protected", // "pPro"
                0x70504149: "purchaserAppleID", // "pPAI"
                0x70504e6d: "purchaserName", // "pPNm"
                0x70527465: "rating", // "pRte"
                0x7052746b: "ratingKind", // "pRtk"
                0x70526177: "rawData", // "pRaw"
                0x70526c44: "releaseDate", // "pRlD"
                0x6c777174: "requestedPrintTime", // "lwqt"
                0x7072737a: "resizable", // "prsz"
                0x70535274: "sampleRate", // "pSRt"
                0x7053654e: "seasonNumber", // "pSeN"
                0x73656c63: "selected", // "selc"
                0x73656c65: "selection", // "sele"
                0x70536872: "shared", // "pShr"
                0x70536877: "show", // "pShw"
                0x70536661: "shufflable", // "pSfa"
                0x70536866: "shuffle", // "pShf"
                0x70536845: "shuffleEnabled", // "pShE"
                0x7053684d: "shuffleMode", // "pShM"
                0x7053697a: "size", // "pSiz"
                0x70536b43: "skippedCount", // "pSkC"
                0x70536b44: "skippedDate", // "pSkD"
                0x70536d74: "smart", // "pSmt"
                0x70527074: "songRepeat", // "pRpt"
                0x7053416c: "sortAlbum", // "pSAl"
                0x70534141: "sortAlbumArtist", // "pSAA"
                0x70534172: "sortArtist", // "pSAr"
                0x7053436d: "sortComposer", // "pSCm"
                0x70534e6d: "sortName", // "pSNm"
                0x7053534e: "sortShow", // "pSSN"
                0x70566f6c: "soundVolume", // "pVol"
                0x7053704b: "specialKind", // "pSpK"
                0x70537472: "start", // "pStr"
                0x6c776670: "startingPage", // "lwfp"
                0x70417564: "supportsAudio", // "pAud"
                0x70566964: "supportsVideo", // "pVid"
                0x74727072: "targetPrinter", // "trpr"
                0x7054696d: "time", // "pTim"
                0x70547243: "trackCount", // "pTrC"
                0x7054724e: "trackNumber", // "pTrN"
                0x70556e70: "unplayed", // "pUnp"
                0x70555443: "updateTracks", // "pUTC"
                0x76657273: "version", // "vers"
                0x7056644b: "videoKind", // "pVdK"
                0x70506c79: "view", // "pPly"
                0x70766973: "visible", // "pvis"
                0x70567345: "visualsEnabled", // "pVsE"
                0x7056537a: "visualSize", // "pVSz"
                0x7041646a: "volumeAdjustment", // "pAdj"
                0x7057726b: "work", // "pWrk"
                0x70597220: "year", // "pYr "
                0x69737a6d: "zoomable", // "iszm"
                0x707a756d: "zoomed", // "pzum"
        ],
        elementsNames: [
                0x63415044: ("AirPlayDevice", "AirPlayDevices"), // "cAPD"
                0x63617070: ("application", "applications"), // "capp"
                0x63417274: ("artwork", "artworks"), // "cArt"
                0x63434450: ("audioCDPlaylist", "audioCDPlaylists"), // "cCDP"
                0x63434454: ("audioCDTrack", "audioCDTracks"), // "cCDT"
                0x63427257: ("browserWindow", "browserWindows"), // "cBrW"
                0x63456e63: ("encoder", "encoders"), // "cEnc"
                0x63455150: ("EQPreset", "EQPresets"), // "cEQP"
                0x63455157: ("EQWindow", "EQWindows"), // "cEQW"
                0x63466c54: ("fileTrack", "fileTracks"), // "cFlT"
                0x63466f50: ("folderPlaylist", "folderPlaylists"), // "cFoP"
                0x636f626a: ("item", "items"), // "cobj"
                0x634c6950: ("libraryPlaylist", "libraryPlaylists"), // "cLiP"
                0x634d5057: ("miniplayerWindow", "miniplayerWindows"), // "cMPW"
                0x63506c79: ("playlist", "playlists"), // "cPly"
                0x63506c57: ("playlistWindow", "playlistWindows"), // "cPlW"
                0x63525450: ("radioTunerPlaylist", "radioTunerPlaylists"), // "cRTP"
                0x63536854: ("sharedTrack", "sharedTracks"), // "cShT"
                0x63537263: ("source", "sources"), // "cSrc"
                0x63537550: ("subscriptionPlaylist", "subscriptionPlaylists"), // "cSuP"
                0x6354726b: ("track", "tracks"), // "cTrk"
                0x63555254: ("URLTrack", "URLTracks"), // "cURT"
                0x63557350: ("userPlaylist", "userPlaylists"), // "cUsP"
                0x634e5057: ("videoWindow", "videoWindows"), // "cNPW"
                0x63566973: ("visual", "visuals"), // "cVis"
                0x6377696e: ("window", "windows"), // "cwin"
        ])

private let _glueClasses = SwiftAutomation.GlueClasses(
                                                insertionSpecifierType: ITUInsertion.self,
                                                objectSpecifierType: ITUItem.self,
                                                multiObjectSpecifierType: ITUItems.self,
                                                rootSpecifierType: ITURoot.self,
                                                applicationType: ITunes.self,
                                                symbolType: ITUSymbol.self,
                                                formatter: _specifierFormatter)

private let _untargetedAppData = SwiftAutomation.AppData(glueClasses: _glueClasses)


/******************************************************************************/
// Symbol subclass defines static type/enum/property constants based on iTunes.app terminology

public class ITUSymbol: SwiftAutomation.Symbol {

    override public var typeAliasName: String {return "ITU"}

    public override class func symbol(code: OSType, type: OSType = AppleEvents.typeType, descriptor: ScalarDescriptor? = nil) -> ITUSymbol {
        switch (code) {
        case 0x70416374: return self.active // "pAct"
        case 0x7055524c: return self.address // "pURL"
        case 0x6b41504f: return self.AirPlayDevice // "kAPO"
        case 0x63415044: return self.AirPlayDevice // "cAPD"
        case 0x70415045: return self.AirPlayEnabled // "pAPE"
        case 0x6b415058: return self.AirPortExpress // "kAPX"
        case 0x70416c62: return self.album // "pAlb"
        case 0x70416c41: return self.albumArtist // "pAlA"
        case 0x70414874: return self.albumDisliked // "pAHt"
        case 0x6b416c62: return self.albumListing // "kAlb"
        case 0x70414c76: return self.albumLoved // "pALv"
        case 0x70416c52: return self.albumRating // "pAlR"
        case 0x7041526b: return self.albumRatingKind // "pARk"
        case 0x6b536841: return self.albums // "kShA"
        case 0x6b53724c: return self.albums // "kSrL"
        case 0x6b4d644c: return self.alertTone // "kMdL"
        case 0x616c6973: return self.alias // "alis"
        case 0x6b416c6c: return self.all_ // "kAll"
        case 0x2a2a2a2a: return self.anything // "****"
        case 0x6b415054: return self.AppleTV // "kAPT"
        case 0x63617070: return self.application // "capp"
        case 0x62756e64: return self.applicationBundleID // "bund"
        case 0x7369676e: return self.applicationSignature // "sign"
        case 0x6170726c: return self.applicationURL // "aprl"
        case 0x61707220: return self.April // "apr "
        case 0x70417274: return self.artist // "pArt"
        case 0x6b537252: return self.artists // "kSrR"
        case 0x63417274: return self.artwork // "cArt"
        case 0x61736b20: return self.ask // "ask "
        case 0x6b4d6441: return self.audiobook // "kMdA"
        case 0x6b414344: return self.audioCD // "kACD"
        case 0x63434450: return self.audioCDPlaylist // "cCDP"
        case 0x63434454: return self.audioCDTrack // "cCDT"
        case 0x61756720: return self.August // "aug "
        case 0x70417661: return self.available // "pAva"
        case 0x70455131: return self.band1 // "pEQ1"
        case 0x70455130: return self.band10 // "pEQ0"
        case 0x70455132: return self.band2 // "pEQ2"
        case 0x70455133: return self.band3 // "pEQ3"
        case 0x70455134: return self.band4 // "pEQ4"
        case 0x70455135: return self.band5 // "pEQ5"
        case 0x70455136: return self.band6 // "pEQ6"
        case 0x70455137: return self.band7 // "pEQ7"
        case 0x70455138: return self.band8 // "pEQ8"
        case 0x70455139: return self.band9 // "pEQ9"
        case 0x62657374: return self.best // "best"
        case 0x70425274: return self.bitRate // "pBRt"
        case 0x6b415042: return self.BluetoothDevice // "kAPB"
        case 0x6b4d6442: return self.book // "kMdB"
        case 0x70426b74: return self.bookmark // "pBkt"
        case 0x70426b6d: return self.bookmarkable // "pBkm"
        case 0x626d726b: return self.bookmarkData // "bmrk"
        case 0x6b537041: return self.Books // "kSpA"
        case 0x626f6f6c: return self.boolean // "bool"
        case 0x71647274: return self.boundingRectangle // "qdrt"
        case 0x70626e64: return self.bounds // "pbnd"
        case 0x7042504d: return self.bpm // "pBPM"
        case 0x63427257: return self.browserWindow // "cBrW"
        case 0x63617061: return self.capacity // "capa"
        case 0x63617365: return self.case_ // "case"
        case 0x70436174: return self.category // "pCat"
        case 0x6b434469: return self.cdInsert // "kCDi"
        case 0x70636c73: return self.class_ // "pcls"
        case 0x68636c62: return self.closeable // "hclb"
        case 0x70436c53: return self.cloudStatus // "pClS"
        case 0x70575368: return self.collapseable // "pWSh"
        case 0x77736864: return self.collapsed // "wshd"
        case 0x6c77636c: return self.collating // "lwcl"
        case 0x636c7274: return self.colorTable // "clrt"
        case 0x70436d74: return self.comment // "pCmt"
        case 0x70416e74: return self.compilation // "pAnt"
        case 0x70436d70: return self.composer // "pCmp"
        case 0x6b537243: return self.composers // "kSrC"
        case 0x6b527443: return self.computed // "kRtC"
        case 0x6b415043: return self.computer // "kAPC"
        case 0x656e756d: return self.constant // "enum"
        case 0x63746e72: return self.container // "ctnr"
        case 0x70436e76: return self.converting // "pCnv"
        case 0x6c776370: return self.copies // "lwcp"
        case 0x70415044: return self.currentAirPlayDevices // "pAPD"
        case 0x70456e63: return self.currentEncoder // "pEnc"
        case 0x70455150: return self.currentEQPreset // "pEQP"
        case 0x70506c61: return self.currentPlaylist // "pPla"
        case 0x70537454: return self.currentStreamTitle // "pStT"
        case 0x70537455: return self.currentStreamURL // "pStU"
        case 0x7054726b: return self.currentTrack // "pTrk"
        case 0x70566973: return self.currentVisual // "pVis"
        case 0x74646173: return self.dashStyle // "tdas"
        case 0x74647461: return self.data // "tdta"
        case 0x70504354: return self.data_ // "pPCT"
        case 0x70444944: return self.databaseID // "pDID"
        case 0x6c647420: return self.date // "ldt "
        case 0x70416464: return self.dateAdded // "pAdd"
        case 0x64656320: return self.December // "dec "
        case 0x6465636d: return self.decimalStruct // "decm"
        case 0x70446573: return self.description_ // "pDes"
        case 0x6c776474: return self.detailed // "lwdt"
        case 0x64696163: return self.diacriticals // "diac"
        case 0x70447343: return self.discCount // "pDsC"
        case 0x7044734e: return self.discNumber // "pDsN"
        case 0x70486174: return self.disliked // "pHat"
        case 0x6b537256: return self.displayed // "kSrV"
        case 0x636f6d70: return self.doubleInteger // "comp"
        case 0x70446c41: return self.downloaded // "pDlA"
        case 0x70444149: return self.downloaderAppleID // "pDAI"
        case 0x70444e6d: return self.downloaderName // "pDNm"
        case 0x6b447570: return self.duplicate // "kDup"
        case 0x70447572: return self.duration // "pDur"
        case 0x656e626c: return self.enabled // "enbl"
        case 0x656e6373: return self.encodedString // "encs"
        case 0x63456e63: return self.encoder // "cEnc"
        case 0x6c776c70: return self.endingPage // "lwlp"
        case 0x70457044: return self.episodeID // "pEpD"
        case 0x7045704e: return self.episodeNumber // "pEpN"
        case 0x45505320: return self.EPSPicture // "EPS "
        case 0x70455170: return self.EQ // "pEQp"
        case 0x70455120: return self.EQEnabled // "pEQ "
        case 0x63455150: return self.EQPreset // "cEQP"
        case 0x63455157: return self.EQWindow // "cEQW"
        case 0x6b457272: return self.error // "kErr"
        case 0x6c776568: return self.errorHandling // "lweh"
        case 0x65787061: return self.expansion // "expa"
        case 0x6b505346: return self.fastForwarding // "kPSF"
        case 0x6661786e: return self.faxNumber // "faxn"
        case 0x66656220: return self.February // "feb "
        case 0x66737266: return self.fileRef // "fsrf"
        case 0x63466c54: return self.fileTrack // "cFlT"
        case 0x6675726c: return self.fileURL // "furl"
        case 0x70537470: return self.finish // "pStp"
        case 0x66697864: return self.fixed // "fixd"
        case 0x70466978: return self.fixedIndexing // "pFix"
        case 0x66706e74: return self.fixedPoint // "fpnt"
        case 0x66726374: return self.fixedRectangle // "frct"
        case 0x6b537046: return self.folder // "kSpF"
        case 0x63466f50: return self.folderPlaylist // "cFoP"
        case 0x70466d74: return self.format // "pFmt"
        case 0x66727370: return self.freeSpace // "frsp"
        case 0x66726920: return self.Friday // "fri "
        case 0x70697366: return self.frontmost // "pisf"
        case 0x70465363: return self.fullScreen // "pFSc"
        case 0x7047706c: return self.gapless // "pGpl"
        case 0x6b537047: return self.Genius // "kSpG"
        case 0x70476e73: return self.genius // "pGns"
        case 0x7047656e: return self.genre // "pGen"
        case 0x47494666: return self.GIFPicture // "GIFf"
        case 0x63677478: return self.graphicText // "cgtx"
        case 0x70477270: return self.grouping // "pGrp"
        case 0x6b536847: return self.groupings // "kShG"
        case 0x6b415048: return self.HomePod // "kAPH"
        case 0x6b566448: return self.homeVideo // "kVdH"
        case 0x68797068: return self.hyphens // "hyph"
        case 0x49442020: return self.id // "ID  "
        case 0x70696478: return self.index // "pidx"
        case 0x6b52656a: return self.ineligible // "kRej"
        case 0x6c6f6e67: return self.integer // "long"
        case 0x69747874: return self.internationalText // "itxt"
        case 0x696e746c: return self.internationalWritingCode // "intl"
        case 0x6b506f64: return self.iPod // "kPod"
        case 0x636f626a: return self.item // "cobj"
        case 0x6b495453: return self.iTunesStore // "kITS"
        case 0x6b537055: return self.iTunesU // "kSpU"
        case 0x6b4d6449: return self.iTunesU // "kMdI"
        case 0x6a616e20: return self.January // "jan "
        case 0x4a504547: return self.JPEGPicture // "JPEG"
        case 0x6a756c20: return self.July // "jul "
        case 0x6a756e20: return self.June // "jun "
        case 0x6b706964: return self.kernelProcessID // "kpid"
        case 0x704b6e64: return self.kind // "pKnd"
        case 0x6b56534c: return self.large // "kVSL"
        case 0x6c64626c: return self.largeReal // "ldbl"
        case 0x6b53704c: return self.Library // "kSpL"
        case 0x6b4c6962: return self.library // "kLib"
        case 0x634c6950: return self.libraryPlaylist // "cLiP"
        case 0x6c697374: return self.list // "list"
        case 0x704c6f63: return self.location // "pLoc"
        case 0x696e736c: return self.locationReference // "insl"
        case 0x704c6473: return self.longDescription // "pLds"
        case 0x6c667864: return self.longFixed // "lfxd"
        case 0x6c667074: return self.longFixedPoint // "lfpt"
        case 0x6c667263: return self.longFixedRectangle // "lfrc"
        case 0x6c706e74: return self.longPoint // "lpnt"
        case 0x6c726374: return self.longRectangle // "lrct"
        case 0x704c6f76: return self.loved // "pLov"
        case 0x704c7972: return self.lyrics // "pLyr"
        case 0x6d616368: return self.machine // "mach"
        case 0x6d4c6f63: return self.machineLocation // "mLoc"
        case 0x706f7274: return self.machPort // "port"
        case 0x6d617220: return self.March // "mar "
        case 0x6b4d6174: return self.matched // "kMat"
        case 0x6d617920: return self.May // "may "
        case 0x704d644b: return self.mediaKind // "pMdK"
        case 0x6b56534d: return self.medium // "kVSM"
        case 0x634d5057: return self.miniplayerWindow // "cMPW"
        case 0x704d6f64: return self.modifiable // "pMod"
        case 0x61736d6f: return self.modificationDate // "asmo"
        case 0x6d6f6e20: return self.Monday // "mon "
        case 0x704d4e6d: return self.movement // "pMNm"
        case 0x704d7643: return self.movementCount // "pMvC"
        case 0x704d764e: return self.movementNumber // "pMvN"
        case 0x6b56644d: return self.movie // "kVdM"
        case 0x6b537049: return self.Movies // "kSpI"
        case 0x6b4d4344: return self.MP3CD // "kMCD"
        case 0x6b53705a: return self.Music // "kSpZ"
        case 0x6b566456: return self.musicVideo // "kVdV"
        case 0x704d7574: return self.mute // "pMut"
        case 0x706e616d: return self.name // "pnam"
        case 0x704d4143: return self.networkAddress // "pMAC"
        case 0x6e6f2020: return self.no // "no  "
        case 0x6b526576: return self.noLongerAvailable // "kRev"
        case 0x6b4e6f6e: return self.none // "kNon"
        case 0x6b557050: return self.notUploaded // "kUpP"
        case 0x6e6f7620: return self.November // "nov "
        case 0x6e756c6c: return self.null // "null"
        case 0x6e756d65: return self.numericStrings // "nume"
        case 0x6f637420: return self.October // "oct "
        case 0x6b52704f: return self.off // "kRpO"
        case 0x6b527031: return self.one // "kRp1"
        case 0x6c776c61: return self.pagesAcross // "lwla"
        case 0x6c776c64: return self.pagesDown // "lwld"
        case 0x70506c50: return self.parent // "pPlP"
        case 0x6b505370: return self.paused // "kPSp"
        case 0x70504953: return self.persistentID // "pPIS"
        case 0x50494354: return self.picture // "PICT"
        case 0x74706d6d: return self.pixelMapRecord // "tpmm"
        case 0x70506c43: return self.playedCount // "pPlC"
        case 0x70506c44: return self.playedDate // "pPlD"
        case 0x70506f73: return self.playerPosition // "pPos"
        case 0x70506c53: return self.playerState // "pPlS"
        case 0x6b505350: return self.playing // "kPSP"
        case 0x63506c79: return self.playlist // "cPly"
        case 0x63506c57: return self.playlistWindow // "cPlW"
        case 0x6b4d6450: return self.podcast // "kMdP"
        case 0x6b537050: return self.Podcasts // "kSpP"
        case 0x51447074: return self.point // "QDpt"
        case 0x70706f73: return self.position // "ppos"
        case 0x70455141: return self.preamp // "pEQA"
        case 0x6c777066: return self.printerFeatures // "lwpf"
        case 0x70736574: return self.printSettings // "pset"
        case 0x70736e20: return self.processSerialNumber // "psn "
        case 0x70414c4c: return self.properties // "pALL"
        case 0x70726f70: return self.property_ // "prop"
        case 0x7050726f: return self.protected // "pPro"
        case 0x70756e63: return self.punctuation // "punc"
        case 0x6b507572: return self.purchased // "kPur"
        case 0x6b53704d: return self.PurchasedMusic // "kSpM"
        case 0x70504149: return self.purchaserAppleID // "pPAI"
        case 0x70504e6d: return self.purchaserName // "pPNm"
        case 0x6b54756e: return self.radioTuner // "kTun"
        case 0x63525450: return self.radioTunerPlaylist // "cRTP"
        case 0x70527465: return self.rating // "pRte"
        case 0x7052746b: return self.ratingKind // "pRtk"
        case 0x70526177: return self.rawData // "pRaw"
        case 0x646f7562: return self.real // "doub"
        case 0x7265636f: return self.record // "reco"
        case 0x6f626a20: return self.reference // "obj "
        case 0x70526c44: return self.releaseDate // "pRlD"
        case 0x6b52656d: return self.removed // "kRem"
        case 0x6c777174: return self.requestedPrintTime // "lwqt"
        case 0x7072737a: return self.resizable // "prsz"
        case 0x6b505352: return self.rewinding // "kPSR"
        case 0x74723136: return self.RGB16Color // "tr16"
        case 0x74723936: return self.RGB96Color // "tr96"
        case 0x63524742: return self.RGBColor // "cRGB"
        case 0x6b4d6452: return self.ringtone // "kMdR"
        case 0x74726f74: return self.rotation // "trot"
        case 0x70535274: return self.sampleRate // "pSRt"
        case 0x73617420: return self.Saturday // "sat "
        case 0x73637074: return self.script // "scpt"
        case 0x7053654e: return self.seasonNumber // "pSeN"
        case 0x73656c63: return self.selected // "selc"
        case 0x73656c65: return self.selection // "sele"
        case 0x73657020: return self.September // "sep "
        case 0x70536872: return self.shared // "pShr"
        case 0x6b536864: return self.sharedLibrary // "kShd"
        case 0x63536854: return self.sharedTrack // "cShT"
        case 0x73686f72: return self.shortInteger // "shor"
        case 0x70536877: return self.show // "pShw"
        case 0x70536661: return self.shufflable // "pSfa"
        case 0x70536866: return self.shuffle // "pShf"
        case 0x70536845: return self.shuffleEnabled // "pShE"
        case 0x7053684d: return self.shuffleMode // "pShM"
        case 0x7053697a: return self.size // "pSiz"
        case 0x70536b43: return self.skippedCount // "pSkC"
        case 0x70536b44: return self.skippedDate // "pSkD"
        case 0x6b565353: return self.small // "kVSS"
        case 0x73696e67: return self.smallReal // "sing"
        case 0x70536d74: return self.smart // "pSmt"
        case 0x6b4d6453: return self.song // "kMdS"
        case 0x70527074: return self.songRepeat // "pRpt"
        case 0x6b536853: return self.songs // "kShS"
        case 0x6b537253: return self.songs // "kSrS"
        case 0x7053416c: return self.sortAlbum // "pSAl"
        case 0x70534141: return self.sortAlbumArtist // "pSAA"
        case 0x70534172: return self.sortArtist // "pSAr"
        case 0x7053436d: return self.sortComposer // "pSCm"
        case 0x70534e6d: return self.sortName // "pSNm"
        case 0x7053534e: return self.sortShow // "pSSN"
        case 0x70566f6c: return self.soundVolume // "pVol"
        case 0x63537263: return self.source // "cSrc"
        case 0x7053704b: return self.specialKind // "pSpK"
        case 0x6c777374: return self.standard // "lwst"
        case 0x70537472: return self.start // "pStr"
        case 0x6c776670: return self.startingPage // "lwfp"
        case 0x6b505353: return self.stopped // "kPSS"
        case 0x54455854: return self.string // "TEXT"
        case 0x7374796c: return self.styledClipboardText // "styl"
        case 0x53545854: return self.styledText // "STXT"
        case 0x6b537562: return self.subscription // "kSub"
        case 0x63537550: return self.subscriptionPlaylist // "cSuP"
        case 0x73756e20: return self.Sunday // "sun "
        case 0x70417564: return self.supportsAudio // "pAud"
        case 0x70566964: return self.supportsVideo // "pVid"
        case 0x74727072: return self.targetPrinter // "trpr"
        case 0x74737479: return self.textStyleInfo // "tsty"
        case 0x74687520: return self.Thursday // "thu "
        case 0x54494646: return self.TIFFPicture // "TIFF"
        case 0x7054696d: return self.time // "pTim"
        case 0x6354726b: return self.track // "cTrk"
        case 0x70547243: return self.trackCount // "pTrC"
        case 0x6b54726b: return self.trackListing // "kTrk"
        case 0x7054724e: return self.trackNumber // "pTrN"
        case 0x74756520: return self.Tuesday // "tue "
        case 0x6b566454: return self.TVShow // "kVdT"
        case 0x6b537054: return self.TVShows // "kSpT"
        case 0x74797065: return self.typeClass // "type"
        case 0x75747874: return self.UnicodeText // "utxt"
        case 0x6b415055: return self.unknown // "kAPU"
        case 0x6b556e6b: return self.unknown // "kUnk"
        case 0x70556e70: return self.unplayed // "pUnp"
        case 0x75636f6d: return self.unsignedDoubleInteger // "ucom"
        case 0x6d61676e: return self.unsignedInteger // "magn"
        case 0x75736872: return self.unsignedShortInteger // "ushr"
        case 0x70555443: return self.updateTracks // "pUTC"
        case 0x6b55706c: return self.uploaded // "kUpl"
        case 0x63555254: return self.URLTrack // "cURT"
        case 0x6b527455: return self.user // "kRtU"
        case 0x63557350: return self.userPlaylist // "cUsP"
        case 0x75743136: return self.UTF16Text // "ut16"
        case 0x75746638: return self.UTF8Text // "utf8"
        case 0x76657273: return self.version // "vers"
        case 0x7056644b: return self.videoKind // "pVdK"
        case 0x634e5057: return self.videoWindow // "cNPW"
        case 0x70506c79: return self.view // "pPly"
        case 0x70766973: return self.visible // "pvis"
        case 0x63566973: return self.visual // "cVis"
        case 0x70567345: return self.visualsEnabled // "pVsE"
        case 0x7056537a: return self.visualSize // "pVSz"
        case 0x6b4d644f: return self.voiceMemo // "kMdO"
        case 0x7041646a: return self.volumeAdjustment // "pAdj"
        case 0x77656420: return self.Wednesday // "wed "
        case 0x77686974: return self.whitespace // "whit"
        case 0x6377696e: return self.window // "cwin"
        case 0x7057726b: return self.work // "pWrk"
        case 0x70736374: return self.writingCode // "psct"
        case 0x70597220: return self.year // "pYr "
        case 0x79657320: return self.yes // "yes "
        case 0x69737a6d: return self.zoomable // "iszm"
        case 0x707a756d: return self.zoomed // "pzum"
        default: return super.symbol(code: code, type: type, descriptor: descriptor) as! ITUSymbol
        }
    }

    // Types/properties
    public static let active = ITUSymbol(name: "active", code: 0x70416374, type: AppleEvents.typeType) // "pAct"
    public static let address = ITUSymbol(name: "address", code: 0x7055524c, type: AppleEvents.typeType) // "pURL"
    public static let AirPlayDevice = ITUSymbol(name: "AirPlayDevice", code: 0x63415044, type: AppleEvents.typeType) // "cAPD"
    public static let AirPlayEnabled = ITUSymbol(name: "AirPlayEnabled", code: 0x70415045, type: AppleEvents.typeType) // "pAPE"
    public static let album = ITUSymbol(name: "album", code: 0x70416c62, type: AppleEvents.typeType) // "pAlb"
    public static let albumArtist = ITUSymbol(name: "albumArtist", code: 0x70416c41, type: AppleEvents.typeType) // "pAlA"
    public static let albumDisliked = ITUSymbol(name: "albumDisliked", code: 0x70414874, type: AppleEvents.typeType) // "pAHt"
    public static let albumLoved = ITUSymbol(name: "albumLoved", code: 0x70414c76, type: AppleEvents.typeType) // "pALv"
    public static let albumRating = ITUSymbol(name: "albumRating", code: 0x70416c52, type: AppleEvents.typeType) // "pAlR"
    public static let albumRatingKind = ITUSymbol(name: "albumRatingKind", code: 0x7041526b, type: AppleEvents.typeType) // "pARk"
    public static let alias = ITUSymbol(name: "alias", code: 0x616c6973, type: AppleEvents.typeType) // "alis"
    public static let anything = ITUSymbol(name: "anything", code: 0x2a2a2a2a, type: AppleEvents.typeType) // "****"
    public static let application = ITUSymbol(name: "application", code: 0x63617070, type: AppleEvents.typeType) // "capp"
    public static let applicationBundleID = ITUSymbol(name: "applicationBundleID", code: 0x62756e64, type: AppleEvents.typeType) // "bund"
    public static let applicationSignature = ITUSymbol(name: "applicationSignature", code: 0x7369676e, type: AppleEvents.typeType) // "sign"
    public static let applicationURL = ITUSymbol(name: "applicationURL", code: 0x6170726c, type: AppleEvents.typeType) // "aprl"
    public static let April = ITUSymbol(name: "April", code: 0x61707220, type: AppleEvents.typeType) // "apr "
    public static let artist = ITUSymbol(name: "artist", code: 0x70417274, type: AppleEvents.typeType) // "pArt"
    public static let artwork = ITUSymbol(name: "artwork", code: 0x63417274, type: AppleEvents.typeType) // "cArt"
    public static let audioCDPlaylist = ITUSymbol(name: "audioCDPlaylist", code: 0x63434450, type: AppleEvents.typeType) // "cCDP"
    public static let audioCDTrack = ITUSymbol(name: "audioCDTrack", code: 0x63434454, type: AppleEvents.typeType) // "cCDT"
    public static let August = ITUSymbol(name: "August", code: 0x61756720, type: AppleEvents.typeType) // "aug "
    public static let available = ITUSymbol(name: "available", code: 0x70417661, type: AppleEvents.typeType) // "pAva"
    public static let band1 = ITUSymbol(name: "band1", code: 0x70455131, type: AppleEvents.typeType) // "pEQ1"
    public static let band10 = ITUSymbol(name: "band10", code: 0x70455130, type: AppleEvents.typeType) // "pEQ0"
    public static let band2 = ITUSymbol(name: "band2", code: 0x70455132, type: AppleEvents.typeType) // "pEQ2"
    public static let band3 = ITUSymbol(name: "band3", code: 0x70455133, type: AppleEvents.typeType) // "pEQ3"
    public static let band4 = ITUSymbol(name: "band4", code: 0x70455134, type: AppleEvents.typeType) // "pEQ4"
    public static let band5 = ITUSymbol(name: "band5", code: 0x70455135, type: AppleEvents.typeType) // "pEQ5"
    public static let band6 = ITUSymbol(name: "band6", code: 0x70455136, type: AppleEvents.typeType) // "pEQ6"
    public static let band7 = ITUSymbol(name: "band7", code: 0x70455137, type: AppleEvents.typeType) // "pEQ7"
    public static let band8 = ITUSymbol(name: "band8", code: 0x70455138, type: AppleEvents.typeType) // "pEQ8"
    public static let band9 = ITUSymbol(name: "band9", code: 0x70455139, type: AppleEvents.typeType) // "pEQ9"
    public static let best = ITUSymbol(name: "best", code: 0x62657374, type: AppleEvents.typeType) // "best"
    public static let bitRate = ITUSymbol(name: "bitRate", code: 0x70425274, type: AppleEvents.typeType) // "pBRt"
    public static let bookmark = ITUSymbol(name: "bookmark", code: 0x70426b74, type: AppleEvents.typeType) // "pBkt"
    public static let bookmarkable = ITUSymbol(name: "bookmarkable", code: 0x70426b6d, type: AppleEvents.typeType) // "pBkm"
    public static let bookmarkData = ITUSymbol(name: "bookmarkData", code: 0x626d726b, type: AppleEvents.typeType) // "bmrk"
    public static let boolean = ITUSymbol(name: "boolean", code: 0x626f6f6c, type: AppleEvents.typeType) // "bool"
    public static let boundingRectangle = ITUSymbol(name: "boundingRectangle", code: 0x71647274, type: AppleEvents.typeType) // "qdrt"
    public static let bounds = ITUSymbol(name: "bounds", code: 0x70626e64, type: AppleEvents.typeType) // "pbnd"
    public static let bpm = ITUSymbol(name: "bpm", code: 0x7042504d, type: AppleEvents.typeType) // "pBPM"
    public static let browserWindow = ITUSymbol(name: "browserWindow", code: 0x63427257, type: AppleEvents.typeType) // "cBrW"
    public static let capacity = ITUSymbol(name: "capacity", code: 0x63617061, type: AppleEvents.typeType) // "capa"
    public static let category = ITUSymbol(name: "category", code: 0x70436174, type: AppleEvents.typeType) // "pCat"
    public static let class_ = ITUSymbol(name: "class_", code: 0x70636c73, type: AppleEvents.typeType) // "pcls"
    public static let closeable = ITUSymbol(name: "closeable", code: 0x68636c62, type: AppleEvents.typeType) // "hclb"
    public static let cloudStatus = ITUSymbol(name: "cloudStatus", code: 0x70436c53, type: AppleEvents.typeType) // "pClS"
    public static let collapseable = ITUSymbol(name: "collapseable", code: 0x70575368, type: AppleEvents.typeType) // "pWSh"
    public static let collapsed = ITUSymbol(name: "collapsed", code: 0x77736864, type: AppleEvents.typeType) // "wshd"
    public static let collating = ITUSymbol(name: "collating", code: 0x6c77636c, type: AppleEvents.typeType) // "lwcl"
    public static let colorTable = ITUSymbol(name: "colorTable", code: 0x636c7274, type: AppleEvents.typeType) // "clrt"
    public static let comment = ITUSymbol(name: "comment", code: 0x70436d74, type: AppleEvents.typeType) // "pCmt"
    public static let compilation = ITUSymbol(name: "compilation", code: 0x70416e74, type: AppleEvents.typeType) // "pAnt"
    public static let composer = ITUSymbol(name: "composer", code: 0x70436d70, type: AppleEvents.typeType) // "pCmp"
    public static let constant = ITUSymbol(name: "constant", code: 0x656e756d, type: AppleEvents.typeType) // "enum"
    public static let container = ITUSymbol(name: "container", code: 0x63746e72, type: AppleEvents.typeType) // "ctnr"
    public static let converting = ITUSymbol(name: "converting", code: 0x70436e76, type: AppleEvents.typeType) // "pCnv"
    public static let copies = ITUSymbol(name: "copies", code: 0x6c776370, type: AppleEvents.typeType) // "lwcp"
    public static let currentAirPlayDevices = ITUSymbol(name: "currentAirPlayDevices", code: 0x70415044, type: AppleEvents.typeType) // "pAPD"
    public static let currentEncoder = ITUSymbol(name: "currentEncoder", code: 0x70456e63, type: AppleEvents.typeType) // "pEnc"
    public static let currentEQPreset = ITUSymbol(name: "currentEQPreset", code: 0x70455150, type: AppleEvents.typeType) // "pEQP"
    public static let currentPlaylist = ITUSymbol(name: "currentPlaylist", code: 0x70506c61, type: AppleEvents.typeType) // "pPla"
    public static let currentStreamTitle = ITUSymbol(name: "currentStreamTitle", code: 0x70537454, type: AppleEvents.typeType) // "pStT"
    public static let currentStreamURL = ITUSymbol(name: "currentStreamURL", code: 0x70537455, type: AppleEvents.typeType) // "pStU"
    public static let currentTrack = ITUSymbol(name: "currentTrack", code: 0x7054726b, type: AppleEvents.typeType) // "pTrk"
    public static let currentVisual = ITUSymbol(name: "currentVisual", code: 0x70566973, type: AppleEvents.typeType) // "pVis"
    public static let dashStyle = ITUSymbol(name: "dashStyle", code: 0x74646173, type: AppleEvents.typeType) // "tdas"
    public static let data = ITUSymbol(name: "data", code: 0x74647461, type: AppleEvents.typeType) // "tdta"
    public static let data_ = ITUSymbol(name: "data_", code: 0x70504354, type: AppleEvents.typeType) // "pPCT"
    public static let databaseID = ITUSymbol(name: "databaseID", code: 0x70444944, type: AppleEvents.typeType) // "pDID"
    public static let date = ITUSymbol(name: "date", code: 0x6c647420, type: AppleEvents.typeType) // "ldt "
    public static let dateAdded = ITUSymbol(name: "dateAdded", code: 0x70416464, type: AppleEvents.typeType) // "pAdd"
    public static let December = ITUSymbol(name: "December", code: 0x64656320, type: AppleEvents.typeType) // "dec "
    public static let decimalStruct = ITUSymbol(name: "decimalStruct", code: 0x6465636d, type: AppleEvents.typeType) // "decm"
    public static let description_ = ITUSymbol(name: "description_", code: 0x70446573, type: AppleEvents.typeType) // "pDes"
    public static let discCount = ITUSymbol(name: "discCount", code: 0x70447343, type: AppleEvents.typeType) // "pDsC"
    public static let discNumber = ITUSymbol(name: "discNumber", code: 0x7044734e, type: AppleEvents.typeType) // "pDsN"
    public static let disliked = ITUSymbol(name: "disliked", code: 0x70486174, type: AppleEvents.typeType) // "pHat"
    public static let doubleInteger = ITUSymbol(name: "doubleInteger", code: 0x636f6d70, type: AppleEvents.typeType) // "comp"
    public static let downloaded = ITUSymbol(name: "downloaded", code: 0x70446c41, type: AppleEvents.typeType) // "pDlA"
    public static let downloaderAppleID = ITUSymbol(name: "downloaderAppleID", code: 0x70444149, type: AppleEvents.typeType) // "pDAI"
    public static let downloaderName = ITUSymbol(name: "downloaderName", code: 0x70444e6d, type: AppleEvents.typeType) // "pDNm"
    public static let duration = ITUSymbol(name: "duration", code: 0x70447572, type: AppleEvents.typeType) // "pDur"
    public static let enabled = ITUSymbol(name: "enabled", code: 0x656e626c, type: AppleEvents.typeType) // "enbl"
    public static let encodedString = ITUSymbol(name: "encodedString", code: 0x656e6373, type: AppleEvents.typeType) // "encs"
    public static let encoder = ITUSymbol(name: "encoder", code: 0x63456e63, type: AppleEvents.typeType) // "cEnc"
    public static let endingPage = ITUSymbol(name: "endingPage", code: 0x6c776c70, type: AppleEvents.typeType) // "lwlp"
    public static let episodeID = ITUSymbol(name: "episodeID", code: 0x70457044, type: AppleEvents.typeType) // "pEpD"
    public static let episodeNumber = ITUSymbol(name: "episodeNumber", code: 0x7045704e, type: AppleEvents.typeType) // "pEpN"
    public static let EPSPicture = ITUSymbol(name: "EPSPicture", code: 0x45505320, type: AppleEvents.typeType) // "EPS "
    public static let EQ = ITUSymbol(name: "EQ", code: 0x70455170, type: AppleEvents.typeType) // "pEQp"
    public static let EQEnabled = ITUSymbol(name: "EQEnabled", code: 0x70455120, type: AppleEvents.typeType) // "pEQ "
    public static let EQPreset = ITUSymbol(name: "EQPreset", code: 0x63455150, type: AppleEvents.typeType) // "cEQP"
    public static let EQWindow = ITUSymbol(name: "EQWindow", code: 0x63455157, type: AppleEvents.typeType) // "cEQW"
    public static let errorHandling = ITUSymbol(name: "errorHandling", code: 0x6c776568, type: AppleEvents.typeType) // "lweh"
    public static let faxNumber = ITUSymbol(name: "faxNumber", code: 0x6661786e, type: AppleEvents.typeType) // "faxn"
    public static let February = ITUSymbol(name: "February", code: 0x66656220, type: AppleEvents.typeType) // "feb "
    public static let fileRef = ITUSymbol(name: "fileRef", code: 0x66737266, type: AppleEvents.typeType) // "fsrf"
    public static let fileTrack = ITUSymbol(name: "fileTrack", code: 0x63466c54, type: AppleEvents.typeType) // "cFlT"
    public static let fileURL = ITUSymbol(name: "fileURL", code: 0x6675726c, type: AppleEvents.typeType) // "furl"
    public static let finish = ITUSymbol(name: "finish", code: 0x70537470, type: AppleEvents.typeType) // "pStp"
    public static let fixed = ITUSymbol(name: "fixed", code: 0x66697864, type: AppleEvents.typeType) // "fixd"
    public static let fixedIndexing = ITUSymbol(name: "fixedIndexing", code: 0x70466978, type: AppleEvents.typeType) // "pFix"
    public static let fixedPoint = ITUSymbol(name: "fixedPoint", code: 0x66706e74, type: AppleEvents.typeType) // "fpnt"
    public static let fixedRectangle = ITUSymbol(name: "fixedRectangle", code: 0x66726374, type: AppleEvents.typeType) // "frct"
    public static let folderPlaylist = ITUSymbol(name: "folderPlaylist", code: 0x63466f50, type: AppleEvents.typeType) // "cFoP"
    public static let format = ITUSymbol(name: "format", code: 0x70466d74, type: AppleEvents.typeType) // "pFmt"
    public static let freeSpace = ITUSymbol(name: "freeSpace", code: 0x66727370, type: AppleEvents.typeType) // "frsp"
    public static let Friday = ITUSymbol(name: "Friday", code: 0x66726920, type: AppleEvents.typeType) // "fri "
    public static let frontmost = ITUSymbol(name: "frontmost", code: 0x70697366, type: AppleEvents.typeType) // "pisf"
    public static let fullScreen = ITUSymbol(name: "fullScreen", code: 0x70465363, type: AppleEvents.typeType) // "pFSc"
    public static let gapless = ITUSymbol(name: "gapless", code: 0x7047706c, type: AppleEvents.typeType) // "pGpl"
    public static let genius = ITUSymbol(name: "genius", code: 0x70476e73, type: AppleEvents.typeType) // "pGns"
    public static let genre = ITUSymbol(name: "genre", code: 0x7047656e, type: AppleEvents.typeType) // "pGen"
    public static let GIFPicture = ITUSymbol(name: "GIFPicture", code: 0x47494666, type: AppleEvents.typeType) // "GIFf"
    public static let graphicText = ITUSymbol(name: "graphicText", code: 0x63677478, type: AppleEvents.typeType) // "cgtx"
    public static let grouping = ITUSymbol(name: "grouping", code: 0x70477270, type: AppleEvents.typeType) // "pGrp"
    public static let id = ITUSymbol(name: "id", code: 0x49442020, type: AppleEvents.typeType) // "ID  "
    public static let index = ITUSymbol(name: "index", code: 0x70696478, type: AppleEvents.typeType) // "pidx"
    public static let integer = ITUSymbol(name: "integer", code: 0x6c6f6e67, type: AppleEvents.typeType) // "long"
    public static let internationalText = ITUSymbol(name: "internationalText", code: 0x69747874, type: AppleEvents.typeType) // "itxt"
    public static let internationalWritingCode = ITUSymbol(name: "internationalWritingCode", code: 0x696e746c, type: AppleEvents.typeType) // "intl"
    public static let item = ITUSymbol(name: "item", code: 0x636f626a, type: AppleEvents.typeType) // "cobj"
    public static let January = ITUSymbol(name: "January", code: 0x6a616e20, type: AppleEvents.typeType) // "jan "
    public static let JPEGPicture = ITUSymbol(name: "JPEGPicture", code: 0x4a504547, type: AppleEvents.typeType) // "JPEG"
    public static let July = ITUSymbol(name: "July", code: 0x6a756c20, type: AppleEvents.typeType) // "jul "
    public static let June = ITUSymbol(name: "June", code: 0x6a756e20, type: AppleEvents.typeType) // "jun "
    public static let kernelProcessID = ITUSymbol(name: "kernelProcessID", code: 0x6b706964, type: AppleEvents.typeType) // "kpid"
    public static let kind = ITUSymbol(name: "kind", code: 0x704b6e64, type: AppleEvents.typeType) // "pKnd"
    public static let largeReal = ITUSymbol(name: "largeReal", code: 0x6c64626c, type: AppleEvents.typeType) // "ldbl"
    public static let libraryPlaylist = ITUSymbol(name: "libraryPlaylist", code: 0x634c6950, type: AppleEvents.typeType) // "cLiP"
    public static let list = ITUSymbol(name: "list", code: 0x6c697374, type: AppleEvents.typeType) // "list"
    public static let location = ITUSymbol(name: "location", code: 0x704c6f63, type: AppleEvents.typeType) // "pLoc"
    public static let locationReference = ITUSymbol(name: "locationReference", code: 0x696e736c, type: AppleEvents.typeType) // "insl"
    public static let longDescription = ITUSymbol(name: "longDescription", code: 0x704c6473, type: AppleEvents.typeType) // "pLds"
    public static let longFixed = ITUSymbol(name: "longFixed", code: 0x6c667864, type: AppleEvents.typeType) // "lfxd"
    public static let longFixedPoint = ITUSymbol(name: "longFixedPoint", code: 0x6c667074, type: AppleEvents.typeType) // "lfpt"
    public static let longFixedRectangle = ITUSymbol(name: "longFixedRectangle", code: 0x6c667263, type: AppleEvents.typeType) // "lfrc"
    public static let longPoint = ITUSymbol(name: "longPoint", code: 0x6c706e74, type: AppleEvents.typeType) // "lpnt"
    public static let longRectangle = ITUSymbol(name: "longRectangle", code: 0x6c726374, type: AppleEvents.typeType) // "lrct"
    public static let loved = ITUSymbol(name: "loved", code: 0x704c6f76, type: AppleEvents.typeType) // "pLov"
    public static let lyrics = ITUSymbol(name: "lyrics", code: 0x704c7972, type: AppleEvents.typeType) // "pLyr"
    public static let machine = ITUSymbol(name: "machine", code: 0x6d616368, type: AppleEvents.typeType) // "mach"
    public static let machineLocation = ITUSymbol(name: "machineLocation", code: 0x6d4c6f63, type: AppleEvents.typeType) // "mLoc"
    public static let machPort = ITUSymbol(name: "machPort", code: 0x706f7274, type: AppleEvents.typeType) // "port"
    public static let March = ITUSymbol(name: "March", code: 0x6d617220, type: AppleEvents.typeType) // "mar "
    public static let May = ITUSymbol(name: "May", code: 0x6d617920, type: AppleEvents.typeType) // "may "
    public static let mediaKind = ITUSymbol(name: "mediaKind", code: 0x704d644b, type: AppleEvents.typeType) // "pMdK"
    public static let miniplayerWindow = ITUSymbol(name: "miniplayerWindow", code: 0x634d5057, type: AppleEvents.typeType) // "cMPW"
    public static let modifiable = ITUSymbol(name: "modifiable", code: 0x704d6f64, type: AppleEvents.typeType) // "pMod"
    public static let modificationDate = ITUSymbol(name: "modificationDate", code: 0x61736d6f, type: AppleEvents.typeType) // "asmo"
    public static let Monday = ITUSymbol(name: "Monday", code: 0x6d6f6e20, type: AppleEvents.typeType) // "mon "
    public static let movement = ITUSymbol(name: "movement", code: 0x704d4e6d, type: AppleEvents.typeType) // "pMNm"
    public static let movementCount = ITUSymbol(name: "movementCount", code: 0x704d7643, type: AppleEvents.typeType) // "pMvC"
    public static let movementNumber = ITUSymbol(name: "movementNumber", code: 0x704d764e, type: AppleEvents.typeType) // "pMvN"
    public static let mute = ITUSymbol(name: "mute", code: 0x704d7574, type: AppleEvents.typeType) // "pMut"
    public static let name = ITUSymbol(name: "name", code: 0x706e616d, type: AppleEvents.typeType) // "pnam"
    public static let networkAddress = ITUSymbol(name: "networkAddress", code: 0x704d4143, type: AppleEvents.typeType) // "pMAC"
    public static let November = ITUSymbol(name: "November", code: 0x6e6f7620, type: AppleEvents.typeType) // "nov "
    public static let null = ITUSymbol(name: "null", code: 0x6e756c6c, type: AppleEvents.typeType) // "null"
    public static let October = ITUSymbol(name: "October", code: 0x6f637420, type: AppleEvents.typeType) // "oct "
    public static let pagesAcross = ITUSymbol(name: "pagesAcross", code: 0x6c776c61, type: AppleEvents.typeType) // "lwla"
    public static let pagesDown = ITUSymbol(name: "pagesDown", code: 0x6c776c64, type: AppleEvents.typeType) // "lwld"
    public static let parent = ITUSymbol(name: "parent", code: 0x70506c50, type: AppleEvents.typeType) // "pPlP"
    public static let persistentID = ITUSymbol(name: "persistentID", code: 0x70504953, type: AppleEvents.typeType) // "pPIS"
    public static let PICTPicture = ITUSymbol(name: "PICTPicture", code: 0x50494354, type: AppleEvents.typeType) // "PICT"
    public static let picture = ITUSymbol(name: "picture", code: 0x50494354, type: AppleEvents.typeType) // "PICT"
    public static let pixelMapRecord = ITUSymbol(name: "pixelMapRecord", code: 0x74706d6d, type: AppleEvents.typeType) // "tpmm"
    public static let playedCount = ITUSymbol(name: "playedCount", code: 0x70506c43, type: AppleEvents.typeType) // "pPlC"
    public static let playedDate = ITUSymbol(name: "playedDate", code: 0x70506c44, type: AppleEvents.typeType) // "pPlD"
    public static let playerPosition = ITUSymbol(name: "playerPosition", code: 0x70506f73, type: AppleEvents.typeType) // "pPos"
    public static let playerState = ITUSymbol(name: "playerState", code: 0x70506c53, type: AppleEvents.typeType) // "pPlS"
    public static let playlist = ITUSymbol(name: "playlist", code: 0x63506c79, type: AppleEvents.typeType) // "cPly"
    public static let playlistWindow = ITUSymbol(name: "playlistWindow", code: 0x63506c57, type: AppleEvents.typeType) // "cPlW"
    public static let point = ITUSymbol(name: "point", code: 0x51447074, type: AppleEvents.typeType) // "QDpt"
    public static let position = ITUSymbol(name: "position", code: 0x70706f73, type: AppleEvents.typeType) // "ppos"
    public static let preamp = ITUSymbol(name: "preamp", code: 0x70455141, type: AppleEvents.typeType) // "pEQA"
    public static let printerFeatures = ITUSymbol(name: "printerFeatures", code: 0x6c777066, type: AppleEvents.typeType) // "lwpf"
    public static let printSettings = ITUSymbol(name: "printSettings", code: 0x70736574, type: AppleEvents.typeType) // "pset"
    public static let processSerialNumber = ITUSymbol(name: "processSerialNumber", code: 0x70736e20, type: AppleEvents.typeType) // "psn "
    public static let properties = ITUSymbol(name: "properties", code: 0x70414c4c, type: AppleEvents.typeType) // "pALL"
    public static let property_ = ITUSymbol(name: "property_", code: 0x70726f70, type: AppleEvents.typeType) // "prop"
    public static let protected = ITUSymbol(name: "protected", code: 0x7050726f, type: AppleEvents.typeType) // "pPro"
    public static let purchaserAppleID = ITUSymbol(name: "purchaserAppleID", code: 0x70504149, type: AppleEvents.typeType) // "pPAI"
    public static let purchaserName = ITUSymbol(name: "purchaserName", code: 0x70504e6d, type: AppleEvents.typeType) // "pPNm"
    public static let radioTunerPlaylist = ITUSymbol(name: "radioTunerPlaylist", code: 0x63525450, type: AppleEvents.typeType) // "cRTP"
    public static let rating = ITUSymbol(name: "rating", code: 0x70527465, type: AppleEvents.typeType) // "pRte"
    public static let ratingKind = ITUSymbol(name: "ratingKind", code: 0x7052746b, type: AppleEvents.typeType) // "pRtk"
    public static let rawData = ITUSymbol(name: "rawData", code: 0x70526177, type: AppleEvents.typeType) // "pRaw"
    public static let real = ITUSymbol(name: "real", code: 0x646f7562, type: AppleEvents.typeType) // "doub"
    public static let record = ITUSymbol(name: "record", code: 0x7265636f, type: AppleEvents.typeType) // "reco"
    public static let reference = ITUSymbol(name: "reference", code: 0x6f626a20, type: AppleEvents.typeType) // "obj "
    public static let releaseDate = ITUSymbol(name: "releaseDate", code: 0x70526c44, type: AppleEvents.typeType) // "pRlD"
    public static let requestedPrintTime = ITUSymbol(name: "requestedPrintTime", code: 0x6c777174, type: AppleEvents.typeType) // "lwqt"
    public static let resizable = ITUSymbol(name: "resizable", code: 0x7072737a, type: AppleEvents.typeType) // "prsz"
    public static let RGB16Color = ITUSymbol(name: "RGB16Color", code: 0x74723136, type: AppleEvents.typeType) // "tr16"
    public static let RGB96Color = ITUSymbol(name: "RGB96Color", code: 0x74723936, type: AppleEvents.typeType) // "tr96"
    public static let RGBColor = ITUSymbol(name: "RGBColor", code: 0x63524742, type: AppleEvents.typeType) // "cRGB"
    public static let rotation = ITUSymbol(name: "rotation", code: 0x74726f74, type: AppleEvents.typeType) // "trot"
    public static let sampleRate = ITUSymbol(name: "sampleRate", code: 0x70535274, type: AppleEvents.typeType) // "pSRt"
    public static let Saturday = ITUSymbol(name: "Saturday", code: 0x73617420, type: AppleEvents.typeType) // "sat "
    public static let script = ITUSymbol(name: "script", code: 0x73637074, type: AppleEvents.typeType) // "scpt"
    public static let seasonNumber = ITUSymbol(name: "seasonNumber", code: 0x7053654e, type: AppleEvents.typeType) // "pSeN"
    public static let selected = ITUSymbol(name: "selected", code: 0x73656c63, type: AppleEvents.typeType) // "selc"
    public static let selection = ITUSymbol(name: "selection", code: 0x73656c65, type: AppleEvents.typeType) // "sele"
    public static let September = ITUSymbol(name: "September", code: 0x73657020, type: AppleEvents.typeType) // "sep "
    public static let shared = ITUSymbol(name: "shared", code: 0x70536872, type: AppleEvents.typeType) // "pShr"
    public static let sharedTrack = ITUSymbol(name: "sharedTrack", code: 0x63536854, type: AppleEvents.typeType) // "cShT"
    public static let shortInteger = ITUSymbol(name: "shortInteger", code: 0x73686f72, type: AppleEvents.typeType) // "shor"
    public static let show = ITUSymbol(name: "show", code: 0x70536877, type: AppleEvents.typeType) // "pShw"
    public static let shufflable = ITUSymbol(name: "shufflable", code: 0x70536661, type: AppleEvents.typeType) // "pSfa"
    public static let shuffle = ITUSymbol(name: "shuffle", code: 0x70536866, type: AppleEvents.typeType) // "pShf"
    public static let shuffleEnabled = ITUSymbol(name: "shuffleEnabled", code: 0x70536845, type: AppleEvents.typeType) // "pShE"
    public static let shuffleMode = ITUSymbol(name: "shuffleMode", code: 0x7053684d, type: AppleEvents.typeType) // "pShM"
    public static let size = ITUSymbol(name: "size", code: 0x7053697a, type: AppleEvents.typeType) // "pSiz"
    public static let skippedCount = ITUSymbol(name: "skippedCount", code: 0x70536b43, type: AppleEvents.typeType) // "pSkC"
    public static let skippedDate = ITUSymbol(name: "skippedDate", code: 0x70536b44, type: AppleEvents.typeType) // "pSkD"
    public static let smallReal = ITUSymbol(name: "smallReal", code: 0x73696e67, type: AppleEvents.typeType) // "sing"
    public static let smart = ITUSymbol(name: "smart", code: 0x70536d74, type: AppleEvents.typeType) // "pSmt"
    public static let songRepeat = ITUSymbol(name: "songRepeat", code: 0x70527074, type: AppleEvents.typeType) // "pRpt"
    public static let sortAlbum = ITUSymbol(name: "sortAlbum", code: 0x7053416c, type: AppleEvents.typeType) // "pSAl"
    public static let sortAlbumArtist = ITUSymbol(name: "sortAlbumArtist", code: 0x70534141, type: AppleEvents.typeType) // "pSAA"
    public static let sortArtist = ITUSymbol(name: "sortArtist", code: 0x70534172, type: AppleEvents.typeType) // "pSAr"
    public static let sortComposer = ITUSymbol(name: "sortComposer", code: 0x7053436d, type: AppleEvents.typeType) // "pSCm"
    public static let sortName = ITUSymbol(name: "sortName", code: 0x70534e6d, type: AppleEvents.typeType) // "pSNm"
    public static let sortShow = ITUSymbol(name: "sortShow", code: 0x7053534e, type: AppleEvents.typeType) // "pSSN"
    public static let soundVolume = ITUSymbol(name: "soundVolume", code: 0x70566f6c, type: AppleEvents.typeType) // "pVol"
    public static let source = ITUSymbol(name: "source", code: 0x63537263, type: AppleEvents.typeType) // "cSrc"
    public static let specialKind = ITUSymbol(name: "specialKind", code: 0x7053704b, type: AppleEvents.typeType) // "pSpK"
    public static let start = ITUSymbol(name: "start", code: 0x70537472, type: AppleEvents.typeType) // "pStr"
    public static let startingPage = ITUSymbol(name: "startingPage", code: 0x6c776670, type: AppleEvents.typeType) // "lwfp"
    public static let string = ITUSymbol(name: "string", code: 0x54455854, type: AppleEvents.typeType) // "TEXT"
    public static let styledClipboardText = ITUSymbol(name: "styledClipboardText", code: 0x7374796c, type: AppleEvents.typeType) // "styl"
    public static let styledText = ITUSymbol(name: "styledText", code: 0x53545854, type: AppleEvents.typeType) // "STXT"
    public static let subscriptionPlaylist = ITUSymbol(name: "subscriptionPlaylist", code: 0x63537550, type: AppleEvents.typeType) // "cSuP"
    public static let Sunday = ITUSymbol(name: "Sunday", code: 0x73756e20, type: AppleEvents.typeType) // "sun "
    public static let supportsAudio = ITUSymbol(name: "supportsAudio", code: 0x70417564, type: AppleEvents.typeType) // "pAud"
    public static let supportsVideo = ITUSymbol(name: "supportsVideo", code: 0x70566964, type: AppleEvents.typeType) // "pVid"
    public static let targetPrinter = ITUSymbol(name: "targetPrinter", code: 0x74727072, type: AppleEvents.typeType) // "trpr"
    public static let textStyleInfo = ITUSymbol(name: "textStyleInfo", code: 0x74737479, type: AppleEvents.typeType) // "tsty"
    public static let Thursday = ITUSymbol(name: "Thursday", code: 0x74687520, type: AppleEvents.typeType) // "thu "
    public static let TIFFPicture = ITUSymbol(name: "TIFFPicture", code: 0x54494646, type: AppleEvents.typeType) // "TIFF"
    public static let time = ITUSymbol(name: "time", code: 0x7054696d, type: AppleEvents.typeType) // "pTim"
    public static let track = ITUSymbol(name: "track", code: 0x6354726b, type: AppleEvents.typeType) // "cTrk"
    public static let trackCount = ITUSymbol(name: "trackCount", code: 0x70547243, type: AppleEvents.typeType) // "pTrC"
    public static let trackNumber = ITUSymbol(name: "trackNumber", code: 0x7054724e, type: AppleEvents.typeType) // "pTrN"
    public static let Tuesday = ITUSymbol(name: "Tuesday", code: 0x74756520, type: AppleEvents.typeType) // "tue "
    public static let typeClass = ITUSymbol(name: "typeClass", code: 0x74797065, type: AppleEvents.typeType) // "type"
    public static let UnicodeText = ITUSymbol(name: "UnicodeText", code: 0x75747874, type: AppleEvents.typeType) // "utxt"
    public static let unplayed = ITUSymbol(name: "unplayed", code: 0x70556e70, type: AppleEvents.typeType) // "pUnp"
    public static let unsignedDoubleInteger = ITUSymbol(name: "unsignedDoubleInteger", code: 0x75636f6d, type: AppleEvents.typeType) // "ucom"
    public static let unsignedInteger = ITUSymbol(name: "unsignedInteger", code: 0x6d61676e, type: AppleEvents.typeType) // "magn"
    public static let unsignedShortInteger = ITUSymbol(name: "unsignedShortInteger", code: 0x75736872, type: AppleEvents.typeType) // "ushr"
    public static let updateTracks = ITUSymbol(name: "updateTracks", code: 0x70555443, type: AppleEvents.typeType) // "pUTC"
    public static let URLTrack = ITUSymbol(name: "URLTrack", code: 0x63555254, type: AppleEvents.typeType) // "cURT"
    public static let userPlaylist = ITUSymbol(name: "userPlaylist", code: 0x63557350, type: AppleEvents.typeType) // "cUsP"
    public static let UTF16Text = ITUSymbol(name: "UTF16Text", code: 0x75743136, type: AppleEvents.typeType) // "ut16"
    public static let UTF8Text = ITUSymbol(name: "UTF8Text", code: 0x75746638, type: AppleEvents.typeType) // "utf8"
    public static let version = ITUSymbol(name: "version", code: 0x76657273, type: AppleEvents.typeType) // "vers"
    public static let videoKind = ITUSymbol(name: "videoKind", code: 0x7056644b, type: AppleEvents.typeType) // "pVdK"
    public static let videoWindow = ITUSymbol(name: "videoWindow", code: 0x634e5057, type: AppleEvents.typeType) // "cNPW"
    public static let view = ITUSymbol(name: "view", code: 0x70506c79, type: AppleEvents.typeType) // "pPly"
    public static let visible = ITUSymbol(name: "visible", code: 0x70766973, type: AppleEvents.typeType) // "pvis"
    public static let visual = ITUSymbol(name: "visual", code: 0x63566973, type: AppleEvents.typeType) // "cVis"
    public static let visualsEnabled = ITUSymbol(name: "visualsEnabled", code: 0x70567345, type: AppleEvents.typeType) // "pVsE"
    public static let visualSize = ITUSymbol(name: "visualSize", code: 0x7056537a, type: AppleEvents.typeType) // "pVSz"
    public static let volumeAdjustment = ITUSymbol(name: "volumeAdjustment", code: 0x7041646a, type: AppleEvents.typeType) // "pAdj"
    public static let Wednesday = ITUSymbol(name: "Wednesday", code: 0x77656420, type: AppleEvents.typeType) // "wed "
    public static let window = ITUSymbol(name: "window", code: 0x6377696e, type: AppleEvents.typeType) // "cwin"
    public static let work = ITUSymbol(name: "work", code: 0x7057726b, type: AppleEvents.typeType) // "pWrk"
    public static let writingCode = ITUSymbol(name: "writingCode", code: 0x70736374, type: AppleEvents.typeType) // "psct"
    public static let year = ITUSymbol(name: "year", code: 0x70597220, type: AppleEvents.typeType) // "pYr "
    public static let zoomable = ITUSymbol(name: "zoomable", code: 0x69737a6d, type: AppleEvents.typeType) // "iszm"
    public static let zoomed = ITUSymbol(name: "zoomed", code: 0x707a756d, type: AppleEvents.typeType) // "pzum"

    // Enumerators
    public static let AirPortExpress = ITUSymbol(name: "AirPortExpress", code: 0x6b415058, type: AppleEvents.typeEnumerated) // "kAPX"
    public static let albumListing = ITUSymbol(name: "albumListing", code: 0x6b416c62, type: AppleEvents.typeEnumerated) // "kAlb"
    public static let albums = ITUSymbol(name: "albums", code: 0x6b536841, type: AppleEvents.typeEnumerated) // "kShA"
    public static let alertTone = ITUSymbol(name: "alertTone", code: 0x6b4d644c, type: AppleEvents.typeEnumerated) // "kMdL"
    public static let all_ = ITUSymbol(name: "all_", code: 0x6b416c6c, type: AppleEvents.typeEnumerated) // "kAll"
    public static let AppleTV = ITUSymbol(name: "AppleTV", code: 0x6b415054, type: AppleEvents.typeEnumerated) // "kAPT"
    public static let artists = ITUSymbol(name: "artists", code: 0x6b537252, type: AppleEvents.typeEnumerated) // "kSrR"
    public static let ask = ITUSymbol(name: "ask", code: 0x61736b20, type: AppleEvents.typeEnumerated) // "ask "
    public static let audiobook = ITUSymbol(name: "audiobook", code: 0x6b4d6441, type: AppleEvents.typeEnumerated) // "kMdA"
    public static let audioCD = ITUSymbol(name: "audioCD", code: 0x6b414344, type: AppleEvents.typeEnumerated) // "kACD"
    public static let BluetoothDevice = ITUSymbol(name: "BluetoothDevice", code: 0x6b415042, type: AppleEvents.typeEnumerated) // "kAPB"
    public static let book = ITUSymbol(name: "book", code: 0x6b4d6442, type: AppleEvents.typeEnumerated) // "kMdB"
    public static let Books = ITUSymbol(name: "Books", code: 0x6b537041, type: AppleEvents.typeEnumerated) // "kSpA"
    public static let case_ = ITUSymbol(name: "case_", code: 0x63617365, type: AppleEvents.typeEnumerated) // "case"
    public static let cdInsert = ITUSymbol(name: "cdInsert", code: 0x6b434469, type: AppleEvents.typeEnumerated) // "kCDi"
    public static let composers = ITUSymbol(name: "composers", code: 0x6b537243, type: AppleEvents.typeEnumerated) // "kSrC"
    public static let computed = ITUSymbol(name: "computed", code: 0x6b527443, type: AppleEvents.typeEnumerated) // "kRtC"
    public static let computer = ITUSymbol(name: "computer", code: 0x6b415043, type: AppleEvents.typeEnumerated) // "kAPC"
    public static let detailed = ITUSymbol(name: "detailed", code: 0x6c776474, type: AppleEvents.typeEnumerated) // "lwdt"
    public static let diacriticals = ITUSymbol(name: "diacriticals", code: 0x64696163, type: AppleEvents.typeEnumerated) // "diac"
    public static let displayed = ITUSymbol(name: "displayed", code: 0x6b537256, type: AppleEvents.typeEnumerated) // "kSrV"
    public static let duplicate = ITUSymbol(name: "duplicate", code: 0x6b447570, type: AppleEvents.typeEnumerated) // "kDup"
    public static let error = ITUSymbol(name: "error", code: 0x6b457272, type: AppleEvents.typeEnumerated) // "kErr"
    public static let expansion = ITUSymbol(name: "expansion", code: 0x65787061, type: AppleEvents.typeEnumerated) // "expa"
    public static let fastForwarding = ITUSymbol(name: "fastForwarding", code: 0x6b505346, type: AppleEvents.typeEnumerated) // "kPSF"
    public static let folder = ITUSymbol(name: "folder", code: 0x6b537046, type: AppleEvents.typeEnumerated) // "kSpF"
    public static let Genius = ITUSymbol(name: "Genius", code: 0x6b537047, type: AppleEvents.typeEnumerated) // "kSpG"
    public static let groupings = ITUSymbol(name: "groupings", code: 0x6b536847, type: AppleEvents.typeEnumerated) // "kShG"
    public static let HomePod = ITUSymbol(name: "HomePod", code: 0x6b415048, type: AppleEvents.typeEnumerated) // "kAPH"
    public static let homeVideo = ITUSymbol(name: "homeVideo", code: 0x6b566448, type: AppleEvents.typeEnumerated) // "kVdH"
    public static let hyphens = ITUSymbol(name: "hyphens", code: 0x68797068, type: AppleEvents.typeEnumerated) // "hyph"
    public static let ineligible = ITUSymbol(name: "ineligible", code: 0x6b52656a, type: AppleEvents.typeEnumerated) // "kRej"
    public static let iPod = ITUSymbol(name: "iPod", code: 0x6b506f64, type: AppleEvents.typeEnumerated) // "kPod"
    public static let iTunesStore = ITUSymbol(name: "iTunesStore", code: 0x6b495453, type: AppleEvents.typeEnumerated) // "kITS"
    public static let iTunesU = ITUSymbol(name: "iTunesU", code: 0x6b537055, type: AppleEvents.typeEnumerated) // "kSpU"
    public static let large = ITUSymbol(name: "large", code: 0x6b56534c, type: AppleEvents.typeEnumerated) // "kVSL"
    public static let Library = ITUSymbol(name: "Library", code: 0x6b53704c, type: AppleEvents.typeEnumerated) // "kSpL"
    public static let library = ITUSymbol(name: "library", code: 0x6b4c6962, type: AppleEvents.typeEnumerated) // "kLib"
    public static let matched = ITUSymbol(name: "matched", code: 0x6b4d6174, type: AppleEvents.typeEnumerated) // "kMat"
    public static let medium = ITUSymbol(name: "medium", code: 0x6b56534d, type: AppleEvents.typeEnumerated) // "kVSM"
    public static let movie = ITUSymbol(name: "movie", code: 0x6b56644d, type: AppleEvents.typeEnumerated) // "kVdM"
    public static let Movies = ITUSymbol(name: "Movies", code: 0x6b537049, type: AppleEvents.typeEnumerated) // "kSpI"
    public static let MP3CD = ITUSymbol(name: "MP3CD", code: 0x6b4d4344, type: AppleEvents.typeEnumerated) // "kMCD"
    public static let Music = ITUSymbol(name: "Music", code: 0x6b53705a, type: AppleEvents.typeEnumerated) // "kSpZ"
    public static let musicVideo = ITUSymbol(name: "musicVideo", code: 0x6b566456, type: AppleEvents.typeEnumerated) // "kVdV"
    public static let no = ITUSymbol(name: "no", code: 0x6e6f2020, type: AppleEvents.typeEnumerated) // "no  "
    public static let noLongerAvailable = ITUSymbol(name: "noLongerAvailable", code: 0x6b526576, type: AppleEvents.typeEnumerated) // "kRev"
    public static let none = ITUSymbol(name: "none", code: 0x6b4e6f6e, type: AppleEvents.typeEnumerated) // "kNon"
    public static let notUploaded = ITUSymbol(name: "notUploaded", code: 0x6b557050, type: AppleEvents.typeEnumerated) // "kUpP"
    public static let numericStrings = ITUSymbol(name: "numericStrings", code: 0x6e756d65, type: AppleEvents.typeEnumerated) // "nume"
    public static let off = ITUSymbol(name: "off", code: 0x6b52704f, type: AppleEvents.typeEnumerated) // "kRpO"
    public static let one = ITUSymbol(name: "one", code: 0x6b527031, type: AppleEvents.typeEnumerated) // "kRp1"
    public static let paused = ITUSymbol(name: "paused", code: 0x6b505370, type: AppleEvents.typeEnumerated) // "kPSp"
    public static let playing = ITUSymbol(name: "playing", code: 0x6b505350, type: AppleEvents.typeEnumerated) // "kPSP"
    public static let podcast = ITUSymbol(name: "podcast", code: 0x6b4d6450, type: AppleEvents.typeEnumerated) // "kMdP"
    public static let Podcasts = ITUSymbol(name: "Podcasts", code: 0x6b537050, type: AppleEvents.typeEnumerated) // "kSpP"
    public static let punctuation = ITUSymbol(name: "punctuation", code: 0x70756e63, type: AppleEvents.typeEnumerated) // "punc"
    public static let purchased = ITUSymbol(name: "purchased", code: 0x6b507572, type: AppleEvents.typeEnumerated) // "kPur"
    public static let PurchasedMusic = ITUSymbol(name: "PurchasedMusic", code: 0x6b53704d, type: AppleEvents.typeEnumerated) // "kSpM"
    public static let radioTuner = ITUSymbol(name: "radioTuner", code: 0x6b54756e, type: AppleEvents.typeEnumerated) // "kTun"
    public static let removed = ITUSymbol(name: "removed", code: 0x6b52656d, type: AppleEvents.typeEnumerated) // "kRem"
    public static let rewinding = ITUSymbol(name: "rewinding", code: 0x6b505352, type: AppleEvents.typeEnumerated) // "kPSR"
    public static let ringtone = ITUSymbol(name: "ringtone", code: 0x6b4d6452, type: AppleEvents.typeEnumerated) // "kMdR"
    public static let sharedLibrary = ITUSymbol(name: "sharedLibrary", code: 0x6b536864, type: AppleEvents.typeEnumerated) // "kShd"
    public static let small = ITUSymbol(name: "small", code: 0x6b565353, type: AppleEvents.typeEnumerated) // "kVSS"
    public static let song = ITUSymbol(name: "song", code: 0x6b4d6453, type: AppleEvents.typeEnumerated) // "kMdS"
    public static let songs = ITUSymbol(name: "songs", code: 0x6b536853, type: AppleEvents.typeEnumerated) // "kShS"
    public static let standard = ITUSymbol(name: "standard", code: 0x6c777374, type: AppleEvents.typeEnumerated) // "lwst"
    public static let stopped = ITUSymbol(name: "stopped", code: 0x6b505353, type: AppleEvents.typeEnumerated) // "kPSS"
    public static let subscription = ITUSymbol(name: "subscription", code: 0x6b537562, type: AppleEvents.typeEnumerated) // "kSub"
    public static let trackListing = ITUSymbol(name: "trackListing", code: 0x6b54726b, type: AppleEvents.typeEnumerated) // "kTrk"
    public static let TVShow = ITUSymbol(name: "TVShow", code: 0x6b566454, type: AppleEvents.typeEnumerated) // "kVdT"
    public static let TVShows = ITUSymbol(name: "TVShows", code: 0x6b537054, type: AppleEvents.typeEnumerated) // "kSpT"
    public static let unknown = ITUSymbol(name: "unknown", code: 0x6b556e6b, type: AppleEvents.typeEnumerated) // "kUnk"
    public static let uploaded = ITUSymbol(name: "uploaded", code: 0x6b55706c, type: AppleEvents.typeEnumerated) // "kUpl"
    public static let user = ITUSymbol(name: "user", code: 0x6b527455, type: AppleEvents.typeEnumerated) // "kRtU"
    public static let voiceMemo = ITUSymbol(name: "voiceMemo", code: 0x6b4d644f, type: AppleEvents.typeEnumerated) // "kMdO"
    public static let whitespace = ITUSymbol(name: "whitespace", code: 0x77686974, type: AppleEvents.typeEnumerated) // "whit"
    public static let yes = ITUSymbol(name: "yes", code: 0x79657320, type: AppleEvents.typeEnumerated) // "yes "
}

public typealias ITU = ITUSymbol // allows symbols to be written as (e.g.) ITU.name instead of ITUSymbol.name


/******************************************************************************/
// Specifier extensions; these add command methods and property/elements getters based on iTunes.app terminology

public protocol ITUCommand: SwiftAutomation.SpecifierProtocol {} // provides AE dispatch methods

// Command->Any will be bound when return type can't be inferred, else Command->T

extension ITUCommand {
    @discardableResult public func activate(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "activate", event: 0x6d697363_61637476, // "miscactv"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func activate<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "activate", event: 0x6d697363_61637476, // "miscactv"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func add(_ directParameter: Any = SwiftAutomation.NoParameter,
            to: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "add", event: 0x686f6f6b_41646420, // "hookAdd "
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x696e7368, to), // "insh"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func add<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            to: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "add", event: 0x686f6f6b_41646420, // "hookAdd "
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x696e7368, to), // "insh"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func backTrack(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "backTrack", event: 0x686f6f6b_4261636b, // "hookBack"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func backTrack<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "backTrack", event: 0x686f6f6b_4261636b, // "hookBack"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func close(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "close", event: 0x636f7265_636c6f73, // "coreclos"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func close<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "close", event: 0x636f7265_636c6f73, // "coreclos"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func convert(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "convert", event: 0x686f6f6b_436f6e76, // "hookConv"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func convert<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "convert", event: 0x686f6f6b_436f6e76, // "hookConv"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func count(_ directParameter: Any = SwiftAutomation.NoParameter,
            each: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "count", event: 0x636f7265_636e7465, // "corecnte"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("each", 0x6b6f636c, each), // "kocl"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func count<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            each: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "count", event: 0x636f7265_636e7465, // "corecnte"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("each", 0x6b6f636c, each), // "kocl"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func delete(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "delete", event: 0x636f7265_64656c6f, // "coredelo"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func delete<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "delete", event: 0x636f7265_64656c6f, // "coredelo"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func download(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "download", event: 0x686f6f6b_44776e6c, // "hookDwnl"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func download<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "download", event: 0x686f6f6b_44776e6c, // "hookDwnl"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func duplicate(_ directParameter: Any = SwiftAutomation.NoParameter,
            to: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "duplicate", event: 0x636f7265_636c6f6e, // "coreclon"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x696e7368, to), // "insh"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func duplicate<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            to: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "duplicate", event: 0x636f7265_636c6f6e, // "coreclon"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x696e7368, to), // "insh"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func eject(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "eject", event: 0x686f6f6b_456a6374, // "hookEjct"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func eject<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "eject", event: 0x686f6f6b_456a6374, // "hookEjct"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func exists(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "exists", event: 0x636f7265_646f6578, // "coredoex"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func exists<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "exists", event: 0x636f7265_646f6578, // "coredoex"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func fastForward(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "fastForward", event: 0x686f6f6b_46617374, // "hookFast"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func fastForward<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "fastForward", event: 0x686f6f6b_46617374, // "hookFast"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func get(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "get", event: 0x636f7265_67657464, // "coregetd"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func get<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "get", event: 0x636f7265_67657464, // "coregetd"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func make(_ directParameter: Any = SwiftAutomation.NoParameter,
            new: Any = SwiftAutomation.NoParameter,
            at: Any = SwiftAutomation.NoParameter,
            withProperties: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "make", event: 0x636f7265_6372656c, // "corecrel"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("new", 0x6b6f636c, new), // "kocl"
                    ("at", 0x696e7368, at), // "insh"
                    ("withProperties", 0x70726474, withProperties), // "prdt"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func make<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            new: Any = SwiftAutomation.NoParameter,
            at: Any = SwiftAutomation.NoParameter,
            withProperties: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "make", event: 0x636f7265_6372656c, // "corecrel"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("new", 0x6b6f636c, new), // "kocl"
                    ("at", 0x696e7368, at), // "insh"
                    ("withProperties", 0x70726474, withProperties), // "prdt"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func move(_ directParameter: Any = SwiftAutomation.NoParameter,
            to: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "move", event: 0x636f7265_6d6f7665, // "coremove"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x696e7368, to), // "insh"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func move<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            to: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "move", event: 0x636f7265_6d6f7665, // "coremove"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x696e7368, to), // "insh"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func nextTrack(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "nextTrack", event: 0x686f6f6b_4e657874, // "hookNext"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func nextTrack<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "nextTrack", event: 0x686f6f6b_4e657874, // "hookNext"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func open(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "open", event: 0x61657674_6f646f63, // "aevtodoc"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func open<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "open", event: 0x61657674_6f646f63, // "aevtodoc"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func openLocation(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "openLocation", event: 0x4755524c_4755524c, // "GURLGURL"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func openLocation<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "openLocation", event: 0x4755524c_4755524c, // "GURLGURL"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func pause(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "pause", event: 0x686f6f6b_50617573, // "hookPaus"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func pause<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "pause", event: 0x686f6f6b_50617573, // "hookPaus"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func play(_ directParameter: Any = SwiftAutomation.NoParameter,
            once: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "play", event: 0x686f6f6b_506c6179, // "hookPlay"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("once", 0x504f6e65, once), // "POne"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func play<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            once: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "play", event: 0x686f6f6b_506c6179, // "hookPlay"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("once", 0x504f6e65, once), // "POne"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func playpause(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "playpause", event: 0x686f6f6b_506c5073, // "hookPlPs"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func playpause<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "playpause", event: 0x686f6f6b_506c5073, // "hookPlPs"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func previousTrack(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "previousTrack", event: 0x686f6f6b_50726576, // "hookPrev"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func previousTrack<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "previousTrack", event: 0x686f6f6b_50726576, // "hookPrev"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func print(_ directParameter: Any = SwiftAutomation.NoParameter,
            printDialog: Any = SwiftAutomation.NoParameter,
            withProperties: Any = SwiftAutomation.NoParameter,
            kind: Any = SwiftAutomation.NoParameter,
            theme: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "print", event: 0x61657674_70646f63, // "aevtpdoc"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("printDialog", 0x70646c67, printDialog), // "pdlg"
                    ("withProperties", 0x70726474, withProperties), // "prdt"
                    ("kind", 0x704b6e64, kind), // "pKnd"
                    ("theme", 0x7054686d, theme), // "pThm"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func print<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            printDialog: Any = SwiftAutomation.NoParameter,
            withProperties: Any = SwiftAutomation.NoParameter,
            kind: Any = SwiftAutomation.NoParameter,
            theme: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "print", event: 0x61657674_70646f63, // "aevtpdoc"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("printDialog", 0x70646c67, printDialog), // "pdlg"
                    ("withProperties", 0x70726474, withProperties), // "prdt"
                    ("kind", 0x704b6e64, kind), // "pKnd"
                    ("theme", 0x7054686d, theme), // "pThm"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func quit(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "quit", event: 0x61657674_71756974, // "aevtquit"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func quit<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "quit", event: 0x61657674_71756974, // "aevtquit"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func refresh(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "refresh", event: 0x686f6f6b_52667273, // "hookRfrs"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func refresh<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "refresh", event: 0x686f6f6b_52667273, // "hookRfrs"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func reopen(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "reopen", event: 0x61657674_72617070, // "aevtrapp"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func reopen<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "reopen", event: 0x61657674_72617070, // "aevtrapp"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func resume(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "resume", event: 0x686f6f6b_52657375, // "hookResu"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func resume<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "resume", event: 0x686f6f6b_52657375, // "hookResu"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func reveal(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "reveal", event: 0x686f6f6b_5265766c, // "hookRevl"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func reveal<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "reveal", event: 0x686f6f6b_5265766c, // "hookRevl"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func rewind(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "rewind", event: 0x686f6f6b_52776e64, // "hookRwnd"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func rewind<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "rewind", event: 0x686f6f6b_52776e64, // "hookRwnd"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func run(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "run", event: 0x61657674_6f617070, // "aevtoapp"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func run<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "run", event: 0x61657674_6f617070, // "aevtoapp"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func save(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "save", event: 0x636f7265_73617665, // "coresave"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func save<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "save", event: 0x636f7265_73617665, // "coresave"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func search(_ directParameter: Any = SwiftAutomation.NoParameter,
            for_: Any = SwiftAutomation.NoParameter,
            only: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "search", event: 0x686f6f6b_53726368, // "hookSrch"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("for_", 0x7054726d, for_), // "pTrm"
                    ("only", 0x70417265, only), // "pAre"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func search<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            for_: Any = SwiftAutomation.NoParameter,
            only: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "search", event: 0x686f6f6b_53726368, // "hookSrch"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("for_", 0x7054726d, for_), // "pTrm"
                    ("only", 0x70417265, only), // "pAre"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func select(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "select", event: 0x6d697363_736c6374, // "miscslct"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func select<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "select", event: 0x6d697363_736c6374, // "miscslct"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func set(_ directParameter: Any = SwiftAutomation.NoParameter,
            to: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "set", event: 0x636f7265_73657464, // "coresetd"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x64617461, to), // "data"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func set<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            to: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "set", event: 0x636f7265_73657464, // "coresetd"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x64617461, to), // "data"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func stop(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "stop", event: 0x686f6f6b_53746f70, // "hookStop"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func stop<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "stop", event: 0x686f6f6b_53746f70, // "hookStop"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func subscribe(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "subscribe", event: 0x686f6f6b_70537562, // "hookpSub"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func subscribe<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "subscribe", event: 0x686f6f6b_70537562, // "hookpSub"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func update(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "update", event: 0x686f6f6b_55706474, // "hookUpdt"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func update<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "update", event: 0x686f6f6b_55706474, // "hookUpdt"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func updateAllPodcasts(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "updateAllPodcasts", event: 0x686f6f6b_55706470, // "hookUpdp"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func updateAllPodcasts<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "updateAllPodcasts", event: 0x686f6f6b_55706470, // "hookUpdp"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func updatePodcast(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "updatePodcast", event: 0x686f6f6b_55706431, // "hookUpd1"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func updatePodcast<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "updatePodcast", event: 0x686f6f6b_55706431, // "hookUpd1"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
}


public protocol ITUObject: SwiftAutomation.ObjectSpecifierExtension, ITUCommand {} // provides vars and methods for constructing specifiers

extension ITUObject {

    // Properties
    public var active: ITUItem {return self.property(0x70416374) as! ITUItem} // "pAct"
    public var address: ITUItem {return self.property(0x7055524c) as! ITUItem} // "pURL"
    public var AirPlayEnabled: ITUItem {return self.property(0x70415045) as! ITUItem} // "pAPE"
    public var album: ITUItem {return self.property(0x70416c62) as! ITUItem} // "pAlb"
    public var albumArtist: ITUItem {return self.property(0x70416c41) as! ITUItem} // "pAlA"
    public var albumDisliked: ITUItem {return self.property(0x70414874) as! ITUItem} // "pAHt"
    public var albumLoved: ITUItem {return self.property(0x70414c76) as! ITUItem} // "pALv"
    public var albumRating: ITUItem {return self.property(0x70416c52) as! ITUItem} // "pAlR"
    public var albumRatingKind: ITUItem {return self.property(0x7041526b) as! ITUItem} // "pARk"
    public var artist: ITUItem {return self.property(0x70417274) as! ITUItem} // "pArt"
    public var available: ITUItem {return self.property(0x70417661) as! ITUItem} // "pAva"
    public var band1: ITUItem {return self.property(0x70455131) as! ITUItem} // "pEQ1"
    public var band10: ITUItem {return self.property(0x70455130) as! ITUItem} // "pEQ0"
    public var band2: ITUItem {return self.property(0x70455132) as! ITUItem} // "pEQ2"
    public var band3: ITUItem {return self.property(0x70455133) as! ITUItem} // "pEQ3"
    public var band4: ITUItem {return self.property(0x70455134) as! ITUItem} // "pEQ4"
    public var band5: ITUItem {return self.property(0x70455135) as! ITUItem} // "pEQ5"
    public var band6: ITUItem {return self.property(0x70455136) as! ITUItem} // "pEQ6"
    public var band7: ITUItem {return self.property(0x70455137) as! ITUItem} // "pEQ7"
    public var band8: ITUItem {return self.property(0x70455138) as! ITUItem} // "pEQ8"
    public var band9: ITUItem {return self.property(0x70455139) as! ITUItem} // "pEQ9"
    public var bitRate: ITUItem {return self.property(0x70425274) as! ITUItem} // "pBRt"
    public var bookmark: ITUItem {return self.property(0x70426b74) as! ITUItem} // "pBkt"
    public var bookmarkable: ITUItem {return self.property(0x70426b6d) as! ITUItem} // "pBkm"
    public var bounds: ITUItem {return self.property(0x70626e64) as! ITUItem} // "pbnd"
    public var bpm: ITUItem {return self.property(0x7042504d) as! ITUItem} // "pBPM"
    public var capacity: ITUItem {return self.property(0x63617061) as! ITUItem} // "capa"
    public var category: ITUItem {return self.property(0x70436174) as! ITUItem} // "pCat"
    public var class_: ITUItem {return self.property(0x70636c73) as! ITUItem} // "pcls"
    public var closeable: ITUItem {return self.property(0x68636c62) as! ITUItem} // "hclb"
    public var cloudStatus: ITUItem {return self.property(0x70436c53) as! ITUItem} // "pClS"
    public var collapseable: ITUItem {return self.property(0x70575368) as! ITUItem} // "pWSh"
    public var collapsed: ITUItem {return self.property(0x77736864) as! ITUItem} // "wshd"
    public var collating: ITUItem {return self.property(0x6c77636c) as! ITUItem} // "lwcl"
    public var comment: ITUItem {return self.property(0x70436d74) as! ITUItem} // "pCmt"
    public var compilation: ITUItem {return self.property(0x70416e74) as! ITUItem} // "pAnt"
    public var composer: ITUItem {return self.property(0x70436d70) as! ITUItem} // "pCmp"
    public var container: ITUItem {return self.property(0x63746e72) as! ITUItem} // "ctnr"
    public var converting: ITUItem {return self.property(0x70436e76) as! ITUItem} // "pCnv"
    public var copies: ITUItem {return self.property(0x6c776370) as! ITUItem} // "lwcp"
    public var currentAirPlayDevices: ITUItem {return self.property(0x70415044) as! ITUItem} // "pAPD"
    public var currentEncoder: ITUItem {return self.property(0x70456e63) as! ITUItem} // "pEnc"
    public var currentEQPreset: ITUItem {return self.property(0x70455150) as! ITUItem} // "pEQP"
    public var currentPlaylist: ITUItem {return self.property(0x70506c61) as! ITUItem} // "pPla"
    public var currentStreamTitle: ITUItem {return self.property(0x70537454) as! ITUItem} // "pStT"
    public var currentStreamURL: ITUItem {return self.property(0x70537455) as! ITUItem} // "pStU"
    public var currentTrack: ITUItem {return self.property(0x7054726b) as! ITUItem} // "pTrk"
    public var currentVisual: ITUItem {return self.property(0x70566973) as! ITUItem} // "pVis"
    public var data_: ITUItem {return self.property(0x70504354) as! ITUItem} // "pPCT"
    public var databaseID: ITUItem {return self.property(0x70444944) as! ITUItem} // "pDID"
    public var dateAdded: ITUItem {return self.property(0x70416464) as! ITUItem} // "pAdd"
    public var description_: ITUItem {return self.property(0x70446573) as! ITUItem} // "pDes"
    public var discCount: ITUItem {return self.property(0x70447343) as! ITUItem} // "pDsC"
    public var discNumber: ITUItem {return self.property(0x7044734e) as! ITUItem} // "pDsN"
    public var disliked: ITUItem {return self.property(0x70486174) as! ITUItem} // "pHat"
    public var downloaded: ITUItem {return self.property(0x70446c41) as! ITUItem} // "pDlA"
    public var downloaderAppleID: ITUItem {return self.property(0x70444149) as! ITUItem} // "pDAI"
    public var downloaderName: ITUItem {return self.property(0x70444e6d) as! ITUItem} // "pDNm"
    public var duration: ITUItem {return self.property(0x70447572) as! ITUItem} // "pDur"
    public var enabled: ITUItem {return self.property(0x656e626c) as! ITUItem} // "enbl"
    public var endingPage: ITUItem {return self.property(0x6c776c70) as! ITUItem} // "lwlp"
    public var episodeID: ITUItem {return self.property(0x70457044) as! ITUItem} // "pEpD"
    public var episodeNumber: ITUItem {return self.property(0x7045704e) as! ITUItem} // "pEpN"
    public var EQ: ITUItem {return self.property(0x70455170) as! ITUItem} // "pEQp"
    public var EQEnabled: ITUItem {return self.property(0x70455120) as! ITUItem} // "pEQ "
    public var errorHandling: ITUItem {return self.property(0x6c776568) as! ITUItem} // "lweh"
    public var faxNumber: ITUItem {return self.property(0x6661786e) as! ITUItem} // "faxn"
    public var finish: ITUItem {return self.property(0x70537470) as! ITUItem} // "pStp"
    public var fixedIndexing: ITUItem {return self.property(0x70466978) as! ITUItem} // "pFix"
    public var format: ITUItem {return self.property(0x70466d74) as! ITUItem} // "pFmt"
    public var freeSpace: ITUItem {return self.property(0x66727370) as! ITUItem} // "frsp"
    public var frontmost: ITUItem {return self.property(0x70697366) as! ITUItem} // "pisf"
    public var fullScreen: ITUItem {return self.property(0x70465363) as! ITUItem} // "pFSc"
    public var gapless: ITUItem {return self.property(0x7047706c) as! ITUItem} // "pGpl"
    public var genius: ITUItem {return self.property(0x70476e73) as! ITUItem} // "pGns"
    public var genre: ITUItem {return self.property(0x7047656e) as! ITUItem} // "pGen"
    public var grouping: ITUItem {return self.property(0x70477270) as! ITUItem} // "pGrp"
    public var id: ITUItem {return self.property(0x49442020) as! ITUItem} // "ID  "
    public var index: ITUItem {return self.property(0x70696478) as! ITUItem} // "pidx"
    public var kind: ITUItem {return self.property(0x704b6e64) as! ITUItem} // "pKnd"
    public var location: ITUItem {return self.property(0x704c6f63) as! ITUItem} // "pLoc"
    public var longDescription: ITUItem {return self.property(0x704c6473) as! ITUItem} // "pLds"
    public var loved: ITUItem {return self.property(0x704c6f76) as! ITUItem} // "pLov"
    public var lyrics: ITUItem {return self.property(0x704c7972) as! ITUItem} // "pLyr"
    public var mediaKind: ITUItem {return self.property(0x704d644b) as! ITUItem} // "pMdK"
    public var modifiable: ITUItem {return self.property(0x704d6f64) as! ITUItem} // "pMod"
    public var modificationDate: ITUItem {return self.property(0x61736d6f) as! ITUItem} // "asmo"
    public var movement: ITUItem {return self.property(0x704d4e6d) as! ITUItem} // "pMNm"
    public var movementCount: ITUItem {return self.property(0x704d7643) as! ITUItem} // "pMvC"
    public var movementNumber: ITUItem {return self.property(0x704d764e) as! ITUItem} // "pMvN"
    public var mute: ITUItem {return self.property(0x704d7574) as! ITUItem} // "pMut"
    public var name: ITUItem {return self.property(0x706e616d) as! ITUItem} // "pnam"
    public var networkAddress: ITUItem {return self.property(0x704d4143) as! ITUItem} // "pMAC"
    public var pagesAcross: ITUItem {return self.property(0x6c776c61) as! ITUItem} // "lwla"
    public var pagesDown: ITUItem {return self.property(0x6c776c64) as! ITUItem} // "lwld"
    public var parent: ITUItem {return self.property(0x70506c50) as! ITUItem} // "pPlP"
    public var persistentID: ITUItem {return self.property(0x70504953) as! ITUItem} // "pPIS"
    public var playedCount: ITUItem {return self.property(0x70506c43) as! ITUItem} // "pPlC"
    public var playedDate: ITUItem {return self.property(0x70506c44) as! ITUItem} // "pPlD"
    public var playerPosition: ITUItem {return self.property(0x70506f73) as! ITUItem} // "pPos"
    public var playerState: ITUItem {return self.property(0x70506c53) as! ITUItem} // "pPlS"
    public var position: ITUItem {return self.property(0x70706f73) as! ITUItem} // "ppos"
    public var preamp: ITUItem {return self.property(0x70455141) as! ITUItem} // "pEQA"
    public var printerFeatures: ITUItem {return self.property(0x6c777066) as! ITUItem} // "lwpf"
    public var properties: ITUItem {return self.property(0x70414c4c) as! ITUItem} // "pALL"
    public var protected: ITUItem {return self.property(0x7050726f) as! ITUItem} // "pPro"
    public var purchaserAppleID: ITUItem {return self.property(0x70504149) as! ITUItem} // "pPAI"
    public var purchaserName: ITUItem {return self.property(0x70504e6d) as! ITUItem} // "pPNm"
    public var rating: ITUItem {return self.property(0x70527465) as! ITUItem} // "pRte"
    public var ratingKind: ITUItem {return self.property(0x7052746b) as! ITUItem} // "pRtk"
    public var rawData: ITUItem {return self.property(0x70526177) as! ITUItem} // "pRaw"
    public var releaseDate: ITUItem {return self.property(0x70526c44) as! ITUItem} // "pRlD"
    public var requestedPrintTime: ITUItem {return self.property(0x6c777174) as! ITUItem} // "lwqt"
    public var resizable: ITUItem {return self.property(0x7072737a) as! ITUItem} // "prsz"
    public var sampleRate: ITUItem {return self.property(0x70535274) as! ITUItem} // "pSRt"
    public var seasonNumber: ITUItem {return self.property(0x7053654e) as! ITUItem} // "pSeN"
    public var selected: ITUItem {return self.property(0x73656c63) as! ITUItem} // "selc"
    public var selection: ITUItem {return self.property(0x73656c65) as! ITUItem} // "sele"
    public var shared: ITUItem {return self.property(0x70536872) as! ITUItem} // "pShr"
    public var show: ITUItem {return self.property(0x70536877) as! ITUItem} // "pShw"
    public var shufflable: ITUItem {return self.property(0x70536661) as! ITUItem} // "pSfa"
    public var shuffle: ITUItem {return self.property(0x70536866) as! ITUItem} // "pShf"
    public var shuffleEnabled: ITUItem {return self.property(0x70536845) as! ITUItem} // "pShE"
    public var shuffleMode: ITUItem {return self.property(0x7053684d) as! ITUItem} // "pShM"
    public var size: ITUItem {return self.property(0x7053697a) as! ITUItem} // "pSiz"
    public var skippedCount: ITUItem {return self.property(0x70536b43) as! ITUItem} // "pSkC"
    public var skippedDate: ITUItem {return self.property(0x70536b44) as! ITUItem} // "pSkD"
    public var smart: ITUItem {return self.property(0x70536d74) as! ITUItem} // "pSmt"
    public var songRepeat: ITUItem {return self.property(0x70527074) as! ITUItem} // "pRpt"
    public var sortAlbum: ITUItem {return self.property(0x7053416c) as! ITUItem} // "pSAl"
    public var sortAlbumArtist: ITUItem {return self.property(0x70534141) as! ITUItem} // "pSAA"
    public var sortArtist: ITUItem {return self.property(0x70534172) as! ITUItem} // "pSAr"
    public var sortComposer: ITUItem {return self.property(0x7053436d) as! ITUItem} // "pSCm"
    public var sortName: ITUItem {return self.property(0x70534e6d) as! ITUItem} // "pSNm"
    public var sortShow: ITUItem {return self.property(0x7053534e) as! ITUItem} // "pSSN"
    public var soundVolume: ITUItem {return self.property(0x70566f6c) as! ITUItem} // "pVol"
    public var specialKind: ITUItem {return self.property(0x7053704b) as! ITUItem} // "pSpK"
    public var start: ITUItem {return self.property(0x70537472) as! ITUItem} // "pStr"
    public var startingPage: ITUItem {return self.property(0x6c776670) as! ITUItem} // "lwfp"
    public var supportsAudio: ITUItem {return self.property(0x70417564) as! ITUItem} // "pAud"
    public var supportsVideo: ITUItem {return self.property(0x70566964) as! ITUItem} // "pVid"
    public var targetPrinter: ITUItem {return self.property(0x74727072) as! ITUItem} // "trpr"
    public var time: ITUItem {return self.property(0x7054696d) as! ITUItem} // "pTim"
    public var trackCount: ITUItem {return self.property(0x70547243) as! ITUItem} // "pTrC"
    public var trackNumber: ITUItem {return self.property(0x7054724e) as! ITUItem} // "pTrN"
    public var unplayed: ITUItem {return self.property(0x70556e70) as! ITUItem} // "pUnp"
    public var updateTracks: ITUItem {return self.property(0x70555443) as! ITUItem} // "pUTC"
    public var version: ITUItem {return self.property(0x76657273) as! ITUItem} // "vers"
    public var videoKind: ITUItem {return self.property(0x7056644b) as! ITUItem} // "pVdK"
    public var view: ITUItem {return self.property(0x70506c79) as! ITUItem} // "pPly"
    public var visible: ITUItem {return self.property(0x70766973) as! ITUItem} // "pvis"
    public var visualsEnabled: ITUItem {return self.property(0x70567345) as! ITUItem} // "pVsE"
    public var visualSize: ITUItem {return self.property(0x7056537a) as! ITUItem} // "pVSz"
    public var volumeAdjustment: ITUItem {return self.property(0x7041646a) as! ITUItem} // "pAdj"
    public var work: ITUItem {return self.property(0x7057726b) as! ITUItem} // "pWrk"
    public var year: ITUItem {return self.property(0x70597220) as! ITUItem} // "pYr "
    public var zoomable: ITUItem {return self.property(0x69737a6d) as! ITUItem} // "iszm"
    public var zoomed: ITUItem {return self.property(0x707a756d) as! ITUItem} // "pzum"

    // Elements
    public var AirPlayDevices: ITUItems {return self.elements(0x63415044) as! ITUItems} // "cAPD"
    public var applications: ITUItems {return self.elements(0x63617070) as! ITUItems} // "capp"
    public var artworks: ITUItems {return self.elements(0x63417274) as! ITUItems} // "cArt"
    public var audioCDPlaylists: ITUItems {return self.elements(0x63434450) as! ITUItems} // "cCDP"
    public var audioCDTracks: ITUItems {return self.elements(0x63434454) as! ITUItems} // "cCDT"
    public var browserWindows: ITUItems {return self.elements(0x63427257) as! ITUItems} // "cBrW"
    public var encoders: ITUItems {return self.elements(0x63456e63) as! ITUItems} // "cEnc"
    public var EQPresets: ITUItems {return self.elements(0x63455150) as! ITUItems} // "cEQP"
    public var EQWindows: ITUItems {return self.elements(0x63455157) as! ITUItems} // "cEQW"
    public var fileTracks: ITUItems {return self.elements(0x63466c54) as! ITUItems} // "cFlT"
    public var folderPlaylists: ITUItems {return self.elements(0x63466f50) as! ITUItems} // "cFoP"
    public var items: ITUItems {return self.elements(0x636f626a) as! ITUItems} // "cobj"
    public var libraryPlaylists: ITUItems {return self.elements(0x634c6950) as! ITUItems} // "cLiP"
    public var miniplayerWindows: ITUItems {return self.elements(0x634d5057) as! ITUItems} // "cMPW"
    public var playlists: ITUItems {return self.elements(0x63506c79) as! ITUItems} // "cPly"
    public var playlistWindows: ITUItems {return self.elements(0x63506c57) as! ITUItems} // "cPlW"
    public var radioTunerPlaylists: ITUItems {return self.elements(0x63525450) as! ITUItems} // "cRTP"
    public var sharedTracks: ITUItems {return self.elements(0x63536854) as! ITUItems} // "cShT"
    public var sources: ITUItems {return self.elements(0x63537263) as! ITUItems} // "cSrc"
    public var subscriptionPlaylists: ITUItems {return self.elements(0x63537550) as! ITUItems} // "cSuP"
    public var tracks: ITUItems {return self.elements(0x6354726b) as! ITUItems} // "cTrk"
    public var URLTracks: ITUItems {return self.elements(0x63555254) as! ITUItems} // "cURT"
    public var userPlaylists: ITUItems {return self.elements(0x63557350) as! ITUItems} // "cUsP"
    public var videoWindows: ITUItems {return self.elements(0x634e5057) as! ITUItems} // "cNPW"
    public var visuals: ITUItems {return self.elements(0x63566973) as! ITUItems} // "cVis"
    public var windows: ITUItems {return self.elements(0x6377696e) as! ITUItems} // "cwin"
}


/******************************************************************************/
// Specifier subclasses add app-specific extensions

// beginning/end/before/after
public class ITUInsertion: SwiftAutomation.InsertionSpecifier, ITUCommand {}


// property/by-index/by-name/by-id/previous/next/first/middle/last/any
public class ITUItem: SwiftAutomation.ObjectSpecifier, ITUObject {
    public typealias InsertionSpecifierType = ITUInsertion
    public typealias ObjectSpecifierType = ITUItem
    public typealias MultipleObjectSpecifierType = ITUItems
}

// by-range/by-test/all
public class ITUItems: ITUItem, SwiftAutomation.MultipleObjectSpecifierExtension {}

// App/Con/Its
public class ITURoot: SwiftAutomation.RootSpecifier, ITUObject, SwiftAutomation.RootSpecifierExtension {
    public typealias InsertionSpecifierType = ITUInsertion
    public typealias ObjectSpecifierType = ITUItem
    public typealias MultipleObjectSpecifierType = ITUItems
    public override class var untargetedAppData: SwiftAutomation.AppData { return _untargetedAppData }
}

// Application
public class ITunes: ITURoot, SwiftAutomation.Application {
    public convenience init(launchOptions: SwiftAutomation.LaunchOptions = SwiftAutomation.DefaultLaunchOptions, relaunchMode: SwiftAutomation.RelaunchMode = SwiftAutomation.DefaultRelaunchMode) {
        self.init(rootObject: SwiftAutomation.AppRootDesc, appData: Swift.type(of:self).untargetedAppData.targetedCopy(
                  .bundleIdentifier("com.apple.iTunes", true), launchOptions: launchOptions, relaunchMode: relaunchMode))
    }
}

// App/Con/Its root objects used to construct untargeted specifiers; these can be used to construct specifiers for use in commands, though cannot send commands themselves

public let ITUApp = _untargetedAppData.app as! ITURoot
public let ITUCon = _untargetedAppData.con as! ITURoot
public let ITUIts = _untargetedAppData.its as! ITURoot


/******************************************************************************/
// Static types

public typealias ITURecord = [ITUSymbol:Any] // default Swift type for AERecordDescs






