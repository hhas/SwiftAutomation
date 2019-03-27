//
//  KeynoteGlue.swift
//  Keynote.app 8.3
//  SwiftAutomation.framework 0.1.0
//  `aeglue -S 'Keynote.app'`
//


import Foundation
import SwiftAutomation


/******************************************************************************/
// Create an untargeted AppData instance for use in App, Con, Its roots,
// and in Application initializers to create targeted AppData instances.

private let _specifierFormatter = SwiftAutomation.SpecifierFormatter(applicationClassName: "Keynote",
                                                     classNamePrefix: "KEY",
                                                     typeNames: [
                                                                     0x4b6d6638: "_1080p_", // "Kmf8"
                                                                     0x4b6d6634: "_2160p_", // "Kmf4"
                                                                     0x4b6d6633: "_360p_", // "Kmf3"
                                                                     0x4b6d6635: "_540p_", // "Kmf5"
                                                                     0x4b6d6637: "_720p_", // "Kmf7"
                                                                     0x4e4d6164: "address", // "NMad"
                                                                     0x66696167: "advancedGradientFill", // "fiag"
                                                                     0x66696169: "advancedImageFill", // "fiai"
                                                                     0x616c6973: "alias", // "alis"
                                                                     0x74657841: "alignment", // "texA"
                                                                     0x4b787061: "allStages", // "Kxpa"
                                                                     0x2a2a2a2a: "anything", // "****"
                                                                     0x63617070: "application", // "capp"
                                                                     0x62756e64: "applicationBundleID", // "bund"
                                                                     0x7369676e: "applicationSignature", // "sign"
                                                                     0x6170726c: "applicationURL", // "aprl"
                                                                     0x61707220: "April", // "apr\0x20"
                                                                     0x61726532: "area_2d", // "are2"
                                                                     0x61726533: "area_3d", // "are3"
                                                                     0x6173636e: "ascending", // "ascn"
                                                                     0x61736b20: "ask", // "ask\0x20"
                                                                     0x73686175: "audioClip", // "shau"
                                                                     0x61756720: "August", // "aug\0x20"
                                                                     0x61617574: "autoAlign", // "aaut"
                                                                     0x61756c70: "autoLoop", // "aulp"
                                                                     0x66617574: "automatic", // "faut"
                                                                     0x78617574: "automaticTransition", // "xaut"
                                                                     0x61757079: "autoPlay", // "aupy"
                                                                     0x61757374: "autoRestart", // "aust"
                                                                     0x63654243: "backgroundColor", // "ceBC"
                                                                     0x626b6674: "backgroundFillType", // "bkft"
                                                                     0x736d6173: "baseSlide", // "smas"
                                                                     0x4b6e5032: "Best", // "KnP2"
                                                                     0x62657374: "best", // "best"
                                                                     0x4b6e5031: "Better", // "KnP1"
                                                                     0x74626c64: "blinds", // "tbld"
                                                                     0x4b627368: "bodyShowing", // "Kbsh"
                                                                     0x626d726b: "bookmarkData", // "bmrk"
                                                                     0x626f6f6c: "boolean", // "bool"
                                                                     0x4b787062: "borders", // "Kxpb"
                                                                     0x61766274: "bottom", // "avbt"
                                                                     0x71647274: "boundingRectangle", // "qdrt"
                                                                     0x70626e64: "bounds", // "pbnd"
                                                                     0x63617365: "case_", // "case"
                                                                     0x4e6d436c: "cell", // "NmCl"
                                                                     0x4e4d5463: "cellRange", // "NMTc"
                                                                     0x61637472: "center", // "actr"
                                                                     0x63686120: "character", // "cha\0x20"
                                                                     0x73686374: "chart", // "shct"
                                                                     0x4b436763: "chartColumn", // "KCgc"
                                                                     0x4b436772: "chartRow", // "KCgr"
                                                                     0x66636368: "checkbox", // "fcch"
                                                                     0x70636c73: "class_", // "pcls"
                                                                     0x61766f6c: "clipVolume", // "avol"
                                                                     0x68636c62: "closeable", // "hclb"
                                                                     0x74636c6f: "clothesline", // "tclo"
                                                                     0x6c77636c: "collating", // "lwcl"
                                                                     0x636f6c72: "color", // "colr"
                                                                     0x6669636f: "colorFill", // "fico"
                                                                     0x7463706c: "colorPlanes", // "tcpl"
                                                                     0x636c7274: "colorTable", // "clrt"
                                                                     0x4e4d436f: "column", // "NMCo"
                                                                     0x4e6d5463: "columnCount", // "NmTc"
                                                                     0x4b786963: "compressionFactor", // "Kxic"
                                                                     0x74636674: "confetti", // "tcft"
                                                                     0x656e756d: "constant", // "enum"
                                                                     0x6c776370: "copies", // "lwcp"
                                                                     0x74637562: "cube", // "tcub"
                                                                     0x66637572: "currency", // "fcur"
                                                                     0x6372736c: "currentSlide", // "crsl"
                                                                     0x74646173: "dashStyle", // "tdas"
                                                                     0x74647461: "data", // "tdta"
                                                                     0x6c647420: "date", // "ldt\0x20"
                                                                     0x4b787064: "date_", // "Kxpd"
                                                                     0x6664746d: "dateAndTime", // "fdtm"
                                                                     0x64656320: "December", // "dec\0x20"
                                                                     0x6465636d: "decimalStruct", // "decm"
                                                                     0x73646269: "defaultBodyItem", // "sdbi"
                                                                     0x73647469: "defaultTitleItem", // "sdti"
                                                                     0x6473636e: "descending", // "dscn"
                                                                     0x64736372: "description_", // "dscr"
                                                                     0x6c776474: "detailed", // "lwdt"
                                                                     0x64696163: "diacriticals", // "diac"
                                                                     0x74646973: "dissolve", // "tdis"
                                                                     0x646f6375: "document", // "docu"
                                                                     0x4b6e6474: "documentTheme", // "Kndt"
                                                                     0x74647779: "doorway", // "tdwy"
                                                                     0x636f6d70: "doubleInteger", // "comp"
                                                                     0x74647270: "drop", // "tdrp"
                                                                     0x7464706c: "droplet", // "tdpl"
                                                                     0x66647572: "duration", // "fdur"
                                                                     0x656e6373: "encodedString", // "encs"
                                                                     0x6c776c70: "endingPage", // "lwlp"
                                                                     0x6c6e6570: "endPoint", // "lnep"
                                                                     0x45505320: "EPSPicture", // "EPS\0x20"
                                                                     0x6c776568: "errorHandling", // "lweh"
                                                                     0x65787061: "expansion", // "expa"
                                                                     0x4b786f70: "exportOptions", // "Kxop"
                                                                     0x4b787077: "exportStyle", // "Kxpw"
                                                                     0x65787465: "extendedReal", // "exte"
                                                                     0x74666164: "fadeAndMove", // "tfad"
                                                                     0x74667463: "fadeThroughColor", // "tftc"
                                                                     0x7466616c: "fall", // "tfal"
                                                                     0x6661786e: "faxNumber", // "faxn"
                                                                     0x66656220: "February", // "feb\0x20"
                                                                     0x66696c65: "file", // "file"
                                                                     0x6174666e: "fileName", // "atfn"
                                                                     0x66737266: "fileRef", // "fsrf"
                                                                     0x66737320: "fileSpecification", // "fss\0x20"
                                                                     0x6675726c: "fileURL", // "furl"
                                                                     0x66697864: "fixed", // "fixd"
                                                                     0x66706e74: "fixedPoint", // "fpnt"
                                                                     0x66726374: "fixedRectangle", // "frct"
                                                                     0x74666970: "flip", // "tfip"
                                                                     0x74666f70: "flop", // "tfop"
                                                                     0x666f6e74: "font", // "font"
                                                                     0x4e4d666e: "fontName", // "NMfn"
                                                                     0x4e4d6673: "fontSize", // "NMfs"
                                                                     0x4e6d4672: "footerRowCount", // "NmFr"
                                                                     0x4e4d4354: "format", // "NMCT"
                                                                     0x4e4d6676: "formattedValue", // "NMfv"
                                                                     0x4e4d4366: "formula", // "NMCf"
                                                                     0x66667261: "fraction", // "ffra"
                                                                     0x66726920: "Friday", // "fri\0x20"
                                                                     0x70697366: "frontmost", // "pisf"
                                                                     0x46727a6e: "frozen", // "Frzn"
                                                                     0x47494666: "GIFPicture", // "GIFf"
                                                                     0x4b6e5030: "Good", // "KnP0"
                                                                     0x66696772: "gradientFill", // "figr"
                                                                     0x63677478: "graphicText", // "cgtx"
                                                                     0x74677264: "grid", // "tgrd"
                                                                     0x69677270: "group", // "igrp"
                                                                     0x4b707768: "Handouts", // "Kpwh"
                                                                     0x4e6d4843: "headerColumnCount", // "NmHC"
                                                                     0x4e6d4872: "headerRowCount", // "NmHr"
                                                                     0x73697468: "height", // "sith"
                                                                     0x68627232: "horizontal_bar_2d", // "hbr2"
                                                                     0x68627233: "horizontal_bar_3d", // "hbr3"
                                                                     0x4b68746d: "HTML", // "Khtm"
                                                                     0x68797068: "hyphens", // "hyph"
                                                                     0x49442020: "id", // "ID\0x20\0x20"
                                                                     0x696d6167: "image", // "imag"
                                                                     0x6669696d: "imageFill", // "fiim"
                                                                     0x4b786966: "imageFormat", // "Kxif"
                                                                     0x70696478: "index", // "pidx"
                                                                     0x4b707769: "IndividualSlides", // "Kpwi"
                                                                     0x6c6f6e67: "integer", // "long"
                                                                     0x69747874: "internationalText", // "itxt"
                                                                     0x696e746c: "internationalWritingCode", // "intl"
                                                                     0x74697273: "iris", // "tirs"
                                                                     0x636f626a: "item", // "cobj"
                                                                     0x69776b63: "iWorkContainer", // "iwkc"
                                                                     0x666d7469: "iWorkItem", // "fmti"
                                                                     0x6a616e20: "January", // "jan\0x20"
                                                                     0x4b69666a: "JPEG", // "Kifj"
                                                                     0x4a504547: "JPEGPicture", // "JPEG"
                                                                     0x6a756c20: "July", // "jul\0x20"
                                                                     0x6a756e20: "June", // "jun\0x20"
                                                                     0x616a7374: "justify", // "ajst"
                                                                     0x6b706964: "kernelProcessID", // "kpid"
                                                                     0x4b6e6666: "Keynote", // "Knff"
                                                                     0x4b6b6579: "Keynote09", // "Kkey"
                                                                     0x6c64626c: "largeReal", // "ldbl"
                                                                     0x616c6674: "left", // "alft"
                                                                     0x69576c6e: "line", // "iWln"
                                                                     0x6c696e32: "line_2d", // "lin2"
                                                                     0x6c696e33: "line_3d", // "lin3"
                                                                     0x6c697374: "list", // "list"
                                                                     0x696e736c: "locationReference", // "insl"
                                                                     0x704c636b: "locked", // "pLck"
                                                                     0x6c667864: "longFixed", // "lfxd"
                                                                     0x6c667074: "longFixedPoint", // "lfpt"
                                                                     0x6c667263: "longFixedRectangle", // "lfrc"
                                                                     0x6c706e74: "longPoint", // "lpnt"
                                                                     0x6c726374: "longRectangle", // "lrct"
                                                                     0x6d766c70: "loop", // "mvlp"
                                                                     0x6d766266: "loopBackAndForth", // "mvbf"
                                                                     0x6d616368: "machine", // "mach"
                                                                     0x6d4c6f63: "machineLocation", // "mLoc"
                                                                     0x706f7274: "machPort", // "port"
                                                                     0x746d6a76: "magicMove", // "tmjv"
                                                                     0x6d617220: "March", // "mar\0x20"
                                                                     0x4b6e4d73: "masterSlide", // "KnMs"
                                                                     0x6d696472: "maximumIdleDuration", // "midr"
                                                                     0x6d617920: "May", // "may\0x20"
                                                                     0x4b707074: "MicrosoftPowerPoint", // "Kppt"
                                                                     0x69736d6e: "miniaturizable", // "ismn"
                                                                     0x706d6e64: "miniaturized", // "pmnd"
                                                                     0x696d6f64: "modified", // "imod"
                                                                     0x6d6f6e20: "Monday", // "mon\0x20"
                                                                     0x746d7363: "mosaic", // "tmsc"
                                                                     0x746d7669: "moveIn", // "tmvi"
                                                                     0x73686d76: "movie", // "shmv"
                                                                     0x4b786d66: "movieFormat", // "Kxmf"
                                                                     0x6d766f6c: "movieVolume", // "mvol"
                                                                     0x706e616d: "name", // "pnam"
                                                                     0x4b6d664e: "nativeSize", // "KmfN"
                                                                     0x6e6f2020: "no", // "no\0x20\0x20"
                                                                     0x66696e6f: "noFill", // "fino"
                                                                     0x6d76726e: "none", // "mvrn"
                                                                     0x746e696c: "noTransitionEffect", // "tnil"
                                                                     0x6e6f7620: "November", // "nov\0x20"
                                                                     0x6e756c6c: "null", // "null"
                                                                     0x6e6d6272: "number", // "nmbr"
                                                                     0x66636e73: "numeralSystem", // "fcns"
                                                                     0x6e756d65: "numericStrings", // "nume"
                                                                     0x746f6362: "objectCube", // "tocb"
                                                                     0x746f6670: "objectFlip", // "tofp"
                                                                     0x746f7070: "objectPop", // "topp"
                                                                     0x746f7068: "objectPush", // "toph"
                                                                     0x746f7276: "objectRevolve", // "torv"
                                                                     0x70445478: "objectText", // "pDTx"
                                                                     0x746f7a6d: "objectZoom", // "tozm"
                                                                     0x6f637420: "October", // "oct\0x20"
                                                                     0x70534f70: "opacity", // "pSOp"
                                                                     0x7470666c: "pageFlip", // "tpfl"
                                                                     0x6c776c61: "pagesAcross", // "lwla"
                                                                     0x6c776c64: "pagesDown", // "lwld"
                                                                     0x63706172: "paragraph", // "cpar"
                                                                     0x73697074: "parent", // "sipt"
                                                                     0x4b785057: "password", // "KxPW"
                                                                     0x4b785048: "passwordHint", // "KxPH"
                                                                     0x4b706466: "PDF", // "Kpdf"
                                                                     0x4b785049: "PDFImageQuality", // "KxPI"
                                                                     0x66706572: "percent", // "fper"
                                                                     0x74707273: "perspective", // "tprs"
                                                                     0x50494354: "PICTPicture", // "PICT"
                                                                     0x70696532: "pie_2d", // "pie2"
                                                                     0x70696533: "pie_3d", // "pie3"
                                                                     0x74707674: "pivot", // "tpvt"
                                                                     0x74706d6d: "pixelMapRecord", // "tpmm"
                                                                     0x506c6e67: "playing", // "Plng"
                                                                     0x4b696670: "PNG", // "Kifp"
                                                                     0x51447074: "point", // "QDpt"
                                                                     0x66637070: "popUpMenu", // "fcpp"
                                                                     0x7369706f: "position", // "sipo"
                                                                     0x6b736e74: "presenterNotes", // "ksnt"
                                                                     0x70736574: "printSettings", // "pset"
                                                                     0x70736e20: "processSerialNumber", // "psn\0x20"
                                                                     0x70414c4c: "properties", // "pALL"
                                                                     0x70726f70: "property_", // "prop"
                                                                     0x70756e63: "punctuation", // "punc"
                                                                     0x74707368: "push", // "tpsh"
                                                                     0x4b6d6f76: "QuickTimeMovie", // "Kmov"
                                                                     0x4e6d4352: "range", // "NmCR"
                                                                     0x66726174: "rating", // "frat"
                                                                     0x4b786b66: "rawKPF", // "Kxkf"
                                                                     0x646f7562: "real", // "doub"
                                                                     0x7265636f: "record", // "reco"
                                                                     0x6f626a20: "reference", // "obj\0x20"
                                                                     0x7472666c: "reflection", // "trfl"
                                                                     0x73697273: "reflectionShowing", // "sirs"
                                                                     0x73697276: "reflectionValue", // "sirv"
                                                                     0x6d767270: "repetitionMethod", // "mvrp"
                                                                     0x6c777174: "requestedPrintTime", // "lwqt"
                                                                     0x7072737a: "resizable", // "prsz"
                                                                     0x7472766c: "reveal", // "trvl"
                                                                     0x74726576: "revolvingDoor", // "trev"
                                                                     0x74723136: "RGB16Color", // "tr16"
                                                                     0x74723936: "RGB96Color", // "tr96"
                                                                     0x63524742: "RGBColor", // "cRGB"
                                                                     0x72747874: "richText", // "rtxt"
                                                                     0x61726974: "right", // "arit"
                                                                     0x74726f74: "rotation", // "trot"
                                                                     0x7369726f: "rotation_", // "siro"
                                                                     0x4e4d5277: "row", // "NMRw"
                                                                     0x4e6d5472: "rowCount", // "NmTr"
                                                                     0x73617420: "Saturday", // "sat\0x20"
                                                                     0x7473636c: "scale", // "tscl"
                                                                     0x73637032: "scatterplot_2d", // "scp2"
                                                                     0x66736369: "scientific", // "fsci"
                                                                     0x73637074: "script", // "scpt"
                                                                     0x4e4d5473: "selectionRange", // "NMTs"
                                                                     0x73657020: "September", // "sep\0x20"
                                                                     0x73736870: "shape", // "sshp"
                                                                     0x7473686d: "shimmer", // "tshm"
                                                                     0x73686f72: "shortInteger", // "shor"
                                                                     0x7074737a: "size", // "ptsz"
                                                                     0x4b736b70: "skipped", // "Kskp"
                                                                     0x4b787073: "skippedSlides", // "Kxps"
                                                                     0x4b6e5364: "slide", // "KnSd"
                                                                     0x4b696d67: "slideImages", // "Kimg"
                                                                     0x4b53644e: "slideNumber", // "KSdN"
                                                                     0x4b78706e: "slideNumbers", // "Kxpn"
                                                                     0x4b6e7368: "slideNumbersShowing", // "Knsh"
                                                                     0x6663736c: "slider", // "fcsl"
                                                                     0x53737673: "slideSwitcherVisible", // "Ssvs"
                                                                     0x4b70776e: "SlideWithNotes", // "Kpwn"
                                                                     0x73696e67: "smallReal", // "sing"
                                                                     0x7473706b: "sparkle", // "tspk"
                                                                     0x73617232: "stacked_area_2d", // "sar2"
                                                                     0x73617233: "stacked_area_3d", // "sar3"
                                                                     0x73686232: "stacked_horizontal_bar_2d", // "shb2"
                                                                     0x73686233: "stacked_horizontal_bar_3d", // "shb3"
                                                                     0x73766232: "stacked_vertical_bar_2d", // "svb2"
                                                                     0x73766233: "stacked_vertical_bar_3d", // "svb3"
                                                                     0x6c777374: "standard", // "lwst"
                                                                     0x6c776670: "startingPage", // "lwfp"
                                                                     0x6c6e7370: "startPoint", // "lnsp"
                                                                     0x66637374: "stepper", // "fcst"
                                                                     0x54455854: "string", // "TEXT"
                                                                     0x7374796c: "styledClipboardText", // "styl"
                                                                     0x53545854: "styledText", // "STXT"
                                                                     0x73756e20: "Sunday", // "sun\0x20"
                                                                     0x74737770: "swap", // "tswp"
                                                                     0x74737767: "swing", // "tswg"
                                                                     0x74737769: "switch_", // "tswi"
                                                                     0x74737773: "swoosh", // "tsws"
                                                                     0x4e6d5462: "table", // "NmTb"
                                                                     0x74727072: "targetPrinter", // "trpr"
                                                                     0x63747874: "text", // "ctxt"
                                                                     0x74657843: "textColor", // "texC"
                                                                     0x73687478: "textItem", // "shtx"
                                                                     0x74737479: "textStyleInfo", // "tsty"
                                                                     0x77726170: "textWrap", // "wrap"
                                                                     0x4b6e7468: "theme", // "Knth"
                                                                     0x74687520: "Thursday", // "thu\0x20"
                                                                     0x4b696674: "TIFF", // "Kift"
                                                                     0x54494646: "TIFFPicture", // "TIFF"
                                                                     0x4b747368: "titleShowing", // "Ktsh"
                                                                     0x61767470: "top", // "avtp"
                                                                     0x78646c79: "transitionDelay", // "xdly"
                                                                     0x78647572: "transitionDuration", // "xdur"
                                                                     0x78656674: "transitionEffect", // "xeft"
                                                                     0x7374726e: "transitionProperties", // "strn"
                                                                     0x78736574: "transitionSettings", // "xset"
                                                                     0x74756520: "Tuesday", // "tue\0x20"
                                                                     0x7474776c: "twirl", // "ttwl"
                                                                     0x74747769: "twist", // "ttwi"
                                                                     0x74797065: "typeClass", // "type"
                                                                     0x75747874: "UnicodeText", // "utxt"
                                                                     0x75636f6d: "unsignedDoubleInteger", // "ucom"
                                                                     0x6d61676e: "unsignedInteger", // "magn"
                                                                     0x75736872: "unsignedShortInteger", // "ushr"
                                                                     0x75743136: "UTF16Text", // "ut16"
                                                                     0x75746638: "UTF8Text", // "utf8"
                                                                     0x4e4d4376: "value", // "NMCv"
                                                                     0x76657273: "version", // "vers"
                                                                     0x76627232: "vertical_bar_2d", // "vbr2"
                                                                     0x76627233: "vertical_bar_3d", // "vbr3"
                                                                     0x74785641: "verticalAlignment", // "txVA"
                                                                     0x70766973: "visible", // "pvis"
                                                                     0x77656420: "Wednesday", // "wed\0x20"
                                                                     0x77686974: "whitespace", // "whit"
                                                                     0x73697477: "width", // "sitw"
                                                                     0x6377696e: "window", // "cwin"
                                                                     0x74777065: "wipe", // "twpe"
                                                                     0x63776f72: "word", // "cwor"
                                                                     0x70736374: "writingCode", // "psct"
                                                                     0x79657320: "yes", // "yes\0x20"
                                                                     0x69737a6d: "zoomable", // "iszm"
                                                                     0x707a756d: "zoomed", // "pzum"
                                                     ],
                                                     propertyNames: [
                                                                     0x4e4d6164: "address", // "NMad"
                                                                     0x74657841: "alignment", // "texA"
                                                                     0x4b787061: "allStages", // "Kxpa"
                                                                     0x61756c70: "autoLoop", // "aulp"
                                                                     0x78617574: "automaticTransition", // "xaut"
                                                                     0x61757079: "autoPlay", // "aupy"
                                                                     0x61757374: "autoRestart", // "aust"
                                                                     0x63654243: "backgroundColor", // "ceBC"
                                                                     0x626b6674: "backgroundFillType", // "bkft"
                                                                     0x736d6173: "baseSlide", // "smas"
                                                                     0x4b627368: "bodyShowing", // "Kbsh"
                                                                     0x4b787062: "borders", // "Kxpb"
                                                                     0x70626e64: "bounds", // "pbnd"
                                                                     0x4e4d5463: "cellRange", // "NMTc"
                                                                     0x70636c73: "class_", // "pcls"
                                                                     0x61766f6c: "clipVolume", // "avol"
                                                                     0x68636c62: "closeable", // "hclb"
                                                                     0x6c77636c: "collating", // "lwcl"
                                                                     0x636f6c72: "color", // "colr"
                                                                     0x4e4d436f: "column", // "NMCo"
                                                                     0x4e6d5463: "columnCount", // "NmTc"
                                                                     0x4b786963: "compressionFactor", // "Kxic"
                                                                     0x6c776370: "copies", // "lwcp"
                                                                     0x6372736c: "currentSlide", // "crsl"
                                                                     0x4b787064: "date_", // "Kxpd"
                                                                     0x73646269: "defaultBodyItem", // "sdbi"
                                                                     0x73647469: "defaultTitleItem", // "sdti"
                                                                     0x64736372: "description_", // "dscr"
                                                                     0x646f6375: "document", // "docu"
                                                                     0x4b6e6474: "documentTheme", // "Kndt"
                                                                     0x6c776c70: "endingPage", // "lwlp"
                                                                     0x6c6e6570: "endPoint", // "lnep"
                                                                     0x6c776568: "errorHandling", // "lweh"
                                                                     0x4b787077: "exportStyle", // "Kxpw"
                                                                     0x6661786e: "faxNumber", // "faxn"
                                                                     0x66696c65: "file", // "file"
                                                                     0x6174666e: "fileName", // "atfn"
                                                                     0x666f6e74: "font", // "font"
                                                                     0x4e4d666e: "fontName", // "NMfn"
                                                                     0x4e4d6673: "fontSize", // "NMfs"
                                                                     0x4e6d4672: "footerRowCount", // "NmFr"
                                                                     0x4e4d4354: "format", // "NMCT"
                                                                     0x4e4d6676: "formattedValue", // "NMfv"
                                                                     0x4e4d4366: "formula", // "NMCf"
                                                                     0x70697366: "frontmost", // "pisf"
                                                                     0x46727a6e: "frozen", // "Frzn"
                                                                     0x4e6d4843: "headerColumnCount", // "NmHC"
                                                                     0x4e6d4872: "headerRowCount", // "NmHr"
                                                                     0x73697468: "height", // "sith"
                                                                     0x49442020: "id", // "ID\0x20\0x20"
                                                                     0x4b786966: "imageFormat", // "Kxif"
                                                                     0x70696478: "index", // "pidx"
                                                                     0x704c636b: "locked", // "pLck"
                                                                     0x6d696472: "maximumIdleDuration", // "midr"
                                                                     0x69736d6e: "miniaturizable", // "ismn"
                                                                     0x706d6e64: "miniaturized", // "pmnd"
                                                                     0x696d6f64: "modified", // "imod"
                                                                     0x4b786d66: "movieFormat", // "Kxmf"
                                                                     0x6d766f6c: "movieVolume", // "mvol"
                                                                     0x706e616d: "name", // "pnam"
                                                                     0x70445478: "objectText", // "pDTx"
                                                                     0x70534f70: "opacity", // "pSOp"
                                                                     0x6c776c61: "pagesAcross", // "lwla"
                                                                     0x6c776c64: "pagesDown", // "lwld"
                                                                     0x73697074: "parent", // "sipt"
                                                                     0x4b785057: "password", // "KxPW"
                                                                     0x4b785048: "passwordHint", // "KxPH"
                                                                     0x4b785049: "PDFImageQuality", // "KxPI"
                                                                     0x506c6e67: "playing", // "Plng"
                                                                     0x7369706f: "position", // "sipo"
                                                                     0x6b736e74: "presenterNotes", // "ksnt"
                                                                     0x70414c4c: "properties", // "pALL"
                                                                     0x4b786b66: "rawKPF", // "Kxkf"
                                                                     0x73697273: "reflectionShowing", // "sirs"
                                                                     0x73697276: "reflectionValue", // "sirv"
                                                                     0x6d767270: "repetitionMethod", // "mvrp"
                                                                     0x6c777174: "requestedPrintTime", // "lwqt"
                                                                     0x7072737a: "resizable", // "prsz"
                                                                     0x7369726f: "rotation_", // "siro"
                                                                     0x4e4d5277: "row", // "NMRw"
                                                                     0x4e6d5472: "rowCount", // "NmTr"
                                                                     0x4e4d5473: "selectionRange", // "NMTs"
                                                                     0x7074737a: "size", // "ptsz"
                                                                     0x4b736b70: "skipped", // "Kskp"
                                                                     0x4b787073: "skippedSlides", // "Kxps"
                                                                     0x4b53644e: "slideNumber", // "KSdN"
                                                                     0x4b78706e: "slideNumbers", // "Kxpn"
                                                                     0x4b6e7368: "slideNumbersShowing", // "Knsh"
                                                                     0x53737673: "slideSwitcherVisible", // "Ssvs"
                                                                     0x6c776670: "startingPage", // "lwfp"
                                                                     0x6c6e7370: "startPoint", // "lnsp"
                                                                     0x74727072: "targetPrinter", // "trpr"
                                                                     0x74657843: "textColor", // "texC"
                                                                     0x77726170: "textWrap", // "wrap"
                                                                     0x4b747368: "titleShowing", // "Ktsh"
                                                                     0x78646c79: "transitionDelay", // "xdly"
                                                                     0x78647572: "transitionDuration", // "xdur"
                                                                     0x78656674: "transitionEffect", // "xeft"
                                                                     0x7374726e: "transitionProperties", // "strn"
                                                                     0x4e4d4376: "value", // "NMCv"
                                                                     0x76657273: "version", // "vers"
                                                                     0x74785641: "verticalAlignment", // "txVA"
                                                                     0x70766973: "visible", // "pvis"
                                                                     0x73697477: "width", // "sitw"
                                                                     0x69737a6d: "zoomable", // "iszm"
                                                                     0x707a756d: "zoomed", // "pzum"
                                                     ],
                                                     elementsNames: [
                                                                     0x63617070: ("application", "applications"), // "capp"
                                                                     0x73686175: ("audio clip", "audioClips"), // "shau"
                                                                     0x4e6d436c: ("cell", "cells"), // "NmCl"
                                                                     0x63686120: ("character", "characters"), // "cha\0x20"
                                                                     0x73686374: ("chart", "charts"), // "shct"
                                                                     0x4e4d436f: ("column", "columns"), // "NMCo"
                                                                     0x646f6375: ("document", "documents"), // "docu"
                                                                     0x69677270: ("group", "groups"), // "igrp"
                                                                     0x696d6167: ("image", "images"), // "imag"
                                                                     0x636f626a: ("item", "items"), // "cobj"
                                                                     0x69776b63: ("iWork container", "iWorkContainers"), // "iwkc"
                                                                     0x666d7469: ("iWork item", "iWorkItems"), // "fmti"
                                                                     0x69576c6e: ("line", "lines"), // "iWln"
                                                                     0x4b6e4d73: ("master slide", "masterSlides"), // "KnMs"
                                                                     0x73686d76: ("movie", "movies"), // "shmv"
                                                                     0x63706172: ("paragraph", "paragraphs"), // "cpar"
                                                                     0x4e6d4352: ("range", "ranges"), // "NmCR"
                                                                     0x72747874: ("rich text", "richText"), // "rtxt"
                                                                     0x4e4d5277: ("row", "rows"), // "NMRw"
                                                                     0x73736870: ("shape", "shapes"), // "sshp"
                                                                     0x4b6e5364: ("slide", "slides"), // "KnSd"
                                                                     0x4e6d5462: ("table", "tables"), // "NmTb"
                                                                     0x73687478: ("text item", "textItems"), // "shtx"
                                                                     0x4b6e7468: ("theme", "themes"), // "Knth"
                                                                     0x6377696e: ("window", "windows"), // "cwin"
                                                                     0x63776f72: ("word", "words"), // "cwor"
                                                     ])

private let _glueClasses = SwiftAutomation.GlueClasses(insertionSpecifierType: KEYInsertion.self,
                                       objectSpecifierType: KEYItem.self,
                                       multiObjectSpecifierType: KEYItems.self,
                                       rootSpecifierType: KEYRoot.self,
                                       applicationType: Keynote.self,
                                       symbolType: KEYSymbol.self,
                                       formatter: _specifierFormatter)

private let _untargetedAppData = SwiftAutomation.AppData(glueClasses: _glueClasses)


/******************************************************************************/
// Symbol subclass defines static type/enum/property constants based on Keynote.app terminology

public class KEYSymbol: SwiftAutomation.Symbol {

    override public var typeAliasName: String {return "KEY"}

    public override class func symbol(code: OSType, type: OSType = typeType, descriptor: NSAppleEventDescriptor? = nil) -> KEYSymbol {
        switch (code) {
        case 0x4b6d6638: return self._1080p_ // "Kmf8"
        case 0x4b6d6634: return self._2160p_ // "Kmf4"
        case 0x4b6d6633: return self._360p_ // "Kmf3"
        case 0x4b6d6635: return self._540p_ // "Kmf5"
        case 0x4b6d6637: return self._720p_ // "Kmf7"
        case 0x4e4d6164: return self.address // "NMad"
        case 0x66696167: return self.advancedGradientFill // "fiag"
        case 0x66696169: return self.advancedImageFill // "fiai"
        case 0x616c6973: return self.alias // "alis"
        case 0x74657841: return self.alignment // "texA"
        case 0x4b787061: return self.allStages // "Kxpa"
        case 0x2a2a2a2a: return self.anything // "****"
        case 0x63617070: return self.application // "capp"
        case 0x62756e64: return self.applicationBundleID // "bund"
        case 0x7369676e: return self.applicationSignature // "sign"
        case 0x6170726c: return self.applicationURL // "aprl"
        case 0x61707220: return self.April // "apr\0x20"
        case 0x61726532: return self.area_2d // "are2"
        case 0x61726533: return self.area_3d // "are3"
        case 0x6173636e: return self.ascending // "ascn"
        case 0x61736b20: return self.ask // "ask\0x20"
        case 0x73686175: return self.audioClip // "shau"
        case 0x61756720: return self.August // "aug\0x20"
        case 0x61617574: return self.autoAlign // "aaut"
        case 0x61756c70: return self.autoLoop // "aulp"
        case 0x66617574: return self.automatic // "faut"
        case 0x78617574: return self.automaticTransition // "xaut"
        case 0x61757079: return self.autoPlay // "aupy"
        case 0x61757374: return self.autoRestart // "aust"
        case 0x63654243: return self.backgroundColor // "ceBC"
        case 0x626b6674: return self.backgroundFillType // "bkft"
        case 0x736d6173: return self.baseSlide // "smas"
        case 0x4b6e5032: return self.Best // "KnP2"
        case 0x62657374: return self.best // "best"
        case 0x4b6e5031: return self.Better // "KnP1"
        case 0x74626c64: return self.blinds // "tbld"
        case 0x4b627368: return self.bodyShowing // "Kbsh"
        case 0x626d726b: return self.bookmarkData // "bmrk"
        case 0x626f6f6c: return self.boolean // "bool"
        case 0x4b787062: return self.borders // "Kxpb"
        case 0x61766274: return self.bottom // "avbt"
        case 0x71647274: return self.boundingRectangle // "qdrt"
        case 0x70626e64: return self.bounds // "pbnd"
        case 0x63617365: return self.case_ // "case"
        case 0x4e6d436c: return self.cell // "NmCl"
        case 0x4e4d5463: return self.cellRange // "NMTc"
        case 0x61637472: return self.center // "actr"
        case 0x63686120: return self.character // "cha\0x20"
        case 0x73686374: return self.chart // "shct"
        case 0x4b436763: return self.chartColumn // "KCgc"
        case 0x4b436772: return self.chartRow // "KCgr"
        case 0x66636368: return self.checkbox // "fcch"
        case 0x70636c73: return self.class_ // "pcls"
        case 0x61766f6c: return self.clipVolume // "avol"
        case 0x68636c62: return self.closeable // "hclb"
        case 0x74636c6f: return self.clothesline // "tclo"
        case 0x6c77636c: return self.collating // "lwcl"
        case 0x636f6c72: return self.color // "colr"
        case 0x6669636f: return self.colorFill // "fico"
        case 0x7463706c: return self.colorPlanes // "tcpl"
        case 0x636c7274: return self.colorTable // "clrt"
        case 0x4e4d436f: return self.column // "NMCo"
        case 0x4e6d5463: return self.columnCount // "NmTc"
        case 0x4b786963: return self.compressionFactor // "Kxic"
        case 0x74636674: return self.confetti // "tcft"
        case 0x656e756d: return self.constant // "enum"
        case 0x6c776370: return self.copies // "lwcp"
        case 0x74637562: return self.cube // "tcub"
        case 0x66637572: return self.currency // "fcur"
        case 0x6372736c: return self.currentSlide // "crsl"
        case 0x74646173: return self.dashStyle // "tdas"
        case 0x74647461: return self.data // "tdta"
        case 0x6c647420: return self.date // "ldt\0x20"
        case 0x4b787064: return self.date_ // "Kxpd"
        case 0x6664746d: return self.dateAndTime // "fdtm"
        case 0x64656320: return self.December // "dec\0x20"
        case 0x6465636d: return self.decimalStruct // "decm"
        case 0x73646269: return self.defaultBodyItem // "sdbi"
        case 0x73647469: return self.defaultTitleItem // "sdti"
        case 0x6473636e: return self.descending // "dscn"
        case 0x64736372: return self.description_ // "dscr"
        case 0x6c776474: return self.detailed // "lwdt"
        case 0x64696163: return self.diacriticals // "diac"
        case 0x74646973: return self.dissolve // "tdis"
        case 0x646f6375: return self.document // "docu"
        case 0x4b6e6474: return self.documentTheme // "Kndt"
        case 0x74647779: return self.doorway // "tdwy"
        case 0x636f6d70: return self.doubleInteger // "comp"
        case 0x74647270: return self.drop // "tdrp"
        case 0x7464706c: return self.droplet // "tdpl"
        case 0x66647572: return self.duration // "fdur"
        case 0x656e6373: return self.encodedString // "encs"
        case 0x6c776c70: return self.endingPage // "lwlp"
        case 0x6c6e6570: return self.endPoint // "lnep"
        case 0x45505320: return self.EPSPicture // "EPS\0x20"
        case 0x6c776568: return self.errorHandling // "lweh"
        case 0x65787061: return self.expansion // "expa"
        case 0x4b786f70: return self.exportOptions // "Kxop"
        case 0x4b787077: return self.exportStyle // "Kxpw"
        case 0x65787465: return self.extendedReal // "exte"
        case 0x74666164: return self.fadeAndMove // "tfad"
        case 0x74667463: return self.fadeThroughColor // "tftc"
        case 0x7466616c: return self.fall // "tfal"
        case 0x6661786e: return self.faxNumber // "faxn"
        case 0x66656220: return self.February // "feb\0x20"
        case 0x66696c65: return self.file // "file"
        case 0x6174666e: return self.fileName // "atfn"
        case 0x66737266: return self.fileRef // "fsrf"
        case 0x66737320: return self.fileSpecification // "fss\0x20"
        case 0x6675726c: return self.fileURL // "furl"
        case 0x66697864: return self.fixed // "fixd"
        case 0x66706e74: return self.fixedPoint // "fpnt"
        case 0x66726374: return self.fixedRectangle // "frct"
        case 0x74666970: return self.flip // "tfip"
        case 0x74666f70: return self.flop // "tfop"
        case 0x666f6e74: return self.font // "font"
        case 0x4e4d666e: return self.fontName // "NMfn"
        case 0x4e4d6673: return self.fontSize // "NMfs"
        case 0x4e6d4672: return self.footerRowCount // "NmFr"
        case 0x4e4d4354: return self.format // "NMCT"
        case 0x4e4d6676: return self.formattedValue // "NMfv"
        case 0x4e4d4366: return self.formula // "NMCf"
        case 0x66667261: return self.fraction // "ffra"
        case 0x66726920: return self.Friday // "fri\0x20"
        case 0x70697366: return self.frontmost // "pisf"
        case 0x46727a6e: return self.frozen // "Frzn"
        case 0x47494666: return self.GIFPicture // "GIFf"
        case 0x4b6e5030: return self.Good // "KnP0"
        case 0x66696772: return self.gradientFill // "figr"
        case 0x63677478: return self.graphicText // "cgtx"
        case 0x74677264: return self.grid // "tgrd"
        case 0x69677270: return self.group // "igrp"
        case 0x4b707768: return self.Handouts // "Kpwh"
        case 0x4e6d4843: return self.headerColumnCount // "NmHC"
        case 0x4e6d4872: return self.headerRowCount // "NmHr"
        case 0x73697468: return self.height // "sith"
        case 0x68627232: return self.horizontal_bar_2d // "hbr2"
        case 0x68627233: return self.horizontal_bar_3d // "hbr3"
        case 0x4b68746d: return self.HTML // "Khtm"
        case 0x68797068: return self.hyphens // "hyph"
        case 0x49442020: return self.id // "ID\0x20\0x20"
        case 0x696d6167: return self.image // "imag"
        case 0x6669696d: return self.imageFill // "fiim"
        case 0x4b786966: return self.imageFormat // "Kxif"
        case 0x70696478: return self.index // "pidx"
        case 0x4b707769: return self.IndividualSlides // "Kpwi"
        case 0x6c6f6e67: return self.integer // "long"
        case 0x69747874: return self.internationalText // "itxt"
        case 0x696e746c: return self.internationalWritingCode // "intl"
        case 0x74697273: return self.iris // "tirs"
        case 0x636f626a: return self.item // "cobj"
        case 0x69776b63: return self.iWorkContainer // "iwkc"
        case 0x666d7469: return self.iWorkItem // "fmti"
        case 0x6a616e20: return self.January // "jan\0x20"
        case 0x4b69666a: return self.JPEG // "Kifj"
        case 0x4a504547: return self.JPEGPicture // "JPEG"
        case 0x6a756c20: return self.July // "jul\0x20"
        case 0x6a756e20: return self.June // "jun\0x20"
        case 0x616a7374: return self.justify // "ajst"
        case 0x6b706964: return self.kernelProcessID // "kpid"
        case 0x4b6e6666: return self.Keynote // "Knff"
        case 0x4b6b6579: return self.Keynote09 // "Kkey"
        case 0x6c64626c: return self.largeReal // "ldbl"
        case 0x616c6674: return self.left // "alft"
        case 0x69576c6e: return self.line // "iWln"
        case 0x6c696e32: return self.line_2d // "lin2"
        case 0x6c696e33: return self.line_3d // "lin3"
        case 0x6c697374: return self.list // "list"
        case 0x696e736c: return self.locationReference // "insl"
        case 0x704c636b: return self.locked // "pLck"
        case 0x6c667864: return self.longFixed // "lfxd"
        case 0x6c667074: return self.longFixedPoint // "lfpt"
        case 0x6c667263: return self.longFixedRectangle // "lfrc"
        case 0x6c706e74: return self.longPoint // "lpnt"
        case 0x6c726374: return self.longRectangle // "lrct"
        case 0x6d766c70: return self.loop // "mvlp"
        case 0x6d766266: return self.loopBackAndForth // "mvbf"
        case 0x6d616368: return self.machine // "mach"
        case 0x6d4c6f63: return self.machineLocation // "mLoc"
        case 0x706f7274: return self.machPort // "port"
        case 0x746d6a76: return self.magicMove // "tmjv"
        case 0x6d617220: return self.March // "mar\0x20"
        case 0x4b6e4d73: return self.masterSlide // "KnMs"
        case 0x6d696472: return self.maximumIdleDuration // "midr"
        case 0x6d617920: return self.May // "may\0x20"
        case 0x4b707074: return self.MicrosoftPowerPoint // "Kppt"
        case 0x69736d6e: return self.miniaturizable // "ismn"
        case 0x706d6e64: return self.miniaturized // "pmnd"
        case 0x696d6f64: return self.modified // "imod"
        case 0x6d6f6e20: return self.Monday // "mon\0x20"
        case 0x746d7363: return self.mosaic // "tmsc"
        case 0x746d7669: return self.moveIn // "tmvi"
        case 0x73686d76: return self.movie // "shmv"
        case 0x4b786d66: return self.movieFormat // "Kxmf"
        case 0x6d766f6c: return self.movieVolume // "mvol"
        case 0x706e616d: return self.name // "pnam"
        case 0x4b6d664e: return self.nativeSize // "KmfN"
        case 0x6e6f2020: return self.no // "no\0x20\0x20"
        case 0x66696e6f: return self.noFill // "fino"
        case 0x6d76726e: return self.none // "mvrn"
        case 0x746e696c: return self.noTransitionEffect // "tnil"
        case 0x6e6f7620: return self.November // "nov\0x20"
        case 0x6e756c6c: return self.null // "null"
        case 0x6e6d6272: return self.number // "nmbr"
        case 0x66636e73: return self.numeralSystem // "fcns"
        case 0x6e756d65: return self.numericStrings // "nume"
        case 0x746f6362: return self.objectCube // "tocb"
        case 0x746f6670: return self.objectFlip // "tofp"
        case 0x746f7070: return self.objectPop // "topp"
        case 0x746f7068: return self.objectPush // "toph"
        case 0x746f7276: return self.objectRevolve // "torv"
        case 0x70445478: return self.objectText // "pDTx"
        case 0x746f7a6d: return self.objectZoom // "tozm"
        case 0x6f637420: return self.October // "oct\0x20"
        case 0x70534f70: return self.opacity // "pSOp"
        case 0x7470666c: return self.pageFlip // "tpfl"
        case 0x6c776c61: return self.pagesAcross // "lwla"
        case 0x6c776c64: return self.pagesDown // "lwld"
        case 0x63706172: return self.paragraph // "cpar"
        case 0x73697074: return self.parent // "sipt"
        case 0x4b785057: return self.password // "KxPW"
        case 0x4b785048: return self.passwordHint // "KxPH"
        case 0x4b706466: return self.PDF // "Kpdf"
        case 0x4b785049: return self.PDFImageQuality // "KxPI"
        case 0x66706572: return self.percent // "fper"
        case 0x74707273: return self.perspective // "tprs"
        case 0x50494354: return self.PICTPicture // "PICT"
        case 0x70696532: return self.pie_2d // "pie2"
        case 0x70696533: return self.pie_3d // "pie3"
        case 0x74707674: return self.pivot // "tpvt"
        case 0x74706d6d: return self.pixelMapRecord // "tpmm"
        case 0x506c6e67: return self.playing // "Plng"
        case 0x4b696670: return self.PNG // "Kifp"
        case 0x51447074: return self.point // "QDpt"
        case 0x66637070: return self.popUpMenu // "fcpp"
        case 0x7369706f: return self.position // "sipo"
        case 0x6b736e74: return self.presenterNotes // "ksnt"
        case 0x70736574: return self.printSettings // "pset"
        case 0x70736e20: return self.processSerialNumber // "psn\0x20"
        case 0x70414c4c: return self.properties // "pALL"
        case 0x70726f70: return self.property_ // "prop"
        case 0x70756e63: return self.punctuation // "punc"
        case 0x74707368: return self.push // "tpsh"
        case 0x4b6d6f76: return self.QuickTimeMovie // "Kmov"
        case 0x4e6d4352: return self.range // "NmCR"
        case 0x66726174: return self.rating // "frat"
        case 0x4b786b66: return self.rawKPF // "Kxkf"
        case 0x646f7562: return self.real // "doub"
        case 0x7265636f: return self.record // "reco"
        case 0x6f626a20: return self.reference // "obj\0x20"
        case 0x7472666c: return self.reflection // "trfl"
        case 0x73697273: return self.reflectionShowing // "sirs"
        case 0x73697276: return self.reflectionValue // "sirv"
        case 0x6d767270: return self.repetitionMethod // "mvrp"
        case 0x6c777174: return self.requestedPrintTime // "lwqt"
        case 0x7072737a: return self.resizable // "prsz"
        case 0x7472766c: return self.reveal // "trvl"
        case 0x74726576: return self.revolvingDoor // "trev"
        case 0x74723136: return self.RGB16Color // "tr16"
        case 0x74723936: return self.RGB96Color // "tr96"
        case 0x63524742: return self.RGBColor // "cRGB"
        case 0x72747874: return self.richText // "rtxt"
        case 0x61726974: return self.right // "arit"
        case 0x74726f74: return self.rotation // "trot"
        case 0x7369726f: return self.rotation_ // "siro"
        case 0x4e4d5277: return self.row // "NMRw"
        case 0x4e6d5472: return self.rowCount // "NmTr"
        case 0x73617420: return self.Saturday // "sat\0x20"
        case 0x7473636c: return self.scale // "tscl"
        case 0x73637032: return self.scatterplot_2d // "scp2"
        case 0x66736369: return self.scientific // "fsci"
        case 0x73637074: return self.script // "scpt"
        case 0x4e4d5473: return self.selectionRange // "NMTs"
        case 0x73657020: return self.September // "sep\0x20"
        case 0x73736870: return self.shape // "sshp"
        case 0x7473686d: return self.shimmer // "tshm"
        case 0x73686f72: return self.shortInteger // "shor"
        case 0x7074737a: return self.size // "ptsz"
        case 0x4b736b70: return self.skipped // "Kskp"
        case 0x4b787073: return self.skippedSlides // "Kxps"
        case 0x4b6e5364: return self.slide // "KnSd"
        case 0x4b696d67: return self.slideImages // "Kimg"
        case 0x4b53644e: return self.slideNumber // "KSdN"
        case 0x4b78706e: return self.slideNumbers // "Kxpn"
        case 0x4b6e7368: return self.slideNumbersShowing // "Knsh"
        case 0x6663736c: return self.slider // "fcsl"
        case 0x53737673: return self.slideSwitcherVisible // "Ssvs"
        case 0x4b70776e: return self.SlideWithNotes // "Kpwn"
        case 0x73696e67: return self.smallReal // "sing"
        case 0x7473706b: return self.sparkle // "tspk"
        case 0x73617232: return self.stacked_area_2d // "sar2"
        case 0x73617233: return self.stacked_area_3d // "sar3"
        case 0x73686232: return self.stacked_horizontal_bar_2d // "shb2"
        case 0x73686233: return self.stacked_horizontal_bar_3d // "shb3"
        case 0x73766232: return self.stacked_vertical_bar_2d // "svb2"
        case 0x73766233: return self.stacked_vertical_bar_3d // "svb3"
        case 0x6c777374: return self.standard // "lwst"
        case 0x6c776670: return self.startingPage // "lwfp"
        case 0x6c6e7370: return self.startPoint // "lnsp"
        case 0x66637374: return self.stepper // "fcst"
        case 0x54455854: return self.string // "TEXT"
        case 0x7374796c: return self.styledClipboardText // "styl"
        case 0x53545854: return self.styledText // "STXT"
        case 0x73756e20: return self.Sunday // "sun\0x20"
        case 0x74737770: return self.swap // "tswp"
        case 0x74737767: return self.swing // "tswg"
        case 0x74737769: return self.switch_ // "tswi"
        case 0x74737773: return self.swoosh // "tsws"
        case 0x4e6d5462: return self.table // "NmTb"
        case 0x74727072: return self.targetPrinter // "trpr"
        case 0x63747874: return self.text // "ctxt"
        case 0x74657843: return self.textColor // "texC"
        case 0x73687478: return self.textItem // "shtx"
        case 0x74737479: return self.textStyleInfo // "tsty"
        case 0x77726170: return self.textWrap // "wrap"
        case 0x4b6e7468: return self.theme // "Knth"
        case 0x74687520: return self.Thursday // "thu\0x20"
        case 0x4b696674: return self.TIFF // "Kift"
        case 0x54494646: return self.TIFFPicture // "TIFF"
        case 0x4b747368: return self.titleShowing // "Ktsh"
        case 0x61767470: return self.top // "avtp"
        case 0x78646c79: return self.transitionDelay // "xdly"
        case 0x78647572: return self.transitionDuration // "xdur"
        case 0x78656674: return self.transitionEffect // "xeft"
        case 0x7374726e: return self.transitionProperties // "strn"
        case 0x78736574: return self.transitionSettings // "xset"
        case 0x74756520: return self.Tuesday // "tue\0x20"
        case 0x7474776c: return self.twirl // "ttwl"
        case 0x74747769: return self.twist // "ttwi"
        case 0x74797065: return self.typeClass // "type"
        case 0x75747874: return self.UnicodeText // "utxt"
        case 0x75636f6d: return self.unsignedDoubleInteger // "ucom"
        case 0x6d61676e: return self.unsignedInteger // "magn"
        case 0x75736872: return self.unsignedShortInteger // "ushr"
        case 0x75743136: return self.UTF16Text // "ut16"
        case 0x75746638: return self.UTF8Text // "utf8"
        case 0x4e4d4376: return self.value // "NMCv"
        case 0x76657273: return self.version // "vers"
        case 0x76627232: return self.vertical_bar_2d // "vbr2"
        case 0x76627233: return self.vertical_bar_3d // "vbr3"
        case 0x74785641: return self.verticalAlignment // "txVA"
        case 0x70766973: return self.visible // "pvis"
        case 0x77656420: return self.Wednesday // "wed\0x20"
        case 0x77686974: return self.whitespace // "whit"
        case 0x73697477: return self.width // "sitw"
        case 0x6377696e: return self.window // "cwin"
        case 0x74777065: return self.wipe // "twpe"
        case 0x63776f72: return self.word // "cwor"
        case 0x70736374: return self.writingCode // "psct"
        case 0x79657320: return self.yes // "yes\0x20"
        case 0x69737a6d: return self.zoomable // "iszm"
        case 0x707a756d: return self.zoomed // "pzum"
        default: return super.symbol(code: code, type: type, descriptor: descriptor) as! KEYSymbol
        }
    }

    // Types/properties
    public static let address = KEYSymbol(name: "address", code: 0x4e4d6164, type: typeType) // "NMad"
    public static let alias = KEYSymbol(name: "alias", code: 0x616c6973, type: typeType) // "alis"
    public static let alignment = KEYSymbol(name: "alignment", code: 0x74657841, type: typeType) // "texA"
    public static let allStages = KEYSymbol(name: "allStages", code: 0x4b787061, type: typeType) // "Kxpa"
    public static let anything = KEYSymbol(name: "anything", code: 0x2a2a2a2a, type: typeType) // "****"
    public static let application = KEYSymbol(name: "application", code: 0x63617070, type: typeType) // "capp"
    public static let applicationBundleID = KEYSymbol(name: "applicationBundleID", code: 0x62756e64, type: typeType) // "bund"
    public static let applicationSignature = KEYSymbol(name: "applicationSignature", code: 0x7369676e, type: typeType) // "sign"
    public static let applicationURL = KEYSymbol(name: "applicationURL", code: 0x6170726c, type: typeType) // "aprl"
    public static let April = KEYSymbol(name: "April", code: 0x61707220, type: typeType) // "apr\0x20"
    public static let audioClip = KEYSymbol(name: "audioClip", code: 0x73686175, type: typeType) // "shau"
    public static let August = KEYSymbol(name: "August", code: 0x61756720, type: typeType) // "aug\0x20"
    public static let autoLoop = KEYSymbol(name: "autoLoop", code: 0x61756c70, type: typeType) // "aulp"
    public static let automaticTransition = KEYSymbol(name: "automaticTransition", code: 0x78617574, type: typeType) // "xaut"
    public static let autoPlay = KEYSymbol(name: "autoPlay", code: 0x61757079, type: typeType) // "aupy"
    public static let autoRestart = KEYSymbol(name: "autoRestart", code: 0x61757374, type: typeType) // "aust"
    public static let backgroundColor = KEYSymbol(name: "backgroundColor", code: 0x63654243, type: typeType) // "ceBC"
    public static let backgroundFillType = KEYSymbol(name: "backgroundFillType", code: 0x626b6674, type: typeType) // "bkft"
    public static let baseSlide = KEYSymbol(name: "baseSlide", code: 0x736d6173, type: typeType) // "smas"
    public static let best = KEYSymbol(name: "best", code: 0x62657374, type: typeType) // "best"
    public static let bodyShowing = KEYSymbol(name: "bodyShowing", code: 0x4b627368, type: typeType) // "Kbsh"
    public static let bookmarkData = KEYSymbol(name: "bookmarkData", code: 0x626d726b, type: typeType) // "bmrk"
    public static let boolean = KEYSymbol(name: "boolean", code: 0x626f6f6c, type: typeType) // "bool"
    public static let borders = KEYSymbol(name: "borders", code: 0x4b787062, type: typeType) // "Kxpb"
    public static let boundingRectangle = KEYSymbol(name: "boundingRectangle", code: 0x71647274, type: typeType) // "qdrt"
    public static let bounds = KEYSymbol(name: "bounds", code: 0x70626e64, type: typeType) // "pbnd"
    public static let cell = KEYSymbol(name: "cell", code: 0x4e6d436c, type: typeType) // "NmCl"
    public static let cellRange = KEYSymbol(name: "cellRange", code: 0x4e4d5463, type: typeType) // "NMTc"
    public static let character = KEYSymbol(name: "character", code: 0x63686120, type: typeType) // "cha\0x20"
    public static let chart = KEYSymbol(name: "chart", code: 0x73686374, type: typeType) // "shct"
    public static let class_ = KEYSymbol(name: "class_", code: 0x70636c73, type: typeType) // "pcls"
    public static let clipVolume = KEYSymbol(name: "clipVolume", code: 0x61766f6c, type: typeType) // "avol"
    public static let closeable = KEYSymbol(name: "closeable", code: 0x68636c62, type: typeType) // "hclb"
    public static let collating = KEYSymbol(name: "collating", code: 0x6c77636c, type: typeType) // "lwcl"
    public static let color = KEYSymbol(name: "color", code: 0x636f6c72, type: typeType) // "colr"
    public static let colorTable = KEYSymbol(name: "colorTable", code: 0x636c7274, type: typeType) // "clrt"
    public static let column = KEYSymbol(name: "column", code: 0x4e4d436f, type: typeType) // "NMCo"
    public static let columnCount = KEYSymbol(name: "columnCount", code: 0x4e6d5463, type: typeType) // "NmTc"
    public static let compressionFactor = KEYSymbol(name: "compressionFactor", code: 0x4b786963, type: typeType) // "Kxic"
    public static let constant = KEYSymbol(name: "constant", code: 0x656e756d, type: typeType) // "enum"
    public static let copies = KEYSymbol(name: "copies", code: 0x6c776370, type: typeType) // "lwcp"
    public static let currentSlide = KEYSymbol(name: "currentSlide", code: 0x6372736c, type: typeType) // "crsl"
    public static let dashStyle = KEYSymbol(name: "dashStyle", code: 0x74646173, type: typeType) // "tdas"
    public static let data = KEYSymbol(name: "data", code: 0x74647461, type: typeType) // "tdta"
    public static let date = KEYSymbol(name: "date", code: 0x6c647420, type: typeType) // "ldt\0x20"
    public static let date_ = KEYSymbol(name: "date_", code: 0x4b787064, type: typeType) // "Kxpd"
    public static let December = KEYSymbol(name: "December", code: 0x64656320, type: typeType) // "dec\0x20"
    public static let decimalStruct = KEYSymbol(name: "decimalStruct", code: 0x6465636d, type: typeType) // "decm"
    public static let defaultBodyItem = KEYSymbol(name: "defaultBodyItem", code: 0x73646269, type: typeType) // "sdbi"
    public static let defaultTitleItem = KEYSymbol(name: "defaultTitleItem", code: 0x73647469, type: typeType) // "sdti"
    public static let description_ = KEYSymbol(name: "description_", code: 0x64736372, type: typeType) // "dscr"
    public static let document = KEYSymbol(name: "document", code: 0x646f6375, type: typeType) // "docu"
    public static let documentTheme = KEYSymbol(name: "documentTheme", code: 0x4b6e6474, type: typeType) // "Kndt"
    public static let doubleInteger = KEYSymbol(name: "doubleInteger", code: 0x636f6d70, type: typeType) // "comp"
    public static let encodedString = KEYSymbol(name: "encodedString", code: 0x656e6373, type: typeType) // "encs"
    public static let endingPage = KEYSymbol(name: "endingPage", code: 0x6c776c70, type: typeType) // "lwlp"
    public static let endPoint = KEYSymbol(name: "endPoint", code: 0x6c6e6570, type: typeType) // "lnep"
    public static let EPSPicture = KEYSymbol(name: "EPSPicture", code: 0x45505320, type: typeType) // "EPS\0x20"
    public static let errorHandling = KEYSymbol(name: "errorHandling", code: 0x6c776568, type: typeType) // "lweh"
    public static let exportOptions = KEYSymbol(name: "exportOptions", code: 0x4b786f70, type: typeType) // "Kxop"
    public static let exportStyle = KEYSymbol(name: "exportStyle", code: 0x4b787077, type: typeType) // "Kxpw"
    public static let extendedReal = KEYSymbol(name: "extendedReal", code: 0x65787465, type: typeType) // "exte"
    public static let faxNumber = KEYSymbol(name: "faxNumber", code: 0x6661786e, type: typeType) // "faxn"
    public static let February = KEYSymbol(name: "February", code: 0x66656220, type: typeType) // "feb\0x20"
    public static let file = KEYSymbol(name: "file", code: 0x66696c65, type: typeType) // "file"
    public static let fileName = KEYSymbol(name: "fileName", code: 0x6174666e, type: typeType) // "atfn"
    public static let fileRef = KEYSymbol(name: "fileRef", code: 0x66737266, type: typeType) // "fsrf"
    public static let fileSpecification = KEYSymbol(name: "fileSpecification", code: 0x66737320, type: typeType) // "fss\0x20"
    public static let fileURL = KEYSymbol(name: "fileURL", code: 0x6675726c, type: typeType) // "furl"
    public static let fixed = KEYSymbol(name: "fixed", code: 0x66697864, type: typeType) // "fixd"
    public static let fixedPoint = KEYSymbol(name: "fixedPoint", code: 0x66706e74, type: typeType) // "fpnt"
    public static let fixedRectangle = KEYSymbol(name: "fixedRectangle", code: 0x66726374, type: typeType) // "frct"
    public static let font = KEYSymbol(name: "font", code: 0x666f6e74, type: typeType) // "font"
    public static let fontName = KEYSymbol(name: "fontName", code: 0x4e4d666e, type: typeType) // "NMfn"
    public static let fontSize = KEYSymbol(name: "fontSize", code: 0x4e4d6673, type: typeType) // "NMfs"
    public static let footerRowCount = KEYSymbol(name: "footerRowCount", code: 0x4e6d4672, type: typeType) // "NmFr"
    public static let format = KEYSymbol(name: "format", code: 0x4e4d4354, type: typeType) // "NMCT"
    public static let formattedValue = KEYSymbol(name: "formattedValue", code: 0x4e4d6676, type: typeType) // "NMfv"
    public static let formula = KEYSymbol(name: "formula", code: 0x4e4d4366, type: typeType) // "NMCf"
    public static let Friday = KEYSymbol(name: "Friday", code: 0x66726920, type: typeType) // "fri\0x20"
    public static let frontmost = KEYSymbol(name: "frontmost", code: 0x70697366, type: typeType) // "pisf"
    public static let frozen = KEYSymbol(name: "frozen", code: 0x46727a6e, type: typeType) // "Frzn"
    public static let GIFPicture = KEYSymbol(name: "GIFPicture", code: 0x47494666, type: typeType) // "GIFf"
    public static let graphicText = KEYSymbol(name: "graphicText", code: 0x63677478, type: typeType) // "cgtx"
    public static let group = KEYSymbol(name: "group", code: 0x69677270, type: typeType) // "igrp"
    public static let headerColumnCount = KEYSymbol(name: "headerColumnCount", code: 0x4e6d4843, type: typeType) // "NmHC"
    public static let headerRowCount = KEYSymbol(name: "headerRowCount", code: 0x4e6d4872, type: typeType) // "NmHr"
    public static let height = KEYSymbol(name: "height", code: 0x73697468, type: typeType) // "sith"
    public static let id = KEYSymbol(name: "id", code: 0x49442020, type: typeType) // "ID\0x20\0x20"
    public static let image = KEYSymbol(name: "image", code: 0x696d6167, type: typeType) // "imag"
    public static let imageFormat = KEYSymbol(name: "imageFormat", code: 0x4b786966, type: typeType) // "Kxif"
    public static let index = KEYSymbol(name: "index", code: 0x70696478, type: typeType) // "pidx"
    public static let integer = KEYSymbol(name: "integer", code: 0x6c6f6e67, type: typeType) // "long"
    public static let internationalText = KEYSymbol(name: "internationalText", code: 0x69747874, type: typeType) // "itxt"
    public static let internationalWritingCode = KEYSymbol(name: "internationalWritingCode", code: 0x696e746c, type: typeType) // "intl"
    public static let item = KEYSymbol(name: "item", code: 0x636f626a, type: typeType) // "cobj"
    public static let iWorkContainer = KEYSymbol(name: "iWorkContainer", code: 0x69776b63, type: typeType) // "iwkc"
    public static let iWorkItem = KEYSymbol(name: "iWorkItem", code: 0x666d7469, type: typeType) // "fmti"
    public static let January = KEYSymbol(name: "January", code: 0x6a616e20, type: typeType) // "jan\0x20"
    public static let JPEGPicture = KEYSymbol(name: "JPEGPicture", code: 0x4a504547, type: typeType) // "JPEG"
    public static let July = KEYSymbol(name: "July", code: 0x6a756c20, type: typeType) // "jul\0x20"
    public static let June = KEYSymbol(name: "June", code: 0x6a756e20, type: typeType) // "jun\0x20"
    public static let kernelProcessID = KEYSymbol(name: "kernelProcessID", code: 0x6b706964, type: typeType) // "kpid"
    public static let largeReal = KEYSymbol(name: "largeReal", code: 0x6c64626c, type: typeType) // "ldbl"
    public static let line = KEYSymbol(name: "line", code: 0x69576c6e, type: typeType) // "iWln"
    public static let list = KEYSymbol(name: "list", code: 0x6c697374, type: typeType) // "list"
    public static let locationReference = KEYSymbol(name: "locationReference", code: 0x696e736c, type: typeType) // "insl"
    public static let locked = KEYSymbol(name: "locked", code: 0x704c636b, type: typeType) // "pLck"
    public static let longFixed = KEYSymbol(name: "longFixed", code: 0x6c667864, type: typeType) // "lfxd"
    public static let longFixedPoint = KEYSymbol(name: "longFixedPoint", code: 0x6c667074, type: typeType) // "lfpt"
    public static let longFixedRectangle = KEYSymbol(name: "longFixedRectangle", code: 0x6c667263, type: typeType) // "lfrc"
    public static let longPoint = KEYSymbol(name: "longPoint", code: 0x6c706e74, type: typeType) // "lpnt"
    public static let longRectangle = KEYSymbol(name: "longRectangle", code: 0x6c726374, type: typeType) // "lrct"
    public static let machine = KEYSymbol(name: "machine", code: 0x6d616368, type: typeType) // "mach"
    public static let machineLocation = KEYSymbol(name: "machineLocation", code: 0x6d4c6f63, type: typeType) // "mLoc"
    public static let machPort = KEYSymbol(name: "machPort", code: 0x706f7274, type: typeType) // "port"
    public static let March = KEYSymbol(name: "March", code: 0x6d617220, type: typeType) // "mar\0x20"
    public static let masterSlide = KEYSymbol(name: "masterSlide", code: 0x4b6e4d73, type: typeType) // "KnMs"
    public static let maximumIdleDuration = KEYSymbol(name: "maximumIdleDuration", code: 0x6d696472, type: typeType) // "midr"
    public static let May = KEYSymbol(name: "May", code: 0x6d617920, type: typeType) // "may\0x20"
    public static let miniaturizable = KEYSymbol(name: "miniaturizable", code: 0x69736d6e, type: typeType) // "ismn"
    public static let miniaturized = KEYSymbol(name: "miniaturized", code: 0x706d6e64, type: typeType) // "pmnd"
    public static let modified = KEYSymbol(name: "modified", code: 0x696d6f64, type: typeType) // "imod"
    public static let Monday = KEYSymbol(name: "Monday", code: 0x6d6f6e20, type: typeType) // "mon\0x20"
    public static let movie = KEYSymbol(name: "movie", code: 0x73686d76, type: typeType) // "shmv"
    public static let movieFormat = KEYSymbol(name: "movieFormat", code: 0x4b786d66, type: typeType) // "Kxmf"
    public static let movieVolume = KEYSymbol(name: "movieVolume", code: 0x6d766f6c, type: typeType) // "mvol"
    public static let name = KEYSymbol(name: "name", code: 0x706e616d, type: typeType) // "pnam"
    public static let November = KEYSymbol(name: "November", code: 0x6e6f7620, type: typeType) // "nov\0x20"
    public static let null = KEYSymbol(name: "null", code: 0x6e756c6c, type: typeType) // "null"
    public static let objectText = KEYSymbol(name: "objectText", code: 0x70445478, type: typeType) // "pDTx"
    public static let October = KEYSymbol(name: "October", code: 0x6f637420, type: typeType) // "oct\0x20"
    public static let opacity = KEYSymbol(name: "opacity", code: 0x70534f70, type: typeType) // "pSOp"
    public static let pagesAcross = KEYSymbol(name: "pagesAcross", code: 0x6c776c61, type: typeType) // "lwla"
    public static let pagesDown = KEYSymbol(name: "pagesDown", code: 0x6c776c64, type: typeType) // "lwld"
    public static let paragraph = KEYSymbol(name: "paragraph", code: 0x63706172, type: typeType) // "cpar"
    public static let parent = KEYSymbol(name: "parent", code: 0x73697074, type: typeType) // "sipt"
    public static let password = KEYSymbol(name: "password", code: 0x4b785057, type: typeType) // "KxPW"
    public static let passwordHint = KEYSymbol(name: "passwordHint", code: 0x4b785048, type: typeType) // "KxPH"
    public static let PDFImageQuality = KEYSymbol(name: "PDFImageQuality", code: 0x4b785049, type: typeType) // "KxPI"
    public static let PICTPicture = KEYSymbol(name: "PICTPicture", code: 0x50494354, type: typeType) // "PICT"
    public static let pixelMapRecord = KEYSymbol(name: "pixelMapRecord", code: 0x74706d6d, type: typeType) // "tpmm"
    public static let playing = KEYSymbol(name: "playing", code: 0x506c6e67, type: typeType) // "Plng"
    public static let point = KEYSymbol(name: "point", code: 0x51447074, type: typeType) // "QDpt"
    public static let position = KEYSymbol(name: "position", code: 0x7369706f, type: typeType) // "sipo"
    public static let presenterNotes = KEYSymbol(name: "presenterNotes", code: 0x6b736e74, type: typeType) // "ksnt"
    public static let printSettings = KEYSymbol(name: "printSettings", code: 0x70736574, type: typeType) // "pset"
    public static let processSerialNumber = KEYSymbol(name: "processSerialNumber", code: 0x70736e20, type: typeType) // "psn\0x20"
    public static let properties = KEYSymbol(name: "properties", code: 0x70414c4c, type: typeType) // "pALL"
    public static let property_ = KEYSymbol(name: "property_", code: 0x70726f70, type: typeType) // "prop"
    public static let range = KEYSymbol(name: "range", code: 0x4e6d4352, type: typeType) // "NmCR"
    public static let rawKPF = KEYSymbol(name: "rawKPF", code: 0x4b786b66, type: typeType) // "Kxkf"
    public static let real = KEYSymbol(name: "real", code: 0x646f7562, type: typeType) // "doub"
    public static let record = KEYSymbol(name: "record", code: 0x7265636f, type: typeType) // "reco"
    public static let reference = KEYSymbol(name: "reference", code: 0x6f626a20, type: typeType) // "obj\0x20"
    public static let reflectionShowing = KEYSymbol(name: "reflectionShowing", code: 0x73697273, type: typeType) // "sirs"
    public static let reflectionValue = KEYSymbol(name: "reflectionValue", code: 0x73697276, type: typeType) // "sirv"
    public static let repetitionMethod = KEYSymbol(name: "repetitionMethod", code: 0x6d767270, type: typeType) // "mvrp"
    public static let requestedPrintTime = KEYSymbol(name: "requestedPrintTime", code: 0x6c777174, type: typeType) // "lwqt"
    public static let resizable = KEYSymbol(name: "resizable", code: 0x7072737a, type: typeType) // "prsz"
    public static let RGB16Color = KEYSymbol(name: "RGB16Color", code: 0x74723136, type: typeType) // "tr16"
    public static let RGB96Color = KEYSymbol(name: "RGB96Color", code: 0x74723936, type: typeType) // "tr96"
    public static let RGBColor = KEYSymbol(name: "RGBColor", code: 0x63524742, type: typeType) // "cRGB"
    public static let richText = KEYSymbol(name: "richText", code: 0x72747874, type: typeType) // "rtxt"
    public static let rotation = KEYSymbol(name: "rotation", code: 0x74726f74, type: typeType) // "trot"
    public static let rotation_ = KEYSymbol(name: "rotation_", code: 0x7369726f, type: typeType) // "siro"
    public static let row = KEYSymbol(name: "row", code: 0x4e4d5277, type: typeType) // "NMRw"
    public static let rowCount = KEYSymbol(name: "rowCount", code: 0x4e6d5472, type: typeType) // "NmTr"
    public static let Saturday = KEYSymbol(name: "Saturday", code: 0x73617420, type: typeType) // "sat\0x20"
    public static let script = KEYSymbol(name: "script", code: 0x73637074, type: typeType) // "scpt"
    public static let selectionRange = KEYSymbol(name: "selectionRange", code: 0x4e4d5473, type: typeType) // "NMTs"
    public static let September = KEYSymbol(name: "September", code: 0x73657020, type: typeType) // "sep\0x20"
    public static let shape = KEYSymbol(name: "shape", code: 0x73736870, type: typeType) // "sshp"
    public static let shortInteger = KEYSymbol(name: "shortInteger", code: 0x73686f72, type: typeType) // "shor"
    public static let size = KEYSymbol(name: "size", code: 0x7074737a, type: typeType) // "ptsz"
    public static let skipped = KEYSymbol(name: "skipped", code: 0x4b736b70, type: typeType) // "Kskp"
    public static let skippedSlides = KEYSymbol(name: "skippedSlides", code: 0x4b787073, type: typeType) // "Kxps"
    public static let slide = KEYSymbol(name: "slide", code: 0x4b6e5364, type: typeType) // "KnSd"
    public static let slideNumber = KEYSymbol(name: "slideNumber", code: 0x4b53644e, type: typeType) // "KSdN"
    public static let slideNumbers = KEYSymbol(name: "slideNumbers", code: 0x4b78706e, type: typeType) // "Kxpn"
    public static let slideNumbersShowing = KEYSymbol(name: "slideNumbersShowing", code: 0x4b6e7368, type: typeType) // "Knsh"
    public static let slideSwitcherVisible = KEYSymbol(name: "slideSwitcherVisible", code: 0x53737673, type: typeType) // "Ssvs"
    public static let smallReal = KEYSymbol(name: "smallReal", code: 0x73696e67, type: typeType) // "sing"
    public static let startingPage = KEYSymbol(name: "startingPage", code: 0x6c776670, type: typeType) // "lwfp"
    public static let startPoint = KEYSymbol(name: "startPoint", code: 0x6c6e7370, type: typeType) // "lnsp"
    public static let string = KEYSymbol(name: "string", code: 0x54455854, type: typeType) // "TEXT"
    public static let styledClipboardText = KEYSymbol(name: "styledClipboardText", code: 0x7374796c, type: typeType) // "styl"
    public static let styledText = KEYSymbol(name: "styledText", code: 0x53545854, type: typeType) // "STXT"
    public static let Sunday = KEYSymbol(name: "Sunday", code: 0x73756e20, type: typeType) // "sun\0x20"
    public static let table = KEYSymbol(name: "table", code: 0x4e6d5462, type: typeType) // "NmTb"
    public static let targetPrinter = KEYSymbol(name: "targetPrinter", code: 0x74727072, type: typeType) // "trpr"
    public static let textColor = KEYSymbol(name: "textColor", code: 0x74657843, type: typeType) // "texC"
    public static let textItem = KEYSymbol(name: "textItem", code: 0x73687478, type: typeType) // "shtx"
    public static let textStyleInfo = KEYSymbol(name: "textStyleInfo", code: 0x74737479, type: typeType) // "tsty"
    public static let textWrap = KEYSymbol(name: "textWrap", code: 0x77726170, type: typeType) // "wrap"
    public static let theme = KEYSymbol(name: "theme", code: 0x4b6e7468, type: typeType) // "Knth"
    public static let Thursday = KEYSymbol(name: "Thursday", code: 0x74687520, type: typeType) // "thu\0x20"
    public static let TIFFPicture = KEYSymbol(name: "TIFFPicture", code: 0x54494646, type: typeType) // "TIFF"
    public static let titleShowing = KEYSymbol(name: "titleShowing", code: 0x4b747368, type: typeType) // "Ktsh"
    public static let transitionDelay = KEYSymbol(name: "transitionDelay", code: 0x78646c79, type: typeType) // "xdly"
    public static let transitionDuration = KEYSymbol(name: "transitionDuration", code: 0x78647572, type: typeType) // "xdur"
    public static let transitionEffect = KEYSymbol(name: "transitionEffect", code: 0x78656674, type: typeType) // "xeft"
    public static let transitionProperties = KEYSymbol(name: "transitionProperties", code: 0x7374726e, type: typeType) // "strn"
    public static let transitionSettings = KEYSymbol(name: "transitionSettings", code: 0x78736574, type: typeType) // "xset"
    public static let Tuesday = KEYSymbol(name: "Tuesday", code: 0x74756520, type: typeType) // "tue\0x20"
    public static let typeClass = KEYSymbol(name: "typeClass", code: 0x74797065, type: typeType) // "type"
    public static let UnicodeText = KEYSymbol(name: "UnicodeText", code: 0x75747874, type: typeType) // "utxt"
    public static let unsignedDoubleInteger = KEYSymbol(name: "unsignedDoubleInteger", code: 0x75636f6d, type: typeType) // "ucom"
    public static let unsignedInteger = KEYSymbol(name: "unsignedInteger", code: 0x6d61676e, type: typeType) // "magn"
    public static let unsignedShortInteger = KEYSymbol(name: "unsignedShortInteger", code: 0x75736872, type: typeType) // "ushr"
    public static let UTF16Text = KEYSymbol(name: "UTF16Text", code: 0x75743136, type: typeType) // "ut16"
    public static let UTF8Text = KEYSymbol(name: "UTF8Text", code: 0x75746638, type: typeType) // "utf8"
    public static let value = KEYSymbol(name: "value", code: 0x4e4d4376, type: typeType) // "NMCv"
    public static let version = KEYSymbol(name: "version", code: 0x76657273, type: typeType) // "vers"
    public static let verticalAlignment = KEYSymbol(name: "verticalAlignment", code: 0x74785641, type: typeType) // "txVA"
    public static let visible = KEYSymbol(name: "visible", code: 0x70766973, type: typeType) // "pvis"
    public static let Wednesday = KEYSymbol(name: "Wednesday", code: 0x77656420, type: typeType) // "wed\0x20"
    public static let width = KEYSymbol(name: "width", code: 0x73697477, type: typeType) // "sitw"
    public static let window = KEYSymbol(name: "window", code: 0x6377696e, type: typeType) // "cwin"
    public static let word = KEYSymbol(name: "word", code: 0x63776f72, type: typeType) // "cwor"
    public static let writingCode = KEYSymbol(name: "writingCode", code: 0x70736374, type: typeType) // "psct"
    public static let zoomable = KEYSymbol(name: "zoomable", code: 0x69737a6d, type: typeType) // "iszm"
    public static let zoomed = KEYSymbol(name: "zoomed", code: 0x707a756d, type: typeType) // "pzum"

    // Enumerators
    public static let _1080p_ = KEYSymbol(name: "_1080p_", code: 0x4b6d6638, type: typeEnumerated) // "Kmf8"
    public static let _2160p_ = KEYSymbol(name: "_2160p_", code: 0x4b6d6634, type: typeEnumerated) // "Kmf4"
    public static let _360p_ = KEYSymbol(name: "_360p_", code: 0x4b6d6633, type: typeEnumerated) // "Kmf3"
    public static let _540p_ = KEYSymbol(name: "_540p_", code: 0x4b6d6635, type: typeEnumerated) // "Kmf5"
    public static let _720p_ = KEYSymbol(name: "_720p_", code: 0x4b6d6637, type: typeEnumerated) // "Kmf7"
    public static let advancedGradientFill = KEYSymbol(name: "advancedGradientFill", code: 0x66696167, type: typeEnumerated) // "fiag"
    public static let advancedImageFill = KEYSymbol(name: "advancedImageFill", code: 0x66696169, type: typeEnumerated) // "fiai"
    public static let area_2d = KEYSymbol(name: "area_2d", code: 0x61726532, type: typeEnumerated) // "are2"
    public static let area_3d = KEYSymbol(name: "area_3d", code: 0x61726533, type: typeEnumerated) // "are3"
    public static let ascending = KEYSymbol(name: "ascending", code: 0x6173636e, type: typeEnumerated) // "ascn"
    public static let ask = KEYSymbol(name: "ask", code: 0x61736b20, type: typeEnumerated) // "ask\0x20"
    public static let autoAlign = KEYSymbol(name: "autoAlign", code: 0x61617574, type: typeEnumerated) // "aaut"
    public static let automatic = KEYSymbol(name: "automatic", code: 0x66617574, type: typeEnumerated) // "faut"
    public static let Best = KEYSymbol(name: "Best", code: 0x4b6e5032, type: typeEnumerated) // "KnP2"
    public static let Better = KEYSymbol(name: "Better", code: 0x4b6e5031, type: typeEnumerated) // "KnP1"
    public static let blinds = KEYSymbol(name: "blinds", code: 0x74626c64, type: typeEnumerated) // "tbld"
    public static let bottom = KEYSymbol(name: "bottom", code: 0x61766274, type: typeEnumerated) // "avbt"
    public static let case_ = KEYSymbol(name: "case_", code: 0x63617365, type: typeEnumerated) // "case"
    public static let center = KEYSymbol(name: "center", code: 0x61637472, type: typeEnumerated) // "actr"
    public static let chartColumn = KEYSymbol(name: "chartColumn", code: 0x4b436763, type: typeEnumerated) // "KCgc"
    public static let chartRow = KEYSymbol(name: "chartRow", code: 0x4b436772, type: typeEnumerated) // "KCgr"
    public static let checkbox = KEYSymbol(name: "checkbox", code: 0x66636368, type: typeEnumerated) // "fcch"
    public static let clothesline = KEYSymbol(name: "clothesline", code: 0x74636c6f, type: typeEnumerated) // "tclo"
    public static let colorFill = KEYSymbol(name: "colorFill", code: 0x6669636f, type: typeEnumerated) // "fico"
    public static let colorPlanes = KEYSymbol(name: "colorPlanes", code: 0x7463706c, type: typeEnumerated) // "tcpl"
    public static let confetti = KEYSymbol(name: "confetti", code: 0x74636674, type: typeEnumerated) // "tcft"
    public static let cube = KEYSymbol(name: "cube", code: 0x74637562, type: typeEnumerated) // "tcub"
    public static let currency = KEYSymbol(name: "currency", code: 0x66637572, type: typeEnumerated) // "fcur"
    public static let dateAndTime = KEYSymbol(name: "dateAndTime", code: 0x6664746d, type: typeEnumerated) // "fdtm"
    public static let descending = KEYSymbol(name: "descending", code: 0x6473636e, type: typeEnumerated) // "dscn"
    public static let detailed = KEYSymbol(name: "detailed", code: 0x6c776474, type: typeEnumerated) // "lwdt"
    public static let diacriticals = KEYSymbol(name: "diacriticals", code: 0x64696163, type: typeEnumerated) // "diac"
    public static let dissolve = KEYSymbol(name: "dissolve", code: 0x74646973, type: typeEnumerated) // "tdis"
    public static let doorway = KEYSymbol(name: "doorway", code: 0x74647779, type: typeEnumerated) // "tdwy"
    public static let drop = KEYSymbol(name: "drop", code: 0x74647270, type: typeEnumerated) // "tdrp"
    public static let droplet = KEYSymbol(name: "droplet", code: 0x7464706c, type: typeEnumerated) // "tdpl"
    public static let duration = KEYSymbol(name: "duration", code: 0x66647572, type: typeEnumerated) // "fdur"
    public static let expansion = KEYSymbol(name: "expansion", code: 0x65787061, type: typeEnumerated) // "expa"
    public static let fadeAndMove = KEYSymbol(name: "fadeAndMove", code: 0x74666164, type: typeEnumerated) // "tfad"
    public static let fadeThroughColor = KEYSymbol(name: "fadeThroughColor", code: 0x74667463, type: typeEnumerated) // "tftc"
    public static let fall = KEYSymbol(name: "fall", code: 0x7466616c, type: typeEnumerated) // "tfal"
    public static let flip = KEYSymbol(name: "flip", code: 0x74666970, type: typeEnumerated) // "tfip"
    public static let flop = KEYSymbol(name: "flop", code: 0x74666f70, type: typeEnumerated) // "tfop"
    public static let fraction = KEYSymbol(name: "fraction", code: 0x66667261, type: typeEnumerated) // "ffra"
    public static let Good = KEYSymbol(name: "Good", code: 0x4b6e5030, type: typeEnumerated) // "KnP0"
    public static let gradientFill = KEYSymbol(name: "gradientFill", code: 0x66696772, type: typeEnumerated) // "figr"
    public static let grid = KEYSymbol(name: "grid", code: 0x74677264, type: typeEnumerated) // "tgrd"
    public static let Handouts = KEYSymbol(name: "Handouts", code: 0x4b707768, type: typeEnumerated) // "Kpwh"
    public static let horizontal_bar_2d = KEYSymbol(name: "horizontal_bar_2d", code: 0x68627232, type: typeEnumerated) // "hbr2"
    public static let horizontal_bar_3d = KEYSymbol(name: "horizontal_bar_3d", code: 0x68627233, type: typeEnumerated) // "hbr3"
    public static let HTML = KEYSymbol(name: "HTML", code: 0x4b68746d, type: typeEnumerated) // "Khtm"
    public static let hyphens = KEYSymbol(name: "hyphens", code: 0x68797068, type: typeEnumerated) // "hyph"
    public static let imageFill = KEYSymbol(name: "imageFill", code: 0x6669696d, type: typeEnumerated) // "fiim"
    public static let IndividualSlides = KEYSymbol(name: "IndividualSlides", code: 0x4b707769, type: typeEnumerated) // "Kpwi"
    public static let iris = KEYSymbol(name: "iris", code: 0x74697273, type: typeEnumerated) // "tirs"
    public static let JPEG = KEYSymbol(name: "JPEG", code: 0x4b69666a, type: typeEnumerated) // "Kifj"
    public static let justify = KEYSymbol(name: "justify", code: 0x616a7374, type: typeEnumerated) // "ajst"
    public static let Keynote = KEYSymbol(name: "Keynote", code: 0x4b6e6666, type: typeEnumerated) // "Knff"
    public static let Keynote09 = KEYSymbol(name: "Keynote09", code: 0x4b6b6579, type: typeEnumerated) // "Kkey"
    public static let left = KEYSymbol(name: "left", code: 0x616c6674, type: typeEnumerated) // "alft"
    public static let line_2d = KEYSymbol(name: "line_2d", code: 0x6c696e32, type: typeEnumerated) // "lin2"
    public static let line_3d = KEYSymbol(name: "line_3d", code: 0x6c696e33, type: typeEnumerated) // "lin3"
    public static let loop = KEYSymbol(name: "loop", code: 0x6d766c70, type: typeEnumerated) // "mvlp"
    public static let loopBackAndForth = KEYSymbol(name: "loopBackAndForth", code: 0x6d766266, type: typeEnumerated) // "mvbf"
    public static let magicMove = KEYSymbol(name: "magicMove", code: 0x746d6a76, type: typeEnumerated) // "tmjv"
    public static let MicrosoftPowerPoint = KEYSymbol(name: "MicrosoftPowerPoint", code: 0x4b707074, type: typeEnumerated) // "Kppt"
    public static let mosaic = KEYSymbol(name: "mosaic", code: 0x746d7363, type: typeEnumerated) // "tmsc"
    public static let moveIn = KEYSymbol(name: "moveIn", code: 0x746d7669, type: typeEnumerated) // "tmvi"
    public static let nativeSize = KEYSymbol(name: "nativeSize", code: 0x4b6d664e, type: typeEnumerated) // "KmfN"
    public static let no = KEYSymbol(name: "no", code: 0x6e6f2020, type: typeEnumerated) // "no\0x20\0x20"
    public static let noFill = KEYSymbol(name: "noFill", code: 0x66696e6f, type: typeEnumerated) // "fino"
    public static let none = KEYSymbol(name: "none", code: 0x6d76726e, type: typeEnumerated) // "mvrn"
    public static let noTransitionEffect = KEYSymbol(name: "noTransitionEffect", code: 0x746e696c, type: typeEnumerated) // "tnil"
    public static let number = KEYSymbol(name: "number", code: 0x6e6d6272, type: typeEnumerated) // "nmbr"
    public static let numeralSystem = KEYSymbol(name: "numeralSystem", code: 0x66636e73, type: typeEnumerated) // "fcns"
    public static let numericStrings = KEYSymbol(name: "numericStrings", code: 0x6e756d65, type: typeEnumerated) // "nume"
    public static let objectCube = KEYSymbol(name: "objectCube", code: 0x746f6362, type: typeEnumerated) // "tocb"
    public static let objectFlip = KEYSymbol(name: "objectFlip", code: 0x746f6670, type: typeEnumerated) // "tofp"
    public static let objectPop = KEYSymbol(name: "objectPop", code: 0x746f7070, type: typeEnumerated) // "topp"
    public static let objectPush = KEYSymbol(name: "objectPush", code: 0x746f7068, type: typeEnumerated) // "toph"
    public static let objectRevolve = KEYSymbol(name: "objectRevolve", code: 0x746f7276, type: typeEnumerated) // "torv"
    public static let objectZoom = KEYSymbol(name: "objectZoom", code: 0x746f7a6d, type: typeEnumerated) // "tozm"
    public static let pageFlip = KEYSymbol(name: "pageFlip", code: 0x7470666c, type: typeEnumerated) // "tpfl"
    public static let PDF = KEYSymbol(name: "PDF", code: 0x4b706466, type: typeEnumerated) // "Kpdf"
    public static let percent = KEYSymbol(name: "percent", code: 0x66706572, type: typeEnumerated) // "fper"
    public static let perspective = KEYSymbol(name: "perspective", code: 0x74707273, type: typeEnumerated) // "tprs"
    public static let pie_2d = KEYSymbol(name: "pie_2d", code: 0x70696532, type: typeEnumerated) // "pie2"
    public static let pie_3d = KEYSymbol(name: "pie_3d", code: 0x70696533, type: typeEnumerated) // "pie3"
    public static let pivot = KEYSymbol(name: "pivot", code: 0x74707674, type: typeEnumerated) // "tpvt"
    public static let PNG = KEYSymbol(name: "PNG", code: 0x4b696670, type: typeEnumerated) // "Kifp"
    public static let popUpMenu = KEYSymbol(name: "popUpMenu", code: 0x66637070, type: typeEnumerated) // "fcpp"
    public static let punctuation = KEYSymbol(name: "punctuation", code: 0x70756e63, type: typeEnumerated) // "punc"
    public static let push = KEYSymbol(name: "push", code: 0x74707368, type: typeEnumerated) // "tpsh"
    public static let QuickTimeMovie = KEYSymbol(name: "QuickTimeMovie", code: 0x4b6d6f76, type: typeEnumerated) // "Kmov"
    public static let rating = KEYSymbol(name: "rating", code: 0x66726174, type: typeEnumerated) // "frat"
    public static let reflection = KEYSymbol(name: "reflection", code: 0x7472666c, type: typeEnumerated) // "trfl"
    public static let reveal = KEYSymbol(name: "reveal", code: 0x7472766c, type: typeEnumerated) // "trvl"
    public static let revolvingDoor = KEYSymbol(name: "revolvingDoor", code: 0x74726576, type: typeEnumerated) // "trev"
    public static let right = KEYSymbol(name: "right", code: 0x61726974, type: typeEnumerated) // "arit"
    public static let scale = KEYSymbol(name: "scale", code: 0x7473636c, type: typeEnumerated) // "tscl"
    public static let scatterplot_2d = KEYSymbol(name: "scatterplot_2d", code: 0x73637032, type: typeEnumerated) // "scp2"
    public static let scientific = KEYSymbol(name: "scientific", code: 0x66736369, type: typeEnumerated) // "fsci"
    public static let shimmer = KEYSymbol(name: "shimmer", code: 0x7473686d, type: typeEnumerated) // "tshm"
    public static let slideImages = KEYSymbol(name: "slideImages", code: 0x4b696d67, type: typeEnumerated) // "Kimg"
    public static let slider = KEYSymbol(name: "slider", code: 0x6663736c, type: typeEnumerated) // "fcsl"
    public static let SlideWithNotes = KEYSymbol(name: "SlideWithNotes", code: 0x4b70776e, type: typeEnumerated) // "Kpwn"
    public static let sparkle = KEYSymbol(name: "sparkle", code: 0x7473706b, type: typeEnumerated) // "tspk"
    public static let stacked_area_2d = KEYSymbol(name: "stacked_area_2d", code: 0x73617232, type: typeEnumerated) // "sar2"
    public static let stacked_area_3d = KEYSymbol(name: "stacked_area_3d", code: 0x73617233, type: typeEnumerated) // "sar3"
    public static let stacked_horizontal_bar_2d = KEYSymbol(name: "stacked_horizontal_bar_2d", code: 0x73686232, type: typeEnumerated) // "shb2"
    public static let stacked_horizontal_bar_3d = KEYSymbol(name: "stacked_horizontal_bar_3d", code: 0x73686233, type: typeEnumerated) // "shb3"
    public static let stacked_vertical_bar_2d = KEYSymbol(name: "stacked_vertical_bar_2d", code: 0x73766232, type: typeEnumerated) // "svb2"
    public static let stacked_vertical_bar_3d = KEYSymbol(name: "stacked_vertical_bar_3d", code: 0x73766233, type: typeEnumerated) // "svb3"
    public static let standard = KEYSymbol(name: "standard", code: 0x6c777374, type: typeEnumerated) // "lwst"
    public static let stepper = KEYSymbol(name: "stepper", code: 0x66637374, type: typeEnumerated) // "fcst"
    public static let swap = KEYSymbol(name: "swap", code: 0x74737770, type: typeEnumerated) // "tswp"
    public static let swing = KEYSymbol(name: "swing", code: 0x74737767, type: typeEnumerated) // "tswg"
    public static let switch_ = KEYSymbol(name: "switch_", code: 0x74737769, type: typeEnumerated) // "tswi"
    public static let swoosh = KEYSymbol(name: "swoosh", code: 0x74737773, type: typeEnumerated) // "tsws"
    public static let text = KEYSymbol(name: "text", code: 0x63747874, type: typeEnumerated) // "ctxt"
    public static let TIFF = KEYSymbol(name: "TIFF", code: 0x4b696674, type: typeEnumerated) // "Kift"
    public static let top = KEYSymbol(name: "top", code: 0x61767470, type: typeEnumerated) // "avtp"
    public static let twirl = KEYSymbol(name: "twirl", code: 0x7474776c, type: typeEnumerated) // "ttwl"
    public static let twist = KEYSymbol(name: "twist", code: 0x74747769, type: typeEnumerated) // "ttwi"
    public static let vertical_bar_2d = KEYSymbol(name: "vertical_bar_2d", code: 0x76627232, type: typeEnumerated) // "vbr2"
    public static let vertical_bar_3d = KEYSymbol(name: "vertical_bar_3d", code: 0x76627233, type: typeEnumerated) // "vbr3"
    public static let whitespace = KEYSymbol(name: "whitespace", code: 0x77686974, type: typeEnumerated) // "whit"
    public static let wipe = KEYSymbol(name: "wipe", code: 0x74777065, type: typeEnumerated) // "twpe"
    public static let yes = KEYSymbol(name: "yes", code: 0x79657320, type: typeEnumerated) // "yes\0x20"
}

public typealias KEY = KEYSymbol // allows symbols to be written as (e.g.) KEY.name instead of KEYSymbol.name


/******************************************************************************/
// Specifier extensions; these add command methods and property/elements getters based on Keynote.app terminology

public protocol KEYCommand: SwiftAutomation.SpecifierProtocol {} // provides AE dispatch methods

// Command->Any will be bound when return type can't be inferred, else Command->T

extension KEYCommand {
    @discardableResult public func acceptSlideSwitcher(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "acceptSlideSwitcher", eventClass: 0x4b6e7463, eventID: 0x61737377, // "Kntc"/"assw"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func acceptSlideSwitcher<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "acceptSlideSwitcher", eventClass: 0x4b6e7463, eventID: 0x61737377, // "Kntc"/"assw"
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
    @discardableResult public func addChart(_ directParameter: Any = SwiftAutomation.NoParameter,
            rowNames: Any = SwiftAutomation.NoParameter,
            columnNames: Any = SwiftAutomation.NoParameter,
            data: Any = SwiftAutomation.NoParameter,
            type: Any = SwiftAutomation.NoParameter,
            groupBy: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "addChart", eventClass: 0x4b6e7463, eventID: 0x41646463, // "Kntc"/"Addc"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("rowNames", 0x4b43726e, rowNames), // "KCrn"
                    ("columnNames", 0x4b43636e, columnNames), // "KCcn"
                    ("data", 0x4b436474, data), // "KCdt"
                    ("type", 0x4b436374, type), // "KCct"
                    ("groupBy", 0x4b436762, groupBy), // "KCgb"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func addChart<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            rowNames: Any = SwiftAutomation.NoParameter,
            columnNames: Any = SwiftAutomation.NoParameter,
            data: Any = SwiftAutomation.NoParameter,
            type: Any = SwiftAutomation.NoParameter,
            groupBy: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "addChart", eventClass: 0x4b6e7463, eventID: 0x41646463, // "Kntc"/"Addc"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("rowNames", 0x4b43726e, rowNames), // "KCrn"
                    ("columnNames", 0x4b43636e, columnNames), // "KCcn"
                    ("data", 0x4b436474, data), // "KCdt"
                    ("type", 0x4b436374, type), // "KCct"
                    ("groupBy", 0x4b436762, groupBy), // "KCgb"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func cancelSlideSwitcher(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "cancelSlideSwitcher", eventClass: 0x4b6e7463, eventID: 0x63737377, // "Kntc"/"cssw"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func cancelSlideSwitcher<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "cancelSlideSwitcher", eventClass: 0x4b6e7463, eventID: 0x63737377, // "Kntc"/"cssw"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func clear(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "clear", eventClass: 0x4e6d5462, eventID: 0x434c5220, // "NmTb"/"CLR\0x20"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func clear<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "clear", eventClass: 0x4e6d5462, eventID: 0x434c5220, // "NmTb"/"CLR\0x20"
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
    @discardableResult public func export(_ directParameter: Any = SwiftAutomation.NoParameter,
            to: Any = SwiftAutomation.NoParameter,
            as_: Any = SwiftAutomation.NoParameter,
            withProperties: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "export", eventClass: 0x4b6e7374, eventID: 0x6578706f, // "Knst"/"expo"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x6b66696c, to), // "kfil"
                    ("as_", 0x65786674, as_), // "exft"
                    ("withProperties", 0x65787072, withProperties), // "expr"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func export<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            to: Any = SwiftAutomation.NoParameter,
            as_: Any = SwiftAutomation.NoParameter,
            withProperties: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "export", eventClass: 0x4b6e7374, eventID: 0x6578706f, // "Knst"/"expo"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x6b66696c, to), // "kfil"
                    ("as_", 0x65786674, as_), // "exft"
                    ("withProperties", 0x65787072, withProperties), // "expr"
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
    @discardableResult public func hideSlideSwitcher(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "hideSlideSwitcher", eventClass: 0x4b6e7463, eventID: 0x63737377, // "Kntc"/"cssw"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func hideSlideSwitcher<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "hideSlideSwitcher", eventClass: 0x4b6e7463, eventID: 0x63737377, // "Kntc"/"cssw"
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
    @discardableResult public func makeImageSlides(_ directParameter: Any = SwiftAutomation.NoParameter,
            files: Any = SwiftAutomation.NoParameter,
            setTitles: Any = SwiftAutomation.NoParameter,
            master: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "makeImageSlides", eventClass: 0x4b6e7463, eventID: 0x4d496d53, // "Kntc"/"MImS"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("files", 0x4b49666c, files), // "KIfl"
                    ("setTitles", 0x4b497374, setTitles), // "KIst"
                    ("master", 0x4b494d73, master), // "KIMs"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func makeImageSlides<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            files: Any = SwiftAutomation.NoParameter,
            setTitles: Any = SwiftAutomation.NoParameter,
            master: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "makeImageSlides", eventClass: 0x4b6e7463, eventID: 0x4d496d53, // "Kntc"/"MImS"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("files", 0x4b49666c, files), // "KIfl"
                    ("setTitles", 0x4b497374, setTitles), // "KIst"
                    ("master", 0x4b494d73, master), // "KIMs"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func merge(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "merge", eventClass: 0x4e4d5462, eventID: 0x4d524745, // "NMTb"/"MRGE"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func merge<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "merge", eventClass: 0x4e4d5462, eventID: 0x4d524745, // "NMTb"/"MRGE"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
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
    @discardableResult public func moveSlideSwitcherBackward(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "moveSlideSwitcherBackward", eventClass: 0x4b6e7463, eventID: 0x6d737362, // "Kntc"/"mssb"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func moveSlideSwitcherBackward<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "moveSlideSwitcherBackward", eventClass: 0x4b6e7463, eventID: 0x6d737362, // "Kntc"/"mssb"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func moveSlideSwitcherForward(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "moveSlideSwitcherForward", eventClass: 0x4b6e7463, eventID: 0x6d737366, // "Kntc"/"mssf"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func moveSlideSwitcherForward<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "moveSlideSwitcherForward", eventClass: 0x4b6e7463, eventID: 0x6d737366, // "Kntc"/"mssf"
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
        return try self.appData.sendAppleEvent(name: "show", eventClass: 0x4b6e7463, eventID: 0x4b6a6d70, // "Kntc"/"Kjmp"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func show<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "show", eventClass: 0x4b6e7463, eventID: 0x4b6a6d70, // "Kntc"/"Kjmp"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func showNext(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "showNext", eventClass: 0x4b6e7463, eventID: 0x73746546, // "Kntc"/"steF"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func showNext<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "showNext", eventClass: 0x4b6e7463, eventID: 0x73746546, // "Kntc"/"steF"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func showPrevious(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "showPrevious", eventClass: 0x4b6e7463, eventID: 0x73746542, // "Kntc"/"steB"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func showPrevious<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "showPrevious", eventClass: 0x4b6e7463, eventID: 0x73746542, // "Kntc"/"steB"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func showSlideSwitcher(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "showSlideSwitcher", eventClass: 0x4b6e7463, eventID: 0x7373736c, // "Kntc"/"sssl"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func showSlideSwitcher<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "showSlideSwitcher", eventClass: 0x4b6e7463, eventID: 0x7373736c, // "Kntc"/"sssl"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func sort(_ directParameter: Any = SwiftAutomation.NoParameter,
            by: Any = SwiftAutomation.NoParameter,
            direction: Any = SwiftAutomation.NoParameter,
            inRows: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "sort", eventClass: 0x4e6d5462, eventID: 0x534f5254, // "NmTb"/"SORT"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("by", 0x4e4d7362, by), // "NMsb"
                    ("direction", 0x4e4d7364, direction), // "NMsd"
                    ("inRows", 0x4e4d4372, inRows), // "NMCr"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func sort<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            by: Any = SwiftAutomation.NoParameter,
            direction: Any = SwiftAutomation.NoParameter,
            inRows: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "sort", eventClass: 0x4e6d5462, eventID: 0x534f5254, // "NmTb"/"SORT"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("by", 0x4e4d7362, by), // "NMsb"
                    ("direction", 0x4e4d7364, direction), // "NMsd"
                    ("inRows", 0x4e4d4372, inRows), // "NMCr"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func start(_ directParameter: Any = SwiftAutomation.NoParameter,
            from: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "start", eventClass: 0x4b6e7374, eventID: 0x706c6159, // "Knst"/"plaY"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("from", 0x6b66726f, from), // "kfro"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func start<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            from: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "start", eventClass: 0x4b6e7374, eventID: 0x706c6159, // "Knst"/"plaY"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("from", 0x6b66726f, from), // "kfro"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func startFrom(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "startFrom", eventClass: 0x4b6e7463, eventID: 0x706c6146, // "Kntc"/"plaF"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func startFrom<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "startFrom", eventClass: 0x4b6e7463, eventID: 0x706c6146, // "Kntc"/"plaF"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func startSlideshow(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "startSlideshow", eventClass: 0x4b6e7463, eventID: 0x706c614c, // "Kntc"/"plaL"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func startSlideshow<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "startSlideshow", eventClass: 0x4b6e7463, eventID: 0x706c614c, // "Kntc"/"plaL"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func stop(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "stop", eventClass: 0x4b6e7374, eventID: 0x73746f50, // "Knst"/"stoP"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func stop<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "stop", eventClass: 0x4b6e7374, eventID: 0x73746f50, // "Knst"/"stoP"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func stopSlideshow(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "stopSlideshow", eventClass: 0x4b6e7463, eventID: 0x73746f54, // "Kntc"/"stoT"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func stopSlideshow<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "stopSlideshow", eventClass: 0x4b6e7463, eventID: 0x73746f54, // "Kntc"/"stoT"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func unmerge(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "unmerge", eventClass: 0x4e6d5462, eventID: 0x5370556d, // "NmTb"/"SpUm"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func unmerge<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "unmerge", eventClass: 0x4e6d5462, eventID: 0x5370556d, // "NmTb"/"SpUm"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
}


public protocol KEYObject: SwiftAutomation.ObjectSpecifierExtension, KEYCommand {} // provides vars and methods for constructing specifiers

extension KEYObject {
    
    // Properties
    public var address: KEYItem {return self.property(0x4e4d6164) as! KEYItem} // "NMad"
    public var alignment: KEYItem {return self.property(0x74657841) as! KEYItem} // "texA"
    public var allStages: KEYItem {return self.property(0x4b787061) as! KEYItem} // "Kxpa"
    public var autoLoop: KEYItem {return self.property(0x61756c70) as! KEYItem} // "aulp"
    public var automaticTransition: KEYItem {return self.property(0x78617574) as! KEYItem} // "xaut"
    public var autoPlay: KEYItem {return self.property(0x61757079) as! KEYItem} // "aupy"
    public var autoRestart: KEYItem {return self.property(0x61757374) as! KEYItem} // "aust"
    public var backgroundColor: KEYItem {return self.property(0x63654243) as! KEYItem} // "ceBC"
    public var backgroundFillType: KEYItem {return self.property(0x626b6674) as! KEYItem} // "bkft"
    public var baseSlide: KEYItem {return self.property(0x736d6173) as! KEYItem} // "smas"
    public var bodyShowing: KEYItem {return self.property(0x4b627368) as! KEYItem} // "Kbsh"
    public var borders: KEYItem {return self.property(0x4b787062) as! KEYItem} // "Kxpb"
    public var bounds: KEYItem {return self.property(0x70626e64) as! KEYItem} // "pbnd"
    public var cellRange: KEYItem {return self.property(0x4e4d5463) as! KEYItem} // "NMTc"
    public var class_: KEYItem {return self.property(0x70636c73) as! KEYItem} // "pcls"
    public var clipVolume: KEYItem {return self.property(0x61766f6c) as! KEYItem} // "avol"
    public var closeable: KEYItem {return self.property(0x68636c62) as! KEYItem} // "hclb"
    public var collating: KEYItem {return self.property(0x6c77636c) as! KEYItem} // "lwcl"
    public var color: KEYItem {return self.property(0x636f6c72) as! KEYItem} // "colr"
    public var column: KEYItem {return self.property(0x4e4d436f) as! KEYItem} // "NMCo"
    public var columnCount: KEYItem {return self.property(0x4e6d5463) as! KEYItem} // "NmTc"
    public var compressionFactor: KEYItem {return self.property(0x4b786963) as! KEYItem} // "Kxic"
    public var copies: KEYItem {return self.property(0x6c776370) as! KEYItem} // "lwcp"
    public var currentSlide: KEYItem {return self.property(0x6372736c) as! KEYItem} // "crsl"
    public var date_: KEYItem {return self.property(0x4b787064) as! KEYItem} // "Kxpd"
    public var defaultBodyItem: KEYItem {return self.property(0x73646269) as! KEYItem} // "sdbi"
    public var defaultTitleItem: KEYItem {return self.property(0x73647469) as! KEYItem} // "sdti"
    public var description_: KEYItem {return self.property(0x64736372) as! KEYItem} // "dscr"
    public var document: KEYItem {return self.property(0x646f6375) as! KEYItem} // "docu"
    public var documentTheme: KEYItem {return self.property(0x4b6e6474) as! KEYItem} // "Kndt"
    public var endingPage: KEYItem {return self.property(0x6c776c70) as! KEYItem} // "lwlp"
    public var endPoint: KEYItem {return self.property(0x6c6e6570) as! KEYItem} // "lnep"
    public var errorHandling: KEYItem {return self.property(0x6c776568) as! KEYItem} // "lweh"
    public var exportStyle: KEYItem {return self.property(0x4b787077) as! KEYItem} // "Kxpw"
    public var faxNumber: KEYItem {return self.property(0x6661786e) as! KEYItem} // "faxn"
    public var file: KEYItem {return self.property(0x66696c65) as! KEYItem} // "file"
    public var fileName: KEYItem {return self.property(0x6174666e) as! KEYItem} // "atfn"
    public var font: KEYItem {return self.property(0x666f6e74) as! KEYItem} // "font"
    public var fontName: KEYItem {return self.property(0x4e4d666e) as! KEYItem} // "NMfn"
    public var fontSize: KEYItem {return self.property(0x4e4d6673) as! KEYItem} // "NMfs"
    public var footerRowCount: KEYItem {return self.property(0x4e6d4672) as! KEYItem} // "NmFr"
    public var format: KEYItem {return self.property(0x4e4d4354) as! KEYItem} // "NMCT"
    public var formattedValue: KEYItem {return self.property(0x4e4d6676) as! KEYItem} // "NMfv"
    public var formula: KEYItem {return self.property(0x4e4d4366) as! KEYItem} // "NMCf"
    public var frontmost: KEYItem {return self.property(0x70697366) as! KEYItem} // "pisf"
    public var frozen: KEYItem {return self.property(0x46727a6e) as! KEYItem} // "Frzn"
    public var headerColumnCount: KEYItem {return self.property(0x4e6d4843) as! KEYItem} // "NmHC"
    public var headerRowCount: KEYItem {return self.property(0x4e6d4872) as! KEYItem} // "NmHr"
    public var height: KEYItem {return self.property(0x73697468) as! KEYItem} // "sith"
    public var id: KEYItem {return self.property(0x49442020) as! KEYItem} // "ID\0x20\0x20"
    public var imageFormat: KEYItem {return self.property(0x4b786966) as! KEYItem} // "Kxif"
    public var index: KEYItem {return self.property(0x70696478) as! KEYItem} // "pidx"
    public var locked: KEYItem {return self.property(0x704c636b) as! KEYItem} // "pLck"
    public var maximumIdleDuration: KEYItem {return self.property(0x6d696472) as! KEYItem} // "midr"
    public var miniaturizable: KEYItem {return self.property(0x69736d6e) as! KEYItem} // "ismn"
    public var miniaturized: KEYItem {return self.property(0x706d6e64) as! KEYItem} // "pmnd"
    public var modified: KEYItem {return self.property(0x696d6f64) as! KEYItem} // "imod"
    public var movieFormat: KEYItem {return self.property(0x4b786d66) as! KEYItem} // "Kxmf"
    public var movieVolume: KEYItem {return self.property(0x6d766f6c) as! KEYItem} // "mvol"
    public var name: KEYItem {return self.property(0x706e616d) as! KEYItem} // "pnam"
    public var objectText: KEYItem {return self.property(0x70445478) as! KEYItem} // "pDTx"
    public var opacity: KEYItem {return self.property(0x70534f70) as! KEYItem} // "pSOp"
    public var pagesAcross: KEYItem {return self.property(0x6c776c61) as! KEYItem} // "lwla"
    public var pagesDown: KEYItem {return self.property(0x6c776c64) as! KEYItem} // "lwld"
    public var parent: KEYItem {return self.property(0x73697074) as! KEYItem} // "sipt"
    public var password: KEYItem {return self.property(0x4b785057) as! KEYItem} // "KxPW"
    public var passwordHint: KEYItem {return self.property(0x4b785048) as! KEYItem} // "KxPH"
    public var PDFImageQuality: KEYItem {return self.property(0x4b785049) as! KEYItem} // "KxPI"
    public var playing: KEYItem {return self.property(0x506c6e67) as! KEYItem} // "Plng"
    public var position: KEYItem {return self.property(0x7369706f) as! KEYItem} // "sipo"
    public var presenterNotes: KEYItem {return self.property(0x6b736e74) as! KEYItem} // "ksnt"
    public var properties: KEYItem {return self.property(0x70414c4c) as! KEYItem} // "pALL"
    public var rawKPF: KEYItem {return self.property(0x4b786b66) as! KEYItem} // "Kxkf"
    public var reflectionShowing: KEYItem {return self.property(0x73697273) as! KEYItem} // "sirs"
    public var reflectionValue: KEYItem {return self.property(0x73697276) as! KEYItem} // "sirv"
    public var repetitionMethod: KEYItem {return self.property(0x6d767270) as! KEYItem} // "mvrp"
    public var requestedPrintTime: KEYItem {return self.property(0x6c777174) as! KEYItem} // "lwqt"
    public var resizable: KEYItem {return self.property(0x7072737a) as! KEYItem} // "prsz"
    public var rotation_: KEYItem {return self.property(0x7369726f) as! KEYItem} // "siro"
    public var row: KEYItem {return self.property(0x4e4d5277) as! KEYItem} // "NMRw"
    public var rowCount: KEYItem {return self.property(0x4e6d5472) as! KEYItem} // "NmTr"
    public var selectionRange: KEYItem {return self.property(0x4e4d5473) as! KEYItem} // "NMTs"
    public var size: KEYItem {return self.property(0x7074737a) as! KEYItem} // "ptsz"
    public var skipped: KEYItem {return self.property(0x4b736b70) as! KEYItem} // "Kskp"
    public var skippedSlides: KEYItem {return self.property(0x4b787073) as! KEYItem} // "Kxps"
    public var slideNumber: KEYItem {return self.property(0x4b53644e) as! KEYItem} // "KSdN"
    public var slideNumbers: KEYItem {return self.property(0x4b78706e) as! KEYItem} // "Kxpn"
    public var slideNumbersShowing: KEYItem {return self.property(0x4b6e7368) as! KEYItem} // "Knsh"
    public var slideSwitcherVisible: KEYItem {return self.property(0x53737673) as! KEYItem} // "Ssvs"
    public var startingPage: KEYItem {return self.property(0x6c776670) as! KEYItem} // "lwfp"
    public var startPoint: KEYItem {return self.property(0x6c6e7370) as! KEYItem} // "lnsp"
    public var targetPrinter: KEYItem {return self.property(0x74727072) as! KEYItem} // "trpr"
    public var textColor: KEYItem {return self.property(0x74657843) as! KEYItem} // "texC"
    public var textWrap: KEYItem {return self.property(0x77726170) as! KEYItem} // "wrap"
    public var titleShowing: KEYItem {return self.property(0x4b747368) as! KEYItem} // "Ktsh"
    public var transitionDelay: KEYItem {return self.property(0x78646c79) as! KEYItem} // "xdly"
    public var transitionDuration: KEYItem {return self.property(0x78647572) as! KEYItem} // "xdur"
    public var transitionEffect: KEYItem {return self.property(0x78656674) as! KEYItem} // "xeft"
    public var transitionProperties: KEYItem {return self.property(0x7374726e) as! KEYItem} // "strn"
    public var value: KEYItem {return self.property(0x4e4d4376) as! KEYItem} // "NMCv"
    public var version: KEYItem {return self.property(0x76657273) as! KEYItem} // "vers"
    public var verticalAlignment: KEYItem {return self.property(0x74785641) as! KEYItem} // "txVA"
    public var visible: KEYItem {return self.property(0x70766973) as! KEYItem} // "pvis"
    public var width: KEYItem {return self.property(0x73697477) as! KEYItem} // "sitw"
    public var zoomable: KEYItem {return self.property(0x69737a6d) as! KEYItem} // "iszm"
    public var zoomed: KEYItem {return self.property(0x707a756d) as! KEYItem} // "pzum"

    // Elements
    public var applications: KEYItems {return self.elements(0x63617070) as! KEYItems} // "capp"
    public var audioClips: KEYItems {return self.elements(0x73686175) as! KEYItems} // "shau"
    public var cells: KEYItems {return self.elements(0x4e6d436c) as! KEYItems} // "NmCl"
    public var characters: KEYItems {return self.elements(0x63686120) as! KEYItems} // "cha\0x20"
    public var charts: KEYItems {return self.elements(0x73686374) as! KEYItems} // "shct"
    public var columns: KEYItems {return self.elements(0x4e4d436f) as! KEYItems} // "NMCo"
    public var documents: KEYItems {return self.elements(0x646f6375) as! KEYItems} // "docu"
    public var groups: KEYItems {return self.elements(0x69677270) as! KEYItems} // "igrp"
    public var images: KEYItems {return self.elements(0x696d6167) as! KEYItems} // "imag"
    public var items: KEYItems {return self.elements(0x636f626a) as! KEYItems} // "cobj"
    public var iWorkContainers: KEYItems {return self.elements(0x69776b63) as! KEYItems} // "iwkc"
    public var iWorkItems: KEYItems {return self.elements(0x666d7469) as! KEYItems} // "fmti"
    public var lines: KEYItems {return self.elements(0x69576c6e) as! KEYItems} // "iWln"
    public var masterSlides: KEYItems {return self.elements(0x4b6e4d73) as! KEYItems} // "KnMs"
    public var movies: KEYItems {return self.elements(0x73686d76) as! KEYItems} // "shmv"
    public var paragraphs: KEYItems {return self.elements(0x63706172) as! KEYItems} // "cpar"
    public var ranges: KEYItems {return self.elements(0x4e6d4352) as! KEYItems} // "NmCR"
    public var richText: KEYItems {return self.elements(0x72747874) as! KEYItems} // "rtxt"
    public var rows: KEYItems {return self.elements(0x4e4d5277) as! KEYItems} // "NMRw"
    public var shapes: KEYItems {return self.elements(0x73736870) as! KEYItems} // "sshp"
    public var slides: KEYItems {return self.elements(0x4b6e5364) as! KEYItems} // "KnSd"
    public var tables: KEYItems {return self.elements(0x4e6d5462) as! KEYItems} // "NmTb"
    public var textItems: KEYItems {return self.elements(0x73687478) as! KEYItems} // "shtx"
    public var themes: KEYItems {return self.elements(0x4b6e7468) as! KEYItems} // "Knth"
    public var windows: KEYItems {return self.elements(0x6377696e) as! KEYItems} // "cwin"
    public var words: KEYItems {return self.elements(0x63776f72) as! KEYItems} // "cwor"
}


/******************************************************************************/
// Specifier subclasses add app-specific extensions

// beginning/end/before/after
public class KEYInsertion: SwiftAutomation.InsertionSpecifier, KEYCommand {}


// property/by-index/by-name/by-id/previous/next/first/middle/last/any
public class KEYItem: SwiftAutomation.ObjectSpecifier, KEYObject {
    public typealias InsertionSpecifierType = KEYInsertion
    public typealias ObjectSpecifierType = KEYItem
    public typealias MultipleObjectSpecifierType = KEYItems
}

// by-range/by-test/all
public class KEYItems: KEYItem, SwiftAutomation.MultipleObjectSpecifierExtension {}

// App/Con/Its
public class KEYRoot: SwiftAutomation.RootSpecifier, KEYObject, SwiftAutomation.RootSpecifierExtension {
    public typealias InsertionSpecifierType = KEYInsertion
    public typealias ObjectSpecifierType = KEYItem
    public typealias MultipleObjectSpecifierType = KEYItems
    public override class var untargetedAppData: SwiftAutomation.AppData { return _untargetedAppData }
}

// Application
public class Keynote: KEYRoot, SwiftAutomation.Application {
    public convenience init(launchOptions: SwiftAutomation.LaunchOptions = SwiftAutomation.DefaultLaunchOptions, relaunchMode: SwiftAutomation.RelaunchMode = SwiftAutomation.DefaultRelaunchMode) {
        self.init(rootObject: SwiftAutomation.AppRootDesc, appData: Swift.type(of:self).untargetedAppData.targetedCopy(
                  .bundleIdentifier("com.apple.iWork.Keynote", true), launchOptions: launchOptions, relaunchMode: relaunchMode))
    }
}

// App/Con/Its root objects used to construct untargeted specifiers; these can be used to construct specifiers for use in commands, though cannot send commands themselves

public let KEYApp = _untargetedAppData.app as! KEYRoot
public let KEYCon = _untargetedAppData.con as! KEYRoot
public let KEYIts = _untargetedAppData.its as! KEYRoot


/******************************************************************************/
// Static types

public typealias KEYRecord = [KEYSymbol:Any] // default Swift type for AERecordDescs







