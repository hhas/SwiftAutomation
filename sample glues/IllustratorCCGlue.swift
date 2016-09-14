//
//  IllustratorCCGlue.swift
//  Adobe Illustrator.app 20.1.0
//  SwiftAE.framework 0.1.0
//  `aeglue -r Adobe Illustrator.app`
//


import Foundation
//import SwiftAE


/******************************************************************************/
// Untargeted AppData instance used in App, Con, Its roots; also used by Application constructors to create their own targeted AppData instances

private let gUntargetedAppData = AppData(glueInfo: GlueInfo(insertionSpecifierType: ICCInsertion.self,
                                                            objectSpecifierType: ICCObject.self,
                                                            elementsSpecifierType: ICCElements.self,
                                                            rootSpecifierType: ICCRoot.self,
                                                            symbolType: ICCSymbol.self,
                                                            formatter: gSpecifierFormatter))


/******************************************************************************/
// Specifier formatter

private let gSpecifierFormatter = SpecifierFormatter(applicationClassName: "IllustratorCC",
                                                     classNamePrefix: "ICC",
                                                     propertyNames: [
                                                                     0x4c616241: "a", // "LabA"
                                                                     0x703e504c: "acrobatLayers", // "p>PL"
                                                                     0x70415452: "addToRecentFiles", // "pATR"
                                                                     0x70433134: "akiLeft", // "pC14"
                                                                     0x70433135: "akiRight", // "pC15"
                                                                     0x54733031: "alignment", // "Ts01"
                                                                     0x703e5041: "allowPrinting", // "p>PA"
                                                                     0x70433075: "alternateGlyphs", // "pC0u"
                                                                     0x70414150: "alterPathsForAppearance", // "pAAP"
                                                                     0x70416e63: "anchor", // "pAnc"
                                                                     0x74724143: "anchorCount", // "trAC"
                                                                     0x7041474c: "angle", // "pAGL"
                                                                     0x70544161: "antialias", // "pTAa"
                                                                     0x74544141: "antialiasing", // "tTAA"
                                                                     0x70416e41: "antialiasing", // "pAnA"
                                                                     0x65414c53: "antialiasingMethod", // "eALS"
                                                                     0x61694152: "area", // "aiAR"
                                                                     0x70414243: "artboardClipping", // "pABC"
                                                                     0x70414c79: "artboardLayout", // "pALy"
                                                                     0x70503463: "artboardRange", // "pP4c"
                                                                     0x62416c31: "artboardRectangle", // "bAl1"
                                                                     0x70415243: "artboardRowsOrCols", // "pARC"
                                                                     0x70415370: "artboardSpacing", // "pASp"
                                                                     0x70464143: "artClipping", // "pFAC"
                                                                     0x666c7470: "as_", // "fltp"
                                                                     0x70504632: "AutoCADFileOptions", // "pPF2"
                                                                     0x70415653: "AutoCADVersion", // "pAVS"
                                                                     0x70543037: "autoKerning0x28obsoleteUse0x27kerningMethod0x270x29", // "pT07"
                                                                     0x70433033: "autoLeading", // "pC03"
                                                                     0x63504161: "autoLeadingAmount", // "cPAa"
                                                                     0x4c616242: "b", // "LabB"
                                                                     0x7042424b: "backgroundBlack", // "pBBK"
                                                                     0x70464243: "backgroundColor", // "pFBC"
                                                                     0x7046424c: "backgroundLayers", // "pFBL"
                                                                     0x70433073: "baselineDirection", // "pC0s"
                                                                     0x70433035: "baselinePosition", // "pC05"
                                                                     0x70543034: "baselineShift", // "pT04"
                                                                     0x70627374: "bestType", // "pbst"
                                                                     0x70503039: "binaryPrinting", // "pP09"
                                                                     0x70503461: "bitmapResolution", // "pP4a"
                                                                     0x63425043: "bitsPerChannel", // "cBPC"
                                                                     0x424c414b: "black", // "BLAK"
                                                                     0x703e424b: "bleedLink", // "p>BK"
                                                                     0x70503737: "bleedOffset", // "pP77"
                                                                     0x70464241: "blendAnimation", // "pFBA"
                                                                     0x70426c4d: "blendMode", // "pBlM"
                                                                     0x70466250: "blendsPolicy", // "pFbP"
                                                                     0x424c5545: "blue", // "BLUE"
                                                                     0x70426c41: "blur", // "pBlA"
                                                                     0x61694258: "boundingBox", // "aiBX"
                                                                     0x70626e64: "bounds", // "pbnd"
                                                                     0x78794241: "browserAvailable", // "xyBA"
                                                                     0x70414142: "buildNumber", // "pAAB"
                                                                     0x65504a38: "BunriKinshi", // "ePJ8"
                                                                     0x65504a39: "BurasagariType", // "ePJ9"
                                                                     0x7454424f: "ByteOrder", // "tTBO"
                                                                     0x70433034: "capitalization", // "pC04"
                                                                     0x70434177: "centerArtwork", // "pCAw"
                                                                     0x61694354: "centerPoint", // "aiCT"
                                                                     0x703e4347: "changesAllowed", // "p>CG"
                                                                     0x6343484e: "channels", // "cCHN"
                                                                     0x70535452: "characterOffset", // "pSTR"
                                                                     0x70636c73: "class_", // "pcls"
                                                                     0x70506e36: "clipComplexRegions", // "pPn6"
                                                                     0x61694370: "clipped", // "aiCp"
                                                                     0x61694350: "clipping", // "aiCP"
                                                                     0x704d534b: "clippingMask", // "pMSK"
                                                                     0x6169436c: "closed", // "aiCl"
                                                                     0x70435053: "CMYKPostScript", // "pCPS"
                                                                     0x70503437: "collate", // "pP47"
                                                                     0x636f6c72: "color", // "colr"
                                                                     0x634f4c73: "colorants", // "cOLs"
                                                                     0x70503735: "colorBars", // "pP75"
                                                                     0x703e4362: "colorCompression", // "p>Cb"
                                                                     0x703e4343: "colorConversionId", // "p>CC"
                                                                     0x70436c43: "colorCount", // "pClC"
                                                                     0x703e434e: "colorDestinationId", // "p>CN"
                                                                     0x70434474: "colorDither", // "pCDt"
                                                                     0x703e4344: "colorDownsampling", // "p>CD"
                                                                     0x703e4341: "colorDownsamplingThreshold", // "p>CA"
                                                                     0x746f4d63: "colorFidelity", // "toMc"
                                                                     0x746f4367: "colorgroup", // "toCg"
                                                                     0x63434f4c: "colorized", // "cCOL"
                                                                     0x70503362: "colorManagementSettings", // "pP3b"
                                                                     0x7044434d: "colorMode", // "pDCM"
                                                                     0x65434d64: "colorModel", // "eCMd"
                                                                     0x703e4350: "colorProfileId", // "p>CP"
                                                                     0x7043504e: "colorProfileName", // "pCPN"
                                                                     0x70435264: "colorReduction", // "pCRd"
                                                                     0x703e4353: "colorResample", // "p>CS"
                                                                     0x7041434c: "colors", // "pACL"
                                                                     0x70503336: "colorSeparationSettings", // "pP36"
                                                                     0x7043534c: "colorSettings", // "pCSL"
                                                                     0x63614353: "colorSpace", // "caCS"
                                                                     0x70503033: "colorSupport", // "pP03"
                                                                     0x703e4354: "colorTileSize", // "p>CT"
                                                                     0x70614354: "colorType", // "paCT"
                                                                     0x70434c43: "columnCount", // "pCLC"
                                                                     0x70434c47: "columnGutter", // "pCLG"
                                                                     0x70494370: "compatibility", // "pICp"
                                                                     0x70434750: "compatibleGradientPrinting", // "pCGP"
                                                                     0x70503935: "compatibleShading", // "pP95"
                                                                     0x70454353: "compoundShapes", // "pECS"
                                                                     0x703e544c: "compressArt", // "p>TL"
                                                                     0x70434463: "compressed", // "pCDc"
                                                                     0x7043306a: "connectionForms", // "pC0j"
                                                                     0x63746e72: "container", // "ctnr"
                                                                     0x70434e54: "contents", // "pCNT"
                                                                     0x70434f56: "contentVariable", // "pCOV"
                                                                     0x70433063: "contextualLigature", // "pC0c"
                                                                     0x61694e58: "controlBounds", // "aiNX"
                                                                     0x70434341: "convertCropAreaToArtboard", // "pCCA"
                                                                     0x7043744e: "converted", // "pCtN"
                                                                     0x70503532: "convertSpotColors", // "pP52"
                                                                     0x70506e35: "convertStrokesToOutlines", // "pPn5"
                                                                     0x70506e34: "convertTextToOutlines", // "pPn4"
                                                                     0x70435441: "convertTilesToArtboard", // "pCTA"
                                                                     0x70446350: "coordinatePrecision", // "pDcP"
                                                                     0x70503337: "coordinateSettings", // "pP37"
                                                                     0x70436f53: "coordinateSystem", // "pCoS"
                                                                     0x70503433: "copies", // "pP43"
                                                                     0x746f4372: "CornerFidelity", // "toCr"
                                                                     0x70434142: "createArtboardWithArtworkBoundingBox", // "pCAB"
                                                                     0x78784342: "cropMarks", // "xxCB"
                                                                     0x78784353: "cropStyle", // "xxCS"
                                                                     0x70435353: "CSSProperties", // "pCSS"
                                                                     0x70414944: "currentAdobeId", // "pAID"
                                                                     0x70444144: "currentDataset", // "pDAD"
                                                                     0x61694144: "currentDocument", // "aiAD"
                                                                     0x6169434c: "currentLayer", // "aiCL"
                                                                     0x70474944: "currentUserGuid", // "pGID"
                                                                     0x61694356: "currentView", // "aiCV"
                                                                     0x70464351: "curveQuality", // "pFCQ"
                                                                     0x70506d36: "customColor", // "pPm6"
                                                                     0x70503232: "customPaper", // "pP22"
                                                                     0x70503036: "customPaperSizes", // "pP06"
                                                                     0x70503037: "customPaperTransverse", // "pP07"
                                                                     0x4359414e: "cyan", // "CYAN"
                                                                     0x54733032: "decimalCharacter", // "Ts02"
                                                                     0x61474353: "defaultColorSettings", // "aGCS"
                                                                     0x44694643: "defaultFillColor", // "DiFC"
                                                                     0x44694650: "defaultFilled", // "DiFP"
                                                                     0x4469464f: "defaultFillOverprint", // "DiFO"
                                                                     0x70503034: "defaultResolution", // "pP04"
                                                                     0x70506231: "defaultScreen", // "pPb1"
                                                                     0x44694378: "defaultStrokeCap", // "DiCx"
                                                                     0x44695343: "defaultStrokeColor", // "DiSC"
                                                                     0x44695350: "defaultStroked", // "DiSP"
                                                                     0x44694453: "defaultStrokeDashes", // "DiDS"
                                                                     0x4469444f: "defaultStrokeDashOffset", // "DiDO"
                                                                     0x44694a6e: "defaultStrokeJoin", // "DiJn"
                                                                     0x44694d78: "defaultStrokeMiterLimit", // "DiMx"
                                                                     0x4469534f: "defaultStrokeOverprint", // "DiSO"
                                                                     0x44695357: "defaultStrokeWidth", // "DiSW"
                                                                     0x64656674: "defaultType", // "deft"
                                                                     0x70506d34: "density", // "pPm4"
                                                                     0x70503431: "designation", // "pP41"
                                                                     0x63504139: "desiredGlyphScaling", // "cPA9"
                                                                     0x70543166: "desiredLetterSpacing", // "pT1f"
                                                                     0x70543163: "desiredWordSpacing", // "pT1c"
                                                                     0x70444d4e: "dimensionsOfPNG", // "pDMN"
                                                                     0x61694449: "dimPlacedImages", // "aiDI"
                                                                     0x70543039: "direction0x28obsoleteUse0x27baselineDirection0x270x29", // "pT09"
                                                                     0x70433062: "discretionaryLigature", // "pC0b"
                                                                     0x70445063: "ditherPercent", // "pDPc"
                                                                     0x703e4450: "documentPassword", // "p>DP"
                                                                     0x78784455: "documentUnits", // "xxDU"
                                                                     0x70506d37: "dotShape", // "pPm7"
                                                                     0x70503831: "downloadFonts", // "pP81"
                                                                     0x7046576c: "downsampleLinkedImages", // "pFWl"
                                                                     0x70414564: "editable", // "pAEd"
                                                                     0x70455478: "editableText", // "pETx"
                                                                     0x70454146: "embedAllFonts", // "pEAF"
                                                                     0x63614c4b: "embedded", // "caLK"
                                                                     0x70455066: "embedICCProfile", // "pEPf"
                                                                     0x70497049: "embedLinkedFiles", // "pIpI"
                                                                     0x70503632: "emulsion", // "pP62"
                                                                     0x703e4541: "enableAccess", // "p>EA"
                                                                     0x703e4543: "enableCopy", // "p>EC"
                                                                     0x703e4542: "enableCopyAndAccess", // "p>EB"
                                                                     0x703e4550: "enablePlaintext", // "p>EP"
                                                                     0x70544554: "endTValue", // "pTET"
                                                                     0x78614547: "entireGradient", // "xaEG"
                                                                     0x61694550: "entirePath", // "aiEP"
                                                                     0x6169454f: "evenodd", // "aiEO"
                                                                     0x65504a64: "everyLineComposer", // "ePJd"
                                                                     0x70464153: "exportAllSymbols", // "pFAS"
                                                                     0x70414646: "exportFileFormat", // "pAFF"
                                                                     0x7041454f: "exportOption", // "pAEO"
                                                                     0x70415341: "exportSelectedArtOnly", // "pASA"
                                                                     0x70465853: "exportStyle", // "pFXS"
                                                                     0x70465856: "exportVersion", // "pFXV"
                                                                     0x70747866: "family", // "ptxf"
                                                                     0x7043306d: "figureStyle", // "pC0m"
                                                                     0x61694653: "filePath", // "aiFS"
                                                                     0x61694643: "fillColor", // "aiFC"
                                                                     0x61694650: "filled", // "aiFP"
                                                                     0x6169464f: "fillOverprint", // "aiFO"
                                                                     0x746f466c: "fills", // "toFl"
                                                                     0x70466650: "filtersPolicy", // "pFfP"
                                                                     0x7046426c: "firstBaseline", // "pFBl"
                                                                     0x7046424d: "firstBaselineMin", // "pFBM"
                                                                     0x70543133: "firstLineIndent", // "pT13"
                                                                     0x70503634: "fitToPage", // "pP64"
                                                                     0x70465053: "FlashPlaybackSecurity", // "pFPS"
                                                                     0x74465354: "flattenerPreset", // "tFST"
                                                                     0x7046534c: "flattenerPresets", // "pFSL"
                                                                     0x70503363: "flattenerSettings", // "pP3c"
                                                                     0x70506e31: "flatteningBalance", // "pPn1"
                                                                     0x704f466c: "flattenOutput", // "pOFl"
                                                                     0x7052574d: "flowLinksHorizontally", // "pRWM"
                                                                     0x70503339: "fontSettings", // "pP39"
                                                                     0x70465354: "fontSubsetThreshold", // "pFST"
                                                                     0x70503834: "fontSubstitutionKind", // "pP84"
                                                                     0x70465459: "fontType", // "pFTY"
                                                                     0x70503934: "forceContinuousTone", // "pP94"
                                                                     0x70433066: "fractions", // "pC0f"
                                                                     0x70464652: "frameRate", // "pFFR"
                                                                     0x6169464d: "freeMemory", // "aiFM"
                                                                     0x70506232: "frequency", // "pPb2"
                                                                     0x70697366: "frontmost", // "pisf"
                                                                     0x70464376: "fxgVersion", // "pFCv"
                                                                     0x70464748: "generateHTML", // "pFGH"
                                                                     0x703e4754: "generateThumbnails", // "p>GT"
                                                                     0x61694247: "geometricBounds", // "aiBG"
                                                                     0x7047534f: "globalScaleOptions", // "pGSO"
                                                                     0x70475350: "globalScalePercent", // "pGSP"
                                                                     0x63614744: "gradient", // "caGD"
                                                                     0x70506e33: "gradientResolution", // "pPn3"
                                                                     0x70466750: "gradientsPolicy", // "pFgP"
                                                                     0x67645479: "gradientType", // "gdTy"
                                                                     0x746f476c: "grayLevels", // "toGl"
                                                                     0x703e4762: "grayscaleCompression", // "p>Gb"
                                                                     0x703e4744: "grayscaleDownsampling", // "p>GD"
                                                                     0x703e4741: "grayscaleDownsamplingThreshold", // "p>GA"
                                                                     0x703e4753: "grayscaleResample", // "p>GS"
                                                                     0x703e475a: "grayscaleTileSize", // "p>GZ"
                                                                     0x47524159: "grayValue", // "GRAY"
                                                                     0x4752454e: "green", // "GREN"
                                                                     0x61694744: "guides", // "aiGD"
                                                                     0x61692424: "hasSelectedArtwork", // "ai$$"
                                                                     0x44486569: "height", // "DHei"
                                                                     0x70534868: "height", // "pSHh"
                                                                     0x61694844: "hidden", // "aiHD"
                                                                     0x7048644c: "hiddenLayers", // "pHdL"
                                                                     0x4764446a: "hiliteAngle", // "GdDj"
                                                                     0x47644478: "hiliteLength", // "GdDx"
                                                                     0x70524468: "horizontalRadius", // "pRDh"
                                                                     0x70535858: "horizontalScale", // "pSXX"
                                                                     0x70487a53: "horizontalScaling", // "pHzS"
                                                                     0x63504133: "hyphenateCapitalizedWords", // "cPA3"
                                                                     0x48783031: "hyphenation", // "Hx01"
                                                                     0x63504134: "hyphenationPreference", // "cPA4"
                                                                     0x63504132: "hyphenationZone", // "cPA2"
                                                                     0x49442020: "id", // "ID  "
                                                                     0x746f4957: "ignoreWhite", // "toIW"
                                                                     0x70503231: "imageableArea", // "pP21"
                                                                     0x70503933: "imageCompression", // "pP93"
                                                                     0x70464946: "imageFormat", // "pFIF"
                                                                     0x7045494d: "imageMap", // "pEIM"
                                                                     0x70494374: "includeDocumentThumbnails", // "pICt"
                                                                     0x70494c59: "includeLayers", // "pILY"
                                                                     0x7046586d: "includeMetadata", // "pFXm"
                                                                     0x70494d44: "includeMetadata", // "pIMD"
                                                                     0x70464975: "includeUnusedSymbols", // "pFIu"
                                                                     0x70696478: "index", // "pidx"
                                                                     0x70494c50: "informationLoss", // "pILP"
                                                                     0x7050494c: "inks", // "pPIL"
                                                                     0x70524432: "innerRadius", // "pRD2"
                                                                     0x70503038: "InRIPSeparationSupport", // "pP08"
                                                                     0x7053496e: "inscribed", // "pSIn"
                                                                     0x70506132: "intent", // "pPa2"
                                                                     0x70496e4c: "interlaced", // "pInL"
                                                                     0x7049736f: "isolated", // "pIso"
                                                                     0x69735472: "isTracing", // "isTr"
                                                                     0x70433072: "italics", // "pC0r"
                                                                     0x704a6666: "japaneseFileFormat0x28obsolete0x29", // "pJff"
                                                                     0x70503335: "jobSettings", // "pP35"
                                                                     0x70464a4d: "JPEGMethod", // "pFJM"
                                                                     0x70464a51: "JPEGQuality", // "pFJQ"
                                                                     0x70543136: "justification", // "pT16"
                                                                     0x70543234: "kerning", // "pT24"
                                                                     0x70543236: "kerningMethod", // "pT26"
                                                                     0x63784454: "kind", // "cxDT"
                                                                     0x634b534f: "Kinsoku", // "cKSO"
                                                                     0x65504a61: "KinsokuOrder", // "ePJa"
                                                                     0x704b534f: "KinsokuSet", // "pKSO"
                                                                     0x704b6e6b: "knockout", // "pKnk"
                                                                     0x65504a62: "KurikaeshiMojiShori", // "ePJb"
                                                                     0x4c61624c: "l", // "LabL"
                                                                     0x70433074: "language", // "pC0t"
                                                                     0x70503131: "languageLevel", // "pP11"
                                                                     0x63614c59: "layer", // "caLY"
                                                                     0x704c4370: "layerComp", // "pLCp"
                                                                     0x70464c4f: "layerOrder", // "pFLO"
                                                                     0x54733033: "leader", // "Ts03"
                                                                     0x70543035: "leading", // "pT05"
                                                                     0x63504138: "leadingType", // "cPA8"
                                                                     0x6361494e: "leftDirection", // "caIN"
                                                                     0x70543134: "leftIndent", // "pT14"
                                                                     0x6c656e67: "length", // "leng"
                                                                     0x70433061: "ligature", // "pC0a"
                                                                     0x7041414c: "locale", // "pAAL"
                                                                     0x61694c4b: "locked", // "aiLK"
                                                                     0x70464c6f: "looping", // "pFLo"
                                                                     0x744c5a43: "LZWCompression", // "tLZC"
                                                                     0x4d41474e: "magenta", // "MAGN"
                                                                     0x70503738: "marksOffset", // "pP78"
                                                                     0x7446584d: "matrix", // "tFXM"
                                                                     0x704d4142: "matte", // "pMAB"
                                                                     0x704d436c: "matteColor", // "pMCl"
                                                                     0x746f4366: "maximumColors", // "toCf"
                                                                     0x48783035: "maximumConsecutiveHyphens", // "Hx05"
                                                                     0x704d4561: "maximumEditability", // "pMEa"
                                                                     0x63504135: "maximumGlyphScaling", // "cPA5"
                                                                     0x7050306a: "maximumHeightOffset", // "pP0j"
                                                                     0x70543165: "maximumLetterSpacing", // "pT1e"
                                                                     0x70503065: "maximumPaperHeight", // "pP0e"
                                                                     0x70503063: "maximumPaperWidth", // "pP0c"
                                                                     0x70503035: "maximumResolution", // "pP05"
                                                                     0x746f4d78: "maximumStrokeWeight", // "toMx"
                                                                     0x70503068: "maximumWidthOffset", // "pP0h"
                                                                     0x70543162: "maximumWordSpacing", // "pT1b"
                                                                     0x704d4c73: "mergeLayers", // "pMLs"
                                                                     0x78614d50: "midpoint", // "xaMP"
                                                                     0x7041534d: "minifySvg", // "pASM"
                                                                     0x48783034: "minimumAfterHyphen", // "Hx04"
                                                                     0x48783033: "minimumBeforeHyphen", // "Hx03"
                                                                     0x63504136: "minimumGlyphScaling", // "cPA6"
                                                                     0x70503069: "minimumHeightOffset", // "pP0i"
                                                                     0x63504131: "minimumHyphenatedWordSize", // "cPA1"
                                                                     0x70543164: "minimumLetterSpacing", // "pT1d"
                                                                     0x70503064: "minimumPaperHeight", // "pP0d"
                                                                     0x70503062: "minimumPaperWidth", // "pP0b"
                                                                     0x70503066: "minimumWidthOffset", // "pP0f"
                                                                     0x70543161: "minimumWordSpacing", // "pT1a"
                                                                     0x696d6f64: "modified", // "imod"
                                                                     0x634d4a49: "Mojikumi", // "cMJI"
                                                                     0x704d4a49: "MojikumiSet", // "pMJI"
                                                                     0x703e4d51: "monochromeCompression", // "p>MQ"
                                                                     0x703e4d44: "monochromeDownsampling", // "p>MD"
                                                                     0x703e4d41: "monochromeDownsamplingThreshold", // "p>MA"
                                                                     0x703e4d53: "monochromeResample", // "p>MS"
                                                                     0x7461566c: "mvalue_a", // "taVl"
                                                                     0x7462566c: "mvalue_b", // "tbVl"
                                                                     0x7463566c: "mvalue_c", // "tcVl"
                                                                     0x7464566c: "mvalue_d", // "tdVl"
                                                                     0x74747856: "mvalue_tx", // "ttxV"
                                                                     0x74747956: "mvalue_ty", // "ttyV"
                                                                     0x62416c39: "name", // "bAl9"
                                                                     0x706e616d: "name", // "pnam"
                                                                     0x70503932: "negativePrinting", // "pP92"
                                                                     0x704e4c79: "nestedLayers", // "pNLy"
                                                                     0x704e4672: "nextFrame", // "pNFr"
                                                                     0x70433136: "noBreak", // "pC16"
                                                                     0x746f4e66: "NoiseFidelity", // "toNf"
                                                                     0x61694e54: "note", // "aiNT"
                                                                     0x704e4172: "numArtboards", // "pNAr"
                                                                     0x703e4f41: "offset", // "p>OA"
                                                                     0x704c4f70: "opacity", // "pLOp"
                                                                     0x70433036: "OpenTypePosition", // "pC06"
                                                                     0x704f5041: "opticalAlignment", // "pOPA"
                                                                     0x704f706d: "optimization", // "pOpm"
                                                                     0x70433067: "ordinals", // "pC0g"
                                                                     0x70503631: "orientation", // "pP61"
                                                                     0x47644f67: "origin", // "GdOg"
                                                                     0x74725363: "originalArt", // "trSc"
                                                                     0x7043306c: "ornaments", // "pC0l"
                                                                     0x703e434f: "outputCondition", // "p>CO"
                                                                     0x703e4355: "outputConditionId", // "p>CU"
                                                                     0x703e4349: "outputIntentProfile", // "p>CI"
                                                                     0x78784f52: "outputResolution", // "xxOR"
                                                                     0x703e4f50: "overprint", // "p>OP"
                                                                     0x70503533: "overPrintBlack", // "pP53"
                                                                     0x70433138: "overprintFill", // "pC18"
                                                                     0x70433137: "overprintStroke", // "pC17"
                                                                     0x70504144: "padding", // "pPAD"
                                                                     0x7050544f: "page", // "pPTO"
                                                                     0x703e5049: "pageInfo", // "p>PI"
                                                                     0x70503736: "pageInfoMarks", // "pP76"
                                                                     0x70503338: "pageMarksSettings", // "pP38"
                                                                     0x70503731: "pageMarksStyle", // "pP71"
                                                                     0x7878504f: "pageOrigin", // "xxPO"
                                                                     0x746f506c: "palette", // "toPl"
                                                                     0x70503333: "paperSettings", // "pP33"
                                                                     0x70503061: "paperSizes", // "pP0a"
                                                                     0x7052654c: "pasteRemembersLayers", // "pReL"
                                                                     0x74725043: "pathCount", // "trPC"
                                                                     0x746f5046: "PathFidelity", // "toPF"
                                                                     0x63615054: "pattern", // "caPT"
                                                                     0x70504366: "PDFCompatible", // "pPCf"
                                                                     0x70505431: "PDFCropBounds", // "pPT1"
                                                                     0x70504631: "PDFFileOptions", // "pPF1"
                                                                     0x703e4f53: "PDFPreset", // "p>OS"
                                                                     0x7044534c: "PDFPresets", // "pDSL"
                                                                     0x703e5058: "pdfXstandard", // "p>PX"
                                                                     0x703e5044: "pdfXstandardDescripton", // "p>PD"
                                                                     0x703e5050: "permissionPassword", // "p>PP"
                                                                     0x7050464f: "PhotoshopFileOptions", // "pPFO"
                                                                     0x7050416c: "pixelAligned", // "pPAl"
                                                                     0x70505463: "pointCount", // "pPTc"
                                                                     0x63614352: "pointType", // "caCR"
                                                                     0x61695050: "polarity", // "aiPP"
                                                                     0x70615073: "position", // "paPs"
                                                                     0x7050536c: "PostScript", // "pPSl"
                                                                     0x70503361: "postscriptSettings", // "pP3a"
                                                                     0x70503332: "PPDName", // "pP32"
                                                                     0x7050444c: "PPDs", // "pPDL"
                                                                     0x65343231: "preserveAppearance", // "e421"
                                                                     0x703e5045: "preserveEditability", // "p>PE"
                                                                     0x70465065: "preserveEditingCapabilities", // "pFPe"
                                                                     0x7050484c: "preserveHiddenLayers", // "pPHL"
                                                                     0x7050494d: "preserveImageMaps", // "pPIM"
                                                                     0x70504c79: "preserveLayers", // "pPLy"
                                                                     0x70504c41: "preserveLegacyArtboard", // "pPLA"
                                                                     0x70505363: "preserveSlices", // "pPSc"
                                                                     0x746f5072: "preset", // "toPr"
                                                                     0x70444f43: "presetSettings", // "pDOC"
                                                                     0x70444f44: "presetSettingsDialogOption", // "pDOD"
                                                                     0x704f444f: "presetSettingsDialogOption", // "pODO"
                                                                     0x61695056: "preview", // "aiPV"
                                                                     0x70445052: "previewMode", // "pDPR"
                                                                     0x63504672: "previousFrame", // "cPFr"
                                                                     0x61695054: "printable", // "aiPT"
                                                                     0x70503462: "printAllArtboards", // "pP4b"
                                                                     0x70503432: "printArea", // "pP42"
                                                                     0x70503439: "printAsBitmap", // "pP49"
                                                                     0x70503331: "printerName", // "pP31"
                                                                     0x703e4650: "printerResolution", // "p>FP"
                                                                     0x7050524c: "printers", // "pPRL"
                                                                     0x70503031: "printerType", // "pP01"
                                                                     0x70503739: "printingStatus", // "pP79"
                                                                     0x74505354: "printPreset", // "tPST"
                                                                     0x7050534c: "printPresets", // "pPSL"
                                                                     0x78785054: "printTiles", // "xxPT"
                                                                     0x70506131: "profileKind", // "pPa1"
                                                                     0x70414c4c: "properties", // "pALL"
                                                                     0x7043306f: "proportionalMetrics", // "pC0o"
                                                                     0x70496d51: "quality", // "pImQ"
                                                                     0x70524478: "radius", // "pRDx"
                                                                     0x78615250: "rampPoint", // "xaRP"
                                                                     0x70524553: "rasterEffectSettings", // "pRES"
                                                                     0x70415246: "rasterFormat", // "pARF"
                                                                     0x70524957: "rasterImageLocation", // "pRIW"
                                                                     0x70506e32: "rasterizationResolution", // "pPn2"
                                                                     0x70445252: "rasterResolution", // "pDRR"
                                                                     0x7046524f: "readOnly", // "pFRO"
                                                                     0x52454420: "red", // "RED "
                                                                     0x53785266: "reflect", // "SxRf"
                                                                     0x53785261: "reflectAngle", // "SxRa"
                                                                     0x70503734: "registrationMarks", // "pP74"
                                                                     0x703e435a: "registryName", // "p>CZ"
                                                                     0x7052706c: "replacing", // "pRpl"
                                                                     0x703e4452: "requireDocPassword", // "p>DR"
                                                                     0x703e5052: "requirePermPassword", // "p>PR"
                                                                     0x6169525a: "resolution", // "aiRZ"
                                                                     0x70495253: "responsiveSvg", // "pIRS"
                                                                     0x70535276: "reversed", // "pSRv"
                                                                     0x70503436: "reversePages", // "pP46"
                                                                     0x63614f54: "rightDirection", // "caOT"
                                                                     0x70543135: "rightIndent", // "pT15"
                                                                     0x65504a36: "romanHanging", // "ePJ6"
                                                                     0x53785278: "rotation_", // "SxRx"
                                                                     0x70525743: "rowCount", // "pRWC"
                                                                     0x70525747: "rowGutter", // "pRWG"
                                                                     0x62416c38: "rulerOrigin", // "bAl8"
                                                                     0x7878524f: "rulerOrigin", // "xxRO"
                                                                     0x62416c32: "rulerPAR", // "bAl2"
                                                                     0x78785255: "rulerUnits", // "xxRU"
                                                                     0x534d4162: "saveMultipleArtboards", // "SMAb"
                                                                     0x70534854: "savingAsHTML", // "pSHT"
                                                                     0x53785363: "scaleFactor", // "SxSc"
                                                                     0x70414c57: "scaleLineweights", // "pALW"
                                                                     0x70415352: "scaleRatio", // "pASR"
                                                                     0x70415355: "scaleUnit", // "pASU"
                                                                     0x70543038: "scaling0x28obsoleteUse0x27horizontalScale0x27And0x27verticalScale0x270x29", // "pT08"
                                                                     0x6169564d: "screenMode", // "aiVM"
                                                                     0x70503133: "screens", // "pP13"
                                                                     0x70415a76: "scriptingVersion", // "pAZv"
                                                                     0x73656c63: "selected", // "selc"
                                                                     0x70534c4e: "selectedLayoutName", // "pSLN"
                                                                     0x61695378: "selectedPathPoints", // "aiSx"
                                                                     0x73656c65: "selection", // "sele"
                                                                     0x70503531: "separationMode", // "pP51"
                                                                     0x70507266: "settings", // "pPrf"
                                                                     0x70494454: "setTypeOfSVG", // "pIDT"
                                                                     0x70503936: "shadingResolution", // "pP96"
                                                                     0x53785361: "shearAngle", // "SxSa"
                                                                     0x53785378: "shearAxis", // "SxSx"
                                                                     0x53784461: "shiftAngle", // "SxDa"
                                                                     0x53784478: "shiftDistance", // "SxDx"
                                                                     0x62416c34: "showCenter", // "bAl4"
                                                                     0x62416c35: "showCrossHairs", // "bAl5"
                                                                     0x78785350: "showPlacedImages", // "xxSP"
                                                                     0x62416c36: "showSafeAreas", // "bAl6"
                                                                     0x70534463: "sides", // "pSDc"
                                                                     0x63504137: "singleWordJustification", // "cPA7"
                                                                     0x7074737a: "size", // "ptsz"
                                                                     0x7041536c: "sliced", // "pASl"
                                                                     0x7045536c: "slices", // "pESl"
                                                                     0x746f5363: "snapCurveToLines", // "toSc"
                                                                     0x6b664149: "sourceArt", // "kfAI"
                                                                     0x63504130: "spaceAfter", // "cPA0"
                                                                     0x70543130: "spaceBefore", // "pT10"
                                                                     0x70535041: "spacing", // "pSPA"
                                                                     0x7878534c: "splitLongPaths", // "xxSL"
                                                                     0x63614343: "spot", // "caCC"
                                                                     0x70506233: "spotFunction", // "pPb3"
                                                                     0x70503134: "spotFunctions", // "pP14"
                                                                     0x7053434b: "spotKind", // "pSCK"
                                                                     0x70545354: "startTValue", // "pTST"
                                                                     0x7044504e: "startupPreset", // "pDPN"
                                                                     0x70535450: "startupPreset", // "pSTP"
                                                                     0x7053504c: "startupPresets", // "pSPL"
                                                                     0x70737064: "stationery", // "pspd"
                                                                     0x63614c4d: "status", // "caLM"
                                                                     0x7847534f: "stopOpacity", // "xGSO"
                                                                     0x6353544f: "story", // "cSTO"
                                                                     0x70433038: "strikeThrough", // "pC08"
                                                                     0x61694378: "strokeCap", // "aiCx"
                                                                     0x61695343: "strokeColor", // "aiSC"
                                                                     0x61695350: "stroked", // "aiSP"
                                                                     0x61694453: "strokeDashes", // "aiDS"
                                                                     0x6169444f: "strokeDashOffset", // "aiDO"
                                                                     0x61694a6e: "strokeJoin", // "aiJn"
                                                                     0x61694d78: "strokeMiterLimit", // "aiMx"
                                                                     0x6169534f: "strokeOverprint", // "aiSO"
                                                                     0x746f5374: "strokes", // "toSt"
                                                                     0x70433139: "strokeWeight", // "pC19"
                                                                     0x61695357: "strokeWidth", // "aiSW"
                                                                     0x74787374: "style", // "txst"
                                                                     0x7043306b: "stylisticAlternates", // "pC0k"
                                                                     0x70433068: "swash", // "pC0h"
                                                                     0x63615359: "symbol", // "caSY"
                                                                     0x70543233: "tabStops", // "pT23"
                                                                     0x70433133: "TCYHorizontal", // "pC13"
                                                                     0x70433132: "TCYVertical", // "pC12"
                                                                     0x63545866: "textFont", // "cTXf"
                                                                     0x70464954: "textkerning", // "pFIT"
                                                                     0x70744f52: "textOrientation", // "ptOR"
                                                                     0x63545870: "textPath", // "cTXp"
                                                                     0x70467450: "textPolicy", // "pFtP"
                                                                     0x70535430: "textRange", // "pST0"
                                                                     0x746f5468: "threshold", // "toTh"
                                                                     0x78785446: "tileFullPages", // "xxTF"
                                                                     0x70503637: "tiling", // "pP67"
                                                                     0x54494e54: "tint", // "TINT"
                                                                     0x70544954: "title", // "pTIT"
                                                                     0x70433069: "titling", // "pC0i"
                                                                     0x67745472: "tracing", // "gtTr"
                                                                     0x746f4354: "TracingColorTypeValue", // "toCT"
                                                                     0x746f4d65: "TracingMethod", // "toMe"
                                                                     0x746f4d64: "tracingMode", // "toMd"
                                                                     0x74724f73: "tracingOptions", // "trOs"
                                                                     0x7054534c: "tracingPresets", // "pTSL"
                                                                     0x70543036: "tracking", // "pT06"
                                                                     0x70547063: "transparency", // "pTpc"
                                                                     0x70445447: "transparencyGrid", // "pDTG"
                                                                     0x65346c31: "transparent", // "e4l1"
                                                                     0x70507031: "transverse", // "pPp1"
                                                                     0x703e4352: "trapped", // "p>CR"
                                                                     0x70506d32: "trapping", // "pPm2"
                                                                     0x70506d33: "trappingOrder", // "pPm3"
                                                                     0x70503733: "trimMarks", // "pP73"
                                                                     0x70503732: "trimMarksWeight", // "pP72"
                                                                     0x703e5457: "trimMarkWeight", // "p>TW"
                                                                     0x70433076: "Tsume", // "pC0v"
                                                                     0x70433037: "underline", // "pC07"
                                                                     0x704c474d: "updateLegacyGradientMesh", // "pLGM"
                                                                     0x70434c54: "updateLegacyText", // "pCLT"
                                                                     0x7055524c: "URL", // "pURL"
                                                                     0x74724e43: "usedColorCount", // "trNC"
                                                                     0x78784453: "useDefaultScreen", // "xxDS"
                                                                     0x7055494c: "userInteractionLevel", // "pUIL"
                                                                     0x61695456: "value", // "aiTV"
                                                                     0x70444c56: "variablesLocked", // "pDLV"
                                                                     0x76657273: "version", // "vers"
                                                                     0x70524476: "verticalRadius", // "pRDv"
                                                                     0x70535959: "verticalScale", // "pSYY"
                                                                     0x70567453: "verticalScaling", // "pVtS"
                                                                     0x746f5676: "viewMode", // "toVv"
                                                                     0x703e5653: "viewPdf", // "p>VS"
                                                                     0x70564956: "visibilityVariable", // "pVIV"
                                                                     0x70766973: "visible", // "pvis"
                                                                     0x61695642: "visibleBounds", // "aiVB"
                                                                     0x70433130: "warichuCharactersAfterBreak", // "pC10"
                                                                     0x7043307a: "warichuCharactersBeforeBreak", // "pC0z"
                                                                     0x70433165: "warichuEnabled", // "pC1e"
                                                                     0x70433078: "warichuGap", // "pC0x"
                                                                     0x70433131: "warichuJustification", // "pC11"
                                                                     0x70433077: "warichuLines", // "pC0w"
                                                                     0x70433079: "warichuScale", // "pC0y"
                                                                     0x70455772: "warnings", // "pEWr"
                                                                     0x70575063: "webSnap", // "pWPc"
                                                                     0x44576468: "width", // "DWdh"
                                                                     0x70534877: "width", // "pSHw"
                                                                     0x70547749: "wrapInside", // "pTwI"
                                                                     0x7054774f: "wrapOffset", // "pTwO"
                                                                     0x70745752: "wrapped", // "ptWR"
                                                                     0x7057724c: "writeLayers", // "pWrL"
                                                                     0x70584d50: "XMPString", // "pXMP"
                                                                     0x59454c4c: "yellow", // "YELL"
                                                                     0x61695a4d: "zoom", // "aiZM"
                                                     ],
                                                     elementsNames: [
                                                                     0x63617070: "application", // "capp"
                                                                     0x64496d31: "artboards", // "dIm1"
                                                                     0x6341574f: "artwork", // "cAWO"
                                                                     0x63444f43: "artwork", // "cDOC"
                                                                     0x74454143: "AutoCADExportOptions", // "tEAC"
                                                                     0x744f4f41: "AutoCADOptions", // "tOOA"
                                                                     0x63614252: "brushes", // "caBR"
                                                                     0x63686120: "character", // "cha "
                                                                     0x63435354: "characterStyles", // "cCST"
                                                                     0x74434d69: "CMYKColorInfo", // "tCMi"
                                                                     0x74414943: "colorInfo", // "tAIC"
                                                                     0x7450434d: "colorManagementOptions", // "tPCM"
                                                                     0x74504353: "colorSeparationOptions", // "tPCS"
                                                                     0x63614350: "compoundPathItems", // "caCP"
                                                                     0x7450434f: "coordinateOptions", // "tPCO"
                                                                     0x74445374: "datasets", // "tDSt"
                                                                     0x444d4e49: "dimensionsInfo", // "DMNI"
                                                                     0x74445052: "documentPreset", // "tDPR"
                                                                     0x646f6375: "documents", // "docu"
                                                                     0x73684f56: "ellipse", // "shOV"
                                                                     0x6361454c: "embededItems", // "caEL"
                                                                     0x7465536f: "EPSSaveOptions", // "teSo"
                                                                     0x7445464c: "FlashExportOptions", // "tEFL"
                                                                     0x7450464c: "flatteningOptions", // "tPFL"
                                                                     0x7450464f: "fontOptions", // "tPFO"
                                                                     0x746d536f: "FXGSaveOptions", // "tmSo"
                                                                     0x63474946: "GIFExportOptions", // "cGIF"
                                                                     0x74474469: "gradientColorInfo", // "tGDi"
                                                                     0x63614744: "gradients", // "caGD"
                                                                     0x74474453: "gradientStopInfo", // "tGDS"
                                                                     0x63614753: "gradientStops", // "caGS"
                                                                     0x63614153: "graphicStyles", // "caAS"
                                                                     0x63475048: "graphItems", // "cGPH"
                                                                     0x74475269: "grayColorInfo", // "tGRi"
                                                                     0x63614750: "groupItems", // "caGP"
                                                                     0x63507266: "IllustratorPreferences", // "cPrf"
                                                                     0x7449536f: "IllustratorSaveOptions", // "tISo"
                                                                     0x7449434f: "imageCaptureOptions", // "tICO"
                                                                     0x7450494b: "ink", // "tPIK"
                                                                     0x74504949: "inkProperties", // "tPII"
                                                                     0x63696e73: "insertionPoints", // "cins"
                                                                     0x636f626a: "items", // "cobj"
                                                                     0x74504a4f: "jobOptions", // "tPJO"
                                                                     0x74454f6a: "JPEGExportOptions", // "tEOj"
                                                                     0x744c6162: "LabColorInfo", // "tLab"
                                                                     0x63614c59: "layers", // "caLY"
                                                                     0x634c5449: "legacyTextItems", // "cLTI"
                                                                     0x636c696e: "line", // "clin"
                                                                     0x7446584d: "matrix", // "tFXM"
                                                                     0x634d5348: "meshItems", // "cMSH"
                                                                     0x6361544f: "multipleTracingOptions", // "caTO"
                                                                     0x744e436c: "noColorInfo", // "tNCl"
                                                                     0x63464f69: "nonNativeItems", // "cFOi"
                                                                     0x4f625072: "obsolete_properties", // "ObPr"
                                                                     0x744f504f: "openOptions", // "tOPO"
                                                                     0x63614154: "pageItems", // "caAT"
                                                                     0x7450504d: "pageMarksOptions", // "tPPM"
                                                                     0x74504150: "paper", // "tPAP"
                                                                     0x7450504f: "paperOptions", // "tPPO"
                                                                     0x74504149: "paperProperties", // "tPAI"
                                                                     0x63706172: "paragraph", // "cpar"
                                                                     0x63505354: "paragraphStyles", // "cPST"
                                                                     0x63615041: "pathItems", // "caPA"
                                                                     0x74534547: "pathPointInfo", // "tSEG"
                                                                     0x63615053: "pathPoints", // "caPS"
                                                                     0x74505469: "patternColorInfo", // "tPTi"
                                                                     0x63615054: "patterns", // "caPT"
                                                                     0x744f5044: "PDFOptions", // "tOPD"
                                                                     0x7470536f: "PDFSaveOptions", // "tpSo"
                                                                     0x74455053: "PhotoshopExportOptions", // "tEPS"
                                                                     0x744f4f50: "PhotoshopOptions", // "tOOP"
                                                                     0x6361504c: "placedItems", // "caPL"
                                                                     0x63504c47: "pluginItems", // "cPLG"
                                                                     0x74503234: "PNG24ExportOptions", // "tP24"
                                                                     0x74504e38: "PNG8ExportOptions", // "tPN8"
                                                                     0x73685047: "polygon", // "shPG"
                                                                     0x74505053: "postscriptOptions", // "tPPS"
                                                                     0x74505044: "PPDFile", // "tPPD"
                                                                     0x74504449: "PPDProperties", // "tPDI"
                                                                     0x74505254: "printer", // "tPRT"
                                                                     0x74504946: "printerProperties", // "tPIF"
                                                                     0x74504f50: "printOptions", // "tPOP"
                                                                     0x7452454f: "rasterEffectOptions", // "tREO"
                                                                     0x63615241: "rasterItems", // "caRA"
                                                                     0x7452534f: "rasterizeOptions", // "tRSO"
                                                                     0x73685243: "rectangle", // "shRC"
                                                                     0x74524769: "RGBColorInfo", // "tRGi"
                                                                     0x73685252: "roundedRectangle", // "shRR"
                                                                     0x74505349: "screenProperties", // "tPSI"
                                                                     0x74505350: "screenSpotFunction", // "tPSP"
                                                                     0x74505343: "separationScreen", // "tPSC"
                                                                     0x74435369: "spotColorInfo", // "tCSi"
                                                                     0x63614343: "spots", // "caCC"
                                                                     0x73685354: "star", // "shST"
                                                                     0x6353544f: "stories", // "cSTO"
                                                                     0x74454f53: "SVGExportOptions", // "tEOS"
                                                                     0x63615357: "swatches", // "caSW"
                                                                     0x63534772: "swatchgroups", // "cSGr"
                                                                     0x63615349: "symbolItems", // "caSI"
                                                                     0x63615359: "symbols", // "caSY"
                                                                     0x74545369: "tabStopInfo", // "tTSi"
                                                                     0x63615447: "tags", // "caTG"
                                                                     0x63747874: "text", // "ctxt"
                                                                     0x63545866: "textFonts", // "cTXf"
                                                                     0x63545861: "textFrames", // "cTXa"
                                                                     0x63545870: "textPath", // "cTXp"
                                                                     0x74454154: "TIFFExportOptions", // "tEAT"
                                                                     0x63615472: "tracings", // "caTr"
                                                                     0x74566172: "variables", // "tVar"
                                                                     0x63614456: "views", // "caDV"
                                                                     0x63776f72: "word", // "cwor"
                                                     ])


/******************************************************************************/
// Symbol subclass defines static type/enum/property constants based on Adobe Illustrator.app terminology

public class ICCSymbol: Symbol {

    override var typeAliasName: String {return "ICC"}

    public override class func symbol(_ code: OSType, type: OSType = typeType, descriptor: NSAppleEventDescriptor? = nil) -> ICCSymbol {
        switch (code) {
        case 0x4c616241: return self.a // "LabA"
        case 0x65346733: return self.absoluteColorimetric // "e4g3"
        case 0x65544d61: return self.abuttingTracingMethod // "eTMa"
        case 0x65323331: return self.Acrobat4 // "e231"
        case 0x65323332: return self.Acrobat5 // "e232"
        case 0x65323333: return self.Acrobat6 // "e233"
        case 0x65323334: return self.Acrobat7 // "e234"
        case 0x65323335: return self.Acrobat8 // "e235"
        case 0x703e504c: return self.acrobatLayers // "p>PL"
        case 0x65333530: return self.adaptive // "e350"
        case 0x70415452: return self.addToRecentFiles // "pATR"
        case 0x70433134: return self.akiLeft // "pC14"
        case 0x70433135: return self.akiRight // "pC15"
        case 0x616c6973: return self.alias // "alis"
        case 0x54733031: return self.alignment // "Ts01"
        case 0x65414538: return self.allCaps // "eAE8"
        case 0x65333835: return self.allGlyphs // "e385"
        case 0x65343633: return self.allLayers // "e463"
        case 0x703e5041: return self.allowPrinting // "p>PA"
        case 0x65414539: return self.allSmallCaps // "eAE9"
        case 0x70433075: return self.alternateGlyphs // "pC0u"
        case 0x70414150: return self.alterPathsForAppearance // "pAAP"
        case 0x70416e63: return self.anchor // "pAnc"
        case 0x74724143: return self.anchorCount // "trAC"
        case 0x65303530: return self.anchorSelected // "e050"
        case 0x7041474c: return self.angle // "pAGL"
        case 0x70544161: return self.antialias // "pTAa"
        case 0x74544141: return self.antialiasing // "tTAA"
        case 0x70416e41: return self.antialiasing // "pAnA"
        case 0x65414c53: return self.antialiasingMethod // "eALS"
        case 0x2a2a2a2a: return self.anything // "****"
        case 0x63617070: return self.application // "capp"
        case 0x62756e64: return self.applicationBundleId // "bund"
        case 0x7369676e: return self.applicationSignature // "sign"
        case 0x6170726c: return self.applicationUrl // "aprl"
        case 0x61707220: return self.April // "apr "
        case 0x654c3339: return self.Arabic // "eL39"
        case 0x61694152: return self.area // "aiAR"
        case 0x65303632: return self.areaText // "e062"
        case 0x64496d31: return self.artboard // "dIm1"
        case 0x65343731: return self.artboardBounds // "e471"
        case 0x70414243: return self.artboardClipping // "pABC"
        case 0x65436f32: return self.artboardCoordinateSystem // "eCo2"
        case 0x70414c79: return self.artboardLayout // "pALy"
        case 0x70503463: return self.artboardRange // "pP4c"
        case 0x62416c31: return self.artboardRectangle // "bAl1"
        case 0x70415243: return self.artboardRowsOrCols // "pARC"
        case 0x70415370: return self.artboardSpacing // "pASp"
        case 0x65343334: return self.ArtboardsToFiles // "e434"
        case 0x70464143: return self.artClipping // "pFAC"
        case 0x614f5054: return self.artOptimized // "aOPT"
        case 0x63444f43: return self.artwork // "cDOC"
        case 0x6341574f: return self.artwork // "cAWO"
        case 0x65343732: return self.artworkBounds // "e472"
        case 0x666c7470: return self.as_ // "fltp"
        case 0x65343030: return self.ASCII // "e400"
        case 0x61736b20: return self.ask // "ask "
        case 0x61756720: return self.August // "aug "
        case 0x65414530: return self.auto // "eAE0"
        case 0x65333337: return self.AutoCAD // "e337"
        case 0x65415534: return self.autocadCentimeters // "eAU4"
        case 0x74454143: return self.AutoCADExportOptions // "tEAC"
        case 0x70504632: return self.AutoCADFileOptions // "pPF2"
        case 0x65415532: return self.autocadInches // "eAU2"
        case 0x65415533: return self.autocadMillimeters // "eAU3"
        case 0x744f4f41: return self.AutoCADOptions // "tOOA"
        case 0x65415531: return self.autocadPicas // "eAU1"
        case 0x65415535: return self.autocadPixels // "eAU5"
        case 0x65415530: return self.autocadPoints // "eAU0"
        case 0x65415630: return self.AutoCADRelease13 // "eAV0"
        case 0x65415631: return self.AutoCADRelease14 // "eAV1"
        case 0x65415632: return self.AutoCADRelease15 // "eAV2"
        case 0x65415633: return self.AutoCADRelease18 // "eAV3"
        case 0x65415634: return self.AutoCADRelease21 // "eAV4"
        case 0x65415635: return self.AutoCADRelease24 // "eAV5"
        case 0x70415653: return self.AutoCADVersion // "pAVS"
        case 0x65356331: return self.autoConvertBlends // "e5c1"
        case 0x65356234: return self.autoConvertGradients // "e5b4"
        case 0x65356134: return self.autoConvertText // "e5a4"
        case 0x65313239: return self.autoJustify // "e129"
        case 0x70543037: return self.autoKerning0x28obsoleteUse0x27kerningMethod0x270x29 // "pT07"
        case 0x70433033: return self.autoLeading // "pC03"
        case 0x63504161: return self.autoLeadingAmount // "cPAa"
        case 0x65353065: return self.automaticJPEG2000High // "e50e"
        case 0x65353131: return self.automaticJPEG2000Lossless // "e511"
        case 0x65353063: return self.automaticJPEG2000Low // "e50c"
        case 0x65353130: return self.automaticJPEG2000Maximum // "e510"
        case 0x65353064: return self.automaticJPEG2000Medium // "e50d"
        case 0x65353062: return self.automaticJPEG2000Minimum // "e50b"
        case 0x65353034: return self.automaticJPEGHigh // "e504"
        case 0x65353032: return self.automaticJPEGLow // "e502"
        case 0x65353035: return self.automaticJPEGMaximum // "e505"
        case 0x65353033: return self.automaticJPEGMedium // "e503"
        case 0x65353031: return self.automaticJPEGMinimum // "e501"
        case 0x65343935: return self.autoRotate // "e495"
        case 0x65323931: return self.averageDownsampling // "e291"
        case 0x4c616242: return self.b // "LabB"
        case 0x7042424b: return self.backgroundBlack // "pBBK"
        case 0x70464243: return self.backgroundColor // "pFBC"
        case 0x7046424c: return self.backgroundLayers // "pFBL"
        case 0x6b424153: return self.baselineAscent // "kBAS"
        case 0x6b424348: return self.baselineCapHeight // "kBCH"
        case 0x70433073: return self.baselineDirection // "pC0s"
        case 0x6b424548: return self.baselineEmBoxHeight // "kBEH"
        case 0x6b424658: return self.baselineFixed // "kBFX"
        case 0x6b424c47: return self.baselineLeading // "kBLG"
        case 0x6b424c59: return self.baselineLegacy // "kBLY"
        case 0x70433035: return self.baselinePosition // "pC05"
        case 0x70543034: return self.baselineShift // "pT04"
        case 0x6b425848: return self.baselineXHeight // "kBXH"
        case 0x70435052: return self.basicCMYKDocument // "pCPR"
        case 0x70525052: return self.basicRGBDocument // "pRPR"
        case 0x61393432: return self.beforeRunning // "a942"
        case 0x654c3531: return self.BengaliIndia // "eL51"
        case 0x62657374: return self.best // "best"
        case 0x70627374: return self.bestType // "pbst"
        case 0x65303331: return self.beveled // "e031"
        case 0x65323933: return self.bicubicDownsample // "e293"
        case 0x70503039: return self.binaryPrinting // "pP09"
        case 0x6b525362: return self.bitmapRasterization // "kRSb"
        case 0x70503461: return self.bitmapResolution // "pP4a"
        case 0x63425043: return self.bitsPerChannel // "cBPC"
        case 0x424c414b: return self.black // "BLAK"
        case 0x65346933: return self.blackAndWhiteOutput // "e4i3"
        case 0x70506d62: return self.blackInk // "pPmb"
        case 0x703e424b: return self.bleedLink // "p>BK"
        case 0x70503737: return self.bleedOffset // "pP77"
        case 0x70464241: return self.blendAnimation // "pFBA"
        case 0x70426c4d: return self.blendMode // "pBlM"
        case 0x70466250: return self.blendsPolicy // "pFbP"
        case 0x424c5545: return self.blue // "BLUE"
        case 0x70544742: return self.blueTransparencyGrids // "pTGB"
        case 0x70426c41: return self.blur // "pBlA"
        case 0x654c3039: return self.BokmalNorwegian // "eL09"
        case 0x626f6f6c: return self.boolean // "bool"
        case 0x65313737: return self.bottom // "e177"
        case 0x65313734: return self.bottomLeft // "e174"
        case 0x65313741: return self.bottomRight // "e17A"
        case 0x65427442: return self.bottomToBottom // "eBtB"
        case 0x65344130: return self.bottomUp // "e4A0"
        case 0x61694258: return self.boundingBox // "aiBX"
        case 0x71647274: return self.boundingRectangle // "qdrt"
        case 0x70626e64: return self.bounds // "pbnd"
        case 0x654c3132: return self.BrazillianPortuguese // "eL12"
        case 0x78794241: return self.browserAvailable // "xyBA"
        case 0x63614252: return self.brush // "caBR"
        case 0x65313937: return self.brushesLibrary // "e197"
        case 0x70414142: return self.buildNumber // "pAAB"
        case 0x654c3231: return self.Bulgarian // "eL21"
        case 0x65504a38: return self.BunriKinshi // "ePJ8"
        case 0x65504a39: return self.BurasagariType // "ePJ9"
        case 0x65303230: return self.butted // "e020"
        case 0x65323131: return self.BWMacintosh // "e211"
        case 0x65323133: return self.BWTIFF // "e213"
        case 0x65544d62: return self.bwTracingMode // "eTMb"
        case 0x7454424f: return self.ByteOrder // "tTBO"
        case 0x654c3034: return self.CanadianFrench // "eL04"
        case 0x70433034: return self.capitalization // "pC04"
        case 0x6b414364: return self.cascade // "kACd"
        case 0x63617365: return self.case_ // "case"
        case 0x654c3138: return self.Catalan // "eL18"
        case 0x65323732: return self.CCIT3 // "e272"
        case 0x65323731: return self.CCIT4 // "e271"
        case 0x65313232: return self.center // "e122"
        case 0x70434177: return self.centerArtwork // "pCAw"
        case 0x61694354: return self.centerPoint // "aiCT"
        case 0x65313833: return self.centimeters // "e183"
        case 0x703e4347: return self.changesAllowed // "p>CG"
        case 0x6343484e: return self.channels // "cCHN"
        case 0x63686120: return self.character // "cha "
        case 0x70535452: return self.characterOffset // "pSTR"
        case 0x63435354: return self.characterStyle // "cCST"
        case 0x654c3330: return self.Chinese // "eL30"
        case 0x70636c73: return self.class_ // "pcls"
        case 0x70506e36: return self.clipComplexRegions // "pPn6"
        case 0x61694370: return self.clipped // "aiCp"
        case 0x61694350: return self.clipping // "aiCP"
        case 0x704d534b: return self.clippingMask // "pMSK"
        case 0x6169436c: return self.closed // "aiCl"
        case 0x6543794d: return self.CMYK // "eCyM"
        case 0x74434d69: return self.CMYKColorInfo // "tCMi"
        case 0x70435053: return self.CMYKPostScript // "pCPS"
        case 0x70503437: return self.collate // "pP47"
        case 0x636f6c72: return self.color // "colr"
        case 0x634f4c73: return self.colorants // "cOLs"
        case 0x70503735: return self.colorBars // "pP75"
        case 0x65333134: return self.colorBlend // "e314"
        case 0x65333037: return self.colorBurn // "e307"
        case 0x703e4362: return self.colorCompression // "p>Cb"
        case 0x703e4343: return self.colorConversionId // "p>CC"
        case 0x65506333: return self.colorConversionRepurpose // "ePc3"
        case 0x65506332: return self.colorConversionToDest // "ePc2"
        case 0x70436c43: return self.colorCount // "pClC"
        case 0x65446332: return self.colorDestDocCmyk // "eDc2"
        case 0x65446334: return self.colorDestDocRgb // "eDc4"
        case 0x703e434e: return self.colorDestinationId // "p>CN"
        case 0x65446336: return self.colorDestProfile // "eDc6"
        case 0x65446333: return self.colorDestWorkingCmyk // "eDc3"
        case 0x65446335: return self.colorDestWorkingRgb // "eDc5"
        case 0x70434474: return self.colorDither // "pCDt"
        case 0x65333036: return self.colorDodge // "e306"
        case 0x703e4344: return self.colorDownsampling // "p>CD"
        case 0x703e4341: return self.colorDownsamplingThreshold // "p>CA"
        case 0x746f4d63: return self.colorFidelity // "toMc"
        case 0x746f4367: return self.colorgroup // "toCg"
        case 0x74414943: return self.colorInfo // "tAIC"
        case 0x63434f4c: return self.colorized // "cCOL"
        case 0x65323132: return self.colorMacintosh // "e212"
        case 0x7450434d: return self.colorManagementOptions // "tPCM"
        case 0x70503362: return self.colorManagementSettings // "pP3b"
        case 0x7044434d: return self.colorMode // "pDCM"
        case 0x65434d64: return self.colorModel // "eCMd"
        case 0x65346931: return self.colorOutput // "e4i1"
        case 0x703e4350: return self.colorProfileId // "p>CP"
        case 0x7043504e: return self.colorProfileName // "pCPN"
        case 0x70435264: return self.colorReduction // "pCRd"
        case 0x703e4353: return self.colorResample // "p>CS"
        case 0x7041434c: return self.colors // "pACL"
        case 0x74504353: return self.colorSeparationOptions // "tPCS"
        case 0x70503336: return self.colorSeparationSettings // "pP36"
        case 0x7043534c: return self.colorSettings // "pCSL"
        case 0x63614353: return self.colorSpace // "caCS"
        case 0x70503033: return self.colorSupport // "pP03"
        case 0x636c7274: return self.colorTable // "clrt"
        case 0x65323134: return self.colorTIFF // "e214"
        case 0x703e4354: return self.colorTileSize // "p>CT"
        case 0x65544d63: return self.colorTracingMode // "eTMc"
        case 0x70614354: return self.colorType // "paCT"
        case 0x70436f6c: return self.column // "pCol"
        case 0x70434c43: return self.columnCount // "pCLC"
        case 0x70434c47: return self.columnGutter // "pCLG"
        case 0x65333831: return self.commonEnglish // "e381"
        case 0x65333833: return self.commonRoman // "e383"
        case 0x70494370: return self.compatibility // "pICp"
        case 0x70434750: return self.compatibleGradientPrinting // "pCGP"
        case 0x70503935: return self.compatibleShading // "pP95"
        case 0x65346332: return self.complete // "e4c2"
        case 0x65343831: return self.composite // "e481"
        case 0x63614350: return self.compoundPathItem // "caCP"
        case 0x70454353: return self.compoundShapes // "pECS"
        case 0x703e544c: return self.compressArt // "p>TL"
        case 0x70434463: return self.compressed // "pCDc"
        case 0x7043306a: return self.connectionForms // "pC0j"
        case 0x6b414341: return self.consolidateAll // "kACA"
        case 0x63746e72: return self.container // "ctnr"
        case 0x70434e54: return self.contents // "pCNT"
        case 0x70434f56: return self.contentVariable // "pCOV"
        case 0x70433063: return self.contextualLigature // "pC0c"
        case 0x61694e58: return self.controlBounds // "aiNX"
        case 0x70434341: return self.convertCropAreaToArtboard // "pCCA"
        case 0x7043744e: return self.converted // "pCtN"
        case 0x65346a33: return self.convertInk // "e4j3"
        case 0x70503532: return self.convertSpotColors // "pP52"
        case 0x70506e35: return self.convertStrokesToOutlines // "pPn5"
        case 0x70506e34: return self.convertTextToOutlines // "pPn4"
        case 0x70435441: return self.convertTilesToArtboard // "pCTA"
        case 0x7450434f: return self.coordinateOptions // "tPCO"
        case 0x70446350: return self.coordinatePrecision // "pDcP"
        case 0x70503337: return self.coordinateSettings // "pP37"
        case 0x70436f53: return self.coordinateSystem // "pCoS"
        case 0x70503433: return self.copies // "pP43"
        case 0x65303537: return self.corner // "e057"
        case 0x746f4372: return self.CornerFidelity // "toCr"
        case 0x70434142: return self.createArtboardWithArtworkBoundingBox // "pCAB"
        case 0x65303634: return self.crisp // "e064"
        case 0x65343733: return self.cropBounds // "e473"
        case 0x78784342: return self.cropMarks // "xxCB"
        case 0x78784353: return self.cropStyle // "xxCS"
        case 0x70435353: return self.CSSProperties // "pCSS"
        case 0x70414944: return self.currentAdobeId // "pAID"
        case 0x70444144: return self.currentDataset // "pDAD"
        case 0x61694144: return self.currentDocument // "aiAD"
        case 0x6169434c: return self.currentLayer // "aiCL"
        case 0x70474944: return self.currentUserGuid // "pGID"
        case 0x61694356: return self.currentView // "aiCV"
        case 0x70464351: return self.curveQuality // "pFCQ"
        case 0x70506d36: return self.customColor // "pPm6"
        case 0x70506d63: return self.customInk // "pPmc"
        case 0x70503232: return self.customPaper // "pP22"
        case 0x70503036: return self.customPaperSizes // "pP06"
        case 0x70503037: return self.customPaperTransverse // "pP07"
        case 0x65346634: return self.customProfile // "e4f4"
        case 0x4359414e: return self.cyan // "CYAN"
        case 0x70506d38: return self.cyanInk // "pPm8"
        case 0x654c3233: return self.Czech // "eL23"
        case 0x654c3137: return self.Danish // "eL17"
        case 0x70544744: return self.darkColorTransparencyGrids // "pTGD"
        case 0x65333038: return self.darken // "e308"
        case 0x74646173: return self.dashStyle // "tdas"
        case 0x74647461: return self.data // "tdta"
        case 0x65303931: return self.dataFromFile // "e091"
        case 0x74445374: return self.dataset // "tDSt"
        case 0x6c647420: return self.date // "ldt "
        case 0x64656320: return self.December // "dec "
        case 0x65313234: return self.decimal // "e124"
        case 0x54733032: return self.decimalCharacter // "Ts02"
        case 0x6465636d: return self.decimalStruct // "decm"
        case 0x70465330: return self.default_ // "pFS0"
        case 0x61474353: return self.defaultColorSettings // "aGCS"
        case 0x44694643: return self.defaultFillColor // "DiFC"
        case 0x44694650: return self.defaultFilled // "DiFP"
        case 0x4469464f: return self.defaultFillOverprint // "DiFO"
        case 0x7044504d: return self.defaultPreview // "pDPM"
        case 0x6b445055: return self.defaultPurpose // "kDPU"
        case 0x6b525364: return self.defaultRasterization // "kRSd"
        case 0x70503034: return self.defaultResolution // "pP04"
        case 0x70506231: return self.defaultScreen // "pPb1"
        case 0x44694378: return self.defaultStrokeCap // "DiCx"
        case 0x44695343: return self.defaultStrokeColor // "DiSC"
        case 0x44695350: return self.defaultStroked // "DiSP"
        case 0x44694453: return self.defaultStrokeDashes // "DiDS"
        case 0x4469444f: return self.defaultStrokeDashOffset // "DiDO"
        case 0x44694a6e: return self.defaultStrokeJoin // "DiJn"
        case 0x44694d78: return self.defaultStrokeMiterLimit // "DiMx"
        case 0x4469534f: return self.defaultStrokeOverprint // "DiSO"
        case 0x44695357: return self.defaultStrokeWidth // "DiSW"
        case 0x64656674: return self.defaultType // "deft"
        case 0x704f5437: return self.denominator // "pOT7"
        case 0x70506d34: return self.density // "pPm4"
        case 0x70503431: return self.designation // "pP41"
        case 0x63504139: return self.desiredGlyphScaling // "cPA9"
        case 0x70543166: return self.desiredLetterSpacing // "pT1f"
        case 0x70543163: return self.desiredWordSpacing // "pT1c"
        case 0x65303032: return self.desktop // "e002"
        case 0x6530444e: return self.DeviceN // "e0DN"
        case 0x65346433: return self.deviceSubstitution // "e4d3"
        case 0x64696163: return self.diacriticals // "diac"
        case 0x65333130: return self.difference // "e310"
        case 0x65333630: return self.diffusion // "e360"
        case 0x444d4e49: return self.dimensionsInfo // "DMNI"
        case 0x70444d4e: return self.dimensionsOfPNG // "pDMN"
        case 0x61694449: return self.dimPlacedImages // "aiDI"
        case 0x70543039: return self.direction0x28obsoleteUse0x27baselineDirection0x270x29 // "pT09"
        case 0x65333231: return self.disabled // "e321"
        case 0x65346a31: return self.disableInk // "e4j1"
        case 0x65353431: return self.discard // "e541"
        case 0x70433062: return self.discretionaryLigature // "pC0b"
        case 0x70445063: return self.ditherPercent // "pDPc"
        case 0x646f6375: return self.document // "docu"
        case 0x65436f31: return self.documentCoordinateSystem // "eCo1"
        case 0x65313731: return self.documentOrigin // "e171"
        case 0x703e4450: return self.documentPassword // "p>DP"
        case 0x74445052: return self.documentPreset // "tDPR"
        case 0x78784455: return self.documentUnits // "xxDU"
        case 0x70506d37: return self.dotShape // "pPm7"
        case 0x636f6d70: return self.doubleInteger // "comp"
        case 0x70503831: return self.downloadFonts // "pP81"
        case 0x7046576c: return self.downsampleLinkedImages // "pFWl"
        case 0x6b44554d: return self.dummyPurposeOption // "kDUM"
        case 0x654c3136: return self.Dutch // "eL16"
        case 0x654c3433: return self.Dutch2005Reform // "eL43"
        case 0x65414631: return self.dwg // "eAF1"
        case 0x65414630: return self.dxf // "eAF0"
        case 0x70414564: return self.editable // "pAEd"
        case 0x70455478: return self.editableText // "pETx"
        case 0x73684f56: return self.ellipse // "shOV"
        case 0x65334430: return self.embed // "e3D0"
        case 0x70454146: return self.embedAllFonts // "pEAF"
        case 0x63614c4b: return self.embedded // "caLK"
        case 0x6361454c: return self.embeddedItem // "caEL"
        case 0x70455066: return self.embedICCProfile // "pEPf"
        case 0x70497049: return self.embedLinkedFiles // "pIpI"
        case 0x70503632: return self.emulsion // "pP62"
        case 0x703e4541: return self.enableAccess // "p>EA"
        case 0x703e4543: return self.enableCopy // "p>EC"
        case 0x703e4542: return self.enableCopyAndAccess // "p>EB"
        case 0x65333232: return self.enabled // "e322"
        case 0x65346a32: return self.enableInk // "e4j2"
        case 0x703e4550: return self.enablePlaintext // "p>EP"
        case 0x656e6373: return self.encodedString // "encs"
        case 0x70544554: return self.endTValue // "pTET"
        case 0x654c3031: return self.English // "eL01"
        case 0x78614547: return self.entireGradient // "xaEG"
        case 0x61694550: return self.entirePath // "aiEP"
        case 0x65343130: return self.entities // "e410"
        case 0x656e756d: return self.enumerator // "enum"
        case 0x65313932: return self.eps // "e192"
        case 0x45505320: return self.EPSPicture // "EPS "
        case 0x7465536f: return self.EPSSaveOptions // "teSo"
        case 0x6169454f: return self.evenodd // "aiEO"
        case 0x65504a64: return self.everyLineComposer // "ePJd"
        case 0x65333131: return self.exclusion // "e311"
        case 0x65353931: return self.expandFilters // "e591"
        case 0x65787061: return self.expansion // "expa"
        case 0x65414566: return self.expert // "eAEf"
        case 0x70464153: return self.exportAllSymbols // "pFAS"
        case 0x70414646: return self.exportFileFormat // "pAFF"
        case 0x7041454f: return self.exportOption // "pAEO"
        case 0x6b455055: return self.exportPurpose // "kEPU"
        case 0x70415341: return self.exportSelectedArtOnly // "pASA"
        case 0x70465853: return self.exportStyle // "pFXS"
        case 0x70465856: return self.exportVersion // "pFXV"
        case 0x65787465: return self.extendedFloat // "exte"
        case 0x70747866: return self.family // "ptxf"
        case 0x654c3431: return self.Farsi // "eL41"
        case 0x66656220: return self.February // "feb "
        case 0x7043306d: return self.figureStyle // "pC0m"
        case 0x61694653: return self.filePath // "aiFS"
        case 0x66737266: return self.fileRef // "fsrf"
        case 0x66737320: return self.fileSpecification // "fss "
        case 0x6675726c: return self.fileUrl // "furl"
        case 0x61694643: return self.fillColor // "aiFC"
        case 0x61694650: return self.filled // "aiFP"
        case 0x6169464f: return self.fillOverprint // "aiFO"
        case 0x746f466c: return self.fills // "toFl"
        case 0x70466650: return self.filtersPolicy // "pFfP"
        case 0x654c3032: return self.Finnish // "eL02"
        case 0x7046426c: return self.firstBaseline // "pFBl"
        case 0x7046424d: return self.firstBaselineMin // "pFBM"
        case 0x70543133: return self.firstLineIndent // "pT13"
        case 0x65415331: return self.fitArtboard // "eAS1"
        case 0x70503634: return self.fitToPage // "pP64"
        case 0x66697864: return self.fixed // "fixd"
        case 0x66706e74: return self.fixedPoint // "fpnt"
        case 0x66726374: return self.fixedRectangle // "frct"
        case 0x65333336: return self.Flash // "e336"
        case 0x7445464c: return self.FlashExportOptions // "tEFL"
        case 0x65343330: return self.FlashFile // "e430"
        case 0x6546504c: return self.flashPlaybackLocalAccess // "eFPL"
        case 0x6546504e: return self.flashPlaybackNetworkAccess // "eFPN"
        case 0x70465053: return self.FlashPlaybackSecurity // "pFPS"
        case 0x74465354: return self.flattenerPreset // "tFST"
        case 0x7046534c: return self.flattenerPresets // "pFSL"
        case 0x70503363: return self.flattenerSettings // "pP3c"
        case 0x70506e31: return self.flatteningBalance // "pPn1"
        case 0x7450464c: return self.flatteningOptions // "tPFL"
        case 0x704f466c: return self.flattenOutput // "pOFl"
        case 0x646f7562: return self.float // "doub"
        case 0x6c64626c: return self.float128bit // "ldbl"
        case 0x6b414641: return self.floatAll // "kAFA"
        case 0x65505034: return self.floorplane // "ePP4"
        case 0x7052574d: return self.flowLinksHorizontally // "pRWM"
        case 0x7450464f: return self.fontOptions // "tPFO"
        case 0x70503339: return self.fontSettings // "pP39"
        case 0x70465354: return self.fontSubsetThreshold // "pFST"
        case 0x70503834: return self.fontSubstitutionKind // "pP84"
        case 0x70465459: return self.fontType // "pFTY"
        case 0x70503934: return self.forceContinuousTone // "pP94"
        case 0x65504a31: return self.forced // "ePJ1"
        case 0x70433066: return self.fractions // "pC0f"
        case 0x70464652: return self.frameRate // "pFFR"
        case 0x6169464d: return self.freeMemory // "aiFM"
        case 0x70506232: return self.frequency // "pPb2"
        case 0x66726920: return self.Friday // "fri "
        case 0x70697366: return self.frontmost // "pisf"
        case 0x65313238: return self.fullJustify // "e128"
        case 0x65313237: return self.fullJustifyLastLineCenter // "e127"
        case 0x65313235: return self.fullJustifyLastLineLeft // "e125"
        case 0x65313236: return self.fullJustifyLastLineRight // "e126"
        case 0x65346131: return self.fullPages // "e4a1"
        case 0x65303033: return self.fullScreen // "e003"
        case 0x6541456f: return self.fullWidth // "eAEo"
        case 0x65313934: return self.fxg // "e194"
        case 0x746d536f: return self.FXGSaveOptions // "tmSo"
        case 0x70464376: return self.fxgVersion // "pFCv"
        case 0x70464748: return self.generateHTML // "pFGH"
        case 0x703e4754: return self.generateThumbnails // "p>GT"
        case 0x61694247: return self.geometricBounds // "aiBG"
        case 0x654c3432: return self.German2006Reform // "eL42"
        case 0x65333335: return self.GIF // "e335"
        case 0x63474946: return self.GIFExportOptions // "cGIF"
        case 0x47494666: return self.GIFPicture // "GIFf"
        case 0x7047534f: return self.globalScaleOptions // "pGSO"
        case 0x70475350: return self.globalScalePercent // "pGSP"
        case 0x65333830: return self.glyphsUsed // "e380"
        case 0x65333832: return self.glyphsUsedPlusEnglish // "e382"
        case 0x65333834: return self.glyphsUsedPlusRoman // "e384"
        case 0x63614744: return self.gradient // "caGD"
        case 0x74474469: return self.gradientColorInfo // "tGDi"
        case 0x70506e33: return self.gradientResolution // "pPn3"
        case 0x70466750: return self.gradientsPolicy // "pFgP"
        case 0x63614753: return self.gradientStop // "caGS"
        case 0x74474453: return self.gradientStopInfo // "tGDS"
        case 0x67645479: return self.gradientType // "gdTy"
        case 0x65343434: return self.graph // "e444"
        case 0x63614153: return self.graphicStyle // "caAS"
        case 0x65313938: return self.graphicStylesLibrary // "e198"
        case 0x63677478: return self.graphicText // "cgtx"
        case 0x63475048: return self.graphItem // "cGPH"
        case 0x6530474d: return self.Gray // "e0GM"
        case 0x74475269: return self.grayColorInfo // "tGRi"
        case 0x746f476c: return self.grayLevels // "toGl"
        case 0x703e4762: return self.grayscaleCompression // "p>Gb"
        case 0x703e4744: return self.grayscaleDownsampling // "p>GD"
        case 0x703e4741: return self.grayscaleDownsamplingThreshold // "p>GA"
        case 0x65346932: return self.grayscaleOutput // "e4i2"
        case 0x6b525367: return self.grayscaleRasterization // "kRSg"
        case 0x703e4753: return self.grayscaleResample // "p>GS"
        case 0x703e475a: return self.grayscaleTileSize // "p>GZ"
        case 0x65544d67: return self.grayTracingMode // "eTMg"
        case 0x47524159: return self.grayValue // "GRAY"
        case 0x654c3236: return self.Greek // "eL26"
        case 0x4752454e: return self.green // "GREN"
        case 0x70544747: return self.greenTransparencyGrids // "pTGG"
        case 0x70477243: return self.gridByColumn // "pGrC"
        case 0x70477252: return self.gridByRow // "pGrR"
        case 0x63614750: return self.groupItem // "caGP"
        case 0x61694744: return self.guides // "aiGD"
        case 0x654c3533: return self.Gujarati // "eL53"
        case 0x65414569: return self.halfWidth // "eAEi"
        case 0x65333035: return self.hardLight // "e305"
        case 0x61692424: return self.hasSelectedArtwork // "ai$$"
        case 0x44486569: return self.height // "DHei"
        case 0x70534868: return self.height // "pSHh"
        case 0x61694844: return self.hidden // "aiHD"
        case 0x7048644c: return self.hiddenLayers // "pHdL"
        case 0x7054474e: return self.hideTransparencyGrids // "pTGN"
        case 0x70485252: return self.highResolution // "pHRR"
        case 0x4764446a: return self.hiliteAngle // "GdDj"
        case 0x47644478: return self.hiliteLength // "GdDx"
        case 0x654c3439: return self.Hindi // "eL49"
        case 0x65303730: return self.horizontal // "e070"
        case 0x70524468: return self.horizontalRadius // "pRDh"
        case 0x70535858: return self.horizontalScale // "pSXX"
        case 0x70487a53: return self.horizontalScaling // "pHzS"
        case 0x6b414854: return self.horizontalTile // "kAHT"
        case 0x65343832: return self.hostBasedSeparation // "e482"
        case 0x65333132: return self.hue // "e312"
        case 0x654c3239: return self.Hungarian // "eL29"
        case 0x63504133: return self.hyphenateCapitalizedWords // "cPA3"
        case 0x48783031: return self.hyphenation // "Hx01"
        case 0x63504134: return self.hyphenationPreference // "cPA4"
        case 0x63504132: return self.hyphenationZone // "cPA2"
        case 0x68797068: return self.hyphens // "hyph"
        case 0x6b544250: return self.IBMPC // "kTBP"
        case 0x654c3238: return self.Icelandic // "eL28"
        case 0x6541456c: return self.icfBottom // "eAEl"
        case 0x6541456e: return self.icfTop // "eAEn"
        case 0x49442020: return self.id // "ID  "
        case 0x65346c33: return self.ignoreOpaque // "e4l3"
        case 0x746f4957: return self.ignoreWhite // "toIW"
        case 0x65313931: return self.Illustrator // "e191"
        case 0x65323039: return self.Illustrator10 // "e209"
        case 0x65323061: return self.Illustrator11 // "e20a"
        case 0x65323062: return self.Illustrator12 // "e20b"
        case 0x65323063: return self.Illustrator13 // "e20c"
        case 0x65323064: return self.Illustrator14 // "e20d"
        case 0x65323065: return self.Illustrator15 // "e20e"
        case 0x65323066: return self.Illustrator16 // "e20f"
        case 0x65323067: return self.Illustrator17 // "e20g"
        case 0x65327832: return self.Illustrator3 // "e2x2"
        case 0x65323037: return self.Illustrator8 // "e207"
        case 0x65323038: return self.Illustrator9 // "e208"
        case 0x65313935: return self.IllustratorArtwork // "e195"
        case 0x63507266: return self.IllustratorPreferences // "cPrf"
        case 0x7449536f: return self.IllustratorSaveOptions // "tISo"
        case 0x65343433: return self.image // "e443"
        case 0x70503231: return self.imageableArea // "pP21"
        case 0x65346132: return self.imageableAreas // "e4a2"
        case 0x7449434f: return self.imageCaptureOptions // "tICO"
        case 0x70503933: return self.imageCompression // "pP93"
        case 0x70464946: return self.imageFormat // "pFIF"
        case 0x7045494d: return self.imageMap // "pEIM"
        case 0x65344231: return self.inBuild // "e4B1"
        case 0x65313832: return self.inches // "e182"
        case 0x65447032: return self.includeAllProfiles // "eDp2"
        case 0x65447034: return self.includeAllRgb // "eDp4"
        case 0x65447035: return self.includeDestProfile // "eDp5"
        case 0x70494374: return self.includeDocumentThumbnails // "pICt"
        case 0x70494c59: return self.includeLayers // "pILY"
        case 0x7046586d: return self.includeMetadata // "pFXm"
        case 0x70494d44: return self.includeMetadata // "pIMD"
        case 0x70464975: return self.includeUnusedSymbols // "pFIu"
        case 0x70696478: return self.index // "pidx"
        case 0x65304944: return self.Indexed // "e0ID"
        case 0x70494c50: return self.informationLoss // "pILP"
        case 0x65333233: return self.inherited // "e323"
        case 0x7450494b: return self.ink // "tPIK"
        case 0x74504949: return self.inkProperties // "tPII"
        case 0x7050494c: return self.inks // "pPIL"
        case 0x70524432: return self.innerRadius // "pRD2"
        case 0x65343833: return self.InRIPSeparation // "e483"
        case 0x70503038: return self.InRIPSeparationSupport // "pP08"
        case 0x7053496e: return self.inscribed // "pSIn"
        case 0x65344230: return self.inSequence // "e4B0"
        case 0x63696e73: return self.insertionPoint // "cins"
        case 0x6c6f6e67: return self.integer // "long"
        case 0x70506132: return self.intent // "pPa2"
        case 0x65343564: return self.interactWithAll // "e45d"
        case 0x65343563: return self.interactWithLocal // "e45c"
        case 0x65343562: return self.interactWithSelf // "e45b"
        case 0x70496e4c: return self.interlaced // "pInL"
        case 0x69747874: return self.internationalText // "itxt"
        case 0x696e746c: return self.internationalWritingCode // "intl"
        case 0x7049736f: return self.isolated // "pIso"
        case 0x69735472: return self.isTracing // "isTr"
        case 0x654c3038: return self.Italian // "eL08"
        case 0x70433072: return self.italics // "pC0r"
        case 0x636f626a: return self.item // "cobj"
        case 0x6a616e20: return self.January // "jan "
        case 0x654c3331: return self.Japanese // "eL31"
        case 0x65323032: return self.Japanese3 // "e202"
        case 0x704a6666: return self.japaneseFileFormat0x28obsolete0x29 // "pJff"
        case 0x65303831: return self.JapaneseStyle // "e081"
        case 0x65414572: return self.jis04 // "eAEr"
        case 0x65414567: return self.jis78 // "eAEg"
        case 0x65414568: return self.jis83 // "eAEh"
        case 0x65414571: return self.jis90 // "eAEq"
        case 0x74504a4f: return self.jobOptions // "tPJO"
        case 0x70503335: return self.jobSettings // "pP35"
        case 0x65333330: return self.JPEG // "e330"
        case 0x65353135: return self.JPEG2000High // "e515"
        case 0x65353137: return self.JPEG2000Lossless // "e517"
        case 0x65353133: return self.JPEG2000Low // "e513"
        case 0x65353136: return self.JPEG2000Maximum // "e516"
        case 0x65353134: return self.JPEG2000Medium // "e514"
        case 0x65353132: return self.JPEG2000Minimum // "e512"
        case 0x74454f6a: return self.JPEGExportOptions // "tEOj"
        case 0x65323538: return self.JPEGHigh // "e258"
        case 0x65323536: return self.JPEGLow // "e256"
        case 0x65323539: return self.JPEGMaximum // "e259"
        case 0x65323537: return self.JPEGMedium // "e257"
        case 0x70464a4d: return self.JPEGMethod // "pFJM"
        case 0x65323535: return self.JPEGMinimum // "e255"
        case 0x4a504547: return self.JPEGPicture // "JPEG"
        case 0x70464a51: return self.JPEGQuality // "pFJQ"
        case 0x65415231: return self.JPEGRaster // "eAR1"
        case 0x6a756c20: return self.July // "jul "
        case 0x6a756e20: return self.June // "jun "
        case 0x70543136: return self.justification // "pT16"
        case 0x654c3537: return self.Kannada // "eL57"
        case 0x65353933: return self.keepFiltersEditable // "e593"
        case 0x65356233: return self.keepGradientsEditable // "e5b3"
        case 0x65356133: return self.keepTextEditable // "e5a3"
        case 0x6b706964: return self.kernelProcessId // "kpid"
        case 0x70543234: return self.kerning // "pT24"
        case 0x70543236: return self.kerningMethod // "pT26"
        case 0x63784454: return self.kind // "cxDT"
        case 0x634b534f: return self.Kinsoku // "cKSO"
        case 0x65504a61: return self.KinsokuOrder // "ePJa"
        case 0x704b534f: return self.KinsokuSet // "pKSO"
        case 0x704b6e6b: return self.knockout // "pKnk"
        case 0x65313132: return self.KumiMoji // "e112"
        case 0x65504a62: return self.KurikaeshiMojiShori // "ePJb"
        case 0x4c61624c: return self.l // "LabL"
        case 0x65304c62: return self.LAB // "e0Lb"
        case 0x744c6162: return self.LabColorInfo // "tLab"
        case 0x65343932: return self.landscape // "e492"
        case 0x70433074: return self.language // "pC0t"
        case 0x70503131: return self.languageLevel // "pP11"
        case 0x63614c59: return self.layer // "caLY"
        case 0x704c4370: return self.layerComp // "pLCp"
        case 0x70464c4f: return self.layerOrder // "pFLO"
        case 0x65343332: return self.layersToFiles // "e432"
        case 0x65343331: return self.layersToFrames // "e431"
        case 0x65343333: return self.layersToSymbols // "e433"
        case 0x54733033: return self.leader // "Ts03"
        case 0x70543035: return self.leading // "pT05"
        case 0x63504138: return self.leadingType // "cPA8"
        case 0x65447033: return self.leaveProfileUnchanged // "eDp3"
        case 0x65313231: return self.left_ // "e121"
        case 0x6361494e: return self.leftDirection // "caIN"
        case 0x70543134: return self.leftIndent // "pT14"
        case 0x65505032: return self.leftplane // "ePP2"
        case 0x65303533: return self.leftRightSelected // "e053"
        case 0x65303531: return self.leftSelected // "e051"
        case 0x634c5449: return self.legacyTextItem // "cLTI"
        case 0x6c656e67: return self.length // "leng"
        case 0x65323230: return self.level1 // "e220"
        case 0x65323231: return self.level2 // "e221"
        case 0x65323232: return self.level3 // "e222"
        case 0x70433061: return self.ligature // "pC0a"
        case 0x7054474c: return self.lightColorTransparencyGrids // "pTGL"
        case 0x65333039: return self.lighten // "e309"
        case 0x636c696e: return self.line // "clin"
        case 0x65303430: return self.linear // "e040"
        case 0x65334431: return self.link // "e3D1"
        case 0x6c697374: return self.list // "list"
        case 0x7041414c: return self.locale // "pAAL"
        case 0x696e736c: return self.locationReference // "insl"
        case 0x61694c4b: return self.locked // "aiLK"
        case 0x6c667864: return self.longFixed // "lfxd"
        case 0x6c667074: return self.longFixedPoint // "lfpt"
        case 0x6c667263: return self.longFixedRectangle // "lfrc"
        case 0x6c706e74: return self.longPoint // "lpnt"
        case 0x6c726374: return self.longRectangle // "lrct"
        case 0x70464c6f: return self.looping // "pFLo"
        case 0x65343361: return self.lossless // "e43a"
        case 0x65343362: return self.lossy // "e43b"
        case 0x65414534: return self.lowerCase // "eAE4"
        case 0x65333135: return self.luminosity // "e315"
        case 0x744c5a43: return self.LZWCompression // "tLZC"
        case 0x6d616368: return self.machine // "mach"
        case 0x6d4c6f63: return self.machineLocation // "mLoc"
        case 0x706f7274: return self.machPort // "port"
        case 0x6b54424d: return self.macintosh // "kTBM"
        case 0x4d41474e: return self.magenta // "MAGN"
        case 0x70506d39: return self.magentaInk // "pPm9"
        case 0x65457830: return self.maintainAppearance // "eEx0"
        case 0x654c3538: return self.Malayalam // "eL58"
        case 0x654c3530: return self.Marathi // "eL50"
        case 0x6d617220: return self.March // "mar "
        case 0x70503738: return self.marksOffset // "pP78"
        case 0x7446584d: return self.matrix // "tFXM"
        case 0x704d4142: return self.matte // "pMAB"
        case 0x704d436c: return self.matteColor // "pMCl"
        case 0x65414331: return self.max16Colors // "eAC1"
        case 0x65414332: return self.max256Colors // "eAC2"
        case 0x65414330: return self.max8Colors // "eAC0"
        case 0x65457831: return self.maximizeEditability // "eEx1"
        case 0x746f4366: return self.maximumColors // "toCf"
        case 0x48783035: return self.maximumConsecutiveHyphens // "Hx05"
        case 0x704d4561: return self.maximumEditability // "pMEa"
        case 0x63504135: return self.maximumGlyphScaling // "cPA5"
        case 0x7050306a: return self.maximumHeightOffset // "pP0j"
        case 0x70543165: return self.maximumLetterSpacing // "pT1e"
        case 0x70503065: return self.maximumPaperHeight // "pP0e"
        case 0x70503063: return self.maximumPaperWidth // "pP0c"
        case 0x70503035: return self.maximumResolution // "pP05"
        case 0x746f4d78: return self.maximumStrokeWeight // "toMx"
        case 0x70503068: return self.maximumWidthOffset // "pP0h"
        case 0x70543162: return self.maximumWordSpacing // "pT1b"
        case 0x6d617920: return self.May // "may "
        case 0x7054474d: return self.mediumColorTransparencyGrids // "pTGM"
        case 0x704d5252: return self.mediumResolution // "pMRR"
        case 0x704d4c73: return self.mergeLayers // "pMLs"
        case 0x634d5348: return self.meshItem // "cMSH"
        case 0x65414573: return self.metricsromanonly // "eAEs"
        case 0x78614d50: return self.midpoint // "xaMP"
        case 0x65313836: return self.millimeters // "e186"
        case 0x7041534d: return self.minifySvg // "pASM"
        case 0x65334330: return self.minimalSvg // "e3C0"
        case 0x48783034: return self.minimumAfterHyphen // "Hx04"
        case 0x48783033: return self.minimumBeforeHyphen // "Hx03"
        case 0x63504136: return self.minimumGlyphScaling // "cPA6"
        case 0x70503069: return self.minimumHeightOffset // "pP0i"
        case 0x63504131: return self.minimumHyphenatedWordSize // "cPA1"
        case 0x70543164: return self.minimumLetterSpacing // "pT1d"
        case 0x70503064: return self.minimumPaperHeight // "pP0d"
        case 0x70503062: return self.minimumPaperWidth // "pP0b"
        case 0x70503066: return self.minimumWidthOffset // "pP0f"
        case 0x70543161: return self.minimumWordSpacing // "pT1a"
        case 0x6d736e67: return self.missingValue // "msng"
        case 0x65303330: return self.mitered // "e030"
        case 0x704d5052: return self.mobileDocumentPreset // "pMPR"
        case 0x696d6f64: return self.modified // "imod"
        case 0x65303932: return self.modifiedData // "e092"
        case 0x634d4a49: return self.Mojikumi // "cMJI"
        case 0x704d4a49: return self.MojikumiSet // "pMJI"
        case 0x6d6f6e20: return self.Monday // "mon "
        case 0x703e4d51: return self.monochromeCompression // "p>MQ"
        case 0x703e4d44: return self.monochromeDownsampling // "p>MD"
        case 0x703e4d41: return self.monochromeDownsamplingThreshold // "p>MA"
        case 0x703e4d53: return self.monochromeResample // "p>MS"
        case 0x65333732: return self.moveBackward // "e372"
        case 0x65333731: return self.moveForward // "e371"
        case 0x65333733: return self.moveToBack // "e373"
        case 0x65333730: return self.moveToFront // "e370"
        case 0x65333031: return self.multiply // "e301"
        case 0x65303031: return self.multiwindow // "e001"
        case 0x7461566c: return self.mvalue_a // "taVl"
        case 0x7462566c: return self.mvalue_b // "tbVl"
        case 0x7463566c: return self.mvalue_c // "tcVl"
        case 0x7464566c: return self.mvalue_d // "tdVl"
        case 0x74747856: return self.mvalue_tx // "ttxV"
        case 0x74747956: return self.mvalue_ty // "ttyV"
        case 0x706e616d: return self.name // "pnam"
        case 0x62416c39: return self.name // "bAl9"
        case 0x65616f32: return self.negative // "eao2"
        case 0x70503932: return self.negativePrinting // "pP92"
        case 0x704e4c79: return self.nestedLayers // "pNLy"
        case 0x4e657672: return self.never // "Nevr"
        case 0x65343561: return self.neverInteract // "e45a"
        case 0x704e4672: return self.nextFrame // "pNFr"
        case 0x6e6f2020: return self.no // "no  "
        case 0x70433136: return self.noBreak // "pC16"
        case 0x744e436c: return self.noColorInfo // "tNCl"
        case 0x65303930: return self.noData // "e090"
        case 0x65323930: return self.nodownsample // "e290"
        case 0x65333633: return self.noise // "e363"
        case 0x746f4e66: return self.NoiseFidelity // "toNf"
        case 0x67653031: return self.none_ // "ge01"
        case 0x63464f69: return self.nonNativeItem // "cFOi"
        case 0x65346832: return self.nonPostScriptPrinter // "e4h2"
        case 0x65505031: return self.noplane // "ePP1"
        case 0x65313130: return self.normal // "e110"
        case 0x61694e54: return self.note // "aiNT"
        case 0x6e6f7620: return self.November // "nov "
        case 0x6e756c6c: return self.null // "null"
        case 0x704e4172: return self.numArtboards // "pNAr"
        case 0x704f5436: return self.numerator // "pOT6"
        case 0x6e756d65: return self.numericStrings // "nume"
        case 0x654c3130: return self.NynorskNorwegian // "eL10"
        case 0x65346431: return self.obliqueSubstitution // "e4d1"
        case 0x4f625072: return self.obsolete_properties // "ObPr"
        case 0x6f637420: return self.October // "oct "
        case 0x703e4f41: return self.offset // "p>OA"
        case 0x654c3036: return self.oldGerman // "eL06"
        case 0x65346631: return self.oldstyleProfile // "e4f1"
        case 0x65393431: return self.onRuntimeError // "e941"
        case 0x704c4f70: return self.opacity // "pLOp"
        case 0x65346c32: return self.opaque // "e4l2"
        case 0x744f504f: return self.openOptions // "tOPO"
        case 0x70433036: return self.OpenTypePosition // "pC06"
        case 0x65414531: return self.optical // "eAE1"
        case 0x704f5041: return self.opticalAlignment // "pOPA"
        case 0x704f706d: return self.optimization // "pOpm"
        case 0x65343365: return self.optimized // "e43e"
        case 0x7054474f: return self.orangeTransparencyGrids // "pTGO"
        case 0x70433067: return self.ordinals // "pC0g"
        case 0x70503631: return self.orientation // "pP61"
        case 0x47644f67: return self.origin // "GdOg"
        case 0x74725363: return self.originalArt // "trSc"
        case 0x65415330: return self.originalSize // "eAS0"
        case 0x654c3534: return self.Oriya // "eL54"
        case 0x7043306c: return self.ornaments // "pC0l"
        case 0x65334132: return self.outlineFont // "e3A2"
        case 0x65356131: return self.outlineText // "e5a1"
        case 0x65343336: return self.outputArtboardBounds // "e436"
        case 0x65343335: return self.outputArtBounds // "e435"
        case 0x703e434f: return self.outputCondition // "p>CO"
        case 0x703e4355: return self.outputConditionId // "p>CU"
        case 0x65343337: return self.outputCroprectBounds // "e437"
        case 0x703e4349: return self.outputIntentProfile // "p>CI"
        case 0x78784f52: return self.outputResolution // "xxOR"
        case 0x65544d6f: return self.overlappingTracingMethod // "eTMo"
        case 0x65333033: return self.overlay // "e303"
        case 0x703e4f50: return self.overprint // "p>OP"
        case 0x70503533: return self.overPrintBlack // "pP53"
        case 0x70433138: return self.overprintFill // "pC18"
        case 0x704f5050: return self.overprintPreview // "pOPP"
        case 0x70433137: return self.overprintStroke // "pC17"
        case 0x70504144: return self.padding // "pPAD"
        case 0x7050544f: return self.page // "pPTO"
        case 0x703e5049: return self.pageInfo // "p>PI"
        case 0x70503736: return self.pageInfoMarks // "pP76"
        case 0x63614154: return self.pageItem // "caAT"
        case 0x7450504d: return self.pageMarksOptions // "tPPM"
        case 0x70503338: return self.pageMarksSettings // "pP38"
        case 0x70503731: return self.pageMarksStyle // "pP71"
        case 0x7878504f: return self.pageOrigin // "xxPO"
        case 0x746f506c: return self.palette // "toPl"
        case 0x74504150: return self.paper // "tPAP"
        case 0x7450504f: return self.paperOptions // "tPPO"
        case 0x74504149: return self.paperProperties // "tPAI"
        case 0x70503333: return self.paperSettings // "pP33"
        case 0x70503061: return self.paperSizes // "pP0a"
        case 0x63706172: return self.paragraph // "cpar"
        case 0x63505354: return self.paragraphStyle // "cPST"
        case 0x7052654c: return self.pasteRemembersLayers // "pReL"
        case 0x74725043: return self.pathCount // "trPC"
        case 0x746f5046: return self.PathFidelity // "toPF"
        case 0x63615041: return self.pathItem // "caPA"
        case 0x63615053: return self.pathPoint // "caPS"
        case 0x74534547: return self.pathPointInfo // "tSEG"
        case 0x65303631: return self.pathText // "e061"
        case 0x63615054: return self.pattern // "caPT"
        case 0x74505469: return self.patternColorInfo // "tPTi"
        case 0x65333631: return self.patternDither // "e361"
        case 0x65313933: return self.pdf // "e193"
        case 0x65353634: return self.pdf128AnyChanges // "e564"
        case 0x65353633: return self.pdf128CommentingAllowed // "e563"
        case 0x65353631: return self.pdf128EditPageAllowed // "e561"
        case 0x65353632: return self.pdf128FillFormAllowed // "e562"
        case 0x65353630: return self.pdf128NoChanges // "e560"
        case 0x65353532: return self.pdf128PrintHighRes // "e552"
        case 0x65353531: return self.pdf128PrintLowRes // "e551"
        case 0x65353530: return self.pdf128PrintNone // "e550"
        case 0x65353638: return self.pdf40AnyChanges // "e568"
        case 0x65353636: return self.pdf40CommentingAllowed // "e566"
        case 0x65353635: return self.pdf40NoChanges // "e565"
        case 0x65353637: return self.pdf40PageLayoutAllowed // "e567"
        case 0x65353534: return self.pdf40PrintHighRes // "e554"
        case 0x65353533: return self.pdf40PrintNone // "e553"
        case 0x65504f31: return self.PDFArtBox // "ePO1"
        case 0x65503034: return self.PDFBleedBox // "eP04"
        case 0x65503036: return self.PDFBoundingBox // "eP06"
        case 0x70504366: return self.PDFCompatible // "pPCf"
        case 0x70505431: return self.PDFCropBounds // "pPT1"
        case 0x65503032: return self.PDFCropBox // "eP02"
        case 0x70504631: return self.PDFFileOptions // "pPF1"
        case 0x65503035: return self.PDFMediaBox // "eP05"
        case 0x744f5044: return self.PDFOptions // "tOPD"
        case 0x703e4f53: return self.PDFPreset // "p>OS"
        case 0x7044534c: return self.PDFPresets // "pDSL"
        case 0x7470536f: return self.PDFSaveOptions // "tpSo"
        case 0x65503033: return self.PDFTrimBox // "eP03"
        case 0x65506431: return self.PDFX1a2001 // "ePd1"
        case 0x65506432: return self.PDFX1a2003 // "ePd2"
        case 0x65506433: return self.PDFX32001 // "ePd3"
        case 0x65506445: return self.PDFX32002 // "ePdE"
        case 0x65506434: return self.PDFX32003 // "ePd4"
        case 0x65506435: return self.PDFX42007 // "ePd5"
        case 0x65506430: return self.PDFXNone // "ePd0"
        case 0x703e5058: return self.pdfXstandard // "p>PX"
        case 0x703e5044: return self.pdfXstandardDescripton // "p>PD"
        case 0x65333532: return self.perceptual // "e352"
        case 0x703e5050: return self.permissionPassword // "p>PP"
        case 0x65333331: return self.Photoshop // "e331"
        case 0x65323431: return self.Photoshop6 // "e241"
        case 0x65323432: return self.Photoshop8 // "e242"
        case 0x74455053: return self.PhotoshopExportOptions // "tEPS"
        case 0x7050464f: return self.PhotoshopFileOptions // "pPFO"
        case 0x744f4f50: return self.PhotoshopOptions // "tOOP"
        case 0x65313835: return self.picas // "e185"
        case 0x50494354: return self.PICTPicture // "PICT"
        case 0x7050416c: return self.pixelAligned // "pPAl"
        case 0x74706d6d: return self.pixelMapRecord // "tpmm"
        case 0x7050504d: return self.pixelPreview // "pPPM"
        case 0x65313838: return self.pixels // "e188"
        case 0x6361504c: return self.placedItem // "caPL"
        case 0x63504c47: return self.pluginItem // "cPLG"
        case 0x65333334: return self.PNG24 // "e334"
        case 0x74503234: return self.PNG24ExportOptions // "tP24"
        case 0x65333333: return self.PNG8 // "e333"
        case 0x74504e38: return self.PNG8ExportOptions // "tPN8"
        case 0x65415230: return self.PNGRaster // "eAR0"
        case 0x51447074: return self.point // "QDpt"
        case 0x70505463: return self.pointCount // "pPTc"
        case 0x65313834: return self.points // "e184"
        case 0x65303630: return self.pointText // "e060"
        case 0x63614352: return self.pointType // "caCR"
        case 0x61695050: return self.polarity // "aiPP"
        case 0x654c3234: return self.Polish // "eL24"
        case 0x73685047: return self.polygon // "shPG"
        case 0x65343931: return self.portrait // "e491"
        case 0x70615073: return self.position // "paPs"
        case 0x65613031: return self.positive // "ea01"
        case 0x7050536c: return self.PostScript // "pPSl"
        case 0x74505053: return self.postscriptOptions // "tPPS"
        case 0x65346831: return self.PostScriptPrinter // "e4h1"
        case 0x70503361: return self.postscriptSettings // "pP3a"
        case 0x74505044: return self.PPDFile // "tPPD"
        case 0x70503332: return self.PPDName // "pP32"
        case 0x74504449: return self.PPDProperties // "tPDI"
        case 0x7050444c: return self.PPDs // "pPDL"
        case 0x65343133: return self.presentationAttributes // "e413"
        case 0x65334432: return self.preserve // "e3D2"
        case 0x65353430: return self.preserve // "e540"
        case 0x65343231: return self.preserveAppearance // "e421"
        case 0x703e5045: return self.preserveEditability // "p>PE"
        case 0x70465065: return self.preserveEditingCapabilities // "pFPe"
        case 0x7050484c: return self.preserveHiddenLayers // "pPHL"
        case 0x7050494d: return self.preserveImageMaps // "pPIM"
        case 0x70504c79: return self.preserveLayers // "pPLy"
        case 0x70504c41: return self.preserveLegacyArtboard // "pPLA"
        case 0x65343230: return self.preservePaths // "e420"
        case 0x70505363: return self.preserveSlices // "pPSc"
        case 0x746f5072: return self.preset // "toPr"
        case 0x70444f43: return self.presetSettings // "pDOC"
        case 0x70444f44: return self.presetSettingsDialogOption // "pDOD"
        case 0x704f444f: return self.presetSettingsDialogOption // "pODO"
        case 0x61695056: return self.preview // "aiPV"
        case 0x70445052: return self.previewMode // "pDPR"
        case 0x6b505055: return self.previewPurpose // "kPPU"
        case 0x63504672: return self.previousFrame // "cPFr"
        case 0x61695054: return self.printable // "aiPT"
        case 0x70503462: return self.printAllArtboards // "pP4b"
        case 0x70503432: return self.printArea // "pP42"
        case 0x70503439: return self.printAsBitmap // "pP49"
        case 0x70505052: return self.printDocumentPreset // "pPPR"
        case 0x74505254: return self.printer // "tPRT"
        case 0x70503331: return self.printerName // "pP31"
        case 0x65346633: return self.printerProfile // "e4f3"
        case 0x74504946: return self.printerProperties // "tPIF"
        case 0x703e4650: return self.printerResolution // "p>FP"
        case 0x7050524c: return self.printers // "pPRL"
        case 0x70503031: return self.printerType // "pP01"
        case 0x70503739: return self.printingStatus // "pP79"
        case 0x74504f50: return self.printOptions // "tPOP"
        case 0x74505354: return self.printPreset // "tPST"
        case 0x7050534c: return self.printPresets // "pPSL"
        case 0x78785054: return self.printTiles // "xxPT"
        case 0x65343236: return self.processColor // "e426"
        case 0x70736e20: return self.processSerialNumber // "psn "
        case 0x70506131: return self.profileKind // "pPa1"
        case 0x65303232: return self.projecting // "e022"
        case 0x70414c4c: return self.properties // "pALL"
        case 0x70726f70: return self.property_ // "prop"
        case 0x70465333: return self.proportional // "pFS3"
        case 0x7043306f: return self.proportionalMetrics // "pC0o"
        case 0x70465332: return self.proportionalOldstyle // "pFS2"
        case 0x65414570: return self.proportionalWidth // "eAEp"
        case 0x70756e63: return self.punctuation // "punc"
        case 0x654c3532: return self.Punjabi // "eL52"
        case 0x70544750: return self.purpleTransparencyGrids // "pTGP"
        case 0x65504a33: return self.pushIn // "ePJ3"
        case 0x65504a34: return self.pushOutFirst // "ePJ4"
        case 0x65504a35: return self.pushOutOnly // "ePJ5"
        case 0x65313837: return self.qs // "e187"
        case 0x70496d51: return self.quality // "pImQ"
        case 0x6541456b: return self.quarterWidth // "eAEk"
        case 0x65303431: return self.radial // "e041"
        case 0x70524478: return self.radius // "pRDx"
        case 0x78615250: return self.rampPoint // "xaRP"
        case 0x7452454f: return self.rasterEffectOptions // "tREO"
        case 0x70524553: return self.rasterEffectSettings // "pRES"
        case 0x70415246: return self.rasterFormat // "pARF"
        case 0x70524957: return self.rasterImageLocation // "pRIW"
        case 0x63615241: return self.rasterItem // "caRA"
        case 0x70506e32: return self.rasterizationResolution // "pPn2"
        case 0x65356332: return self.rasterizeBlends // "e5c2"
        case 0x65353932: return self.rasterizeFilters // "e592"
        case 0x7452534f: return self.rasterizeOptions // "tRSO"
        case 0x65356132: return self.rasterizeText // "e5a2"
        case 0x70445252: return self.rasterResolution // "pDRR"
        case 0x7046524f: return self.readOnly // "pFRO"
        case 0x7265636f: return self.record // "reco"
        case 0x73685243: return self.rectangle // "shRC"
        case 0x52454420: return self.red // "RED "
        case 0x70544752: return self.redColorTransparencyGrids // "pTGR"
        case 0x6f626a20: return self.reference // "obj "
        case 0x53785266: return self.reflect // "SxRf"
        case 0x53785261: return self.reflectAngle // "SxRa"
        case 0x65343235: return self.registrationColor // "e425"
        case 0x70503734: return self.registrationMarks // "pP74"
        case 0x703e435a: return self.registryName // "p>CZ"
        case 0x65334331: return self.regularSvg // "e3C1"
        case 0x65346732: return self.relativeColorimetric // "e4g2"
        case 0x7052706c: return self.replacing // "pRpl"
        case 0x703e4452: return self.requireDocPassword // "p>DR"
        case 0x703e5052: return self.requirePermPassword // "p>PR"
        case 0x6169525a: return self.resolution // "aiRZ"
        case 0x70495253: return self.responsiveSvg // "pIRS"
        case 0x70535276: return self.reversed // "pSRv"
        case 0x65343934: return self.reverseLandscape // "e494"
        case 0x70503436: return self.reversePages // "pP46"
        case 0x65343933: return self.reversePortrait // "e493"
        case 0x6552624d: return self.RGB // "eRbM"
        case 0x74723136: return self.RGB16Color // "tr16"
        case 0x74723936: return self.RGB96Color // "tr96"
        case 0x63524742: return self.RGBColor // "cRGB"
        case 0x74524769: return self.RGBColorInfo // "tRGi"
        case 0x65313233: return self.right_ // "e123"
        case 0x63614f54: return self.rightDirection // "caOT"
        case 0x70543135: return self.rightIndent // "pT15"
        case 0x65505033: return self.rightplane // "ePP3"
        case 0x65303532: return self.rightSelected // "e052"
        case 0x65346531: return self.RLE // "e4e1"
        case 0x70524743: return self.rlGridByCol // "pRGC"
        case 0x70524752: return self.rlGridByRow // "pRGR"
        case 0x70525277: return self.rlRow // "pRRw"
        case 0x65414532: return self.Roman // "eAE2"
        case 0x6541456d: return self.romanBaseline // "eAEm"
        case 0x65504a36: return self.romanHanging // "ePJ6"
        case 0x654c3235: return self.Romanian // "eL25"
        case 0x65313131: return self.rotated // "e111"
        case 0x74726f74: return self.rotation // "trot"
        case 0x53785278: return self.rotation_ // "SxRx"
        case 0x65303231: return self.rounded // "e021"
        case 0x73685252: return self.roundedRectangle // "shRR"
        case 0x70526f77: return self.row // "pRow"
        case 0x70525743: return self.rowCount // "pRWC"
        case 0x70525747: return self.rowGutter // "pRWG"
        case 0x62416c38: return self.rulerOrigin // "bAl8"
        case 0x7878524f: return self.rulerOrigin // "xxRO"
        case 0x62416c32: return self.rulerPAR // "bAl2"
        case 0x78785255: return self.rulerUnits // "xxRU"
        case 0x65323734: return self.runLength // "e274"
        case 0x654c3139: return self.Russian // "eL19"
        case 0x65346731: return self.saturation // "e4g1"
        case 0x65333133: return self.saturationBlend // "e313"
        case 0x73617420: return self.Saturday // "sat "
        case 0x534d4162: return self.saveMultipleArtboards // "SMAb"
        case 0x70534854: return self.savingAsHTML // "pSHT"
        case 0x65415332: return self.scaleByValue // "eAS2"
        case 0x53785363: return self.scaleFactor // "SxSc"
        case 0x70414c57: return self.scaleLineweights // "pALW"
        case 0x70415352: return self.scaleRatio // "pASR"
        case 0x70415355: return self.scaleUnit // "pASU"
        case 0x70543038: return self.scaling0x28obsoleteUse0x27horizontalScale0x27And0x27verticalScale0x270x29 // "pT08"
        case 0x65333032: return self.screen // "e302"
        case 0x6169564d: return self.screenMode // "aiVM"
        case 0x74505349: return self.screenProperties // "tPSI"
        case 0x70535252: return self.screenResolution // "pSRR"
        case 0x70503133: return self.screens // "pP13"
        case 0x74505350: return self.screenSpotFunction // "tPSP"
        case 0x73637074: return self.script // "scpt"
        case 0x70415a76: return self.scriptingVersion // "pAZv"
        case 0x73656c63: return self.selected // "selc"
        case 0x70534c4e: return self.selectedLayoutName // "pSLN"
        case 0x61695378: return self.selectedPathPoints // "aiSx"
        case 0x73656c65: return self.selection // "sele"
        case 0x65333531: return self.selective // "e351"
        case 0x65414536: return self.sentenceCase // "eAE6"
        case 0x65305350: return self.Separation // "e0SP"
        case 0x70503531: return self.separationMode // "pP51"
        case 0x74505343: return self.separationScreen // "tPSC"
        case 0x73657020: return self.September // "sep "
        case 0x654c3232: return self.Serbian // "eL22"
        case 0x70507266: return self.settings // "pPrf"
        case 0x70494454: return self.setTypeOfSVG // "pIDT"
        case 0x70503936: return self.shadingResolution // "pP96"
        case 0x65303633: return self.sharp // "e063"
        case 0x53785361: return self.shearAngle // "SxSa"
        case 0x53785378: return self.shearAxis // "SxSx"
        case 0x53784461: return self.shiftAngle // "SxDa"
        case 0x53784478: return self.shiftDistance // "SxDx"
        case 0x73696e67: return self.shortFloat // "sing"
        case 0x73686f72: return self.shortInteger // "shor"
        case 0x62416c34: return self.showCenter // "bAl4"
        case 0x62416c35: return self.showCrossHairs // "bAl5"
        case 0x78785350: return self.showPlacedImages // "xxSP"
        case 0x62416c36: return self.showSafeAreas // "bAl6"
        case 0x70534463: return self.sides // "pSDc"
        case 0x65346130: return self.singleFullPage // "e4a0"
        case 0x63504137: return self.singleWordJustification // "cPA7"
        case 0x7074737a: return self.size // "ptsz"
        case 0x7041536c: return self.sliced // "pASl"
        case 0x7045536c: return self.slices // "pESl"
        case 0x65414537: return self.smallCaps // "eAE7"
        case 0x65303536: return self.smooth // "e056"
        case 0x746f5363: return self.snapCurveToLines // "toSc"
        case 0x65333034: return self.softLight // "e304"
        case 0x6b664149: return self.sourceArt // "kfAI"
        case 0x65346632: return self.sourceProfile // "e4f2"
        case 0x63504130: return self.spaceAfter // "cPA0"
        case 0x70543130: return self.spaceBefore // "pT10"
        case 0x70535041: return self.spacing // "pSPA"
        case 0x654c3133: return self.Spanish // "eL13"
        case 0x7878534c: return self.splitLongPaths // "xxSL"
        case 0x63614343: return self.spot // "caCC"
        case 0x6b434d59: return self.spotCmykColor // "kCMY"
        case 0x65343237: return self.spotColor // "e427"
        case 0x74435369: return self.spotColorInfo // "tCSi"
        case 0x70506233: return self.spotFunction // "pPb3"
        case 0x70503134: return self.spotFunctions // "pP14"
        case 0x7053434b: return self.spotKind // "pSCK"
        case 0x6b4c4142: return self.spotLabColor // "kLAB"
        case 0x6b524742: return self.spotRgbColor // "kRGB"
        case 0x65303830: return self.standard // "e080"
        case 0x654c3033: return self.standardFrench // "eL03"
        case 0x654c3035: return self.standardGerman // "eL05"
        case 0x654c3131: return self.standardPortuguese // "eL11"
        case 0x73685354: return self.star // "shST"
        case 0x70545354: return self.startTValue // "pTST"
        case 0x70535450: return self.startupPreset // "pSTP"
        case 0x7044504e: return self.startupPreset // "pDPN"
        case 0x7053504c: return self.startupPresets // "pSPL"
        case 0x70737064: return self.stationery // "pspd"
        case 0x63614c4d: return self.status // "caLM"
        case 0x7847534f: return self.stopOpacity // "xGSO"
        case 0x6353544f: return self.story // "cSTO"
        case 0x70433038: return self.strikeThrough // "pC08"
        case 0x54455854: return self.string // "TEXT"
        case 0x61694378: return self.strokeCap // "aiCx"
        case 0x61695343: return self.strokeColor // "aiSC"
        case 0x61695350: return self.stroked // "aiSP"
        case 0x61694453: return self.strokeDashes // "aiDS"
        case 0x6169444f: return self.strokeDashOffset // "aiDO"
        case 0x61694a6e: return self.strokeJoin // "aiJn"
        case 0x61694d78: return self.strokeMiterLimit // "aiMx"
        case 0x6169534f: return self.strokeOverprint // "aiSO"
        case 0x746f5374: return self.strokes // "toSt"
        case 0x70433139: return self.strokeWeight // "pC19"
        case 0x61695357: return self.strokeWidth // "aiSW"
        case 0x65303635: return self.strong // "e065"
        case 0x74787374: return self.style // "txst"
        case 0x65343131: return self.styleAttributes // "e411"
        case 0x7374796c: return self.styledClipboardText // "styl"
        case 0x53545854: return self.styledText // "STXT"
        case 0x65343132: return self.styleElements // "e412"
        case 0x7043306b: return self.stylisticAlternates // "pC0k"
        case 0x65323932: return self.subsampling // "e292"
        case 0x704f5438: return self.subscript_ // "pOT8"
        case 0x65346331: return self.subset // "e4c1"
        case 0x73756e20: return self.Sunday // "sun "
        case 0x704f5439: return self.superscript // "pOT9"
        case 0x65333332: return self.SVG // "e332"
        case 0x65334230: return self.SVG10x2E0 // "e3B0"
        case 0x65334231: return self.SVG10x2E1 // "e3B1"
        case 0x65334234: return self.SVGBasic10x2E1 // "e3B4"
        case 0x74454f53: return self.SVGExportOptions // "tEOS"
        case 0x65334131: return self.SVGFont // "e3A1"
        case 0x65334232: return self.SVGTiny10x2E1 // "e3B2"
        case 0x65334233: return self.SVGTiny10x2E1Plus // "e3B3"
        case 0x65334235: return self.SVGTiny10x2E2 // "e3B5"
        case 0x70433068: return self.swash // "pC0h"
        case 0x63615357: return self.swatch // "caSW"
        case 0x65313936: return self.swatchesLibrary // "e196"
        case 0x63534772: return self.swatchgroup // "cSGr"
        case 0x654c3134: return self.Swedish // "eL14"
        case 0x65465631: return self.SWFVersion1 // "eFV1"
        case 0x65465632: return self.SWFVersion2 // "eFV2"
        case 0x65465633: return self.SWFVersion3 // "eFV3"
        case 0x65465634: return self.SWFVersion4 // "eFV4"
        case 0x65465635: return self.SWFVersion5 // "eFV5"
        case 0x65465636: return self.SWFVersion6 // "eFV6"
        case 0x65465637: return self.SWFVersion7 // "eFV7"
        case 0x65465638: return self.SWFVersion8 // "eFV8"
        case 0x65465639: return self.SWFVersion9 // "eFV9"
        case 0x654c3037: return self.SwissGerman // "eL07"
        case 0x654c3434: return self.SwissGerman2006Reform // "eL44"
        case 0x63615359: return self.symbol // "caSY"
        case 0x65535237: return self.symbolBottomleftPoint // "eSR7"
        case 0x65535238: return self.symbolBottommiddlePoint // "eSR8"
        case 0x65535239: return self.symbolBottomrightPoint // "eSR9"
        case 0x65535235: return self.symbolCenterPoint // "eSR5"
        case 0x63615349: return self.symbolItem // "caSI"
        case 0x65535234: return self.symbolMiddleleftPoint // "eSR4"
        case 0x65535236: return self.symbolMiddlerightPoint // "eSR6"
        case 0x65313939: return self.symbolsLibrary // "e199"
        case 0x65535231: return self.symbolTopleftPoint // "eSR1"
        case 0x65535232: return self.symbolTopmiddlePoint // "eSR2"
        case 0x65535233: return self.symbolToprightPoint // "eSR3"
        case 0x74545369: return self.tabStopInfo // "tTSi"
        case 0x70543233: return self.tabStops // "pT23"
        case 0x70465331: return self.tabular // "pFS1"
        case 0x70465334: return self.tabularOldstyle // "pFS4"
        case 0x63615447: return self.tag // "caTG"
        case 0x654c3535: return self.Tamil // "eL55"
        case 0x65414564: return self.TateChuYoko // "eAEd"
        case 0x70433133: return self.TCYHorizontal // "pC13"
        case 0x70433132: return self.TCYVertical // "pC12"
        case 0x654c3536: return self.Telugu // "eL56"
        case 0x63747874: return self.text // "ctxt"
        case 0x63545866: return self.textFont // "cTXf"
        case 0x63545861: return self.textFrame // "cTXa"
        case 0x70464954: return self.textkerning // "pFIT"
        case 0x70744f52: return self.textOrientation // "ptOR"
        case 0x63545870: return self.textPath // "cTXp"
        case 0x70467450: return self.textPolicy // "pFtP"
        case 0x70535430: return self.textRange // "pST0"
        case 0x74737479: return self.textStyleInfo // "tsty"
        case 0x65343432: return self.textual // "e442"
        case 0x6541456a: return self.thirdWidth // "eAEj"
        case 0x746f5468: return self.threshold // "toTh"
        case 0x74687520: return self.Thursday // "thu "
        case 0x65333338: return self.TIFF // "e338"
        case 0x74454154: return self.TIFFExportOptions // "tEAT"
        case 0x54494646: return self.TIFFPicture // "TIFF"
        case 0x78785446: return self.tileFullPages // "xxTF"
        case 0x70503637: return self.tiling // "pP67"
        case 0x54494e54: return self.tint // "TINT"
        case 0x65346432: return self.tintSubstitution // "e4d2"
        case 0x70544954: return self.title // "pTIT"
        case 0x65414535: return self.titleCase // "eAE5"
        case 0x70433069: return self.titling // "pC0i"
        case 0x65313735: return self.top // "e175"
        case 0x65344131: return self.topDown // "e4A1"
        case 0x65313732: return self.topLeft // "e172"
        case 0x65313738: return self.topRight // "e178"
        case 0x65547454: return self.topToTop // "eTtT"
        case 0x67745472: return self.tracing // "gtTr"
        case 0x746f4354: return self.TracingColorTypeValue // "toCT"
        case 0x746f4d65: return self.TracingMethod // "toMe"
        case 0x746f4d64: return self.tracingMode // "toMd"
        case 0x63615472: return self.tracingobject // "caTr"
        case 0x6361544f: return self.tracingoptions // "caTO"
        case 0x74724f73: return self.tracingOptions // "trOs"
        case 0x7054534c: return self.tracingPresets // "pTSL"
        case 0x70543036: return self.tracking // "pT06"
        case 0x65414565: return self.traditional // "eAEe"
        case 0x70547063: return self.transparency // "pTpc"
        case 0x70445447: return self.transparencyGrid // "pDTG"
        case 0x65346c31: return self.transparent // "e4l1"
        case 0x65323135: return self.transparentColorTIFF // "e215"
        case 0x70507031: return self.transverse // "pPp1"
        case 0x703e4352: return self.trapped // "p>CR"
        case 0x70506d32: return self.trapping // "pPm2"
        case 0x70506d33: return self.trappingOrder // "pPm3"
        case 0x70503733: return self.trimMarks // "pP73"
        case 0x70503732: return self.trimMarksWeight // "pP72"
        case 0x703e5457: return self.trimMarkWeight // "p>TW"
        case 0x65353730: return self.trimmarkweight0125 // "e570"
        case 0x65353731: return self.trimmarkweight025 // "e571"
        case 0x65353732: return self.trimmarkweight05 // "e572"
        case 0x65414333: return self.trueColors // "eAC3"
        case 0x70433076: return self.Tsume // "pC0v"
        case 0x74756520: return self.Tuesday // "tue "
        case 0x654c3237: return self.Turkish // "eL27"
        case 0x74797065: return self.typeClass // "type"
        case 0x744f5054: return self.typeOptimized // "tOPT"
        case 0x654c3135: return self.UKEnglish // "eL15"
        case 0x654c3230: return self.Ukranian // "eL20"
        case 0x70433037: return self.underline // "pC07"
        case 0x75747874: return self.unicodeText // "utxt"
        case 0x65334332: return self.uniqueSvg // "e3C2"
        case 0x65313230: return self.unknown // "e120"
        case 0x6d61676e: return self.unsignedInteger // "magn"
        case 0x704c474d: return self.updateLegacyGradientMesh // "pLGM"
        case 0x70434c54: return self.updateLegacyText // "pCLT"
        case 0x65414533: return self.upperCase // "eAE3"
        case 0x7055524c: return self.URL // "pURL"
        case 0x74724e43: return self.usedColorCount // "trNC"
        case 0x78784453: return self.useDefaultScreen // "xxDS"
        case 0x65544366: return self.useFullColors // "eTCf"
        case 0x6554436c: return self.useLimitedColors // "eTCl"
        case 0x7055494c: return self.userInteractionLevel // "pUIL"
        case 0x65343032: return self.UTF16 // "e402"
        case 0x75743136: return self.utf16Text // "ut16"
        case 0x65343031: return self.UTF8 // "e401"
        case 0x75746638: return self.utf8Text // "utf8"
        case 0x61695456: return self.value // "aiTV"
        case 0x74566172: return self.variable // "tVar"
        case 0x70444c56: return self.variablesLocked // "pDLV"
        case 0x76657273: return self.version // "vers"
        case 0x65353831: return self.version10x2E0 // "e581"
        case 0x65353832: return self.version20x2E0 // "e582"
        case 0x65303731: return self.vertical // "e071"
        case 0x70524476: return self.verticalRadius // "pRDv"
        case 0x65414563: return self.verticalRotated // "eAEc"
        case 0x70535959: return self.verticalScale // "pSYY"
        case 0x70567453: return self.verticalScaling // "pVtS"
        case 0x6b415654: return self.verticalTile // "kAVT"
        case 0x70565052: return self.videoDocumentPreset // "pVPR"
        case 0x63614456: return self.view // "caDV"
        case 0x746f5676: return self.viewMode // "toVv"
        case 0x65547633: return self.viewOutlines // "eTv3"
        case 0x65547632: return self.viewOutlinesWithTracing // "eTv2"
        case 0x65547634: return self.viewOutlinesWithTransparentImage // "eTv4"
        case 0x703e5653: return self.viewPdf // "p>VS"
        case 0x65547635: return self.viewSourceImage // "eTv5"
        case 0x65547631: return self.viewTracingResult // "eTv1"
        case 0x65343431: return self.visibility // "e441"
        case 0x70564956: return self.visibilityVariable // "pVIV"
        case 0x70766973: return self.visible // "pvis"
        case 0x61695642: return self.visibleBounds // "aiVB"
        case 0x65343632: return self.visibleLayers // "e462"
        case 0x65343631: return self.visiblePrintableLayers // "e461"
        case 0x70433130: return self.warichuCharactersAfterBreak // "pC10"
        case 0x7043307a: return self.warichuCharactersBeforeBreak // "pC0z"
        case 0x70433165: return self.warichuEnabled // "pC1e"
        case 0x70433078: return self.warichuGap // "pC0x"
        case 0x70433131: return self.warichuJustification // "pC11"
        case 0x70433077: return self.warichuLines // "pC0w"
        case 0x70433079: return self.warichuScale // "pC0y"
        case 0x70455772: return self.warnings // "pEWr"
        case 0x65333533: return self.web // "e353"
        case 0x70575052: return self.webDocumentPreset // "pWPR"
        case 0x70575063: return self.webSnap // "pWPc"
        case 0x77656420: return self.Wednesday // "wed "
        case 0x77686974: return self.whitespace // "whit"
        case 0x70534877: return self.width // "pSHw"
        case 0x44576468: return self.width // "DWdh"
        case 0x63776f72: return self.word // "cwor"
        case 0x65333339: return self.WOSVG // "e339"
        case 0x70547749: return self.wrapInside // "pTwI"
        case 0x7054774f: return self.wrapOffset // "pTwO"
        case 0x70745752: return self.wrapped // "ptWR"
        case 0x7057724c: return self.writeLayers // "pWrL"
        case 0x70736374: return self.writingCode // "psct"
        case 0x70584d50: return self.XMPString // "pXMP"
        case 0x59454c4c: return self.yellow // "YELL"
        case 0x70506d61: return self.yellowInk // "pPma"
        case 0x79657320: return self.yes // "yes "
        case 0x65323733: return self.ZIP // "e273"
        case 0x65323561: return self.ZIP4bit // "e25a"
        case 0x65323562: return self.ZIP8bit // "e25b"
        case 0x61695a4d: return self.zoom // "aiZM"
        default: return super.symbol(code, type: type, descriptor: descriptor) as! ICCSymbol
        }
    }

    // Types/properties
    public static let a = ICCSymbol(name: "a", code: 0x4c616241, type: typeType) // "LabA"
    public static let acrobatLayers = ICCSymbol(name: "acrobatLayers", code: 0x703e504c, type: typeType) // "p>PL"
    public static let addToRecentFiles = ICCSymbol(name: "addToRecentFiles", code: 0x70415452, type: typeType) // "pATR"
    public static let akiLeft = ICCSymbol(name: "akiLeft", code: 0x70433134, type: typeType) // "pC14"
    public static let akiRight = ICCSymbol(name: "akiRight", code: 0x70433135, type: typeType) // "pC15"
    public static let alias = ICCSymbol(name: "alias", code: 0x616c6973, type: typeType) // "alis"
    public static let alignment = ICCSymbol(name: "alignment", code: 0x54733031, type: typeType) // "Ts01"
    public static let allowPrinting = ICCSymbol(name: "allowPrinting", code: 0x703e5041, type: typeType) // "p>PA"
    public static let alternateGlyphs = ICCSymbol(name: "alternateGlyphs", code: 0x70433075, type: typeType) // "pC0u"
    public static let alterPathsForAppearance = ICCSymbol(name: "alterPathsForAppearance", code: 0x70414150, type: typeType) // "pAAP"
    public static let anchor = ICCSymbol(name: "anchor", code: 0x70416e63, type: typeType) // "pAnc"
    public static let anchorCount = ICCSymbol(name: "anchorCount", code: 0x74724143, type: typeType) // "trAC"
    public static let angle = ICCSymbol(name: "angle", code: 0x7041474c, type: typeType) // "pAGL"
    public static let antialias = ICCSymbol(name: "antialias", code: 0x70544161, type: typeType) // "pTAa"
    public static let antialiasing = ICCSymbol(name: "antialiasing", code: 0x70416e41, type: typeType) // "pAnA"
    public static let antialiasingMethod = ICCSymbol(name: "antialiasingMethod", code: 0x65414c53, type: typeType) // "eALS"
    public static let anything = ICCSymbol(name: "anything", code: 0x2a2a2a2a, type: typeType) // "****"
    public static let application = ICCSymbol(name: "application", code: 0x63617070, type: typeType) // "capp"
    public static let applicationBundleId = ICCSymbol(name: "applicationBundleId", code: 0x62756e64, type: typeType) // "bund"
    public static let applicationSignature = ICCSymbol(name: "applicationSignature", code: 0x7369676e, type: typeType) // "sign"
    public static let applicationUrl = ICCSymbol(name: "applicationUrl", code: 0x6170726c, type: typeType) // "aprl"
    public static let April = ICCSymbol(name: "April", code: 0x61707220, type: typeType) // "apr "
    public static let area = ICCSymbol(name: "area", code: 0x61694152, type: typeType) // "aiAR"
    public static let artboard = ICCSymbol(name: "artboard", code: 0x64496d31, type: typeType) // "dIm1"
    public static let artboardClipping = ICCSymbol(name: "artboardClipping", code: 0x70414243, type: typeType) // "pABC"
    public static let artboardLayout = ICCSymbol(name: "artboardLayout", code: 0x70414c79, type: typeType) // "pALy"
    public static let artboardRange = ICCSymbol(name: "artboardRange", code: 0x70503463, type: typeType) // "pP4c"
    public static let artboardRectangle = ICCSymbol(name: "artboardRectangle", code: 0x62416c31, type: typeType) // "bAl1"
    public static let artboardRowsOrCols = ICCSymbol(name: "artboardRowsOrCols", code: 0x70415243, type: typeType) // "pARC"
    public static let artboardSpacing = ICCSymbol(name: "artboardSpacing", code: 0x70415370, type: typeType) // "pASp"
    public static let artClipping = ICCSymbol(name: "artClipping", code: 0x70464143, type: typeType) // "pFAC"
    public static let artwork = ICCSymbol(name: "artwork", code: 0x63444f43, type: typeType) // "cDOC"
    public static let as_ = ICCSymbol(name: "as_", code: 0x666c7470, type: typeType) // "fltp"
    public static let August = ICCSymbol(name: "August", code: 0x61756720, type: typeType) // "aug "
    public static let AutoCADExportOptions = ICCSymbol(name: "AutoCADExportOptions", code: 0x74454143, type: typeType) // "tEAC"
    public static let AutoCADFileOptions = ICCSymbol(name: "AutoCADFileOptions", code: 0x70504632, type: typeType) // "pPF2"
    public static let AutoCADOptions = ICCSymbol(name: "AutoCADOptions", code: 0x744f4f41, type: typeType) // "tOOA"
    public static let AutoCADVersion = ICCSymbol(name: "AutoCADVersion", code: 0x70415653, type: typeType) // "pAVS"
    public static let autoKerning0x28obsoleteUse0x27kerningMethod0x270x29 = ICCSymbol(name: "autoKerning0x28obsoleteUse0x27kerningMethod0x270x29", code: 0x70543037, type: typeType) // "pT07"
    public static let autoLeading = ICCSymbol(name: "autoLeading", code: 0x70433033, type: typeType) // "pC03"
    public static let autoLeadingAmount = ICCSymbol(name: "autoLeadingAmount", code: 0x63504161, type: typeType) // "cPAa"
    public static let b = ICCSymbol(name: "b", code: 0x4c616242, type: typeType) // "LabB"
    public static let backgroundBlack = ICCSymbol(name: "backgroundBlack", code: 0x7042424b, type: typeType) // "pBBK"
    public static let backgroundColor = ICCSymbol(name: "backgroundColor", code: 0x70464243, type: typeType) // "pFBC"
    public static let backgroundLayers = ICCSymbol(name: "backgroundLayers", code: 0x7046424c, type: typeType) // "pFBL"
    public static let baselineDirection = ICCSymbol(name: "baselineDirection", code: 0x70433073, type: typeType) // "pC0s"
    public static let baselinePosition = ICCSymbol(name: "baselinePosition", code: 0x70433035, type: typeType) // "pC05"
    public static let baselineShift = ICCSymbol(name: "baselineShift", code: 0x70543034, type: typeType) // "pT04"
    public static let best = ICCSymbol(name: "best", code: 0x62657374, type: typeType) // "best"
    public static let bestType = ICCSymbol(name: "bestType", code: 0x70627374, type: typeType) // "pbst"
    public static let binaryPrinting = ICCSymbol(name: "binaryPrinting", code: 0x70503039, type: typeType) // "pP09"
    public static let bitmapResolution = ICCSymbol(name: "bitmapResolution", code: 0x70503461, type: typeType) // "pP4a"
    public static let bitsPerChannel = ICCSymbol(name: "bitsPerChannel", code: 0x63425043, type: typeType) // "cBPC"
    public static let black = ICCSymbol(name: "black", code: 0x424c414b, type: typeType) // "BLAK"
    public static let bleedLink = ICCSymbol(name: "bleedLink", code: 0x703e424b, type: typeType) // "p>BK"
    public static let bleedOffset = ICCSymbol(name: "bleedOffset", code: 0x70503737, type: typeType) // "pP77"
    public static let blendAnimation = ICCSymbol(name: "blendAnimation", code: 0x70464241, type: typeType) // "pFBA"
    public static let blendMode = ICCSymbol(name: "blendMode", code: 0x70426c4d, type: typeType) // "pBlM"
    public static let blendsPolicy = ICCSymbol(name: "blendsPolicy", code: 0x70466250, type: typeType) // "pFbP"
    public static let blue = ICCSymbol(name: "blue", code: 0x424c5545, type: typeType) // "BLUE"
    public static let blur = ICCSymbol(name: "blur", code: 0x70426c41, type: typeType) // "pBlA"
    public static let boolean = ICCSymbol(name: "boolean", code: 0x626f6f6c, type: typeType) // "bool"
    public static let boundingBox = ICCSymbol(name: "boundingBox", code: 0x61694258, type: typeType) // "aiBX"
    public static let boundingRectangle = ICCSymbol(name: "boundingRectangle", code: 0x71647274, type: typeType) // "qdrt"
    public static let bounds = ICCSymbol(name: "bounds", code: 0x70626e64, type: typeType) // "pbnd"
    public static let browserAvailable = ICCSymbol(name: "browserAvailable", code: 0x78794241, type: typeType) // "xyBA"
    public static let brush = ICCSymbol(name: "brush", code: 0x63614252, type: typeType) // "caBR"
    public static let buildNumber = ICCSymbol(name: "buildNumber", code: 0x70414142, type: typeType) // "pAAB"
    public static let BunriKinshi = ICCSymbol(name: "BunriKinshi", code: 0x65504a38, type: typeType) // "ePJ8"
    public static let BurasagariType = ICCSymbol(name: "BurasagariType", code: 0x65504a39, type: typeType) // "ePJ9"
    public static let ByteOrder = ICCSymbol(name: "ByteOrder", code: 0x7454424f, type: typeType) // "tTBO"
    public static let capitalization = ICCSymbol(name: "capitalization", code: 0x70433034, type: typeType) // "pC04"
    public static let centerArtwork = ICCSymbol(name: "centerArtwork", code: 0x70434177, type: typeType) // "pCAw"
    public static let centerPoint = ICCSymbol(name: "centerPoint", code: 0x61694354, type: typeType) // "aiCT"
    public static let changesAllowed = ICCSymbol(name: "changesAllowed", code: 0x703e4347, type: typeType) // "p>CG"
    public static let channels = ICCSymbol(name: "channels", code: 0x6343484e, type: typeType) // "cCHN"
    public static let character = ICCSymbol(name: "character", code: 0x63686120, type: typeType) // "cha "
    public static let characterOffset = ICCSymbol(name: "characterOffset", code: 0x70535452, type: typeType) // "pSTR"
    public static let characterStyle = ICCSymbol(name: "characterStyle", code: 0x63435354, type: typeType) // "cCST"
    public static let class_ = ICCSymbol(name: "class_", code: 0x70636c73, type: typeType) // "pcls"
    public static let clipComplexRegions = ICCSymbol(name: "clipComplexRegions", code: 0x70506e36, type: typeType) // "pPn6"
    public static let clipped = ICCSymbol(name: "clipped", code: 0x61694370, type: typeType) // "aiCp"
    public static let clipping = ICCSymbol(name: "clipping", code: 0x61694350, type: typeType) // "aiCP"
    public static let clippingMask = ICCSymbol(name: "clippingMask", code: 0x704d534b, type: typeType) // "pMSK"
    public static let closed = ICCSymbol(name: "closed", code: 0x6169436c, type: typeType) // "aiCl"
    public static let CMYKColorInfo = ICCSymbol(name: "CMYKColorInfo", code: 0x74434d69, type: typeType) // "tCMi"
    public static let CMYKPostScript = ICCSymbol(name: "CMYKPostScript", code: 0x70435053, type: typeType) // "pCPS"
    public static let collate = ICCSymbol(name: "collate", code: 0x70503437, type: typeType) // "pP47"
    public static let color = ICCSymbol(name: "color", code: 0x636f6c72, type: typeType) // "colr"
    public static let colorants = ICCSymbol(name: "colorants", code: 0x634f4c73, type: typeType) // "cOLs"
    public static let colorBars = ICCSymbol(name: "colorBars", code: 0x70503735, type: typeType) // "pP75"
    public static let colorCompression = ICCSymbol(name: "colorCompression", code: 0x703e4362, type: typeType) // "p>Cb"
    public static let colorConversionId = ICCSymbol(name: "colorConversionId", code: 0x703e4343, type: typeType) // "p>CC"
    public static let colorCount = ICCSymbol(name: "colorCount", code: 0x70436c43, type: typeType) // "pClC"
    public static let colorDestinationId = ICCSymbol(name: "colorDestinationId", code: 0x703e434e, type: typeType) // "p>CN"
    public static let colorDither = ICCSymbol(name: "colorDither", code: 0x70434474, type: typeType) // "pCDt"
    public static let colorDownsampling = ICCSymbol(name: "colorDownsampling", code: 0x703e4344, type: typeType) // "p>CD"
    public static let colorDownsamplingThreshold = ICCSymbol(name: "colorDownsamplingThreshold", code: 0x703e4341, type: typeType) // "p>CA"
    public static let colorFidelity = ICCSymbol(name: "colorFidelity", code: 0x746f4d63, type: typeType) // "toMc"
    public static let colorgroup = ICCSymbol(name: "colorgroup", code: 0x746f4367, type: typeType) // "toCg"
    public static let colorInfo = ICCSymbol(name: "colorInfo", code: 0x74414943, type: typeType) // "tAIC"
    public static let colorized = ICCSymbol(name: "colorized", code: 0x63434f4c, type: typeType) // "cCOL"
    public static let colorManagementOptions = ICCSymbol(name: "colorManagementOptions", code: 0x7450434d, type: typeType) // "tPCM"
    public static let colorManagementSettings = ICCSymbol(name: "colorManagementSettings", code: 0x70503362, type: typeType) // "pP3b"
    public static let colorMode = ICCSymbol(name: "colorMode", code: 0x7044434d, type: typeType) // "pDCM"
    public static let colorModel = ICCSymbol(name: "colorModel", code: 0x65434d64, type: typeType) // "eCMd"
    public static let colorProfileId = ICCSymbol(name: "colorProfileId", code: 0x703e4350, type: typeType) // "p>CP"
    public static let colorProfileName = ICCSymbol(name: "colorProfileName", code: 0x7043504e, type: typeType) // "pCPN"
    public static let colorReduction = ICCSymbol(name: "colorReduction", code: 0x70435264, type: typeType) // "pCRd"
    public static let colorResample = ICCSymbol(name: "colorResample", code: 0x703e4353, type: typeType) // "p>CS"
    public static let colors = ICCSymbol(name: "colors", code: 0x7041434c, type: typeType) // "pACL"
    public static let colorSeparationOptions = ICCSymbol(name: "colorSeparationOptions", code: 0x74504353, type: typeType) // "tPCS"
    public static let colorSeparationSettings = ICCSymbol(name: "colorSeparationSettings", code: 0x70503336, type: typeType) // "pP36"
    public static let colorSettings = ICCSymbol(name: "colorSettings", code: 0x7043534c, type: typeType) // "pCSL"
    public static let colorSpace = ICCSymbol(name: "colorSpace", code: 0x63614353, type: typeType) // "caCS"
    public static let colorSupport = ICCSymbol(name: "colorSupport", code: 0x70503033, type: typeType) // "pP03"
    public static let colorTable = ICCSymbol(name: "colorTable", code: 0x636c7274, type: typeType) // "clrt"
    public static let colorTileSize = ICCSymbol(name: "colorTileSize", code: 0x703e4354, type: typeType) // "p>CT"
    public static let colorType = ICCSymbol(name: "colorType", code: 0x70614354, type: typeType) // "paCT"
    public static let columnCount = ICCSymbol(name: "columnCount", code: 0x70434c43, type: typeType) // "pCLC"
    public static let columnGutter = ICCSymbol(name: "columnGutter", code: 0x70434c47, type: typeType) // "pCLG"
    public static let compatibility = ICCSymbol(name: "compatibility", code: 0x70494370, type: typeType) // "pICp"
    public static let compatibleGradientPrinting = ICCSymbol(name: "compatibleGradientPrinting", code: 0x70434750, type: typeType) // "pCGP"
    public static let compatibleShading = ICCSymbol(name: "compatibleShading", code: 0x70503935, type: typeType) // "pP95"
    public static let compoundPathItem = ICCSymbol(name: "compoundPathItem", code: 0x63614350, type: typeType) // "caCP"
    public static let compoundShapes = ICCSymbol(name: "compoundShapes", code: 0x70454353, type: typeType) // "pECS"
    public static let compressArt = ICCSymbol(name: "compressArt", code: 0x703e544c, type: typeType) // "p>TL"
    public static let compressed = ICCSymbol(name: "compressed", code: 0x70434463, type: typeType) // "pCDc"
    public static let connectionForms = ICCSymbol(name: "connectionForms", code: 0x7043306a, type: typeType) // "pC0j"
    public static let container = ICCSymbol(name: "container", code: 0x63746e72, type: typeType) // "ctnr"
    public static let contents = ICCSymbol(name: "contents", code: 0x70434e54, type: typeType) // "pCNT"
    public static let contentVariable = ICCSymbol(name: "contentVariable", code: 0x70434f56, type: typeType) // "pCOV"
    public static let contextualLigature = ICCSymbol(name: "contextualLigature", code: 0x70433063, type: typeType) // "pC0c"
    public static let controlBounds = ICCSymbol(name: "controlBounds", code: 0x61694e58, type: typeType) // "aiNX"
    public static let convertCropAreaToArtboard = ICCSymbol(name: "convertCropAreaToArtboard", code: 0x70434341, type: typeType) // "pCCA"
    public static let converted = ICCSymbol(name: "converted", code: 0x7043744e, type: typeType) // "pCtN"
    public static let convertSpotColors = ICCSymbol(name: "convertSpotColors", code: 0x70503532, type: typeType) // "pP52"
    public static let convertStrokesToOutlines = ICCSymbol(name: "convertStrokesToOutlines", code: 0x70506e35, type: typeType) // "pPn5"
    public static let convertTextToOutlines = ICCSymbol(name: "convertTextToOutlines", code: 0x70506e34, type: typeType) // "pPn4"
    public static let convertTilesToArtboard = ICCSymbol(name: "convertTilesToArtboard", code: 0x70435441, type: typeType) // "pCTA"
    public static let coordinateOptions = ICCSymbol(name: "coordinateOptions", code: 0x7450434f, type: typeType) // "tPCO"
    public static let coordinatePrecision = ICCSymbol(name: "coordinatePrecision", code: 0x70446350, type: typeType) // "pDcP"
    public static let coordinateSettings = ICCSymbol(name: "coordinateSettings", code: 0x70503337, type: typeType) // "pP37"
    public static let coordinateSystem = ICCSymbol(name: "coordinateSystem", code: 0x70436f53, type: typeType) // "pCoS"
    public static let copies = ICCSymbol(name: "copies", code: 0x70503433, type: typeType) // "pP43"
    public static let CornerFidelity = ICCSymbol(name: "CornerFidelity", code: 0x746f4372, type: typeType) // "toCr"
    public static let createArtboardWithArtworkBoundingBox = ICCSymbol(name: "createArtboardWithArtworkBoundingBox", code: 0x70434142, type: typeType) // "pCAB"
    public static let cropMarks = ICCSymbol(name: "cropMarks", code: 0x78784342, type: typeType) // "xxCB"
    public static let cropStyle = ICCSymbol(name: "cropStyle", code: 0x78784353, type: typeType) // "xxCS"
    public static let CSSProperties = ICCSymbol(name: "CSSProperties", code: 0x70435353, type: typeType) // "pCSS"
    public static let currentAdobeId = ICCSymbol(name: "currentAdobeId", code: 0x70414944, type: typeType) // "pAID"
    public static let currentDataset = ICCSymbol(name: "currentDataset", code: 0x70444144, type: typeType) // "pDAD"
    public static let currentDocument = ICCSymbol(name: "currentDocument", code: 0x61694144, type: typeType) // "aiAD"
    public static let currentLayer = ICCSymbol(name: "currentLayer", code: 0x6169434c, type: typeType) // "aiCL"
    public static let currentUserGuid = ICCSymbol(name: "currentUserGuid", code: 0x70474944, type: typeType) // "pGID"
    public static let currentView = ICCSymbol(name: "currentView", code: 0x61694356, type: typeType) // "aiCV"
    public static let curveQuality = ICCSymbol(name: "curveQuality", code: 0x70464351, type: typeType) // "pFCQ"
    public static let customColor = ICCSymbol(name: "customColor", code: 0x70506d36, type: typeType) // "pPm6"
    public static let customPaper = ICCSymbol(name: "customPaper", code: 0x70503232, type: typeType) // "pP22"
    public static let customPaperSizes = ICCSymbol(name: "customPaperSizes", code: 0x70503036, type: typeType) // "pP06"
    public static let customPaperTransverse = ICCSymbol(name: "customPaperTransverse", code: 0x70503037, type: typeType) // "pP07"
    public static let cyan = ICCSymbol(name: "cyan", code: 0x4359414e, type: typeType) // "CYAN"
    public static let dashStyle = ICCSymbol(name: "dashStyle", code: 0x74646173, type: typeType) // "tdas"
    public static let data = ICCSymbol(name: "data", code: 0x74647461, type: typeType) // "tdta"
    public static let dataset = ICCSymbol(name: "dataset", code: 0x74445374, type: typeType) // "tDSt"
    public static let date = ICCSymbol(name: "date", code: 0x6c647420, type: typeType) // "ldt "
    public static let December = ICCSymbol(name: "December", code: 0x64656320, type: typeType) // "dec "
    public static let decimalCharacter = ICCSymbol(name: "decimalCharacter", code: 0x54733032, type: typeType) // "Ts02"
    public static let decimalStruct = ICCSymbol(name: "decimalStruct", code: 0x6465636d, type: typeType) // "decm"
    public static let defaultColorSettings = ICCSymbol(name: "defaultColorSettings", code: 0x61474353, type: typeType) // "aGCS"
    public static let defaultFillColor = ICCSymbol(name: "defaultFillColor", code: 0x44694643, type: typeType) // "DiFC"
    public static let defaultFilled = ICCSymbol(name: "defaultFilled", code: 0x44694650, type: typeType) // "DiFP"
    public static let defaultFillOverprint = ICCSymbol(name: "defaultFillOverprint", code: 0x4469464f, type: typeType) // "DiFO"
    public static let defaultResolution = ICCSymbol(name: "defaultResolution", code: 0x70503034, type: typeType) // "pP04"
    public static let defaultScreen = ICCSymbol(name: "defaultScreen", code: 0x70506231, type: typeType) // "pPb1"
    public static let defaultStrokeCap = ICCSymbol(name: "defaultStrokeCap", code: 0x44694378, type: typeType) // "DiCx"
    public static let defaultStrokeColor = ICCSymbol(name: "defaultStrokeColor", code: 0x44695343, type: typeType) // "DiSC"
    public static let defaultStroked = ICCSymbol(name: "defaultStroked", code: 0x44695350, type: typeType) // "DiSP"
    public static let defaultStrokeDashes = ICCSymbol(name: "defaultStrokeDashes", code: 0x44694453, type: typeType) // "DiDS"
    public static let defaultStrokeDashOffset = ICCSymbol(name: "defaultStrokeDashOffset", code: 0x4469444f, type: typeType) // "DiDO"
    public static let defaultStrokeJoin = ICCSymbol(name: "defaultStrokeJoin", code: 0x44694a6e, type: typeType) // "DiJn"
    public static let defaultStrokeMiterLimit = ICCSymbol(name: "defaultStrokeMiterLimit", code: 0x44694d78, type: typeType) // "DiMx"
    public static let defaultStrokeOverprint = ICCSymbol(name: "defaultStrokeOverprint", code: 0x4469534f, type: typeType) // "DiSO"
    public static let defaultStrokeWidth = ICCSymbol(name: "defaultStrokeWidth", code: 0x44695357, type: typeType) // "DiSW"
    public static let defaultType = ICCSymbol(name: "defaultType", code: 0x64656674, type: typeType) // "deft"
    public static let density = ICCSymbol(name: "density", code: 0x70506d34, type: typeType) // "pPm4"
    public static let designation = ICCSymbol(name: "designation", code: 0x70503431, type: typeType) // "pP41"
    public static let desiredGlyphScaling = ICCSymbol(name: "desiredGlyphScaling", code: 0x63504139, type: typeType) // "cPA9"
    public static let desiredLetterSpacing = ICCSymbol(name: "desiredLetterSpacing", code: 0x70543166, type: typeType) // "pT1f"
    public static let desiredWordSpacing = ICCSymbol(name: "desiredWordSpacing", code: 0x70543163, type: typeType) // "pT1c"
    public static let dimensionsInfo = ICCSymbol(name: "dimensionsInfo", code: 0x444d4e49, type: typeType) // "DMNI"
    public static let dimensionsOfPNG = ICCSymbol(name: "dimensionsOfPNG", code: 0x70444d4e, type: typeType) // "pDMN"
    public static let dimPlacedImages = ICCSymbol(name: "dimPlacedImages", code: 0x61694449, type: typeType) // "aiDI"
    public static let direction0x28obsoleteUse0x27baselineDirection0x270x29 = ICCSymbol(name: "direction0x28obsoleteUse0x27baselineDirection0x270x29", code: 0x70543039, type: typeType) // "pT09"
    public static let discretionaryLigature = ICCSymbol(name: "discretionaryLigature", code: 0x70433062, type: typeType) // "pC0b"
    public static let ditherPercent = ICCSymbol(name: "ditherPercent", code: 0x70445063, type: typeType) // "pDPc"
    public static let document = ICCSymbol(name: "document", code: 0x646f6375, type: typeType) // "docu"
    public static let documentPassword = ICCSymbol(name: "documentPassword", code: 0x703e4450, type: typeType) // "p>DP"
    public static let documentPreset = ICCSymbol(name: "documentPreset", code: 0x74445052, type: typeType) // "tDPR"
    public static let documentUnits = ICCSymbol(name: "documentUnits", code: 0x78784455, type: typeType) // "xxDU"
    public static let dotShape = ICCSymbol(name: "dotShape", code: 0x70506d37, type: typeType) // "pPm7"
    public static let doubleInteger = ICCSymbol(name: "doubleInteger", code: 0x636f6d70, type: typeType) // "comp"
    public static let downloadFonts = ICCSymbol(name: "downloadFonts", code: 0x70503831, type: typeType) // "pP81"
    public static let downsampleLinkedImages = ICCSymbol(name: "downsampleLinkedImages", code: 0x7046576c, type: typeType) // "pFWl"
    public static let editable = ICCSymbol(name: "editable", code: 0x70414564, type: typeType) // "pAEd"
    public static let editableText = ICCSymbol(name: "editableText", code: 0x70455478, type: typeType) // "pETx"
    public static let ellipse = ICCSymbol(name: "ellipse", code: 0x73684f56, type: typeType) // "shOV"
    public static let embedAllFonts = ICCSymbol(name: "embedAllFonts", code: 0x70454146, type: typeType) // "pEAF"
    public static let embedded = ICCSymbol(name: "embedded", code: 0x63614c4b, type: typeType) // "caLK"
    public static let embeddedItem = ICCSymbol(name: "embeddedItem", code: 0x6361454c, type: typeType) // "caEL"
    public static let embedICCProfile = ICCSymbol(name: "embedICCProfile", code: 0x70455066, type: typeType) // "pEPf"
    public static let embedLinkedFiles = ICCSymbol(name: "embedLinkedFiles", code: 0x70497049, type: typeType) // "pIpI"
    public static let emulsion = ICCSymbol(name: "emulsion", code: 0x70503632, type: typeType) // "pP62"
    public static let enableAccess = ICCSymbol(name: "enableAccess", code: 0x703e4541, type: typeType) // "p>EA"
    public static let enableCopy = ICCSymbol(name: "enableCopy", code: 0x703e4543, type: typeType) // "p>EC"
    public static let enableCopyAndAccess = ICCSymbol(name: "enableCopyAndAccess", code: 0x703e4542, type: typeType) // "p>EB"
    public static let enablePlaintext = ICCSymbol(name: "enablePlaintext", code: 0x703e4550, type: typeType) // "p>EP"
    public static let encodedString = ICCSymbol(name: "encodedString", code: 0x656e6373, type: typeType) // "encs"
    public static let endTValue = ICCSymbol(name: "endTValue", code: 0x70544554, type: typeType) // "pTET"
    public static let entireGradient = ICCSymbol(name: "entireGradient", code: 0x78614547, type: typeType) // "xaEG"
    public static let entirePath = ICCSymbol(name: "entirePath", code: 0x61694550, type: typeType) // "aiEP"
    public static let enumerator = ICCSymbol(name: "enumerator", code: 0x656e756d, type: typeType) // "enum"
    public static let EPSPicture = ICCSymbol(name: "EPSPicture", code: 0x45505320, type: typeType) // "EPS "
    public static let EPSSaveOptions = ICCSymbol(name: "EPSSaveOptions", code: 0x7465536f, type: typeType) // "teSo"
    public static let evenodd = ICCSymbol(name: "evenodd", code: 0x6169454f, type: typeType) // "aiEO"
    public static let everyLineComposer = ICCSymbol(name: "everyLineComposer", code: 0x65504a64, type: typeType) // "ePJd"
    public static let exportAllSymbols = ICCSymbol(name: "exportAllSymbols", code: 0x70464153, type: typeType) // "pFAS"
    public static let exportFileFormat = ICCSymbol(name: "exportFileFormat", code: 0x70414646, type: typeType) // "pAFF"
    public static let exportOption = ICCSymbol(name: "exportOption", code: 0x7041454f, type: typeType) // "pAEO"
    public static let exportSelectedArtOnly = ICCSymbol(name: "exportSelectedArtOnly", code: 0x70415341, type: typeType) // "pASA"
    public static let exportStyle = ICCSymbol(name: "exportStyle", code: 0x70465853, type: typeType) // "pFXS"
    public static let exportVersion = ICCSymbol(name: "exportVersion", code: 0x70465856, type: typeType) // "pFXV"
    public static let extendedFloat = ICCSymbol(name: "extendedFloat", code: 0x65787465, type: typeType) // "exte"
    public static let family = ICCSymbol(name: "family", code: 0x70747866, type: typeType) // "ptxf"
    public static let February = ICCSymbol(name: "February", code: 0x66656220, type: typeType) // "feb "
    public static let figureStyle = ICCSymbol(name: "figureStyle", code: 0x7043306d, type: typeType) // "pC0m"
    public static let filePath = ICCSymbol(name: "filePath", code: 0x61694653, type: typeType) // "aiFS"
    public static let fileRef = ICCSymbol(name: "fileRef", code: 0x66737266, type: typeType) // "fsrf"
    public static let fileSpecification = ICCSymbol(name: "fileSpecification", code: 0x66737320, type: typeType) // "fss "
    public static let fileUrl = ICCSymbol(name: "fileUrl", code: 0x6675726c, type: typeType) // "furl"
    public static let fillColor = ICCSymbol(name: "fillColor", code: 0x61694643, type: typeType) // "aiFC"
    public static let filled = ICCSymbol(name: "filled", code: 0x61694650, type: typeType) // "aiFP"
    public static let fillOverprint = ICCSymbol(name: "fillOverprint", code: 0x6169464f, type: typeType) // "aiFO"
    public static let fills = ICCSymbol(name: "fills", code: 0x746f466c, type: typeType) // "toFl"
    public static let filtersPolicy = ICCSymbol(name: "filtersPolicy", code: 0x70466650, type: typeType) // "pFfP"
    public static let firstBaseline = ICCSymbol(name: "firstBaseline", code: 0x7046426c, type: typeType) // "pFBl"
    public static let firstBaselineMin = ICCSymbol(name: "firstBaselineMin", code: 0x7046424d, type: typeType) // "pFBM"
    public static let firstLineIndent = ICCSymbol(name: "firstLineIndent", code: 0x70543133, type: typeType) // "pT13"
    public static let fitToPage = ICCSymbol(name: "fitToPage", code: 0x70503634, type: typeType) // "pP64"
    public static let fixed = ICCSymbol(name: "fixed", code: 0x66697864, type: typeType) // "fixd"
    public static let fixedPoint = ICCSymbol(name: "fixedPoint", code: 0x66706e74, type: typeType) // "fpnt"
    public static let fixedRectangle = ICCSymbol(name: "fixedRectangle", code: 0x66726374, type: typeType) // "frct"
    public static let FlashExportOptions = ICCSymbol(name: "FlashExportOptions", code: 0x7445464c, type: typeType) // "tEFL"
    public static let FlashPlaybackSecurity = ICCSymbol(name: "FlashPlaybackSecurity", code: 0x70465053, type: typeType) // "pFPS"
    public static let flattenerPreset = ICCSymbol(name: "flattenerPreset", code: 0x74465354, type: typeType) // "tFST"
    public static let flattenerPresets = ICCSymbol(name: "flattenerPresets", code: 0x7046534c, type: typeType) // "pFSL"
    public static let flattenerSettings = ICCSymbol(name: "flattenerSettings", code: 0x70503363, type: typeType) // "pP3c"
    public static let flatteningBalance = ICCSymbol(name: "flatteningBalance", code: 0x70506e31, type: typeType) // "pPn1"
    public static let flatteningOptions = ICCSymbol(name: "flatteningOptions", code: 0x7450464c, type: typeType) // "tPFL"
    public static let flattenOutput = ICCSymbol(name: "flattenOutput", code: 0x704f466c, type: typeType) // "pOFl"
    public static let float = ICCSymbol(name: "float", code: 0x646f7562, type: typeType) // "doub"
    public static let float128bit = ICCSymbol(name: "float128bit", code: 0x6c64626c, type: typeType) // "ldbl"
    public static let flowLinksHorizontally = ICCSymbol(name: "flowLinksHorizontally", code: 0x7052574d, type: typeType) // "pRWM"
    public static let font = ICCSymbol(name: "font", code: 0x63545866, type: typeType) // "cTXf"
    public static let fontOptions = ICCSymbol(name: "fontOptions", code: 0x7450464f, type: typeType) // "tPFO"
    public static let fontSettings = ICCSymbol(name: "fontSettings", code: 0x70503339, type: typeType) // "pP39"
    public static let fontSubsetThreshold = ICCSymbol(name: "fontSubsetThreshold", code: 0x70465354, type: typeType) // "pFST"
    public static let fontSubstitutionKind = ICCSymbol(name: "fontSubstitutionKind", code: 0x70503834, type: typeType) // "pP84"
    public static let fontType = ICCSymbol(name: "fontType", code: 0x70465459, type: typeType) // "pFTY"
    public static let forceContinuousTone = ICCSymbol(name: "forceContinuousTone", code: 0x70503934, type: typeType) // "pP94"
    public static let fractions = ICCSymbol(name: "fractions", code: 0x70433066, type: typeType) // "pC0f"
    public static let frameRate = ICCSymbol(name: "frameRate", code: 0x70464652, type: typeType) // "pFFR"
    public static let freeMemory = ICCSymbol(name: "freeMemory", code: 0x6169464d, type: typeType) // "aiFM"
    public static let frequency = ICCSymbol(name: "frequency", code: 0x70506232, type: typeType) // "pPb2"
    public static let Friday = ICCSymbol(name: "Friday", code: 0x66726920, type: typeType) // "fri "
    public static let frontmost = ICCSymbol(name: "frontmost", code: 0x70697366, type: typeType) // "pisf"
    public static let FXGSaveOptions = ICCSymbol(name: "FXGSaveOptions", code: 0x746d536f, type: typeType) // "tmSo"
    public static let fxgVersion = ICCSymbol(name: "fxgVersion", code: 0x70464376, type: typeType) // "pFCv"
    public static let generateHTML = ICCSymbol(name: "generateHTML", code: 0x70464748, type: typeType) // "pFGH"
    public static let generateThumbnails = ICCSymbol(name: "generateThumbnails", code: 0x703e4754, type: typeType) // "p>GT"
    public static let geometricBounds = ICCSymbol(name: "geometricBounds", code: 0x61694247, type: typeType) // "aiBG"
    public static let GIFExportOptions = ICCSymbol(name: "GIFExportOptions", code: 0x63474946, type: typeType) // "cGIF"
    public static let GIFPicture = ICCSymbol(name: "GIFPicture", code: 0x47494666, type: typeType) // "GIFf"
    public static let globalScaleOptions = ICCSymbol(name: "globalScaleOptions", code: 0x7047534f, type: typeType) // "pGSO"
    public static let globalScalePercent = ICCSymbol(name: "globalScalePercent", code: 0x70475350, type: typeType) // "pGSP"
    public static let gradient = ICCSymbol(name: "gradient", code: 0x63614744, type: typeType) // "caGD"
    public static let gradientColorInfo = ICCSymbol(name: "gradientColorInfo", code: 0x74474469, type: typeType) // "tGDi"
    public static let gradientResolution = ICCSymbol(name: "gradientResolution", code: 0x70506e33, type: typeType) // "pPn3"
    public static let gradientsPolicy = ICCSymbol(name: "gradientsPolicy", code: 0x70466750, type: typeType) // "pFgP"
    public static let gradientStop = ICCSymbol(name: "gradientStop", code: 0x63614753, type: typeType) // "caGS"
    public static let gradientStopInfo = ICCSymbol(name: "gradientStopInfo", code: 0x74474453, type: typeType) // "tGDS"
    public static let gradientType = ICCSymbol(name: "gradientType", code: 0x67645479, type: typeType) // "gdTy"
    public static let graphicStyle = ICCSymbol(name: "graphicStyle", code: 0x63614153, type: typeType) // "caAS"
    public static let graphicText = ICCSymbol(name: "graphicText", code: 0x63677478, type: typeType) // "cgtx"
    public static let graphItem = ICCSymbol(name: "graphItem", code: 0x63475048, type: typeType) // "cGPH"
    public static let grayColorInfo = ICCSymbol(name: "grayColorInfo", code: 0x74475269, type: typeType) // "tGRi"
    public static let grayLevels = ICCSymbol(name: "grayLevels", code: 0x746f476c, type: typeType) // "toGl"
    public static let grayscaleCompression = ICCSymbol(name: "grayscaleCompression", code: 0x703e4762, type: typeType) // "p>Gb"
    public static let grayscaleDownsampling = ICCSymbol(name: "grayscaleDownsampling", code: 0x703e4744, type: typeType) // "p>GD"
    public static let grayscaleDownsamplingThreshold = ICCSymbol(name: "grayscaleDownsamplingThreshold", code: 0x703e4741, type: typeType) // "p>GA"
    public static let grayscaleResample = ICCSymbol(name: "grayscaleResample", code: 0x703e4753, type: typeType) // "p>GS"
    public static let grayscaleTileSize = ICCSymbol(name: "grayscaleTileSize", code: 0x703e475a, type: typeType) // "p>GZ"
    public static let grayValue = ICCSymbol(name: "grayValue", code: 0x47524159, type: typeType) // "GRAY"
    public static let green = ICCSymbol(name: "green", code: 0x4752454e, type: typeType) // "GREN"
    public static let groupItem = ICCSymbol(name: "groupItem", code: 0x63614750, type: typeType) // "caGP"
    public static let guides = ICCSymbol(name: "guides", code: 0x61694744, type: typeType) // "aiGD"
    public static let hasSelectedArtwork = ICCSymbol(name: "hasSelectedArtwork", code: 0x61692424, type: typeType) // "ai$$"
    public static let height = ICCSymbol(name: "height", code: 0x70534868, type: typeType) // "pSHh"
    public static let hidden = ICCSymbol(name: "hidden", code: 0x61694844, type: typeType) // "aiHD"
    public static let hiddenLayers = ICCSymbol(name: "hiddenLayers", code: 0x7048644c, type: typeType) // "pHdL"
    public static let hiliteAngle = ICCSymbol(name: "hiliteAngle", code: 0x4764446a, type: typeType) // "GdDj"
    public static let hiliteLength = ICCSymbol(name: "hiliteLength", code: 0x47644478, type: typeType) // "GdDx"
    public static let horizontalRadius = ICCSymbol(name: "horizontalRadius", code: 0x70524468, type: typeType) // "pRDh"
    public static let horizontalScale = ICCSymbol(name: "horizontalScale", code: 0x70535858, type: typeType) // "pSXX"
    public static let horizontalScaling = ICCSymbol(name: "horizontalScaling", code: 0x70487a53, type: typeType) // "pHzS"
    public static let hyphenateCapitalizedWords = ICCSymbol(name: "hyphenateCapitalizedWords", code: 0x63504133, type: typeType) // "cPA3"
    public static let hyphenation = ICCSymbol(name: "hyphenation", code: 0x48783031, type: typeType) // "Hx01"
    public static let hyphenationPreference = ICCSymbol(name: "hyphenationPreference", code: 0x63504134, type: typeType) // "cPA4"
    public static let hyphenationZone = ICCSymbol(name: "hyphenationZone", code: 0x63504132, type: typeType) // "cPA2"
    public static let id = ICCSymbol(name: "id", code: 0x49442020, type: typeType) // "ID  "
    public static let ignoreWhite = ICCSymbol(name: "ignoreWhite", code: 0x746f4957, type: typeType) // "toIW"
    public static let IllustratorPreferences = ICCSymbol(name: "IllustratorPreferences", code: 0x63507266, type: typeType) // "cPrf"
    public static let IllustratorSaveOptions = ICCSymbol(name: "IllustratorSaveOptions", code: 0x7449536f, type: typeType) // "tISo"
    public static let imageableArea = ICCSymbol(name: "imageableArea", code: 0x70503231, type: typeType) // "pP21"
    public static let imageCaptureOptions = ICCSymbol(name: "imageCaptureOptions", code: 0x7449434f, type: typeType) // "tICO"
    public static let imageCompression = ICCSymbol(name: "imageCompression", code: 0x70503933, type: typeType) // "pP93"
    public static let imageFormat = ICCSymbol(name: "imageFormat", code: 0x70464946, type: typeType) // "pFIF"
    public static let imageMap = ICCSymbol(name: "imageMap", code: 0x7045494d, type: typeType) // "pEIM"
    public static let includeDocumentThumbnails = ICCSymbol(name: "includeDocumentThumbnails", code: 0x70494374, type: typeType) // "pICt"
    public static let includeLayers = ICCSymbol(name: "includeLayers", code: 0x70494c59, type: typeType) // "pILY"
    public static let includeMetadata = ICCSymbol(name: "includeMetadata", code: 0x7046586d, type: typeType) // "pFXm"
    public static let includeUnusedSymbols = ICCSymbol(name: "includeUnusedSymbols", code: 0x70464975, type: typeType) // "pFIu"
    public static let index = ICCSymbol(name: "index", code: 0x70696478, type: typeType) // "pidx"
    public static let informationLoss = ICCSymbol(name: "informationLoss", code: 0x70494c50, type: typeType) // "pILP"
    public static let ink = ICCSymbol(name: "ink", code: 0x7450494b, type: typeType) // "tPIK"
    public static let inkProperties = ICCSymbol(name: "inkProperties", code: 0x74504949, type: typeType) // "tPII"
    public static let inks = ICCSymbol(name: "inks", code: 0x7050494c, type: typeType) // "pPIL"
    public static let innerRadius = ICCSymbol(name: "innerRadius", code: 0x70524432, type: typeType) // "pRD2"
    public static let InRIPSeparationSupport = ICCSymbol(name: "InRIPSeparationSupport", code: 0x70503038, type: typeType) // "pP08"
    public static let inscribed = ICCSymbol(name: "inscribed", code: 0x7053496e, type: typeType) // "pSIn"
    public static let insertionPoint = ICCSymbol(name: "insertionPoint", code: 0x63696e73, type: typeType) // "cins"
    public static let integer = ICCSymbol(name: "integer", code: 0x6c6f6e67, type: typeType) // "long"
    public static let intent = ICCSymbol(name: "intent", code: 0x70506132, type: typeType) // "pPa2"
    public static let interlaced = ICCSymbol(name: "interlaced", code: 0x70496e4c, type: typeType) // "pInL"
    public static let internationalText = ICCSymbol(name: "internationalText", code: 0x69747874, type: typeType) // "itxt"
    public static let internationalWritingCode = ICCSymbol(name: "internationalWritingCode", code: 0x696e746c, type: typeType) // "intl"
    public static let isolated = ICCSymbol(name: "isolated", code: 0x7049736f, type: typeType) // "pIso"
    public static let isTracing = ICCSymbol(name: "isTracing", code: 0x69735472, type: typeType) // "isTr"
    public static let italics = ICCSymbol(name: "italics", code: 0x70433072, type: typeType) // "pC0r"
    public static let item = ICCSymbol(name: "item", code: 0x636f626a, type: typeType) // "cobj"
    public static let January = ICCSymbol(name: "January", code: 0x6a616e20, type: typeType) // "jan "
    public static let japaneseFileFormat0x28obsolete0x29 = ICCSymbol(name: "japaneseFileFormat0x28obsolete0x29", code: 0x704a6666, type: typeType) // "pJff"
    public static let jobOptions = ICCSymbol(name: "jobOptions", code: 0x74504a4f, type: typeType) // "tPJO"
    public static let jobSettings = ICCSymbol(name: "jobSettings", code: 0x70503335, type: typeType) // "pP35"
    public static let JPEGExportOptions = ICCSymbol(name: "JPEGExportOptions", code: 0x74454f6a, type: typeType) // "tEOj"
    public static let JPEGMethod = ICCSymbol(name: "JPEGMethod", code: 0x70464a4d, type: typeType) // "pFJM"
    public static let JPEGPicture = ICCSymbol(name: "JPEGPicture", code: 0x4a504547, type: typeType) // "JPEG"
    public static let JPEGQuality = ICCSymbol(name: "JPEGQuality", code: 0x70464a51, type: typeType) // "pFJQ"
    public static let July = ICCSymbol(name: "July", code: 0x6a756c20, type: typeType) // "jul "
    public static let June = ICCSymbol(name: "June", code: 0x6a756e20, type: typeType) // "jun "
    public static let justification = ICCSymbol(name: "justification", code: 0x70543136, type: typeType) // "pT16"
    public static let kernelProcessId = ICCSymbol(name: "kernelProcessId", code: 0x6b706964, type: typeType) // "kpid"
    public static let kerning = ICCSymbol(name: "kerning", code: 0x70543234, type: typeType) // "pT24"
    public static let kerningMethod = ICCSymbol(name: "kerningMethod", code: 0x70543236, type: typeType) // "pT26"
    public static let kind = ICCSymbol(name: "kind", code: 0x63784454, type: typeType) // "cxDT"
    public static let Kinsoku = ICCSymbol(name: "Kinsoku", code: 0x634b534f, type: typeType) // "cKSO"
    public static let KinsokuOrder = ICCSymbol(name: "KinsokuOrder", code: 0x65504a61, type: typeType) // "ePJa"
    public static let KinsokuSet = ICCSymbol(name: "KinsokuSet", code: 0x704b534f, type: typeType) // "pKSO"
    public static let knockout = ICCSymbol(name: "knockout", code: 0x704b6e6b, type: typeType) // "pKnk"
    public static let KurikaeshiMojiShori = ICCSymbol(name: "KurikaeshiMojiShori", code: 0x65504a62, type: typeType) // "ePJb"
    public static let l = ICCSymbol(name: "l", code: 0x4c61624c, type: typeType) // "LabL"
    public static let LabColorInfo = ICCSymbol(name: "LabColorInfo", code: 0x744c6162, type: typeType) // "tLab"
    public static let language = ICCSymbol(name: "language", code: 0x70433074, type: typeType) // "pC0t"
    public static let languageLevel = ICCSymbol(name: "languageLevel", code: 0x70503131, type: typeType) // "pP11"
    public static let layer = ICCSymbol(name: "layer", code: 0x63614c59, type: typeType) // "caLY"
    public static let layerComp = ICCSymbol(name: "layerComp", code: 0x704c4370, type: typeType) // "pLCp"
    public static let layerOrder = ICCSymbol(name: "layerOrder", code: 0x70464c4f, type: typeType) // "pFLO"
    public static let leader = ICCSymbol(name: "leader", code: 0x54733033, type: typeType) // "Ts03"
    public static let leading = ICCSymbol(name: "leading", code: 0x70543035, type: typeType) // "pT05"
    public static let leadingType = ICCSymbol(name: "leadingType", code: 0x63504138, type: typeType) // "cPA8"
    public static let leftDirection = ICCSymbol(name: "leftDirection", code: 0x6361494e, type: typeType) // "caIN"
    public static let leftIndent = ICCSymbol(name: "leftIndent", code: 0x70543134, type: typeType) // "pT14"
    public static let legacyTextItem = ICCSymbol(name: "legacyTextItem", code: 0x634c5449, type: typeType) // "cLTI"
    public static let length = ICCSymbol(name: "length", code: 0x6c656e67, type: typeType) // "leng"
    public static let ligature = ICCSymbol(name: "ligature", code: 0x70433061, type: typeType) // "pC0a"
    public static let line = ICCSymbol(name: "line", code: 0x636c696e, type: typeType) // "clin"
    public static let list = ICCSymbol(name: "list", code: 0x6c697374, type: typeType) // "list"
    public static let locale = ICCSymbol(name: "locale", code: 0x7041414c, type: typeType) // "pAAL"
    public static let locationReference = ICCSymbol(name: "locationReference", code: 0x696e736c, type: typeType) // "insl"
    public static let locked = ICCSymbol(name: "locked", code: 0x61694c4b, type: typeType) // "aiLK"
    public static let longFixed = ICCSymbol(name: "longFixed", code: 0x6c667864, type: typeType) // "lfxd"
    public static let longFixedPoint = ICCSymbol(name: "longFixedPoint", code: 0x6c667074, type: typeType) // "lfpt"
    public static let longFixedRectangle = ICCSymbol(name: "longFixedRectangle", code: 0x6c667263, type: typeType) // "lfrc"
    public static let longPoint = ICCSymbol(name: "longPoint", code: 0x6c706e74, type: typeType) // "lpnt"
    public static let longRectangle = ICCSymbol(name: "longRectangle", code: 0x6c726374, type: typeType) // "lrct"
    public static let looping = ICCSymbol(name: "looping", code: 0x70464c6f, type: typeType) // "pFLo"
    public static let LZWCompression = ICCSymbol(name: "LZWCompression", code: 0x744c5a43, type: typeType) // "tLZC"
    public static let machine = ICCSymbol(name: "machine", code: 0x6d616368, type: typeType) // "mach"
    public static let machineLocation = ICCSymbol(name: "machineLocation", code: 0x6d4c6f63, type: typeType) // "mLoc"
    public static let machPort = ICCSymbol(name: "machPort", code: 0x706f7274, type: typeType) // "port"
    public static let magenta = ICCSymbol(name: "magenta", code: 0x4d41474e, type: typeType) // "MAGN"
    public static let March = ICCSymbol(name: "March", code: 0x6d617220, type: typeType) // "mar "
    public static let marksOffset = ICCSymbol(name: "marksOffset", code: 0x70503738, type: typeType) // "pP78"
    public static let matrix = ICCSymbol(name: "matrix", code: 0x7446584d, type: typeType) // "tFXM"
    public static let matte = ICCSymbol(name: "matte", code: 0x704d4142, type: typeType) // "pMAB"
    public static let matteColor = ICCSymbol(name: "matteColor", code: 0x704d436c, type: typeType) // "pMCl"
    public static let maximumColors = ICCSymbol(name: "maximumColors", code: 0x746f4366, type: typeType) // "toCf"
    public static let maximumConsecutiveHyphens = ICCSymbol(name: "maximumConsecutiveHyphens", code: 0x48783035, type: typeType) // "Hx05"
    public static let maximumEditability = ICCSymbol(name: "maximumEditability", code: 0x704d4561, type: typeType) // "pMEa"
    public static let maximumGlyphScaling = ICCSymbol(name: "maximumGlyphScaling", code: 0x63504135, type: typeType) // "cPA5"
    public static let maximumHeightOffset = ICCSymbol(name: "maximumHeightOffset", code: 0x7050306a, type: typeType) // "pP0j"
    public static let maximumLetterSpacing = ICCSymbol(name: "maximumLetterSpacing", code: 0x70543165, type: typeType) // "pT1e"
    public static let maximumPaperHeight = ICCSymbol(name: "maximumPaperHeight", code: 0x70503065, type: typeType) // "pP0e"
    public static let maximumPaperWidth = ICCSymbol(name: "maximumPaperWidth", code: 0x70503063, type: typeType) // "pP0c"
    public static let maximumResolution = ICCSymbol(name: "maximumResolution", code: 0x70503035, type: typeType) // "pP05"
    public static let maximumStrokeWeight = ICCSymbol(name: "maximumStrokeWeight", code: 0x746f4d78, type: typeType) // "toMx"
    public static let maximumWidthOffset = ICCSymbol(name: "maximumWidthOffset", code: 0x70503068, type: typeType) // "pP0h"
    public static let maximumWordSpacing = ICCSymbol(name: "maximumWordSpacing", code: 0x70543162, type: typeType) // "pT1b"
    public static let May = ICCSymbol(name: "May", code: 0x6d617920, type: typeType) // "may "
    public static let mergeLayers = ICCSymbol(name: "mergeLayers", code: 0x704d4c73, type: typeType) // "pMLs"
    public static let meshItem = ICCSymbol(name: "meshItem", code: 0x634d5348, type: typeType) // "cMSH"
    public static let midpoint = ICCSymbol(name: "midpoint", code: 0x78614d50, type: typeType) // "xaMP"
    public static let minifySvg = ICCSymbol(name: "minifySvg", code: 0x7041534d, type: typeType) // "pASM"
    public static let minimumAfterHyphen = ICCSymbol(name: "minimumAfterHyphen", code: 0x48783034, type: typeType) // "Hx04"
    public static let minimumBeforeHyphen = ICCSymbol(name: "minimumBeforeHyphen", code: 0x48783033, type: typeType) // "Hx03"
    public static let minimumGlyphScaling = ICCSymbol(name: "minimumGlyphScaling", code: 0x63504136, type: typeType) // "cPA6"
    public static let minimumHeightOffset = ICCSymbol(name: "minimumHeightOffset", code: 0x70503069, type: typeType) // "pP0i"
    public static let minimumHyphenatedWordSize = ICCSymbol(name: "minimumHyphenatedWordSize", code: 0x63504131, type: typeType) // "cPA1"
    public static let minimumLetterSpacing = ICCSymbol(name: "minimumLetterSpacing", code: 0x70543164, type: typeType) // "pT1d"
    public static let minimumPaperHeight = ICCSymbol(name: "minimumPaperHeight", code: 0x70503064, type: typeType) // "pP0d"
    public static let minimumPaperWidth = ICCSymbol(name: "minimumPaperWidth", code: 0x70503062, type: typeType) // "pP0b"
    public static let minimumWidthOffset = ICCSymbol(name: "minimumWidthOffset", code: 0x70503066, type: typeType) // "pP0f"
    public static let minimumWordSpacing = ICCSymbol(name: "minimumWordSpacing", code: 0x70543161, type: typeType) // "pT1a"
    public static let missingValue = ICCSymbol(name: "missingValue", code: 0x6d736e67, type: typeType) // "msng"
    public static let modified = ICCSymbol(name: "modified", code: 0x696d6f64, type: typeType) // "imod"
    public static let Mojikumi = ICCSymbol(name: "Mojikumi", code: 0x634d4a49, type: typeType) // "cMJI"
    public static let MojikumiSet = ICCSymbol(name: "MojikumiSet", code: 0x704d4a49, type: typeType) // "pMJI"
    public static let Monday = ICCSymbol(name: "Monday", code: 0x6d6f6e20, type: typeType) // "mon "
    public static let monochromeCompression = ICCSymbol(name: "monochromeCompression", code: 0x703e4d51, type: typeType) // "p>MQ"
    public static let monochromeDownsampling = ICCSymbol(name: "monochromeDownsampling", code: 0x703e4d44, type: typeType) // "p>MD"
    public static let monochromeDownsamplingThreshold = ICCSymbol(name: "monochromeDownsamplingThreshold", code: 0x703e4d41, type: typeType) // "p>MA"
    public static let monochromeResample = ICCSymbol(name: "monochromeResample", code: 0x703e4d53, type: typeType) // "p>MS"
    public static let mvalue_a = ICCSymbol(name: "mvalue_a", code: 0x7461566c, type: typeType) // "taVl"
    public static let mvalue_b = ICCSymbol(name: "mvalue_b", code: 0x7462566c, type: typeType) // "tbVl"
    public static let mvalue_c = ICCSymbol(name: "mvalue_c", code: 0x7463566c, type: typeType) // "tcVl"
    public static let mvalue_d = ICCSymbol(name: "mvalue_d", code: 0x7464566c, type: typeType) // "tdVl"
    public static let mvalue_tx = ICCSymbol(name: "mvalue_tx", code: 0x74747856, type: typeType) // "ttxV"
    public static let mvalue_ty = ICCSymbol(name: "mvalue_ty", code: 0x74747956, type: typeType) // "ttyV"
    public static let name = ICCSymbol(name: "name", code: 0x706e616d, type: typeType) // "pnam"
    public static let negativePrinting = ICCSymbol(name: "negativePrinting", code: 0x70503932, type: typeType) // "pP92"
    public static let nestedLayers = ICCSymbol(name: "nestedLayers", code: 0x704e4c79, type: typeType) // "pNLy"
    public static let nextFrame = ICCSymbol(name: "nextFrame", code: 0x704e4672, type: typeType) // "pNFr"
    public static let noBreak = ICCSymbol(name: "noBreak", code: 0x70433136, type: typeType) // "pC16"
    public static let noColorInfo = ICCSymbol(name: "noColorInfo", code: 0x744e436c, type: typeType) // "tNCl"
    public static let NoiseFidelity = ICCSymbol(name: "NoiseFidelity", code: 0x746f4e66, type: typeType) // "toNf"
    public static let nonNativeItem = ICCSymbol(name: "nonNativeItem", code: 0x63464f69, type: typeType) // "cFOi"
    public static let note = ICCSymbol(name: "note", code: 0x61694e54, type: typeType) // "aiNT"
    public static let November = ICCSymbol(name: "November", code: 0x6e6f7620, type: typeType) // "nov "
    public static let null = ICCSymbol(name: "null", code: 0x6e756c6c, type: typeType) // "null"
    public static let numArtboards = ICCSymbol(name: "numArtboards", code: 0x704e4172, type: typeType) // "pNAr"
    public static let obsolete_properties = ICCSymbol(name: "obsolete_properties", code: 0x4f625072, type: typeType) // "ObPr"
    public static let October = ICCSymbol(name: "October", code: 0x6f637420, type: typeType) // "oct "
    public static let offset = ICCSymbol(name: "offset", code: 0x703e4f41, type: typeType) // "p>OA"
    public static let opacity = ICCSymbol(name: "opacity", code: 0x704c4f70, type: typeType) // "pLOp"
    public static let openOptions = ICCSymbol(name: "openOptions", code: 0x744f504f, type: typeType) // "tOPO"
    public static let OpenTypePosition = ICCSymbol(name: "OpenTypePosition", code: 0x70433036, type: typeType) // "pC06"
    public static let opticalAlignment = ICCSymbol(name: "opticalAlignment", code: 0x704f5041, type: typeType) // "pOPA"
    public static let optimization = ICCSymbol(name: "optimization", code: 0x704f706d, type: typeType) // "pOpm"
    public static let ordinals = ICCSymbol(name: "ordinals", code: 0x70433067, type: typeType) // "pC0g"
    public static let orientation = ICCSymbol(name: "orientation", code: 0x70503631, type: typeType) // "pP61"
    public static let origin = ICCSymbol(name: "origin", code: 0x47644f67, type: typeType) // "GdOg"
    public static let originalArt = ICCSymbol(name: "originalArt", code: 0x74725363, type: typeType) // "trSc"
    public static let ornaments = ICCSymbol(name: "ornaments", code: 0x7043306c, type: typeType) // "pC0l"
    public static let outputCondition = ICCSymbol(name: "outputCondition", code: 0x703e434f, type: typeType) // "p>CO"
    public static let outputConditionId = ICCSymbol(name: "outputConditionId", code: 0x703e4355, type: typeType) // "p>CU"
    public static let outputIntentProfile = ICCSymbol(name: "outputIntentProfile", code: 0x703e4349, type: typeType) // "p>CI"
    public static let outputResolution = ICCSymbol(name: "outputResolution", code: 0x78784f52, type: typeType) // "xxOR"
    public static let overprint = ICCSymbol(name: "overprint", code: 0x703e4f50, type: typeType) // "p>OP"
    public static let overPrintBlack = ICCSymbol(name: "overPrintBlack", code: 0x70503533, type: typeType) // "pP53"
    public static let overprintFill = ICCSymbol(name: "overprintFill", code: 0x70433138, type: typeType) // "pC18"
    public static let overprintStroke = ICCSymbol(name: "overprintStroke", code: 0x70433137, type: typeType) // "pC17"
    public static let padding = ICCSymbol(name: "padding", code: 0x70504144, type: typeType) // "pPAD"
    public static let page = ICCSymbol(name: "page", code: 0x7050544f, type: typeType) // "pPTO"
    public static let pageInfo = ICCSymbol(name: "pageInfo", code: 0x703e5049, type: typeType) // "p>PI"
    public static let pageInfoMarks = ICCSymbol(name: "pageInfoMarks", code: 0x70503736, type: typeType) // "pP76"
    public static let pageItem = ICCSymbol(name: "pageItem", code: 0x63614154, type: typeType) // "caAT"
    public static let pageMarksOptions = ICCSymbol(name: "pageMarksOptions", code: 0x7450504d, type: typeType) // "tPPM"
    public static let pageMarksSettings = ICCSymbol(name: "pageMarksSettings", code: 0x70503338, type: typeType) // "pP38"
    public static let pageMarksStyle = ICCSymbol(name: "pageMarksStyle", code: 0x70503731, type: typeType) // "pP71"
    public static let pageOrigin = ICCSymbol(name: "pageOrigin", code: 0x7878504f, type: typeType) // "xxPO"
    public static let palette = ICCSymbol(name: "palette", code: 0x746f506c, type: typeType) // "toPl"
    public static let paper = ICCSymbol(name: "paper", code: 0x74504150, type: typeType) // "tPAP"
    public static let paperOptions = ICCSymbol(name: "paperOptions", code: 0x7450504f, type: typeType) // "tPPO"
    public static let paperProperties = ICCSymbol(name: "paperProperties", code: 0x74504149, type: typeType) // "tPAI"
    public static let paperSettings = ICCSymbol(name: "paperSettings", code: 0x70503333, type: typeType) // "pP33"
    public static let paperSizes = ICCSymbol(name: "paperSizes", code: 0x70503061, type: typeType) // "pP0a"
    public static let paragraph = ICCSymbol(name: "paragraph", code: 0x63706172, type: typeType) // "cpar"
    public static let paragraphStyle = ICCSymbol(name: "paragraphStyle", code: 0x63505354, type: typeType) // "cPST"
    public static let pasteRemembersLayers = ICCSymbol(name: "pasteRemembersLayers", code: 0x7052654c, type: typeType) // "pReL"
    public static let pathCount = ICCSymbol(name: "pathCount", code: 0x74725043, type: typeType) // "trPC"
    public static let PathFidelity = ICCSymbol(name: "PathFidelity", code: 0x746f5046, type: typeType) // "toPF"
    public static let pathItem = ICCSymbol(name: "pathItem", code: 0x63615041, type: typeType) // "caPA"
    public static let pathPoint = ICCSymbol(name: "pathPoint", code: 0x63615053, type: typeType) // "caPS"
    public static let pathPointInfo = ICCSymbol(name: "pathPointInfo", code: 0x74534547, type: typeType) // "tSEG"
    public static let pattern = ICCSymbol(name: "pattern", code: 0x63615054, type: typeType) // "caPT"
    public static let patternColorInfo = ICCSymbol(name: "patternColorInfo", code: 0x74505469, type: typeType) // "tPTi"
    public static let PDFCompatible = ICCSymbol(name: "PDFCompatible", code: 0x70504366, type: typeType) // "pPCf"
    public static let PDFCropBounds = ICCSymbol(name: "PDFCropBounds", code: 0x70505431, type: typeType) // "pPT1"
    public static let PDFFileOptions = ICCSymbol(name: "PDFFileOptions", code: 0x70504631, type: typeType) // "pPF1"
    public static let PDFOptions = ICCSymbol(name: "PDFOptions", code: 0x744f5044, type: typeType) // "tOPD"
    public static let PDFPreset = ICCSymbol(name: "PDFPreset", code: 0x703e4f53, type: typeType) // "p>OS"
    public static let PDFPresets = ICCSymbol(name: "PDFPresets", code: 0x7044534c, type: typeType) // "pDSL"
    public static let PDFSaveOptions = ICCSymbol(name: "PDFSaveOptions", code: 0x7470536f, type: typeType) // "tpSo"
    public static let pdfXstandard = ICCSymbol(name: "pdfXstandard", code: 0x703e5058, type: typeType) // "p>PX"
    public static let pdfXstandardDescripton = ICCSymbol(name: "pdfXstandardDescripton", code: 0x703e5044, type: typeType) // "p>PD"
    public static let permissionPassword = ICCSymbol(name: "permissionPassword", code: 0x703e5050, type: typeType) // "p>PP"
    public static let PhotoshopExportOptions = ICCSymbol(name: "PhotoshopExportOptions", code: 0x74455053, type: typeType) // "tEPS"
    public static let PhotoshopFileOptions = ICCSymbol(name: "PhotoshopFileOptions", code: 0x7050464f, type: typeType) // "pPFO"
    public static let PhotoshopOptions = ICCSymbol(name: "PhotoshopOptions", code: 0x744f4f50, type: typeType) // "tOOP"
    public static let PICTPicture = ICCSymbol(name: "PICTPicture", code: 0x50494354, type: typeType) // "PICT"
    public static let pixelAligned = ICCSymbol(name: "pixelAligned", code: 0x7050416c, type: typeType) // "pPAl"
    public static let pixelAspectRatioCorrection = ICCSymbol(name: "pixelAspectRatioCorrection", code: 0x70415243, type: typeType) // "pARC"
    public static let pixelMapRecord = ICCSymbol(name: "pixelMapRecord", code: 0x74706d6d, type: typeType) // "tpmm"
    public static let placedItem = ICCSymbol(name: "placedItem", code: 0x6361504c, type: typeType) // "caPL"
    public static let pluginItem = ICCSymbol(name: "pluginItem", code: 0x63504c47, type: typeType) // "cPLG"
    public static let PNG24ExportOptions = ICCSymbol(name: "PNG24ExportOptions", code: 0x74503234, type: typeType) // "tP24"
    public static let PNG8ExportOptions = ICCSymbol(name: "PNG8ExportOptions", code: 0x74504e38, type: typeType) // "tPN8"
    public static let point = ICCSymbol(name: "point", code: 0x51447074, type: typeType) // "QDpt"
    public static let pointCount = ICCSymbol(name: "pointCount", code: 0x70505463, type: typeType) // "pPTc"
    public static let pointType = ICCSymbol(name: "pointType", code: 0x63614352, type: typeType) // "caCR"
    public static let polarity = ICCSymbol(name: "polarity", code: 0x61695050, type: typeType) // "aiPP"
    public static let polygon = ICCSymbol(name: "polygon", code: 0x73685047, type: typeType) // "shPG"
    public static let position = ICCSymbol(name: "position", code: 0x70615073, type: typeType) // "paPs"
    public static let PostScript = ICCSymbol(name: "PostScript", code: 0x7050536c, type: typeType) // "pPSl"
    public static let postscriptOptions = ICCSymbol(name: "postscriptOptions", code: 0x74505053, type: typeType) // "tPPS"
    public static let postscriptSettings = ICCSymbol(name: "postscriptSettings", code: 0x70503361, type: typeType) // "pP3a"
    public static let PPDFile = ICCSymbol(name: "PPDFile", code: 0x74505044, type: typeType) // "tPPD"
    public static let PPDName = ICCSymbol(name: "PPDName", code: 0x70503332, type: typeType) // "pP32"
    public static let PPDProperties = ICCSymbol(name: "PPDProperties", code: 0x74504449, type: typeType) // "tPDI"
    public static let PPDs = ICCSymbol(name: "PPDs", code: 0x7050444c, type: typeType) // "pPDL"
    public static let preserveEditability = ICCSymbol(name: "preserveEditability", code: 0x703e5045, type: typeType) // "p>PE"
    public static let preserveEditingCapabilities = ICCSymbol(name: "preserveEditingCapabilities", code: 0x70465065, type: typeType) // "pFPe"
    public static let preserveHiddenLayers = ICCSymbol(name: "preserveHiddenLayers", code: 0x7050484c, type: typeType) // "pPHL"
    public static let preserveImageMaps = ICCSymbol(name: "preserveImageMaps", code: 0x7050494d, type: typeType) // "pPIM"
    public static let preserveLayers = ICCSymbol(name: "preserveLayers", code: 0x70504c79, type: typeType) // "pPLy"
    public static let preserveLegacyArtboard = ICCSymbol(name: "preserveLegacyArtboard", code: 0x70504c41, type: typeType) // "pPLA"
    public static let preserveSlices = ICCSymbol(name: "preserveSlices", code: 0x70505363, type: typeType) // "pPSc"
    public static let preset = ICCSymbol(name: "preset", code: 0x746f5072, type: typeType) // "toPr"
    public static let presetSettings = ICCSymbol(name: "presetSettings", code: 0x70444f43, type: typeType) // "pDOC"
    public static let presetSettingsDialogOption = ICCSymbol(name: "presetSettingsDialogOption", code: 0x70444f44, type: typeType) // "pDOD"
    public static let preview = ICCSymbol(name: "preview", code: 0x61695056, type: typeType) // "aiPV"
    public static let previewMode = ICCSymbol(name: "previewMode", code: 0x70445052, type: typeType) // "pDPR"
    public static let previousFrame = ICCSymbol(name: "previousFrame", code: 0x63504672, type: typeType) // "cPFr"
    public static let printable = ICCSymbol(name: "printable", code: 0x61695054, type: typeType) // "aiPT"
    public static let printAllArtboards = ICCSymbol(name: "printAllArtboards", code: 0x70503462, type: typeType) // "pP4b"
    public static let printArea = ICCSymbol(name: "printArea", code: 0x70503432, type: typeType) // "pP42"
    public static let printAsBitmap = ICCSymbol(name: "printAsBitmap", code: 0x70503439, type: typeType) // "pP49"
    public static let printer = ICCSymbol(name: "printer", code: 0x74505254, type: typeType) // "tPRT"
    public static let printerName = ICCSymbol(name: "printerName", code: 0x70503331, type: typeType) // "pP31"
    public static let printerProperties = ICCSymbol(name: "printerProperties", code: 0x74504946, type: typeType) // "tPIF"
    public static let printerResolution = ICCSymbol(name: "printerResolution", code: 0x703e4650, type: typeType) // "p>FP"
    public static let printers = ICCSymbol(name: "printers", code: 0x7050524c, type: typeType) // "pPRL"
    public static let printerType = ICCSymbol(name: "printerType", code: 0x70503031, type: typeType) // "pP01"
    public static let printingStatus = ICCSymbol(name: "printingStatus", code: 0x70503739, type: typeType) // "pP79"
    public static let printOptions = ICCSymbol(name: "printOptions", code: 0x74504f50, type: typeType) // "tPOP"
    public static let printPreset = ICCSymbol(name: "printPreset", code: 0x74505354, type: typeType) // "tPST"
    public static let printPresets = ICCSymbol(name: "printPresets", code: 0x7050534c, type: typeType) // "pPSL"
    public static let printTiles = ICCSymbol(name: "printTiles", code: 0x78785054, type: typeType) // "xxPT"
    public static let processSerialNumber = ICCSymbol(name: "processSerialNumber", code: 0x70736e20, type: typeType) // "psn "
    public static let profileKind = ICCSymbol(name: "profileKind", code: 0x70506131, type: typeType) // "pPa1"
    public static let properties = ICCSymbol(name: "properties", code: 0x70414c4c, type: typeType) // "pALL"
    public static let property_ = ICCSymbol(name: "property_", code: 0x70726f70, type: typeType) // "prop"
    public static let proportionalMetrics = ICCSymbol(name: "proportionalMetrics", code: 0x7043306f, type: typeType) // "pC0o"
    public static let quality = ICCSymbol(name: "quality", code: 0x70496d51, type: typeType) // "pImQ"
    public static let radius = ICCSymbol(name: "radius", code: 0x70524478, type: typeType) // "pRDx"
    public static let rampPoint = ICCSymbol(name: "rampPoint", code: 0x78615250, type: typeType) // "xaRP"
    public static let rasterEffectOptions = ICCSymbol(name: "rasterEffectOptions", code: 0x7452454f, type: typeType) // "tREO"
    public static let rasterEffectSettings = ICCSymbol(name: "rasterEffectSettings", code: 0x70524553, type: typeType) // "pRES"
    public static let rasterFormat = ICCSymbol(name: "rasterFormat", code: 0x70415246, type: typeType) // "pARF"
    public static let rasterImageLocation = ICCSymbol(name: "rasterImageLocation", code: 0x70524957, type: typeType) // "pRIW"
    public static let rasterItem = ICCSymbol(name: "rasterItem", code: 0x63615241, type: typeType) // "caRA"
    public static let rasterizationResolution = ICCSymbol(name: "rasterizationResolution", code: 0x70506e32, type: typeType) // "pPn2"
    public static let rasterizeOptions = ICCSymbol(name: "rasterizeOptions", code: 0x7452534f, type: typeType) // "tRSO"
    public static let rasterResolution = ICCSymbol(name: "rasterResolution", code: 0x70445252, type: typeType) // "pDRR"
    public static let readOnly = ICCSymbol(name: "readOnly", code: 0x7046524f, type: typeType) // "pFRO"
    public static let record = ICCSymbol(name: "record", code: 0x7265636f, type: typeType) // "reco"
    public static let rectangle = ICCSymbol(name: "rectangle", code: 0x73685243, type: typeType) // "shRC"
    public static let red = ICCSymbol(name: "red", code: 0x52454420, type: typeType) // "RED "
    public static let reference = ICCSymbol(name: "reference", code: 0x6f626a20, type: typeType) // "obj "
    public static let reflect = ICCSymbol(name: "reflect", code: 0x53785266, type: typeType) // "SxRf"
    public static let reflectAngle = ICCSymbol(name: "reflectAngle", code: 0x53785261, type: typeType) // "SxRa"
    public static let registrationMarks = ICCSymbol(name: "registrationMarks", code: 0x70503734, type: typeType) // "pP74"
    public static let registryName = ICCSymbol(name: "registryName", code: 0x703e435a, type: typeType) // "p>CZ"
    public static let replacing = ICCSymbol(name: "replacing", code: 0x7052706c, type: typeType) // "pRpl"
    public static let requireDocPassword = ICCSymbol(name: "requireDocPassword", code: 0x703e4452, type: typeType) // "p>DR"
    public static let requirePermPassword = ICCSymbol(name: "requirePermPassword", code: 0x703e5052, type: typeType) // "p>PR"
    public static let resolution = ICCSymbol(name: "resolution", code: 0x6169525a, type: typeType) // "aiRZ"
    public static let responsiveSvg = ICCSymbol(name: "responsiveSvg", code: 0x70495253, type: typeType) // "pIRS"
    public static let reversed = ICCSymbol(name: "reversed", code: 0x70535276, type: typeType) // "pSRv"
    public static let reversePages = ICCSymbol(name: "reversePages", code: 0x70503436, type: typeType) // "pP46"
    public static let RGB16Color = ICCSymbol(name: "RGB16Color", code: 0x74723136, type: typeType) // "tr16"
    public static let RGB96Color = ICCSymbol(name: "RGB96Color", code: 0x74723936, type: typeType) // "tr96"
    public static let RGBColor = ICCSymbol(name: "RGBColor", code: 0x63524742, type: typeType) // "cRGB"
    public static let RGBColorInfo = ICCSymbol(name: "RGBColorInfo", code: 0x74524769, type: typeType) // "tRGi"
    public static let rightDirection = ICCSymbol(name: "rightDirection", code: 0x63614f54, type: typeType) // "caOT"
    public static let rightIndent = ICCSymbol(name: "rightIndent", code: 0x70543135, type: typeType) // "pT15"
    public static let romanHanging = ICCSymbol(name: "romanHanging", code: 0x65504a36, type: typeType) // "ePJ6"
    public static let rotation = ICCSymbol(name: "rotation", code: 0x74726f74, type: typeType) // "trot"
    public static let rotation_ = ICCSymbol(name: "rotation_", code: 0x53785278, type: typeType) // "SxRx"
    public static let roundedRectangle = ICCSymbol(name: "roundedRectangle", code: 0x73685252, type: typeType) // "shRR"
    public static let rowCount = ICCSymbol(name: "rowCount", code: 0x70525743, type: typeType) // "pRWC"
    public static let rowGutter = ICCSymbol(name: "rowGutter", code: 0x70525747, type: typeType) // "pRWG"
    public static let rulerOrigin = ICCSymbol(name: "rulerOrigin", code: 0x7878524f, type: typeType) // "xxRO"
    public static let rulerPAR = ICCSymbol(name: "rulerPAR", code: 0x62416c32, type: typeType) // "bAl2"
    public static let rulerUnits = ICCSymbol(name: "rulerUnits", code: 0x78785255, type: typeType) // "xxRU"
    public static let Saturday = ICCSymbol(name: "Saturday", code: 0x73617420, type: typeType) // "sat "
    public static let saveMultipleArtboards = ICCSymbol(name: "saveMultipleArtboards", code: 0x534d4162, type: typeType) // "SMAb"
    public static let savingAsHTML = ICCSymbol(name: "savingAsHTML", code: 0x70534854, type: typeType) // "pSHT"
    public static let scaleFactor = ICCSymbol(name: "scaleFactor", code: 0x53785363, type: typeType) // "SxSc"
    public static let scaleLineweights = ICCSymbol(name: "scaleLineweights", code: 0x70414c57, type: typeType) // "pALW"
    public static let scaleRatio = ICCSymbol(name: "scaleRatio", code: 0x70415352, type: typeType) // "pASR"
    public static let scaleUnit = ICCSymbol(name: "scaleUnit", code: 0x70415355, type: typeType) // "pASU"
    public static let scaling0x28obsoleteUse0x27horizontalScale0x27And0x27verticalScale0x270x29 = ICCSymbol(name: "scaling0x28obsoleteUse0x27horizontalScale0x27And0x27verticalScale0x270x29", code: 0x70543038, type: typeType) // "pT08"
    public static let screenMode = ICCSymbol(name: "screenMode", code: 0x6169564d, type: typeType) // "aiVM"
    public static let screenProperties = ICCSymbol(name: "screenProperties", code: 0x74505349, type: typeType) // "tPSI"
    public static let screens = ICCSymbol(name: "screens", code: 0x70503133, type: typeType) // "pP13"
    public static let screenSpotFunction = ICCSymbol(name: "screenSpotFunction", code: 0x74505350, type: typeType) // "tPSP"
    public static let script = ICCSymbol(name: "script", code: 0x73637074, type: typeType) // "scpt"
    public static let scriptingVersion = ICCSymbol(name: "scriptingVersion", code: 0x70415a76, type: typeType) // "pAZv"
    public static let selected = ICCSymbol(name: "selected", code: 0x73656c63, type: typeType) // "selc"
    public static let selectedLayoutName = ICCSymbol(name: "selectedLayoutName", code: 0x70534c4e, type: typeType) // "pSLN"
    public static let selectedPathPoints = ICCSymbol(name: "selectedPathPoints", code: 0x61695378, type: typeType) // "aiSx"
    public static let selection = ICCSymbol(name: "selection", code: 0x73656c65, type: typeType) // "sele"
    public static let separationMode = ICCSymbol(name: "separationMode", code: 0x70503531, type: typeType) // "pP51"
    public static let separationScreen = ICCSymbol(name: "separationScreen", code: 0x74505343, type: typeType) // "tPSC"
    public static let September = ICCSymbol(name: "September", code: 0x73657020, type: typeType) // "sep "
    public static let settings = ICCSymbol(name: "settings", code: 0x70507266, type: typeType) // "pPrf"
    public static let setTypeOfSVG = ICCSymbol(name: "setTypeOfSVG", code: 0x70494454, type: typeType) // "pIDT"
    public static let shadingResolution = ICCSymbol(name: "shadingResolution", code: 0x70503936, type: typeType) // "pP96"
    public static let shearAngle = ICCSymbol(name: "shearAngle", code: 0x53785361, type: typeType) // "SxSa"
    public static let shearAxis = ICCSymbol(name: "shearAxis", code: 0x53785378, type: typeType) // "SxSx"
    public static let shiftAngle = ICCSymbol(name: "shiftAngle", code: 0x53784461, type: typeType) // "SxDa"
    public static let shiftDistance = ICCSymbol(name: "shiftDistance", code: 0x53784478, type: typeType) // "SxDx"
    public static let shortFloat = ICCSymbol(name: "shortFloat", code: 0x73696e67, type: typeType) // "sing"
    public static let shortInteger = ICCSymbol(name: "shortInteger", code: 0x73686f72, type: typeType) // "shor"
    public static let showCenter = ICCSymbol(name: "showCenter", code: 0x62416c34, type: typeType) // "bAl4"
    public static let showCrossHairs = ICCSymbol(name: "showCrossHairs", code: 0x62416c35, type: typeType) // "bAl5"
    public static let showPlacedImages = ICCSymbol(name: "showPlacedImages", code: 0x78785350, type: typeType) // "xxSP"
    public static let showSafeAreas = ICCSymbol(name: "showSafeAreas", code: 0x62416c36, type: typeType) // "bAl6"
    public static let sides = ICCSymbol(name: "sides", code: 0x70534463, type: typeType) // "pSDc"
    public static let singleWordJustification = ICCSymbol(name: "singleWordJustification", code: 0x63504137, type: typeType) // "cPA7"
    public static let size = ICCSymbol(name: "size", code: 0x7074737a, type: typeType) // "ptsz"
    public static let sliced = ICCSymbol(name: "sliced", code: 0x7041536c, type: typeType) // "pASl"
    public static let slices = ICCSymbol(name: "slices", code: 0x7045536c, type: typeType) // "pESl"
    public static let snapCurveToLines = ICCSymbol(name: "snapCurveToLines", code: 0x746f5363, type: typeType) // "toSc"
    public static let sourceArt = ICCSymbol(name: "sourceArt", code: 0x6b664149, type: typeType) // "kfAI"
    public static let spaceAfter = ICCSymbol(name: "spaceAfter", code: 0x63504130, type: typeType) // "cPA0"
    public static let spaceBefore = ICCSymbol(name: "spaceBefore", code: 0x70543130, type: typeType) // "pT10"
    public static let spacing = ICCSymbol(name: "spacing", code: 0x70535041, type: typeType) // "pSPA"
    public static let splitLongPaths = ICCSymbol(name: "splitLongPaths", code: 0x7878534c, type: typeType) // "xxSL"
    public static let spot = ICCSymbol(name: "spot", code: 0x63614343, type: typeType) // "caCC"
    public static let spotColorInfo = ICCSymbol(name: "spotColorInfo", code: 0x74435369, type: typeType) // "tCSi"
    public static let spotFunction = ICCSymbol(name: "spotFunction", code: 0x70506233, type: typeType) // "pPb3"
    public static let spotFunctions = ICCSymbol(name: "spotFunctions", code: 0x70503134, type: typeType) // "pP14"
    public static let spotKind = ICCSymbol(name: "spotKind", code: 0x7053434b, type: typeType) // "pSCK"
    public static let star = ICCSymbol(name: "star", code: 0x73685354, type: typeType) // "shST"
    public static let startTValue = ICCSymbol(name: "startTValue", code: 0x70545354, type: typeType) // "pTST"
    public static let startupPreset = ICCSymbol(name: "startupPreset", code: 0x70535450, type: typeType) // "pSTP"
    public static let startupPresets = ICCSymbol(name: "startupPresets", code: 0x7053504c, type: typeType) // "pSPL"
    public static let stationery = ICCSymbol(name: "stationery", code: 0x70737064, type: typeType) // "pspd"
    public static let status = ICCSymbol(name: "status", code: 0x63614c4d, type: typeType) // "caLM"
    public static let stopOpacity = ICCSymbol(name: "stopOpacity", code: 0x7847534f, type: typeType) // "xGSO"
    public static let story = ICCSymbol(name: "story", code: 0x6353544f, type: typeType) // "cSTO"
    public static let strikeThrough = ICCSymbol(name: "strikeThrough", code: 0x70433038, type: typeType) // "pC08"
    public static let string = ICCSymbol(name: "string", code: 0x54455854, type: typeType) // "TEXT"
    public static let strokeCap = ICCSymbol(name: "strokeCap", code: 0x61694378, type: typeType) // "aiCx"
    public static let strokeColor = ICCSymbol(name: "strokeColor", code: 0x61695343, type: typeType) // "aiSC"
    public static let stroked = ICCSymbol(name: "stroked", code: 0x61695350, type: typeType) // "aiSP"
    public static let strokeDashes = ICCSymbol(name: "strokeDashes", code: 0x61694453, type: typeType) // "aiDS"
    public static let strokeDashOffset = ICCSymbol(name: "strokeDashOffset", code: 0x6169444f, type: typeType) // "aiDO"
    public static let strokeJoin = ICCSymbol(name: "strokeJoin", code: 0x61694a6e, type: typeType) // "aiJn"
    public static let strokeMiterLimit = ICCSymbol(name: "strokeMiterLimit", code: 0x61694d78, type: typeType) // "aiMx"
    public static let strokeOverprint = ICCSymbol(name: "strokeOverprint", code: 0x6169534f, type: typeType) // "aiSO"
    public static let strokes = ICCSymbol(name: "strokes", code: 0x746f5374, type: typeType) // "toSt"
    public static let strokeWeight = ICCSymbol(name: "strokeWeight", code: 0x70433139, type: typeType) // "pC19"
    public static let strokeWidth = ICCSymbol(name: "strokeWidth", code: 0x61695357, type: typeType) // "aiSW"
    public static let style = ICCSymbol(name: "style", code: 0x74787374, type: typeType) // "txst"
    public static let styledClipboardText = ICCSymbol(name: "styledClipboardText", code: 0x7374796c, type: typeType) // "styl"
    public static let styledText = ICCSymbol(name: "styledText", code: 0x53545854, type: typeType) // "STXT"
    public static let stylisticAlternates = ICCSymbol(name: "stylisticAlternates", code: 0x7043306b, type: typeType) // "pC0k"
    public static let Sunday = ICCSymbol(name: "Sunday", code: 0x73756e20, type: typeType) // "sun "
    public static let SVGExportOptions = ICCSymbol(name: "SVGExportOptions", code: 0x74454f53, type: typeType) // "tEOS"
    public static let swash = ICCSymbol(name: "swash", code: 0x70433068, type: typeType) // "pC0h"
    public static let swatch = ICCSymbol(name: "swatch", code: 0x63615357, type: typeType) // "caSW"
    public static let swatchgroup = ICCSymbol(name: "swatchgroup", code: 0x63534772, type: typeType) // "cSGr"
    public static let symbol = ICCSymbol(name: "symbol", code: 0x63615359, type: typeType) // "caSY"
    public static let symbolItem = ICCSymbol(name: "symbolItem", code: 0x63615349, type: typeType) // "caSI"
    public static let tabStopInfo = ICCSymbol(name: "tabStopInfo", code: 0x74545369, type: typeType) // "tTSi"
    public static let tabStops = ICCSymbol(name: "tabStops", code: 0x70543233, type: typeType) // "pT23"
    public static let tag = ICCSymbol(name: "tag", code: 0x63615447, type: typeType) // "caTG"
    public static let TCYHorizontal = ICCSymbol(name: "TCYHorizontal", code: 0x70433133, type: typeType) // "pC13"
    public static let TCYVertical = ICCSymbol(name: "TCYVertical", code: 0x70433132, type: typeType) // "pC12"
    public static let text = ICCSymbol(name: "text", code: 0x63747874, type: typeType) // "ctxt"
    public static let textFont = ICCSymbol(name: "textFont", code: 0x63545866, type: typeType) // "cTXf"
    public static let textFrame = ICCSymbol(name: "textFrame", code: 0x63545861, type: typeType) // "cTXa"
    public static let textkerning = ICCSymbol(name: "textkerning", code: 0x70464954, type: typeType) // "pFIT"
    public static let textOrientation = ICCSymbol(name: "textOrientation", code: 0x70744f52, type: typeType) // "ptOR"
    public static let textPath = ICCSymbol(name: "textPath", code: 0x63545870, type: typeType) // "cTXp"
    public static let textPolicy = ICCSymbol(name: "textPolicy", code: 0x70467450, type: typeType) // "pFtP"
    public static let textRange = ICCSymbol(name: "textRange", code: 0x70535430, type: typeType) // "pST0"
    public static let textStyleInfo = ICCSymbol(name: "textStyleInfo", code: 0x74737479, type: typeType) // "tsty"
    public static let threshold = ICCSymbol(name: "threshold", code: 0x746f5468, type: typeType) // "toTh"
    public static let Thursday = ICCSymbol(name: "Thursday", code: 0x74687520, type: typeType) // "thu "
    public static let TIFFExportOptions = ICCSymbol(name: "TIFFExportOptions", code: 0x74454154, type: typeType) // "tEAT"
    public static let TIFFPicture = ICCSymbol(name: "TIFFPicture", code: 0x54494646, type: typeType) // "TIFF"
    public static let tileFullPages = ICCSymbol(name: "tileFullPages", code: 0x78785446, type: typeType) // "xxTF"
    public static let tiling = ICCSymbol(name: "tiling", code: 0x70503637, type: typeType) // "pP67"
    public static let tint = ICCSymbol(name: "tint", code: 0x54494e54, type: typeType) // "TINT"
    public static let title = ICCSymbol(name: "title", code: 0x70544954, type: typeType) // "pTIT"
    public static let titling = ICCSymbol(name: "titling", code: 0x70433069, type: typeType) // "pC0i"
    public static let tracing = ICCSymbol(name: "tracing", code: 0x67745472, type: typeType) // "gtTr"
    public static let TracingColorTypeValue = ICCSymbol(name: "TracingColorTypeValue", code: 0x746f4354, type: typeType) // "toCT"
    public static let TracingMethod = ICCSymbol(name: "TracingMethod", code: 0x746f4d65, type: typeType) // "toMe"
    public static let tracingMode = ICCSymbol(name: "tracingMode", code: 0x746f4d64, type: typeType) // "toMd"
    public static let tracingobject = ICCSymbol(name: "tracingobject", code: 0x63615472, type: typeType) // "caTr"
    public static let tracingoptions = ICCSymbol(name: "tracingoptions", code: 0x6361544f, type: typeType) // "caTO"
    public static let tracingOptions = ICCSymbol(name: "tracingOptions", code: 0x74724f73, type: typeType) // "trOs"
    public static let tracingPresets = ICCSymbol(name: "tracingPresets", code: 0x7054534c, type: typeType) // "pTSL"
    public static let tracking = ICCSymbol(name: "tracking", code: 0x70543036, type: typeType) // "pT06"
    public static let transparency = ICCSymbol(name: "transparency", code: 0x70547063, type: typeType) // "pTpc"
    public static let transparencyGrid = ICCSymbol(name: "transparencyGrid", code: 0x70445447, type: typeType) // "pDTG"
    public static let transverse = ICCSymbol(name: "transverse", code: 0x70507031, type: typeType) // "pPp1"
    public static let trapped = ICCSymbol(name: "trapped", code: 0x703e4352, type: typeType) // "p>CR"
    public static let trapping = ICCSymbol(name: "trapping", code: 0x70506d32, type: typeType) // "pPm2"
    public static let trappingOrder = ICCSymbol(name: "trappingOrder", code: 0x70506d33, type: typeType) // "pPm3"
    public static let trimMarks = ICCSymbol(name: "trimMarks", code: 0x70503733, type: typeType) // "pP73"
    public static let trimMarksWeight = ICCSymbol(name: "trimMarksWeight", code: 0x70503732, type: typeType) // "pP72"
    public static let trimMarkWeight = ICCSymbol(name: "trimMarkWeight", code: 0x703e5457, type: typeType) // "p>TW"
    public static let Tsume = ICCSymbol(name: "Tsume", code: 0x70433076, type: typeType) // "pC0v"
    public static let Tuesday = ICCSymbol(name: "Tuesday", code: 0x74756520, type: typeType) // "tue "
    public static let typeClass = ICCSymbol(name: "typeClass", code: 0x74797065, type: typeType) // "type"
    public static let underline = ICCSymbol(name: "underline", code: 0x70433037, type: typeType) // "pC07"
    public static let unicodeText = ICCSymbol(name: "unicodeText", code: 0x75747874, type: typeType) // "utxt"
    public static let unsignedInteger = ICCSymbol(name: "unsignedInteger", code: 0x6d61676e, type: typeType) // "magn"
    public static let updateLegacyGradientMesh = ICCSymbol(name: "updateLegacyGradientMesh", code: 0x704c474d, type: typeType) // "pLGM"
    public static let updateLegacyText = ICCSymbol(name: "updateLegacyText", code: 0x70434c54, type: typeType) // "pCLT"
    public static let URL = ICCSymbol(name: "URL", code: 0x7055524c, type: typeType) // "pURL"
    public static let usedColorCount = ICCSymbol(name: "usedColorCount", code: 0x74724e43, type: typeType) // "trNC"
    public static let useDefaultScreen = ICCSymbol(name: "useDefaultScreen", code: 0x78784453, type: typeType) // "xxDS"
    public static let userInteractionLevel = ICCSymbol(name: "userInteractionLevel", code: 0x7055494c, type: typeType) // "pUIL"
    public static let utf16Text = ICCSymbol(name: "utf16Text", code: 0x75743136, type: typeType) // "ut16"
    public static let utf8Text = ICCSymbol(name: "utf8Text", code: 0x75746638, type: typeType) // "utf8"
    public static let value = ICCSymbol(name: "value", code: 0x61695456, type: typeType) // "aiTV"
    public static let variable = ICCSymbol(name: "variable", code: 0x74566172, type: typeType) // "tVar"
    public static let variablesLocked = ICCSymbol(name: "variablesLocked", code: 0x70444c56, type: typeType) // "pDLV"
    public static let version = ICCSymbol(name: "version", code: 0x76657273, type: typeType) // "vers"
    public static let verticalRadius = ICCSymbol(name: "verticalRadius", code: 0x70524476, type: typeType) // "pRDv"
    public static let verticalScale = ICCSymbol(name: "verticalScale", code: 0x70535959, type: typeType) // "pSYY"
    public static let verticalScaling = ICCSymbol(name: "verticalScaling", code: 0x70567453, type: typeType) // "pVtS"
    public static let view = ICCSymbol(name: "view", code: 0x63614456, type: typeType) // "caDV"
    public static let viewMode = ICCSymbol(name: "viewMode", code: 0x746f5676, type: typeType) // "toVv"
    public static let viewPdf = ICCSymbol(name: "viewPdf", code: 0x703e5653, type: typeType) // "p>VS"
    public static let visibilityVariable = ICCSymbol(name: "visibilityVariable", code: 0x70564956, type: typeType) // "pVIV"
    public static let visible = ICCSymbol(name: "visible", code: 0x70766973, type: typeType) // "pvis"
    public static let visibleBounds = ICCSymbol(name: "visibleBounds", code: 0x61695642, type: typeType) // "aiVB"
    public static let warichuCharactersAfterBreak = ICCSymbol(name: "warichuCharactersAfterBreak", code: 0x70433130, type: typeType) // "pC10"
    public static let warichuCharactersBeforeBreak = ICCSymbol(name: "warichuCharactersBeforeBreak", code: 0x7043307a, type: typeType) // "pC0z"
    public static let warichuEnabled = ICCSymbol(name: "warichuEnabled", code: 0x70433165, type: typeType) // "pC1e"
    public static let warichuGap = ICCSymbol(name: "warichuGap", code: 0x70433078, type: typeType) // "pC0x"
    public static let warichuJustification = ICCSymbol(name: "warichuJustification", code: 0x70433131, type: typeType) // "pC11"
    public static let warichuLines = ICCSymbol(name: "warichuLines", code: 0x70433077, type: typeType) // "pC0w"
    public static let warichuScale = ICCSymbol(name: "warichuScale", code: 0x70433079, type: typeType) // "pC0y"
    public static let warnings = ICCSymbol(name: "warnings", code: 0x70455772, type: typeType) // "pEWr"
    public static let webSnap = ICCSymbol(name: "webSnap", code: 0x70575063, type: typeType) // "pWPc"
    public static let Wednesday = ICCSymbol(name: "Wednesday", code: 0x77656420, type: typeType) // "wed "
    public static let width = ICCSymbol(name: "width", code: 0x70534877, type: typeType) // "pSHw"
    public static let word = ICCSymbol(name: "word", code: 0x63776f72, type: typeType) // "cwor"
    public static let wrapInside = ICCSymbol(name: "wrapInside", code: 0x70547749, type: typeType) // "pTwI"
    public static let wrapOffset = ICCSymbol(name: "wrapOffset", code: 0x7054774f, type: typeType) // "pTwO"
    public static let wrapped = ICCSymbol(name: "wrapped", code: 0x70745752, type: typeType) // "ptWR"
    public static let writeLayers = ICCSymbol(name: "writeLayers", code: 0x7057724c, type: typeType) // "pWrL"
    public static let writingCode = ICCSymbol(name: "writingCode", code: 0x70736374, type: typeType) // "psct"
    public static let XMPString = ICCSymbol(name: "XMPString", code: 0x70584d50, type: typeType) // "pXMP"
    public static let yellow = ICCSymbol(name: "yellow", code: 0x59454c4c, type: typeType) // "YELL"
    public static let zoom = ICCSymbol(name: "zoom", code: 0x61695a4d, type: typeType) // "aiZM"

    // Enumerators
    public static let absoluteColorimetric = ICCSymbol(name: "absoluteColorimetric", code: 0x65346733, type: typeEnumerated) // "e4g3"
    public static let abuttingTracingMethod = ICCSymbol(name: "abuttingTracingMethod", code: 0x65544d61, type: typeEnumerated) // "eTMa"
    public static let Acrobat4 = ICCSymbol(name: "Acrobat4", code: 0x65323331, type: typeEnumerated) // "e231"
    public static let Acrobat5 = ICCSymbol(name: "Acrobat5", code: 0x65323332, type: typeEnumerated) // "e232"
    public static let Acrobat6 = ICCSymbol(name: "Acrobat6", code: 0x65323333, type: typeEnumerated) // "e233"
    public static let Acrobat7 = ICCSymbol(name: "Acrobat7", code: 0x65323334, type: typeEnumerated) // "e234"
    public static let Acrobat8 = ICCSymbol(name: "Acrobat8", code: 0x65323335, type: typeEnumerated) // "e235"
    public static let adaptive = ICCSymbol(name: "adaptive", code: 0x65333530, type: typeEnumerated) // "e350"
    public static let allCaps = ICCSymbol(name: "allCaps", code: 0x65414538, type: typeEnumerated) // "eAE8"
    public static let allGlyphs = ICCSymbol(name: "allGlyphs", code: 0x65333835, type: typeEnumerated) // "e385"
    public static let allLayers = ICCSymbol(name: "allLayers", code: 0x65343633, type: typeEnumerated) // "e463"
    public static let allSmallCaps = ICCSymbol(name: "allSmallCaps", code: 0x65414539, type: typeEnumerated) // "eAE9"
    public static let anchorSelected = ICCSymbol(name: "anchorSelected", code: 0x65303530, type: typeEnumerated) // "e050"
    public static let Arabic = ICCSymbol(name: "Arabic", code: 0x654c3339, type: typeEnumerated) // "eL39"
    public static let areaText = ICCSymbol(name: "areaText", code: 0x65303632, type: typeEnumerated) // "e062"
    public static let artboardBounds = ICCSymbol(name: "artboardBounds", code: 0x65343731, type: typeEnumerated) // "e471"
    public static let artboardCoordinateSystem = ICCSymbol(name: "artboardCoordinateSystem", code: 0x65436f32, type: typeEnumerated) // "eCo2"
    public static let ArtboardsToFiles = ICCSymbol(name: "ArtboardsToFiles", code: 0x65343334, type: typeEnumerated) // "e434"
    public static let artOptimized = ICCSymbol(name: "artOptimized", code: 0x614f5054, type: typeEnumerated) // "aOPT"
    public static let artworkBounds = ICCSymbol(name: "artworkBounds", code: 0x65343732, type: typeEnumerated) // "e472"
    public static let ASCII = ICCSymbol(name: "ASCII", code: 0x65343030, type: typeEnumerated) // "e400"
    public static let ask = ICCSymbol(name: "ask", code: 0x61736b20, type: typeEnumerated) // "ask "
    public static let auto = ICCSymbol(name: "auto", code: 0x65414530, type: typeEnumerated) // "eAE0"
    public static let AutoCAD = ICCSymbol(name: "AutoCAD", code: 0x65333337, type: typeEnumerated) // "e337"
    public static let autocadCentimeters = ICCSymbol(name: "autocadCentimeters", code: 0x65415534, type: typeEnumerated) // "eAU4"
    public static let autocadInches = ICCSymbol(name: "autocadInches", code: 0x65415532, type: typeEnumerated) // "eAU2"
    public static let autocadMillimeters = ICCSymbol(name: "autocadMillimeters", code: 0x65415533, type: typeEnumerated) // "eAU3"
    public static let autocadPicas = ICCSymbol(name: "autocadPicas", code: 0x65415531, type: typeEnumerated) // "eAU1"
    public static let autocadPixels = ICCSymbol(name: "autocadPixels", code: 0x65415535, type: typeEnumerated) // "eAU5"
    public static let autocadPoints = ICCSymbol(name: "autocadPoints", code: 0x65415530, type: typeEnumerated) // "eAU0"
    public static let AutoCADRelease13 = ICCSymbol(name: "AutoCADRelease13", code: 0x65415630, type: typeEnumerated) // "eAV0"
    public static let AutoCADRelease14 = ICCSymbol(name: "AutoCADRelease14", code: 0x65415631, type: typeEnumerated) // "eAV1"
    public static let AutoCADRelease15 = ICCSymbol(name: "AutoCADRelease15", code: 0x65415632, type: typeEnumerated) // "eAV2"
    public static let AutoCADRelease18 = ICCSymbol(name: "AutoCADRelease18", code: 0x65415633, type: typeEnumerated) // "eAV3"
    public static let AutoCADRelease21 = ICCSymbol(name: "AutoCADRelease21", code: 0x65415634, type: typeEnumerated) // "eAV4"
    public static let AutoCADRelease24 = ICCSymbol(name: "AutoCADRelease24", code: 0x65415635, type: typeEnumerated) // "eAV5"
    public static let autoConvertBlends = ICCSymbol(name: "autoConvertBlends", code: 0x65356331, type: typeEnumerated) // "e5c1"
    public static let autoConvertGradients = ICCSymbol(name: "autoConvertGradients", code: 0x65356234, type: typeEnumerated) // "e5b4"
    public static let autoConvertText = ICCSymbol(name: "autoConvertText", code: 0x65356134, type: typeEnumerated) // "e5a4"
    public static let autoJustify = ICCSymbol(name: "autoJustify", code: 0x65313239, type: typeEnumerated) // "e129"
    public static let automaticJPEG2000High = ICCSymbol(name: "automaticJPEG2000High", code: 0x65353065, type: typeEnumerated) // "e50e"
    public static let automaticJPEG2000Lossless = ICCSymbol(name: "automaticJPEG2000Lossless", code: 0x65353131, type: typeEnumerated) // "e511"
    public static let automaticJPEG2000Low = ICCSymbol(name: "automaticJPEG2000Low", code: 0x65353063, type: typeEnumerated) // "e50c"
    public static let automaticJPEG2000Maximum = ICCSymbol(name: "automaticJPEG2000Maximum", code: 0x65353130, type: typeEnumerated) // "e510"
    public static let automaticJPEG2000Medium = ICCSymbol(name: "automaticJPEG2000Medium", code: 0x65353064, type: typeEnumerated) // "e50d"
    public static let automaticJPEG2000Minimum = ICCSymbol(name: "automaticJPEG2000Minimum", code: 0x65353062, type: typeEnumerated) // "e50b"
    public static let automaticJPEGHigh = ICCSymbol(name: "automaticJPEGHigh", code: 0x65353034, type: typeEnumerated) // "e504"
    public static let automaticJPEGLow = ICCSymbol(name: "automaticJPEGLow", code: 0x65353032, type: typeEnumerated) // "e502"
    public static let automaticJPEGMaximum = ICCSymbol(name: "automaticJPEGMaximum", code: 0x65353035, type: typeEnumerated) // "e505"
    public static let automaticJPEGMedium = ICCSymbol(name: "automaticJPEGMedium", code: 0x65353033, type: typeEnumerated) // "e503"
    public static let automaticJPEGMinimum = ICCSymbol(name: "automaticJPEGMinimum", code: 0x65353031, type: typeEnumerated) // "e501"
    public static let autoRotate = ICCSymbol(name: "autoRotate", code: 0x65343935, type: typeEnumerated) // "e495"
    public static let averageDownsampling = ICCSymbol(name: "averageDownsampling", code: 0x65323931, type: typeEnumerated) // "e291"
    public static let baselineAscent = ICCSymbol(name: "baselineAscent", code: 0x6b424153, type: typeEnumerated) // "kBAS"
    public static let baselineCapHeight = ICCSymbol(name: "baselineCapHeight", code: 0x6b424348, type: typeEnumerated) // "kBCH"
    public static let baselineEmBoxHeight = ICCSymbol(name: "baselineEmBoxHeight", code: 0x6b424548, type: typeEnumerated) // "kBEH"
    public static let baselineFixed = ICCSymbol(name: "baselineFixed", code: 0x6b424658, type: typeEnumerated) // "kBFX"
    public static let baselineLeading = ICCSymbol(name: "baselineLeading", code: 0x6b424c47, type: typeEnumerated) // "kBLG"
    public static let baselineLegacy = ICCSymbol(name: "baselineLegacy", code: 0x6b424c59, type: typeEnumerated) // "kBLY"
    public static let baselineXHeight = ICCSymbol(name: "baselineXHeight", code: 0x6b425848, type: typeEnumerated) // "kBXH"
    public static let basicCMYKDocument = ICCSymbol(name: "basicCMYKDocument", code: 0x70435052, type: typeEnumerated) // "pCPR"
    public static let basicRGBDocument = ICCSymbol(name: "basicRGBDocument", code: 0x70525052, type: typeEnumerated) // "pRPR"
    public static let beforeRunning = ICCSymbol(name: "beforeRunning", code: 0x61393432, type: typeEnumerated) // "a942"
    public static let BengaliIndia = ICCSymbol(name: "BengaliIndia", code: 0x654c3531, type: typeEnumerated) // "eL51"
    public static let beveled = ICCSymbol(name: "beveled", code: 0x65303331, type: typeEnumerated) // "e031"
    public static let bicubicDownsample = ICCSymbol(name: "bicubicDownsample", code: 0x65323933, type: typeEnumerated) // "e293"
    public static let bitmapRasterization = ICCSymbol(name: "bitmapRasterization", code: 0x6b525362, type: typeEnumerated) // "kRSb"
    public static let blackAndWhiteOutput = ICCSymbol(name: "blackAndWhiteOutput", code: 0x65346933, type: typeEnumerated) // "e4i3"
    public static let blackInk = ICCSymbol(name: "blackInk", code: 0x70506d62, type: typeEnumerated) // "pPmb"
    public static let blueTransparencyGrids = ICCSymbol(name: "blueTransparencyGrids", code: 0x70544742, type: typeEnumerated) // "pTGB"
    public static let BokmalNorwegian = ICCSymbol(name: "BokmalNorwegian", code: 0x654c3039, type: typeEnumerated) // "eL09"
    public static let bottom = ICCSymbol(name: "bottom", code: 0x65313737, type: typeEnumerated) // "e177"
    public static let bottomLeft = ICCSymbol(name: "bottomLeft", code: 0x65313734, type: typeEnumerated) // "e174"
    public static let bottomRight = ICCSymbol(name: "bottomRight", code: 0x65313741, type: typeEnumerated) // "e17A"
    public static let bottomToBottom = ICCSymbol(name: "bottomToBottom", code: 0x65427442, type: typeEnumerated) // "eBtB"
    public static let bottomUp = ICCSymbol(name: "bottomUp", code: 0x65344130, type: typeEnumerated) // "e4A0"
    public static let BrazillianPortuguese = ICCSymbol(name: "BrazillianPortuguese", code: 0x654c3132, type: typeEnumerated) // "eL12"
    public static let brushesLibrary = ICCSymbol(name: "brushesLibrary", code: 0x65313937, type: typeEnumerated) // "e197"
    public static let Bulgarian = ICCSymbol(name: "Bulgarian", code: 0x654c3231, type: typeEnumerated) // "eL21"
    public static let butted = ICCSymbol(name: "butted", code: 0x65303230, type: typeEnumerated) // "e020"
    public static let BWMacintosh = ICCSymbol(name: "BWMacintosh", code: 0x65323131, type: typeEnumerated) // "e211"
    public static let BWTIFF = ICCSymbol(name: "BWTIFF", code: 0x65323133, type: typeEnumerated) // "e213"
    public static let bwTracingMode = ICCSymbol(name: "bwTracingMode", code: 0x65544d62, type: typeEnumerated) // "eTMb"
    public static let CanadianFrench = ICCSymbol(name: "CanadianFrench", code: 0x654c3034, type: typeEnumerated) // "eL04"
    public static let cascade = ICCSymbol(name: "cascade", code: 0x6b414364, type: typeEnumerated) // "kACd"
    public static let case_ = ICCSymbol(name: "case_", code: 0x63617365, type: typeEnumerated) // "case"
    public static let Catalan = ICCSymbol(name: "Catalan", code: 0x654c3138, type: typeEnumerated) // "eL18"
    public static let CCIT3 = ICCSymbol(name: "CCIT3", code: 0x65323732, type: typeEnumerated) // "e272"
    public static let CCIT4 = ICCSymbol(name: "CCIT4", code: 0x65323731, type: typeEnumerated) // "e271"
    public static let center = ICCSymbol(name: "center", code: 0x65313232, type: typeEnumerated) // "e122"
    public static let centimeters = ICCSymbol(name: "centimeters", code: 0x65313833, type: typeEnumerated) // "e183"
    public static let Chinese = ICCSymbol(name: "Chinese", code: 0x654c3330, type: typeEnumerated) // "eL30"
    public static let CMYK = ICCSymbol(name: "CMYK", code: 0x6543794d, type: typeEnumerated) // "eCyM"
    public static let colorBlend = ICCSymbol(name: "colorBlend", code: 0x65333134, type: typeEnumerated) // "e314"
    public static let colorBurn = ICCSymbol(name: "colorBurn", code: 0x65333037, type: typeEnumerated) // "e307"
    public static let colorConversionRepurpose = ICCSymbol(name: "colorConversionRepurpose", code: 0x65506333, type: typeEnumerated) // "ePc3"
    public static let colorConversionToDest = ICCSymbol(name: "colorConversionToDest", code: 0x65506332, type: typeEnumerated) // "ePc2"
    public static let colorDestDocCmyk = ICCSymbol(name: "colorDestDocCmyk", code: 0x65446332, type: typeEnumerated) // "eDc2"
    public static let colorDestDocRgb = ICCSymbol(name: "colorDestDocRgb", code: 0x65446334, type: typeEnumerated) // "eDc4"
    public static let colorDestProfile = ICCSymbol(name: "colorDestProfile", code: 0x65446336, type: typeEnumerated) // "eDc6"
    public static let colorDestWorkingCmyk = ICCSymbol(name: "colorDestWorkingCmyk", code: 0x65446333, type: typeEnumerated) // "eDc3"
    public static let colorDestWorkingRgb = ICCSymbol(name: "colorDestWorkingRgb", code: 0x65446335, type: typeEnumerated) // "eDc5"
    public static let colorDodge = ICCSymbol(name: "colorDodge", code: 0x65333036, type: typeEnumerated) // "e306"
    public static let colorMacintosh = ICCSymbol(name: "colorMacintosh", code: 0x65323132, type: typeEnumerated) // "e212"
    public static let colorOutput = ICCSymbol(name: "colorOutput", code: 0x65346931, type: typeEnumerated) // "e4i1"
    public static let colorTIFF = ICCSymbol(name: "colorTIFF", code: 0x65323134, type: typeEnumerated) // "e214"
    public static let colorTracingMode = ICCSymbol(name: "colorTracingMode", code: 0x65544d63, type: typeEnumerated) // "eTMc"
    public static let column = ICCSymbol(name: "column", code: 0x70436f6c, type: typeEnumerated) // "pCol"
    public static let commonEnglish = ICCSymbol(name: "commonEnglish", code: 0x65333831, type: typeEnumerated) // "e381"
    public static let commonRoman = ICCSymbol(name: "commonRoman", code: 0x65333833, type: typeEnumerated) // "e383"
    public static let complete = ICCSymbol(name: "complete", code: 0x65346332, type: typeEnumerated) // "e4c2"
    public static let composite = ICCSymbol(name: "composite", code: 0x65343831, type: typeEnumerated) // "e481"
    public static let consolidateAll = ICCSymbol(name: "consolidateAll", code: 0x6b414341, type: typeEnumerated) // "kACA"
    public static let convertInk = ICCSymbol(name: "convertInk", code: 0x65346a33, type: typeEnumerated) // "e4j3"
    public static let corner = ICCSymbol(name: "corner", code: 0x65303537, type: typeEnumerated) // "e057"
    public static let crisp = ICCSymbol(name: "crisp", code: 0x65303634, type: typeEnumerated) // "e064"
    public static let cropBounds = ICCSymbol(name: "cropBounds", code: 0x65343733, type: typeEnumerated) // "e473"
    public static let customInk = ICCSymbol(name: "customInk", code: 0x70506d63, type: typeEnumerated) // "pPmc"
    public static let customProfile = ICCSymbol(name: "customProfile", code: 0x65346634, type: typeEnumerated) // "e4f4"
    public static let cyanInk = ICCSymbol(name: "cyanInk", code: 0x70506d38, type: typeEnumerated) // "pPm8"
    public static let Czech = ICCSymbol(name: "Czech", code: 0x654c3233, type: typeEnumerated) // "eL23"
    public static let Danish = ICCSymbol(name: "Danish", code: 0x654c3137, type: typeEnumerated) // "eL17"
    public static let darkColorTransparencyGrids = ICCSymbol(name: "darkColorTransparencyGrids", code: 0x70544744, type: typeEnumerated) // "pTGD"
    public static let darken = ICCSymbol(name: "darken", code: 0x65333038, type: typeEnumerated) // "e308"
    public static let dataFromFile = ICCSymbol(name: "dataFromFile", code: 0x65303931, type: typeEnumerated) // "e091"
    public static let decimal = ICCSymbol(name: "decimal", code: 0x65313234, type: typeEnumerated) // "e124"
    public static let default_ = ICCSymbol(name: "default_", code: 0x70465330, type: typeEnumerated) // "pFS0"
    public static let defaultPreview = ICCSymbol(name: "defaultPreview", code: 0x7044504d, type: typeEnumerated) // "pDPM"
    public static let defaultPurpose = ICCSymbol(name: "defaultPurpose", code: 0x6b445055, type: typeEnumerated) // "kDPU"
    public static let defaultRasterization = ICCSymbol(name: "defaultRasterization", code: 0x6b525364, type: typeEnumerated) // "kRSd"
    public static let denominator = ICCSymbol(name: "denominator", code: 0x704f5437, type: typeEnumerated) // "pOT7"
    public static let desktop = ICCSymbol(name: "desktop", code: 0x65303032, type: typeEnumerated) // "e002"
    public static let DeviceN = ICCSymbol(name: "DeviceN", code: 0x6530444e, type: typeEnumerated) // "e0DN"
    public static let deviceSubstitution = ICCSymbol(name: "deviceSubstitution", code: 0x65346433, type: typeEnumerated) // "e4d3"
    public static let diacriticals = ICCSymbol(name: "diacriticals", code: 0x64696163, type: typeEnumerated) // "diac"
    public static let difference = ICCSymbol(name: "difference", code: 0x65333130, type: typeEnumerated) // "e310"
    public static let diffusion = ICCSymbol(name: "diffusion", code: 0x65333630, type: typeEnumerated) // "e360"
    public static let disabled = ICCSymbol(name: "disabled", code: 0x65333231, type: typeEnumerated) // "e321"
    public static let disableInk = ICCSymbol(name: "disableInk", code: 0x65346a31, type: typeEnumerated) // "e4j1"
    public static let discard = ICCSymbol(name: "discard", code: 0x65353431, type: typeEnumerated) // "e541"
    public static let documentCoordinateSystem = ICCSymbol(name: "documentCoordinateSystem", code: 0x65436f31, type: typeEnumerated) // "eCo1"
    public static let documentOrigin = ICCSymbol(name: "documentOrigin", code: 0x65313731, type: typeEnumerated) // "e171"
    public static let dummyPurposeOption = ICCSymbol(name: "dummyPurposeOption", code: 0x6b44554d, type: typeEnumerated) // "kDUM"
    public static let Dutch = ICCSymbol(name: "Dutch", code: 0x654c3136, type: typeEnumerated) // "eL16"
    public static let Dutch2005Reform = ICCSymbol(name: "Dutch2005Reform", code: 0x654c3433, type: typeEnumerated) // "eL43"
    public static let dwg = ICCSymbol(name: "dwg", code: 0x65414631, type: typeEnumerated) // "eAF1"
    public static let dxf = ICCSymbol(name: "dxf", code: 0x65414630, type: typeEnumerated) // "eAF0"
    public static let embed = ICCSymbol(name: "embed", code: 0x65334430, type: typeEnumerated) // "e3D0"
    public static let enabled = ICCSymbol(name: "enabled", code: 0x65333232, type: typeEnumerated) // "e322"
    public static let enableInk = ICCSymbol(name: "enableInk", code: 0x65346a32, type: typeEnumerated) // "e4j2"
    public static let English = ICCSymbol(name: "English", code: 0x654c3031, type: typeEnumerated) // "eL01"
    public static let entities = ICCSymbol(name: "entities", code: 0x65343130, type: typeEnumerated) // "e410"
    public static let eps = ICCSymbol(name: "eps", code: 0x65313932, type: typeEnumerated) // "e192"
    public static let exclusion = ICCSymbol(name: "exclusion", code: 0x65333131, type: typeEnumerated) // "e311"
    public static let expandFilters = ICCSymbol(name: "expandFilters", code: 0x65353931, type: typeEnumerated) // "e591"
    public static let expansion = ICCSymbol(name: "expansion", code: 0x65787061, type: typeEnumerated) // "expa"
    public static let expert = ICCSymbol(name: "expert", code: 0x65414566, type: typeEnumerated) // "eAEf"
    public static let exportPurpose = ICCSymbol(name: "exportPurpose", code: 0x6b455055, type: typeEnumerated) // "kEPU"
    public static let Farsi = ICCSymbol(name: "Farsi", code: 0x654c3431, type: typeEnumerated) // "eL41"
    public static let Finnish = ICCSymbol(name: "Finnish", code: 0x654c3032, type: typeEnumerated) // "eL02"
    public static let fitArtboard = ICCSymbol(name: "fitArtboard", code: 0x65415331, type: typeEnumerated) // "eAS1"
    public static let Flash = ICCSymbol(name: "Flash", code: 0x65333336, type: typeEnumerated) // "e336"
    public static let FlashFile = ICCSymbol(name: "FlashFile", code: 0x65343330, type: typeEnumerated) // "e430"
    public static let flashPlaybackLocalAccess = ICCSymbol(name: "flashPlaybackLocalAccess", code: 0x6546504c, type: typeEnumerated) // "eFPL"
    public static let flashPlaybackNetworkAccess = ICCSymbol(name: "flashPlaybackNetworkAccess", code: 0x6546504e, type: typeEnumerated) // "eFPN"
    public static let floatAll = ICCSymbol(name: "floatAll", code: 0x6b414641, type: typeEnumerated) // "kAFA"
    public static let floorplane = ICCSymbol(name: "floorplane", code: 0x65505034, type: typeEnumerated) // "ePP4"
    public static let forced = ICCSymbol(name: "forced", code: 0x65504a31, type: typeEnumerated) // "ePJ1"
    public static let fullJustify = ICCSymbol(name: "fullJustify", code: 0x65313238, type: typeEnumerated) // "e128"
    public static let fullJustifyLastLineCenter = ICCSymbol(name: "fullJustifyLastLineCenter", code: 0x65313237, type: typeEnumerated) // "e127"
    public static let fullJustifyLastLineLeft = ICCSymbol(name: "fullJustifyLastLineLeft", code: 0x65313235, type: typeEnumerated) // "e125"
    public static let fullJustifyLastLineRight = ICCSymbol(name: "fullJustifyLastLineRight", code: 0x65313236, type: typeEnumerated) // "e126"
    public static let fullPages = ICCSymbol(name: "fullPages", code: 0x65346131, type: typeEnumerated) // "e4a1"
    public static let fullScreen = ICCSymbol(name: "fullScreen", code: 0x65303033, type: typeEnumerated) // "e003"
    public static let fullWidth = ICCSymbol(name: "fullWidth", code: 0x6541456f, type: typeEnumerated) // "eAEo"
    public static let fxg = ICCSymbol(name: "fxg", code: 0x65313934, type: typeEnumerated) // "e194"
    public static let German2006Reform = ICCSymbol(name: "German2006Reform", code: 0x654c3432, type: typeEnumerated) // "eL42"
    public static let GIF = ICCSymbol(name: "GIF", code: 0x65333335, type: typeEnumerated) // "e335"
    public static let glyphsUsed = ICCSymbol(name: "glyphsUsed", code: 0x65333830, type: typeEnumerated) // "e380"
    public static let glyphsUsedPlusEnglish = ICCSymbol(name: "glyphsUsedPlusEnglish", code: 0x65333832, type: typeEnumerated) // "e382"
    public static let glyphsUsedPlusRoman = ICCSymbol(name: "glyphsUsedPlusRoman", code: 0x65333834, type: typeEnumerated) // "e384"
    public static let graph = ICCSymbol(name: "graph", code: 0x65343434, type: typeEnumerated) // "e444"
    public static let graphicStylesLibrary = ICCSymbol(name: "graphicStylesLibrary", code: 0x65313938, type: typeEnumerated) // "e198"
    public static let Gray = ICCSymbol(name: "Gray", code: 0x6530474d, type: typeEnumerated) // "e0GM"
    public static let grayscaleOutput = ICCSymbol(name: "grayscaleOutput", code: 0x65346932, type: typeEnumerated) // "e4i2"
    public static let grayscaleRasterization = ICCSymbol(name: "grayscaleRasterization", code: 0x6b525367, type: typeEnumerated) // "kRSg"
    public static let grayTracingMode = ICCSymbol(name: "grayTracingMode", code: 0x65544d67, type: typeEnumerated) // "eTMg"
    public static let Greek = ICCSymbol(name: "Greek", code: 0x654c3236, type: typeEnumerated) // "eL26"
    public static let greenTransparencyGrids = ICCSymbol(name: "greenTransparencyGrids", code: 0x70544747, type: typeEnumerated) // "pTGG"
    public static let gridByColumn = ICCSymbol(name: "gridByColumn", code: 0x70477243, type: typeEnumerated) // "pGrC"
    public static let gridByRow = ICCSymbol(name: "gridByRow", code: 0x70477252, type: typeEnumerated) // "pGrR"
    public static let Gujarati = ICCSymbol(name: "Gujarati", code: 0x654c3533, type: typeEnumerated) // "eL53"
    public static let halfWidth = ICCSymbol(name: "halfWidth", code: 0x65414569, type: typeEnumerated) // "eAEi"
    public static let hardLight = ICCSymbol(name: "hardLight", code: 0x65333035, type: typeEnumerated) // "e305"
    public static let hideTransparencyGrids = ICCSymbol(name: "hideTransparencyGrids", code: 0x7054474e, type: typeEnumerated) // "pTGN"
    public static let highResolution = ICCSymbol(name: "highResolution", code: 0x70485252, type: typeEnumerated) // "pHRR"
    public static let Hindi = ICCSymbol(name: "Hindi", code: 0x654c3439, type: typeEnumerated) // "eL49"
    public static let horizontal = ICCSymbol(name: "horizontal", code: 0x65303730, type: typeEnumerated) // "e070"
    public static let horizontalTile = ICCSymbol(name: "horizontalTile", code: 0x6b414854, type: typeEnumerated) // "kAHT"
    public static let hostBasedSeparation = ICCSymbol(name: "hostBasedSeparation", code: 0x65343832, type: typeEnumerated) // "e482"
    public static let hue = ICCSymbol(name: "hue", code: 0x65333132, type: typeEnumerated) // "e312"
    public static let Hungarian = ICCSymbol(name: "Hungarian", code: 0x654c3239, type: typeEnumerated) // "eL29"
    public static let hyphens = ICCSymbol(name: "hyphens", code: 0x68797068, type: typeEnumerated) // "hyph"
    public static let IBMPC = ICCSymbol(name: "IBMPC", code: 0x6b544250, type: typeEnumerated) // "kTBP"
    public static let Icelandic = ICCSymbol(name: "Icelandic", code: 0x654c3238, type: typeEnumerated) // "eL28"
    public static let icfBottom = ICCSymbol(name: "icfBottom", code: 0x6541456c, type: typeEnumerated) // "eAEl"
    public static let icfTop = ICCSymbol(name: "icfTop", code: 0x6541456e, type: typeEnumerated) // "eAEn"
    public static let ignoreOpaque = ICCSymbol(name: "ignoreOpaque", code: 0x65346c33, type: typeEnumerated) // "e4l3"
    public static let Illustrator = ICCSymbol(name: "Illustrator", code: 0x65313931, type: typeEnumerated) // "e191"
    public static let Illustrator10 = ICCSymbol(name: "Illustrator10", code: 0x65323039, type: typeEnumerated) // "e209"
    public static let Illustrator11 = ICCSymbol(name: "Illustrator11", code: 0x65323061, type: typeEnumerated) // "e20a"
    public static let Illustrator12 = ICCSymbol(name: "Illustrator12", code: 0x65323062, type: typeEnumerated) // "e20b"
    public static let Illustrator13 = ICCSymbol(name: "Illustrator13", code: 0x65323063, type: typeEnumerated) // "e20c"
    public static let Illustrator14 = ICCSymbol(name: "Illustrator14", code: 0x65323064, type: typeEnumerated) // "e20d"
    public static let Illustrator15 = ICCSymbol(name: "Illustrator15", code: 0x65323065, type: typeEnumerated) // "e20e"
    public static let Illustrator16 = ICCSymbol(name: "Illustrator16", code: 0x65323066, type: typeEnumerated) // "e20f"
    public static let Illustrator17 = ICCSymbol(name: "Illustrator17", code: 0x65323067, type: typeEnumerated) // "e20g"
    public static let Illustrator3 = ICCSymbol(name: "Illustrator3", code: 0x65327832, type: typeEnumerated) // "e2x2"
    public static let Illustrator8 = ICCSymbol(name: "Illustrator8", code: 0x65323037, type: typeEnumerated) // "e207"
    public static let Illustrator9 = ICCSymbol(name: "Illustrator9", code: 0x65323038, type: typeEnumerated) // "e208"
    public static let IllustratorArtwork = ICCSymbol(name: "IllustratorArtwork", code: 0x65313935, type: typeEnumerated) // "e195"
    public static let image = ICCSymbol(name: "image", code: 0x65343433, type: typeEnumerated) // "e443"
    public static let imageableAreas = ICCSymbol(name: "imageableAreas", code: 0x65346132, type: typeEnumerated) // "e4a2"
    public static let inBuild = ICCSymbol(name: "inBuild", code: 0x65344231, type: typeEnumerated) // "e4B1"
    public static let inches = ICCSymbol(name: "inches", code: 0x65313832, type: typeEnumerated) // "e182"
    public static let includeAllProfiles = ICCSymbol(name: "includeAllProfiles", code: 0x65447032, type: typeEnumerated) // "eDp2"
    public static let includeAllRgb = ICCSymbol(name: "includeAllRgb", code: 0x65447034, type: typeEnumerated) // "eDp4"
    public static let includeDestProfile = ICCSymbol(name: "includeDestProfile", code: 0x65447035, type: typeEnumerated) // "eDp5"
    public static let Indexed = ICCSymbol(name: "Indexed", code: 0x65304944, type: typeEnumerated) // "e0ID"
    public static let inherited = ICCSymbol(name: "inherited", code: 0x65333233, type: typeEnumerated) // "e323"
    public static let InRIPSeparation = ICCSymbol(name: "InRIPSeparation", code: 0x65343833, type: typeEnumerated) // "e483"
    public static let inSequence = ICCSymbol(name: "inSequence", code: 0x65344230, type: typeEnumerated) // "e4B0"
    public static let interactWithAll = ICCSymbol(name: "interactWithAll", code: 0x65343564, type: typeEnumerated) // "e45d"
    public static let interactWithLocal = ICCSymbol(name: "interactWithLocal", code: 0x65343563, type: typeEnumerated) // "e45c"
    public static let interactWithSelf = ICCSymbol(name: "interactWithSelf", code: 0x65343562, type: typeEnumerated) // "e45b"
    public static let Italian = ICCSymbol(name: "Italian", code: 0x654c3038, type: typeEnumerated) // "eL08"
    public static let Japanese = ICCSymbol(name: "Japanese", code: 0x654c3331, type: typeEnumerated) // "eL31"
    public static let Japanese3 = ICCSymbol(name: "Japanese3", code: 0x65323032, type: typeEnumerated) // "e202"
    public static let JapaneseStyle = ICCSymbol(name: "JapaneseStyle", code: 0x65303831, type: typeEnumerated) // "e081"
    public static let jis04 = ICCSymbol(name: "jis04", code: 0x65414572, type: typeEnumerated) // "eAEr"
    public static let jis78 = ICCSymbol(name: "jis78", code: 0x65414567, type: typeEnumerated) // "eAEg"
    public static let jis83 = ICCSymbol(name: "jis83", code: 0x65414568, type: typeEnumerated) // "eAEh"
    public static let jis90 = ICCSymbol(name: "jis90", code: 0x65414571, type: typeEnumerated) // "eAEq"
    public static let JPEG = ICCSymbol(name: "JPEG", code: 0x65333330, type: typeEnumerated) // "e330"
    public static let JPEG2000High = ICCSymbol(name: "JPEG2000High", code: 0x65353135, type: typeEnumerated) // "e515"
    public static let JPEG2000Lossless = ICCSymbol(name: "JPEG2000Lossless", code: 0x65353137, type: typeEnumerated) // "e517"
    public static let JPEG2000Low = ICCSymbol(name: "JPEG2000Low", code: 0x65353133, type: typeEnumerated) // "e513"
    public static let JPEG2000Maximum = ICCSymbol(name: "JPEG2000Maximum", code: 0x65353136, type: typeEnumerated) // "e516"
    public static let JPEG2000Medium = ICCSymbol(name: "JPEG2000Medium", code: 0x65353134, type: typeEnumerated) // "e514"
    public static let JPEG2000Minimum = ICCSymbol(name: "JPEG2000Minimum", code: 0x65353132, type: typeEnumerated) // "e512"
    public static let JPEGHigh = ICCSymbol(name: "JPEGHigh", code: 0x65323538, type: typeEnumerated) // "e258"
    public static let JPEGLow = ICCSymbol(name: "JPEGLow", code: 0x65323536, type: typeEnumerated) // "e256"
    public static let JPEGMaximum = ICCSymbol(name: "JPEGMaximum", code: 0x65323539, type: typeEnumerated) // "e259"
    public static let JPEGMedium = ICCSymbol(name: "JPEGMedium", code: 0x65323537, type: typeEnumerated) // "e257"
    public static let JPEGMinimum = ICCSymbol(name: "JPEGMinimum", code: 0x65323535, type: typeEnumerated) // "e255"
    public static let JPEGRaster = ICCSymbol(name: "JPEGRaster", code: 0x65415231, type: typeEnumerated) // "eAR1"
    public static let Kannada = ICCSymbol(name: "Kannada", code: 0x654c3537, type: typeEnumerated) // "eL57"
    public static let keepFiltersEditable = ICCSymbol(name: "keepFiltersEditable", code: 0x65353933, type: typeEnumerated) // "e593"
    public static let keepGradientsEditable = ICCSymbol(name: "keepGradientsEditable", code: 0x65356233, type: typeEnumerated) // "e5b3"
    public static let keepTextEditable = ICCSymbol(name: "keepTextEditable", code: 0x65356133, type: typeEnumerated) // "e5a3"
    public static let KumiMoji = ICCSymbol(name: "KumiMoji", code: 0x65313132, type: typeEnumerated) // "e112"
    public static let LAB = ICCSymbol(name: "LAB", code: 0x65304c62, type: typeEnumerated) // "e0Lb"
    public static let landscape = ICCSymbol(name: "landscape", code: 0x65343932, type: typeEnumerated) // "e492"
    public static let layersToFiles = ICCSymbol(name: "layersToFiles", code: 0x65343332, type: typeEnumerated) // "e432"
    public static let layersToFrames = ICCSymbol(name: "layersToFrames", code: 0x65343331, type: typeEnumerated) // "e431"
    public static let layersToSymbols = ICCSymbol(name: "layersToSymbols", code: 0x65343333, type: typeEnumerated) // "e433"
    public static let leaveProfileUnchanged = ICCSymbol(name: "leaveProfileUnchanged", code: 0x65447033, type: typeEnumerated) // "eDp3"
    public static let left_ = ICCSymbol(name: "left_", code: 0x65313231, type: typeEnumerated) // "e121"
    public static let leftplane = ICCSymbol(name: "leftplane", code: 0x65505032, type: typeEnumerated) // "ePP2"
    public static let leftRightSelected = ICCSymbol(name: "leftRightSelected", code: 0x65303533, type: typeEnumerated) // "e053"
    public static let leftSelected = ICCSymbol(name: "leftSelected", code: 0x65303531, type: typeEnumerated) // "e051"
    public static let level1 = ICCSymbol(name: "level1", code: 0x65323230, type: typeEnumerated) // "e220"
    public static let level2 = ICCSymbol(name: "level2", code: 0x65323231, type: typeEnumerated) // "e221"
    public static let level3 = ICCSymbol(name: "level3", code: 0x65323232, type: typeEnumerated) // "e222"
    public static let lightColorTransparencyGrids = ICCSymbol(name: "lightColorTransparencyGrids", code: 0x7054474c, type: typeEnumerated) // "pTGL"
    public static let lighten = ICCSymbol(name: "lighten", code: 0x65333039, type: typeEnumerated) // "e309"
    public static let linear = ICCSymbol(name: "linear", code: 0x65303430, type: typeEnumerated) // "e040"
    public static let link = ICCSymbol(name: "link", code: 0x65334431, type: typeEnumerated) // "e3D1"
    public static let lossless = ICCSymbol(name: "lossless", code: 0x65343361, type: typeEnumerated) // "e43a"
    public static let lossy = ICCSymbol(name: "lossy", code: 0x65343362, type: typeEnumerated) // "e43b"
    public static let lowerCase = ICCSymbol(name: "lowerCase", code: 0x65414534, type: typeEnumerated) // "eAE4"
    public static let luminosity = ICCSymbol(name: "luminosity", code: 0x65333135, type: typeEnumerated) // "e315"
    public static let macintosh = ICCSymbol(name: "macintosh", code: 0x6b54424d, type: typeEnumerated) // "kTBM"
    public static let magentaInk = ICCSymbol(name: "magentaInk", code: 0x70506d39, type: typeEnumerated) // "pPm9"
    public static let maintainAppearance = ICCSymbol(name: "maintainAppearance", code: 0x65457830, type: typeEnumerated) // "eEx0"
    public static let Malayalam = ICCSymbol(name: "Malayalam", code: 0x654c3538, type: typeEnumerated) // "eL58"
    public static let Marathi = ICCSymbol(name: "Marathi", code: 0x654c3530, type: typeEnumerated) // "eL50"
    public static let max16Colors = ICCSymbol(name: "max16Colors", code: 0x65414331, type: typeEnumerated) // "eAC1"
    public static let max256Colors = ICCSymbol(name: "max256Colors", code: 0x65414332, type: typeEnumerated) // "eAC2"
    public static let max8Colors = ICCSymbol(name: "max8Colors", code: 0x65414330, type: typeEnumerated) // "eAC0"
    public static let maximizeEditability = ICCSymbol(name: "maximizeEditability", code: 0x65457831, type: typeEnumerated) // "eEx1"
    public static let mediumColorTransparencyGrids = ICCSymbol(name: "mediumColorTransparencyGrids", code: 0x7054474d, type: typeEnumerated) // "pTGM"
    public static let mediumResolution = ICCSymbol(name: "mediumResolution", code: 0x704d5252, type: typeEnumerated) // "pMRR"
    public static let metricsromanonly = ICCSymbol(name: "metricsromanonly", code: 0x65414573, type: typeEnumerated) // "eAEs"
    public static let millimeters = ICCSymbol(name: "millimeters", code: 0x65313836, type: typeEnumerated) // "e186"
    public static let minimalSvg = ICCSymbol(name: "minimalSvg", code: 0x65334330, type: typeEnumerated) // "e3C0"
    public static let mitered = ICCSymbol(name: "mitered", code: 0x65303330, type: typeEnumerated) // "e030"
    public static let mobileDocumentPreset = ICCSymbol(name: "mobileDocumentPreset", code: 0x704d5052, type: typeEnumerated) // "pMPR"
    public static let modifiedData = ICCSymbol(name: "modifiedData", code: 0x65303932, type: typeEnumerated) // "e092"
    public static let moveBackward = ICCSymbol(name: "moveBackward", code: 0x65333732, type: typeEnumerated) // "e372"
    public static let moveForward = ICCSymbol(name: "moveForward", code: 0x65333731, type: typeEnumerated) // "e371"
    public static let moveToBack = ICCSymbol(name: "moveToBack", code: 0x65333733, type: typeEnumerated) // "e373"
    public static let moveToFront = ICCSymbol(name: "moveToFront", code: 0x65333730, type: typeEnumerated) // "e370"
    public static let multiply = ICCSymbol(name: "multiply", code: 0x65333031, type: typeEnumerated) // "e301"
    public static let multiwindow = ICCSymbol(name: "multiwindow", code: 0x65303031, type: typeEnumerated) // "e001"
    public static let negative = ICCSymbol(name: "negative", code: 0x65616f32, type: typeEnumerated) // "eao2"
    public static let never = ICCSymbol(name: "never", code: 0x4e657672, type: typeEnumerated) // "Nevr"
    public static let neverInteract = ICCSymbol(name: "neverInteract", code: 0x65343561, type: typeEnumerated) // "e45a"
    public static let no = ICCSymbol(name: "no", code: 0x6e6f2020, type: typeEnumerated) // "no  "
    public static let noData = ICCSymbol(name: "noData", code: 0x65303930, type: typeEnumerated) // "e090"
    public static let nodownsample = ICCSymbol(name: "nodownsample", code: 0x65323930, type: typeEnumerated) // "e290"
    public static let noise = ICCSymbol(name: "noise", code: 0x65333633, type: typeEnumerated) // "e363"
    public static let none_ = ICCSymbol(name: "none_", code: 0x67653031, type: typeEnumerated) // "ge01"
    public static let nonPostScriptPrinter = ICCSymbol(name: "nonPostScriptPrinter", code: 0x65346832, type: typeEnumerated) // "e4h2"
    public static let noplane = ICCSymbol(name: "noplane", code: 0x65505031, type: typeEnumerated) // "ePP1"
    public static let normal = ICCSymbol(name: "normal", code: 0x65313130, type: typeEnumerated) // "e110"
    public static let numerator = ICCSymbol(name: "numerator", code: 0x704f5436, type: typeEnumerated) // "pOT6"
    public static let numericStrings = ICCSymbol(name: "numericStrings", code: 0x6e756d65, type: typeEnumerated) // "nume"
    public static let NynorskNorwegian = ICCSymbol(name: "NynorskNorwegian", code: 0x654c3130, type: typeEnumerated) // "eL10"
    public static let obliqueSubstitution = ICCSymbol(name: "obliqueSubstitution", code: 0x65346431, type: typeEnumerated) // "e4d1"
    public static let oldGerman = ICCSymbol(name: "oldGerman", code: 0x654c3036, type: typeEnumerated) // "eL06"
    public static let oldstyleProfile = ICCSymbol(name: "oldstyleProfile", code: 0x65346631, type: typeEnumerated) // "e4f1"
    public static let onRuntimeError = ICCSymbol(name: "onRuntimeError", code: 0x65393431, type: typeEnumerated) // "e941"
    public static let opaque = ICCSymbol(name: "opaque", code: 0x65346c32, type: typeEnumerated) // "e4l2"
    public static let optical = ICCSymbol(name: "optical", code: 0x65414531, type: typeEnumerated) // "eAE1"
    public static let optimized = ICCSymbol(name: "optimized", code: 0x65343365, type: typeEnumerated) // "e43e"
    public static let orangeTransparencyGrids = ICCSymbol(name: "orangeTransparencyGrids", code: 0x7054474f, type: typeEnumerated) // "pTGO"
    public static let originalSize = ICCSymbol(name: "originalSize", code: 0x65415330, type: typeEnumerated) // "eAS0"
    public static let Oriya = ICCSymbol(name: "Oriya", code: 0x654c3534, type: typeEnumerated) // "eL54"
    public static let outlineFont = ICCSymbol(name: "outlineFont", code: 0x65334132, type: typeEnumerated) // "e3A2"
    public static let outlineText = ICCSymbol(name: "outlineText", code: 0x65356131, type: typeEnumerated) // "e5a1"
    public static let outputArtboardBounds = ICCSymbol(name: "outputArtboardBounds", code: 0x65343336, type: typeEnumerated) // "e436"
    public static let outputArtBounds = ICCSymbol(name: "outputArtBounds", code: 0x65343335, type: typeEnumerated) // "e435"
    public static let outputCroprectBounds = ICCSymbol(name: "outputCroprectBounds", code: 0x65343337, type: typeEnumerated) // "e437"
    public static let overlappingTracingMethod = ICCSymbol(name: "overlappingTracingMethod", code: 0x65544d6f, type: typeEnumerated) // "eTMo"
    public static let overlay = ICCSymbol(name: "overlay", code: 0x65333033, type: typeEnumerated) // "e303"
    public static let overprintPreview = ICCSymbol(name: "overprintPreview", code: 0x704f5050, type: typeEnumerated) // "pOPP"
    public static let pathText = ICCSymbol(name: "pathText", code: 0x65303631, type: typeEnumerated) // "e061"
    public static let patternDither = ICCSymbol(name: "patternDither", code: 0x65333631, type: typeEnumerated) // "e361"
    public static let pdf = ICCSymbol(name: "pdf", code: 0x65313933, type: typeEnumerated) // "e193"
    public static let pdf128AnyChanges = ICCSymbol(name: "pdf128AnyChanges", code: 0x65353634, type: typeEnumerated) // "e564"
    public static let pdf128CommentingAllowed = ICCSymbol(name: "pdf128CommentingAllowed", code: 0x65353633, type: typeEnumerated) // "e563"
    public static let pdf128EditPageAllowed = ICCSymbol(name: "pdf128EditPageAllowed", code: 0x65353631, type: typeEnumerated) // "e561"
    public static let pdf128FillFormAllowed = ICCSymbol(name: "pdf128FillFormAllowed", code: 0x65353632, type: typeEnumerated) // "e562"
    public static let pdf128NoChanges = ICCSymbol(name: "pdf128NoChanges", code: 0x65353630, type: typeEnumerated) // "e560"
    public static let pdf128PrintHighRes = ICCSymbol(name: "pdf128PrintHighRes", code: 0x65353532, type: typeEnumerated) // "e552"
    public static let pdf128PrintLowRes = ICCSymbol(name: "pdf128PrintLowRes", code: 0x65353531, type: typeEnumerated) // "e551"
    public static let pdf128PrintNone = ICCSymbol(name: "pdf128PrintNone", code: 0x65353530, type: typeEnumerated) // "e550"
    public static let pdf40AnyChanges = ICCSymbol(name: "pdf40AnyChanges", code: 0x65353638, type: typeEnumerated) // "e568"
    public static let pdf40CommentingAllowed = ICCSymbol(name: "pdf40CommentingAllowed", code: 0x65353636, type: typeEnumerated) // "e566"
    public static let pdf40NoChanges = ICCSymbol(name: "pdf40NoChanges", code: 0x65353635, type: typeEnumerated) // "e565"
    public static let pdf40PageLayoutAllowed = ICCSymbol(name: "pdf40PageLayoutAllowed", code: 0x65353637, type: typeEnumerated) // "e567"
    public static let pdf40PrintHighRes = ICCSymbol(name: "pdf40PrintHighRes", code: 0x65353534, type: typeEnumerated) // "e554"
    public static let pdf40PrintNone = ICCSymbol(name: "pdf40PrintNone", code: 0x65353533, type: typeEnumerated) // "e553"
    public static let PDFArtBox = ICCSymbol(name: "PDFArtBox", code: 0x65504f31, type: typeEnumerated) // "ePO1"
    public static let PDFBleedBox = ICCSymbol(name: "PDFBleedBox", code: 0x65503034, type: typeEnumerated) // "eP04"
    public static let PDFBoundingBox = ICCSymbol(name: "PDFBoundingBox", code: 0x65503036, type: typeEnumerated) // "eP06"
    public static let PDFCropBox = ICCSymbol(name: "PDFCropBox", code: 0x65503032, type: typeEnumerated) // "eP02"
    public static let PDFMediaBox = ICCSymbol(name: "PDFMediaBox", code: 0x65503035, type: typeEnumerated) // "eP05"
    public static let PDFTrimBox = ICCSymbol(name: "PDFTrimBox", code: 0x65503033, type: typeEnumerated) // "eP03"
    public static let PDFX1a2001 = ICCSymbol(name: "PDFX1a2001", code: 0x65506431, type: typeEnumerated) // "ePd1"
    public static let PDFX1a2003 = ICCSymbol(name: "PDFX1a2003", code: 0x65506432, type: typeEnumerated) // "ePd2"
    public static let PDFX32001 = ICCSymbol(name: "PDFX32001", code: 0x65506433, type: typeEnumerated) // "ePd3"
    public static let PDFX32002 = ICCSymbol(name: "PDFX32002", code: 0x65506445, type: typeEnumerated) // "ePdE"
    public static let PDFX32003 = ICCSymbol(name: "PDFX32003", code: 0x65506434, type: typeEnumerated) // "ePd4"
    public static let PDFX42007 = ICCSymbol(name: "PDFX42007", code: 0x65506435, type: typeEnumerated) // "ePd5"
    public static let PDFXNone = ICCSymbol(name: "PDFXNone", code: 0x65506430, type: typeEnumerated) // "ePd0"
    public static let perceptual = ICCSymbol(name: "perceptual", code: 0x65333532, type: typeEnumerated) // "e352"
    public static let Photoshop = ICCSymbol(name: "Photoshop", code: 0x65333331, type: typeEnumerated) // "e331"
    public static let Photoshop6 = ICCSymbol(name: "Photoshop6", code: 0x65323431, type: typeEnumerated) // "e241"
    public static let Photoshop8 = ICCSymbol(name: "Photoshop8", code: 0x65323432, type: typeEnumerated) // "e242"
    public static let picas = ICCSymbol(name: "picas", code: 0x65313835, type: typeEnumerated) // "e185"
    public static let pixelPreview = ICCSymbol(name: "pixelPreview", code: 0x7050504d, type: typeEnumerated) // "pPPM"
    public static let pixels = ICCSymbol(name: "pixels", code: 0x65313838, type: typeEnumerated) // "e188"
    public static let PNG24 = ICCSymbol(name: "PNG24", code: 0x65333334, type: typeEnumerated) // "e334"
    public static let PNG8 = ICCSymbol(name: "PNG8", code: 0x65333333, type: typeEnumerated) // "e333"
    public static let PNGRaster = ICCSymbol(name: "PNGRaster", code: 0x65415230, type: typeEnumerated) // "eAR0"
    public static let points = ICCSymbol(name: "points", code: 0x65313834, type: typeEnumerated) // "e184"
    public static let pointText = ICCSymbol(name: "pointText", code: 0x65303630, type: typeEnumerated) // "e060"
    public static let Polish = ICCSymbol(name: "Polish", code: 0x654c3234, type: typeEnumerated) // "eL24"
    public static let portrait = ICCSymbol(name: "portrait", code: 0x65343931, type: typeEnumerated) // "e491"
    public static let positive = ICCSymbol(name: "positive", code: 0x65613031, type: typeEnumerated) // "ea01"
    public static let PostScriptPrinter = ICCSymbol(name: "PostScriptPrinter", code: 0x65346831, type: typeEnumerated) // "e4h1"
    public static let presentationAttributes = ICCSymbol(name: "presentationAttributes", code: 0x65343133, type: typeEnumerated) // "e413"
    public static let preserve = ICCSymbol(name: "preserve", code: 0x65353430, type: typeEnumerated) // "e540"
    public static let preserveAppearance = ICCSymbol(name: "preserveAppearance", code: 0x65343231, type: typeEnumerated) // "e421"
    public static let preservePaths = ICCSymbol(name: "preservePaths", code: 0x65343230, type: typeEnumerated) // "e420"
    public static let previewPurpose = ICCSymbol(name: "previewPurpose", code: 0x6b505055, type: typeEnumerated) // "kPPU"
    public static let printDocumentPreset = ICCSymbol(name: "printDocumentPreset", code: 0x70505052, type: typeEnumerated) // "pPPR"
    public static let printerProfile = ICCSymbol(name: "printerProfile", code: 0x65346633, type: typeEnumerated) // "e4f3"
    public static let processColor = ICCSymbol(name: "processColor", code: 0x65343236, type: typeEnumerated) // "e426"
    public static let projecting = ICCSymbol(name: "projecting", code: 0x65303232, type: typeEnumerated) // "e022"
    public static let proportional = ICCSymbol(name: "proportional", code: 0x70465333, type: typeEnumerated) // "pFS3"
    public static let proportionalOldstyle = ICCSymbol(name: "proportionalOldstyle", code: 0x70465332, type: typeEnumerated) // "pFS2"
    public static let proportionalWidth = ICCSymbol(name: "proportionalWidth", code: 0x65414570, type: typeEnumerated) // "eAEp"
    public static let punctuation = ICCSymbol(name: "punctuation", code: 0x70756e63, type: typeEnumerated) // "punc"
    public static let Punjabi = ICCSymbol(name: "Punjabi", code: 0x654c3532, type: typeEnumerated) // "eL52"
    public static let purpleTransparencyGrids = ICCSymbol(name: "purpleTransparencyGrids", code: 0x70544750, type: typeEnumerated) // "pTGP"
    public static let pushIn = ICCSymbol(name: "pushIn", code: 0x65504a33, type: typeEnumerated) // "ePJ3"
    public static let pushOutFirst = ICCSymbol(name: "pushOutFirst", code: 0x65504a34, type: typeEnumerated) // "ePJ4"
    public static let pushOutOnly = ICCSymbol(name: "pushOutOnly", code: 0x65504a35, type: typeEnumerated) // "ePJ5"
    public static let qs = ICCSymbol(name: "qs", code: 0x65313837, type: typeEnumerated) // "e187"
    public static let quarterWidth = ICCSymbol(name: "quarterWidth", code: 0x6541456b, type: typeEnumerated) // "eAEk"
    public static let radial = ICCSymbol(name: "radial", code: 0x65303431, type: typeEnumerated) // "e041"
    public static let rasterizeBlends = ICCSymbol(name: "rasterizeBlends", code: 0x65356332, type: typeEnumerated) // "e5c2"
    public static let rasterizeFilters = ICCSymbol(name: "rasterizeFilters", code: 0x65353932, type: typeEnumerated) // "e592"
    public static let rasterizeText = ICCSymbol(name: "rasterizeText", code: 0x65356132, type: typeEnumerated) // "e5a2"
    public static let redColorTransparencyGrids = ICCSymbol(name: "redColorTransparencyGrids", code: 0x70544752, type: typeEnumerated) // "pTGR"
    public static let registrationColor = ICCSymbol(name: "registrationColor", code: 0x65343235, type: typeEnumerated) // "e425"
    public static let regularSvg = ICCSymbol(name: "regularSvg", code: 0x65334331, type: typeEnumerated) // "e3C1"
    public static let relativeColorimetric = ICCSymbol(name: "relativeColorimetric", code: 0x65346732, type: typeEnumerated) // "e4g2"
    public static let reverseLandscape = ICCSymbol(name: "reverseLandscape", code: 0x65343934, type: typeEnumerated) // "e494"
    public static let reversePortrait = ICCSymbol(name: "reversePortrait", code: 0x65343933, type: typeEnumerated) // "e493"
    public static let RGB = ICCSymbol(name: "RGB", code: 0x6552624d, type: typeEnumerated) // "eRbM"
    public static let right_ = ICCSymbol(name: "right_", code: 0x65313233, type: typeEnumerated) // "e123"
    public static let rightplane = ICCSymbol(name: "rightplane", code: 0x65505033, type: typeEnumerated) // "ePP3"
    public static let rightSelected = ICCSymbol(name: "rightSelected", code: 0x65303532, type: typeEnumerated) // "e052"
    public static let RLE = ICCSymbol(name: "RLE", code: 0x65346531, type: typeEnumerated) // "e4e1"
    public static let rlGridByCol = ICCSymbol(name: "rlGridByCol", code: 0x70524743, type: typeEnumerated) // "pRGC"
    public static let rlGridByRow = ICCSymbol(name: "rlGridByRow", code: 0x70524752, type: typeEnumerated) // "pRGR"
    public static let rlRow = ICCSymbol(name: "rlRow", code: 0x70525277, type: typeEnumerated) // "pRRw"
    public static let Roman = ICCSymbol(name: "Roman", code: 0x65414532, type: typeEnumerated) // "eAE2"
    public static let romanBaseline = ICCSymbol(name: "romanBaseline", code: 0x6541456d, type: typeEnumerated) // "eAEm"
    public static let Romanian = ICCSymbol(name: "Romanian", code: 0x654c3235, type: typeEnumerated) // "eL25"
    public static let rotated = ICCSymbol(name: "rotated", code: 0x65313131, type: typeEnumerated) // "e111"
    public static let rounded = ICCSymbol(name: "rounded", code: 0x65303231, type: typeEnumerated) // "e021"
    public static let row = ICCSymbol(name: "row", code: 0x70526f77, type: typeEnumerated) // "pRow"
    public static let runLength = ICCSymbol(name: "runLength", code: 0x65323734, type: typeEnumerated) // "e274"
    public static let Russian = ICCSymbol(name: "Russian", code: 0x654c3139, type: typeEnumerated) // "eL19"
    public static let saturation = ICCSymbol(name: "saturation", code: 0x65346731, type: typeEnumerated) // "e4g1"
    public static let saturationBlend = ICCSymbol(name: "saturationBlend", code: 0x65333133, type: typeEnumerated) // "e313"
    public static let scaleByValue = ICCSymbol(name: "scaleByValue", code: 0x65415332, type: typeEnumerated) // "eAS2"
    public static let screen = ICCSymbol(name: "screen", code: 0x65333032, type: typeEnumerated) // "e302"
    public static let screenResolution = ICCSymbol(name: "screenResolution", code: 0x70535252, type: typeEnumerated) // "pSRR"
    public static let selective = ICCSymbol(name: "selective", code: 0x65333531, type: typeEnumerated) // "e351"
    public static let sentenceCase = ICCSymbol(name: "sentenceCase", code: 0x65414536, type: typeEnumerated) // "eAE6"
    public static let Separation = ICCSymbol(name: "Separation", code: 0x65305350, type: typeEnumerated) // "e0SP"
    public static let Serbian = ICCSymbol(name: "Serbian", code: 0x654c3232, type: typeEnumerated) // "eL22"
    public static let sharp = ICCSymbol(name: "sharp", code: 0x65303633, type: typeEnumerated) // "e063"
    public static let singleFullPage = ICCSymbol(name: "singleFullPage", code: 0x65346130, type: typeEnumerated) // "e4a0"
    public static let smallCaps = ICCSymbol(name: "smallCaps", code: 0x65414537, type: typeEnumerated) // "eAE7"
    public static let smooth = ICCSymbol(name: "smooth", code: 0x65303536, type: typeEnumerated) // "e056"
    public static let softLight = ICCSymbol(name: "softLight", code: 0x65333034, type: typeEnumerated) // "e304"
    public static let sourceProfile = ICCSymbol(name: "sourceProfile", code: 0x65346632, type: typeEnumerated) // "e4f2"
    public static let Spanish = ICCSymbol(name: "Spanish", code: 0x654c3133, type: typeEnumerated) // "eL13"
    public static let spotCmykColor = ICCSymbol(name: "spotCmykColor", code: 0x6b434d59, type: typeEnumerated) // "kCMY"
    public static let spotColor = ICCSymbol(name: "spotColor", code: 0x65343237, type: typeEnumerated) // "e427"
    public static let spotLabColor = ICCSymbol(name: "spotLabColor", code: 0x6b4c4142, type: typeEnumerated) // "kLAB"
    public static let spotRgbColor = ICCSymbol(name: "spotRgbColor", code: 0x6b524742, type: typeEnumerated) // "kRGB"
    public static let standard = ICCSymbol(name: "standard", code: 0x65303830, type: typeEnumerated) // "e080"
    public static let standardFrench = ICCSymbol(name: "standardFrench", code: 0x654c3033, type: typeEnumerated) // "eL03"
    public static let standardGerman = ICCSymbol(name: "standardGerman", code: 0x654c3035, type: typeEnumerated) // "eL05"
    public static let standardPortuguese = ICCSymbol(name: "standardPortuguese", code: 0x654c3131, type: typeEnumerated) // "eL11"
    public static let strong = ICCSymbol(name: "strong", code: 0x65303635, type: typeEnumerated) // "e065"
    public static let styleAttributes = ICCSymbol(name: "styleAttributes", code: 0x65343131, type: typeEnumerated) // "e411"
    public static let styleElements = ICCSymbol(name: "styleElements", code: 0x65343132, type: typeEnumerated) // "e412"
    public static let subsampling = ICCSymbol(name: "subsampling", code: 0x65323932, type: typeEnumerated) // "e292"
    public static let subscript_ = ICCSymbol(name: "subscript_", code: 0x704f5438, type: typeEnumerated) // "pOT8"
    public static let subset = ICCSymbol(name: "subset", code: 0x65346331, type: typeEnumerated) // "e4c1"
    public static let superscript = ICCSymbol(name: "superscript", code: 0x704f5439, type: typeEnumerated) // "pOT9"
    public static let SVG = ICCSymbol(name: "SVG", code: 0x65333332, type: typeEnumerated) // "e332"
    public static let SVG10x2E0 = ICCSymbol(name: "SVG10x2E0", code: 0x65334230, type: typeEnumerated) // "e3B0"
    public static let SVG10x2E1 = ICCSymbol(name: "SVG10x2E1", code: 0x65334231, type: typeEnumerated) // "e3B1"
    public static let SVGBasic10x2E1 = ICCSymbol(name: "SVGBasic10x2E1", code: 0x65334234, type: typeEnumerated) // "e3B4"
    public static let SVGFont = ICCSymbol(name: "SVGFont", code: 0x65334131, type: typeEnumerated) // "e3A1"
    public static let SVGTiny10x2E1 = ICCSymbol(name: "SVGTiny10x2E1", code: 0x65334232, type: typeEnumerated) // "e3B2"
    public static let SVGTiny10x2E1Plus = ICCSymbol(name: "SVGTiny10x2E1Plus", code: 0x65334233, type: typeEnumerated) // "e3B3"
    public static let SVGTiny10x2E2 = ICCSymbol(name: "SVGTiny10x2E2", code: 0x65334235, type: typeEnumerated) // "e3B5"
    public static let swatchesLibrary = ICCSymbol(name: "swatchesLibrary", code: 0x65313936, type: typeEnumerated) // "e196"
    public static let Swedish = ICCSymbol(name: "Swedish", code: 0x654c3134, type: typeEnumerated) // "eL14"
    public static let SWFVersion1 = ICCSymbol(name: "SWFVersion1", code: 0x65465631, type: typeEnumerated) // "eFV1"
    public static let SWFVersion2 = ICCSymbol(name: "SWFVersion2", code: 0x65465632, type: typeEnumerated) // "eFV2"
    public static let SWFVersion3 = ICCSymbol(name: "SWFVersion3", code: 0x65465633, type: typeEnumerated) // "eFV3"
    public static let SWFVersion4 = ICCSymbol(name: "SWFVersion4", code: 0x65465634, type: typeEnumerated) // "eFV4"
    public static let SWFVersion5 = ICCSymbol(name: "SWFVersion5", code: 0x65465635, type: typeEnumerated) // "eFV5"
    public static let SWFVersion6 = ICCSymbol(name: "SWFVersion6", code: 0x65465636, type: typeEnumerated) // "eFV6"
    public static let SWFVersion7 = ICCSymbol(name: "SWFVersion7", code: 0x65465637, type: typeEnumerated) // "eFV7"
    public static let SWFVersion8 = ICCSymbol(name: "SWFVersion8", code: 0x65465638, type: typeEnumerated) // "eFV8"
    public static let SWFVersion9 = ICCSymbol(name: "SWFVersion9", code: 0x65465639, type: typeEnumerated) // "eFV9"
    public static let SwissGerman = ICCSymbol(name: "SwissGerman", code: 0x654c3037, type: typeEnumerated) // "eL07"
    public static let SwissGerman2006Reform = ICCSymbol(name: "SwissGerman2006Reform", code: 0x654c3434, type: typeEnumerated) // "eL44"
    public static let symbolBottomleftPoint = ICCSymbol(name: "symbolBottomleftPoint", code: 0x65535237, type: typeEnumerated) // "eSR7"
    public static let symbolBottommiddlePoint = ICCSymbol(name: "symbolBottommiddlePoint", code: 0x65535238, type: typeEnumerated) // "eSR8"
    public static let symbolBottomrightPoint = ICCSymbol(name: "symbolBottomrightPoint", code: 0x65535239, type: typeEnumerated) // "eSR9"
    public static let symbolCenterPoint = ICCSymbol(name: "symbolCenterPoint", code: 0x65535235, type: typeEnumerated) // "eSR5"
    public static let symbolMiddleleftPoint = ICCSymbol(name: "symbolMiddleleftPoint", code: 0x65535234, type: typeEnumerated) // "eSR4"
    public static let symbolMiddlerightPoint = ICCSymbol(name: "symbolMiddlerightPoint", code: 0x65535236, type: typeEnumerated) // "eSR6"
    public static let symbolsLibrary = ICCSymbol(name: "symbolsLibrary", code: 0x65313939, type: typeEnumerated) // "e199"
    public static let symbolTopleftPoint = ICCSymbol(name: "symbolTopleftPoint", code: 0x65535231, type: typeEnumerated) // "eSR1"
    public static let symbolTopmiddlePoint = ICCSymbol(name: "symbolTopmiddlePoint", code: 0x65535232, type: typeEnumerated) // "eSR2"
    public static let symbolToprightPoint = ICCSymbol(name: "symbolToprightPoint", code: 0x65535233, type: typeEnumerated) // "eSR3"
    public static let tabular = ICCSymbol(name: "tabular", code: 0x70465331, type: typeEnumerated) // "pFS1"
    public static let tabularOldstyle = ICCSymbol(name: "tabularOldstyle", code: 0x70465334, type: typeEnumerated) // "pFS4"
    public static let Tamil = ICCSymbol(name: "Tamil", code: 0x654c3535, type: typeEnumerated) // "eL55"
    public static let TateChuYoko = ICCSymbol(name: "TateChuYoko", code: 0x65414564, type: typeEnumerated) // "eAEd"
    public static let Telugu = ICCSymbol(name: "Telugu", code: 0x654c3536, type: typeEnumerated) // "eL56"
    public static let textual = ICCSymbol(name: "textual", code: 0x65343432, type: typeEnumerated) // "e442"
    public static let thirdWidth = ICCSymbol(name: "thirdWidth", code: 0x6541456a, type: typeEnumerated) // "eAEj"
    public static let TIFF = ICCSymbol(name: "TIFF", code: 0x65333338, type: typeEnumerated) // "e338"
    public static let tintSubstitution = ICCSymbol(name: "tintSubstitution", code: 0x65346432, type: typeEnumerated) // "e4d2"
    public static let titleCase = ICCSymbol(name: "titleCase", code: 0x65414535, type: typeEnumerated) // "eAE5"
    public static let top = ICCSymbol(name: "top", code: 0x65313735, type: typeEnumerated) // "e175"
    public static let topDown = ICCSymbol(name: "topDown", code: 0x65344131, type: typeEnumerated) // "e4A1"
    public static let topLeft = ICCSymbol(name: "topLeft", code: 0x65313732, type: typeEnumerated) // "e172"
    public static let topRight = ICCSymbol(name: "topRight", code: 0x65313738, type: typeEnumerated) // "e178"
    public static let topToTop = ICCSymbol(name: "topToTop", code: 0x65547454, type: typeEnumerated) // "eTtT"
    public static let traditional = ICCSymbol(name: "traditional", code: 0x65414565, type: typeEnumerated) // "eAEe"
    public static let transparent = ICCSymbol(name: "transparent", code: 0x65346c31, type: typeEnumerated) // "e4l1"
    public static let transparentColorTIFF = ICCSymbol(name: "transparentColorTIFF", code: 0x65323135, type: typeEnumerated) // "e215"
    public static let trimmarkweight0125 = ICCSymbol(name: "trimmarkweight0125", code: 0x65353730, type: typeEnumerated) // "e570"
    public static let trimmarkweight025 = ICCSymbol(name: "trimmarkweight025", code: 0x65353731, type: typeEnumerated) // "e571"
    public static let trimmarkweight05 = ICCSymbol(name: "trimmarkweight05", code: 0x65353732, type: typeEnumerated) // "e572"
    public static let trueColors = ICCSymbol(name: "trueColors", code: 0x65414333, type: typeEnumerated) // "eAC3"
    public static let Turkish = ICCSymbol(name: "Turkish", code: 0x654c3237, type: typeEnumerated) // "eL27"
    public static let typeOptimized = ICCSymbol(name: "typeOptimized", code: 0x744f5054, type: typeEnumerated) // "tOPT"
    public static let UKEnglish = ICCSymbol(name: "UKEnglish", code: 0x654c3135, type: typeEnumerated) // "eL15"
    public static let Ukranian = ICCSymbol(name: "Ukranian", code: 0x654c3230, type: typeEnumerated) // "eL20"
    public static let uniqueSvg = ICCSymbol(name: "uniqueSvg", code: 0x65334332, type: typeEnumerated) // "e3C2"
    public static let unknown = ICCSymbol(name: "unknown", code: 0x65313230, type: typeEnumerated) // "e120"
    public static let upperCase = ICCSymbol(name: "upperCase", code: 0x65414533, type: typeEnumerated) // "eAE3"
    public static let useFullColors = ICCSymbol(name: "useFullColors", code: 0x65544366, type: typeEnumerated) // "eTCf"
    public static let useLimitedColors = ICCSymbol(name: "useLimitedColors", code: 0x6554436c, type: typeEnumerated) // "eTCl"
    public static let UTF16 = ICCSymbol(name: "UTF16", code: 0x65343032, type: typeEnumerated) // "e402"
    public static let UTF8 = ICCSymbol(name: "UTF8", code: 0x65343031, type: typeEnumerated) // "e401"
    public static let version10x2E0 = ICCSymbol(name: "version10x2E0", code: 0x65353831, type: typeEnumerated) // "e581"
    public static let version20x2E0 = ICCSymbol(name: "version20x2E0", code: 0x65353832, type: typeEnumerated) // "e582"
    public static let vertical = ICCSymbol(name: "vertical", code: 0x65303731, type: typeEnumerated) // "e071"
    public static let verticalRotated = ICCSymbol(name: "verticalRotated", code: 0x65414563, type: typeEnumerated) // "eAEc"
    public static let verticalTile = ICCSymbol(name: "verticalTile", code: 0x6b415654, type: typeEnumerated) // "kAVT"
    public static let videoDocumentPreset = ICCSymbol(name: "videoDocumentPreset", code: 0x70565052, type: typeEnumerated) // "pVPR"
    public static let viewOutlines = ICCSymbol(name: "viewOutlines", code: 0x65547633, type: typeEnumerated) // "eTv3"
    public static let viewOutlinesWithTracing = ICCSymbol(name: "viewOutlinesWithTracing", code: 0x65547632, type: typeEnumerated) // "eTv2"
    public static let viewOutlinesWithTransparentImage = ICCSymbol(name: "viewOutlinesWithTransparentImage", code: 0x65547634, type: typeEnumerated) // "eTv4"
    public static let viewSourceImage = ICCSymbol(name: "viewSourceImage", code: 0x65547635, type: typeEnumerated) // "eTv5"
    public static let viewTracingResult = ICCSymbol(name: "viewTracingResult", code: 0x65547631, type: typeEnumerated) // "eTv1"
    public static let visibility = ICCSymbol(name: "visibility", code: 0x65343431, type: typeEnumerated) // "e441"
    public static let visibleLayers = ICCSymbol(name: "visibleLayers", code: 0x65343632, type: typeEnumerated) // "e462"
    public static let visiblePrintableLayers = ICCSymbol(name: "visiblePrintableLayers", code: 0x65343631, type: typeEnumerated) // "e461"
    public static let web = ICCSymbol(name: "web", code: 0x65333533, type: typeEnumerated) // "e353"
    public static let webDocumentPreset = ICCSymbol(name: "webDocumentPreset", code: 0x70575052, type: typeEnumerated) // "pWPR"
    public static let whitespace = ICCSymbol(name: "whitespace", code: 0x77686974, type: typeEnumerated) // "whit"
    public static let WOSVG = ICCSymbol(name: "WOSVG", code: 0x65333339, type: typeEnumerated) // "e339"
    public static let yellowInk = ICCSymbol(name: "yellowInk", code: 0x70506d61, type: typeEnumerated) // "pPma"
    public static let yes = ICCSymbol(name: "yes", code: 0x79657320, type: typeEnumerated) // "yes "
    public static let ZIP = ICCSymbol(name: "ZIP", code: 0x65323733, type: typeEnumerated) // "e273"
    public static let ZIP4bit = ICCSymbol(name: "ZIP4bit", code: 0x65323561, type: typeEnumerated) // "e25a"
    public static let ZIP8bit = ICCSymbol(name: "ZIP8bit", code: 0x65323562, type: typeEnumerated) // "e25b"
}

public typealias ICC = ICCSymbol // allows symbols to be written as (e.g.) ICC.name instead of ICCSymbol.name



/******************************************************************************/
// Specifier extensions; these add command methods and property/elements getters based on Adobe Illustrator.app terminology

public protocol ICCCommand: SpecifierProtocol {} // provides AE dispatch methods

// Command->Any will be bound when return type can't be inferred, else Command->T

extension ICCCommand {
    @discardableResult public func activate(_ directParameter: Any = NoParameter,
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
    @discardableResult public func addSpot(_ directParameter: Any = NoParameter,
            spot: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("addSpot", eventClass: 0x4169436c, eventID: 0x6b415370, // "AiCl"/"kASp"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("spot", 0x6b535073, spot), // "kSPs"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func addSpot<T>(_ directParameter: Any = NoParameter,
            spot: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("addSpot", eventClass: 0x4169436c, eventID: 0x6b415370, // "AiCl"/"kASp"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("spot", 0x6b535073, spot), // "kSPs"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func addSwatch(_ directParameter: Any = NoParameter,
            swatch: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("addSwatch", eventClass: 0x4169436c, eventID: 0x6b415368, // "AiCl"/"kASh"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("swatch", 0x6b535774, swatch), // "kSWt"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func addSwatch<T>(_ directParameter: Any = NoParameter,
            swatch: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("addSwatch", eventClass: 0x4169436c, eventID: 0x6b415368, // "AiCl"/"kASh"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("swatch", 0x6b535774, swatch), // "kSWt"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func apply(_ directParameter: Any = NoParameter,
            to: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("apply", eventClass: 0x41525435, eventID: 0x41706c79, // "ART5"/"Aply"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x746f2020, to), // "to  "
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func apply<T>(_ directParameter: Any = NoParameter,
            to: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("apply", eventClass: 0x41525435, eventID: 0x41706c79, // "ART5"/"Aply"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x746f2020, to), // "to  "
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func applyCharacterStyle(_ directParameter: Any = NoParameter,
            to: Any = NoParameter,
            clearingOverrides: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("applyCharacterStyle", eventClass: 0x41695458, eventID: 0x41704353, // "AiTX"/"ApCS"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x746f2020, to), // "to  "
                    ("clearingOverrides", 0x70434c52, clearingOverrides), // "pCLR"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func applyCharacterStyle<T>(_ directParameter: Any = NoParameter,
            to: Any = NoParameter,
            clearingOverrides: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("applyCharacterStyle", eventClass: 0x41695458, eventID: 0x41704353, // "AiTX"/"ApCS"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x746f2020, to), // "to  "
                    ("clearingOverrides", 0x70434c52, clearingOverrides), // "pCLR"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func applyeffect(_ directParameter: Any = NoParameter,
            liveeffectxml: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("applyeffect", eventClass: 0x41525435, eventID: 0x6b416554, // "ART5"/"kAeT"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("liveeffectxml", 0x634c6550, liveeffectxml), // "cLeP"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func applyeffect<T>(_ directParameter: Any = NoParameter,
            liveeffectxml: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("applyeffect", eventClass: 0x41525435, eventID: 0x6b416554, // "ART5"/"kAeT"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("liveeffectxml", 0x634c6550, liveeffectxml), // "cLeP"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func applyParagraphStyle(_ directParameter: Any = NoParameter,
            to: Any = NoParameter,
            clearingOverrides: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("applyParagraphStyle", eventClass: 0x41695458, eventID: 0x41705053, // "AiTX"/"ApPS"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x746f2020, to), // "to  "
                    ("clearingOverrides", 0x70434c52, clearingOverrides), // "pCLR"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func applyParagraphStyle<T>(_ directParameter: Any = NoParameter,
            to: Any = NoParameter,
            clearingOverrides: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("applyParagraphStyle", eventClass: 0x41695458, eventID: 0x41705053, // "AiTX"/"ApPS"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x746f2020, to), // "to  "
                    ("clearingOverrides", 0x70434c52, clearingOverrides), // "pCLR"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func bringInPerspective(_ directParameter: Any = NoParameter,
            positionX: Any = NoParameter,
            positionY: Any = NoParameter,
            perspectiveGridPlane: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("bringInPerspective", eventClass: 0x41525435, eventID: 0x646f4250, // "ART5"/"doBP"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("positionX", 0x70504f58, positionX), // "pPOX"
                    ("positionY", 0x70504f59, positionY), // "pPOY"
                    ("perspectiveGridPlane", 0x50736750, perspectiveGridPlane), // "PsgP"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func bringInPerspective<T>(_ directParameter: Any = NoParameter,
            positionX: Any = NoParameter,
            positionY: Any = NoParameter,
            perspectiveGridPlane: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("bringInPerspective", eventClass: 0x41525435, eventID: 0x646f4250, // "ART5"/"doBP"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("positionX", 0x70504f58, positionX), // "pPOX"
                    ("positionY", 0x70504f59, positionY), // "pPOY"
                    ("perspectiveGridPlane", 0x50736750, perspectiveGridPlane), // "PsgP"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func capture(_ directParameter: Any = NoParameter,
            to: Any = NoParameter,
            size: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("capture", eventClass: 0x41525435, eventID: 0x61495743, // "ART5"/"aIWC"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x746f2020, to), // "to  "
                    ("size", 0x70445753, size), // "pDWS"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func capture<T>(_ directParameter: Any = NoParameter,
            to: Any = NoParameter,
            size: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("capture", eventClass: 0x41525435, eventID: 0x61495743, // "ART5"/"aIWC"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x746f2020, to), // "to  "
                    ("size", 0x70445753, size), // "pDWS"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func changeCase(_ directParameter: Any = NoParameter,
            to: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("changeCase", eventClass: 0x41695458, eventID: 0x70545235, // "AiTX"/"pTR5"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x746f2020, to), // "to  "
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func changeCase<T>(_ directParameter: Any = NoParameter,
            to: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("changeCase", eventClass: 0x41695458, eventID: 0x70545235, // "AiTX"/"pTR5"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x746f2020, to), // "to  "
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func clearStyle(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("clearStyle", eventClass: 0x41695458, eventID: 0x41435053, // "AiTX"/"ACPS"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func clearStyle<T>(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("clearStyle", eventClass: 0x41695458, eventID: 0x41435053, // "AiTX"/"ACPS"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func close(_ directParameter: Any = NoParameter,
            saving: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("close", eventClass: 0x636f7265, eventID: 0x636c6f73, // "core"/"clos"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("saving", 0x7361766f, saving), // "savo"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func close<T>(_ directParameter: Any = NoParameter,
            saving: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("close", eventClass: 0x636f7265, eventID: 0x636c6f73, // "core"/"clos"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("saving", 0x7361766f, saving), // "savo"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func colorize(_ directParameter: Any = NoParameter,
            rasterColor: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("colorize", eventClass: 0x41525435, eventID: 0x6361434d, // "ART5"/"caCM"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("rasterColor", 0x63614358, rasterColor), // "caCX"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func colorize<T>(_ directParameter: Any = NoParameter,
            rasterColor: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("colorize", eventClass: 0x41525435, eventID: 0x6361434d, // "ART5"/"caCM"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("rasterColor", 0x63614358, rasterColor), // "caCX"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func concatenateMatrix(_ directParameter: Any = NoParameter,
            with: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("concatenateMatrix", eventClass: 0x41525478, eventID: 0x63744d58, // "ARTx"/"ctMX"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("with", 0x704d4d58, with), // "pMMX"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func concatenateMatrix<T>(_ directParameter: Any = NoParameter,
            with: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("concatenateMatrix", eventClass: 0x41525478, eventID: 0x63744d58, // "ARTx"/"ctMX"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("with", 0x704d4d58, with), // "pMMX"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func concatenateRotationMatrix(_ directParameter: Any = NoParameter,
            angle: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("concatenateRotationMatrix", eventClass: 0x41525478, eventID: 0x6374524d, // "ARTx"/"ctRM"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("angle", 0x7041474c, angle), // "pAGL"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func concatenateRotationMatrix<T>(_ directParameter: Any = NoParameter,
            angle: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("concatenateRotationMatrix", eventClass: 0x41525478, eventID: 0x6374524d, // "ARTx"/"ctRM"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("angle", 0x7041474c, angle), // "pAGL"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func concatenateScaleMatrix(_ directParameter: Any = NoParameter,
            horizontalScale: Any = NoParameter,
            verticalScale: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("concatenateScaleMatrix", eventClass: 0x41525478, eventID: 0x6374534d, // "ARTx"/"ctSM"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("horizontalScale", 0x70535858, horizontalScale), // "pSXX"
                    ("verticalScale", 0x70535959, verticalScale), // "pSYY"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func concatenateScaleMatrix<T>(_ directParameter: Any = NoParameter,
            horizontalScale: Any = NoParameter,
            verticalScale: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("concatenateScaleMatrix", eventClass: 0x41525478, eventID: 0x6374534d, // "ARTx"/"ctSM"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("horizontalScale", 0x70535858, horizontalScale), // "pSXX"
                    ("verticalScale", 0x70535959, verticalScale), // "pSYY"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func concatenateTranslationMatrix(_ directParameter: Any = NoParameter,
            deltaX: Any = NoParameter,
            deltaY: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("concatenateTranslationMatrix", eventClass: 0x41525478, eventID: 0x6374584d, // "ARTx"/"ctXM"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("deltaX", 0x70445858, deltaX), // "pDXX"
                    ("deltaY", 0x70445959, deltaY), // "pDYY"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func concatenateTranslationMatrix<T>(_ directParameter: Any = NoParameter,
            deltaX: Any = NoParameter,
            deltaY: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("concatenateTranslationMatrix", eventClass: 0x41525478, eventID: 0x6374584d, // "ARTx"/"ctXM"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("deltaX", 0x70445858, deltaX), // "pDXX"
                    ("deltaY", 0x70445959, deltaY), // "pDYY"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func convert(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("convert", eventClass: 0x41695458, eventID: 0x43744e54, // "AiTX"/"CtNT"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func convert<T>(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("convert", eventClass: 0x41695458, eventID: 0x43744e54, // "AiTX"/"CtNT"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func convertAreaObjectToPointObject(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("convertAreaObjectToPointObject", eventClass: 0x41695458, eventID: 0x43415450, // "AiTX"/"CATP"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func convertAreaObjectToPointObject<T>(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("convertAreaObjectToPointObject", eventClass: 0x41695458, eventID: 0x43415450, // "AiTX"/"CATP"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func convertcoordinate(_ directParameter: Any = NoParameter,
            coordinate: Any = NoParameter,
            source: Any = NoParameter,
            destination: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("convertcoordinate", eventClass: 0x41525435, eventID: 0x43636f64, // "ART5"/"Ccod"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("coordinate", 0x436f7264, coordinate), // "Cord"
                    ("source", 0x53436f53, source), // "SCoS"
                    ("destination", 0x44436f53, destination), // "DCoS"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func convertcoordinate<T>(_ directParameter: Any = NoParameter,
            coordinate: Any = NoParameter,
            source: Any = NoParameter,
            destination: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("convertcoordinate", eventClass: 0x41525435, eventID: 0x43636f64, // "ART5"/"Ccod"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("coordinate", 0x436f7264, coordinate), // "Cord"
                    ("source", 0x53436f53, source), // "SCoS"
                    ("destination", 0x44436f53, destination), // "DCoS"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func convertPointObjectToAreaObject(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("convertPointObjectToAreaObject", eventClass: 0x41695458, eventID: 0x43505441, // "AiTX"/"CPTA"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func convertPointObjectToAreaObject<T>(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("convertPointObjectToAreaObject", eventClass: 0x41695458, eventID: 0x43505441, // "AiTX"/"CPTA"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func convertSampleColor(_ directParameter: Any = NoParameter,
            sourceColorSpace: Any = NoParameter,
            sourceColor: Any = NoParameter,
            destinationColorSpace: Any = NoParameter,
            colorConversionPurpose: Any = NoParameter,
            sourceHasAlpha: Any = NoParameter,
            destinationHasAlpha: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("convertSampleColor", eventClass: 0x4169436c, eventID: 0x61435343, // "AiCl"/"aCSC"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("sourceColorSpace", 0x70534353, sourceColorSpace), // "pSCS"
                    ("sourceColor", 0x7053434c, sourceColor), // "pSCL"
                    ("destinationColorSpace", 0x70444353, destinationColorSpace), // "pDCS"
                    ("colorConversionPurpose", 0x7043434f, colorConversionPurpose), // "pCCO"
                    ("sourceHasAlpha", 0x70534841, sourceHasAlpha), // "pSHA"
                    ("destinationHasAlpha", 0x70444841, destinationHasAlpha), // "pDHA"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func convertSampleColor<T>(_ directParameter: Any = NoParameter,
            sourceColorSpace: Any = NoParameter,
            sourceColor: Any = NoParameter,
            destinationColorSpace: Any = NoParameter,
            colorConversionPurpose: Any = NoParameter,
            sourceHasAlpha: Any = NoParameter,
            destinationHasAlpha: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("convertSampleColor", eventClass: 0x4169436c, eventID: 0x61435343, // "AiCl"/"aCSC"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("sourceColorSpace", 0x70534353, sourceColorSpace), // "pSCS"
                    ("sourceColor", 0x7053434c, sourceColor), // "pSCL"
                    ("destinationColorSpace", 0x70444353, destinationColorSpace), // "pDCS"
                    ("colorConversionPurpose", 0x7043434f, colorConversionPurpose), // "pCCO"
                    ("sourceHasAlpha", 0x70534841, sourceHasAlpha), // "pSHA"
                    ("destinationHasAlpha", 0x70444841, destinationHasAlpha), // "pDHA"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func convertToPaths(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("convertToPaths", eventClass: 0x41695458, eventID: 0x45585044, // "AiTX"/"EXPD"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func convertToPaths<T>(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("convertToPaths", eventClass: 0x41695458, eventID: 0x45585044, // "AiTX"/"EXPD"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func copy(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("copy", eventClass: 0x6d697363, eventID: 0x636f7079, // "misc"/"copy"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func copy<T>(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("copy", eventClass: 0x6d697363, eventID: 0x636f7079, // "misc"/"copy"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func count(_ directParameter: Any = NoParameter,
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
    @discardableResult public func cut(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("cut", eventClass: 0x6d697363, eventID: 0x63757420, // "misc"/"cut "
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func cut<T>(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("cut", eventClass: 0x6d697363, eventID: 0x63757420, // "misc"/"cut "
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func delete(_ directParameter: Any = NoParameter,
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
    @discardableResult public func deletePreference(_ directParameter: Any = NoParameter,
            key: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("deletePreference", eventClass: 0x636f7265, eventID: 0x70445046, // "core"/"pDPF"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("key", 0x7052464b, key), // "pRFK"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func deletePreference<T>(_ directParameter: Any = NoParameter,
            key: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("deletePreference", eventClass: 0x636f7265, eventID: 0x70445046, // "core"/"pDPF"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("key", 0x7052464b, key), // "pRFK"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func deleteWorkspace(_ directParameter: Any = NoParameter,
            workspaceName: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("deleteWorkspace", eventClass: 0x41525435, eventID: 0x6b414457, // "ART5"/"kADW"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("workspaceName", 0x7057734e, workspaceName), // "pWsN"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func deleteWorkspace<T>(_ directParameter: Any = NoParameter,
            workspaceName: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("deleteWorkspace", eventClass: 0x41525435, eventID: 0x6b414457, // "ART5"/"kADW"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("workspaceName", 0x7057734e, workspaceName), // "pWsN"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func deselect(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("deselect", eventClass: 0x41695458, eventID: 0x70545232, // "AiTX"/"pTR2"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func deselect<T>(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("deselect", eventClass: 0x41695458, eventID: 0x70545232, // "AiTX"/"pTR2"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func display(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("display", eventClass: 0x41694450, eventID: 0x6d445350, // "AiDP"/"mDSP"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func display<T>(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("display", eventClass: 0x41694450, eventID: 0x6d445350, // "AiDP"/"mDSP"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func doJavascript(_ directParameter: Any = NoParameter,
            withArguments: Any = NoParameter,
            showDebugger: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("doJavascript", eventClass: 0x6d697363, eventID: 0x446a784d, // "misc"/"DjxM"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("withArguments", 0x4a417267, withArguments), // "JArg"
                    ("showDebugger", 0x4a584d64, showDebugger), // "JXMd"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func doJavascript<T>(_ directParameter: Any = NoParameter,
            withArguments: Any = NoParameter,
            showDebugger: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("doJavascript", eventClass: 0x6d697363, eventID: 0x446a784d, // "misc"/"DjxM"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("withArguments", 0x4a417267, withArguments), // "JArg"
                    ("showDebugger", 0x4a584d64, showDebugger), // "JXMd"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func doScript(_ directParameter: Any = NoParameter,
            from: Any = NoParameter,
            dialogs: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("doScript", eventClass: 0x6d697363, eventID: 0x646f7363, // "misc"/"dosc"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("from", 0x66726f6d, from), // "from"
                    ("dialogs", 0x444c4f47, dialogs), // "DLOG"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func doScript<T>(_ directParameter: Any = NoParameter,
            from: Any = NoParameter,
            dialogs: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("doScript", eventClass: 0x6d697363, eventID: 0x646f7363, // "misc"/"dosc"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("from", 0x66726f6d, from), // "from"
                    ("dialogs", 0x444c4f47, dialogs), // "DLOG"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func duplicate(_ directParameter: Any = NoParameter,
            to: Any = NoParameter,
            withProperties: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("duplicate", eventClass: 0x636f7265, eventID: 0x636c6f6e, // "core"/"clon"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x696e7368, to), // "insh"
                    ("withProperties", 0x70726474, withProperties), // "prdt"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func duplicate<T>(_ directParameter: Any = NoParameter,
            to: Any = NoParameter,
            withProperties: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("duplicate", eventClass: 0x636f7265, eventID: 0x636c6f6e, // "core"/"clon"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x696e7368, to), // "insh"
                    ("withProperties", 0x70726474, withProperties), // "prdt"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func embed(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("embed", eventClass: 0x41525435, eventID: 0x70456d62, // "ART5"/"pEmb"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func embed<T>(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("embed", eventClass: 0x41525435, eventID: 0x70456d62, // "ART5"/"pEmb"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func equalMatrices(_ directParameter: Any = NoParameter,
            with: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("equalMatrices", eventClass: 0x41525478, eventID: 0x6973454d, // "ARTx"/"isEM"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("with", 0x704d4d58, with), // "pMMX"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func equalMatrices<T>(_ directParameter: Any = NoParameter,
            with: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("equalMatrices", eventClass: 0x41525478, eventID: 0x6973454d, // "ARTx"/"isEM"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("with", 0x704d4d58, with), // "pMMX"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func executeAATFile(_ directParameter: Any = NoParameter,
            file: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("executeAATFile", eventClass: 0x41694353, eventID: 0x466c4578, // "AiCS"/"FlEx"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("file", 0x53734944, file), // "SsID"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func executeAATFile<T>(_ directParameter: Any = NoParameter,
            file: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("executeAATFile", eventClass: 0x41694353, eventID: 0x466c4578, // "AiCS"/"FlEx"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("file", 0x53734944, file), // "SsID"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func executeMenuCommand(_ directParameter: Any = NoParameter,
            menuCommandString: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("executeMenuCommand", eventClass: 0x6d697363, eventID: 0x61454d43, // "misc"/"aEMC"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("menuCommandString", 0x704d4353, menuCommandString), // "pMCS"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func executeMenuCommand<T>(_ directParameter: Any = NoParameter,
            menuCommandString: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("executeMenuCommand", eventClass: 0x6d697363, eventID: 0x61454d43, // "misc"/"aEMC"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("menuCommandString", 0x704d4353, menuCommandString), // "pMCS"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func exists(_ directParameter: Any = NoParameter,
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
    @discardableResult public func expandTracing(_ directParameter: Any = NoParameter,
            viewed: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("expandTracing", eventClass: 0x41694972, eventID: 0x74724558, // "AiIr"/"trEX"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("viewed", 0x56455744, viewed), // "VEWD"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func expandTracing<T>(_ directParameter: Any = NoParameter,
            viewed: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("expandTracing", eventClass: 0x41694972, eventID: 0x74724558, // "AiIr"/"trEX"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("viewed", 0x56455744, viewed), // "VEWD"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func export(_ directParameter: Any = NoParameter,
            to: Any = NoParameter,
            as_: Any = NoParameter,
            withOptions: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("export", eventClass: 0x41525435, eventID: 0x45446f63, // "ART5"/"EDoc"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x746f2020, to), // "to  "
                    ("as_", 0x666c7470, as_), // "fltp"
                    ("withOptions", 0x7053666f, withOptions), // "pSfo"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func export<T>(_ directParameter: Any = NoParameter,
            to: Any = NoParameter,
            as_: Any = NoParameter,
            withOptions: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("export", eventClass: 0x41525435, eventID: 0x45446f63, // "ART5"/"EDoc"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x746f2020, to), // "to  "
                    ("as_", 0x666c7470, as_), // "fltp"
                    ("withOptions", 0x7053666f, withOptions), // "pSfo"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func exportPDFPreset(_ directParameter: Any = NoParameter,
            to: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("exportPDFPreset", eventClass: 0x4169536f, eventID: 0x61455153, // "AiSo"/"aEQS"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x746f2020, to), // "to  "
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func exportPDFPreset<T>(_ directParameter: Any = NoParameter,
            to: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("exportPDFPreset", eventClass: 0x4169536f, eventID: 0x61455153, // "AiSo"/"aEQS"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x746f2020, to), // "to  "
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func exportPerspectiveGridPreset(_ directParameter: Any = NoParameter,
            to: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("exportPerspectiveGridPreset", eventClass: 0x41525435, eventID: 0x50657050, // "ART5"/"PepP"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x746f2020, to), // "to  "
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func exportPerspectiveGridPreset<T>(_ directParameter: Any = NoParameter,
            to: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("exportPerspectiveGridPreset", eventClass: 0x41525435, eventID: 0x50657050, // "ART5"/"PepP"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x746f2020, to), // "to  "
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func exportPrintPreset(_ directParameter: Any = NoParameter,
            to: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("exportPrintPreset", eventClass: 0x41695072, eventID: 0x61455053, // "AiPr"/"aEPS"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x746f2020, to), // "to  "
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func exportPrintPreset<T>(_ directParameter: Any = NoParameter,
            to: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("exportPrintPreset", eventClass: 0x41695072, eventID: 0x61455053, // "AiPr"/"aEPS"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x746f2020, to), // "to  "
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func exportSelectedArtwork(_ directParameter: Any = NoParameter,
            to: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("exportSelectedArtwork", eventClass: 0x41525435, eventID: 0x45536541, // "ART5"/"ESeA"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x746f2020, to), // "to  "
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func exportSelectedArtwork<T>(_ directParameter: Any = NoParameter,
            to: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("exportSelectedArtwork", eventClass: 0x41525435, eventID: 0x45536541, // "ART5"/"ESeA"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x746f2020, to), // "to  "
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func exportSelection(_ directParameter: Any = NoParameter,
            to: Any = NoParameter,
            withPNG24Options: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("exportSelection", eventClass: 0x41525435, eventID: 0x4553656c, // "ART5"/"ESel"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x746f2020, to), // "to  "
                    ("withPNG24Options", 0x7050454f, withPNG24Options), // "pPEO"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func exportSelection<T>(_ directParameter: Any = NoParameter,
            to: Any = NoParameter,
            withPNG24Options: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("exportSelection", eventClass: 0x41525435, eventID: 0x4553656c, // "ART5"/"ESel"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x746f2020, to), // "to  "
                    ("withPNG24Options", 0x7050454f, withPNG24Options), // "pPEO"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func exportVariables(_ directParameter: Any = NoParameter,
            to: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("exportVariables", eventClass: 0x41694450, eventID: 0x61694556, // "AiDP"/"aiEV"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x746f2020, to), // "to  "
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func exportVariables<T>(_ directParameter: Any = NoParameter,
            to: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("exportVariables", eventClass: 0x41694450, eventID: 0x61694556, // "AiDP"/"aiEV"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x746f2020, to), // "to  "
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func fitartboardtoselectedart(_ directParameter: Any = NoParameter,
            index: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("fitartboardtoselectedart", eventClass: 0x41525435, eventID: 0x55615341, // "ART5"/"UaSA"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("index", 0x70416249, index), // "pAbI"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func fitartboardtoselectedart<T>(_ directParameter: Any = NoParameter,
            index: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("fitartboardtoselectedart", eventClass: 0x41525435, eventID: 0x55615341, // "ART5"/"UaSA"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("index", 0x70416249, index), // "pAbI"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func generateThumbnailWithTextFrameProperties(_ directParameter: Any = NoParameter,
            textString: Any = NoParameter,
            fontSize: Any = NoParameter,
            textColor: Any = NoParameter,
            destinationPath: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("generateThumbnailWithTextFrameProperties", eventClass: 0x41695458, eventID: 0x47544650, // "AiTX"/"GTFP"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("textString", 0x54585453, textString), // "TXTS"
                    ("fontSize", 0x46535a45, fontSize), // "FSZE"
                    ("textColor", 0x54434f4c, textColor), // "TCOL"
                    ("destinationPath", 0x44504154, destinationPath), // "DPAT"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func generateThumbnailWithTextFrameProperties<T>(_ directParameter: Any = NoParameter,
            textString: Any = NoParameter,
            fontSize: Any = NoParameter,
            textColor: Any = NoParameter,
            destinationPath: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("generateThumbnailWithTextFrameProperties", eventClass: 0x41695458, eventID: 0x47544650, // "AiTX"/"GTFP"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("textString", 0x54585453, textString), // "TXTS"
                    ("fontSize", 0x46535a45, fontSize), // "FSZE"
                    ("textColor", 0x54434f4c, textColor), // "TCOL"
                    ("destinationPath", 0x44504154, destinationPath), // "DPAT"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func get(_ directParameter: Any = NoParameter,
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
    @discardableResult public func getAllSwatches(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("getAllSwatches", eventClass: 0x4169436c, eventID: 0x6b474173, // "AiCl"/"kGAs"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func getAllSwatches<T>(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("getAllSwatches", eventClass: 0x4169436c, eventID: 0x6b474173, // "AiCl"/"kGAs"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func getBooleanPreference(_ directParameter: Any = NoParameter,
            key: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("getBooleanPreference", eventClass: 0x636f7265, eventID: 0x70504633, // "core"/"pPF3"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("key", 0x7052464b, key), // "pRFK"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func getBooleanPreference<T>(_ directParameter: Any = NoParameter,
            key: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("getBooleanPreference", eventClass: 0x636f7265, eventID: 0x70504633, // "core"/"pPF3"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("key", 0x7052464b, key), // "pRFK"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func getIdentityMatrix(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("getIdentityMatrix", eventClass: 0x41525478, eventID: 0x6774494d, // "ARTx"/"gtIM"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func getIdentityMatrix<T>(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("getIdentityMatrix", eventClass: 0x41525478, eventID: 0x6774494d, // "ARTx"/"gtIM"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func getIntegerPreference(_ directParameter: Any = NoParameter,
            key: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("getIntegerPreference", eventClass: 0x636f7265, eventID: 0x70504635, // "core"/"pPF5"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("key", 0x7052464b, key), // "pRFK"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func getIntegerPreference<T>(_ directParameter: Any = NoParameter,
            key: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("getIntegerPreference", eventClass: 0x636f7265, eventID: 0x70504635, // "core"/"pPF5"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("key", 0x7052464b, key), // "pRFK"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func getInternalColor(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("getInternalColor", eventClass: 0x4169436c, eventID: 0x6b474963, // "AiCl"/"kGIc"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func getInternalColor<T>(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("getInternalColor", eventClass: 0x4169436c, eventID: 0x6b474963, // "AiCl"/"kGIc"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func getPerspectiveActivePlane(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("getPerspectiveActivePlane", eventClass: 0x41525435, eventID: 0x50676150, // "ART5"/"PgaP"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func getPerspectiveActivePlane<T>(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("getPerspectiveActivePlane", eventClass: 0x41525435, eventID: 0x50676150, // "ART5"/"PgaP"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func getPPDInfo(_ directParameter: Any = NoParameter,
            for_: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("getPPDInfo", eventClass: 0x41694353, eventID: 0x70504454, // "AiCS"/"pPDT"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("for_", 0x666f7220, for_), // "for "
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func getPPDInfo<T>(_ directParameter: Any = NoParameter,
            for_: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("getPPDInfo", eventClass: 0x41694353, eventID: 0x70504454, // "AiCS"/"pPDT"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("for_", 0x666f7220, for_), // "for "
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func getPresetFileOf(_ directParameter: Any = NoParameter,
            presetType: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("getPresetFileOf", eventClass: 0x6d697363, eventID: 0x61475046, // "misc"/"aGPF"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("presetType", 0x70445054, presetType), // "pDPT"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func getPresetFileOf<T>(_ directParameter: Any = NoParameter,
            presetType: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("getPresetFileOf", eventClass: 0x6d697363, eventID: 0x61475046, // "misc"/"aGPF"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("presetType", 0x70445054, presetType), // "pDPT"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func getPresetSettings(_ directParameter: Any = NoParameter,
            preset: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("getPresetSettings", eventClass: 0x6d697363, eventID: 0x61475053, // "misc"/"aGPS"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("preset", 0x746f5072, preset), // "toPr"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func getPresetSettings<T>(_ directParameter: Any = NoParameter,
            preset: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("getPresetSettings", eventClass: 0x6d697363, eventID: 0x61475053, // "misc"/"aGPS"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("preset", 0x746f5072, preset), // "toPr"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func getRealPreference(_ directParameter: Any = NoParameter,
            key: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("getRealPreference", eventClass: 0x636f7265, eventID: 0x70504637, // "core"/"pPF7"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("key", 0x7052464b, key), // "pRFK"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func getRealPreference<T>(_ directParameter: Any = NoParameter,
            key: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("getRealPreference", eventClass: 0x636f7265, eventID: 0x70504637, // "core"/"pPF7"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("key", 0x7052464b, key), // "pRFK"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func getRotationMatrix(_ directParameter: Any = NoParameter,
            angle: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("getRotationMatrix", eventClass: 0x41525478, eventID: 0x6765524d, // "ARTx"/"geRM"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("angle", 0x7041474c, angle), // "pAGL"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func getRotationMatrix<T>(_ directParameter: Any = NoParameter,
            angle: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("getRotationMatrix", eventClass: 0x41525478, eventID: 0x6765524d, // "ARTx"/"geRM"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("angle", 0x7041474c, angle), // "pAGL"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func getScaleMatrix(_ directParameter: Any = NoParameter,
            horizontalScale: Any = NoParameter,
            verticalScale: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("getScaleMatrix", eventClass: 0x41525478, eventID: 0x6765534d, // "ARTx"/"geSM"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("horizontalScale", 0x70535858, horizontalScale), // "pSXX"
                    ("verticalScale", 0x70535959, verticalScale), // "pSYY"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func getScaleMatrix<T>(_ directParameter: Any = NoParameter,
            horizontalScale: Any = NoParameter,
            verticalScale: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("getScaleMatrix", eventClass: 0x41525478, eventID: 0x6765534d, // "ARTx"/"geSM"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("horizontalScale", 0x70535858, horizontalScale), // "pSXX"
                    ("verticalScale", 0x70535959, verticalScale), // "pSYY"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func getScriptableHelpGroup(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("getScriptableHelpGroup", eventClass: 0x41525435, eventID: 0x61534847, // "ART5"/"aSHG"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func getScriptableHelpGroup<T>(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("getScriptableHelpGroup", eventClass: 0x41525435, eventID: 0x61534847, // "ART5"/"aSHG"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func getStringPreference(_ directParameter: Any = NoParameter,
            key: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("getStringPreference", eventClass: 0x636f7265, eventID: 0x70504639, // "core"/"pPF9"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("key", 0x7052464b, key), // "pRFK"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func getStringPreference<T>(_ directParameter: Any = NoParameter,
            key: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("getStringPreference", eventClass: 0x636f7265, eventID: 0x70504639, // "core"/"pPF9"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("key", 0x7052464b, key), // "pRFK"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func getTranslationMatrix(_ directParameter: Any = NoParameter,
            deltaX: Any = NoParameter,
            deltaY: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("getTranslationMatrix", eventClass: 0x41525478, eventID: 0x6765584d, // "ARTx"/"geXM"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("deltaX", 0x70445858, deltaX), // "pDXX"
                    ("deltaY", 0x70445959, deltaY), // "pDYY"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func getTranslationMatrix<T>(_ directParameter: Any = NoParameter,
            deltaX: Any = NoParameter,
            deltaY: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("getTranslationMatrix", eventClass: 0x41525478, eventID: 0x6765584d, // "ARTx"/"geXM"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("deltaX", 0x70445858, deltaX), // "pDXX"
                    ("deltaY", 0x70445959, deltaY), // "pDYY"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func hidePerspectiveGrid(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("hidePerspectiveGrid", eventClass: 0x41525435, eventID: 0x50687047, // "ART5"/"PhpG"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func hidePerspectiveGrid<T>(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("hidePerspectiveGrid", eventClass: 0x41525435, eventID: 0x50687047, // "ART5"/"PhpG"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func importCharacterStyles(_ directParameter: Any = NoParameter,
            from: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("importCharacterStyles", eventClass: 0x41695458, eventID: 0x61694943, // "AiTX"/"aiIC"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("from", 0x66726f6d, from), // "from"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func importCharacterStyles<T>(_ directParameter: Any = NoParameter,
            from: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("importCharacterStyles", eventClass: 0x41695458, eventID: 0x61694943, // "AiTX"/"aiIC"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("from", 0x66726f6d, from), // "from"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func importFile(_ directParameter: Any = NoParameter,
            from: Any = NoParameter,
            isLinked: Any = NoParameter,
            libraryName: Any = NoParameter,
            itemName: Any = NoParameter,
            elementRef: Any = NoParameter,
            modifiedTime: Any = NoParameter,
            creationTime: Any = NoParameter,
            adobeStockId: Any = NoParameter,
            adobeStockLicense: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("importFile", eventClass: 0x41525435, eventID: 0x4946696c, // "ART5"/"IFil"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("from", 0x746f2020, from), // "to  "
                    ("isLinked", 0x4b494c4c, isLinked), // "KILL"
                    ("libraryName", 0x4b414c4e, libraryName), // "KALN"
                    ("itemName", 0x6b41494e, itemName), // "kAIN"
                    ("elementRef", 0x6b414552, elementRef), // "kAER"
                    ("modifiedTime", 0x4b414d54, modifiedTime), // "KAMT"
                    ("creationTime", 0x6b414354, creationTime), // "kACT"
                    ("adobeStockId", 0x41534944, adobeStockId), // "ASID"
                    ("adobeStockLicense", 0x6b41534c, adobeStockLicense), // "kASL"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func importFile<T>(_ directParameter: Any = NoParameter,
            from: Any = NoParameter,
            isLinked: Any = NoParameter,
            libraryName: Any = NoParameter,
            itemName: Any = NoParameter,
            elementRef: Any = NoParameter,
            modifiedTime: Any = NoParameter,
            creationTime: Any = NoParameter,
            adobeStockId: Any = NoParameter,
            adobeStockLicense: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("importFile", eventClass: 0x41525435, eventID: 0x4946696c, // "ART5"/"IFil"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("from", 0x746f2020, from), // "to  "
                    ("isLinked", 0x4b494c4c, isLinked), // "KILL"
                    ("libraryName", 0x4b414c4e, libraryName), // "KALN"
                    ("itemName", 0x6b41494e, itemName), // "kAIN"
                    ("elementRef", 0x6b414552, elementRef), // "kAER"
                    ("modifiedTime", 0x4b414d54, modifiedTime), // "KAMT"
                    ("creationTime", 0x6b414354, creationTime), // "kACT"
                    ("adobeStockId", 0x41534944, adobeStockId), // "ASID"
                    ("adobeStockLicense", 0x6b41534c, adobeStockLicense), // "kASL"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func importParagraphStyles(_ directParameter: Any = NoParameter,
            from: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("importParagraphStyles", eventClass: 0x41695458, eventID: 0x61694950, // "AiTX"/"aiIP"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("from", 0x66726f6d, from), // "from"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func importParagraphStyles<T>(_ directParameter: Any = NoParameter,
            from: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("importParagraphStyles", eventClass: 0x41695458, eventID: 0x61694950, // "AiTX"/"aiIP"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("from", 0x66726f6d, from), // "from"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func importPDFPreset(_ directParameter: Any = NoParameter,
            from: Any = NoParameter,
            replacingPreset: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("importPDFPreset", eventClass: 0x4169536f, eventID: 0x61495153, // "AiSo"/"aIQS"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("from", 0x66726f6d, from), // "from"
                    ("replacingPreset", 0x65525065, replacingPreset), // "eRPe"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func importPDFPreset<T>(_ directParameter: Any = NoParameter,
            from: Any = NoParameter,
            replacingPreset: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("importPDFPreset", eventClass: 0x4169536f, eventID: 0x61495153, // "AiSo"/"aIQS"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("from", 0x66726f6d, from), // "from"
                    ("replacingPreset", 0x65525065, replacingPreset), // "eRPe"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func importPerspectiveGridPreset(_ directParameter: Any = NoParameter,
            from: Any = NoParameter,
            perspectivePreset: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("importPerspectiveGridPreset", eventClass: 0x41525435, eventID: 0x50697050, // "ART5"/"PipP"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("from", 0x66726f6d, from), // "from"
                    ("perspectivePreset", 0x5072506e, perspectivePreset), // "PrPn"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func importPerspectiveGridPreset<T>(_ directParameter: Any = NoParameter,
            from: Any = NoParameter,
            perspectivePreset: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("importPerspectiveGridPreset", eventClass: 0x41525435, eventID: 0x50697050, // "ART5"/"PipP"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("from", 0x66726f6d, from), // "from"
                    ("perspectivePreset", 0x5072506e, perspectivePreset), // "PrPn"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func importPrintPreset(_ directParameter: Any = NoParameter,
            printPreset: Any = NoParameter,
            from: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("importPrintPreset", eventClass: 0x41695072, eventID: 0x61495053, // "AiPr"/"aIPS"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("printPreset", 0x74505354, printPreset), // "tPST"
                    ("from", 0x66726f6d, from), // "from"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func importPrintPreset<T>(_ directParameter: Any = NoParameter,
            printPreset: Any = NoParameter,
            from: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("importPrintPreset", eventClass: 0x41695072, eventID: 0x61495053, // "AiPr"/"aIPS"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("printPreset", 0x74505354, printPreset), // "tPST"
                    ("from", 0x66726f6d, from), // "from"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func importVariables(_ directParameter: Any = NoParameter,
            from: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("importVariables", eventClass: 0x41694450, eventID: 0x61694956, // "AiDP"/"aiIV"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("from", 0x66726f6d, from), // "from"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func importVariables<T>(_ directParameter: Any = NoParameter,
            from: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("importVariables", eventClass: 0x41694450, eventID: 0x61694956, // "AiDP"/"aiIV"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("from", 0x66726f6d, from), // "from"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func invertMatrix(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("invertMatrix", eventClass: 0x41525478, eventID: 0x494e566d, // "ARTx"/"INVm"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func invertMatrix<T>(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("invertMatrix", eventClass: 0x41525478, eventID: 0x494e566d, // "ARTx"/"INVm"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func isFillActive(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("isFillActive", eventClass: 0x6d697363, eventID: 0x6b464163, // "misc"/"kFAc"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func isFillActive<T>(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("isFillActive", eventClass: 0x6d697363, eventID: 0x6b464163, // "misc"/"kFAc"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func ISInTouchWorkspace(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("ISInTouchWorkspace", eventClass: 0x41525435, eventID: 0x6b495457, // "ART5"/"kITW"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func ISInTouchWorkspace<T>(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("ISInTouchWorkspace", eventClass: 0x41525435, eventID: 0x6b495457, // "ART5"/"kITW"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func isStrokeActive(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("isStrokeActive", eventClass: 0x6d697363, eventID: 0x6b534163, // "misc"/"kSAc"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func isStrokeActive<T>(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("isStrokeActive", eventClass: 0x6d697363, eventID: 0x6b534163, // "misc"/"kSAc"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func isusersharingappusagedata(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("isusersharingappusagedata", eventClass: 0x41525435, eventID: 0x6b415544, // "ART5"/"kAUD"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func isusersharingappusagedata<T>(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("isusersharingappusagedata", eventClass: 0x41525435, eventID: 0x6b415544, // "ART5"/"kAUD"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func launch(_ directParameter: Any = NoParameter,
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
    @discardableResult public func loadAction(_ directParameter: Any = NoParameter,
            actionFilePath: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("loadAction", eventClass: 0x6d697363, eventID: 0x614c4146, // "misc"/"aLAF"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("actionFilePath", 0x70414650, actionFilePath), // "pAFP"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func loadAction<T>(_ directParameter: Any = NoParameter,
            actionFilePath: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("loadAction", eventClass: 0x6d697363, eventID: 0x614c4146, // "misc"/"aLAF"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("actionFilePath", 0x70414650, actionFilePath), // "pAFP"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func loadColorSettings(_ directParameter: Any = NoParameter,
            from: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("loadColorSettings", eventClass: 0x41694353, eventID: 0x614c4353, // "AiCS"/"aLCS"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("from", 0x66726f6d, from), // "from"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func loadColorSettings<T>(_ directParameter: Any = NoParameter,
            from: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("loadColorSettings", eventClass: 0x41694353, eventID: 0x614c4353, // "AiCS"/"aLCS"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("from", 0x66726f6d, from), // "from"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func loadPreset(_ directParameter: Any = NoParameter,
            presetname: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("loadPreset", eventClass: 0x41694972, eventID: 0x746f4c50, // "AiIr"/"toLP"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("presetname", 0x746f506b, presetname), // "toPk"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func loadPreset<T>(_ directParameter: Any = NoParameter,
            presetname: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("loadPreset", eventClass: 0x41694972, eventID: 0x746f4c50, // "AiIr"/"toLP"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("presetname", 0x746f506b, presetname), // "toPk"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func make(_ directParameter: Any = NoParameter,
            new: Any = NoParameter,
            at: Any = NoParameter,
            withData: Any = NoParameter,
            withProperties: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("make", eventClass: 0x636f7265, eventID: 0x6372656c, // "core"/"crel"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("new", 0x6b6f636c, new), // "kocl"
                    ("at", 0x696e7368, at), // "insh"
                    ("withData", 0x64617461, withData), // "data"
                    ("withProperties", 0x70726474, withProperties), // "prdt"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func make<T>(_ directParameter: Any = NoParameter,
            new: Any = NoParameter,
            at: Any = NoParameter,
            withData: Any = NoParameter,
            withProperties: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("make", eventClass: 0x636f7265, eventID: 0x6372656c, // "core"/"crel"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("new", 0x6b6f636c, new), // "kocl"
                    ("at", 0x696e7368, at), // "insh"
                    ("withData", 0x64617461, withData), // "data"
                    ("withProperties", 0x70726474, withProperties), // "prdt"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func merge(_ directParameter: Any = NoParameter,
            to: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("merge", eventClass: 0x41525435, eventID: 0x4d657267, // "ART5"/"Merg"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x746f2020, to), // "to  "
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func merge<T>(_ directParameter: Any = NoParameter,
            to: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("merge", eventClass: 0x41525435, eventID: 0x4d657267, // "ART5"/"Merg"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x746f2020, to), // "to  "
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func move(_ directParameter: Any = NoParameter,
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
    @discardableResult public func open(_ directParameter: Any = NoParameter,
            forcing: Any = NoParameter,
            dialogs: Any = NoParameter,
            withOptions: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("open", eventClass: 0x61657674, eventID: 0x6f646f63, // "aevt"/"odoc"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("forcing", 0x6b55434d, forcing), // "kUCM"
                    ("dialogs", 0x444c4f47, dialogs), // "DLOG"
                    ("withOptions", 0x7053666f, withOptions), // "pSfo"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func open<T>(_ directParameter: Any = NoParameter,
            forcing: Any = NoParameter,
            dialogs: Any = NoParameter,
            withOptions: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("open", eventClass: 0x61657674, eventID: 0x6f646f63, // "aevt"/"odoc"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("forcing", 0x6b55434d, forcing), // "kUCM"
                    ("dialogs", 0x444c4f47, dialogs), // "DLOG"
                    ("withOptions", 0x7053666f, withOptions), // "pSfo"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func openCloudLibraryAssetForEditing(_ directParameter: Any = NoParameter,
            asseturl: Any = NoParameter,
            thumbnailurl: Any = NoParameter,
            options: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("openCloudLibraryAssetForEditing", eventClass: 0x6d697363, eventID: 0x6b414564, // "misc"/"kAEd"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("asseturl", 0x41415552, asseturl), // "AAUR"
                    ("thumbnailurl", 0x41545552, thumbnailurl), // "ATUR"
                    ("options", 0x4b415445, options), // "KATE"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func openCloudLibraryAssetForEditing<T>(_ directParameter: Any = NoParameter,
            asseturl: Any = NoParameter,
            thumbnailurl: Any = NoParameter,
            options: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("openCloudLibraryAssetForEditing", eventClass: 0x6d697363, eventID: 0x6b414564, // "misc"/"kAEd"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("asseturl", 0x41415552, asseturl), // "AAUR"
                    ("thumbnailurl", 0x41545552, thumbnailurl), // "ATUR"
                    ("options", 0x4b415445, options), // "KATE"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func openLocation(_ directParameter: Any = NoParameter,
            window: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("openLocation", eventClass: 0x4755524c, eventID: 0x4755524c, // "GURL"/"GURL"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("window", 0x57494e44, window), // "WIND"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func openLocation<T>(_ directParameter: Any = NoParameter,
            window: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("openLocation", eventClass: 0x4755524c, eventID: 0x4755524c, // "GURL"/"GURL"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("window", 0x57494e44, window), // "WIND"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func paste(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("paste", eventClass: 0x6d697363, eventID: 0x70617374, // "misc"/"past"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func paste<T>(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("paste", eventClass: 0x6d697363, eventID: 0x70617374, // "misc"/"past"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func print(_ directParameter: Any = NoParameter,
            options: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("print", eventClass: 0x61657674, eventID: 0x70646f63, // "aevt"/"pdoc"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("options", 0x504f5054, options), // "POPT"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func print<T>(_ directParameter: Any = NoParameter,
            options: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("print", eventClass: 0x61657674, eventID: 0x70646f63, // "aevt"/"pdoc"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("options", 0x504f5054, options), // "POPT"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func quit(_ directParameter: Any = NoParameter,
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
    @discardableResult public func rasterize(_ directParameter: Any = NoParameter,
            sourceArt: Any = NoParameter,
            inside: Any = NoParameter,
            withOptions: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("rasterize", eventClass: 0x41525435, eventID: 0x6b524153, // "ART5"/"kRAS"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("sourceArt", 0x6b664149, sourceArt), // "kfAI"
                    ("inside", 0x70434c50, inside), // "pCLP"
                    ("withOptions", 0x7053666f, withOptions), // "pSfo"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func rasterize<T>(_ directParameter: Any = NoParameter,
            sourceArt: Any = NoParameter,
            inside: Any = NoParameter,
            withOptions: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("rasterize", eventClass: 0x41525435, eventID: 0x6b524153, // "ART5"/"kRAS"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("sourceArt", 0x6b664149, sourceArt), // "kfAI"
                    ("inside", 0x70434c50, inside), // "pCLP"
                    ("withOptions", 0x7053666f, withOptions), // "pSfo"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func rearrangeartboards(_ directParameter: Any = NoParameter,
            artboardLayout: Any = NoParameter,
            artboardRowsOrCols: Any = NoParameter,
            artboardSpacing: Any = NoParameter,
            artboardMoveArtwork: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("rearrangeartboards", eventClass: 0x41525435, eventID: 0x72654162, // "ART5"/"reAb"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("artboardLayout", 0x70414c79, artboardLayout), // "pALy"
                    ("artboardRowsOrCols", 0x70415243, artboardRowsOrCols), // "pARC"
                    ("artboardSpacing", 0x70415370, artboardSpacing), // "pASp"
                    ("artboardMoveArtwork", 0x70414d41, artboardMoveArtwork), // "pAMA"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func rearrangeartboards<T>(_ directParameter: Any = NoParameter,
            artboardLayout: Any = NoParameter,
            artboardRowsOrCols: Any = NoParameter,
            artboardSpacing: Any = NoParameter,
            artboardMoveArtwork: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("rearrangeartboards", eventClass: 0x41525435, eventID: 0x72654162, // "ART5"/"reAb"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("artboardLayout", 0x70414c79, artboardLayout), // "pALy"
                    ("artboardRowsOrCols", 0x70415243, artboardRowsOrCols), // "pARC"
                    ("artboardSpacing", 0x70415370, artboardSpacing), // "pASp"
                    ("artboardMoveArtwork", 0x70414d41, artboardMoveArtwork), // "pAMA"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func redo(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("redo", eventClass: 0x6d697363, eventID: 0x61524544, // "misc"/"aRED"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func redo<T>(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("redo", eventClass: 0x6d697363, eventID: 0x61524544, // "misc"/"aRED"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func redraw(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("redraw", eventClass: 0x41525435, eventID: 0x52454652, // "ART5"/"REFR"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func redraw<T>(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("redraw", eventClass: 0x41525435, eventID: 0x52454652, // "ART5"/"REFR"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func reflectCsaw(_ directParameter: Any = NoParameter,
            to: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("reflectCsaw", eventClass: 0x41525435, eventID: 0x52664157, // "ART5"/"RfAW"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x746f2020, to), // "to  "
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func reflectCsaw<T>(_ directParameter: Any = NoParameter,
            to: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("reflectCsaw", eventClass: 0x41525435, eventID: 0x52664157, // "ART5"/"RfAW"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x746f2020, to), // "to  "
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func releaseTracing(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("releaseTracing", eventClass: 0x41694972, eventID: 0x7472524c, // "AiIr"/"trRL"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func releaseTracing<T>(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("releaseTracing", eventClass: 0x41694972, eventID: 0x7472524c, // "AiIr"/"trRL"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func relink(_ directParameter: Any = NoParameter,
            from: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("relink", eventClass: 0x41525435, eventID: 0x7061524c, // "ART5"/"paRL"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("from", 0x66726f6d, from), // "from"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func relink<T>(_ directParameter: Any = NoParameter,
            from: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("relink", eventClass: 0x41525435, eventID: 0x7061524c, // "ART5"/"paRL"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("from", 0x66726f6d, from), // "from"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func reopen(_ directParameter: Any = NoParameter,
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
    @discardableResult public func resetWorkspace(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("resetWorkspace", eventClass: 0x41525435, eventID: 0x6b415257, // "ART5"/"kARW"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func resetWorkspace<T>(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("resetWorkspace", eventClass: 0x41525435, eventID: 0x6b415257, // "ART5"/"kARW"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func rotate(_ directParameter: Any = NoParameter,
            angle: Any = NoParameter,
            transformingObjects: Any = NoParameter,
            transformingFillPatterns: Any = NoParameter,
            transformingFillGradients: Any = NoParameter,
            transformingStrokePatterns: Any = NoParameter,
            about: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("rotate", eventClass: 0x41525435, eventID: 0x646f524d, // "ART5"/"doRM"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("angle", 0x7041474c, angle), // "pAGL"
                    ("transformingObjects", 0x7054584f, transformingObjects), // "pTXO"
                    ("transformingFillPatterns", 0x70544650, transformingFillPatterns), // "pTFP"
                    ("transformingFillGradients", 0x70544647, transformingFillGradients), // "pTFG"
                    ("transformingStrokePatterns", 0x70545350, transformingStrokePatterns), // "pTSP"
                    ("about", 0x70545878, about), // "pTXx"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func rotate<T>(_ directParameter: Any = NoParameter,
            angle: Any = NoParameter,
            transformingObjects: Any = NoParameter,
            transformingFillPatterns: Any = NoParameter,
            transformingFillGradients: Any = NoParameter,
            transformingStrokePatterns: Any = NoParameter,
            about: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("rotate", eventClass: 0x41525435, eventID: 0x646f524d, // "ART5"/"doRM"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("angle", 0x7041474c, angle), // "pAGL"
                    ("transformingObjects", 0x7054584f, transformingObjects), // "pTXO"
                    ("transformingFillPatterns", 0x70544650, transformingFillPatterns), // "pTFP"
                    ("transformingFillGradients", 0x70544647, transformingFillGradients), // "pTFG"
                    ("transformingStrokePatterns", 0x70545350, transformingStrokePatterns), // "pTSP"
                    ("about", 0x70545878, about), // "pTXx"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func run(_ directParameter: Any = NoParameter,
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
    @discardableResult public func save(_ directParameter: Any = NoParameter,
            in_: Any = NoParameter,
            as_: Any = NoParameter,
            withOptions: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("save", eventClass: 0x636f7265, eventID: 0x73617665, // "core"/"save"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("in_", 0x6b66696c, in_), // "kfil"
                    ("as_", 0x666c7470, as_), // "fltp"
                    ("withOptions", 0x7053666f, withOptions), // "pSfo"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func save<T>(_ directParameter: Any = NoParameter,
            in_: Any = NoParameter,
            as_: Any = NoParameter,
            withOptions: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("save", eventClass: 0x636f7265, eventID: 0x73617665, // "core"/"save"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("in_", 0x6b66696c, in_), // "kfil"
                    ("as_", 0x666c7470, as_), // "fltp"
                    ("withOptions", 0x7053666f, withOptions), // "pSfo"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func saveWorkspace(_ directParameter: Any = NoParameter,
            workspaceName: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("saveWorkspace", eventClass: 0x41525435, eventID: 0x6b417357, // "ART5"/"kAsW"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("workspaceName", 0x7057734e, workspaceName), // "pWsN"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func saveWorkspace<T>(_ directParameter: Any = NoParameter,
            workspaceName: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("saveWorkspace", eventClass: 0x41525435, eventID: 0x6b417357, // "ART5"/"kAsW"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("workspaceName", 0x7057734e, workspaceName), // "pWsN"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func scale(_ directParameter: Any = NoParameter,
            horizontalScale: Any = NoParameter,
            verticalScale: Any = NoParameter,
            transformingObjects: Any = NoParameter,
            transformingFillPatterns: Any = NoParameter,
            transformingFillGradients: Any = NoParameter,
            transformingStrokePatterns: Any = NoParameter,
            lineScale: Any = NoParameter,
            about: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("scale", eventClass: 0x41525435, eventID: 0x646f534d, // "ART5"/"doSM"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("horizontalScale", 0x70535858, horizontalScale), // "pSXX"
                    ("verticalScale", 0x70535959, verticalScale), // "pSYY"
                    ("transformingObjects", 0x7054584f, transformingObjects), // "pTXO"
                    ("transformingFillPatterns", 0x70544650, transformingFillPatterns), // "pTFP"
                    ("transformingFillGradients", 0x70544647, transformingFillGradients), // "pTFG"
                    ("transformingStrokePatterns", 0x70545350, transformingStrokePatterns), // "pTSP"
                    ("lineScale", 0x704c4e53, lineScale), // "pLNS"
                    ("about", 0x70545878, about), // "pTXx"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func scale<T>(_ directParameter: Any = NoParameter,
            horizontalScale: Any = NoParameter,
            verticalScale: Any = NoParameter,
            transformingObjects: Any = NoParameter,
            transformingFillPatterns: Any = NoParameter,
            transformingFillGradients: Any = NoParameter,
            transformingStrokePatterns: Any = NoParameter,
            lineScale: Any = NoParameter,
            about: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("scale", eventClass: 0x41525435, eventID: 0x646f534d, // "ART5"/"doSM"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("horizontalScale", 0x70535858, horizontalScale), // "pSXX"
                    ("verticalScale", 0x70535959, verticalScale), // "pSYY"
                    ("transformingObjects", 0x7054584f, transformingObjects), // "pTXO"
                    ("transformingFillPatterns", 0x70544650, transformingFillPatterns), // "pTFP"
                    ("transformingFillGradients", 0x70544647, transformingFillGradients), // "pTFG"
                    ("transformingStrokePatterns", 0x70545350, transformingStrokePatterns), // "pTSP"
                    ("lineScale", 0x704c4e53, lineScale), // "pLNS"
                    ("about", 0x70545878, about), // "pTXx"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func select(_ directParameter: Any = NoParameter,
            extendingSelection: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("select", eventClass: 0x41695458, eventID: 0x70545230, // "AiTX"/"pTR0"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("extendingSelection", 0x70545231, extendingSelection), // "pTR1"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func select<T>(_ directParameter: Any = NoParameter,
            extendingSelection: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("select", eventClass: 0x41695458, eventID: 0x70545230, // "AiTX"/"pTR0"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("extendingSelection", 0x70545231, extendingSelection), // "pTR1"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func selectobjectsonactiveartboard(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("selectobjectsonactiveartboard", eventClass: 0x41525435, eventID: 0x736f4162, // "ART5"/"soAb"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func selectobjectsonactiveartboard<T>(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("selectobjectsonactiveartboard", eventClass: 0x41525435, eventID: 0x736f4162, // "ART5"/"soAb"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func selectPerspectivePreset(_ directParameter: Any = NoParameter,
            perspectivePreset: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("selectPerspectivePreset", eventClass: 0x41525435, eventID: 0x53707250, // "ART5"/"SprP"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("perspectivePreset", 0x5072506e, perspectivePreset), // "PrPn"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func selectPerspectivePreset<T>(_ directParameter: Any = NoParameter,
            perspectivePreset: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("selectPerspectivePreset", eventClass: 0x41525435, eventID: 0x53707250, // "ART5"/"SprP"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("perspectivePreset", 0x5072506e, perspectivePreset), // "PrPn"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func SendScriptMessageAction(_ directParameter: Any = NoParameter,
            pluginName: Any = NoParameter,
            messageSelector: Any = NoParameter,
            parameterString: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("SendScriptMessageAction", eventClass: 0x6d697363, eventID: 0x6153534d, // "misc"/"aSSM"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("pluginName", 0x7041504e, pluginName), // "pAPN"
                    ("messageSelector", 0x70414d53, messageSelector), // "pAMS"
                    ("parameterString", 0x70415052, parameterString), // "pAPR"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func SendScriptMessageAction<T>(_ directParameter: Any = NoParameter,
            pluginName: Any = NoParameter,
            messageSelector: Any = NoParameter,
            parameterString: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("SendScriptMessageAction", eventClass: 0x6d697363, eventID: 0x6153534d, // "misc"/"aSSM"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("pluginName", 0x7041504e, pluginName), // "pAPN"
                    ("messageSelector", 0x70414d53, messageSelector), // "pAMS"
                    ("parameterString", 0x70415052, parameterString), // "pAPR"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func set(_ directParameter: Any = NoParameter,
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
    @discardableResult public func setBooleanPreference(_ directParameter: Any = NoParameter,
            key: Any = NoParameter,
            to: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("setBooleanPreference", eventClass: 0x636f7265, eventID: 0x70504634, // "core"/"pPF4"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("key", 0x7052464b, key), // "pRFK"
                    ("to", 0x746f2020, to), // "to  "
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func setBooleanPreference<T>(_ directParameter: Any = NoParameter,
            key: Any = NoParameter,
            to: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("setBooleanPreference", eventClass: 0x636f7265, eventID: 0x70504634, // "core"/"pPF4"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("key", 0x7052464b, key), // "pRFK"
                    ("to", 0x746f2020, to), // "to  "
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func setIntegerPreference(_ directParameter: Any = NoParameter,
            key: Any = NoParameter,
            to: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("setIntegerPreference", eventClass: 0x636f7265, eventID: 0x70504636, // "core"/"pPF6"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("key", 0x7052464b, key), // "pRFK"
                    ("to", 0x746f2020, to), // "to  "
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func setIntegerPreference<T>(_ directParameter: Any = NoParameter,
            key: Any = NoParameter,
            to: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("setIntegerPreference", eventClass: 0x636f7265, eventID: 0x70504636, // "core"/"pPF6"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("key", 0x7052464b, key), // "pRFK"
                    ("to", 0x746f2020, to), // "to  "
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func setPerspectiveActivePlane(_ directParameter: Any = NoParameter,
            perspectiveGridPlane: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("setPerspectiveActivePlane", eventClass: 0x41525435, eventID: 0x50736150, // "ART5"/"PsaP"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("perspectiveGridPlane", 0x50736750, perspectiveGridPlane), // "PsgP"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func setPerspectiveActivePlane<T>(_ directParameter: Any = NoParameter,
            perspectiveGridPlane: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("setPerspectiveActivePlane", eventClass: 0x41525435, eventID: 0x50736150, // "ART5"/"PsaP"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("perspectiveGridPlane", 0x50736750, perspectiveGridPlane), // "PsgP"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func setRealPreference(_ directParameter: Any = NoParameter,
            key: Any = NoParameter,
            to: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("setRealPreference", eventClass: 0x636f7265, eventID: 0x70504638, // "core"/"pPF8"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("key", 0x7052464b, key), // "pRFK"
                    ("to", 0x746f2020, to), // "to  "
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func setRealPreference<T>(_ directParameter: Any = NoParameter,
            key: Any = NoParameter,
            to: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("setRealPreference", eventClass: 0x636f7265, eventID: 0x70504638, // "core"/"pPF8"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("key", 0x7052464b, key), // "pRFK"
                    ("to", 0x746f2020, to), // "to  "
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func setStringPreference(_ directParameter: Any = NoParameter,
            key: Any = NoParameter,
            to: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("setStringPreference", eventClass: 0x636f7265, eventID: 0x70504661, // "core"/"pPFa"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("key", 0x7052464b, key), // "pRFK"
                    ("to", 0x746f2020, to), // "to  "
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func setStringPreference<T>(_ directParameter: Any = NoParameter,
            key: Any = NoParameter,
            to: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("setStringPreference", eventClass: 0x636f7265, eventID: 0x70504661, // "core"/"pPFa"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("key", 0x7052464b, key), // "pRFK"
                    ("to", 0x746f2020, to), // "to  "
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func setThumbnailOptionsForCloudLibrary(_ directParameter: Any = NoParameter,
            options: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("setThumbnailOptionsForCloudLibrary", eventClass: 0x6d697363, eventID: 0x6b41544f, // "misc"/"kATO"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("options", 0x4750454f, options), // "GPEO"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func setThumbnailOptionsForCloudLibrary<T>(_ directParameter: Any = NoParameter,
            options: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("setThumbnailOptionsForCloudLibrary", eventClass: 0x6d697363, eventID: 0x6b41544f, // "misc"/"kATO"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("options", 0x4750454f, options), // "GPEO"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func showColorPicker(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("showColorPicker", eventClass: 0x6d697363, eventID: 0x6b43506b, // "misc"/"kCPk"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func showColorPicker<T>(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("showColorPicker", eventClass: 0x6d697363, eventID: 0x6b43506b, // "misc"/"kCPk"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func showPerspectiveGrid(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("showPerspectiveGrid", eventClass: 0x41525435, eventID: 0x50737047, // "ART5"/"PspG"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func showPerspectiveGrid<T>(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("showPerspectiveGrid", eventClass: 0x41525435, eventID: 0x50737047, // "ART5"/"PspG"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func showPresets(_ directParameter: Any = NoParameter,
            from: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("showPresets", eventClass: 0x41694353, eventID: 0x61535053, // "AiCS"/"aSPS"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("from", 0x66726f6d, from), // "from"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func showPresets<T>(_ directParameter: Any = NoParameter,
            from: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("showPresets", eventClass: 0x41694353, eventID: 0x61535053, // "AiCS"/"aSPS"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("from", 0x66726f6d, from), // "from"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func singularMatrix(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("singularMatrix", eventClass: 0x41525478, eventID: 0x6973534d, // "ARTx"/"isSM"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func singularMatrix<T>(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("singularMatrix", eventClass: 0x41525478, eventID: 0x6973534d, // "ARTx"/"isSM"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func storePreset(_ directParameter: Any = NoParameter,
            presetname: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("storePreset", eventClass: 0x41694972, eventID: 0x746f5350, // "AiIr"/"toSP"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("presetname", 0x746f506b, presetname), // "toPk"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func storePreset<T>(_ directParameter: Any = NoParameter,
            presetname: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("storePreset", eventClass: 0x41694972, eventID: 0x746f5350, // "AiIr"/"toSP"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("presetname", 0x746f506b, presetname), // "toPk"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func switchWorkspace(_ directParameter: Any = NoParameter,
            workspaceName: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("switchWorkspace", eventClass: 0x41525435, eventID: 0x6b415357, // "ART5"/"kASW"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("workspaceName", 0x7057734e, workspaceName), // "pWsN"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func switchWorkspace<T>(_ directParameter: Any = NoParameter,
            workspaceName: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("switchWorkspace", eventClass: 0x41525435, eventID: 0x6b415357, // "ART5"/"kASW"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("workspaceName", 0x7057734e, workspaceName), // "pWsN"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func tracePlaced(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("tracePlaced", eventClass: 0x41694972, eventID: 0x70615472, // "AiIr"/"paTr"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func tracePlaced<T>(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("tracePlaced", eventClass: 0x41694972, eventID: 0x70615472, // "AiIr"/"paTr"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func traceRaster(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("traceRaster", eventClass: 0x41694972, eventID: 0x63615472, // "AiIr"/"caTr"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func traceRaster<T>(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("traceRaster", eventClass: 0x41694972, eventID: 0x63615472, // "AiIr"/"caTr"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func transform(_ directParameter: Any = NoParameter,
            using: Any = NoParameter,
            transformingObjects: Any = NoParameter,
            transformingFillPatterns: Any = NoParameter,
            transformingFillGradients: Any = NoParameter,
            transformingStrokePatterns: Any = NoParameter,
            lineScale: Any = NoParameter,
            about: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("transform", eventClass: 0x41525478, eventID: 0x5452414e, // "ARTx"/"TRAN"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("using", 0x54526d78, using), // "TRmx"
                    ("transformingObjects", 0x7054584f, transformingObjects), // "pTXO"
                    ("transformingFillPatterns", 0x70544650, transformingFillPatterns), // "pTFP"
                    ("transformingFillGradients", 0x70544647, transformingFillGradients), // "pTFG"
                    ("transformingStrokePatterns", 0x70545350, transformingStrokePatterns), // "pTSP"
                    ("lineScale", 0x704c4e53, lineScale), // "pLNS"
                    ("about", 0x70545878, about), // "pTXx"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func transform<T>(_ directParameter: Any = NoParameter,
            using: Any = NoParameter,
            transformingObjects: Any = NoParameter,
            transformingFillPatterns: Any = NoParameter,
            transformingFillGradients: Any = NoParameter,
            transformingStrokePatterns: Any = NoParameter,
            lineScale: Any = NoParameter,
            about: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("transform", eventClass: 0x41525478, eventID: 0x5452414e, // "ARTx"/"TRAN"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("using", 0x54526d78, using), // "TRmx"
                    ("transformingObjects", 0x7054584f, transformingObjects), // "pTXO"
                    ("transformingFillPatterns", 0x70544650, transformingFillPatterns), // "pTFP"
                    ("transformingFillGradients", 0x70544647, transformingFillGradients), // "pTFG"
                    ("transformingStrokePatterns", 0x70545350, transformingStrokePatterns), // "pTSP"
                    ("lineScale", 0x704c4e53, lineScale), // "pLNS"
                    ("about", 0x70545878, about), // "pTXx"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func translate(_ directParameter: Any = NoParameter,
            deltaX: Any = NoParameter,
            deltaY: Any = NoParameter,
            transformingObjects: Any = NoParameter,
            transformingFillPatterns: Any = NoParameter,
            transformingFillGradients: Any = NoParameter,
            transformingStrokePatterns: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("translate", eventClass: 0x41525435, eventID: 0x646f584d, // "ART5"/"doXM"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("deltaX", 0x70445858, deltaX), // "pDXX"
                    ("deltaY", 0x70445959, deltaY), // "pDYY"
                    ("transformingObjects", 0x7054584f, transformingObjects), // "pTXO"
                    ("transformingFillPatterns", 0x70544650, transformingFillPatterns), // "pTFP"
                    ("transformingFillGradients", 0x70544647, transformingFillGradients), // "pTFG"
                    ("transformingStrokePatterns", 0x70545350, transformingStrokePatterns), // "pTSP"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func translate<T>(_ directParameter: Any = NoParameter,
            deltaX: Any = NoParameter,
            deltaY: Any = NoParameter,
            transformingObjects: Any = NoParameter,
            transformingFillPatterns: Any = NoParameter,
            transformingFillGradients: Any = NoParameter,
            transformingStrokePatterns: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("translate", eventClass: 0x41525435, eventID: 0x646f584d, // "ART5"/"doXM"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("deltaX", 0x70445858, deltaX), // "pDXX"
                    ("deltaY", 0x70445959, deltaY), // "pDYY"
                    ("transformingObjects", 0x7054584f, transformingObjects), // "pTXO"
                    ("transformingFillPatterns", 0x70544650, transformingFillPatterns), // "pTFP"
                    ("transformingFillGradients", 0x70544647, transformingFillGradients), // "pTFG"
                    ("transformingStrokePatterns", 0x70545350, transformingStrokePatterns), // "pTSP"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func translatePlaceholderText(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("translatePlaceholderText", eventClass: 0x41695458, eventID: 0x54726e54, // "AiTX"/"TrnT"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func translatePlaceholderText<T>(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("translatePlaceholderText", eventClass: 0x41695458, eventID: 0x54726e54, // "AiTX"/"TrnT"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func undo(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("undo", eventClass: 0x6d697363, eventID: 0x61554e44, // "misc"/"aUND"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func undo<T>(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("undo", eventClass: 0x6d697363, eventID: 0x61554e44, // "misc"/"aUND"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func unloadAction(_ directParameter: Any = NoParameter,
            actionFilePath: Any = NoParameter,
            actionFilePath: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("unloadAction", eventClass: 0x6d697363, eventID: 0x61554c41, // "misc"/"aULA"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("actionFilePath", 0x70535455, actionFilePath), // "pSTU"
                    ("actionFilePath", 0x70415455, actionFilePath), // "pATU"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func unloadAction<T>(_ directParameter: Any = NoParameter,
            actionFilePath: Any = NoParameter,
            actionFilePath: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("unloadAction", eventClass: 0x6d697363, eventID: 0x61554c41, // "misc"/"aULA"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("actionFilePath", 0x70535455, actionFilePath), // "pSTU"
                    ("actionFilePath", 0x70415455, actionFilePath), // "pATU"
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
    @discardableResult public func update(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("update", eventClass: 0x41694450, eventID: 0x70445355, // "AiDP"/"pDSU"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: Any.self)
    }
    public func update<T>(_ directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: TimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent("update", eventClass: 0x41694450, eventID: 0x70445355, // "AiDP"/"pDSU"
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, returnType: T.self)
    }
}


public protocol ICCQuery: ObjectSpecifierExtension, ICCCommand {} // provides vars and methods for constructing specifiers

extension ICCQuery {
    
    // Properties
    public var a: ICCObject {return self.property(0x4c616241) as! ICCObject} // "LabA"
    public var acrobatLayers: ICCObject {return self.property(0x703e504c) as! ICCObject} // "p>PL"
    public var addToRecentFiles: ICCObject {return self.property(0x70415452) as! ICCObject} // "pATR"
    public var akiLeft: ICCObject {return self.property(0x70433134) as! ICCObject} // "pC14"
    public var akiRight: ICCObject {return self.property(0x70433135) as! ICCObject} // "pC15"
    public var alignment: ICCObject {return self.property(0x54733031) as! ICCObject} // "Ts01"
    public var allowPrinting: ICCObject {return self.property(0x703e5041) as! ICCObject} // "p>PA"
    public var alternateGlyphs: ICCObject {return self.property(0x70433075) as! ICCObject} // "pC0u"
    public var alterPathsForAppearance: ICCObject {return self.property(0x70414150) as! ICCObject} // "pAAP"
    public var anchor: ICCObject {return self.property(0x70416e63) as! ICCObject} // "pAnc"
    public var anchorCount: ICCObject {return self.property(0x74724143) as! ICCObject} // "trAC"
    public var angle: ICCObject {return self.property(0x7041474c) as! ICCObject} // "pAGL"
    public var antialias: ICCObject {return self.property(0x70544161) as! ICCObject} // "pTAa"
    public var antialiasing: ICCObject {return self.property(0x70416e41) as! ICCObject} // "pAnA"
    public var antialiasingMethod: ICCObject {return self.property(0x65414c53) as! ICCObject} // "eALS"
    public var area: ICCObject {return self.property(0x61694152) as! ICCObject} // "aiAR"
    public var artboardClipping: ICCObject {return self.property(0x70414243) as! ICCObject} // "pABC"
    public var artboardLayout: ICCObject {return self.property(0x70414c79) as! ICCObject} // "pALy"
    public var artboardRange: ICCObject {return self.property(0x70503463) as! ICCObject} // "pP4c"
    public var artboardRectangle: ICCObject {return self.property(0x62416c31) as! ICCObject} // "bAl1"
    public var artboardRowsOrCols: ICCObject {return self.property(0x70415243) as! ICCObject} // "pARC"
    public var artboardSpacing: ICCObject {return self.property(0x70415370) as! ICCObject} // "pASp"
    public var artClipping: ICCObject {return self.property(0x70464143) as! ICCObject} // "pFAC"
    public var as_: ICCObject {return self.property(0x666c7470) as! ICCObject} // "fltp"
    public var AutoCADFileOptions: ICCObject {return self.property(0x70504632) as! ICCObject} // "pPF2"
    public var AutoCADVersion: ICCObject {return self.property(0x70415653) as! ICCObject} // "pAVS"
    public var autoKerning0x28obsoleteUse0x27kerningMethod0x270x29: ICCObject {return self.property(0x70543037) as! ICCObject} // "pT07"
    public var autoLeading: ICCObject {return self.property(0x70433033) as! ICCObject} // "pC03"
    public var autoLeadingAmount: ICCObject {return self.property(0x63504161) as! ICCObject} // "cPAa"
    public var b: ICCObject {return self.property(0x4c616242) as! ICCObject} // "LabB"
    public var backgroundBlack: ICCObject {return self.property(0x7042424b) as! ICCObject} // "pBBK"
    public var backgroundColor: ICCObject {return self.property(0x70464243) as! ICCObject} // "pFBC"
    public var backgroundLayers: ICCObject {return self.property(0x7046424c) as! ICCObject} // "pFBL"
    public var baselineDirection: ICCObject {return self.property(0x70433073) as! ICCObject} // "pC0s"
    public var baselinePosition: ICCObject {return self.property(0x70433035) as! ICCObject} // "pC05"
    public var baselineShift: ICCObject {return self.property(0x70543034) as! ICCObject} // "pT04"
    public var bestType: ICCObject {return self.property(0x70627374) as! ICCObject} // "pbst"
    public var binaryPrinting: ICCObject {return self.property(0x70503039) as! ICCObject} // "pP09"
    public var bitmapResolution: ICCObject {return self.property(0x70503461) as! ICCObject} // "pP4a"
    public var bitsPerChannel: ICCObject {return self.property(0x63425043) as! ICCObject} // "cBPC"
    public var black: ICCObject {return self.property(0x424c414b) as! ICCObject} // "BLAK"
    public var bleedLink: ICCObject {return self.property(0x703e424b) as! ICCObject} // "p>BK"
    public var bleedOffset: ICCObject {return self.property(0x70503737) as! ICCObject} // "pP77"
    public var blendAnimation: ICCObject {return self.property(0x70464241) as! ICCObject} // "pFBA"
    public var blendMode: ICCObject {return self.property(0x70426c4d) as! ICCObject} // "pBlM"
    public var blendsPolicy: ICCObject {return self.property(0x70466250) as! ICCObject} // "pFbP"
    public var blue: ICCObject {return self.property(0x424c5545) as! ICCObject} // "BLUE"
    public var blur: ICCObject {return self.property(0x70426c41) as! ICCObject} // "pBlA"
    public var boundingBox: ICCObject {return self.property(0x61694258) as! ICCObject} // "aiBX"
    public var bounds: ICCObject {return self.property(0x70626e64) as! ICCObject} // "pbnd"
    public var browserAvailable: ICCObject {return self.property(0x78794241) as! ICCObject} // "xyBA"
    public var buildNumber: ICCObject {return self.property(0x70414142) as! ICCObject} // "pAAB"
    public var BunriKinshi: ICCObject {return self.property(0x65504a38) as! ICCObject} // "ePJ8"
    public var BurasagariType: ICCObject {return self.property(0x65504a39) as! ICCObject} // "ePJ9"
    public var ByteOrder: ICCObject {return self.property(0x7454424f) as! ICCObject} // "tTBO"
    public var capitalization: ICCObject {return self.property(0x70433034) as! ICCObject} // "pC04"
    public var centerArtwork: ICCObject {return self.property(0x70434177) as! ICCObject} // "pCAw"
    public var centerPoint: ICCObject {return self.property(0x61694354) as! ICCObject} // "aiCT"
    public var changesAllowed: ICCObject {return self.property(0x703e4347) as! ICCObject} // "p>CG"
    public var channels: ICCObject {return self.property(0x6343484e) as! ICCObject} // "cCHN"
    public var characterOffset: ICCObject {return self.property(0x70535452) as! ICCObject} // "pSTR"
    public var class_: ICCObject {return self.property(0x70636c73) as! ICCObject} // "pcls"
    public var clipComplexRegions: ICCObject {return self.property(0x70506e36) as! ICCObject} // "pPn6"
    public var clipped: ICCObject {return self.property(0x61694370) as! ICCObject} // "aiCp"
    public var clipping: ICCObject {return self.property(0x61694350) as! ICCObject} // "aiCP"
    public var clippingMask: ICCObject {return self.property(0x704d534b) as! ICCObject} // "pMSK"
    public var closed: ICCObject {return self.property(0x6169436c) as! ICCObject} // "aiCl"
    public var CMYKPostScript: ICCObject {return self.property(0x70435053) as! ICCObject} // "pCPS"
    public var collate: ICCObject {return self.property(0x70503437) as! ICCObject} // "pP47"
    public var color: ICCObject {return self.property(0x636f6c72) as! ICCObject} // "colr"
    public var colorants: ICCObject {return self.property(0x634f4c73) as! ICCObject} // "cOLs"
    public var colorBars: ICCObject {return self.property(0x70503735) as! ICCObject} // "pP75"
    public var colorCompression: ICCObject {return self.property(0x703e4362) as! ICCObject} // "p>Cb"
    public var colorConversionId: ICCObject {return self.property(0x703e4343) as! ICCObject} // "p>CC"
    public var colorCount: ICCObject {return self.property(0x70436c43) as! ICCObject} // "pClC"
    public var colorDestinationId: ICCObject {return self.property(0x703e434e) as! ICCObject} // "p>CN"
    public var colorDither: ICCObject {return self.property(0x70434474) as! ICCObject} // "pCDt"
    public var colorDownsampling: ICCObject {return self.property(0x703e4344) as! ICCObject} // "p>CD"
    public var colorDownsamplingThreshold: ICCObject {return self.property(0x703e4341) as! ICCObject} // "p>CA"
    public var colorFidelity: ICCObject {return self.property(0x746f4d63) as! ICCObject} // "toMc"
    public var colorgroup: ICCObject {return self.property(0x746f4367) as! ICCObject} // "toCg"
    public var colorized: ICCObject {return self.property(0x63434f4c) as! ICCObject} // "cCOL"
    public var colorManagementSettings: ICCObject {return self.property(0x70503362) as! ICCObject} // "pP3b"
    public var colorMode: ICCObject {return self.property(0x7044434d) as! ICCObject} // "pDCM"
    public var colorModel: ICCObject {return self.property(0x65434d64) as! ICCObject} // "eCMd"
    public var colorProfileId: ICCObject {return self.property(0x703e4350) as! ICCObject} // "p>CP"
    public var colorProfileName: ICCObject {return self.property(0x7043504e) as! ICCObject} // "pCPN"
    public var colorReduction: ICCObject {return self.property(0x70435264) as! ICCObject} // "pCRd"
    public var colorResample: ICCObject {return self.property(0x703e4353) as! ICCObject} // "p>CS"
    public var colors: ICCObject {return self.property(0x7041434c) as! ICCObject} // "pACL"
    public var colorSeparationSettings: ICCObject {return self.property(0x70503336) as! ICCObject} // "pP36"
    public var colorSettings: ICCObject {return self.property(0x7043534c) as! ICCObject} // "pCSL"
    public var colorSpace: ICCObject {return self.property(0x63614353) as! ICCObject} // "caCS"
    public var colorSupport: ICCObject {return self.property(0x70503033) as! ICCObject} // "pP03"
    public var colorTileSize: ICCObject {return self.property(0x703e4354) as! ICCObject} // "p>CT"
    public var colorType: ICCObject {return self.property(0x70614354) as! ICCObject} // "paCT"
    public var columnCount: ICCObject {return self.property(0x70434c43) as! ICCObject} // "pCLC"
    public var columnGutter: ICCObject {return self.property(0x70434c47) as! ICCObject} // "pCLG"
    public var compatibility: ICCObject {return self.property(0x70494370) as! ICCObject} // "pICp"
    public var compatibleGradientPrinting: ICCObject {return self.property(0x70434750) as! ICCObject} // "pCGP"
    public var compatibleShading: ICCObject {return self.property(0x70503935) as! ICCObject} // "pP95"
    public var compoundShapes: ICCObject {return self.property(0x70454353) as! ICCObject} // "pECS"
    public var compressArt: ICCObject {return self.property(0x703e544c) as! ICCObject} // "p>TL"
    public var compressed: ICCObject {return self.property(0x70434463) as! ICCObject} // "pCDc"
    public var connectionForms: ICCObject {return self.property(0x7043306a) as! ICCObject} // "pC0j"
    public var container: ICCObject {return self.property(0x63746e72) as! ICCObject} // "ctnr"
    public var contents: ICCObject {return self.property(0x70434e54) as! ICCObject} // "pCNT"
    public var contentVariable: ICCObject {return self.property(0x70434f56) as! ICCObject} // "pCOV"
    public var contextualLigature: ICCObject {return self.property(0x70433063) as! ICCObject} // "pC0c"
    public var controlBounds: ICCObject {return self.property(0x61694e58) as! ICCObject} // "aiNX"
    public var convertCropAreaToArtboard: ICCObject {return self.property(0x70434341) as! ICCObject} // "pCCA"
    public var converted: ICCObject {return self.property(0x7043744e) as! ICCObject} // "pCtN"
    public var convertSpotColors: ICCObject {return self.property(0x70503532) as! ICCObject} // "pP52"
    public var convertStrokesToOutlines: ICCObject {return self.property(0x70506e35) as! ICCObject} // "pPn5"
    public var convertTextToOutlines: ICCObject {return self.property(0x70506e34) as! ICCObject} // "pPn4"
    public var convertTilesToArtboard: ICCObject {return self.property(0x70435441) as! ICCObject} // "pCTA"
    public var coordinatePrecision: ICCObject {return self.property(0x70446350) as! ICCObject} // "pDcP"
    public var coordinateSettings: ICCObject {return self.property(0x70503337) as! ICCObject} // "pP37"
    public var coordinateSystem: ICCObject {return self.property(0x70436f53) as! ICCObject} // "pCoS"
    public var copies: ICCObject {return self.property(0x70503433) as! ICCObject} // "pP43"
    public var CornerFidelity: ICCObject {return self.property(0x746f4372) as! ICCObject} // "toCr"
    public var createArtboardWithArtworkBoundingBox: ICCObject {return self.property(0x70434142) as! ICCObject} // "pCAB"
    public var cropMarks: ICCObject {return self.property(0x78784342) as! ICCObject} // "xxCB"
    public var cropStyle: ICCObject {return self.property(0x78784353) as! ICCObject} // "xxCS"
    public var CSSProperties: ICCObject {return self.property(0x70435353) as! ICCObject} // "pCSS"
    public var currentAdobeId: ICCObject {return self.property(0x70414944) as! ICCObject} // "pAID"
    public var currentDataset: ICCObject {return self.property(0x70444144) as! ICCObject} // "pDAD"
    public var currentDocument: ICCObject {return self.property(0x61694144) as! ICCObject} // "aiAD"
    public var currentLayer: ICCObject {return self.property(0x6169434c) as! ICCObject} // "aiCL"
    public var currentUserGuid: ICCObject {return self.property(0x70474944) as! ICCObject} // "pGID"
    public var currentView: ICCObject {return self.property(0x61694356) as! ICCObject} // "aiCV"
    public var curveQuality: ICCObject {return self.property(0x70464351) as! ICCObject} // "pFCQ"
    public var customColor: ICCObject {return self.property(0x70506d36) as! ICCObject} // "pPm6"
    public var customPaper: ICCObject {return self.property(0x70503232) as! ICCObject} // "pP22"
    public var customPaperSizes: ICCObject {return self.property(0x70503036) as! ICCObject} // "pP06"
    public var customPaperTransverse: ICCObject {return self.property(0x70503037) as! ICCObject} // "pP07"
    public var cyan: ICCObject {return self.property(0x4359414e) as! ICCObject} // "CYAN"
    public var decimalCharacter: ICCObject {return self.property(0x54733032) as! ICCObject} // "Ts02"
    public var defaultColorSettings: ICCObject {return self.property(0x61474353) as! ICCObject} // "aGCS"
    public var defaultFillColor: ICCObject {return self.property(0x44694643) as! ICCObject} // "DiFC"
    public var defaultFilled: ICCObject {return self.property(0x44694650) as! ICCObject} // "DiFP"
    public var defaultFillOverprint: ICCObject {return self.property(0x4469464f) as! ICCObject} // "DiFO"
    public var defaultResolution: ICCObject {return self.property(0x70503034) as! ICCObject} // "pP04"
    public var defaultScreen: ICCObject {return self.property(0x70506231) as! ICCObject} // "pPb1"
    public var defaultStrokeCap: ICCObject {return self.property(0x44694378) as! ICCObject} // "DiCx"
    public var defaultStrokeColor: ICCObject {return self.property(0x44695343) as! ICCObject} // "DiSC"
    public var defaultStroked: ICCObject {return self.property(0x44695350) as! ICCObject} // "DiSP"
    public var defaultStrokeDashes: ICCObject {return self.property(0x44694453) as! ICCObject} // "DiDS"
    public var defaultStrokeDashOffset: ICCObject {return self.property(0x4469444f) as! ICCObject} // "DiDO"
    public var defaultStrokeJoin: ICCObject {return self.property(0x44694a6e) as! ICCObject} // "DiJn"
    public var defaultStrokeMiterLimit: ICCObject {return self.property(0x44694d78) as! ICCObject} // "DiMx"
    public var defaultStrokeOverprint: ICCObject {return self.property(0x4469534f) as! ICCObject} // "DiSO"
    public var defaultStrokeWidth: ICCObject {return self.property(0x44695357) as! ICCObject} // "DiSW"
    public var defaultType: ICCObject {return self.property(0x64656674) as! ICCObject} // "deft"
    public var density: ICCObject {return self.property(0x70506d34) as! ICCObject} // "pPm4"
    public var designation: ICCObject {return self.property(0x70503431) as! ICCObject} // "pP41"
    public var desiredGlyphScaling: ICCObject {return self.property(0x63504139) as! ICCObject} // "cPA9"
    public var desiredLetterSpacing: ICCObject {return self.property(0x70543166) as! ICCObject} // "pT1f"
    public var desiredWordSpacing: ICCObject {return self.property(0x70543163) as! ICCObject} // "pT1c"
    public var dimensionsOfPNG: ICCObject {return self.property(0x70444d4e) as! ICCObject} // "pDMN"
    public var dimPlacedImages: ICCObject {return self.property(0x61694449) as! ICCObject} // "aiDI"
    public var direction0x28obsoleteUse0x27baselineDirection0x270x29: ICCObject {return self.property(0x70543039) as! ICCObject} // "pT09"
    public var discretionaryLigature: ICCObject {return self.property(0x70433062) as! ICCObject} // "pC0b"
    public var ditherPercent: ICCObject {return self.property(0x70445063) as! ICCObject} // "pDPc"
    public var documentPassword: ICCObject {return self.property(0x703e4450) as! ICCObject} // "p>DP"
    public var documentUnits: ICCObject {return self.property(0x78784455) as! ICCObject} // "xxDU"
    public var dotShape: ICCObject {return self.property(0x70506d37) as! ICCObject} // "pPm7"
    public var downloadFonts: ICCObject {return self.property(0x70503831) as! ICCObject} // "pP81"
    public var downsampleLinkedImages: ICCObject {return self.property(0x7046576c) as! ICCObject} // "pFWl"
    public var editable: ICCObject {return self.property(0x70414564) as! ICCObject} // "pAEd"
    public var editableText: ICCObject {return self.property(0x70455478) as! ICCObject} // "pETx"
    public var embedAllFonts: ICCObject {return self.property(0x70454146) as! ICCObject} // "pEAF"
    public var embedded: ICCObject {return self.property(0x63614c4b) as! ICCObject} // "caLK"
    public var embedICCProfile: ICCObject {return self.property(0x70455066) as! ICCObject} // "pEPf"
    public var embedLinkedFiles: ICCObject {return self.property(0x70497049) as! ICCObject} // "pIpI"
    public var emulsion: ICCObject {return self.property(0x70503632) as! ICCObject} // "pP62"
    public var enableAccess: ICCObject {return self.property(0x703e4541) as! ICCObject} // "p>EA"
    public var enableCopy: ICCObject {return self.property(0x703e4543) as! ICCObject} // "p>EC"
    public var enableCopyAndAccess: ICCObject {return self.property(0x703e4542) as! ICCObject} // "p>EB"
    public var enablePlaintext: ICCObject {return self.property(0x703e4550) as! ICCObject} // "p>EP"
    public var endTValue: ICCObject {return self.property(0x70544554) as! ICCObject} // "pTET"
    public var entireGradient: ICCObject {return self.property(0x78614547) as! ICCObject} // "xaEG"
    public var entirePath: ICCObject {return self.property(0x61694550) as! ICCObject} // "aiEP"
    public var evenodd: ICCObject {return self.property(0x6169454f) as! ICCObject} // "aiEO"
    public var everyLineComposer: ICCObject {return self.property(0x65504a64) as! ICCObject} // "ePJd"
    public var exportAllSymbols: ICCObject {return self.property(0x70464153) as! ICCObject} // "pFAS"
    public var exportFileFormat: ICCObject {return self.property(0x70414646) as! ICCObject} // "pAFF"
    public var exportOption: ICCObject {return self.property(0x7041454f) as! ICCObject} // "pAEO"
    public var exportSelectedArtOnly: ICCObject {return self.property(0x70415341) as! ICCObject} // "pASA"
    public var exportStyle: ICCObject {return self.property(0x70465853) as! ICCObject} // "pFXS"
    public var exportVersion: ICCObject {return self.property(0x70465856) as! ICCObject} // "pFXV"
    public var family: ICCObject {return self.property(0x70747866) as! ICCObject} // "ptxf"
    public var figureStyle: ICCObject {return self.property(0x7043306d) as! ICCObject} // "pC0m"
    public var filePath: ICCObject {return self.property(0x61694653) as! ICCObject} // "aiFS"
    public var fillColor: ICCObject {return self.property(0x61694643) as! ICCObject} // "aiFC"
    public var filled: ICCObject {return self.property(0x61694650) as! ICCObject} // "aiFP"
    public var fillOverprint: ICCObject {return self.property(0x6169464f) as! ICCObject} // "aiFO"
    public var fills: ICCObject {return self.property(0x746f466c) as! ICCObject} // "toFl"
    public var filtersPolicy: ICCObject {return self.property(0x70466650) as! ICCObject} // "pFfP"
    public var firstBaseline: ICCObject {return self.property(0x7046426c) as! ICCObject} // "pFBl"
    public var firstBaselineMin: ICCObject {return self.property(0x7046424d) as! ICCObject} // "pFBM"
    public var firstLineIndent: ICCObject {return self.property(0x70543133) as! ICCObject} // "pT13"
    public var fitToPage: ICCObject {return self.property(0x70503634) as! ICCObject} // "pP64"
    public var FlashPlaybackSecurity: ICCObject {return self.property(0x70465053) as! ICCObject} // "pFPS"
    public var flattenerPreset: ICCObject {return self.property(0x74465354) as! ICCObject} // "tFST"
    public var flattenerPresets: ICCObject {return self.property(0x7046534c) as! ICCObject} // "pFSL"
    public var flattenerSettings: ICCObject {return self.property(0x70503363) as! ICCObject} // "pP3c"
    public var flatteningBalance: ICCObject {return self.property(0x70506e31) as! ICCObject} // "pPn1"
    public var flattenOutput: ICCObject {return self.property(0x704f466c) as! ICCObject} // "pOFl"
    public var flowLinksHorizontally: ICCObject {return self.property(0x7052574d) as! ICCObject} // "pRWM"
    public var fontSettings: ICCObject {return self.property(0x70503339) as! ICCObject} // "pP39"
    public var fontSubsetThreshold: ICCObject {return self.property(0x70465354) as! ICCObject} // "pFST"
    public var fontSubstitutionKind: ICCObject {return self.property(0x70503834) as! ICCObject} // "pP84"
    public var fontType: ICCObject {return self.property(0x70465459) as! ICCObject} // "pFTY"
    public var forceContinuousTone: ICCObject {return self.property(0x70503934) as! ICCObject} // "pP94"
    public var fractions: ICCObject {return self.property(0x70433066) as! ICCObject} // "pC0f"
    public var frameRate: ICCObject {return self.property(0x70464652) as! ICCObject} // "pFFR"
    public var freeMemory: ICCObject {return self.property(0x6169464d) as! ICCObject} // "aiFM"
    public var frequency: ICCObject {return self.property(0x70506232) as! ICCObject} // "pPb2"
    public var frontmost: ICCObject {return self.property(0x70697366) as! ICCObject} // "pisf"
    public var fxgVersion: ICCObject {return self.property(0x70464376) as! ICCObject} // "pFCv"
    public var generateHTML: ICCObject {return self.property(0x70464748) as! ICCObject} // "pFGH"
    public var generateThumbnails: ICCObject {return self.property(0x703e4754) as! ICCObject} // "p>GT"
    public var geometricBounds: ICCObject {return self.property(0x61694247) as! ICCObject} // "aiBG"
    public var globalScaleOptions: ICCObject {return self.property(0x7047534f) as! ICCObject} // "pGSO"
    public var globalScalePercent: ICCObject {return self.property(0x70475350) as! ICCObject} // "pGSP"
    public var gradient: ICCObject {return self.property(0x63614744) as! ICCObject} // "caGD"
    public var gradientResolution: ICCObject {return self.property(0x70506e33) as! ICCObject} // "pPn3"
    public var gradientsPolicy: ICCObject {return self.property(0x70466750) as! ICCObject} // "pFgP"
    public var gradientType: ICCObject {return self.property(0x67645479) as! ICCObject} // "gdTy"
    public var grayLevels: ICCObject {return self.property(0x746f476c) as! ICCObject} // "toGl"
    public var grayscaleCompression: ICCObject {return self.property(0x703e4762) as! ICCObject} // "p>Gb"
    public var grayscaleDownsampling: ICCObject {return self.property(0x703e4744) as! ICCObject} // "p>GD"
    public var grayscaleDownsamplingThreshold: ICCObject {return self.property(0x703e4741) as! ICCObject} // "p>GA"
    public var grayscaleResample: ICCObject {return self.property(0x703e4753) as! ICCObject} // "p>GS"
    public var grayscaleTileSize: ICCObject {return self.property(0x703e475a) as! ICCObject} // "p>GZ"
    public var grayValue: ICCObject {return self.property(0x47524159) as! ICCObject} // "GRAY"
    public var green: ICCObject {return self.property(0x4752454e) as! ICCObject} // "GREN"
    public var guides: ICCObject {return self.property(0x61694744) as! ICCObject} // "aiGD"
    public var hasSelectedArtwork: ICCObject {return self.property(0x61692424) as! ICCObject} // "ai$$"
    public var height: ICCObject {return self.property(0x70534868) as! ICCObject} // "pSHh"
    public var hidden: ICCObject {return self.property(0x61694844) as! ICCObject} // "aiHD"
    public var hiddenLayers: ICCObject {return self.property(0x7048644c) as! ICCObject} // "pHdL"
    public var hiliteAngle: ICCObject {return self.property(0x4764446a) as! ICCObject} // "GdDj"
    public var hiliteLength: ICCObject {return self.property(0x47644478) as! ICCObject} // "GdDx"
    public var horizontalRadius: ICCObject {return self.property(0x70524468) as! ICCObject} // "pRDh"
    public var horizontalScale: ICCObject {return self.property(0x70535858) as! ICCObject} // "pSXX"
    public var horizontalScaling: ICCObject {return self.property(0x70487a53) as! ICCObject} // "pHzS"
    public var hyphenateCapitalizedWords: ICCObject {return self.property(0x63504133) as! ICCObject} // "cPA3"
    public var hyphenation: ICCObject {return self.property(0x48783031) as! ICCObject} // "Hx01"
    public var hyphenationPreference: ICCObject {return self.property(0x63504134) as! ICCObject} // "cPA4"
    public var hyphenationZone: ICCObject {return self.property(0x63504132) as! ICCObject} // "cPA2"
    public var id: ICCObject {return self.property(0x49442020) as! ICCObject} // "ID  "
    public var ignoreWhite: ICCObject {return self.property(0x746f4957) as! ICCObject} // "toIW"
    public var imageableArea: ICCObject {return self.property(0x70503231) as! ICCObject} // "pP21"
    public var imageCompression: ICCObject {return self.property(0x70503933) as! ICCObject} // "pP93"
    public var imageFormat: ICCObject {return self.property(0x70464946) as! ICCObject} // "pFIF"
    public var imageMap: ICCObject {return self.property(0x7045494d) as! ICCObject} // "pEIM"
    public var includeDocumentThumbnails: ICCObject {return self.property(0x70494374) as! ICCObject} // "pICt"
    public var includeLayers: ICCObject {return self.property(0x70494c59) as! ICCObject} // "pILY"
    public var includeMetadata: ICCObject {return self.property(0x7046586d) as! ICCObject} // "pFXm"
    public var includeUnusedSymbols: ICCObject {return self.property(0x70464975) as! ICCObject} // "pFIu"
    public var index: ICCObject {return self.property(0x70696478) as! ICCObject} // "pidx"
    public var informationLoss: ICCObject {return self.property(0x70494c50) as! ICCObject} // "pILP"
    public var inks: ICCObject {return self.property(0x7050494c) as! ICCObject} // "pPIL"
    public var innerRadius: ICCObject {return self.property(0x70524432) as! ICCObject} // "pRD2"
    public var InRIPSeparationSupport: ICCObject {return self.property(0x70503038) as! ICCObject} // "pP08"
    public var inscribed: ICCObject {return self.property(0x7053496e) as! ICCObject} // "pSIn"
    public var intent: ICCObject {return self.property(0x70506132) as! ICCObject} // "pPa2"
    public var interlaced: ICCObject {return self.property(0x70496e4c) as! ICCObject} // "pInL"
    public var isolated: ICCObject {return self.property(0x7049736f) as! ICCObject} // "pIso"
    public var isTracing: ICCObject {return self.property(0x69735472) as! ICCObject} // "isTr"
    public var italics: ICCObject {return self.property(0x70433072) as! ICCObject} // "pC0r"
    public var japaneseFileFormat0x28obsolete0x29: ICCObject {return self.property(0x704a6666) as! ICCObject} // "pJff"
    public var jobSettings: ICCObject {return self.property(0x70503335) as! ICCObject} // "pP35"
    public var JPEGMethod: ICCObject {return self.property(0x70464a4d) as! ICCObject} // "pFJM"
    public var JPEGQuality: ICCObject {return self.property(0x70464a51) as! ICCObject} // "pFJQ"
    public var justification: ICCObject {return self.property(0x70543136) as! ICCObject} // "pT16"
    public var kerning: ICCObject {return self.property(0x70543234) as! ICCObject} // "pT24"
    public var kerningMethod: ICCObject {return self.property(0x70543236) as! ICCObject} // "pT26"
    public var kind: ICCObject {return self.property(0x63784454) as! ICCObject} // "cxDT"
    public var Kinsoku: ICCObject {return self.property(0x634b534f) as! ICCObject} // "cKSO"
    public var KinsokuOrder: ICCObject {return self.property(0x65504a61) as! ICCObject} // "ePJa"
    public var KinsokuSet: ICCObject {return self.property(0x704b534f) as! ICCObject} // "pKSO"
    public var knockout: ICCObject {return self.property(0x704b6e6b) as! ICCObject} // "pKnk"
    public var KurikaeshiMojiShori: ICCObject {return self.property(0x65504a62) as! ICCObject} // "ePJb"
    public var l: ICCObject {return self.property(0x4c61624c) as! ICCObject} // "LabL"
    public var language: ICCObject {return self.property(0x70433074) as! ICCObject} // "pC0t"
    public var languageLevel: ICCObject {return self.property(0x70503131) as! ICCObject} // "pP11"
    public var layer: ICCObject {return self.property(0x63614c59) as! ICCObject} // "caLY"
    public var layerComp: ICCObject {return self.property(0x704c4370) as! ICCObject} // "pLCp"
    public var layerOrder: ICCObject {return self.property(0x70464c4f) as! ICCObject} // "pFLO"
    public var leader: ICCObject {return self.property(0x54733033) as! ICCObject} // "Ts03"
    public var leading: ICCObject {return self.property(0x70543035) as! ICCObject} // "pT05"
    public var leadingType: ICCObject {return self.property(0x63504138) as! ICCObject} // "cPA8"
    public var leftDirection: ICCObject {return self.property(0x6361494e) as! ICCObject} // "caIN"
    public var leftIndent: ICCObject {return self.property(0x70543134) as! ICCObject} // "pT14"
    public var length: ICCObject {return self.property(0x6c656e67) as! ICCObject} // "leng"
    public var ligature: ICCObject {return self.property(0x70433061) as! ICCObject} // "pC0a"
    public var locale: ICCObject {return self.property(0x7041414c) as! ICCObject} // "pAAL"
    public var locked: ICCObject {return self.property(0x61694c4b) as! ICCObject} // "aiLK"
    public var looping: ICCObject {return self.property(0x70464c6f) as! ICCObject} // "pFLo"
    public var LZWCompression: ICCObject {return self.property(0x744c5a43) as! ICCObject} // "tLZC"
    public var magenta: ICCObject {return self.property(0x4d41474e) as! ICCObject} // "MAGN"
    public var marksOffset: ICCObject {return self.property(0x70503738) as! ICCObject} // "pP78"
    public var matrix: ICCObject {return self.property(0x7446584d) as! ICCObject} // "tFXM"
    public var matte: ICCObject {return self.property(0x704d4142) as! ICCObject} // "pMAB"
    public var matteColor: ICCObject {return self.property(0x704d436c) as! ICCObject} // "pMCl"
    public var maximumColors: ICCObject {return self.property(0x746f4366) as! ICCObject} // "toCf"
    public var maximumConsecutiveHyphens: ICCObject {return self.property(0x48783035) as! ICCObject} // "Hx05"
    public var maximumEditability: ICCObject {return self.property(0x704d4561) as! ICCObject} // "pMEa"
    public var maximumGlyphScaling: ICCObject {return self.property(0x63504135) as! ICCObject} // "cPA5"
    public var maximumHeightOffset: ICCObject {return self.property(0x7050306a) as! ICCObject} // "pP0j"
    public var maximumLetterSpacing: ICCObject {return self.property(0x70543165) as! ICCObject} // "pT1e"
    public var maximumPaperHeight: ICCObject {return self.property(0x70503065) as! ICCObject} // "pP0e"
    public var maximumPaperWidth: ICCObject {return self.property(0x70503063) as! ICCObject} // "pP0c"
    public var maximumResolution: ICCObject {return self.property(0x70503035) as! ICCObject} // "pP05"
    public var maximumStrokeWeight: ICCObject {return self.property(0x746f4d78) as! ICCObject} // "toMx"
    public var maximumWidthOffset: ICCObject {return self.property(0x70503068) as! ICCObject} // "pP0h"
    public var maximumWordSpacing: ICCObject {return self.property(0x70543162) as! ICCObject} // "pT1b"
    public var mergeLayers: ICCObject {return self.property(0x704d4c73) as! ICCObject} // "pMLs"
    public var midpoint: ICCObject {return self.property(0x78614d50) as! ICCObject} // "xaMP"
    public var minifySvg: ICCObject {return self.property(0x7041534d) as! ICCObject} // "pASM"
    public var minimumAfterHyphen: ICCObject {return self.property(0x48783034) as! ICCObject} // "Hx04"
    public var minimumBeforeHyphen: ICCObject {return self.property(0x48783033) as! ICCObject} // "Hx03"
    public var minimumGlyphScaling: ICCObject {return self.property(0x63504136) as! ICCObject} // "cPA6"
    public var minimumHeightOffset: ICCObject {return self.property(0x70503069) as! ICCObject} // "pP0i"
    public var minimumHyphenatedWordSize: ICCObject {return self.property(0x63504131) as! ICCObject} // "cPA1"
    public var minimumLetterSpacing: ICCObject {return self.property(0x70543164) as! ICCObject} // "pT1d"
    public var minimumPaperHeight: ICCObject {return self.property(0x70503064) as! ICCObject} // "pP0d"
    public var minimumPaperWidth: ICCObject {return self.property(0x70503062) as! ICCObject} // "pP0b"
    public var minimumWidthOffset: ICCObject {return self.property(0x70503066) as! ICCObject} // "pP0f"
    public var minimumWordSpacing: ICCObject {return self.property(0x70543161) as! ICCObject} // "pT1a"
    public var modified: ICCObject {return self.property(0x696d6f64) as! ICCObject} // "imod"
    public var Mojikumi: ICCObject {return self.property(0x634d4a49) as! ICCObject} // "cMJI"
    public var MojikumiSet: ICCObject {return self.property(0x704d4a49) as! ICCObject} // "pMJI"
    public var monochromeCompression: ICCObject {return self.property(0x703e4d51) as! ICCObject} // "p>MQ"
    public var monochromeDownsampling: ICCObject {return self.property(0x703e4d44) as! ICCObject} // "p>MD"
    public var monochromeDownsamplingThreshold: ICCObject {return self.property(0x703e4d41) as! ICCObject} // "p>MA"
    public var monochromeResample: ICCObject {return self.property(0x703e4d53) as! ICCObject} // "p>MS"
    public var mvalue_a: ICCObject {return self.property(0x7461566c) as! ICCObject} // "taVl"
    public var mvalue_b: ICCObject {return self.property(0x7462566c) as! ICCObject} // "tbVl"
    public var mvalue_c: ICCObject {return self.property(0x7463566c) as! ICCObject} // "tcVl"
    public var mvalue_d: ICCObject {return self.property(0x7464566c) as! ICCObject} // "tdVl"
    public var mvalue_tx: ICCObject {return self.property(0x74747856) as! ICCObject} // "ttxV"
    public var mvalue_ty: ICCObject {return self.property(0x74747956) as! ICCObject} // "ttyV"
    public var name: ICCObject {return self.property(0x706e616d) as! ICCObject} // "pnam"
    public var negativePrinting: ICCObject {return self.property(0x70503932) as! ICCObject} // "pP92"
    public var nestedLayers: ICCObject {return self.property(0x704e4c79) as! ICCObject} // "pNLy"
    public var nextFrame: ICCObject {return self.property(0x704e4672) as! ICCObject} // "pNFr"
    public var noBreak: ICCObject {return self.property(0x70433136) as! ICCObject} // "pC16"
    public var NoiseFidelity: ICCObject {return self.property(0x746f4e66) as! ICCObject} // "toNf"
    public var note: ICCObject {return self.property(0x61694e54) as! ICCObject} // "aiNT"
    public var numArtboards: ICCObject {return self.property(0x704e4172) as! ICCObject} // "pNAr"
    public var offset: ICCObject {return self.property(0x703e4f41) as! ICCObject} // "p>OA"
    public var opacity: ICCObject {return self.property(0x704c4f70) as! ICCObject} // "pLOp"
    public var OpenTypePosition: ICCObject {return self.property(0x70433036) as! ICCObject} // "pC06"
    public var opticalAlignment: ICCObject {return self.property(0x704f5041) as! ICCObject} // "pOPA"
    public var optimization: ICCObject {return self.property(0x704f706d) as! ICCObject} // "pOpm"
    public var ordinals: ICCObject {return self.property(0x70433067) as! ICCObject} // "pC0g"
    public var orientation: ICCObject {return self.property(0x70503631) as! ICCObject} // "pP61"
    public var origin: ICCObject {return self.property(0x47644f67) as! ICCObject} // "GdOg"
    public var originalArt: ICCObject {return self.property(0x74725363) as! ICCObject} // "trSc"
    public var ornaments: ICCObject {return self.property(0x7043306c) as! ICCObject} // "pC0l"
    public var outputCondition: ICCObject {return self.property(0x703e434f) as! ICCObject} // "p>CO"
    public var outputConditionId: ICCObject {return self.property(0x703e4355) as! ICCObject} // "p>CU"
    public var outputIntentProfile: ICCObject {return self.property(0x703e4349) as! ICCObject} // "p>CI"
    public var outputResolution: ICCObject {return self.property(0x78784f52) as! ICCObject} // "xxOR"
    public var overprint: ICCObject {return self.property(0x703e4f50) as! ICCObject} // "p>OP"
    public var overPrintBlack: ICCObject {return self.property(0x70503533) as! ICCObject} // "pP53"
    public var overprintFill: ICCObject {return self.property(0x70433138) as! ICCObject} // "pC18"
    public var overprintStroke: ICCObject {return self.property(0x70433137) as! ICCObject} // "pC17"
    public var padding: ICCObject {return self.property(0x70504144) as! ICCObject} // "pPAD"
    public var page: ICCObject {return self.property(0x7050544f) as! ICCObject} // "pPTO"
    public var pageInfo: ICCObject {return self.property(0x703e5049) as! ICCObject} // "p>PI"
    public var pageInfoMarks: ICCObject {return self.property(0x70503736) as! ICCObject} // "pP76"
    public var pageMarksSettings: ICCObject {return self.property(0x70503338) as! ICCObject} // "pP38"
    public var pageMarksStyle: ICCObject {return self.property(0x70503731) as! ICCObject} // "pP71"
    public var pageOrigin: ICCObject {return self.property(0x7878504f) as! ICCObject} // "xxPO"
    public var palette: ICCObject {return self.property(0x746f506c) as! ICCObject} // "toPl"
    public var paperSettings: ICCObject {return self.property(0x70503333) as! ICCObject} // "pP33"
    public var paperSizes: ICCObject {return self.property(0x70503061) as! ICCObject} // "pP0a"
    public var pasteRemembersLayers: ICCObject {return self.property(0x7052654c) as! ICCObject} // "pReL"
    public var pathCount: ICCObject {return self.property(0x74725043) as! ICCObject} // "trPC"
    public var PathFidelity: ICCObject {return self.property(0x746f5046) as! ICCObject} // "toPF"
    public var pattern: ICCObject {return self.property(0x63615054) as! ICCObject} // "caPT"
    public var PDFCompatible: ICCObject {return self.property(0x70504366) as! ICCObject} // "pPCf"
    public var PDFCropBounds: ICCObject {return self.property(0x70505431) as! ICCObject} // "pPT1"
    public var PDFFileOptions: ICCObject {return self.property(0x70504631) as! ICCObject} // "pPF1"
    public var PDFPreset: ICCObject {return self.property(0x703e4f53) as! ICCObject} // "p>OS"
    public var PDFPresets: ICCObject {return self.property(0x7044534c) as! ICCObject} // "pDSL"
    public var pdfXstandard: ICCObject {return self.property(0x703e5058) as! ICCObject} // "p>PX"
    public var pdfXstandardDescripton: ICCObject {return self.property(0x703e5044) as! ICCObject} // "p>PD"
    public var permissionPassword: ICCObject {return self.property(0x703e5050) as! ICCObject} // "p>PP"
    public var PhotoshopFileOptions: ICCObject {return self.property(0x7050464f) as! ICCObject} // "pPFO"
    public var pixelAligned: ICCObject {return self.property(0x7050416c) as! ICCObject} // "pPAl"
    public var pixelAspectRatioCorrection: ICCObject {return self.property(0x70415243) as! ICCObject} // "pARC"
    public var pointCount: ICCObject {return self.property(0x70505463) as! ICCObject} // "pPTc"
    public var pointType: ICCObject {return self.property(0x63614352) as! ICCObject} // "caCR"
    public var polarity: ICCObject {return self.property(0x61695050) as! ICCObject} // "aiPP"
    public var position: ICCObject {return self.property(0x70615073) as! ICCObject} // "paPs"
    public var PostScript: ICCObject {return self.property(0x7050536c) as! ICCObject} // "pPSl"
    public var postscriptSettings: ICCObject {return self.property(0x70503361) as! ICCObject} // "pP3a"
    public var PPDName: ICCObject {return self.property(0x70503332) as! ICCObject} // "pP32"
    public var PPDs: ICCObject {return self.property(0x7050444c) as! ICCObject} // "pPDL"
    public var preserveAppearance: ICCObject {return self.property(0x65343231) as! ICCObject} // "e421"
    public var preserveEditability: ICCObject {return self.property(0x703e5045) as! ICCObject} // "p>PE"
    public var preserveEditingCapabilities: ICCObject {return self.property(0x70465065) as! ICCObject} // "pFPe"
    public var preserveHiddenLayers: ICCObject {return self.property(0x7050484c) as! ICCObject} // "pPHL"
    public var preserveImageMaps: ICCObject {return self.property(0x7050494d) as! ICCObject} // "pPIM"
    public var preserveLayers: ICCObject {return self.property(0x70504c79) as! ICCObject} // "pPLy"
    public var preserveLegacyArtboard: ICCObject {return self.property(0x70504c41) as! ICCObject} // "pPLA"
    public var preserveSlices: ICCObject {return self.property(0x70505363) as! ICCObject} // "pPSc"
    public var preset: ICCObject {return self.property(0x746f5072) as! ICCObject} // "toPr"
    public var presetSettings: ICCObject {return self.property(0x70444f43) as! ICCObject} // "pDOC"
    public var presetSettingsDialogOption: ICCObject {return self.property(0x70444f44) as! ICCObject} // "pDOD"
    public var preview: ICCObject {return self.property(0x61695056) as! ICCObject} // "aiPV"
    public var previewMode: ICCObject {return self.property(0x70445052) as! ICCObject} // "pDPR"
    public var previousFrame: ICCObject {return self.property(0x63504672) as! ICCObject} // "cPFr"
    public var printable: ICCObject {return self.property(0x61695054) as! ICCObject} // "aiPT"
    public var printAllArtboards: ICCObject {return self.property(0x70503462) as! ICCObject} // "pP4b"
    public var printArea: ICCObject {return self.property(0x70503432) as! ICCObject} // "pP42"
    public var printAsBitmap: ICCObject {return self.property(0x70503439) as! ICCObject} // "pP49"
    public var printerName: ICCObject {return self.property(0x70503331) as! ICCObject} // "pP31"
    public var printerResolution: ICCObject {return self.property(0x703e4650) as! ICCObject} // "p>FP"
    public var printers: ICCObject {return self.property(0x7050524c) as! ICCObject} // "pPRL"
    public var printerType: ICCObject {return self.property(0x70503031) as! ICCObject} // "pP01"
    public var printingStatus: ICCObject {return self.property(0x70503739) as! ICCObject} // "pP79"
    public var printPreset: ICCObject {return self.property(0x74505354) as! ICCObject} // "tPST"
    public var printPresets: ICCObject {return self.property(0x7050534c) as! ICCObject} // "pPSL"
    public var printTiles: ICCObject {return self.property(0x78785054) as! ICCObject} // "xxPT"
    public var profileKind: ICCObject {return self.property(0x70506131) as! ICCObject} // "pPa1"
    public var properties: ICCObject {return self.property(0x70414c4c) as! ICCObject} // "pALL"
    public var proportionalMetrics: ICCObject {return self.property(0x7043306f) as! ICCObject} // "pC0o"
    public var quality: ICCObject {return self.property(0x70496d51) as! ICCObject} // "pImQ"
    public var radius: ICCObject {return self.property(0x70524478) as! ICCObject} // "pRDx"
    public var rampPoint: ICCObject {return self.property(0x78615250) as! ICCObject} // "xaRP"
    public var rasterEffectSettings: ICCObject {return self.property(0x70524553) as! ICCObject} // "pRES"
    public var rasterFormat: ICCObject {return self.property(0x70415246) as! ICCObject} // "pARF"
    public var rasterImageLocation: ICCObject {return self.property(0x70524957) as! ICCObject} // "pRIW"
    public var rasterizationResolution: ICCObject {return self.property(0x70506e32) as! ICCObject} // "pPn2"
    public var rasterResolution: ICCObject {return self.property(0x70445252) as! ICCObject} // "pDRR"
    public var readOnly: ICCObject {return self.property(0x7046524f) as! ICCObject} // "pFRO"
    public var red: ICCObject {return self.property(0x52454420) as! ICCObject} // "RED "
    public var reflect: ICCObject {return self.property(0x53785266) as! ICCObject} // "SxRf"
    public var reflectAngle: ICCObject {return self.property(0x53785261) as! ICCObject} // "SxRa"
    public var registrationMarks: ICCObject {return self.property(0x70503734) as! ICCObject} // "pP74"
    public var registryName: ICCObject {return self.property(0x703e435a) as! ICCObject} // "p>CZ"
    public var replacing: ICCObject {return self.property(0x7052706c) as! ICCObject} // "pRpl"
    public var requireDocPassword: ICCObject {return self.property(0x703e4452) as! ICCObject} // "p>DR"
    public var requirePermPassword: ICCObject {return self.property(0x703e5052) as! ICCObject} // "p>PR"
    public var resolution: ICCObject {return self.property(0x6169525a) as! ICCObject} // "aiRZ"
    public var responsiveSvg: ICCObject {return self.property(0x70495253) as! ICCObject} // "pIRS"
    public var reversed: ICCObject {return self.property(0x70535276) as! ICCObject} // "pSRv"
    public var reversePages: ICCObject {return self.property(0x70503436) as! ICCObject} // "pP46"
    public var rightDirection: ICCObject {return self.property(0x63614f54) as! ICCObject} // "caOT"
    public var rightIndent: ICCObject {return self.property(0x70543135) as! ICCObject} // "pT15"
    public var romanHanging: ICCObject {return self.property(0x65504a36) as! ICCObject} // "ePJ6"
    public var rotation_: ICCObject {return self.property(0x53785278) as! ICCObject} // "SxRx"
    public var rowCount: ICCObject {return self.property(0x70525743) as! ICCObject} // "pRWC"
    public var rowGutter: ICCObject {return self.property(0x70525747) as! ICCObject} // "pRWG"
    public var rulerOrigin: ICCObject {return self.property(0x7878524f) as! ICCObject} // "xxRO"
    public var rulerPAR: ICCObject {return self.property(0x62416c32) as! ICCObject} // "bAl2"
    public var rulerUnits: ICCObject {return self.property(0x78785255) as! ICCObject} // "xxRU"
    public var saveMultipleArtboards: ICCObject {return self.property(0x534d4162) as! ICCObject} // "SMAb"
    public var savingAsHTML: ICCObject {return self.property(0x70534854) as! ICCObject} // "pSHT"
    public var scaleFactor: ICCObject {return self.property(0x53785363) as! ICCObject} // "SxSc"
    public var scaleLineweights: ICCObject {return self.property(0x70414c57) as! ICCObject} // "pALW"
    public var scaleRatio: ICCObject {return self.property(0x70415352) as! ICCObject} // "pASR"
    public var scaleUnit: ICCObject {return self.property(0x70415355) as! ICCObject} // "pASU"
    public var scaling0x28obsoleteUse0x27horizontalScale0x27And0x27verticalScale0x270x29: ICCObject {return self.property(0x70543038) as! ICCObject} // "pT08"
    public var screenMode: ICCObject {return self.property(0x6169564d) as! ICCObject} // "aiVM"
    public var screens: ICCObject {return self.property(0x70503133) as! ICCObject} // "pP13"
    public var scriptingVersion: ICCObject {return self.property(0x70415a76) as! ICCObject} // "pAZv"
    public var selected: ICCObject {return self.property(0x73656c63) as! ICCObject} // "selc"
    public var selectedLayoutName: ICCObject {return self.property(0x70534c4e) as! ICCObject} // "pSLN"
    public var selectedPathPoints: ICCObject {return self.property(0x61695378) as! ICCObject} // "aiSx"
    public var selection: ICCObject {return self.property(0x73656c65) as! ICCObject} // "sele"
    public var separationMode: ICCObject {return self.property(0x70503531) as! ICCObject} // "pP51"
    public var settings: ICCObject {return self.property(0x70507266) as! ICCObject} // "pPrf"
    public var setTypeOfSVG: ICCObject {return self.property(0x70494454) as! ICCObject} // "pIDT"
    public var shadingResolution: ICCObject {return self.property(0x70503936) as! ICCObject} // "pP96"
    public var shearAngle: ICCObject {return self.property(0x53785361) as! ICCObject} // "SxSa"
    public var shearAxis: ICCObject {return self.property(0x53785378) as! ICCObject} // "SxSx"
    public var shiftAngle: ICCObject {return self.property(0x53784461) as! ICCObject} // "SxDa"
    public var shiftDistance: ICCObject {return self.property(0x53784478) as! ICCObject} // "SxDx"
    public var showCenter: ICCObject {return self.property(0x62416c34) as! ICCObject} // "bAl4"
    public var showCrossHairs: ICCObject {return self.property(0x62416c35) as! ICCObject} // "bAl5"
    public var showPlacedImages: ICCObject {return self.property(0x78785350) as! ICCObject} // "xxSP"
    public var showSafeAreas: ICCObject {return self.property(0x62416c36) as! ICCObject} // "bAl6"
    public var sides: ICCObject {return self.property(0x70534463) as! ICCObject} // "pSDc"
    public var singleWordJustification: ICCObject {return self.property(0x63504137) as! ICCObject} // "cPA7"
    public var size: ICCObject {return self.property(0x7074737a) as! ICCObject} // "ptsz"
    public var sliced: ICCObject {return self.property(0x7041536c) as! ICCObject} // "pASl"
    public var slices: ICCObject {return self.property(0x7045536c) as! ICCObject} // "pESl"
    public var snapCurveToLines: ICCObject {return self.property(0x746f5363) as! ICCObject} // "toSc"
    public var sourceArt: ICCObject {return self.property(0x6b664149) as! ICCObject} // "kfAI"
    public var spaceAfter: ICCObject {return self.property(0x63504130) as! ICCObject} // "cPA0"
    public var spaceBefore: ICCObject {return self.property(0x70543130) as! ICCObject} // "pT10"
    public var spacing: ICCObject {return self.property(0x70535041) as! ICCObject} // "pSPA"
    public var splitLongPaths: ICCObject {return self.property(0x7878534c) as! ICCObject} // "xxSL"
    public var spot: ICCObject {return self.property(0x63614343) as! ICCObject} // "caCC"
    public var spotFunction: ICCObject {return self.property(0x70506233) as! ICCObject} // "pPb3"
    public var spotFunctions: ICCObject {return self.property(0x70503134) as! ICCObject} // "pP14"
    public var spotKind: ICCObject {return self.property(0x7053434b) as! ICCObject} // "pSCK"
    public var startTValue: ICCObject {return self.property(0x70545354) as! ICCObject} // "pTST"
    public var startupPreset: ICCObject {return self.property(0x70535450) as! ICCObject} // "pSTP"
    public var startupPresets: ICCObject {return self.property(0x7053504c) as! ICCObject} // "pSPL"
    public var stationery: ICCObject {return self.property(0x70737064) as! ICCObject} // "pspd"
    public var status: ICCObject {return self.property(0x63614c4d) as! ICCObject} // "caLM"
    public var stopOpacity: ICCObject {return self.property(0x7847534f) as! ICCObject} // "xGSO"
    public var story: ICCObject {return self.property(0x6353544f) as! ICCObject} // "cSTO"
    public var strikeThrough: ICCObject {return self.property(0x70433038) as! ICCObject} // "pC08"
    public var strokeCap: ICCObject {return self.property(0x61694378) as! ICCObject} // "aiCx"
    public var strokeColor: ICCObject {return self.property(0x61695343) as! ICCObject} // "aiSC"
    public var stroked: ICCObject {return self.property(0x61695350) as! ICCObject} // "aiSP"
    public var strokeDashes: ICCObject {return self.property(0x61694453) as! ICCObject} // "aiDS"
    public var strokeDashOffset: ICCObject {return self.property(0x6169444f) as! ICCObject} // "aiDO"
    public var strokeJoin: ICCObject {return self.property(0x61694a6e) as! ICCObject} // "aiJn"
    public var strokeMiterLimit: ICCObject {return self.property(0x61694d78) as! ICCObject} // "aiMx"
    public var strokeOverprint: ICCObject {return self.property(0x6169534f) as! ICCObject} // "aiSO"
    public var strokes: ICCObject {return self.property(0x746f5374) as! ICCObject} // "toSt"
    public var strokeWeight: ICCObject {return self.property(0x70433139) as! ICCObject} // "pC19"
    public var strokeWidth: ICCObject {return self.property(0x61695357) as! ICCObject} // "aiSW"
    public var style: ICCObject {return self.property(0x74787374) as! ICCObject} // "txst"
    public var stylisticAlternates: ICCObject {return self.property(0x7043306b) as! ICCObject} // "pC0k"
    public var swash: ICCObject {return self.property(0x70433068) as! ICCObject} // "pC0h"
    public var symbol: ICCObject {return self.property(0x63615359) as! ICCObject} // "caSY"
    public var tabStops: ICCObject {return self.property(0x70543233) as! ICCObject} // "pT23"
    public var TCYHorizontal: ICCObject {return self.property(0x70433133) as! ICCObject} // "pC13"
    public var TCYVertical: ICCObject {return self.property(0x70433132) as! ICCObject} // "pC12"
    public var textFont: ICCObject {return self.property(0x63545866) as! ICCObject} // "cTXf"
    public var textkerning: ICCObject {return self.property(0x70464954) as! ICCObject} // "pFIT"
    public var textOrientation: ICCObject {return self.property(0x70744f52) as! ICCObject} // "ptOR"
    public var textPath: ICCObject {return self.property(0x63545870) as! ICCObject} // "cTXp"
    public var textPolicy: ICCObject {return self.property(0x70467450) as! ICCObject} // "pFtP"
    public var textRange: ICCObject {return self.property(0x70535430) as! ICCObject} // "pST0"
    public var threshold: ICCObject {return self.property(0x746f5468) as! ICCObject} // "toTh"
    public var tileFullPages: ICCObject {return self.property(0x78785446) as! ICCObject} // "xxTF"
    public var tiling: ICCObject {return self.property(0x70503637) as! ICCObject} // "pP67"
    public var tint: ICCObject {return self.property(0x54494e54) as! ICCObject} // "TINT"
    public var title: ICCObject {return self.property(0x70544954) as! ICCObject} // "pTIT"
    public var titling: ICCObject {return self.property(0x70433069) as! ICCObject} // "pC0i"
    public var tracing: ICCObject {return self.property(0x67745472) as! ICCObject} // "gtTr"
    public var TracingColorTypeValue: ICCObject {return self.property(0x746f4354) as! ICCObject} // "toCT"
    public var TracingMethod: ICCObject {return self.property(0x746f4d65) as! ICCObject} // "toMe"
    public var tracingMode: ICCObject {return self.property(0x746f4d64) as! ICCObject} // "toMd"
    public var tracingOptions: ICCObject {return self.property(0x74724f73) as! ICCObject} // "trOs"
    public var tracingPresets: ICCObject {return self.property(0x7054534c) as! ICCObject} // "pTSL"
    public var tracking: ICCObject {return self.property(0x70543036) as! ICCObject} // "pT06"
    public var transparency: ICCObject {return self.property(0x70547063) as! ICCObject} // "pTpc"
    public var transparencyGrid: ICCObject {return self.property(0x70445447) as! ICCObject} // "pDTG"
    public var transparent: ICCObject {return self.property(0x65346c31) as! ICCObject} // "e4l1"
    public var transverse: ICCObject {return self.property(0x70507031) as! ICCObject} // "pPp1"
    public var trapped: ICCObject {return self.property(0x703e4352) as! ICCObject} // "p>CR"
    public var trapping: ICCObject {return self.property(0x70506d32) as! ICCObject} // "pPm2"
    public var trappingOrder: ICCObject {return self.property(0x70506d33) as! ICCObject} // "pPm3"
    public var trimMarks: ICCObject {return self.property(0x70503733) as! ICCObject} // "pP73"
    public var trimMarksWeight: ICCObject {return self.property(0x70503732) as! ICCObject} // "pP72"
    public var trimMarkWeight: ICCObject {return self.property(0x703e5457) as! ICCObject} // "p>TW"
    public var Tsume: ICCObject {return self.property(0x70433076) as! ICCObject} // "pC0v"
    public var underline: ICCObject {return self.property(0x70433037) as! ICCObject} // "pC07"
    public var updateLegacyGradientMesh: ICCObject {return self.property(0x704c474d) as! ICCObject} // "pLGM"
    public var updateLegacyText: ICCObject {return self.property(0x70434c54) as! ICCObject} // "pCLT"
    public var URL: ICCObject {return self.property(0x7055524c) as! ICCObject} // "pURL"
    public var usedColorCount: ICCObject {return self.property(0x74724e43) as! ICCObject} // "trNC"
    public var useDefaultScreen: ICCObject {return self.property(0x78784453) as! ICCObject} // "xxDS"
    public var userInteractionLevel: ICCObject {return self.property(0x7055494c) as! ICCObject} // "pUIL"
    public var value: ICCObject {return self.property(0x61695456) as! ICCObject} // "aiTV"
    public var variablesLocked: ICCObject {return self.property(0x70444c56) as! ICCObject} // "pDLV"
    public var version: ICCObject {return self.property(0x76657273) as! ICCObject} // "vers"
    public var verticalRadius: ICCObject {return self.property(0x70524476) as! ICCObject} // "pRDv"
    public var verticalScale: ICCObject {return self.property(0x70535959) as! ICCObject} // "pSYY"
    public var verticalScaling: ICCObject {return self.property(0x70567453) as! ICCObject} // "pVtS"
    public var viewMode: ICCObject {return self.property(0x746f5676) as! ICCObject} // "toVv"
    public var viewPdf: ICCObject {return self.property(0x703e5653) as! ICCObject} // "p>VS"
    public var visibilityVariable: ICCObject {return self.property(0x70564956) as! ICCObject} // "pVIV"
    public var visible: ICCObject {return self.property(0x70766973) as! ICCObject} // "pvis"
    public var visibleBounds: ICCObject {return self.property(0x61695642) as! ICCObject} // "aiVB"
    public var warichuCharactersAfterBreak: ICCObject {return self.property(0x70433130) as! ICCObject} // "pC10"
    public var warichuCharactersBeforeBreak: ICCObject {return self.property(0x7043307a) as! ICCObject} // "pC0z"
    public var warichuEnabled: ICCObject {return self.property(0x70433165) as! ICCObject} // "pC1e"
    public var warichuGap: ICCObject {return self.property(0x70433078) as! ICCObject} // "pC0x"
    public var warichuJustification: ICCObject {return self.property(0x70433131) as! ICCObject} // "pC11"
    public var warichuLines: ICCObject {return self.property(0x70433077) as! ICCObject} // "pC0w"
    public var warichuScale: ICCObject {return self.property(0x70433079) as! ICCObject} // "pC0y"
    public var warnings: ICCObject {return self.property(0x70455772) as! ICCObject} // "pEWr"
    public var webSnap: ICCObject {return self.property(0x70575063) as! ICCObject} // "pWPc"
    public var width: ICCObject {return self.property(0x70534877) as! ICCObject} // "pSHw"
    public var wrapInside: ICCObject {return self.property(0x70547749) as! ICCObject} // "pTwI"
    public var wrapOffset: ICCObject {return self.property(0x7054774f) as! ICCObject} // "pTwO"
    public var wrapped: ICCObject {return self.property(0x70745752) as! ICCObject} // "ptWR"
    public var writeLayers: ICCObject {return self.property(0x7057724c) as! ICCObject} // "pWrL"
    public var XMPString: ICCObject {return self.property(0x70584d50) as! ICCObject} // "pXMP"
    public var yellow: ICCObject {return self.property(0x59454c4c) as! ICCObject} // "YELL"
    public var zoom: ICCObject {return self.property(0x61695a4d) as! ICCObject} // "aiZM"

    // Elements
    public var application: ICCElements {return self.elements(0x63617070) as! ICCElements} // "capp"
    public var artboards: ICCElements {return self.elements(0x64496d31) as! ICCElements} // "dIm1"
    public var artwork: ICCElements {return self.elements(0x6341574f) as! ICCElements} // "cAWO"
    public var AutoCADExportOptions: ICCElements {return self.elements(0x74454143) as! ICCElements} // "tEAC"
    public var AutoCADOptions: ICCElements {return self.elements(0x744f4f41) as! ICCElements} // "tOOA"
    public var brushes: ICCElements {return self.elements(0x63614252) as! ICCElements} // "caBR"
    public var character: ICCElements {return self.elements(0x63686120) as! ICCElements} // "cha "
    public var characterStyles: ICCElements {return self.elements(0x63435354) as! ICCElements} // "cCST"
    public var CMYKColorInfo: ICCElements {return self.elements(0x74434d69) as! ICCElements} // "tCMi"
    public var colorInfo: ICCElements {return self.elements(0x74414943) as! ICCElements} // "tAIC"
    public var colorManagementOptions: ICCElements {return self.elements(0x7450434d) as! ICCElements} // "tPCM"
    public var colorSeparationOptions: ICCElements {return self.elements(0x74504353) as! ICCElements} // "tPCS"
    public var compoundPathItems: ICCElements {return self.elements(0x63614350) as! ICCElements} // "caCP"
    public var coordinateOptions: ICCElements {return self.elements(0x7450434f) as! ICCElements} // "tPCO"
    public var datasets: ICCElements {return self.elements(0x74445374) as! ICCElements} // "tDSt"
    public var dimensionsInfo: ICCElements {return self.elements(0x444d4e49) as! ICCElements} // "DMNI"
    public var documentPreset: ICCElements {return self.elements(0x74445052) as! ICCElements} // "tDPR"
    public var documents: ICCElements {return self.elements(0x646f6375) as! ICCElements} // "docu"
    public var ellipse: ICCElements {return self.elements(0x73684f56) as! ICCElements} // "shOV"
    public var embededItems: ICCElements {return self.elements(0x6361454c) as! ICCElements} // "caEL"
    public var EPSSaveOptions: ICCElements {return self.elements(0x7465536f) as! ICCElements} // "teSo"
    public var FlashExportOptions: ICCElements {return self.elements(0x7445464c) as! ICCElements} // "tEFL"
    public var flatteningOptions: ICCElements {return self.elements(0x7450464c) as! ICCElements} // "tPFL"
    public var fontOptions: ICCElements {return self.elements(0x7450464f) as! ICCElements} // "tPFO"
    public var FXGSaveOptions: ICCElements {return self.elements(0x746d536f) as! ICCElements} // "tmSo"
    public var GIFExportOptions: ICCElements {return self.elements(0x63474946) as! ICCElements} // "cGIF"
    public var gradientColorInfo: ICCElements {return self.elements(0x74474469) as! ICCElements} // "tGDi"
    public var gradients: ICCElements {return self.elements(0x63614744) as! ICCElements} // "caGD"
    public var gradientStopInfo: ICCElements {return self.elements(0x74474453) as! ICCElements} // "tGDS"
    public var gradientStops: ICCElements {return self.elements(0x63614753) as! ICCElements} // "caGS"
    public var graphicStyles: ICCElements {return self.elements(0x63614153) as! ICCElements} // "caAS"
    public var graphItems: ICCElements {return self.elements(0x63475048) as! ICCElements} // "cGPH"
    public var grayColorInfo: ICCElements {return self.elements(0x74475269) as! ICCElements} // "tGRi"
    public var groupItems: ICCElements {return self.elements(0x63614750) as! ICCElements} // "caGP"
    public var IllustratorPreferences: ICCElements {return self.elements(0x63507266) as! ICCElements} // "cPrf"
    public var IllustratorSaveOptions: ICCElements {return self.elements(0x7449536f) as! ICCElements} // "tISo"
    public var imageCaptureOptions: ICCElements {return self.elements(0x7449434f) as! ICCElements} // "tICO"
    public var ink: ICCElements {return self.elements(0x7450494b) as! ICCElements} // "tPIK"
    public var inkProperties: ICCElements {return self.elements(0x74504949) as! ICCElements} // "tPII"
    public var insertionPoints: ICCElements {return self.elements(0x63696e73) as! ICCElements} // "cins"
    public var items: ICCElements {return self.elements(0x636f626a) as! ICCElements} // "cobj"
    public var jobOptions: ICCElements {return self.elements(0x74504a4f) as! ICCElements} // "tPJO"
    public var JPEGExportOptions: ICCElements {return self.elements(0x74454f6a) as! ICCElements} // "tEOj"
    public var LabColorInfo: ICCElements {return self.elements(0x744c6162) as! ICCElements} // "tLab"
    public var layers: ICCElements {return self.elements(0x63614c59) as! ICCElements} // "caLY"
    public var legacyTextItems: ICCElements {return self.elements(0x634c5449) as! ICCElements} // "cLTI"
    public var line: ICCElements {return self.elements(0x636c696e) as! ICCElements} // "clin"
    public var meshItems: ICCElements {return self.elements(0x634d5348) as! ICCElements} // "cMSH"
    public var multipleTracingOptions: ICCElements {return self.elements(0x6361544f) as! ICCElements} // "caTO"
    public var noColorInfo: ICCElements {return self.elements(0x744e436c) as! ICCElements} // "tNCl"
    public var nonNativeItems: ICCElements {return self.elements(0x63464f69) as! ICCElements} // "cFOi"
    public var obsolete_properties: ICCElements {return self.elements(0x4f625072) as! ICCElements} // "ObPr"
    public var openOptions: ICCElements {return self.elements(0x744f504f) as! ICCElements} // "tOPO"
    public var pageItems: ICCElements {return self.elements(0x63614154) as! ICCElements} // "caAT"
    public var pageMarksOptions: ICCElements {return self.elements(0x7450504d) as! ICCElements} // "tPPM"
    public var paper: ICCElements {return self.elements(0x74504150) as! ICCElements} // "tPAP"
    public var paperOptions: ICCElements {return self.elements(0x7450504f) as! ICCElements} // "tPPO"
    public var paperProperties: ICCElements {return self.elements(0x74504149) as! ICCElements} // "tPAI"
    public var paragraph: ICCElements {return self.elements(0x63706172) as! ICCElements} // "cpar"
    public var paragraphStyles: ICCElements {return self.elements(0x63505354) as! ICCElements} // "cPST"
    public var pathItems: ICCElements {return self.elements(0x63615041) as! ICCElements} // "caPA"
    public var pathPointInfo: ICCElements {return self.elements(0x74534547) as! ICCElements} // "tSEG"
    public var pathPoints: ICCElements {return self.elements(0x63615053) as! ICCElements} // "caPS"
    public var patternColorInfo: ICCElements {return self.elements(0x74505469) as! ICCElements} // "tPTi"
    public var patterns: ICCElements {return self.elements(0x63615054) as! ICCElements} // "caPT"
    public var PDFOptions: ICCElements {return self.elements(0x744f5044) as! ICCElements} // "tOPD"
    public var PDFSaveOptions: ICCElements {return self.elements(0x7470536f) as! ICCElements} // "tpSo"
    public var PhotoshopExportOptions: ICCElements {return self.elements(0x74455053) as! ICCElements} // "tEPS"
    public var PhotoshopOptions: ICCElements {return self.elements(0x744f4f50) as! ICCElements} // "tOOP"
    public var placedItems: ICCElements {return self.elements(0x6361504c) as! ICCElements} // "caPL"
    public var pluginItems: ICCElements {return self.elements(0x63504c47) as! ICCElements} // "cPLG"
    public var PNG24ExportOptions: ICCElements {return self.elements(0x74503234) as! ICCElements} // "tP24"
    public var PNG8ExportOptions: ICCElements {return self.elements(0x74504e38) as! ICCElements} // "tPN8"
    public var polygon: ICCElements {return self.elements(0x73685047) as! ICCElements} // "shPG"
    public var postscriptOptions: ICCElements {return self.elements(0x74505053) as! ICCElements} // "tPPS"
    public var PPDFile: ICCElements {return self.elements(0x74505044) as! ICCElements} // "tPPD"
    public var PPDProperties: ICCElements {return self.elements(0x74504449) as! ICCElements} // "tPDI"
    public var printer: ICCElements {return self.elements(0x74505254) as! ICCElements} // "tPRT"
    public var printerProperties: ICCElements {return self.elements(0x74504946) as! ICCElements} // "tPIF"
    public var printOptions: ICCElements {return self.elements(0x74504f50) as! ICCElements} // "tPOP"
    public var rasterEffectOptions: ICCElements {return self.elements(0x7452454f) as! ICCElements} // "tREO"
    public var rasterItems: ICCElements {return self.elements(0x63615241) as! ICCElements} // "caRA"
    public var rasterizeOptions: ICCElements {return self.elements(0x7452534f) as! ICCElements} // "tRSO"
    public var rectangle: ICCElements {return self.elements(0x73685243) as! ICCElements} // "shRC"
    public var RGBColorInfo: ICCElements {return self.elements(0x74524769) as! ICCElements} // "tRGi"
    public var roundedRectangle: ICCElements {return self.elements(0x73685252) as! ICCElements} // "shRR"
    public var screenProperties: ICCElements {return self.elements(0x74505349) as! ICCElements} // "tPSI"
    public var screenSpotFunction: ICCElements {return self.elements(0x74505350) as! ICCElements} // "tPSP"
    public var separationScreen: ICCElements {return self.elements(0x74505343) as! ICCElements} // "tPSC"
    public var spotColorInfo: ICCElements {return self.elements(0x74435369) as! ICCElements} // "tCSi"
    public var spots: ICCElements {return self.elements(0x63614343) as! ICCElements} // "caCC"
    public var star: ICCElements {return self.elements(0x73685354) as! ICCElements} // "shST"
    public var stories: ICCElements {return self.elements(0x6353544f) as! ICCElements} // "cSTO"
    public var SVGExportOptions: ICCElements {return self.elements(0x74454f53) as! ICCElements} // "tEOS"
    public var swatches: ICCElements {return self.elements(0x63615357) as! ICCElements} // "caSW"
    public var swatchgroups: ICCElements {return self.elements(0x63534772) as! ICCElements} // "cSGr"
    public var symbolItems: ICCElements {return self.elements(0x63615349) as! ICCElements} // "caSI"
    public var symbols: ICCElements {return self.elements(0x63615359) as! ICCElements} // "caSY"
    public var tabStopInfo: ICCElements {return self.elements(0x74545369) as! ICCElements} // "tTSi"
    public var tags: ICCElements {return self.elements(0x63615447) as! ICCElements} // "caTG"
    public var text: ICCElements {return self.elements(0x63747874) as! ICCElements} // "ctxt"
    public var textFonts: ICCElements {return self.elements(0x63545866) as! ICCElements} // "cTXf"
    public var textFrames: ICCElements {return self.elements(0x63545861) as! ICCElements} // "cTXa"
    public var TIFFExportOptions: ICCElements {return self.elements(0x74454154) as! ICCElements} // "tEAT"
    public var tracings: ICCElements {return self.elements(0x63615472) as! ICCElements} // "caTr"
    public var variables: ICCElements {return self.elements(0x74566172) as! ICCElements} // "tVar"
    public var views: ICCElements {return self.elements(0x63614456) as! ICCElements} // "caDV"
    public var word: ICCElements {return self.elements(0x63776f72) as! ICCElements} // "cwor"
}


/******************************************************************************/
// Specifier subclasses add app-specific extensions

// beginning/end/before/after
public class ICCInsertion: InsertionSpecifier, ICCCommand {}


// by index/name/id/previous/next
// first/middle/last/any
public class ICCObject: ObjectSpecifier, ICCQuery {
    public typealias InsertionSpecifierType = ICCInsertion
    public typealias ObjectSpecifierType = ICCObject
    public typealias ElementsSpecifierType = ICCElements
}

// by range/test
// all
public class ICCElements: ICCObject, ElementsSpecifierExtension {}

// App/Con/Its
public class ICCRoot: RootSpecifier, ICCQuery, RootSpecifierExtension {
    public typealias InsertionSpecifierType = ICCInsertion
    public typealias ObjectSpecifierType = ICCObject
    public typealias ElementsSpecifierType = ICCElements
    public override class var untargetedAppData: AppData { return gUntargetedAppData }
}

// application
public class IllustratorCC: ICCRoot, ApplicationExtension {
    public convenience init(launchOptions: LaunchOptions = DefaultLaunchOptions, relaunchMode: RelaunchMode = DefaultRelaunchMode) {
        self.init(rootObject: AppRootDesc, appData: type(of:self).untargetedAppData.targetedCopy(
                .bundleIdentifier("com.adobe.illustrator", true), launchOptions: launchOptions, relaunchMode: relaunchMode))
    }
}

// App/Con/Its root objects used to construct untargeted specifiers; these can be used to construct specifiers for use in commands, though cannot send commands themselves

public let ICCApp = gUntargetedAppData.rootObjects.app as! ICCRoot
public let ICCCon = gUntargetedAppData.rootObjects.con as! ICCRoot
public let ICCIts = gUntargetedAppData.rootObjects.its as! ICCRoot

