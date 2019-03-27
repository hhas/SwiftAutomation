//
//  PagesGlue.swift
//  Pages.app 7.3
//  SwiftAutomation.framework 0.1.0
//  `aeglue -S 'Pages.app'`
//


import Foundation
import SwiftAutomation


/******************************************************************************/
// Create an untargeted AppData instance for use in App, Con, Its roots,
// and in Application initializers to create targeted AppData instances.

private let _specifierFormatter = SwiftAutomation.SpecifierFormatter(applicationClassName: "Pages",
                                                     classNamePrefix: "PAG",
                                                     typeNames: [
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
                                                                     0x50786561: "author", // "Pxea"
                                                                     0x61617574: "autoAlign", // "aaut"
                                                                     0x66617574: "automatic", // "faut"
                                                                     0x63654243: "backgroundColor", // "ceBC"
                                                                     0x626b6674: "backgroundFillType", // "bkft"
                                                                     0x50675032: "Best", // "PgP2"
                                                                     0x62657374: "best", // "best"
                                                                     0x50675031: "Better", // "PgP1"
                                                                     0x70547874: "bodyText", // "pTxt"
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
                                                                     0x50786563: "cover", // "Pxec"
                                                                     0x66637572: "currency", // "fcur"
                                                                     0x70437061: "currentPage", // "pCpa"
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
                                                                     0x7044626f: "documentBody", // "pDbo"
                                                                     0x546d706c: "documentTemplate", // "Tmpl"
                                                                     0x636f6d70: "doubleInteger", // "comp"
                                                                     0x66647572: "duration", // "fdur"
                                                                     0x656e6373: "encodedString", // "encs"
                                                                     0x6c776c70: "endingPage", // "lwlp"
                                                                     0x6c6e6570: "endPoint", // "lnep"
                                                                     0x45505320: "EPSPicture", // "EPS\0x20"
                                                                     0x50657075: "EPUB", // "Pepu"
                                                                     0x6c776568: "errorHandling", // "lweh"
                                                                     0x65787061: "expansion", // "expa"
                                                                     0x50786f70: "exportOptions", // "Pxop"
                                                                     0x65787465: "extendedReal", // "exte"
                                                                     0x6661786e: "faxNumber", // "faxn"
                                                                     0x66656220: "February", // "feb\0x20"
                                                                     0x66696c65: "file", // "file"
                                                                     0x6174666e: "fileName", // "atfn"
                                                                     0x66737266: "fileRef", // "fsrf"
                                                                     0x66737320: "fileSpecification", // "fss\0x20"
                                                                     0x6675726c: "fileURL", // "furl"
                                                                     0x66697864: "fixed", // "fixd"
                                                                     0x50786566: "fixedLayout", // "Pxef"
                                                                     0x66706e74: "fixedPoint", // "fpnt"
                                                                     0x66726374: "fixedRectangle", // "frct"
                                                                     0x666f6e74: "font", // "font"
                                                                     0x4e4d666e: "fontName", // "NMfn"
                                                                     0x4e4d6673: "fontSize", // "NMfs"
                                                                     0x4e6d4672: "footerRowCount", // "NmFr"
                                                                     0x4e4d4354: "format", // "NMCT"
                                                                     0x50727466: "formattedText", // "Prtf"
                                                                     0x4e4d6676: "formattedValue", // "NMfv"
                                                                     0x4e4d4366: "formula", // "NMCf"
                                                                     0x66667261: "fraction", // "ffra"
                                                                     0x66726920: "Friday", // "fri\0x20"
                                                                     0x70697366: "frontmost", // "pisf"
                                                                     0x50786567: "genre", // "Pxeg"
                                                                     0x47494666: "GIFPicture", // "GIFf"
                                                                     0x50675030: "Good", // "PgP0"
                                                                     0x66696772: "gradientFill", // "figr"
                                                                     0x63677478: "graphicText", // "cgtx"
                                                                     0x69677270: "group", // "igrp"
                                                                     0x4e6d4843: "headerColumnCount", // "NmHC"
                                                                     0x4e6d4872: "headerRowCount", // "NmHr"
                                                                     0x73697468: "height", // "sith"
                                                                     0x68797068: "hyphens", // "hyph"
                                                                     0x49442020: "id", // "ID\0x20\0x20"
                                                                     0x696d6167: "image", // "imag"
                                                                     0x6669696d: "imageFill", // "fiim"
                                                                     0x50785049: "imageQuality", // "PxPI"
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
                                                                     0x5078656c: "language", // "Pxel"
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
                                                                     0x50777264: "MicrosoftWord", // "Pwrd"
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
                                                                     0x66636e73: "numeralSystem", // "fcns"
                                                                     0x6e756d65: "numericStrings", // "nume"
                                                                     0x70445478: "objectText", // "pDTx"
                                                                     0x6f637420: "October", // "oct\0x20"
                                                                     0x70534f70: "opacity", // "pSOp"
                                                                     0x63506167: "page", // "cPag"
                                                                     0x50506167: "Pages09", // "PPag"
                                                                     0x6c776c61: "pagesAcross", // "lwla"
                                                                     0x6c776c64: "pagesDown", // "lwld"
                                                                     0x50676666: "PagesFormat", // "Pgff"
                                                                     0x63706172: "paragraph", // "cpar"
                                                                     0x73697074: "parent", // "sipt"
                                                                     0x50785057: "password", // "PxPW"
                                                                     0x50785048: "passwordHint", // "PxPH"
                                                                     0x50706466: "PDF", // "Ppdf"
                                                                     0x66706572: "percent", // "fper"
                                                                     0x50494354: "PICTPicture", // "PICT"
                                                                     0x74706d6d: "pixelMapRecord", // "tpmm"
                                                                     0x63706c61: "placeholderText", // "cpla"
                                                                     0x51447074: "point", // "QDpt"
                                                                     0x66637070: "popUpMenu", // "fcpp"
                                                                     0x7369706f: "position", // "sipo"
                                                                     0x70736574: "printSettings", // "pset"
                                                                     0x70736e20: "processSerialNumber", // "psn\0x20"
                                                                     0x70414c4c: "properties", // "pALL"
                                                                     0x70726f70: "property_", // "prop"
                                                                     0x50786570: "publisher", // "Pxep"
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
                                                                     0x63536563: "section", // "cSec"
                                                                     0x4e4d5473: "selectionRange", // "NMTs"
                                                                     0x73657020: "September", // "sep\0x20"
                                                                     0x73736870: "shape", // "sshp"
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
                                                                     0x63706c74: "tag", // "cplt"
                                                                     0x74727072: "targetPrinter", // "trpr"
                                                                     0x746d706c: "template", // "tmpl"
                                                                     0x63747874: "text", // "ctxt"
                                                                     0x74657843: "textColor", // "texC"
                                                                     0x73687478: "textItem", // "shtx"
                                                                     0x74737479: "textStyleInfo", // "tsty"
                                                                     0x77726170: "textWrap", // "wrap"
                                                                     0x74687520: "Thursday", // "thu\0x20"
                                                                     0x54494646: "TIFFPicture", // "TIFF"
                                                                     0x50786574: "title", // "Pxet"
                                                                     0x61767470: "top", // "avtp"
                                                                     0x74756520: "Tuesday", // "tue\0x20"
                                                                     0x74797065: "typeClass", // "type"
                                                                     0x50747866: "unformattedText", // "Ptxf"
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
                                                                     0x4e4d6164: "address", // "NMad"
                                                                     0x74657841: "alignment", // "texA"
                                                                     0x50786561: "author", // "Pxea"
                                                                     0x63654243: "backgroundColor", // "ceBC"
                                                                     0x626b6674: "backgroundFillType", // "bkft"
                                                                     0x70547874: "bodyText", // "pTxt"
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
                                                                     0x50786563: "cover", // "Pxec"
                                                                     0x70437061: "currentPage", // "pCpa"
                                                                     0x64736372: "description_", // "dscr"
                                                                     0x646f6375: "document", // "docu"
                                                                     0x7044626f: "documentBody", // "pDbo"
                                                                     0x546d706c: "documentTemplate", // "Tmpl"
                                                                     0x6c776c70: "endingPage", // "lwlp"
                                                                     0x6c6e6570: "endPoint", // "lnep"
                                                                     0x6c776568: "errorHandling", // "lweh"
                                                                     0x6661786e: "faxNumber", // "faxn"
                                                                     0x66696c65: "file", // "file"
                                                                     0x6174666e: "fileName", // "atfn"
                                                                     0x50786566: "fixedLayout", // "Pxef"
                                                                     0x666f6e74: "font", // "font"
                                                                     0x4e4d666e: "fontName", // "NMfn"
                                                                     0x4e4d6673: "fontSize", // "NMfs"
                                                                     0x4e6d4672: "footerRowCount", // "NmFr"
                                                                     0x4e4d4354: "format", // "NMCT"
                                                                     0x4e4d6676: "formattedValue", // "NMfv"
                                                                     0x4e4d4366: "formula", // "NMCf"
                                                                     0x70697366: "frontmost", // "pisf"
                                                                     0x50786567: "genre", // "Pxeg"
                                                                     0x4e6d4843: "headerColumnCount", // "NmHC"
                                                                     0x4e6d4872: "headerRowCount", // "NmHr"
                                                                     0x73697468: "height", // "sith"
                                                                     0x49442020: "id", // "ID\0x20\0x20"
                                                                     0x50785049: "imageQuality", // "PxPI"
                                                                     0x70696478: "index", // "pidx"
                                                                     0x5078656c: "language", // "Pxel"
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
                                                                     0x50785057: "password", // "PxPW"
                                                                     0x50785048: "passwordHint", // "PxPH"
                                                                     0x7369706f: "position", // "sipo"
                                                                     0x70414c4c: "properties", // "pALL"
                                                                     0x50786570: "publisher", // "Pxep"
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
                                                                     0x63706c74: "tag", // "cplt"
                                                                     0x74727072: "targetPrinter", // "trpr"
                                                                     0x74657843: "textColor", // "texC"
                                                                     0x77726170: "textWrap", // "wrap"
                                                                     0x50786574: "title", // "Pxet"
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
                                                                     0x63506167: ("page", "pages"), // "cPag"
                                                                     0x63706172: ("paragraph", "paragraphs"), // "cpar"
                                                                     0x63706c61: ("placeholder text", "placeholderTexts"), // "cpla"
                                                                     0x4e6d4352: ("range", "ranges"), // "NmCR"
                                                                     0x72747874: ("rich text", "richText"), // "rtxt"
                                                                     0x4e4d5277: ("row", "rows"), // "NMRw"
                                                                     0x63536563: ("section", "sections"), // "cSec"
                                                                     0x73736870: ("shape", "shapes"), // "sshp"
                                                                     0x4e6d5462: ("table", "tables"), // "NmTb"
                                                                     0x746d706c: ("template", "templates"), // "tmpl"
                                                                     0x73687478: ("text item", "textItems"), // "shtx"
                                                                     0x6377696e: ("window", "windows"), // "cwin"
                                                                     0x63776f72: ("word", "words"), // "cwor"
                                                     ])

private let _glueClasses = SwiftAutomation.GlueClasses(insertionSpecifierType: PAGInsertion.self,
                                       objectSpecifierType: PAGItem.self,
                                       multiObjectSpecifierType: PAGItems.self,
                                       rootSpecifierType: PAGRoot.self,
                                       applicationType: Pages.self,
                                       symbolType: PAGSymbol.self,
                                       formatter: _specifierFormatter)

private let _untargetedAppData = SwiftAutomation.AppData(glueClasses: _glueClasses)


/******************************************************************************/
// Symbol subclass defines static type/enum/property constants based on Pages.app terminology

public class PAGSymbol: SwiftAutomation.Symbol {

    override public var typeAliasName: String {return "PAG"}

    public override class func symbol(code: OSType, type: OSType = typeType, descriptor: NSAppleEventDescriptor? = nil) -> PAGSymbol {
        switch (code) {
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
        case 0x50786561: return self.author // "Pxea"
        case 0x61617574: return self.autoAlign // "aaut"
        case 0x66617574: return self.automatic // "faut"
        case 0x63654243: return self.backgroundColor // "ceBC"
        case 0x626b6674: return self.backgroundFillType // "bkft"
        case 0x50675032: return self.Best // "PgP2"
        case 0x62657374: return self.best // "best"
        case 0x50675031: return self.Better // "PgP1"
        case 0x70547874: return self.bodyText // "pTxt"
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
        case 0x50786563: return self.cover // "Pxec"
        case 0x66637572: return self.currency // "fcur"
        case 0x70437061: return self.currentPage // "pCpa"
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
        case 0x7044626f: return self.documentBody // "pDbo"
        case 0x546d706c: return self.documentTemplate // "Tmpl"
        case 0x636f6d70: return self.doubleInteger // "comp"
        case 0x66647572: return self.duration // "fdur"
        case 0x656e6373: return self.encodedString // "encs"
        case 0x6c776c70: return self.endingPage // "lwlp"
        case 0x6c6e6570: return self.endPoint // "lnep"
        case 0x45505320: return self.EPSPicture // "EPS\0x20"
        case 0x50657075: return self.EPUB // "Pepu"
        case 0x6c776568: return self.errorHandling // "lweh"
        case 0x65787061: return self.expansion // "expa"
        case 0x50786f70: return self.exportOptions // "Pxop"
        case 0x65787465: return self.extendedReal // "exte"
        case 0x6661786e: return self.faxNumber // "faxn"
        case 0x66656220: return self.February // "feb\0x20"
        case 0x66696c65: return self.file // "file"
        case 0x6174666e: return self.fileName // "atfn"
        case 0x66737266: return self.fileRef // "fsrf"
        case 0x66737320: return self.fileSpecification // "fss\0x20"
        case 0x6675726c: return self.fileURL // "furl"
        case 0x66697864: return self.fixed // "fixd"
        case 0x50786566: return self.fixedLayout // "Pxef"
        case 0x66706e74: return self.fixedPoint // "fpnt"
        case 0x66726374: return self.fixedRectangle // "frct"
        case 0x666f6e74: return self.font // "font"
        case 0x4e4d666e: return self.fontName // "NMfn"
        case 0x4e4d6673: return self.fontSize // "NMfs"
        case 0x4e6d4672: return self.footerRowCount // "NmFr"
        case 0x4e4d4354: return self.format // "NMCT"
        case 0x50727466: return self.formattedText // "Prtf"
        case 0x4e4d6676: return self.formattedValue // "NMfv"
        case 0x4e4d4366: return self.formula // "NMCf"
        case 0x66667261: return self.fraction // "ffra"
        case 0x66726920: return self.Friday // "fri\0x20"
        case 0x70697366: return self.frontmost // "pisf"
        case 0x50786567: return self.genre // "Pxeg"
        case 0x47494666: return self.GIFPicture // "GIFf"
        case 0x50675030: return self.Good // "PgP0"
        case 0x66696772: return self.gradientFill // "figr"
        case 0x63677478: return self.graphicText // "cgtx"
        case 0x69677270: return self.group // "igrp"
        case 0x4e6d4843: return self.headerColumnCount // "NmHC"
        case 0x4e6d4872: return self.headerRowCount // "NmHr"
        case 0x73697468: return self.height // "sith"
        case 0x68797068: return self.hyphens // "hyph"
        case 0x49442020: return self.id // "ID\0x20\0x20"
        case 0x696d6167: return self.image // "imag"
        case 0x6669696d: return self.imageFill // "fiim"
        case 0x50785049: return self.imageQuality // "PxPI"
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
        case 0x5078656c: return self.language // "Pxel"
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
        case 0x50777264: return self.MicrosoftWord // "Pwrd"
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
        case 0x66636e73: return self.numeralSystem // "fcns"
        case 0x6e756d65: return self.numericStrings // "nume"
        case 0x70445478: return self.objectText // "pDTx"
        case 0x6f637420: return self.October // "oct\0x20"
        case 0x70534f70: return self.opacity // "pSOp"
        case 0x63506167: return self.page // "cPag"
        case 0x50506167: return self.Pages09 // "PPag"
        case 0x6c776c61: return self.pagesAcross // "lwla"
        case 0x6c776c64: return self.pagesDown // "lwld"
        case 0x50676666: return self.PagesFormat // "Pgff"
        case 0x63706172: return self.paragraph // "cpar"
        case 0x73697074: return self.parent // "sipt"
        case 0x50785057: return self.password // "PxPW"
        case 0x50785048: return self.passwordHint // "PxPH"
        case 0x50706466: return self.PDF // "Ppdf"
        case 0x66706572: return self.percent // "fper"
        case 0x50494354: return self.PICTPicture // "PICT"
        case 0x74706d6d: return self.pixelMapRecord // "tpmm"
        case 0x63706c61: return self.placeholderText // "cpla"
        case 0x51447074: return self.point // "QDpt"
        case 0x66637070: return self.popUpMenu // "fcpp"
        case 0x7369706f: return self.position // "sipo"
        case 0x70736574: return self.printSettings // "pset"
        case 0x70736e20: return self.processSerialNumber // "psn\0x20"
        case 0x70414c4c: return self.properties // "pALL"
        case 0x70726f70: return self.property_ // "prop"
        case 0x50786570: return self.publisher // "Pxep"
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
        case 0x63536563: return self.section // "cSec"
        case 0x4e4d5473: return self.selectionRange // "NMTs"
        case 0x73657020: return self.September // "sep\0x20"
        case 0x73736870: return self.shape // "sshp"
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
        case 0x63706c74: return self.tag // "cplt"
        case 0x74727072: return self.targetPrinter // "trpr"
        case 0x746d706c: return self.template // "tmpl"
        case 0x63747874: return self.text // "ctxt"
        case 0x74657843: return self.textColor // "texC"
        case 0x73687478: return self.textItem // "shtx"
        case 0x74737479: return self.textStyleInfo // "tsty"
        case 0x77726170: return self.textWrap // "wrap"
        case 0x74687520: return self.Thursday // "thu\0x20"
        case 0x54494646: return self.TIFFPicture // "TIFF"
        case 0x50786574: return self.title // "Pxet"
        case 0x61767470: return self.top // "avtp"
        case 0x74756520: return self.Tuesday // "tue\0x20"
        case 0x74797065: return self.typeClass // "type"
        case 0x50747866: return self.unformattedText // "Ptxf"
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
        default: return super.symbol(code: code, type: type, descriptor: descriptor) as! PAGSymbol
        }
    }

    // Types/properties
    public static let address = PAGSymbol(name: "address", code: 0x4e4d6164, type: typeType) // "NMad"
    public static let alias = PAGSymbol(name: "alias", code: 0x616c6973, type: typeType) // "alis"
    public static let alignment = PAGSymbol(name: "alignment", code: 0x74657841, type: typeType) // "texA"
    public static let anything = PAGSymbol(name: "anything", code: 0x2a2a2a2a, type: typeType) // "****"
    public static let application = PAGSymbol(name: "application", code: 0x63617070, type: typeType) // "capp"
    public static let applicationBundleID = PAGSymbol(name: "applicationBundleID", code: 0x62756e64, type: typeType) // "bund"
    public static let applicationSignature = PAGSymbol(name: "applicationSignature", code: 0x7369676e, type: typeType) // "sign"
    public static let applicationURL = PAGSymbol(name: "applicationURL", code: 0x6170726c, type: typeType) // "aprl"
    public static let April = PAGSymbol(name: "April", code: 0x61707220, type: typeType) // "apr\0x20"
    public static let audioClip = PAGSymbol(name: "audioClip", code: 0x73686175, type: typeType) // "shau"
    public static let August = PAGSymbol(name: "August", code: 0x61756720, type: typeType) // "aug\0x20"
    public static let author = PAGSymbol(name: "author", code: 0x50786561, type: typeType) // "Pxea"
    public static let backgroundColor = PAGSymbol(name: "backgroundColor", code: 0x63654243, type: typeType) // "ceBC"
    public static let backgroundFillType = PAGSymbol(name: "backgroundFillType", code: 0x626b6674, type: typeType) // "bkft"
    public static let best = PAGSymbol(name: "best", code: 0x62657374, type: typeType) // "best"
    public static let bodyText = PAGSymbol(name: "bodyText", code: 0x70547874, type: typeType) // "pTxt"
    public static let bookmarkData = PAGSymbol(name: "bookmarkData", code: 0x626d726b, type: typeType) // "bmrk"
    public static let boolean = PAGSymbol(name: "boolean", code: 0x626f6f6c, type: typeType) // "bool"
    public static let boundingRectangle = PAGSymbol(name: "boundingRectangle", code: 0x71647274, type: typeType) // "qdrt"
    public static let bounds = PAGSymbol(name: "bounds", code: 0x70626e64, type: typeType) // "pbnd"
    public static let cell = PAGSymbol(name: "cell", code: 0x4e6d436c, type: typeType) // "NmCl"
    public static let cellRange = PAGSymbol(name: "cellRange", code: 0x4e4d5463, type: typeType) // "NMTc"
    public static let character = PAGSymbol(name: "character", code: 0x63686120, type: typeType) // "cha\0x20"
    public static let chart = PAGSymbol(name: "chart", code: 0x73686374, type: typeType) // "shct"
    public static let class_ = PAGSymbol(name: "class_", code: 0x70636c73, type: typeType) // "pcls"
    public static let clipVolume = PAGSymbol(name: "clipVolume", code: 0x61766f6c, type: typeType) // "avol"
    public static let closeable = PAGSymbol(name: "closeable", code: 0x68636c62, type: typeType) // "hclb"
    public static let collating = PAGSymbol(name: "collating", code: 0x6c77636c, type: typeType) // "lwcl"
    public static let color = PAGSymbol(name: "color", code: 0x636f6c72, type: typeType) // "colr"
    public static let colorTable = PAGSymbol(name: "colorTable", code: 0x636c7274, type: typeType) // "clrt"
    public static let column = PAGSymbol(name: "column", code: 0x4e4d436f, type: typeType) // "NMCo"
    public static let columnCount = PAGSymbol(name: "columnCount", code: 0x4e6d5463, type: typeType) // "NmTc"
    public static let constant = PAGSymbol(name: "constant", code: 0x656e756d, type: typeType) // "enum"
    public static let copies = PAGSymbol(name: "copies", code: 0x6c776370, type: typeType) // "lwcp"
    public static let cover = PAGSymbol(name: "cover", code: 0x50786563, type: typeType) // "Pxec"
    public static let currentPage = PAGSymbol(name: "currentPage", code: 0x70437061, type: typeType) // "pCpa"
    public static let dashStyle = PAGSymbol(name: "dashStyle", code: 0x74646173, type: typeType) // "tdas"
    public static let data = PAGSymbol(name: "data", code: 0x74647461, type: typeType) // "tdta"
    public static let date = PAGSymbol(name: "date", code: 0x6c647420, type: typeType) // "ldt\0x20"
    public static let December = PAGSymbol(name: "December", code: 0x64656320, type: typeType) // "dec\0x20"
    public static let decimalStruct = PAGSymbol(name: "decimalStruct", code: 0x6465636d, type: typeType) // "decm"
    public static let description_ = PAGSymbol(name: "description_", code: 0x64736372, type: typeType) // "dscr"
    public static let document = PAGSymbol(name: "document", code: 0x646f6375, type: typeType) // "docu"
    public static let documentBody = PAGSymbol(name: "documentBody", code: 0x7044626f, type: typeType) // "pDbo"
    public static let documentTemplate = PAGSymbol(name: "documentTemplate", code: 0x546d706c, type: typeType) // "Tmpl"
    public static let doubleInteger = PAGSymbol(name: "doubleInteger", code: 0x636f6d70, type: typeType) // "comp"
    public static let encodedString = PAGSymbol(name: "encodedString", code: 0x656e6373, type: typeType) // "encs"
    public static let endingPage = PAGSymbol(name: "endingPage", code: 0x6c776c70, type: typeType) // "lwlp"
    public static let endPoint = PAGSymbol(name: "endPoint", code: 0x6c6e6570, type: typeType) // "lnep"
    public static let EPSPicture = PAGSymbol(name: "EPSPicture", code: 0x45505320, type: typeType) // "EPS\0x20"
    public static let errorHandling = PAGSymbol(name: "errorHandling", code: 0x6c776568, type: typeType) // "lweh"
    public static let exportOptions = PAGSymbol(name: "exportOptions", code: 0x50786f70, type: typeType) // "Pxop"
    public static let extendedReal = PAGSymbol(name: "extendedReal", code: 0x65787465, type: typeType) // "exte"
    public static let faxNumber = PAGSymbol(name: "faxNumber", code: 0x6661786e, type: typeType) // "faxn"
    public static let February = PAGSymbol(name: "February", code: 0x66656220, type: typeType) // "feb\0x20"
    public static let file = PAGSymbol(name: "file", code: 0x66696c65, type: typeType) // "file"
    public static let fileName = PAGSymbol(name: "fileName", code: 0x6174666e, type: typeType) // "atfn"
    public static let fileRef = PAGSymbol(name: "fileRef", code: 0x66737266, type: typeType) // "fsrf"
    public static let fileSpecification = PAGSymbol(name: "fileSpecification", code: 0x66737320, type: typeType) // "fss\0x20"
    public static let fileURL = PAGSymbol(name: "fileURL", code: 0x6675726c, type: typeType) // "furl"
    public static let fixed = PAGSymbol(name: "fixed", code: 0x66697864, type: typeType) // "fixd"
    public static let fixedLayout = PAGSymbol(name: "fixedLayout", code: 0x50786566, type: typeType) // "Pxef"
    public static let fixedPoint = PAGSymbol(name: "fixedPoint", code: 0x66706e74, type: typeType) // "fpnt"
    public static let fixedRectangle = PAGSymbol(name: "fixedRectangle", code: 0x66726374, type: typeType) // "frct"
    public static let font = PAGSymbol(name: "font", code: 0x666f6e74, type: typeType) // "font"
    public static let fontName = PAGSymbol(name: "fontName", code: 0x4e4d666e, type: typeType) // "NMfn"
    public static let fontSize = PAGSymbol(name: "fontSize", code: 0x4e4d6673, type: typeType) // "NMfs"
    public static let footerRowCount = PAGSymbol(name: "footerRowCount", code: 0x4e6d4672, type: typeType) // "NmFr"
    public static let format = PAGSymbol(name: "format", code: 0x4e4d4354, type: typeType) // "NMCT"
    public static let formattedValue = PAGSymbol(name: "formattedValue", code: 0x4e4d6676, type: typeType) // "NMfv"
    public static let formula = PAGSymbol(name: "formula", code: 0x4e4d4366, type: typeType) // "NMCf"
    public static let Friday = PAGSymbol(name: "Friday", code: 0x66726920, type: typeType) // "fri\0x20"
    public static let frontmost = PAGSymbol(name: "frontmost", code: 0x70697366, type: typeType) // "pisf"
    public static let genre = PAGSymbol(name: "genre", code: 0x50786567, type: typeType) // "Pxeg"
    public static let GIFPicture = PAGSymbol(name: "GIFPicture", code: 0x47494666, type: typeType) // "GIFf"
    public static let graphicText = PAGSymbol(name: "graphicText", code: 0x63677478, type: typeType) // "cgtx"
    public static let group = PAGSymbol(name: "group", code: 0x69677270, type: typeType) // "igrp"
    public static let headerColumnCount = PAGSymbol(name: "headerColumnCount", code: 0x4e6d4843, type: typeType) // "NmHC"
    public static let headerRowCount = PAGSymbol(name: "headerRowCount", code: 0x4e6d4872, type: typeType) // "NmHr"
    public static let height = PAGSymbol(name: "height", code: 0x73697468, type: typeType) // "sith"
    public static let id = PAGSymbol(name: "id", code: 0x49442020, type: typeType) // "ID\0x20\0x20"
    public static let image = PAGSymbol(name: "image", code: 0x696d6167, type: typeType) // "imag"
    public static let imageQuality = PAGSymbol(name: "imageQuality", code: 0x50785049, type: typeType) // "PxPI"
    public static let index = PAGSymbol(name: "index", code: 0x70696478, type: typeType) // "pidx"
    public static let integer = PAGSymbol(name: "integer", code: 0x6c6f6e67, type: typeType) // "long"
    public static let internationalText = PAGSymbol(name: "internationalText", code: 0x69747874, type: typeType) // "itxt"
    public static let internationalWritingCode = PAGSymbol(name: "internationalWritingCode", code: 0x696e746c, type: typeType) // "intl"
    public static let item = PAGSymbol(name: "item", code: 0x636f626a, type: typeType) // "cobj"
    public static let iWorkContainer = PAGSymbol(name: "iWorkContainer", code: 0x69776b63, type: typeType) // "iwkc"
    public static let iWorkItem = PAGSymbol(name: "iWorkItem", code: 0x666d7469, type: typeType) // "fmti"
    public static let January = PAGSymbol(name: "January", code: 0x6a616e20, type: typeType) // "jan\0x20"
    public static let JPEGPicture = PAGSymbol(name: "JPEGPicture", code: 0x4a504547, type: typeType) // "JPEG"
    public static let July = PAGSymbol(name: "July", code: 0x6a756c20, type: typeType) // "jul\0x20"
    public static let June = PAGSymbol(name: "June", code: 0x6a756e20, type: typeType) // "jun\0x20"
    public static let kernelProcessID = PAGSymbol(name: "kernelProcessID", code: 0x6b706964, type: typeType) // "kpid"
    public static let language = PAGSymbol(name: "language", code: 0x5078656c, type: typeType) // "Pxel"
    public static let largeReal = PAGSymbol(name: "largeReal", code: 0x6c64626c, type: typeType) // "ldbl"
    public static let line = PAGSymbol(name: "line", code: 0x69576c6e, type: typeType) // "iWln"
    public static let list = PAGSymbol(name: "list", code: 0x6c697374, type: typeType) // "list"
    public static let locationReference = PAGSymbol(name: "locationReference", code: 0x696e736c, type: typeType) // "insl"
    public static let locked = PAGSymbol(name: "locked", code: 0x704c636b, type: typeType) // "pLck"
    public static let longFixed = PAGSymbol(name: "longFixed", code: 0x6c667864, type: typeType) // "lfxd"
    public static let longFixedPoint = PAGSymbol(name: "longFixedPoint", code: 0x6c667074, type: typeType) // "lfpt"
    public static let longFixedRectangle = PAGSymbol(name: "longFixedRectangle", code: 0x6c667263, type: typeType) // "lfrc"
    public static let longPoint = PAGSymbol(name: "longPoint", code: 0x6c706e74, type: typeType) // "lpnt"
    public static let longRectangle = PAGSymbol(name: "longRectangle", code: 0x6c726374, type: typeType) // "lrct"
    public static let machine = PAGSymbol(name: "machine", code: 0x6d616368, type: typeType) // "mach"
    public static let machineLocation = PAGSymbol(name: "machineLocation", code: 0x6d4c6f63, type: typeType) // "mLoc"
    public static let machPort = PAGSymbol(name: "machPort", code: 0x706f7274, type: typeType) // "port"
    public static let March = PAGSymbol(name: "March", code: 0x6d617220, type: typeType) // "mar\0x20"
    public static let May = PAGSymbol(name: "May", code: 0x6d617920, type: typeType) // "may\0x20"
    public static let miniaturizable = PAGSymbol(name: "miniaturizable", code: 0x69736d6e, type: typeType) // "ismn"
    public static let miniaturized = PAGSymbol(name: "miniaturized", code: 0x706d6e64, type: typeType) // "pmnd"
    public static let modified = PAGSymbol(name: "modified", code: 0x696d6f64, type: typeType) // "imod"
    public static let Monday = PAGSymbol(name: "Monday", code: 0x6d6f6e20, type: typeType) // "mon\0x20"
    public static let movie = PAGSymbol(name: "movie", code: 0x73686d76, type: typeType) // "shmv"
    public static let movieVolume = PAGSymbol(name: "movieVolume", code: 0x6d766f6c, type: typeType) // "mvol"
    public static let name = PAGSymbol(name: "name", code: 0x706e616d, type: typeType) // "pnam"
    public static let November = PAGSymbol(name: "November", code: 0x6e6f7620, type: typeType) // "nov\0x20"
    public static let null = PAGSymbol(name: "null", code: 0x6e756c6c, type: typeType) // "null"
    public static let objectText = PAGSymbol(name: "objectText", code: 0x70445478, type: typeType) // "pDTx"
    public static let October = PAGSymbol(name: "October", code: 0x6f637420, type: typeType) // "oct\0x20"
    public static let opacity = PAGSymbol(name: "opacity", code: 0x70534f70, type: typeType) // "pSOp"
    public static let page = PAGSymbol(name: "page", code: 0x63506167, type: typeType) // "cPag"
    public static let pagesAcross = PAGSymbol(name: "pagesAcross", code: 0x6c776c61, type: typeType) // "lwla"
    public static let pagesDown = PAGSymbol(name: "pagesDown", code: 0x6c776c64, type: typeType) // "lwld"
    public static let paragraph = PAGSymbol(name: "paragraph", code: 0x63706172, type: typeType) // "cpar"
    public static let parent = PAGSymbol(name: "parent", code: 0x73697074, type: typeType) // "sipt"
    public static let password = PAGSymbol(name: "password", code: 0x50785057, type: typeType) // "PxPW"
    public static let passwordHint = PAGSymbol(name: "passwordHint", code: 0x50785048, type: typeType) // "PxPH"
    public static let PICTPicture = PAGSymbol(name: "PICTPicture", code: 0x50494354, type: typeType) // "PICT"
    public static let pixelMapRecord = PAGSymbol(name: "pixelMapRecord", code: 0x74706d6d, type: typeType) // "tpmm"
    public static let placeholderText = PAGSymbol(name: "placeholderText", code: 0x63706c61, type: typeType) // "cpla"
    public static let point = PAGSymbol(name: "point", code: 0x51447074, type: typeType) // "QDpt"
    public static let position = PAGSymbol(name: "position", code: 0x7369706f, type: typeType) // "sipo"
    public static let printSettings = PAGSymbol(name: "printSettings", code: 0x70736574, type: typeType) // "pset"
    public static let processSerialNumber = PAGSymbol(name: "processSerialNumber", code: 0x70736e20, type: typeType) // "psn\0x20"
    public static let properties = PAGSymbol(name: "properties", code: 0x70414c4c, type: typeType) // "pALL"
    public static let property_ = PAGSymbol(name: "property_", code: 0x70726f70, type: typeType) // "prop"
    public static let publisher = PAGSymbol(name: "publisher", code: 0x50786570, type: typeType) // "Pxep"
    public static let range = PAGSymbol(name: "range", code: 0x4e6d4352, type: typeType) // "NmCR"
    public static let real = PAGSymbol(name: "real", code: 0x646f7562, type: typeType) // "doub"
    public static let record = PAGSymbol(name: "record", code: 0x7265636f, type: typeType) // "reco"
    public static let reference = PAGSymbol(name: "reference", code: 0x6f626a20, type: typeType) // "obj\0x20"
    public static let reflectionShowing = PAGSymbol(name: "reflectionShowing", code: 0x73697273, type: typeType) // "sirs"
    public static let reflectionValue = PAGSymbol(name: "reflectionValue", code: 0x73697276, type: typeType) // "sirv"
    public static let repetitionMethod = PAGSymbol(name: "repetitionMethod", code: 0x6d767270, type: typeType) // "mvrp"
    public static let requestedPrintTime = PAGSymbol(name: "requestedPrintTime", code: 0x6c777174, type: typeType) // "lwqt"
    public static let resizable = PAGSymbol(name: "resizable", code: 0x7072737a, type: typeType) // "prsz"
    public static let RGB16Color = PAGSymbol(name: "RGB16Color", code: 0x74723136, type: typeType) // "tr16"
    public static let RGB96Color = PAGSymbol(name: "RGB96Color", code: 0x74723936, type: typeType) // "tr96"
    public static let RGBColor = PAGSymbol(name: "RGBColor", code: 0x63524742, type: typeType) // "cRGB"
    public static let richText = PAGSymbol(name: "richText", code: 0x72747874, type: typeType) // "rtxt"
    public static let rotation = PAGSymbol(name: "rotation", code: 0x74726f74, type: typeType) // "trot"
    public static let rotation_ = PAGSymbol(name: "rotation_", code: 0x7369726f, type: typeType) // "siro"
    public static let row = PAGSymbol(name: "row", code: 0x4e4d5277, type: typeType) // "NMRw"
    public static let rowCount = PAGSymbol(name: "rowCount", code: 0x4e6d5472, type: typeType) // "NmTr"
    public static let Saturday = PAGSymbol(name: "Saturday", code: 0x73617420, type: typeType) // "sat\0x20"
    public static let script = PAGSymbol(name: "script", code: 0x73637074, type: typeType) // "scpt"
    public static let section = PAGSymbol(name: "section", code: 0x63536563, type: typeType) // "cSec"
    public static let selectionRange = PAGSymbol(name: "selectionRange", code: 0x4e4d5473, type: typeType) // "NMTs"
    public static let September = PAGSymbol(name: "September", code: 0x73657020, type: typeType) // "sep\0x20"
    public static let shape = PAGSymbol(name: "shape", code: 0x73736870, type: typeType) // "sshp"
    public static let shortInteger = PAGSymbol(name: "shortInteger", code: 0x73686f72, type: typeType) // "shor"
    public static let size = PAGSymbol(name: "size", code: 0x7074737a, type: typeType) // "ptsz"
    public static let smallReal = PAGSymbol(name: "smallReal", code: 0x73696e67, type: typeType) // "sing"
    public static let startingPage = PAGSymbol(name: "startingPage", code: 0x6c776670, type: typeType) // "lwfp"
    public static let startPoint = PAGSymbol(name: "startPoint", code: 0x6c6e7370, type: typeType) // "lnsp"
    public static let string = PAGSymbol(name: "string", code: 0x54455854, type: typeType) // "TEXT"
    public static let styledClipboardText = PAGSymbol(name: "styledClipboardText", code: 0x7374796c, type: typeType) // "styl"
    public static let styledText = PAGSymbol(name: "styledText", code: 0x53545854, type: typeType) // "STXT"
    public static let Sunday = PAGSymbol(name: "Sunday", code: 0x73756e20, type: typeType) // "sun\0x20"
    public static let table = PAGSymbol(name: "table", code: 0x4e6d5462, type: typeType) // "NmTb"
    public static let tag = PAGSymbol(name: "tag", code: 0x63706c74, type: typeType) // "cplt"
    public static let targetPrinter = PAGSymbol(name: "targetPrinter", code: 0x74727072, type: typeType) // "trpr"
    public static let template = PAGSymbol(name: "template", code: 0x746d706c, type: typeType) // "tmpl"
    public static let textColor = PAGSymbol(name: "textColor", code: 0x74657843, type: typeType) // "texC"
    public static let textItem = PAGSymbol(name: "textItem", code: 0x73687478, type: typeType) // "shtx"
    public static let textStyleInfo = PAGSymbol(name: "textStyleInfo", code: 0x74737479, type: typeType) // "tsty"
    public static let textWrap = PAGSymbol(name: "textWrap", code: 0x77726170, type: typeType) // "wrap"
    public static let Thursday = PAGSymbol(name: "Thursday", code: 0x74687520, type: typeType) // "thu\0x20"
    public static let TIFFPicture = PAGSymbol(name: "TIFFPicture", code: 0x54494646, type: typeType) // "TIFF"
    public static let title = PAGSymbol(name: "title", code: 0x50786574, type: typeType) // "Pxet"
    public static let Tuesday = PAGSymbol(name: "Tuesday", code: 0x74756520, type: typeType) // "tue\0x20"
    public static let typeClass = PAGSymbol(name: "typeClass", code: 0x74797065, type: typeType) // "type"
    public static let UnicodeText = PAGSymbol(name: "UnicodeText", code: 0x75747874, type: typeType) // "utxt"
    public static let unsignedDoubleInteger = PAGSymbol(name: "unsignedDoubleInteger", code: 0x75636f6d, type: typeType) // "ucom"
    public static let unsignedInteger = PAGSymbol(name: "unsignedInteger", code: 0x6d61676e, type: typeType) // "magn"
    public static let unsignedShortInteger = PAGSymbol(name: "unsignedShortInteger", code: 0x75736872, type: typeType) // "ushr"
    public static let UTF16Text = PAGSymbol(name: "UTF16Text", code: 0x75743136, type: typeType) // "ut16"
    public static let UTF8Text = PAGSymbol(name: "UTF8Text", code: 0x75746638, type: typeType) // "utf8"
    public static let value = PAGSymbol(name: "value", code: 0x4e4d4376, type: typeType) // "NMCv"
    public static let version = PAGSymbol(name: "version", code: 0x76657273, type: typeType) // "vers"
    public static let verticalAlignment = PAGSymbol(name: "verticalAlignment", code: 0x74785641, type: typeType) // "txVA"
    public static let visible = PAGSymbol(name: "visible", code: 0x70766973, type: typeType) // "pvis"
    public static let Wednesday = PAGSymbol(name: "Wednesday", code: 0x77656420, type: typeType) // "wed\0x20"
    public static let width = PAGSymbol(name: "width", code: 0x73697477, type: typeType) // "sitw"
    public static let window = PAGSymbol(name: "window", code: 0x6377696e, type: typeType) // "cwin"
    public static let word = PAGSymbol(name: "word", code: 0x63776f72, type: typeType) // "cwor"
    public static let writingCode = PAGSymbol(name: "writingCode", code: 0x70736374, type: typeType) // "psct"
    public static let zoomable = PAGSymbol(name: "zoomable", code: 0x69737a6d, type: typeType) // "iszm"
    public static let zoomed = PAGSymbol(name: "zoomed", code: 0x707a756d, type: typeType) // "pzum"

    // Enumerators
    public static let advancedGradientFill = PAGSymbol(name: "advancedGradientFill", code: 0x66696167, type: typeEnumerated) // "fiag"
    public static let advancedImageFill = PAGSymbol(name: "advancedImageFill", code: 0x66696169, type: typeEnumerated) // "fiai"
    public static let ascending = PAGSymbol(name: "ascending", code: 0x6173636e, type: typeEnumerated) // "ascn"
    public static let ask = PAGSymbol(name: "ask", code: 0x61736b20, type: typeEnumerated) // "ask\0x20"
    public static let autoAlign = PAGSymbol(name: "autoAlign", code: 0x61617574, type: typeEnumerated) // "aaut"
    public static let automatic = PAGSymbol(name: "automatic", code: 0x66617574, type: typeEnumerated) // "faut"
    public static let Best = PAGSymbol(name: "Best", code: 0x50675032, type: typeEnumerated) // "PgP2"
    public static let Better = PAGSymbol(name: "Better", code: 0x50675031, type: typeEnumerated) // "PgP1"
    public static let bottom = PAGSymbol(name: "bottom", code: 0x61766274, type: typeEnumerated) // "avbt"
    public static let case_ = PAGSymbol(name: "case_", code: 0x63617365, type: typeEnumerated) // "case"
    public static let center = PAGSymbol(name: "center", code: 0x61637472, type: typeEnumerated) // "actr"
    public static let checkbox = PAGSymbol(name: "checkbox", code: 0x66636368, type: typeEnumerated) // "fcch"
    public static let colorFill = PAGSymbol(name: "colorFill", code: 0x6669636f, type: typeEnumerated) // "fico"
    public static let currency = PAGSymbol(name: "currency", code: 0x66637572, type: typeEnumerated) // "fcur"
    public static let dateAndTime = PAGSymbol(name: "dateAndTime", code: 0x6664746d, type: typeEnumerated) // "fdtm"
    public static let descending = PAGSymbol(name: "descending", code: 0x6473636e, type: typeEnumerated) // "dscn"
    public static let detailed = PAGSymbol(name: "detailed", code: 0x6c776474, type: typeEnumerated) // "lwdt"
    public static let diacriticals = PAGSymbol(name: "diacriticals", code: 0x64696163, type: typeEnumerated) // "diac"
    public static let duration = PAGSymbol(name: "duration", code: 0x66647572, type: typeEnumerated) // "fdur"
    public static let EPUB = PAGSymbol(name: "EPUB", code: 0x50657075, type: typeEnumerated) // "Pepu"
    public static let expansion = PAGSymbol(name: "expansion", code: 0x65787061, type: typeEnumerated) // "expa"
    public static let formattedText = PAGSymbol(name: "formattedText", code: 0x50727466, type: typeEnumerated) // "Prtf"
    public static let fraction = PAGSymbol(name: "fraction", code: 0x66667261, type: typeEnumerated) // "ffra"
    public static let Good = PAGSymbol(name: "Good", code: 0x50675030, type: typeEnumerated) // "PgP0"
    public static let gradientFill = PAGSymbol(name: "gradientFill", code: 0x66696772, type: typeEnumerated) // "figr"
    public static let hyphens = PAGSymbol(name: "hyphens", code: 0x68797068, type: typeEnumerated) // "hyph"
    public static let imageFill = PAGSymbol(name: "imageFill", code: 0x6669696d, type: typeEnumerated) // "fiim"
    public static let justify = PAGSymbol(name: "justify", code: 0x616a7374, type: typeEnumerated) // "ajst"
    public static let left = PAGSymbol(name: "left", code: 0x616c6674, type: typeEnumerated) // "alft"
    public static let loop = PAGSymbol(name: "loop", code: 0x6d766c70, type: typeEnumerated) // "mvlp"
    public static let loopBackAndForth = PAGSymbol(name: "loopBackAndForth", code: 0x6d766266, type: typeEnumerated) // "mvbf"
    public static let MicrosoftWord = PAGSymbol(name: "MicrosoftWord", code: 0x50777264, type: typeEnumerated) // "Pwrd"
    public static let no = PAGSymbol(name: "no", code: 0x6e6f2020, type: typeEnumerated) // "no\0x20\0x20"
    public static let noFill = PAGSymbol(name: "noFill", code: 0x66696e6f, type: typeEnumerated) // "fino"
    public static let none = PAGSymbol(name: "none", code: 0x6d76726e, type: typeEnumerated) // "mvrn"
    public static let number = PAGSymbol(name: "number", code: 0x6e6d6272, type: typeEnumerated) // "nmbr"
    public static let numeralSystem = PAGSymbol(name: "numeralSystem", code: 0x66636e73, type: typeEnumerated) // "fcns"
    public static let numericStrings = PAGSymbol(name: "numericStrings", code: 0x6e756d65, type: typeEnumerated) // "nume"
    public static let Pages09 = PAGSymbol(name: "Pages09", code: 0x50506167, type: typeEnumerated) // "PPag"
    public static let PagesFormat = PAGSymbol(name: "PagesFormat", code: 0x50676666, type: typeEnumerated) // "Pgff"
    public static let PDF = PAGSymbol(name: "PDF", code: 0x50706466, type: typeEnumerated) // "Ppdf"
    public static let percent = PAGSymbol(name: "percent", code: 0x66706572, type: typeEnumerated) // "fper"
    public static let popUpMenu = PAGSymbol(name: "popUpMenu", code: 0x66637070, type: typeEnumerated) // "fcpp"
    public static let punctuation = PAGSymbol(name: "punctuation", code: 0x70756e63, type: typeEnumerated) // "punc"
    public static let rating = PAGSymbol(name: "rating", code: 0x66726174, type: typeEnumerated) // "frat"
    public static let right = PAGSymbol(name: "right", code: 0x61726974, type: typeEnumerated) // "arit"
    public static let scientific = PAGSymbol(name: "scientific", code: 0x66736369, type: typeEnumerated) // "fsci"
    public static let slider = PAGSymbol(name: "slider", code: 0x6663736c, type: typeEnumerated) // "fcsl"
    public static let standard = PAGSymbol(name: "standard", code: 0x6c777374, type: typeEnumerated) // "lwst"
    public static let stepper = PAGSymbol(name: "stepper", code: 0x66637374, type: typeEnumerated) // "fcst"
    public static let text = PAGSymbol(name: "text", code: 0x63747874, type: typeEnumerated) // "ctxt"
    public static let top = PAGSymbol(name: "top", code: 0x61767470, type: typeEnumerated) // "avtp"
    public static let unformattedText = PAGSymbol(name: "unformattedText", code: 0x50747866, type: typeEnumerated) // "Ptxf"
    public static let whitespace = PAGSymbol(name: "whitespace", code: 0x77686974, type: typeEnumerated) // "whit"
    public static let yes = PAGSymbol(name: "yes", code: 0x79657320, type: typeEnumerated) // "yes\0x20"
}

public typealias PAG = PAGSymbol // allows symbols to be written as (e.g.) PAG.name instead of PAGSymbol.name


/******************************************************************************/
// Specifier extensions; these add command methods and property/elements getters based on Pages.app terminology

public protocol PAGCommand: SwiftAutomation.SpecifierProtocol {} // provides AE dispatch methods

// Command->Any will be bound when return type can't be inferred, else Command->T

extension PAGCommand {
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
        return try self.appData.sendAppleEvent(name: "export", eventClass: 0x50677374, eventID: 0x6578706f, // "Pgst"/"expo"
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
        return try self.appData.sendAppleEvent(name: "export", eventClass: 0x50677374, eventID: 0x6578706f, // "Pgst"/"expo"
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


public protocol PAGObject: SwiftAutomation.ObjectSpecifierExtension, PAGCommand {} // provides vars and methods for constructing specifiers

extension PAGObject {
    
    // Properties
    public var address: PAGItem {return self.property(0x4e4d6164) as! PAGItem} // "NMad"
    public var alignment: PAGItem {return self.property(0x74657841) as! PAGItem} // "texA"
    public var author: PAGItem {return self.property(0x50786561) as! PAGItem} // "Pxea"
    public var backgroundColor: PAGItem {return self.property(0x63654243) as! PAGItem} // "ceBC"
    public var backgroundFillType: PAGItem {return self.property(0x626b6674) as! PAGItem} // "bkft"
    public var bodyText: PAGItem {return self.property(0x70547874) as! PAGItem} // "pTxt"
    public var bounds: PAGItem {return self.property(0x70626e64) as! PAGItem} // "pbnd"
    public var cellRange: PAGItem {return self.property(0x4e4d5463) as! PAGItem} // "NMTc"
    public var class_: PAGItem {return self.property(0x70636c73) as! PAGItem} // "pcls"
    public var clipVolume: PAGItem {return self.property(0x61766f6c) as! PAGItem} // "avol"
    public var closeable: PAGItem {return self.property(0x68636c62) as! PAGItem} // "hclb"
    public var collating: PAGItem {return self.property(0x6c77636c) as! PAGItem} // "lwcl"
    public var color: PAGItem {return self.property(0x636f6c72) as! PAGItem} // "colr"
    public var column: PAGItem {return self.property(0x4e4d436f) as! PAGItem} // "NMCo"
    public var columnCount: PAGItem {return self.property(0x4e6d5463) as! PAGItem} // "NmTc"
    public var copies: PAGItem {return self.property(0x6c776370) as! PAGItem} // "lwcp"
    public var cover: PAGItem {return self.property(0x50786563) as! PAGItem} // "Pxec"
    public var currentPage: PAGItem {return self.property(0x70437061) as! PAGItem} // "pCpa"
    public var description_: PAGItem {return self.property(0x64736372) as! PAGItem} // "dscr"
    public var document: PAGItem {return self.property(0x646f6375) as! PAGItem} // "docu"
    public var documentBody: PAGItem {return self.property(0x7044626f) as! PAGItem} // "pDbo"
    public var documentTemplate: PAGItem {return self.property(0x546d706c) as! PAGItem} // "Tmpl"
    public var endingPage: PAGItem {return self.property(0x6c776c70) as! PAGItem} // "lwlp"
    public var endPoint: PAGItem {return self.property(0x6c6e6570) as! PAGItem} // "lnep"
    public var errorHandling: PAGItem {return self.property(0x6c776568) as! PAGItem} // "lweh"
    public var faxNumber: PAGItem {return self.property(0x6661786e) as! PAGItem} // "faxn"
    public var file: PAGItem {return self.property(0x66696c65) as! PAGItem} // "file"
    public var fileName: PAGItem {return self.property(0x6174666e) as! PAGItem} // "atfn"
    public var fixedLayout: PAGItem {return self.property(0x50786566) as! PAGItem} // "Pxef"
    public var font: PAGItem {return self.property(0x666f6e74) as! PAGItem} // "font"
    public var fontName: PAGItem {return self.property(0x4e4d666e) as! PAGItem} // "NMfn"
    public var fontSize: PAGItem {return self.property(0x4e4d6673) as! PAGItem} // "NMfs"
    public var footerRowCount: PAGItem {return self.property(0x4e6d4672) as! PAGItem} // "NmFr"
    public var format: PAGItem {return self.property(0x4e4d4354) as! PAGItem} // "NMCT"
    public var formattedValue: PAGItem {return self.property(0x4e4d6676) as! PAGItem} // "NMfv"
    public var formula: PAGItem {return self.property(0x4e4d4366) as! PAGItem} // "NMCf"
    public var frontmost: PAGItem {return self.property(0x70697366) as! PAGItem} // "pisf"
    public var genre: PAGItem {return self.property(0x50786567) as! PAGItem} // "Pxeg"
    public var headerColumnCount: PAGItem {return self.property(0x4e6d4843) as! PAGItem} // "NmHC"
    public var headerRowCount: PAGItem {return self.property(0x4e6d4872) as! PAGItem} // "NmHr"
    public var height: PAGItem {return self.property(0x73697468) as! PAGItem} // "sith"
    public var id: PAGItem {return self.property(0x49442020) as! PAGItem} // "ID\0x20\0x20"
    public var imageQuality: PAGItem {return self.property(0x50785049) as! PAGItem} // "PxPI"
    public var index: PAGItem {return self.property(0x70696478) as! PAGItem} // "pidx"
    public var language: PAGItem {return self.property(0x5078656c) as! PAGItem} // "Pxel"
    public var locked: PAGItem {return self.property(0x704c636b) as! PAGItem} // "pLck"
    public var miniaturizable: PAGItem {return self.property(0x69736d6e) as! PAGItem} // "ismn"
    public var miniaturized: PAGItem {return self.property(0x706d6e64) as! PAGItem} // "pmnd"
    public var modified: PAGItem {return self.property(0x696d6f64) as! PAGItem} // "imod"
    public var movieVolume: PAGItem {return self.property(0x6d766f6c) as! PAGItem} // "mvol"
    public var name: PAGItem {return self.property(0x706e616d) as! PAGItem} // "pnam"
    public var objectText: PAGItem {return self.property(0x70445478) as! PAGItem} // "pDTx"
    public var opacity: PAGItem {return self.property(0x70534f70) as! PAGItem} // "pSOp"
    public var pagesAcross: PAGItem {return self.property(0x6c776c61) as! PAGItem} // "lwla"
    public var pagesDown: PAGItem {return self.property(0x6c776c64) as! PAGItem} // "lwld"
    public var parent: PAGItem {return self.property(0x73697074) as! PAGItem} // "sipt"
    public var password: PAGItem {return self.property(0x50785057) as! PAGItem} // "PxPW"
    public var passwordHint: PAGItem {return self.property(0x50785048) as! PAGItem} // "PxPH"
    public var position: PAGItem {return self.property(0x7369706f) as! PAGItem} // "sipo"
    public var properties: PAGItem {return self.property(0x70414c4c) as! PAGItem} // "pALL"
    public var publisher: PAGItem {return self.property(0x50786570) as! PAGItem} // "Pxep"
    public var reflectionShowing: PAGItem {return self.property(0x73697273) as! PAGItem} // "sirs"
    public var reflectionValue: PAGItem {return self.property(0x73697276) as! PAGItem} // "sirv"
    public var repetitionMethod: PAGItem {return self.property(0x6d767270) as! PAGItem} // "mvrp"
    public var requestedPrintTime: PAGItem {return self.property(0x6c777174) as! PAGItem} // "lwqt"
    public var resizable: PAGItem {return self.property(0x7072737a) as! PAGItem} // "prsz"
    public var rotation_: PAGItem {return self.property(0x7369726f) as! PAGItem} // "siro"
    public var row: PAGItem {return self.property(0x4e4d5277) as! PAGItem} // "NMRw"
    public var rowCount: PAGItem {return self.property(0x4e6d5472) as! PAGItem} // "NmTr"
    public var selectionRange: PAGItem {return self.property(0x4e4d5473) as! PAGItem} // "NMTs"
    public var size: PAGItem {return self.property(0x7074737a) as! PAGItem} // "ptsz"
    public var startingPage: PAGItem {return self.property(0x6c776670) as! PAGItem} // "lwfp"
    public var startPoint: PAGItem {return self.property(0x6c6e7370) as! PAGItem} // "lnsp"
    public var tag: PAGItem {return self.property(0x63706c74) as! PAGItem} // "cplt"
    public var targetPrinter: PAGItem {return self.property(0x74727072) as! PAGItem} // "trpr"
    public var textColor: PAGItem {return self.property(0x74657843) as! PAGItem} // "texC"
    public var textWrap: PAGItem {return self.property(0x77726170) as! PAGItem} // "wrap"
    public var title: PAGItem {return self.property(0x50786574) as! PAGItem} // "Pxet"
    public var value: PAGItem {return self.property(0x4e4d4376) as! PAGItem} // "NMCv"
    public var version: PAGItem {return self.property(0x76657273) as! PAGItem} // "vers"
    public var verticalAlignment: PAGItem {return self.property(0x74785641) as! PAGItem} // "txVA"
    public var visible: PAGItem {return self.property(0x70766973) as! PAGItem} // "pvis"
    public var width: PAGItem {return self.property(0x73697477) as! PAGItem} // "sitw"
    public var zoomable: PAGItem {return self.property(0x69737a6d) as! PAGItem} // "iszm"
    public var zoomed: PAGItem {return self.property(0x707a756d) as! PAGItem} // "pzum"

    // Elements
    public var applications: PAGItems {return self.elements(0x63617070) as! PAGItems} // "capp"
    public var audioClips: PAGItems {return self.elements(0x73686175) as! PAGItems} // "shau"
    public var cells: PAGItems {return self.elements(0x4e6d436c) as! PAGItems} // "NmCl"
    public var characters: PAGItems {return self.elements(0x63686120) as! PAGItems} // "cha\0x20"
    public var charts: PAGItems {return self.elements(0x73686374) as! PAGItems} // "shct"
    public var columns: PAGItems {return self.elements(0x4e4d436f) as! PAGItems} // "NMCo"
    public var documents: PAGItems {return self.elements(0x646f6375) as! PAGItems} // "docu"
    public var groups: PAGItems {return self.elements(0x69677270) as! PAGItems} // "igrp"
    public var images: PAGItems {return self.elements(0x696d6167) as! PAGItems} // "imag"
    public var items: PAGItems {return self.elements(0x636f626a) as! PAGItems} // "cobj"
    public var iWorkContainers: PAGItems {return self.elements(0x69776b63) as! PAGItems} // "iwkc"
    public var iWorkItems: PAGItems {return self.elements(0x666d7469) as! PAGItems} // "fmti"
    public var lines: PAGItems {return self.elements(0x69576c6e) as! PAGItems} // "iWln"
    public var movies: PAGItems {return self.elements(0x73686d76) as! PAGItems} // "shmv"
    public var pages: PAGItems {return self.elements(0x63506167) as! PAGItems} // "cPag"
    public var paragraphs: PAGItems {return self.elements(0x63706172) as! PAGItems} // "cpar"
    public var placeholderTexts: PAGItems {return self.elements(0x63706c61) as! PAGItems} // "cpla"
    public var ranges: PAGItems {return self.elements(0x4e6d4352) as! PAGItems} // "NmCR"
    public var richText: PAGItems {return self.elements(0x72747874) as! PAGItems} // "rtxt"
    public var rows: PAGItems {return self.elements(0x4e4d5277) as! PAGItems} // "NMRw"
    public var sections: PAGItems {return self.elements(0x63536563) as! PAGItems} // "cSec"
    public var shapes: PAGItems {return self.elements(0x73736870) as! PAGItems} // "sshp"
    public var tables: PAGItems {return self.elements(0x4e6d5462) as! PAGItems} // "NmTb"
    public var templates: PAGItems {return self.elements(0x746d706c) as! PAGItems} // "tmpl"
    public var textItems: PAGItems {return self.elements(0x73687478) as! PAGItems} // "shtx"
    public var windows: PAGItems {return self.elements(0x6377696e) as! PAGItems} // "cwin"
    public var words: PAGItems {return self.elements(0x63776f72) as! PAGItems} // "cwor"
}


/******************************************************************************/
// Specifier subclasses add app-specific extensions

// beginning/end/before/after
public class PAGInsertion: SwiftAutomation.InsertionSpecifier, PAGCommand {}


// property/by-index/by-name/by-id/previous/next/first/middle/last/any
public class PAGItem: SwiftAutomation.ObjectSpecifier, PAGObject {
    public typealias InsertionSpecifierType = PAGInsertion
    public typealias ObjectSpecifierType = PAGItem
    public typealias MultipleObjectSpecifierType = PAGItems
}

// by-range/by-test/all
public class PAGItems: PAGItem, SwiftAutomation.MultipleObjectSpecifierExtension {}

// App/Con/Its
public class PAGRoot: SwiftAutomation.RootSpecifier, PAGObject, SwiftAutomation.RootSpecifierExtension {
    public typealias InsertionSpecifierType = PAGInsertion
    public typealias ObjectSpecifierType = PAGItem
    public typealias MultipleObjectSpecifierType = PAGItems
    public override class var untargetedAppData: SwiftAutomation.AppData { return _untargetedAppData }
}

// Application
public class Pages: PAGRoot, SwiftAutomation.Application {
    public convenience init(launchOptions: SwiftAutomation.LaunchOptions = SwiftAutomation.DefaultLaunchOptions, relaunchMode: SwiftAutomation.RelaunchMode = SwiftAutomation.DefaultRelaunchMode) {
        self.init(rootObject: SwiftAutomation.AppRootDesc, appData: Swift.type(of:self).untargetedAppData.targetedCopy(
                  .bundleIdentifier("com.apple.iWork.Pages", true), launchOptions: launchOptions, relaunchMode: relaunchMode))
    }
}

// App/Con/Its root objects used to construct untargeted specifiers; these can be used to construct specifiers for use in commands, though cannot send commands themselves

public let PAGApp = _untargetedAppData.app as! PAGRoot
public let PAGCon = _untargetedAppData.con as! PAGRoot
public let PAGIts = _untargetedAppData.its as! PAGRoot


/******************************************************************************/
// Static types

public typealias PAGRecord = [PAGSymbol:Any] // default Swift type for AERecordDescs







