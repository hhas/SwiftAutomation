//
//  FinderGlue.swift
//  Finder.app 10.10.5
//  SwiftAE.framework 0.7.0
//  `aeglue -s -r Finder`
//


import Foundation


/******************************************************************************/
// Untargeted AppData instance used in App, Con, Its roots; also used by Application constructors to create their own targeted AppData instances

private let gNullAppData = AppData(glueInfo: GlueInfo(insertionSpecifierType: FINInsertion.self, objectSpecifierType: FINObject.self,
                                                      elementsSpecifierType: FINElements.self, rootSpecifierType: FINRoot.self,
                                                      symbolType: Symbol.self, formatter: gSpecifierFormatter))


/******************************************************************************/
// Specifier formatter

private let gSpecifierFormatter = SpecifierFormatter(applicationClassName: "Finder",
                                                     classNamePrefix: "FIN",
                                                     propertyNames: [
                                                                     0x70667270: "FinderPreferences", // 'pfrp'
                                                                     0x7055524c: "URL", // 'pURL'
                                                                     0x69736162: "acceptsHighLevelEvents", // 'isab'
                                                                     0x72657674: "acceptsRemoteEvents", // 'revt'
                                                                     0x70736e78: "allNameExtensionsShowing", // 'psnx'
                                                                     0x61707066: "applicationFile", // 'appf'
                                                                     0x69617272: "arrangement", // 'iarr'
                                                                     0x636f6c72: "backgroundColor", // 'colr'
                                                                     0x69626b67: "backgroundPicture", // 'ibkg'
                                                                     0x70626e64: "bounds", // 'pbnd'
                                                                     0x7366737a: "calculatesFolderSizes", // 'sfsz'
                                                                     0x63617061: "capacity", // 'capa'
                                                                     0x70636c73: "class_", // 'pcls'
                                                                     0x70636c69: "clipboard", // 'pcli'
                                                                     0x6c776e64: "clippingWindow", // 'lwnd'
                                                                     0x68636c62: "closeable", // 'hclb'
                                                                     0x77736864: "collapsed", // 'wshd'
                                                                     0x63766f70: "columnViewOptions", // 'cvop'
                                                                     0x636f6d74: "comment", // 'comt'
                                                                     0x70657863: "completelyExpanded", // 'pexc'
                                                                     0x70636d70: "computerContainer", // 'pcmp'
                                                                     0x63746e72: "container", // 'ctnr'
                                                                     0x63776e64: "containerWindow", // 'cwnd'
                                                                     0x61736364: "creationDate", // 'ascd'
                                                                     0x66637274: "creatorType", // 'fcrt'
                                                                     0x70616e6c: "currentPanel", // 'panl'
                                                                     0x70766577: "currentView", // 'pvew'
                                                                     0x64656c61: "delayBeforeSpringing", // 'dela'
                                                                     0x64736372: "description_", // 'dscr'
                                                                     0x64616669: "deskAccessoryFile", // 'dafi'
                                                                     0x6465736b: "desktop", // 'desk'
                                                                     0x64706963: "desktopPicture", // 'dpic'
                                                                     0x64706f73: "desktopPosition", // 'dpos'
                                                                     0x70647376: "desktopShowsConnectedServers", // 'pdsv'
                                                                     0x70656864: "desktopShowsExternalHardDisks", // 'pehd'
                                                                     0x70646864: "desktopShowsHardDisks", // 'pdhd'
                                                                     0x7064726d: "desktopShowsRemovableMedia", // 'pdrm'
                                                                     0x64737072: "disclosesPreviewPane", // 'dspr'
                                                                     0x63646973: "disk", // 'cdis'
                                                                     0x646e616d: "displayedName", // 'dnam'
                                                                     0x6973656a: "ejectable", // 'isej'
                                                                     0x65637473: "entireContents", // 'ects'
                                                                     0x67737470: "everyonesPrivileges", // 'gstp'
                                                                     0x70657861: "expandable", // 'pexa'
                                                                     0x70657870: "expanded", // 'pexp'
                                                                     0x68696478: "extensionHidden", // 'hidx'
                                                                     0x66696c65: "file", // 'file'
                                                                     0x61737479: "fileType", // 'asty'
                                                                     0x6973666c: "floating", // 'isfl'
                                                                     0x706f6e74: "foldersOpenInNewTabs", // 'pont'
                                                                     0x706f6e77: "foldersOpenInNewWindows", // 'ponw'
                                                                     0x73707267: "foldersSpringOpen", // 'sprg'
                                                                     0x64666d74: "format", // 'dfmt'
                                                                     0x66727370: "freeSpace", // 'frsp'
                                                                     0x70697366: "frontmost", // 'pisf'
                                                                     0x73677270: "group", // 'sgrp'
                                                                     0x67707072: "groupPrivileges", // 'gppr'
                                                                     0x68736372: "hasScriptingTerminology", // 'hscr'
                                                                     0x686f6d65: "home", // 'home'
                                                                     0x69696d67: "icon", // 'iimg'
                                                                     0x6c766973: "iconSize", // 'lvis'
                                                                     0x69636f70: "iconViewOptions", // 'icop'
                                                                     0x49442020: "id", // 'ID  '
                                                                     0x69677072: "ignorePrivileges", // 'igpr'
                                                                     0x70696478: "index", // 'pidx'
                                                                     0x69776e64: "informationWindow", // 'iwnd'
                                                                     0x70696e73: "insertionLocation", // 'pins'
                                                                     0x636f626a: "item", // 'cobj'
                                                                     0x4a726e6c: "journalingEnabled", // 'Jrnl'
                                                                     0x6b696e64: "kind", // 'kind'
                                                                     0x6c616269: "labelIndex", // 'labi'
                                                                     0x6c706f73: "labelPosition", // 'lpos'
                                                                     0x696c3332: "large32BitIcon", // 'il32'
                                                                     0x69636c34: "large4BitIcon", // 'icl4'
                                                                     0x69636c38: "large8BitIcon", // 'icl8'
                                                                     0x6c386d6b: "large8BitMask", // 'l8mk'
                                                                     0x49434e23: "largeMonochromeIconAndMask", // 'ICN#'
                                                                     0x6c766f70: "listViewOptions", // 'lvop'
                                                                     0x69737276: "localVolume", // 'isrv'
                                                                     0x696c6f63: "location", // 'iloc'
                                                                     0x61736c6b: "locked", // 'aslk'
                                                                     0x636c776d: "maximumWidth", // 'clwm'
                                                                     0x6d707274: "minimumSize", // 'mprt'
                                                                     0x636c776e: "minimumWidth", // 'clwn'
                                                                     0x706d6f64: "modal", // 'pmod'
                                                                     0x61736d6f: "modificationDate", // 'asmo'
                                                                     0x706e616d: "name", // 'pnam'
                                                                     0x6e6d7874: "nameExtension", // 'nmxt'
                                                                     0x706e7774: "newWindowTarget", // 'pnwt'
                                                                     0x706f6376: "newWindowsOpenInColumnView", // 'pocv'
                                                                     0x436c7363: "opensInClassic", // 'Clsc'
                                                                     0x6f726967: "originalItem", // 'orig'
                                                                     0x736f776e: "owner", // 'sown'
                                                                     0x6f776e72: "ownerPrivileges", // 'ownr'
                                                                     0x70757364: "partitionSpaceUsed", // 'pusd'
                                                                     0x70687973: "physicalSize", // 'phys'
                                                                     0x706f736e: "position", // 'posn'
                                                                     0x76657232: "productVersion", // 'ver2'
                                                                     0x70414c4c: "properties", // 'pALL'
                                                                     0x7072737a: "resizable", // 'prsz'
                                                                     0x73656c65: "selection", // 'sele'
                                                                     0x73686963: "showsIcon", // 'shic'
                                                                     0x70727677: "showsIconPreview", // 'prvw'
                                                                     0x6d6e666f: "showsItemInfo", // 'mnfo'
                                                                     0x73687072: "showsPreviewColumn", // 'shpr'
                                                                     0x73627769: "sidebarWidth", // 'sbwi'
                                                                     0x7074737a: "size", // 'ptsz'
                                                                     0x69733332: "small32BitIcon", // 'is32'
                                                                     0x69637334: "small4BitIcon", // 'ics4'
                                                                     0x69637338: "small8BitIcon", // 'ics8'
                                                                     0x69637323: "smallMonochromeIconAndMask", // 'ics#'
                                                                     0x73727463: "sortColumn", // 'srtc'
                                                                     0x736f7264: "sortDirection", // 'sord'
                                                                     0x69737464: "startup", // 'istd'
                                                                     0x7364736b: "startupDisk", // 'sdsk'
                                                                     0x70737064: "stationery", // 'pspd'
                                                                     0x73747669: "statusbarVisible", // 'stvi'
                                                                     0x73707274: "suggestedSize", // 'sprt'
                                                                     0x66767467: "target", // 'fvtg'
                                                                     0x6673697a: "textSize", // 'fsiz'
                                                                     0x70746974: "titled", // 'ptit'
                                                                     0x74627669: "toolbarVisible", // 'tbvi'
                                                                     0x61707074: "totalPartitionSize", // 'appt'
                                                                     0x74727368: "trash", // 'trsh'
                                                                     0x75726474: "usesRelativeDates", // 'urdt'
                                                                     0x76657273: "version_", // 'vers'
                                                                     0x70766973: "visible", // 'pvis'
                                                                     0x7761726e: "warnsBeforeEmptying", // 'warn'
                                                                     0x636c7764: "width", // 'clwd'
                                                                     0x6377696e: "window", // 'cwin'
                                                                     0x69737a6d: "zoomable", // 'iszm'
                                                                     0x707a756d: "zoomed", // 'pzum'
                                                     ],
                                                     elementsNames: [
                                                                     0x62726f77: "FinderWindows", // 'brow'
                                                                     0x616c6961: "aliasFiles", // 'alia'
                                                                     0x616c7374: "aliasLists", // 'alst'
                                                                     0x61707066: "applicationFiles", // 'appf'
                                                                     0x70636170: "applicationProcesses", // 'pcap'
                                                                     0x63617070: "applications", // 'capp'
                                                                     0x6c776e64: "clippingWindows", // 'lwnd'
                                                                     0x636c7066: "clippings", // 'clpf'
                                                                     0x63766f70: "columnViewOptionss", // 'cvop'
                                                                     0x6c76636c: "columns", // 'lvcl'
                                                                     0x63636d70: "computerObjects", // 'ccmp'
                                                                     0x63746e72: "containers", // 'ctnr'
                                                                     0x70636461: "deskAccessoryProcesses", // 'pcda'
                                                                     0x6364736b: "desktopObjects", // 'cdsk'
                                                                     0x646b7477: "desktopWindows", // 'dktw'
                                                                     0x63646973: "disks", // 'cdis'
                                                                     0x646f6366: "documentFiles", // 'docf'
                                                                     0x66696c65: "files", // 'file'
                                                                     0x63666f6c: "folders", // 'cfol'
                                                                     0x6966616d: "iconFamilys", // 'ifam'
                                                                     0x69636f70: "iconViewOptionss", // 'icop'
                                                                     0x69776e64: "informationWindows", // 'iwnd'
                                                                     0x696e6c66: "internetLocationFiles", // 'inlf'
                                                                     0x636f626a: "items", // 'cobj'
                                                                     0x636c626c: "labels", // 'clbl'
                                                                     0x6c766f70: "listViewOptionss", // 'lvop'
                                                                     0x7061636b: "packages", // 'pack'
                                                                     0x70776e64: "preferencesWindows", // 'pwnd'
                                                                     0x63707266: "preferencess", // 'cprf'
                                                                     0x70726373: "processes", // 'prcs'
                                                                     0x63747273: "trashObjects", // 'ctrs'
                                                                     0x6377696e: "windows", // 'cwin'
                                                     ])


/******************************************************************************/
// Symbol subclass defines static type/enum/property constants based on Finder.app's terminology

public class FINSymbol: Symbol {

    override var typeAliasName: String {return "FIN"}

    public override class func symbol(code: OSType, type: OSType = typeType, descriptor: NSAppleEventDescriptor? = nil) -> FINSymbol {
        switch (code) {
        case 0x70616476: return self.AdvancedPreferencesPanel // 'padv'
        case 0x64667068: return self.ApplePhotoFormat // 'dfph'
        case 0x64666173: return self.AppleShareFormat // 'dfas'
        case 0x61706e6c: return self.ApplicationPanel // 'apnl'
        case 0x61707220: return self.April // 'apr '
        case 0x61756720: return self.August // 'aug '
        case 0x62706e6c: return self.BurningPanel // 'bpnl'
        case 0x63737472: return self.CString // 'cstr'
        case 0x63706e6c: return self.CommentsPanel // 'cpnl'
        case 0x63696e6c: return self.ContentIndexPanel // 'cinl'
        case 0x64656320: return self.December // 'dec '
        case 0x45505320: return self.EPSPicture // 'EPS '
        case 0x64666674: return self.FTPFormat // 'dfft'
        case 0x66656220: return self.February // 'feb '
        case 0x70667270: return self.FinderPreferences // 'pfrp'
        case 0x62726f77: return self.FinderWindow // 'brow'
        case 0x66726920: return self.Friday // 'fri '
        case 0x47494666: return self.GIFPicture // 'GIFf'
        case 0x67706e6c: return self.GeneralInformationPanel // 'gpnl'
        case 0x70676e70: return self.GeneralPreferencesPanel // 'pgnp'
        case 0x64666873: return self.HighSierraFormat // 'dfhs'
        case 0x64663936: return self.ISO9660Format // 'df96'
        case 0x4a504547: return self.JPEGPicture // 'JPEG'
        case 0x6a616e20: return self.January // 'jan '
        case 0x6a756c20: return self.July // 'jul '
        case 0x6a756e20: return self.June // 'jun '
        case 0x706c6270: return self.LabelPreferencesPanel // 'plbp'
        case 0x706b6c67: return self.LanguagesPanel // 'pklg'
        case 0x64666d73: return self.MSDOSFormat // 'dfms'
        case 0x6466682b: return self.MacOSExtendedFormat // 'dfh+'
        case 0x64666866: return self.MacOSFormat // 'dfhf'
        case 0x6d617220: return self.March // 'mar '
        case 0x6d617920: return self.May // 'may '
        case 0x6d706e6c: return self.MemoryPanel // 'mpnl'
        case 0x6d6f6e20: return self.Monday // 'mon '
        case 0x6d696e6c: return self.MoreInfoPanel // 'minl'
        case 0x64666e66: return self.NFSFormat // 'dfnf'
        case 0x64666e74: return self.NTFSFormat // 'dfnt'
        case 0x6e706e6c: return self.NameAndExtensionPanel // 'npnl'
        case 0x6e6f7620: return self.November // 'nov '
        case 0x6f637420: return self.October // 'oct '
        case 0x50494354: return self.PICTPicture // 'PICT'
        case 0x64667075: return self.PacketWrittenUDFFormat // 'dfpu'
        case 0x70737472: return self.PascalString // 'pstr'
        case 0x706b7067: return self.PluginsPanel // 'pkpg'
        case 0x76706e6c: return self.PreviewPanel // 'vpnl'
        case 0x64667072: return self.ProDOSFormat // 'dfpr'
        case 0x64667174: return self.QuickTakeFormat // 'dfqt'
        case 0x74723136: return self.RGB16Color // 'tr16'
        case 0x74723936: return self.RGB96Color // 'tr96'
        case 0x63524742: return self.RGBColor // 'cRGB'
        case 0x73617420: return self.Saturday // 'sat '
        case 0x73657020: return self.September // 'sep '
        case 0x73706e6c: return self.SharingPanel // 'spnl'
        case 0x70736964: return self.SidebarPreferencesPanel // 'psid'
        case 0x73686e6c: return self.SimpleHeaderPanel // 'shnl'
        case 0x73756e20: return self.Sunday // 'sun '
        case 0x54494646: return self.TIFFPicture // 'TIFF'
        case 0x74687520: return self.Thursday // 'thu '
        case 0x74756520: return self.Tuesday // 'tue '
        case 0x64667564: return self.UDFFormat // 'dfud'
        case 0x64667566: return self.UFSFormat // 'dfuf'
        case 0x7055524c: return self.URL // 'pURL'
        case 0x75743136: return self.UTF16Text // 'ut16'
        case 0x75746638: return self.UTF8Text // 'utf8'
        case 0x75747874: return self.UnicodeText // 'utxt'
        case 0x64667764: return self.WebDAVFormat // 'dfwd'
        case 0x77656420: return self.Wednesday // 'wed '
        case 0x64666163: return self.XsanFormat // 'dfac'
        case 0x69736162: return self.acceptsHighLevelEvents // 'isab'
        case 0x72657674: return self.acceptsRemoteEvents // 'revt'
        case 0x616c6973: return self.alias // 'alis'
        case 0x616c6961: return self.aliasFile // 'alia'
        case 0x616c7374: return self.aliasList // 'alst'
        case 0x70736e78: return self.allNameExtensionsShowing // 'psnx'
        case 0x2a2a2a2a: return self.anything // '****'
        case 0x63617070: return self.application // 'capp'
        case 0x62756e64: return self.applicationBundleID // 'bund'
        case 0x61707066: return self.applicationFile // 'appf'
        case 0x70636170: return self.applicationProcess // 'pcap'
        case 0x726d7465: return self.applicationResponses // 'rmte'
        case 0x7369676e: return self.applicationSignature // 'sign'
        case 0x6170726c: return self.applicationURL // 'aprl'
        case 0x63647461: return self.arrangedByCreationDate // 'cdta'
        case 0x6b696e61: return self.arrangedByKind // 'kina'
        case 0x6c616261: return self.arrangedByLabel // 'laba'
        case 0x6d647461: return self.arrangedByModificationDate // 'mdta'
        case 0x6e616d61: return self.arrangedByName // 'nama'
        case 0x73697a61: return self.arrangedBySize // 'siza'
        case 0x69617272: return self.arrangement // 'iarr'
        case 0x61736b20: return self.ask // 'ask '
        case 0x64666175: return self.audioFormat // 'dfau'
        case 0x636f6c72: return self.backgroundColor // 'colr'
        case 0x69626b67: return self.backgroundPicture // 'ibkg'
        case 0x62657374: return self.best // 'best'
        case 0x626f6f6c: return self.boolean // 'bool'
        case 0x6c626f74: return self.bottom // 'lbot'
        case 0x71647274: return self.boundingRectangle // 'qdrt'
        case 0x70626e64: return self.bounds // 'pbnd'
        case 0x7366737a: return self.calculatesFolderSizes // 'sfsz'
        case 0x63617061: return self.capacity // 'capa'
        case 0x63617365: return self.case_ // 'case'
        case 0x636d7472: return self.centimeters // 'cmtr'
        case 0x67636c69: return self.classInfo // 'gcli'
        case 0x70636c73: return self.class_ // 'pcls'
        case 0x70636c69: return self.clipboard // 'pcli'
        case 0x636c7066: return self.clipping // 'clpf'
        case 0x6c776e64: return self.clippingWindow // 'lwnd'
        case 0x68636c62: return self.closeable // 'hclb'
        case 0x77736864: return self.collapsed // 'wshd'
        case 0x636c7274: return self.colorTable // 'clrt'
        case 0x6c76636c: return self.column // 'lvcl'
        case 0x636c7677: return self.columnView // 'clvw'
        case 0x63766f70: return self.columnViewOptions // 'cvop'
        case 0x636f6d74: return self.comment // 'comt'
        case 0x656c7343: return self.commentColumn // 'elsC'
        case 0x70657863: return self.completelyExpanded // 'pexc'
        case 0x70636d70: return self.computerContainer // 'pcmp'
        case 0x63636d70: return self.computerObject // 'ccmp'
        case 0x63746e72: return self.container // 'ctnr'
        case 0x63776e64: return self.containerWindow // 'cwnd'
        case 0x61736364: return self.creationDate // 'ascd'
        case 0x656c7363: return self.creationDateColumn // 'elsc'
        case 0x66637274: return self.creatorType // 'fcrt'
        case 0x63636d74: return self.cubicCentimeters // 'ccmt'
        case 0x63666574: return self.cubicFeet // 'cfet'
        case 0x6375696e: return self.cubicInches // 'cuin'
        case 0x636d6574: return self.cubicMeters // 'cmet'
        case 0x63797264: return self.cubicYards // 'cyrd'
        case 0x70616e6c: return self.currentPanel // 'panl'
        case 0x70766577: return self.currentView // 'pvew'
        case 0x74646173: return self.dashStyle // 'tdas'
        case 0x72646174: return self.data // 'rdat'
        case 0x6c647420: return self.date // 'ldt '
        case 0x6465636d: return self.decimalStruct // 'decm'
        case 0x64656763: return self.degreesCelsius // 'degc'
        case 0x64656766: return self.degreesFahrenheit // 'degf'
        case 0x6465676b: return self.degreesKelvin // 'degk'
        case 0x64656c61: return self.delayBeforeSpringing // 'dela'
        case 0x64736372: return self.description_ // 'dscr'
        case 0x64616669: return self.deskAccessoryFile // 'dafi'
        case 0x70636461: return self.deskAccessoryProcess // 'pcda'
        case 0x6465736b: return self.desktop // 'desk'
        case 0x6364736b: return self.desktopObject // 'cdsk'
        case 0x64706963: return self.desktopPicture // 'dpic'
        case 0x64706f73: return self.desktopPosition // 'dpos'
        case 0x70647376: return self.desktopShowsConnectedServers // 'pdsv'
        case 0x70656864: return self.desktopShowsExternalHardDisks // 'pehd'
        case 0x70646864: return self.desktopShowsHardDisks // 'pdhd'
        case 0x7064726d: return self.desktopShowsRemovableMedia // 'pdrm'
        case 0x646b7477: return self.desktopWindow // 'dktw'
        case 0x64696163: return self.diacriticals // 'diac'
        case 0x64737072: return self.disclosesPreviewPane // 'dspr'
        case 0x63646973: return self.disk // 'cdis'
        case 0x646e616d: return self.displayedName // 'dnam'
        case 0x646f6366: return self.documentFile // 'docf'
        case 0x636f6d70: return self.doubleInteger // 'comp'
        case 0x6973656a: return self.ejectable // 'isej'
        case 0x656c696e: return self.elementInfo // 'elin'
        case 0x656e6373: return self.encodedString // 'encs'
        case 0x65637473: return self.entireContents // 'ects'
        case 0x656e756d: return self.enumerator // 'enum'
        case 0x6576696e: return self.eventInfo // 'evin'
        case 0x67737470: return self.everyonesPrivileges // 'gstp'
        case 0x70657861: return self.expandable // 'pexa'
        case 0x70657870: return self.expanded // 'pexp'
        case 0x65787061: return self.expansion // 'expa'
        case 0x65787465: return self.extendedFloat // 'exte'
        case 0x68696478: return self.extensionHidden // 'hidx'
        case 0x66656574: return self.feet // 'feet'
        case 0x66696c65: return self.file // 'file'
        case 0x66737266: return self.fileRef // 'fsrf'
        case 0x66737320: return self.fileSpecification // 'fss '
        case 0x61737479: return self.fileType // 'asty'
        case 0x6675726c: return self.fileURL // 'furl'
        case 0x66697864: return self.fixed // 'fixd'
        case 0x66706e74: return self.fixedPoint // 'fpnt'
        case 0x66726374: return self.fixedRectangle // 'frct'
        case 0x646f7562: return self.float // 'doub'
        case 0x6c64626c: return self.float128bit // 'ldbl'
        case 0x6973666c: return self.floating // 'isfl'
        case 0x666c7677: return self.flowView // 'flvw'
        case 0x63666f6c: return self.folder // 'cfol'
        case 0x706f6e74: return self.foldersOpenInNewTabs // 'pont'
        case 0x706f6e77: return self.foldersOpenInNewWindows // 'ponw'
        case 0x73707267: return self.foldersSpringOpen // 'sprg'
        case 0x64666d74: return self.format // 'dfmt'
        case 0x66727370: return self.freeSpace // 'frsp'
        case 0x70697366: return self.frontmost // 'pisf'
        case 0x67616c6e: return self.gallons // 'galn'
        case 0x6772616d: return self.grams // 'gram'
        case 0x63677478: return self.graphicText // 'cgtx'
        case 0x73677270: return self.group // 'sgrp'
        case 0x67707072: return self.groupPrivileges // 'gppr'
        case 0x67727677: return self.groupView // 'grvw'
        case 0x68736372: return self.hasScriptingTerminology // 'hscr'
        case 0x686f6d65: return self.home // 'home'
        case 0x68797068: return self.hyphens // 'hyph'
        case 0x69696d67: return self.icon // 'iimg'
        case 0x6966616d: return self.iconFamily // 'ifam'
        case 0x6c766973: return self.iconSize // 'lvis'
        case 0x69636e76: return self.iconView // 'icnv'
        case 0x69636f70: return self.iconViewOptions // 'icop'
        case 0x49442020: return self.id // 'ID  '
        case 0x69677072: return self.ignorePrivileges // 'igpr'
        case 0x696e6368: return self.inches // 'inch'
        case 0x70696478: return self.index // 'pidx'
        case 0x69776e64: return self.informationWindow // 'iwnd'
        case 0x70696e73: return self.insertionLocation // 'pins'
        case 0x6c6f6e67: return self.integer // 'long'
        case 0x69747874: return self.internationalText // 'itxt'
        case 0x696e746c: return self.internationalWritingCode // 'intl'
        case 0x696e6c66: return self.internetLocationFile // 'inlf'
        case 0x636f626a: return self.item // 'cobj'
        case 0x4a726e6c: return self.journalingEnabled // 'Jrnl'
        case 0x6b706964: return self.kernelProcessID // 'kpid'
        case 0x6b67726d: return self.kilograms // 'kgrm'
        case 0x6b6d7472: return self.kilometers // 'kmtr'
        case 0x6b696e64: return self.kind // 'kind'
        case 0x656c736b: return self.kindColumn // 'elsk'
        case 0x636c626c: return self.label // 'clbl'
        case 0x656c736c: return self.labelColumn // 'elsl'
        case 0x6c616269: return self.labelIndex // 'labi'
        case 0x6c706f73: return self.labelPosition // 'lpos'
        case 0x6c676963: return self.large // 'lgic'
        case 0x696c3332: return self.large32BitIcon // 'il32'
        case 0x69636c34: return self.large4BitIcon // 'icl4'
        case 0x69636c38: return self.large8BitIcon // 'icl8'
        case 0x6c386d6b: return self.large8BitMask // 'l8mk'
        case 0x49434e23: return self.largeMonochromeIconAndMask // 'ICN#'
        case 0x6c697374: return self.list // 'list'
        case 0x6c737677: return self.listView // 'lsvw'
        case 0x6c766f70: return self.listViewOptions // 'lvop'
        case 0x6c697472: return self.liters // 'litr'
        case 0x69737276: return self.localVolume // 'isrv'
        case 0x696c6f63: return self.location // 'iloc'
        case 0x696e736c: return self.locationReference // 'insl'
        case 0x61736c6b: return self.locked // 'aslk'
        case 0x6c667864: return self.longFixed // 'lfxd'
        case 0x6c667074: return self.longFixedPoint // 'lfpt'
        case 0x6c667263: return self.longFixedRectangle // 'lfrc'
        case 0x6c706e74: return self.longPoint // 'lpnt'
        case 0x6c726374: return self.longRectangle // 'lrct'
        case 0x706f7274: return self.machPort // 'port'
        case 0x6d616368: return self.machine // 'mach'
        case 0x6d4c6f63: return self.machineLocation // 'mLoc'
        case 0x636c776d: return self.maximumWidth // 'clwm'
        case 0x6d657472: return self.meters // 'metr'
        case 0x6d696c65: return self.miles // 'mile'
        case 0x6d696963: return self.mini // 'miic'
        case 0x6d707274: return self.minimumSize // 'mprt'
        case 0x636c776e: return self.minimumWidth // 'clwn'
        case 0x6d736e67: return self.missingValue // 'msng'
        case 0x706d6f64: return self.modal // 'pmod'
        case 0x61736d6f: return self.modificationDate // 'asmo'
        case 0x656c736d: return self.modificationDateColumn // 'elsm'
        case 0x706e616d: return self.name // 'pnam'
        case 0x656c736e: return self.nameColumn // 'elsn'
        case 0x6e6d7874: return self.nameExtension // 'nmxt'
        case 0x706e7774: return self.newWindowTarget // 'pnwt'
        case 0x706f6376: return self.newWindowsOpenInColumnView // 'pocv'
        case 0x6e6f2020: return self.no // 'no  '
        case 0x6e6f6e65: return self.none_ // 'none'
        case 0x736e726d: return self.normal // 'snrm'
        case 0x6e617272: return self.notArranged // 'narr'
        case 0x6e756c6c: return self.null // 'null'
        case 0x6e756d65: return self.numericStrings // 'nume'
        case 0x436c7363: return self.opensInClassic // 'Clsc'
        case 0x6f726967: return self.originalItem // 'orig'
        case 0x6f7a7320: return self.ounces // 'ozs '
        case 0x736f776e: return self.owner // 'sown'
        case 0x6f776e72: return self.ownerPrivileges // 'ownr'
        case 0x7061636b: return self.package // 'pack'
        case 0x706d696e: return self.parameterInfo // 'pmin'
        case 0x70757364: return self.partitionSpaceUsed // 'pusd'
        case 0x74706d6d: return self.pixelMapRecord // 'tpmm'
        case 0x51447074: return self.point // 'QDpt'
        case 0x706f736e: return self.position // 'posn'
        case 0x6c627320: return self.pounds // 'lbs '
        case 0x63707266: return self.preferences // 'cprf'
        case 0x70776e64: return self.preferencesWindow // 'pwnd'
        case 0x70726373: return self.process // 'prcs'
        case 0x70736e20: return self.processSerialNumber // 'psn '
        case 0x76657232: return self.productVersion // 'ver2'
        case 0x70414c4c: return self.properties // 'pALL'
        case 0x70726f70: return self.property // 'prop'
        case 0x70696e66: return self.propertyInfo // 'pinf'
        case 0x70756e63: return self.punctuation // 'punc'
        case 0x71727473: return self.quarts // 'qrts'
        case 0x72656164: return self.readOnly // 'read'
        case 0x72647772: return self.readWrite // 'rdwr'
        case 0x7265636f: return self.record // 'reco'
        case 0x6f626a20: return self.reference // 'obj '
        case 0x7072737a: return self.resizable // 'prsz'
        case 0x73727673: return self.reversed // 'srvs'
        case 0x6c726774: return self.right_ // 'lrgt'
        case 0x74726f74: return self.rotation // 'trot'
        case 0x73637074: return self.script // 'scpt'
        case 0x73656c65: return self.selection // 'sele'
        case 0x73696e67: return self.shortFloat // 'sing'
        case 0x73686f72: return self.shortInteger // 'shor'
        case 0x73686963: return self.showsIcon // 'shic'
        case 0x70727677: return self.showsIconPreview // 'prvw'
        case 0x6d6e666f: return self.showsItemInfo // 'mnfo'
        case 0x73687072: return self.showsPreviewColumn // 'shpr'
        case 0x73627769: return self.sidebarWidth // 'sbwi'
        case 0x7074737a: return self.size // 'ptsz'
        case 0x70687973: return self.size // 'phys'
        case 0x656c7373: return self.sizeColumn // 'elss'
        case 0x736d6963: return self.small // 'smic'
        case 0x69733332: return self.small32BitIcon // 'is32'
        case 0x69637334: return self.small4BitIcon // 'ics4'
        case 0x69637338: return self.small8BitIcon // 'ics8'
        case 0x69637323: return self.smallMonochromeIconAndMask // 'ics#'
        case 0x67726461: return self.snapToGrid // 'grda'
        case 0x73727463: return self.sortColumn // 'srtc'
        case 0x736f7264: return self.sortDirection // 'sord'
        case 0x73716674: return self.squareFeet // 'sqft'
        case 0x73716b6d: return self.squareKilometers // 'sqkm'
        case 0x7371726d: return self.squareMeters // 'sqrm'
        case 0x73716d69: return self.squareMiles // 'sqmi'
        case 0x73717964: return self.squareYards // 'sqyd'
        case 0x69737464: return self.startup // 'istd'
        case 0x7364736b: return self.startupDisk // 'sdsk'
        case 0x70737064: return self.stationery // 'pspd'
        case 0x73747669: return self.statusbarVisible // 'stvi'
        case 0x54455854: return self.string // 'TEXT'
        case 0x7374796c: return self.styledClipboardText // 'styl'
        case 0x53545854: return self.styledText // 'STXT'
        case 0x73757478: return self.styledUnicodeText // 'sutx'
        case 0x73707274: return self.suggestedSize // 'sprt'
        case 0x7375696e: return self.suiteInfo // 'suin'
        case 0x66767467: return self.target // 'fvtg'
        case 0x6673697a: return self.textSize // 'fsiz'
        case 0x74737479: return self.textStyleInfo // 'tsty'
        case 0x70746974: return self.titled // 'ptit'
        case 0x74627669: return self.toolbarVisible // 'tbvi'
        case 0x61707074: return self.totalPartitionSize // 'appt'
        case 0x74727368: return self.trash // 'trsh'
        case 0x63747273: return self.trashObject // 'ctrs'
        case 0x74797065: return self.typeClass // 'type'
        case 0x64663f3f: return self.unknownFormat // 'df??'
        case 0x6d61676e: return self.unsignedInteger // 'magn'
        case 0x75726474: return self.usesRelativeDates // 'urdt'
        case 0x656c7376: return self.versionColumn // 'elsv'
        case 0x76657273: return self.version_ // 'vers'
        case 0x70766973: return self.visible // 'pvis'
        case 0x7761726e: return self.warnsBeforeEmptying // 'warn'
        case 0x77686974: return self.whitespace // 'whit'
        case 0x636c7764: return self.width // 'clwd'
        case 0x6377696e: return self.window // 'cwin'
        case 0x77726974: return self.writeOnly // 'writ'
        case 0x70736374: return self.writingCode // 'psct'
        case 0x79617264: return self.yards // 'yard'
        case 0x79657320: return self.yes // 'yes '
        case 0x69737a6d: return self.zoomable // 'iszm'
        case 0x707a756d: return self.zoomed // 'pzum'
        default: return super.symbol(code, type: type, descriptor: descriptor) as! FINSymbol
        }
    }

    // Types/properties
    public static let April = FINSymbol(name: "April", code: 0x61707220, type: typeType) // 'apr '
    public static let August = FINSymbol(name: "August", code: 0x61756720, type: typeType) // 'aug '
    public static let CString = FINSymbol(name: "CString", code: 0x63737472, type: typeType) // 'cstr'
    public static let December = FINSymbol(name: "December", code: 0x64656320, type: typeType) // 'dec '
    public static let EPSPicture = FINSymbol(name: "EPSPicture", code: 0x45505320, type: typeType) // 'EPS '
    public static let February = FINSymbol(name: "February", code: 0x66656220, type: typeType) // 'feb '
    public static let FinderPreferences = FINSymbol(name: "FinderPreferences", code: 0x70667270, type: typeType) // 'pfrp'
    public static let FinderWindow = FINSymbol(name: "FinderWindow", code: 0x62726f77, type: typeType) // 'brow'
    public static let Friday = FINSymbol(name: "Friday", code: 0x66726920, type: typeType) // 'fri '
    public static let GIFPicture = FINSymbol(name: "GIFPicture", code: 0x47494666, type: typeType) // 'GIFf'
    public static let JPEGPicture = FINSymbol(name: "JPEGPicture", code: 0x4a504547, type: typeType) // 'JPEG'
    public static let January = FINSymbol(name: "January", code: 0x6a616e20, type: typeType) // 'jan '
    public static let July = FINSymbol(name: "July", code: 0x6a756c20, type: typeType) // 'jul '
    public static let June = FINSymbol(name: "June", code: 0x6a756e20, type: typeType) // 'jun '
    public static let March = FINSymbol(name: "March", code: 0x6d617220, type: typeType) // 'mar '
    public static let May = FINSymbol(name: "May", code: 0x6d617920, type: typeType) // 'may '
    public static let Monday = FINSymbol(name: "Monday", code: 0x6d6f6e20, type: typeType) // 'mon '
    public static let November = FINSymbol(name: "November", code: 0x6e6f7620, type: typeType) // 'nov '
    public static let October = FINSymbol(name: "October", code: 0x6f637420, type: typeType) // 'oct '
    public static let PICTPicture = FINSymbol(name: "PICTPicture", code: 0x50494354, type: typeType) // 'PICT'
    public static let PascalString = FINSymbol(name: "PascalString", code: 0x70737472, type: typeType) // 'pstr'
    public static let RGB16Color = FINSymbol(name: "RGB16Color", code: 0x74723136, type: typeType) // 'tr16'
    public static let RGB96Color = FINSymbol(name: "RGB96Color", code: 0x74723936, type: typeType) // 'tr96'
    public static let RGBColor = FINSymbol(name: "RGBColor", code: 0x63524742, type: typeType) // 'cRGB'
    public static let Saturday = FINSymbol(name: "Saturday", code: 0x73617420, type: typeType) // 'sat '
    public static let September = FINSymbol(name: "September", code: 0x73657020, type: typeType) // 'sep '
    public static let Sunday = FINSymbol(name: "Sunday", code: 0x73756e20, type: typeType) // 'sun '
    public static let TIFFPicture = FINSymbol(name: "TIFFPicture", code: 0x54494646, type: typeType) // 'TIFF'
    public static let Thursday = FINSymbol(name: "Thursday", code: 0x74687520, type: typeType) // 'thu '
    public static let Tuesday = FINSymbol(name: "Tuesday", code: 0x74756520, type: typeType) // 'tue '
    public static let URL = FINSymbol(name: "URL", code: 0x7055524c, type: typeType) // 'pURL'
    public static let UTF16Text = FINSymbol(name: "UTF16Text", code: 0x75743136, type: typeType) // 'ut16'
    public static let UTF8Text = FINSymbol(name: "UTF8Text", code: 0x75746638, type: typeType) // 'utf8'
    public static let UnicodeText = FINSymbol(name: "UnicodeText", code: 0x75747874, type: typeType) // 'utxt'
    public static let Wednesday = FINSymbol(name: "Wednesday", code: 0x77656420, type: typeType) // 'wed '
    public static let acceptsHighLevelEvents = FINSymbol(name: "acceptsHighLevelEvents", code: 0x69736162, type: typeType) // 'isab'
    public static let acceptsRemoteEvents = FINSymbol(name: "acceptsRemoteEvents", code: 0x72657674, type: typeType) // 'revt'
    public static let alias = FINSymbol(name: "alias", code: 0x616c6973, type: typeType) // 'alis'
    public static let aliasFile = FINSymbol(name: "aliasFile", code: 0x616c6961, type: typeType) // 'alia'
    public static let aliasList = FINSymbol(name: "aliasList", code: 0x616c7374, type: typeType) // 'alst'
    public static let allNameExtensionsShowing = FINSymbol(name: "allNameExtensionsShowing", code: 0x70736e78, type: typeType) // 'psnx'
    public static let anything = FINSymbol(name: "anything", code: 0x2a2a2a2a, type: typeType) // '****'
    public static let application = FINSymbol(name: "application", code: 0x63617070, type: typeType) // 'capp'
    public static let applicationBundleID = FINSymbol(name: "applicationBundleID", code: 0x62756e64, type: typeType) // 'bund'
    public static let applicationFile = FINSymbol(name: "applicationFile", code: 0x61707066, type: typeType) // 'appf'
    public static let applicationProcess = FINSymbol(name: "applicationProcess", code: 0x70636170, type: typeType) // 'pcap'
    public static let applicationSignature = FINSymbol(name: "applicationSignature", code: 0x7369676e, type: typeType) // 'sign'
    public static let applicationURL = FINSymbol(name: "applicationURL", code: 0x6170726c, type: typeType) // 'aprl'
    public static let arrangement = FINSymbol(name: "arrangement", code: 0x69617272, type: typeType) // 'iarr'
    public static let backgroundColor = FINSymbol(name: "backgroundColor", code: 0x636f6c72, type: typeType) // 'colr'
    public static let backgroundPicture = FINSymbol(name: "backgroundPicture", code: 0x69626b67, type: typeType) // 'ibkg'
    public static let best = FINSymbol(name: "best", code: 0x62657374, type: typeType) // 'best'
    public static let boolean = FINSymbol(name: "boolean", code: 0x626f6f6c, type: typeType) // 'bool'
    public static let boundingRectangle = FINSymbol(name: "boundingRectangle", code: 0x71647274, type: typeType) // 'qdrt'
    public static let bounds = FINSymbol(name: "bounds", code: 0x70626e64, type: typeType) // 'pbnd'
    public static let calculatesFolderSizes = FINSymbol(name: "calculatesFolderSizes", code: 0x7366737a, type: typeType) // 'sfsz'
    public static let capacity = FINSymbol(name: "capacity", code: 0x63617061, type: typeType) // 'capa'
    public static let centimeters = FINSymbol(name: "centimeters", code: 0x636d7472, type: typeType) // 'cmtr'
    public static let classInfo = FINSymbol(name: "classInfo", code: 0x67636c69, type: typeType) // 'gcli'
    public static let class_ = FINSymbol(name: "class_", code: 0x70636c73, type: typeType) // 'pcls'
    public static let clipboard = FINSymbol(name: "clipboard", code: 0x70636c69, type: typeType) // 'pcli'
    public static let clipping = FINSymbol(name: "clipping", code: 0x636c7066, type: typeType) // 'clpf'
    public static let clippingWindow = FINSymbol(name: "clippingWindow", code: 0x6c776e64, type: typeType) // 'lwnd'
    public static let closeable = FINSymbol(name: "closeable", code: 0x68636c62, type: typeType) // 'hclb'
    public static let collapsed = FINSymbol(name: "collapsed", code: 0x77736864, type: typeType) // 'wshd'
    public static let color = FINSymbol(name: "color", code: 0x636f6c72, type: typeType) // 'colr'
    public static let colorTable = FINSymbol(name: "colorTable", code: 0x636c7274, type: typeType) // 'clrt'
    public static let column = FINSymbol(name: "column", code: 0x6c76636c, type: typeType) // 'lvcl'
    public static let columnViewOptions = FINSymbol(name: "columnViewOptions", code: 0x63766f70, type: typeType) // 'cvop'
    public static let completelyExpanded = FINSymbol(name: "completelyExpanded", code: 0x70657863, type: typeType) // 'pexc'
    public static let computerContainer = FINSymbol(name: "computerContainer", code: 0x70636d70, type: typeType) // 'pcmp'
    public static let computerObject = FINSymbol(name: "computerObject", code: 0x63636d70, type: typeType) // 'ccmp'
    public static let container = FINSymbol(name: "container", code: 0x63746e72, type: typeType) // 'ctnr'
    public static let containerWindow = FINSymbol(name: "containerWindow", code: 0x63776e64, type: typeType) // 'cwnd'
    public static let creatorType = FINSymbol(name: "creatorType", code: 0x66637274, type: typeType) // 'fcrt'
    public static let cubicCentimeters = FINSymbol(name: "cubicCentimeters", code: 0x63636d74, type: typeType) // 'ccmt'
    public static let cubicFeet = FINSymbol(name: "cubicFeet", code: 0x63666574, type: typeType) // 'cfet'
    public static let cubicInches = FINSymbol(name: "cubicInches", code: 0x6375696e, type: typeType) // 'cuin'
    public static let cubicMeters = FINSymbol(name: "cubicMeters", code: 0x636d6574, type: typeType) // 'cmet'
    public static let cubicYards = FINSymbol(name: "cubicYards", code: 0x63797264, type: typeType) // 'cyrd'
    public static let currentPanel = FINSymbol(name: "currentPanel", code: 0x70616e6c, type: typeType) // 'panl'
    public static let currentView = FINSymbol(name: "currentView", code: 0x70766577, type: typeType) // 'pvew'
    public static let dashStyle = FINSymbol(name: "dashStyle", code: 0x74646173, type: typeType) // 'tdas'
    public static let data = FINSymbol(name: "data", code: 0x72646174, type: typeType) // 'rdat'
    public static let date = FINSymbol(name: "date", code: 0x6c647420, type: typeType) // 'ldt '
    public static let decimalStruct = FINSymbol(name: "decimalStruct", code: 0x6465636d, type: typeType) // 'decm'
    public static let degreesCelsius = FINSymbol(name: "degreesCelsius", code: 0x64656763, type: typeType) // 'degc'
    public static let degreesFahrenheit = FINSymbol(name: "degreesFahrenheit", code: 0x64656766, type: typeType) // 'degf'
    public static let degreesKelvin = FINSymbol(name: "degreesKelvin", code: 0x6465676b, type: typeType) // 'degk'
    public static let delayBeforeSpringing = FINSymbol(name: "delayBeforeSpringing", code: 0x64656c61, type: typeType) // 'dela'
    public static let description_ = FINSymbol(name: "description_", code: 0x64736372, type: typeType) // 'dscr'
    public static let deskAccessoryFile = FINSymbol(name: "deskAccessoryFile", code: 0x64616669, type: typeType) // 'dafi'
    public static let deskAccessoryProcess = FINSymbol(name: "deskAccessoryProcess", code: 0x70636461, type: typeType) // 'pcda'
    public static let desktop = FINSymbol(name: "desktop", code: 0x6465736b, type: typeType) // 'desk'
    public static let desktopObject = FINSymbol(name: "desktopObject", code: 0x6364736b, type: typeType) // 'cdsk'
    public static let desktopPicture = FINSymbol(name: "desktopPicture", code: 0x64706963, type: typeType) // 'dpic'
    public static let desktopPosition = FINSymbol(name: "desktopPosition", code: 0x64706f73, type: typeType) // 'dpos'
    public static let desktopShowsConnectedServers = FINSymbol(name: "desktopShowsConnectedServers", code: 0x70647376, type: typeType) // 'pdsv'
    public static let desktopShowsExternalHardDisks = FINSymbol(name: "desktopShowsExternalHardDisks", code: 0x70656864, type: typeType) // 'pehd'
    public static let desktopShowsHardDisks = FINSymbol(name: "desktopShowsHardDisks", code: 0x70646864, type: typeType) // 'pdhd'
    public static let desktopShowsRemovableMedia = FINSymbol(name: "desktopShowsRemovableMedia", code: 0x7064726d, type: typeType) // 'pdrm'
    public static let desktopWindow = FINSymbol(name: "desktopWindow", code: 0x646b7477, type: typeType) // 'dktw'
    public static let disclosesPreviewPane = FINSymbol(name: "disclosesPreviewPane", code: 0x64737072, type: typeType) // 'dspr'
    public static let disk = FINSymbol(name: "disk", code: 0x63646973, type: typeType) // 'cdis'
    public static let displayedName = FINSymbol(name: "displayedName", code: 0x646e616d, type: typeType) // 'dnam'
    public static let documentFile = FINSymbol(name: "documentFile", code: 0x646f6366, type: typeType) // 'docf'
    public static let doubleInteger = FINSymbol(name: "doubleInteger", code: 0x636f6d70, type: typeType) // 'comp'
    public static let ejectable = FINSymbol(name: "ejectable", code: 0x6973656a, type: typeType) // 'isej'
    public static let elementInfo = FINSymbol(name: "elementInfo", code: 0x656c696e, type: typeType) // 'elin'
    public static let encodedString = FINSymbol(name: "encodedString", code: 0x656e6373, type: typeType) // 'encs'
    public static let entireContents = FINSymbol(name: "entireContents", code: 0x65637473, type: typeType) // 'ects'
    public static let enumerator = FINSymbol(name: "enumerator", code: 0x656e756d, type: typeType) // 'enum'
    public static let eventInfo = FINSymbol(name: "eventInfo", code: 0x6576696e, type: typeType) // 'evin'
    public static let everyonesPrivileges = FINSymbol(name: "everyonesPrivileges", code: 0x67737470, type: typeType) // 'gstp'
    public static let expandable = FINSymbol(name: "expandable", code: 0x70657861, type: typeType) // 'pexa'
    public static let expanded = FINSymbol(name: "expanded", code: 0x70657870, type: typeType) // 'pexp'
    public static let extendedFloat = FINSymbol(name: "extendedFloat", code: 0x65787465, type: typeType) // 'exte'
    public static let extensionHidden = FINSymbol(name: "extensionHidden", code: 0x68696478, type: typeType) // 'hidx'
    public static let feet = FINSymbol(name: "feet", code: 0x66656574, type: typeType) // 'feet'
    public static let file = FINSymbol(name: "file", code: 0x66696c65, type: typeType) // 'file'
    public static let fileRef = FINSymbol(name: "fileRef", code: 0x66737266, type: typeType) // 'fsrf'
    public static let fileSpecification = FINSymbol(name: "fileSpecification", code: 0x66737320, type: typeType) // 'fss '
    public static let fileType = FINSymbol(name: "fileType", code: 0x61737479, type: typeType) // 'asty'
    public static let fileURL = FINSymbol(name: "fileURL", code: 0x6675726c, type: typeType) // 'furl'
    public static let fixed = FINSymbol(name: "fixed", code: 0x66697864, type: typeType) // 'fixd'
    public static let fixedPoint = FINSymbol(name: "fixedPoint", code: 0x66706e74, type: typeType) // 'fpnt'
    public static let fixedRectangle = FINSymbol(name: "fixedRectangle", code: 0x66726374, type: typeType) // 'frct'
    public static let float = FINSymbol(name: "float", code: 0x646f7562, type: typeType) // 'doub'
    public static let float128bit = FINSymbol(name: "float128bit", code: 0x6c64626c, type: typeType) // 'ldbl'
    public static let floating = FINSymbol(name: "floating", code: 0x6973666c, type: typeType) // 'isfl'
    public static let folder = FINSymbol(name: "folder", code: 0x63666f6c, type: typeType) // 'cfol'
    public static let foldersOpenInNewTabs = FINSymbol(name: "foldersOpenInNewTabs", code: 0x706f6e74, type: typeType) // 'pont'
    public static let foldersOpenInNewWindows = FINSymbol(name: "foldersOpenInNewWindows", code: 0x706f6e77, type: typeType) // 'ponw'
    public static let foldersSpringOpen = FINSymbol(name: "foldersSpringOpen", code: 0x73707267, type: typeType) // 'sprg'
    public static let format = FINSymbol(name: "format", code: 0x64666d74, type: typeType) // 'dfmt'
    public static let freeSpace = FINSymbol(name: "freeSpace", code: 0x66727370, type: typeType) // 'frsp'
    public static let frontmost = FINSymbol(name: "frontmost", code: 0x70697366, type: typeType) // 'pisf'
    public static let gallons = FINSymbol(name: "gallons", code: 0x67616c6e, type: typeType) // 'galn'
    public static let grams = FINSymbol(name: "grams", code: 0x6772616d, type: typeType) // 'gram'
    public static let graphicText = FINSymbol(name: "graphicText", code: 0x63677478, type: typeType) // 'cgtx'
    public static let group = FINSymbol(name: "group", code: 0x73677270, type: typeType) // 'sgrp'
    public static let groupPrivileges = FINSymbol(name: "groupPrivileges", code: 0x67707072, type: typeType) // 'gppr'
    public static let hasScriptingTerminology = FINSymbol(name: "hasScriptingTerminology", code: 0x68736372, type: typeType) // 'hscr'
    public static let home = FINSymbol(name: "home", code: 0x686f6d65, type: typeType) // 'home'
    public static let icon = FINSymbol(name: "icon", code: 0x69696d67, type: typeType) // 'iimg'
    public static let iconFamily = FINSymbol(name: "iconFamily", code: 0x6966616d, type: typeType) // 'ifam'
    public static let iconSize = FINSymbol(name: "iconSize", code: 0x6c766973, type: typeType) // 'lvis'
    public static let iconViewOptions = FINSymbol(name: "iconViewOptions", code: 0x69636f70, type: typeType) // 'icop'
    public static let id = FINSymbol(name: "id", code: 0x49442020, type: typeType) // 'ID  '
    public static let ignorePrivileges = FINSymbol(name: "ignorePrivileges", code: 0x69677072, type: typeType) // 'igpr'
    public static let inches = FINSymbol(name: "inches", code: 0x696e6368, type: typeType) // 'inch'
    public static let index = FINSymbol(name: "index", code: 0x70696478, type: typeType) // 'pidx'
    public static let informationWindow = FINSymbol(name: "informationWindow", code: 0x69776e64, type: typeType) // 'iwnd'
    public static let insertionLocation = FINSymbol(name: "insertionLocation", code: 0x70696e73, type: typeType) // 'pins'
    public static let integer = FINSymbol(name: "integer", code: 0x6c6f6e67, type: typeType) // 'long'
    public static let internationalText = FINSymbol(name: "internationalText", code: 0x69747874, type: typeType) // 'itxt'
    public static let internationalWritingCode = FINSymbol(name: "internationalWritingCode", code: 0x696e746c, type: typeType) // 'intl'
    public static let internetLocationFile = FINSymbol(name: "internetLocationFile", code: 0x696e6c66, type: typeType) // 'inlf'
    public static let item = FINSymbol(name: "item", code: 0x636f626a, type: typeType) // 'cobj'
    public static let journalingEnabled = FINSymbol(name: "journalingEnabled", code: 0x4a726e6c, type: typeType) // 'Jrnl'
    public static let kernelProcessID = FINSymbol(name: "kernelProcessID", code: 0x6b706964, type: typeType) // 'kpid'
    public static let kilograms = FINSymbol(name: "kilograms", code: 0x6b67726d, type: typeType) // 'kgrm'
    public static let kilometers = FINSymbol(name: "kilometers", code: 0x6b6d7472, type: typeType) // 'kmtr'
    public static let label = FINSymbol(name: "label", code: 0x636c626c, type: typeType) // 'clbl'
    public static let labelPosition = FINSymbol(name: "labelPosition", code: 0x6c706f73, type: typeType) // 'lpos'
    public static let large32BitIcon = FINSymbol(name: "large32BitIcon", code: 0x696c3332, type: typeType) // 'il32'
    public static let large4BitIcon = FINSymbol(name: "large4BitIcon", code: 0x69636c34, type: typeType) // 'icl4'
    public static let large8BitIcon = FINSymbol(name: "large8BitIcon", code: 0x69636c38, type: typeType) // 'icl8'
    public static let large8BitMask = FINSymbol(name: "large8BitMask", code: 0x6c386d6b, type: typeType) // 'l8mk'
    public static let largeMonochromeIconAndMask = FINSymbol(name: "largeMonochromeIconAndMask", code: 0x49434e23, type: typeType) // 'ICN#'
    public static let list = FINSymbol(name: "list", code: 0x6c697374, type: typeType) // 'list'
    public static let listViewOptions = FINSymbol(name: "listViewOptions", code: 0x6c766f70, type: typeType) // 'lvop'
    public static let liters = FINSymbol(name: "liters", code: 0x6c697472, type: typeType) // 'litr'
    public static let localVolume = FINSymbol(name: "localVolume", code: 0x69737276, type: typeType) // 'isrv'
    public static let location = FINSymbol(name: "location", code: 0x696c6f63, type: typeType) // 'iloc'
    public static let locationReference = FINSymbol(name: "locationReference", code: 0x696e736c, type: typeType) // 'insl'
    public static let locked = FINSymbol(name: "locked", code: 0x61736c6b, type: typeType) // 'aslk'
    public static let longFixed = FINSymbol(name: "longFixed", code: 0x6c667864, type: typeType) // 'lfxd'
    public static let longFixedPoint = FINSymbol(name: "longFixedPoint", code: 0x6c667074, type: typeType) // 'lfpt'
    public static let longFixedRectangle = FINSymbol(name: "longFixedRectangle", code: 0x6c667263, type: typeType) // 'lfrc'
    public static let longPoint = FINSymbol(name: "longPoint", code: 0x6c706e74, type: typeType) // 'lpnt'
    public static let longRectangle = FINSymbol(name: "longRectangle", code: 0x6c726374, type: typeType) // 'lrct'
    public static let machPort = FINSymbol(name: "machPort", code: 0x706f7274, type: typeType) // 'port'
    public static let machine = FINSymbol(name: "machine", code: 0x6d616368, type: typeType) // 'mach'
    public static let machineLocation = FINSymbol(name: "machineLocation", code: 0x6d4c6f63, type: typeType) // 'mLoc'
    public static let maximumWidth = FINSymbol(name: "maximumWidth", code: 0x636c776d, type: typeType) // 'clwm'
    public static let meters = FINSymbol(name: "meters", code: 0x6d657472, type: typeType) // 'metr'
    public static let miles = FINSymbol(name: "miles", code: 0x6d696c65, type: typeType) // 'mile'
    public static let minimumSize = FINSymbol(name: "minimumSize", code: 0x6d707274, type: typeType) // 'mprt'
    public static let minimumWidth = FINSymbol(name: "minimumWidth", code: 0x636c776e, type: typeType) // 'clwn'
    public static let missingValue = FINSymbol(name: "missingValue", code: 0x6d736e67, type: typeType) // 'msng'
    public static let modal = FINSymbol(name: "modal", code: 0x706d6f64, type: typeType) // 'pmod'
    public static let nameExtension = FINSymbol(name: "nameExtension", code: 0x6e6d7874, type: typeType) // 'nmxt'
    public static let newWindowTarget = FINSymbol(name: "newWindowTarget", code: 0x706e7774, type: typeType) // 'pnwt'
    public static let newWindowsOpenInColumnView = FINSymbol(name: "newWindowsOpenInColumnView", code: 0x706f6376, type: typeType) // 'pocv'
    public static let null = FINSymbol(name: "null", code: 0x6e756c6c, type: typeType) // 'null'
    public static let opensInClassic = FINSymbol(name: "opensInClassic", code: 0x436c7363, type: typeType) // 'Clsc'
    public static let originalItem = FINSymbol(name: "originalItem", code: 0x6f726967, type: typeType) // 'orig'
    public static let ounces = FINSymbol(name: "ounces", code: 0x6f7a7320, type: typeType) // 'ozs '
    public static let owner = FINSymbol(name: "owner", code: 0x736f776e, type: typeType) // 'sown'
    public static let ownerPrivileges = FINSymbol(name: "ownerPrivileges", code: 0x6f776e72, type: typeType) // 'ownr'
    public static let package = FINSymbol(name: "package", code: 0x7061636b, type: typeType) // 'pack'
    public static let parameterInfo = FINSymbol(name: "parameterInfo", code: 0x706d696e, type: typeType) // 'pmin'
    public static let partitionSpaceUsed = FINSymbol(name: "partitionSpaceUsed", code: 0x70757364, type: typeType) // 'pusd'
    public static let physicalSize = FINSymbol(name: "physicalSize", code: 0x70687973, type: typeType) // 'phys'
    public static let pixelMapRecord = FINSymbol(name: "pixelMapRecord", code: 0x74706d6d, type: typeType) // 'tpmm'
    public static let point = FINSymbol(name: "point", code: 0x51447074, type: typeType) // 'QDpt'
    public static let position = FINSymbol(name: "position", code: 0x706f736e, type: typeType) // 'posn'
    public static let pounds = FINSymbol(name: "pounds", code: 0x6c627320, type: typeType) // 'lbs '
    public static let preferences = FINSymbol(name: "preferences", code: 0x63707266, type: typeType) // 'cprf'
    public static let preferencesWindow = FINSymbol(name: "preferencesWindow", code: 0x70776e64, type: typeType) // 'pwnd'
    public static let preferredSize = FINSymbol(name: "preferredSize", code: 0x61707074, type: typeType) // 'appt'
    public static let process = FINSymbol(name: "process", code: 0x70726373, type: typeType) // 'prcs'
    public static let processSerialNumber = FINSymbol(name: "processSerialNumber", code: 0x70736e20, type: typeType) // 'psn '
    public static let productVersion = FINSymbol(name: "productVersion", code: 0x76657232, type: typeType) // 'ver2'
    public static let properties = FINSymbol(name: "properties", code: 0x70414c4c, type: typeType) // 'pALL'
    public static let property = FINSymbol(name: "property", code: 0x70726f70, type: typeType) // 'prop'
    public static let propertyInfo = FINSymbol(name: "propertyInfo", code: 0x70696e66, type: typeType) // 'pinf'
    public static let quarts = FINSymbol(name: "quarts", code: 0x71727473, type: typeType) // 'qrts'
    public static let record = FINSymbol(name: "record", code: 0x7265636f, type: typeType) // 'reco'
    public static let reference = FINSymbol(name: "reference", code: 0x6f626a20, type: typeType) // 'obj '
    public static let resizable = FINSymbol(name: "resizable", code: 0x7072737a, type: typeType) // 'prsz'
    public static let rotation = FINSymbol(name: "rotation", code: 0x74726f74, type: typeType) // 'trot'
    public static let script = FINSymbol(name: "script", code: 0x73637074, type: typeType) // 'scpt'
    public static let selection = FINSymbol(name: "selection", code: 0x73656c65, type: typeType) // 'sele'
    public static let shortFloat = FINSymbol(name: "shortFloat", code: 0x73696e67, type: typeType) // 'sing'
    public static let shortInteger = FINSymbol(name: "shortInteger", code: 0x73686f72, type: typeType) // 'shor'
    public static let showsIcon = FINSymbol(name: "showsIcon", code: 0x73686963, type: typeType) // 'shic'
    public static let showsIconPreview = FINSymbol(name: "showsIconPreview", code: 0x70727677, type: typeType) // 'prvw'
    public static let showsItemInfo = FINSymbol(name: "showsItemInfo", code: 0x6d6e666f, type: typeType) // 'mnfo'
    public static let showsPreviewColumn = FINSymbol(name: "showsPreviewColumn", code: 0x73687072, type: typeType) // 'shpr'
    public static let sidebarWidth = FINSymbol(name: "sidebarWidth", code: 0x73627769, type: typeType) // 'sbwi'
    public static let small32BitIcon = FINSymbol(name: "small32BitIcon", code: 0x69733332, type: typeType) // 'is32'
    public static let small4BitIcon = FINSymbol(name: "small4BitIcon", code: 0x69637334, type: typeType) // 'ics4'
    public static let small8BitIcon = FINSymbol(name: "small8BitIcon", code: 0x69637338, type: typeType) // 'ics8'
    public static let small8BitMask = FINSymbol(name: "small8BitMask", code: 0x69637338, type: typeType) // 'ics8'
    public static let smallMonochromeIconAndMask = FINSymbol(name: "smallMonochromeIconAndMask", code: 0x69637323, type: typeType) // 'ics#'
    public static let sortColumn = FINSymbol(name: "sortColumn", code: 0x73727463, type: typeType) // 'srtc'
    public static let sortDirection = FINSymbol(name: "sortDirection", code: 0x736f7264, type: typeType) // 'sord'
    public static let squareFeet = FINSymbol(name: "squareFeet", code: 0x73716674, type: typeType) // 'sqft'
    public static let squareKilometers = FINSymbol(name: "squareKilometers", code: 0x73716b6d, type: typeType) // 'sqkm'
    public static let squareMeters = FINSymbol(name: "squareMeters", code: 0x7371726d, type: typeType) // 'sqrm'
    public static let squareMiles = FINSymbol(name: "squareMiles", code: 0x73716d69, type: typeType) // 'sqmi'
    public static let squareYards = FINSymbol(name: "squareYards", code: 0x73717964, type: typeType) // 'sqyd'
    public static let startup = FINSymbol(name: "startup", code: 0x69737464, type: typeType) // 'istd'
    public static let startupDisk = FINSymbol(name: "startupDisk", code: 0x7364736b, type: typeType) // 'sdsk'
    public static let stationery = FINSymbol(name: "stationery", code: 0x70737064, type: typeType) // 'pspd'
    public static let statusbarVisible = FINSymbol(name: "statusbarVisible", code: 0x73747669, type: typeType) // 'stvi'
    public static let string = FINSymbol(name: "string", code: 0x54455854, type: typeType) // 'TEXT'
    public static let styledClipboardText = FINSymbol(name: "styledClipboardText", code: 0x7374796c, type: typeType) // 'styl'
    public static let styledText = FINSymbol(name: "styledText", code: 0x53545854, type: typeType) // 'STXT'
    public static let styledUnicodeText = FINSymbol(name: "styledUnicodeText", code: 0x73757478, type: typeType) // 'sutx'
    public static let suggestedSize = FINSymbol(name: "suggestedSize", code: 0x73707274, type: typeType) // 'sprt'
    public static let suiteInfo = FINSymbol(name: "suiteInfo", code: 0x7375696e, type: typeType) // 'suin'
    public static let target = FINSymbol(name: "target", code: 0x66767467, type: typeType) // 'fvtg'
    public static let textSize = FINSymbol(name: "textSize", code: 0x6673697a, type: typeType) // 'fsiz'
    public static let textStyleInfo = FINSymbol(name: "textStyleInfo", code: 0x74737479, type: typeType) // 'tsty'
    public static let titled = FINSymbol(name: "titled", code: 0x70746974, type: typeType) // 'ptit'
    public static let toolbarVisible = FINSymbol(name: "toolbarVisible", code: 0x74627669, type: typeType) // 'tbvi'
    public static let totalPartitionSize = FINSymbol(name: "totalPartitionSize", code: 0x61707074, type: typeType) // 'appt'
    public static let trash = FINSymbol(name: "trash", code: 0x74727368, type: typeType) // 'trsh'
    public static let trashObject = FINSymbol(name: "trashObject", code: 0x63747273, type: typeType) // 'ctrs'
    public static let typeClass = FINSymbol(name: "typeClass", code: 0x74797065, type: typeType) // 'type'
    public static let unsignedInteger = FINSymbol(name: "unsignedInteger", code: 0x6d61676e, type: typeType) // 'magn'
    public static let usesRelativeDates = FINSymbol(name: "usesRelativeDates", code: 0x75726474, type: typeType) // 'urdt'
    public static let visible = FINSymbol(name: "visible", code: 0x70766973, type: typeType) // 'pvis'
    public static let warnsBeforeEmptying = FINSymbol(name: "warnsBeforeEmptying", code: 0x7761726e, type: typeType) // 'warn'
    public static let width = FINSymbol(name: "width", code: 0x636c7764, type: typeType) // 'clwd'
    public static let window = FINSymbol(name: "window", code: 0x6377696e, type: typeType) // 'cwin'
    public static let writingCode = FINSymbol(name: "writingCode", code: 0x70736374, type: typeType) // 'psct'
    public static let yards = FINSymbol(name: "yards", code: 0x79617264, type: typeType) // 'yard'
    public static let zoomable = FINSymbol(name: "zoomable", code: 0x69737a6d, type: typeType) // 'iszm'
    public static let zoomed = FINSymbol(name: "zoomed", code: 0x707a756d, type: typeType) // 'pzum'

    // Enumerators
    public static let AdvancedPreferencesPanel = FINSymbol(name: "AdvancedPreferencesPanel", code: 0x70616476, type: typeEnumerated) // 'padv'
    public static let ApplePhotoFormat = FINSymbol(name: "ApplePhotoFormat", code: 0x64667068, type: typeEnumerated) // 'dfph'
    public static let AppleShareFormat = FINSymbol(name: "AppleShareFormat", code: 0x64666173, type: typeEnumerated) // 'dfas'
    public static let ApplicationPanel = FINSymbol(name: "ApplicationPanel", code: 0x61706e6c, type: typeEnumerated) // 'apnl'
    public static let BurningPanel = FINSymbol(name: "BurningPanel", code: 0x62706e6c, type: typeEnumerated) // 'bpnl'
    public static let CommentsPanel = FINSymbol(name: "CommentsPanel", code: 0x63706e6c, type: typeEnumerated) // 'cpnl'
    public static let ContentIndexPanel = FINSymbol(name: "ContentIndexPanel", code: 0x63696e6c, type: typeEnumerated) // 'cinl'
    public static let FTPFormat = FINSymbol(name: "FTPFormat", code: 0x64666674, type: typeEnumerated) // 'dfft'
    public static let GeneralInformationPanel = FINSymbol(name: "GeneralInformationPanel", code: 0x67706e6c, type: typeEnumerated) // 'gpnl'
    public static let GeneralPreferencesPanel = FINSymbol(name: "GeneralPreferencesPanel", code: 0x70676e70, type: typeEnumerated) // 'pgnp'
    public static let HighSierraFormat = FINSymbol(name: "HighSierraFormat", code: 0x64666873, type: typeEnumerated) // 'dfhs'
    public static let ISO9660Format = FINSymbol(name: "ISO9660Format", code: 0x64663936, type: typeEnumerated) // 'df96'
    public static let LabelPreferencesPanel = FINSymbol(name: "LabelPreferencesPanel", code: 0x706c6270, type: typeEnumerated) // 'plbp'
    public static let LanguagesPanel = FINSymbol(name: "LanguagesPanel", code: 0x706b6c67, type: typeEnumerated) // 'pklg'
    public static let MSDOSFormat = FINSymbol(name: "MSDOSFormat", code: 0x64666d73, type: typeEnumerated) // 'dfms'
    public static let MacOSExtendedFormat = FINSymbol(name: "MacOSExtendedFormat", code: 0x6466682b, type: typeEnumerated) // 'dfh+'
    public static let MacOSFormat = FINSymbol(name: "MacOSFormat", code: 0x64666866, type: typeEnumerated) // 'dfhf'
    public static let MemoryPanel = FINSymbol(name: "MemoryPanel", code: 0x6d706e6c, type: typeEnumerated) // 'mpnl'
    public static let MoreInfoPanel = FINSymbol(name: "MoreInfoPanel", code: 0x6d696e6c, type: typeEnumerated) // 'minl'
    public static let NFSFormat = FINSymbol(name: "NFSFormat", code: 0x64666e66, type: typeEnumerated) // 'dfnf'
    public static let NTFSFormat = FINSymbol(name: "NTFSFormat", code: 0x64666e74, type: typeEnumerated) // 'dfnt'
    public static let NameAndExtensionPanel = FINSymbol(name: "NameAndExtensionPanel", code: 0x6e706e6c, type: typeEnumerated) // 'npnl'
    public static let PacketWrittenUDFFormat = FINSymbol(name: "PacketWrittenUDFFormat", code: 0x64667075, type: typeEnumerated) // 'dfpu'
    public static let PluginsPanel = FINSymbol(name: "PluginsPanel", code: 0x706b7067, type: typeEnumerated) // 'pkpg'
    public static let PreviewPanel = FINSymbol(name: "PreviewPanel", code: 0x76706e6c, type: typeEnumerated) // 'vpnl'
    public static let ProDOSFormat = FINSymbol(name: "ProDOSFormat", code: 0x64667072, type: typeEnumerated) // 'dfpr'
    public static let QuickTakeFormat = FINSymbol(name: "QuickTakeFormat", code: 0x64667174, type: typeEnumerated) // 'dfqt'
    public static let SharingPanel = FINSymbol(name: "SharingPanel", code: 0x73706e6c, type: typeEnumerated) // 'spnl'
    public static let SidebarPreferencesPanel = FINSymbol(name: "SidebarPreferencesPanel", code: 0x70736964, type: typeEnumerated) // 'psid'
    public static let SimpleHeaderPanel = FINSymbol(name: "SimpleHeaderPanel", code: 0x73686e6c, type: typeEnumerated) // 'shnl'
    public static let UDFFormat = FINSymbol(name: "UDFFormat", code: 0x64667564, type: typeEnumerated) // 'dfud'
    public static let UFSFormat = FINSymbol(name: "UFSFormat", code: 0x64667566, type: typeEnumerated) // 'dfuf'
    public static let WebDAVFormat = FINSymbol(name: "WebDAVFormat", code: 0x64667764, type: typeEnumerated) // 'dfwd'
    public static let XsanFormat = FINSymbol(name: "XsanFormat", code: 0x64666163, type: typeEnumerated) // 'dfac'
    public static let applicationResponses = FINSymbol(name: "applicationResponses", code: 0x726d7465, type: typeEnumerated) // 'rmte'
    public static let arrangedByCreationDate = FINSymbol(name: "arrangedByCreationDate", code: 0x63647461, type: typeEnumerated) // 'cdta'
    public static let arrangedByKind = FINSymbol(name: "arrangedByKind", code: 0x6b696e61, type: typeEnumerated) // 'kina'
    public static let arrangedByLabel = FINSymbol(name: "arrangedByLabel", code: 0x6c616261, type: typeEnumerated) // 'laba'
    public static let arrangedByModificationDate = FINSymbol(name: "arrangedByModificationDate", code: 0x6d647461, type: typeEnumerated) // 'mdta'
    public static let arrangedByName = FINSymbol(name: "arrangedByName", code: 0x6e616d61, type: typeEnumerated) // 'nama'
    public static let arrangedBySize = FINSymbol(name: "arrangedBySize", code: 0x73697a61, type: typeEnumerated) // 'siza'
    public static let ask = FINSymbol(name: "ask", code: 0x61736b20, type: typeEnumerated) // 'ask '
    public static let audioFormat = FINSymbol(name: "audioFormat", code: 0x64666175, type: typeEnumerated) // 'dfau'
    public static let bottom = FINSymbol(name: "bottom", code: 0x6c626f74, type: typeEnumerated) // 'lbot'
    public static let case_ = FINSymbol(name: "case_", code: 0x63617365, type: typeEnumerated) // 'case'
    public static let columnView = FINSymbol(name: "columnView", code: 0x636c7677, type: typeEnumerated) // 'clvw'
    public static let comment = FINSymbol(name: "comment", code: 0x636f6d74, type: typeEnumerated) // 'comt'
    public static let commentColumn = FINSymbol(name: "commentColumn", code: 0x656c7343, type: typeEnumerated) // 'elsC'
    public static let creationDate = FINSymbol(name: "creationDate", code: 0x61736364, type: typeEnumerated) // 'ascd'
    public static let creationDateColumn = FINSymbol(name: "creationDateColumn", code: 0x656c7363, type: typeEnumerated) // 'elsc'
    public static let diacriticals = FINSymbol(name: "diacriticals", code: 0x64696163, type: typeEnumerated) // 'diac'
    public static let expansion = FINSymbol(name: "expansion", code: 0x65787061, type: typeEnumerated) // 'expa'
    public static let flowView = FINSymbol(name: "flowView", code: 0x666c7677, type: typeEnumerated) // 'flvw'
    public static let groupView = FINSymbol(name: "groupView", code: 0x67727677, type: typeEnumerated) // 'grvw'
    public static let hyphens = FINSymbol(name: "hyphens", code: 0x68797068, type: typeEnumerated) // 'hyph'
    public static let iconView = FINSymbol(name: "iconView", code: 0x69636e76, type: typeEnumerated) // 'icnv'
    public static let kind = FINSymbol(name: "kind", code: 0x6b696e64, type: typeEnumerated) // 'kind'
    public static let kindColumn = FINSymbol(name: "kindColumn", code: 0x656c736b, type: typeEnumerated) // 'elsk'
    public static let labelColumn = FINSymbol(name: "labelColumn", code: 0x656c736c, type: typeEnumerated) // 'elsl'
    public static let labelIndex = FINSymbol(name: "labelIndex", code: 0x6c616269, type: typeEnumerated) // 'labi'
    public static let large = FINSymbol(name: "large", code: 0x6c676963, type: typeEnumerated) // 'lgic'
    public static let largeIcon = FINSymbol(name: "largeIcon", code: 0x6c676963, type: typeEnumerated) // 'lgic'
    public static let listView = FINSymbol(name: "listView", code: 0x6c737677, type: typeEnumerated) // 'lsvw'
    public static let mini = FINSymbol(name: "mini", code: 0x6d696963, type: typeEnumerated) // 'miic'
    public static let modificationDate = FINSymbol(name: "modificationDate", code: 0x61736d6f, type: typeEnumerated) // 'asmo'
    public static let modificationDateColumn = FINSymbol(name: "modificationDateColumn", code: 0x656c736d, type: typeEnumerated) // 'elsm'
    public static let name = FINSymbol(name: "name", code: 0x706e616d, type: typeEnumerated) // 'pnam'
    public static let nameColumn = FINSymbol(name: "nameColumn", code: 0x656c736e, type: typeEnumerated) // 'elsn'
    public static let no = FINSymbol(name: "no", code: 0x6e6f2020, type: typeEnumerated) // 'no  '
    public static let none_ = FINSymbol(name: "none_", code: 0x6e6f6e65, type: typeEnumerated) // 'none'
    public static let normal = FINSymbol(name: "normal", code: 0x736e726d, type: typeEnumerated) // 'snrm'
    public static let notArranged = FINSymbol(name: "notArranged", code: 0x6e617272, type: typeEnumerated) // 'narr'
    public static let numericStrings = FINSymbol(name: "numericStrings", code: 0x6e756d65, type: typeEnumerated) // 'nume'
    public static let punctuation = FINSymbol(name: "punctuation", code: 0x70756e63, type: typeEnumerated) // 'punc'
    public static let readOnly = FINSymbol(name: "readOnly", code: 0x72656164, type: typeEnumerated) // 'read'
    public static let readWrite = FINSymbol(name: "readWrite", code: 0x72647772, type: typeEnumerated) // 'rdwr'
    public static let reversed = FINSymbol(name: "reversed", code: 0x73727673, type: typeEnumerated) // 'srvs'
    public static let right_ = FINSymbol(name: "right_", code: 0x6c726774, type: typeEnumerated) // 'lrgt'
    public static let size = FINSymbol(name: "size", code: 0x70687973, type: typeEnumerated) // 'phys'
    public static let sizeColumn = FINSymbol(name: "sizeColumn", code: 0x656c7373, type: typeEnumerated) // 'elss'
    public static let small = FINSymbol(name: "small", code: 0x736d6963, type: typeEnumerated) // 'smic'
    public static let smallIcon = FINSymbol(name: "smallIcon", code: 0x736d6963, type: typeEnumerated) // 'smic'
    public static let snapToGrid = FINSymbol(name: "snapToGrid", code: 0x67726461, type: typeEnumerated) // 'grda'
    public static let unknownFormat = FINSymbol(name: "unknownFormat", code: 0x64663f3f, type: typeEnumerated) // 'df??'
    public static let versionColumn = FINSymbol(name: "versionColumn", code: 0x656c7376, type: typeEnumerated) // 'elsv'
    public static let version_ = FINSymbol(name: "version_", code: 0x76657273, type: typeEnumerated) // 'vers'
    public static let whitespace = FINSymbol(name: "whitespace", code: 0x77686974, type: typeEnumerated) // 'whit'
    public static let writeOnly = FINSymbol(name: "writeOnly", code: 0x77726974, type: typeEnumerated) // 'writ'
    public static let yes = FINSymbol(name: "yes", code: 0x79657320, type: typeEnumerated) // 'yes '
}

public typealias FIN = FINSymbol // allows symbols to be written as (e.g.) FIN.name instead of FINSymbol.name



/******************************************************************************/
// Specifier extensions; these add command methods and property/elements getters based on Finder.app's terminology

public protocol FINCommand: SpecifierProtocol {} // provides AE dispatch methods

extension FINCommand {

    public func activate(directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: NSTimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("activate", eventClass: 0x6d697363, eventID: 0x61637476, // 'miscactv'
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, asType: Any.self)
    }
    public func cleanUp(directParameter: Any = NoParameter,
            by: Any = NoParameter,
            waitReply: Bool = true, withTimeout: NSTimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("cleanUp", eventClass: 0x666e6472, eventID: 0x66636c75, // 'fndrfclu'
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("by", 0x62792020, by), // 'by  '
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, asType: Any.self)
    }
    public func close(directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: NSTimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("close", eventClass: 0x636f7265, eventID: 0x636c6f73, // 'coreclos'
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, asType: Any.self)
    }
    public func copy_(directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: NSTimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("copy_", eventClass: 0x6d697363, eventID: 0x636f7079, // 'misccopy'
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, asType: Any.self)
    }
    public func count(directParameter: Any = NoParameter,
            each: Any = NoParameter,
            waitReply: Bool = true, withTimeout: NSTimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("count", eventClass: 0x636f7265, eventID: 0x636e7465, // 'corecnte'
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("each", 0x6b6f636c, each), // 'kocl'
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, asType: Any.self)
    }
    public func dataSize(directParameter: Any = NoParameter,
            as_: Any = NoParameter,
            waitReply: Bool = true, withTimeout: NSTimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("dataSize", eventClass: 0x636f7265, eventID: 0x6473697a, // 'coredsiz'
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("as_", 0x72747970, as_), // 'rtyp'
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, asType: Any.self)
    }
    public func delete(directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: NSTimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("delete", eventClass: 0x636f7265, eventID: 0x64656c6f, // 'coredelo'
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, asType: Any.self)
    }
    public func duplicate(directParameter: Any = NoParameter,
            to: Any = NoParameter,
            replacing: Any = NoParameter,
            routingSuppressed: Any = NoParameter,
            exactCopy: Any = NoParameter,
            waitReply: Bool = true, withTimeout: NSTimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("duplicate", eventClass: 0x636f7265, eventID: 0x636c6f6e, // 'coreclon'
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x696e7368, to), // 'insh'
                    ("replacing", 0x616c7270, replacing), // 'alrp'
                    ("routingSuppressed", 0x726f7574, routingSuppressed), // 'rout'
                    ("exactCopy", 0x65786374, exactCopy), // 'exct'
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, asType: Any.self)
    }
    public func eject(directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: NSTimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("eject", eventClass: 0x666e6472, eventID: 0x656a6374, // 'fndrejct'
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, asType: Any.self)
    }
    public func empty(directParameter: Any = NoParameter,
            security: Any = NoParameter,
            waitReply: Bool = true, withTimeout: NSTimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("empty", eventClass: 0x666e6472, eventID: 0x656d7074, // 'fndrempt'
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("security", 0x7365633f, security), // 'sec?'
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, asType: Any.self)
    }
    public func erase(directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: NSTimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("erase", eventClass: 0x666e6472, eventID: 0x66657261, // 'fndrfera'
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, asType: Any.self)
    }
    public func exists(directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: NSTimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("exists", eventClass: 0x636f7265, eventID: 0x646f6578, // 'coredoex'
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, asType: Any.self)
    }
    public func get(directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: NSTimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("get", eventClass: 0x636f7265, eventID: 0x67657464, // 'coregetd'
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, asType: Any.self)
    }
    public func launch(directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: NSTimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("launch", eventClass: 0x61736372, eventID: 0x6e6f6f70, // 'ascrnoop'
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, asType: Any.self)
    }
    public func make(directParameter: Any = NoParameter,
            new: Any = NoParameter,
            at: Any = NoParameter,
            to: Any = NoParameter,
            withProperties: Any = NoParameter,
            waitReply: Bool = true, withTimeout: NSTimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("make", eventClass: 0x636f7265, eventID: 0x6372656c, // 'corecrel'
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("new", 0x6b6f636c, new), // 'kocl'
                    ("at", 0x696e7368, at), // 'insh'
                    ("to", 0x746f2020, to), // 'to  '
                    ("withProperties", 0x70726474, withProperties), // 'prdt'
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, asType: Any.self)
    }
    public func move(directParameter: Any = NoParameter,
            to: Any = NoParameter,
            replacing: Any = NoParameter,
            positionedAt: Any = NoParameter,
            routingSuppressed: Any = NoParameter,
            waitReply: Bool = true, withTimeout: NSTimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("move", eventClass: 0x636f7265, eventID: 0x6d6f7665, // 'coremove'
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x696e7368, to), // 'insh'
                    ("replacing", 0x616c7270, replacing), // 'alrp'
                    ("positionedAt", 0x6d76706c, positionedAt), // 'mvpl'
                    ("routingSuppressed", 0x726f7574, routingSuppressed), // 'rout'
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, asType: Any.self)
    }
    public func open(directParameter: Any = NoParameter,
            using: Any = NoParameter,
            withProperties: Any = NoParameter,
            waitReply: Bool = true, withTimeout: NSTimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("open", eventClass: 0x61657674, eventID: 0x6f646f63, // 'aevtodoc'
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("using", 0x7573696e, using), // 'usin'
                    ("withProperties", 0x70726474, withProperties), // 'prdt'
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, asType: Any.self)
    }
    public func openLocation(directParameter: Any = NoParameter,
            window: Any = NoParameter,
            waitReply: Bool = true, withTimeout: NSTimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("openLocation", eventClass: 0x4755524c, eventID: 0x4755524c, // 'GURLGURL'
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("window", 0x57494e44, window), // 'WIND'
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, asType: Any.self)
    }
    public func print(directParameter: Any = NoParameter,
            withProperties: Any = NoParameter,
            waitReply: Bool = true, withTimeout: NSTimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("print", eventClass: 0x61657674, eventID: 0x70646f63, // 'aevtpdoc'
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("withProperties", 0x70726474, withProperties), // 'prdt'
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, asType: Any.self)
    }
    public func quit(directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: NSTimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("quit", eventClass: 0x61657674, eventID: 0x71756974, // 'aevtquit'
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, asType: Any.self)
    }
    public func reopen(directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: NSTimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("reopen", eventClass: 0x61657674, eventID: 0x72617070, // 'aevtrapp'
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, asType: Any.self)
    }
    public func restart(directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: NSTimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("restart", eventClass: 0x666e6472, eventID: 0x72657374, // 'fndrrest'
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, asType: Any.self)
    }
    public func reveal(directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: NSTimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("reveal", eventClass: 0x6d697363, eventID: 0x6d766973, // 'miscmvis'
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, asType: Any.self)
    }
    public func run(directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: NSTimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("run", eventClass: 0x61657674, eventID: 0x6f617070, // 'aevtoapp'
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, asType: Any.self)
    }
    public func select(directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: NSTimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("select", eventClass: 0x6d697363, eventID: 0x736c6374, // 'miscslct'
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, asType: Any.self)
    }
    public func set(directParameter: Any = NoParameter,
            to: Any = NoParameter,
            waitReply: Bool = true, withTimeout: NSTimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("set", eventClass: 0x636f7265, eventID: 0x73657464, // 'coresetd'
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("to", 0x64617461, to), // 'data'
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, asType: Any.self)
    }
    public func shutDown(directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: NSTimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("shutDown", eventClass: 0x666e6472, eventID: 0x73687574, // 'fndrshut'
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, asType: Any.self)
    }
    public func sleep(directParameter: Any = NoParameter,
            waitReply: Bool = true, withTimeout: NSTimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("sleep", eventClass: 0x666e6472, eventID: 0x736c6570, // 'fndrslep'
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, asType: Any.self)
    }
    public func sort(directParameter: Any = NoParameter,
            by: Any = NoParameter,
            waitReply: Bool = true, withTimeout: NSTimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("sort", eventClass: 0x44415441, eventID: 0x534f5254, // 'DATASORT'
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("by", 0x62792020, by), // 'by  '
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, asType: Any.self)
    }
    public func update(directParameter: Any = NoParameter,
            necessity: Any = NoParameter,
            registeringApplications: Any = NoParameter,
            waitReply: Bool = true, withTimeout: NSTimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent("update", eventClass: 0x666e6472, eventID: 0x66757064, // 'fndrfupd'
                parentSpecifier: (self as! Specifier), directParameter: directParameter, keywordParameters: [
                    ("necessity", 0x6e65633f, necessity), // 'nec?'
                    ("registeringApplications", 0x7265673f, registeringApplications), // 'reg?'
                ], requestedType: nil, waitReply: waitReply, sendOptions: nil,
                withTimeout: withTimeout, considering: considering, asType: Any.self)
    }
}


public protocol FINQuery: ObjectSpecifierExtension, FINCommand {} // provides vars and methods for constructing specifiers

extension FINQuery {
    
    // Properties
    public var FinderPreferences: FINObject {return self.property(0x70667270) as! FINObject} // 'pfrp'
    public var URL: FINObject {return self.property(0x7055524c) as! FINObject} // 'pURL'
    public var acceptsHighLevelEvents: FINObject {return self.property(0x69736162) as! FINObject} // 'isab'
    public var acceptsRemoteEvents: FINObject {return self.property(0x72657674) as! FINObject} // 'revt'
    public var allNameExtensionsShowing: FINObject {return self.property(0x70736e78) as! FINObject} // 'psnx'
    public var applicationFile: FINObject {return self.property(0x61707066) as! FINObject} // 'appf'
    public var arrangement: FINObject {return self.property(0x69617272) as! FINObject} // 'iarr'
    public var backgroundColor: FINObject {return self.property(0x636f6c72) as! FINObject} // 'colr'
    public var backgroundPicture: FINObject {return self.property(0x69626b67) as! FINObject} // 'ibkg'
    public var bounds: FINObject {return self.property(0x70626e64) as! FINObject} // 'pbnd'
    public var calculatesFolderSizes: FINObject {return self.property(0x7366737a) as! FINObject} // 'sfsz'
    public var capacity: FINObject {return self.property(0x63617061) as! FINObject} // 'capa'
    public var class_: FINObject {return self.property(0x70636c73) as! FINObject} // 'pcls'
    public var clipboard: FINObject {return self.property(0x70636c69) as! FINObject} // 'pcli'
    public var clippingWindow: FINObject {return self.property(0x6c776e64) as! FINObject} // 'lwnd'
    public var closeable: FINObject {return self.property(0x68636c62) as! FINObject} // 'hclb'
    public var collapsed: FINObject {return self.property(0x77736864) as! FINObject} // 'wshd'
    public var color: FINObject {return self.property(0x636f6c72) as! FINObject} // 'colr'
    public var columnViewOptions: FINObject {return self.property(0x63766f70) as! FINObject} // 'cvop'
    public var comment: FINObject {return self.property(0x636f6d74) as! FINObject} // 'comt'
    public var completelyExpanded: FINObject {return self.property(0x70657863) as! FINObject} // 'pexc'
    public var computerContainer: FINObject {return self.property(0x70636d70) as! FINObject} // 'pcmp'
    public var container: FINObject {return self.property(0x63746e72) as! FINObject} // 'ctnr'
    public var containerWindow: FINObject {return self.property(0x63776e64) as! FINObject} // 'cwnd'
    public var creationDate: FINObject {return self.property(0x61736364) as! FINObject} // 'ascd'
    public var creatorType: FINObject {return self.property(0x66637274) as! FINObject} // 'fcrt'
    public var currentPanel: FINObject {return self.property(0x70616e6c) as! FINObject} // 'panl'
    public var currentView: FINObject {return self.property(0x70766577) as! FINObject} // 'pvew'
    public var delayBeforeSpringing: FINObject {return self.property(0x64656c61) as! FINObject} // 'dela'
    public var description_: FINObject {return self.property(0x64736372) as! FINObject} // 'dscr'
    public var deskAccessoryFile: FINObject {return self.property(0x64616669) as! FINObject} // 'dafi'
    public var desktop: FINObject {return self.property(0x6465736b) as! FINObject} // 'desk'
    public var desktopPicture: FINObject {return self.property(0x64706963) as! FINObject} // 'dpic'
    public var desktopPosition: FINObject {return self.property(0x64706f73) as! FINObject} // 'dpos'
    public var desktopShowsConnectedServers: FINObject {return self.property(0x70647376) as! FINObject} // 'pdsv'
    public var desktopShowsExternalHardDisks: FINObject {return self.property(0x70656864) as! FINObject} // 'pehd'
    public var desktopShowsHardDisks: FINObject {return self.property(0x70646864) as! FINObject} // 'pdhd'
    public var desktopShowsRemovableMedia: FINObject {return self.property(0x7064726d) as! FINObject} // 'pdrm'
    public var disclosesPreviewPane: FINObject {return self.property(0x64737072) as! FINObject} // 'dspr'
    public var disk: FINObject {return self.property(0x63646973) as! FINObject} // 'cdis'
    public var displayedName: FINObject {return self.property(0x646e616d) as! FINObject} // 'dnam'
    public var ejectable: FINObject {return self.property(0x6973656a) as! FINObject} // 'isej'
    public var entireContents: FINObject {return self.property(0x65637473) as! FINObject} // 'ects'
    public var everyonesPrivileges: FINObject {return self.property(0x67737470) as! FINObject} // 'gstp'
    public var expandable: FINObject {return self.property(0x70657861) as! FINObject} // 'pexa'
    public var expanded: FINObject {return self.property(0x70657870) as! FINObject} // 'pexp'
    public var extensionHidden: FINObject {return self.property(0x68696478) as! FINObject} // 'hidx'
    public var file: FINObject {return self.property(0x66696c65) as! FINObject} // 'file'
    public var fileType: FINObject {return self.property(0x61737479) as! FINObject} // 'asty'
    public var floating: FINObject {return self.property(0x6973666c) as! FINObject} // 'isfl'
    public var foldersOpenInNewTabs: FINObject {return self.property(0x706f6e74) as! FINObject} // 'pont'
    public var foldersOpenInNewWindows: FINObject {return self.property(0x706f6e77) as! FINObject} // 'ponw'
    public var foldersSpringOpen: FINObject {return self.property(0x73707267) as! FINObject} // 'sprg'
    public var format: FINObject {return self.property(0x64666d74) as! FINObject} // 'dfmt'
    public var freeSpace: FINObject {return self.property(0x66727370) as! FINObject} // 'frsp'
    public var frontmost: FINObject {return self.property(0x70697366) as! FINObject} // 'pisf'
    public var group: FINObject {return self.property(0x73677270) as! FINObject} // 'sgrp'
    public var groupPrivileges: FINObject {return self.property(0x67707072) as! FINObject} // 'gppr'
    public var hasScriptingTerminology: FINObject {return self.property(0x68736372) as! FINObject} // 'hscr'
    public var home: FINObject {return self.property(0x686f6d65) as! FINObject} // 'home'
    public var icon: FINObject {return self.property(0x69696d67) as! FINObject} // 'iimg'
    public var iconSize: FINObject {return self.property(0x6c766973) as! FINObject} // 'lvis'
    public var iconViewOptions: FINObject {return self.property(0x69636f70) as! FINObject} // 'icop'
    public var id: FINObject {return self.property(0x49442020) as! FINObject} // 'ID  '
    public var ignorePrivileges: FINObject {return self.property(0x69677072) as! FINObject} // 'igpr'
    public var index: FINObject {return self.property(0x70696478) as! FINObject} // 'pidx'
    public var informationWindow: FINObject {return self.property(0x69776e64) as! FINObject} // 'iwnd'
    public var insertionLocation: FINObject {return self.property(0x70696e73) as! FINObject} // 'pins'
    public var item: FINObject {return self.property(0x636f626a) as! FINObject} // 'cobj'
    public var journalingEnabled: FINObject {return self.property(0x4a726e6c) as! FINObject} // 'Jrnl'
    public var kind: FINObject {return self.property(0x6b696e64) as! FINObject} // 'kind'
    public var labelIndex: FINObject {return self.property(0x6c616269) as! FINObject} // 'labi'
    public var labelPosition: FINObject {return self.property(0x6c706f73) as! FINObject} // 'lpos'
    public var large32BitIcon: FINObject {return self.property(0x696c3332) as! FINObject} // 'il32'
    public var large4BitIcon: FINObject {return self.property(0x69636c34) as! FINObject} // 'icl4'
    public var large8BitIcon: FINObject {return self.property(0x69636c38) as! FINObject} // 'icl8'
    public var large8BitMask: FINObject {return self.property(0x6c386d6b) as! FINObject} // 'l8mk'
    public var largeMonochromeIconAndMask: FINObject {return self.property(0x49434e23) as! FINObject} // 'ICN#'
    public var listViewOptions: FINObject {return self.property(0x6c766f70) as! FINObject} // 'lvop'
    public var localVolume: FINObject {return self.property(0x69737276) as! FINObject} // 'isrv'
    public var location: FINObject {return self.property(0x696c6f63) as! FINObject} // 'iloc'
    public var locked: FINObject {return self.property(0x61736c6b) as! FINObject} // 'aslk'
    public var maximumWidth: FINObject {return self.property(0x636c776d) as! FINObject} // 'clwm'
    public var minimumSize: FINObject {return self.property(0x6d707274) as! FINObject} // 'mprt'
    public var minimumWidth: FINObject {return self.property(0x636c776e) as! FINObject} // 'clwn'
    public var modal: FINObject {return self.property(0x706d6f64) as! FINObject} // 'pmod'
    public var modificationDate: FINObject {return self.property(0x61736d6f) as! FINObject} // 'asmo'
    public var name: FINObject {return self.property(0x706e616d) as! FINObject} // 'pnam'
    public var nameExtension: FINObject {return self.property(0x6e6d7874) as! FINObject} // 'nmxt'
    public var newWindowTarget: FINObject {return self.property(0x706e7774) as! FINObject} // 'pnwt'
    public var newWindowsOpenInColumnView: FINObject {return self.property(0x706f6376) as! FINObject} // 'pocv'
    public var opensInClassic: FINObject {return self.property(0x436c7363) as! FINObject} // 'Clsc'
    public var originalItem: FINObject {return self.property(0x6f726967) as! FINObject} // 'orig'
    public var owner: FINObject {return self.property(0x736f776e) as! FINObject} // 'sown'
    public var ownerPrivileges: FINObject {return self.property(0x6f776e72) as! FINObject} // 'ownr'
    public var partitionSpaceUsed: FINObject {return self.property(0x70757364) as! FINObject} // 'pusd'
    public var physicalSize: FINObject {return self.property(0x70687973) as! FINObject} // 'phys'
    public var position: FINObject {return self.property(0x706f736e) as! FINObject} // 'posn'
    public var preferredSize: FINObject {return self.property(0x61707074) as! FINObject} // 'appt'
    public var productVersion: FINObject {return self.property(0x76657232) as! FINObject} // 'ver2'
    public var properties: FINObject {return self.property(0x70414c4c) as! FINObject} // 'pALL'
    public var resizable: FINObject {return self.property(0x7072737a) as! FINObject} // 'prsz'
    public var selection: FINObject {return self.property(0x73656c65) as! FINObject} // 'sele'
    public var showsIcon: FINObject {return self.property(0x73686963) as! FINObject} // 'shic'
    public var showsIconPreview: FINObject {return self.property(0x70727677) as! FINObject} // 'prvw'
    public var showsItemInfo: FINObject {return self.property(0x6d6e666f) as! FINObject} // 'mnfo'
    public var showsPreviewColumn: FINObject {return self.property(0x73687072) as! FINObject} // 'shpr'
    public var sidebarWidth: FINObject {return self.property(0x73627769) as! FINObject} // 'sbwi'
    public var size: FINObject {return self.property(0x7074737a) as! FINObject} // 'ptsz'
    public var small32BitIcon: FINObject {return self.property(0x69733332) as! FINObject} // 'is32'
    public var small4BitIcon: FINObject {return self.property(0x69637334) as! FINObject} // 'ics4'
    public var small8BitIcon: FINObject {return self.property(0x69637338) as! FINObject} // 'ics8'
    public var small8BitMask: FINObject {return self.property(0x69637338) as! FINObject} // 'ics8'
    public var smallMonochromeIconAndMask: FINObject {return self.property(0x69637323) as! FINObject} // 'ics#'
    public var sortColumn: FINObject {return self.property(0x73727463) as! FINObject} // 'srtc'
    public var sortDirection: FINObject {return self.property(0x736f7264) as! FINObject} // 'sord'
    public var startup: FINObject {return self.property(0x69737464) as! FINObject} // 'istd'
    public var startupDisk: FINObject {return self.property(0x7364736b) as! FINObject} // 'sdsk'
    public var stationery: FINObject {return self.property(0x70737064) as! FINObject} // 'pspd'
    public var statusbarVisible: FINObject {return self.property(0x73747669) as! FINObject} // 'stvi'
    public var suggestedSize: FINObject {return self.property(0x73707274) as! FINObject} // 'sprt'
    public var target: FINObject {return self.property(0x66767467) as! FINObject} // 'fvtg'
    public var textSize: FINObject {return self.property(0x6673697a) as! FINObject} // 'fsiz'
    public var titled: FINObject {return self.property(0x70746974) as! FINObject} // 'ptit'
    public var toolbarVisible: FINObject {return self.property(0x74627669) as! FINObject} // 'tbvi'
    public var totalPartitionSize: FINObject {return self.property(0x61707074) as! FINObject} // 'appt'
    public var trash: FINObject {return self.property(0x74727368) as! FINObject} // 'trsh'
    public var usesRelativeDates: FINObject {return self.property(0x75726474) as! FINObject} // 'urdt'
    public var version_: FINObject {return self.property(0x76657273) as! FINObject} // 'vers'
    public var visible: FINObject {return self.property(0x70766973) as! FINObject} // 'pvis'
    public var warnsBeforeEmptying: FINObject {return self.property(0x7761726e) as! FINObject} // 'warn'
    public var width: FINObject {return self.property(0x636c7764) as! FINObject} // 'clwd'
    public var window: FINObject {return self.property(0x6377696e) as! FINObject} // 'cwin'
    public var zoomable: FINObject {return self.property(0x69737a6d) as! FINObject} // 'iszm'
    public var zoomed: FINObject {return self.property(0x707a756d) as! FINObject} // 'pzum'

    // Elements
    public var FinderWindows: FINElements {return self.elements(0x62726f77) as! FINElements} // 'brow'
    public var aliasFiles: FINElements {return self.elements(0x616c6961) as! FINElements} // 'alia'
    public var aliasLists: FINElements {return self.elements(0x616c7374) as! FINElements} // 'alst'
    public var applicationFiles: FINElements {return self.elements(0x61707066) as! FINElements} // 'appf'
    public var applicationProcesses: FINElements {return self.elements(0x70636170) as! FINElements} // 'pcap'
    public var applications: FINElements {return self.elements(0x63617070) as! FINElements} // 'capp'
    public var clippingWindows: FINElements {return self.elements(0x6c776e64) as! FINElements} // 'lwnd'
    public var clippings: FINElements {return self.elements(0x636c7066) as! FINElements} // 'clpf'
    public var columnViewOptionss: FINElements {return self.elements(0x63766f70) as! FINElements} // 'cvop'
    public var columns: FINElements {return self.elements(0x6c76636c) as! FINElements} // 'lvcl'
    public var computerObjects: FINElements {return self.elements(0x63636d70) as! FINElements} // 'ccmp'
    public var containers: FINElements {return self.elements(0x63746e72) as! FINElements} // 'ctnr'
    public var deskAccessoryProcesses: FINElements {return self.elements(0x70636461) as! FINElements} // 'pcda'
    public var desktopObjects: FINElements {return self.elements(0x6364736b) as! FINElements} // 'cdsk'
    public var desktopWindows: FINElements {return self.elements(0x646b7477) as! FINElements} // 'dktw'
    public var disks: FINElements {return self.elements(0x63646973) as! FINElements} // 'cdis'
    public var documentFiles: FINElements {return self.elements(0x646f6366) as! FINElements} // 'docf'
    public var files: FINElements {return self.elements(0x66696c65) as! FINElements} // 'file'
    public var folders: FINElements {return self.elements(0x63666f6c) as! FINElements} // 'cfol'
    public var iconFamilys: FINElements {return self.elements(0x6966616d) as! FINElements} // 'ifam'
    public var iconViewOptionss: FINElements {return self.elements(0x69636f70) as! FINElements} // 'icop'
    public var informationWindows: FINElements {return self.elements(0x69776e64) as! FINElements} // 'iwnd'
    public var internetLocationFiles: FINElements {return self.elements(0x696e6c66) as! FINElements} // 'inlf'
    public var items: FINElements {return self.elements(0x636f626a) as! FINElements} // 'cobj'
    public var labels: FINElements {return self.elements(0x636c626c) as! FINElements} // 'clbl'
    public var listViewOptionss: FINElements {return self.elements(0x6c766f70) as! FINElements} // 'lvop'
    public var packages: FINElements {return self.elements(0x7061636b) as! FINElements} // 'pack'
    public var preferencesWindows: FINElements {return self.elements(0x70776e64) as! FINElements} // 'pwnd'
    public var preferencess: FINElements {return self.elements(0x63707266) as! FINElements} // 'cprf'
    public var processes: FINElements {return self.elements(0x70726373) as! FINElements} // 'prcs'
    public var trashObjects: FINElements {return self.elements(0x63747273) as! FINElements} // 'ctrs'
    public var windows: FINElements {return self.elements(0x6377696e) as! FINElements} // 'cwin'
}


/******************************************************************************/
// Specifier subclasses add app-specific extensions

public class FINInsertion: InsertionSpecifier, FINCommand {}

public class FINObject: ObjectSpecifier, FINQuery {
    public typealias InsertionSpecifierType = FINInsertion
    public typealias ObjectSpecifierType = FINObject
    public typealias ElementsSpecifierType = FINElements
}

public class FINElements: FINObject, ElementsSpecifierExtension {}

public class FINRoot: RootSpecifier, FINQuery {
    public typealias InsertionSpecifierType = FINInsertion
    public typealias ObjectSpecifierType = FINObject
    public typealias ElementsSpecifierType = FINElements
    public override class var nullAppData: AppData { return gNullAppData }
}

public class Finder: FINRoot, ApplicationExtension {

    public convenience init(launchOptions: LaunchOptions = DefaultLaunchOptions, relaunchMode: RelaunchMode = DefaultRelaunchMode) {
        self.init(bundleIdentifier: "com.apple.finder", launchOptions: launchOptions, relaunchMode: relaunchMode)
    }

}

// App/Con/Its root objects used to construct untargeted specifiers; these can be used to construct specifiers for use in commands, though cannot send commands themselves

public let FINApp = gNullAppData.rootObjects.app as! FINRoot
public let FINCon = gNullAppData.rootObjects.con as! FINRoot
public let FINIts = gNullAppData.rootObjects.its as! FINRoot

