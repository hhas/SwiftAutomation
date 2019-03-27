//
//  NumbersGlue.swift
//  Numbers.app 5.3
//  SwiftAutomation.framework 0.1.0
//  `aeglue -S 'Numbers.app'`
//


import Foundation
import SwiftAutomation


/******************************************************************************/
// Create an untargeted AppData instance for use in App, Con, Its roots,
// and in Application initializers to create targeted AppData instances.

private let _specifierFormatter = SwiftAutomation.SpecifierFormatter(applicationClassName: "Numbers",
                                                     classNamePrefix: "NUM",
                                                     typeNames: [
                                                                     0x4e6d4153: "activeSheet", // "NmAS"
                                                                     0x4e4d6164: "address", // "NMad"
                                                                     0x66696167: "advancedGradientFill", // "fiag"
                                                                     0x66696169: "advancedImageFill", // "fiai"
                                                                     0x616c6973: "alias", // "alis"
                                                                     0x74657841: "alignment", // "texA"
                                                                     0x2a2a2a2a: "anything", // "****"
                                                                     0x63617070: "application", // "capp"
                                                                     0x62756e64: "applicationBundleID", // "bund"
                                                                     0x7369676e: "applicationSignature", // "sign"
                                                                     0x6170726c: "applicationURL", // "aprl"
                                                                     0x61707220: "April", // "apr\0x20"
                                                                     0x6173636e: "ascending", // "ascn"
                                                                     0x61736b20: "ask", // "ask\0x20"
                                                                     0x73686175: "audioClip", // "shau"
                                                                     0x61756720: "August", // "aug\0x20"
                                                                     0x61617574: "autoAlign", // "aaut"
                                                                     0x66617574: "automatic", // "faut"
                                                                     0x63654243: "backgroundColor", // "ceBC"
                                                                     0x626b6674: "backgroundFillType", // "bkft"
                                                                     0x4b6e5032: "Best", // "KnP2"
                                                                     0x62657374: "best", // "best"
                                                                     0x4b6e5031: "Better", // "KnP1"
                                                                     0x626d726b: "bookmarkData", // "bmrk"
                                                                     0x626f6f6c: "boolean", // "bool"
                                                                     0x61766274: "bottom", // "avbt"
                                                                     0x71647274: "boundingRectangle", // "qdrt"
                                                                     0x70626e64: "bounds", // "pbnd"
                                                                     0x63617365: "case_", // "case"
                                                                     0x4e6d436c: "cell", // "NmCl"
                                                                     0x4e4d5463: "cellRange", // "NMTc"
                                                                     0x61637472: "center", // "actr"
                                                                     0x63686120: "character", // "cha\0x20"
                                                                     0x73686374: "chart", // "shct"
                                                                     0x66636368: "checkbox", // "fcch"
                                                                     0x70636c73: "class_", // "pcls"
                                                                     0x61766f6c: "clipVolume", // "avol"
                                                                     0x68636c62: "closeable", // "hclb"
                                                                     0x6c77636c: "collating", // "lwcl"
                                                                     0x636f6c72: "color", // "colr"
                                                                     0x6669636f: "colorFill", // "fico"
                                                                     0x636c7274: "colorTable", // "clrt"
                                                                     0x4e4d436f: "column", // "NMCo"
                                                                     0x4e6d5463: "columnCount", // "NmTc"
                                                                     0x656e756d: "constant", // "enum"
                                                                     0x6c776370: "copies", // "lwcp"
                                                                     0x4e637376: "CSV", // "Ncsv"
                                                                     0x66637572: "currency", // "fcur"
                                                                     0x74646173: "dashStyle", // "tdas"
                                                                     0x74647461: "data", // "tdta"
                                                                     0x6c647420: "date", // "ldt\0x20"
                                                                     0x6664746d: "dateAndTime", // "fdtm"
                                                                     0x64656320: "December", // "dec\0x20"
                                                                     0x6465636d: "decimalStruct", // "decm"
                                                                     0x6473636e: "descending", // "dscn"
                                                                     0x64736372: "description_", // "dscr"
                                                                     0x6c776474: "detailed", // "lwdt"
                                                                     0x64696163: "diacriticals", // "diac"
                                                                     0x646f6375: "document", // "docu"
                                                                     0x546d706c: "documentTemplate", // "Tmpl"
                                                                     0x636f6d70: "doubleInteger", // "comp"
                                                                     0x66647572: "duration", // "fdur"
                                                                     0x656e6373: "encodedString", // "encs"
                                                                     0x6c776c70: "endingPage", // "lwlp"
                                                                     0x6c6e6570: "endPoint", // "lnep"
                                                                     0x45505320: "EPSPicture", // "EPS\0x20"
                                                                     0x6c776568: "errorHandling", // "lweh"
                                                                     0x4e784553: "excludeSummaryWorksheet", // "NxES"
                                                                     0x65787061: "expansion", // "expa"
                                                                     0x4e786f70: "exportOptions", // "Nxop"
                                                                     0x65787465: "extendedReal", // "exte"
                                                                     0x6661786e: "faxNumber", // "faxn"
                                                                     0x66656220: "February", // "feb\0x20"
                                                                     0x66696c65: "file", // "file"
                                                                     0x6174666e: "fileName", // "atfn"
                                                                     0x66737266: "fileRef", // "fsrf"
                                                                     0x66737320: "fileSpecification", // "fss\0x20"
                                                                     0x6675726c: "fileURL", // "furl"
                                                                     0x4e4d5466: "filtered", // "NMTf"
                                                                     0x66697864: "fixed", // "fixd"
                                                                     0x66706e74: "fixedPoint", // "fpnt"
                                                                     0x66726374: "fixedRectangle", // "frct"
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
                                                                     0x47494666: "GIFPicture", // "GIFf"
                                                                     0x4b6e5030: "Good", // "KnP0"
                                                                     0x66696772: "gradientFill", // "figr"
                                                                     0x63677478: "graphicText", // "cgtx"
                                                                     0x69677270: "group", // "igrp"
                                                                     0x4e6d4843: "headerColumnCount", // "NmHC"
                                                                     0x4e6d4643: "headerColumnsFrozen", // "NmFC"
                                                                     0x4e6d4872: "headerRowCount", // "NmHr"
                                                                     0x4e6d4648: "headerRowsFrozen", // "NmFH"
                                                                     0x73697468: "height", // "sith"
                                                                     0x68797068: "hyphens", // "hyph"
                                                                     0x49442020: "id", // "ID\0x20\0x20"
                                                                     0x696d6167: "image", // "imag"
                                                                     0x6669696d: "imageFill", // "fiim"
                                                                     0x4e785049: "imageQuality", // "NxPI"
                                                                     0x70696478: "index", // "pidx"
                                                                     0x6c6f6e67: "integer", // "long"
                                                                     0x69747874: "internationalText", // "itxt"
                                                                     0x696e746c: "internationalWritingCode", // "intl"
                                                                     0x636f626a: "item", // "cobj"
                                                                     0x69776b63: "iWorkContainer", // "iwkc"
                                                                     0x666d7469: "iWorkItem", // "fmti"
                                                                     0x6a616e20: "January", // "jan\0x20"
                                                                     0x4a504547: "JPEGPicture", // "JPEG"
                                                                     0x6a756c20: "July", // "jul\0x20"
                                                                     0x6a756e20: "June", // "jun\0x20"
                                                                     0x616a7374: "justify", // "ajst"
                                                                     0x6b706964: "kernelProcessID", // "kpid"
                                                                     0x6c64626c: "largeReal", // "ldbl"
                                                                     0x616c6674: "left", // "alft"
                                                                     0x69576c6e: "line", // "iWln"
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
                                                                     0x6d617220: "March", // "mar\0x20"
                                                                     0x6d617920: "May", // "may\0x20"
                                                                     0x4e65786c: "MicrosoftExcel", // "Nexl"
                                                                     0x69736d6e: "miniaturizable", // "ismn"
                                                                     0x706d6e64: "miniaturized", // "pmnd"
                                                                     0x696d6f64: "modified", // "imod"
                                                                     0x6d6f6e20: "Monday", // "mon\0x20"
                                                                     0x73686d76: "movie", // "shmv"
                                                                     0x6d766f6c: "movieVolume", // "mvol"
                                                                     0x706e616d: "name", // "pnam"
                                                                     0x6e6f2020: "no", // "no\0x20\0x20"
                                                                     0x66696e6f: "noFill", // "fino"
                                                                     0x6d76726e: "none", // "mvrn"
                                                                     0x6e6f7620: "November", // "nov\0x20"
                                                                     0x6e756c6c: "null", // "null"
                                                                     0x6e6d6272: "number", // "nmbr"
                                                                     0x4e756666: "Numbers", // "Nuff"
                                                                     0x4e6e6d62: "Numbers09", // "Nnmb"
                                                                     0x66636e73: "numeralSystem", // "fcns"
                                                                     0x6e756d65: "numericStrings", // "nume"
                                                                     0x70445478: "objectText", // "pDTx"
                                                                     0x6f637420: "October", // "oct\0x20"
                                                                     0x70534f70: "opacity", // "pSOp"
                                                                     0x6c776c61: "pagesAcross", // "lwla"
                                                                     0x6c776c64: "pagesDown", // "lwld"
                                                                     0x63706172: "paragraph", // "cpar"
                                                                     0x73697074: "parent", // "sipt"
                                                                     0x4e785057: "password", // "NxPW"
                                                                     0x4e785048: "passwordHint", // "NxPH"
                                                                     0x4e706466: "PDF", // "Npdf"
                                                                     0x66706572: "percent", // "fper"
                                                                     0x50494354: "PICTPicture", // "PICT"
                                                                     0x74706d6d: "pixelMapRecord", // "tpmm"
                                                                     0x51447074: "point", // "QDpt"
                                                                     0x66637070: "popUpMenu", // "fcpp"
                                                                     0x7369706f: "position", // "sipo"
                                                                     0x70736574: "printSettings", // "pset"
                                                                     0x70736e20: "processSerialNumber", // "psn\0x20"
                                                                     0x70414c4c: "properties", // "pALL"
                                                                     0x70726f70: "property_", // "prop"
                                                                     0x70756e63: "punctuation", // "punc"
                                                                     0x4e6d4352: "range", // "NmCR"
                                                                     0x66726174: "rating", // "frat"
                                                                     0x646f7562: "real", // "doub"
                                                                     0x7265636f: "record", // "reco"
                                                                     0x6f626a20: "reference", // "obj\0x20"
                                                                     0x73697273: "reflectionShowing", // "sirs"
                                                                     0x73697276: "reflectionValue", // "sirv"
                                                                     0x6d767270: "repetitionMethod", // "mvrp"
                                                                     0x6c777174: "requestedPrintTime", // "lwqt"
                                                                     0x7072737a: "resizable", // "prsz"
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
                                                                     0x66736369: "scientific", // "fsci"
                                                                     0x73637074: "script", // "scpt"
                                                                     0x4e4d5473: "selectionRange", // "NMTs"
                                                                     0x73657020: "September", // "sep\0x20"
                                                                     0x73736870: "shape", // "sshp"
                                                                     0x4e6d5368: "sheet", // "NmSh"
                                                                     0x73686f72: "shortInteger", // "shor"
                                                                     0x7074737a: "size", // "ptsz"
                                                                     0x6663736c: "slider", // "fcsl"
                                                                     0x73696e67: "smallReal", // "sing"
                                                                     0x6c777374: "standard", // "lwst"
                                                                     0x6c776670: "startingPage", // "lwfp"
                                                                     0x6c6e7370: "startPoint", // "lnsp"
                                                                     0x66637374: "stepper", // "fcst"
                                                                     0x54455854: "string", // "TEXT"
                                                                     0x7374796c: "styledClipboardText", // "styl"
                                                                     0x53545854: "styledText", // "STXT"
                                                                     0x73756e20: "Sunday", // "sun\0x20"
                                                                     0x4e6d5462: "table", // "NmTb"
                                                                     0x74727072: "targetPrinter", // "trpr"
                                                                     0x746d706c: "template", // "tmpl"
                                                                     0x63747874: "text", // "ctxt"
                                                                     0x74657843: "textColor", // "texC"
                                                                     0x73687478: "textItem", // "shtx"
                                                                     0x74737479: "textStyleInfo", // "tsty"
                                                                     0x77726170: "textWrap", // "wrap"
                                                                     0x74687520: "Thursday", // "thu\0x20"
                                                                     0x54494646: "TIFFPicture", // "TIFF"
                                                                     0x61767470: "top", // "avtp"
                                                                     0x74756520: "Tuesday", // "tue\0x20"
                                                                     0x74797065: "typeClass", // "type"
                                                                     0x75747874: "UnicodeText", // "utxt"
                                                                     0x75636f6d: "unsignedDoubleInteger", // "ucom"
                                                                     0x6d61676e: "unsignedInteger", // "magn"
                                                                     0x75736872: "unsignedShortInteger", // "ushr"
                                                                     0x75743136: "UTF16Text", // "ut16"
                                                                     0x75746638: "UTF8Text", // "utf8"
                                                                     0x4e4d4376: "value", // "NMCv"
                                                                     0x76657273: "version", // "vers"
                                                                     0x74785641: "verticalAlignment", // "txVA"
                                                                     0x70766973: "visible", // "pvis"
                                                                     0x77656420: "Wednesday", // "wed\0x20"
                                                                     0x77686974: "whitespace", // "whit"
                                                                     0x73697477: "width", // "sitw"
                                                                     0x6377696e: "window", // "cwin"
                                                                     0x63776f72: "word", // "cwor"
                                                                     0x70736374: "writingCode", // "psct"
                                                                     0x79657320: "yes", // "yes\0x20"
                                                                     0x69737a6d: "zoomable", // "iszm"
                                                                     0x707a756d: "zoomed", // "pzum"
                                                     ],
                                                     propertyNames: [
                                                                     0x4e6d4153: "activeSheet", // "NmAS"
                                                                     0x4e4d6164: "address", // "NMad"
                                                                     0x74657841: "alignment", // "texA"
                                                                     0x63654243: "backgroundColor", // "ceBC"
                                                                     0x626b6674: "backgroundFillType", // "bkft"
                                                                     0x70626e64: "bounds", // "pbnd"
                                                                     0x4e4d5463: "cellRange", // "NMTc"
                                                                     0x70636c73: "class_", // "pcls"
                                                                     0x61766f6c: "clipVolume", // "avol"
                                                                     0x68636c62: "closeable", // "hclb"
                                                                     0x6c77636c: "collating", // "lwcl"
                                                                     0x636f6c72: "color", // "colr"
                                                                     0x4e4d436f: "column", // "NMCo"
                                                                     0x4e6d5463: "columnCount", // "NmTc"
                                                                     0x6c776370: "copies", // "lwcp"
                                                                     0x64736372: "description_", // "dscr"
                                                                     0x646f6375: "document", // "docu"
                                                                     0x546d706c: "documentTemplate", // "Tmpl"
                                                                     0x6c776c70: "endingPage", // "lwlp"
                                                                     0x6c6e6570: "endPoint", // "lnep"
                                                                     0x6c776568: "errorHandling", // "lweh"
                                                                     0x4e784553: "excludeSummaryWorksheet", // "NxES"
                                                                     0x6661786e: "faxNumber", // "faxn"
                                                                     0x66696c65: "file", // "file"
                                                                     0x6174666e: "fileName", // "atfn"
                                                                     0x4e4d5466: "filtered", // "NMTf"
                                                                     0x666f6e74: "font", // "font"
                                                                     0x4e4d666e: "fontName", // "NMfn"
                                                                     0x4e4d6673: "fontSize", // "NMfs"
                                                                     0x4e6d4672: "footerRowCount", // "NmFr"
                                                                     0x4e4d4354: "format", // "NMCT"
                                                                     0x4e4d6676: "formattedValue", // "NMfv"
                                                                     0x4e4d4366: "formula", // "NMCf"
                                                                     0x70697366: "frontmost", // "pisf"
                                                                     0x4e6d4843: "headerColumnCount", // "NmHC"
                                                                     0x4e6d4643: "headerColumnsFrozen", // "NmFC"
                                                                     0x4e6d4872: "headerRowCount", // "NmHr"
                                                                     0x4e6d4648: "headerRowsFrozen", // "NmFH"
                                                                     0x73697468: "height", // "sith"
                                                                     0x49442020: "id", // "ID\0x20\0x20"
                                                                     0x4e785049: "imageQuality", // "NxPI"
                                                                     0x70696478: "index", // "pidx"
                                                                     0x704c636b: "locked", // "pLck"
                                                                     0x69736d6e: "miniaturizable", // "ismn"
                                                                     0x706d6e64: "miniaturized", // "pmnd"
                                                                     0x696d6f64: "modified", // "imod"
                                                                     0x6d766f6c: "movieVolume", // "mvol"
                                                                     0x706e616d: "name", // "pnam"
                                                                     0x70445478: "objectText", // "pDTx"
                                                                     0x70534f70: "opacity", // "pSOp"
                                                                     0x6c776c61: "pagesAcross", // "lwla"
                                                                     0x6c776c64: "pagesDown", // "lwld"
                                                                     0x73697074: "parent", // "sipt"
                                                                     0x4e785057: "password", // "NxPW"
                                                                     0x4e785048: "passwordHint", // "NxPH"
                                                                     0x7369706f: "position", // "sipo"
                                                                     0x70414c4c: "properties", // "pALL"
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
                                                                     0x6c776670: "startingPage", // "lwfp"
                                                                     0x6c6e7370: "startPoint", // "lnsp"
                                                                     0x74727072: "targetPrinter", // "trpr"
                                                                     0x74657843: "textColor", // "texC"
                                                                     0x77726170: "textWrap", // "wrap"
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
                                                                     0x73686d76: ("movie", "movies"), // "shmv"
                                                                     0x63706172: ("paragraph", "paragraphs"), // "cpar"
                                                                     0x4e6d4352: ("range", "ranges"), // "NmCR"
                                                                     0x72747874: ("rich text", "richText"), // "rtxt"
                                                                     0x4e4d5277: ("row", "rows"), // "NMRw"
                                                                     0x73736870: ("shape", "shapes"), // "sshp"
                                                                     0x4e6d5368: ("sheet", "sheets"), // "NmSh"
                                                                     0x4e6d5462: ("table", "tables"), // "NmTb"
                                                                     0x746d706c: ("template", "templates"), // "tmpl"
                                                                     0x73687478: ("text item", "textItems"), // "shtx"
                                                                     0x6377696e: ("window", "windows"), // "cwin"
                                                                     0x63776f72: ("word", "words"), // "cwor"
                                                     ])

private let _glueClasses = SwiftAutomation.GlueClasses(insertionSpecifierType: NUMInsertion.self,
                                       objectSpecifierType: NUMItem.self,
                                       multiObjectSpecifierType: NUMItems.self,
                                       rootSpecifierType: NUMRoot.self,
                                       applicationType: Numbers.self,
                                       symbolType: NUMSymbol.self,
                                       formatter: _specifierFormatter)

private let _untargetedAppData = SwiftAutomation.AppData(glueClasses: _glueClasses)


/******************************************************************************/
// Symbol subclass defines static type/enum/property constants based on Numbers.app terminology

public class NUMSymbol: SwiftAutomation.Symbol {

    override public var typeAliasName: String {return "NUM"}

    public override class func symbol(code: OSType, type: OSType = typeType, descriptor: NSAppleEventDescriptor? = nil) -> NUMSymbol {
        switch (code) {
        case 0x4e6d4153: return self.activeSheet // "NmAS"
        case 0x4e4d6164: return self.address // "NMad"
        case 0x66696167: return self.advancedGradientFill // "fiag"
        case 0x66696169: return self.advancedImageFill // "fiai"
        case 0x616c6973: return self.alias // "alis"
        case 0x74657841: return self.alignment // "texA"
        case 0x2a2a2a2a: return self.anything // "****"
        case 0x63617070: return self.application // "capp"
        case 0x62756e64: return self.applicationBundleID // "bund"
        case 0x7369676e: return self.applicationSignature // "sign"
        case 0x6170726c: return self.applicationURL // "aprl"
        case 0x61707220: return self.April // "apr\0x20"
        case 0x6173636e: return self.ascending // "ascn"
        case 0x61736b20: return self.ask // "ask\0x20"
        case 0x73686175: return self.audioClip // "shau"
        case 0x61756720: return self.August // "aug\0x20"
        case 0x61617574: return self.autoAlign // "aaut"
        case 0x66617574: return self.automatic // "faut"
        case 0x63654243: return self.backgroundColor // "ceBC"
        case 0x626b6674: return self.backgroundFillType // "bkft"
        case 0x4b6e5032: return self.Best // "KnP2"
        case 0x62657374: return self.best // "best"
        case 0x4b6e5031: return self.Better // "KnP1"
        case 0x626d726b: return self.bookmarkData // "bmrk"
        case 0x626f6f6c: return self.boolean // "bool"
        case 0x61766274: return self.bottom // "avbt"
        case 0x71647274: return self.boundingRectangle // "qdrt"
        case 0x70626e64: return self.bounds // "pbnd"
        case 0x63617365: return self.case_ // "case"
        case 0x4e6d436c: return self.cell // "NmCl"
        case 0x4e4d5463: return self.cellRange // "NMTc"
        case 0x61637472: return self.center // "actr"
        case 0x63686120: return self.character // "cha\0x20"
        case 0x73686374: return self.chart // "shct"
        case 0x66636368: return self.checkbox // "fcch"
        case 0x70636c73: return self.class_ // "pcls"
        case 0x61766f6c: return self.clipVolume // "avol"
        case 0x68636c62: return self.closeable // "hclb"
        case 0x6c77636c: return self.collating // "lwcl"
        case 0x636f6c72: return self.color // "colr"
        case 0x6669636f: return self.colorFill // "fico"
        case 0x636c7274: return self.colorTable // "clrt"
        case 0x4e4d436f: return self.column // "NMCo"
        case 0x4e6d5463: return self.columnCount // "NmTc"
        case 0x656e756d: return self.constant // "enum"
        case 0x6c776370: return self.copies // "lwcp"
        case 0x4e637376: return self.CSV // "Ncsv"
        case 0x66637572: return self.currency // "fcur"
        case 0x74646173: return self.dashStyle // "tdas"
        case 0x74647461: return self.data // "tdta"
        case 0x6c647420: return self.date // "ldt\0x20"
        case 0x6664746d: return self.dateAndTime // "fdtm"
        case 0x64656320: return self.December // "dec\0x20"
        case 0x6465636d: return self.decimalStruct // "decm"
        case 0x6473636e: return self.descending // "dscn"
        case 0x64736372: return self.description_ // "dscr"
        case 0x6c776474: return self.detailed // "lwdt"
        case 0x64696163: return self.diacriticals // "diac"
        case 0x646f6375: return self.document // "docu"
        case 0x546d706c: return self.documentTemplate // "Tmpl"
        case 0x636f6d70: return self.doubleInteger // "comp"
        case 0x66647572: return self.duration // "fdur"
        case 0x656e6373: return self.encodedString // "encs"
        case 0x6c776c70: return self.endingPage // "lwlp"
        case 0x6c6e6570: return self.endPoint // "lnep"
        case 0x45505320: return self.EPSPicture // "EPS\0x20"
        case 0x6c776568: return self.errorHandling // "lweh"
        case 0x4e784553: return self.excludeSummaryWorksheet // "NxES"
        case 0x65787061: return self.expansion // "expa"
        case 0x4e786f70: return self.exportOptions // "Nxop"
        case 0x65787465: return self.extendedReal // "exte"
        case 0x6661786e: return self.faxNumber // "faxn"
        case 0x66656220: return self.February // "feb\0x20"
        case 0x66696c65: return self.file // "file"
        case 0x6174666e: return self.fileName // "atfn"
        case 0x66737266: return self.fileRef // "fsrf"
        case 0x66737320: return self.fileSpecification // "fss\0x20"
        case 0x6675726c: return self.fileURL // "furl"
        case 0x4e4d5466: return self.filtered // "NMTf"
        case 0x66697864: return self.fixed // "fixd"
        case 0x66706e74: return self.fixedPoint // "fpnt"
        case 0x66726374: return self.fixedRectangle // "frct"
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
        case 0x47494666: return self.GIFPicture // "GIFf"
        case 0x4b6e5030: return self.Good // "KnP0"
        case 0x66696772: return self.gradientFill // "figr"
        case 0x63677478: return self.graphicText // "cgtx"
        case 0x69677270: return self.group // "igrp"
        case 0x4e6d4843: return self.headerColumnCount // "NmHC"
        case 0x4e6d4643: return self.headerColumnsFrozen // "NmFC"
        case 0x4e6d4872: return self.headerRowCount // "NmHr"
        case 0x4e6d4648: return self.headerRowsFrozen // "NmFH"
        case 0x73697468: return self.height // "sith"
        case 0x68797068: return self.hyphens // "hyph"
        case 0x49442020: return self.id // "ID\0x20\0x20"
        case 0x696d6167: return self.image // "imag"
        case 0x6669696d: return self.imageFill // "fiim"
        case 0x4e785049: return self.imageQuality // "NxPI"
        case 0x70696478: return self.index // "pidx"
        case 0x6c6f6e67: return self.integer // "long"
        case 0x69747874: return self.internationalText // "itxt"
        case 0x696e746c: return self.internationalWritingCode // "intl"
        case 0x636f626a: return self.item // "cobj"
        case 0x69776b63: return self.iWorkContainer // "iwkc"
        case 0x666d7469: return self.iWorkItem // "fmti"
        case 0x6a616e20: return self.January // "jan\0x20"
        case 0x4a504547: return self.JPEGPicture // "JPEG"
        case 0x6a756c20: return self.July // "jul\0x20"
        case 0x6a756e20: return self.June // "jun\0x20"
        case 0x616a7374: return self.justify // "ajst"
        case 0x6b706964: return self.kernelProcessID // "kpid"
        case 0x6c64626c: return self.largeReal // "ldbl"
        case 0x616c6674: return self.left // "alft"
        case 0x69576c6e: return self.line // "iWln"
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
        case 0x6d617220: return self.March // "mar\0x20"
        case 0x6d617920: return self.May // "may\0x20"
        case 0x4e65786c: return self.MicrosoftExcel // "Nexl"
        case 0x69736d6e: return self.miniaturizable // "ismn"
        case 0x706d6e64: return self.miniaturized // "pmnd"
        case 0x696d6f64: return self.modified // "imod"
        case 0x6d6f6e20: return self.Monday // "mon\0x20"
        case 0x73686d76: return self.movie // "shmv"
        case 0x6d766f6c: return self.movieVolume // "mvol"
        case 0x706e616d: return self.name // "pnam"
        case 0x6e6f2020: return self.no // "no\0x20\0x20"
        case 0x66696e6f: return self.noFill // "fino"
        case 0x6d76726e: return self.none // "mvrn"
        case 0x6e6f7620: return self.November // "nov\0x20"
        case 0x6e756c6c: return self.null // "null"
        case 0x6e6d6272: return self.number // "nmbr"
        case 0x4e756666: return self.Numbers // "Nuff"
        case 0x4e6e6d62: return self.Numbers09 // "Nnmb"
        case 0x66636e73: return self.numeralSystem // "fcns"
        case 0x6e756d65: return self.numericStrings // "nume"
        case 0x70445478: return self.objectText // "pDTx"
        case 0x6f637420: return self.October // "oct\0x20"
        case 0x70534f70: return self.opacity // "pSOp"
        case 0x6c776c61: return self.pagesAcross // "lwla"
        case 0x6c776c64: return self.pagesDown // "lwld"
        case 0x63706172: return self.paragraph // "cpar"
        case 0x73697074: return self.parent // "sipt"
        case 0x4e785057: return self.password // "NxPW"
        case 0x4e785048: return self.passwordHint // "NxPH"
        case 0x4e706466: return self.PDF // "Npdf"
        case 0x66706572: return self.percent // "fper"
        case 0x50494354: return self.PICTPicture // "PICT"
        case 0x74706d6d: return self.pixelMapRecord // "tpmm"
        case 0x51447074: return self.point // "QDpt"
        case 0x66637070: return self.popUpMenu // "fcpp"
        case 0x7369706f: return self.position // "sipo"
        case 0x70736574: return self.printSettings // "pset"
        case 0x70736e20: return self.processSerialNumber // "psn\0x20"
        case 0x70414c4c: return self.properties // "pALL"
        case 0x70726f70: return self.property_ // "prop"
        case 0x70756e63: return self.punctuation // "punc"
        case 0x4e6d4352: return self.range // "NmCR"
        case 0x66726174: return self.rating // "frat"
        case 0x646f7562: return self.real // "doub"
        case 0x7265636f: return self.record // "reco"
        case 0x6f626a20: return self.reference // "obj\0x20"
        case 0x73697273: return self.reflectionShowing // "sirs"
        case 0x73697276: return self.reflectionValue // "sirv"
        case 0x6d767270: return self.repetitionMethod // "mvrp"
        case 0x6c777174: return self.requestedPrintTime // "lwqt"
        case 0x7072737a: return self.resizable // "prsz"
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
        case 0x66736369: return self.scientific // "fsci"
        case 0x73637074: return self.script // "scpt"
        case 0x4e4d5473: return self.selectionRange // "NMTs"
        case 0x73657020: return self.September // "sep\0x20"
        case 0x73736870: return self.shape // "sshp"
        case 0x4e6d5368: return self.sheet // "NmSh"
        case 0x73686f72: return self.shortInteger // "shor"
        case 0x7074737a: return self.size // "ptsz"
        case 0x6663736c: return self.slider // "fcsl"
        case 0x73696e67: return self.smallReal // "sing"
        case 0x6c777374: return self.standard // "lwst"
        case 0x6c776670: return self.startingPage // "lwfp"
        case 0x6c6e7370: return self.startPoint // "lnsp"
        case 0x66637374: return self.stepper // "fcst"
        case 0x54455854: return self.string // "TEXT"
        case 0x7374796c: return self.styledClipboardText // "styl"
        case 0x53545854: return self.styledText // "STXT"
        case 0x73756e20: return self.Sunday // "sun\0x20"
        case 0x4e6d5462: return self.table // "NmTb"
        case 0x74727072: return self.targetPrinter // "trpr"
        case 0x746d706c: return self.template // "tmpl"
        case 0x63747874: return self.text // "ctxt"
        case 0x74657843: return self.textColor // "texC"
        case 0x73687478: return self.textItem // "shtx"
        case 0x74737479: return self.textStyleInfo // "tsty"
        case 0x77726170: return self.textWrap // "wrap"
        case 0x74687520: return self.Thursday // "thu\0x20"
        case 0x54494646: return self.TIFFPicture // "TIFF"
        case 0x61767470: return self.top // "avtp"
        case 0x74756520: return self.Tuesday // "tue\0x20"
        case 0x74797065: return self.typeClass // "type"
        case 0x75747874: return self.UnicodeText // "utxt"
        case 0x75636f6d: return self.unsignedDoubleInteger // "ucom"
        case 0x6d61676e: return self.unsignedInteger // "magn"
        case 0x75736872: return self.unsignedShortInteger // "ushr"
        case 0x75743136: return self.UTF16Text // "ut16"
        case 0x75746638: return self.UTF8Text // "utf8"
        case 0x4e4d4376: return self.value // "NMCv"
        case 0x76657273: return self.version // "vers"
        case 0x74785641: return self.verticalAlignment // "txVA"
        case 0x70766973: return self.visible // "pvis"
        case 0x77656420: return self.Wednesday // "wed\0x20"
        case 0x77686974: return self.whitespace // "whit"
        case 0x73697477: return self.width // "sitw"
        case 0x6377696e: return self.window // "cwin"
        case 0x63776f72: return self.word // "cwor"
        case 0x70736374: return self.writingCode // "psct"
        case 0x79657320: return self.yes // "yes\0x20"
        case 0x69737a6d: return self.zoomable // "iszm"
        case 0x707a756d: return self.zoomed // "pzum"
        default: return super.symbol(code: code, type: type, descriptor: descriptor) as! NUMSymbol
        }
    }

    // Types/properties
    public static let activeSheet = NUMSymbol(name: "activeSheet", code: 0x4e6d4153, type: typeType) // "NmAS"
    public static let address = NUMSymbol(name: "address", code: 0x4e4d6164, type: typeType) // "NMad"
    public static let alias = NUMSymbol(name: "alias", code: 0x616c6973, type: typeType) // "alis"
    public static let alignment = NUMSymbol(name: "alignment", code: 0x74657841, type: typeType) // "texA"
    public static let anything = NUMSymbol(name: "anything", code: 0x2a2a2a2a, type: typeType) // "****"
    public static let application = NUMSymbol(name: "application", code: 0x63617070, type: typeType) // "capp"
    public static let applicationBundleID = NUMSymbol(name: "applicationBundleID", code: 0x62756e64, type: typeType) // "bund"
    public static let applicationSignature = NUMSymbol(name: "applicationSignature", code: 0x7369676e, type: typeType) // "sign"
    public static let applicationURL = NUMSymbol(name: "applicationURL", code: 0x6170726c, type: typeType) // "aprl"
    public static let April = NUMSymbol(name: "April", code: 0x61707220, type: typeType) // "apr\0x20"
    public static let audioClip = NUMSymbol(name: "audioClip", code: 0x73686175, type: typeType) // "shau"
    public static let August = NUMSymbol(name: "August", code: 0x61756720, type: typeType) // "aug\0x20"
    public static let backgroundColor = NUMSymbol(name: "backgroundColor", code: 0x63654243, type: typeType) // "ceBC"
    public static let backgroundFillType = NUMSymbol(name: "backgroundFillType", code: 0x626b6674, type: typeType) // "bkft"
    public static let best = NUMSymbol(name: "best", code: 0x62657374, type: typeType) // "best"
    public static let bookmarkData = NUMSymbol(name: "bookmarkData", code: 0x626d726b, type: typeType) // "bmrk"
    public static let boolean = NUMSymbol(name: "boolean", code: 0x626f6f6c, type: typeType) // "bool"
    public static let boundingRectangle = NUMSymbol(name: "boundingRectangle", code: 0x71647274, type: typeType) // "qdrt"
    public static let bounds = NUMSymbol(name: "bounds", code: 0x70626e64, type: typeType) // "pbnd"
    public static let cell = NUMSymbol(name: "cell", code: 0x4e6d436c, type: typeType) // "NmCl"
    public static let cellRange = NUMSymbol(name: "cellRange", code: 0x4e4d5463, type: typeType) // "NMTc"
    public static let character = NUMSymbol(name: "character", code: 0x63686120, type: typeType) // "cha\0x20"
    public static let chart = NUMSymbol(name: "chart", code: 0x73686374, type: typeType) // "shct"
    public static let class_ = NUMSymbol(name: "class_", code: 0x70636c73, type: typeType) // "pcls"
    public static let clipVolume = NUMSymbol(name: "clipVolume", code: 0x61766f6c, type: typeType) // "avol"
    public static let closeable = NUMSymbol(name: "closeable", code: 0x68636c62, type: typeType) // "hclb"
    public static let collating = NUMSymbol(name: "collating", code: 0x6c77636c, type: typeType) // "lwcl"
    public static let color = NUMSymbol(name: "color", code: 0x636f6c72, type: typeType) // "colr"
    public static let colorTable = NUMSymbol(name: "colorTable", code: 0x636c7274, type: typeType) // "clrt"
    public static let column = NUMSymbol(name: "column", code: 0x4e4d436f, type: typeType) // "NMCo"
    public static let columnCount = NUMSymbol(name: "columnCount", code: 0x4e6d5463, type: typeType) // "NmTc"
    public static let constant = NUMSymbol(name: "constant", code: 0x656e756d, type: typeType) // "enum"
    public static let copies = NUMSymbol(name: "copies", code: 0x6c776370, type: typeType) // "lwcp"
    public static let dashStyle = NUMSymbol(name: "dashStyle", code: 0x74646173, type: typeType) // "tdas"
    public static let data = NUMSymbol(name: "data", code: 0x74647461, type: typeType) // "tdta"
    public static let date = NUMSymbol(name: "date", code: 0x6c647420, type: typeType) // "ldt\0x20"
    public static let December = NUMSymbol(name: "December", code: 0x64656320, type: typeType) // "dec\0x20"
    public static let decimalStruct = NUMSymbol(name: "decimalStruct", code: 0x6465636d, type: typeType) // "decm"
    public static let description_ = NUMSymbol(name: "description_", code: 0x64736372, type: typeType) // "dscr"
    public static let document = NUMSymbol(name: "document", code: 0x646f6375, type: typeType) // "docu"
    public static let documentTemplate = NUMSymbol(name: "documentTemplate", code: 0x546d706c, type: typeType) // "Tmpl"
    public static let doubleInteger = NUMSymbol(name: "doubleInteger", code: 0x636f6d70, type: typeType) // "comp"
    public static let encodedString = NUMSymbol(name: "encodedString", code: 0x656e6373, type: typeType) // "encs"
    public static let endingPage = NUMSymbol(name: "endingPage", code: 0x6c776c70, type: typeType) // "lwlp"
    public static let endPoint = NUMSymbol(name: "endPoint", code: 0x6c6e6570, type: typeType) // "lnep"
    public static let EPSPicture = NUMSymbol(name: "EPSPicture", code: 0x45505320, type: typeType) // "EPS\0x20"
    public static let errorHandling = NUMSymbol(name: "errorHandling", code: 0x6c776568, type: typeType) // "lweh"
    public static let excludeSummaryWorksheet = NUMSymbol(name: "excludeSummaryWorksheet", code: 0x4e784553, type: typeType) // "NxES"
    public static let exportOptions = NUMSymbol(name: "exportOptions", code: 0x4e786f70, type: typeType) // "Nxop"
    public static let extendedReal = NUMSymbol(name: "extendedReal", code: 0x65787465, type: typeType) // "exte"
    public static let faxNumber = NUMSymbol(name: "faxNumber", code: 0x6661786e, type: typeType) // "faxn"
    public static let February = NUMSymbol(name: "February", code: 0x66656220, type: typeType) // "feb\0x20"
    public static let file = NUMSymbol(name: "file", code: 0x66696c65, type: typeType) // "file"
    public static let fileName = NUMSymbol(name: "fileName", code: 0x6174666e, type: typeType) // "atfn"
    public static let fileRef = NUMSymbol(name: "fileRef", code: 0x66737266, type: typeType) // "fsrf"
    public static let fileSpecification = NUMSymbol(name: "fileSpecification", code: 0x66737320, type: typeType) // "fss\0x20"
    public static let fileURL = NUMSymbol(name: "fileURL", code: 0x6675726c, type: typeType) // "furl"
    public static let filtered = NUMSymbol(name: "filtered", code: 0x4e4d5466, type: typeType) // "NMTf"
    public static let fixed = NUMSymbol(name: "fixed", code: 0x66697864, type: typeType) // "fixd"
    public static let fixedPoint = NUMSymbol(name: "fixedPoint", code: 0x66706e74, type: typeType) // "fpnt"
    public static let fixedRectangle = NUMSymbol(name: "fixedRectangle", code: 0x66726374, type: typeType) // "frct"
    public static let font = NUMSymbol(name: "font", code: 0x666f6e74, type: typeType) // "font"
    public static let fontName = NUMSymbol(name: "fontName", code: 0x4e4d666e, type: typeType) // "NMfn"
    public static let fontSize = NUMSymbol(name: "fontSize", code: 0x4e4d6673, type: typeType) // "NMfs"
    public static let footerRowCount = NUMSymbol(name: "footerRowCount", code: 0x4e6d4672, type: typeType) // "NmFr"
    public static let format = NUMSymbol(name: "format", code: 0x4e4d4354, type: typeType) // "NMCT"
    public static let formattedValue = NUMSymbol(name: "formattedValue", code: 0x4e4d6676, type: typeType) // "NMfv"
    public static let formula = NUMSymbol(name: "formula", code: 0x4e4d4366, type: typeType) // "NMCf"
    public static let Friday = NUMSymbol(name: "Friday", code: 0x66726920, type: typeType) // "fri\0x20"
    public static let frontmost = NUMSymbol(name: "frontmost", code: 0x70697366, type: typeType) // "pisf"
    public static let GIFPicture = NUMSymbol(name: "GIFPicture", code: 0x47494666, type: typeType) // "GIFf"
    public static let graphicText = NUMSymbol(name: "graphicText", code: 0x63677478, type: typeType) // "cgtx"
    public static let group = NUMSymbol(name: "group", code: 0x69677270, type: typeType) // "igrp"
    public static let headerColumnCount = NUMSymbol(name: "headerColumnCount", code: 0x4e6d4843, type: typeType) // "NmHC"
    public static let headerColumnsFrozen = NUMSymbol(name: "headerColumnsFrozen", code: 0x4e6d4643, type: typeType) // "NmFC"
    public static let headerRowCount = NUMSymbol(name: "headerRowCount", code: 0x4e6d4872, type: typeType) // "NmHr"
    public static let headerRowsFrozen = NUMSymbol(name: "headerRowsFrozen", code: 0x4e6d4648, type: typeType) // "NmFH"
    public static let height = NUMSymbol(name: "height", code: 0x73697468, type: typeType) // "sith"
    public static let id = NUMSymbol(name: "id", code: 0x49442020, type: typeType) // "ID\0x20\0x20"
    public static let image = NUMSymbol(name: "image", code: 0x696d6167, type: typeType) // "imag"
    public static let imageQuality = NUMSymbol(name: "imageQuality", code: 0x4e785049, type: typeType) // "NxPI"
    public static let index = NUMSymbol(name: "index", code: 0x70696478, type: typeType) // "pidx"
    public static let integer = NUMSymbol(name: "integer", code: 0x6c6f6e67, type: typeType) // "long"
    public static let internationalText = NUMSymbol(name: "internationalText", code: 0x69747874, type: typeType) // "itxt"
    public static let internationalWritingCode = NUMSymbol(name: "internationalWritingCode", code: 0x696e746c, type: typeType) // "intl"
    public static let item = NUMSymbol(name: "item", code: 0x636f626a, type: typeType) // "cobj"
    public static let iWorkContainer = NUMSymbol(name: "iWorkContainer", code: 0x69776b63, type: typeType) // "iwkc"
    public static let iWorkItem = NUMSymbol(name: "iWorkItem", code: 0x666d7469, type: typeType) // "fmti"
    public static let January = NUMSymbol(name: "January", code: 0x6a616e20, type: typeType) // "jan\0x20"
    public static let JPEGPicture = NUMSymbol(name: "JPEGPicture", code: 0x4a504547, type: typeType) // "JPEG"
    public static let July = NUMSymbol(name: "July", code: 0x6a756c20, type: typeType) // "jul\0x20"
    public static let June = NUMSymbol(name: "June", code: 0x6a756e20, type: typeType) // "jun\0x20"
    public static let kernelProcessID = NUMSymbol(name: "kernelProcessID", code: 0x6b706964, type: typeType) // "kpid"
    public static let largeReal = NUMSymbol(name: "largeReal", code: 0x6c64626c, type: typeType) // "ldbl"
    public static let line = NUMSymbol(name: "line", code: 0x69576c6e, type: typeType) // "iWln"
    public static let list = NUMSymbol(name: "list", code: 0x6c697374, type: typeType) // "list"
    public static let locationReference = NUMSymbol(name: "locationReference", code: 0x696e736c, type: typeType) // "insl"
    public static let locked = NUMSymbol(name: "locked", code: 0x704c636b, type: typeType) // "pLck"
    public static let longFixed = NUMSymbol(name: "longFixed", code: 0x6c667864, type: typeType) // "lfxd"
    public static let longFixedPoint = NUMSymbol(name: "longFixedPoint", code: 0x6c667074, type: typeType) // "lfpt"
    public static let longFixedRectangle = NUMSymbol(name: "longFixedRectangle", code: 0x6c667263, type: typeType) // "lfrc"
    public static let longPoint = NUMSymbol(name: "longPoint", code: 0x6c706e74, type: typeType) // "lpnt"
    public static let longRectangle = NUMSymbol(name: "longRectangle", code: 0x6c726374, type: typeType) // "lrct"
    public static let machine = NUMSymbol(name: "machine", code: 0x6d616368, type: typeType) // "mach"
    public static let machineLocation = NUMSymbol(name: "machineLocation", code: 0x6d4c6f63, type: typeType) // "mLoc"
    public static let machPort = NUMSymbol(name: "machPort", code: 0x706f7274, type: typeType) // "port"
    public static let March = NUMSymbol(name: "March", code: 0x6d617220, type: typeType) // "mar\0x20"
    public static let May = NUMSymbol(name: "May", code: 0x6d617920, type: typeType) // "may\0x20"
    public static let miniaturizable = NUMSymbol(name: "miniaturizable", code: 0x69736d6e, type: typeType) // "ismn"
    public static let miniaturized = NUMSymbol(name: "miniaturized", code: 0x706d6e64, type: typeType) // "pmnd"
    public static let modified = NUMSymbol(name: "modified", code: 0x696d6f64, type: typeType) // "imod"
    public static let Monday = NUMSymbol(name: "Monday", code: 0x6d6f6e20, type: typeType) // "mon\0x20"
    public static let movie = NUMSymbol(name: "movie", code: 0x73686d76, type: typeType) // "shmv"
    public static let movieVolume = NUMSymbol(name: "movieVolume", code: 0x6d766f6c, type: typeType) // "mvol"
    public static let name = NUMSymbol(name: "name", code: 0x706e616d, type: typeType) // "pnam"
    public static let November = NUMSymbol(name: "November", code: 0x6e6f7620, type: typeType) // "nov\0x20"
    public static let null = NUMSymbol(name: "null", code: 0x6e756c6c, type: typeType) // "null"
    public static let objectText = NUMSymbol(name: "objectText", code: 0x70445478, type: typeType) // "pDTx"
    public static let October = NUMSymbol(name: "October", code: 0x6f637420, type: typeType) // "oct\0x20"
    public static let opacity = NUMSymbol(name: "opacity", code: 0x70534f70, type: typeType) // "pSOp"
    public static let pagesAcross = NUMSymbol(name: "pagesAcross", code: 0x6c776c61, type: typeType) // "lwla"
    public static let pagesDown = NUMSymbol(name: "pagesDown", code: 0x6c776c64, type: typeType) // "lwld"
    public static let paragraph = NUMSymbol(name: "paragraph", code: 0x63706172, type: typeType) // "cpar"
    public static let parent = NUMSymbol(name: "parent", code: 0x73697074, type: typeType) // "sipt"
    public static let password = NUMSymbol(name: "password", code: 0x4e785057, type: typeType) // "NxPW"
    public static let passwordHint = NUMSymbol(name: "passwordHint", code: 0x4e785048, type: typeType) // "NxPH"
    public static let PICTPicture = NUMSymbol(name: "PICTPicture", code: 0x50494354, type: typeType) // "PICT"
    public static let pixelMapRecord = NUMSymbol(name: "pixelMapRecord", code: 0x74706d6d, type: typeType) // "tpmm"
    public static let point = NUMSymbol(name: "point", code: 0x51447074, type: typeType) // "QDpt"
    public static let position = NUMSymbol(name: "position", code: 0x7369706f, type: typeType) // "sipo"
    public static let printSettings = NUMSymbol(name: "printSettings", code: 0x70736574, type: typeType) // "pset"
    public static let processSerialNumber = NUMSymbol(name: "processSerialNumber", code: 0x70736e20, type: typeType) // "psn\0x20"
    public static let properties = NUMSymbol(name: "properties", code: 0x70414c4c, type: typeType) // "pALL"
    public static let property_ = NUMSymbol(name: "property_", code: 0x70726f70, type: typeType) // "prop"
    public static let range = NUMSymbol(name: "range", code: 0x4e6d4352, type: typeType) // "NmCR"
    public static let real = NUMSymbol(name: "real", code: 0x646f7562, type: typeType) // "doub"
    public static let record = NUMSymbol(name: "record", code: 0x7265636f, type: typeType) // "reco"
    public static let reference = NUMSymbol(name: "reference", code: 0x6f626a20, type: typeType) // "obj\0x20"
    public static let reflectionShowing = NUMSymbol(name: "reflectionShowing", code: 0x73697273, type: typeType) // "sirs"
    public static let reflectionValue = NUMSymbol(name: "reflectionValue", code: 0x73697276, type: typeType) // "sirv"
    public static let repetitionMethod = NUMSymbol(name: "repetitionMethod", code: 0x6d767270, type: typeType) // "mvrp"
    public static let requestedPrintTime = NUMSymbol(name: "requestedPrintTime", code: 0x6c777174, type: typeType) // "lwqt"
    public static let resizable = NUMSymbol(name: "resizable", code: 0x7072737a, type: typeType) // "prsz"
    public static let RGB16Color = NUMSymbol(name: "RGB16Color", code: 0x74723136, type: typeType) // "tr16"
    public static let RGB96Color = NUMSymbol(name: "RGB96Color", code: 0x74723936, type: typeType) // "tr96"
    public static let RGBColor = NUMSymbol(name: "RGBColor", code: 0x63524742, type: typeType) // "cRGB"
    public static let richText = NUMSymbol(name: "richText", code: 0x72747874, type: typeType) // "rtxt"
    public static let rotation = NUMSymbol(name: "rotation", code: 0x74726f74, type: typeType) // "trot"
    public static let rotation_ = NUMSymbol(name: "rotation_", code: 0x7369726f, type: typeType) // "siro"
    public static let row = NUMSymbol(name: "row", code: 0x4e4d5277, type: typeType) // "NMRw"
    public static let rowCount = NUMSymbol(name: "rowCount", code: 0x4e6d5472, type: typeType) // "NmTr"
    public static let Saturday = NUMSymbol(name: "Saturday", code: 0x73617420, type: typeType) // "sat\0x20"
    public static let script = NUMSymbol(name: "script", code: 0x73637074, type: typeType) // "scpt"
    public static let selectionRange = NUMSymbol(name: "selectionRange", code: 0x4e4d5473, type: typeType) // "NMTs"
    public static let September = NUMSymbol(name: "September", code: 0x73657020, type: typeType) // "sep\0x20"
    public static let shape = NUMSymbol(name: "shape", code: 0x73736870, type: typeType) // "sshp"
    public static let sheet = NUMSymbol(name: "sheet", code: 0x4e6d5368, type: typeType) // "NmSh"
    public static let shortInteger = NUMSymbol(name: "shortInteger", code: 0x73686f72, type: typeType) // "shor"
    public static let size = NUMSymbol(name: "size", code: 0x7074737a, type: typeType) // "ptsz"
    public static let smallReal = NUMSymbol(name: "smallReal", code: 0x73696e67, type: typeType) // "sing"
    public static let startingPage = NUMSymbol(name: "startingPage", code: 0x6c776670, type: typeType) // "lwfp"
    public static let startPoint = NUMSymbol(name: "startPoint", code: 0x6c6e7370, type: typeType) // "lnsp"
    public static let string = NUMSymbol(name: "string", code: 0x54455854, type: typeType) // "TEXT"
    public static let styledClipboardText = NUMSymbol(name: "styledClipboardText", code: 0x7374796c, type: typeType) // "styl"
    public static let styledText = NUMSymbol(name: "styledText", code: 0x53545854, type: typeType) // "STXT"
    public static let Sunday = NUMSymbol(name: "Sunday", code: 0x73756e20, type: typeType) // "sun\0x20"
    public static let table = NUMSymbol(name: "table", code: 0x4e6d5462, type: typeType) // "NmTb"
    public static let targetPrinter = NUMSymbol(name: "targetPrinter", code: 0x74727072, type: typeType) // "trpr"
    public static let template = NUMSymbol(name: "template", code: 0x746d706c, type: typeType) // "tmpl"
    public static let textColor = NUMSymbol(name: "textColor", code: 0x74657843, type: typeType) // "texC"
    public static let textItem = NUMSymbol(name: "textItem", code: 0x73687478, type: typeType) // "shtx"
    public static let textStyleInfo = NUMSymbol(name: "textStyleInfo", code: 0x74737479, type: typeType) // "tsty"
    public static let textWrap = NUMSymbol(name: "textWrap", code: 0x77726170, type: typeType) // "wrap"
    public static let Thursday = NUMSymbol(name: "Thursday", code: 0x74687520, type: typeType) // "thu\0x20"
    public static let TIFFPicture = NUMSymbol(name: "TIFFPicture", code: 0x54494646, type: typeType) // "TIFF"
    public static let Tuesday = NUMSymbol(name: "Tuesday", code: 0x74756520, type: typeType) // "tue\0x20"
    public static let typeClass = NUMSymbol(name: "typeClass", code: 0x74797065, type: typeType) // "type"
    public static let UnicodeText = NUMSymbol(name: "UnicodeText", code: 0x75747874, type: typeType) // "utxt"
    public static let unsignedDoubleInteger = NUMSymbol(name: "unsignedDoubleInteger", code: 0x75636f6d, type: typeType) // "ucom"
    public static let unsignedInteger = NUMSymbol(name: "unsignedInteger", code: 0x6d61676e, type: typeType) // "magn"
    public static let unsignedShortInteger = NUMSymbol(name: "unsignedShortInteger", code: 0x75736872, type: typeType) // "ushr"
    public static let UTF16Text = NUMSymbol(name: "UTF16Text", code: 0x75743136, type: typeType) // "ut16"
    public static let UTF8Text = NUMSymbol(name: "UTF8Text", code: 0x75746638, type: typeType) // "utf8"
    public static let value = NUMSymbol(name: "value", code: 0x4e4d4376, type: typeType) // "NMCv"
    public static let version = NUMSymbol(name: "version", code: 0x76657273, type: typeType) // "vers"
    public static let verticalAlignment = NUMSymbol(name: "verticalAlignment", code: 0x74785641, type: typeType) // "txVA"
    public static let visible = NUMSymbol(name: "visible", code: 0x70766973, type: typeType) // "pvis"
    public static let Wednesday = NUMSymbol(name: "Wednesday", code: 0x77656420, type: typeType) // "wed\0x20"
    public static let width = NUMSymbol(name: "width", code: 0x73697477, type: typeType) // "sitw"
    public static let window = NUMSymbol(name: "window", code: 0x6377696e, type: typeType) // "cwin"
    public static let word = NUMSymbol(name: "word", code: 0x63776f72, type: typeType) // "cwor"
    public static let writingCode = NUMSymbol(name: "writingCode", code: 0x70736374, type: typeType) // "psct"
    public static let zoomable = NUMSymbol(name: "zoomable", code: 0x69737a6d, type: typeType) // "iszm"
    public static let zoomed = NUMSymbol(name: "zoomed", code: 0x707a756d, type: typeType) // "pzum"

    // Enumerators
    public static let advancedGradientFill = NUMSymbol(name: "advancedGradientFill", code: 0x66696167, type: typeEnumerated) // "fiag"
    public static let advancedImageFill = NUMSymbol(name: "advancedImageFill", code: 0x66696169, type: typeEnumerated) // "fiai"
    public static let ascending = NUMSymbol(name: "ascending", code: 0x6173636e, type: typeEnumerated) // "ascn"
    public static let ask = NUMSymbol(name: "ask", code: 0x61736b20, type: typeEnumerated) // "ask\0x20"
    public static let autoAlign = NUMSymbol(name: "autoAlign", code: 0x61617574, type: typeEnumerated) // "aaut"
    public static let automatic = NUMSymbol(name: "automatic", code: 0x66617574, type: typeEnumerated) // "faut"
    public static let Best = NUMSymbol(name: "Best", code: 0x4b6e5032, type: typeEnumerated) // "KnP2"
    public static let Better = NUMSymbol(name: "Better", code: 0x4b6e5031, type: typeEnumerated) // "KnP1"
    public static let bottom = NUMSymbol(name: "bottom", code: 0x61766274, type: typeEnumerated) // "avbt"
    public static let case_ = NUMSymbol(name: "case_", code: 0x63617365, type: typeEnumerated) // "case"
    public static let center = NUMSymbol(name: "center", code: 0x61637472, type: typeEnumerated) // "actr"
    public static let checkbox = NUMSymbol(name: "checkbox", code: 0x66636368, type: typeEnumerated) // "fcch"
    public static let colorFill = NUMSymbol(name: "colorFill", code: 0x6669636f, type: typeEnumerated) // "fico"
    public static let CSV = NUMSymbol(name: "CSV", code: 0x4e637376, type: typeEnumerated) // "Ncsv"
    public static let currency = NUMSymbol(name: "currency", code: 0x66637572, type: typeEnumerated) // "fcur"
    public static let dateAndTime = NUMSymbol(name: "dateAndTime", code: 0x6664746d, type: typeEnumerated) // "fdtm"
    public static let descending = NUMSymbol(name: "descending", code: 0x6473636e, type: typeEnumerated) // "dscn"
    public static let detailed = NUMSymbol(name: "detailed", code: 0x6c776474, type: typeEnumerated) // "lwdt"
    public static let diacriticals = NUMSymbol(name: "diacriticals", code: 0x64696163, type: typeEnumerated) // "diac"
    public static let duration = NUMSymbol(name: "duration", code: 0x66647572, type: typeEnumerated) // "fdur"
    public static let expansion = NUMSymbol(name: "expansion", code: 0x65787061, type: typeEnumerated) // "expa"
    public static let fraction = NUMSymbol(name: "fraction", code: 0x66667261, type: typeEnumerated) // "ffra"
    public static let Good = NUMSymbol(name: "Good", code: 0x4b6e5030, type: typeEnumerated) // "KnP0"
    public static let gradientFill = NUMSymbol(name: "gradientFill", code: 0x66696772, type: typeEnumerated) // "figr"
    public static let hyphens = NUMSymbol(name: "hyphens", code: 0x68797068, type: typeEnumerated) // "hyph"
    public static let imageFill = NUMSymbol(name: "imageFill", code: 0x6669696d, type: typeEnumerated) // "fiim"
    public static let justify = NUMSymbol(name: "justify", code: 0x616a7374, type: typeEnumerated) // "ajst"
    public static let left = NUMSymbol(name: "left", code: 0x616c6674, type: typeEnumerated) // "alft"
    public static let loop = NUMSymbol(name: "loop", code: 0x6d766c70, type: typeEnumerated) // "mvlp"
    public static let loopBackAndForth = NUMSymbol(name: "loopBackAndForth", code: 0x6d766266, type: typeEnumerated) // "mvbf"
    public static let MicrosoftExcel = NUMSymbol(name: "MicrosoftExcel", code: 0x4e65786c, type: typeEnumerated) // "Nexl"
    public static let no = NUMSymbol(name: "no", code: 0x6e6f2020, type: typeEnumerated) // "no\0x20\0x20"
    public static let noFill = NUMSymbol(name: "noFill", code: 0x66696e6f, type: typeEnumerated) // "fino"
    public static let none = NUMSymbol(name: "none", code: 0x6d76726e, type: typeEnumerated) // "mvrn"
    public static let number = NUMSymbol(name: "number", code: 0x6e6d6272, type: typeEnumerated) // "nmbr"
    public static let Numbers = NUMSymbol(name: "Numbers", code: 0x4e756666, type: typeEnumerated) // "Nuff"
    public static let Numbers09 = NUMSymbol(name: "Numbers09", code: 0x4e6e6d62, type: typeEnumerated) // "Nnmb"
    public static let numeralSystem = NUMSymbol(name: "numeralSystem", code: 0x66636e73, type: typeEnumerated) // "fcns"
    public static let numericStrings = NUMSymbol(name: "numericStrings", code: 0x6e756d65, type: typeEnumerated) // "nume"
    public static let PDF = NUMSymbol(name: "PDF", code: 0x4e706466, type: typeEnumerated) // "Npdf"
    public static let percent = NUMSymbol(name: "percent", code: 0x66706572, type: typeEnumerated) // "fper"
    public static let popUpMenu = NUMSymbol(name: "popUpMenu", code: 0x66637070, type: typeEnumerated) // "fcpp"
    public static let punctuation = NUMSymbol(name: "punctuation", code: 0x70756e63, type: typeEnumerated) // "punc"
    public static let rating = NUMSymbol(name: "rating", code: 0x66726174, type: typeEnumerated) // "frat"
    public static let right = NUMSymbol(name: "right", code: 0x61726974, type: typeEnumerated) // "arit"
    public static let scientific = NUMSymbol(name: "scientific", code: 0x66736369, type: typeEnumerated) // "fsci"
    public static let slider = NUMSymbol(name: "slider", code: 0x6663736c, type: typeEnumerated) // "fcsl"
    public static let standard = NUMSymbol(name: "standard", code: 0x6c777374, type: typeEnumerated) // "lwst"
    public static let stepper = NUMSymbol(name: "stepper", code: 0x66637374, type: typeEnumerated) // "fcst"
    public static let text = NUMSymbol(name: "text", code: 0x63747874, type: typeEnumerated) // "ctxt"
    public static let top = NUMSymbol(name: "top", code: 0x61767470, type: typeEnumerated) // "avtp"
    public static let whitespace = NUMSymbol(name: "whitespace", code: 0x77686974, type: typeEnumerated) // "whit"
    public static let yes = NUMSymbol(name: "yes", code: 0x79657320, type: typeEnumerated) // "yes\0x20"
}

public typealias NUM = NUMSymbol // allows symbols to be written as (e.g.) NUM.name instead of NUMSymbol.name


/******************************************************************************/
// Specifier extensions; these add command methods and property/elements getters based on Numbers.app terminology

public protocol NUMCommand: SwiftAutomation.SpecifierProtocol {} // provides AE dispatch methods

// Command->Any will be bound when return type can't be inferred, else Command->T

extension NUMCommand {
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
    @discardableResult public func addColumnAfter(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "addColumnAfter", eventClass: 0x4e4d5462, eventID: 0x41436166, // "NMTb"/"ACaf"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func addColumnAfter<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "addColumnAfter", eventClass: 0x4e4d5462, eventID: 0x41436166, // "NMTb"/"ACaf"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func addColumnBefore(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "addColumnBefore", eventClass: 0x4e4d5462, eventID: 0x41436266, // "NMTb"/"ACbf"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func addColumnBefore<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "addColumnBefore", eventClass: 0x4e4d5462, eventID: 0x41436266, // "NMTb"/"ACbf"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func addRowAbove(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "addRowAbove", eventClass: 0x4e4d5462, eventID: 0x41526162, // "NMTb"/"ARab"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func addRowAbove<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "addRowAbove", eventClass: 0x4e4d5462, eventID: 0x41526162, // "NMTb"/"ARab"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func addRowBelow(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "addRowBelow", eventClass: 0x4e4d5462, eventID: 0x41526166, // "NMTb"/"ARaf"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func addRowBelow<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "addRowBelow", eventClass: 0x4e4d5462, eventID: 0x41526166, // "NMTb"/"ARaf"
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
        return try self.appData.sendAppleEvent(name: "export", eventClass: 0x4e6d7374, eventID: 0x6578706f, // "Nmst"/"expo"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x7066696c, to), // "pfil"
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
        return try self.appData.sendAppleEvent(name: "export", eventClass: 0x4e6d7374, eventID: 0x6578706f, // "Nmst"/"expo"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x7066696c, to), // "pfil"
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
    @discardableResult public func remove(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "remove", eventClass: 0x4e6d5462, eventID: 0x444c5420, // "NmTb"/"DLT\0x20"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func remove<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "remove", eventClass: 0x4e6d5462, eventID: 0x444c5420, // "NmTb"/"DLT\0x20"
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
    @discardableResult public func transpose(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "transpose", eventClass: 0x4e6d5462, eventID: 0x58504f53, // "NmTb"/"XPOS"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func transpose<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "transpose", eventClass: 0x4e6d5462, eventID: 0x58504f53, // "NmTb"/"XPOS"
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


public protocol NUMObject: SwiftAutomation.ObjectSpecifierExtension, NUMCommand {} // provides vars and methods for constructing specifiers

extension NUMObject {
    
    // Properties
    public var activeSheet: NUMItem {return self.property(0x4e6d4153) as! NUMItem} // "NmAS"
    public var address: NUMItem {return self.property(0x4e4d6164) as! NUMItem} // "NMad"
    public var alignment: NUMItem {return self.property(0x74657841) as! NUMItem} // "texA"
    public var backgroundColor: NUMItem {return self.property(0x63654243) as! NUMItem} // "ceBC"
    public var backgroundFillType: NUMItem {return self.property(0x626b6674) as! NUMItem} // "bkft"
    public var bounds: NUMItem {return self.property(0x70626e64) as! NUMItem} // "pbnd"
    public var cellRange: NUMItem {return self.property(0x4e4d5463) as! NUMItem} // "NMTc"
    public var class_: NUMItem {return self.property(0x70636c73) as! NUMItem} // "pcls"
    public var clipVolume: NUMItem {return self.property(0x61766f6c) as! NUMItem} // "avol"
    public var closeable: NUMItem {return self.property(0x68636c62) as! NUMItem} // "hclb"
    public var collating: NUMItem {return self.property(0x6c77636c) as! NUMItem} // "lwcl"
    public var color: NUMItem {return self.property(0x636f6c72) as! NUMItem} // "colr"
    public var column: NUMItem {return self.property(0x4e4d436f) as! NUMItem} // "NMCo"
    public var columnCount: NUMItem {return self.property(0x4e6d5463) as! NUMItem} // "NmTc"
    public var copies: NUMItem {return self.property(0x6c776370) as! NUMItem} // "lwcp"
    public var description_: NUMItem {return self.property(0x64736372) as! NUMItem} // "dscr"
    public var document: NUMItem {return self.property(0x646f6375) as! NUMItem} // "docu"
    public var documentTemplate: NUMItem {return self.property(0x546d706c) as! NUMItem} // "Tmpl"
    public var endingPage: NUMItem {return self.property(0x6c776c70) as! NUMItem} // "lwlp"
    public var endPoint: NUMItem {return self.property(0x6c6e6570) as! NUMItem} // "lnep"
    public var errorHandling: NUMItem {return self.property(0x6c776568) as! NUMItem} // "lweh"
    public var excludeSummaryWorksheet: NUMItem {return self.property(0x4e784553) as! NUMItem} // "NxES"
    public var faxNumber: NUMItem {return self.property(0x6661786e) as! NUMItem} // "faxn"
    public var file: NUMItem {return self.property(0x66696c65) as! NUMItem} // "file"
    public var fileName: NUMItem {return self.property(0x6174666e) as! NUMItem} // "atfn"
    public var filtered: NUMItem {return self.property(0x4e4d5466) as! NUMItem} // "NMTf"
    public var font: NUMItem {return self.property(0x666f6e74) as! NUMItem} // "font"
    public var fontName: NUMItem {return self.property(0x4e4d666e) as! NUMItem} // "NMfn"
    public var fontSize: NUMItem {return self.property(0x4e4d6673) as! NUMItem} // "NMfs"
    public var footerRowCount: NUMItem {return self.property(0x4e6d4672) as! NUMItem} // "NmFr"
    public var format: NUMItem {return self.property(0x4e4d4354) as! NUMItem} // "NMCT"
    public var formattedValue: NUMItem {return self.property(0x4e4d6676) as! NUMItem} // "NMfv"
    public var formula: NUMItem {return self.property(0x4e4d4366) as! NUMItem} // "NMCf"
    public var frontmost: NUMItem {return self.property(0x70697366) as! NUMItem} // "pisf"
    public var headerColumnCount: NUMItem {return self.property(0x4e6d4843) as! NUMItem} // "NmHC"
    public var headerColumnsFrozen: NUMItem {return self.property(0x4e6d4643) as! NUMItem} // "NmFC"
    public var headerRowCount: NUMItem {return self.property(0x4e6d4872) as! NUMItem} // "NmHr"
    public var headerRowsFrozen: NUMItem {return self.property(0x4e6d4648) as! NUMItem} // "NmFH"
    public var height: NUMItem {return self.property(0x73697468) as! NUMItem} // "sith"
    public var id: NUMItem {return self.property(0x49442020) as! NUMItem} // "ID\0x20\0x20"
    public var imageQuality: NUMItem {return self.property(0x4e785049) as! NUMItem} // "NxPI"
    public var index: NUMItem {return self.property(0x70696478) as! NUMItem} // "pidx"
    public var locked: NUMItem {return self.property(0x704c636b) as! NUMItem} // "pLck"
    public var miniaturizable: NUMItem {return self.property(0x69736d6e) as! NUMItem} // "ismn"
    public var miniaturized: NUMItem {return self.property(0x706d6e64) as! NUMItem} // "pmnd"
    public var modified: NUMItem {return self.property(0x696d6f64) as! NUMItem} // "imod"
    public var movieVolume: NUMItem {return self.property(0x6d766f6c) as! NUMItem} // "mvol"
    public var name: NUMItem {return self.property(0x706e616d) as! NUMItem} // "pnam"
    public var objectText: NUMItem {return self.property(0x70445478) as! NUMItem} // "pDTx"
    public var opacity: NUMItem {return self.property(0x70534f70) as! NUMItem} // "pSOp"
    public var pagesAcross: NUMItem {return self.property(0x6c776c61) as! NUMItem} // "lwla"
    public var pagesDown: NUMItem {return self.property(0x6c776c64) as! NUMItem} // "lwld"
    public var parent: NUMItem {return self.property(0x73697074) as! NUMItem} // "sipt"
    public var password: NUMItem {return self.property(0x4e785057) as! NUMItem} // "NxPW"
    public var passwordHint: NUMItem {return self.property(0x4e785048) as! NUMItem} // "NxPH"
    public var position: NUMItem {return self.property(0x7369706f) as! NUMItem} // "sipo"
    public var properties: NUMItem {return self.property(0x70414c4c) as! NUMItem} // "pALL"
    public var reflectionShowing: NUMItem {return self.property(0x73697273) as! NUMItem} // "sirs"
    public var reflectionValue: NUMItem {return self.property(0x73697276) as! NUMItem} // "sirv"
    public var repetitionMethod: NUMItem {return self.property(0x6d767270) as! NUMItem} // "mvrp"
    public var requestedPrintTime: NUMItem {return self.property(0x6c777174) as! NUMItem} // "lwqt"
    public var resizable: NUMItem {return self.property(0x7072737a) as! NUMItem} // "prsz"
    public var rotation_: NUMItem {return self.property(0x7369726f) as! NUMItem} // "siro"
    public var row: NUMItem {return self.property(0x4e4d5277) as! NUMItem} // "NMRw"
    public var rowCount: NUMItem {return self.property(0x4e6d5472) as! NUMItem} // "NmTr"
    public var selectionRange: NUMItem {return self.property(0x4e4d5473) as! NUMItem} // "NMTs"
    public var size: NUMItem {return self.property(0x7074737a) as! NUMItem} // "ptsz"
    public var startingPage: NUMItem {return self.property(0x6c776670) as! NUMItem} // "lwfp"
    public var startPoint: NUMItem {return self.property(0x6c6e7370) as! NUMItem} // "lnsp"
    public var targetPrinter: NUMItem {return self.property(0x74727072) as! NUMItem} // "trpr"
    public var textColor: NUMItem {return self.property(0x74657843) as! NUMItem} // "texC"
    public var textWrap: NUMItem {return self.property(0x77726170) as! NUMItem} // "wrap"
    public var value: NUMItem {return self.property(0x4e4d4376) as! NUMItem} // "NMCv"
    public var version: NUMItem {return self.property(0x76657273) as! NUMItem} // "vers"
    public var verticalAlignment: NUMItem {return self.property(0x74785641) as! NUMItem} // "txVA"
    public var visible: NUMItem {return self.property(0x70766973) as! NUMItem} // "pvis"
    public var width: NUMItem {return self.property(0x73697477) as! NUMItem} // "sitw"
    public var zoomable: NUMItem {return self.property(0x69737a6d) as! NUMItem} // "iszm"
    public var zoomed: NUMItem {return self.property(0x707a756d) as! NUMItem} // "pzum"

    // Elements
    public var applications: NUMItems {return self.elements(0x63617070) as! NUMItems} // "capp"
    public var audioClips: NUMItems {return self.elements(0x73686175) as! NUMItems} // "shau"
    public var cells: NUMItems {return self.elements(0x4e6d436c) as! NUMItems} // "NmCl"
    public var characters: NUMItems {return self.elements(0x63686120) as! NUMItems} // "cha\0x20"
    public var charts: NUMItems {return self.elements(0x73686374) as! NUMItems} // "shct"
    public var columns: NUMItems {return self.elements(0x4e4d436f) as! NUMItems} // "NMCo"
    public var documents: NUMItems {return self.elements(0x646f6375) as! NUMItems} // "docu"
    public var groups: NUMItems {return self.elements(0x69677270) as! NUMItems} // "igrp"
    public var images: NUMItems {return self.elements(0x696d6167) as! NUMItems} // "imag"
    public var items: NUMItems {return self.elements(0x636f626a) as! NUMItems} // "cobj"
    public var iWorkContainers: NUMItems {return self.elements(0x69776b63) as! NUMItems} // "iwkc"
    public var iWorkItems: NUMItems {return self.elements(0x666d7469) as! NUMItems} // "fmti"
    public var lines: NUMItems {return self.elements(0x69576c6e) as! NUMItems} // "iWln"
    public var movies: NUMItems {return self.elements(0x73686d76) as! NUMItems} // "shmv"
    public var paragraphs: NUMItems {return self.elements(0x63706172) as! NUMItems} // "cpar"
    public var ranges: NUMItems {return self.elements(0x4e6d4352) as! NUMItems} // "NmCR"
    public var richText: NUMItems {return self.elements(0x72747874) as! NUMItems} // "rtxt"
    public var rows: NUMItems {return self.elements(0x4e4d5277) as! NUMItems} // "NMRw"
    public var shapes: NUMItems {return self.elements(0x73736870) as! NUMItems} // "sshp"
    public var sheets: NUMItems {return self.elements(0x4e6d5368) as! NUMItems} // "NmSh"
    public var tables: NUMItems {return self.elements(0x4e6d5462) as! NUMItems} // "NmTb"
    public var templates: NUMItems {return self.elements(0x746d706c) as! NUMItems} // "tmpl"
    public var textItems: NUMItems {return self.elements(0x73687478) as! NUMItems} // "shtx"
    public var windows: NUMItems {return self.elements(0x6377696e) as! NUMItems} // "cwin"
    public var words: NUMItems {return self.elements(0x63776f72) as! NUMItems} // "cwor"
}


/******************************************************************************/
// Specifier subclasses add app-specific extensions

// beginning/end/before/after
public class NUMInsertion: SwiftAutomation.InsertionSpecifier, NUMCommand {}


// property/by-index/by-name/by-id/previous/next/first/middle/last/any
public class NUMItem: SwiftAutomation.ObjectSpecifier, NUMObject {
    public typealias InsertionSpecifierType = NUMInsertion
    public typealias ObjectSpecifierType = NUMItem
    public typealias MultipleObjectSpecifierType = NUMItems
}

// by-range/by-test/all
public class NUMItems: NUMItem, SwiftAutomation.MultipleObjectSpecifierExtension {}

// App/Con/Its
public class NUMRoot: SwiftAutomation.RootSpecifier, NUMObject, SwiftAutomation.RootSpecifierExtension {
    public typealias InsertionSpecifierType = NUMInsertion
    public typealias ObjectSpecifierType = NUMItem
    public typealias MultipleObjectSpecifierType = NUMItems
    public override class var untargetedAppData: SwiftAutomation.AppData { return _untargetedAppData }
}

// Application
public class Numbers: NUMRoot, SwiftAutomation.Application {
    public convenience init(launchOptions: SwiftAutomation.LaunchOptions = SwiftAutomation.DefaultLaunchOptions, relaunchMode: SwiftAutomation.RelaunchMode = SwiftAutomation.DefaultRelaunchMode) {
        self.init(rootObject: SwiftAutomation.AppRootDesc, appData: Swift.type(of:self).untargetedAppData.targetedCopy(
                  .bundleIdentifier("com.apple.iWork.Numbers", true), launchOptions: launchOptions, relaunchMode: relaunchMode))
    }
}

// App/Con/Its root objects used to construct untargeted specifiers; these can be used to construct specifiers for use in commands, though cannot send commands themselves

public let NUMApp = _untargetedAppData.app as! NUMRoot
public let NUMCon = _untargetedAppData.con as! NUMRoot
public let NUMIts = _untargetedAppData.its as! NUMRoot


/******************************************************************************/
// Static types

public typealias NUMRecord = [NUMSymbol:Any] // default Swift type for AERecordDescs







