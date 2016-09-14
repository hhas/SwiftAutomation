//
//  ITunesGlue.swift
//  iTunes.app 12.4.3
//  SwiftAE.framework 0.1.0
//  `aeglue -r iTunes.app`
//


import Foundation
//import SwiftAE


/******************************************************************************/
// Untargeted AppData instance used in App, Con, Its roots; also used by Application constructors to create their own targeted AppData instances

private let gUntargetedAppData = AppData(glueInfo: GlueInfo(insertionSpecifierType: ITUInsertion.self,
                                                            objectSpecifierType: ITUObject.self,
                                                            elementsSpecifierType: ITUElements.self,
                                                            rootSpecifierType: ITURoot.self,
                                                            symbolType: ITUSymbol.self,
                                                            formatter: gSpecifierFormatter))


/******************************************************************************/
// Specifier formatter

private let gSpecifierFormatter = SpecifierFormatter(applicationClassName: "ITunes",
                                                     classNamePrefix: "ITU",
                                                     propertyNames: [
                                                                     0x7055524c: "address", // "pURL"
                                                                     0x70416c62: "album", // "pAlb"
                                                                     0x70416c41: "albumArtist", // "pAlA"
                                                                     0x70416c52: "albumRating", // "pAlR"
                                                                     0x7041526b: "albumRatingKind", // "pARk"
                                                                     0x70417274: "artist", // "pArt"
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
                                                                     0x70575368: "collapseable", // "pWSh"
                                                                     0x77736864: "collapsed", // "wshd"
                                                                     0x6c77636c: "collating", // "lwcl"
                                                                     0x70436d74: "comment", // "pCmt"
                                                                     0x70416e74: "compilation", // "pAnt"
                                                                     0x70436d70: "composer", // "pCmp"
                                                                     0x63746e72: "container", // "ctnr"
                                                                     0x6c776370: "copies", // "lwcp"
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
                                                                     0x70446573: "description", // "pDes"
                                                                     0x70447343: "discCount", // "pDsC"
                                                                     0x7044734e: "discNumber", // "pDsN"
                                                                     0x70446c41: "downloaded", // "pDlA"
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
                                                                     0x7047656e: "genre", // "pGen"
                                                                     0x70477270: "grouping", // "pGrp"
                                                                     0x49442020: "id", // "ID  "
                                                                     0x70696478: "index", // "pidx"
                                                                     0x704b6e64: "kind", // "pKnd"
                                                                     0x704c6f63: "location", // "pLoc"
                                                                     0x704c6473: "longDescription", // "pLds"
                                                                     0x704c7972: "lyrics", // "pLyr"
                                                                     0x704d696e: "minimized", // "pMin"
                                                                     0x704d6f64: "modifiable", // "pMod"
                                                                     0x61736d6f: "modificationDate", // "asmo"
                                                                     0x704d7574: "mute", // "pMut"
                                                                     0x706e616d: "name", // "pnam"
                                                                     0x6c776c61: "pagesAcross", // "lwla"
                                                                     0x6c776c64: "pagesDown", // "lwld"
                                                                     0x70506c50: "parent", // "pPlP"
                                                                     0x70504953: "persistentID", // "pPIS"
                                                                     0x70506c43: "playedCount", // "pPlC"
                                                                     0x70506c44: "playedDate", // "pPlD"
                                                                     0x70506f73: "playerPosition", // "pPos"
                                                                     0x70506c53: "playerState", // "pPlS"
                                                                     0x70545063: "podcast", // "pTPc"
                                                                     0x70706f73: "position", // "ppos"
                                                                     0x70455141: "preamp", // "pEQA"
                                                                     0x6c777066: "printerFeatures", // "lwpf"
                                                                     0x70414c4c: "properties", // "pALL"
                                                                     0x70527465: "rating", // "pRte"
                                                                     0x7052746b: "ratingKind", // "pRtk"
                                                                     0x70526177: "rawData", // "pRaw"
                                                                     0x70526c44: "releaseDate", // "pRlD"
                                                                     0x6c777174: "requestedPrintTime", // "lwqt"
                                                                     0x7072737a: "resizable", // "prsz"
                                                                     0x70535274: "sampleRate", // "pSRt"
                                                                     0x7053654e: "seasonNumber", // "pSeN"
                                                                     0x73656c65: "selection", // "sele"
                                                                     0x70536872: "shared", // "pShr"
                                                                     0x70536877: "show", // "pShw"
                                                                     0x70536661: "shufflable", // "pSfa"
                                                                     0x70536866: "shuffle", // "pShf"
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
                                                                     0x70597220: "year", // "pYr "
                                                                     0x69737a6d: "zoomable", // "iszm"
                                                                     0x707a756d: "zoomed", // "pzum"
                                                     ],
                                                     elementsNames: [
                                                                     0x63617070: "applications", // "capp"
                                                                     0x63417274: "artworks", // "cArt"
                                                                     0x63434450: "audioCDPlaylists", // "cCDP"
                                                                     0x63434454: "audioCDTracks", // "cCDT"
                                                                     0x63427257: "browserWindows", // "cBrW"
                                                                     0x63447650: "devicePlaylists", // "cDvP"
                                                                     0x63447654: "deviceTracks", // "cDvT"
                                                                     0x63456e63: "encoders", // "cEnc"
                                                                     0x63455150: "EQPresets", // "cEQP"
                                                                     0x63455157: "EQWindows", // "cEQW"
                                                                     0x63466c54: "fileTracks", // "cFlT"
                                                                     0x63466f50: "folderPlaylists", // "cFoP"
                                                                     0x636f626a: "items", // "cobj"
                                                                     0x634c6950: "libraryPlaylists", // "cLiP"
                                                                     0x50494354: "picture", // "PICT"
                                                                     0x63506c79: "playlists", // "cPly"
                                                                     0x63506c57: "playlistWindows", // "cPlW"
                                                                     0x70736574: "printSettings", // "pset"
                                                                     0x63525450: "radioTunerPlaylists", // "cRTP"
                                                                     0x74647461: "rawData", // "tdta"
                                                                     0x63536854: "sharedTracks", // "cShT"
                                                                     0x63537263: "sources", // "cSrc"
                                                                     0x6354726b: "tracks", // "cTrk"
                                                                     0x63555254: "URLTracks", // "cURT"
                                                                     0x63557350: "userPlaylists", // "cUsP"
                                                                     0x63566973: "visuals", // "cVis"
                                                                     0x6377696e: "windows", // "cwin"
                                                     ])


/******************************************************************************/
// Symbol subclass defines static type/enum/property constants based on iTunes.app terminology

public class ITUSymbol: Symbol {

    override var typeAliasName: String {return "ITU"}

    public override class func symbol(_ code: OSType, type: OSType = typeType, descriptor: NSAppleEventDescriptor? = nil) -> ITUSymbol {
        switch (code) {
        case 0x7055524c: return self.address // "pURL"
        case 0x70416c62: return self.album // "pAlb"
        case 0x70416c41: return self.albumArtist // "pAlA"
        case 0x6b416c62: return self.albumListing // "kAlb"
        case 0x70416c52: return self.albumRating // "pAlR"
        case 0x7041526b: return self.albumRatingKind // "pARk"
        case 0x6b53724c: return self.albums // "kSrL"
        case 0x616c6973: return self.alias // "alis"
        case 0x6b416c6c: return self.all // "kAll"
        case 0x2a2a2a2a: return self.anything // "****"
        case 0x63617070: return self.application // "capp"
        case 0x62756e64: return self.applicationBundleId // "bund"
        case 0x7369676e: return self.applicationSignature // "sign"
        case 0x6170726c: return self.applicationUrl // "aprl"
        case 0x61707220: return self.April // "apr "
        case 0x70417274: return self.artist // "pArt"
        case 0x6b537252: return self.artists // "kSrR"
        case 0x63417274: return self.artwork // "cArt"
        case 0x61736b20: return self.ask // "ask "
        case 0x6b414344: return self.audioCD // "kACD"
        case 0x63434450: return self.audioCDPlaylist // "cCDP"
        case 0x63434454: return self.audioCDTrack // "cCDT"
        case 0x61756720: return self.August // "aug "
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
        case 0x70426b74: return self.bookmark // "pBkt"
        case 0x70426b6d: return self.bookmarkable // "pBkm"
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
        case 0x70575368: return self.collapseable // "pWSh"
        case 0x77736864: return self.collapsed // "wshd"
        case 0x6c77636c: return self.collating // "lwcl"
        case 0x636c7274: return self.colorTable // "clrt"
        case 0x70436d74: return self.comment // "pCmt"
        case 0x70416e74: return self.compilation // "pAnt"
        case 0x70436d70: return self.composer // "pCmp"
        case 0x6b537243: return self.composers // "kSrC"
        case 0x6b527443: return self.computed // "kRtC"
        case 0x63746e72: return self.container // "ctnr"
        case 0x6c776370: return self.copies // "lwcp"
        case 0x70456e63: return self.currentEncoder // "pEnc"
        case 0x70455150: return self.currentEQPreset // "pEQP"
        case 0x70506c61: return self.currentPlaylist // "pPla"
        case 0x70537454: return self.currentStreamTitle // "pStT"
        case 0x70537455: return self.currentStreamURL // "pStU"
        case 0x7054726b: return self.currentTrack // "pTrk"
        case 0x70566973: return self.currentVisual // "pVis"
        case 0x74646173: return self.dashStyle // "tdas"
        case 0x70504354: return self.data_ // "pPCT"
        case 0x70444944: return self.databaseID // "pDID"
        case 0x6c647420: return self.date // "ldt "
        case 0x70416464: return self.dateAdded // "pAdd"
        case 0x64656320: return self.December // "dec "
        case 0x6465636d: return self.decimalStruct // "decm"
        case 0x70446573: return self.description // "pDes"
        case 0x6c776474: return self.detailed // "lwdt"
        case 0x6b446576: return self.device // "kDev"
        case 0x63447650: return self.devicePlaylist // "cDvP"
        case 0x63447654: return self.deviceTrack // "cDvT"
        case 0x64696163: return self.diacriticals // "diac"
        case 0x70447343: return self.discCount // "pDsC"
        case 0x7044734e: return self.discNumber // "pDsN"
        case 0x6b537256: return self.displayed // "kSrV"
        case 0x636f6d70: return self.doubleInteger // "comp"
        case 0x70446c41: return self.downloaded // "pDlA"
        case 0x70447572: return self.duration // "pDur"
        case 0x656e626c: return self.enabled // "enbl"
        case 0x656e6373: return self.encodedString // "encs"
        case 0x63456e63: return self.encoder // "cEnc"
        case 0x6c776c70: return self.endingPage // "lwlp"
        case 0x656e756d: return self.enumerator // "enum"
        case 0x70457044: return self.episodeID // "pEpD"
        case 0x7045704e: return self.episodeNumber // "pEpN"
        case 0x45505320: return self.EPSPicture // "EPS "
        case 0x70455170: return self.EQ // "pEQp"
        case 0x70455120: return self.EQEnabled // "pEQ "
        case 0x63455150: return self.EQPreset // "cEQP"
        case 0x63455157: return self.EQWindow // "cEQW"
        case 0x6c776568: return self.errorHandling // "lweh"
        case 0x65787061: return self.expansion // "expa"
        case 0x65787465: return self.extendedFloat // "exte"
        case 0x6b505346: return self.fastForwarding // "kPSF"
        case 0x6661786e: return self.faxNumber // "faxn"
        case 0x66656220: return self.February // "feb "
        case 0x66737266: return self.fileRef // "fsrf"
        case 0x66737320: return self.fileSpecification // "fss "
        case 0x63466c54: return self.fileTrack // "cFlT"
        case 0x6675726c: return self.fileUrl // "furl"
        case 0x70537470: return self.finish // "pStp"
        case 0x66697864: return self.fixed // "fixd"
        case 0x70466978: return self.fixedIndexing // "pFix"
        case 0x66706e74: return self.fixedPoint // "fpnt"
        case 0x66726374: return self.fixedRectangle // "frct"
        case 0x646f7562: return self.float // "doub"
        case 0x6c64626c: return self.float128bit // "ldbl"
        case 0x6b537046: return self.folder // "kSpF"
        case 0x63466f50: return self.folderPlaylist // "cFoP"
        case 0x70466d74: return self.format // "pFmt"
        case 0x66727370: return self.freeSpace // "frsp"
        case 0x66726920: return self.Friday // "fri "
        case 0x70697366: return self.frontmost // "pisf"
        case 0x70465363: return self.fullScreen // "pFSc"
        case 0x7047706c: return self.gapless // "pGpl"
        case 0x6b537047: return self.Genius // "kSpG"
        case 0x7047656e: return self.genre // "pGen"
        case 0x47494666: return self.GIFPicture // "GIFf"
        case 0x63677478: return self.graphicText // "cgtx"
        case 0x70477270: return self.grouping // "pGrp"
        case 0x68797068: return self.hyphens // "hyph"
        case 0x49442020: return self.id // "ID  "
        case 0x70696478: return self.index // "pidx"
        case 0x6c6f6e67: return self.integer // "long"
        case 0x69747874: return self.internationalText // "itxt"
        case 0x696e746c: return self.internationalWritingCode // "intl"
        case 0x6b506f64: return self.iPod // "kPod"
        case 0x636f626a: return self.item // "cobj"
        case 0x6b537055: return self.iTunesU // "kSpU"
        case 0x6a616e20: return self.January // "jan "
        case 0x4a504547: return self.JPEGPicture // "JPEG"
        case 0x6a756c20: return self.July // "jul "
        case 0x6a756e20: return self.June // "jun "
        case 0x6b706964: return self.kernelProcessId // "kpid"
        case 0x704b6e64: return self.kind // "pKnd"
        case 0x6b56534c: return self.large // "kVSL"
        case 0x6b4c6962: return self.library // "kLib"
        case 0x6b53704c: return self.Library // "kSpL"
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
        case 0x704c7972: return self.lyrics // "pLyr"
        case 0x6d616368: return self.machine // "mach"
        case 0x6d4c6f63: return self.machineLocation // "mLoc"
        case 0x706f7274: return self.machPort // "port"
        case 0x6d617220: return self.March // "mar "
        case 0x6d617920: return self.May // "may "
        case 0x6b56534d: return self.medium // "kVSM"
        case 0x704d696e: return self.minimized // "pMin"
        case 0x6d736e67: return self.missingValue // "msng"
        case 0x704d6f64: return self.modifiable // "pMod"
        case 0x61736d6f: return self.modificationDate // "asmo"
        case 0x6d6f6e20: return self.Monday // "mon "
        case 0x6b56644d: return self.movie // "kVdM"
        case 0x6b537049: return self.Movies // "kSpI"
        case 0x6b4d4344: return self.MP3CD // "kMCD"
        case 0x6b53705a: return self.Music // "kSpZ"
        case 0x6b566456: return self.musicVideo // "kVdV"
        case 0x704d7574: return self.mute // "pMut"
        case 0x706e616d: return self.name // "pnam"
        case 0x6e6f2020: return self.no // "no  "
        case 0x6b4e6f6e: return self.none_ // "kNon"
        case 0x6e6f7620: return self.November // "nov "
        case 0x6e756c6c: return self.null // "null"
        case 0x6e756d65: return self.numericStrings // "nume"
        case 0x6f637420: return self.October // "oct "
        case 0x6b52704f: return self.off // "kRpO"
        case 0x6b527031: return self.one // "kRp1"
        case 0x6c776c61: return self.pagesAcross // "lwla"
        case 0x6c776c64: return self.pagesDown // "lwld"
        case 0x70506c50: return self.parent // "pPlP"
        case 0x6b537053: return self.PartyShuffle // "kSpS"
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
        case 0x70545063: return self.podcast // "pTPc"
        case 0x6b537050: return self.Podcasts // "kSpP"
        case 0x51447074: return self.point // "QDpt"
        case 0x70706f73: return self.position // "ppos"
        case 0x70455141: return self.preamp // "pEQA"
        case 0x6c777066: return self.printerFeatures // "lwpf"
        case 0x70736574: return self.printSettings // "pset"
        case 0x70736e20: return self.processSerialNumber // "psn "
        case 0x70414c4c: return self.properties // "pALL"
        case 0x70726f70: return self.property_ // "prop"
        case 0x70756e63: return self.punctuation // "punc"
        case 0x6b53704d: return self.PurchasedMusic // "kSpM"
        case 0x6b54756e: return self.radioTuner // "kTun"
        case 0x63525450: return self.radioTunerPlaylist // "cRTP"
        case 0x70527465: return self.rating // "pRte"
        case 0x7052746b: return self.ratingKind // "pRtk"
        case 0x74647461: return self.rawData // "tdta"
        case 0x70526177: return self.rawData // "pRaw"
        case 0x7265636f: return self.record // "reco"
        case 0x6f626a20: return self.reference // "obj "
        case 0x70526c44: return self.releaseDate // "pRlD"
        case 0x6c777174: return self.requestedPrintTime // "lwqt"
        case 0x7072737a: return self.resizable // "prsz"
        case 0x6b505352: return self.rewinding // "kPSR"
        case 0x74723136: return self.RGB16Color // "tr16"
        case 0x74723936: return self.RGB96Color // "tr96"
        case 0x63524742: return self.RGBColor // "cRGB"
        case 0x74726f74: return self.rotation // "trot"
        case 0x70535274: return self.sampleRate // "pSRt"
        case 0x73617420: return self.Saturday // "sat "
        case 0x73637074: return self.script // "scpt"
        case 0x7053654e: return self.seasonNumber // "pSeN"
        case 0x73656c65: return self.selection // "sele"
        case 0x73657020: return self.September // "sep "
        case 0x70536872: return self.shared // "pShr"
        case 0x6b536864: return self.sharedLibrary // "kShd"
        case 0x63536854: return self.sharedTrack // "cShT"
        case 0x73696e67: return self.shortFloat // "sing"
        case 0x73686f72: return self.shortInteger // "shor"
        case 0x70536877: return self.show // "pShw"
        case 0x70536661: return self.shufflable // "pSfa"
        case 0x70536866: return self.shuffle // "pShf"
        case 0x7053697a: return self.size // "pSiz"
        case 0x70536b43: return self.skippedCount // "pSkC"
        case 0x70536b44: return self.skippedDate // "pSkD"
        case 0x6b565353: return self.small // "kVSS"
        case 0x70536d74: return self.smart // "pSmt"
        case 0x70527074: return self.songRepeat // "pRpt"
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
        case 0x73756e20: return self.Sunday // "sun "
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
        case 0x75747874: return self.unicodeText // "utxt"
        case 0x6b556e6b: return self.unknown // "kUnk"
        case 0x70556e70: return self.unplayed // "pUnp"
        case 0x6d61676e: return self.unsignedInteger // "magn"
        case 0x70555443: return self.updateTracks // "pUTC"
        case 0x63555254: return self.URLTrack // "cURT"
        case 0x6b527455: return self.user // "kRtU"
        case 0x63557350: return self.userPlaylist // "cUsP"
        case 0x75743136: return self.utf16Text // "ut16"
        case 0x75746638: return self.utf8Text // "utf8"
        case 0x76657273: return self.version // "vers"
        case 0x7056644b: return self.videoKind // "pVdK"
        case 0x70506c79: return self.view // "pPly"
        case 0x70766973: return self.visible // "pvis"
        case 0x63566973: return self.visual // "cVis"
        case 0x70567345: return self.visualsEnabled // "pVsE"
        case 0x7056537a: return self.visualSize // "pVSz"
        case 0x7041646a: return self.volumeAdjustment // "pAdj"
        case 0x77656420: return self.Wednesday // "wed "
        case 0x77686974: return self.whitespace // "whit"
        case 0x6377696e: return self.window // "cwin"
        case 0x70736374: return self.writingCode // "psct"
        case 0x70597220: return self.year // "pYr "
        case 0x79657320: return self.yes // "yes "
        case 0x69737a6d: return self.zoomable // "iszm"
        case 0x707a756d: return self.zoomed // "pzum"
        default: return super.symbol(code, type: type, descriptor: descriptor) as! ITUSymbol
        }
    }

    // Types/properties
    public static let address = ITUSymbol(name: "address", code: 0x7055524c, type: typeType) // "pURL"
    public static let album = ITUSymbol(name: "album", code: 0x70416c62, type: typeType) // "pAlb"
    public static let albumArtist = ITUSymbol(name: "albumArtist", code: 0x70416c41, type: typeType) // "pAlA"
    public static let albumRating = ITUSymbol(name: "albumRating", code: 0x70416c52, type: typeType) // "pAlR"
    public static let albumRatingKind = ITUSymbol(name: "albumRatingKind", code: 0x7041526b, type: typeType) // "pARk"
    public static let alias = ITUSymbol(name: "alias", code: 0x616c6973, type: typeType) // "alis"
    public static let anything = ITUSymbol(name: "anything", code: 0x2a2a2a2a, type: typeType) // "****"
    public static let application = ITUSymbol(name: "application", code: 0x63617070, type: typeType) // "capp"
    public static let applicationBundleId = ITUSymbol(name: "applicationBundleId", code: 0x62756e64, type: typeType) // "bund"
    public static let applicationSignature = ITUSymbol(name: "applicationSignature", code: 0x7369676e, type: typeType) // "sign"
    public static let applicationUrl = ITUSymbol(name: "applicationUrl", code: 0x6170726c, type: typeType) // "aprl"
    public static let April = ITUSymbol(name: "April", code: 0x61707220, type: typeType) // "apr "
    public static let artist = ITUSymbol(name: "artist", code: 0x70417274, type: typeType) // "pArt"
    public static let artwork = ITUSymbol(name: "artwork", code: 0x63417274, type: typeType) // "cArt"
    public static let audioCDPlaylist = ITUSymbol(name: "audioCDPlaylist", code: 0x63434450, type: typeType) // "cCDP"
    public static let audioCDTrack = ITUSymbol(name: "audioCDTrack", code: 0x63434454, type: typeType) // "cCDT"
    public static let August = ITUSymbol(name: "August", code: 0x61756720, type: typeType) // "aug "
    public static let band1 = ITUSymbol(name: "band1", code: 0x70455131, type: typeType) // "pEQ1"
    public static let band10 = ITUSymbol(name: "band10", code: 0x70455130, type: typeType) // "pEQ0"
    public static let band2 = ITUSymbol(name: "band2", code: 0x70455132, type: typeType) // "pEQ2"
    public static let band3 = ITUSymbol(name: "band3", code: 0x70455133, type: typeType) // "pEQ3"
    public static let band4 = ITUSymbol(name: "band4", code: 0x70455134, type: typeType) // "pEQ4"
    public static let band5 = ITUSymbol(name: "band5", code: 0x70455135, type: typeType) // "pEQ5"
    public static let band6 = ITUSymbol(name: "band6", code: 0x70455136, type: typeType) // "pEQ6"
    public static let band7 = ITUSymbol(name: "band7", code: 0x70455137, type: typeType) // "pEQ7"
    public static let band8 = ITUSymbol(name: "band8", code: 0x70455138, type: typeType) // "pEQ8"
    public static let band9 = ITUSymbol(name: "band9", code: 0x70455139, type: typeType) // "pEQ9"
    public static let best = ITUSymbol(name: "best", code: 0x62657374, type: typeType) // "best"
    public static let bitRate = ITUSymbol(name: "bitRate", code: 0x70425274, type: typeType) // "pBRt"
    public static let bookmark = ITUSymbol(name: "bookmark", code: 0x70426b74, type: typeType) // "pBkt"
    public static let bookmarkable = ITUSymbol(name: "bookmarkable", code: 0x70426b6d, type: typeType) // "pBkm"
    public static let boolean = ITUSymbol(name: "boolean", code: 0x626f6f6c, type: typeType) // "bool"
    public static let boundingRectangle = ITUSymbol(name: "boundingRectangle", code: 0x71647274, type: typeType) // "qdrt"
    public static let bounds = ITUSymbol(name: "bounds", code: 0x70626e64, type: typeType) // "pbnd"
    public static let bpm = ITUSymbol(name: "bpm", code: 0x7042504d, type: typeType) // "pBPM"
    public static let browserWindow = ITUSymbol(name: "browserWindow", code: 0x63427257, type: typeType) // "cBrW"
    public static let capacity = ITUSymbol(name: "capacity", code: 0x63617061, type: typeType) // "capa"
    public static let category = ITUSymbol(name: "category", code: 0x70436174, type: typeType) // "pCat"
    public static let class_ = ITUSymbol(name: "class_", code: 0x70636c73, type: typeType) // "pcls"
    public static let closeable = ITUSymbol(name: "closeable", code: 0x68636c62, type: typeType) // "hclb"
    public static let collapseable = ITUSymbol(name: "collapseable", code: 0x70575368, type: typeType) // "pWSh"
    public static let collapsed = ITUSymbol(name: "collapsed", code: 0x77736864, type: typeType) // "wshd"
    public static let collating = ITUSymbol(name: "collating", code: 0x6c77636c, type: typeType) // "lwcl"
    public static let colorTable = ITUSymbol(name: "colorTable", code: 0x636c7274, type: typeType) // "clrt"
    public static let comment = ITUSymbol(name: "comment", code: 0x70436d74, type: typeType) // "pCmt"
    public static let compilation = ITUSymbol(name: "compilation", code: 0x70416e74, type: typeType) // "pAnt"
    public static let composer = ITUSymbol(name: "composer", code: 0x70436d70, type: typeType) // "pCmp"
    public static let container = ITUSymbol(name: "container", code: 0x63746e72, type: typeType) // "ctnr"
    public static let copies = ITUSymbol(name: "copies", code: 0x6c776370, type: typeType) // "lwcp"
    public static let currentEncoder = ITUSymbol(name: "currentEncoder", code: 0x70456e63, type: typeType) // "pEnc"
    public static let currentEQPreset = ITUSymbol(name: "currentEQPreset", code: 0x70455150, type: typeType) // "pEQP"
    public static let currentPlaylist = ITUSymbol(name: "currentPlaylist", code: 0x70506c61, type: typeType) // "pPla"
    public static let currentStreamTitle = ITUSymbol(name: "currentStreamTitle", code: 0x70537454, type: typeType) // "pStT"
    public static let currentStreamURL = ITUSymbol(name: "currentStreamURL", code: 0x70537455, type: typeType) // "pStU"
    public static let currentTrack = ITUSymbol(name: "currentTrack", code: 0x7054726b, type: typeType) // "pTrk"
    public static let currentVisual = ITUSymbol(name: "currentVisual", code: 0x70566973, type: typeType) // "pVis"
    public static let dashStyle = ITUSymbol(name: "dashStyle", code: 0x74646173, type: typeType) // "tdas"
    public static let data = ITUSymbol(name: "data", code: 0x74647461, type: typeType) // "tdta"
    public static let data_ = ITUSymbol(name: "data_", code: 0x70504354, type: typeType) // "pPCT"
    public static let databaseID = ITUSymbol(name: "databaseID", code: 0x70444944, type: typeType) // "pDID"
    public static let date = ITUSymbol(name: "date", code: 0x6c647420, type: typeType) // "ldt "
    public static let dateAdded = ITUSymbol(name: "dateAdded", code: 0x70416464, type: typeType) // "pAdd"
    public static let December = ITUSymbol(name: "December", code: 0x64656320, type: typeType) // "dec "
    public static let decimalStruct = ITUSymbol(name: "decimalStruct", code: 0x6465636d, type: typeType) // "decm"
    public static let description = ITUSymbol(name: "description", code: 0x70446573, type: typeType) // "pDes"
    public static let devicePlaylist = ITUSymbol(name: "devicePlaylist", code: 0x63447650, type: typeType) // "cDvP"
    public static let deviceTrack = ITUSymbol(name: "deviceTrack", code: 0x63447654, type: typeType) // "cDvT"
    public static let discCount = ITUSymbol(name: "discCount", code: 0x70447343, type: typeType) // "pDsC"
    public static let discNumber = ITUSymbol(name: "discNumber", code: 0x7044734e, type: typeType) // "pDsN"
    public static let doubleInteger = ITUSymbol(name: "doubleInteger", code: 0x636f6d70, type: typeType) // "comp"
    public static let downloaded = ITUSymbol(name: "downloaded", code: 0x70446c41, type: typeType) // "pDlA"
    public static let duration = ITUSymbol(name: "duration", code: 0x70447572, type: typeType) // "pDur"
    public static let enabled = ITUSymbol(name: "enabled", code: 0x656e626c, type: typeType) // "enbl"
    public static let encodedString = ITUSymbol(name: "encodedString", code: 0x656e6373, type: typeType) // "encs"
    public static let encoder = ITUSymbol(name: "encoder", code: 0x63456e63, type: typeType) // "cEnc"
    public static let endingPage = ITUSymbol(name: "endingPage", code: 0x6c776c70, type: typeType) // "lwlp"
    public static let enumerator = ITUSymbol(name: "enumerator", code: 0x656e756d, type: typeType) // "enum"
    public static let episodeID = ITUSymbol(name: "episodeID", code: 0x70457044, type: typeType) // "pEpD"
    public static let episodeNumber = ITUSymbol(name: "episodeNumber", code: 0x7045704e, type: typeType) // "pEpN"
    public static let EPSPicture = ITUSymbol(name: "EPSPicture", code: 0x45505320, type: typeType) // "EPS "
    public static let EQ = ITUSymbol(name: "EQ", code: 0x70455170, type: typeType) // "pEQp"
    public static let EQEnabled = ITUSymbol(name: "EQEnabled", code: 0x70455120, type: typeType) // "pEQ "
    public static let EQPreset = ITUSymbol(name: "EQPreset", code: 0x63455150, type: typeType) // "cEQP"
    public static let EQWindow = ITUSymbol(name: "EQWindow", code: 0x63455157, type: typeType) // "cEQW"
    public static let errorHandling = ITUSymbol(name: "errorHandling", code: 0x6c776568, type: typeType) // "lweh"
    public static let extendedFloat = ITUSymbol(name: "extendedFloat", code: 0x65787465, type: typeType) // "exte"
    public static let faxNumber = ITUSymbol(name: "faxNumber", code: 0x6661786e, type: typeType) // "faxn"
    public static let February = ITUSymbol(name: "February", code: 0x66656220, type: typeType) // "feb "
    public static let fileRef = ITUSymbol(name: "fileRef", code: 0x66737266, type: typeType) // "fsrf"
    public static let fileSpecification = ITUSymbol(name: "fileSpecification", code: 0x66737320, type: typeType) // "fss "
    public static let fileTrack = ITUSymbol(name: "fileTrack", code: 0x63466c54, type: typeType) // "cFlT"
    public static let fileUrl = ITUSymbol(name: "fileUrl", code: 0x6675726c, type: typeType) // "furl"
    public static let finish = ITUSymbol(name: "finish", code: 0x70537470, type: typeType) // "pStp"
    public static let fixed = ITUSymbol(name: "fixed", code: 0x66697864, type: typeType) // "fixd"
    public static let fixedIndexing = ITUSymbol(name: "fixedIndexing", code: 0x70466978, type: typeType) // "pFix"
    public static let fixedPoint = ITUSymbol(name: "fixedPoint", code: 0x66706e74, type: typeType) // "fpnt"
    public static let fixedRectangle = ITUSymbol(name: "fixedRectangle", code: 0x66726374, type: typeType) // "frct"
    public static let float = ITUSymbol(name: "float", code: 0x646f7562, type: typeType) // "doub"
    public static let float128bit = ITUSymbol(name: "float128bit", code: 0x6c64626c, type: typeType) // "ldbl"
    public static let folderPlaylist = ITUSymbol(name: "folderPlaylist", code: 0x63466f50, type: typeType) // "cFoP"
    public static let format = ITUSymbol(name: "format", code: 0x70466d74, type: typeType) // "pFmt"
    public static let freeSpace = ITUSymbol(name: "freeSpace", code: 0x66727370, type: typeType) // "frsp"
    public static let Friday = ITUSymbol(name: "Friday", code: 0x66726920, type: typeType) // "fri "
    public static let frontmost = ITUSymbol(name: "frontmost", code: 0x70697366, type: typeType) // "pisf"
    public static let fullScreen = ITUSymbol(name: "fullScreen", code: 0x70465363, type: typeType) // "pFSc"
    public static let gapless = ITUSymbol(name: "gapless", code: 0x7047706c, type: typeType) // "pGpl"
    public static let genre = ITUSymbol(name: "genre", code: 0x7047656e, type: typeType) // "pGen"
    public static let GIFPicture = ITUSymbol(name: "GIFPicture", code: 0x47494666, type: typeType) // "GIFf"
    public static let graphicText = ITUSymbol(name: "graphicText", code: 0x63677478, type: typeType) // "cgtx"
    public static let grouping = ITUSymbol(name: "grouping", code: 0x70477270, type: typeType) // "pGrp"
    public static let id = ITUSymbol(name: "id", code: 0x49442020, type: typeType) // "ID  "
    public static let index = ITUSymbol(name: "index", code: 0x70696478, type: typeType) // "pidx"
    public static let integer = ITUSymbol(name: "integer", code: 0x6c6f6e67, type: typeType) // "long"
    public static let internationalText = ITUSymbol(name: "internationalText", code: 0x69747874, type: typeType) // "itxt"
    public static let internationalWritingCode = ITUSymbol(name: "internationalWritingCode", code: 0x696e746c, type: typeType) // "intl"
    public static let item = ITUSymbol(name: "item", code: 0x636f626a, type: typeType) // "cobj"
    public static let January = ITUSymbol(name: "January", code: 0x6a616e20, type: typeType) // "jan "
    public static let JPEGPicture = ITUSymbol(name: "JPEGPicture", code: 0x4a504547, type: typeType) // "JPEG"
    public static let July = ITUSymbol(name: "July", code: 0x6a756c20, type: typeType) // "jul "
    public static let June = ITUSymbol(name: "June", code: 0x6a756e20, type: typeType) // "jun "
    public static let kernelProcessId = ITUSymbol(name: "kernelProcessId", code: 0x6b706964, type: typeType) // "kpid"
    public static let kind = ITUSymbol(name: "kind", code: 0x704b6e64, type: typeType) // "pKnd"
    public static let libraryPlaylist = ITUSymbol(name: "libraryPlaylist", code: 0x634c6950, type: typeType) // "cLiP"
    public static let list = ITUSymbol(name: "list", code: 0x6c697374, type: typeType) // "list"
    public static let location = ITUSymbol(name: "location", code: 0x704c6f63, type: typeType) // "pLoc"
    public static let locationReference = ITUSymbol(name: "locationReference", code: 0x696e736c, type: typeType) // "insl"
    public static let longDescription = ITUSymbol(name: "longDescription", code: 0x704c6473, type: typeType) // "pLds"
    public static let longFixed = ITUSymbol(name: "longFixed", code: 0x6c667864, type: typeType) // "lfxd"
    public static let longFixedPoint = ITUSymbol(name: "longFixedPoint", code: 0x6c667074, type: typeType) // "lfpt"
    public static let longFixedRectangle = ITUSymbol(name: "longFixedRectangle", code: 0x6c667263, type: typeType) // "lfrc"
    public static let longPoint = ITUSymbol(name: "longPoint", code: 0x6c706e74, type: typeType) // "lpnt"
    public static let longRectangle = ITUSymbol(name: "longRectangle", code: 0x6c726374, type: typeType) // "lrct"
    public static let lyrics = ITUSymbol(name: "lyrics", code: 0x704c7972, type: typeType) // "pLyr"
    public static let machine = ITUSymbol(name: "machine", code: 0x6d616368, type: typeType) // "mach"
    public static let machineLocation = ITUSymbol(name: "machineLocation", code: 0x6d4c6f63, type: typeType) // "mLoc"
    public static let machPort = ITUSymbol(name: "machPort", code: 0x706f7274, type: typeType) // "port"
    public static let March = ITUSymbol(name: "March", code: 0x6d617220, type: typeType) // "mar "
    public static let May = ITUSymbol(name: "May", code: 0x6d617920, type: typeType) // "may "
    public static let minimized = ITUSymbol(name: "minimized", code: 0x704d696e, type: typeType) // "pMin"
    public static let missingValue = ITUSymbol(name: "missingValue", code: 0x6d736e67, type: typeType) // "msng"
    public static let modifiable = ITUSymbol(name: "modifiable", code: 0x704d6f64, type: typeType) // "pMod"
    public static let modificationDate = ITUSymbol(name: "modificationDate", code: 0x61736d6f, type: typeType) // "asmo"
    public static let Monday = ITUSymbol(name: "Monday", code: 0x6d6f6e20, type: typeType) // "mon "
    public static let mute = ITUSymbol(name: "mute", code: 0x704d7574, type: typeType) // "pMut"
    public static let name = ITUSymbol(name: "name", code: 0x706e616d, type: typeType) // "pnam"
    public static let November = ITUSymbol(name: "November", code: 0x6e6f7620, type: typeType) // "nov "
    public static let null = ITUSymbol(name: "null", code: 0x6e756c6c, type: typeType) // "null"
    public static let October = ITUSymbol(name: "October", code: 0x6f637420, type: typeType) // "oct "
    public static let pagesAcross = ITUSymbol(name: "pagesAcross", code: 0x6c776c61, type: typeType) // "lwla"
    public static let pagesDown = ITUSymbol(name: "pagesDown", code: 0x6c776c64, type: typeType) // "lwld"
    public static let parent = ITUSymbol(name: "parent", code: 0x70506c50, type: typeType) // "pPlP"
    public static let persistentID = ITUSymbol(name: "persistentID", code: 0x70504953, type: typeType) // "pPIS"
    public static let PICTPicture = ITUSymbol(name: "PICTPicture", code: 0x50494354, type: typeType) // "PICT"
    public static let picture = ITUSymbol(name: "picture", code: 0x50494354, type: typeType) // "PICT"
    public static let pixelMapRecord = ITUSymbol(name: "pixelMapRecord", code: 0x74706d6d, type: typeType) // "tpmm"
    public static let playedCount = ITUSymbol(name: "playedCount", code: 0x70506c43, type: typeType) // "pPlC"
    public static let playedDate = ITUSymbol(name: "playedDate", code: 0x70506c44, type: typeType) // "pPlD"
    public static let playerPosition = ITUSymbol(name: "playerPosition", code: 0x70506f73, type: typeType) // "pPos"
    public static let playerState = ITUSymbol(name: "playerState", code: 0x70506c53, type: typeType) // "pPlS"
    public static let playlist = ITUSymbol(name: "playlist", code: 0x63506c79, type: typeType) // "cPly"
    public static let playlistWindow = ITUSymbol(name: "playlistWindow", code: 0x63506c57, type: typeType) // "cPlW"
    public static let podcast = ITUSymbol(name: "podcast", code: 0x70545063, type: typeType) // "pTPc"
    public static let point = ITUSymbol(name: "point", code: 0x51447074, type: typeType) // "QDpt"
    public static let position = ITUSymbol(name: "position", code: 0x70706f73, type: typeType) // "ppos"
    public static let preamp = ITUSymbol(name: "preamp", code: 0x70455141, type: typeType) // "pEQA"
    public static let printerFeatures = ITUSymbol(name: "printerFeatures", code: 0x6c777066, type: typeType) // "lwpf"
    public static let printSettings = ITUSymbol(name: "printSettings", code: 0x70736574, type: typeType) // "pset"
    public static let processSerialNumber = ITUSymbol(name: "processSerialNumber", code: 0x70736e20, type: typeType) // "psn "
    public static let properties = ITUSymbol(name: "properties", code: 0x70414c4c, type: typeType) // "pALL"
    public static let property_ = ITUSymbol(name: "property_", code: 0x70726f70, type: typeType) // "prop"
    public static let radioTunerPlaylist = ITUSymbol(name: "radioTunerPlaylist", code: 0x63525450, type: typeType) // "cRTP"
    public static let rating = ITUSymbol(name: "rating", code: 0x70527465, type: typeType) // "pRte"
    public static let ratingKind = ITUSymbol(name: "ratingKind", code: 0x7052746b, type: typeType) // "pRtk"
    public static let rawData = ITUSymbol(name: "rawData", code: 0x74647461, type: typeType) // "tdta"
    public static let record = ITUSymbol(name: "record", code: 0x7265636f, type: typeType) // "reco"
    public static let reference = ITUSymbol(name: "reference", code: 0x6f626a20, type: typeType) // "obj "
    public static let releaseDate = ITUSymbol(name: "releaseDate", code: 0x70526c44, type: typeType) // "pRlD"
    public static let requestedPrintTime = ITUSymbol(name: "requestedPrintTime", code: 0x6c777174, type: typeType) // "lwqt"
    public static let resizable = ITUSymbol(name: "resizable", code: 0x7072737a, type: typeType) // "prsz"
    public static let RGB16Color = ITUSymbol(name: "RGB16Color", code: 0x74723136, type: typeType) // "tr16"
    public static let RGB96Color = ITUSymbol(name: "RGB96Color", code: 0x74723936, type: typeType) // "tr96"
    public static let RGBColor = ITUSymbol(name: "RGBColor", code: 0x63524742, type: typeType) // "cRGB"
    public static let rotation = ITUSymbol(name: "rotation", code: 0x74726f74, type: typeType) // "trot"
    public static let sampleRate = ITUSymbol(name: "sampleRate", code: 0x70535274, type: typeType) // "pSRt"
    public static let Saturday = ITUSymbol(name: "Saturday", code: 0x73617420, type: typeType) // "sat "
    public static let script = ITUSymbol(name: "script", code: 0x73637074, type: typeType) // "scpt"
    public static let seasonNumber = ITUSymbol(name: "seasonNumber", code: 0x7053654e, type: typeType) // "pSeN"
    public static let selection = ITUSymbol(name: "selection", code: 0x73656c65, type: typeType) // "sele"
    public static let September = ITUSymbol(name: "September", code: 0x73657020, type: typeType) // "sep "
    public static let shared = ITUSymbol(name: "shared", code: 0x70536872, type: typeType) // "pShr"
    public static let sharedTrack = ITUSymbol(name: "sharedTrack", code: 0x63536854, type: typeType) // "cShT"
    public static let shortFloat = ITUSymbol(name: "shortFloat", code: 0x73696e67, type: typeType) // "sing"
    public static let shortInteger = ITUSymbol(name: "shortInteger", code: 0x73686f72, type: typeType) // "shor"
    public static let show = ITUSymbol(name: "show", code: 0x70536877, type: typeType) // "pShw"
    public static let shufflable = ITUSymbol(name: "shufflable", code: 0x70536661, type: typeType) // "pSfa"
    public static let shuffle = ITUSymbol(name: "shuffle", code: 0x70536866, type: typeType) // "pShf"
    public static let size = ITUSymbol(name: "size", code: 0x7053697a, type: typeType) // "pSiz"
    public static let skippedCount = ITUSymbol(name: "skippedCount", code: 0x70536b43, type: typeType) // "pSkC"
    public static let skippedDate = ITUSymbol(name: "skippedDate", code: 0x70536b44, type: typeType) // "pSkD"
    public static let smart = ITUSymbol(name: "smart", code: 0x70536d74, type: typeType) // "pSmt"
    public static let songRepeat = ITUSymbol(name: "songRepeat", code: 0x70527074, type: typeType) // "pRpt"
    public static let sortAlbum = ITUSymbol(name: "sortAlbum", code: 0x7053416c, type: typeType) // "pSAl"
    public static let sortAlbumArtist = ITUSymbol(name: "sortAlbumArtist", code: 0x70534141, type: typeType) // "pSAA"
    public static let sortArtist = ITUSymbol(name: "sortArtist", code: 0x70534172, type: typeType) // "pSAr"
    public static let sortComposer = ITUSymbol(name: "sortComposer", code: 0x7053436d, type: typeType) // "pSCm"
    public static let sortName = ITUSymbol(name: "sortName", code: 0x70534e6d, type: typeType) // "pSNm"
    public static let sortShow = ITUSymbol(name: "sortShow", code: 0x7053534e, type: typeType) // "pSSN"
    public static let soundVolume = ITUSymbol(name: "soundVolume", code: 0x70566f6c, type: typeType) // "pVol"
    public static let source = ITUSymbol(name: "source", code: 0x63537263, type: typeType) // "cSrc"
    public static let specialKind = ITUSymbol(name: "specialKind", code: 0x7053704b, type: typeType) // "pSpK"
    public static let start = ITUSymbol(name: "start", code: 0x70537472, type: typeType) // "pStr"
    public static let startingPage = ITUSymbol(name: "startingPage", code: 0x6c776670, type: typeType) // "lwfp"
    public static let string = ITUSymbol(name: "string", code: 0x54455854, type: typeType) // "TEXT"
    public static let styledClipboardText = ITUSymbol(name: "styledClipboardText", code: 0x7374796c, type: typeType) // "styl"
    public static let styledText = ITUSymbol(name: "styledText", code: 0x53545854, type: typeType) // "STXT"
    public static let Sunday = ITUSymbol(name: "Sunday", code: 0x73756e20, type: typeType) // "sun "
    public static let targetPrinter = ITUSymbol(name: "targetPrinter", code: 0x74727072, type: typeType) // "trpr"
    public static let textStyleInfo = ITUSymbol(name: "textStyleInfo", code: 0x74737479, type: typeType) // "tsty"
    public static let Thursday = ITUSymbol(name: "Thursday", code: 0x74687520, type: typeType) // "thu "
    public static let TIFFPicture = ITUSymbol(name: "TIFFPicture", code: 0x54494646, type: typeType) // "TIFF"
    public static let time = ITUSymbol(name: "time", code: 0x7054696d, type: typeType) // "pTim"
    public static let track = ITUSymbol(name: "track", code: 0x6354726b, type: typeType) // "cTrk"
    public static let trackCount = ITUSymbol(name: "trackCount", code: 0x70547243, type: typeType) // "pTrC"
    public static let trackNumber = ITUSymbol(name: "trackNumber", code: 0x7054724e, type: typeType) // "pTrN"
    public static let Tuesday = ITUSymbol(name: "Tuesday", code: 0x74756520, type: typeType) // "tue "
    public static let typeClass = ITUSymbol(name: "typeClass", code: 0x74797065, type: typeType) // "type"
    public static let unicodeText = ITUSymbol(name: "unicodeText", code: 0x75747874, type: typeType) // "utxt"
    public static let unplayed = ITUSymbol(name: "unplayed", code: 0x70556e70, type: typeType) // "pUnp"
    public static let unsignedInteger = ITUSymbol(name: "unsignedInteger", code: 0x6d61676e, type: typeType) // "magn"
    public static let updateTracks = ITUSymbol(name: "updateTracks", code: 0x70555443, type: typeType) // "pUTC"
    public static let URLTrack = ITUSymbol(name: "URLTrack", code: 0x63555254, type: typeType) // "cURT"
    public static let userPlaylist = ITUSymbol(name: "userPlaylist", code: 0x63557350, type: typeType) // "cUsP"
    public static let utf16Text = ITUSymbol(name: "utf16Text", code: 0x75743136, type: typeType) // "ut16"
    public static let utf8Text = ITUSymbol(name: "utf8Text", code: 0x75746638, type: typeType) // "utf8"
    public static let version = ITUSymbol(name: "version", code: 0x76657273, type: typeType) // "vers"
    public static let videoKind = ITUSymbol(name: "videoKind", code: 0x7056644b, type: typeType) // "pVdK"
    public static let view = ITUSymbol(name: "view", code: 0x70506c79, type: typeType) // "pPly"
    public static let visible = ITUSymbol(name: "visible", code: 0x70766973, type: typeType) // "pvis"
    public static let visual = ITUSymbol(name: "visual", code: 0x63566973, type: typeType) // "cVis"
    public static let visualsEnabled = ITUSymbol(name: "visualsEnabled", code: 0x70567345, type: typeType) // "pVsE"
    public static let visualSize = ITUSymbol(name: "visualSize", code: 0x7056537a, type: typeType) // "pVSz"
    public static let volumeAdjustment = ITUSymbol(name: "volumeAdjustment", code: 0x7041646a, type: typeType) // "pAdj"
    public static let Wednesday = ITUSymbol(name: "Wednesday", code: 0x77656420, type: typeType) // "wed "
    public static let window = ITUSymbol(name: "window", code: 0x6377696e, type: typeType) // "cwin"
    public static let writingCode = ITUSymbol(name: "writingCode", code: 0x70736374, type: typeType) // "psct"
    public static let year = ITUSymbol(name: "year", code: 0x70597220, type: typeType) // "pYr "
    public static let zoomable = ITUSymbol(name: "zoomable", code: 0x69737a6d, type: typeType) // "iszm"
    public static let zoomed = ITUSymbol(name: "zoomed", code: 0x707a756d, type: typeType) // "pzum"

    // Enumerators
    public static let albumListing = ITUSymbol(name: "albumListing", code: 0x6b416c62, type: typeEnumerated) // "kAlb"
    public static let albums = ITUSymbol(name: "albums", code: 0x6b53724c, type: typeEnumerated) // "kSrL"
    public static let all = ITUSymbol(name: "all", code: 0x6b416c6c, type: typeEnumerated) // "kAll"
    public static let artists = ITUSymbol(name: "artists", code: 0x6b537252, type: typeEnumerated) // "kSrR"
    public static let ask = ITUSymbol(name: "ask", code: 0x61736b20, type: typeEnumerated) // "ask "
    public static let audioCD = ITUSymbol(name: "audioCD", code: 0x6b414344, type: typeEnumerated) // "kACD"
    public static let Books = ITUSymbol(name: "Books", code: 0x6b537041, type: typeEnumerated) // "kSpA"
    public static let case_ = ITUSymbol(name: "case_", code: 0x63617365, type: typeEnumerated) // "case"
    public static let cdInsert = ITUSymbol(name: "cdInsert", code: 0x6b434469, type: typeEnumerated) // "kCDi"
    public static let composers = ITUSymbol(name: "composers", code: 0x6b537243, type: typeEnumerated) // "kSrC"
    public static let computed = ITUSymbol(name: "computed", code: 0x6b527443, type: typeEnumerated) // "kRtC"
    public static let detailed = ITUSymbol(name: "detailed", code: 0x6c776474, type: typeEnumerated) // "lwdt"
    public static let device = ITUSymbol(name: "device", code: 0x6b446576, type: typeEnumerated) // "kDev"
    public static let diacriticals = ITUSymbol(name: "diacriticals", code: 0x64696163, type: typeEnumerated) // "diac"
    public static let displayed = ITUSymbol(name: "displayed", code: 0x6b537256, type: typeEnumerated) // "kSrV"
    public static let expansion = ITUSymbol(name: "expansion", code: 0x65787061, type: typeEnumerated) // "expa"
    public static let fastForwarding = ITUSymbol(name: "fastForwarding", code: 0x6b505346, type: typeEnumerated) // "kPSF"
    public static let folder = ITUSymbol(name: "folder", code: 0x6b537046, type: typeEnumerated) // "kSpF"
    public static let Genius = ITUSymbol(name: "Genius", code: 0x6b537047, type: typeEnumerated) // "kSpG"
    public static let hyphens = ITUSymbol(name: "hyphens", code: 0x68797068, type: typeEnumerated) // "hyph"
    public static let iPod = ITUSymbol(name: "iPod", code: 0x6b506f64, type: typeEnumerated) // "kPod"
    public static let iTunesU = ITUSymbol(name: "iTunesU", code: 0x6b537055, type: typeEnumerated) // "kSpU"
    public static let large = ITUSymbol(name: "large", code: 0x6b56534c, type: typeEnumerated) // "kVSL"
    public static let Library = ITUSymbol(name: "Library", code: 0x6b53704c, type: typeEnumerated) // "kSpL"
    public static let library = ITUSymbol(name: "library", code: 0x6b4c6962, type: typeEnumerated) // "kLib"
    public static let medium = ITUSymbol(name: "medium", code: 0x6b56534d, type: typeEnumerated) // "kVSM"
    public static let movie = ITUSymbol(name: "movie", code: 0x6b56644d, type: typeEnumerated) // "kVdM"
    public static let Movies = ITUSymbol(name: "Movies", code: 0x6b537049, type: typeEnumerated) // "kSpI"
    public static let MP3CD = ITUSymbol(name: "MP3CD", code: 0x6b4d4344, type: typeEnumerated) // "kMCD"
    public static let Music = ITUSymbol(name: "Music", code: 0x6b53705a, type: typeEnumerated) // "kSpZ"
    public static let musicVideo = ITUSymbol(name: "musicVideo", code: 0x6b566456, type: typeEnumerated) // "kVdV"
    public static let no = ITUSymbol(name: "no", code: 0x6e6f2020, type: typeEnumerated) // "no  "
    public static let none_ = ITUSymbol(name: "none_", code: 0x6b4e6f6e, type: typeEnumerated) // "kNon"
    public static let numericStrings = ITUSymbol(name: "numericStrings", code: 0x6e756d65, type: typeEnumerated) // "nume"
    public static let off = ITUSymbol(name: "off", code: 0x6b52704f, type: typeEnumerated) // "kRpO"
    public static let one = ITUSymbol(name: "one", code: 0x6b527031, type: typeEnumerated) // "kRp1"
    public static let PartyShuffle = ITUSymbol(name: "PartyShuffle", code: 0x6b537053, type: typeEnumerated) // "kSpS"
    public static let paused = ITUSymbol(name: "paused", code: 0x6b505370, type: typeEnumerated) // "kPSp"
    public static let playing = ITUSymbol(name: "playing", code: 0x6b505350, type: typeEnumerated) // "kPSP"
    public static let Podcasts = ITUSymbol(name: "Podcasts", code: 0x6b537050, type: typeEnumerated) // "kSpP"
    public static let punctuation = ITUSymbol(name: "punctuation", code: 0x70756e63, type: typeEnumerated) // "punc"
    public static let PurchasedMusic = ITUSymbol(name: "PurchasedMusic", code: 0x6b53704d, type: typeEnumerated) // "kSpM"
    public static let radioTuner = ITUSymbol(name: "radioTuner", code: 0x6b54756e, type: typeEnumerated) // "kTun"
    public static let rewinding = ITUSymbol(name: "rewinding", code: 0x6b505352, type: typeEnumerated) // "kPSR"
    public static let sharedLibrary = ITUSymbol(name: "sharedLibrary", code: 0x6b536864, type: typeEnumerated) // "kShd"
    public static let small = ITUSymbol(name: "small", code: 0x6b565353, type: typeEnumerated) // "kVSS"
    public static let songs = ITUSymbol(name: "songs", code: 0x6b537253, type: typeEnumerated) // "kSrS"
    public static let standard = ITUSymbol(name: "standard", code: 0x6c777374, type: typeEnumerated) // "lwst"
    public static let stopped = ITUSymbol(name: "stopped", code: 0x6b505353, type: typeEnumerated) // "kPSS"
    public static let trackListing = ITUSymbol(name: "trackListing", code: 0x6b54726b, type: typeEnumerated) // "kTrk"
    public static let TVShow = ITUSymbol(name: "TVShow", code: 0x6b566454, type: typeEnumerated) // "kVdT"
    public static let TVShows = ITUSymbol(name: "TVShows", code: 0x6b537054, type: typeEnumerated) // "kSpT"
    public static let unknown = ITUSymbol(name: "unknown", code: 0x6b556e6b, type: typeEnumerated) // "kUnk"
    public static let user = ITUSymbol(name: "user", code: 0x6b527455, type: typeEnumerated) // "kRtU"
    public static let whitespace = ITUSymbol(name: "whitespace", code: 0x77686974, type: typeEnumerated) // "whit"
    public static let yes = ITUSymbol(name: "yes", code: 0x79657320, type: typeEnumerated) // "yes "
}

public typealias ITU = ITUSymbol // allows symbols to be written as (e.g.) ITU.name instead of ITUSymbol.name



/******************************************************************************/
// Specifier extensions; these add command methods and property/elements getters based on iTunes.app terminology

public protocol ITUCommand: SpecifierProtocol {} // provides AE dispatch methods

// Command->Any will be bound when return type can't be inferred, else Command->T

extension ITUCommand {
    public func activate(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("activate", eventClass: 0x6d697363, eventID: 0x61637476, // "misc"/"actv"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func activate<T>(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("activate", eventClass: 0x6d697363, eventID: 0x61637476, // "misc"/"actv"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    public func add(_ directParameter: Any = NoParameter,
            to: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("add", eventClass: 0x686f6f6b, eventID: 0x41646420, // "hook"/"Add "
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x696e7368, to), // "insh"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func add<T>(_ directParameter: Any = NoParameter,
            to: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("add", eventClass: 0x686f6f6b, eventID: 0x41646420, // "hook"/"Add "
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x696e7368, to), // "insh"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    public func backTrack(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("backTrack", eventClass: 0x686f6f6b, eventID: 0x4261636b, // "hook"/"Back"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func backTrack<T>(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("backTrack", eventClass: 0x686f6f6b, eventID: 0x4261636b, // "hook"/"Back"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    public func close(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("close", eventClass: 0x636f7265, eventID: 0x636c6f73, // "core"/"clos"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func close<T>(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("close", eventClass: 0x636f7265, eventID: 0x636c6f73, // "core"/"clos"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    public func convert(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("convert", eventClass: 0x686f6f6b, eventID: 0x436f6e76, // "hook"/"Conv"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func convert<T>(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("convert", eventClass: 0x686f6f6b, eventID: 0x436f6e76, // "hook"/"Conv"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    public func count(_ directParameter: Any = NoParameter,
            each: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("count", eventClass: 0x636f7265, eventID: 0x636e7465, // "core"/"cnte"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("each", 0x6b6f636c, each), // "kocl"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func count<T>(_ directParameter: Any = NoParameter,
            each: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("count", eventClass: 0x636f7265, eventID: 0x636e7465, // "core"/"cnte"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("each", 0x6b6f636c, each), // "kocl"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    public func delete(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("delete", eventClass: 0x636f7265, eventID: 0x64656c6f, // "core"/"delo"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func delete<T>(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("delete", eventClass: 0x636f7265, eventID: 0x64656c6f, // "core"/"delo"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    public func download(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("download", eventClass: 0x686f6f6b, eventID: 0x44776e6c, // "hook"/"Dwnl"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func download<T>(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("download", eventClass: 0x686f6f6b, eventID: 0x44776e6c, // "hook"/"Dwnl"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    public func duplicate(_ directParameter: Any = NoParameter,
            to: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("duplicate", eventClass: 0x636f7265, eventID: 0x636c6f6e, // "core"/"clon"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x696e7368, to), // "insh"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func duplicate<T>(_ directParameter: Any = NoParameter,
            to: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("duplicate", eventClass: 0x636f7265, eventID: 0x636c6f6e, // "core"/"clon"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x696e7368, to), // "insh"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    public func eject(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("eject", eventClass: 0x686f6f6b, eventID: 0x456a6374, // "hook"/"Ejct"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func eject<T>(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("eject", eventClass: 0x686f6f6b, eventID: 0x456a6374, // "hook"/"Ejct"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    public func exists(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("exists", eventClass: 0x636f7265, eventID: 0x646f6578, // "core"/"doex"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func exists<T>(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("exists", eventClass: 0x636f7265, eventID: 0x646f6578, // "core"/"doex"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    public func fastForward(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("fastForward", eventClass: 0x686f6f6b, eventID: 0x46617374, // "hook"/"Fast"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func fastForward<T>(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("fastForward", eventClass: 0x686f6f6b, eventID: 0x46617374, // "hook"/"Fast"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    public func get(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("get", eventClass: 0x636f7265, eventID: 0x67657464, // "core"/"getd"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func get<T>(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("get", eventClass: 0x636f7265, eventID: 0x67657464, // "core"/"getd"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    public func launch(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("launch", eventClass: 0x61736372, eventID: 0x6e6f6f70, // "ascr"/"noop"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func launch<T>(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("launch", eventClass: 0x61736372, eventID: 0x6e6f6f70, // "ascr"/"noop"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    public func make(_ directParameter: Any = NoParameter,
            new: Any = NoParameter,
            at: Any = NoParameter,
            withProperties: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("make", eventClass: 0x636f7265, eventID: 0x6372656c, // "core"/"crel"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("new", 0x6b6f636c, new), // "kocl"
                    ("at", 0x696e7368, at), // "insh"
                    ("withProperties", 0x70726474, withProperties), // "prdt"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func make<T>(_ directParameter: Any = NoParameter,
            new: Any = NoParameter,
            at: Any = NoParameter,
            withProperties: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("make", eventClass: 0x636f7265, eventID: 0x6372656c, // "core"/"crel"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("new", 0x6b6f636c, new), // "kocl"
                    ("at", 0x696e7368, at), // "insh"
                    ("withProperties", 0x70726474, withProperties), // "prdt"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    public func move(_ directParameter: Any = NoParameter,
            to: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("move", eventClass: 0x636f7265, eventID: 0x6d6f7665, // "core"/"move"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x696e7368, to), // "insh"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func move<T>(_ directParameter: Any = NoParameter,
            to: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("move", eventClass: 0x636f7265, eventID: 0x6d6f7665, // "core"/"move"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x696e7368, to), // "insh"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    public func nextTrack(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("nextTrack", eventClass: 0x686f6f6b, eventID: 0x4e657874, // "hook"/"Next"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func nextTrack<T>(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("nextTrack", eventClass: 0x686f6f6b, eventID: 0x4e657874, // "hook"/"Next"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    public func open(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("open", eventClass: 0x61657674, eventID: 0x6f646f63, // "aevt"/"odoc"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func open<T>(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("open", eventClass: 0x61657674, eventID: 0x6f646f63, // "aevt"/"odoc"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    public func openLocation(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("openLocation", eventClass: 0x4755524c, eventID: 0x4755524c, // "GURL"/"GURL"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func openLocation<T>(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("openLocation", eventClass: 0x4755524c, eventID: 0x4755524c, // "GURL"/"GURL"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    public func pause(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("pause", eventClass: 0x686f6f6b, eventID: 0x50617573, // "hook"/"Paus"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func pause<T>(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("pause", eventClass: 0x686f6f6b, eventID: 0x50617573, // "hook"/"Paus"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    public func play(_ directParameter: Any = NoParameter,
            once: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("play", eventClass: 0x686f6f6b, eventID: 0x506c6179, // "hook"/"Play"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("once", 0x504f6e65, once), // "POne"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func play<T>(_ directParameter: Any = NoParameter,
            once: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("play", eventClass: 0x686f6f6b, eventID: 0x506c6179, // "hook"/"Play"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("once", 0x504f6e65, once), // "POne"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    public func playpause(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("playpause", eventClass: 0x686f6f6b, eventID: 0x506c5073, // "hook"/"PlPs"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func playpause<T>(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("playpause", eventClass: 0x686f6f6b, eventID: 0x506c5073, // "hook"/"PlPs"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    public func previousTrack(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("previousTrack", eventClass: 0x686f6f6b, eventID: 0x50726576, // "hook"/"Prev"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func previousTrack<T>(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("previousTrack", eventClass: 0x686f6f6b, eventID: 0x50726576, // "hook"/"Prev"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    public func print(_ directParameter: Any = NoParameter,
            printDialog: Any = NoParameter,
            withProperties: Any = NoParameter,
            kind: Any = NoParameter,
            theme: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("print", eventClass: 0x61657674, eventID: 0x70646f63, // "aevt"/"pdoc"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("printDialog", 0x70646c67, printDialog), // "pdlg"
                    ("withProperties", 0x70726474, withProperties), // "prdt"
                    ("kind", 0x704b6e64, kind), // "pKnd"
                    ("theme", 0x7054686d, theme), // "pThm"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func print<T>(_ directParameter: Any = NoParameter,
            printDialog: Any = NoParameter,
            withProperties: Any = NoParameter,
            kind: Any = NoParameter,
            theme: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("print", eventClass: 0x61657674, eventID: 0x70646f63, // "aevt"/"pdoc"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("printDialog", 0x70646c67, printDialog), // "pdlg"
                    ("withProperties", 0x70726474, withProperties), // "prdt"
                    ("kind", 0x704b6e64, kind), // "pKnd"
                    ("theme", 0x7054686d, theme), // "pThm"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    public func quit(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("quit", eventClass: 0x61657674, eventID: 0x71756974, // "aevt"/"quit"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func quit<T>(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("quit", eventClass: 0x61657674, eventID: 0x71756974, // "aevt"/"quit"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    public func refresh(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("refresh", eventClass: 0x686f6f6b, eventID: 0x52667273, // "hook"/"Rfrs"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func refresh<T>(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("refresh", eventClass: 0x686f6f6b, eventID: 0x52667273, // "hook"/"Rfrs"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    public func reopen(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("reopen", eventClass: 0x61657674, eventID: 0x72617070, // "aevt"/"rapp"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func reopen<T>(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("reopen", eventClass: 0x61657674, eventID: 0x72617070, // "aevt"/"rapp"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    public func resume(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("resume", eventClass: 0x686f6f6b, eventID: 0x52657375, // "hook"/"Resu"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func resume<T>(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("resume", eventClass: 0x686f6f6b, eventID: 0x52657375, // "hook"/"Resu"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    public func reveal(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("reveal", eventClass: 0x686f6f6b, eventID: 0x5265766c, // "hook"/"Revl"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func reveal<T>(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("reveal", eventClass: 0x686f6f6b, eventID: 0x5265766c, // "hook"/"Revl"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    public func rewind(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("rewind", eventClass: 0x686f6f6b, eventID: 0x52776e64, // "hook"/"Rwnd"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func rewind<T>(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("rewind", eventClass: 0x686f6f6b, eventID: 0x52776e64, // "hook"/"Rwnd"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    public func run(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("run", eventClass: 0x61657674, eventID: 0x6f617070, // "aevt"/"oapp"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func run<T>(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("run", eventClass: 0x61657674, eventID: 0x6f617070, // "aevt"/"oapp"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    public func search(_ directParameter: Any = NoParameter,
            for_: Any = NoParameter,
            only: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("search", eventClass: 0x686f6f6b, eventID: 0x53726368, // "hook"/"Srch"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("for_", 0x7054726d, for_), // "pTrm"
                    ("only", 0x70417265, only), // "pAre"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func search<T>(_ directParameter: Any = NoParameter,
            for_: Any = NoParameter,
            only: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("search", eventClass: 0x686f6f6b, eventID: 0x53726368, // "hook"/"Srch"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("for_", 0x7054726d, for_), // "pTrm"
                    ("only", 0x70417265, only), // "pAre"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    public func set(_ directParameter: Any = NoParameter,
            to: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("set", eventClass: 0x636f7265, eventID: 0x73657464, // "core"/"setd"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x64617461, to), // "data"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func set<T>(_ directParameter: Any = NoParameter,
            to: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("set", eventClass: 0x636f7265, eventID: 0x73657464, // "core"/"setd"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x64617461, to), // "data"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    public func stop(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("stop", eventClass: 0x686f6f6b, eventID: 0x53746f70, // "hook"/"Stop"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func stop<T>(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("stop", eventClass: 0x686f6f6b, eventID: 0x53746f70, // "hook"/"Stop"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    public func subscribe(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("subscribe", eventClass: 0x686f6f6b, eventID: 0x70537562, // "hook"/"pSub"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func subscribe<T>(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("subscribe", eventClass: 0x686f6f6b, eventID: 0x70537562, // "hook"/"pSub"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    public func update(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("update", eventClass: 0x686f6f6b, eventID: 0x55706474, // "hook"/"Updt"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func update<T>(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("update", eventClass: 0x686f6f6b, eventID: 0x55706474, // "hook"/"Updt"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    public func updateAllPodcasts(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("updateAllPodcasts", eventClass: 0x686f6f6b, eventID: 0x55706470, // "hook"/"Updp"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func updateAllPodcasts<T>(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("updateAllPodcasts", eventClass: 0x686f6f6b, eventID: 0x55706470, // "hook"/"Updp"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    public func updatePodcast(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("updatePodcast", eventClass: 0x686f6f6b, eventID: 0x55706431, // "hook"/"Upd1"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func updatePodcast<T>(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("updatePodcast", eventClass: 0x686f6f6b, eventID: 0x55706431, // "hook"/"Upd1"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
}


public protocol ITUQuery: ObjectSpecifierExtension, ITUCommand {} // provides vars and methods for constructing specifiers

extension ITUQuery {
    
    // Properties
    public var address: ITUObject {return self.property(0x7055524c) as! ITUObject} // "pURL"
    public var album: ITUObject {return self.property(0x70416c62) as! ITUObject} // "pAlb"
    public var albumArtist: ITUObject {return self.property(0x70416c41) as! ITUObject} // "pAlA"
    public var albumRating: ITUObject {return self.property(0x70416c52) as! ITUObject} // "pAlR"
    public var albumRatingKind: ITUObject {return self.property(0x7041526b) as! ITUObject} // "pARk"
    public var artist: ITUObject {return self.property(0x70417274) as! ITUObject} // "pArt"
    public var band1: ITUObject {return self.property(0x70455131) as! ITUObject} // "pEQ1"
    public var band10: ITUObject {return self.property(0x70455130) as! ITUObject} // "pEQ0"
    public var band2: ITUObject {return self.property(0x70455132) as! ITUObject} // "pEQ2"
    public var band3: ITUObject {return self.property(0x70455133) as! ITUObject} // "pEQ3"
    public var band4: ITUObject {return self.property(0x70455134) as! ITUObject} // "pEQ4"
    public var band5: ITUObject {return self.property(0x70455135) as! ITUObject} // "pEQ5"
    public var band6: ITUObject {return self.property(0x70455136) as! ITUObject} // "pEQ6"
    public var band7: ITUObject {return self.property(0x70455137) as! ITUObject} // "pEQ7"
    public var band8: ITUObject {return self.property(0x70455138) as! ITUObject} // "pEQ8"
    public var band9: ITUObject {return self.property(0x70455139) as! ITUObject} // "pEQ9"
    public var bitRate: ITUObject {return self.property(0x70425274) as! ITUObject} // "pBRt"
    public var bookmark: ITUObject {return self.property(0x70426b74) as! ITUObject} // "pBkt"
    public var bookmarkable: ITUObject {return self.property(0x70426b6d) as! ITUObject} // "pBkm"
    public var bounds: ITUObject {return self.property(0x70626e64) as! ITUObject} // "pbnd"
    public var bpm: ITUObject {return self.property(0x7042504d) as! ITUObject} // "pBPM"
    public var capacity: ITUObject {return self.property(0x63617061) as! ITUObject} // "capa"
    public var category: ITUObject {return self.property(0x70436174) as! ITUObject} // "pCat"
    public var class_: ITUObject {return self.property(0x70636c73) as! ITUObject} // "pcls"
    public var closeable: ITUObject {return self.property(0x68636c62) as! ITUObject} // "hclb"
    public var collapseable: ITUObject {return self.property(0x70575368) as! ITUObject} // "pWSh"
    public var collapsed: ITUObject {return self.property(0x77736864) as! ITUObject} // "wshd"
    public var collating: ITUObject {return self.property(0x6c77636c) as! ITUObject} // "lwcl"
    public var comment: ITUObject {return self.property(0x70436d74) as! ITUObject} // "pCmt"
    public var compilation: ITUObject {return self.property(0x70416e74) as! ITUObject} // "pAnt"
    public var composer: ITUObject {return self.property(0x70436d70) as! ITUObject} // "pCmp"
    public var container: ITUObject {return self.property(0x63746e72) as! ITUObject} // "ctnr"
    public var copies: ITUObject {return self.property(0x6c776370) as! ITUObject} // "lwcp"
    public var currentEncoder: ITUObject {return self.property(0x70456e63) as! ITUObject} // "pEnc"
    public var currentEQPreset: ITUObject {return self.property(0x70455150) as! ITUObject} // "pEQP"
    public var currentPlaylist: ITUObject {return self.property(0x70506c61) as! ITUObject} // "pPla"
    public var currentStreamTitle: ITUObject {return self.property(0x70537454) as! ITUObject} // "pStT"
    public var currentStreamURL: ITUObject {return self.property(0x70537455) as! ITUObject} // "pStU"
    public var currentTrack: ITUObject {return self.property(0x7054726b) as! ITUObject} // "pTrk"
    public var currentVisual: ITUObject {return self.property(0x70566973) as! ITUObject} // "pVis"
    public var data_: ITUObject {return self.property(0x70504354) as! ITUObject} // "pPCT"
    public var databaseID: ITUObject {return self.property(0x70444944) as! ITUObject} // "pDID"
    public var dateAdded: ITUObject {return self.property(0x70416464) as! ITUObject} // "pAdd"
    public var description: ITUObject {return self.property(0x70446573) as! ITUObject} // "pDes"
    public var discCount: ITUObject {return self.property(0x70447343) as! ITUObject} // "pDsC"
    public var discNumber: ITUObject {return self.property(0x7044734e) as! ITUObject} // "pDsN"
    public var downloaded: ITUObject {return self.property(0x70446c41) as! ITUObject} // "pDlA"
    public var duration: ITUObject {return self.property(0x70447572) as! ITUObject} // "pDur"
    public var enabled: ITUObject {return self.property(0x656e626c) as! ITUObject} // "enbl"
    public var endingPage: ITUObject {return self.property(0x6c776c70) as! ITUObject} // "lwlp"
    public var episodeID: ITUObject {return self.property(0x70457044) as! ITUObject} // "pEpD"
    public var episodeNumber: ITUObject {return self.property(0x7045704e) as! ITUObject} // "pEpN"
    public var EQ: ITUObject {return self.property(0x70455170) as! ITUObject} // "pEQp"
    public var EQEnabled: ITUObject {return self.property(0x70455120) as! ITUObject} // "pEQ "
    public var errorHandling: ITUObject {return self.property(0x6c776568) as! ITUObject} // "lweh"
    public var faxNumber: ITUObject {return self.property(0x6661786e) as! ITUObject} // "faxn"
    public var finish: ITUObject {return self.property(0x70537470) as! ITUObject} // "pStp"
    public var fixedIndexing: ITUObject {return self.property(0x70466978) as! ITUObject} // "pFix"
    public var format: ITUObject {return self.property(0x70466d74) as! ITUObject} // "pFmt"
    public var freeSpace: ITUObject {return self.property(0x66727370) as! ITUObject} // "frsp"
    public var frontmost: ITUObject {return self.property(0x70697366) as! ITUObject} // "pisf"
    public var fullScreen: ITUObject {return self.property(0x70465363) as! ITUObject} // "pFSc"
    public var gapless: ITUObject {return self.property(0x7047706c) as! ITUObject} // "pGpl"
    public var genre: ITUObject {return self.property(0x7047656e) as! ITUObject} // "pGen"
    public var grouping: ITUObject {return self.property(0x70477270) as! ITUObject} // "pGrp"
    public var id: ITUObject {return self.property(0x49442020) as! ITUObject} // "ID  "
    public var index: ITUObject {return self.property(0x70696478) as! ITUObject} // "pidx"
    public var kind: ITUObject {return self.property(0x704b6e64) as! ITUObject} // "pKnd"
    public var location: ITUObject {return self.property(0x704c6f63) as! ITUObject} // "pLoc"
    public var longDescription: ITUObject {return self.property(0x704c6473) as! ITUObject} // "pLds"
    public var lyrics: ITUObject {return self.property(0x704c7972) as! ITUObject} // "pLyr"
    public var minimized: ITUObject {return self.property(0x704d696e) as! ITUObject} // "pMin"
    public var modifiable: ITUObject {return self.property(0x704d6f64) as! ITUObject} // "pMod"
    public var modificationDate: ITUObject {return self.property(0x61736d6f) as! ITUObject} // "asmo"
    public var mute: ITUObject {return self.property(0x704d7574) as! ITUObject} // "pMut"
    public var name: ITUObject {return self.property(0x706e616d) as! ITUObject} // "pnam"
    public var pagesAcross: ITUObject {return self.property(0x6c776c61) as! ITUObject} // "lwla"
    public var pagesDown: ITUObject {return self.property(0x6c776c64) as! ITUObject} // "lwld"
    public var parent: ITUObject {return self.property(0x70506c50) as! ITUObject} // "pPlP"
    public var persistentID: ITUObject {return self.property(0x70504953) as! ITUObject} // "pPIS"
    public var playedCount: ITUObject {return self.property(0x70506c43) as! ITUObject} // "pPlC"
    public var playedDate: ITUObject {return self.property(0x70506c44) as! ITUObject} // "pPlD"
    public var playerPosition: ITUObject {return self.property(0x70506f73) as! ITUObject} // "pPos"
    public var playerState: ITUObject {return self.property(0x70506c53) as! ITUObject} // "pPlS"
    public var podcast: ITUObject {return self.property(0x70545063) as! ITUObject} // "pTPc"
    public var position: ITUObject {return self.property(0x70706f73) as! ITUObject} // "ppos"
    public var preamp: ITUObject {return self.property(0x70455141) as! ITUObject} // "pEQA"
    public var printerFeatures: ITUObject {return self.property(0x6c777066) as! ITUObject} // "lwpf"
    public var properties: ITUObject {return self.property(0x70414c4c) as! ITUObject} // "pALL"
    public var rating: ITUObject {return self.property(0x70527465) as! ITUObject} // "pRte"
    public var ratingKind: ITUObject {return self.property(0x7052746b) as! ITUObject} // "pRtk"
    public var rawData: ITUObject {return self.property(0x70526177) as! ITUObject} // "pRaw"
    public var releaseDate: ITUObject {return self.property(0x70526c44) as! ITUObject} // "pRlD"
    public var requestedPrintTime: ITUObject {return self.property(0x6c777174) as! ITUObject} // "lwqt"
    public var resizable: ITUObject {return self.property(0x7072737a) as! ITUObject} // "prsz"
    public var sampleRate: ITUObject {return self.property(0x70535274) as! ITUObject} // "pSRt"
    public var seasonNumber: ITUObject {return self.property(0x7053654e) as! ITUObject} // "pSeN"
    public var selection: ITUObject {return self.property(0x73656c65) as! ITUObject} // "sele"
    public var shared: ITUObject {return self.property(0x70536872) as! ITUObject} // "pShr"
    public var show: ITUObject {return self.property(0x70536877) as! ITUObject} // "pShw"
    public var shufflable: ITUObject {return self.property(0x70536661) as! ITUObject} // "pSfa"
    public var shuffle: ITUObject {return self.property(0x70536866) as! ITUObject} // "pShf"
    public var size: ITUObject {return self.property(0x7053697a) as! ITUObject} // "pSiz"
    public var skippedCount: ITUObject {return self.property(0x70536b43) as! ITUObject} // "pSkC"
    public var skippedDate: ITUObject {return self.property(0x70536b44) as! ITUObject} // "pSkD"
    public var smart: ITUObject {return self.property(0x70536d74) as! ITUObject} // "pSmt"
    public var songRepeat: ITUObject {return self.property(0x70527074) as! ITUObject} // "pRpt"
    public var sortAlbum: ITUObject {return self.property(0x7053416c) as! ITUObject} // "pSAl"
    public var sortAlbumArtist: ITUObject {return self.property(0x70534141) as! ITUObject} // "pSAA"
    public var sortArtist: ITUObject {return self.property(0x70534172) as! ITUObject} // "pSAr"
    public var sortComposer: ITUObject {return self.property(0x7053436d) as! ITUObject} // "pSCm"
    public var sortName: ITUObject {return self.property(0x70534e6d) as! ITUObject} // "pSNm"
    public var sortShow: ITUObject {return self.property(0x7053534e) as! ITUObject} // "pSSN"
    public var soundVolume: ITUObject {return self.property(0x70566f6c) as! ITUObject} // "pVol"
    public var specialKind: ITUObject {return self.property(0x7053704b) as! ITUObject} // "pSpK"
    public var start: ITUObject {return self.property(0x70537472) as! ITUObject} // "pStr"
    public var startingPage: ITUObject {return self.property(0x6c776670) as! ITUObject} // "lwfp"
    public var targetPrinter: ITUObject {return self.property(0x74727072) as! ITUObject} // "trpr"
    public var time: ITUObject {return self.property(0x7054696d) as! ITUObject} // "pTim"
    public var trackCount: ITUObject {return self.property(0x70547243) as! ITUObject} // "pTrC"
    public var trackNumber: ITUObject {return self.property(0x7054724e) as! ITUObject} // "pTrN"
    public var unplayed: ITUObject {return self.property(0x70556e70) as! ITUObject} // "pUnp"
    public var updateTracks: ITUObject {return self.property(0x70555443) as! ITUObject} // "pUTC"
    public var version: ITUObject {return self.property(0x76657273) as! ITUObject} // "vers"
    public var videoKind: ITUObject {return self.property(0x7056644b) as! ITUObject} // "pVdK"
    public var view: ITUObject {return self.property(0x70506c79) as! ITUObject} // "pPly"
    public var visible: ITUObject {return self.property(0x70766973) as! ITUObject} // "pvis"
    public var visualsEnabled: ITUObject {return self.property(0x70567345) as! ITUObject} // "pVsE"
    public var visualSize: ITUObject {return self.property(0x7056537a) as! ITUObject} // "pVSz"
    public var volumeAdjustment: ITUObject {return self.property(0x7041646a) as! ITUObject} // "pAdj"
    public var year: ITUObject {return self.property(0x70597220) as! ITUObject} // "pYr "
    public var zoomable: ITUObject {return self.property(0x69737a6d) as! ITUObject} // "iszm"
    public var zoomed: ITUObject {return self.property(0x707a756d) as! ITUObject} // "pzum"

    // Elements
    public var applications: ITUElements {return self.elements(0x63617070) as! ITUElements} // "capp"
    public var artworks: ITUElements {return self.elements(0x63417274) as! ITUElements} // "cArt"
    public var audioCDPlaylists: ITUElements {return self.elements(0x63434450) as! ITUElements} // "cCDP"
    public var audioCDTracks: ITUElements {return self.elements(0x63434454) as! ITUElements} // "cCDT"
    public var browserWindows: ITUElements {return self.elements(0x63427257) as! ITUElements} // "cBrW"
    public var devicePlaylists: ITUElements {return self.elements(0x63447650) as! ITUElements} // "cDvP"
    public var deviceTracks: ITUElements {return self.elements(0x63447654) as! ITUElements} // "cDvT"
    public var encoders: ITUElements {return self.elements(0x63456e63) as! ITUElements} // "cEnc"
    public var EQPresets: ITUElements {return self.elements(0x63455150) as! ITUElements} // "cEQP"
    public var EQWindows: ITUElements {return self.elements(0x63455157) as! ITUElements} // "cEQW"
    public var fileTracks: ITUElements {return self.elements(0x63466c54) as! ITUElements} // "cFlT"
    public var folderPlaylists: ITUElements {return self.elements(0x63466f50) as! ITUElements} // "cFoP"
    public var items: ITUElements {return self.elements(0x636f626a) as! ITUElements} // "cobj"
    public var libraryPlaylists: ITUElements {return self.elements(0x634c6950) as! ITUElements} // "cLiP"
    public var picture: ITUElements {return self.elements(0x50494354) as! ITUElements} // "PICT"
    public var playlists: ITUElements {return self.elements(0x63506c79) as! ITUElements} // "cPly"
    public var playlistWindows: ITUElements {return self.elements(0x63506c57) as! ITUElements} // "cPlW"
    public var printSettings: ITUElements {return self.elements(0x70736574) as! ITUElements} // "pset"
    public var radioTunerPlaylists: ITUElements {return self.elements(0x63525450) as! ITUElements} // "cRTP"
    public var sharedTracks: ITUElements {return self.elements(0x63536854) as! ITUElements} // "cShT"
    public var sources: ITUElements {return self.elements(0x63537263) as! ITUElements} // "cSrc"
    public var tracks: ITUElements {return self.elements(0x6354726b) as! ITUElements} // "cTrk"
    public var URLTracks: ITUElements {return self.elements(0x63555254) as! ITUElements} // "cURT"
    public var userPlaylists: ITUElements {return self.elements(0x63557350) as! ITUElements} // "cUsP"
    public var visuals: ITUElements {return self.elements(0x63566973) as! ITUElements} // "cVis"
    public var windows: ITUElements {return self.elements(0x6377696e) as! ITUElements} // "cwin"
}


/******************************************************************************/
// Specifier subclasses add app-specific extensions

// beginning/end/before/after
public class ITUInsertion: InsertionSpecifier, ITUCommand {}


// by index/name/id/previous/next
// first/middle/last/any
public class ITUObject: ObjectSpecifier, ITUQuery {
    public typealias InsertionSpecifierType = ITUInsertion
    public typealias ObjectSpecifierType = ITUObject
    public typealias ElementsSpecifierType = ITUElements
}

// by range/test
// all
public class ITUElements: ITUObject, ElementsSpecifierExtension {}

// App/Con/Its
public class ITURoot: RootSpecifier, ITUQuery, RootSpecifierExtension {
    public typealias InsertionSpecifierType = ITUInsertion
    public typealias ObjectSpecifierType = ITUObject
    public typealias ElementsSpecifierType = ITUElements
    public override class var untargetedAppData: AppData { return gUntargetedAppData }
}

// application
public class ITunes: ITURoot, ApplicationExtension {
    public convenience init(launchOptions: LaunchOptions = DefaultLaunchOptions, relaunchMode: RelaunchMode = DefaultRelaunchMode) {
        self.init(rootObject: AppRootDesc, appData: type(of:self).untargetedAppData.targetedCopy(
                .bundleIdentifier("com.apple.iTunes", true), launchOptions: launchOptions, relaunchMode: relaunchMode))
    }
}

// App/Con/Its root objects used to construct untargeted specifiers; these can be used to construct specifiers for use in commands, though cannot send commands themselves

public let ITUApp = gUntargetedAppData.rootObjects.app as! ITURoot
public let ITUCon = gUntargetedAppData.rootObjects.con as! ITURoot
public let ITUIts = gUntargetedAppData.rootObjects.its as! ITURoot

