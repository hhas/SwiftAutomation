//
//  ImageEventsGlue.swift
//  Image Events.app 1.1.6
//  SwiftAutomation.framework 0.1.0
//  `aeglue -S 'Image Events.app'`
//


import Foundation
import SwiftAutomation


/******************************************************************************/
// Create an untargeted AppData instance for use in App, Con, Its roots,
// and in Application initializers to create targeted AppData instances.

private let _specifierFormatter = SwiftAutomation.SpecifierFormatter(applicationClassName: "ImageEvents",
                                                     classNamePrefix: "IEV",
                                                     typeNames: [
                                                                     0x52647233: "absoluteColorimetricIntent", // "Rdr3"
                                                                     0x61627374: "abstract", // "abst"
                                                                     0x616c6973: "alias", // "alis"
                                                                     0x2a2a2a2a: "anything", // "****"
                                                                     0x616d6e75: "appleMenuFolder", // "amnu"
                                                                     0x64667068: "ApplePhotoFormat", // "dfph"
                                                                     0x64666173: "AppleShareFormat", // "dfas"
                                                                     0x63617070: "application", // "capp"
                                                                     0x62756e64: "applicationBundleID", // "bund"
                                                                     0x61707073: "applicationsFolder", // "apps"
                                                                     0x7369676e: "applicationSignature", // "sign"
                                                                     0x61737570: "applicationSupportFolder", // "asup"
                                                                     0x6170726c: "applicationURL", // "aprl"
                                                                     0x61707220: "April", // "apr\0x20"
                                                                     0x61736b20: "ask", // "ask\0x20"
                                                                     0x64666175: "audioFormat", // "dfau"
                                                                     0x61756720: "August", // "aug\0x20"
                                                                     0x62657374: "best", // "best"
                                                                     0x51756132: "best_", // "Qua2"
                                                                     0x70647074: "bitDepth", // "pdpt"
                                                                     0x62267720: "blackAndWhite", // "b&w\0x20"
                                                                     0x424d5066: "BMP", // "BMPf"
                                                                     0x626d726b: "bookmarkData", // "bmrk"
                                                                     0x626f6f6c: "boolean", // "bool"
                                                                     0x71647274: "boundingRectangle", // "qdrt"
                                                                     0x70626e64: "bounds", // "pbnd"
                                                                     0x62757379: "busyStatus", // "busy"
                                                                     0x63617061: "capacity", // "capa"
                                                                     0x63617365: "case_", // "case"
                                                                     0x70636c73: "class_", // "pcls"
                                                                     0x666c6463: "ClassicDomain", // "fldc"
                                                                     0x646f6d63: "ClassicDomainObject", // "domc"
                                                                     0x68636c62: "closeable", // "hclb"
                                                                     0x434d594b: "CMYK", // "CMYK"
                                                                     0x6c77636c: "collating", // "lwcl"
                                                                     0x636f6c72: "color", // "colr"
                                                                     0x73706163: "colorspace", // "spac"
                                                                     0x70537063: "colorSpace", // "pSpc"
                                                                     0x636c7274: "colorTable", // "clrt"
                                                                     0x70504353: "connectionSpace", // "pPCS"
                                                                     0x656e756d: "constant", // "enum"
                                                                     0x63746e72: "container", // "ctnr"
                                                                     0x6374726c: "controlPanelsFolder", // "ctrl"
                                                                     0x73646576: "controlStripModulesFolder", // "sdev"
                                                                     0x6c776370: "copies", // "lwcp"
                                                                     0x61736364: "creationDate", // "ascd"
                                                                     0x70437265: "creator", // "pCre"
                                                                     0x66637274: "creatorType", // "fcrt"
                                                                     0x74646173: "dashStyle", // "tdas"
                                                                     0x74647461: "data", // "tdta"
                                                                     0x6c647420: "date", // "ldt\0x20"
                                                                     0x64656320: "December", // "dec\0x20"
                                                                     0x6465636d: "decimalStruct", // "decm"
                                                                     0x61736461: "defaultApplication", // "asda"
                                                                     0x434d4b50: "defaultCMYKProfile", // "CMKP"
                                                                     0x434d4b70: "defaultCMYKProfileLocation", // "CMKp"
                                                                     0x47525950: "defaultGrayProfile", // "GRYP"
                                                                     0x47525970: "defaultGrayProfileLocation", // "GRYp"
                                                                     0x4c616250: "defaultLabProfile", // "LabP"
                                                                     0x4c616270: "defaultLabProfileLocation", // "Labp"
                                                                     0x52474250: "defaultRGBProfile", // "RGBP"
                                                                     0x52474270: "defaultRGBProfileLocation", // "RGBp"
                                                                     0x58595a50: "defaultXYZProfile", // "XYZP"
                                                                     0x58595a70: "defaultXYZProfileLocation", // "XYZp"
                                                                     0x64736372: "description_", // "dscr"
                                                                     0x6465736b: "desktopFolder", // "desk"
                                                                     0x64747024: "desktopPicturesFolder", // "dtp$"
                                                                     0x6c776474: "detailed", // "lwdt"
                                                                     0x70436c61: "deviceClass", // "pCla"
                                                                     0x704d616e: "deviceManufacturer", // "pMan"
                                                                     0x704d6f64: "deviceModel", // "pMod"
                                                                     0x64696163: "diacriticals", // "diac"
                                                                     0x646d6e73: "dimensions", // "dmns"
                                                                     0x63646973: "disk", // "cdis"
                                                                     0x6469746d: "diskItem", // "ditm"
                                                                     0x64697370: "display", // "disp"
                                                                     0x646e616d: "displayedName", // "dnam"
                                                                     0x6d4e756d: "displayNumber", // "mNum"
                                                                     0x6d507266: "displayProfile", // "mPrf"
                                                                     0x646f6375: "document", // "docu"
                                                                     0x646f6373: "documentsFolder", // "docs"
                                                                     0x646f6d61: "domain", // "doma"
                                                                     0x636f6d70: "doubleInteger", // "comp"
                                                                     0x646f776e: "downloadsFolder", // "down"
                                                                     0x51756131: "draft", // "Qua1"
                                                                     0x4d434838: "EightChannel", // "MCH8"
                                                                     0x38434c52: "EightColor", // "8CLR"
                                                                     0x6973656a: "ejectable", // "isej"
                                                                     0x65707266: "embeddedProfile", // "eprf"
                                                                     0x656e6373: "encodedString", // "encs"
                                                                     0x6c776c70: "endingPage", // "lwlp"
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
                                                                     0x4d434835: "FiveChannel", // "MCH5"
                                                                     0x35434c52: "FiveColor", // "5CLR"
                                                                     0x66697864: "fixed", // "fixd"
                                                                     0x66706e74: "fixedPoint", // "fpnt"
                                                                     0x66726374: "fixedRectangle", // "frct"
                                                                     0x63666f6c: "folder", // "cfol"
                                                                     0x66617366: "FolderActionScriptsFolder", // "fasf"
                                                                     0x666f6e74: "fontsFolder", // "font"
                                                                     0x64666d74: "format", // "dfmt"
                                                                     0x34636c72: "fourColors", // "4clr"
                                                                     0x34677279: "fourGrays", // "4gry"
                                                                     0x66727370: "freeSpace", // "frsp"
                                                                     0x66726920: "Friday", // "fri\0x20"
                                                                     0x70697366: "frontmost", // "pisf"
                                                                     0x47494620: "GIF", // "GIF\0x20"
                                                                     0x47494666: "GIFPicture", // "GIFf"
                                                                     0x63677478: "graphicText", // "cgtx"
                                                                     0x47524159: "Gray", // "GRAY"
                                                                     0x67726179: "grayscale", // "gray"
                                                                     0x68696768: "high", // "high"
                                                                     0x64666873: "HighSierraFormat", // "dfhs"
                                                                     0x63757372: "homeFolder", // "cusr"
                                                                     0x68797068: "hyphens", // "hyph"
                                                                     0x49442020: "id", // "ID\0x20\0x20"
                                                                     0x69677072: "ignorePrivileges", // "igpr"
                                                                     0x696d6167: "image", // "imag"
                                                                     0x696d6766: "imageFile", // "imgf"
                                                                     0x70696478: "index", // "pidx"
                                                                     0x73636e72: "input", // "scnr"
                                                                     0x6c6f6e67: "integer", // "long"
                                                                     0x69747874: "internationalText", // "itxt"
                                                                     0x696e746c: "internationalWritingCode", // "intl"
                                                                     0x64663936: "ISO9660Format", // "df96"
                                                                     0x636f626a: "item", // "cobj"
                                                                     0x6a616e20: "January", // "jan\0x20"
                                                                     0x4a504547: "JPEG", // "JPEG"
                                                                     0x6a706732: "JPEG2", // "jpg2"
                                                                     0x6a756c20: "July", // "jul\0x20"
                                                                     0x6a756e20: "June", // "jun\0x20"
                                                                     0x6b706964: "kernelProcessID", // "kpid"
                                                                     0x6b696e64: "kind", // "kind"
                                                                     0x4c616220: "Lab", // "Lab\0x20"
                                                                     0x6c64626c: "largeReal", // "ldbl"
                                                                     0x6c61756e: "launcherItemsFolder", // "laun"
                                                                     0x6c656173: "least", // "leas"
                                                                     0x646c6962: "libraryFolder", // "dlib"
                                                                     0x6c696e6b: "link", // "link"
                                                                     0x6c697374: "list", // "list"
                                                                     0x666c646c: "localDomain", // "fldl"
                                                                     0x646f6d6c: "localDomainObject", // "doml"
                                                                     0x69737276: "localVolume", // "isrv"
                                                                     0x704c6f63: "location", // "pLoc"
                                                                     0x696e736c: "locationReference", // "insl"
                                                                     0x6c667864: "longFixed", // "lfxd"
                                                                     0x6c667074: "longFixedPoint", // "lfpt"
                                                                     0x6c667263: "longFixedRectangle", // "lfrc"
                                                                     0x6c706e74: "longPoint", // "lpnt"
                                                                     0x6c726374: "longRectangle", // "lrct"
                                                                     0x6c6f7720: "low", // "low\0x20"
                                                                     0x6d616368: "machine", // "mach"
                                                                     0x6d4c6f63: "machineLocation", // "mLoc"
                                                                     0x706f7274: "machPort", // "port"
                                                                     0x6466682b: "MacOSExtendedFormat", // "dfh+"
                                                                     0x64666866: "MacOSFormat", // "dfhf"
                                                                     0x504e5447: "MacPaint", // "PNTG"
                                                                     0x6d617220: "March", // "mar\0x20"
                                                                     0x6d617920: "May", // "may\0x20"
                                                                     0x6d656469: "medium", // "medi"
                                                                     0x74616720: "metadataTag", // "tag\0x20"
                                                                     0x6d696c6c: "millionsOfColors", // "mill"
                                                                     0x6d696c2b: "millionsOfColorsPlus", // "mil+"
                                                                     0x69736d6e: "miniaturizable", // "ismn"
                                                                     0x706d6e64: "miniaturized", // "pmnd"
                                                                     0x61736d6f: "modificationDate", // "asmo"
                                                                     0x696d6f64: "modified", // "imod"
                                                                     0x6d6f6e20: "Monday", // "mon\0x20"
                                                                     0x6d6e7472: "monitor", // "mntr"
                                                                     0x6d646f63: "moviesFolder", // "mdoc"
                                                                     0x64666d73: "MSDOSFormat", // "dfms"
                                                                     0x25646f63: "musicFolder", // "%doc"
                                                                     0x706e616d: "name", // "pnam"
                                                                     0x4e414d45: "Named", // "NAME"
                                                                     0x6e6d636c: "named_", // "nmcl"
                                                                     0x6578746e: "nameExtension", // "extn"
                                                                     0x666c646e: "networkDomain", // "fldn"
                                                                     0x646f6d6e: "networkDomainObject", // "domn"
                                                                     0x64666e66: "NFSFormat", // "dfnf"
                                                                     0x6e6f2020: "no", // "no\0x20\0x20"
                                                                     0x51756130: "normal", // "Qua0"
                                                                     0x6e6f7620: "November", // "nov\0x20"
                                                                     0x6e756c6c: "null", // "null"
                                                                     0x6e756d65: "numericStrings", // "nume"
                                                                     0x6f637420: "October", // "oct\0x20"
                                                                     0x70727472: "output", // "prtr"
                                                                     0x706b6766: "packageFolder", // "pkgf"
                                                                     0x6c776c61: "pagesAcross", // "lwla"
                                                                     0x6c776c64: "pagesDown", // "lwld"
                                                                     0x70707468: "path", // "ppth"
                                                                     0x50444620: "PDF", // "PDF\0x20"
                                                                     0x52647230: "perceptualIntent", // "Rdr0"
                                                                     0x38425053: "Photoshop", // "8BPS"
                                                                     0x70687973: "physicalSize", // "phys"
                                                                     0x50494354: "PICT", // "PICT"
                                                                     0x70646f63: "picturesFolder", // "pdoc"
                                                                     0x74706d6d: "pixelMapRecord", // "tpmm"
                                                                     0x70506c74: "platform", // "pPlt"
                                                                     0x504e4766: "PNG", // "PNGf"
                                                                     0x51447074: "point", // "QDpt"
                                                                     0x706f7378: "POSIXPath", // "posx"
                                                                     0x70726566: "preferencesFolder", // "pref"
                                                                     0x70636d6d: "preferredCMM", // "pcmm"
                                                                     0x70736574: "printSettings", // "pset"
                                                                     0x70736e20: "processSerialNumber", // "psn\0x20"
                                                                     0x64667072: "ProDOSFormat", // "dfpr"
                                                                     0x76657232: "productVersion", // "ver2"
                                                                     0x70726f66: "profile", // "prof"
                                                                     0x70666472: "profileFolder", // "pfdr"
                                                                     0x70414c4c: "properties", // "pALL"
                                                                     0x70726f70: "property_", // "prop"
                                                                     0x70736420: "PSD", // "psd\0x20"
                                                                     0x70756262: "publicFolder", // "pubb"
                                                                     0x70756e63: "punctuation", // "punc"
                                                                     0x7051616c: "quality", // "pQal"
                                                                     0x64667174: "QuickTakeFormat", // "dfqt"
                                                                     0x71746966: "QuickTimeImage", // "qtif"
                                                                     0x7164656c: "quitDelay", // "qdel"
                                                                     0x646f7562: "real", // "doub"
                                                                     0x7265636f: "record", // "reco"
                                                                     0x6f626a20: "reference", // "obj\0x20"
                                                                     0x52647231: "relativeColorimetricIntent", // "Rdr1"
                                                                     0x70526472: "renderingIntent", // "pRdr"
                                                                     0x6c777174: "requestedPrintTime", // "lwqt"
                                                                     0x7072737a: "resizable", // "prsz"
                                                                     0x7265736f: "resolution", // "reso"
                                                                     0x52474220: "RGB", // "RGB\0x20"
                                                                     0x74723136: "RGB16Color", // "tr16"
                                                                     0x74723936: "RGB96Color", // "tr96"
                                                                     0x63524742: "RGBColor", // "cRGB"
                                                                     0x74726f74: "rotation", // "trot"
                                                                     0x52647232: "saturationIntent", // "Rdr2"
                                                                     0x73617420: "Saturday", // "sat\0x20"
                                                                     0x73637074: "script", // "scpt"
                                                                     0x24736372: "scriptingAdditionsFolder", // "$scr"
                                                                     0x73637224: "scriptsFolder", // "scr$"
                                                                     0x73657020: "September", // "sep\0x20"
                                                                     0x73727672: "server", // "srvr"
                                                                     0x4d434837: "SevenChannel", // "MCH7"
                                                                     0x37434c52: "SevenColor", // "7CLR"
                                                                     0x2e534749: "SGI", // ".SGI"
                                                                     0x73646174: "sharedDocumentsFolder", // "sdat"
                                                                     0x73686f72: "shortInteger", // "shor"
                                                                     0x61737376: "shortVersion", // "assv"
                                                                     0x73686466: "shutdownFolder", // "shdf"
                                                                     0x73697465: "sitesFolder", // "site"
                                                                     0x4d434836: "SixChannel", // "MCH6"
                                                                     0x36434c52: "SixColor", // "6CLR"
                                                                     0x3136636c: "sixteenColors", // "16cl"
                                                                     0x31366772: "sixteenGrays", // "16gr"
                                                                     0x7074737a: "size", // "ptsz"
                                                                     0x73696e67: "smallReal", // "sing"
                                                                     0x73706b69: "speakableItemsFolder", // "spki"
                                                                     0x6c777374: "standard", // "lwst"
                                                                     0x6c776670: "startingPage", // "lwfp"
                                                                     0x69737464: "startup", // "istd"
                                                                     0x7364736b: "startupDisk", // "sdsk"
                                                                     0x656d707a: "startupItemsFolder", // "empz"
                                                                     0x70737064: "stationery", // "pspd"
                                                                     0x7374796c: "styledClipboardText", // "styl"
                                                                     0x53545854: "styledText", // "STXT"
                                                                     0x73756e20: "Sunday", // "sun\0x20"
                                                                     0x666c6473: "systemDomain", // "flds"
                                                                     0x646f6d73: "systemDomainObject", // "doms"
                                                                     0x6d616373: "systemFolder", // "macs"
                                                                     0x7379737a: "systemProfile", // "sysz"
                                                                     0x73797370: "systemProfileLocation", // "sysp"
                                                                     0x74727072: "targetPrinter", // "trpr"
                                                                     0x74656d70: "temporaryItemsFolder", // "temp"
                                                                     0x63747874: "text", // "ctxt"
                                                                     0x54455854: "Text", // "TEXT"
                                                                     0x74737479: "textStyleInfo", // "tsty"
                                                                     0x74676120: "TGA", // "tga\0x20"
                                                                     0x74686f75: "thousandsOfColors", // "thou"
                                                                     0x74687520: "Thursday", // "thu\0x20"
                                                                     0x54494646: "TIFF", // "TIFF"
                                                                     0x74727368: "trash", // "trsh"
                                                                     0x74756520: "Tuesday", // "tue\0x20"
                                                                     0x32353663: "twoHundredFiftySixColors", // "256c"
                                                                     0x32353667: "twoHundredFiftySixGrays", // "256g"
                                                                     0x74797065: "typeClass", // "type"
                                                                     0x75746964: "typeIdentifier", // "utid"
                                                                     0x64667564: "UDFFormat", // "dfud"
                                                                     0x64667566: "UFSFormat", // "dfuf"
                                                                     0x75747874: "UnicodeText", // "utxt"
                                                                     0x64662424: "unknownFormat", // "df$$"
                                                                     0x75636f6d: "unsignedDoubleInteger", // "ucom"
                                                                     0x6d61676e: "unsignedInteger", // "magn"
                                                                     0x75736872: "unsignedShortInteger", // "ushr"
                                                                     0x75726c20: "URL", // "url\0x20"
                                                                     0x666c6475: "userDomain", // "fldu"
                                                                     0x646f6d75: "userDomainObject", // "domu"
                                                                     0x75743136: "UTF16Text", // "ut16"
                                                                     0x75746638: "UTF8Text", // "utf8"
                                                                     0x75746924: "utilitiesFolder", // "uti$"
                                                                     0x76616c4c: "value", // "valL"
                                                                     0x76657273: "version", // "vers"
                                                                     0x70766973: "visible", // "pvis"
                                                                     0x766f6c75: "volume", // "volu"
                                                                     0x64667764: "WebDAVFormat", // "dfwd"
                                                                     0x77656420: "Wednesday", // "wed\0x20"
                                                                     0x77686974: "whitespace", // "whit"
                                                                     0x6377696e: "window", // "cwin"
                                                                     0x666c6f77: "workflowsFolder", // "flow"
                                                                     0x70736374: "writingCode", // "psct"
                                                                     0x58595a20: "XYZ", // "XYZ\0x20"
                                                                     0x79657320: "yes", // "yes\0x20"
                                                                     0x7a6f6e65: "zone", // "zone"
                                                                     0x69737a6d: "zoomable", // "iszm"
                                                                     0x707a756d: "zoomed", // "pzum"
                                                     ],
                                                     propertyNames: [
                                                                     0x616d6e75: "appleMenuFolder", // "amnu"
                                                                     0x61707073: "applicationsFolder", // "apps"
                                                                     0x61737570: "applicationSupportFolder", // "asup"
                                                                     0x70647074: "bitDepth", // "pdpt"
                                                                     0x70626e64: "bounds", // "pbnd"
                                                                     0x62757379: "busyStatus", // "busy"
                                                                     0x63617061: "capacity", // "capa"
                                                                     0x70636c73: "class_", // "pcls"
                                                                     0x666c6463: "ClassicDomain", // "fldc"
                                                                     0x68636c62: "closeable", // "hclb"
                                                                     0x6c77636c: "collating", // "lwcl"
                                                                     0x70537063: "colorSpace", // "pSpc"
                                                                     0x70504353: "connectionSpace", // "pPCS"
                                                                     0x63746e72: "container", // "ctnr"
                                                                     0x6374726c: "controlPanelsFolder", // "ctrl"
                                                                     0x73646576: "controlStripModulesFolder", // "sdev"
                                                                     0x6c776370: "copies", // "lwcp"
                                                                     0x61736364: "creationDate", // "ascd"
                                                                     0x70437265: "creator", // "pCre"
                                                                     0x66637274: "creatorType", // "fcrt"
                                                                     0x61736461: "defaultApplication", // "asda"
                                                                     0x434d4b50: "defaultCMYKProfile", // "CMKP"
                                                                     0x434d4b70: "defaultCMYKProfileLocation", // "CMKp"
                                                                     0x47525950: "defaultGrayProfile", // "GRYP"
                                                                     0x47525970: "defaultGrayProfileLocation", // "GRYp"
                                                                     0x4c616250: "defaultLabProfile", // "LabP"
                                                                     0x4c616270: "defaultLabProfileLocation", // "Labp"
                                                                     0x52474250: "defaultRGBProfile", // "RGBP"
                                                                     0x52474270: "defaultRGBProfileLocation", // "RGBp"
                                                                     0x58595a50: "defaultXYZProfile", // "XYZP"
                                                                     0x58595a70: "defaultXYZProfileLocation", // "XYZp"
                                                                     0x64736372: "description_", // "dscr"
                                                                     0x6465736b: "desktopFolder", // "desk"
                                                                     0x64747024: "desktopPicturesFolder", // "dtp$"
                                                                     0x70436c61: "deviceClass", // "pCla"
                                                                     0x704d616e: "deviceManufacturer", // "pMan"
                                                                     0x704d6f64: "deviceModel", // "pMod"
                                                                     0x646d6e73: "dimensions", // "dmns"
                                                                     0x646e616d: "displayedName", // "dnam"
                                                                     0x6d4e756d: "displayNumber", // "mNum"
                                                                     0x6d507266: "displayProfile", // "mPrf"
                                                                     0x646f6375: "document", // "docu"
                                                                     0x646f6373: "documentsFolder", // "docs"
                                                                     0x646f776e: "downloadsFolder", // "down"
                                                                     0x6973656a: "ejectable", // "isej"
                                                                     0x65707266: "embeddedProfile", // "eprf"
                                                                     0x6c776c70: "endingPage", // "lwlp"
                                                                     0x6c776568: "errorHandling", // "lweh"
                                                                     0x6578747a: "extensionsFolder", // "extz"
                                                                     0x66617673: "favoritesFolder", // "favs"
                                                                     0x6661786e: "faxNumber", // "faxn"
                                                                     0x66696c65: "file", // "file"
                                                                     0x61737479: "fileType", // "asty"
                                                                     0x66617366: "FolderActionScriptsFolder", // "fasf"
                                                                     0x666f6e74: "fontsFolder", // "font"
                                                                     0x64666d74: "format", // "dfmt"
                                                                     0x66727370: "freeSpace", // "frsp"
                                                                     0x70697366: "frontmost", // "pisf"
                                                                     0x63757372: "homeFolder", // "cusr"
                                                                     0x49442020: "id", // "ID\0x20\0x20"
                                                                     0x69677072: "ignorePrivileges", // "igpr"
                                                                     0x696d6766: "imageFile", // "imgf"
                                                                     0x70696478: "index", // "pidx"
                                                                     0x6b696e64: "kind", // "kind"
                                                                     0x6c61756e: "launcherItemsFolder", // "laun"
                                                                     0x646c6962: "libraryFolder", // "dlib"
                                                                     0x666c646c: "localDomain", // "fldl"
                                                                     0x69737276: "localVolume", // "isrv"
                                                                     0x704c6f63: "location", // "pLoc"
                                                                     0x69736d6e: "miniaturizable", // "ismn"
                                                                     0x706d6e64: "miniaturized", // "pmnd"
                                                                     0x61736d6f: "modificationDate", // "asmo"
                                                                     0x696d6f64: "modified", // "imod"
                                                                     0x6d646f63: "moviesFolder", // "mdoc"
                                                                     0x25646f63: "musicFolder", // "%doc"
                                                                     0x706e616d: "name", // "pnam"
                                                                     0x6578746e: "nameExtension", // "extn"
                                                                     0x666c646e: "networkDomain", // "fldn"
                                                                     0x706b6766: "packageFolder", // "pkgf"
                                                                     0x6c776c61: "pagesAcross", // "lwla"
                                                                     0x6c776c64: "pagesDown", // "lwld"
                                                                     0x70707468: "path", // "ppth"
                                                                     0x70687973: "physicalSize", // "phys"
                                                                     0x70646f63: "picturesFolder", // "pdoc"
                                                                     0x70506c74: "platform", // "pPlt"
                                                                     0x706f7378: "POSIXPath", // "posx"
                                                                     0x70726566: "preferencesFolder", // "pref"
                                                                     0x70636d6d: "preferredCMM", // "pcmm"
                                                                     0x76657232: "productVersion", // "ver2"
                                                                     0x70666472: "profileFolder", // "pfdr"
                                                                     0x70414c4c: "properties", // "pALL"
                                                                     0x70756262: "publicFolder", // "pubb"
                                                                     0x7051616c: "quality", // "pQal"
                                                                     0x7164656c: "quitDelay", // "qdel"
                                                                     0x70526472: "renderingIntent", // "pRdr"
                                                                     0x6c777174: "requestedPrintTime", // "lwqt"
                                                                     0x7072737a: "resizable", // "prsz"
                                                                     0x7265736f: "resolution", // "reso"
                                                                     0x24736372: "scriptingAdditionsFolder", // "$scr"
                                                                     0x73637224: "scriptsFolder", // "scr$"
                                                                     0x73727672: "server", // "srvr"
                                                                     0x73646174: "sharedDocumentsFolder", // "sdat"
                                                                     0x61737376: "shortVersion", // "assv"
                                                                     0x73686466: "shutdownFolder", // "shdf"
                                                                     0x73697465: "sitesFolder", // "site"
                                                                     0x7074737a: "size", // "ptsz"
                                                                     0x73706b69: "speakableItemsFolder", // "spki"
                                                                     0x6c776670: "startingPage", // "lwfp"
                                                                     0x69737464: "startup", // "istd"
                                                                     0x7364736b: "startupDisk", // "sdsk"
                                                                     0x656d707a: "startupItemsFolder", // "empz"
                                                                     0x70737064: "stationery", // "pspd"
                                                                     0x666c6473: "systemDomain", // "flds"
                                                                     0x6d616373: "systemFolder", // "macs"
                                                                     0x7379737a: "systemProfile", // "sysz"
                                                                     0x73797370: "systemProfileLocation", // "sysp"
                                                                     0x74727072: "targetPrinter", // "trpr"
                                                                     0x74656d70: "temporaryItemsFolder", // "temp"
                                                                     0x74727368: "trash", // "trsh"
                                                                     0x75746964: "typeIdentifier", // "utid"
                                                                     0x75726c20: "URL", // "url\0x20"
                                                                     0x666c6475: "userDomain", // "fldu"
                                                                     0x75746924: "utilitiesFolder", // "uti$"
                                                                     0x76616c4c: "value", // "valL"
                                                                     0x76657273: "version", // "vers"
                                                                     0x70766973: "visible", // "pvis"
                                                                     0x766f6c75: "volume", // "volu"
                                                                     0x666c6f77: "workflowsFolder", // "flow"
                                                                     0x7a6f6e65: "zone", // "zone"
                                                                     0x69737a6d: "zoomable", // "iszm"
                                                                     0x707a756d: "zoomed", // "pzum"
                                                     ],
                                                     elementsNames: [
                                                                     0x616c6973: ("alias", "aliases"), // "alis"
                                                                     0x63617070: ("application", "applications"), // "capp"
                                                                     0x646f6d63: ("Classic domain object", "ClassicDomainObjects"), // "domc"
                                                                     0x6469746d: ("disk item", "diskItems"), // "ditm"
                                                                     0x63646973: ("disk", "disks"), // "cdis"
                                                                     0x64697370: ("display", "displays"), // "disp"
                                                                     0x646f6375: ("document", "documents"), // "docu"
                                                                     0x646f6d61: ("domain", "domains"), // "doma"
                                                                     0x63706b67: ("file package", "filePackages"), // "cpkg"
                                                                     0x66696c65: ("file", "files"), // "file"
                                                                     0x63666f6c: ("folder", "folders"), // "cfol"
                                                                     0x696d6167: ("image", "images"), // "imag"
                                                                     0x636f626a: ("item", "items"), // "cobj"
                                                                     0x646f6d6c: ("local domain object", "localDomainObjects"), // "doml"
                                                                     0x74616720: ("metadata tag", "metadataTags"), // "tag\0x20"
                                                                     0x646f6d6e: ("network domain object", "networkDomainObjects"), // "domn"
                                                                     0x70726f66: ("profile", "profiles"), // "prof"
                                                                     0x646f6d73: ("system domain object", "systemDomainObjects"), // "doms"
                                                                     0x646f6d75: ("user domain object", "userDomainObjects"), // "domu"
                                                                     0x6377696e: ("window", "windows"), // "cwin"
                                                     ])

private let _glueClasses = SwiftAutomation.GlueClasses(insertionSpecifierType: IEVInsertion.self,
                                       objectSpecifierType: IEVItem.self,
                                       multiObjectSpecifierType: IEVItems.self,
                                       rootSpecifierType: IEVRoot.self,
                                       applicationType: ImageEvents.self,
                                       symbolType: IEVSymbol.self,
                                       formatter: _specifierFormatter)

private let _untargetedAppData = SwiftAutomation.AppData(glueClasses: _glueClasses)


/******************************************************************************/
// Symbol subclass defines static type/enum/property constants based on Image Events.app terminology

public class IEVSymbol: SwiftAutomation.Symbol {

    override public var typeAliasName: String {return "IEV"}

    public override class func symbol(code: OSType, type: OSType = typeType, descriptor: NSAppleEventDescriptor? = nil) -> IEVSymbol {
        switch (code) {
        case 0x52647233: return self.absoluteColorimetricIntent // "Rdr3"
        case 0x61627374: return self.abstract // "abst"
        case 0x616c6973: return self.alias // "alis"
        case 0x2a2a2a2a: return self.anything // "****"
        case 0x616d6e75: return self.appleMenuFolder // "amnu"
        case 0x64667068: return self.ApplePhotoFormat // "dfph"
        case 0x64666173: return self.AppleShareFormat // "dfas"
        case 0x63617070: return self.application // "capp"
        case 0x62756e64: return self.applicationBundleID // "bund"
        case 0x61707073: return self.applicationsFolder // "apps"
        case 0x7369676e: return self.applicationSignature // "sign"
        case 0x61737570: return self.applicationSupportFolder // "asup"
        case 0x6170726c: return self.applicationURL // "aprl"
        case 0x61707220: return self.April // "apr\0x20"
        case 0x61736b20: return self.ask // "ask\0x20"
        case 0x64666175: return self.audioFormat // "dfau"
        case 0x61756720: return self.August // "aug\0x20"
        case 0x62657374: return self.best // "best"
        case 0x51756132: return self.best_ // "Qua2"
        case 0x70647074: return self.bitDepth // "pdpt"
        case 0x62267720: return self.blackAndWhite // "b&w\0x20"
        case 0x424d5066: return self.BMP // "BMPf"
        case 0x626d726b: return self.bookmarkData // "bmrk"
        case 0x626f6f6c: return self.boolean // "bool"
        case 0x71647274: return self.boundingRectangle // "qdrt"
        case 0x70626e64: return self.bounds // "pbnd"
        case 0x62757379: return self.busyStatus // "busy"
        case 0x63617061: return self.capacity // "capa"
        case 0x63617365: return self.case_ // "case"
        case 0x70636c73: return self.class_ // "pcls"
        case 0x666c6463: return self.ClassicDomain // "fldc"
        case 0x646f6d63: return self.ClassicDomainObject // "domc"
        case 0x68636c62: return self.closeable // "hclb"
        case 0x434d594b: return self.CMYK // "CMYK"
        case 0x6c77636c: return self.collating // "lwcl"
        case 0x636f6c72: return self.color // "colr"
        case 0x73706163: return self.colorspace // "spac"
        case 0x70537063: return self.colorSpace // "pSpc"
        case 0x636c7274: return self.colorTable // "clrt"
        case 0x70504353: return self.connectionSpace // "pPCS"
        case 0x656e756d: return self.constant // "enum"
        case 0x63746e72: return self.container // "ctnr"
        case 0x6374726c: return self.controlPanelsFolder // "ctrl"
        case 0x73646576: return self.controlStripModulesFolder // "sdev"
        case 0x6c776370: return self.copies // "lwcp"
        case 0x61736364: return self.creationDate // "ascd"
        case 0x70437265: return self.creator // "pCre"
        case 0x66637274: return self.creatorType // "fcrt"
        case 0x74646173: return self.dashStyle // "tdas"
        case 0x74647461: return self.data // "tdta"
        case 0x6c647420: return self.date // "ldt\0x20"
        case 0x64656320: return self.December // "dec\0x20"
        case 0x6465636d: return self.decimalStruct // "decm"
        case 0x61736461: return self.defaultApplication // "asda"
        case 0x434d4b50: return self.defaultCMYKProfile // "CMKP"
        case 0x434d4b70: return self.defaultCMYKProfileLocation // "CMKp"
        case 0x47525950: return self.defaultGrayProfile // "GRYP"
        case 0x47525970: return self.defaultGrayProfileLocation // "GRYp"
        case 0x4c616250: return self.defaultLabProfile // "LabP"
        case 0x4c616270: return self.defaultLabProfileLocation // "Labp"
        case 0x52474250: return self.defaultRGBProfile // "RGBP"
        case 0x52474270: return self.defaultRGBProfileLocation // "RGBp"
        case 0x58595a50: return self.defaultXYZProfile // "XYZP"
        case 0x58595a70: return self.defaultXYZProfileLocation // "XYZp"
        case 0x64736372: return self.description_ // "dscr"
        case 0x6465736b: return self.desktopFolder // "desk"
        case 0x64747024: return self.desktopPicturesFolder // "dtp$"
        case 0x6c776474: return self.detailed // "lwdt"
        case 0x70436c61: return self.deviceClass // "pCla"
        case 0x704d616e: return self.deviceManufacturer // "pMan"
        case 0x704d6f64: return self.deviceModel // "pMod"
        case 0x64696163: return self.diacriticals // "diac"
        case 0x646d6e73: return self.dimensions // "dmns"
        case 0x63646973: return self.disk // "cdis"
        case 0x6469746d: return self.diskItem // "ditm"
        case 0x64697370: return self.display // "disp"
        case 0x646e616d: return self.displayedName // "dnam"
        case 0x6d4e756d: return self.displayNumber // "mNum"
        case 0x6d507266: return self.displayProfile // "mPrf"
        case 0x646f6375: return self.document // "docu"
        case 0x646f6373: return self.documentsFolder // "docs"
        case 0x646f6d61: return self.domain // "doma"
        case 0x636f6d70: return self.doubleInteger // "comp"
        case 0x646f776e: return self.downloadsFolder // "down"
        case 0x51756131: return self.draft // "Qua1"
        case 0x4d434838: return self.EightChannel // "MCH8"
        case 0x38434c52: return self.EightColor // "8CLR"
        case 0x6973656a: return self.ejectable // "isej"
        case 0x65707266: return self.embeddedProfile // "eprf"
        case 0x656e6373: return self.encodedString // "encs"
        case 0x6c776c70: return self.endingPage // "lwlp"
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
        case 0x4d434835: return self.FiveChannel // "MCH5"
        case 0x35434c52: return self.FiveColor // "5CLR"
        case 0x66697864: return self.fixed // "fixd"
        case 0x66706e74: return self.fixedPoint // "fpnt"
        case 0x66726374: return self.fixedRectangle // "frct"
        case 0x63666f6c: return self.folder // "cfol"
        case 0x66617366: return self.FolderActionScriptsFolder // "fasf"
        case 0x666f6e74: return self.fontsFolder // "font"
        case 0x64666d74: return self.format // "dfmt"
        case 0x34636c72: return self.fourColors // "4clr"
        case 0x34677279: return self.fourGrays // "4gry"
        case 0x66727370: return self.freeSpace // "frsp"
        case 0x66726920: return self.Friday // "fri\0x20"
        case 0x70697366: return self.frontmost // "pisf"
        case 0x47494620: return self.GIF // "GIF\0x20"
        case 0x47494666: return self.GIFPicture // "GIFf"
        case 0x63677478: return self.graphicText // "cgtx"
        case 0x47524159: return self.Gray // "GRAY"
        case 0x67726179: return self.grayscale // "gray"
        case 0x68696768: return self.high // "high"
        case 0x64666873: return self.HighSierraFormat // "dfhs"
        case 0x63757372: return self.homeFolder // "cusr"
        case 0x68797068: return self.hyphens // "hyph"
        case 0x49442020: return self.id // "ID\0x20\0x20"
        case 0x69677072: return self.ignorePrivileges // "igpr"
        case 0x696d6167: return self.image // "imag"
        case 0x696d6766: return self.imageFile // "imgf"
        case 0x70696478: return self.index // "pidx"
        case 0x73636e72: return self.input // "scnr"
        case 0x6c6f6e67: return self.integer // "long"
        case 0x69747874: return self.internationalText // "itxt"
        case 0x696e746c: return self.internationalWritingCode // "intl"
        case 0x64663936: return self.ISO9660Format // "df96"
        case 0x636f626a: return self.item // "cobj"
        case 0x6a616e20: return self.January // "jan\0x20"
        case 0x4a504547: return self.JPEG // "JPEG"
        case 0x6a706732: return self.JPEG2 // "jpg2"
        case 0x6a756c20: return self.July // "jul\0x20"
        case 0x6a756e20: return self.June // "jun\0x20"
        case 0x6b706964: return self.kernelProcessID // "kpid"
        case 0x6b696e64: return self.kind // "kind"
        case 0x4c616220: return self.Lab // "Lab\0x20"
        case 0x6c64626c: return self.largeReal // "ldbl"
        case 0x6c61756e: return self.launcherItemsFolder // "laun"
        case 0x6c656173: return self.least // "leas"
        case 0x646c6962: return self.libraryFolder // "dlib"
        case 0x6c696e6b: return self.link // "link"
        case 0x6c697374: return self.list // "list"
        case 0x666c646c: return self.localDomain // "fldl"
        case 0x646f6d6c: return self.localDomainObject // "doml"
        case 0x69737276: return self.localVolume // "isrv"
        case 0x704c6f63: return self.location // "pLoc"
        case 0x696e736c: return self.locationReference // "insl"
        case 0x6c667864: return self.longFixed // "lfxd"
        case 0x6c667074: return self.longFixedPoint // "lfpt"
        case 0x6c667263: return self.longFixedRectangle // "lfrc"
        case 0x6c706e74: return self.longPoint // "lpnt"
        case 0x6c726374: return self.longRectangle // "lrct"
        case 0x6c6f7720: return self.low // "low\0x20"
        case 0x6d616368: return self.machine // "mach"
        case 0x6d4c6f63: return self.machineLocation // "mLoc"
        case 0x706f7274: return self.machPort // "port"
        case 0x6466682b: return self.MacOSExtendedFormat // "dfh+"
        case 0x64666866: return self.MacOSFormat // "dfhf"
        case 0x504e5447: return self.MacPaint // "PNTG"
        case 0x6d617220: return self.March // "mar\0x20"
        case 0x6d617920: return self.May // "may\0x20"
        case 0x6d656469: return self.medium // "medi"
        case 0x74616720: return self.metadataTag // "tag\0x20"
        case 0x6d696c6c: return self.millionsOfColors // "mill"
        case 0x6d696c2b: return self.millionsOfColorsPlus // "mil+"
        case 0x69736d6e: return self.miniaturizable // "ismn"
        case 0x706d6e64: return self.miniaturized // "pmnd"
        case 0x61736d6f: return self.modificationDate // "asmo"
        case 0x696d6f64: return self.modified // "imod"
        case 0x6d6f6e20: return self.Monday // "mon\0x20"
        case 0x6d6e7472: return self.monitor // "mntr"
        case 0x6d646f63: return self.moviesFolder // "mdoc"
        case 0x64666d73: return self.MSDOSFormat // "dfms"
        case 0x25646f63: return self.musicFolder // "%doc"
        case 0x706e616d: return self.name // "pnam"
        case 0x4e414d45: return self.Named // "NAME"
        case 0x6e6d636c: return self.named_ // "nmcl"
        case 0x6578746e: return self.nameExtension // "extn"
        case 0x666c646e: return self.networkDomain // "fldn"
        case 0x646f6d6e: return self.networkDomainObject // "domn"
        case 0x64666e66: return self.NFSFormat // "dfnf"
        case 0x6e6f2020: return self.no // "no\0x20\0x20"
        case 0x51756130: return self.normal // "Qua0"
        case 0x6e6f7620: return self.November // "nov\0x20"
        case 0x6e756c6c: return self.null // "null"
        case 0x6e756d65: return self.numericStrings // "nume"
        case 0x6f637420: return self.October // "oct\0x20"
        case 0x70727472: return self.output // "prtr"
        case 0x706b6766: return self.packageFolder // "pkgf"
        case 0x6c776c61: return self.pagesAcross // "lwla"
        case 0x6c776c64: return self.pagesDown // "lwld"
        case 0x70707468: return self.path // "ppth"
        case 0x50444620: return self.PDF // "PDF\0x20"
        case 0x52647230: return self.perceptualIntent // "Rdr0"
        case 0x38425053: return self.Photoshop // "8BPS"
        case 0x70687973: return self.physicalSize // "phys"
        case 0x50494354: return self.PICT // "PICT"
        case 0x70646f63: return self.picturesFolder // "pdoc"
        case 0x74706d6d: return self.pixelMapRecord // "tpmm"
        case 0x70506c74: return self.platform // "pPlt"
        case 0x504e4766: return self.PNG // "PNGf"
        case 0x51447074: return self.point // "QDpt"
        case 0x706f7378: return self.POSIXPath // "posx"
        case 0x70726566: return self.preferencesFolder // "pref"
        case 0x70636d6d: return self.preferredCMM // "pcmm"
        case 0x70736574: return self.printSettings // "pset"
        case 0x70736e20: return self.processSerialNumber // "psn\0x20"
        case 0x64667072: return self.ProDOSFormat // "dfpr"
        case 0x76657232: return self.productVersion // "ver2"
        case 0x70726f66: return self.profile // "prof"
        case 0x70666472: return self.profileFolder // "pfdr"
        case 0x70414c4c: return self.properties // "pALL"
        case 0x70726f70: return self.property_ // "prop"
        case 0x70736420: return self.PSD // "psd\0x20"
        case 0x70756262: return self.publicFolder // "pubb"
        case 0x70756e63: return self.punctuation // "punc"
        case 0x7051616c: return self.quality // "pQal"
        case 0x64667174: return self.QuickTakeFormat // "dfqt"
        case 0x71746966: return self.QuickTimeImage // "qtif"
        case 0x7164656c: return self.quitDelay // "qdel"
        case 0x646f7562: return self.real // "doub"
        case 0x7265636f: return self.record // "reco"
        case 0x6f626a20: return self.reference // "obj\0x20"
        case 0x52647231: return self.relativeColorimetricIntent // "Rdr1"
        case 0x70526472: return self.renderingIntent // "pRdr"
        case 0x6c777174: return self.requestedPrintTime // "lwqt"
        case 0x7072737a: return self.resizable // "prsz"
        case 0x7265736f: return self.resolution // "reso"
        case 0x52474220: return self.RGB // "RGB\0x20"
        case 0x74723136: return self.RGB16Color // "tr16"
        case 0x74723936: return self.RGB96Color // "tr96"
        case 0x63524742: return self.RGBColor // "cRGB"
        case 0x74726f74: return self.rotation // "trot"
        case 0x52647232: return self.saturationIntent // "Rdr2"
        case 0x73617420: return self.Saturday // "sat\0x20"
        case 0x73637074: return self.script // "scpt"
        case 0x24736372: return self.scriptingAdditionsFolder // "$scr"
        case 0x73637224: return self.scriptsFolder // "scr$"
        case 0x73657020: return self.September // "sep\0x20"
        case 0x73727672: return self.server // "srvr"
        case 0x4d434837: return self.SevenChannel // "MCH7"
        case 0x37434c52: return self.SevenColor // "7CLR"
        case 0x2e534749: return self.SGI // ".SGI"
        case 0x73646174: return self.sharedDocumentsFolder // "sdat"
        case 0x73686f72: return self.shortInteger // "shor"
        case 0x61737376: return self.shortVersion // "assv"
        case 0x73686466: return self.shutdownFolder // "shdf"
        case 0x73697465: return self.sitesFolder // "site"
        case 0x4d434836: return self.SixChannel // "MCH6"
        case 0x36434c52: return self.SixColor // "6CLR"
        case 0x3136636c: return self.sixteenColors // "16cl"
        case 0x31366772: return self.sixteenGrays // "16gr"
        case 0x7074737a: return self.size // "ptsz"
        case 0x73696e67: return self.smallReal // "sing"
        case 0x73706b69: return self.speakableItemsFolder // "spki"
        case 0x6c777374: return self.standard // "lwst"
        case 0x6c776670: return self.startingPage // "lwfp"
        case 0x69737464: return self.startup // "istd"
        case 0x7364736b: return self.startupDisk // "sdsk"
        case 0x656d707a: return self.startupItemsFolder // "empz"
        case 0x70737064: return self.stationery // "pspd"
        case 0x7374796c: return self.styledClipboardText // "styl"
        case 0x53545854: return self.styledText // "STXT"
        case 0x73756e20: return self.Sunday // "sun\0x20"
        case 0x666c6473: return self.systemDomain // "flds"
        case 0x646f6d73: return self.systemDomainObject // "doms"
        case 0x6d616373: return self.systemFolder // "macs"
        case 0x7379737a: return self.systemProfile // "sysz"
        case 0x73797370: return self.systemProfileLocation // "sysp"
        case 0x74727072: return self.targetPrinter // "trpr"
        case 0x74656d70: return self.temporaryItemsFolder // "temp"
        case 0x63747874: return self.text // "ctxt"
        case 0x54455854: return self.Text // "TEXT"
        case 0x74737479: return self.textStyleInfo // "tsty"
        case 0x74676120: return self.TGA // "tga\0x20"
        case 0x74686f75: return self.thousandsOfColors // "thou"
        case 0x74687520: return self.Thursday // "thu\0x20"
        case 0x54494646: return self.TIFF // "TIFF"
        case 0x74727368: return self.trash // "trsh"
        case 0x74756520: return self.Tuesday // "tue\0x20"
        case 0x32353663: return self.twoHundredFiftySixColors // "256c"
        case 0x32353667: return self.twoHundredFiftySixGrays // "256g"
        case 0x74797065: return self.typeClass // "type"
        case 0x75746964: return self.typeIdentifier // "utid"
        case 0x64667564: return self.UDFFormat // "dfud"
        case 0x64667566: return self.UFSFormat // "dfuf"
        case 0x75747874: return self.UnicodeText // "utxt"
        case 0x64662424: return self.unknownFormat // "df$$"
        case 0x75636f6d: return self.unsignedDoubleInteger // "ucom"
        case 0x6d61676e: return self.unsignedInteger // "magn"
        case 0x75736872: return self.unsignedShortInteger // "ushr"
        case 0x75726c20: return self.URL // "url\0x20"
        case 0x666c6475: return self.userDomain // "fldu"
        case 0x646f6d75: return self.userDomainObject // "domu"
        case 0x75743136: return self.UTF16Text // "ut16"
        case 0x75746638: return self.UTF8Text // "utf8"
        case 0x75746924: return self.utilitiesFolder // "uti$"
        case 0x76616c4c: return self.value // "valL"
        case 0x76657273: return self.version // "vers"
        case 0x70766973: return self.visible // "pvis"
        case 0x766f6c75: return self.volume // "volu"
        case 0x64667764: return self.WebDAVFormat // "dfwd"
        case 0x77656420: return self.Wednesday // "wed\0x20"
        case 0x77686974: return self.whitespace // "whit"
        case 0x6377696e: return self.window // "cwin"
        case 0x666c6f77: return self.workflowsFolder // "flow"
        case 0x70736374: return self.writingCode // "psct"
        case 0x58595a20: return self.XYZ // "XYZ\0x20"
        case 0x79657320: return self.yes // "yes\0x20"
        case 0x7a6f6e65: return self.zone // "zone"
        case 0x69737a6d: return self.zoomable // "iszm"
        case 0x707a756d: return self.zoomed // "pzum"
        default: return super.symbol(code: code, type: type, descriptor: descriptor) as! IEVSymbol
        }
    }

    // Types/properties
    public static let alias = IEVSymbol(name: "alias", code: 0x616c6973, type: typeType) // "alis"
    public static let anything = IEVSymbol(name: "anything", code: 0x2a2a2a2a, type: typeType) // "****"
    public static let appleMenuFolder = IEVSymbol(name: "appleMenuFolder", code: 0x616d6e75, type: typeType) // "amnu"
    public static let application = IEVSymbol(name: "application", code: 0x63617070, type: typeType) // "capp"
    public static let applicationBundleID = IEVSymbol(name: "applicationBundleID", code: 0x62756e64, type: typeType) // "bund"
    public static let applicationsFolder = IEVSymbol(name: "applicationsFolder", code: 0x61707073, type: typeType) // "apps"
    public static let applicationSignature = IEVSymbol(name: "applicationSignature", code: 0x7369676e, type: typeType) // "sign"
    public static let applicationSupportFolder = IEVSymbol(name: "applicationSupportFolder", code: 0x61737570, type: typeType) // "asup"
    public static let applicationURL = IEVSymbol(name: "applicationURL", code: 0x6170726c, type: typeType) // "aprl"
    public static let April = IEVSymbol(name: "April", code: 0x61707220, type: typeType) // "apr\0x20"
    public static let August = IEVSymbol(name: "August", code: 0x61756720, type: typeType) // "aug\0x20"
    public static let bitDepth = IEVSymbol(name: "bitDepth", code: 0x70647074, type: typeType) // "pdpt"
    public static let bookmarkData = IEVSymbol(name: "bookmarkData", code: 0x626d726b, type: typeType) // "bmrk"
    public static let boolean = IEVSymbol(name: "boolean", code: 0x626f6f6c, type: typeType) // "bool"
    public static let boundingRectangle = IEVSymbol(name: "boundingRectangle", code: 0x71647274, type: typeType) // "qdrt"
    public static let bounds = IEVSymbol(name: "bounds", code: 0x70626e64, type: typeType) // "pbnd"
    public static let busyStatus = IEVSymbol(name: "busyStatus", code: 0x62757379, type: typeType) // "busy"
    public static let capacity = IEVSymbol(name: "capacity", code: 0x63617061, type: typeType) // "capa"
    public static let class_ = IEVSymbol(name: "class_", code: 0x70636c73, type: typeType) // "pcls"
    public static let ClassicDomain = IEVSymbol(name: "ClassicDomain", code: 0x666c6463, type: typeType) // "fldc"
    public static let ClassicDomainObject = IEVSymbol(name: "ClassicDomainObject", code: 0x646f6d63, type: typeType) // "domc"
    public static let closeable = IEVSymbol(name: "closeable", code: 0x68636c62, type: typeType) // "hclb"
    public static let collating = IEVSymbol(name: "collating", code: 0x6c77636c, type: typeType) // "lwcl"
    public static let colorSpace = IEVSymbol(name: "colorSpace", code: 0x70537063, type: typeType) // "pSpc"
    public static let colorTable = IEVSymbol(name: "colorTable", code: 0x636c7274, type: typeType) // "clrt"
    public static let connectionSpace = IEVSymbol(name: "connectionSpace", code: 0x70504353, type: typeType) // "pPCS"
    public static let constant = IEVSymbol(name: "constant", code: 0x656e756d, type: typeType) // "enum"
    public static let container = IEVSymbol(name: "container", code: 0x63746e72, type: typeType) // "ctnr"
    public static let controlPanelsFolder = IEVSymbol(name: "controlPanelsFolder", code: 0x6374726c, type: typeType) // "ctrl"
    public static let controlStripModulesFolder = IEVSymbol(name: "controlStripModulesFolder", code: 0x73646576, type: typeType) // "sdev"
    public static let copies = IEVSymbol(name: "copies", code: 0x6c776370, type: typeType) // "lwcp"
    public static let creationDate = IEVSymbol(name: "creationDate", code: 0x61736364, type: typeType) // "ascd"
    public static let creator = IEVSymbol(name: "creator", code: 0x70437265, type: typeType) // "pCre"
    public static let creatorType = IEVSymbol(name: "creatorType", code: 0x66637274, type: typeType) // "fcrt"
    public static let dashStyle = IEVSymbol(name: "dashStyle", code: 0x74646173, type: typeType) // "tdas"
    public static let data = IEVSymbol(name: "data", code: 0x74647461, type: typeType) // "tdta"
    public static let date = IEVSymbol(name: "date", code: 0x6c647420, type: typeType) // "ldt\0x20"
    public static let December = IEVSymbol(name: "December", code: 0x64656320, type: typeType) // "dec\0x20"
    public static let decimalStruct = IEVSymbol(name: "decimalStruct", code: 0x6465636d, type: typeType) // "decm"
    public static let defaultApplication = IEVSymbol(name: "defaultApplication", code: 0x61736461, type: typeType) // "asda"
    public static let defaultCMYKProfile = IEVSymbol(name: "defaultCMYKProfile", code: 0x434d4b50, type: typeType) // "CMKP"
    public static let defaultCMYKProfileLocation = IEVSymbol(name: "defaultCMYKProfileLocation", code: 0x434d4b70, type: typeType) // "CMKp"
    public static let defaultGrayProfile = IEVSymbol(name: "defaultGrayProfile", code: 0x47525950, type: typeType) // "GRYP"
    public static let defaultGrayProfileLocation = IEVSymbol(name: "defaultGrayProfileLocation", code: 0x47525970, type: typeType) // "GRYp"
    public static let defaultLabProfile = IEVSymbol(name: "defaultLabProfile", code: 0x4c616250, type: typeType) // "LabP"
    public static let defaultLabProfileLocation = IEVSymbol(name: "defaultLabProfileLocation", code: 0x4c616270, type: typeType) // "Labp"
    public static let defaultRGBProfile = IEVSymbol(name: "defaultRGBProfile", code: 0x52474250, type: typeType) // "RGBP"
    public static let defaultRGBProfileLocation = IEVSymbol(name: "defaultRGBProfileLocation", code: 0x52474270, type: typeType) // "RGBp"
    public static let defaultXYZProfile = IEVSymbol(name: "defaultXYZProfile", code: 0x58595a50, type: typeType) // "XYZP"
    public static let defaultXYZProfileLocation = IEVSymbol(name: "defaultXYZProfileLocation", code: 0x58595a70, type: typeType) // "XYZp"
    public static let description_ = IEVSymbol(name: "description_", code: 0x64736372, type: typeType) // "dscr"
    public static let desktopFolder = IEVSymbol(name: "desktopFolder", code: 0x6465736b, type: typeType) // "desk"
    public static let desktopPicturesFolder = IEVSymbol(name: "desktopPicturesFolder", code: 0x64747024, type: typeType) // "dtp$"
    public static let deviceClass = IEVSymbol(name: "deviceClass", code: 0x70436c61, type: typeType) // "pCla"
    public static let deviceManufacturer = IEVSymbol(name: "deviceManufacturer", code: 0x704d616e, type: typeType) // "pMan"
    public static let deviceModel = IEVSymbol(name: "deviceModel", code: 0x704d6f64, type: typeType) // "pMod"
    public static let dimensions = IEVSymbol(name: "dimensions", code: 0x646d6e73, type: typeType) // "dmns"
    public static let disk = IEVSymbol(name: "disk", code: 0x63646973, type: typeType) // "cdis"
    public static let diskItem = IEVSymbol(name: "diskItem", code: 0x6469746d, type: typeType) // "ditm"
    public static let display = IEVSymbol(name: "display", code: 0x64697370, type: typeType) // "disp"
    public static let displayedName = IEVSymbol(name: "displayedName", code: 0x646e616d, type: typeType) // "dnam"
    public static let displayNumber = IEVSymbol(name: "displayNumber", code: 0x6d4e756d, type: typeType) // "mNum"
    public static let displayProfile = IEVSymbol(name: "displayProfile", code: 0x6d507266, type: typeType) // "mPrf"
    public static let document = IEVSymbol(name: "document", code: 0x646f6375, type: typeType) // "docu"
    public static let documentsFolder = IEVSymbol(name: "documentsFolder", code: 0x646f6373, type: typeType) // "docs"
    public static let domain = IEVSymbol(name: "domain", code: 0x646f6d61, type: typeType) // "doma"
    public static let doubleInteger = IEVSymbol(name: "doubleInteger", code: 0x636f6d70, type: typeType) // "comp"
    public static let downloadsFolder = IEVSymbol(name: "downloadsFolder", code: 0x646f776e, type: typeType) // "down"
    public static let ejectable = IEVSymbol(name: "ejectable", code: 0x6973656a, type: typeType) // "isej"
    public static let embeddedProfile = IEVSymbol(name: "embeddedProfile", code: 0x65707266, type: typeType) // "eprf"
    public static let encodedString = IEVSymbol(name: "encodedString", code: 0x656e6373, type: typeType) // "encs"
    public static let endingPage = IEVSymbol(name: "endingPage", code: 0x6c776c70, type: typeType) // "lwlp"
    public static let EPSPicture = IEVSymbol(name: "EPSPicture", code: 0x45505320, type: typeType) // "EPS\0x20"
    public static let errorHandling = IEVSymbol(name: "errorHandling", code: 0x6c776568, type: typeType) // "lweh"
    public static let extendedReal = IEVSymbol(name: "extendedReal", code: 0x65787465, type: typeType) // "exte"
    public static let extensionsFolder = IEVSymbol(name: "extensionsFolder", code: 0x6578747a, type: typeType) // "extz"
    public static let favoritesFolder = IEVSymbol(name: "favoritesFolder", code: 0x66617673, type: typeType) // "favs"
    public static let faxNumber = IEVSymbol(name: "faxNumber", code: 0x6661786e, type: typeType) // "faxn"
    public static let February = IEVSymbol(name: "February", code: 0x66656220, type: typeType) // "feb\0x20"
    public static let file = IEVSymbol(name: "file", code: 0x66696c65, type: typeType) // "file"
    public static let filePackage = IEVSymbol(name: "filePackage", code: 0x63706b67, type: typeType) // "cpkg"
    public static let fileRef = IEVSymbol(name: "fileRef", code: 0x66737266, type: typeType) // "fsrf"
    public static let fileSpecification = IEVSymbol(name: "fileSpecification", code: 0x66737320, type: typeType) // "fss\0x20"
    public static let fileType = IEVSymbol(name: "fileType", code: 0x61737479, type: typeType) // "asty"
    public static let fileURL = IEVSymbol(name: "fileURL", code: 0x6675726c, type: typeType) // "furl"
    public static let fixed = IEVSymbol(name: "fixed", code: 0x66697864, type: typeType) // "fixd"
    public static let fixedPoint = IEVSymbol(name: "fixedPoint", code: 0x66706e74, type: typeType) // "fpnt"
    public static let fixedRectangle = IEVSymbol(name: "fixedRectangle", code: 0x66726374, type: typeType) // "frct"
    public static let folder = IEVSymbol(name: "folder", code: 0x63666f6c, type: typeType) // "cfol"
    public static let FolderActionScriptsFolder = IEVSymbol(name: "FolderActionScriptsFolder", code: 0x66617366, type: typeType) // "fasf"
    public static let fontsFolder = IEVSymbol(name: "fontsFolder", code: 0x666f6e74, type: typeType) // "font"
    public static let format = IEVSymbol(name: "format", code: 0x64666d74, type: typeType) // "dfmt"
    public static let freeSpace = IEVSymbol(name: "freeSpace", code: 0x66727370, type: typeType) // "frsp"
    public static let Friday = IEVSymbol(name: "Friday", code: 0x66726920, type: typeType) // "fri\0x20"
    public static let frontmost = IEVSymbol(name: "frontmost", code: 0x70697366, type: typeType) // "pisf"
    public static let GIFPicture = IEVSymbol(name: "GIFPicture", code: 0x47494666, type: typeType) // "GIFf"
    public static let graphicText = IEVSymbol(name: "graphicText", code: 0x63677478, type: typeType) // "cgtx"
    public static let homeFolder = IEVSymbol(name: "homeFolder", code: 0x63757372, type: typeType) // "cusr"
    public static let id = IEVSymbol(name: "id", code: 0x49442020, type: typeType) // "ID\0x20\0x20"
    public static let ignorePrivileges = IEVSymbol(name: "ignorePrivileges", code: 0x69677072, type: typeType) // "igpr"
    public static let image = IEVSymbol(name: "image", code: 0x696d6167, type: typeType) // "imag"
    public static let imageFile = IEVSymbol(name: "imageFile", code: 0x696d6766, type: typeType) // "imgf"
    public static let index = IEVSymbol(name: "index", code: 0x70696478, type: typeType) // "pidx"
    public static let integer = IEVSymbol(name: "integer", code: 0x6c6f6e67, type: typeType) // "long"
    public static let internationalText = IEVSymbol(name: "internationalText", code: 0x69747874, type: typeType) // "itxt"
    public static let internationalWritingCode = IEVSymbol(name: "internationalWritingCode", code: 0x696e746c, type: typeType) // "intl"
    public static let item = IEVSymbol(name: "item", code: 0x636f626a, type: typeType) // "cobj"
    public static let January = IEVSymbol(name: "January", code: 0x6a616e20, type: typeType) // "jan\0x20"
    public static let JPEGPicture = IEVSymbol(name: "JPEGPicture", code: 0x4a504547, type: typeType) // "JPEG"
    public static let July = IEVSymbol(name: "July", code: 0x6a756c20, type: typeType) // "jul\0x20"
    public static let June = IEVSymbol(name: "June", code: 0x6a756e20, type: typeType) // "jun\0x20"
    public static let kernelProcessID = IEVSymbol(name: "kernelProcessID", code: 0x6b706964, type: typeType) // "kpid"
    public static let kind = IEVSymbol(name: "kind", code: 0x6b696e64, type: typeType) // "kind"
    public static let largeReal = IEVSymbol(name: "largeReal", code: 0x6c64626c, type: typeType) // "ldbl"
    public static let launcherItemsFolder = IEVSymbol(name: "launcherItemsFolder", code: 0x6c61756e, type: typeType) // "laun"
    public static let libraryFolder = IEVSymbol(name: "libraryFolder", code: 0x646c6962, type: typeType) // "dlib"
    public static let list = IEVSymbol(name: "list", code: 0x6c697374, type: typeType) // "list"
    public static let localDomain = IEVSymbol(name: "localDomain", code: 0x666c646c, type: typeType) // "fldl"
    public static let localDomainObject = IEVSymbol(name: "localDomainObject", code: 0x646f6d6c, type: typeType) // "doml"
    public static let localVolume = IEVSymbol(name: "localVolume", code: 0x69737276, type: typeType) // "isrv"
    public static let location = IEVSymbol(name: "location", code: 0x704c6f63, type: typeType) // "pLoc"
    public static let locationReference = IEVSymbol(name: "locationReference", code: 0x696e736c, type: typeType) // "insl"
    public static let longFixed = IEVSymbol(name: "longFixed", code: 0x6c667864, type: typeType) // "lfxd"
    public static let longFixedPoint = IEVSymbol(name: "longFixedPoint", code: 0x6c667074, type: typeType) // "lfpt"
    public static let longFixedRectangle = IEVSymbol(name: "longFixedRectangle", code: 0x6c667263, type: typeType) // "lfrc"
    public static let longPoint = IEVSymbol(name: "longPoint", code: 0x6c706e74, type: typeType) // "lpnt"
    public static let longRectangle = IEVSymbol(name: "longRectangle", code: 0x6c726374, type: typeType) // "lrct"
    public static let machine = IEVSymbol(name: "machine", code: 0x6d616368, type: typeType) // "mach"
    public static let machineLocation = IEVSymbol(name: "machineLocation", code: 0x6d4c6f63, type: typeType) // "mLoc"
    public static let machPort = IEVSymbol(name: "machPort", code: 0x706f7274, type: typeType) // "port"
    public static let March = IEVSymbol(name: "March", code: 0x6d617220, type: typeType) // "mar\0x20"
    public static let May = IEVSymbol(name: "May", code: 0x6d617920, type: typeType) // "may\0x20"
    public static let metadataTag = IEVSymbol(name: "metadataTag", code: 0x74616720, type: typeType) // "tag\0x20"
    public static let miniaturizable = IEVSymbol(name: "miniaturizable", code: 0x69736d6e, type: typeType) // "ismn"
    public static let miniaturized = IEVSymbol(name: "miniaturized", code: 0x706d6e64, type: typeType) // "pmnd"
    public static let modificationDate = IEVSymbol(name: "modificationDate", code: 0x61736d6f, type: typeType) // "asmo"
    public static let modified = IEVSymbol(name: "modified", code: 0x696d6f64, type: typeType) // "imod"
    public static let Monday = IEVSymbol(name: "Monday", code: 0x6d6f6e20, type: typeType) // "mon\0x20"
    public static let moviesFolder = IEVSymbol(name: "moviesFolder", code: 0x6d646f63, type: typeType) // "mdoc"
    public static let musicFolder = IEVSymbol(name: "musicFolder", code: 0x25646f63, type: typeType) // "%doc"
    public static let name = IEVSymbol(name: "name", code: 0x706e616d, type: typeType) // "pnam"
    public static let nameExtension = IEVSymbol(name: "nameExtension", code: 0x6578746e, type: typeType) // "extn"
    public static let networkDomain = IEVSymbol(name: "networkDomain", code: 0x666c646e, type: typeType) // "fldn"
    public static let networkDomainObject = IEVSymbol(name: "networkDomainObject", code: 0x646f6d6e, type: typeType) // "domn"
    public static let November = IEVSymbol(name: "November", code: 0x6e6f7620, type: typeType) // "nov\0x20"
    public static let null = IEVSymbol(name: "null", code: 0x6e756c6c, type: typeType) // "null"
    public static let October = IEVSymbol(name: "October", code: 0x6f637420, type: typeType) // "oct\0x20"
    public static let packageFolder = IEVSymbol(name: "packageFolder", code: 0x706b6766, type: typeType) // "pkgf"
    public static let pagesAcross = IEVSymbol(name: "pagesAcross", code: 0x6c776c61, type: typeType) // "lwla"
    public static let pagesDown = IEVSymbol(name: "pagesDown", code: 0x6c776c64, type: typeType) // "lwld"
    public static let path = IEVSymbol(name: "path", code: 0x70707468, type: typeType) // "ppth"
    public static let physicalSize = IEVSymbol(name: "physicalSize", code: 0x70687973, type: typeType) // "phys"
    public static let PICTPicture = IEVSymbol(name: "PICTPicture", code: 0x50494354, type: typeType) // "PICT"
    public static let picturesFolder = IEVSymbol(name: "picturesFolder", code: 0x70646f63, type: typeType) // "pdoc"
    public static let pixelMapRecord = IEVSymbol(name: "pixelMapRecord", code: 0x74706d6d, type: typeType) // "tpmm"
    public static let platform = IEVSymbol(name: "platform", code: 0x70506c74, type: typeType) // "pPlt"
    public static let point = IEVSymbol(name: "point", code: 0x51447074, type: typeType) // "QDpt"
    public static let POSIXPath = IEVSymbol(name: "POSIXPath", code: 0x706f7378, type: typeType) // "posx"
    public static let preferencesFolder = IEVSymbol(name: "preferencesFolder", code: 0x70726566, type: typeType) // "pref"
    public static let preferredCMM = IEVSymbol(name: "preferredCMM", code: 0x70636d6d, type: typeType) // "pcmm"
    public static let printSettings = IEVSymbol(name: "printSettings", code: 0x70736574, type: typeType) // "pset"
    public static let processSerialNumber = IEVSymbol(name: "processSerialNumber", code: 0x70736e20, type: typeType) // "psn\0x20"
    public static let productVersion = IEVSymbol(name: "productVersion", code: 0x76657232, type: typeType) // "ver2"
    public static let profile = IEVSymbol(name: "profile", code: 0x70726f66, type: typeType) // "prof"
    public static let profileFolder = IEVSymbol(name: "profileFolder", code: 0x70666472, type: typeType) // "pfdr"
    public static let properties = IEVSymbol(name: "properties", code: 0x70414c4c, type: typeType) // "pALL"
    public static let property_ = IEVSymbol(name: "property_", code: 0x70726f70, type: typeType) // "prop"
    public static let publicFolder = IEVSymbol(name: "publicFolder", code: 0x70756262, type: typeType) // "pubb"
    public static let quality = IEVSymbol(name: "quality", code: 0x7051616c, type: typeType) // "pQal"
    public static let quitDelay = IEVSymbol(name: "quitDelay", code: 0x7164656c, type: typeType) // "qdel"
    public static let real = IEVSymbol(name: "real", code: 0x646f7562, type: typeType) // "doub"
    public static let record = IEVSymbol(name: "record", code: 0x7265636f, type: typeType) // "reco"
    public static let reference = IEVSymbol(name: "reference", code: 0x6f626a20, type: typeType) // "obj\0x20"
    public static let renderingIntent = IEVSymbol(name: "renderingIntent", code: 0x70526472, type: typeType) // "pRdr"
    public static let requestedPrintTime = IEVSymbol(name: "requestedPrintTime", code: 0x6c777174, type: typeType) // "lwqt"
    public static let resizable = IEVSymbol(name: "resizable", code: 0x7072737a, type: typeType) // "prsz"
    public static let resolution = IEVSymbol(name: "resolution", code: 0x7265736f, type: typeType) // "reso"
    public static let RGB16Color = IEVSymbol(name: "RGB16Color", code: 0x74723136, type: typeType) // "tr16"
    public static let RGB96Color = IEVSymbol(name: "RGB96Color", code: 0x74723936, type: typeType) // "tr96"
    public static let RGBColor = IEVSymbol(name: "RGBColor", code: 0x63524742, type: typeType) // "cRGB"
    public static let rotation = IEVSymbol(name: "rotation", code: 0x74726f74, type: typeType) // "trot"
    public static let Saturday = IEVSymbol(name: "Saturday", code: 0x73617420, type: typeType) // "sat\0x20"
    public static let script = IEVSymbol(name: "script", code: 0x73637074, type: typeType) // "scpt"
    public static let scriptingAdditionsFolder = IEVSymbol(name: "scriptingAdditionsFolder", code: 0x24736372, type: typeType) // "$scr"
    public static let scriptsFolder = IEVSymbol(name: "scriptsFolder", code: 0x73637224, type: typeType) // "scr$"
    public static let September = IEVSymbol(name: "September", code: 0x73657020, type: typeType) // "sep\0x20"
    public static let server = IEVSymbol(name: "server", code: 0x73727672, type: typeType) // "srvr"
    public static let sharedDocumentsFolder = IEVSymbol(name: "sharedDocumentsFolder", code: 0x73646174, type: typeType) // "sdat"
    public static let shortInteger = IEVSymbol(name: "shortInteger", code: 0x73686f72, type: typeType) // "shor"
    public static let shortVersion = IEVSymbol(name: "shortVersion", code: 0x61737376, type: typeType) // "assv"
    public static let shutdownFolder = IEVSymbol(name: "shutdownFolder", code: 0x73686466, type: typeType) // "shdf"
    public static let sitesFolder = IEVSymbol(name: "sitesFolder", code: 0x73697465, type: typeType) // "site"
    public static let size = IEVSymbol(name: "size", code: 0x7074737a, type: typeType) // "ptsz"
    public static let smallReal = IEVSymbol(name: "smallReal", code: 0x73696e67, type: typeType) // "sing"
    public static let speakableItemsFolder = IEVSymbol(name: "speakableItemsFolder", code: 0x73706b69, type: typeType) // "spki"
    public static let startingPage = IEVSymbol(name: "startingPage", code: 0x6c776670, type: typeType) // "lwfp"
    public static let startup = IEVSymbol(name: "startup", code: 0x69737464, type: typeType) // "istd"
    public static let startupDisk = IEVSymbol(name: "startupDisk", code: 0x7364736b, type: typeType) // "sdsk"
    public static let startupItemsFolder = IEVSymbol(name: "startupItemsFolder", code: 0x656d707a, type: typeType) // "empz"
    public static let stationery = IEVSymbol(name: "stationery", code: 0x70737064, type: typeType) // "pspd"
    public static let string = IEVSymbol(name: "string", code: 0x54455854, type: typeType) // "TEXT"
    public static let styledClipboardText = IEVSymbol(name: "styledClipboardText", code: 0x7374796c, type: typeType) // "styl"
    public static let styledText = IEVSymbol(name: "styledText", code: 0x53545854, type: typeType) // "STXT"
    public static let Sunday = IEVSymbol(name: "Sunday", code: 0x73756e20, type: typeType) // "sun\0x20"
    public static let systemDomain = IEVSymbol(name: "systemDomain", code: 0x666c6473, type: typeType) // "flds"
    public static let systemDomainObject = IEVSymbol(name: "systemDomainObject", code: 0x646f6d73, type: typeType) // "doms"
    public static let systemFolder = IEVSymbol(name: "systemFolder", code: 0x6d616373, type: typeType) // "macs"
    public static let systemProfile = IEVSymbol(name: "systemProfile", code: 0x7379737a, type: typeType) // "sysz"
    public static let systemProfileLocation = IEVSymbol(name: "systemProfileLocation", code: 0x73797370, type: typeType) // "sysp"
    public static let targetPrinter = IEVSymbol(name: "targetPrinter", code: 0x74727072, type: typeType) // "trpr"
    public static let temporaryItemsFolder = IEVSymbol(name: "temporaryItemsFolder", code: 0x74656d70, type: typeType) // "temp"
    public static let textStyleInfo = IEVSymbol(name: "textStyleInfo", code: 0x74737479, type: typeType) // "tsty"
    public static let Thursday = IEVSymbol(name: "Thursday", code: 0x74687520, type: typeType) // "thu\0x20"
    public static let TIFFPicture = IEVSymbol(name: "TIFFPicture", code: 0x54494646, type: typeType) // "TIFF"
    public static let trash = IEVSymbol(name: "trash", code: 0x74727368, type: typeType) // "trsh"
    public static let Tuesday = IEVSymbol(name: "Tuesday", code: 0x74756520, type: typeType) // "tue\0x20"
    public static let typeClass = IEVSymbol(name: "typeClass", code: 0x74797065, type: typeType) // "type"
    public static let typeIdentifier = IEVSymbol(name: "typeIdentifier", code: 0x75746964, type: typeType) // "utid"
    public static let UnicodeText = IEVSymbol(name: "UnicodeText", code: 0x75747874, type: typeType) // "utxt"
    public static let unsignedDoubleInteger = IEVSymbol(name: "unsignedDoubleInteger", code: 0x75636f6d, type: typeType) // "ucom"
    public static let unsignedInteger = IEVSymbol(name: "unsignedInteger", code: 0x6d61676e, type: typeType) // "magn"
    public static let unsignedShortInteger = IEVSymbol(name: "unsignedShortInteger", code: 0x75736872, type: typeType) // "ushr"
    public static let URL = IEVSymbol(name: "URL", code: 0x75726c20, type: typeType) // "url\0x20"
    public static let userDomain = IEVSymbol(name: "userDomain", code: 0x666c6475, type: typeType) // "fldu"
    public static let userDomainObject = IEVSymbol(name: "userDomainObject", code: 0x646f6d75, type: typeType) // "domu"
    public static let UTF16Text = IEVSymbol(name: "UTF16Text", code: 0x75743136, type: typeType) // "ut16"
    public static let UTF8Text = IEVSymbol(name: "UTF8Text", code: 0x75746638, type: typeType) // "utf8"
    public static let utilitiesFolder = IEVSymbol(name: "utilitiesFolder", code: 0x75746924, type: typeType) // "uti$"
    public static let value = IEVSymbol(name: "value", code: 0x76616c4c, type: typeType) // "valL"
    public static let version = IEVSymbol(name: "version", code: 0x76657273, type: typeType) // "vers"
    public static let visible = IEVSymbol(name: "visible", code: 0x70766973, type: typeType) // "pvis"
    public static let volume = IEVSymbol(name: "volume", code: 0x766f6c75, type: typeType) // "volu"
    public static let Wednesday = IEVSymbol(name: "Wednesday", code: 0x77656420, type: typeType) // "wed\0x20"
    public static let window = IEVSymbol(name: "window", code: 0x6377696e, type: typeType) // "cwin"
    public static let workflowsFolder = IEVSymbol(name: "workflowsFolder", code: 0x666c6f77, type: typeType) // "flow"
    public static let writingCode = IEVSymbol(name: "writingCode", code: 0x70736374, type: typeType) // "psct"
    public static let zone = IEVSymbol(name: "zone", code: 0x7a6f6e65, type: typeType) // "zone"
    public static let zoomable = IEVSymbol(name: "zoomable", code: 0x69737a6d, type: typeType) // "iszm"
    public static let zoomed = IEVSymbol(name: "zoomed", code: 0x707a756d, type: typeType) // "pzum"

    // Enumerators
    public static let absoluteColorimetricIntent = IEVSymbol(name: "absoluteColorimetricIntent", code: 0x52647233, type: typeEnumerated) // "Rdr3"
    public static let abstract = IEVSymbol(name: "abstract", code: 0x61627374, type: typeEnumerated) // "abst"
    public static let ApplePhotoFormat = IEVSymbol(name: "ApplePhotoFormat", code: 0x64667068, type: typeEnumerated) // "dfph"
    public static let AppleShareFormat = IEVSymbol(name: "AppleShareFormat", code: 0x64666173, type: typeEnumerated) // "dfas"
    public static let ask = IEVSymbol(name: "ask", code: 0x61736b20, type: typeEnumerated) // "ask\0x20"
    public static let audioFormat = IEVSymbol(name: "audioFormat", code: 0x64666175, type: typeEnumerated) // "dfau"
    public static let best = IEVSymbol(name: "best", code: 0x62657374, type: typeEnumerated) // "best"
    public static let best_ = IEVSymbol(name: "best_", code: 0x51756132, type: typeEnumerated) // "Qua2"
    public static let blackAndWhite = IEVSymbol(name: "blackAndWhite", code: 0x62267720, type: typeEnumerated) // "b&w\0x20"
    public static let BMP = IEVSymbol(name: "BMP", code: 0x424d5066, type: typeEnumerated) // "BMPf"
    public static let case_ = IEVSymbol(name: "case_", code: 0x63617365, type: typeEnumerated) // "case"
    public static let CMYK = IEVSymbol(name: "CMYK", code: 0x434d594b, type: typeEnumerated) // "CMYK"
    public static let color = IEVSymbol(name: "color", code: 0x636f6c72, type: typeEnumerated) // "colr"
    public static let colorspace = IEVSymbol(name: "colorspace", code: 0x73706163, type: typeEnumerated) // "spac"
    public static let detailed = IEVSymbol(name: "detailed", code: 0x6c776474, type: typeEnumerated) // "lwdt"
    public static let diacriticals = IEVSymbol(name: "diacriticals", code: 0x64696163, type: typeEnumerated) // "diac"
    public static let draft = IEVSymbol(name: "draft", code: 0x51756131, type: typeEnumerated) // "Qua1"
    public static let EightChannel = IEVSymbol(name: "EightChannel", code: 0x4d434838, type: typeEnumerated) // "MCH8"
    public static let EightColor = IEVSymbol(name: "EightColor", code: 0x38434c52, type: typeEnumerated) // "8CLR"
    public static let expansion = IEVSymbol(name: "expansion", code: 0x65787061, type: typeEnumerated) // "expa"
    public static let FiveChannel = IEVSymbol(name: "FiveChannel", code: 0x4d434835, type: typeEnumerated) // "MCH5"
    public static let FiveColor = IEVSymbol(name: "FiveColor", code: 0x35434c52, type: typeEnumerated) // "5CLR"
    public static let fourColors = IEVSymbol(name: "fourColors", code: 0x34636c72, type: typeEnumerated) // "4clr"
    public static let fourGrays = IEVSymbol(name: "fourGrays", code: 0x34677279, type: typeEnumerated) // "4gry"
    public static let GIF = IEVSymbol(name: "GIF", code: 0x47494620, type: typeEnumerated) // "GIF\0x20"
    public static let Gray = IEVSymbol(name: "Gray", code: 0x47524159, type: typeEnumerated) // "GRAY"
    public static let grayscale = IEVSymbol(name: "grayscale", code: 0x67726179, type: typeEnumerated) // "gray"
    public static let high = IEVSymbol(name: "high", code: 0x68696768, type: typeEnumerated) // "high"
    public static let HighSierraFormat = IEVSymbol(name: "HighSierraFormat", code: 0x64666873, type: typeEnumerated) // "dfhs"
    public static let hyphens = IEVSymbol(name: "hyphens", code: 0x68797068, type: typeEnumerated) // "hyph"
    public static let input = IEVSymbol(name: "input", code: 0x73636e72, type: typeEnumerated) // "scnr"
    public static let ISO9660Format = IEVSymbol(name: "ISO9660Format", code: 0x64663936, type: typeEnumerated) // "df96"
    public static let JPEG = IEVSymbol(name: "JPEG", code: 0x4a504547, type: typeEnumerated) // "JPEG"
    public static let JPEG2 = IEVSymbol(name: "JPEG2", code: 0x6a706732, type: typeEnumerated) // "jpg2"
    public static let Lab = IEVSymbol(name: "Lab", code: 0x4c616220, type: typeEnumerated) // "Lab\0x20"
    public static let least = IEVSymbol(name: "least", code: 0x6c656173, type: typeEnumerated) // "leas"
    public static let link = IEVSymbol(name: "link", code: 0x6c696e6b, type: typeEnumerated) // "link"
    public static let low = IEVSymbol(name: "low", code: 0x6c6f7720, type: typeEnumerated) // "low\0x20"
    public static let MacOSExtendedFormat = IEVSymbol(name: "MacOSExtendedFormat", code: 0x6466682b, type: typeEnumerated) // "dfh+"
    public static let MacOSFormat = IEVSymbol(name: "MacOSFormat", code: 0x64666866, type: typeEnumerated) // "dfhf"
    public static let MacPaint = IEVSymbol(name: "MacPaint", code: 0x504e5447, type: typeEnumerated) // "PNTG"
    public static let medium = IEVSymbol(name: "medium", code: 0x6d656469, type: typeEnumerated) // "medi"
    public static let millionsOfColors = IEVSymbol(name: "millionsOfColors", code: 0x6d696c6c, type: typeEnumerated) // "mill"
    public static let millionsOfColorsPlus = IEVSymbol(name: "millionsOfColorsPlus", code: 0x6d696c2b, type: typeEnumerated) // "mil+"
    public static let monitor = IEVSymbol(name: "monitor", code: 0x6d6e7472, type: typeEnumerated) // "mntr"
    public static let MSDOSFormat = IEVSymbol(name: "MSDOSFormat", code: 0x64666d73, type: typeEnumerated) // "dfms"
    public static let Named = IEVSymbol(name: "Named", code: 0x4e414d45, type: typeEnumerated) // "NAME"
    public static let named_ = IEVSymbol(name: "named_", code: 0x6e6d636c, type: typeEnumerated) // "nmcl"
    public static let NFSFormat = IEVSymbol(name: "NFSFormat", code: 0x64666e66, type: typeEnumerated) // "dfnf"
    public static let no = IEVSymbol(name: "no", code: 0x6e6f2020, type: typeEnumerated) // "no\0x20\0x20"
    public static let normal = IEVSymbol(name: "normal", code: 0x51756130, type: typeEnumerated) // "Qua0"
    public static let numericStrings = IEVSymbol(name: "numericStrings", code: 0x6e756d65, type: typeEnumerated) // "nume"
    public static let output = IEVSymbol(name: "output", code: 0x70727472, type: typeEnumerated) // "prtr"
    public static let PDF = IEVSymbol(name: "PDF", code: 0x50444620, type: typeEnumerated) // "PDF\0x20"
    public static let perceptualIntent = IEVSymbol(name: "perceptualIntent", code: 0x52647230, type: typeEnumerated) // "Rdr0"
    public static let Photoshop = IEVSymbol(name: "Photoshop", code: 0x38425053, type: typeEnumerated) // "8BPS"
    public static let PICT = IEVSymbol(name: "PICT", code: 0x50494354, type: typeEnumerated) // "PICT"
    public static let PNG = IEVSymbol(name: "PNG", code: 0x504e4766, type: typeEnumerated) // "PNGf"
    public static let ProDOSFormat = IEVSymbol(name: "ProDOSFormat", code: 0x64667072, type: typeEnumerated) // "dfpr"
    public static let PSD = IEVSymbol(name: "PSD", code: 0x70736420, type: typeEnumerated) // "psd\0x20"
    public static let punctuation = IEVSymbol(name: "punctuation", code: 0x70756e63, type: typeEnumerated) // "punc"
    public static let QuickTakeFormat = IEVSymbol(name: "QuickTakeFormat", code: 0x64667174, type: typeEnumerated) // "dfqt"
    public static let QuickTimeImage = IEVSymbol(name: "QuickTimeImage", code: 0x71746966, type: typeEnumerated) // "qtif"
    public static let relativeColorimetricIntent = IEVSymbol(name: "relativeColorimetricIntent", code: 0x52647231, type: typeEnumerated) // "Rdr1"
    public static let RGB = IEVSymbol(name: "RGB", code: 0x52474220, type: typeEnumerated) // "RGB\0x20"
    public static let saturationIntent = IEVSymbol(name: "saturationIntent", code: 0x52647232, type: typeEnumerated) // "Rdr2"
    public static let SevenChannel = IEVSymbol(name: "SevenChannel", code: 0x4d434837, type: typeEnumerated) // "MCH7"
    public static let SevenColor = IEVSymbol(name: "SevenColor", code: 0x37434c52, type: typeEnumerated) // "7CLR"
    public static let SGI = IEVSymbol(name: "SGI", code: 0x2e534749, type: typeEnumerated) // ".SGI"
    public static let SixChannel = IEVSymbol(name: "SixChannel", code: 0x4d434836, type: typeEnumerated) // "MCH6"
    public static let SixColor = IEVSymbol(name: "SixColor", code: 0x36434c52, type: typeEnumerated) // "6CLR"
    public static let sixteenColors = IEVSymbol(name: "sixteenColors", code: 0x3136636c, type: typeEnumerated) // "16cl"
    public static let sixteenGrays = IEVSymbol(name: "sixteenGrays", code: 0x31366772, type: typeEnumerated) // "16gr"
    public static let standard = IEVSymbol(name: "standard", code: 0x6c777374, type: typeEnumerated) // "lwst"
    public static let Text = IEVSymbol(name: "Text", code: 0x54455854, type: typeEnumerated) // "TEXT"
    public static let text = IEVSymbol(name: "text", code: 0x63747874, type: typeEnumerated) // "ctxt"
    public static let TGA = IEVSymbol(name: "TGA", code: 0x74676120, type: typeEnumerated) // "tga\0x20"
    public static let thousandsOfColors = IEVSymbol(name: "thousandsOfColors", code: 0x74686f75, type: typeEnumerated) // "thou"
    public static let TIFF = IEVSymbol(name: "TIFF", code: 0x54494646, type: typeEnumerated) // "TIFF"
    public static let twoHundredFiftySixColors = IEVSymbol(name: "twoHundredFiftySixColors", code: 0x32353663, type: typeEnumerated) // "256c"
    public static let twoHundredFiftySixGrays = IEVSymbol(name: "twoHundredFiftySixGrays", code: 0x32353667, type: typeEnumerated) // "256g"
    public static let UDFFormat = IEVSymbol(name: "UDFFormat", code: 0x64667564, type: typeEnumerated) // "dfud"
    public static let UFSFormat = IEVSymbol(name: "UFSFormat", code: 0x64667566, type: typeEnumerated) // "dfuf"
    public static let unknownFormat = IEVSymbol(name: "unknownFormat", code: 0x64662424, type: typeEnumerated) // "df$$"
    public static let WebDAVFormat = IEVSymbol(name: "WebDAVFormat", code: 0x64667764, type: typeEnumerated) // "dfwd"
    public static let whitespace = IEVSymbol(name: "whitespace", code: 0x77686974, type: typeEnumerated) // "whit"
    public static let XYZ = IEVSymbol(name: "XYZ", code: 0x58595a20, type: typeEnumerated) // "XYZ\0x20"
    public static let yes = IEVSymbol(name: "yes", code: 0x79657320, type: typeEnumerated) // "yes\0x20"
}

public typealias IEV = IEVSymbol // allows symbols to be written as (e.g.) IEV.name instead of IEVSymbol.name


/******************************************************************************/
// Specifier extensions; these add command methods and property/elements getters based on Image Events.app terminology

public protocol IEVCommand: SwiftAutomation.SpecifierProtocol {} // provides AE dispatch methods

// Command->Any will be bound when return type can't be inferred, else Command->T

extension IEVCommand {
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
    @discardableResult public func crop(_ directParameter: Any = SwiftAutomation.NoParameter,
            toDimensions: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "crop", eventClass: 0x696d6773, eventID: 0x63726f70, // "imgs"/"crop"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("toDimensions", 0x446d6e73, toDimensions), // "Dmns"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func crop<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            toDimensions: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "crop", eventClass: 0x696d6773, eventID: 0x63726f70, // "imgs"/"crop"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("toDimensions", 0x446d6e73, toDimensions), // "Dmns"
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
    @discardableResult public func embed(_ directParameter: Any = SwiftAutomation.NoParameter,
            withSource: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "embed", eventClass: 0x73796e63, eventID: 0x63734549, // "sync"/"csEI"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("withSource", 0x65507266, withSource), // "ePrf"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func embed<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            withSource: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "embed", eventClass: 0x73796e63, eventID: 0x63734549, // "sync"/"csEI"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("withSource", 0x65507266, withSource), // "ePrf"
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
    @discardableResult public func flip(_ directParameter: Any = SwiftAutomation.NoParameter,
            horizontal: Any = SwiftAutomation.NoParameter,
            vertical: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "flip", eventClass: 0x696d6773, eventID: 0x666c6970, // "imgs"/"flip"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("horizontal", 0x686f7269, horizontal), // "hori"
                    ("vertical", 0x76657274, vertical), // "vert"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func flip<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            horizontal: Any = SwiftAutomation.NoParameter,
            vertical: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "flip", eventClass: 0x696d6773, eventID: 0x666c6970, // "imgs"/"flip"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("horizontal", 0x686f7269, horizontal), // "hori"
                    ("vertical", 0x76657274, vertical), // "vert"
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
    @discardableResult public func match(_ directParameter: Any = SwiftAutomation.NoParameter,
            toDestination: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "match", eventClass: 0x73796e63, eventID: 0x63734d49, // "sync"/"csMI"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("toDestination", 0x64507266, toDestination), // "dPrf"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func match<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            toDestination: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "match", eventClass: 0x73796e63, eventID: 0x63734d49, // "sync"/"csMI"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("toDestination", 0x64507266, toDestination), // "dPrf"
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
    @discardableResult public func pad(_ directParameter: Any = SwiftAutomation.NoParameter,
            toDimensions: Any = SwiftAutomation.NoParameter,
            withPadColor: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "pad", eventClass: 0x696d6773, eventID: 0x70616464, // "imgs"/"padd"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("toDimensions", 0x446d6e73, toDimensions), // "Dmns"
                    ("withPadColor", 0x77706463, withPadColor), // "wpdc"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func pad<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            toDimensions: Any = SwiftAutomation.NoParameter,
            withPadColor: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "pad", eventClass: 0x696d6773, eventID: 0x70616464, // "imgs"/"padd"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("toDimensions", 0x446d6e73, toDimensions), // "Dmns"
                    ("withPadColor", 0x77706463, withPadColor), // "wpdc"
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
    @discardableResult public func rotate(_ directParameter: Any = SwiftAutomation.NoParameter,
            toAngle: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "rotate", eventClass: 0x69636173, eventID: 0x726f7461, // "icas"/"rota"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("toAngle", 0x616e676c, toAngle), // "angl"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func rotate<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            toAngle: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "rotate", eventClass: 0x69636173, eventID: 0x726f7461, // "icas"/"rota"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("toAngle", 0x616e676c, toAngle), // "angl"
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
            as_: Any = SwiftAutomation.NoParameter,
            icon: Any = SwiftAutomation.NoParameter,
            in_: Any = SwiftAutomation.NoParameter,
            PackBits: Any = SwiftAutomation.NoParameter,
            withCompressionLevel: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "save", eventClass: 0x636f7265, eventID: 0x73617665, // "core"/"save"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("as_", 0x666c7470, as_), // "fltp"
                    ("icon", 0x69696d67, icon), // "iimg"
                    ("in_", 0x6b66696c, in_), // "kfil"
                    ("PackBits", 0x7061636b, PackBits), // "pack"
                    ("withCompressionLevel", 0x636d6c76, withCompressionLevel), // "cmlv"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func save<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            as_: Any = SwiftAutomation.NoParameter,
            icon: Any = SwiftAutomation.NoParameter,
            in_: Any = SwiftAutomation.NoParameter,
            PackBits: Any = SwiftAutomation.NoParameter,
            withCompressionLevel: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "save", eventClass: 0x636f7265, eventID: 0x73617665, // "core"/"save"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("as_", 0x666c7470, as_), // "fltp"
                    ("icon", 0x69696d67, icon), // "iimg"
                    ("in_", 0x6b66696c, in_), // "kfil"
                    ("PackBits", 0x7061636b, PackBits), // "pack"
                    ("withCompressionLevel", 0x636d6c76, withCompressionLevel), // "cmlv"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func scale(_ directParameter: Any = SwiftAutomation.NoParameter,
            byFactor: Any = SwiftAutomation.NoParameter,
            toSize: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "scale", eventClass: 0x69636173, eventID: 0x7363616c, // "icas"/"scal"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("byFactor", 0x66616374, byFactor), // "fact"
                    ("toSize", 0x6d617869, toSize), // "maxi"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func scale<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            byFactor: Any = SwiftAutomation.NoParameter,
            toSize: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "scale", eventClass: 0x69636173, eventID: 0x7363616c, // "icas"/"scal"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("byFactor", 0x66616374, byFactor), // "fact"
                    ("toSize", 0x6d617869, toSize), // "maxi"
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
    @discardableResult public func unembed(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "unembed", eventClass: 0x73796e63, eventID: 0x63735549, // "sync"/"csUI"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func unembed<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "unembed", eventClass: 0x73796e63, eventID: 0x63735549, // "sync"/"csUI"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
}


public protocol IEVObject: SwiftAutomation.ObjectSpecifierExtension, IEVCommand {} // provides vars and methods for constructing specifiers

extension IEVObject {
    
    // Properties
    public var appleMenuFolder: IEVItem {return self.property(0x616d6e75) as! IEVItem} // "amnu"
    public var applicationsFolder: IEVItem {return self.property(0x61707073) as! IEVItem} // "apps"
    public var applicationSupportFolder: IEVItem {return self.property(0x61737570) as! IEVItem} // "asup"
    public var bitDepth: IEVItem {return self.property(0x70647074) as! IEVItem} // "pdpt"
    public var bounds: IEVItem {return self.property(0x70626e64) as! IEVItem} // "pbnd"
    public var busyStatus: IEVItem {return self.property(0x62757379) as! IEVItem} // "busy"
    public var capacity: IEVItem {return self.property(0x63617061) as! IEVItem} // "capa"
    public var class_: IEVItem {return self.property(0x70636c73) as! IEVItem} // "pcls"
    public var ClassicDomain: IEVItem {return self.property(0x666c6463) as! IEVItem} // "fldc"
    public var closeable: IEVItem {return self.property(0x68636c62) as! IEVItem} // "hclb"
    public var collating: IEVItem {return self.property(0x6c77636c) as! IEVItem} // "lwcl"
    public var colorSpace: IEVItem {return self.property(0x70537063) as! IEVItem} // "pSpc"
    public var connectionSpace: IEVItem {return self.property(0x70504353) as! IEVItem} // "pPCS"
    public var container: IEVItem {return self.property(0x63746e72) as! IEVItem} // "ctnr"
    public var controlPanelsFolder: IEVItem {return self.property(0x6374726c) as! IEVItem} // "ctrl"
    public var controlStripModulesFolder: IEVItem {return self.property(0x73646576) as! IEVItem} // "sdev"
    public var copies: IEVItem {return self.property(0x6c776370) as! IEVItem} // "lwcp"
    public var creationDate: IEVItem {return self.property(0x61736364) as! IEVItem} // "ascd"
    public var creator: IEVItem {return self.property(0x70437265) as! IEVItem} // "pCre"
    public var creatorType: IEVItem {return self.property(0x66637274) as! IEVItem} // "fcrt"
    public var defaultApplication: IEVItem {return self.property(0x61736461) as! IEVItem} // "asda"
    public var defaultCMYKProfile: IEVItem {return self.property(0x434d4b50) as! IEVItem} // "CMKP"
    public var defaultCMYKProfileLocation: IEVItem {return self.property(0x434d4b70) as! IEVItem} // "CMKp"
    public var defaultGrayProfile: IEVItem {return self.property(0x47525950) as! IEVItem} // "GRYP"
    public var defaultGrayProfileLocation: IEVItem {return self.property(0x47525970) as! IEVItem} // "GRYp"
    public var defaultLabProfile: IEVItem {return self.property(0x4c616250) as! IEVItem} // "LabP"
    public var defaultLabProfileLocation: IEVItem {return self.property(0x4c616270) as! IEVItem} // "Labp"
    public var defaultRGBProfile: IEVItem {return self.property(0x52474250) as! IEVItem} // "RGBP"
    public var defaultRGBProfileLocation: IEVItem {return self.property(0x52474270) as! IEVItem} // "RGBp"
    public var defaultXYZProfile: IEVItem {return self.property(0x58595a50) as! IEVItem} // "XYZP"
    public var defaultXYZProfileLocation: IEVItem {return self.property(0x58595a70) as! IEVItem} // "XYZp"
    public var description_: IEVItem {return self.property(0x64736372) as! IEVItem} // "dscr"
    public var desktopFolder: IEVItem {return self.property(0x6465736b) as! IEVItem} // "desk"
    public var desktopPicturesFolder: IEVItem {return self.property(0x64747024) as! IEVItem} // "dtp$"
    public var deviceClass: IEVItem {return self.property(0x70436c61) as! IEVItem} // "pCla"
    public var deviceManufacturer: IEVItem {return self.property(0x704d616e) as! IEVItem} // "pMan"
    public var deviceModel: IEVItem {return self.property(0x704d6f64) as! IEVItem} // "pMod"
    public var dimensions: IEVItem {return self.property(0x646d6e73) as! IEVItem} // "dmns"
    public var displayedName: IEVItem {return self.property(0x646e616d) as! IEVItem} // "dnam"
    public var displayNumber: IEVItem {return self.property(0x6d4e756d) as! IEVItem} // "mNum"
    public var displayProfile: IEVItem {return self.property(0x6d507266) as! IEVItem} // "mPrf"
    public var document: IEVItem {return self.property(0x646f6375) as! IEVItem} // "docu"
    public var documentsFolder: IEVItem {return self.property(0x646f6373) as! IEVItem} // "docs"
    public var downloadsFolder: IEVItem {return self.property(0x646f776e) as! IEVItem} // "down"
    public var ejectable: IEVItem {return self.property(0x6973656a) as! IEVItem} // "isej"
    public var embeddedProfile: IEVItem {return self.property(0x65707266) as! IEVItem} // "eprf"
    public var endingPage: IEVItem {return self.property(0x6c776c70) as! IEVItem} // "lwlp"
    public var errorHandling: IEVItem {return self.property(0x6c776568) as! IEVItem} // "lweh"
    public var extensionsFolder: IEVItem {return self.property(0x6578747a) as! IEVItem} // "extz"
    public var favoritesFolder: IEVItem {return self.property(0x66617673) as! IEVItem} // "favs"
    public var faxNumber: IEVItem {return self.property(0x6661786e) as! IEVItem} // "faxn"
    public var file: IEVItem {return self.property(0x66696c65) as! IEVItem} // "file"
    public var fileType: IEVItem {return self.property(0x61737479) as! IEVItem} // "asty"
    public var FolderActionScriptsFolder: IEVItem {return self.property(0x66617366) as! IEVItem} // "fasf"
    public var fontsFolder: IEVItem {return self.property(0x666f6e74) as! IEVItem} // "font"
    public var format: IEVItem {return self.property(0x64666d74) as! IEVItem} // "dfmt"
    public var freeSpace: IEVItem {return self.property(0x66727370) as! IEVItem} // "frsp"
    public var frontmost: IEVItem {return self.property(0x70697366) as! IEVItem} // "pisf"
    public var homeFolder: IEVItem {return self.property(0x63757372) as! IEVItem} // "cusr"
    public var id: IEVItem {return self.property(0x49442020) as! IEVItem} // "ID\0x20\0x20"
    public var ignorePrivileges: IEVItem {return self.property(0x69677072) as! IEVItem} // "igpr"
    public var imageFile: IEVItem {return self.property(0x696d6766) as! IEVItem} // "imgf"
    public var index: IEVItem {return self.property(0x70696478) as! IEVItem} // "pidx"
    public var kind: IEVItem {return self.property(0x6b696e64) as! IEVItem} // "kind"
    public var launcherItemsFolder: IEVItem {return self.property(0x6c61756e) as! IEVItem} // "laun"
    public var libraryFolder: IEVItem {return self.property(0x646c6962) as! IEVItem} // "dlib"
    public var localDomain: IEVItem {return self.property(0x666c646c) as! IEVItem} // "fldl"
    public var localVolume: IEVItem {return self.property(0x69737276) as! IEVItem} // "isrv"
    public var location: IEVItem {return self.property(0x704c6f63) as! IEVItem} // "pLoc"
    public var miniaturizable: IEVItem {return self.property(0x69736d6e) as! IEVItem} // "ismn"
    public var miniaturized: IEVItem {return self.property(0x706d6e64) as! IEVItem} // "pmnd"
    public var modificationDate: IEVItem {return self.property(0x61736d6f) as! IEVItem} // "asmo"
    public var modified: IEVItem {return self.property(0x696d6f64) as! IEVItem} // "imod"
    public var moviesFolder: IEVItem {return self.property(0x6d646f63) as! IEVItem} // "mdoc"
    public var musicFolder: IEVItem {return self.property(0x25646f63) as! IEVItem} // "%doc"
    public var name: IEVItem {return self.property(0x706e616d) as! IEVItem} // "pnam"
    public var nameExtension: IEVItem {return self.property(0x6578746e) as! IEVItem} // "extn"
    public var networkDomain: IEVItem {return self.property(0x666c646e) as! IEVItem} // "fldn"
    public var packageFolder: IEVItem {return self.property(0x706b6766) as! IEVItem} // "pkgf"
    public var pagesAcross: IEVItem {return self.property(0x6c776c61) as! IEVItem} // "lwla"
    public var pagesDown: IEVItem {return self.property(0x6c776c64) as! IEVItem} // "lwld"
    public var path: IEVItem {return self.property(0x70707468) as! IEVItem} // "ppth"
    public var physicalSize: IEVItem {return self.property(0x70687973) as! IEVItem} // "phys"
    public var picturesFolder: IEVItem {return self.property(0x70646f63) as! IEVItem} // "pdoc"
    public var platform: IEVItem {return self.property(0x70506c74) as! IEVItem} // "pPlt"
    public var POSIXPath: IEVItem {return self.property(0x706f7378) as! IEVItem} // "posx"
    public var preferencesFolder: IEVItem {return self.property(0x70726566) as! IEVItem} // "pref"
    public var preferredCMM: IEVItem {return self.property(0x70636d6d) as! IEVItem} // "pcmm"
    public var productVersion: IEVItem {return self.property(0x76657232) as! IEVItem} // "ver2"
    public var profileFolder: IEVItem {return self.property(0x70666472) as! IEVItem} // "pfdr"
    public var properties: IEVItem {return self.property(0x70414c4c) as! IEVItem} // "pALL"
    public var publicFolder: IEVItem {return self.property(0x70756262) as! IEVItem} // "pubb"
    public var quality: IEVItem {return self.property(0x7051616c) as! IEVItem} // "pQal"
    public var quitDelay: IEVItem {return self.property(0x7164656c) as! IEVItem} // "qdel"
    public var renderingIntent: IEVItem {return self.property(0x70526472) as! IEVItem} // "pRdr"
    public var requestedPrintTime: IEVItem {return self.property(0x6c777174) as! IEVItem} // "lwqt"
    public var resizable: IEVItem {return self.property(0x7072737a) as! IEVItem} // "prsz"
    public var resolution: IEVItem {return self.property(0x7265736f) as! IEVItem} // "reso"
    public var scriptingAdditionsFolder: IEVItem {return self.property(0x24736372) as! IEVItem} // "$scr"
    public var scriptsFolder: IEVItem {return self.property(0x73637224) as! IEVItem} // "scr$"
    public var server: IEVItem {return self.property(0x73727672) as! IEVItem} // "srvr"
    public var sharedDocumentsFolder: IEVItem {return self.property(0x73646174) as! IEVItem} // "sdat"
    public var shortVersion: IEVItem {return self.property(0x61737376) as! IEVItem} // "assv"
    public var shutdownFolder: IEVItem {return self.property(0x73686466) as! IEVItem} // "shdf"
    public var sitesFolder: IEVItem {return self.property(0x73697465) as! IEVItem} // "site"
    public var size: IEVItem {return self.property(0x7074737a) as! IEVItem} // "ptsz"
    public var speakableItemsFolder: IEVItem {return self.property(0x73706b69) as! IEVItem} // "spki"
    public var startingPage: IEVItem {return self.property(0x6c776670) as! IEVItem} // "lwfp"
    public var startup: IEVItem {return self.property(0x69737464) as! IEVItem} // "istd"
    public var startupDisk: IEVItem {return self.property(0x7364736b) as! IEVItem} // "sdsk"
    public var startupItemsFolder: IEVItem {return self.property(0x656d707a) as! IEVItem} // "empz"
    public var stationery: IEVItem {return self.property(0x70737064) as! IEVItem} // "pspd"
    public var systemDomain: IEVItem {return self.property(0x666c6473) as! IEVItem} // "flds"
    public var systemFolder: IEVItem {return self.property(0x6d616373) as! IEVItem} // "macs"
    public var systemProfile: IEVItem {return self.property(0x7379737a) as! IEVItem} // "sysz"
    public var systemProfileLocation: IEVItem {return self.property(0x73797370) as! IEVItem} // "sysp"
    public var targetPrinter: IEVItem {return self.property(0x74727072) as! IEVItem} // "trpr"
    public var temporaryItemsFolder: IEVItem {return self.property(0x74656d70) as! IEVItem} // "temp"
    public var trash: IEVItem {return self.property(0x74727368) as! IEVItem} // "trsh"
    public var typeIdentifier: IEVItem {return self.property(0x75746964) as! IEVItem} // "utid"
    public var URL: IEVItem {return self.property(0x75726c20) as! IEVItem} // "url\0x20"
    public var userDomain: IEVItem {return self.property(0x666c6475) as! IEVItem} // "fldu"
    public var utilitiesFolder: IEVItem {return self.property(0x75746924) as! IEVItem} // "uti$"
    public var value: IEVItem {return self.property(0x76616c4c) as! IEVItem} // "valL"
    public var version: IEVItem {return self.property(0x76657273) as! IEVItem} // "vers"
    public var visible: IEVItem {return self.property(0x70766973) as! IEVItem} // "pvis"
    public var volume: IEVItem {return self.property(0x766f6c75) as! IEVItem} // "volu"
    public var workflowsFolder: IEVItem {return self.property(0x666c6f77) as! IEVItem} // "flow"
    public var zone: IEVItem {return self.property(0x7a6f6e65) as! IEVItem} // "zone"
    public var zoomable: IEVItem {return self.property(0x69737a6d) as! IEVItem} // "iszm"
    public var zoomed: IEVItem {return self.property(0x707a756d) as! IEVItem} // "pzum"

    // Elements
    public var aliases: IEVItems {return self.elements(0x616c6973) as! IEVItems} // "alis"
    public var applications: IEVItems {return self.elements(0x63617070) as! IEVItems} // "capp"
    public var ClassicDomainObjects: IEVItems {return self.elements(0x646f6d63) as! IEVItems} // "domc"
    public var disks: IEVItems {return self.elements(0x63646973) as! IEVItems} // "cdis"
    public var diskItems: IEVItems {return self.elements(0x6469746d) as! IEVItems} // "ditm"
    public var displays: IEVItems {return self.elements(0x64697370) as! IEVItems} // "disp"
    public var documents: IEVItems {return self.elements(0x646f6375) as! IEVItems} // "docu"
    public var domains: IEVItems {return self.elements(0x646f6d61) as! IEVItems} // "doma"
    public var files: IEVItems {return self.elements(0x66696c65) as! IEVItems} // "file"
    public var filePackages: IEVItems {return self.elements(0x63706b67) as! IEVItems} // "cpkg"
    public var folders: IEVItems {return self.elements(0x63666f6c) as! IEVItems} // "cfol"
    public var images: IEVItems {return self.elements(0x696d6167) as! IEVItems} // "imag"
    public var items: IEVItems {return self.elements(0x636f626a) as! IEVItems} // "cobj"
    public var localDomainObjects: IEVItems {return self.elements(0x646f6d6c) as! IEVItems} // "doml"
    public var metadataTags: IEVItems {return self.elements(0x74616720) as! IEVItems} // "tag\0x20"
    public var networkDomainObjects: IEVItems {return self.elements(0x646f6d6e) as! IEVItems} // "domn"
    public var profiles: IEVItems {return self.elements(0x70726f66) as! IEVItems} // "prof"
    public var systemDomainObjects: IEVItems {return self.elements(0x646f6d73) as! IEVItems} // "doms"
    public var userDomainObjects: IEVItems {return self.elements(0x646f6d75) as! IEVItems} // "domu"
    public var windows: IEVItems {return self.elements(0x6377696e) as! IEVItems} // "cwin"
}


/******************************************************************************/
// Specifier subclasses add app-specific extensions

// beginning/end/before/after
public class IEVInsertion: SwiftAutomation.InsertionSpecifier, IEVCommand {}


// property/by-index/by-name/by-id/previous/next/first/middle/last/any
public class IEVItem: SwiftAutomation.ObjectSpecifier, IEVObject {
    public typealias InsertionSpecifierType = IEVInsertion
    public typealias ObjectSpecifierType = IEVItem
    public typealias MultipleObjectSpecifierType = IEVItems
}

// by-range/by-test/all
public class IEVItems: IEVItem, SwiftAutomation.MultipleObjectSpecifierExtension {}

// App/Con/Its
public class IEVRoot: SwiftAutomation.RootSpecifier, IEVObject, SwiftAutomation.RootSpecifierExtension {
    public typealias InsertionSpecifierType = IEVInsertion
    public typealias ObjectSpecifierType = IEVItem
    public typealias MultipleObjectSpecifierType = IEVItems
    public override class var untargetedAppData: SwiftAutomation.AppData { return _untargetedAppData }
}

// Application
public class ImageEvents: IEVRoot, SwiftAutomation.Application {
    public convenience init(launchOptions: SwiftAutomation.LaunchOptions = SwiftAutomation.DefaultLaunchOptions, relaunchMode: SwiftAutomation.RelaunchMode = SwiftAutomation.DefaultRelaunchMode) {
        self.init(rootObject: SwiftAutomation.AppRootDesc, appData: Swift.type(of:self).untargetedAppData.targetedCopy(
                  .bundleIdentifier("com.apple.imageevents", true), launchOptions: launchOptions, relaunchMode: relaunchMode))
    }
}

// App/Con/Its root objects used to construct untargeted specifiers; these can be used to construct specifiers for use in commands, though cannot send commands themselves

public let IEVApp = _untargetedAppData.app as! IEVRoot
public let IEVCon = _untargetedAppData.con as! IEVRoot
public let IEVIts = _untargetedAppData.its as! IEVRoot


/******************************************************************************/
// Static types

public typealias IEVRecord = [IEVSymbol:Any] // default Swift type for AERecordDescs







