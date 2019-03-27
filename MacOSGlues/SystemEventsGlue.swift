//
//  SystemEventsGlue.swift
//  System Events.app 1.3.6
//  SwiftAutomation.framework 0.1.0
//  `aeglue -S 'System Events.app'`
//


import Foundation
import SwiftAutomation


/******************************************************************************/
// Create an untargeted AppData instance for use in App, Con, Its roots,
// and in Application initializers to create targeted AppData instances.

private let _specifierFormatter = SwiftAutomation.SpecifierFormatter(applicationClassName: "SystemEvents",
                                                     classNamePrefix: "SEV",
                                                     typeNames: [
                                                                     0x69736162: "acceptsHighLevelEvents", // "isab"
                                                                     0x72657674: "acceptsRemoteEvents", // "revt"
                                                                     0x61636373: "access", // "accs"
                                                                     0x61786473: "accessibilityDescription", // "axds"
                                                                     0x75736572: "accountName", // "user"
                                                                     0x61637454: "action", // "actT"
                                                                     0x61637469: "active", // "acti"
                                                                     0x616c6973: "alias", // "alis"
                                                                     0x64616e69: "animate", // "dani"
                                                                     0x616e6e6f: "annotation", // "anno"
                                                                     0x2a2a2a2a: "anything", // "****"
                                                                     0x61707065: "appearance", // "appe"
                                                                     0x61707270: "appearancePreferences", // "aprp"
                                                                     0x6170726f: "appearancePreferencesObject", // "apro"
                                                                     0x616d6e75: "appleMenuFolder", // "amnu"
                                                                     0x64667068: "ApplePhotoFormat", // "dfph"
                                                                     0x64666173: "AppleShareFormat", // "dfas"
                                                                     0x63617070: "application", // "capp"
                                                                     0x62756e64: "applicationBundleID", // "bund"
                                                                     0x61707066: "applicationFile", // "appf"
                                                                     0x70636170: "applicationProcess", // "pcap"
                                                                     0x61707073: "applicationsFolder", // "apps"
                                                                     0x7369676e: "applicationSignature", // "sign"
                                                                     0x61737570: "applicationSupportFolder", // "asup"
                                                                     0x6170726c: "applicationURL", // "aprl"
                                                                     0x61707220: "April", // "apr\0x20"
                                                                     0x61726368: "architecture", // "arch"
                                                                     0x61736b20: "ask", // "ask\0x20"
                                                                     0x64686173: "askWhatToDo", // "dhas"
                                                                     0x61747472: "attribute", // "attr"
                                                                     0x61636861: "audioChannelCount", // "acha"
                                                                     0x61756469: "audioCharacteristic", // "audi"
                                                                     0x61756464: "audioData", // "audd"
                                                                     0x61756466: "audioFile", // "audf"
                                                                     0x64666175: "audioFormat", // "dfau"
                                                                     0x61737261: "audioSampleRate", // "asra"
                                                                     0x6173737a: "audioSampleSize", // "assz"
                                                                     0x61756720: "August", // "aug\0x20"
                                                                     0x64616864: "autohide", // "dahd"
                                                                     0x6175746d: "automatic", // "autm"
                                                                     0x6175746f: "automatic", // "auto"
                                                                     0x61756c67: "automaticLogin", // "aulg"
                                                                     0x61757470: "autoPlay", // "autp"
                                                                     0x61707265: "autoPresent", // "apre"
                                                                     0x61717569: "autoQuitWhenDone", // "aqui"
                                                                     0x626b676f: "backgroundOnly", // "bkgo"
                                                                     0x62657374: "best", // "best"
                                                                     0x64686262: "blankBD", // "dhbb"
                                                                     0x64686263: "blankCD", // "dhbc"
                                                                     0x64686264: "blankDVD", // "dhbd"
                                                                     0x626c7565: "blue", // "blue"
                                                                     0x626d726b: "bookmarkData", // "bmrk"
                                                                     0x626f6f6c: "boolean", // "bool"
                                                                     0x626f7474: "bottom", // "bott"
                                                                     0x71647274: "boundingRectangle", // "qdrt"
                                                                     0x70626e64: "bounds", // "pbnd"
                                                                     0x62726f57: "browser", // "broW"
                                                                     0x626e6964: "bundleIdentifier", // "bnid"
                                                                     0x62757369: "busyIndicator", // "busi"
                                                                     0x62757379: "busyStatus", // "busy"
                                                                     0x62757454: "button", // "butT"
                                                                     0x63617061: "capacity", // "capa"
                                                                     0x63617365: "case_", // "case"
                                                                     0x6468616f: "CDAndDVDPreferencesObject", // "dhao"
                                                                     0x63696e54: "changeInterval", // "cinT"
                                                                     0x63686278: "checkbox", // "chbx"
                                                                     0x70636c73: "class_", // "pcls"
                                                                     0x636c7363: "Classic", // "clsc"
                                                                     0x666c6463: "ClassicDomain", // "fldc"
                                                                     0x646f6d63: "ClassicDomainObject", // "domc"
                                                                     0x68636c62: "closeable", // "hclb"
                                                                     0x6c77636c: "collating", // "lwcl"
                                                                     0x636f6c72: "color", // "colr"
                                                                     0x636c7274: "colorTable", // "clrt"
                                                                     0x636f6c57: "colorWell", // "colW"
                                                                     0x63636f6c: "column", // "ccol"
                                                                     0x636f6d42: "comboBox", // "comB"
                                                                     0x65436d64: "command", // "eCmd"
                                                                     0x4b636d64: "commandDown", // "Kcmd"
                                                                     0x636f6e46: "configuration", // "conF"
                                                                     0x636f6e6e: "connected", // "conn"
                                                                     0x656e756d: "constant", // "enum"
                                                                     0x63746e72: "container", // "ctnr"
                                                                     0x65436e74: "control", // "eCnt"
                                                                     0x4b63746c: "controlDown", // "Kctl"
                                                                     0x6374726c: "controlPanelsFolder", // "ctrl"
                                                                     0x73646576: "controlStripModulesFolder", // "sdev"
                                                                     0x6c776370: "copies", // "lwcp"
                                                                     0x61736364: "creationDate", // "ascd"
                                                                     0x6d646372: "creationTime", // "mdcr"
                                                                     0x66637274: "creatorType", // "fcrt"
                                                                     0x63757374: "current", // "cust"
                                                                     0x636e6667: "currentConfiguration", // "cnfg"
                                                                     0x63757264: "currentDesktop", // "curd"
                                                                     0x6c6f6363: "currentLocation", // "locc"
                                                                     0x73737663: "currentScreenSaver", // "ssvc"
                                                                     0x63757275: "currentUser", // "curu"
                                                                     0x64686361: "customApplication", // "dhca"
                                                                     0x64686373: "customScript", // "dhcs"
                                                                     0x74686d65: "darkMode", // "thme"
                                                                     0x74646173: "dashStyle", // "tdas"
                                                                     0x74647461: "data", // "tdta"
                                                                     0x72646174: "data_", // "rdat"
                                                                     0x74646672: "dataFormat", // "tdfr"
                                                                     0x64647261: "dataRate", // "ddra"
                                                                     0x6473697a: "dataSize", // "dsiz"
                                                                     0x6c647420: "date", // "ldt\0x20"
                                                                     0x64656320: "December", // "dec\0x20"
                                                                     0x6465636d: "decimalStruct", // "decm"
                                                                     0x61736461: "defaultApplication", // "asda"
                                                                     0x646c7969: "delayInterval", // "dlyi"
                                                                     0x64657363: "description_", // "desc"
                                                                     0x64616669: "deskAccessoryFile", // "dafi"
                                                                     0x70636461: "deskAccessoryProcess", // "pcda"
                                                                     0x64736b70: "desktop", // "dskp"
                                                                     0x6465736b: "desktopFolder", // "desk"
                                                                     0x64747024: "desktopPicturesFolder", // "dtp$"
                                                                     0x6c776474: "detailed", // "lwdt"
                                                                     0x64696163: "diacriticals", // "diac"
                                                                     0x7064696d: "dimensions", // "pdim"
                                                                     0x73646470: "directParameter", // "sddp"
                                                                     0x63646973: "disk", // "cdis"
                                                                     0x6469746d: "diskItem", // "ditm"
                                                                     0x646e616d: "displayedName", // "dnam"
                                                                     0x646e614d: "displayName", // "dnaM"
                                                                     0x64706173: "dockPreferences", // "dpas"
                                                                     0x6470616f: "dockPreferencesObject", // "dpao"
                                                                     0x64737a65: "dockSize", // "dsze"
                                                                     0x646f6375: "document", // "docu"
                                                                     0x646f6373: "documentsFolder", // "docs"
                                                                     0x646f6d61: "domain", // "doma"
                                                                     0x646f7562: "double", // "doub"
                                                                     0x636f6d70: "doubleInteger", // "comp"
                                                                     0x646f776e: "downloadsFolder", // "down"
                                                                     0x64726141: "drawer", // "draA"
                                                                     0x6475706c: "duplex", // "dupl"
                                                                     0x6475726e: "duration", // "durn"
                                                                     0x6973656a: "ejectable", // "isej"
                                                                     0x656e6142: "enabled", // "enaB"
                                                                     0x656e6373: "encodedString", // "encs"
                                                                     0x6c776c70: "endingPage", // "lwlp"
                                                                     0x65637473: "entireContents", // "ects"
                                                                     0x656e6d64: "enumerated", // "enmd"
                                                                     0x45505320: "EPSPicture", // "EPS\0x20"
                                                                     0x6c776568: "errorHandling", // "lweh"
                                                                     0x65787061: "expansion", // "expa"
                                                                     0x65787465: "extendedReal", // "exte"
                                                                     0x6578747a: "extensionsFolder", // "extz"
                                                                     0x66617673: "favoritesFolder", // "favs"
                                                                     0x6661786e: "faxNumber", // "faxn"
                                                                     0x66656220: "February", // "feb\0x20"
                                                                     0x66696c65: "file", // "file"
                                                                     0x63706b67: "filePackage", // "cpkg"
                                                                     0x66737266: "fileRef", // "fsrf"
                                                                     0x66737320: "fileSpecification", // "fss\0x20"
                                                                     0x61737479: "fileType", // "asty"
                                                                     0x6675726c: "fileURL", // "furl"
                                                                     0x66697864: "fixed", // "fixd"
                                                                     0x66706e74: "fixedPoint", // "fpnt"
                                                                     0x66726374: "fixedRectangle", // "frct"
                                                                     0x666f6375: "focused", // "focu"
                                                                     0x63666f6c: "folder", // "cfol"
                                                                     0x666f6163: "folderAction", // "foac"
                                                                     0x66617366: "FolderActionScriptsFolder", // "fasf"
                                                                     0x6661656e: "folderActionsEnabled", // "faen"
                                                                     0x666f6e74: "fontsFolder", // "font"
                                                                     0x66747473: "fontSmoothing", // "ftts"
                                                                     0x6674736d: "fontSmoothingLimit", // "ftsm"
                                                                     0x66747373: "fontSmoothingStyle", // "ftss"
                                                                     0x64666d74: "format", // "dfmt"
                                                                     0x66727370: "freeSpace", // "frsp"
                                                                     0x66726920: "Friday", // "fri\0x20"
                                                                     0x70697366: "frontmost", // "pisf"
                                                                     0x666e616d: "fullName", // "fnam"
                                                                     0x616e6f74: "fullText", // "anot"
                                                                     0x67656e69: "genie", // "geni"
                                                                     0x47494666: "GIFPicture", // "GIFf"
                                                                     0x676f6c64: "gold", // "gold"
                                                                     0x63677478: "graphicText", // "cgtx"
                                                                     0x67726674: "graphite", // "grft"
                                                                     0x6772656e: "green", // "gren"
                                                                     0x73677270: "group", // "sgrp"
                                                                     0x67726f77: "growArea", // "grow"
                                                                     0x68616c66: "half", // "half"
                                                                     0x68736372: "hasScriptingTerminology", // "hscr"
                                                                     0x68656c70: "help", // "help"
                                                                     0x6869646e: "hidden", // "hidn"
                                                                     0x6869636f: "highlightColor", // "hico"
                                                                     0x68717561: "highQuality", // "hqua"
                                                                     0x64666873: "HighSierraFormat", // "dfhs"
                                                                     0x686f6d65: "homeDirectory", // "home"
                                                                     0x63757372: "homeFolder", // "cusr"
                                                                     0x68726566: "href", // "href"
                                                                     0x68797068: "hyphens", // "hyph"
                                                                     0x49442020: "id", // "ID\0x20\0x20"
                                                                     0x64686967: "ignore", // "dhig"
                                                                     0x69677072: "ignorePrivileges", // "igpr"
                                                                     0x696d6141: "image", // "imaA"
                                                                     0x696e6372: "incrementor", // "incr"
                                                                     0x70696478: "index", // "pidx"
                                                                     0x64686174: "insertionAction", // "dhat"
                                                                     0x64686970: "insertionPreference", // "dhip"
                                                                     0x6c6f6e67: "integer", // "long"
                                                                     0x696e7466: "interface", // "intf"
                                                                     0x69747874: "internationalText", // "itxt"
                                                                     0x696e746c: "internationalWritingCode", // "intl"
                                                                     0x64663936: "ISO9660Format", // "df96"
                                                                     0x636f626a: "item", // "cobj"
                                                                     0x66676574: "itemsAdded", // "fget"
                                                                     0x666c6f73: "itemsRemoved", // "flos"
                                                                     0x6a616e20: "January", // "jan\0x20"
                                                                     0x4a504547: "JPEGPicture", // "JPEG"
                                                                     0x6a756c20: "July", // "jul\0x20"
                                                                     0x746f6872: "jumpToHere", // "tohr"
                                                                     0x6e787067: "jumpToNextPage", // "nxpg"
                                                                     0x6a756e20: "June", // "jun\0x20"
                                                                     0x6b706964: "kernelProcessID", // "kpid"
                                                                     0x6b696e64: "kind", // "kind"
                                                                     0x6c64626c: "largeReal", // "ldbl"
                                                                     0x6c61756e: "launcherItemsFolder", // "laun"
                                                                     0x6c656674: "left", // "left"
                                                                     0x646c6962: "libraryFolder", // "dlib"
                                                                     0x6c697465: "light", // "lite"
                                                                     0x6c697374: "list", // "list"
                                                                     0x6c737464: "listed", // "lstd"
                                                                     0x666c646c: "localDomain", // "fldl"
                                                                     0x646f6d6c: "localDomainObject", // "doml"
                                                                     0x69737276: "localVolume", // "isrv"
                                                                     0x6c6f6361: "location", // "loca"
                                                                     0x696e736c: "locationReference", // "insl"
                                                                     0x6c6f6769: "loginItem", // "logi"
                                                                     0x61636c6b: "logOutWhenInactive", // "aclk"
                                                                     0x6163746f: "logOutWhenInactiveInterval", // "acto"
                                                                     0x6c667864: "longFixed", // "lfxd"
                                                                     0x6c667074: "longFixedPoint", // "lfpt"
                                                                     0x6c667263: "longFixedRectangle", // "lfrc"
                                                                     0x6c706e74: "longPoint", // "lpnt"
                                                                     0x6c726374: "longRectangle", // "lrct"
                                                                     0x6c6f6f70: "looping", // "loop"
                                                                     0x6d616361: "MACAddress", // "maca"
                                                                     0x6d616368: "machine", // "mach"
                                                                     0x6d4c6f63: "machineLocation", // "mLoc"
                                                                     0x706f7274: "machPort", // "port"
                                                                     0x6466682b: "MacOSExtendedFormat", // "dfh+"
                                                                     0x64666866: "MacOSFormat", // "dfhf"
                                                                     0x646d6167: "magnification", // "dmag"
                                                                     0x646d737a: "magnificationSize", // "dmsz"
                                                                     0x6d736372: "mainScreenOnly", // "mscr"
                                                                     0x6d617220: "March", // "mar\0x20"
                                                                     0x6d617856: "maximumValue", // "maxV"
                                                                     0x6d617920: "May", // "may\0x20"
                                                                     0x6d656469: "medium", // "medi"
                                                                     0x6d656e45: "menu", // "menE"
                                                                     0x6d626172: "menuBar", // "mbar"
                                                                     0x6d627269: "menuBarItem", // "mbri"
                                                                     0x6d656e42: "menuButton", // "menB"
                                                                     0x6d656e49: "menuItem", // "menI"
                                                                     0x69736d6e: "miniaturizable", // "ismn"
                                                                     0x706d6e64: "miniaturized", // "pmnd"
                                                                     0x64656666: "minimizeEffect", // "deff"
                                                                     0x6d696e57: "minimumValue", // "minW"
                                                                     0x61736d6f: "modificationDate", // "asmo"
                                                                     0x6d64746d: "modificationTime", // "mdtm"
                                                                     0x696d6f64: "modified", // "imod"
                                                                     0x6d6f6e20: "Monday", // "mon\0x20"
                                                                     0x6d6f7664: "movieData", // "movd"
                                                                     0x6d6f7666: "movieFile", // "movf"
                                                                     0x6d646f63: "moviesFolder", // "mdoc"
                                                                     0x64666d73: "MSDOSFormat", // "dfms"
                                                                     0x6d747520: "mtu", // "mtu\0x20"
                                                                     0x64686d63: "musicCD", // "dhmc"
                                                                     0x25646f63: "musicFolder", // "%doc"
                                                                     0x706e616d: "name", // "pnam"
                                                                     0x6578746e: "nameExtension", // "extn"
                                                                     0x6e64696d: "naturalDimensions", // "ndim"
                                                                     0x666c646e: "networkDomain", // "fldn"
                                                                     0x646f6d6e: "networkDomainObject", // "domn"
                                                                     0x6e657470: "networkPreferences", // "netp"
                                                                     0x6e65746f: "networkPreferencesObject", // "neto"
                                                                     0x64666e66: "NFSFormat", // "dfnf"
                                                                     0x6e6f2020: "no", // "no\0x20\0x20"
                                                                     0x6e6f6e65: "none", // "none"
                                                                     0x6e6f726d: "normal", // "norm"
                                                                     0x6e6f7620: "November", // "nov\0x20"
                                                                     0x6e756c6c: "null", // "null"
                                                                     0x6e756d65: "numericStrings", // "nume"
                                                                     0x6f637420: "October", // "oct\0x20"
                                                                     0x64686170: "openApplication", // "dhap"
                                                                     0x654f7074: "option", // "eOpt"
                                                                     0x6f70746c: "optional_", // "optl"
                                                                     0x4b6f7074: "optionDown", // "Kopt"
                                                                     0x6f726e67: "orange", // "orng"
                                                                     0x6f726965: "orientation", // "orie"
                                                                     0x6f75746c: "outline", // "outl"
                                                                     0x706b6766: "packageFolder", // "pkgf"
                                                                     0x6c776c61: "pagesAcross", // "lwla"
                                                                     0x6c776c64: "pagesDown", // "lwld"
                                                                     0x70757364: "partitionSpaceUsed", // "pusd"
                                                                     0x70707468: "path", // "ppth"
                                                                     0x70687973: "physicalSize", // "phys"
                                                                     0x50494354: "PICTPicture", // "PICT"
                                                                     0x70696350: "picture", // "picP"
                                                                     0x64687063: "pictureCD", // "dhpc"
                                                                     0x70737479: "pictureDisplayStyle", // "psty"
                                                                     0x70696370: "picturePath", // "picp"
                                                                     0x63686e47: "pictureRotation", // "chnG"
                                                                     0x70646f63: "picturesFolder", // "pdoc"
                                                                     0x74706d6d: "pixelMapRecord", // "tpmm"
                                                                     0x706c6e6d: "pluralName", // "plnm"
                                                                     0x51447074: "point", // "QDpt"
                                                                     0x706f7076: "popOver", // "popv"
                                                                     0x706f7042: "popUpButton", // "popB"
                                                                     0x706f736e: "position", // "posn"
                                                                     0x706f7378: "POSIXPath", // "posx"
                                                                     0x70726566: "preferencesFolder", // "pref"
                                                                     0x70726672: "preferredRate", // "prfr"
                                                                     0x70726676: "preferredVolume", // "prfv"
                                                                     0x70726d64: "presentationMode", // "prmd"
                                                                     0x6d76737a: "presentationSize", // "mvsz"
                                                                     0x70767764: "previewDuration", // "pvwd"
                                                                     0x70767774: "previewTime", // "pvwt"
                                                                     0x70736574: "printSettings", // "pset"
                                                                     0x70726373: "process", // "prcs"
                                                                     0x70736e20: "processSerialNumber", // "psn\0x20"
                                                                     0x64667072: "ProDOSFormat", // "dfpr"
                                                                     0x76657232: "productVersion", // "ver2"
                                                                     0x70726f49: "progressIndicator", // "proI"
                                                                     0x70414c4c: "properties", // "pALL"
                                                                     0x70726f70: "property_", // "prop"
                                                                     0x706c6966: "propertyListFile", // "plif"
                                                                     0x706c6969: "propertyListItem", // "plii"
                                                                     0x70756262: "publicFolder", // "pubb"
                                                                     0x70756e63: "punctuation", // "punc"
                                                                     0x7072706c: "purple", // "prpl"
                                                                     0x64667174: "QuickTakeFormat", // "dfqt"
                                                                     0x71746664: "QuickTimeData", // "qtfd"
                                                                     0x71746666: "QuickTimeFile", // "qtff"
                                                                     0x7164656c: "quitDelay", // "qdel"
                                                                     0x72616442: "radioButton", // "radB"
                                                                     0x72677270: "radioGroup", // "rgrp"
                                                                     0x72616e44: "randomOrder", // "ranD"
                                                                     0x72656164: "readOnly", // "read"
                                                                     0x72647772: "readWrite", // "rdwr"
                                                                     0x7261706c: "recentApplicationsLimit", // "rapl"
                                                                     0x7264636c: "recentDocumentsLimit", // "rdcl"
                                                                     0x7273766c: "recentServersLimit", // "rsvl"
                                                                     0x7265636f: "record", // "reco"
                                                                     0x72656420: "red", // "red\0x20"
                                                                     0x6f626a20: "reference", // "obj\0x20"
                                                                     0x72656c69: "relevanceIndicator", // "reli"
                                                                     0x6c777174: "requestedPrintTime", // "lwqt"
                                                                     0x7077756c: "requirePasswordToUnlock", // "pwul"
                                                                     0x7077776b: "requirePasswordToWake", // "pwwk"
                                                                     0x7072737a: "resizable", // "prsz"
                                                                     0x74723136: "RGB16Color", // "tr16"
                                                                     0x74723936: "RGB96Color", // "tr96"
                                                                     0x63524742: "RGBColor", // "cRGB"
                                                                     0x72696768: "right", // "righ"
                                                                     0x726f6c65: "role", // "role"
                                                                     0x726f6c64: "roleDescription", // "rold"
                                                                     0x74726f74: "rotation", // "trot"
                                                                     0x63726f77: "row", // "crow"
                                                                     0x64687273: "runAScript", // "dhrs"
                                                                     0x72756e6e: "running", // "runn"
                                                                     0x73617420: "Saturday", // "sat\0x20"
                                                                     0x7363616c: "scale", // "scal"
                                                                     0x66697473: "screen", // "fits"
                                                                     0x64707365: "screenEdge", // "dpse"
                                                                     0x73737672: "screenSaver", // "ssvr"
                                                                     0x73737670: "screenSaverPreferences", // "ssvp"
                                                                     0x7373766f: "screenSaverPreferencesObject", // "ssvo"
                                                                     0x73637074: "script", // "scpt"
                                                                     0x24736372: "scriptingAdditionsFolder", // "$scr"
                                                                     0x7364636c: "scriptingClass", // "sdcl"
                                                                     0x7364636d: "scriptingCommand", // "sdcm"
                                                                     0x73646566: "scriptingDefinition", // "sdef"
                                                                     0x7364656f: "scriptingDefinitionObject", // "sdeo"
                                                                     0x7364656c: "scriptingElement", // "sdel"
                                                                     0x7364656e: "scriptingEnumeration", // "sden"
                                                                     0x73646572: "scriptingEnumerator", // "sder"
                                                                     0x73647061: "scriptingParameter", // "sdpa"
                                                                     0x73647072: "scriptingProperty", // "sdpr"
                                                                     0x73647273: "scriptingResult", // "sdrs"
                                                                     0x7364726f: "scriptingResultObject", // "sdro"
                                                                     0x73647374: "scriptingSuite", // "sdst"
                                                                     0x73636d6e: "scriptMenuEnabled", // "scmn"
                                                                     0x73637224: "scriptsFolder", // "scr$"
                                                                     0x73637261: "scrollArea", // "scra"
                                                                     0x73637262: "scrollBar", // "scrb"
                                                                     0x73636c62: "scrollBarAction", // "sclb"
                                                                     0x7363766d: "secureVirtualMemory", // "scvm"
                                                                     0x73656370: "securityPreferences", // "secp"
                                                                     0x7365636f: "securityPreferencesObject", // "seco"
                                                                     0x73656c45: "selected", // "selE"
                                                                     0x73657020: "September", // "sep\0x20"
                                                                     0x73727672: "server", // "srvr"
                                                                     0x73766365: "service", // "svce"
                                                                     0x7374626c: "settable", // "stbl"
                                                                     0x73646174: "sharedDocumentsFolder", // "sdat"
                                                                     0x73686545: "sheet", // "sheE"
                                                                     0x65536674: "shift", // "eSft"
                                                                     0x4b736674: "shiftDown", // "Ksft"
                                                                     0x73686f72: "shortInteger", // "shor"
                                                                     0x6366626e: "shortName", // "cfbn"
                                                                     0x61737376: "shortVersion", // "assv"
                                                                     0x7368636c: "showClock", // "shcl"
                                                                     0x73686466: "shutdownFolder", // "shdf"
                                                                     0x736c7672: "silver", // "slvr"
                                                                     0x73697465: "sitesFolder", // "site"
                                                                     0x7074737a: "size", // "ptsz"
                                                                     0x736c6949: "slider", // "sliI"
                                                                     0x706d7373: "slideShow", // "pmss"
                                                                     0x73696e67: "smallReal", // "sing"
                                                                     0x73636c73: "smoothScrolling", // "scls"
                                                                     0x73706b69: "speakableItemsFolder", // "spki"
                                                                     0x73706564: "speed", // "sped"
                                                                     0x73706c72: "splitter", // "splr"
                                                                     0x73706c67: "splitterGroup", // "splg"
                                                                     0x73746e64: "standard", // "stnd"
                                                                     0x6c777374: "standard", // "lwst"
                                                                     0x6c776670: "startingPage", // "lwfp"
                                                                     0x6f666673: "startTime", // "offs"
                                                                     0x69737464: "startup", // "istd"
                                                                     0x7364736b: "startupDisk", // "sdsk"
                                                                     0x656d707a: "startupItemsFolder", // "empz"
                                                                     0x73747478: "staticText", // "sttx"
                                                                     0x70737064: "stationery", // "pspd"
                                                                     0x69737373: "storedStream", // "isss"
                                                                     0x54455854: "string", // "TEXT"
                                                                     0x73747267: "strong", // "strg"
                                                                     0x7374796c: "styledClipboardText", // "styl"
                                                                     0x53545854: "styledText", // "STXT"
                                                                     0x7362726c: "subrole", // "sbrl"
                                                                     0x73746e6d: "suiteName", // "stnm"
                                                                     0x73756e20: "Sunday", // "sun\0x20"
                                                                     0x73757065: "superclass", // "supe"
                                                                     0x666c6473: "systemDomain", // "flds"
                                                                     0x646f6d73: "systemDomainObject", // "doms"
                                                                     0x6d616373: "systemFolder", // "macs"
                                                                     0x74616267: "tabGroup", // "tabg"
                                                                     0x74616242: "table", // "tabB"
                                                                     0x74727072: "targetPrinter", // "trpr"
                                                                     0x74656d70: "temporaryItemsFolder", // "temp"
                                                                     0x63747874: "text", // "ctxt"
                                                                     0x74787461: "textArea", // "txta"
                                                                     0x74787466: "textField", // "txtf"
                                                                     0x74737479: "textStyleInfo", // "tsty"
                                                                     0x74687520: "Thursday", // "thu\0x20"
                                                                     0x54494646: "TIFFPicture", // "TIFF"
                                                                     0x746d7363: "timeScale", // "tmsc"
                                                                     0x7469746c: "title", // "titl"
                                                                     0x74626172: "toolbar", // "tbar"
                                                                     0x61707074: "totalPartitionSize", // "appt"
                                                                     0x7472616b: "track", // "trak"
                                                                     0x6d6e5472: "translucentMenuBar", // "mnTr"
                                                                     0x74727368: "trash", // "trsh"
                                                                     0x74756520: "Tuesday", // "tue\0x20"
                                                                     0x70747970: "type", // "ptyp"
                                                                     0x74797065: "typeClass", // "type"
                                                                     0x75746964: "typeIdentifier", // "utid"
                                                                     0x64667564: "UDFFormat", // "dfud"
                                                                     0x64667566: "UFSFormat", // "dfuf"
                                                                     0x7569656c: "UIElement", // "uiel"
                                                                     0x7569656e: "UIElementsEnabled", // "uien"
                                                                     0x75747874: "UnicodeText", // "utxt"
                                                                     0x69647578: "unixId", // "idux"
                                                                     0x64662424: "unknownFormat", // "df$$"
                                                                     0x75636f6d: "unsignedDoubleInteger", // "ucom"
                                                                     0x6d61676e: "unsignedInteger", // "magn"
                                                                     0x75736872: "unsignedShortInteger", // "ushr"
                                                                     0x75726c20: "URL", // "url\0x20"
                                                                     0x75616363: "user", // "uacc"
                                                                     0x666c6475: "userDomain", // "fldu"
                                                                     0x646f6d75: "userDomainObject", // "domu"
                                                                     0x75743136: "UTF16Text", // "ut16"
                                                                     0x75746638: "UTF8Text", // "utf8"
                                                                     0x75746924: "utilitiesFolder", // "uti$"
                                                                     0x76616c4c: "value", // "valL"
                                                                     0x76616c69: "valueIndicator", // "vali"
                                                                     0x76657273: "version", // "vers"
                                                                     0x64687662: "videoBD", // "dhvb"
                                                                     0x76636470: "videoDepth", // "vcdp"
                                                                     0x64687664: "videoDVD", // "dhvd"
                                                                     0x70766973: "visible", // "pvis"
                                                                     0x76697375: "visualCharacteristic", // "visu"
                                                                     0x766f6c75: "volume", // "volu"
                                                                     0x64667764: "WebDAVFormat", // "dfwd"
                                                                     0x77656420: "Wednesday", // "wed\0x20"
                                                                     0x77686974: "whitespace", // "whit"
                                                                     0x6377696e: "window", // "cwin"
                                                                     0x66636c6f: "windowClosed", // "fclo"
                                                                     0x6673697a: "windowMoved", // "fsiz"
                                                                     0x666f706e: "windowOpened", // "fopn"
                                                                     0x666c6f77: "workflowsFolder", // "flow"
                                                                     0x77726974: "writeOnly", // "writ"
                                                                     0x70736374: "writingCode", // "psct"
                                                                     0x786d6c61: "XMLAttribute", // "xmla"
                                                                     0x786d6c64: "XMLData", // "xmld"
                                                                     0x786d6c65: "XMLElement", // "xmle"
                                                                     0x786d6c66: "XMLFile", // "xmlf"
                                                                     0x79657320: "yes", // "yes\0x20"
                                                                     0x7a6f6e65: "zone", // "zone"
                                                                     0x69737a6d: "zoomable", // "iszm"
                                                                     0x707a756d: "zoomed", // "pzum"
                                                     ],
                                                     propertyNames: [
                                                                     0x69736162: "acceptsHighLevelEvents", // "isab"
                                                                     0x72657674: "acceptsRemoteEvents", // "revt"
                                                                     0x61636373: "access", // "accs"
                                                                     0x61786473: "accessibilityDescription", // "axds"
                                                                     0x75736572: "accountName", // "user"
                                                                     0x61637469: "active", // "acti"
                                                                     0x64616e69: "animate", // "dani"
                                                                     0x61707065: "appearance", // "appe"
                                                                     0x61707270: "appearancePreferences", // "aprp"
                                                                     0x616d6e75: "appleMenuFolder", // "amnu"
                                                                     0x61707066: "applicationFile", // "appf"
                                                                     0x61707073: "applicationsFolder", // "apps"
                                                                     0x61737570: "applicationSupportFolder", // "asup"
                                                                     0x61726368: "architecture", // "arch"
                                                                     0x61636861: "audioChannelCount", // "acha"
                                                                     0x61756469: "audioCharacteristic", // "audi"
                                                                     0x61737261: "audioSampleRate", // "asra"
                                                                     0x6173737a: "audioSampleSize", // "assz"
                                                                     0x64616864: "autohide", // "dahd"
                                                                     0x6175746f: "automatic", // "auto"
                                                                     0x61756c67: "automaticLogin", // "aulg"
                                                                     0x61757470: "autoPlay", // "autp"
                                                                     0x61707265: "autoPresent", // "apre"
                                                                     0x61717569: "autoQuitWhenDone", // "aqui"
                                                                     0x626b676f: "backgroundOnly", // "bkgo"
                                                                     0x64686262: "blankBD", // "dhbb"
                                                                     0x64686263: "blankCD", // "dhbc"
                                                                     0x64686264: "blankDVD", // "dhbd"
                                                                     0x70626e64: "bounds", // "pbnd"
                                                                     0x626e6964: "bundleIdentifier", // "bnid"
                                                                     0x62757379: "busyStatus", // "busy"
                                                                     0x63617061: "capacity", // "capa"
                                                                     0x64686173: "CDAndDVDPreferences", // "dhas"
                                                                     0x63696e54: "changeInterval", // "cinT"
                                                                     0x70636c73: "class_", // "pcls"
                                                                     0x636c7363: "Classic", // "clsc"
                                                                     0x666c6463: "ClassicDomain", // "fldc"
                                                                     0x68636c62: "closeable", // "hclb"
                                                                     0x6c77636c: "collating", // "lwcl"
                                                                     0x636f6e6e: "connected", // "conn"
                                                                     0x63746e72: "container", // "ctnr"
                                                                     0x6374726c: "controlPanelsFolder", // "ctrl"
                                                                     0x73646576: "controlStripModulesFolder", // "sdev"
                                                                     0x6c776370: "copies", // "lwcp"
                                                                     0x61736364: "creationDate", // "ascd"
                                                                     0x6d646372: "creationTime", // "mdcr"
                                                                     0x66637274: "creatorType", // "fcrt"
                                                                     0x636e6667: "currentConfiguration", // "cnfg"
                                                                     0x63757264: "currentDesktop", // "curd"
                                                                     0x6c6f6363: "currentLocation", // "locc"
                                                                     0x73737663: "currentScreenSaver", // "ssvc"
                                                                     0x63757275: "currentUser", // "curu"
                                                                     0x64686361: "customApplication", // "dhca"
                                                                     0x64686373: "customScript", // "dhcs"
                                                                     0x74686d65: "darkMode", // "thme"
                                                                     0x74646672: "dataFormat", // "tdfr"
                                                                     0x64647261: "dataRate", // "ddra"
                                                                     0x6473697a: "dataSize", // "dsiz"
                                                                     0x61736461: "defaultApplication", // "asda"
                                                                     0x646c7969: "delayInterval", // "dlyi"
                                                                     0x64657363: "description_", // "desc"
                                                                     0x64616669: "deskAccessoryFile", // "dafi"
                                                                     0x6465736b: "desktopFolder", // "desk"
                                                                     0x64747024: "desktopPicturesFolder", // "dtp$"
                                                                     0x7064696d: "dimensions", // "pdim"
                                                                     0x73646470: "directParameter", // "sddp"
                                                                     0x646e616d: "displayedName", // "dnam"
                                                                     0x646e614d: "displayName", // "dnaM"
                                                                     0x64706173: "dockPreferences", // "dpas"
                                                                     0x64737a65: "dockSize", // "dsze"
                                                                     0x646f6375: "document", // "docu"
                                                                     0x646f6373: "documentsFolder", // "docs"
                                                                     0x646f776e: "downloadsFolder", // "down"
                                                                     0x6475706c: "duplex", // "dupl"
                                                                     0x6475726e: "duration", // "durn"
                                                                     0x6973656a: "ejectable", // "isej"
                                                                     0x656e6142: "enabled", // "enaB"
                                                                     0x6c776c70: "endingPage", // "lwlp"
                                                                     0x65637473: "entireContents", // "ects"
                                                                     0x656e6d64: "enumerated", // "enmd"
                                                                     0x6c776568: "errorHandling", // "lweh"
                                                                     0x6578747a: "extensionsFolder", // "extz"
                                                                     0x66617673: "favoritesFolder", // "favs"
                                                                     0x6661786e: "faxNumber", // "faxn"
                                                                     0x66696c65: "file", // "file"
                                                                     0x61737479: "fileType", // "asty"
                                                                     0x666f6375: "focused", // "focu"
                                                                     0x66617366: "FolderActionScriptsFolder", // "fasf"
                                                                     0x6661656e: "folderActionsEnabled", // "faen"
                                                                     0x666f6e74: "fontsFolder", // "font"
                                                                     0x66747473: "fontSmoothing", // "ftts"
                                                                     0x6674736d: "fontSmoothingLimit", // "ftsm"
                                                                     0x66747373: "fontSmoothingStyle", // "ftss"
                                                                     0x64666d74: "format", // "dfmt"
                                                                     0x66727370: "freeSpace", // "frsp"
                                                                     0x70697366: "frontmost", // "pisf"
                                                                     0x666e616d: "fullName", // "fnam"
                                                                     0x616e6f74: "fullText", // "anot"
                                                                     0x68736372: "hasScriptingTerminology", // "hscr"
                                                                     0x68656c70: "help", // "help"
                                                                     0x6869646e: "hidden", // "hidn"
                                                                     0x6869636f: "highlightColor", // "hico"
                                                                     0x68717561: "highQuality", // "hqua"
                                                                     0x686f6d65: "homeDirectory", // "home"
                                                                     0x63757372: "homeFolder", // "cusr"
                                                                     0x68726566: "href", // "href"
                                                                     0x49442020: "id", // "ID\0x20\0x20"
                                                                     0x69677072: "ignorePrivileges", // "igpr"
                                                                     0x70696478: "index", // "pidx"
                                                                     0x64686174: "insertionAction", // "dhat"
                                                                     0x696e7466: "interface", // "intf"
                                                                     0x6b696e64: "kind", // "kind"
                                                                     0x6c61756e: "launcherItemsFolder", // "laun"
                                                                     0x646c6962: "libraryFolder", // "dlib"
                                                                     0x6c737464: "listed", // "lstd"
                                                                     0x666c646c: "localDomain", // "fldl"
                                                                     0x69737276: "localVolume", // "isrv"
                                                                     0x61636c6b: "logOutWhenInactive", // "aclk"
                                                                     0x6163746f: "logOutWhenInactiveInterval", // "acto"
                                                                     0x6c6f6f70: "looping", // "loop"
                                                                     0x6d616361: "MACAddress", // "maca"
                                                                     0x646d6167: "magnification", // "dmag"
                                                                     0x646d737a: "magnificationSize", // "dmsz"
                                                                     0x6d736372: "mainScreenOnly", // "mscr"
                                                                     0x6d617856: "maximumValue", // "maxV"
                                                                     0x69736d6e: "miniaturizable", // "ismn"
                                                                     0x706d6e64: "miniaturized", // "pmnd"
                                                                     0x64656666: "minimizeEffect", // "deff"
                                                                     0x6d696e57: "minimumValue", // "minW"
                                                                     0x61736d6f: "modificationDate", // "asmo"
                                                                     0x6d64746d: "modificationTime", // "mdtm"
                                                                     0x696d6f64: "modified", // "imod"
                                                                     0x6d646f63: "moviesFolder", // "mdoc"
                                                                     0x6d747520: "mtu", // "mtu\0x20"
                                                                     0x64686d63: "musicCD", // "dhmc"
                                                                     0x25646f63: "musicFolder", // "%doc"
                                                                     0x706e616d: "name", // "pnam"
                                                                     0x6578746e: "nameExtension", // "extn"
                                                                     0x6e64696d: "naturalDimensions", // "ndim"
                                                                     0x666c646e: "networkDomain", // "fldn"
                                                                     0x6e657470: "networkPreferences", // "netp"
                                                                     0x6f70746c: "optional_", // "optl"
                                                                     0x6f726965: "orientation", // "orie"
                                                                     0x706b6766: "packageFolder", // "pkgf"
                                                                     0x6c776c61: "pagesAcross", // "lwla"
                                                                     0x6c776c64: "pagesDown", // "lwld"
                                                                     0x70757364: "partitionSpaceUsed", // "pusd"
                                                                     0x70707468: "path", // "ppth"
                                                                     0x70687973: "physicalSize", // "phys"
                                                                     0x70696350: "picture", // "picP"
                                                                     0x64687063: "pictureCD", // "dhpc"
                                                                     0x70737479: "pictureDisplayStyle", // "psty"
                                                                     0x70696370: "picturePath", // "picp"
                                                                     0x63686e47: "pictureRotation", // "chnG"
                                                                     0x70646f63: "picturesFolder", // "pdoc"
                                                                     0x706c6e6d: "pluralName", // "plnm"
                                                                     0x706f736e: "position", // "posn"
                                                                     0x706f7378: "POSIXPath", // "posx"
                                                                     0x70726566: "preferencesFolder", // "pref"
                                                                     0x70726672: "preferredRate", // "prfr"
                                                                     0x70726676: "preferredVolume", // "prfv"
                                                                     0x70726d64: "presentationMode", // "prmd"
                                                                     0x6d76737a: "presentationSize", // "mvsz"
                                                                     0x70767764: "previewDuration", // "pvwd"
                                                                     0x70767774: "previewTime", // "pvwt"
                                                                     0x76657232: "productVersion", // "ver2"
                                                                     0x70414c4c: "properties", // "pALL"
                                                                     0x70756262: "publicFolder", // "pubb"
                                                                     0x7164656c: "quitDelay", // "qdel"
                                                                     0x72616e44: "randomOrder", // "ranD"
                                                                     0x7261706c: "recentApplicationsLimit", // "rapl"
                                                                     0x7264636c: "recentDocumentsLimit", // "rdcl"
                                                                     0x7273766c: "recentServersLimit", // "rsvl"
                                                                     0x6c777174: "requestedPrintTime", // "lwqt"
                                                                     0x7077756c: "requirePasswordToUnlock", // "pwul"
                                                                     0x7077776b: "requirePasswordToWake", // "pwwk"
                                                                     0x7072737a: "resizable", // "prsz"
                                                                     0x726f6c65: "role", // "role"
                                                                     0x726f6c64: "roleDescription", // "rold"
                                                                     0x72756e6e: "running", // "runn"
                                                                     0x64707365: "screenEdge", // "dpse"
                                                                     0x73737670: "screenSaverPreferences", // "ssvp"
                                                                     0x24736372: "scriptingAdditionsFolder", // "$scr"
                                                                     0x73646566: "scriptingDefinition", // "sdef"
                                                                     0x73647273: "scriptingResult", // "sdrs"
                                                                     0x73636d6e: "scriptMenuEnabled", // "scmn"
                                                                     0x73637224: "scriptsFolder", // "scr$"
                                                                     0x73636c62: "scrollBarAction", // "sclb"
                                                                     0x7363766d: "secureVirtualMemory", // "scvm"
                                                                     0x73656370: "securityPreferences", // "secp"
                                                                     0x73656c45: "selected", // "selE"
                                                                     0x73727672: "server", // "srvr"
                                                                     0x7374626c: "settable", // "stbl"
                                                                     0x73646174: "sharedDocumentsFolder", // "sdat"
                                                                     0x6366626e: "shortName", // "cfbn"
                                                                     0x61737376: "shortVersion", // "assv"
                                                                     0x7368636c: "showClock", // "shcl"
                                                                     0x73686466: "shutdownFolder", // "shdf"
                                                                     0x73697465: "sitesFolder", // "site"
                                                                     0x7074737a: "size", // "ptsz"
                                                                     0x73636c73: "smoothScrolling", // "scls"
                                                                     0x73706b69: "speakableItemsFolder", // "spki"
                                                                     0x73706564: "speed", // "sped"
                                                                     0x6c776670: "startingPage", // "lwfp"
                                                                     0x6f666673: "startTime", // "offs"
                                                                     0x69737464: "startup", // "istd"
                                                                     0x7364736b: "startupDisk", // "sdsk"
                                                                     0x656d707a: "startupItemsFolder", // "empz"
                                                                     0x70737064: "stationery", // "pspd"
                                                                     0x69737373: "storedStream", // "isss"
                                                                     0x7362726c: "subrole", // "sbrl"
                                                                     0x73746e6d: "suiteName", // "stnm"
                                                                     0x73757065: "superclass", // "supe"
                                                                     0x666c6473: "systemDomain", // "flds"
                                                                     0x6d616373: "systemFolder", // "macs"
                                                                     0x74727072: "targetPrinter", // "trpr"
                                                                     0x74656d70: "temporaryItemsFolder", // "temp"
                                                                     0x63747874: "text", // "ctxt"
                                                                     0x746d7363: "timeScale", // "tmsc"
                                                                     0x7469746c: "title", // "titl"
                                                                     0x61707074: "totalPartitionSize", // "appt"
                                                                     0x6d6e5472: "translucentMenuBar", // "mnTr"
                                                                     0x74727368: "trash", // "trsh"
                                                                     0x70747970: "type", // "ptyp"
                                                                     0x74797065: "typeClass", // "type"
                                                                     0x75746964: "typeIdentifier", // "utid"
                                                                     0x7569656e: "UIElementsEnabled", // "uien"
                                                                     0x69647578: "unixId", // "idux"
                                                                     0x75726c20: "URL", // "url\0x20"
                                                                     0x666c6475: "userDomain", // "fldu"
                                                                     0x75746924: "utilitiesFolder", // "uti$"
                                                                     0x76616c4c: "value", // "valL"
                                                                     0x76657273: "version", // "vers"
                                                                     0x64687662: "videoBD", // "dhvb"
                                                                     0x76636470: "videoDepth", // "vcdp"
                                                                     0x64687664: "videoDVD", // "dhvd"
                                                                     0x70766973: "visible", // "pvis"
                                                                     0x76697375: "visualCharacteristic", // "visu"
                                                                     0x766f6c75: "volume", // "volu"
                                                                     0x666c6f77: "workflowsFolder", // "flow"
                                                                     0x7a6f6e65: "zone", // "zone"
                                                                     0x69737a6d: "zoomable", // "iszm"
                                                                     0x707a756d: "zoomed", // "pzum"
                                                     ],
                                                     elementsNames: [
                                                                     0x61637454: ("action", "actions"), // "actT"
                                                                     0x616c6973: ("alias", "aliases"), // "alis"
                                                                     0x616e6e6f: ("annotation", "annotations"), // "anno"
                                                                     0x6170726f: ("appearance preferences object", "appearancePreferencesObjects"), // "apro"
                                                                     0x70636170: ("application process", "applicationProcesses"), // "pcap"
                                                                     0x63617070: ("application", "applications"), // "capp"
                                                                     0x61747472: ("attribute", "attributes"), // "attr"
                                                                     0x61756464: ("audio data", "audioDatas"), // "audd"
                                                                     0x61756466: ("audio file", "audioFiles"), // "audf"
                                                                     0x62726f57: ("browser", "browsers"), // "broW"
                                                                     0x62757369: ("busy indicator", "busyIndicators"), // "busi"
                                                                     0x62757454: ("button", "buttons"), // "butT"
                                                                     0x6468616f: ("CD and DVD preferences object", "CDAndDVDPreferencesObjects"), // "dhao"
                                                                     0x63686278: ("checkbox", "checkboxes"), // "chbx"
                                                                     0x646f6d63: ("Classic domain object", "ClassicDomainObjects"), // "domc"
                                                                     0x636f6c57: ("color well", "colorWells"), // "colW"
                                                                     0x63636f6c: ("column", "columns"), // "ccol"
                                                                     0x636f6d42: ("combo box", "comboBoxes"), // "comB"
                                                                     0x636f6e46: ("configuration", "configurations"), // "conF"
                                                                     0x72646174: ("data", "datas"), // "rdat"
                                                                     0x70636461: ("desk accessory process", "deskAccessoryProcesses"), // "pcda"
                                                                     0x64736b70: ("desktop", "desktops"), // "dskp"
                                                                     0x6469746d: ("disk item", "diskItems"), // "ditm"
                                                                     0x63646973: ("disk", "disks"), // "cdis"
                                                                     0x6470616f: ("dock preferences object", "dockPreferencesObjects"), // "dpao"
                                                                     0x646f6375: ("document", "documents"), // "docu"
                                                                     0x646f6d61: ("domain", "domains"), // "doma"
                                                                     0x64726141: ("drawer", "drawers"), // "draA"
                                                                     0x63706b67: ("file package", "filePackages"), // "cpkg"
                                                                     0x66696c65: ("file", "files"), // "file"
                                                                     0x666f6163: ("folder action", "folderActions"), // "foac"
                                                                     0x63666f6c: ("folder", "folders"), // "cfol"
                                                                     0x73677270: ("group", "groups"), // "sgrp"
                                                                     0x67726f77: ("grow area", "growAreas"), // "grow"
                                                                     0x696d6141: ("image", "images"), // "imaA"
                                                                     0x696e6372: ("incrementor", "incrementors"), // "incr"
                                                                     0x64686970: ("insertion preference", "insertionPreferences"), // "dhip"
                                                                     0x696e7466: ("interface", "interfaces"), // "intf"
                                                                     0x636f626a: ("item", "items"), // "cobj"
                                                                     0x6c697374: ("list", "lists"), // "list"
                                                                     0x646f6d6c: ("local domain object", "localDomainObjects"), // "doml"
                                                                     0x6c6f6361: ("location", "locations"), // "loca"
                                                                     0x6c6f6769: ("login item", "loginItems"), // "logi"
                                                                     0x6d627269: ("menu bar item", "menuBarItems"), // "mbri"
                                                                     0x6d626172: ("menu bar", "menuBars"), // "mbar"
                                                                     0x6d656e42: ("menu button", "menuButtons"), // "menB"
                                                                     0x6d656e49: ("menu item", "menuItems"), // "menI"
                                                                     0x6d656e45: ("menu", "menus"), // "menE"
                                                                     0x6d6f7664: ("movie data", "movieDatas"), // "movd"
                                                                     0x6d6f7666: ("movie file", "movieFiles"), // "movf"
                                                                     0x646f6d6e: ("network domain object", "networkDomainObjects"), // "domn"
                                                                     0x6e65746f: ("network preferences object", "networkPreferencesObjects"), // "neto"
                                                                     0x6f75746c: ("outline", "outlines"), // "outl"
                                                                     0x706f7076: ("pop over", "popOvers"), // "popv"
                                                                     0x706f7042: ("pop up button", "popUpButtons"), // "popB"
                                                                     0x70736574: ("print settings", "printSettings"), // "pset"
                                                                     0x70726373: ("process", "processes"), // "prcs"
                                                                     0x70726f49: ("progress indicator", "progressIndicators"), // "proI"
                                                                     0x706c6966: ("property list file", "propertyListFiles"), // "plif"
                                                                     0x706c6969: ("property list item", "propertyListItems"), // "plii"
                                                                     0x71746664: ("QuickTime data", "QuickTimeDatas"), // "qtfd"
                                                                     0x71746666: ("QuickTime file", "QuickTimeFiles"), // "qtff"
                                                                     0x72616442: ("radio button", "radioButtons"), // "radB"
                                                                     0x72677270: ("radio group", "radioGroups"), // "rgrp"
                                                                     0x72656c69: ("relevance indicator", "relevanceIndicators"), // "reli"
                                                                     0x63726f77: ("row", "rows"), // "crow"
                                                                     0x7373766f: ("screen saver preferences object", "screenSaverPreferencesObjects"), // "ssvo"
                                                                     0x73737672: ("screen saver", "screenSavers"), // "ssvr"
                                                                     0x7364636c: ("scripting class", "scriptingClasses"), // "sdcl"
                                                                     0x7364636d: ("scripting command", "scriptingCommands"), // "sdcm"
                                                                     0x7364656f: ("scripting definition object", "scriptingDefinitionObjects"), // "sdeo"
                                                                     0x7364656c: ("scripting element", "scriptingElements"), // "sdel"
                                                                     0x7364656e: ("scripting enumeration", "scriptingEnumerations"), // "sden"
                                                                     0x73646572: ("scripting enumerator", "scriptingEnumerators"), // "sder"
                                                                     0x73647061: ("scripting parameter", "scriptingParameters"), // "sdpa"
                                                                     0x73647072: ("scripting property", "scriptingProperties"), // "sdpr"
                                                                     0x7364726f: ("scripting result object", "scriptingResultObjects"), // "sdro"
                                                                     0x73647374: ("scripting suite", "scriptingSuites"), // "sdst"
                                                                     0x73637074: ("script", "scripts"), // "scpt"
                                                                     0x73637261: ("scroll area", "scrollAreas"), // "scra"
                                                                     0x73637262: ("scroll bar", "scrollBars"), // "scrb"
                                                                     0x7365636f: ("security preferences object", "securityPreferencesObjects"), // "seco"
                                                                     0x73766365: ("service", "services"), // "svce"
                                                                     0x73686545: ("sheet", "sheets"), // "sheE"
                                                                     0x736c6949: ("slider", "sliders"), // "sliI"
                                                                     0x73706c67: ("splitter group", "splitterGroups"), // "splg"
                                                                     0x73706c72: ("splitter", "splitters"), // "splr"
                                                                     0x73747478: ("static text", "staticTexts"), // "sttx"
                                                                     0x646f6d73: ("system domain object", "systemDomainObjects"), // "doms"
                                                                     0x74616267: ("tab group", "tabGroups"), // "tabg"
                                                                     0x74616242: ("table", "tables"), // "tabB"
                                                                     0x74787461: ("text area", "textAreas"), // "txta"
                                                                     0x74787466: ("text field", "textFields"), // "txtf"
                                                                     0x74626172: ("toolbar", "toolbars"), // "tbar"
                                                                     0x7472616b: ("track", "tracks"), // "trak"
                                                                     0x7569656c: ("UI element", "UIElements"), // "uiel"
                                                                     0x646f6d75: ("user domain object", "userDomainObjects"), // "domu"
                                                                     0x75616363: ("user", "users"), // "uacc"
                                                                     0x76616c69: ("value indicator", "valueIndicators"), // "vali"
                                                                     0x6377696e: ("window", "windows"), // "cwin"
                                                                     0x786d6c61: ("XML attribute", "XMLAttributes"), // "xmla"
                                                                     0x786d6c64: ("XML data", "XMLDatas"), // "xmld"
                                                                     0x786d6c65: ("XML element", "XMLElements"), // "xmle"
                                                                     0x786d6c66: ("XML file", "XMLFiles"), // "xmlf"
                                                     ])

private let _glueClasses = SwiftAutomation.GlueClasses(insertionSpecifierType: SEVInsertion.self,
                                       objectSpecifierType: SEVItem.self,
                                       multiObjectSpecifierType: SEVItems.self,
                                       rootSpecifierType: SEVRoot.self,
                                       applicationType: SystemEvents.self,
                                       symbolType: SEVSymbol.self,
                                       formatter: _specifierFormatter)

private let _untargetedAppData = SwiftAutomation.AppData(glueClasses: _glueClasses)


/******************************************************************************/
// Symbol subclass defines static type/enum/property constants based on System Events.app terminology

public class SEVSymbol: SwiftAutomation.Symbol {

    override public var typeAliasName: String {return "SEV"}

    public override class func symbol(code: OSType, type: OSType = typeType, descriptor: NSAppleEventDescriptor? = nil) -> SEVSymbol {
        switch (code) {
        case 0x69736162: return self.acceptsHighLevelEvents // "isab"
        case 0x72657674: return self.acceptsRemoteEvents // "revt"
        case 0x61636373: return self.access // "accs"
        case 0x61786473: return self.accessibilityDescription // "axds"
        case 0x75736572: return self.accountName // "user"
        case 0x61637454: return self.action // "actT"
        case 0x61637469: return self.active // "acti"
        case 0x616c6973: return self.alias // "alis"
        case 0x64616e69: return self.animate // "dani"
        case 0x616e6e6f: return self.annotation // "anno"
        case 0x2a2a2a2a: return self.anything // "****"
        case 0x61707065: return self.appearance // "appe"
        case 0x61707270: return self.appearancePreferences // "aprp"
        case 0x6170726f: return self.appearancePreferencesObject // "apro"
        case 0x616d6e75: return self.appleMenuFolder // "amnu"
        case 0x64667068: return self.ApplePhotoFormat // "dfph"
        case 0x64666173: return self.AppleShareFormat // "dfas"
        case 0x63617070: return self.application // "capp"
        case 0x62756e64: return self.applicationBundleID // "bund"
        case 0x61707066: return self.applicationFile // "appf"
        case 0x70636170: return self.applicationProcess // "pcap"
        case 0x61707073: return self.applicationsFolder // "apps"
        case 0x7369676e: return self.applicationSignature // "sign"
        case 0x61737570: return self.applicationSupportFolder // "asup"
        case 0x6170726c: return self.applicationURL // "aprl"
        case 0x61707220: return self.April // "apr\0x20"
        case 0x61726368: return self.architecture // "arch"
        case 0x61736b20: return self.ask // "ask\0x20"
        case 0x64686173: return self.askWhatToDo // "dhas"
        case 0x61747472: return self.attribute // "attr"
        case 0x61636861: return self.audioChannelCount // "acha"
        case 0x61756469: return self.audioCharacteristic // "audi"
        case 0x61756464: return self.audioData // "audd"
        case 0x61756466: return self.audioFile // "audf"
        case 0x64666175: return self.audioFormat // "dfau"
        case 0x61737261: return self.audioSampleRate // "asra"
        case 0x6173737a: return self.audioSampleSize // "assz"
        case 0x61756720: return self.August // "aug\0x20"
        case 0x64616864: return self.autohide // "dahd"
        case 0x6175746d: return self.automatic // "autm"
        case 0x6175746f: return self.automatic // "auto"
        case 0x61756c67: return self.automaticLogin // "aulg"
        case 0x61757470: return self.autoPlay // "autp"
        case 0x61707265: return self.autoPresent // "apre"
        case 0x61717569: return self.autoQuitWhenDone // "aqui"
        case 0x626b676f: return self.backgroundOnly // "bkgo"
        case 0x62657374: return self.best // "best"
        case 0x64686262: return self.blankBD // "dhbb"
        case 0x64686263: return self.blankCD // "dhbc"
        case 0x64686264: return self.blankDVD // "dhbd"
        case 0x626c7565: return self.blue // "blue"
        case 0x626d726b: return self.bookmarkData // "bmrk"
        case 0x626f6f6c: return self.boolean // "bool"
        case 0x626f7474: return self.bottom // "bott"
        case 0x71647274: return self.boundingRectangle // "qdrt"
        case 0x70626e64: return self.bounds // "pbnd"
        case 0x62726f57: return self.browser // "broW"
        case 0x626e6964: return self.bundleIdentifier // "bnid"
        case 0x62757369: return self.busyIndicator // "busi"
        case 0x62757379: return self.busyStatus // "busy"
        case 0x62757454: return self.button // "butT"
        case 0x63617061: return self.capacity // "capa"
        case 0x63617365: return self.case_ // "case"
        case 0x6468616f: return self.CDAndDVDPreferencesObject // "dhao"
        case 0x63696e54: return self.changeInterval // "cinT"
        case 0x63686278: return self.checkbox // "chbx"
        case 0x70636c73: return self.class_ // "pcls"
        case 0x636c7363: return self.Classic // "clsc"
        case 0x666c6463: return self.ClassicDomain // "fldc"
        case 0x646f6d63: return self.ClassicDomainObject // "domc"
        case 0x68636c62: return self.closeable // "hclb"
        case 0x6c77636c: return self.collating // "lwcl"
        case 0x636f6c72: return self.color // "colr"
        case 0x636c7274: return self.colorTable // "clrt"
        case 0x636f6c57: return self.colorWell // "colW"
        case 0x63636f6c: return self.column // "ccol"
        case 0x636f6d42: return self.comboBox // "comB"
        case 0x65436d64: return self.command // "eCmd"
        case 0x4b636d64: return self.commandDown // "Kcmd"
        case 0x636f6e46: return self.configuration // "conF"
        case 0x636f6e6e: return self.connected // "conn"
        case 0x656e756d: return self.constant // "enum"
        case 0x63746e72: return self.container // "ctnr"
        case 0x65436e74: return self.control // "eCnt"
        case 0x4b63746c: return self.controlDown // "Kctl"
        case 0x6374726c: return self.controlPanelsFolder // "ctrl"
        case 0x73646576: return self.controlStripModulesFolder // "sdev"
        case 0x6c776370: return self.copies // "lwcp"
        case 0x61736364: return self.creationDate // "ascd"
        case 0x6d646372: return self.creationTime // "mdcr"
        case 0x66637274: return self.creatorType // "fcrt"
        case 0x63757374: return self.current // "cust"
        case 0x636e6667: return self.currentConfiguration // "cnfg"
        case 0x63757264: return self.currentDesktop // "curd"
        case 0x6c6f6363: return self.currentLocation // "locc"
        case 0x73737663: return self.currentScreenSaver // "ssvc"
        case 0x63757275: return self.currentUser // "curu"
        case 0x64686361: return self.customApplication // "dhca"
        case 0x64686373: return self.customScript // "dhcs"
        case 0x74686d65: return self.darkMode // "thme"
        case 0x74646173: return self.dashStyle // "tdas"
        case 0x74647461: return self.data // "tdta"
        case 0x72646174: return self.data_ // "rdat"
        case 0x74646672: return self.dataFormat // "tdfr"
        case 0x64647261: return self.dataRate // "ddra"
        case 0x6473697a: return self.dataSize // "dsiz"
        case 0x6c647420: return self.date // "ldt\0x20"
        case 0x64656320: return self.December // "dec\0x20"
        case 0x6465636d: return self.decimalStruct // "decm"
        case 0x61736461: return self.defaultApplication // "asda"
        case 0x646c7969: return self.delayInterval // "dlyi"
        case 0x64657363: return self.description_ // "desc"
        case 0x64616669: return self.deskAccessoryFile // "dafi"
        case 0x70636461: return self.deskAccessoryProcess // "pcda"
        case 0x64736b70: return self.desktop // "dskp"
        case 0x6465736b: return self.desktopFolder // "desk"
        case 0x64747024: return self.desktopPicturesFolder // "dtp$"
        case 0x6c776474: return self.detailed // "lwdt"
        case 0x64696163: return self.diacriticals // "diac"
        case 0x7064696d: return self.dimensions // "pdim"
        case 0x73646470: return self.directParameter // "sddp"
        case 0x63646973: return self.disk // "cdis"
        case 0x6469746d: return self.diskItem // "ditm"
        case 0x646e616d: return self.displayedName // "dnam"
        case 0x646e614d: return self.displayName // "dnaM"
        case 0x64706173: return self.dockPreferences // "dpas"
        case 0x6470616f: return self.dockPreferencesObject // "dpao"
        case 0x64737a65: return self.dockSize // "dsze"
        case 0x646f6375: return self.document // "docu"
        case 0x646f6373: return self.documentsFolder // "docs"
        case 0x646f6d61: return self.domain // "doma"
        case 0x646f7562: return self.double // "doub"
        case 0x636f6d70: return self.doubleInteger // "comp"
        case 0x646f776e: return self.downloadsFolder // "down"
        case 0x64726141: return self.drawer // "draA"
        case 0x6475706c: return self.duplex // "dupl"
        case 0x6475726e: return self.duration // "durn"
        case 0x6973656a: return self.ejectable // "isej"
        case 0x656e6142: return self.enabled // "enaB"
        case 0x656e6373: return self.encodedString // "encs"
        case 0x6c776c70: return self.endingPage // "lwlp"
        case 0x65637473: return self.entireContents // "ects"
        case 0x656e6d64: return self.enumerated // "enmd"
        case 0x45505320: return self.EPSPicture // "EPS\0x20"
        case 0x6c776568: return self.errorHandling // "lweh"
        case 0x65787061: return self.expansion // "expa"
        case 0x65787465: return self.extendedReal // "exte"
        case 0x6578747a: return self.extensionsFolder // "extz"
        case 0x66617673: return self.favoritesFolder // "favs"
        case 0x6661786e: return self.faxNumber // "faxn"
        case 0x66656220: return self.February // "feb\0x20"
        case 0x66696c65: return self.file // "file"
        case 0x63706b67: return self.filePackage // "cpkg"
        case 0x66737266: return self.fileRef // "fsrf"
        case 0x66737320: return self.fileSpecification // "fss\0x20"
        case 0x61737479: return self.fileType // "asty"
        case 0x6675726c: return self.fileURL // "furl"
        case 0x66697864: return self.fixed // "fixd"
        case 0x66706e74: return self.fixedPoint // "fpnt"
        case 0x66726374: return self.fixedRectangle // "frct"
        case 0x666f6375: return self.focused // "focu"
        case 0x63666f6c: return self.folder // "cfol"
        case 0x666f6163: return self.folderAction // "foac"
        case 0x66617366: return self.FolderActionScriptsFolder // "fasf"
        case 0x6661656e: return self.folderActionsEnabled // "faen"
        case 0x666f6e74: return self.fontsFolder // "font"
        case 0x66747473: return self.fontSmoothing // "ftts"
        case 0x6674736d: return self.fontSmoothingLimit // "ftsm"
        case 0x66747373: return self.fontSmoothingStyle // "ftss"
        case 0x64666d74: return self.format // "dfmt"
        case 0x66727370: return self.freeSpace // "frsp"
        case 0x66726920: return self.Friday // "fri\0x20"
        case 0x70697366: return self.frontmost // "pisf"
        case 0x666e616d: return self.fullName // "fnam"
        case 0x616e6f74: return self.fullText // "anot"
        case 0x67656e69: return self.genie // "geni"
        case 0x47494666: return self.GIFPicture // "GIFf"
        case 0x676f6c64: return self.gold // "gold"
        case 0x63677478: return self.graphicText // "cgtx"
        case 0x67726674: return self.graphite // "grft"
        case 0x6772656e: return self.green // "gren"
        case 0x73677270: return self.group // "sgrp"
        case 0x67726f77: return self.growArea // "grow"
        case 0x68616c66: return self.half // "half"
        case 0x68736372: return self.hasScriptingTerminology // "hscr"
        case 0x68656c70: return self.help // "help"
        case 0x6869646e: return self.hidden // "hidn"
        case 0x6869636f: return self.highlightColor // "hico"
        case 0x68717561: return self.highQuality // "hqua"
        case 0x64666873: return self.HighSierraFormat // "dfhs"
        case 0x686f6d65: return self.homeDirectory // "home"
        case 0x63757372: return self.homeFolder // "cusr"
        case 0x68726566: return self.href // "href"
        case 0x68797068: return self.hyphens // "hyph"
        case 0x49442020: return self.id // "ID\0x20\0x20"
        case 0x64686967: return self.ignore // "dhig"
        case 0x69677072: return self.ignorePrivileges // "igpr"
        case 0x696d6141: return self.image // "imaA"
        case 0x696e6372: return self.incrementor // "incr"
        case 0x70696478: return self.index // "pidx"
        case 0x64686174: return self.insertionAction // "dhat"
        case 0x64686970: return self.insertionPreference // "dhip"
        case 0x6c6f6e67: return self.integer // "long"
        case 0x696e7466: return self.interface // "intf"
        case 0x69747874: return self.internationalText // "itxt"
        case 0x696e746c: return self.internationalWritingCode // "intl"
        case 0x64663936: return self.ISO9660Format // "df96"
        case 0x636f626a: return self.item // "cobj"
        case 0x66676574: return self.itemsAdded // "fget"
        case 0x666c6f73: return self.itemsRemoved // "flos"
        case 0x6a616e20: return self.January // "jan\0x20"
        case 0x4a504547: return self.JPEGPicture // "JPEG"
        case 0x6a756c20: return self.July // "jul\0x20"
        case 0x746f6872: return self.jumpToHere // "tohr"
        case 0x6e787067: return self.jumpToNextPage // "nxpg"
        case 0x6a756e20: return self.June // "jun\0x20"
        case 0x6b706964: return self.kernelProcessID // "kpid"
        case 0x6b696e64: return self.kind // "kind"
        case 0x6c64626c: return self.largeReal // "ldbl"
        case 0x6c61756e: return self.launcherItemsFolder // "laun"
        case 0x6c656674: return self.left // "left"
        case 0x646c6962: return self.libraryFolder // "dlib"
        case 0x6c697465: return self.light // "lite"
        case 0x6c697374: return self.list // "list"
        case 0x6c737464: return self.listed // "lstd"
        case 0x666c646c: return self.localDomain // "fldl"
        case 0x646f6d6c: return self.localDomainObject // "doml"
        case 0x69737276: return self.localVolume // "isrv"
        case 0x6c6f6361: return self.location // "loca"
        case 0x696e736c: return self.locationReference // "insl"
        case 0x6c6f6769: return self.loginItem // "logi"
        case 0x61636c6b: return self.logOutWhenInactive // "aclk"
        case 0x6163746f: return self.logOutWhenInactiveInterval // "acto"
        case 0x6c667864: return self.longFixed // "lfxd"
        case 0x6c667074: return self.longFixedPoint // "lfpt"
        case 0x6c667263: return self.longFixedRectangle // "lfrc"
        case 0x6c706e74: return self.longPoint // "lpnt"
        case 0x6c726374: return self.longRectangle // "lrct"
        case 0x6c6f6f70: return self.looping // "loop"
        case 0x6d616361: return self.MACAddress // "maca"
        case 0x6d616368: return self.machine // "mach"
        case 0x6d4c6f63: return self.machineLocation // "mLoc"
        case 0x706f7274: return self.machPort // "port"
        case 0x6466682b: return self.MacOSExtendedFormat // "dfh+"
        case 0x64666866: return self.MacOSFormat // "dfhf"
        case 0x646d6167: return self.magnification // "dmag"
        case 0x646d737a: return self.magnificationSize // "dmsz"
        case 0x6d736372: return self.mainScreenOnly // "mscr"
        case 0x6d617220: return self.March // "mar\0x20"
        case 0x6d617856: return self.maximumValue // "maxV"
        case 0x6d617920: return self.May // "may\0x20"
        case 0x6d656469: return self.medium // "medi"
        case 0x6d656e45: return self.menu // "menE"
        case 0x6d626172: return self.menuBar // "mbar"
        case 0x6d627269: return self.menuBarItem // "mbri"
        case 0x6d656e42: return self.menuButton // "menB"
        case 0x6d656e49: return self.menuItem // "menI"
        case 0x69736d6e: return self.miniaturizable // "ismn"
        case 0x706d6e64: return self.miniaturized // "pmnd"
        case 0x64656666: return self.minimizeEffect // "deff"
        case 0x6d696e57: return self.minimumValue // "minW"
        case 0x61736d6f: return self.modificationDate // "asmo"
        case 0x6d64746d: return self.modificationTime // "mdtm"
        case 0x696d6f64: return self.modified // "imod"
        case 0x6d6f6e20: return self.Monday // "mon\0x20"
        case 0x6d6f7664: return self.movieData // "movd"
        case 0x6d6f7666: return self.movieFile // "movf"
        case 0x6d646f63: return self.moviesFolder // "mdoc"
        case 0x64666d73: return self.MSDOSFormat // "dfms"
        case 0x6d747520: return self.mtu // "mtu\0x20"
        case 0x64686d63: return self.musicCD // "dhmc"
        case 0x25646f63: return self.musicFolder // "%doc"
        case 0x706e616d: return self.name // "pnam"
        case 0x6578746e: return self.nameExtension // "extn"
        case 0x6e64696d: return self.naturalDimensions // "ndim"
        case 0x666c646e: return self.networkDomain // "fldn"
        case 0x646f6d6e: return self.networkDomainObject // "domn"
        case 0x6e657470: return self.networkPreferences // "netp"
        case 0x6e65746f: return self.networkPreferencesObject // "neto"
        case 0x64666e66: return self.NFSFormat // "dfnf"
        case 0x6e6f2020: return self.no // "no\0x20\0x20"
        case 0x6e6f6e65: return self.none // "none"
        case 0x6e6f726d: return self.normal // "norm"
        case 0x6e6f7620: return self.November // "nov\0x20"
        case 0x6e756c6c: return self.null // "null"
        case 0x6e756d65: return self.numericStrings // "nume"
        case 0x6f637420: return self.October // "oct\0x20"
        case 0x64686170: return self.openApplication // "dhap"
        case 0x654f7074: return self.option // "eOpt"
        case 0x6f70746c: return self.optional_ // "optl"
        case 0x4b6f7074: return self.optionDown // "Kopt"
        case 0x6f726e67: return self.orange // "orng"
        case 0x6f726965: return self.orientation // "orie"
        case 0x6f75746c: return self.outline // "outl"
        case 0x706b6766: return self.packageFolder // "pkgf"
        case 0x6c776c61: return self.pagesAcross // "lwla"
        case 0x6c776c64: return self.pagesDown // "lwld"
        case 0x70757364: return self.partitionSpaceUsed // "pusd"
        case 0x70707468: return self.path // "ppth"
        case 0x70687973: return self.physicalSize // "phys"
        case 0x50494354: return self.PICTPicture // "PICT"
        case 0x70696350: return self.picture // "picP"
        case 0x64687063: return self.pictureCD // "dhpc"
        case 0x70737479: return self.pictureDisplayStyle // "psty"
        case 0x70696370: return self.picturePath // "picp"
        case 0x63686e47: return self.pictureRotation // "chnG"
        case 0x70646f63: return self.picturesFolder // "pdoc"
        case 0x74706d6d: return self.pixelMapRecord // "tpmm"
        case 0x706c6e6d: return self.pluralName // "plnm"
        case 0x51447074: return self.point // "QDpt"
        case 0x706f7076: return self.popOver // "popv"
        case 0x706f7042: return self.popUpButton // "popB"
        case 0x706f736e: return self.position // "posn"
        case 0x706f7378: return self.POSIXPath // "posx"
        case 0x70726566: return self.preferencesFolder // "pref"
        case 0x70726672: return self.preferredRate // "prfr"
        case 0x70726676: return self.preferredVolume // "prfv"
        case 0x70726d64: return self.presentationMode // "prmd"
        case 0x6d76737a: return self.presentationSize // "mvsz"
        case 0x70767764: return self.previewDuration // "pvwd"
        case 0x70767774: return self.previewTime // "pvwt"
        case 0x70736574: return self.printSettings // "pset"
        case 0x70726373: return self.process // "prcs"
        case 0x70736e20: return self.processSerialNumber // "psn\0x20"
        case 0x64667072: return self.ProDOSFormat // "dfpr"
        case 0x76657232: return self.productVersion // "ver2"
        case 0x70726f49: return self.progressIndicator // "proI"
        case 0x70414c4c: return self.properties // "pALL"
        case 0x70726f70: return self.property_ // "prop"
        case 0x706c6966: return self.propertyListFile // "plif"
        case 0x706c6969: return self.propertyListItem // "plii"
        case 0x70756262: return self.publicFolder // "pubb"
        case 0x70756e63: return self.punctuation // "punc"
        case 0x7072706c: return self.purple // "prpl"
        case 0x64667174: return self.QuickTakeFormat // "dfqt"
        case 0x71746664: return self.QuickTimeData // "qtfd"
        case 0x71746666: return self.QuickTimeFile // "qtff"
        case 0x7164656c: return self.quitDelay // "qdel"
        case 0x72616442: return self.radioButton // "radB"
        case 0x72677270: return self.radioGroup // "rgrp"
        case 0x72616e44: return self.randomOrder // "ranD"
        case 0x72656164: return self.readOnly // "read"
        case 0x72647772: return self.readWrite // "rdwr"
        case 0x7261706c: return self.recentApplicationsLimit // "rapl"
        case 0x7264636c: return self.recentDocumentsLimit // "rdcl"
        case 0x7273766c: return self.recentServersLimit // "rsvl"
        case 0x7265636f: return self.record // "reco"
        case 0x72656420: return self.red // "red\0x20"
        case 0x6f626a20: return self.reference // "obj\0x20"
        case 0x72656c69: return self.relevanceIndicator // "reli"
        case 0x6c777174: return self.requestedPrintTime // "lwqt"
        case 0x7077756c: return self.requirePasswordToUnlock // "pwul"
        case 0x7077776b: return self.requirePasswordToWake // "pwwk"
        case 0x7072737a: return self.resizable // "prsz"
        case 0x74723136: return self.RGB16Color // "tr16"
        case 0x74723936: return self.RGB96Color // "tr96"
        case 0x63524742: return self.RGBColor // "cRGB"
        case 0x72696768: return self.right // "righ"
        case 0x726f6c65: return self.role // "role"
        case 0x726f6c64: return self.roleDescription // "rold"
        case 0x74726f74: return self.rotation // "trot"
        case 0x63726f77: return self.row // "crow"
        case 0x64687273: return self.runAScript // "dhrs"
        case 0x72756e6e: return self.running // "runn"
        case 0x73617420: return self.Saturday // "sat\0x20"
        case 0x7363616c: return self.scale // "scal"
        case 0x66697473: return self.screen // "fits"
        case 0x64707365: return self.screenEdge // "dpse"
        case 0x73737672: return self.screenSaver // "ssvr"
        case 0x73737670: return self.screenSaverPreferences // "ssvp"
        case 0x7373766f: return self.screenSaverPreferencesObject // "ssvo"
        case 0x73637074: return self.script // "scpt"
        case 0x24736372: return self.scriptingAdditionsFolder // "$scr"
        case 0x7364636c: return self.scriptingClass // "sdcl"
        case 0x7364636d: return self.scriptingCommand // "sdcm"
        case 0x73646566: return self.scriptingDefinition // "sdef"
        case 0x7364656f: return self.scriptingDefinitionObject // "sdeo"
        case 0x7364656c: return self.scriptingElement // "sdel"
        case 0x7364656e: return self.scriptingEnumeration // "sden"
        case 0x73646572: return self.scriptingEnumerator // "sder"
        case 0x73647061: return self.scriptingParameter // "sdpa"
        case 0x73647072: return self.scriptingProperty // "sdpr"
        case 0x73647273: return self.scriptingResult // "sdrs"
        case 0x7364726f: return self.scriptingResultObject // "sdro"
        case 0x73647374: return self.scriptingSuite // "sdst"
        case 0x73636d6e: return self.scriptMenuEnabled // "scmn"
        case 0x73637224: return self.scriptsFolder // "scr$"
        case 0x73637261: return self.scrollArea // "scra"
        case 0x73637262: return self.scrollBar // "scrb"
        case 0x73636c62: return self.scrollBarAction // "sclb"
        case 0x7363766d: return self.secureVirtualMemory // "scvm"
        case 0x73656370: return self.securityPreferences // "secp"
        case 0x7365636f: return self.securityPreferencesObject // "seco"
        case 0x73656c45: return self.selected // "selE"
        case 0x73657020: return self.September // "sep\0x20"
        case 0x73727672: return self.server // "srvr"
        case 0x73766365: return self.service // "svce"
        case 0x7374626c: return self.settable // "stbl"
        case 0x73646174: return self.sharedDocumentsFolder // "sdat"
        case 0x73686545: return self.sheet // "sheE"
        case 0x65536674: return self.shift // "eSft"
        case 0x4b736674: return self.shiftDown // "Ksft"
        case 0x73686f72: return self.shortInteger // "shor"
        case 0x6366626e: return self.shortName // "cfbn"
        case 0x61737376: return self.shortVersion // "assv"
        case 0x7368636c: return self.showClock // "shcl"
        case 0x73686466: return self.shutdownFolder // "shdf"
        case 0x736c7672: return self.silver // "slvr"
        case 0x73697465: return self.sitesFolder // "site"
        case 0x7074737a: return self.size // "ptsz"
        case 0x736c6949: return self.slider // "sliI"
        case 0x706d7373: return self.slideShow // "pmss"
        case 0x73696e67: return self.smallReal // "sing"
        case 0x73636c73: return self.smoothScrolling // "scls"
        case 0x73706b69: return self.speakableItemsFolder // "spki"
        case 0x73706564: return self.speed // "sped"
        case 0x73706c72: return self.splitter // "splr"
        case 0x73706c67: return self.splitterGroup // "splg"
        case 0x73746e64: return self.standard // "stnd"
        case 0x6c777374: return self.standard // "lwst"
        case 0x6c776670: return self.startingPage // "lwfp"
        case 0x6f666673: return self.startTime // "offs"
        case 0x69737464: return self.startup // "istd"
        case 0x7364736b: return self.startupDisk // "sdsk"
        case 0x656d707a: return self.startupItemsFolder // "empz"
        case 0x73747478: return self.staticText // "sttx"
        case 0x70737064: return self.stationery // "pspd"
        case 0x69737373: return self.storedStream // "isss"
        case 0x54455854: return self.string // "TEXT"
        case 0x73747267: return self.strong // "strg"
        case 0x7374796c: return self.styledClipboardText // "styl"
        case 0x53545854: return self.styledText // "STXT"
        case 0x7362726c: return self.subrole // "sbrl"
        case 0x73746e6d: return self.suiteName // "stnm"
        case 0x73756e20: return self.Sunday // "sun\0x20"
        case 0x73757065: return self.superclass // "supe"
        case 0x666c6473: return self.systemDomain // "flds"
        case 0x646f6d73: return self.systemDomainObject // "doms"
        case 0x6d616373: return self.systemFolder // "macs"
        case 0x74616267: return self.tabGroup // "tabg"
        case 0x74616242: return self.table // "tabB"
        case 0x74727072: return self.targetPrinter // "trpr"
        case 0x74656d70: return self.temporaryItemsFolder // "temp"
        case 0x63747874: return self.text // "ctxt"
        case 0x74787461: return self.textArea // "txta"
        case 0x74787466: return self.textField // "txtf"
        case 0x74737479: return self.textStyleInfo // "tsty"
        case 0x74687520: return self.Thursday // "thu\0x20"
        case 0x54494646: return self.TIFFPicture // "TIFF"
        case 0x746d7363: return self.timeScale // "tmsc"
        case 0x7469746c: return self.title // "titl"
        case 0x74626172: return self.toolbar // "tbar"
        case 0x61707074: return self.totalPartitionSize // "appt"
        case 0x7472616b: return self.track // "trak"
        case 0x6d6e5472: return self.translucentMenuBar // "mnTr"
        case 0x74727368: return self.trash // "trsh"
        case 0x74756520: return self.Tuesday // "tue\0x20"
        case 0x70747970: return self.type // "ptyp"
        case 0x74797065: return self.typeClass // "type"
        case 0x75746964: return self.typeIdentifier // "utid"
        case 0x64667564: return self.UDFFormat // "dfud"
        case 0x64667566: return self.UFSFormat // "dfuf"
        case 0x7569656c: return self.UIElement // "uiel"
        case 0x7569656e: return self.UIElementsEnabled // "uien"
        case 0x75747874: return self.UnicodeText // "utxt"
        case 0x69647578: return self.unixId // "idux"
        case 0x64662424: return self.unknownFormat // "df$$"
        case 0x75636f6d: return self.unsignedDoubleInteger // "ucom"
        case 0x6d61676e: return self.unsignedInteger // "magn"
        case 0x75736872: return self.unsignedShortInteger // "ushr"
        case 0x75726c20: return self.URL // "url\0x20"
        case 0x75616363: return self.user // "uacc"
        case 0x666c6475: return self.userDomain // "fldu"
        case 0x646f6d75: return self.userDomainObject // "domu"
        case 0x75743136: return self.UTF16Text // "ut16"
        case 0x75746638: return self.UTF8Text // "utf8"
        case 0x75746924: return self.utilitiesFolder // "uti$"
        case 0x76616c4c: return self.value // "valL"
        case 0x76616c69: return self.valueIndicator // "vali"
        case 0x76657273: return self.version // "vers"
        case 0x64687662: return self.videoBD // "dhvb"
        case 0x76636470: return self.videoDepth // "vcdp"
        case 0x64687664: return self.videoDVD // "dhvd"
        case 0x70766973: return self.visible // "pvis"
        case 0x76697375: return self.visualCharacteristic // "visu"
        case 0x766f6c75: return self.volume // "volu"
        case 0x64667764: return self.WebDAVFormat // "dfwd"
        case 0x77656420: return self.Wednesday // "wed\0x20"
        case 0x77686974: return self.whitespace // "whit"
        case 0x6377696e: return self.window // "cwin"
        case 0x66636c6f: return self.windowClosed // "fclo"
        case 0x6673697a: return self.windowMoved // "fsiz"
        case 0x666f706e: return self.windowOpened // "fopn"
        case 0x666c6f77: return self.workflowsFolder // "flow"
        case 0x77726974: return self.writeOnly // "writ"
        case 0x70736374: return self.writingCode // "psct"
        case 0x786d6c61: return self.XMLAttribute // "xmla"
        case 0x786d6c64: return self.XMLData // "xmld"
        case 0x786d6c65: return self.XMLElement // "xmle"
        case 0x786d6c66: return self.XMLFile // "xmlf"
        case 0x79657320: return self.yes // "yes\0x20"
        case 0x7a6f6e65: return self.zone // "zone"
        case 0x69737a6d: return self.zoomable // "iszm"
        case 0x707a756d: return self.zoomed // "pzum"
        default: return super.symbol(code: code, type: type, descriptor: descriptor) as! SEVSymbol
        }
    }

    // Types/properties
    public static let acceptsHighLevelEvents = SEVSymbol(name: "acceptsHighLevelEvents", code: 0x69736162, type: typeType) // "isab"
    public static let acceptsRemoteEvents = SEVSymbol(name: "acceptsRemoteEvents", code: 0x72657674, type: typeType) // "revt"
    public static let access = SEVSymbol(name: "access", code: 0x61636373, type: typeType) // "accs"
    public static let accessibilityDescription = SEVSymbol(name: "accessibilityDescription", code: 0x61786473, type: typeType) // "axds"
    public static let accountName = SEVSymbol(name: "accountName", code: 0x75736572, type: typeType) // "user"
    public static let action = SEVSymbol(name: "action", code: 0x61637454, type: typeType) // "actT"
    public static let active = SEVSymbol(name: "active", code: 0x61637469, type: typeType) // "acti"
    public static let alias = SEVSymbol(name: "alias", code: 0x616c6973, type: typeType) // "alis"
    public static let animate = SEVSymbol(name: "animate", code: 0x64616e69, type: typeType) // "dani"
    public static let annotation = SEVSymbol(name: "annotation", code: 0x616e6e6f, type: typeType) // "anno"
    public static let anything = SEVSymbol(name: "anything", code: 0x2a2a2a2a, type: typeType) // "****"
    public static let appearance = SEVSymbol(name: "appearance", code: 0x61707065, type: typeType) // "appe"
    public static let appearancePreferences = SEVSymbol(name: "appearancePreferences", code: 0x61707270, type: typeType) // "aprp"
    public static let appearancePreferencesObject = SEVSymbol(name: "appearancePreferencesObject", code: 0x6170726f, type: typeType) // "apro"
    public static let appleMenuFolder = SEVSymbol(name: "appleMenuFolder", code: 0x616d6e75, type: typeType) // "amnu"
    public static let application = SEVSymbol(name: "application", code: 0x63617070, type: typeType) // "capp"
    public static let applicationBundleID = SEVSymbol(name: "applicationBundleID", code: 0x62756e64, type: typeType) // "bund"
    public static let applicationFile = SEVSymbol(name: "applicationFile", code: 0x61707066, type: typeType) // "appf"
    public static let applicationProcess = SEVSymbol(name: "applicationProcess", code: 0x70636170, type: typeType) // "pcap"
    public static let applicationsFolder = SEVSymbol(name: "applicationsFolder", code: 0x61707073, type: typeType) // "apps"
    public static let applicationSignature = SEVSymbol(name: "applicationSignature", code: 0x7369676e, type: typeType) // "sign"
    public static let applicationSupportFolder = SEVSymbol(name: "applicationSupportFolder", code: 0x61737570, type: typeType) // "asup"
    public static let applicationURL = SEVSymbol(name: "applicationURL", code: 0x6170726c, type: typeType) // "aprl"
    public static let April = SEVSymbol(name: "April", code: 0x61707220, type: typeType) // "apr\0x20"
    public static let architecture = SEVSymbol(name: "architecture", code: 0x61726368, type: typeType) // "arch"
    public static let attribute = SEVSymbol(name: "attribute", code: 0x61747472, type: typeType) // "attr"
    public static let audioChannelCount = SEVSymbol(name: "audioChannelCount", code: 0x61636861, type: typeType) // "acha"
    public static let audioCharacteristic = SEVSymbol(name: "audioCharacteristic", code: 0x61756469, type: typeType) // "audi"
    public static let audioData = SEVSymbol(name: "audioData", code: 0x61756464, type: typeType) // "audd"
    public static let audioFile = SEVSymbol(name: "audioFile", code: 0x61756466, type: typeType) // "audf"
    public static let audioSampleRate = SEVSymbol(name: "audioSampleRate", code: 0x61737261, type: typeType) // "asra"
    public static let audioSampleSize = SEVSymbol(name: "audioSampleSize", code: 0x6173737a, type: typeType) // "assz"
    public static let August = SEVSymbol(name: "August", code: 0x61756720, type: typeType) // "aug\0x20"
    public static let autohide = SEVSymbol(name: "autohide", code: 0x64616864, type: typeType) // "dahd"
    public static let automaticLogin = SEVSymbol(name: "automaticLogin", code: 0x61756c67, type: typeType) // "aulg"
    public static let autoPlay = SEVSymbol(name: "autoPlay", code: 0x61757470, type: typeType) // "autp"
    public static let autoPresent = SEVSymbol(name: "autoPresent", code: 0x61707265, type: typeType) // "apre"
    public static let autoQuitWhenDone = SEVSymbol(name: "autoQuitWhenDone", code: 0x61717569, type: typeType) // "aqui"
    public static let backgroundOnly = SEVSymbol(name: "backgroundOnly", code: 0x626b676f, type: typeType) // "bkgo"
    public static let best = SEVSymbol(name: "best", code: 0x62657374, type: typeType) // "best"
    public static let blankBD = SEVSymbol(name: "blankBD", code: 0x64686262, type: typeType) // "dhbb"
    public static let blankCD = SEVSymbol(name: "blankCD", code: 0x64686263, type: typeType) // "dhbc"
    public static let blankDVD = SEVSymbol(name: "blankDVD", code: 0x64686264, type: typeType) // "dhbd"
    public static let bookmarkData = SEVSymbol(name: "bookmarkData", code: 0x626d726b, type: typeType) // "bmrk"
    public static let boolean = SEVSymbol(name: "boolean", code: 0x626f6f6c, type: typeType) // "bool"
    public static let boundingRectangle = SEVSymbol(name: "boundingRectangle", code: 0x71647274, type: typeType) // "qdrt"
    public static let bounds = SEVSymbol(name: "bounds", code: 0x70626e64, type: typeType) // "pbnd"
    public static let browser = SEVSymbol(name: "browser", code: 0x62726f57, type: typeType) // "broW"
    public static let bundleIdentifier = SEVSymbol(name: "bundleIdentifier", code: 0x626e6964, type: typeType) // "bnid"
    public static let busyIndicator = SEVSymbol(name: "busyIndicator", code: 0x62757369, type: typeType) // "busi"
    public static let busyStatus = SEVSymbol(name: "busyStatus", code: 0x62757379, type: typeType) // "busy"
    public static let button = SEVSymbol(name: "button", code: 0x62757454, type: typeType) // "butT"
    public static let capacity = SEVSymbol(name: "capacity", code: 0x63617061, type: typeType) // "capa"
    public static let CDAndDVDPreferences = SEVSymbol(name: "CDAndDVDPreferences", code: 0x64686173, type: typeType) // "dhas"
    public static let CDAndDVDPreferencesObject = SEVSymbol(name: "CDAndDVDPreferencesObject", code: 0x6468616f, type: typeType) // "dhao"
    public static let changeInterval = SEVSymbol(name: "changeInterval", code: 0x63696e54, type: typeType) // "cinT"
    public static let checkbox = SEVSymbol(name: "checkbox", code: 0x63686278, type: typeType) // "chbx"
    public static let class_ = SEVSymbol(name: "class_", code: 0x70636c73, type: typeType) // "pcls"
    public static let Classic = SEVSymbol(name: "Classic", code: 0x636c7363, type: typeType) // "clsc"
    public static let ClassicDomain = SEVSymbol(name: "ClassicDomain", code: 0x666c6463, type: typeType) // "fldc"
    public static let ClassicDomainObject = SEVSymbol(name: "ClassicDomainObject", code: 0x646f6d63, type: typeType) // "domc"
    public static let closeable = SEVSymbol(name: "closeable", code: 0x68636c62, type: typeType) // "hclb"
    public static let collating = SEVSymbol(name: "collating", code: 0x6c77636c, type: typeType) // "lwcl"
    public static let color = SEVSymbol(name: "color", code: 0x636f6c72, type: typeType) // "colr"
    public static let colorTable = SEVSymbol(name: "colorTable", code: 0x636c7274, type: typeType) // "clrt"
    public static let colorWell = SEVSymbol(name: "colorWell", code: 0x636f6c57, type: typeType) // "colW"
    public static let column = SEVSymbol(name: "column", code: 0x63636f6c, type: typeType) // "ccol"
    public static let comboBox = SEVSymbol(name: "comboBox", code: 0x636f6d42, type: typeType) // "comB"
    public static let configuration = SEVSymbol(name: "configuration", code: 0x636f6e46, type: typeType) // "conF"
    public static let connected = SEVSymbol(name: "connected", code: 0x636f6e6e, type: typeType) // "conn"
    public static let constant = SEVSymbol(name: "constant", code: 0x656e756d, type: typeType) // "enum"
    public static let container = SEVSymbol(name: "container", code: 0x63746e72, type: typeType) // "ctnr"
    public static let controlPanelsFolder = SEVSymbol(name: "controlPanelsFolder", code: 0x6374726c, type: typeType) // "ctrl"
    public static let controlStripModulesFolder = SEVSymbol(name: "controlStripModulesFolder", code: 0x73646576, type: typeType) // "sdev"
    public static let copies = SEVSymbol(name: "copies", code: 0x6c776370, type: typeType) // "lwcp"
    public static let creationDate = SEVSymbol(name: "creationDate", code: 0x61736364, type: typeType) // "ascd"
    public static let creationTime = SEVSymbol(name: "creationTime", code: 0x6d646372, type: typeType) // "mdcr"
    public static let creatorType = SEVSymbol(name: "creatorType", code: 0x66637274, type: typeType) // "fcrt"
    public static let currentConfiguration = SEVSymbol(name: "currentConfiguration", code: 0x636e6667, type: typeType) // "cnfg"
    public static let currentDesktop = SEVSymbol(name: "currentDesktop", code: 0x63757264, type: typeType) // "curd"
    public static let currentLocation = SEVSymbol(name: "currentLocation", code: 0x6c6f6363, type: typeType) // "locc"
    public static let currentScreenSaver = SEVSymbol(name: "currentScreenSaver", code: 0x73737663, type: typeType) // "ssvc"
    public static let currentUser = SEVSymbol(name: "currentUser", code: 0x63757275, type: typeType) // "curu"
    public static let customApplication = SEVSymbol(name: "customApplication", code: 0x64686361, type: typeType) // "dhca"
    public static let customScript = SEVSymbol(name: "customScript", code: 0x64686373, type: typeType) // "dhcs"
    public static let darkMode = SEVSymbol(name: "darkMode", code: 0x74686d65, type: typeType) // "thme"
    public static let dashStyle = SEVSymbol(name: "dashStyle", code: 0x74646173, type: typeType) // "tdas"
    public static let data = SEVSymbol(name: "data", code: 0x74647461, type: typeType) // "tdta"
    public static let data_ = SEVSymbol(name: "data_", code: 0x72646174, type: typeType) // "rdat"
    public static let dataFormat = SEVSymbol(name: "dataFormat", code: 0x74646672, type: typeType) // "tdfr"
    public static let dataRate = SEVSymbol(name: "dataRate", code: 0x64647261, type: typeType) // "ddra"
    public static let dataSize = SEVSymbol(name: "dataSize", code: 0x6473697a, type: typeType) // "dsiz"
    public static let date = SEVSymbol(name: "date", code: 0x6c647420, type: typeType) // "ldt\0x20"
    public static let December = SEVSymbol(name: "December", code: 0x64656320, type: typeType) // "dec\0x20"
    public static let decimalStruct = SEVSymbol(name: "decimalStruct", code: 0x6465636d, type: typeType) // "decm"
    public static let defaultApplication = SEVSymbol(name: "defaultApplication", code: 0x61736461, type: typeType) // "asda"
    public static let delayInterval = SEVSymbol(name: "delayInterval", code: 0x646c7969, type: typeType) // "dlyi"
    public static let description_ = SEVSymbol(name: "description_", code: 0x64657363, type: typeType) // "desc"
    public static let deskAccessoryFile = SEVSymbol(name: "deskAccessoryFile", code: 0x64616669, type: typeType) // "dafi"
    public static let deskAccessoryProcess = SEVSymbol(name: "deskAccessoryProcess", code: 0x70636461, type: typeType) // "pcda"
    public static let desktop = SEVSymbol(name: "desktop", code: 0x64736b70, type: typeType) // "dskp"
    public static let desktopFolder = SEVSymbol(name: "desktopFolder", code: 0x6465736b, type: typeType) // "desk"
    public static let desktopPicturesFolder = SEVSymbol(name: "desktopPicturesFolder", code: 0x64747024, type: typeType) // "dtp$"
    public static let dimensions = SEVSymbol(name: "dimensions", code: 0x7064696d, type: typeType) // "pdim"
    public static let directParameter = SEVSymbol(name: "directParameter", code: 0x73646470, type: typeType) // "sddp"
    public static let disk = SEVSymbol(name: "disk", code: 0x63646973, type: typeType) // "cdis"
    public static let diskItem = SEVSymbol(name: "diskItem", code: 0x6469746d, type: typeType) // "ditm"
    public static let displayedName = SEVSymbol(name: "displayedName", code: 0x646e616d, type: typeType) // "dnam"
    public static let displayName = SEVSymbol(name: "displayName", code: 0x646e614d, type: typeType) // "dnaM"
    public static let dockPreferences = SEVSymbol(name: "dockPreferences", code: 0x64706173, type: typeType) // "dpas"
    public static let dockPreferencesObject = SEVSymbol(name: "dockPreferencesObject", code: 0x6470616f, type: typeType) // "dpao"
    public static let dockSize = SEVSymbol(name: "dockSize", code: 0x64737a65, type: typeType) // "dsze"
    public static let document = SEVSymbol(name: "document", code: 0x646f6375, type: typeType) // "docu"
    public static let documentsFolder = SEVSymbol(name: "documentsFolder", code: 0x646f6373, type: typeType) // "docs"
    public static let domain = SEVSymbol(name: "domain", code: 0x646f6d61, type: typeType) // "doma"
    public static let doubleInteger = SEVSymbol(name: "doubleInteger", code: 0x636f6d70, type: typeType) // "comp"
    public static let downloadsFolder = SEVSymbol(name: "downloadsFolder", code: 0x646f776e, type: typeType) // "down"
    public static let drawer = SEVSymbol(name: "drawer", code: 0x64726141, type: typeType) // "draA"
    public static let duplex = SEVSymbol(name: "duplex", code: 0x6475706c, type: typeType) // "dupl"
    public static let duration = SEVSymbol(name: "duration", code: 0x6475726e, type: typeType) // "durn"
    public static let ejectable = SEVSymbol(name: "ejectable", code: 0x6973656a, type: typeType) // "isej"
    public static let enabled = SEVSymbol(name: "enabled", code: 0x656e6142, type: typeType) // "enaB"
    public static let encodedString = SEVSymbol(name: "encodedString", code: 0x656e6373, type: typeType) // "encs"
    public static let endingPage = SEVSymbol(name: "endingPage", code: 0x6c776c70, type: typeType) // "lwlp"
    public static let entireContents = SEVSymbol(name: "entireContents", code: 0x65637473, type: typeType) // "ects"
    public static let enumerated = SEVSymbol(name: "enumerated", code: 0x656e6d64, type: typeType) // "enmd"
    public static let EPSPicture = SEVSymbol(name: "EPSPicture", code: 0x45505320, type: typeType) // "EPS\0x20"
    public static let errorHandling = SEVSymbol(name: "errorHandling", code: 0x6c776568, type: typeType) // "lweh"
    public static let extendedReal = SEVSymbol(name: "extendedReal", code: 0x65787465, type: typeType) // "exte"
    public static let extensionsFolder = SEVSymbol(name: "extensionsFolder", code: 0x6578747a, type: typeType) // "extz"
    public static let favoritesFolder = SEVSymbol(name: "favoritesFolder", code: 0x66617673, type: typeType) // "favs"
    public static let faxNumber = SEVSymbol(name: "faxNumber", code: 0x6661786e, type: typeType) // "faxn"
    public static let February = SEVSymbol(name: "February", code: 0x66656220, type: typeType) // "feb\0x20"
    public static let file = SEVSymbol(name: "file", code: 0x66696c65, type: typeType) // "file"
    public static let filePackage = SEVSymbol(name: "filePackage", code: 0x63706b67, type: typeType) // "cpkg"
    public static let fileRef = SEVSymbol(name: "fileRef", code: 0x66737266, type: typeType) // "fsrf"
    public static let fileSpecification = SEVSymbol(name: "fileSpecification", code: 0x66737320, type: typeType) // "fss\0x20"
    public static let fileType = SEVSymbol(name: "fileType", code: 0x61737479, type: typeType) // "asty"
    public static let fileURL = SEVSymbol(name: "fileURL", code: 0x6675726c, type: typeType) // "furl"
    public static let fixed = SEVSymbol(name: "fixed", code: 0x66697864, type: typeType) // "fixd"
    public static let fixedPoint = SEVSymbol(name: "fixedPoint", code: 0x66706e74, type: typeType) // "fpnt"
    public static let fixedRectangle = SEVSymbol(name: "fixedRectangle", code: 0x66726374, type: typeType) // "frct"
    public static let focused = SEVSymbol(name: "focused", code: 0x666f6375, type: typeType) // "focu"
    public static let folder = SEVSymbol(name: "folder", code: 0x63666f6c, type: typeType) // "cfol"
    public static let folderAction = SEVSymbol(name: "folderAction", code: 0x666f6163, type: typeType) // "foac"
    public static let FolderActionScriptsFolder = SEVSymbol(name: "FolderActionScriptsFolder", code: 0x66617366, type: typeType) // "fasf"
    public static let folderActionsEnabled = SEVSymbol(name: "folderActionsEnabled", code: 0x6661656e, type: typeType) // "faen"
    public static let fontsFolder = SEVSymbol(name: "fontsFolder", code: 0x666f6e74, type: typeType) // "font"
    public static let fontSmoothing = SEVSymbol(name: "fontSmoothing", code: 0x66747473, type: typeType) // "ftts"
    public static let fontSmoothingLimit = SEVSymbol(name: "fontSmoothingLimit", code: 0x6674736d, type: typeType) // "ftsm"
    public static let fontSmoothingStyle = SEVSymbol(name: "fontSmoothingStyle", code: 0x66747373, type: typeType) // "ftss"
    public static let format = SEVSymbol(name: "format", code: 0x64666d74, type: typeType) // "dfmt"
    public static let freeSpace = SEVSymbol(name: "freeSpace", code: 0x66727370, type: typeType) // "frsp"
    public static let Friday = SEVSymbol(name: "Friday", code: 0x66726920, type: typeType) // "fri\0x20"
    public static let frontmost = SEVSymbol(name: "frontmost", code: 0x70697366, type: typeType) // "pisf"
    public static let fullName = SEVSymbol(name: "fullName", code: 0x666e616d, type: typeType) // "fnam"
    public static let fullText = SEVSymbol(name: "fullText", code: 0x616e6f74, type: typeType) // "anot"
    public static let GIFPicture = SEVSymbol(name: "GIFPicture", code: 0x47494666, type: typeType) // "GIFf"
    public static let graphicText = SEVSymbol(name: "graphicText", code: 0x63677478, type: typeType) // "cgtx"
    public static let group = SEVSymbol(name: "group", code: 0x73677270, type: typeType) // "sgrp"
    public static let growArea = SEVSymbol(name: "growArea", code: 0x67726f77, type: typeType) // "grow"
    public static let hasScriptingTerminology = SEVSymbol(name: "hasScriptingTerminology", code: 0x68736372, type: typeType) // "hscr"
    public static let help = SEVSymbol(name: "help", code: 0x68656c70, type: typeType) // "help"
    public static let hidden = SEVSymbol(name: "hidden", code: 0x6869646e, type: typeType) // "hidn"
    public static let highlightColor = SEVSymbol(name: "highlightColor", code: 0x6869636f, type: typeType) // "hico"
    public static let highQuality = SEVSymbol(name: "highQuality", code: 0x68717561, type: typeType) // "hqua"
    public static let homeDirectory = SEVSymbol(name: "homeDirectory", code: 0x686f6d65, type: typeType) // "home"
    public static let homeFolder = SEVSymbol(name: "homeFolder", code: 0x63757372, type: typeType) // "cusr"
    public static let href = SEVSymbol(name: "href", code: 0x68726566, type: typeType) // "href"
    public static let id = SEVSymbol(name: "id", code: 0x49442020, type: typeType) // "ID\0x20\0x20"
    public static let ignorePrivileges = SEVSymbol(name: "ignorePrivileges", code: 0x69677072, type: typeType) // "igpr"
    public static let image = SEVSymbol(name: "image", code: 0x696d6141, type: typeType) // "imaA"
    public static let incrementor = SEVSymbol(name: "incrementor", code: 0x696e6372, type: typeType) // "incr"
    public static let index = SEVSymbol(name: "index", code: 0x70696478, type: typeType) // "pidx"
    public static let insertionAction = SEVSymbol(name: "insertionAction", code: 0x64686174, type: typeType) // "dhat"
    public static let insertionPreference = SEVSymbol(name: "insertionPreference", code: 0x64686970, type: typeType) // "dhip"
    public static let integer = SEVSymbol(name: "integer", code: 0x6c6f6e67, type: typeType) // "long"
    public static let interface = SEVSymbol(name: "interface", code: 0x696e7466, type: typeType) // "intf"
    public static let internationalText = SEVSymbol(name: "internationalText", code: 0x69747874, type: typeType) // "itxt"
    public static let internationalWritingCode = SEVSymbol(name: "internationalWritingCode", code: 0x696e746c, type: typeType) // "intl"
    public static let item = SEVSymbol(name: "item", code: 0x636f626a, type: typeType) // "cobj"
    public static let January = SEVSymbol(name: "January", code: 0x6a616e20, type: typeType) // "jan\0x20"
    public static let JPEGPicture = SEVSymbol(name: "JPEGPicture", code: 0x4a504547, type: typeType) // "JPEG"
    public static let July = SEVSymbol(name: "July", code: 0x6a756c20, type: typeType) // "jul\0x20"
    public static let June = SEVSymbol(name: "June", code: 0x6a756e20, type: typeType) // "jun\0x20"
    public static let kernelProcessID = SEVSymbol(name: "kernelProcessID", code: 0x6b706964, type: typeType) // "kpid"
    public static let kind = SEVSymbol(name: "kind", code: 0x6b696e64, type: typeType) // "kind"
    public static let largeReal = SEVSymbol(name: "largeReal", code: 0x6c64626c, type: typeType) // "ldbl"
    public static let launcherItemsFolder = SEVSymbol(name: "launcherItemsFolder", code: 0x6c61756e, type: typeType) // "laun"
    public static let libraryFolder = SEVSymbol(name: "libraryFolder", code: 0x646c6962, type: typeType) // "dlib"
    public static let list = SEVSymbol(name: "list", code: 0x6c697374, type: typeType) // "list"
    public static let listed = SEVSymbol(name: "listed", code: 0x6c737464, type: typeType) // "lstd"
    public static let localDomain = SEVSymbol(name: "localDomain", code: 0x666c646c, type: typeType) // "fldl"
    public static let localDomainObject = SEVSymbol(name: "localDomainObject", code: 0x646f6d6c, type: typeType) // "doml"
    public static let localVolume = SEVSymbol(name: "localVolume", code: 0x69737276, type: typeType) // "isrv"
    public static let location = SEVSymbol(name: "location", code: 0x6c6f6361, type: typeType) // "loca"
    public static let locationReference = SEVSymbol(name: "locationReference", code: 0x696e736c, type: typeType) // "insl"
    public static let loginItem = SEVSymbol(name: "loginItem", code: 0x6c6f6769, type: typeType) // "logi"
    public static let logOutWhenInactive = SEVSymbol(name: "logOutWhenInactive", code: 0x61636c6b, type: typeType) // "aclk"
    public static let logOutWhenInactiveInterval = SEVSymbol(name: "logOutWhenInactiveInterval", code: 0x6163746f, type: typeType) // "acto"
    public static let longFixed = SEVSymbol(name: "longFixed", code: 0x6c667864, type: typeType) // "lfxd"
    public static let longFixedPoint = SEVSymbol(name: "longFixedPoint", code: 0x6c667074, type: typeType) // "lfpt"
    public static let longFixedRectangle = SEVSymbol(name: "longFixedRectangle", code: 0x6c667263, type: typeType) // "lfrc"
    public static let longPoint = SEVSymbol(name: "longPoint", code: 0x6c706e74, type: typeType) // "lpnt"
    public static let longRectangle = SEVSymbol(name: "longRectangle", code: 0x6c726374, type: typeType) // "lrct"
    public static let looping = SEVSymbol(name: "looping", code: 0x6c6f6f70, type: typeType) // "loop"
    public static let MACAddress = SEVSymbol(name: "MACAddress", code: 0x6d616361, type: typeType) // "maca"
    public static let machine = SEVSymbol(name: "machine", code: 0x6d616368, type: typeType) // "mach"
    public static let machineLocation = SEVSymbol(name: "machineLocation", code: 0x6d4c6f63, type: typeType) // "mLoc"
    public static let machPort = SEVSymbol(name: "machPort", code: 0x706f7274, type: typeType) // "port"
    public static let magnification = SEVSymbol(name: "magnification", code: 0x646d6167, type: typeType) // "dmag"
    public static let magnificationSize = SEVSymbol(name: "magnificationSize", code: 0x646d737a, type: typeType) // "dmsz"
    public static let mainScreenOnly = SEVSymbol(name: "mainScreenOnly", code: 0x6d736372, type: typeType) // "mscr"
    public static let March = SEVSymbol(name: "March", code: 0x6d617220, type: typeType) // "mar\0x20"
    public static let maximumValue = SEVSymbol(name: "maximumValue", code: 0x6d617856, type: typeType) // "maxV"
    public static let May = SEVSymbol(name: "May", code: 0x6d617920, type: typeType) // "may\0x20"
    public static let menu = SEVSymbol(name: "menu", code: 0x6d656e45, type: typeType) // "menE"
    public static let menuBar = SEVSymbol(name: "menuBar", code: 0x6d626172, type: typeType) // "mbar"
    public static let menuBarItem = SEVSymbol(name: "menuBarItem", code: 0x6d627269, type: typeType) // "mbri"
    public static let menuButton = SEVSymbol(name: "menuButton", code: 0x6d656e42, type: typeType) // "menB"
    public static let menuItem = SEVSymbol(name: "menuItem", code: 0x6d656e49, type: typeType) // "menI"
    public static let miniaturizable = SEVSymbol(name: "miniaturizable", code: 0x69736d6e, type: typeType) // "ismn"
    public static let miniaturized = SEVSymbol(name: "miniaturized", code: 0x706d6e64, type: typeType) // "pmnd"
    public static let minimizeEffect = SEVSymbol(name: "minimizeEffect", code: 0x64656666, type: typeType) // "deff"
    public static let minimumValue = SEVSymbol(name: "minimumValue", code: 0x6d696e57, type: typeType) // "minW"
    public static let modificationDate = SEVSymbol(name: "modificationDate", code: 0x61736d6f, type: typeType) // "asmo"
    public static let modificationTime = SEVSymbol(name: "modificationTime", code: 0x6d64746d, type: typeType) // "mdtm"
    public static let modified = SEVSymbol(name: "modified", code: 0x696d6f64, type: typeType) // "imod"
    public static let Monday = SEVSymbol(name: "Monday", code: 0x6d6f6e20, type: typeType) // "mon\0x20"
    public static let movieData = SEVSymbol(name: "movieData", code: 0x6d6f7664, type: typeType) // "movd"
    public static let movieFile = SEVSymbol(name: "movieFile", code: 0x6d6f7666, type: typeType) // "movf"
    public static let moviesFolder = SEVSymbol(name: "moviesFolder", code: 0x6d646f63, type: typeType) // "mdoc"
    public static let mtu = SEVSymbol(name: "mtu", code: 0x6d747520, type: typeType) // "mtu\0x20"
    public static let musicCD = SEVSymbol(name: "musicCD", code: 0x64686d63, type: typeType) // "dhmc"
    public static let musicFolder = SEVSymbol(name: "musicFolder", code: 0x25646f63, type: typeType) // "%doc"
    public static let name = SEVSymbol(name: "name", code: 0x706e616d, type: typeType) // "pnam"
    public static let nameExtension = SEVSymbol(name: "nameExtension", code: 0x6578746e, type: typeType) // "extn"
    public static let naturalDimensions = SEVSymbol(name: "naturalDimensions", code: 0x6e64696d, type: typeType) // "ndim"
    public static let networkDomain = SEVSymbol(name: "networkDomain", code: 0x666c646e, type: typeType) // "fldn"
    public static let networkDomainObject = SEVSymbol(name: "networkDomainObject", code: 0x646f6d6e, type: typeType) // "domn"
    public static let networkPreferences = SEVSymbol(name: "networkPreferences", code: 0x6e657470, type: typeType) // "netp"
    public static let networkPreferencesObject = SEVSymbol(name: "networkPreferencesObject", code: 0x6e65746f, type: typeType) // "neto"
    public static let November = SEVSymbol(name: "November", code: 0x6e6f7620, type: typeType) // "nov\0x20"
    public static let null = SEVSymbol(name: "null", code: 0x6e756c6c, type: typeType) // "null"
    public static let October = SEVSymbol(name: "October", code: 0x6f637420, type: typeType) // "oct\0x20"
    public static let optional_ = SEVSymbol(name: "optional_", code: 0x6f70746c, type: typeType) // "optl"
    public static let orientation = SEVSymbol(name: "orientation", code: 0x6f726965, type: typeType) // "orie"
    public static let outline = SEVSymbol(name: "outline", code: 0x6f75746c, type: typeType) // "outl"
    public static let packageFolder = SEVSymbol(name: "packageFolder", code: 0x706b6766, type: typeType) // "pkgf"
    public static let pagesAcross = SEVSymbol(name: "pagesAcross", code: 0x6c776c61, type: typeType) // "lwla"
    public static let pagesDown = SEVSymbol(name: "pagesDown", code: 0x6c776c64, type: typeType) // "lwld"
    public static let partitionSpaceUsed = SEVSymbol(name: "partitionSpaceUsed", code: 0x70757364, type: typeType) // "pusd"
    public static let path = SEVSymbol(name: "path", code: 0x70707468, type: typeType) // "ppth"
    public static let physicalSize = SEVSymbol(name: "physicalSize", code: 0x70687973, type: typeType) // "phys"
    public static let PICTPicture = SEVSymbol(name: "PICTPicture", code: 0x50494354, type: typeType) // "PICT"
    public static let picture = SEVSymbol(name: "picture", code: 0x70696350, type: typeType) // "picP"
    public static let pictureCD = SEVSymbol(name: "pictureCD", code: 0x64687063, type: typeType) // "dhpc"
    public static let pictureDisplayStyle = SEVSymbol(name: "pictureDisplayStyle", code: 0x70737479, type: typeType) // "psty"
    public static let picturePath = SEVSymbol(name: "picturePath", code: 0x70696370, type: typeType) // "picp"
    public static let pictureRotation = SEVSymbol(name: "pictureRotation", code: 0x63686e47, type: typeType) // "chnG"
    public static let picturesFolder = SEVSymbol(name: "picturesFolder", code: 0x70646f63, type: typeType) // "pdoc"
    public static let pixelMapRecord = SEVSymbol(name: "pixelMapRecord", code: 0x74706d6d, type: typeType) // "tpmm"
    public static let pluralName = SEVSymbol(name: "pluralName", code: 0x706c6e6d, type: typeType) // "plnm"
    public static let point = SEVSymbol(name: "point", code: 0x51447074, type: typeType) // "QDpt"
    public static let popOver = SEVSymbol(name: "popOver", code: 0x706f7076, type: typeType) // "popv"
    public static let popUpButton = SEVSymbol(name: "popUpButton", code: 0x706f7042, type: typeType) // "popB"
    public static let position = SEVSymbol(name: "position", code: 0x706f736e, type: typeType) // "posn"
    public static let POSIXPath = SEVSymbol(name: "POSIXPath", code: 0x706f7378, type: typeType) // "posx"
    public static let preferencesFolder = SEVSymbol(name: "preferencesFolder", code: 0x70726566, type: typeType) // "pref"
    public static let preferredRate = SEVSymbol(name: "preferredRate", code: 0x70726672, type: typeType) // "prfr"
    public static let preferredVolume = SEVSymbol(name: "preferredVolume", code: 0x70726676, type: typeType) // "prfv"
    public static let presentationMode = SEVSymbol(name: "presentationMode", code: 0x70726d64, type: typeType) // "prmd"
    public static let presentationSize = SEVSymbol(name: "presentationSize", code: 0x6d76737a, type: typeType) // "mvsz"
    public static let previewDuration = SEVSymbol(name: "previewDuration", code: 0x70767764, type: typeType) // "pvwd"
    public static let previewTime = SEVSymbol(name: "previewTime", code: 0x70767774, type: typeType) // "pvwt"
    public static let printSettings = SEVSymbol(name: "printSettings", code: 0x70736574, type: typeType) // "pset"
    public static let process = SEVSymbol(name: "process", code: 0x70726373, type: typeType) // "prcs"
    public static let processSerialNumber = SEVSymbol(name: "processSerialNumber", code: 0x70736e20, type: typeType) // "psn\0x20"
    public static let productVersion = SEVSymbol(name: "productVersion", code: 0x76657232, type: typeType) // "ver2"
    public static let progressIndicator = SEVSymbol(name: "progressIndicator", code: 0x70726f49, type: typeType) // "proI"
    public static let properties = SEVSymbol(name: "properties", code: 0x70414c4c, type: typeType) // "pALL"
    public static let property_ = SEVSymbol(name: "property_", code: 0x70726f70, type: typeType) // "prop"
    public static let propertyListFile = SEVSymbol(name: "propertyListFile", code: 0x706c6966, type: typeType) // "plif"
    public static let propertyListItem = SEVSymbol(name: "propertyListItem", code: 0x706c6969, type: typeType) // "plii"
    public static let publicFolder = SEVSymbol(name: "publicFolder", code: 0x70756262, type: typeType) // "pubb"
    public static let QuickTimeData = SEVSymbol(name: "QuickTimeData", code: 0x71746664, type: typeType) // "qtfd"
    public static let QuickTimeFile = SEVSymbol(name: "QuickTimeFile", code: 0x71746666, type: typeType) // "qtff"
    public static let quitDelay = SEVSymbol(name: "quitDelay", code: 0x7164656c, type: typeType) // "qdel"
    public static let radioButton = SEVSymbol(name: "radioButton", code: 0x72616442, type: typeType) // "radB"
    public static let radioGroup = SEVSymbol(name: "radioGroup", code: 0x72677270, type: typeType) // "rgrp"
    public static let randomOrder = SEVSymbol(name: "randomOrder", code: 0x72616e44, type: typeType) // "ranD"
    public static let real = SEVSymbol(name: "real", code: 0x646f7562, type: typeType) // "doub"
    public static let recentApplicationsLimit = SEVSymbol(name: "recentApplicationsLimit", code: 0x7261706c, type: typeType) // "rapl"
    public static let recentDocumentsLimit = SEVSymbol(name: "recentDocumentsLimit", code: 0x7264636c, type: typeType) // "rdcl"
    public static let recentServersLimit = SEVSymbol(name: "recentServersLimit", code: 0x7273766c, type: typeType) // "rsvl"
    public static let record = SEVSymbol(name: "record", code: 0x7265636f, type: typeType) // "reco"
    public static let reference = SEVSymbol(name: "reference", code: 0x6f626a20, type: typeType) // "obj\0x20"
    public static let relevanceIndicator = SEVSymbol(name: "relevanceIndicator", code: 0x72656c69, type: typeType) // "reli"
    public static let requestedPrintTime = SEVSymbol(name: "requestedPrintTime", code: 0x6c777174, type: typeType) // "lwqt"
    public static let requirePasswordToUnlock = SEVSymbol(name: "requirePasswordToUnlock", code: 0x7077756c, type: typeType) // "pwul"
    public static let requirePasswordToWake = SEVSymbol(name: "requirePasswordToWake", code: 0x7077776b, type: typeType) // "pwwk"
    public static let resizable = SEVSymbol(name: "resizable", code: 0x7072737a, type: typeType) // "prsz"
    public static let RGB16Color = SEVSymbol(name: "RGB16Color", code: 0x74723136, type: typeType) // "tr16"
    public static let RGB96Color = SEVSymbol(name: "RGB96Color", code: 0x74723936, type: typeType) // "tr96"
    public static let RGBColor = SEVSymbol(name: "RGBColor", code: 0x63524742, type: typeType) // "cRGB"
    public static let role = SEVSymbol(name: "role", code: 0x726f6c65, type: typeType) // "role"
    public static let roleDescription = SEVSymbol(name: "roleDescription", code: 0x726f6c64, type: typeType) // "rold"
    public static let rotation = SEVSymbol(name: "rotation", code: 0x74726f74, type: typeType) // "trot"
    public static let row = SEVSymbol(name: "row", code: 0x63726f77, type: typeType) // "crow"
    public static let running = SEVSymbol(name: "running", code: 0x72756e6e, type: typeType) // "runn"
    public static let Saturday = SEVSymbol(name: "Saturday", code: 0x73617420, type: typeType) // "sat\0x20"
    public static let screenEdge = SEVSymbol(name: "screenEdge", code: 0x64707365, type: typeType) // "dpse"
    public static let screenSaver = SEVSymbol(name: "screenSaver", code: 0x73737672, type: typeType) // "ssvr"
    public static let screenSaverPreferences = SEVSymbol(name: "screenSaverPreferences", code: 0x73737670, type: typeType) // "ssvp"
    public static let screenSaverPreferencesObject = SEVSymbol(name: "screenSaverPreferencesObject", code: 0x7373766f, type: typeType) // "ssvo"
    public static let script = SEVSymbol(name: "script", code: 0x73637074, type: typeType) // "scpt"
    public static let scriptingAdditionsFolder = SEVSymbol(name: "scriptingAdditionsFolder", code: 0x24736372, type: typeType) // "$scr"
    public static let scriptingClass = SEVSymbol(name: "scriptingClass", code: 0x7364636c, type: typeType) // "sdcl"
    public static let scriptingCommand = SEVSymbol(name: "scriptingCommand", code: 0x7364636d, type: typeType) // "sdcm"
    public static let scriptingDefinition = SEVSymbol(name: "scriptingDefinition", code: 0x73646566, type: typeType) // "sdef"
    public static let scriptingDefinitionObject = SEVSymbol(name: "scriptingDefinitionObject", code: 0x7364656f, type: typeType) // "sdeo"
    public static let scriptingElement = SEVSymbol(name: "scriptingElement", code: 0x7364656c, type: typeType) // "sdel"
    public static let scriptingEnumeration = SEVSymbol(name: "scriptingEnumeration", code: 0x7364656e, type: typeType) // "sden"
    public static let scriptingEnumerator = SEVSymbol(name: "scriptingEnumerator", code: 0x73646572, type: typeType) // "sder"
    public static let scriptingParameter = SEVSymbol(name: "scriptingParameter", code: 0x73647061, type: typeType) // "sdpa"
    public static let scriptingProperty = SEVSymbol(name: "scriptingProperty", code: 0x73647072, type: typeType) // "sdpr"
    public static let scriptingResult = SEVSymbol(name: "scriptingResult", code: 0x73647273, type: typeType) // "sdrs"
    public static let scriptingResultObject = SEVSymbol(name: "scriptingResultObject", code: 0x7364726f, type: typeType) // "sdro"
    public static let scriptingSuite = SEVSymbol(name: "scriptingSuite", code: 0x73647374, type: typeType) // "sdst"
    public static let scriptMenuEnabled = SEVSymbol(name: "scriptMenuEnabled", code: 0x73636d6e, type: typeType) // "scmn"
    public static let scriptsFolder = SEVSymbol(name: "scriptsFolder", code: 0x73637224, type: typeType) // "scr$"
    public static let scrollArea = SEVSymbol(name: "scrollArea", code: 0x73637261, type: typeType) // "scra"
    public static let scrollBar = SEVSymbol(name: "scrollBar", code: 0x73637262, type: typeType) // "scrb"
    public static let scrollBarAction = SEVSymbol(name: "scrollBarAction", code: 0x73636c62, type: typeType) // "sclb"
    public static let secureVirtualMemory = SEVSymbol(name: "secureVirtualMemory", code: 0x7363766d, type: typeType) // "scvm"
    public static let securityPreferences = SEVSymbol(name: "securityPreferences", code: 0x73656370, type: typeType) // "secp"
    public static let securityPreferencesObject = SEVSymbol(name: "securityPreferencesObject", code: 0x7365636f, type: typeType) // "seco"
    public static let selected = SEVSymbol(name: "selected", code: 0x73656c45, type: typeType) // "selE"
    public static let September = SEVSymbol(name: "September", code: 0x73657020, type: typeType) // "sep\0x20"
    public static let server = SEVSymbol(name: "server", code: 0x73727672, type: typeType) // "srvr"
    public static let service = SEVSymbol(name: "service", code: 0x73766365, type: typeType) // "svce"
    public static let settable = SEVSymbol(name: "settable", code: 0x7374626c, type: typeType) // "stbl"
    public static let sharedDocumentsFolder = SEVSymbol(name: "sharedDocumentsFolder", code: 0x73646174, type: typeType) // "sdat"
    public static let sheet = SEVSymbol(name: "sheet", code: 0x73686545, type: typeType) // "sheE"
    public static let shortInteger = SEVSymbol(name: "shortInteger", code: 0x73686f72, type: typeType) // "shor"
    public static let shortName = SEVSymbol(name: "shortName", code: 0x6366626e, type: typeType) // "cfbn"
    public static let shortVersion = SEVSymbol(name: "shortVersion", code: 0x61737376, type: typeType) // "assv"
    public static let showClock = SEVSymbol(name: "showClock", code: 0x7368636c, type: typeType) // "shcl"
    public static let shutdownFolder = SEVSymbol(name: "shutdownFolder", code: 0x73686466, type: typeType) // "shdf"
    public static let sitesFolder = SEVSymbol(name: "sitesFolder", code: 0x73697465, type: typeType) // "site"
    public static let size = SEVSymbol(name: "size", code: 0x7074737a, type: typeType) // "ptsz"
    public static let slider = SEVSymbol(name: "slider", code: 0x736c6949, type: typeType) // "sliI"
    public static let smallReal = SEVSymbol(name: "smallReal", code: 0x73696e67, type: typeType) // "sing"
    public static let smoothScrolling = SEVSymbol(name: "smoothScrolling", code: 0x73636c73, type: typeType) // "scls"
    public static let speakableItemsFolder = SEVSymbol(name: "speakableItemsFolder", code: 0x73706b69, type: typeType) // "spki"
    public static let speed = SEVSymbol(name: "speed", code: 0x73706564, type: typeType) // "sped"
    public static let splitter = SEVSymbol(name: "splitter", code: 0x73706c72, type: typeType) // "splr"
    public static let splitterGroup = SEVSymbol(name: "splitterGroup", code: 0x73706c67, type: typeType) // "splg"
    public static let startingPage = SEVSymbol(name: "startingPage", code: 0x6c776670, type: typeType) // "lwfp"
    public static let startTime = SEVSymbol(name: "startTime", code: 0x6f666673, type: typeType) // "offs"
    public static let startup = SEVSymbol(name: "startup", code: 0x69737464, type: typeType) // "istd"
    public static let startupDisk = SEVSymbol(name: "startupDisk", code: 0x7364736b, type: typeType) // "sdsk"
    public static let startupItemsFolder = SEVSymbol(name: "startupItemsFolder", code: 0x656d707a, type: typeType) // "empz"
    public static let staticText = SEVSymbol(name: "staticText", code: 0x73747478, type: typeType) // "sttx"
    public static let stationery = SEVSymbol(name: "stationery", code: 0x70737064, type: typeType) // "pspd"
    public static let storedStream = SEVSymbol(name: "storedStream", code: 0x69737373, type: typeType) // "isss"
    public static let string = SEVSymbol(name: "string", code: 0x54455854, type: typeType) // "TEXT"
    public static let styledClipboardText = SEVSymbol(name: "styledClipboardText", code: 0x7374796c, type: typeType) // "styl"
    public static let styledText = SEVSymbol(name: "styledText", code: 0x53545854, type: typeType) // "STXT"
    public static let subrole = SEVSymbol(name: "subrole", code: 0x7362726c, type: typeType) // "sbrl"
    public static let suiteName = SEVSymbol(name: "suiteName", code: 0x73746e6d, type: typeType) // "stnm"
    public static let Sunday = SEVSymbol(name: "Sunday", code: 0x73756e20, type: typeType) // "sun\0x20"
    public static let superclass = SEVSymbol(name: "superclass", code: 0x73757065, type: typeType) // "supe"
    public static let systemDomain = SEVSymbol(name: "systemDomain", code: 0x666c6473, type: typeType) // "flds"
    public static let systemDomainObject = SEVSymbol(name: "systemDomainObject", code: 0x646f6d73, type: typeType) // "doms"
    public static let systemFolder = SEVSymbol(name: "systemFolder", code: 0x6d616373, type: typeType) // "macs"
    public static let tabGroup = SEVSymbol(name: "tabGroup", code: 0x74616267, type: typeType) // "tabg"
    public static let table = SEVSymbol(name: "table", code: 0x74616242, type: typeType) // "tabB"
    public static let targetPrinter = SEVSymbol(name: "targetPrinter", code: 0x74727072, type: typeType) // "trpr"
    public static let temporaryItemsFolder = SEVSymbol(name: "temporaryItemsFolder", code: 0x74656d70, type: typeType) // "temp"
    public static let textArea = SEVSymbol(name: "textArea", code: 0x74787461, type: typeType) // "txta"
    public static let textField = SEVSymbol(name: "textField", code: 0x74787466, type: typeType) // "txtf"
    public static let textStyleInfo = SEVSymbol(name: "textStyleInfo", code: 0x74737479, type: typeType) // "tsty"
    public static let Thursday = SEVSymbol(name: "Thursday", code: 0x74687520, type: typeType) // "thu\0x20"
    public static let TIFFPicture = SEVSymbol(name: "TIFFPicture", code: 0x54494646, type: typeType) // "TIFF"
    public static let timeScale = SEVSymbol(name: "timeScale", code: 0x746d7363, type: typeType) // "tmsc"
    public static let title = SEVSymbol(name: "title", code: 0x7469746c, type: typeType) // "titl"
    public static let toolbar = SEVSymbol(name: "toolbar", code: 0x74626172, type: typeType) // "tbar"
    public static let totalPartitionSize = SEVSymbol(name: "totalPartitionSize", code: 0x61707074, type: typeType) // "appt"
    public static let track = SEVSymbol(name: "track", code: 0x7472616b, type: typeType) // "trak"
    public static let translucentMenuBar = SEVSymbol(name: "translucentMenuBar", code: 0x6d6e5472, type: typeType) // "mnTr"
    public static let trash = SEVSymbol(name: "trash", code: 0x74727368, type: typeType) // "trsh"
    public static let Tuesday = SEVSymbol(name: "Tuesday", code: 0x74756520, type: typeType) // "tue\0x20"
    public static let type = SEVSymbol(name: "type", code: 0x70747970, type: typeType) // "ptyp"
    public static let typeClass = SEVSymbol(name: "typeClass", code: 0x74797065, type: typeType) // "type"
    public static let typeIdentifier = SEVSymbol(name: "typeIdentifier", code: 0x75746964, type: typeType) // "utid"
    public static let UIElement = SEVSymbol(name: "UIElement", code: 0x7569656c, type: typeType) // "uiel"
    public static let UIElementsEnabled = SEVSymbol(name: "UIElementsEnabled", code: 0x7569656e, type: typeType) // "uien"
    public static let UnicodeText = SEVSymbol(name: "UnicodeText", code: 0x75747874, type: typeType) // "utxt"
    public static let unixId = SEVSymbol(name: "unixId", code: 0x69647578, type: typeType) // "idux"
    public static let unsignedDoubleInteger = SEVSymbol(name: "unsignedDoubleInteger", code: 0x75636f6d, type: typeType) // "ucom"
    public static let unsignedInteger = SEVSymbol(name: "unsignedInteger", code: 0x6d61676e, type: typeType) // "magn"
    public static let unsignedShortInteger = SEVSymbol(name: "unsignedShortInteger", code: 0x75736872, type: typeType) // "ushr"
    public static let URL = SEVSymbol(name: "URL", code: 0x75726c20, type: typeType) // "url\0x20"
    public static let user = SEVSymbol(name: "user", code: 0x75616363, type: typeType) // "uacc"
    public static let userDomain = SEVSymbol(name: "userDomain", code: 0x666c6475, type: typeType) // "fldu"
    public static let userDomainObject = SEVSymbol(name: "userDomainObject", code: 0x646f6d75, type: typeType) // "domu"
    public static let UTF16Text = SEVSymbol(name: "UTF16Text", code: 0x75743136, type: typeType) // "ut16"
    public static let UTF8Text = SEVSymbol(name: "UTF8Text", code: 0x75746638, type: typeType) // "utf8"
    public static let utilitiesFolder = SEVSymbol(name: "utilitiesFolder", code: 0x75746924, type: typeType) // "uti$"
    public static let value = SEVSymbol(name: "value", code: 0x76616c4c, type: typeType) // "valL"
    public static let valueIndicator = SEVSymbol(name: "valueIndicator", code: 0x76616c69, type: typeType) // "vali"
    public static let version = SEVSymbol(name: "version", code: 0x76657273, type: typeType) // "vers"
    public static let videoBD = SEVSymbol(name: "videoBD", code: 0x64687662, type: typeType) // "dhvb"
    public static let videoDepth = SEVSymbol(name: "videoDepth", code: 0x76636470, type: typeType) // "vcdp"
    public static let videoDVD = SEVSymbol(name: "videoDVD", code: 0x64687664, type: typeType) // "dhvd"
    public static let visible = SEVSymbol(name: "visible", code: 0x70766973, type: typeType) // "pvis"
    public static let visualCharacteristic = SEVSymbol(name: "visualCharacteristic", code: 0x76697375, type: typeType) // "visu"
    public static let volume = SEVSymbol(name: "volume", code: 0x766f6c75, type: typeType) // "volu"
    public static let Wednesday = SEVSymbol(name: "Wednesday", code: 0x77656420, type: typeType) // "wed\0x20"
    public static let window = SEVSymbol(name: "window", code: 0x6377696e, type: typeType) // "cwin"
    public static let workflowsFolder = SEVSymbol(name: "workflowsFolder", code: 0x666c6f77, type: typeType) // "flow"
    public static let writingCode = SEVSymbol(name: "writingCode", code: 0x70736374, type: typeType) // "psct"
    public static let XMLAttribute = SEVSymbol(name: "XMLAttribute", code: 0x786d6c61, type: typeType) // "xmla"
    public static let XMLData = SEVSymbol(name: "XMLData", code: 0x786d6c64, type: typeType) // "xmld"
    public static let XMLElement = SEVSymbol(name: "XMLElement", code: 0x786d6c65, type: typeType) // "xmle"
    public static let XMLFile = SEVSymbol(name: "XMLFile", code: 0x786d6c66, type: typeType) // "xmlf"
    public static let zone = SEVSymbol(name: "zone", code: 0x7a6f6e65, type: typeType) // "zone"
    public static let zoomable = SEVSymbol(name: "zoomable", code: 0x69737a6d, type: typeType) // "iszm"
    public static let zoomed = SEVSymbol(name: "zoomed", code: 0x707a756d, type: typeType) // "pzum"

    // Enumerators
    public static let ApplePhotoFormat = SEVSymbol(name: "ApplePhotoFormat", code: 0x64667068, type: typeEnumerated) // "dfph"
    public static let AppleShareFormat = SEVSymbol(name: "AppleShareFormat", code: 0x64666173, type: typeEnumerated) // "dfas"
    public static let ask = SEVSymbol(name: "ask", code: 0x61736b20, type: typeEnumerated) // "ask\0x20"
    public static let askWhatToDo = SEVSymbol(name: "askWhatToDo", code: 0x64686173, type: typeEnumerated) // "dhas"
    public static let audioFormat = SEVSymbol(name: "audioFormat", code: 0x64666175, type: typeEnumerated) // "dfau"
    public static let automatic = SEVSymbol(name: "automatic", code: 0x6175746d, type: typeEnumerated) // "autm"
    public static let blue = SEVSymbol(name: "blue", code: 0x626c7565, type: typeEnumerated) // "blue"
    public static let bottom = SEVSymbol(name: "bottom", code: 0x626f7474, type: typeEnumerated) // "bott"
    public static let case_ = SEVSymbol(name: "case_", code: 0x63617365, type: typeEnumerated) // "case"
    public static let command = SEVSymbol(name: "command", code: 0x65436d64, type: typeEnumerated) // "eCmd"
    public static let commandDown = SEVSymbol(name: "commandDown", code: 0x4b636d64, type: typeEnumerated) // "Kcmd"
    public static let control = SEVSymbol(name: "control", code: 0x65436e74, type: typeEnumerated) // "eCnt"
    public static let controlDown = SEVSymbol(name: "controlDown", code: 0x4b63746c, type: typeEnumerated) // "Kctl"
    public static let current = SEVSymbol(name: "current", code: 0x63757374, type: typeEnumerated) // "cust"
    public static let detailed = SEVSymbol(name: "detailed", code: 0x6c776474, type: typeEnumerated) // "lwdt"
    public static let diacriticals = SEVSymbol(name: "diacriticals", code: 0x64696163, type: typeEnumerated) // "diac"
    public static let double = SEVSymbol(name: "double", code: 0x646f7562, type: typeEnumerated) // "doub"
    public static let expansion = SEVSymbol(name: "expansion", code: 0x65787061, type: typeEnumerated) // "expa"
    public static let genie = SEVSymbol(name: "genie", code: 0x67656e69, type: typeEnumerated) // "geni"
    public static let gold = SEVSymbol(name: "gold", code: 0x676f6c64, type: typeEnumerated) // "gold"
    public static let graphite = SEVSymbol(name: "graphite", code: 0x67726674, type: typeEnumerated) // "grft"
    public static let green = SEVSymbol(name: "green", code: 0x6772656e, type: typeEnumerated) // "gren"
    public static let half = SEVSymbol(name: "half", code: 0x68616c66, type: typeEnumerated) // "half"
    public static let HighSierraFormat = SEVSymbol(name: "HighSierraFormat", code: 0x64666873, type: typeEnumerated) // "dfhs"
    public static let hyphens = SEVSymbol(name: "hyphens", code: 0x68797068, type: typeEnumerated) // "hyph"
    public static let ignore = SEVSymbol(name: "ignore", code: 0x64686967, type: typeEnumerated) // "dhig"
    public static let ISO9660Format = SEVSymbol(name: "ISO9660Format", code: 0x64663936, type: typeEnumerated) // "df96"
    public static let itemsAdded = SEVSymbol(name: "itemsAdded", code: 0x66676574, type: typeEnumerated) // "fget"
    public static let itemsRemoved = SEVSymbol(name: "itemsRemoved", code: 0x666c6f73, type: typeEnumerated) // "flos"
    public static let jumpToHere = SEVSymbol(name: "jumpToHere", code: 0x746f6872, type: typeEnumerated) // "tohr"
    public static let jumpToNextPage = SEVSymbol(name: "jumpToNextPage", code: 0x6e787067, type: typeEnumerated) // "nxpg"
    public static let left = SEVSymbol(name: "left", code: 0x6c656674, type: typeEnumerated) // "left"
    public static let light = SEVSymbol(name: "light", code: 0x6c697465, type: typeEnumerated) // "lite"
    public static let MacOSExtendedFormat = SEVSymbol(name: "MacOSExtendedFormat", code: 0x6466682b, type: typeEnumerated) // "dfh+"
    public static let MacOSFormat = SEVSymbol(name: "MacOSFormat", code: 0x64666866, type: typeEnumerated) // "dfhf"
    public static let medium = SEVSymbol(name: "medium", code: 0x6d656469, type: typeEnumerated) // "medi"
    public static let MSDOSFormat = SEVSymbol(name: "MSDOSFormat", code: 0x64666d73, type: typeEnumerated) // "dfms"
    public static let NFSFormat = SEVSymbol(name: "NFSFormat", code: 0x64666e66, type: typeEnumerated) // "dfnf"
    public static let no = SEVSymbol(name: "no", code: 0x6e6f2020, type: typeEnumerated) // "no\0x20\0x20"
    public static let none = SEVSymbol(name: "none", code: 0x6e6f6e65, type: typeEnumerated) // "none"
    public static let normal = SEVSymbol(name: "normal", code: 0x6e6f726d, type: typeEnumerated) // "norm"
    public static let numericStrings = SEVSymbol(name: "numericStrings", code: 0x6e756d65, type: typeEnumerated) // "nume"
    public static let openApplication = SEVSymbol(name: "openApplication", code: 0x64686170, type: typeEnumerated) // "dhap"
    public static let option = SEVSymbol(name: "option", code: 0x654f7074, type: typeEnumerated) // "eOpt"
    public static let optionDown = SEVSymbol(name: "optionDown", code: 0x4b6f7074, type: typeEnumerated) // "Kopt"
    public static let orange = SEVSymbol(name: "orange", code: 0x6f726e67, type: typeEnumerated) // "orng"
    public static let ProDOSFormat = SEVSymbol(name: "ProDOSFormat", code: 0x64667072, type: typeEnumerated) // "dfpr"
    public static let punctuation = SEVSymbol(name: "punctuation", code: 0x70756e63, type: typeEnumerated) // "punc"
    public static let purple = SEVSymbol(name: "purple", code: 0x7072706c, type: typeEnumerated) // "prpl"
    public static let QuickTakeFormat = SEVSymbol(name: "QuickTakeFormat", code: 0x64667174, type: typeEnumerated) // "dfqt"
    public static let readOnly = SEVSymbol(name: "readOnly", code: 0x72656164, type: typeEnumerated) // "read"
    public static let readWrite = SEVSymbol(name: "readWrite", code: 0x72647772, type: typeEnumerated) // "rdwr"
    public static let red = SEVSymbol(name: "red", code: 0x72656420, type: typeEnumerated) // "red\0x20"
    public static let right = SEVSymbol(name: "right", code: 0x72696768, type: typeEnumerated) // "righ"
    public static let runAScript = SEVSymbol(name: "runAScript", code: 0x64687273, type: typeEnumerated) // "dhrs"
    public static let scale = SEVSymbol(name: "scale", code: 0x7363616c, type: typeEnumerated) // "scal"
    public static let screen = SEVSymbol(name: "screen", code: 0x66697473, type: typeEnumerated) // "fits"
    public static let shift = SEVSymbol(name: "shift", code: 0x65536674, type: typeEnumerated) // "eSft"
    public static let shiftDown = SEVSymbol(name: "shiftDown", code: 0x4b736674, type: typeEnumerated) // "Ksft"
    public static let silver = SEVSymbol(name: "silver", code: 0x736c7672, type: typeEnumerated) // "slvr"
    public static let slideShow = SEVSymbol(name: "slideShow", code: 0x706d7373, type: typeEnumerated) // "pmss"
    public static let standard = SEVSymbol(name: "standard", code: 0x6c777374, type: typeEnumerated) // "lwst"
    public static let strong = SEVSymbol(name: "strong", code: 0x73747267, type: typeEnumerated) // "strg"
    public static let text = SEVSymbol(name: "text", code: 0x63747874, type: typeEnumerated) // "ctxt"
    public static let UDFFormat = SEVSymbol(name: "UDFFormat", code: 0x64667564, type: typeEnumerated) // "dfud"
    public static let UFSFormat = SEVSymbol(name: "UFSFormat", code: 0x64667566, type: typeEnumerated) // "dfuf"
    public static let unknownFormat = SEVSymbol(name: "unknownFormat", code: 0x64662424, type: typeEnumerated) // "df$$"
    public static let WebDAVFormat = SEVSymbol(name: "WebDAVFormat", code: 0x64667764, type: typeEnumerated) // "dfwd"
    public static let whitespace = SEVSymbol(name: "whitespace", code: 0x77686974, type: typeEnumerated) // "whit"
    public static let windowClosed = SEVSymbol(name: "windowClosed", code: 0x66636c6f, type: typeEnumerated) // "fclo"
    public static let windowMoved = SEVSymbol(name: "windowMoved", code: 0x6673697a, type: typeEnumerated) // "fsiz"
    public static let windowOpened = SEVSymbol(name: "windowOpened", code: 0x666f706e, type: typeEnumerated) // "fopn"
    public static let writeOnly = SEVSymbol(name: "writeOnly", code: 0x77726974, type: typeEnumerated) // "writ"
    public static let yes = SEVSymbol(name: "yes", code: 0x79657320, type: typeEnumerated) // "yes\0x20"
}

public typealias SEV = SEVSymbol // allows symbols to be written as (e.g.) SEV.name instead of SEVSymbol.name


/******************************************************************************/
// Specifier extensions; these add command methods and property/elements getters based on System Events.app terminology

public protocol SEVCommand: SwiftAutomation.SpecifierProtocol {} // provides AE dispatch methods

// Command->Any will be bound when return type can't be inferred, else Command->T

extension SEVCommand {
    @discardableResult public func abortTransaction(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "abortTransaction", eventClass: 0x6d697363, eventID: 0x7474726d, // "misc"/"ttrm"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func abortTransaction<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "abortTransaction", eventClass: 0x6d697363, eventID: 0x7474726d, // "misc"/"ttrm"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
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
    @discardableResult public func attachActionTo(_ directParameter: Any = SwiftAutomation.NoParameter,
            using: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "attachActionTo", eventClass: 0x6661636f, eventID: 0x61746661, // "faco"/"atfa"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("using", 0x6661616c, using), // "faal"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func attachActionTo<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            using: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "attachActionTo", eventClass: 0x6661636f, eventID: 0x61746661, // "faco"/"atfa"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("using", 0x6661616c, using), // "faal"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func attachedScripts(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "attachedScripts", eventClass: 0x6661636f, eventID: 0x6c616374, // "faco"/"lact"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func attachedScripts<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "attachedScripts", eventClass: 0x6661636f, eventID: 0x6c616374, // "faco"/"lact"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func beginTransaction(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "beginTransaction", eventClass: 0x6d697363, eventID: 0x62656769, // "misc"/"begi"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func beginTransaction<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "beginTransaction", eventClass: 0x6d697363, eventID: 0x62656769, // "misc"/"begi"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func cancel(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "cancel", eventClass: 0x70726373, eventID: 0x636e636c, // "prcs"/"cncl"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func cancel<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "cancel", eventClass: 0x70726373, eventID: 0x636e636c, // "prcs"/"cncl"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func click(_ directParameter: Any = SwiftAutomation.NoParameter,
            at: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "click", eventClass: 0x70726373, eventID: 0x636c6963, // "prcs"/"clic"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("at", 0x696e7368, at), // "insh"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func click<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            at: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "click", eventClass: 0x70726373, eventID: 0x636c6963, // "prcs"/"clic"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("at", 0x696e7368, at), // "insh"
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
    @discardableResult public func confirm(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "confirm", eventClass: 0x70726373, eventID: 0x636e666d, // "prcs"/"cnfm"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func confirm<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "confirm", eventClass: 0x70726373, eventID: 0x636e666d, // "prcs"/"cnfm"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func connect(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "connect", eventClass: 0x6e65747a, eventID: 0x636f6e6e, // "netz"/"conn"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func connect<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "connect", eventClass: 0x6e65747a, eventID: 0x636f6e6e, // "netz"/"conn"
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
    @discardableResult public func decrement(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "decrement", eventClass: 0x70726373, eventID: 0x64656372, // "prcs"/"decr"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func decrement<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "decrement", eventClass: 0x70726373, eventID: 0x64656372, // "prcs"/"decr"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
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
    @discardableResult public func disconnect(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "disconnect", eventClass: 0x6e65747a, eventID: 0x64636f6e, // "netz"/"dcon"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func disconnect<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "disconnect", eventClass: 0x6e65747a, eventID: 0x64636f6e, // "netz"/"dcon"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func doFolderAction(_ directParameter: Any = SwiftAutomation.NoParameter,
            folderActionCode: Any = SwiftAutomation.NoParameter,
            withItemList: Any = SwiftAutomation.NoParameter,
            withWindowSize: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "doFolderAction", eventClass: 0x6661636f, eventID: 0x666f6c61, // "faco"/"fola"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("folderActionCode", 0x6163746e, folderActionCode), // "actn"
                    ("withItemList", 0x666c7374, withItemList), // "flst"
                    ("withWindowSize", 0x666e737a, withWindowSize), // "fnsz"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func doFolderAction<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            folderActionCode: Any = SwiftAutomation.NoParameter,
            withItemList: Any = SwiftAutomation.NoParameter,
            withWindowSize: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "doFolderAction", eventClass: 0x6661636f, eventID: 0x666f6c61, // "faco"/"fola"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("folderActionCode", 0x6163746e, folderActionCode), // "actn"
                    ("withItemList", 0x666c7374, withItemList), // "flst"
                    ("withWindowSize", 0x666e737a, withWindowSize), // "fnsz"
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
    @discardableResult public func editActionOf(_ directParameter: Any = SwiftAutomation.NoParameter,
            usingActionName: Any = SwiftAutomation.NoParameter,
            usingActionNumber: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "editActionOf", eventClass: 0x6661636f, eventID: 0x65646661, // "faco"/"edfa"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("usingActionName", 0x736e616d, usingActionName), // "snam"
                    ("usingActionNumber", 0x696e6478, usingActionNumber), // "indx"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func editActionOf<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            usingActionName: Any = SwiftAutomation.NoParameter,
            usingActionNumber: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "editActionOf", eventClass: 0x6661636f, eventID: 0x65646661, // "faco"/"edfa"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("usingActionName", 0x736e616d, usingActionName), // "snam"
                    ("usingActionNumber", 0x696e6478, usingActionNumber), // "indx"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func enable(_ directParameter: Any = SwiftAutomation.NoParameter,
            processNewChanges: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "enable", eventClass: 0x6661636f, eventID: 0x656e626c, // "faco"/"enbl"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("processNewChanges", 0x70726e63, processNewChanges), // "prnc"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func enable<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            processNewChanges: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "enable", eventClass: 0x6661636f, eventID: 0x656e626c, // "faco"/"enbl"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("processNewChanges", 0x70726e63, processNewChanges), // "prnc"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func endTransaction(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "endTransaction", eventClass: 0x6d697363, eventID: 0x656e6474, // "misc"/"endt"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func endTransaction<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "endTransaction", eventClass: 0x6d697363, eventID: 0x656e6474, // "misc"/"endt"
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
    @discardableResult public func increment(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "increment", eventClass: 0x70726373, eventID: 0x696e6345, // "prcs"/"incE"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func increment<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "increment", eventClass: 0x70726373, eventID: 0x696e6345, // "prcs"/"incE"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func keyCode(_ directParameter: Any = SwiftAutomation.NoParameter,
            using: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "keyCode", eventClass: 0x70726373, eventID: 0x6b636f64, // "prcs"/"kcod"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("using", 0x6661616c, using), // "faal"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func keyCode<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            using: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "keyCode", eventClass: 0x70726373, eventID: 0x6b636f64, // "prcs"/"kcod"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("using", 0x6661616c, using), // "faal"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func keyDown(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "keyDown", eventClass: 0x70726373, eventID: 0x6b657946, // "prcs"/"keyF"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func keyDown<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "keyDown", eventClass: 0x70726373, eventID: 0x6b657946, // "prcs"/"keyF"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func keystroke(_ directParameter: Any = SwiftAutomation.NoParameter,
            using: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "keystroke", eventClass: 0x70726373, eventID: 0x6b707273, // "prcs"/"kprs"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("using", 0x6661616c, using), // "faal"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func keystroke<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            using: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "keystroke", eventClass: 0x70726373, eventID: 0x6b707273, // "prcs"/"kprs"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("using", 0x6661616c, using), // "faal"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func keyUp(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "keyUp", eventClass: 0x70726373, eventID: 0x6b657955, // "prcs"/"keyU"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func keyUp<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "keyUp", eventClass: 0x70726373, eventID: 0x6b657955, // "prcs"/"keyU"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func logOut(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "logOut", eventClass: 0x666e6472, eventID: 0x6c6f676f, // "fndr"/"logo"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func logOut<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "logOut", eventClass: 0x666e6472, eventID: 0x6c6f676f, // "fndr"/"logo"
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
    @discardableResult public func perform(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "perform", eventClass: 0x70726373, eventID: 0x70657266, // "prcs"/"perf"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func perform<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "perform", eventClass: 0x70726373, eventID: 0x70657266, // "prcs"/"perf"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func pick(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "pick", eventClass: 0x70726373, eventID: 0x7069636b, // "prcs"/"pick"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func pick<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "pick", eventClass: 0x70726373, eventID: 0x7069636b, // "prcs"/"pick"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
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
    @discardableResult public func removeActionFrom(_ directParameter: Any = SwiftAutomation.NoParameter,
            usingActionName: Any = SwiftAutomation.NoParameter,
            usingActionNumber: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "removeActionFrom", eventClass: 0x6661636f, eventID: 0x726d6661, // "faco"/"rmfa"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("usingActionName", 0x736e616d, usingActionName), // "snam"
                    ("usingActionNumber", 0x696e6478, usingActionNumber), // "indx"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func removeActionFrom<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            usingActionName: Any = SwiftAutomation.NoParameter,
            usingActionNumber: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "removeActionFrom", eventClass: 0x6661636f, eventID: 0x726d6661, // "faco"/"rmfa"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("usingActionName", 0x736e616d, usingActionName), // "snam"
                    ("usingActionNumber", 0x696e6478, usingActionNumber), // "indx"
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
            stateSavingPreference: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "restart", eventClass: 0x666e6472, eventID: 0x72657374, // "fndr"/"rest"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("stateSavingPreference", 0x73747376, stateSavingPreference), // "stsv"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func restart<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            stateSavingPreference: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "restart", eventClass: 0x666e6472, eventID: 0x72657374, // "fndr"/"rest"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("stateSavingPreference", 0x73747376, stateSavingPreference), // "stsv"
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
            in_: Any = SwiftAutomation.NoParameter,
            as_: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "save", eventClass: 0x636f7265, eventID: 0x73617665, // "core"/"save"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("in_", 0x6b66696c, in_), // "kfil"
                    ("as_", 0x666c7470, as_), // "fltp"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func save<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            in_: Any = SwiftAutomation.NoParameter,
            as_: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "save", eventClass: 0x636f7265, eventID: 0x73617665, // "core"/"save"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("in_", 0x6b66696c, in_), // "kfil"
                    ("as_", 0x666c7470, as_), // "fltp"
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
            stateSavingPreference: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "shutDown", eventClass: 0x666e6472, eventID: 0x73687574, // "fndr"/"shut"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("stateSavingPreference", 0x73747376, stateSavingPreference), // "stsv"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func shutDown<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            stateSavingPreference: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "shutDown", eventClass: 0x666e6472, eventID: 0x73687574, // "fndr"/"shut"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("stateSavingPreference", 0x73747376, stateSavingPreference), // "stsv"
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
    @discardableResult public func start(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "start", eventClass: 0x73637376, eventID: 0x73747274, // "scsv"/"strt"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func start<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "start", eventClass: 0x73637376, eventID: 0x73747274, // "scsv"/"strt"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func stop(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "stop", eventClass: 0x73637376, eventID: 0x73746f70, // "scsv"/"stop"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func stop<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "stop", eventClass: 0x73637376, eventID: 0x73746f70, // "scsv"/"stop"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
}


public protocol SEVObject: SwiftAutomation.ObjectSpecifierExtension, SEVCommand {} // provides vars and methods for constructing specifiers

extension SEVObject {
    
    // Properties
    public var acceptsHighLevelEvents: SEVItem {return self.property(0x69736162) as! SEVItem} // "isab"
    public var acceptsRemoteEvents: SEVItem {return self.property(0x72657674) as! SEVItem} // "revt"
    public var access: SEVItem {return self.property(0x61636373) as! SEVItem} // "accs"
    public var accessibilityDescription: SEVItem {return self.property(0x61786473) as! SEVItem} // "axds"
    public var accountName: SEVItem {return self.property(0x75736572) as! SEVItem} // "user"
    public var active: SEVItem {return self.property(0x61637469) as! SEVItem} // "acti"
    public var animate: SEVItem {return self.property(0x64616e69) as! SEVItem} // "dani"
    public var appearance: SEVItem {return self.property(0x61707065) as! SEVItem} // "appe"
    public var appearancePreferences: SEVItem {return self.property(0x61707270) as! SEVItem} // "aprp"
    public var appleMenuFolder: SEVItem {return self.property(0x616d6e75) as! SEVItem} // "amnu"
    public var applicationFile: SEVItem {return self.property(0x61707066) as! SEVItem} // "appf"
    public var applicationsFolder: SEVItem {return self.property(0x61707073) as! SEVItem} // "apps"
    public var applicationSupportFolder: SEVItem {return self.property(0x61737570) as! SEVItem} // "asup"
    public var architecture: SEVItem {return self.property(0x61726368) as! SEVItem} // "arch"
    public var audioChannelCount: SEVItem {return self.property(0x61636861) as! SEVItem} // "acha"
    public var audioCharacteristic: SEVItem {return self.property(0x61756469) as! SEVItem} // "audi"
    public var audioSampleRate: SEVItem {return self.property(0x61737261) as! SEVItem} // "asra"
    public var audioSampleSize: SEVItem {return self.property(0x6173737a) as! SEVItem} // "assz"
    public var autohide: SEVItem {return self.property(0x64616864) as! SEVItem} // "dahd"
    public var automatic: SEVItem {return self.property(0x6175746f) as! SEVItem} // "auto"
    public var automaticLogin: SEVItem {return self.property(0x61756c67) as! SEVItem} // "aulg"
    public var autoPlay: SEVItem {return self.property(0x61757470) as! SEVItem} // "autp"
    public var autoPresent: SEVItem {return self.property(0x61707265) as! SEVItem} // "apre"
    public var autoQuitWhenDone: SEVItem {return self.property(0x61717569) as! SEVItem} // "aqui"
    public var backgroundOnly: SEVItem {return self.property(0x626b676f) as! SEVItem} // "bkgo"
    public var blankBD: SEVItem {return self.property(0x64686262) as! SEVItem} // "dhbb"
    public var blankCD: SEVItem {return self.property(0x64686263) as! SEVItem} // "dhbc"
    public var blankDVD: SEVItem {return self.property(0x64686264) as! SEVItem} // "dhbd"
    public var bounds: SEVItem {return self.property(0x70626e64) as! SEVItem} // "pbnd"
    public var bundleIdentifier: SEVItem {return self.property(0x626e6964) as! SEVItem} // "bnid"
    public var busyStatus: SEVItem {return self.property(0x62757379) as! SEVItem} // "busy"
    public var capacity: SEVItem {return self.property(0x63617061) as! SEVItem} // "capa"
    public var CDAndDVDPreferences: SEVItem {return self.property(0x64686173) as! SEVItem} // "dhas"
    public var changeInterval: SEVItem {return self.property(0x63696e54) as! SEVItem} // "cinT"
    public var class_: SEVItem {return self.property(0x70636c73) as! SEVItem} // "pcls"
    public var Classic: SEVItem {return self.property(0x636c7363) as! SEVItem} // "clsc"
    public var ClassicDomain: SEVItem {return self.property(0x666c6463) as! SEVItem} // "fldc"
    public var closeable: SEVItem {return self.property(0x68636c62) as! SEVItem} // "hclb"
    public var collating: SEVItem {return self.property(0x6c77636c) as! SEVItem} // "lwcl"
    public var connected: SEVItem {return self.property(0x636f6e6e) as! SEVItem} // "conn"
    public var container: SEVItem {return self.property(0x63746e72) as! SEVItem} // "ctnr"
    public var controlPanelsFolder: SEVItem {return self.property(0x6374726c) as! SEVItem} // "ctrl"
    public var controlStripModulesFolder: SEVItem {return self.property(0x73646576) as! SEVItem} // "sdev"
    public var copies: SEVItem {return self.property(0x6c776370) as! SEVItem} // "lwcp"
    public var creationDate: SEVItem {return self.property(0x61736364) as! SEVItem} // "ascd"
    public var creationTime: SEVItem {return self.property(0x6d646372) as! SEVItem} // "mdcr"
    public var creatorType: SEVItem {return self.property(0x66637274) as! SEVItem} // "fcrt"
    public var currentConfiguration: SEVItem {return self.property(0x636e6667) as! SEVItem} // "cnfg"
    public var currentDesktop: SEVItem {return self.property(0x63757264) as! SEVItem} // "curd"
    public var currentLocation: SEVItem {return self.property(0x6c6f6363) as! SEVItem} // "locc"
    public var currentScreenSaver: SEVItem {return self.property(0x73737663) as! SEVItem} // "ssvc"
    public var currentUser: SEVItem {return self.property(0x63757275) as! SEVItem} // "curu"
    public var customApplication: SEVItem {return self.property(0x64686361) as! SEVItem} // "dhca"
    public var customScript: SEVItem {return self.property(0x64686373) as! SEVItem} // "dhcs"
    public var darkMode: SEVItem {return self.property(0x74686d65) as! SEVItem} // "thme"
    public var dataFormat: SEVItem {return self.property(0x74646672) as! SEVItem} // "tdfr"
    public var dataRate: SEVItem {return self.property(0x64647261) as! SEVItem} // "ddra"
    public var dataSize: SEVItem {return self.property(0x6473697a) as! SEVItem} // "dsiz"
    public var defaultApplication: SEVItem {return self.property(0x61736461) as! SEVItem} // "asda"
    public var delayInterval: SEVItem {return self.property(0x646c7969) as! SEVItem} // "dlyi"
    public var description_: SEVItem {return self.property(0x64657363) as! SEVItem} // "desc"
    public var deskAccessoryFile: SEVItem {return self.property(0x64616669) as! SEVItem} // "dafi"
    public var desktopFolder: SEVItem {return self.property(0x6465736b) as! SEVItem} // "desk"
    public var desktopPicturesFolder: SEVItem {return self.property(0x64747024) as! SEVItem} // "dtp$"
    public var dimensions: SEVItem {return self.property(0x7064696d) as! SEVItem} // "pdim"
    public var directParameter: SEVItem {return self.property(0x73646470) as! SEVItem} // "sddp"
    public var displayedName: SEVItem {return self.property(0x646e616d) as! SEVItem} // "dnam"
    public var displayName: SEVItem {return self.property(0x646e614d) as! SEVItem} // "dnaM"
    public var dockPreferences: SEVItem {return self.property(0x64706173) as! SEVItem} // "dpas"
    public var dockSize: SEVItem {return self.property(0x64737a65) as! SEVItem} // "dsze"
    public var document: SEVItem {return self.property(0x646f6375) as! SEVItem} // "docu"
    public var documentsFolder: SEVItem {return self.property(0x646f6373) as! SEVItem} // "docs"
    public var downloadsFolder: SEVItem {return self.property(0x646f776e) as! SEVItem} // "down"
    public var duplex: SEVItem {return self.property(0x6475706c) as! SEVItem} // "dupl"
    public var duration: SEVItem {return self.property(0x6475726e) as! SEVItem} // "durn"
    public var ejectable: SEVItem {return self.property(0x6973656a) as! SEVItem} // "isej"
    public var enabled: SEVItem {return self.property(0x656e6142) as! SEVItem} // "enaB"
    public var endingPage: SEVItem {return self.property(0x6c776c70) as! SEVItem} // "lwlp"
    public var entireContents: SEVItem {return self.property(0x65637473) as! SEVItem} // "ects"
    public var enumerated: SEVItem {return self.property(0x656e6d64) as! SEVItem} // "enmd"
    public var errorHandling: SEVItem {return self.property(0x6c776568) as! SEVItem} // "lweh"
    public var extensionsFolder: SEVItem {return self.property(0x6578747a) as! SEVItem} // "extz"
    public var favoritesFolder: SEVItem {return self.property(0x66617673) as! SEVItem} // "favs"
    public var faxNumber: SEVItem {return self.property(0x6661786e) as! SEVItem} // "faxn"
    public var file: SEVItem {return self.property(0x66696c65) as! SEVItem} // "file"
    public var fileType: SEVItem {return self.property(0x61737479) as! SEVItem} // "asty"
    public var focused: SEVItem {return self.property(0x666f6375) as! SEVItem} // "focu"
    public var FolderActionScriptsFolder: SEVItem {return self.property(0x66617366) as! SEVItem} // "fasf"
    public var folderActionsEnabled: SEVItem {return self.property(0x6661656e) as! SEVItem} // "faen"
    public var fontsFolder: SEVItem {return self.property(0x666f6e74) as! SEVItem} // "font"
    public var fontSmoothing: SEVItem {return self.property(0x66747473) as! SEVItem} // "ftts"
    public var fontSmoothingLimit: SEVItem {return self.property(0x6674736d) as! SEVItem} // "ftsm"
    public var fontSmoothingStyle: SEVItem {return self.property(0x66747373) as! SEVItem} // "ftss"
    public var format: SEVItem {return self.property(0x64666d74) as! SEVItem} // "dfmt"
    public var freeSpace: SEVItem {return self.property(0x66727370) as! SEVItem} // "frsp"
    public var frontmost: SEVItem {return self.property(0x70697366) as! SEVItem} // "pisf"
    public var fullName: SEVItem {return self.property(0x666e616d) as! SEVItem} // "fnam"
    public var fullText: SEVItem {return self.property(0x616e6f74) as! SEVItem} // "anot"
    public var hasScriptingTerminology: SEVItem {return self.property(0x68736372) as! SEVItem} // "hscr"
    public var help: SEVItem {return self.property(0x68656c70) as! SEVItem} // "help"
    public var hidden: SEVItem {return self.property(0x6869646e) as! SEVItem} // "hidn"
    public var highlightColor: SEVItem {return self.property(0x6869636f) as! SEVItem} // "hico"
    public var highQuality: SEVItem {return self.property(0x68717561) as! SEVItem} // "hqua"
    public var homeDirectory: SEVItem {return self.property(0x686f6d65) as! SEVItem} // "home"
    public var homeFolder: SEVItem {return self.property(0x63757372) as! SEVItem} // "cusr"
    public var href: SEVItem {return self.property(0x68726566) as! SEVItem} // "href"
    public var id: SEVItem {return self.property(0x49442020) as! SEVItem} // "ID\0x20\0x20"
    public var ignorePrivileges: SEVItem {return self.property(0x69677072) as! SEVItem} // "igpr"
    public var index: SEVItem {return self.property(0x70696478) as! SEVItem} // "pidx"
    public var insertionAction: SEVItem {return self.property(0x64686174) as! SEVItem} // "dhat"
    public var interface: SEVItem {return self.property(0x696e7466) as! SEVItem} // "intf"
    public var kind: SEVItem {return self.property(0x6b696e64) as! SEVItem} // "kind"
    public var launcherItemsFolder: SEVItem {return self.property(0x6c61756e) as! SEVItem} // "laun"
    public var libraryFolder: SEVItem {return self.property(0x646c6962) as! SEVItem} // "dlib"
    public var listed: SEVItem {return self.property(0x6c737464) as! SEVItem} // "lstd"
    public var localDomain: SEVItem {return self.property(0x666c646c) as! SEVItem} // "fldl"
    public var localVolume: SEVItem {return self.property(0x69737276) as! SEVItem} // "isrv"
    public var logOutWhenInactive: SEVItem {return self.property(0x61636c6b) as! SEVItem} // "aclk"
    public var logOutWhenInactiveInterval: SEVItem {return self.property(0x6163746f) as! SEVItem} // "acto"
    public var looping: SEVItem {return self.property(0x6c6f6f70) as! SEVItem} // "loop"
    public var MACAddress: SEVItem {return self.property(0x6d616361) as! SEVItem} // "maca"
    public var magnification: SEVItem {return self.property(0x646d6167) as! SEVItem} // "dmag"
    public var magnificationSize: SEVItem {return self.property(0x646d737a) as! SEVItem} // "dmsz"
    public var mainScreenOnly: SEVItem {return self.property(0x6d736372) as! SEVItem} // "mscr"
    public var maximumValue: SEVItem {return self.property(0x6d617856) as! SEVItem} // "maxV"
    public var miniaturizable: SEVItem {return self.property(0x69736d6e) as! SEVItem} // "ismn"
    public var miniaturized: SEVItem {return self.property(0x706d6e64) as! SEVItem} // "pmnd"
    public var minimizeEffect: SEVItem {return self.property(0x64656666) as! SEVItem} // "deff"
    public var minimumValue: SEVItem {return self.property(0x6d696e57) as! SEVItem} // "minW"
    public var modificationDate: SEVItem {return self.property(0x61736d6f) as! SEVItem} // "asmo"
    public var modificationTime: SEVItem {return self.property(0x6d64746d) as! SEVItem} // "mdtm"
    public var modified: SEVItem {return self.property(0x696d6f64) as! SEVItem} // "imod"
    public var moviesFolder: SEVItem {return self.property(0x6d646f63) as! SEVItem} // "mdoc"
    public var mtu: SEVItem {return self.property(0x6d747520) as! SEVItem} // "mtu\0x20"
    public var musicCD: SEVItem {return self.property(0x64686d63) as! SEVItem} // "dhmc"
    public var musicFolder: SEVItem {return self.property(0x25646f63) as! SEVItem} // "%doc"
    public var name: SEVItem {return self.property(0x706e616d) as! SEVItem} // "pnam"
    public var nameExtension: SEVItem {return self.property(0x6578746e) as! SEVItem} // "extn"
    public var naturalDimensions: SEVItem {return self.property(0x6e64696d) as! SEVItem} // "ndim"
    public var networkDomain: SEVItem {return self.property(0x666c646e) as! SEVItem} // "fldn"
    public var networkPreferences: SEVItem {return self.property(0x6e657470) as! SEVItem} // "netp"
    public var optional_: SEVItem {return self.property(0x6f70746c) as! SEVItem} // "optl"
    public var orientation: SEVItem {return self.property(0x6f726965) as! SEVItem} // "orie"
    public var packageFolder: SEVItem {return self.property(0x706b6766) as! SEVItem} // "pkgf"
    public var pagesAcross: SEVItem {return self.property(0x6c776c61) as! SEVItem} // "lwla"
    public var pagesDown: SEVItem {return self.property(0x6c776c64) as! SEVItem} // "lwld"
    public var partitionSpaceUsed: SEVItem {return self.property(0x70757364) as! SEVItem} // "pusd"
    public var path: SEVItem {return self.property(0x70707468) as! SEVItem} // "ppth"
    public var physicalSize: SEVItem {return self.property(0x70687973) as! SEVItem} // "phys"
    public var picture: SEVItem {return self.property(0x70696350) as! SEVItem} // "picP"
    public var pictureCD: SEVItem {return self.property(0x64687063) as! SEVItem} // "dhpc"
    public var pictureDisplayStyle: SEVItem {return self.property(0x70737479) as! SEVItem} // "psty"
    public var picturePath: SEVItem {return self.property(0x70696370) as! SEVItem} // "picp"
    public var pictureRotation: SEVItem {return self.property(0x63686e47) as! SEVItem} // "chnG"
    public var picturesFolder: SEVItem {return self.property(0x70646f63) as! SEVItem} // "pdoc"
    public var pluralName: SEVItem {return self.property(0x706c6e6d) as! SEVItem} // "plnm"
    public var position: SEVItem {return self.property(0x706f736e) as! SEVItem} // "posn"
    public var POSIXPath: SEVItem {return self.property(0x706f7378) as! SEVItem} // "posx"
    public var preferencesFolder: SEVItem {return self.property(0x70726566) as! SEVItem} // "pref"
    public var preferredRate: SEVItem {return self.property(0x70726672) as! SEVItem} // "prfr"
    public var preferredVolume: SEVItem {return self.property(0x70726676) as! SEVItem} // "prfv"
    public var presentationMode: SEVItem {return self.property(0x70726d64) as! SEVItem} // "prmd"
    public var presentationSize: SEVItem {return self.property(0x6d76737a) as! SEVItem} // "mvsz"
    public var previewDuration: SEVItem {return self.property(0x70767764) as! SEVItem} // "pvwd"
    public var previewTime: SEVItem {return self.property(0x70767774) as! SEVItem} // "pvwt"
    public var productVersion: SEVItem {return self.property(0x76657232) as! SEVItem} // "ver2"
    public var properties: SEVItem {return self.property(0x70414c4c) as! SEVItem} // "pALL"
    public var publicFolder: SEVItem {return self.property(0x70756262) as! SEVItem} // "pubb"
    public var quitDelay: SEVItem {return self.property(0x7164656c) as! SEVItem} // "qdel"
    public var randomOrder: SEVItem {return self.property(0x72616e44) as! SEVItem} // "ranD"
    public var recentApplicationsLimit: SEVItem {return self.property(0x7261706c) as! SEVItem} // "rapl"
    public var recentDocumentsLimit: SEVItem {return self.property(0x7264636c) as! SEVItem} // "rdcl"
    public var recentServersLimit: SEVItem {return self.property(0x7273766c) as! SEVItem} // "rsvl"
    public var requestedPrintTime: SEVItem {return self.property(0x6c777174) as! SEVItem} // "lwqt"
    public var requirePasswordToUnlock: SEVItem {return self.property(0x7077756c) as! SEVItem} // "pwul"
    public var requirePasswordToWake: SEVItem {return self.property(0x7077776b) as! SEVItem} // "pwwk"
    public var resizable: SEVItem {return self.property(0x7072737a) as! SEVItem} // "prsz"
    public var role: SEVItem {return self.property(0x726f6c65) as! SEVItem} // "role"
    public var roleDescription: SEVItem {return self.property(0x726f6c64) as! SEVItem} // "rold"
    public var running: SEVItem {return self.property(0x72756e6e) as! SEVItem} // "runn"
    public var screenEdge: SEVItem {return self.property(0x64707365) as! SEVItem} // "dpse"
    public var screenSaverPreferences: SEVItem {return self.property(0x73737670) as! SEVItem} // "ssvp"
    public var scriptingAdditionsFolder: SEVItem {return self.property(0x24736372) as! SEVItem} // "$scr"
    public var scriptingDefinition: SEVItem {return self.property(0x73646566) as! SEVItem} // "sdef"
    public var scriptingResult: SEVItem {return self.property(0x73647273) as! SEVItem} // "sdrs"
    public var scriptMenuEnabled: SEVItem {return self.property(0x73636d6e) as! SEVItem} // "scmn"
    public var scriptsFolder: SEVItem {return self.property(0x73637224) as! SEVItem} // "scr$"
    public var scrollBarAction: SEVItem {return self.property(0x73636c62) as! SEVItem} // "sclb"
    public var secureVirtualMemory: SEVItem {return self.property(0x7363766d) as! SEVItem} // "scvm"
    public var securityPreferences: SEVItem {return self.property(0x73656370) as! SEVItem} // "secp"
    public var selected: SEVItem {return self.property(0x73656c45) as! SEVItem} // "selE"
    public var server: SEVItem {return self.property(0x73727672) as! SEVItem} // "srvr"
    public var settable: SEVItem {return self.property(0x7374626c) as! SEVItem} // "stbl"
    public var sharedDocumentsFolder: SEVItem {return self.property(0x73646174) as! SEVItem} // "sdat"
    public var shortName: SEVItem {return self.property(0x6366626e) as! SEVItem} // "cfbn"
    public var shortVersion: SEVItem {return self.property(0x61737376) as! SEVItem} // "assv"
    public var showClock: SEVItem {return self.property(0x7368636c) as! SEVItem} // "shcl"
    public var shutdownFolder: SEVItem {return self.property(0x73686466) as! SEVItem} // "shdf"
    public var sitesFolder: SEVItem {return self.property(0x73697465) as! SEVItem} // "site"
    public var size: SEVItem {return self.property(0x7074737a) as! SEVItem} // "ptsz"
    public var smoothScrolling: SEVItem {return self.property(0x73636c73) as! SEVItem} // "scls"
    public var speakableItemsFolder: SEVItem {return self.property(0x73706b69) as! SEVItem} // "spki"
    public var speed: SEVItem {return self.property(0x73706564) as! SEVItem} // "sped"
    public var startingPage: SEVItem {return self.property(0x6c776670) as! SEVItem} // "lwfp"
    public var startTime: SEVItem {return self.property(0x6f666673) as! SEVItem} // "offs"
    public var startup: SEVItem {return self.property(0x69737464) as! SEVItem} // "istd"
    public var startupDisk: SEVItem {return self.property(0x7364736b) as! SEVItem} // "sdsk"
    public var startupItemsFolder: SEVItem {return self.property(0x656d707a) as! SEVItem} // "empz"
    public var stationery: SEVItem {return self.property(0x70737064) as! SEVItem} // "pspd"
    public var storedStream: SEVItem {return self.property(0x69737373) as! SEVItem} // "isss"
    public var subrole: SEVItem {return self.property(0x7362726c) as! SEVItem} // "sbrl"
    public var suiteName: SEVItem {return self.property(0x73746e6d) as! SEVItem} // "stnm"
    public var superclass: SEVItem {return self.property(0x73757065) as! SEVItem} // "supe"
    public var systemDomain: SEVItem {return self.property(0x666c6473) as! SEVItem} // "flds"
    public var systemFolder: SEVItem {return self.property(0x6d616373) as! SEVItem} // "macs"
    public var targetPrinter: SEVItem {return self.property(0x74727072) as! SEVItem} // "trpr"
    public var temporaryItemsFolder: SEVItem {return self.property(0x74656d70) as! SEVItem} // "temp"
    public var timeScale: SEVItem {return self.property(0x746d7363) as! SEVItem} // "tmsc"
    public var title: SEVItem {return self.property(0x7469746c) as! SEVItem} // "titl"
    public var totalPartitionSize: SEVItem {return self.property(0x61707074) as! SEVItem} // "appt"
    public var translucentMenuBar: SEVItem {return self.property(0x6d6e5472) as! SEVItem} // "mnTr"
    public var trash: SEVItem {return self.property(0x74727368) as! SEVItem} // "trsh"
    public var type: SEVItem {return self.property(0x70747970) as! SEVItem} // "ptyp"
    public var typeClass: SEVItem {return self.property(0x74797065) as! SEVItem} // "type"
    public var typeIdentifier: SEVItem {return self.property(0x75746964) as! SEVItem} // "utid"
    public var UIElementsEnabled: SEVItem {return self.property(0x7569656e) as! SEVItem} // "uien"
    public var unixId: SEVItem {return self.property(0x69647578) as! SEVItem} // "idux"
    public var URL: SEVItem {return self.property(0x75726c20) as! SEVItem} // "url\0x20"
    public var userDomain: SEVItem {return self.property(0x666c6475) as! SEVItem} // "fldu"
    public var utilitiesFolder: SEVItem {return self.property(0x75746924) as! SEVItem} // "uti$"
    public var value: SEVItem {return self.property(0x76616c4c) as! SEVItem} // "valL"
    public var version: SEVItem {return self.property(0x76657273) as! SEVItem} // "vers"
    public var videoBD: SEVItem {return self.property(0x64687662) as! SEVItem} // "dhvb"
    public var videoDepth: SEVItem {return self.property(0x76636470) as! SEVItem} // "vcdp"
    public var videoDVD: SEVItem {return self.property(0x64687664) as! SEVItem} // "dhvd"
    public var visible: SEVItem {return self.property(0x70766973) as! SEVItem} // "pvis"
    public var visualCharacteristic: SEVItem {return self.property(0x76697375) as! SEVItem} // "visu"
    public var volume: SEVItem {return self.property(0x766f6c75) as! SEVItem} // "volu"
    public var workflowsFolder: SEVItem {return self.property(0x666c6f77) as! SEVItem} // "flow"
    public var zone: SEVItem {return self.property(0x7a6f6e65) as! SEVItem} // "zone"
    public var zoomable: SEVItem {return self.property(0x69737a6d) as! SEVItem} // "iszm"
    public var zoomed: SEVItem {return self.property(0x707a756d) as! SEVItem} // "pzum"

    // Elements
    public var actions: SEVItems {return self.elements(0x61637454) as! SEVItems} // "actT"
    public var aliases: SEVItems {return self.elements(0x616c6973) as! SEVItems} // "alis"
    public var annotations: SEVItems {return self.elements(0x616e6e6f) as! SEVItems} // "anno"
    public var appearancePreferencesObjects: SEVItems {return self.elements(0x6170726f) as! SEVItems} // "apro"
    public var applications: SEVItems {return self.elements(0x63617070) as! SEVItems} // "capp"
    public var applicationProcesses: SEVItems {return self.elements(0x70636170) as! SEVItems} // "pcap"
    public var attributes: SEVItems {return self.elements(0x61747472) as! SEVItems} // "attr"
    public var audioDatas: SEVItems {return self.elements(0x61756464) as! SEVItems} // "audd"
    public var audioFiles: SEVItems {return self.elements(0x61756466) as! SEVItems} // "audf"
    public var browsers: SEVItems {return self.elements(0x62726f57) as! SEVItems} // "broW"
    public var busyIndicators: SEVItems {return self.elements(0x62757369) as! SEVItems} // "busi"
    public var buttons: SEVItems {return self.elements(0x62757454) as! SEVItems} // "butT"
    public var CDAndDVDPreferencesObjects: SEVItems {return self.elements(0x6468616f) as! SEVItems} // "dhao"
    public var checkboxes: SEVItems {return self.elements(0x63686278) as! SEVItems} // "chbx"
    public var ClassicDomainObjects: SEVItems {return self.elements(0x646f6d63) as! SEVItems} // "domc"
    public var colorWells: SEVItems {return self.elements(0x636f6c57) as! SEVItems} // "colW"
    public var columns: SEVItems {return self.elements(0x63636f6c) as! SEVItems} // "ccol"
    public var comboBoxes: SEVItems {return self.elements(0x636f6d42) as! SEVItems} // "comB"
    public var configurations: SEVItems {return self.elements(0x636f6e46) as! SEVItems} // "conF"
    public var datas: SEVItems {return self.elements(0x72646174) as! SEVItems} // "rdat"
    public var deskAccessoryProcesses: SEVItems {return self.elements(0x70636461) as! SEVItems} // "pcda"
    public var desktops: SEVItems {return self.elements(0x64736b70) as! SEVItems} // "dskp"
    public var disks: SEVItems {return self.elements(0x63646973) as! SEVItems} // "cdis"
    public var diskItems: SEVItems {return self.elements(0x6469746d) as! SEVItems} // "ditm"
    public var dockPreferencesObjects: SEVItems {return self.elements(0x6470616f) as! SEVItems} // "dpao"
    public var documents: SEVItems {return self.elements(0x646f6375) as! SEVItems} // "docu"
    public var domains: SEVItems {return self.elements(0x646f6d61) as! SEVItems} // "doma"
    public var drawers: SEVItems {return self.elements(0x64726141) as! SEVItems} // "draA"
    public var files: SEVItems {return self.elements(0x66696c65) as! SEVItems} // "file"
    public var filePackages: SEVItems {return self.elements(0x63706b67) as! SEVItems} // "cpkg"
    public var folders: SEVItems {return self.elements(0x63666f6c) as! SEVItems} // "cfol"
    public var folderActions: SEVItems {return self.elements(0x666f6163) as! SEVItems} // "foac"
    public var groups: SEVItems {return self.elements(0x73677270) as! SEVItems} // "sgrp"
    public var growAreas: SEVItems {return self.elements(0x67726f77) as! SEVItems} // "grow"
    public var images: SEVItems {return self.elements(0x696d6141) as! SEVItems} // "imaA"
    public var incrementors: SEVItems {return self.elements(0x696e6372) as! SEVItems} // "incr"
    public var insertionPreferences: SEVItems {return self.elements(0x64686970) as! SEVItems} // "dhip"
    public var interfaces: SEVItems {return self.elements(0x696e7466) as! SEVItems} // "intf"
    public var items: SEVItems {return self.elements(0x636f626a) as! SEVItems} // "cobj"
    public var lists: SEVItems {return self.elements(0x6c697374) as! SEVItems} // "list"
    public var localDomainObjects: SEVItems {return self.elements(0x646f6d6c) as! SEVItems} // "doml"
    public var locations: SEVItems {return self.elements(0x6c6f6361) as! SEVItems} // "loca"
    public var loginItems: SEVItems {return self.elements(0x6c6f6769) as! SEVItems} // "logi"
    public var menus: SEVItems {return self.elements(0x6d656e45) as! SEVItems} // "menE"
    public var menuBars: SEVItems {return self.elements(0x6d626172) as! SEVItems} // "mbar"
    public var menuBarItems: SEVItems {return self.elements(0x6d627269) as! SEVItems} // "mbri"
    public var menuButtons: SEVItems {return self.elements(0x6d656e42) as! SEVItems} // "menB"
    public var menuItems: SEVItems {return self.elements(0x6d656e49) as! SEVItems} // "menI"
    public var movieDatas: SEVItems {return self.elements(0x6d6f7664) as! SEVItems} // "movd"
    public var movieFiles: SEVItems {return self.elements(0x6d6f7666) as! SEVItems} // "movf"
    public var networkDomainObjects: SEVItems {return self.elements(0x646f6d6e) as! SEVItems} // "domn"
    public var networkPreferencesObjects: SEVItems {return self.elements(0x6e65746f) as! SEVItems} // "neto"
    public var outlines: SEVItems {return self.elements(0x6f75746c) as! SEVItems} // "outl"
    public var popOvers: SEVItems {return self.elements(0x706f7076) as! SEVItems} // "popv"
    public var popUpButtons: SEVItems {return self.elements(0x706f7042) as! SEVItems} // "popB"
    public var printSettings: SEVItems {return self.elements(0x70736574) as! SEVItems} // "pset"
    public var processes: SEVItems {return self.elements(0x70726373) as! SEVItems} // "prcs"
    public var progressIndicators: SEVItems {return self.elements(0x70726f49) as! SEVItems} // "proI"
    public var propertyListFiles: SEVItems {return self.elements(0x706c6966) as! SEVItems} // "plif"
    public var propertyListItems: SEVItems {return self.elements(0x706c6969) as! SEVItems} // "plii"
    public var QuickTimeDatas: SEVItems {return self.elements(0x71746664) as! SEVItems} // "qtfd"
    public var QuickTimeFiles: SEVItems {return self.elements(0x71746666) as! SEVItems} // "qtff"
    public var radioButtons: SEVItems {return self.elements(0x72616442) as! SEVItems} // "radB"
    public var radioGroups: SEVItems {return self.elements(0x72677270) as! SEVItems} // "rgrp"
    public var relevanceIndicators: SEVItems {return self.elements(0x72656c69) as! SEVItems} // "reli"
    public var rows: SEVItems {return self.elements(0x63726f77) as! SEVItems} // "crow"
    public var screenSavers: SEVItems {return self.elements(0x73737672) as! SEVItems} // "ssvr"
    public var screenSaverPreferencesObjects: SEVItems {return self.elements(0x7373766f) as! SEVItems} // "ssvo"
    public var scripts: SEVItems {return self.elements(0x73637074) as! SEVItems} // "scpt"
    public var scriptingClasses: SEVItems {return self.elements(0x7364636c) as! SEVItems} // "sdcl"
    public var scriptingCommands: SEVItems {return self.elements(0x7364636d) as! SEVItems} // "sdcm"
    public var scriptingDefinitionObjects: SEVItems {return self.elements(0x7364656f) as! SEVItems} // "sdeo"
    public var scriptingElements: SEVItems {return self.elements(0x7364656c) as! SEVItems} // "sdel"
    public var scriptingEnumerations: SEVItems {return self.elements(0x7364656e) as! SEVItems} // "sden"
    public var scriptingEnumerators: SEVItems {return self.elements(0x73646572) as! SEVItems} // "sder"
    public var scriptingParameters: SEVItems {return self.elements(0x73647061) as! SEVItems} // "sdpa"
    public var scriptingProperties: SEVItems {return self.elements(0x73647072) as! SEVItems} // "sdpr"
    public var scriptingResultObjects: SEVItems {return self.elements(0x7364726f) as! SEVItems} // "sdro"
    public var scriptingSuites: SEVItems {return self.elements(0x73647374) as! SEVItems} // "sdst"
    public var scrollAreas: SEVItems {return self.elements(0x73637261) as! SEVItems} // "scra"
    public var scrollBars: SEVItems {return self.elements(0x73637262) as! SEVItems} // "scrb"
    public var securityPreferencesObjects: SEVItems {return self.elements(0x7365636f) as! SEVItems} // "seco"
    public var services: SEVItems {return self.elements(0x73766365) as! SEVItems} // "svce"
    public var sheets: SEVItems {return self.elements(0x73686545) as! SEVItems} // "sheE"
    public var sliders: SEVItems {return self.elements(0x736c6949) as! SEVItems} // "sliI"
    public var splitters: SEVItems {return self.elements(0x73706c72) as! SEVItems} // "splr"
    public var splitterGroups: SEVItems {return self.elements(0x73706c67) as! SEVItems} // "splg"
    public var staticTexts: SEVItems {return self.elements(0x73747478) as! SEVItems} // "sttx"
    public var systemDomainObjects: SEVItems {return self.elements(0x646f6d73) as! SEVItems} // "doms"
    public var tabGroups: SEVItems {return self.elements(0x74616267) as! SEVItems} // "tabg"
    public var tables: SEVItems {return self.elements(0x74616242) as! SEVItems} // "tabB"
    public var text: SEVItems {return self.elements(0x63747874) as! SEVItems} // "ctxt"
    public var textAreas: SEVItems {return self.elements(0x74787461) as! SEVItems} // "txta"
    public var textFields: SEVItems {return self.elements(0x74787466) as! SEVItems} // "txtf"
    public var toolbars: SEVItems {return self.elements(0x74626172) as! SEVItems} // "tbar"
    public var tracks: SEVItems {return self.elements(0x7472616b) as! SEVItems} // "trak"
    public var UIElements: SEVItems {return self.elements(0x7569656c) as! SEVItems} // "uiel"
    public var users: SEVItems {return self.elements(0x75616363) as! SEVItems} // "uacc"
    public var userDomainObjects: SEVItems {return self.elements(0x646f6d75) as! SEVItems} // "domu"
    public var valueIndicators: SEVItems {return self.elements(0x76616c69) as! SEVItems} // "vali"
    public var windows: SEVItems {return self.elements(0x6377696e) as! SEVItems} // "cwin"
    public var XMLAttributes: SEVItems {return self.elements(0x786d6c61) as! SEVItems} // "xmla"
    public var XMLDatas: SEVItems {return self.elements(0x786d6c64) as! SEVItems} // "xmld"
    public var XMLElements: SEVItems {return self.elements(0x786d6c65) as! SEVItems} // "xmle"
    public var XMLFiles: SEVItems {return self.elements(0x786d6c66) as! SEVItems} // "xmlf"
}


/******************************************************************************/
// Specifier subclasses add app-specific extensions

// beginning/end/before/after
public class SEVInsertion: SwiftAutomation.InsertionSpecifier, SEVCommand {}


// property/by-index/by-name/by-id/previous/next/first/middle/last/any
public class SEVItem: SwiftAutomation.ObjectSpecifier, SEVObject {
    public typealias InsertionSpecifierType = SEVInsertion
    public typealias ObjectSpecifierType = SEVItem
    public typealias MultipleObjectSpecifierType = SEVItems
}

// by-range/by-test/all
public class SEVItems: SEVItem, SwiftAutomation.MultipleObjectSpecifierExtension {}

// App/Con/Its
public class SEVRoot: SwiftAutomation.RootSpecifier, SEVObject, SwiftAutomation.RootSpecifierExtension {
    public typealias InsertionSpecifierType = SEVInsertion
    public typealias ObjectSpecifierType = SEVItem
    public typealias MultipleObjectSpecifierType = SEVItems
    public override class var untargetedAppData: SwiftAutomation.AppData { return _untargetedAppData }
}

// Application
public class SystemEvents: SEVRoot, SwiftAutomation.Application {
    public convenience init(launchOptions: SwiftAutomation.LaunchOptions = SwiftAutomation.DefaultLaunchOptions, relaunchMode: SwiftAutomation.RelaunchMode = SwiftAutomation.DefaultRelaunchMode) {
        self.init(rootObject: SwiftAutomation.AppRootDesc, appData: Swift.type(of:self).untargetedAppData.targetedCopy(
                  .bundleIdentifier("com.apple.systemevents", true), launchOptions: launchOptions, relaunchMode: relaunchMode))
    }
}

// App/Con/Its root objects used to construct untargeted specifiers; these can be used to construct specifiers for use in commands, though cannot send commands themselves

public let SEVApp = _untargetedAppData.app as! SEVRoot
public let SEVCon = _untargetedAppData.con as! SEVRoot
public let SEVIts = _untargetedAppData.its as! SEVRoot


/******************************************************************************/
// Static types

public typealias SEVRecord = [SEVSymbol:Any] // default Swift type for AERecordDescs







