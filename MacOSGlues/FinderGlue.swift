//
//  FinderGlue.swift
//  Finder.app 10.14.4
//  SwiftAutomation.framework 0.1.0
//  `aeglue -S 'Finder.app'`
//


import Foundation
import SwiftAutomation


/******************************************************************************/
// Create an untargeted AppData instance for use in App, Con, Its roots,
// and in Application initializers to create targeted AppData instances.

private let _specifierFormatter = SwiftAutomation.SpecifierFormatter(applicationClassName: "Finder",
                                                     classNamePrefix: "FIN",
                                                     typeNames: [
                                                                     0x69736162: "acceptsHighLevelEvents", // "isab"
                                                                     0x72657674: "acceptsRemoteEvents", // "revt"
                                                                     0x70616476: "AdvancedPreferencesPanel", // "padv"
                                                                     0x616c6973: "alias", // "alis"
                                                                     0x616c6961: "aliasFile", // "alia"
                                                                     0x616c7374: "aliasList", // "alst"
                                                                     0x70736e78: "allNameExtensionsShowing", // "psnx"
                                                                     0x2a2a2a2a: "anything", // "****"
                                                                     0x64666170: "APFSFormat", // "dfap"
                                                                     0x64667068: "ApplePhotoFormat", // "dfph"
                                                                     0x64666173: "AppleShareFormat", // "dfas"
                                                                     0x63617070: "application", // "capp"
                                                                     0x62756e64: "applicationBundleID", // "bund"
                                                                     0x61707066: "applicationFile", // "appf"
                                                                     0x61706e6c: "ApplicationPanel", // "apnl"
                                                                     0x70636170: "applicationProcess", // "pcap"
                                                                     0x7369676e: "applicationSignature", // "sign"
                                                                     0x6170726c: "applicationURL", // "aprl"
                                                                     0x61707220: "April", // "apr\0x20"
                                                                     0x63647461: "arrangedByCreationDate", // "cdta"
                                                                     0x6b696e61: "arrangedByKind", // "kina"
                                                                     0x6c616261: "arrangedByLabel", // "laba"
                                                                     0x6d647461: "arrangedByModificationDate", // "mdta"
                                                                     0x6e616d61: "arrangedByName", // "nama"
                                                                     0x73697a61: "arrangedBySize", // "siza"
                                                                     0x69617272: "arrangement", // "iarr"
                                                                     0x61736b20: "ask", // "ask\0x20"
                                                                     0x64666175: "audioFormat", // "dfau"
                                                                     0x61756720: "August", // "aug\0x20"
                                                                     0x636f6c72: "backgroundColor", // "colr"
                                                                     0x69626b67: "backgroundPicture", // "ibkg"
                                                                     0x62657374: "best", // "best"
                                                                     0x626d726b: "bookmarkData", // "bmrk"
                                                                     0x626f6f6c: "boolean", // "bool"
                                                                     0x6c626f74: "bottom", // "lbot"
                                                                     0x71647274: "boundingRectangle", // "qdrt"
                                                                     0x70626e64: "bounds", // "pbnd"
                                                                     0x62706e6c: "BurningPanel", // "bpnl"
                                                                     0x7366737a: "calculatesFolderSizes", // "sfsz"
                                                                     0x63617061: "capacity", // "capa"
                                                                     0x63617365: "case_", // "case"
                                                                     0x70636c73: "class_", // "pcls"
                                                                     0x70636c69: "clipboard", // "pcli"
                                                                     0x636c7066: "clipping", // "clpf"
                                                                     0x6c776e64: "clippingWindow", // "lwnd"
                                                                     0x68636c62: "closeable", // "hclb"
                                                                     0x77736864: "collapsed", // "wshd"
                                                                     0x636c7274: "colorTable", // "clrt"
                                                                     0x6c76636c: "column", // "lvcl"
                                                                     0x636c7677: "columnView", // "clvw"
                                                                     0x63766f70: "columnViewOptions", // "cvop"
                                                                     0x636f6d74: "comment", // "comt"
                                                                     0x656c7343: "commentColumn", // "elsC"
                                                                     0x63706e6c: "CommentsPanel", // "cpnl"
                                                                     0x70657863: "completelyExpanded", // "pexc"
                                                                     0x70636d70: "computerContainer", // "pcmp"
                                                                     0x63636d70: "computerObject", // "ccmp"
                                                                     0x656e756d: "constant", // "enum"
                                                                     0x63746e72: "container", // "ctnr"
                                                                     0x63776e64: "containerWindow", // "cwnd"
                                                                     0x63696e6c: "ContentIndexPanel", // "cinl"
                                                                     0x61736364: "creationDate", // "ascd"
                                                                     0x656c7363: "creationDateColumn", // "elsc"
                                                                     0x66637274: "creatorType", // "fcrt"
                                                                     0x70616e6c: "currentPanel", // "panl"
                                                                     0x70766577: "currentView", // "pvew"
                                                                     0x74646173: "dashStyle", // "tdas"
                                                                     0x74647461: "data", // "tdta"
                                                                     0x6c647420: "date", // "ldt\0x20"
                                                                     0x64656320: "December", // "dec\0x20"
                                                                     0x6465636d: "decimalStruct", // "decm"
                                                                     0x64656c61: "delayBeforeSpringing", // "dela"
                                                                     0x64736372: "description_", // "dscr"
                                                                     0x64616669: "deskAccessoryFile", // "dafi"
                                                                     0x70636461: "deskAccessoryProcess", // "pcda"
                                                                     0x6465736b: "desktop", // "desk"
                                                                     0x6364736b: "desktopObject", // "cdsk"
                                                                     0x64706963: "desktopPicture", // "dpic"
                                                                     0x64706f73: "desktopPosition", // "dpos"
                                                                     0x70647376: "desktopShowsConnectedServers", // "pdsv"
                                                                     0x70656864: "desktopShowsExternalHardDisks", // "pehd"
                                                                     0x70646864: "desktopShowsHardDisks", // "pdhd"
                                                                     0x7064726d: "desktopShowsRemovableMedia", // "pdrm"
                                                                     0x646b7477: "desktopWindow", // "dktw"
                                                                     0x64696163: "diacriticals", // "diac"
                                                                     0x64737072: "disclosesPreviewPane", // "dspr"
                                                                     0x63646973: "disk", // "cdis"
                                                                     0x646e616d: "displayedName", // "dnam"
                                                                     0x646f6366: "documentFile", // "docf"
                                                                     0x636f6d70: "doubleInteger", // "comp"
                                                                     0x6973656a: "ejectable", // "isej"
                                                                     0x656e6373: "encodedString", // "encs"
                                                                     0x65637473: "entireContents", // "ects"
                                                                     0x45505320: "EPSPicture", // "EPS\0x20"
                                                                     0x67737470: "everyonesPrivileges", // "gstp"
                                                                     0x64667866: "ExFATFormat", // "dfxf"
                                                                     0x70657861: "expandable", // "pexa"
                                                                     0x70657870: "expanded", // "pexp"
                                                                     0x65787061: "expansion", // "expa"
                                                                     0x65787465: "extendedReal", // "exte"
                                                                     0x68696478: "extensionHidden", // "hidx"
                                                                     0x66656220: "February", // "feb\0x20"
                                                                     0x66696c65: "file", // "file"
                                                                     0x66737266: "fileRef", // "fsrf"
                                                                     0x66737320: "fileSpecification", // "fss\0x20"
                                                                     0x61737479: "fileType", // "asty"
                                                                     0x6675726c: "fileURL", // "furl"
                                                                     0x70667270: "FinderPreferences", // "pfrp"
                                                                     0x62726f77: "FinderWindow", // "brow"
                                                                     0x66697864: "fixed", // "fixd"
                                                                     0x66706e74: "fixedPoint", // "fpnt"
                                                                     0x66726374: "fixedRectangle", // "frct"
                                                                     0x6973666c: "floating", // "isfl"
                                                                     0x666c7677: "flowView", // "flvw"
                                                                     0x63666f6c: "folder", // "cfol"
                                                                     0x706f6e74: "foldersOpenInNewTabs", // "pont"
                                                                     0x706f6e77: "foldersOpenInNewWindows", // "ponw"
                                                                     0x73707267: "foldersSpringOpen", // "sprg"
                                                                     0x64666d74: "format", // "dfmt"
                                                                     0x66727370: "freeSpace", // "frsp"
                                                                     0x66726920: "Friday", // "fri\0x20"
                                                                     0x70697366: "frontmost", // "pisf"
                                                                     0x64666674: "FTPFormat", // "dfft"
                                                                     0x67706e6c: "GeneralInformationPanel", // "gpnl"
                                                                     0x70676e70: "GeneralPreferencesPanel", // "pgnp"
                                                                     0x47494666: "GIFPicture", // "GIFf"
                                                                     0x63677478: "graphicText", // "cgtx"
                                                                     0x73677270: "group", // "sgrp"
                                                                     0x67707072: "groupPrivileges", // "gppr"
                                                                     0x68736372: "hasScriptingTerminology", // "hscr"
                                                                     0x64666873: "HighSierraFormat", // "dfhs"
                                                                     0x686f6d65: "home", // "home"
                                                                     0x68797068: "hyphens", // "hyph"
                                                                     0x69636c34: "icl4", // "icl4"
                                                                     0x69636c38: "icl8", // "icl8"
                                                                     0x49434e23: "ICN_U0023_", // "ICN#"
                                                                     0x69696d67: "icon", // "iimg"
                                                                     0x6966616d: "iconFamily", // "ifam"
                                                                     0x6c766973: "iconSize", // "lvis"
                                                                     0x69636e76: "iconView", // "icnv"
                                                                     0x69636f70: "iconViewOptions", // "icop"
                                                                     0x69637334: "ics4", // "ics4"
                                                                     0x69637338: "ics8", // "ics8"
                                                                     0x69637323: "ics_U0023_", // "ics#"
                                                                     0x49442020: "id", // "ID\0x20\0x20"
                                                                     0x69677072: "ignorePrivileges", // "igpr"
                                                                     0x696c3332: "il32", // "il32"
                                                                     0x70696478: "index", // "pidx"
                                                                     0x69776e64: "informationWindow", // "iwnd"
                                                                     0x70696e73: "insertionLocation", // "pins"
                                                                     0x6c6f6e67: "integer", // "long"
                                                                     0x69747874: "internationalText", // "itxt"
                                                                     0x696e746c: "internationalWritingCode", // "intl"
                                                                     0x696e6c66: "internetLocationFile", // "inlf"
                                                                     0x69733332: "is32", // "is32"
                                                                     0x64663936: "ISO9660Format", // "df96"
                                                                     0x636f626a: "item", // "cobj"
                                                                     0x6a616e20: "January", // "jan\0x20"
                                                                     0x4a726e6c: "journalingEnabled", // "Jrnl"
                                                                     0x4a504547: "JPEGPicture", // "JPEG"
                                                                     0x6a756c20: "July", // "jul\0x20"
                                                                     0x6a756e20: "June", // "jun\0x20"
                                                                     0x6b706964: "kernelProcessID", // "kpid"
                                                                     0x6b696e64: "kind", // "kind"
                                                                     0x656c736b: "kindColumn", // "elsk"
                                                                     0x6c386d6b: "l8mk", // "l8mk"
                                                                     0x636c626c: "label", // "clbl"
                                                                     0x656c736c: "labelColumn", // "elsl"
                                                                     0x6c616269: "labelIndex", // "labi"
                                                                     0x6c706f73: "labelPosition", // "lpos"
                                                                     0x706c6270: "LabelPreferencesPanel", // "plbp"
                                                                     0x706b6c67: "LanguagesPanel", // "pklg"
                                                                     0x6c676963: "large", // "lgic"
                                                                     0x6c64626c: "largeReal", // "ldbl"
                                                                     0x6c697374: "list", // "list"
                                                                     0x6c737677: "listView", // "lsvw"
                                                                     0x6c766f70: "listViewOptions", // "lvop"
                                                                     0x69737276: "localVolume", // "isrv"
                                                                     0x696c6f63: "location", // "iloc"
                                                                     0x696e736c: "locationReference", // "insl"
                                                                     0x61736c6b: "locked", // "aslk"
                                                                     0x6c667864: "longFixed", // "lfxd"
                                                                     0x6c667074: "longFixedPoint", // "lfpt"
                                                                     0x6c667263: "longFixedRectangle", // "lfrc"
                                                                     0x6c706e74: "longPoint", // "lpnt"
                                                                     0x6c726374: "longRectangle", // "lrct"
                                                                     0x6d616368: "machine", // "mach"
                                                                     0x6d4c6f63: "machineLocation", // "mLoc"
                                                                     0x706f7274: "machPort", // "port"
                                                                     0x6466682b: "MacOSExtendedFormat", // "dfh+"
                                                                     0x64666866: "MacOSFormat", // "dfhf"
                                                                     0x6d617220: "March", // "mar\0x20"
                                                                     0x636c776d: "maximumWidth", // "clwm"
                                                                     0x6d617920: "May", // "may\0x20"
                                                                     0x6d706e6c: "MemoryPanel", // "mpnl"
                                                                     0x6d696963: "mini", // "miic"
                                                                     0x6d707274: "minimumSize", // "mprt"
                                                                     0x636c776e: "minimumWidth", // "clwn"
                                                                     0x706d6f64: "modal", // "pmod"
                                                                     0x61736d6f: "modificationDate", // "asmo"
                                                                     0x656c736d: "modificationDateColumn", // "elsm"
                                                                     0x6d6f6e20: "Monday", // "mon\0x20"
                                                                     0x6d696e6c: "MoreInfoPanel", // "minl"
                                                                     0x64666d73: "MSDOSFormat", // "dfms"
                                                                     0x706e616d: "name", // "pnam"
                                                                     0x6e706e6c: "NameAndExtensionPanel", // "npnl"
                                                                     0x656c736e: "nameColumn", // "elsn"
                                                                     0x6e6d7874: "nameExtension", // "nmxt"
                                                                     0x706f6376: "newWindowsOpenInColumnView", // "pocv"
                                                                     0x706e7774: "newWindowTarget", // "pnwt"
                                                                     0x64666e66: "NFSFormat", // "dfnf"
                                                                     0x6e6f2020: "no", // "no\0x20\0x20"
                                                                     0x6e6f6e65: "none", // "none"
                                                                     0x736e726d: "normal", // "snrm"
                                                                     0x6e617272: "notArranged", // "narr"
                                                                     0x6e6f7620: "November", // "nov\0x20"
                                                                     0x64666e74: "NTFSFormat", // "dfnt"
                                                                     0x6e756c6c: "null", // "null"
                                                                     0x6e756d65: "numericStrings", // "nume"
                                                                     0x6f637420: "October", // "oct\0x20"
                                                                     0x436c7363: "opensInClassic", // "Clsc"
                                                                     0x6f726967: "originalItem", // "orig"
                                                                     0x736f776e: "owner", // "sown"
                                                                     0x6f776e72: "ownerPrivileges", // "ownr"
                                                                     0x7061636b: "package", // "pack"
                                                                     0x64667075: "PacketWrittenUDFFormat", // "dfpu"
                                                                     0x70757364: "partitionSpaceUsed", // "pusd"
                                                                     0x50494354: "PICTPicture", // "PICT"
                                                                     0x74706d6d: "pixelMapRecord", // "tpmm"
                                                                     0x706b7067: "PluginsPanel", // "pkpg"
                                                                     0x51447074: "point", // "QDpt"
                                                                     0x706f736e: "position", // "posn"
                                                                     0x63707266: "preferences", // "cprf"
                                                                     0x70776e64: "preferencesWindow", // "pwnd"
                                                                     0x76706e6c: "PreviewPanel", // "vpnl"
                                                                     0x70726373: "process", // "prcs"
                                                                     0x70736e20: "processSerialNumber", // "psn\0x20"
                                                                     0x64667072: "ProDOSFormat", // "dfpr"
                                                                     0x76657232: "productVersion", // "ver2"
                                                                     0x70414c4c: "properties", // "pALL"
                                                                     0x70726f70: "property_", // "prop"
                                                                     0x70756e63: "punctuation", // "punc"
                                                                     0x64667174: "QuickTakeFormat", // "dfqt"
                                                                     0x72656164: "readOnly", // "read"
                                                                     0x72647772: "readWrite", // "rdwr"
                                                                     0x646f7562: "real", // "doub"
                                                                     0x7265636f: "record", // "reco"
                                                                     0x6f626a20: "reference", // "obj\0x20"
                                                                     0x7072737a: "resizable", // "prsz"
                                                                     0x73727673: "reversed", // "srvs"
                                                                     0x74723136: "RGB16Color", // "tr16"
                                                                     0x74723936: "RGB96Color", // "tr96"
                                                                     0x63524742: "RGBColor", // "cRGB"
                                                                     0x6c726774: "right", // "lrgt"
                                                                     0x74726f74: "rotation", // "trot"
                                                                     0x73386d6b: "s8mk", // "s8mk"
                                                                     0x73617420: "Saturday", // "sat\0x20"
                                                                     0x73637074: "script", // "scpt"
                                                                     0x73656c65: "selection", // "sele"
                                                                     0x73657020: "September", // "sep\0x20"
                                                                     0x73706e6c: "SharingPanel", // "spnl"
                                                                     0x73686f72: "shortInteger", // "shor"
                                                                     0x73686963: "showsIcon", // "shic"
                                                                     0x70727677: "showsIconPreview", // "prvw"
                                                                     0x6d6e666f: "showsItemInfo", // "mnfo"
                                                                     0x73687072: "showsPreviewColumn", // "shpr"
                                                                     0x70736964: "SidebarPreferencesPanel", // "psid"
                                                                     0x73627769: "sidebarWidth", // "sbwi"
                                                                     0x73686e6c: "SimpleHeaderPanel", // "shnl"
                                                                     0x7074737a: "size", // "ptsz"
                                                                     0x70687973: "size", // "phys"
                                                                     0x656c7373: "sizeColumn", // "elss"
                                                                     0x736d6963: "small", // "smic"
                                                                     0x73696e67: "smallReal", // "sing"
                                                                     0x6466736d: "SMBFormat", // "dfsm"
                                                                     0x67726461: "snapToGrid", // "grda"
                                                                     0x73727463: "sortColumn", // "srtc"
                                                                     0x736f7264: "sortDirection", // "sord"
                                                                     0x69737464: "startup", // "istd"
                                                                     0x7364736b: "startupDisk", // "sdsk"
                                                                     0x70737064: "stationery", // "pspd"
                                                                     0x73747669: "statusbarVisible", // "stvi"
                                                                     0x54455854: "string", // "TEXT"
                                                                     0x7374796c: "styledClipboardText", // "styl"
                                                                     0x53545854: "styledText", // "STXT"
                                                                     0x73707274: "suggestedSize", // "sprt"
                                                                     0x73756e20: "Sunday", // "sun\0x20"
                                                                     0x66767467: "target", // "fvtg"
                                                                     0x6673697a: "textSize", // "fsiz"
                                                                     0x74737479: "textStyleInfo", // "tsty"
                                                                     0x74687520: "Thursday", // "thu\0x20"
                                                                     0x54494646: "TIFFPicture", // "TIFF"
                                                                     0x70746974: "titled", // "ptit"
                                                                     0x74627669: "toolbarVisible", // "tbvi"
                                                                     0x61707074: "totalPartitionSize", // "appt"
                                                                     0x74727368: "trash", // "trsh"
                                                                     0x63747273: "trashObject", // "ctrs"
                                                                     0x74756520: "Tuesday", // "tue\0x20"
                                                                     0x74797065: "typeClass", // "type"
                                                                     0x64667564: "UDFFormat", // "dfud"
                                                                     0x64667566: "UFSFormat", // "dfuf"
                                                                     0x75747874: "UnicodeText", // "utxt"
                                                                     0x64663f3f: "unknownFormat", // "df??"
                                                                     0x75636f6d: "unsignedDoubleInteger", // "ucom"
                                                                     0x6d61676e: "unsignedInteger", // "magn"
                                                                     0x75736872: "unsignedShortInteger", // "ushr"
                                                                     0x7055524c: "URL", // "pURL"
                                                                     0x75726474: "usesRelativeDates", // "urdt"
                                                                     0x75743136: "UTF16Text", // "ut16"
                                                                     0x75746638: "UTF8Text", // "utf8"
                                                                     0x76657273: "version", // "vers"
                                                                     0x656c7376: "versionColumn", // "elsv"
                                                                     0x70766973: "visible", // "pvis"
                                                                     0x7761726e: "warnsBeforeEmptying", // "warn"
                                                                     0x64667764: "WebDAVFormat", // "dfwd"
                                                                     0x77656420: "Wednesday", // "wed\0x20"
                                                                     0x77686974: "whitespace", // "whit"
                                                                     0x636c7764: "width", // "clwd"
                                                                     0x6377696e: "window", // "cwin"
                                                                     0x77726974: "writeOnly", // "writ"
                                                                     0x70736374: "writingCode", // "psct"
                                                                     0x64666163: "XsanFormat", // "dfac"
                                                                     0x79657320: "yes", // "yes\0x20"
                                                                     0x69737a6d: "zoomable", // "iszm"
                                                                     0x707a756d: "zoomed", // "pzum"
                                                     ],
                                                     propertyNames: [
                                                                     0x69736162: "acceptsHighLevelEvents", // "isab"
                                                                     0x72657674: "acceptsRemoteEvents", // "revt"
                                                                     0x70736e78: "allNameExtensionsShowing", // "psnx"
                                                                     0x61707066: "applicationFile", // "appf"
                                                                     0x69617272: "arrangement", // "iarr"
                                                                     0x636f6c72: "backgroundColor", // "colr"
                                                                     0x69626b67: "backgroundPicture", // "ibkg"
                                                                     0x70626e64: "bounds", // "pbnd"
                                                                     0x7366737a: "calculatesFolderSizes", // "sfsz"
                                                                     0x63617061: "capacity", // "capa"
                                                                     0x70636c73: "class_", // "pcls"
                                                                     0x70636c69: "clipboard", // "pcli"
                                                                     0x6c776e64: "clippingWindow", // "lwnd"
                                                                     0x68636c62: "closeable", // "hclb"
                                                                     0x77736864: "collapsed", // "wshd"
                                                                     0x63766f70: "columnViewOptions", // "cvop"
                                                                     0x636f6d74: "comment", // "comt"
                                                                     0x70657863: "completelyExpanded", // "pexc"
                                                                     0x70636d70: "computerContainer", // "pcmp"
                                                                     0x63746e72: "container", // "ctnr"
                                                                     0x63776e64: "containerWindow", // "cwnd"
                                                                     0x61736364: "creationDate", // "ascd"
                                                                     0x66637274: "creatorType", // "fcrt"
                                                                     0x70616e6c: "currentPanel", // "panl"
                                                                     0x70766577: "currentView", // "pvew"
                                                                     0x64656c61: "delayBeforeSpringing", // "dela"
                                                                     0x64736372: "description_", // "dscr"
                                                                     0x64616669: "deskAccessoryFile", // "dafi"
                                                                     0x6465736b: "desktop", // "desk"
                                                                     0x64706963: "desktopPicture", // "dpic"
                                                                     0x64706f73: "desktopPosition", // "dpos"
                                                                     0x70647376: "desktopShowsConnectedServers", // "pdsv"
                                                                     0x70656864: "desktopShowsExternalHardDisks", // "pehd"
                                                                     0x70646864: "desktopShowsHardDisks", // "pdhd"
                                                                     0x7064726d: "desktopShowsRemovableMedia", // "pdrm"
                                                                     0x64737072: "disclosesPreviewPane", // "dspr"
                                                                     0x63646973: "disk", // "cdis"
                                                                     0x646e616d: "displayedName", // "dnam"
                                                                     0x6973656a: "ejectable", // "isej"
                                                                     0x65637473: "entireContents", // "ects"
                                                                     0x67737470: "everyonesPrivileges", // "gstp"
                                                                     0x70657861: "expandable", // "pexa"
                                                                     0x70657870: "expanded", // "pexp"
                                                                     0x68696478: "extensionHidden", // "hidx"
                                                                     0x66696c65: "file", // "file"
                                                                     0x61737479: "fileType", // "asty"
                                                                     0x70667270: "FinderPreferences", // "pfrp"
                                                                     0x6973666c: "floating", // "isfl"
                                                                     0x706f6e74: "foldersOpenInNewTabs", // "pont"
                                                                     0x706f6e77: "foldersOpenInNewWindows", // "ponw"
                                                                     0x73707267: "foldersSpringOpen", // "sprg"
                                                                     0x64666d74: "format", // "dfmt"
                                                                     0x66727370: "freeSpace", // "frsp"
                                                                     0x70697366: "frontmost", // "pisf"
                                                                     0x73677270: "group", // "sgrp"
                                                                     0x67707072: "groupPrivileges", // "gppr"
                                                                     0x68736372: "hasScriptingTerminology", // "hscr"
                                                                     0x686f6d65: "home", // "home"
                                                                     0x69696d67: "icon", // "iimg"
                                                                     0x6c766973: "iconSize", // "lvis"
                                                                     0x69636f70: "iconViewOptions", // "icop"
                                                                     0x49442020: "id", // "ID\0x20\0x20"
                                                                     0x69677072: "ignorePrivileges", // "igpr"
                                                                     0x70696478: "index", // "pidx"
                                                                     0x69776e64: "informationWindow", // "iwnd"
                                                                     0x70696e73: "insertionLocation", // "pins"
                                                                     0x636f626a: "item", // "cobj"
                                                                     0x4a726e6c: "journalingEnabled", // "Jrnl"
                                                                     0x6b696e64: "kind", // "kind"
                                                                     0x6c616269: "labelIndex", // "labi"
                                                                     0x6c706f73: "labelPosition", // "lpos"
                                                                     0x696c3332: "large32BitIcon", // "il32"
                                                                     0x69636c34: "large4BitIcon", // "icl4"
                                                                     0x69636c38: "large8BitIcon", // "icl8"
                                                                     0x6c386d6b: "large8BitMask", // "l8mk"
                                                                     0x49434e23: "largeMonochromeIconAndMask", // "ICN#"
                                                                     0x6c766f70: "listViewOptions", // "lvop"
                                                                     0x69737276: "localVolume", // "isrv"
                                                                     0x696c6f63: "location", // "iloc"
                                                                     0x61736c6b: "locked", // "aslk"
                                                                     0x636c776d: "maximumWidth", // "clwm"
                                                                     0x6d707274: "minimumSize", // "mprt"
                                                                     0x636c776e: "minimumWidth", // "clwn"
                                                                     0x706d6f64: "modal", // "pmod"
                                                                     0x61736d6f: "modificationDate", // "asmo"
                                                                     0x706e616d: "name", // "pnam"
                                                                     0x6e6d7874: "nameExtension", // "nmxt"
                                                                     0x706f6376: "newWindowsOpenInColumnView", // "pocv"
                                                                     0x706e7774: "newWindowTarget", // "pnwt"
                                                                     0x436c7363: "opensInClassic", // "Clsc"
                                                                     0x6f726967: "originalItem", // "orig"
                                                                     0x736f776e: "owner", // "sown"
                                                                     0x6f776e72: "ownerPrivileges", // "ownr"
                                                                     0x70757364: "partitionSpaceUsed", // "pusd"
                                                                     0x70687973: "physicalSize", // "phys"
                                                                     0x706f736e: "position", // "posn"
                                                                     0x76657232: "productVersion", // "ver2"
                                                                     0x70414c4c: "properties", // "pALL"
                                                                     0x7072737a: "resizable", // "prsz"
                                                                     0x73656c65: "selection", // "sele"
                                                                     0x73686963: "showsIcon", // "shic"
                                                                     0x70727677: "showsIconPreview", // "prvw"
                                                                     0x6d6e666f: "showsItemInfo", // "mnfo"
                                                                     0x73687072: "showsPreviewColumn", // "shpr"
                                                                     0x73627769: "sidebarWidth", // "sbwi"
                                                                     0x7074737a: "size", // "ptsz"
                                                                     0x69733332: "small32BitIcon", // "is32"
                                                                     0x69637334: "small4BitIcon", // "ics4"
                                                                     0x69637338: "small8BitIcon", // "ics8"
                                                                     0x69637323: "smallMonochromeIconAndMask", // "ics#"
                                                                     0x73727463: "sortColumn", // "srtc"
                                                                     0x736f7264: "sortDirection", // "sord"
                                                                     0x69737464: "startup", // "istd"
                                                                     0x7364736b: "startupDisk", // "sdsk"
                                                                     0x70737064: "stationery", // "pspd"
                                                                     0x73747669: "statusbarVisible", // "stvi"
                                                                     0x73707274: "suggestedSize", // "sprt"
                                                                     0x66767467: "target", // "fvtg"
                                                                     0x6673697a: "textSize", // "fsiz"
                                                                     0x70746974: "titled", // "ptit"
                                                                     0x74627669: "toolbarVisible", // "tbvi"
                                                                     0x61707074: "totalPartitionSize", // "appt"
                                                                     0x74727368: "trash", // "trsh"
                                                                     0x7055524c: "URL", // "pURL"
                                                                     0x75726474: "usesRelativeDates", // "urdt"
                                                                     0x76657273: "version", // "vers"
                                                                     0x70766973: "visible", // "pvis"
                                                                     0x7761726e: "warnsBeforeEmptying", // "warn"
                                                                     0x636c7764: "width", // "clwd"
                                                                     0x6377696e: "window", // "cwin"
                                                                     0x69737a6d: "zoomable", // "iszm"
                                                                     0x707a756d: "zoomed", // "pzum"
                                                     ],
                                                     elementsNames: [
                                                                     0x616c6961: ("alias file", "aliasFiles"), // "alia"
                                                                     0x616c7374: ("alias list", "aliasLists"), // "alst"
                                                                     0x61707066: ("application file", "applicationFiles"), // "appf"
                                                                     0x70636170: ("application process", "applicationProcesses"), // "pcap"
                                                                     0x63617070: ("application", "applications"), // "capp"
                                                                     0x636c7066: ("clipping", "clippings"), // "clpf"
                                                                     0x6c776e64: ("clipping window", "clippingWindows"), // "lwnd"
                                                                     0x6c76636c: ("column", "columns"), // "lvcl"
                                                                     0x63766f70: ("column view options", "columnViewOptions"), // "cvop"
                                                                     0x63636d70: ("computer-object", "computerObjects"), // "ccmp"
                                                                     0x63746e72: ("container", "containers"), // "ctnr"
                                                                     0x70636461: ("desk accessory process", "deskAccessoryProcesses"), // "pcda"
                                                                     0x6364736b: ("desktop-object", "desktopObjects"), // "cdsk"
                                                                     0x646b7477: ("desktop window", "desktopWindows"), // "dktw"
                                                                     0x63646973: ("disk", "disks"), // "cdis"
                                                                     0x646f6366: ("document file", "documentFiles"), // "docf"
                                                                     0x66696c65: ("file", "files"), // "file"
                                                                     0x62726f77: ("Finder window", "FinderWindows"), // "brow"
                                                                     0x63666f6c: ("folder", "folders"), // "cfol"
                                                                     0x6966616d: ("icon family", "iconFamilys"), // "ifam"
                                                                     0x69636f70: ("icon view options", "iconViewOptions"), // "icop"
                                                                     0x69776e64: ("information window", "informationWindows"), // "iwnd"
                                                                     0x696e6c66: ("internet location file", "internetLocationFiles"), // "inlf"
                                                                     0x636f626a: ("item", "items"), // "cobj"
                                                                     0x636c626c: ("label", "labels"), // "clbl"
                                                                     0x6c766f70: ("list view options", "listViewOptions"), // "lvop"
                                                                     0x7061636b: ("package", "packages"), // "pack"
                                                                     0x63707266: ("preferences", "preferences"), // "cprf"
                                                                     0x70776e64: ("preferences window", "preferencesWindows"), // "pwnd"
                                                                     0x70726373: ("process", "processes"), // "prcs"
                                                                     0x63747273: ("trash-object", "trashObjects"), // "ctrs"
                                                                     0x6377696e: ("window", "windows"), // "cwin"
                                                     ])

private let _glueClasses = SwiftAutomation.GlueClasses(insertionSpecifierType: FINInsertion.self,
                                       objectSpecifierType: FINItem.self,
                                       multiObjectSpecifierType: FINItems.self,
                                       rootSpecifierType: FINRoot.self,
                                       applicationType: Finder.self,
                                       symbolType: FINSymbol.self,
                                       formatter: _specifierFormatter)

private let _untargetedAppData = SwiftAutomation.AppData(glueClasses: _glueClasses)


/******************************************************************************/
// Symbol subclass defines static type/enum/property constants based on Finder.app terminology

public class FINSymbol: SwiftAutomation.Symbol {

    override public var typeAliasName: String {return "FIN"}

    public override class func symbol(code: OSType, type: OSType = typeType, descriptor: NSAppleEventDescriptor? = nil) -> FINSymbol {
        switch (code) {
        case 0x69736162: return self.acceptsHighLevelEvents // "isab"
        case 0x72657674: return self.acceptsRemoteEvents // "revt"
        case 0x70616476: return self.AdvancedPreferencesPanel // "padv"
        case 0x616c6973: return self.alias // "alis"
        case 0x616c6961: return self.aliasFile // "alia"
        case 0x616c7374: return self.aliasList // "alst"
        case 0x70736e78: return self.allNameExtensionsShowing // "psnx"
        case 0x2a2a2a2a: return self.anything // "****"
        case 0x64666170: return self.APFSFormat // "dfap"
        case 0x64667068: return self.ApplePhotoFormat // "dfph"
        case 0x64666173: return self.AppleShareFormat // "dfas"
        case 0x63617070: return self.application // "capp"
        case 0x62756e64: return self.applicationBundleID // "bund"
        case 0x61707066: return self.applicationFile // "appf"
        case 0x61706e6c: return self.ApplicationPanel // "apnl"
        case 0x70636170: return self.applicationProcess // "pcap"
        case 0x7369676e: return self.applicationSignature // "sign"
        case 0x6170726c: return self.applicationURL // "aprl"
        case 0x61707220: return self.April // "apr\0x20"
        case 0x63647461: return self.arrangedByCreationDate // "cdta"
        case 0x6b696e61: return self.arrangedByKind // "kina"
        case 0x6c616261: return self.arrangedByLabel // "laba"
        case 0x6d647461: return self.arrangedByModificationDate // "mdta"
        case 0x6e616d61: return self.arrangedByName // "nama"
        case 0x73697a61: return self.arrangedBySize // "siza"
        case 0x69617272: return self.arrangement // "iarr"
        case 0x61736b20: return self.ask // "ask\0x20"
        case 0x64666175: return self.audioFormat // "dfau"
        case 0x61756720: return self.August // "aug\0x20"
        case 0x636f6c72: return self.backgroundColor // "colr"
        case 0x69626b67: return self.backgroundPicture // "ibkg"
        case 0x62657374: return self.best // "best"
        case 0x626d726b: return self.bookmarkData // "bmrk"
        case 0x626f6f6c: return self.boolean // "bool"
        case 0x6c626f74: return self.bottom // "lbot"
        case 0x71647274: return self.boundingRectangle // "qdrt"
        case 0x70626e64: return self.bounds // "pbnd"
        case 0x62706e6c: return self.BurningPanel // "bpnl"
        case 0x7366737a: return self.calculatesFolderSizes // "sfsz"
        case 0x63617061: return self.capacity // "capa"
        case 0x63617365: return self.case_ // "case"
        case 0x70636c73: return self.class_ // "pcls"
        case 0x70636c69: return self.clipboard // "pcli"
        case 0x636c7066: return self.clipping // "clpf"
        case 0x6c776e64: return self.clippingWindow // "lwnd"
        case 0x68636c62: return self.closeable // "hclb"
        case 0x77736864: return self.collapsed // "wshd"
        case 0x636c7274: return self.colorTable // "clrt"
        case 0x6c76636c: return self.column // "lvcl"
        case 0x636c7677: return self.columnView // "clvw"
        case 0x63766f70: return self.columnViewOptions // "cvop"
        case 0x636f6d74: return self.comment // "comt"
        case 0x656c7343: return self.commentColumn // "elsC"
        case 0x63706e6c: return self.CommentsPanel // "cpnl"
        case 0x70657863: return self.completelyExpanded // "pexc"
        case 0x70636d70: return self.computerContainer // "pcmp"
        case 0x63636d70: return self.computerObject // "ccmp"
        case 0x656e756d: return self.constant // "enum"
        case 0x63746e72: return self.container // "ctnr"
        case 0x63776e64: return self.containerWindow // "cwnd"
        case 0x63696e6c: return self.ContentIndexPanel // "cinl"
        case 0x61736364: return self.creationDate // "ascd"
        case 0x656c7363: return self.creationDateColumn // "elsc"
        case 0x66637274: return self.creatorType // "fcrt"
        case 0x70616e6c: return self.currentPanel // "panl"
        case 0x70766577: return self.currentView // "pvew"
        case 0x74646173: return self.dashStyle // "tdas"
        case 0x74647461: return self.data // "tdta"
        case 0x6c647420: return self.date // "ldt\0x20"
        case 0x64656320: return self.December // "dec\0x20"
        case 0x6465636d: return self.decimalStruct // "decm"
        case 0x64656c61: return self.delayBeforeSpringing // "dela"
        case 0x64736372: return self.description_ // "dscr"
        case 0x64616669: return self.deskAccessoryFile // "dafi"
        case 0x70636461: return self.deskAccessoryProcess // "pcda"
        case 0x6465736b: return self.desktop // "desk"
        case 0x6364736b: return self.desktopObject // "cdsk"
        case 0x64706963: return self.desktopPicture // "dpic"
        case 0x64706f73: return self.desktopPosition // "dpos"
        case 0x70647376: return self.desktopShowsConnectedServers // "pdsv"
        case 0x70656864: return self.desktopShowsExternalHardDisks // "pehd"
        case 0x70646864: return self.desktopShowsHardDisks // "pdhd"
        case 0x7064726d: return self.desktopShowsRemovableMedia // "pdrm"
        case 0x646b7477: return self.desktopWindow // "dktw"
        case 0x64696163: return self.diacriticals // "diac"
        case 0x64737072: return self.disclosesPreviewPane // "dspr"
        case 0x63646973: return self.disk // "cdis"
        case 0x646e616d: return self.displayedName // "dnam"
        case 0x646f6366: return self.documentFile // "docf"
        case 0x636f6d70: return self.doubleInteger // "comp"
        case 0x6973656a: return self.ejectable // "isej"
        case 0x656e6373: return self.encodedString // "encs"
        case 0x65637473: return self.entireContents // "ects"
        case 0x45505320: return self.EPSPicture // "EPS\0x20"
        case 0x67737470: return self.everyonesPrivileges // "gstp"
        case 0x64667866: return self.ExFATFormat // "dfxf"
        case 0x70657861: return self.expandable // "pexa"
        case 0x70657870: return self.expanded // "pexp"
        case 0x65787061: return self.expansion // "expa"
        case 0x65787465: return self.extendedReal // "exte"
        case 0x68696478: return self.extensionHidden // "hidx"
        case 0x66656220: return self.February // "feb\0x20"
        case 0x66696c65: return self.file // "file"
        case 0x66737266: return self.fileRef // "fsrf"
        case 0x66737320: return self.fileSpecification // "fss\0x20"
        case 0x61737479: return self.fileType // "asty"
        case 0x6675726c: return self.fileURL // "furl"
        case 0x70667270: return self.FinderPreferences // "pfrp"
        case 0x62726f77: return self.FinderWindow // "brow"
        case 0x66697864: return self.fixed // "fixd"
        case 0x66706e74: return self.fixedPoint // "fpnt"
        case 0x66726374: return self.fixedRectangle // "frct"
        case 0x6973666c: return self.floating // "isfl"
        case 0x666c7677: return self.flowView // "flvw"
        case 0x63666f6c: return self.folder // "cfol"
        case 0x706f6e74: return self.foldersOpenInNewTabs // "pont"
        case 0x706f6e77: return self.foldersOpenInNewWindows // "ponw"
        case 0x73707267: return self.foldersSpringOpen // "sprg"
        case 0x64666d74: return self.format // "dfmt"
        case 0x66727370: return self.freeSpace // "frsp"
        case 0x66726920: return self.Friday // "fri\0x20"
        case 0x70697366: return self.frontmost // "pisf"
        case 0x64666674: return self.FTPFormat // "dfft"
        case 0x67706e6c: return self.GeneralInformationPanel // "gpnl"
        case 0x70676e70: return self.GeneralPreferencesPanel // "pgnp"
        case 0x47494666: return self.GIFPicture // "GIFf"
        case 0x63677478: return self.graphicText // "cgtx"
        case 0x73677270: return self.group // "sgrp"
        case 0x67707072: return self.groupPrivileges // "gppr"
        case 0x68736372: return self.hasScriptingTerminology // "hscr"
        case 0x64666873: return self.HighSierraFormat // "dfhs"
        case 0x686f6d65: return self.home // "home"
        case 0x68797068: return self.hyphens // "hyph"
        case 0x69636c34: return self.icl4 // "icl4"
        case 0x69636c38: return self.icl8 // "icl8"
        case 0x49434e23: return self.ICN_U0023_ // "ICN#"
        case 0x69696d67: return self.icon // "iimg"
        case 0x6966616d: return self.iconFamily // "ifam"
        case 0x6c766973: return self.iconSize // "lvis"
        case 0x69636e76: return self.iconView // "icnv"
        case 0x69636f70: return self.iconViewOptions // "icop"
        case 0x69637334: return self.ics4 // "ics4"
        case 0x69637338: return self.ics8 // "ics8"
        case 0x69637323: return self.ics_U0023_ // "ics#"
        case 0x49442020: return self.id // "ID\0x20\0x20"
        case 0x69677072: return self.ignorePrivileges // "igpr"
        case 0x696c3332: return self.il32 // "il32"
        case 0x70696478: return self.index // "pidx"
        case 0x69776e64: return self.informationWindow // "iwnd"
        case 0x70696e73: return self.insertionLocation // "pins"
        case 0x6c6f6e67: return self.integer // "long"
        case 0x69747874: return self.internationalText // "itxt"
        case 0x696e746c: return self.internationalWritingCode // "intl"
        case 0x696e6c66: return self.internetLocationFile // "inlf"
        case 0x69733332: return self.is32 // "is32"
        case 0x64663936: return self.ISO9660Format // "df96"
        case 0x636f626a: return self.item // "cobj"
        case 0x6a616e20: return self.January // "jan\0x20"
        case 0x4a726e6c: return self.journalingEnabled // "Jrnl"
        case 0x4a504547: return self.JPEGPicture // "JPEG"
        case 0x6a756c20: return self.July // "jul\0x20"
        case 0x6a756e20: return self.June // "jun\0x20"
        case 0x6b706964: return self.kernelProcessID // "kpid"
        case 0x6b696e64: return self.kind // "kind"
        case 0x656c736b: return self.kindColumn // "elsk"
        case 0x6c386d6b: return self.l8mk // "l8mk"
        case 0x636c626c: return self.label // "clbl"
        case 0x656c736c: return self.labelColumn // "elsl"
        case 0x6c616269: return self.labelIndex // "labi"
        case 0x6c706f73: return self.labelPosition // "lpos"
        case 0x706c6270: return self.LabelPreferencesPanel // "plbp"
        case 0x706b6c67: return self.LanguagesPanel // "pklg"
        case 0x6c676963: return self.large // "lgic"
        case 0x6c64626c: return self.largeReal // "ldbl"
        case 0x6c697374: return self.list // "list"
        case 0x6c737677: return self.listView // "lsvw"
        case 0x6c766f70: return self.listViewOptions // "lvop"
        case 0x69737276: return self.localVolume // "isrv"
        case 0x696c6f63: return self.location // "iloc"
        case 0x696e736c: return self.locationReference // "insl"
        case 0x61736c6b: return self.locked // "aslk"
        case 0x6c667864: return self.longFixed // "lfxd"
        case 0x6c667074: return self.longFixedPoint // "lfpt"
        case 0x6c667263: return self.longFixedRectangle // "lfrc"
        case 0x6c706e74: return self.longPoint // "lpnt"
        case 0x6c726374: return self.longRectangle // "lrct"
        case 0x6d616368: return self.machine // "mach"
        case 0x6d4c6f63: return self.machineLocation // "mLoc"
        case 0x706f7274: return self.machPort // "port"
        case 0x6466682b: return self.MacOSExtendedFormat // "dfh+"
        case 0x64666866: return self.MacOSFormat // "dfhf"
        case 0x6d617220: return self.March // "mar\0x20"
        case 0x636c776d: return self.maximumWidth // "clwm"
        case 0x6d617920: return self.May // "may\0x20"
        case 0x6d706e6c: return self.MemoryPanel // "mpnl"
        case 0x6d696963: return self.mini // "miic"
        case 0x6d707274: return self.minimumSize // "mprt"
        case 0x636c776e: return self.minimumWidth // "clwn"
        case 0x706d6f64: return self.modal // "pmod"
        case 0x61736d6f: return self.modificationDate // "asmo"
        case 0x656c736d: return self.modificationDateColumn // "elsm"
        case 0x6d6f6e20: return self.Monday // "mon\0x20"
        case 0x6d696e6c: return self.MoreInfoPanel // "minl"
        case 0x64666d73: return self.MSDOSFormat // "dfms"
        case 0x706e616d: return self.name // "pnam"
        case 0x6e706e6c: return self.NameAndExtensionPanel // "npnl"
        case 0x656c736e: return self.nameColumn // "elsn"
        case 0x6e6d7874: return self.nameExtension // "nmxt"
        case 0x706f6376: return self.newWindowsOpenInColumnView // "pocv"
        case 0x706e7774: return self.newWindowTarget // "pnwt"
        case 0x64666e66: return self.NFSFormat // "dfnf"
        case 0x6e6f2020: return self.no // "no\0x20\0x20"
        case 0x6e6f6e65: return self.none // "none"
        case 0x736e726d: return self.normal // "snrm"
        case 0x6e617272: return self.notArranged // "narr"
        case 0x6e6f7620: return self.November // "nov\0x20"
        case 0x64666e74: return self.NTFSFormat // "dfnt"
        case 0x6e756c6c: return self.null // "null"
        case 0x6e756d65: return self.numericStrings // "nume"
        case 0x6f637420: return self.October // "oct\0x20"
        case 0x436c7363: return self.opensInClassic // "Clsc"
        case 0x6f726967: return self.originalItem // "orig"
        case 0x736f776e: return self.owner // "sown"
        case 0x6f776e72: return self.ownerPrivileges // "ownr"
        case 0x7061636b: return self.package // "pack"
        case 0x64667075: return self.PacketWrittenUDFFormat // "dfpu"
        case 0x70757364: return self.partitionSpaceUsed // "pusd"
        case 0x50494354: return self.PICTPicture // "PICT"
        case 0x74706d6d: return self.pixelMapRecord // "tpmm"
        case 0x706b7067: return self.PluginsPanel // "pkpg"
        case 0x51447074: return self.point // "QDpt"
        case 0x706f736e: return self.position // "posn"
        case 0x63707266: return self.preferences // "cprf"
        case 0x70776e64: return self.preferencesWindow // "pwnd"
        case 0x76706e6c: return self.PreviewPanel // "vpnl"
        case 0x70726373: return self.process // "prcs"
        case 0x70736e20: return self.processSerialNumber // "psn\0x20"
        case 0x64667072: return self.ProDOSFormat // "dfpr"
        case 0x76657232: return self.productVersion // "ver2"
        case 0x70414c4c: return self.properties // "pALL"
        case 0x70726f70: return self.property_ // "prop"
        case 0x70756e63: return self.punctuation // "punc"
        case 0x64667174: return self.QuickTakeFormat // "dfqt"
        case 0x72656164: return self.readOnly // "read"
        case 0x72647772: return self.readWrite // "rdwr"
        case 0x646f7562: return self.real // "doub"
        case 0x7265636f: return self.record // "reco"
        case 0x6f626a20: return self.reference // "obj\0x20"
        case 0x7072737a: return self.resizable // "prsz"
        case 0x73727673: return self.reversed // "srvs"
        case 0x74723136: return self.RGB16Color // "tr16"
        case 0x74723936: return self.RGB96Color // "tr96"
        case 0x63524742: return self.RGBColor // "cRGB"
        case 0x6c726774: return self.right // "lrgt"
        case 0x74726f74: return self.rotation // "trot"
        case 0x73386d6b: return self.s8mk // "s8mk"
        case 0x73617420: return self.Saturday // "sat\0x20"
        case 0x73637074: return self.script // "scpt"
        case 0x73656c65: return self.selection // "sele"
        case 0x73657020: return self.September // "sep\0x20"
        case 0x73706e6c: return self.SharingPanel // "spnl"
        case 0x73686f72: return self.shortInteger // "shor"
        case 0x73686963: return self.showsIcon // "shic"
        case 0x70727677: return self.showsIconPreview // "prvw"
        case 0x6d6e666f: return self.showsItemInfo // "mnfo"
        case 0x73687072: return self.showsPreviewColumn // "shpr"
        case 0x70736964: return self.SidebarPreferencesPanel // "psid"
        case 0x73627769: return self.sidebarWidth // "sbwi"
        case 0x73686e6c: return self.SimpleHeaderPanel // "shnl"
        case 0x7074737a: return self.size // "ptsz"
        case 0x70687973: return self.size // "phys"
        case 0x656c7373: return self.sizeColumn // "elss"
        case 0x736d6963: return self.small // "smic"
        case 0x73696e67: return self.smallReal // "sing"
        case 0x6466736d: return self.SMBFormat // "dfsm"
        case 0x67726461: return self.snapToGrid // "grda"
        case 0x73727463: return self.sortColumn // "srtc"
        case 0x736f7264: return self.sortDirection // "sord"
        case 0x69737464: return self.startup // "istd"
        case 0x7364736b: return self.startupDisk // "sdsk"
        case 0x70737064: return self.stationery // "pspd"
        case 0x73747669: return self.statusbarVisible // "stvi"
        case 0x54455854: return self.string // "TEXT"
        case 0x7374796c: return self.styledClipboardText // "styl"
        case 0x53545854: return self.styledText // "STXT"
        case 0x73707274: return self.suggestedSize // "sprt"
        case 0x73756e20: return self.Sunday // "sun\0x20"
        case 0x66767467: return self.target // "fvtg"
        case 0x6673697a: return self.textSize // "fsiz"
        case 0x74737479: return self.textStyleInfo // "tsty"
        case 0x74687520: return self.Thursday // "thu\0x20"
        case 0x54494646: return self.TIFFPicture // "TIFF"
        case 0x70746974: return self.titled // "ptit"
        case 0x74627669: return self.toolbarVisible // "tbvi"
        case 0x61707074: return self.totalPartitionSize // "appt"
        case 0x74727368: return self.trash // "trsh"
        case 0x63747273: return self.trashObject // "ctrs"
        case 0x74756520: return self.Tuesday // "tue\0x20"
        case 0x74797065: return self.typeClass // "type"
        case 0x64667564: return self.UDFFormat // "dfud"
        case 0x64667566: return self.UFSFormat // "dfuf"
        case 0x75747874: return self.UnicodeText // "utxt"
        case 0x64663f3f: return self.unknownFormat // "df??"
        case 0x75636f6d: return self.unsignedDoubleInteger // "ucom"
        case 0x6d61676e: return self.unsignedInteger // "magn"
        case 0x75736872: return self.unsignedShortInteger // "ushr"
        case 0x7055524c: return self.URL // "pURL"
        case 0x75726474: return self.usesRelativeDates // "urdt"
        case 0x75743136: return self.UTF16Text // "ut16"
        case 0x75746638: return self.UTF8Text // "utf8"
        case 0x76657273: return self.version // "vers"
        case 0x656c7376: return self.versionColumn // "elsv"
        case 0x70766973: return self.visible // "pvis"
        case 0x7761726e: return self.warnsBeforeEmptying // "warn"
        case 0x64667764: return self.WebDAVFormat // "dfwd"
        case 0x77656420: return self.Wednesday // "wed\0x20"
        case 0x77686974: return self.whitespace // "whit"
        case 0x636c7764: return self.width // "clwd"
        case 0x6377696e: return self.window // "cwin"
        case 0x77726974: return self.writeOnly // "writ"
        case 0x70736374: return self.writingCode // "psct"
        case 0x64666163: return self.XsanFormat // "dfac"
        case 0x79657320: return self.yes // "yes\0x20"
        case 0x69737a6d: return self.zoomable // "iszm"
        case 0x707a756d: return self.zoomed // "pzum"
        default: return super.symbol(code: code, type: type, descriptor: descriptor) as! FINSymbol
        }
    }

    // Types/properties
    public static let acceptsHighLevelEvents = FINSymbol(name: "acceptsHighLevelEvents", code: 0x69736162, type: typeType) // "isab"
    public static let acceptsRemoteEvents = FINSymbol(name: "acceptsRemoteEvents", code: 0x72657674, type: typeType) // "revt"
    public static let alias = FINSymbol(name: "alias", code: 0x616c6973, type: typeType) // "alis"
    public static let aliasFile = FINSymbol(name: "aliasFile", code: 0x616c6961, type: typeType) // "alia"
    public static let aliasList = FINSymbol(name: "aliasList", code: 0x616c7374, type: typeType) // "alst"
    public static let allNameExtensionsShowing = FINSymbol(name: "allNameExtensionsShowing", code: 0x70736e78, type: typeType) // "psnx"
    public static let anything = FINSymbol(name: "anything", code: 0x2a2a2a2a, type: typeType) // "****"
    public static let application = FINSymbol(name: "application", code: 0x63617070, type: typeType) // "capp"
    public static let applicationBundleID = FINSymbol(name: "applicationBundleID", code: 0x62756e64, type: typeType) // "bund"
    public static let applicationFile = FINSymbol(name: "applicationFile", code: 0x61707066, type: typeType) // "appf"
    public static let applicationProcess = FINSymbol(name: "applicationProcess", code: 0x70636170, type: typeType) // "pcap"
    public static let applicationSignature = FINSymbol(name: "applicationSignature", code: 0x7369676e, type: typeType) // "sign"
    public static let applicationURL = FINSymbol(name: "applicationURL", code: 0x6170726c, type: typeType) // "aprl"
    public static let April = FINSymbol(name: "April", code: 0x61707220, type: typeType) // "apr\0x20"
    public static let arrangement = FINSymbol(name: "arrangement", code: 0x69617272, type: typeType) // "iarr"
    public static let August = FINSymbol(name: "August", code: 0x61756720, type: typeType) // "aug\0x20"
    public static let backgroundColor = FINSymbol(name: "backgroundColor", code: 0x636f6c72, type: typeType) // "colr"
    public static let backgroundPicture = FINSymbol(name: "backgroundPicture", code: 0x69626b67, type: typeType) // "ibkg"
    public static let best = FINSymbol(name: "best", code: 0x62657374, type: typeType) // "best"
    public static let bookmarkData = FINSymbol(name: "bookmarkData", code: 0x626d726b, type: typeType) // "bmrk"
    public static let boolean = FINSymbol(name: "boolean", code: 0x626f6f6c, type: typeType) // "bool"
    public static let boundingRectangle = FINSymbol(name: "boundingRectangle", code: 0x71647274, type: typeType) // "qdrt"
    public static let bounds = FINSymbol(name: "bounds", code: 0x70626e64, type: typeType) // "pbnd"
    public static let calculatesFolderSizes = FINSymbol(name: "calculatesFolderSizes", code: 0x7366737a, type: typeType) // "sfsz"
    public static let capacity = FINSymbol(name: "capacity", code: 0x63617061, type: typeType) // "capa"
    public static let class_ = FINSymbol(name: "class_", code: 0x70636c73, type: typeType) // "pcls"
    public static let clipboard = FINSymbol(name: "clipboard", code: 0x70636c69, type: typeType) // "pcli"
    public static let clipping = FINSymbol(name: "clipping", code: 0x636c7066, type: typeType) // "clpf"
    public static let clippingWindow = FINSymbol(name: "clippingWindow", code: 0x6c776e64, type: typeType) // "lwnd"
    public static let closeable = FINSymbol(name: "closeable", code: 0x68636c62, type: typeType) // "hclb"
    public static let collapsed = FINSymbol(name: "collapsed", code: 0x77736864, type: typeType) // "wshd"
    public static let color = FINSymbol(name: "color", code: 0x636f6c72, type: typeType) // "colr"
    public static let colorTable = FINSymbol(name: "colorTable", code: 0x636c7274, type: typeType) // "clrt"
    public static let column = FINSymbol(name: "column", code: 0x6c76636c, type: typeType) // "lvcl"
    public static let columnViewOptions = FINSymbol(name: "columnViewOptions", code: 0x63766f70, type: typeType) // "cvop"
    public static let completelyExpanded = FINSymbol(name: "completelyExpanded", code: 0x70657863, type: typeType) // "pexc"
    public static let computerContainer = FINSymbol(name: "computerContainer", code: 0x70636d70, type: typeType) // "pcmp"
    public static let computerObject = FINSymbol(name: "computerObject", code: 0x63636d70, type: typeType) // "ccmp"
    public static let constant = FINSymbol(name: "constant", code: 0x656e756d, type: typeType) // "enum"
    public static let container = FINSymbol(name: "container", code: 0x63746e72, type: typeType) // "ctnr"
    public static let containerWindow = FINSymbol(name: "containerWindow", code: 0x63776e64, type: typeType) // "cwnd"
    public static let creatorType = FINSymbol(name: "creatorType", code: 0x66637274, type: typeType) // "fcrt"
    public static let currentPanel = FINSymbol(name: "currentPanel", code: 0x70616e6c, type: typeType) // "panl"
    public static let currentView = FINSymbol(name: "currentView", code: 0x70766577, type: typeType) // "pvew"
    public static let dashStyle = FINSymbol(name: "dashStyle", code: 0x74646173, type: typeType) // "tdas"
    public static let data = FINSymbol(name: "data", code: 0x74647461, type: typeType) // "tdta"
    public static let date = FINSymbol(name: "date", code: 0x6c647420, type: typeType) // "ldt\0x20"
    public static let December = FINSymbol(name: "December", code: 0x64656320, type: typeType) // "dec\0x20"
    public static let decimalStruct = FINSymbol(name: "decimalStruct", code: 0x6465636d, type: typeType) // "decm"
    public static let delayBeforeSpringing = FINSymbol(name: "delayBeforeSpringing", code: 0x64656c61, type: typeType) // "dela"
    public static let description_ = FINSymbol(name: "description_", code: 0x64736372, type: typeType) // "dscr"
    public static let deskAccessoryFile = FINSymbol(name: "deskAccessoryFile", code: 0x64616669, type: typeType) // "dafi"
    public static let deskAccessoryProcess = FINSymbol(name: "deskAccessoryProcess", code: 0x70636461, type: typeType) // "pcda"
    public static let desktop = FINSymbol(name: "desktop", code: 0x6465736b, type: typeType) // "desk"
    public static let desktopObject = FINSymbol(name: "desktopObject", code: 0x6364736b, type: typeType) // "cdsk"
    public static let desktopPicture = FINSymbol(name: "desktopPicture", code: 0x64706963, type: typeType) // "dpic"
    public static let desktopPosition = FINSymbol(name: "desktopPosition", code: 0x64706f73, type: typeType) // "dpos"
    public static let desktopShowsConnectedServers = FINSymbol(name: "desktopShowsConnectedServers", code: 0x70647376, type: typeType) // "pdsv"
    public static let desktopShowsExternalHardDisks = FINSymbol(name: "desktopShowsExternalHardDisks", code: 0x70656864, type: typeType) // "pehd"
    public static let desktopShowsHardDisks = FINSymbol(name: "desktopShowsHardDisks", code: 0x70646864, type: typeType) // "pdhd"
    public static let desktopShowsRemovableMedia = FINSymbol(name: "desktopShowsRemovableMedia", code: 0x7064726d, type: typeType) // "pdrm"
    public static let desktopWindow = FINSymbol(name: "desktopWindow", code: 0x646b7477, type: typeType) // "dktw"
    public static let disclosesPreviewPane = FINSymbol(name: "disclosesPreviewPane", code: 0x64737072, type: typeType) // "dspr"
    public static let disk = FINSymbol(name: "disk", code: 0x63646973, type: typeType) // "cdis"
    public static let displayedName = FINSymbol(name: "displayedName", code: 0x646e616d, type: typeType) // "dnam"
    public static let documentFile = FINSymbol(name: "documentFile", code: 0x646f6366, type: typeType) // "docf"
    public static let doubleInteger = FINSymbol(name: "doubleInteger", code: 0x636f6d70, type: typeType) // "comp"
    public static let ejectable = FINSymbol(name: "ejectable", code: 0x6973656a, type: typeType) // "isej"
    public static let encodedString = FINSymbol(name: "encodedString", code: 0x656e6373, type: typeType) // "encs"
    public static let entireContents = FINSymbol(name: "entireContents", code: 0x65637473, type: typeType) // "ects"
    public static let EPSPicture = FINSymbol(name: "EPSPicture", code: 0x45505320, type: typeType) // "EPS\0x20"
    public static let everyonesPrivileges = FINSymbol(name: "everyonesPrivileges", code: 0x67737470, type: typeType) // "gstp"
    public static let expandable = FINSymbol(name: "expandable", code: 0x70657861, type: typeType) // "pexa"
    public static let expanded = FINSymbol(name: "expanded", code: 0x70657870, type: typeType) // "pexp"
    public static let extendedReal = FINSymbol(name: "extendedReal", code: 0x65787465, type: typeType) // "exte"
    public static let extensionHidden = FINSymbol(name: "extensionHidden", code: 0x68696478, type: typeType) // "hidx"
    public static let February = FINSymbol(name: "February", code: 0x66656220, type: typeType) // "feb\0x20"
    public static let file = FINSymbol(name: "file", code: 0x66696c65, type: typeType) // "file"
    public static let fileRef = FINSymbol(name: "fileRef", code: 0x66737266, type: typeType) // "fsrf"
    public static let fileSpecification = FINSymbol(name: "fileSpecification", code: 0x66737320, type: typeType) // "fss\0x20"
    public static let fileType = FINSymbol(name: "fileType", code: 0x61737479, type: typeType) // "asty"
    public static let fileURL = FINSymbol(name: "fileURL", code: 0x6675726c, type: typeType) // "furl"
    public static let FinderPreferences = FINSymbol(name: "FinderPreferences", code: 0x70667270, type: typeType) // "pfrp"
    public static let FinderWindow = FINSymbol(name: "FinderWindow", code: 0x62726f77, type: typeType) // "brow"
    public static let fixed = FINSymbol(name: "fixed", code: 0x66697864, type: typeType) // "fixd"
    public static let fixedPoint = FINSymbol(name: "fixedPoint", code: 0x66706e74, type: typeType) // "fpnt"
    public static let fixedRectangle = FINSymbol(name: "fixedRectangle", code: 0x66726374, type: typeType) // "frct"
    public static let floating = FINSymbol(name: "floating", code: 0x6973666c, type: typeType) // "isfl"
    public static let folder = FINSymbol(name: "folder", code: 0x63666f6c, type: typeType) // "cfol"
    public static let foldersOpenInNewTabs = FINSymbol(name: "foldersOpenInNewTabs", code: 0x706f6e74, type: typeType) // "pont"
    public static let foldersOpenInNewWindows = FINSymbol(name: "foldersOpenInNewWindows", code: 0x706f6e77, type: typeType) // "ponw"
    public static let foldersSpringOpen = FINSymbol(name: "foldersSpringOpen", code: 0x73707267, type: typeType) // "sprg"
    public static let format = FINSymbol(name: "format", code: 0x64666d74, type: typeType) // "dfmt"
    public static let freeSpace = FINSymbol(name: "freeSpace", code: 0x66727370, type: typeType) // "frsp"
    public static let Friday = FINSymbol(name: "Friday", code: 0x66726920, type: typeType) // "fri\0x20"
    public static let frontmost = FINSymbol(name: "frontmost", code: 0x70697366, type: typeType) // "pisf"
    public static let GIFPicture = FINSymbol(name: "GIFPicture", code: 0x47494666, type: typeType) // "GIFf"
    public static let graphicText = FINSymbol(name: "graphicText", code: 0x63677478, type: typeType) // "cgtx"
    public static let group = FINSymbol(name: "group", code: 0x73677270, type: typeType) // "sgrp"
    public static let groupPrivileges = FINSymbol(name: "groupPrivileges", code: 0x67707072, type: typeType) // "gppr"
    public static let hasScriptingTerminology = FINSymbol(name: "hasScriptingTerminology", code: 0x68736372, type: typeType) // "hscr"
    public static let home = FINSymbol(name: "home", code: 0x686f6d65, type: typeType) // "home"
    public static let icl4 = FINSymbol(name: "icl4", code: 0x69636c34, type: typeType) // "icl4"
    public static let icl8 = FINSymbol(name: "icl8", code: 0x69636c38, type: typeType) // "icl8"
    public static let ICN_U0023_ = FINSymbol(name: "ICN_U0023_", code: 0x49434e23, type: typeType) // "ICN#"
    public static let icon = FINSymbol(name: "icon", code: 0x69696d67, type: typeType) // "iimg"
    public static let iconFamily = FINSymbol(name: "iconFamily", code: 0x6966616d, type: typeType) // "ifam"
    public static let iconSize = FINSymbol(name: "iconSize", code: 0x6c766973, type: typeType) // "lvis"
    public static let iconViewOptions = FINSymbol(name: "iconViewOptions", code: 0x69636f70, type: typeType) // "icop"
    public static let ics4 = FINSymbol(name: "ics4", code: 0x69637334, type: typeType) // "ics4"
    public static let ics8 = FINSymbol(name: "ics8", code: 0x69637338, type: typeType) // "ics8"
    public static let ics_U0023_ = FINSymbol(name: "ics_U0023_", code: 0x69637323, type: typeType) // "ics#"
    public static let id = FINSymbol(name: "id", code: 0x49442020, type: typeType) // "ID\0x20\0x20"
    public static let ignorePrivileges = FINSymbol(name: "ignorePrivileges", code: 0x69677072, type: typeType) // "igpr"
    public static let il32 = FINSymbol(name: "il32", code: 0x696c3332, type: typeType) // "il32"
    public static let index = FINSymbol(name: "index", code: 0x70696478, type: typeType) // "pidx"
    public static let informationWindow = FINSymbol(name: "informationWindow", code: 0x69776e64, type: typeType) // "iwnd"
    public static let insertionLocation = FINSymbol(name: "insertionLocation", code: 0x70696e73, type: typeType) // "pins"
    public static let integer = FINSymbol(name: "integer", code: 0x6c6f6e67, type: typeType) // "long"
    public static let internationalText = FINSymbol(name: "internationalText", code: 0x69747874, type: typeType) // "itxt"
    public static let internationalWritingCode = FINSymbol(name: "internationalWritingCode", code: 0x696e746c, type: typeType) // "intl"
    public static let internetLocationFile = FINSymbol(name: "internetLocationFile", code: 0x696e6c66, type: typeType) // "inlf"
    public static let is32 = FINSymbol(name: "is32", code: 0x69733332, type: typeType) // "is32"
    public static let item = FINSymbol(name: "item", code: 0x636f626a, type: typeType) // "cobj"
    public static let January = FINSymbol(name: "January", code: 0x6a616e20, type: typeType) // "jan\0x20"
    public static let journalingEnabled = FINSymbol(name: "journalingEnabled", code: 0x4a726e6c, type: typeType) // "Jrnl"
    public static let JPEGPicture = FINSymbol(name: "JPEGPicture", code: 0x4a504547, type: typeType) // "JPEG"
    public static let July = FINSymbol(name: "July", code: 0x6a756c20, type: typeType) // "jul\0x20"
    public static let June = FINSymbol(name: "June", code: 0x6a756e20, type: typeType) // "jun\0x20"
    public static let kernelProcessID = FINSymbol(name: "kernelProcessID", code: 0x6b706964, type: typeType) // "kpid"
    public static let l8mk = FINSymbol(name: "l8mk", code: 0x6c386d6b, type: typeType) // "l8mk"
    public static let label = FINSymbol(name: "label", code: 0x636c626c, type: typeType) // "clbl"
    public static let labelPosition = FINSymbol(name: "labelPosition", code: 0x6c706f73, type: typeType) // "lpos"
    public static let large32BitIcon = FINSymbol(name: "large32BitIcon", code: 0x696c3332, type: typeType) // "il32"
    public static let large4BitIcon = FINSymbol(name: "large4BitIcon", code: 0x69636c34, type: typeType) // "icl4"
    public static let large8BitIcon = FINSymbol(name: "large8BitIcon", code: 0x69636c38, type: typeType) // "icl8"
    public static let large8BitMask = FINSymbol(name: "large8BitMask", code: 0x6c386d6b, type: typeType) // "l8mk"
    public static let largeMonochromeIconAndMask = FINSymbol(name: "largeMonochromeIconAndMask", code: 0x49434e23, type: typeType) // "ICN#"
    public static let largeReal = FINSymbol(name: "largeReal", code: 0x6c64626c, type: typeType) // "ldbl"
    public static let list = FINSymbol(name: "list", code: 0x6c697374, type: typeType) // "list"
    public static let listViewOptions = FINSymbol(name: "listViewOptions", code: 0x6c766f70, type: typeType) // "lvop"
    public static let localVolume = FINSymbol(name: "localVolume", code: 0x69737276, type: typeType) // "isrv"
    public static let location = FINSymbol(name: "location", code: 0x696c6f63, type: typeType) // "iloc"
    public static let locationReference = FINSymbol(name: "locationReference", code: 0x696e736c, type: typeType) // "insl"
    public static let locked = FINSymbol(name: "locked", code: 0x61736c6b, type: typeType) // "aslk"
    public static let longFixed = FINSymbol(name: "longFixed", code: 0x6c667864, type: typeType) // "lfxd"
    public static let longFixedPoint = FINSymbol(name: "longFixedPoint", code: 0x6c667074, type: typeType) // "lfpt"
    public static let longFixedRectangle = FINSymbol(name: "longFixedRectangle", code: 0x6c667263, type: typeType) // "lfrc"
    public static let longPoint = FINSymbol(name: "longPoint", code: 0x6c706e74, type: typeType) // "lpnt"
    public static let longRectangle = FINSymbol(name: "longRectangle", code: 0x6c726374, type: typeType) // "lrct"
    public static let machine = FINSymbol(name: "machine", code: 0x6d616368, type: typeType) // "mach"
    public static let machineLocation = FINSymbol(name: "machineLocation", code: 0x6d4c6f63, type: typeType) // "mLoc"
    public static let machPort = FINSymbol(name: "machPort", code: 0x706f7274, type: typeType) // "port"
    public static let March = FINSymbol(name: "March", code: 0x6d617220, type: typeType) // "mar\0x20"
    public static let maximumWidth = FINSymbol(name: "maximumWidth", code: 0x636c776d, type: typeType) // "clwm"
    public static let May = FINSymbol(name: "May", code: 0x6d617920, type: typeType) // "may\0x20"
    public static let minimumSize = FINSymbol(name: "minimumSize", code: 0x6d707274, type: typeType) // "mprt"
    public static let minimumWidth = FINSymbol(name: "minimumWidth", code: 0x636c776e, type: typeType) // "clwn"
    public static let modal = FINSymbol(name: "modal", code: 0x706d6f64, type: typeType) // "pmod"
    public static let Monday = FINSymbol(name: "Monday", code: 0x6d6f6e20, type: typeType) // "mon\0x20"
    public static let nameExtension = FINSymbol(name: "nameExtension", code: 0x6e6d7874, type: typeType) // "nmxt"
    public static let newWindowsOpenInColumnView = FINSymbol(name: "newWindowsOpenInColumnView", code: 0x706f6376, type: typeType) // "pocv"
    public static let newWindowTarget = FINSymbol(name: "newWindowTarget", code: 0x706e7774, type: typeType) // "pnwt"
    public static let November = FINSymbol(name: "November", code: 0x6e6f7620, type: typeType) // "nov\0x20"
    public static let null = FINSymbol(name: "null", code: 0x6e756c6c, type: typeType) // "null"
    public static let October = FINSymbol(name: "October", code: 0x6f637420, type: typeType) // "oct\0x20"
    public static let opensInClassic = FINSymbol(name: "opensInClassic", code: 0x436c7363, type: typeType) // "Clsc"
    public static let originalItem = FINSymbol(name: "originalItem", code: 0x6f726967, type: typeType) // "orig"
    public static let owner = FINSymbol(name: "owner", code: 0x736f776e, type: typeType) // "sown"
    public static let ownerPrivileges = FINSymbol(name: "ownerPrivileges", code: 0x6f776e72, type: typeType) // "ownr"
    public static let package = FINSymbol(name: "package", code: 0x7061636b, type: typeType) // "pack"
    public static let partitionSpaceUsed = FINSymbol(name: "partitionSpaceUsed", code: 0x70757364, type: typeType) // "pusd"
    public static let physicalSize = FINSymbol(name: "physicalSize", code: 0x70687973, type: typeType) // "phys"
    public static let PICTPicture = FINSymbol(name: "PICTPicture", code: 0x50494354, type: typeType) // "PICT"
    public static let pixelMapRecord = FINSymbol(name: "pixelMapRecord", code: 0x74706d6d, type: typeType) // "tpmm"
    public static let point = FINSymbol(name: "point", code: 0x51447074, type: typeType) // "QDpt"
    public static let position = FINSymbol(name: "position", code: 0x706f736e, type: typeType) // "posn"
    public static let preferences = FINSymbol(name: "preferences", code: 0x63707266, type: typeType) // "cprf"
    public static let preferencesWindow = FINSymbol(name: "preferencesWindow", code: 0x70776e64, type: typeType) // "pwnd"
    public static let preferredSize = FINSymbol(name: "preferredSize", code: 0x61707074, type: typeType) // "appt"
    public static let process = FINSymbol(name: "process", code: 0x70726373, type: typeType) // "prcs"
    public static let processSerialNumber = FINSymbol(name: "processSerialNumber", code: 0x70736e20, type: typeType) // "psn\0x20"
    public static let productVersion = FINSymbol(name: "productVersion", code: 0x76657232, type: typeType) // "ver2"
    public static let properties = FINSymbol(name: "properties", code: 0x70414c4c, type: typeType) // "pALL"
    public static let property_ = FINSymbol(name: "property_", code: 0x70726f70, type: typeType) // "prop"
    public static let real = FINSymbol(name: "real", code: 0x646f7562, type: typeType) // "doub"
    public static let record = FINSymbol(name: "record", code: 0x7265636f, type: typeType) // "reco"
    public static let reference = FINSymbol(name: "reference", code: 0x6f626a20, type: typeType) // "obj\0x20"
    public static let resizable = FINSymbol(name: "resizable", code: 0x7072737a, type: typeType) // "prsz"
    public static let RGB16Color = FINSymbol(name: "RGB16Color", code: 0x74723136, type: typeType) // "tr16"
    public static let RGB96Color = FINSymbol(name: "RGB96Color", code: 0x74723936, type: typeType) // "tr96"
    public static let RGBColor = FINSymbol(name: "RGBColor", code: 0x63524742, type: typeType) // "cRGB"
    public static let rotation = FINSymbol(name: "rotation", code: 0x74726f74, type: typeType) // "trot"
    public static let s8mk = FINSymbol(name: "s8mk", code: 0x73386d6b, type: typeType) // "s8mk"
    public static let Saturday = FINSymbol(name: "Saturday", code: 0x73617420, type: typeType) // "sat\0x20"
    public static let script = FINSymbol(name: "script", code: 0x73637074, type: typeType) // "scpt"
    public static let selection = FINSymbol(name: "selection", code: 0x73656c65, type: typeType) // "sele"
    public static let September = FINSymbol(name: "September", code: 0x73657020, type: typeType) // "sep\0x20"
    public static let shortInteger = FINSymbol(name: "shortInteger", code: 0x73686f72, type: typeType) // "shor"
    public static let showsIcon = FINSymbol(name: "showsIcon", code: 0x73686963, type: typeType) // "shic"
    public static let showsIconPreview = FINSymbol(name: "showsIconPreview", code: 0x70727677, type: typeType) // "prvw"
    public static let showsItemInfo = FINSymbol(name: "showsItemInfo", code: 0x6d6e666f, type: typeType) // "mnfo"
    public static let showsPreviewColumn = FINSymbol(name: "showsPreviewColumn", code: 0x73687072, type: typeType) // "shpr"
    public static let sidebarWidth = FINSymbol(name: "sidebarWidth", code: 0x73627769, type: typeType) // "sbwi"
    public static let small32BitIcon = FINSymbol(name: "small32BitIcon", code: 0x69733332, type: typeType) // "is32"
    public static let small4BitIcon = FINSymbol(name: "small4BitIcon", code: 0x69637334, type: typeType) // "ics4"
    public static let small8BitIcon = FINSymbol(name: "small8BitIcon", code: 0x69637338, type: typeType) // "ics8"
    public static let small8BitMask = FINSymbol(name: "small8BitMask", code: 0x69637338, type: typeType) // "ics8"
    public static let smallMonochromeIconAndMask = FINSymbol(name: "smallMonochromeIconAndMask", code: 0x69637323, type: typeType) // "ics#"
    public static let smallReal = FINSymbol(name: "smallReal", code: 0x73696e67, type: typeType) // "sing"
    public static let sortColumn = FINSymbol(name: "sortColumn", code: 0x73727463, type: typeType) // "srtc"
    public static let sortDirection = FINSymbol(name: "sortDirection", code: 0x736f7264, type: typeType) // "sord"
    public static let startup = FINSymbol(name: "startup", code: 0x69737464, type: typeType) // "istd"
    public static let startupDisk = FINSymbol(name: "startupDisk", code: 0x7364736b, type: typeType) // "sdsk"
    public static let stationery = FINSymbol(name: "stationery", code: 0x70737064, type: typeType) // "pspd"
    public static let statusbarVisible = FINSymbol(name: "statusbarVisible", code: 0x73747669, type: typeType) // "stvi"
    public static let string = FINSymbol(name: "string", code: 0x54455854, type: typeType) // "TEXT"
    public static let styledClipboardText = FINSymbol(name: "styledClipboardText", code: 0x7374796c, type: typeType) // "styl"
    public static let styledText = FINSymbol(name: "styledText", code: 0x53545854, type: typeType) // "STXT"
    public static let suggestedSize = FINSymbol(name: "suggestedSize", code: 0x73707274, type: typeType) // "sprt"
    public static let Sunday = FINSymbol(name: "Sunday", code: 0x73756e20, type: typeType) // "sun\0x20"
    public static let target = FINSymbol(name: "target", code: 0x66767467, type: typeType) // "fvtg"
    public static let textSize = FINSymbol(name: "textSize", code: 0x6673697a, type: typeType) // "fsiz"
    public static let textStyleInfo = FINSymbol(name: "textStyleInfo", code: 0x74737479, type: typeType) // "tsty"
    public static let Thursday = FINSymbol(name: "Thursday", code: 0x74687520, type: typeType) // "thu\0x20"
    public static let TIFFPicture = FINSymbol(name: "TIFFPicture", code: 0x54494646, type: typeType) // "TIFF"
    public static let titled = FINSymbol(name: "titled", code: 0x70746974, type: typeType) // "ptit"
    public static let toolbarVisible = FINSymbol(name: "toolbarVisible", code: 0x74627669, type: typeType) // "tbvi"
    public static let totalPartitionSize = FINSymbol(name: "totalPartitionSize", code: 0x61707074, type: typeType) // "appt"
    public static let trash = FINSymbol(name: "trash", code: 0x74727368, type: typeType) // "trsh"
    public static let trashObject = FINSymbol(name: "trashObject", code: 0x63747273, type: typeType) // "ctrs"
    public static let Tuesday = FINSymbol(name: "Tuesday", code: 0x74756520, type: typeType) // "tue\0x20"
    public static let typeClass = FINSymbol(name: "typeClass", code: 0x74797065, type: typeType) // "type"
    public static let UnicodeText = FINSymbol(name: "UnicodeText", code: 0x75747874, type: typeType) // "utxt"
    public static let unsignedDoubleInteger = FINSymbol(name: "unsignedDoubleInteger", code: 0x75636f6d, type: typeType) // "ucom"
    public static let unsignedInteger = FINSymbol(name: "unsignedInteger", code: 0x6d61676e, type: typeType) // "magn"
    public static let unsignedShortInteger = FINSymbol(name: "unsignedShortInteger", code: 0x75736872, type: typeType) // "ushr"
    public static let URL = FINSymbol(name: "URL", code: 0x7055524c, type: typeType) // "pURL"
    public static let usesRelativeDates = FINSymbol(name: "usesRelativeDates", code: 0x75726474, type: typeType) // "urdt"
    public static let UTF16Text = FINSymbol(name: "UTF16Text", code: 0x75743136, type: typeType) // "ut16"
    public static let UTF8Text = FINSymbol(name: "UTF8Text", code: 0x75746638, type: typeType) // "utf8"
    public static let visible = FINSymbol(name: "visible", code: 0x70766973, type: typeType) // "pvis"
    public static let warnsBeforeEmptying = FINSymbol(name: "warnsBeforeEmptying", code: 0x7761726e, type: typeType) // "warn"
    public static let Wednesday = FINSymbol(name: "Wednesday", code: 0x77656420, type: typeType) // "wed\0x20"
    public static let width = FINSymbol(name: "width", code: 0x636c7764, type: typeType) // "clwd"
    public static let window = FINSymbol(name: "window", code: 0x6377696e, type: typeType) // "cwin"
    public static let writingCode = FINSymbol(name: "writingCode", code: 0x70736374, type: typeType) // "psct"
    public static let zoomable = FINSymbol(name: "zoomable", code: 0x69737a6d, type: typeType) // "iszm"
    public static let zoomed = FINSymbol(name: "zoomed", code: 0x707a756d, type: typeType) // "pzum"

    // Enumerators
    public static let AdvancedPreferencesPanel = FINSymbol(name: "AdvancedPreferencesPanel", code: 0x70616476, type: typeEnumerated) // "padv"
    public static let APFSFormat = FINSymbol(name: "APFSFormat", code: 0x64666170, type: typeEnumerated) // "dfap"
    public static let ApplePhotoFormat = FINSymbol(name: "ApplePhotoFormat", code: 0x64667068, type: typeEnumerated) // "dfph"
    public static let AppleShareFormat = FINSymbol(name: "AppleShareFormat", code: 0x64666173, type: typeEnumerated) // "dfas"
    public static let ApplicationPanel = FINSymbol(name: "ApplicationPanel", code: 0x61706e6c, type: typeEnumerated) // "apnl"
    public static let arrangedByCreationDate = FINSymbol(name: "arrangedByCreationDate", code: 0x63647461, type: typeEnumerated) // "cdta"
    public static let arrangedByKind = FINSymbol(name: "arrangedByKind", code: 0x6b696e61, type: typeEnumerated) // "kina"
    public static let arrangedByLabel = FINSymbol(name: "arrangedByLabel", code: 0x6c616261, type: typeEnumerated) // "laba"
    public static let arrangedByModificationDate = FINSymbol(name: "arrangedByModificationDate", code: 0x6d647461, type: typeEnumerated) // "mdta"
    public static let arrangedByName = FINSymbol(name: "arrangedByName", code: 0x6e616d61, type: typeEnumerated) // "nama"
    public static let arrangedBySize = FINSymbol(name: "arrangedBySize", code: 0x73697a61, type: typeEnumerated) // "siza"
    public static let ask = FINSymbol(name: "ask", code: 0x61736b20, type: typeEnumerated) // "ask\0x20"
    public static let audioFormat = FINSymbol(name: "audioFormat", code: 0x64666175, type: typeEnumerated) // "dfau"
    public static let bottom = FINSymbol(name: "bottom", code: 0x6c626f74, type: typeEnumerated) // "lbot"
    public static let BurningPanel = FINSymbol(name: "BurningPanel", code: 0x62706e6c, type: typeEnumerated) // "bpnl"
    public static let case_ = FINSymbol(name: "case_", code: 0x63617365, type: typeEnumerated) // "case"
    public static let columnView = FINSymbol(name: "columnView", code: 0x636c7677, type: typeEnumerated) // "clvw"
    public static let comment = FINSymbol(name: "comment", code: 0x636f6d74, type: typeEnumerated) // "comt"
    public static let commentColumn = FINSymbol(name: "commentColumn", code: 0x656c7343, type: typeEnumerated) // "elsC"
    public static let CommentsPanel = FINSymbol(name: "CommentsPanel", code: 0x63706e6c, type: typeEnumerated) // "cpnl"
    public static let ContentIndexPanel = FINSymbol(name: "ContentIndexPanel", code: 0x63696e6c, type: typeEnumerated) // "cinl"
    public static let creationDate = FINSymbol(name: "creationDate", code: 0x61736364, type: typeEnumerated) // "ascd"
    public static let creationDateColumn = FINSymbol(name: "creationDateColumn", code: 0x656c7363, type: typeEnumerated) // "elsc"
    public static let diacriticals = FINSymbol(name: "diacriticals", code: 0x64696163, type: typeEnumerated) // "diac"
    public static let ExFATFormat = FINSymbol(name: "ExFATFormat", code: 0x64667866, type: typeEnumerated) // "dfxf"
    public static let expansion = FINSymbol(name: "expansion", code: 0x65787061, type: typeEnumerated) // "expa"
    public static let flowView = FINSymbol(name: "flowView", code: 0x666c7677, type: typeEnumerated) // "flvw"
    public static let FTPFormat = FINSymbol(name: "FTPFormat", code: 0x64666674, type: typeEnumerated) // "dfft"
    public static let GeneralInformationPanel = FINSymbol(name: "GeneralInformationPanel", code: 0x67706e6c, type: typeEnumerated) // "gpnl"
    public static let GeneralPreferencesPanel = FINSymbol(name: "GeneralPreferencesPanel", code: 0x70676e70, type: typeEnumerated) // "pgnp"
    public static let groupView = FINSymbol(name: "groupView", code: 0x666c7677, type: typeEnumerated) // "flvw"
    public static let HighSierraFormat = FINSymbol(name: "HighSierraFormat", code: 0x64666873, type: typeEnumerated) // "dfhs"
    public static let hyphens = FINSymbol(name: "hyphens", code: 0x68797068, type: typeEnumerated) // "hyph"
    public static let iconView = FINSymbol(name: "iconView", code: 0x69636e76, type: typeEnumerated) // "icnv"
    public static let ISO9660Format = FINSymbol(name: "ISO9660Format", code: 0x64663936, type: typeEnumerated) // "df96"
    public static let kind = FINSymbol(name: "kind", code: 0x6b696e64, type: typeEnumerated) // "kind"
    public static let kindColumn = FINSymbol(name: "kindColumn", code: 0x656c736b, type: typeEnumerated) // "elsk"
    public static let labelColumn = FINSymbol(name: "labelColumn", code: 0x656c736c, type: typeEnumerated) // "elsl"
    public static let labelIndex = FINSymbol(name: "labelIndex", code: 0x6c616269, type: typeEnumerated) // "labi"
    public static let LabelPreferencesPanel = FINSymbol(name: "LabelPreferencesPanel", code: 0x706c6270, type: typeEnumerated) // "plbp"
    public static let LanguagesPanel = FINSymbol(name: "LanguagesPanel", code: 0x706b6c67, type: typeEnumerated) // "pklg"
    public static let large = FINSymbol(name: "large", code: 0x6c676963, type: typeEnumerated) // "lgic"
    public static let largeIcon = FINSymbol(name: "largeIcon", code: 0x6c676963, type: typeEnumerated) // "lgic"
    public static let listView = FINSymbol(name: "listView", code: 0x6c737677, type: typeEnumerated) // "lsvw"
    public static let MacOSExtendedFormat = FINSymbol(name: "MacOSExtendedFormat", code: 0x6466682b, type: typeEnumerated) // "dfh+"
    public static let MacOSFormat = FINSymbol(name: "MacOSFormat", code: 0x64666866, type: typeEnumerated) // "dfhf"
    public static let MemoryPanel = FINSymbol(name: "MemoryPanel", code: 0x6d706e6c, type: typeEnumerated) // "mpnl"
    public static let mini = FINSymbol(name: "mini", code: 0x6d696963, type: typeEnumerated) // "miic"
    public static let modificationDate = FINSymbol(name: "modificationDate", code: 0x61736d6f, type: typeEnumerated) // "asmo"
    public static let modificationDateColumn = FINSymbol(name: "modificationDateColumn", code: 0x656c736d, type: typeEnumerated) // "elsm"
    public static let MoreInfoPanel = FINSymbol(name: "MoreInfoPanel", code: 0x6d696e6c, type: typeEnumerated) // "minl"
    public static let MSDOSFormat = FINSymbol(name: "MSDOSFormat", code: 0x64666d73, type: typeEnumerated) // "dfms"
    public static let name = FINSymbol(name: "name", code: 0x706e616d, type: typeEnumerated) // "pnam"
    public static let NameAndExtensionPanel = FINSymbol(name: "NameAndExtensionPanel", code: 0x6e706e6c, type: typeEnumerated) // "npnl"
    public static let nameColumn = FINSymbol(name: "nameColumn", code: 0x656c736e, type: typeEnumerated) // "elsn"
    public static let NFSFormat = FINSymbol(name: "NFSFormat", code: 0x64666e66, type: typeEnumerated) // "dfnf"
    public static let no = FINSymbol(name: "no", code: 0x6e6f2020, type: typeEnumerated) // "no\0x20\0x20"
    public static let none = FINSymbol(name: "none", code: 0x6e6f6e65, type: typeEnumerated) // "none"
    public static let normal = FINSymbol(name: "normal", code: 0x736e726d, type: typeEnumerated) // "snrm"
    public static let notArranged = FINSymbol(name: "notArranged", code: 0x6e617272, type: typeEnumerated) // "narr"
    public static let NTFSFormat = FINSymbol(name: "NTFSFormat", code: 0x64666e74, type: typeEnumerated) // "dfnt"
    public static let numericStrings = FINSymbol(name: "numericStrings", code: 0x6e756d65, type: typeEnumerated) // "nume"
    public static let PacketWrittenUDFFormat = FINSymbol(name: "PacketWrittenUDFFormat", code: 0x64667075, type: typeEnumerated) // "dfpu"
    public static let PluginsPanel = FINSymbol(name: "PluginsPanel", code: 0x706b7067, type: typeEnumerated) // "pkpg"
    public static let PreviewPanel = FINSymbol(name: "PreviewPanel", code: 0x76706e6c, type: typeEnumerated) // "vpnl"
    public static let ProDOSFormat = FINSymbol(name: "ProDOSFormat", code: 0x64667072, type: typeEnumerated) // "dfpr"
    public static let punctuation = FINSymbol(name: "punctuation", code: 0x70756e63, type: typeEnumerated) // "punc"
    public static let QuickTakeFormat = FINSymbol(name: "QuickTakeFormat", code: 0x64667174, type: typeEnumerated) // "dfqt"
    public static let readOnly = FINSymbol(name: "readOnly", code: 0x72656164, type: typeEnumerated) // "read"
    public static let readWrite = FINSymbol(name: "readWrite", code: 0x72647772, type: typeEnumerated) // "rdwr"
    public static let reversed = FINSymbol(name: "reversed", code: 0x73727673, type: typeEnumerated) // "srvs"
    public static let right = FINSymbol(name: "right", code: 0x6c726774, type: typeEnumerated) // "lrgt"
    public static let SharingPanel = FINSymbol(name: "SharingPanel", code: 0x73706e6c, type: typeEnumerated) // "spnl"
    public static let SidebarPreferencesPanel = FINSymbol(name: "SidebarPreferencesPanel", code: 0x70736964, type: typeEnumerated) // "psid"
    public static let SimpleHeaderPanel = FINSymbol(name: "SimpleHeaderPanel", code: 0x73686e6c, type: typeEnumerated) // "shnl"
    public static let size = FINSymbol(name: "size", code: 0x70687973, type: typeEnumerated) // "phys"
    public static let sizeColumn = FINSymbol(name: "sizeColumn", code: 0x656c7373, type: typeEnumerated) // "elss"
    public static let small = FINSymbol(name: "small", code: 0x736d6963, type: typeEnumerated) // "smic"
    public static let smallIcon = FINSymbol(name: "smallIcon", code: 0x736d6963, type: typeEnumerated) // "smic"
    public static let SMBFormat = FINSymbol(name: "SMBFormat", code: 0x6466736d, type: typeEnumerated) // "dfsm"
    public static let snapToGrid = FINSymbol(name: "snapToGrid", code: 0x67726461, type: typeEnumerated) // "grda"
    public static let UDFFormat = FINSymbol(name: "UDFFormat", code: 0x64667564, type: typeEnumerated) // "dfud"
    public static let UFSFormat = FINSymbol(name: "UFSFormat", code: 0x64667566, type: typeEnumerated) // "dfuf"
    public static let unknownFormat = FINSymbol(name: "unknownFormat", code: 0x64663f3f, type: typeEnumerated) // "df??"
    public static let version = FINSymbol(name: "version", code: 0x76657273, type: typeEnumerated) // "vers"
    public static let versionColumn = FINSymbol(name: "versionColumn", code: 0x656c7376, type: typeEnumerated) // "elsv"
    public static let WebDAVFormat = FINSymbol(name: "WebDAVFormat", code: 0x64667764, type: typeEnumerated) // "dfwd"
    public static let whitespace = FINSymbol(name: "whitespace", code: 0x77686974, type: typeEnumerated) // "whit"
    public static let writeOnly = FINSymbol(name: "writeOnly", code: 0x77726974, type: typeEnumerated) // "writ"
    public static let XsanFormat = FINSymbol(name: "XsanFormat", code: 0x64666163, type: typeEnumerated) // "dfac"
    public static let yes = FINSymbol(name: "yes", code: 0x79657320, type: typeEnumerated) // "yes\0x20"
}

public typealias FIN = FINSymbol // allows symbols to be written as (e.g.) FIN.name instead of FINSymbol.name


/******************************************************************************/
// Specifier extensions; these add command methods and property/elements getters based on Finder.app terminology

public protocol FINCommand: SwiftAutomation.SpecifierProtocol {} // provides AE dispatch methods

// Command->Any will be bound when return type can't be inferred, else Command->T

extension FINCommand {
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
    @discardableResult public func cleanUp(_ directParameter: Any = SwiftAutomation.NoParameter,
            by: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "cleanUp", eventClass: 0x666e6472, eventID: 0x66636c75, // "fndr"/"fclu"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("by", 0x62792020, by), // "by\0x20\0x20"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func cleanUp<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            by: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "cleanUp", eventClass: 0x666e6472, eventID: 0x66636c75, // "fndr"/"fclu"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("by", 0x62792020, by), // "by\0x20\0x20"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func close(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "close", eventClass: 0x636f7265, eventID: 0x636c6f73, // "core"/"clos"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func close<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "close", eventClass: 0x636f7265, eventID: 0x636c6f73, // "core"/"clos"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func copy(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "copy", eventClass: 0x6d697363, eventID: 0x636f7079, // "misc"/"copy"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func copy<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "copy", eventClass: 0x6d697363, eventID: 0x636f7079, // "misc"/"copy"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
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
    @discardableResult public func dataSize(_ directParameter: Any = SwiftAutomation.NoParameter,
            as_: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "dataSize", eventClass: 0x636f7265, eventID: 0x6473697a, // "core"/"dsiz"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("as_", 0x72747970, as_), // "rtyp"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func dataSize<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            as_: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "dataSize", eventClass: 0x636f7265, eventID: 0x6473697a, // "core"/"dsiz"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("as_", 0x72747970, as_), // "rtyp"
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
            replacing: Any = SwiftAutomation.NoParameter,
            routingSuppressed: Any = SwiftAutomation.NoParameter,
            exactCopy: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "duplicate", eventClass: 0x636f7265, eventID: 0x636c6f6e, // "core"/"clon"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x696e7368, to), // "insh"
                    ("replacing", 0x616c7270, replacing), // "alrp"
                    ("routingSuppressed", 0x726f7574, routingSuppressed), // "rout"
                    ("exactCopy", 0x65786374, exactCopy), // "exct"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func duplicate<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            to: Any = SwiftAutomation.NoParameter,
            replacing: Any = SwiftAutomation.NoParameter,
            routingSuppressed: Any = SwiftAutomation.NoParameter,
            exactCopy: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "duplicate", eventClass: 0x636f7265, eventID: 0x636c6f6e, // "core"/"clon"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x696e7368, to), // "insh"
                    ("replacing", 0x616c7270, replacing), // "alrp"
                    ("routingSuppressed", 0x726f7574, routingSuppressed), // "rout"
                    ("exactCopy", 0x65786374, exactCopy), // "exct"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func eject(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "eject", eventClass: 0x666e6472, eventID: 0x656a6374, // "fndr"/"ejct"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func eject<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "eject", eventClass: 0x666e6472, eventID: 0x656a6374, // "fndr"/"ejct"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func empty(_ directParameter: Any = SwiftAutomation.NoParameter,
            security: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "empty", eventClass: 0x666e6472, eventID: 0x656d7074, // "fndr"/"empt"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("security", 0x7365633f, security), // "sec?"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func empty<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            security: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "empty", eventClass: 0x666e6472, eventID: 0x656d7074, // "fndr"/"empt"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("security", 0x7365633f, security), // "sec?"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func erase(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "erase", eventClass: 0x666e6472, eventID: 0x66657261, // "fndr"/"fera"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func erase<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "erase", eventClass: 0x666e6472, eventID: 0x66657261, // "fndr"/"fera"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
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
    @discardableResult public func make(_ directParameter: Any = SwiftAutomation.NoParameter,
            new: Any = SwiftAutomation.NoParameter,
            at: Any = SwiftAutomation.NoParameter,
            to: Any = SwiftAutomation.NoParameter,
            withProperties: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "make", eventClass: 0x636f7265, eventID: 0x6372656c, // "core"/"crel"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("new", 0x6b6f636c, new), // "kocl"
                    ("at", 0x696e7368, at), // "insh"
                    ("to", 0x746f2020, to), // "to\0x20\0x20"
                    ("withProperties", 0x70726474, withProperties), // "prdt"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func make<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            new: Any = SwiftAutomation.NoParameter,
            at: Any = SwiftAutomation.NoParameter,
            to: Any = SwiftAutomation.NoParameter,
            withProperties: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "make", eventClass: 0x636f7265, eventID: 0x6372656c, // "core"/"crel"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("new", 0x6b6f636c, new), // "kocl"
                    ("at", 0x696e7368, at), // "insh"
                    ("to", 0x746f2020, to), // "to\0x20\0x20"
                    ("withProperties", 0x70726474, withProperties), // "prdt"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func move(_ directParameter: Any = SwiftAutomation.NoParameter,
            to: Any = SwiftAutomation.NoParameter,
            replacing: Any = SwiftAutomation.NoParameter,
            positionedAt: Any = SwiftAutomation.NoParameter,
            routingSuppressed: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "move", eventClass: 0x636f7265, eventID: 0x6d6f7665, // "core"/"move"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x696e7368, to), // "insh"
                    ("replacing", 0x616c7270, replacing), // "alrp"
                    ("positionedAt", 0x6d76706c, positionedAt), // "mvpl"
                    ("routingSuppressed", 0x726f7574, routingSuppressed), // "rout"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func move<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            to: Any = SwiftAutomation.NoParameter,
            replacing: Any = SwiftAutomation.NoParameter,
            positionedAt: Any = SwiftAutomation.NoParameter,
            routingSuppressed: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "move", eventClass: 0x636f7265, eventID: 0x6d6f7665, // "core"/"move"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x696e7368, to), // "insh"
                    ("replacing", 0x616c7270, replacing), // "alrp"
                    ("positionedAt", 0x6d76706c, positionedAt), // "mvpl"
                    ("routingSuppressed", 0x726f7574, routingSuppressed), // "rout"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func open(_ directParameter: Any = SwiftAutomation.NoParameter,
            using: Any = SwiftAutomation.NoParameter,
            withProperties: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "open", eventClass: 0x61657674, eventID: 0x6f646f63, // "aevt"/"odoc"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("using", 0x7573696e, using), // "usin"
                    ("withProperties", 0x70726474, withProperties), // "prdt"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func open<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            using: Any = SwiftAutomation.NoParameter,
            withProperties: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "open", eventClass: 0x61657674, eventID: 0x6f646f63, // "aevt"/"odoc"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("using", 0x7573696e, using), // "usin"
                    ("withProperties", 0x70726474, withProperties), // "prdt"
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
    @discardableResult public func openVirtualLocation(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "openVirtualLocation", eventClass: 0x666e6472, eventID: 0x6f766972, // "fndr"/"ovir"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func openVirtualLocation<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "openVirtualLocation", eventClass: 0x666e6472, eventID: 0x6f766972, // "fndr"/"ovir"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func print(_ directParameter: Any = SwiftAutomation.NoParameter,
            withProperties: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "print", eventClass: 0x61657674, eventID: 0x70646f63, // "aevt"/"pdoc"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("withProperties", 0x70726474, withProperties), // "prdt"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func print<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            withProperties: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "print", eventClass: 0x61657674, eventID: 0x70646f63, // "aevt"/"pdoc"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("withProperties", 0x70726474, withProperties), // "prdt"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func quit(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "quit", eventClass: 0x61657674, eventID: 0x71756974, // "aevt"/"quit"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func quit<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "quit", eventClass: 0x61657674, eventID: 0x71756974, // "aevt"/"quit"
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
    @discardableResult public func restart(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "restart", eventClass: 0x666e6472, eventID: 0x72657374, // "fndr"/"rest"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func restart<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "restart", eventClass: 0x666e6472, eventID: 0x72657374, // "fndr"/"rest"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func reveal(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "reveal", eventClass: 0x6d697363, eventID: 0x6d766973, // "misc"/"mvis"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func reveal<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "reveal", eventClass: 0x6d697363, eventID: 0x6d766973, // "misc"/"mvis"
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
    @discardableResult public func select(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "select", eventClass: 0x6d697363, eventID: 0x736c6374, // "misc"/"slct"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func select<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "select", eventClass: 0x6d697363, eventID: 0x736c6374, // "misc"/"slct"
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
    @discardableResult public func shutDown(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "shutDown", eventClass: 0x666e6472, eventID: 0x73687574, // "fndr"/"shut"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func shutDown<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "shutDown", eventClass: 0x666e6472, eventID: 0x73687574, // "fndr"/"shut"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func sleep(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "sleep", eventClass: 0x666e6472, eventID: 0x736c6570, // "fndr"/"slep"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func sleep<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "sleep", eventClass: 0x666e6472, eventID: 0x736c6570, // "fndr"/"slep"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func sort(_ directParameter: Any = SwiftAutomation.NoParameter,
            by: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "sort", eventClass: 0x44415441, eventID: 0x534f5254, // "DATA"/"SORT"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("by", 0x62792020, by), // "by\0x20\0x20"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func sort<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            by: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "sort", eventClass: 0x44415441, eventID: 0x534f5254, // "DATA"/"SORT"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("by", 0x62792020, by), // "by\0x20\0x20"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func update(_ directParameter: Any = SwiftAutomation.NoParameter,
            necessity: Any = SwiftAutomation.NoParameter,
            registeringApplications: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "update", eventClass: 0x666e6472, eventID: 0x66757064, // "fndr"/"fupd"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("necessity", 0x6e65633f, necessity), // "nec?"
                    ("registeringApplications", 0x7265673f, registeringApplications), // "reg?"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func update<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            necessity: Any = SwiftAutomation.NoParameter,
            registeringApplications: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "update", eventClass: 0x666e6472, eventID: 0x66757064, // "fndr"/"fupd"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("necessity", 0x6e65633f, necessity), // "nec?"
                    ("registeringApplications", 0x7265673f, registeringApplications), // "reg?"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
}


public protocol FINObject: SwiftAutomation.ObjectSpecifierExtension, FINCommand {} // provides vars and methods for constructing specifiers

extension FINObject {
    
    // Properties
    public var acceptsHighLevelEvents: FINItem {return self.property(0x69736162) as! FINItem} // "isab"
    public var acceptsRemoteEvents: FINItem {return self.property(0x72657674) as! FINItem} // "revt"
    public var allNameExtensionsShowing: FINItem {return self.property(0x70736e78) as! FINItem} // "psnx"
    public var applicationFile: FINItem {return self.property(0x61707066) as! FINItem} // "appf"
    public var arrangement: FINItem {return self.property(0x69617272) as! FINItem} // "iarr"
    public var backgroundColor: FINItem {return self.property(0x636f6c72) as! FINItem} // "colr"
    public var backgroundPicture: FINItem {return self.property(0x69626b67) as! FINItem} // "ibkg"
    public var bounds: FINItem {return self.property(0x70626e64) as! FINItem} // "pbnd"
    public var calculatesFolderSizes: FINItem {return self.property(0x7366737a) as! FINItem} // "sfsz"
    public var capacity: FINItem {return self.property(0x63617061) as! FINItem} // "capa"
    public var class_: FINItem {return self.property(0x70636c73) as! FINItem} // "pcls"
    public var clipboard: FINItem {return self.property(0x70636c69) as! FINItem} // "pcli"
    public var clippingWindow: FINItem {return self.property(0x6c776e64) as! FINItem} // "lwnd"
    public var closeable: FINItem {return self.property(0x68636c62) as! FINItem} // "hclb"
    public var collapsed: FINItem {return self.property(0x77736864) as! FINItem} // "wshd"
    public var color: FINItem {return self.property(0x636f6c72) as! FINItem} // "colr"
    public var columnViewOptions: FINItem {return self.property(0x63766f70) as! FINItem} // "cvop"
    public var comment: FINItem {return self.property(0x636f6d74) as! FINItem} // "comt"
    public var completelyExpanded: FINItem {return self.property(0x70657863) as! FINItem} // "pexc"
    public var computerContainer: FINItem {return self.property(0x70636d70) as! FINItem} // "pcmp"
    public var container: FINItem {return self.property(0x63746e72) as! FINItem} // "ctnr"
    public var containerWindow: FINItem {return self.property(0x63776e64) as! FINItem} // "cwnd"
    public var creationDate: FINItem {return self.property(0x61736364) as! FINItem} // "ascd"
    public var creatorType: FINItem {return self.property(0x66637274) as! FINItem} // "fcrt"
    public var currentPanel: FINItem {return self.property(0x70616e6c) as! FINItem} // "panl"
    public var currentView: FINItem {return self.property(0x70766577) as! FINItem} // "pvew"
    public var delayBeforeSpringing: FINItem {return self.property(0x64656c61) as! FINItem} // "dela"
    public var description_: FINItem {return self.property(0x64736372) as! FINItem} // "dscr"
    public var deskAccessoryFile: FINItem {return self.property(0x64616669) as! FINItem} // "dafi"
    public var desktop: FINItem {return self.property(0x6465736b) as! FINItem} // "desk"
    public var desktopPicture: FINItem {return self.property(0x64706963) as! FINItem} // "dpic"
    public var desktopPosition: FINItem {return self.property(0x64706f73) as! FINItem} // "dpos"
    public var desktopShowsConnectedServers: FINItem {return self.property(0x70647376) as! FINItem} // "pdsv"
    public var desktopShowsExternalHardDisks: FINItem {return self.property(0x70656864) as! FINItem} // "pehd"
    public var desktopShowsHardDisks: FINItem {return self.property(0x70646864) as! FINItem} // "pdhd"
    public var desktopShowsRemovableMedia: FINItem {return self.property(0x7064726d) as! FINItem} // "pdrm"
    public var disclosesPreviewPane: FINItem {return self.property(0x64737072) as! FINItem} // "dspr"
    public var disk: FINItem {return self.property(0x63646973) as! FINItem} // "cdis"
    public var displayedName: FINItem {return self.property(0x646e616d) as! FINItem} // "dnam"
    public var ejectable: FINItem {return self.property(0x6973656a) as! FINItem} // "isej"
    public var entireContents: FINItem {return self.property(0x65637473) as! FINItem} // "ects"
    public var everyonesPrivileges: FINItem {return self.property(0x67737470) as! FINItem} // "gstp"
    public var expandable: FINItem {return self.property(0x70657861) as! FINItem} // "pexa"
    public var expanded: FINItem {return self.property(0x70657870) as! FINItem} // "pexp"
    public var extensionHidden: FINItem {return self.property(0x68696478) as! FINItem} // "hidx"
    public var file: FINItem {return self.property(0x66696c65) as! FINItem} // "file"
    public var fileType: FINItem {return self.property(0x61737479) as! FINItem} // "asty"
    public var FinderPreferences: FINItem {return self.property(0x70667270) as! FINItem} // "pfrp"
    public var floating: FINItem {return self.property(0x6973666c) as! FINItem} // "isfl"
    public var foldersOpenInNewTabs: FINItem {return self.property(0x706f6e74) as! FINItem} // "pont"
    public var foldersOpenInNewWindows: FINItem {return self.property(0x706f6e77) as! FINItem} // "ponw"
    public var foldersSpringOpen: FINItem {return self.property(0x73707267) as! FINItem} // "sprg"
    public var format: FINItem {return self.property(0x64666d74) as! FINItem} // "dfmt"
    public var freeSpace: FINItem {return self.property(0x66727370) as! FINItem} // "frsp"
    public var frontmost: FINItem {return self.property(0x70697366) as! FINItem} // "pisf"
    public var group: FINItem {return self.property(0x73677270) as! FINItem} // "sgrp"
    public var groupPrivileges: FINItem {return self.property(0x67707072) as! FINItem} // "gppr"
    public var hasScriptingTerminology: FINItem {return self.property(0x68736372) as! FINItem} // "hscr"
    public var home: FINItem {return self.property(0x686f6d65) as! FINItem} // "home"
    public var icon: FINItem {return self.property(0x69696d67) as! FINItem} // "iimg"
    public var iconSize: FINItem {return self.property(0x6c766973) as! FINItem} // "lvis"
    public var iconViewOptions: FINItem {return self.property(0x69636f70) as! FINItem} // "icop"
    public var id: FINItem {return self.property(0x49442020) as! FINItem} // "ID\0x20\0x20"
    public var ignorePrivileges: FINItem {return self.property(0x69677072) as! FINItem} // "igpr"
    public var index: FINItem {return self.property(0x70696478) as! FINItem} // "pidx"
    public var informationWindow: FINItem {return self.property(0x69776e64) as! FINItem} // "iwnd"
    public var insertionLocation: FINItem {return self.property(0x70696e73) as! FINItem} // "pins"
    public var item: FINItem {return self.property(0x636f626a) as! FINItem} // "cobj"
    public var journalingEnabled: FINItem {return self.property(0x4a726e6c) as! FINItem} // "Jrnl"
    public var kind: FINItem {return self.property(0x6b696e64) as! FINItem} // "kind"
    public var labelIndex: FINItem {return self.property(0x6c616269) as! FINItem} // "labi"
    public var labelPosition: FINItem {return self.property(0x6c706f73) as! FINItem} // "lpos"
    public var large32BitIcon: FINItem {return self.property(0x696c3332) as! FINItem} // "il32"
    public var large4BitIcon: FINItem {return self.property(0x69636c34) as! FINItem} // "icl4"
    public var large8BitIcon: FINItem {return self.property(0x69636c38) as! FINItem} // "icl8"
    public var large8BitMask: FINItem {return self.property(0x6c386d6b) as! FINItem} // "l8mk"
    public var largeMonochromeIconAndMask: FINItem {return self.property(0x49434e23) as! FINItem} // "ICN#"
    public var listViewOptions: FINItem {return self.property(0x6c766f70) as! FINItem} // "lvop"
    public var localVolume: FINItem {return self.property(0x69737276) as! FINItem} // "isrv"
    public var location: FINItem {return self.property(0x696c6f63) as! FINItem} // "iloc"
    public var locked: FINItem {return self.property(0x61736c6b) as! FINItem} // "aslk"
    public var maximumWidth: FINItem {return self.property(0x636c776d) as! FINItem} // "clwm"
    public var minimumSize: FINItem {return self.property(0x6d707274) as! FINItem} // "mprt"
    public var minimumWidth: FINItem {return self.property(0x636c776e) as! FINItem} // "clwn"
    public var modal: FINItem {return self.property(0x706d6f64) as! FINItem} // "pmod"
    public var modificationDate: FINItem {return self.property(0x61736d6f) as! FINItem} // "asmo"
    public var name: FINItem {return self.property(0x706e616d) as! FINItem} // "pnam"
    public var nameExtension: FINItem {return self.property(0x6e6d7874) as! FINItem} // "nmxt"
    public var newWindowsOpenInColumnView: FINItem {return self.property(0x706f6376) as! FINItem} // "pocv"
    public var newWindowTarget: FINItem {return self.property(0x706e7774) as! FINItem} // "pnwt"
    public var opensInClassic: FINItem {return self.property(0x436c7363) as! FINItem} // "Clsc"
    public var originalItem: FINItem {return self.property(0x6f726967) as! FINItem} // "orig"
    public var owner: FINItem {return self.property(0x736f776e) as! FINItem} // "sown"
    public var ownerPrivileges: FINItem {return self.property(0x6f776e72) as! FINItem} // "ownr"
    public var partitionSpaceUsed: FINItem {return self.property(0x70757364) as! FINItem} // "pusd"
    public var physicalSize: FINItem {return self.property(0x70687973) as! FINItem} // "phys"
    public var position: FINItem {return self.property(0x706f736e) as! FINItem} // "posn"
    public var preferredSize: FINItem {return self.property(0x61707074) as! FINItem} // "appt"
    public var productVersion: FINItem {return self.property(0x76657232) as! FINItem} // "ver2"
    public var properties: FINItem {return self.property(0x70414c4c) as! FINItem} // "pALL"
    public var resizable: FINItem {return self.property(0x7072737a) as! FINItem} // "prsz"
    public var selection: FINItem {return self.property(0x73656c65) as! FINItem} // "sele"
    public var showsIcon: FINItem {return self.property(0x73686963) as! FINItem} // "shic"
    public var showsIconPreview: FINItem {return self.property(0x70727677) as! FINItem} // "prvw"
    public var showsItemInfo: FINItem {return self.property(0x6d6e666f) as! FINItem} // "mnfo"
    public var showsPreviewColumn: FINItem {return self.property(0x73687072) as! FINItem} // "shpr"
    public var sidebarWidth: FINItem {return self.property(0x73627769) as! FINItem} // "sbwi"
    public var size: FINItem {return self.property(0x7074737a) as! FINItem} // "ptsz"
    public var small32BitIcon: FINItem {return self.property(0x69733332) as! FINItem} // "is32"
    public var small4BitIcon: FINItem {return self.property(0x69637334) as! FINItem} // "ics4"
    public var small8BitIcon: FINItem {return self.property(0x69637338) as! FINItem} // "ics8"
    public var small8BitMask: FINItem {return self.property(0x69637338) as! FINItem} // "ics8"
    public var smallMonochromeIconAndMask: FINItem {return self.property(0x69637323) as! FINItem} // "ics#"
    public var sortColumn: FINItem {return self.property(0x73727463) as! FINItem} // "srtc"
    public var sortDirection: FINItem {return self.property(0x736f7264) as! FINItem} // "sord"
    public var startup: FINItem {return self.property(0x69737464) as! FINItem} // "istd"
    public var startupDisk: FINItem {return self.property(0x7364736b) as! FINItem} // "sdsk"
    public var stationery: FINItem {return self.property(0x70737064) as! FINItem} // "pspd"
    public var statusbarVisible: FINItem {return self.property(0x73747669) as! FINItem} // "stvi"
    public var suggestedSize: FINItem {return self.property(0x73707274) as! FINItem} // "sprt"
    public var target: FINItem {return self.property(0x66767467) as! FINItem} // "fvtg"
    public var textSize: FINItem {return self.property(0x6673697a) as! FINItem} // "fsiz"
    public var titled: FINItem {return self.property(0x70746974) as! FINItem} // "ptit"
    public var toolbarVisible: FINItem {return self.property(0x74627669) as! FINItem} // "tbvi"
    public var totalPartitionSize: FINItem {return self.property(0x61707074) as! FINItem} // "appt"
    public var trash: FINItem {return self.property(0x74727368) as! FINItem} // "trsh"
    public var URL: FINItem {return self.property(0x7055524c) as! FINItem} // "pURL"
    public var usesRelativeDates: FINItem {return self.property(0x75726474) as! FINItem} // "urdt"
    public var version: FINItem {return self.property(0x76657273) as! FINItem} // "vers"
    public var visible: FINItem {return self.property(0x70766973) as! FINItem} // "pvis"
    public var warnsBeforeEmptying: FINItem {return self.property(0x7761726e) as! FINItem} // "warn"
    public var width: FINItem {return self.property(0x636c7764) as! FINItem} // "clwd"
    public var window: FINItem {return self.property(0x6377696e) as! FINItem} // "cwin"
    public var zoomable: FINItem {return self.property(0x69737a6d) as! FINItem} // "iszm"
    public var zoomed: FINItem {return self.property(0x707a756d) as! FINItem} // "pzum"

    // Elements
    public var aliasFiles: FINItems {return self.elements(0x616c6961) as! FINItems} // "alia"
    public var aliasLists: FINItems {return self.elements(0x616c7374) as! FINItems} // "alst"
    public var applications: FINItems {return self.elements(0x63617070) as! FINItems} // "capp"
    public var applicationFiles: FINItems {return self.elements(0x61707066) as! FINItems} // "appf"
    public var applicationProcesses: FINItems {return self.elements(0x70636170) as! FINItems} // "pcap"
    public var clippings: FINItems {return self.elements(0x636c7066) as! FINItems} // "clpf"
    public var clippingWindows: FINItems {return self.elements(0x6c776e64) as! FINItems} // "lwnd"
    public var columns: FINItems {return self.elements(0x6c76636c) as! FINItems} // "lvcl"
    public var computerObjects: FINItems {return self.elements(0x63636d70) as! FINItems} // "ccmp"
    public var containers: FINItems {return self.elements(0x63746e72) as! FINItems} // "ctnr"
    public var deskAccessoryProcesses: FINItems {return self.elements(0x70636461) as! FINItems} // "pcda"
    public var desktopWindows: FINItems {return self.elements(0x646b7477) as! FINItems} // "dktw"
    public var desktopObjects: FINItems {return self.elements(0x6364736b) as! FINItems} // "cdsk"
    public var disks: FINItems {return self.elements(0x63646973) as! FINItems} // "cdis"
    public var documentFiles: FINItems {return self.elements(0x646f6366) as! FINItems} // "docf"
    public var files: FINItems {return self.elements(0x66696c65) as! FINItems} // "file"
    public var FinderWindows: FINItems {return self.elements(0x62726f77) as! FINItems} // "brow"
    public var folders: FINItems {return self.elements(0x63666f6c) as! FINItems} // "cfol"
    public var iconFamilys: FINItems {return self.elements(0x6966616d) as! FINItems} // "ifam"
    public var informationWindows: FINItems {return self.elements(0x69776e64) as! FINItems} // "iwnd"
    public var internetLocationFiles: FINItems {return self.elements(0x696e6c66) as! FINItems} // "inlf"
    public var items: FINItems {return self.elements(0x636f626a) as! FINItems} // "cobj"
    public var labels: FINItems {return self.elements(0x636c626c) as! FINItems} // "clbl"
    public var packages: FINItems {return self.elements(0x7061636b) as! FINItems} // "pack"
    public var preferences: FINItems {return self.elements(0x63707266) as! FINItems} // "cprf"
    public var preferencesWindows: FINItems {return self.elements(0x70776e64) as! FINItems} // "pwnd"
    public var processes: FINItems {return self.elements(0x70726373) as! FINItems} // "prcs"
    public var trashObjects: FINItems {return self.elements(0x63747273) as! FINItems} // "ctrs"
    public var windows: FINItems {return self.elements(0x6377696e) as! FINItems} // "cwin"
}


/******************************************************************************/
// Specifier subclasses add app-specific extensions

// beginning/end/before/after
public class FINInsertion: SwiftAutomation.InsertionSpecifier, FINCommand {}


// property/by-index/by-name/by-id/previous/next/first/middle/last/any
public class FINItem: SwiftAutomation.ObjectSpecifier, FINObject {
    public typealias InsertionSpecifierType = FINInsertion
    public typealias ObjectSpecifierType = FINItem
    public typealias MultipleObjectSpecifierType = FINItems
}

// by-range/by-test/all
public class FINItems: FINItem, SwiftAutomation.MultipleObjectSpecifierExtension {}

// App/Con/Its
public class FINRoot: SwiftAutomation.RootSpecifier, FINObject, SwiftAutomation.RootSpecifierExtension {
    public typealias InsertionSpecifierType = FINInsertion
    public typealias ObjectSpecifierType = FINItem
    public typealias MultipleObjectSpecifierType = FINItems
    public override class var untargetedAppData: SwiftAutomation.AppData { return _untargetedAppData }
}

// Application
public class Finder: FINRoot, SwiftAutomation.Application {
    public convenience init(launchOptions: SwiftAutomation.LaunchOptions = SwiftAutomation.DefaultLaunchOptions, relaunchMode: SwiftAutomation.RelaunchMode = SwiftAutomation.DefaultRelaunchMode) {
        self.init(rootObject: SwiftAutomation.AppRootDesc, appData: Swift.type(of:self).untargetedAppData.targetedCopy(
                  .bundleIdentifier("com.apple.finder", true), launchOptions: launchOptions, relaunchMode: relaunchMode))
    }
}

// App/Con/Its root objects used to construct untargeted specifiers; these can be used to construct specifiers for use in commands, though cannot send commands themselves

public let FINApp = _untargetedAppData.app as! FINRoot
public let FINCon = _untargetedAppData.con as! FINRoot
public let FINIts = _untargetedAppData.its as! FINRoot


/******************************************************************************/
// Static types

public typealias FINRecord = [FINSymbol:Any] // default Swift type for AERecordDescs







