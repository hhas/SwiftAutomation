//
//  MailGlue.swift
//  Mail.app 12.4
//  SwiftAutomation.framework 0.1.0
//  `aeglue -S 'Mail.app'`
//


import Foundation
import SwiftAutomation


/******************************************************************************/
// Create an untargeted AppData instance for use in App, Con, Its roots,
// and in Application initializers to create targeted AppData instances.

private let _specifierFormatter = SwiftAutomation.SpecifierFormatter(applicationClassName: "Mail",
                                                     classNamePrefix: "MAI",
                                                     typeNames: [
                                                                     0x74616363: "account", // "tacc"
                                                                     0x6d616374: "account", // "mact"
                                                                     0x70617468: "accountDirectory", // "path"
                                                                     0x61747970: "accountType", // "atyp"
                                                                     0x72616464: "address", // "radd"
                                                                     0x616c6973: "alias", // "alis"
                                                                     0x6864616c: "all_", // "hdal"
                                                                     0x7261636d: "allConditionsMustBeMet", // "racm"
                                                                     0x616c6865: "allHeaders", // "alhe"
                                                                     0x7839616c: "allMessagesAndTheirAttachments", // "x9al"
                                                                     0x7839626f: "allMessagesButOmitAttachments", // "x9bo"
                                                                     0x6162636d: "alwaysBccMyself", // "abcm"
                                                                     0x6163636d: "alwaysCcMyself", // "accm"
                                                                     0x74616e72: "anyRecipient", // "tanr"
                                                                     0x2a2a2a2a: "anything", // "****"
                                                                     0x6161706f: "apop", // "aapo"
                                                                     0x61746f6b: "AppleToken", // "atok"
                                                                     0x63617070: "application", // "capp"
                                                                     0x62756e64: "applicationBundleID", // "bund"
                                                                     0x7369676e: "applicationSignature", // "sign"
                                                                     0x6170726c: "applicationURL", // "aprl"
                                                                     0x61707665: "applicationVersion", // "apve"
                                                                     0x61707220: "April", // "apr\0x20"
                                                                     0x61736b20: "ask", // "ask\0x20"
                                                                     0x61747473: "attachment", // "atts"
                                                                     0x65636174: "attachmentsColumn", // "ecat"
                                                                     0x74617474: "attachmentType", // "tatt"
                                                                     0x63617472: "attributeRun", // "catr"
                                                                     0x61756720: "August", // "aug\0x20"
                                                                     0x70617573: "authentication", // "paus"
                                                                     0x62746863: "backgroundActivityCount", // "bthc"
                                                                     0x6d636f6c: "backgroundColor", // "mcol"
                                                                     0x6c736261: "base", // "lsba"
                                                                     0x62726370: "bccRecipient", // "brcp"
                                                                     0x72716277: "beginsWithValue", // "rqbw"
                                                                     0x62657374: "best", // "best"
                                                                     0x626d7773: "bigMessageWarningSize", // "bmws"
                                                                     0x6363626c: "blue", // "ccbl"
                                                                     0x626d726b: "bookmarkData", // "bmrk"
                                                                     0x626f6f6c: "boolean", // "bool"
                                                                     0x71647274: "boundingRectangle", // "qdrt"
                                                                     0x70626e64: "bounds", // "pbnd"
                                                                     0x63617365: "case_", // "case"
                                                                     0x74636363: "ccHeader", // "tccc"
                                                                     0x63726370: "ccRecipient", // "crcp"
                                                                     0x63686120: "character", // "cha\0x20"
                                                                     0x63687370: "checkSpellingWhileTyping", // "chsp"
                                                                     0x63737763: "chooseSignatureWhenComposing", // "cswc"
                                                                     0x70636c73: "class_", // "pcls"
                                                                     0x68636c62: "closeable", // "hclb"
                                                                     0x6c77636c: "collating", // "lwcl"
                                                                     0x636f6c72: "color", // "colr"
                                                                     0x72636d65: "colorMessage", // "rcme"
                                                                     0x6d636374: "colorQuotedText", // "mcct"
                                                                     0x636c7274: "colorTable", // "clrt"
                                                                     0x6377636d: "compactMailboxesWhenClosing", // "cwcm"
                                                                     0x656e756d: "constant", // "enum"
                                                                     0x6d627863: "container", // "mbxc"
                                                                     0x63746e74: "content", // "ctnt"
                                                                     0x6c776370: "copies", // "lwcp"
                                                                     0x72636d62: "copyMessage", // "rcmb"
                                                                     0x68646375: "custom", // "hdcu"
                                                                     0x74646173: "dashStyle", // "tdas"
                                                                     0x74647461: "data", // "tdta"
                                                                     0x6c647420: "date", // "ldt\0x20"
                                                                     0x65636c73: "dateLastSavedColumn", // "ecls"
                                                                     0x72647263: "dateReceived", // "rdrc"
                                                                     0x65636472: "dateReceivedColumn", // "ecdr"
                                                                     0x64726376: "dateSent", // "drcv"
                                                                     0x65636473: "dateSentColumn", // "ecds"
                                                                     0x64656320: "December", // "dec\0x20"
                                                                     0x6465636d: "decimalStruct", // "decm"
                                                                     0x68646465: "default_", // "hdde"
                                                                     0x64656d66: "defaultMessageFormat", // "demf"
                                                                     0x646d6469: "delayedMessageDeletionInterval", // "dmdi"
                                                                     0x6973646c: "deletedStatus", // "isdl"
                                                                     0x646d6f73: "deleteMailOnServer", // "dmos"
                                                                     0x72646d65: "deleteMessage", // "rdme"
                                                                     0x646d776d: "deleteMessagesWhenMovedFromInbox", // "dmwm"
                                                                     0x6c776474: "detailed", // "lwdt"
                                                                     0x64696163: "diacriticals", // "diac"
                                                                     0x646f6375: "document", // "docu"
                                                                     0x7271636f: "doesContainValue", // "rqco"
                                                                     0x7271646e: "doesNotContainValue", // "rqdn"
                                                                     0x78396e6f: "doNotKeepCopiesOfAnyMessages", // "x9no"
                                                                     0x636f6d70: "doubleInteger", // "comp"
                                                                     0x6174646e: "downloaded", // "atdn"
                                                                     0x64687461: "downloadHtmlAttachments", // "dhta"
                                                                     0x64726d62: "draftsMailbox", // "drmb"
                                                                     0x656d6164: "emailAddresses", // "emad"
                                                                     0x656a6d66: "emptyJunkMessagesFrequency", // "ejmf"
                                                                     0x656a6d6f: "emptyJunkMessagesOnQuit", // "ejmo"
                                                                     0x65736d66: "emptySentMessagesFrequency", // "esmf"
                                                                     0x65736d6f: "emptySentMessagesOnQuit", // "esmo"
                                                                     0x65747266: "emptyTrashFrequency", // "etrf"
                                                                     0x65746f71: "emptyTrashOnQuit", // "etoq"
                                                                     0x69736163: "enabled", // "isac"
                                                                     0x656e6373: "encodedString", // "encs"
                                                                     0x6c776c70: "endingPage", // "lwlp"
                                                                     0x72716577: "endsWithValue", // "rqew"
                                                                     0x45505320: "EPSPicture", // "EPS\0x20"
                                                                     0x72716965: "equalToValue", // "rqie"
                                                                     0x6c776568: "errorHandling", // "lweh"
                                                                     0x65786761: "expandGroupAddresses", // "exga"
                                                                     0x65787061: "expansion", // "expa"
                                                                     0x72657870: "expression", // "rexp"
                                                                     0x65787465: "extendedReal", // "exte"
                                                                     0x61657874: "external", // "aext"
                                                                     0x6661786e: "faxNumber", // "faxn"
                                                                     0x66656220: "February", // "feb\0x20"
                                                                     0x73616674: "fetchesAutomatically", // "saft"
                                                                     0x61666671: "fetchInterval", // "affq"
                                                                     0x66696c65: "file", // "file"
                                                                     0x6174666e: "fileName", // "atfn"
                                                                     0x66737266: "fileRef", // "fsrf"
                                                                     0x6174737a: "fileSize", // "atsz"
                                                                     0x66737320: "fileSpecification", // "fss\0x20"
                                                                     0x6675726c: "fileURL", // "furl"
                                                                     0x66697864: "fixed", // "fixd"
                                                                     0x66706e74: "fixedPoint", // "fpnt"
                                                                     0x66726374: "fixedRectangle", // "frct"
                                                                     0x6d707466: "fixedWidthFont", // "mptf"
                                                                     0x70746673: "fixedWidthFontSize", // "ptfs"
                                                                     0x6973666c: "flaggedStatus", // "isfl"
                                                                     0x66696478: "flagIndex", // "fidx"
                                                                     0x6563666c: "flagsColumn", // "ecfl"
                                                                     0x666f6e74: "font", // "font"
                                                                     0x72666164: "forwardMessage", // "rfad"
                                                                     0x72667465: "forwardText", // "rfte"
                                                                     0x66727665: "frameworkVersion", // "frve"
                                                                     0x66726920: "Friday", // "fri\0x20"
                                                                     0x65636672: "fromColumn", // "ecfr"
                                                                     0x7466726f: "fromHeader", // "tfro"
                                                                     0x70697366: "frontmost", // "pisf"
                                                                     0x666c6c6e: "fullName", // "flln"
                                                                     0x47494666: "GIFPicture", // "GIFf"
                                                                     0x63677478: "graphicText", // "cgtx"
                                                                     0x63636779: "gray", // "ccgy"
                                                                     0x72716774: "greaterThanValue", // "rqgt"
                                                                     0x63636772: "green", // "ccgr"
                                                                     0x6d686472: "header", // "mhdr"
                                                                     0x72686564: "header", // "rhed"
                                                                     0x6865646c: "headerDetail", // "hedl"
                                                                     0x7468646b: "headerKey", // "thdk"
                                                                     0x73686874: "highlightSelectedConversation", // "shht"
                                                                     0x68747563: "highlightTextUsingColor", // "htuc"
                                                                     0x6c647361: "hostName", // "ldsa"
                                                                     0x6c616f68: "hostsToLogActivityOn", // "laoh"
                                                                     0x68746461: "htmlContent", // "htda"
                                                                     0x68797068: "hyphens", // "hyph"
                                                                     0x65746974: "iCloud", // "etit"
                                                                     0x69746163: "iCloudAccount", // "itac"
                                                                     0x49442020: "id", // "ID\0x20\0x20"
                                                                     0x6574696d: "imap", // "etim"
                                                                     0x69616374: "imapAccount", // "iact"
                                                                     0x696e6d62: "inbox", // "inmb"
                                                                     0x69616f6f: "includeAllOriginalMessageText", // "iaoo"
                                                                     0x6977676d: "includeWhenGettingNewMail", // "iwgm"
                                                                     0x70696478: "index", // "pidx"
                                                                     0x6c6f6e67: "integer", // "long"
                                                                     0x69747874: "internationalText", // "itxt"
                                                                     0x696e746c: "internationalWritingCode", // "intl"
                                                                     0x636f626a: "item", // "cobj"
                                                                     0x6a616e20: "January", // "jan\0x20"
                                                                     0x4a504547: "JPEGPicture", // "JPEG"
                                                                     0x6a756c20: "July", // "jul\0x20"
                                                                     0x6a756e20: "June", // "jun\0x20"
                                                                     0x6a6b6d62: "junkMailbox", // "jkmb"
                                                                     0x69736a6b: "junkMailStatus", // "isjk"
                                                                     0x61786b35: "kerberos5", // "axk5"
                                                                     0x6b706964: "kernelProcessID", // "kpid"
                                                                     0x6c64626c: "largeReal", // "ldbl"
                                                                     0x6c647365: "ldapServer", // "ldse"
                                                                     0x72716c74: "lessThanValue", // "rqlt"
                                                                     0x6c6f7163: "levelOneQuotingColor", // "loqc"
                                                                     0x6c687163: "levelThreeQuotingColor", // "lhqc"
                                                                     0x6c777163: "levelTwoQuotingColor", // "lwqc"
                                                                     0x6c697374: "list", // "list"
                                                                     0x696e736c: "locationReference", // "insl"
                                                                     0x6c616173: "logAllSocketActivity", // "laas"
                                                                     0x6c667864: "longFixed", // "lfxd"
                                                                     0x6c667074: "longFixedPoint", // "lfpt"
                                                                     0x6c667263: "longFixedRectangle", // "lfrc"
                                                                     0x6c706e74: "longPoint", // "lpnt"
                                                                     0x6c726374: "longRectangle", // "lrct"
                                                                     0x6d616368: "machine", // "mach"
                                                                     0x6d4c6f63: "machineLocation", // "mLoc"
                                                                     0x61747463: "mailAttachment", // "attc"
                                                                     0x6d627870: "mailbox", // "mbxp"
                                                                     0x65636d62: "mailboxColumn", // "ecmb"
                                                                     0x6d6c7368: "mailboxListVisible", // "mlsh"
                                                                     0x6d617220: "March", // "mar\0x20"
                                                                     0x726d666c: "markFlagged", // "rmfl"
                                                                     0x7266636c: "markFlagIndex", // "rfcl"
                                                                     0x726d7265: "markRead", // "rmre"
                                                                     0x7465766d: "matchesEveryMessage", // "tevm"
                                                                     0x6d617920: "May", // "may\0x20"
                                                                     0x61786d64: "md5", // "axmd"
                                                                     0x6d656d73: "memoryStatistics", // "mems"
                                                                     0x6d737367: "message", // "mssg"
                                                                     0x6d736763: "messageCaching", // "msgc"
                                                                     0x6563636c: "messageColor", // "eccl"
                                                                     0x746d6563: "messageContent", // "tmec"
                                                                     0x6d6d666e: "messageFont", // "mmfn"
                                                                     0x6d6d6673: "messageFontSize", // "mmfs"
                                                                     0x6d656964: "messageId", // "meid"
                                                                     0x746d696a: "messageIsJunkMail", // "tmij"
                                                                     0x6d6d6c66: "messageListFont", // "mmlf"
                                                                     0x6d6c6673: "messageListFontSize", // "mlfs"
                                                                     0x746e7267: "messageSignature", // "tnrg"
                                                                     0x6d737a65: "messageSize", // "msze"
                                                                     0x65636d73: "messageStatusColumn", // "ecms"
                                                                     0x6d767772: "messageViewer", // "mvwr"
                                                                     0x61747470: "MIMEType", // "attp"
                                                                     0x69736d6e: "miniaturizable", // "ismn"
                                                                     0x706d6e64: "miniaturized", // "pmnd"
                                                                     0x696d6f64: "modified", // "imod"
                                                                     0x6d6f6e20: "Monday", // "mon\0x20"
                                                                     0x736d646d: "moveDeletedMessagesToTrash", // "smdm"
                                                                     0x72746d65: "moveMessage", // "rtme"
                                                                     0x706e616d: "name", // "pnam"
                                                                     0x6974656d: "nativeFormat", // "item"
                                                                     0x6d6e6d73: "newMailSound", // "mnms"
                                                                     0x6e6f2020: "no", // "no\0x20\0x20"
                                                                     0x68646e6e: "noHeaders", // "hdnn"
                                                                     0x72716e6f: "none", // "rqno"
                                                                     0x63636e6f: "none", // "ccno"
                                                                     0x6e6f7620: "November", // "nov\0x20"
                                                                     0x61786e74: "ntlm", // "axnt"
                                                                     0x6e756c6c: "null", // "null"
                                                                     0x65636e6d: "numberColumn", // "ecnm"
                                                                     0x6e756d65: "numericStrings", // "nume"
                                                                     0x6f637420: "October", // "oct\0x20"
                                                                     0x6d656474: "OLDMessageEditor", // "medt"
                                                                     0x6c736f6c: "oneLevel", // "lsol"
                                                                     0x78397772: "onlyMessagesIHaveRead", // "x9wr"
                                                                     0x63636f72: "orange", // "ccor"
                                                                     0x63636f74: "other", // "ccot"
                                                                     0x6f756d62: "outbox", // "oumb"
                                                                     0x62636b65: "outgoingMessage", // "bcke"
                                                                     0x6c776c61: "pagesAcross", // "lwla"
                                                                     0x6c776c64: "pagesDown", // "lwld"
                                                                     0x63706172: "paragraph", // "cpar"
                                                                     0x6d616370: "password", // "macp"
                                                                     0x61786374: "password", // "axct"
                                                                     0x50494354: "PICTPicture", // "PICT"
                                                                     0x74706d6d: "pixelMapRecord", // "tpmm"
                                                                     0x646d7074: "plainFormat", // "dmpt"
                                                                     0x7270736f: "playSound", // "rpso"
                                                                     0x51447074: "point", // "QDpt"
                                                                     0x6574706f: "pop", // "etpo"
                                                                     0x70616374: "popAccount", // "pact"
                                                                     0x706f7274: "port", // "port"
                                                                     0x6c616f70: "portsToLogActivityOn", // "laop"
                                                                     0x6d767076: "previewPaneIsVisible", // "mvpv"
                                                                     0x75656d6c: "primaryEmail", // "ueml"
                                                                     0x70736574: "printSettings", // "pset"
                                                                     0x70736e20: "processSerialNumber", // "psn\0x20"
                                                                     0x70414c4c: "properties", // "pALL"
                                                                     0x70726f70: "property_", // "prop"
                                                                     0x70756e63: "punctuation", // "punc"
                                                                     0x63637075: "purple", // "ccpu"
                                                                     0x72717561: "qualifier", // "rqua"
                                                                     0x696e6f6d: "quoteOriginalMessage", // "inom"
                                                                     0x69737264: "readStatus", // "isrd"
                                                                     0x646f7562: "real", // "doub"
                                                                     0x72637074: "recipient", // "rcpt"
                                                                     0x7265636f: "record", // "reco"
                                                                     0x63637265: "red", // "ccre"
                                                                     0x72726164: "redirectMessage", // "rrad"
                                                                     0x6f626a20: "reference", // "obj\0x20"
                                                                     0x72727465: "replyText", // "rrte"
                                                                     0x7270746f: "replyTo", // "rpto"
                                                                     0x6c777174: "requestedPrintTime", // "lwqt"
                                                                     0x7072737a: "resizable", // "prsz"
                                                                     0x74723136: "RGB16Color", // "tr16"
                                                                     0x74723936: "RGB96Color", // "tr96"
                                                                     0x63524742: "RGBColor", // "cRGB"
                                                                     0x646d7274: "richFormat", // "dmrt"
                                                                     0x63747874: "richText", // "ctxt"
                                                                     0x74726f74: "rotation", // "trot"
                                                                     0x72756c65: "rule", // "rule"
                                                                     0x72756372: "ruleCondition", // "rucr"
                                                                     0x72747970: "ruleType", // "rtyp"
                                                                     0x72726173: "runScript", // "rras"
                                                                     0x72697366: "sameReplyFormat", // "risf"
                                                                     0x73617420: "Saturday", // "sat\0x20"
                                                                     0x6c647363: "scope", // "ldsc"
                                                                     0x73637074: "script", // "scpt"
                                                                     0x6c647362: "searchBase", // "ldsb"
                                                                     0x6d736278: "selectedMailboxes", // "msbx"
                                                                     0x736d6773: "selectedMessages", // "smgs"
                                                                     0x73657369: "selectedSignature", // "sesi"
                                                                     0x736c6374: "selection", // "slct"
                                                                     0x736e6472: "sender", // "sndr"
                                                                     0x74736969: "senderIsInMyContacts", // "tsii"
                                                                     0x74736168: "senderIsInMyPreviousRecipients", // "tsah"
                                                                     0x7473696d: "senderIsMemberOfGroup", // "tsim"
                                                                     0x7473696e: "senderIsNotInMyContacts", // "tsin"
                                                                     0x746e6168: "senderIsNotInMyPreviousRecipients", // "tnah"
                                                                     0x74736967: "senderIsVIP", // "tsig"
                                                                     0x73746d62: "sentMailbox", // "stmb"
                                                                     0x73657020: "September", // "sep\0x20"
                                                                     0x686f7374: "serverName", // "host"
                                                                     0x73686f72: "shortInteger", // "shor"
                                                                     0x7273636d: "shouldCopyMessage", // "rscm"
                                                                     0x7273746d: "shouldMoveMessage", // "rstm"
                                                                     0x706f6d73: "shouldPlayOtherMailSounds", // "poms"
                                                                     0x73697475: "signature", // "situ"
                                                                     0x7074737a: "size", // "ptsz"
                                                                     0x6563737a: "sizeColumn", // "ecsz"
                                                                     0x73696e67: "smallReal", // "sing"
                                                                     0x6574736d: "smtp", // "etsm"
                                                                     0x64616374: "smtpServer", // "dact"
                                                                     0x6d767363: "sortColumn", // "mvsc"
                                                                     0x6d767372: "sortedAscending", // "mvsr"
                                                                     0x7261736f: "source", // "raso"
                                                                     0x6c777374: "standard", // "lwst"
                                                                     0x6c776670: "startingPage", // "lwfp"
                                                                     0x72736572: "stopEvaluatingRules", // "rser"
                                                                     0x73746f73: "storeDeletedMessagesOnServer", // "stos"
                                                                     0x73646f73: "storeDraftsOnServer", // "sdos"
                                                                     0x736a6f73: "storeJunkMailOnServer", // "sjos"
                                                                     0x73736f73: "storeSentMessagesOnServer", // "ssos"
                                                                     0x54455854: "string", // "TEXT"
                                                                     0x7374796c: "styledClipboardText", // "styl"
                                                                     0x53545854: "styledText", // "STXT"
                                                                     0x7375626a: "subject", // "subj"
                                                                     0x65637375: "subjectColumn", // "ecsu"
                                                                     0x74737562: "subjectHeader", // "tsub"
                                                                     0x6c737374: "subtree", // "lsst"
                                                                     0x73756e20: "Sunday", // "sun\0x20"
                                                                     0x74727072: "targetPrinter", // "trpr"
                                                                     0x74737479: "textStyleInfo", // "tsty"
                                                                     0x74687520: "Thursday", // "thu\0x20"
                                                                     0x54494646: "TIFFPicture", // "TIFF"
                                                                     0x6563746f: "toColumn", // "ecto"
                                                                     0x74746f6f: "toHeader", // "ttoo"
                                                                     0x74746f63: "toOrCcHeader", // "ttoc"
                                                                     0x74726370: "toRecipient", // "trcp"
                                                                     0x74726d62: "trashMailbox", // "trmb"
                                                                     0x74756520: "Tuesday", // "tue\0x20"
                                                                     0x74797065: "typeClass", // "type"
                                                                     0x75747874: "UnicodeText", // "utxt"
                                                                     0x6574756e: "unknown", // "etun"
                                                                     0x6d627563: "unreadCount", // "mbuc"
                                                                     0x75636f6d: "unsignedDoubleInteger", // "ucom"
                                                                     0x6d61676e: "unsignedInteger", // "magn"
                                                                     0x75736872: "unsignedShortInteger", // "ushr"
                                                                     0x75736c61: "useAddressCompletion", // "usla"
                                                                     0x75667766: "useFixedWidthFont", // "ufwf"
                                                                     0x75736b65: "useKeychain", // "uske"
                                                                     0x756e6d65: "userName", // "unme"
                                                                     0x75737373: "usesSsl", // "usss"
                                                                     0x75743136: "UTF16Text", // "ut16"
                                                                     0x75746638: "UTF8Text", // "utf8"
                                                                     0x68747663: "vcardPath", // "htvc"
                                                                     0x76657273: "version", // "vers"
                                                                     0x70766973: "visible", // "pvis"
                                                                     0x6d767663: "visibleColumns", // "mvvc"
                                                                     0x6d76666d: "visibleMessages", // "mvfm"
                                                                     0x69736677: "wasForwarded", // "isfw"
                                                                     0x69737263: "wasRedirected", // "isrc"
                                                                     0x69737270: "wasRepliedTo", // "isrp"
                                                                     0x77656420: "Wednesday", // "wed\0x20"
                                                                     0x77686974: "whitespace", // "whit"
                                                                     0x6377696e: "window", // "cwin"
                                                                     0x63776f72: "word", // "cwor"
                                                                     0x70736374: "writingCode", // "psct"
                                                                     0x63637965: "yellow", // "ccye"
                                                                     0x79657320: "yes", // "yes\0x20"
                                                                     0x69737a6d: "zoomable", // "iszm"
                                                                     0x707a756d: "zoomed", // "pzum"
                                                     ],
                                                     propertyNames: [
                                                                     0x6d616374: "account", // "mact"
                                                                     0x70617468: "accountDirectory", // "path"
                                                                     0x61747970: "accountType", // "atyp"
                                                                     0x72616464: "address", // "radd"
                                                                     0x7261636d: "allConditionsMustBeMet", // "racm"
                                                                     0x616c6865: "allHeaders", // "alhe"
                                                                     0x6162636d: "alwaysBccMyself", // "abcm"
                                                                     0x6163636d: "alwaysCcMyself", // "accm"
                                                                     0x61707665: "applicationVersion", // "apve"
                                                                     0x70617573: "authentication", // "paus"
                                                                     0x62746863: "backgroundActivityCount", // "bthc"
                                                                     0x6d636f6c: "backgroundColor", // "mcol"
                                                                     0x626d7773: "bigMessageWarningSize", // "bmws"
                                                                     0x70626e64: "bounds", // "pbnd"
                                                                     0x63687370: "checkSpellingWhileTyping", // "chsp"
                                                                     0x63737763: "chooseSignatureWhenComposing", // "cswc"
                                                                     0x70636c73: "class_", // "pcls"
                                                                     0x68636c62: "closeable", // "hclb"
                                                                     0x6c77636c: "collating", // "lwcl"
                                                                     0x636f6c72: "color", // "colr"
                                                                     0x72636d65: "colorMessage", // "rcme"
                                                                     0x6d636374: "colorQuotedText", // "mcct"
                                                                     0x6377636d: "compactMailboxesWhenClosing", // "cwcm"
                                                                     0x6d627863: "container", // "mbxc"
                                                                     0x63746e74: "content", // "ctnt"
                                                                     0x6c776370: "copies", // "lwcp"
                                                                     0x72636d62: "copyMessage", // "rcmb"
                                                                     0x72647263: "dateReceived", // "rdrc"
                                                                     0x64726376: "dateSent", // "drcv"
                                                                     0x64656d66: "defaultMessageFormat", // "demf"
                                                                     0x646d6469: "delayedMessageDeletionInterval", // "dmdi"
                                                                     0x6973646c: "deletedStatus", // "isdl"
                                                                     0x646d6f73: "deleteMailOnServer", // "dmos"
                                                                     0x72646d65: "deleteMessage", // "rdme"
                                                                     0x646d776d: "deleteMessagesWhenMovedFromInbox", // "dmwm"
                                                                     0x64616374: "deliveryAccount", // "dact"
                                                                     0x646f6375: "document", // "docu"
                                                                     0x6174646e: "downloaded", // "atdn"
                                                                     0x64687461: "downloadHtmlAttachments", // "dhta"
                                                                     0x64726d62: "draftsMailbox", // "drmb"
                                                                     0x656d6164: "emailAddresses", // "emad"
                                                                     0x656a6d66: "emptyJunkMessagesFrequency", // "ejmf"
                                                                     0x656a6d6f: "emptyJunkMessagesOnQuit", // "ejmo"
                                                                     0x65736d66: "emptySentMessagesFrequency", // "esmf"
                                                                     0x65736d6f: "emptySentMessagesOnQuit", // "esmo"
                                                                     0x65747266: "emptyTrashFrequency", // "etrf"
                                                                     0x65746f71: "emptyTrashOnQuit", // "etoq"
                                                                     0x69736163: "enabled", // "isac"
                                                                     0x6c776c70: "endingPage", // "lwlp"
                                                                     0x6c776568: "errorHandling", // "lweh"
                                                                     0x65786761: "expandGroupAddresses", // "exga"
                                                                     0x72657870: "expression", // "rexp"
                                                                     0x6661786e: "faxNumber", // "faxn"
                                                                     0x73616674: "fetchesAutomatically", // "saft"
                                                                     0x61666671: "fetchInterval", // "affq"
                                                                     0x66696c65: "file", // "file"
                                                                     0x6174666e: "fileName", // "atfn"
                                                                     0x6174737a: "fileSize", // "atsz"
                                                                     0x6d707466: "fixedWidthFont", // "mptf"
                                                                     0x70746673: "fixedWidthFontSize", // "ptfs"
                                                                     0x6973666c: "flaggedStatus", // "isfl"
                                                                     0x66696478: "flagIndex", // "fidx"
                                                                     0x666f6e74: "font", // "font"
                                                                     0x72666164: "forwardMessage", // "rfad"
                                                                     0x72667465: "forwardText", // "rfte"
                                                                     0x66727665: "frameworkVersion", // "frve"
                                                                     0x70697366: "frontmost", // "pisf"
                                                                     0x666c6c6e: "fullName", // "flln"
                                                                     0x72686564: "header", // "rhed"
                                                                     0x6865646c: "headerDetail", // "hedl"
                                                                     0x73686874: "highlightSelectedConversation", // "shht"
                                                                     0x68747563: "highlightTextUsingColor", // "htuc"
                                                                     0x6c647361: "hostName", // "ldsa"
                                                                     0x6c616f68: "hostsToLogActivityOn", // "laoh"
                                                                     0x68746461: "htmlContent", // "htda"
                                                                     0x49442020: "id", // "ID\0x20\0x20"
                                                                     0x696e6d62: "inbox", // "inmb"
                                                                     0x69616f6f: "includeAllOriginalMessageText", // "iaoo"
                                                                     0x6977676d: "includeWhenGettingNewMail", // "iwgm"
                                                                     0x70696478: "index", // "pidx"
                                                                     0x6a6b6d62: "junkMailbox", // "jkmb"
                                                                     0x69736a6b: "junkMailStatus", // "isjk"
                                                                     0x6c6f7163: "levelOneQuotingColor", // "loqc"
                                                                     0x6c687163: "levelThreeQuotingColor", // "lhqc"
                                                                     0x6c777163: "levelTwoQuotingColor", // "lwqc"
                                                                     0x6c616173: "logAllSocketActivity", // "laas"
                                                                     0x6d627870: "mailbox", // "mbxp"
                                                                     0x6d6c7368: "mailboxListVisible", // "mlsh"
                                                                     0x726d666c: "markFlagged", // "rmfl"
                                                                     0x7266636c: "markFlagIndex", // "rfcl"
                                                                     0x726d7265: "markRead", // "rmre"
                                                                     0x6d656d73: "memoryStatistics", // "mems"
                                                                     0x6d736763: "messageCaching", // "msgc"
                                                                     0x6d6d666e: "messageFont", // "mmfn"
                                                                     0x6d6d6673: "messageFontSize", // "mmfs"
                                                                     0x6d656964: "messageId", // "meid"
                                                                     0x6d6d6c66: "messageListFont", // "mmlf"
                                                                     0x6d6c6673: "messageListFontSize", // "mlfs"
                                                                     0x746e7267: "messageSignature", // "tnrg"
                                                                     0x6d737a65: "messageSize", // "msze"
                                                                     0x61747470: "MIMEType", // "attp"
                                                                     0x69736d6e: "miniaturizable", // "ismn"
                                                                     0x706d6e64: "miniaturized", // "pmnd"
                                                                     0x696d6f64: "modified", // "imod"
                                                                     0x736d646d: "moveDeletedMessagesToTrash", // "smdm"
                                                                     0x72746d65: "moveMessage", // "rtme"
                                                                     0x706e616d: "name", // "pnam"
                                                                     0x6d6e6d73: "newMailSound", // "mnms"
                                                                     0x62636b65: "OLDComposeMessage", // "bcke"
                                                                     0x6f756d62: "outbox", // "oumb"
                                                                     0x6c776c61: "pagesAcross", // "lwla"
                                                                     0x6c776c64: "pagesDown", // "lwld"
                                                                     0x6d616370: "password", // "macp"
                                                                     0x7270736f: "playSound", // "rpso"
                                                                     0x706f7274: "port", // "port"
                                                                     0x6c616f70: "portsToLogActivityOn", // "laop"
                                                                     0x6d767076: "previewPaneIsVisible", // "mvpv"
                                                                     0x75656d6c: "primaryEmail", // "ueml"
                                                                     0x70414c4c: "properties", // "pALL"
                                                                     0x72717561: "qualifier", // "rqua"
                                                                     0x696e6f6d: "quoteOriginalMessage", // "inom"
                                                                     0x69737264: "readStatus", // "isrd"
                                                                     0x72726164: "redirectMessage", // "rrad"
                                                                     0x72727465: "replyText", // "rrte"
                                                                     0x7270746f: "replyTo", // "rpto"
                                                                     0x6c777174: "requestedPrintTime", // "lwqt"
                                                                     0x7072737a: "resizable", // "prsz"
                                                                     0x72747970: "ruleType", // "rtyp"
                                                                     0x72726173: "runScript", // "rras"
                                                                     0x72697366: "sameReplyFormat", // "risf"
                                                                     0x6c647363: "scope", // "ldsc"
                                                                     0x6c647362: "searchBase", // "ldsb"
                                                                     0x6d736278: "selectedMailboxes", // "msbx"
                                                                     0x736d6773: "selectedMessages", // "smgs"
                                                                     0x73657369: "selectedSignature", // "sesi"
                                                                     0x736c6374: "selection", // "slct"
                                                                     0x736e6472: "sender", // "sndr"
                                                                     0x73746d62: "sentMailbox", // "stmb"
                                                                     0x686f7374: "serverName", // "host"
                                                                     0x7273636d: "shouldCopyMessage", // "rscm"
                                                                     0x7273746d: "shouldMoveMessage", // "rstm"
                                                                     0x706f6d73: "shouldPlayOtherMailSounds", // "poms"
                                                                     0x7074737a: "size", // "ptsz"
                                                                     0x6d767363: "sortColumn", // "mvsc"
                                                                     0x6d767372: "sortedAscending", // "mvsr"
                                                                     0x7261736f: "source", // "raso"
                                                                     0x6c776670: "startingPage", // "lwfp"
                                                                     0x72736572: "stopEvaluatingRules", // "rser"
                                                                     0x73746f73: "storeDeletedMessagesOnServer", // "stos"
                                                                     0x73646f73: "storeDraftsOnServer", // "sdos"
                                                                     0x736a6f73: "storeJunkMailOnServer", // "sjos"
                                                                     0x73736f73: "storeSentMessagesOnServer", // "ssos"
                                                                     0x7375626a: "subject", // "subj"
                                                                     0x74727072: "targetPrinter", // "trpr"
                                                                     0x74726d62: "trashMailbox", // "trmb"
                                                                     0x6d627563: "unreadCount", // "mbuc"
                                                                     0x75736c61: "useAddressCompletion", // "usla"
                                                                     0x75667766: "useFixedWidthFont", // "ufwf"
                                                                     0x75736b65: "useKeychain", // "uske"
                                                                     0x756e6d65: "userName", // "unme"
                                                                     0x75737373: "usesSsl", // "usss"
                                                                     0x68747663: "vcardPath", // "htvc"
                                                                     0x76657273: "version", // "vers"
                                                                     0x70766973: "visible", // "pvis"
                                                                     0x6d767663: "visibleColumns", // "mvvc"
                                                                     0x6d76666d: "visibleMessages", // "mvfm"
                                                                     0x69736677: "wasForwarded", // "isfw"
                                                                     0x69737263: "wasRedirected", // "isrc"
                                                                     0x69737270: "wasRepliedTo", // "isrp"
                                                                     0x69737a6d: "zoomable", // "iszm"
                                                                     0x707a756d: "zoomed", // "pzum"
                                                     ],
                                                     elementsNames: [
                                                                     0x6d616374: ("account", "accounts"), // "mact"
                                                                     0x63617070: ("application", "applications"), // "capp"
                                                                     0x61747473: ("attachment", "attachments"), // "atts"
                                                                     0x63617472: ("attribute run", "attributeRuns"), // "catr"
                                                                     0x62726370: ("bcc recipient", "bccRecipients"), // "brcp"
                                                                     0x63726370: ("cc recipient", "ccRecipients"), // "crcp"
                                                                     0x63686120: ("character", "characters"), // "cha\0x20"
                                                                     0x6d627863: ("container", "containers"), // "mbxc"
                                                                     0x646f6375: ("document", "documents"), // "docu"
                                                                     0x6d686472: ("header", "headers"), // "mhdr"
                                                                     0x69746163: ("iCloud account", "iCloudAccounts"), // "itac"
                                                                     0x69616374: ("imap account", "imapAccounts"), // "iact"
                                                                     0x636f626a: ("item", "items"), // "cobj"
                                                                     0x6c647365: ("ldap server", "ldapServers"), // "ldse"
                                                                     0x61747463: ("mail attachment", "mailAttachments"), // "attc"
                                                                     0x6d627870: ("mailbox", "mailboxes"), // "mbxp"
                                                                     0x6d737367: ("message", "messages"), // "mssg"
                                                                     0x6d767772: ("message viewer", "messageViewers"), // "mvwr"
                                                                     0x6d656474: ("OLD message editor", "OLDMessageEditors"), // "medt"
                                                                     0x62636b65: ("outgoing message", "outgoingMessages"), // "bcke"
                                                                     0x63706172: ("paragraph", "paragraphs"), // "cpar"
                                                                     0x70616374: ("pop account", "popAccounts"), // "pact"
                                                                     0x72637074: ("recipient", "recipients"), // "rcpt"
                                                                     0x63747874: ("rich text", "richText"), // "ctxt"
                                                                     0x72756372: ("rule condition", "ruleConditions"), // "rucr"
                                                                     0x72756c65: ("rule", "rules"), // "rule"
                                                                     0x73697475: ("signature", "signatures"), // "situ"
                                                                     0x64616374: ("smtp server", "smtpServers"), // "dact"
                                                                     0x74726370: ("to recipient", "toRecipients"), // "trcp"
                                                                     0x6377696e: ("window", "windows"), // "cwin"
                                                                     0x63776f72: ("word", "words"), // "cwor"
                                                     ])

private let _glueClasses = SwiftAutomation.GlueClasses(insertionSpecifierType: MAIInsertion.self,
                                       objectSpecifierType: MAIItem.self,
                                       multiObjectSpecifierType: MAIItems.self,
                                       rootSpecifierType: MAIRoot.self,
                                       applicationType: Mail.self,
                                       symbolType: MAISymbol.self,
                                       formatter: _specifierFormatter)

private let _untargetedAppData = SwiftAutomation.AppData(glueClasses: _glueClasses)


/******************************************************************************/
// Symbol subclass defines static type/enum/property constants based on Mail.app terminology

public class MAISymbol: SwiftAutomation.Symbol {

    override public var typeAliasName: String {return "MAI"}

    public override class func symbol(code: OSType, type: OSType = typeType, descriptor: NSAppleEventDescriptor? = nil) -> MAISymbol {
        switch (code) {
        case 0x74616363: return self.account // "tacc"
        case 0x6d616374: return self.account // "mact"
        case 0x70617468: return self.accountDirectory // "path"
        case 0x61747970: return self.accountType // "atyp"
        case 0x72616464: return self.address // "radd"
        case 0x616c6973: return self.alias // "alis"
        case 0x6864616c: return self.all_ // "hdal"
        case 0x7261636d: return self.allConditionsMustBeMet // "racm"
        case 0x616c6865: return self.allHeaders // "alhe"
        case 0x7839616c: return self.allMessagesAndTheirAttachments // "x9al"
        case 0x7839626f: return self.allMessagesButOmitAttachments // "x9bo"
        case 0x6162636d: return self.alwaysBccMyself // "abcm"
        case 0x6163636d: return self.alwaysCcMyself // "accm"
        case 0x74616e72: return self.anyRecipient // "tanr"
        case 0x2a2a2a2a: return self.anything // "****"
        case 0x6161706f: return self.apop // "aapo"
        case 0x61746f6b: return self.AppleToken // "atok"
        case 0x63617070: return self.application // "capp"
        case 0x62756e64: return self.applicationBundleID // "bund"
        case 0x7369676e: return self.applicationSignature // "sign"
        case 0x6170726c: return self.applicationURL // "aprl"
        case 0x61707665: return self.applicationVersion // "apve"
        case 0x61707220: return self.April // "apr\0x20"
        case 0x61736b20: return self.ask // "ask\0x20"
        case 0x61747473: return self.attachment // "atts"
        case 0x65636174: return self.attachmentsColumn // "ecat"
        case 0x74617474: return self.attachmentType // "tatt"
        case 0x63617472: return self.attributeRun // "catr"
        case 0x61756720: return self.August // "aug\0x20"
        case 0x70617573: return self.authentication // "paus"
        case 0x62746863: return self.backgroundActivityCount // "bthc"
        case 0x6d636f6c: return self.backgroundColor // "mcol"
        case 0x6c736261: return self.base // "lsba"
        case 0x62726370: return self.bccRecipient // "brcp"
        case 0x72716277: return self.beginsWithValue // "rqbw"
        case 0x62657374: return self.best // "best"
        case 0x626d7773: return self.bigMessageWarningSize // "bmws"
        case 0x6363626c: return self.blue // "ccbl"
        case 0x626d726b: return self.bookmarkData // "bmrk"
        case 0x626f6f6c: return self.boolean // "bool"
        case 0x71647274: return self.boundingRectangle // "qdrt"
        case 0x70626e64: return self.bounds // "pbnd"
        case 0x63617365: return self.case_ // "case"
        case 0x74636363: return self.ccHeader // "tccc"
        case 0x63726370: return self.ccRecipient // "crcp"
        case 0x63686120: return self.character // "cha\0x20"
        case 0x63687370: return self.checkSpellingWhileTyping // "chsp"
        case 0x63737763: return self.chooseSignatureWhenComposing // "cswc"
        case 0x70636c73: return self.class_ // "pcls"
        case 0x68636c62: return self.closeable // "hclb"
        case 0x6c77636c: return self.collating // "lwcl"
        case 0x636f6c72: return self.color // "colr"
        case 0x72636d65: return self.colorMessage // "rcme"
        case 0x6d636374: return self.colorQuotedText // "mcct"
        case 0x636c7274: return self.colorTable // "clrt"
        case 0x6377636d: return self.compactMailboxesWhenClosing // "cwcm"
        case 0x656e756d: return self.constant // "enum"
        case 0x6d627863: return self.container // "mbxc"
        case 0x63746e74: return self.content // "ctnt"
        case 0x6c776370: return self.copies // "lwcp"
        case 0x72636d62: return self.copyMessage // "rcmb"
        case 0x68646375: return self.custom // "hdcu"
        case 0x74646173: return self.dashStyle // "tdas"
        case 0x74647461: return self.data // "tdta"
        case 0x6c647420: return self.date // "ldt\0x20"
        case 0x65636c73: return self.dateLastSavedColumn // "ecls"
        case 0x72647263: return self.dateReceived // "rdrc"
        case 0x65636472: return self.dateReceivedColumn // "ecdr"
        case 0x64726376: return self.dateSent // "drcv"
        case 0x65636473: return self.dateSentColumn // "ecds"
        case 0x64656320: return self.December // "dec\0x20"
        case 0x6465636d: return self.decimalStruct // "decm"
        case 0x68646465: return self.default_ // "hdde"
        case 0x64656d66: return self.defaultMessageFormat // "demf"
        case 0x646d6469: return self.delayedMessageDeletionInterval // "dmdi"
        case 0x6973646c: return self.deletedStatus // "isdl"
        case 0x646d6f73: return self.deleteMailOnServer // "dmos"
        case 0x72646d65: return self.deleteMessage // "rdme"
        case 0x646d776d: return self.deleteMessagesWhenMovedFromInbox // "dmwm"
        case 0x6c776474: return self.detailed // "lwdt"
        case 0x64696163: return self.diacriticals // "diac"
        case 0x646f6375: return self.document // "docu"
        case 0x7271636f: return self.doesContainValue // "rqco"
        case 0x7271646e: return self.doesNotContainValue // "rqdn"
        case 0x78396e6f: return self.doNotKeepCopiesOfAnyMessages // "x9no"
        case 0x636f6d70: return self.doubleInteger // "comp"
        case 0x6174646e: return self.downloaded // "atdn"
        case 0x64687461: return self.downloadHtmlAttachments // "dhta"
        case 0x64726d62: return self.draftsMailbox // "drmb"
        case 0x656d6164: return self.emailAddresses // "emad"
        case 0x656a6d66: return self.emptyJunkMessagesFrequency // "ejmf"
        case 0x656a6d6f: return self.emptyJunkMessagesOnQuit // "ejmo"
        case 0x65736d66: return self.emptySentMessagesFrequency // "esmf"
        case 0x65736d6f: return self.emptySentMessagesOnQuit // "esmo"
        case 0x65747266: return self.emptyTrashFrequency // "etrf"
        case 0x65746f71: return self.emptyTrashOnQuit // "etoq"
        case 0x69736163: return self.enabled // "isac"
        case 0x656e6373: return self.encodedString // "encs"
        case 0x6c776c70: return self.endingPage // "lwlp"
        case 0x72716577: return self.endsWithValue // "rqew"
        case 0x45505320: return self.EPSPicture // "EPS\0x20"
        case 0x72716965: return self.equalToValue // "rqie"
        case 0x6c776568: return self.errorHandling // "lweh"
        case 0x65786761: return self.expandGroupAddresses // "exga"
        case 0x65787061: return self.expansion // "expa"
        case 0x72657870: return self.expression // "rexp"
        case 0x65787465: return self.extendedReal // "exte"
        case 0x61657874: return self.external // "aext"
        case 0x6661786e: return self.faxNumber // "faxn"
        case 0x66656220: return self.February // "feb\0x20"
        case 0x73616674: return self.fetchesAutomatically // "saft"
        case 0x61666671: return self.fetchInterval // "affq"
        case 0x66696c65: return self.file // "file"
        case 0x6174666e: return self.fileName // "atfn"
        case 0x66737266: return self.fileRef // "fsrf"
        case 0x6174737a: return self.fileSize // "atsz"
        case 0x66737320: return self.fileSpecification // "fss\0x20"
        case 0x6675726c: return self.fileURL // "furl"
        case 0x66697864: return self.fixed // "fixd"
        case 0x66706e74: return self.fixedPoint // "fpnt"
        case 0x66726374: return self.fixedRectangle // "frct"
        case 0x6d707466: return self.fixedWidthFont // "mptf"
        case 0x70746673: return self.fixedWidthFontSize // "ptfs"
        case 0x6973666c: return self.flaggedStatus // "isfl"
        case 0x66696478: return self.flagIndex // "fidx"
        case 0x6563666c: return self.flagsColumn // "ecfl"
        case 0x666f6e74: return self.font // "font"
        case 0x72666164: return self.forwardMessage // "rfad"
        case 0x72667465: return self.forwardText // "rfte"
        case 0x66727665: return self.frameworkVersion // "frve"
        case 0x66726920: return self.Friday // "fri\0x20"
        case 0x65636672: return self.fromColumn // "ecfr"
        case 0x7466726f: return self.fromHeader // "tfro"
        case 0x70697366: return self.frontmost // "pisf"
        case 0x666c6c6e: return self.fullName // "flln"
        case 0x47494666: return self.GIFPicture // "GIFf"
        case 0x63677478: return self.graphicText // "cgtx"
        case 0x63636779: return self.gray // "ccgy"
        case 0x72716774: return self.greaterThanValue // "rqgt"
        case 0x63636772: return self.green // "ccgr"
        case 0x6d686472: return self.header // "mhdr"
        case 0x72686564: return self.header // "rhed"
        case 0x6865646c: return self.headerDetail // "hedl"
        case 0x7468646b: return self.headerKey // "thdk"
        case 0x73686874: return self.highlightSelectedConversation // "shht"
        case 0x68747563: return self.highlightTextUsingColor // "htuc"
        case 0x6c647361: return self.hostName // "ldsa"
        case 0x6c616f68: return self.hostsToLogActivityOn // "laoh"
        case 0x68746461: return self.htmlContent // "htda"
        case 0x68797068: return self.hyphens // "hyph"
        case 0x65746974: return self.iCloud // "etit"
        case 0x69746163: return self.iCloudAccount // "itac"
        case 0x49442020: return self.id // "ID\0x20\0x20"
        case 0x6574696d: return self.imap // "etim"
        case 0x69616374: return self.imapAccount // "iact"
        case 0x696e6d62: return self.inbox // "inmb"
        case 0x69616f6f: return self.includeAllOriginalMessageText // "iaoo"
        case 0x6977676d: return self.includeWhenGettingNewMail // "iwgm"
        case 0x70696478: return self.index // "pidx"
        case 0x6c6f6e67: return self.integer // "long"
        case 0x69747874: return self.internationalText // "itxt"
        case 0x696e746c: return self.internationalWritingCode // "intl"
        case 0x636f626a: return self.item // "cobj"
        case 0x6a616e20: return self.January // "jan\0x20"
        case 0x4a504547: return self.JPEGPicture // "JPEG"
        case 0x6a756c20: return self.July // "jul\0x20"
        case 0x6a756e20: return self.June // "jun\0x20"
        case 0x6a6b6d62: return self.junkMailbox // "jkmb"
        case 0x69736a6b: return self.junkMailStatus // "isjk"
        case 0x61786b35: return self.kerberos5 // "axk5"
        case 0x6b706964: return self.kernelProcessID // "kpid"
        case 0x6c64626c: return self.largeReal // "ldbl"
        case 0x6c647365: return self.ldapServer // "ldse"
        case 0x72716c74: return self.lessThanValue // "rqlt"
        case 0x6c6f7163: return self.levelOneQuotingColor // "loqc"
        case 0x6c687163: return self.levelThreeQuotingColor // "lhqc"
        case 0x6c777163: return self.levelTwoQuotingColor // "lwqc"
        case 0x6c697374: return self.list // "list"
        case 0x696e736c: return self.locationReference // "insl"
        case 0x6c616173: return self.logAllSocketActivity // "laas"
        case 0x6c667864: return self.longFixed // "lfxd"
        case 0x6c667074: return self.longFixedPoint // "lfpt"
        case 0x6c667263: return self.longFixedRectangle // "lfrc"
        case 0x6c706e74: return self.longPoint // "lpnt"
        case 0x6c726374: return self.longRectangle // "lrct"
        case 0x6d616368: return self.machine // "mach"
        case 0x6d4c6f63: return self.machineLocation // "mLoc"
        case 0x61747463: return self.mailAttachment // "attc"
        case 0x6d627870: return self.mailbox // "mbxp"
        case 0x65636d62: return self.mailboxColumn // "ecmb"
        case 0x6d6c7368: return self.mailboxListVisible // "mlsh"
        case 0x6d617220: return self.March // "mar\0x20"
        case 0x726d666c: return self.markFlagged // "rmfl"
        case 0x7266636c: return self.markFlagIndex // "rfcl"
        case 0x726d7265: return self.markRead // "rmre"
        case 0x7465766d: return self.matchesEveryMessage // "tevm"
        case 0x6d617920: return self.May // "may\0x20"
        case 0x61786d64: return self.md5 // "axmd"
        case 0x6d656d73: return self.memoryStatistics // "mems"
        case 0x6d737367: return self.message // "mssg"
        case 0x6d736763: return self.messageCaching // "msgc"
        case 0x6563636c: return self.messageColor // "eccl"
        case 0x746d6563: return self.messageContent // "tmec"
        case 0x6d6d666e: return self.messageFont // "mmfn"
        case 0x6d6d6673: return self.messageFontSize // "mmfs"
        case 0x6d656964: return self.messageId // "meid"
        case 0x746d696a: return self.messageIsJunkMail // "tmij"
        case 0x6d6d6c66: return self.messageListFont // "mmlf"
        case 0x6d6c6673: return self.messageListFontSize // "mlfs"
        case 0x746e7267: return self.messageSignature // "tnrg"
        case 0x6d737a65: return self.messageSize // "msze"
        case 0x65636d73: return self.messageStatusColumn // "ecms"
        case 0x6d767772: return self.messageViewer // "mvwr"
        case 0x61747470: return self.MIMEType // "attp"
        case 0x69736d6e: return self.miniaturizable // "ismn"
        case 0x706d6e64: return self.miniaturized // "pmnd"
        case 0x696d6f64: return self.modified // "imod"
        case 0x6d6f6e20: return self.Monday // "mon\0x20"
        case 0x736d646d: return self.moveDeletedMessagesToTrash // "smdm"
        case 0x72746d65: return self.moveMessage // "rtme"
        case 0x706e616d: return self.name // "pnam"
        case 0x6974656d: return self.nativeFormat // "item"
        case 0x6d6e6d73: return self.newMailSound // "mnms"
        case 0x6e6f2020: return self.no // "no\0x20\0x20"
        case 0x68646e6e: return self.noHeaders // "hdnn"
        case 0x72716e6f: return self.none // "rqno"
        case 0x63636e6f: return self.none // "ccno"
        case 0x6e6f7620: return self.November // "nov\0x20"
        case 0x61786e74: return self.ntlm // "axnt"
        case 0x6e756c6c: return self.null // "null"
        case 0x65636e6d: return self.numberColumn // "ecnm"
        case 0x6e756d65: return self.numericStrings // "nume"
        case 0x6f637420: return self.October // "oct\0x20"
        case 0x6d656474: return self.OLDMessageEditor // "medt"
        case 0x6c736f6c: return self.oneLevel // "lsol"
        case 0x78397772: return self.onlyMessagesIHaveRead // "x9wr"
        case 0x63636f72: return self.orange // "ccor"
        case 0x63636f74: return self.other // "ccot"
        case 0x6f756d62: return self.outbox // "oumb"
        case 0x62636b65: return self.outgoingMessage // "bcke"
        case 0x6c776c61: return self.pagesAcross // "lwla"
        case 0x6c776c64: return self.pagesDown // "lwld"
        case 0x63706172: return self.paragraph // "cpar"
        case 0x6d616370: return self.password // "macp"
        case 0x61786374: return self.password // "axct"
        case 0x50494354: return self.PICTPicture // "PICT"
        case 0x74706d6d: return self.pixelMapRecord // "tpmm"
        case 0x646d7074: return self.plainFormat // "dmpt"
        case 0x7270736f: return self.playSound // "rpso"
        case 0x51447074: return self.point // "QDpt"
        case 0x6574706f: return self.pop // "etpo"
        case 0x70616374: return self.popAccount // "pact"
        case 0x706f7274: return self.port // "port"
        case 0x6c616f70: return self.portsToLogActivityOn // "laop"
        case 0x6d767076: return self.previewPaneIsVisible // "mvpv"
        case 0x75656d6c: return self.primaryEmail // "ueml"
        case 0x70736574: return self.printSettings // "pset"
        case 0x70736e20: return self.processSerialNumber // "psn\0x20"
        case 0x70414c4c: return self.properties // "pALL"
        case 0x70726f70: return self.property_ // "prop"
        case 0x70756e63: return self.punctuation // "punc"
        case 0x63637075: return self.purple // "ccpu"
        case 0x72717561: return self.qualifier // "rqua"
        case 0x696e6f6d: return self.quoteOriginalMessage // "inom"
        case 0x69737264: return self.readStatus // "isrd"
        case 0x646f7562: return self.real // "doub"
        case 0x72637074: return self.recipient // "rcpt"
        case 0x7265636f: return self.record // "reco"
        case 0x63637265: return self.red // "ccre"
        case 0x72726164: return self.redirectMessage // "rrad"
        case 0x6f626a20: return self.reference // "obj\0x20"
        case 0x72727465: return self.replyText // "rrte"
        case 0x7270746f: return self.replyTo // "rpto"
        case 0x6c777174: return self.requestedPrintTime // "lwqt"
        case 0x7072737a: return self.resizable // "prsz"
        case 0x74723136: return self.RGB16Color // "tr16"
        case 0x74723936: return self.RGB96Color // "tr96"
        case 0x63524742: return self.RGBColor // "cRGB"
        case 0x646d7274: return self.richFormat // "dmrt"
        case 0x63747874: return self.richText // "ctxt"
        case 0x74726f74: return self.rotation // "trot"
        case 0x72756c65: return self.rule // "rule"
        case 0x72756372: return self.ruleCondition // "rucr"
        case 0x72747970: return self.ruleType // "rtyp"
        case 0x72726173: return self.runScript // "rras"
        case 0x72697366: return self.sameReplyFormat // "risf"
        case 0x73617420: return self.Saturday // "sat\0x20"
        case 0x6c647363: return self.scope // "ldsc"
        case 0x73637074: return self.script // "scpt"
        case 0x6c647362: return self.searchBase // "ldsb"
        case 0x6d736278: return self.selectedMailboxes // "msbx"
        case 0x736d6773: return self.selectedMessages // "smgs"
        case 0x73657369: return self.selectedSignature // "sesi"
        case 0x736c6374: return self.selection // "slct"
        case 0x736e6472: return self.sender // "sndr"
        case 0x74736969: return self.senderIsInMyContacts // "tsii"
        case 0x74736168: return self.senderIsInMyPreviousRecipients // "tsah"
        case 0x7473696d: return self.senderIsMemberOfGroup // "tsim"
        case 0x7473696e: return self.senderIsNotInMyContacts // "tsin"
        case 0x746e6168: return self.senderIsNotInMyPreviousRecipients // "tnah"
        case 0x74736967: return self.senderIsVIP // "tsig"
        case 0x73746d62: return self.sentMailbox // "stmb"
        case 0x73657020: return self.September // "sep\0x20"
        case 0x686f7374: return self.serverName // "host"
        case 0x73686f72: return self.shortInteger // "shor"
        case 0x7273636d: return self.shouldCopyMessage // "rscm"
        case 0x7273746d: return self.shouldMoveMessage // "rstm"
        case 0x706f6d73: return self.shouldPlayOtherMailSounds // "poms"
        case 0x73697475: return self.signature // "situ"
        case 0x7074737a: return self.size // "ptsz"
        case 0x6563737a: return self.sizeColumn // "ecsz"
        case 0x73696e67: return self.smallReal // "sing"
        case 0x6574736d: return self.smtp // "etsm"
        case 0x64616374: return self.smtpServer // "dact"
        case 0x6d767363: return self.sortColumn // "mvsc"
        case 0x6d767372: return self.sortedAscending // "mvsr"
        case 0x7261736f: return self.source // "raso"
        case 0x6c777374: return self.standard // "lwst"
        case 0x6c776670: return self.startingPage // "lwfp"
        case 0x72736572: return self.stopEvaluatingRules // "rser"
        case 0x73746f73: return self.storeDeletedMessagesOnServer // "stos"
        case 0x73646f73: return self.storeDraftsOnServer // "sdos"
        case 0x736a6f73: return self.storeJunkMailOnServer // "sjos"
        case 0x73736f73: return self.storeSentMessagesOnServer // "ssos"
        case 0x54455854: return self.string // "TEXT"
        case 0x7374796c: return self.styledClipboardText // "styl"
        case 0x53545854: return self.styledText // "STXT"
        case 0x7375626a: return self.subject // "subj"
        case 0x65637375: return self.subjectColumn // "ecsu"
        case 0x74737562: return self.subjectHeader // "tsub"
        case 0x6c737374: return self.subtree // "lsst"
        case 0x73756e20: return self.Sunday // "sun\0x20"
        case 0x74727072: return self.targetPrinter // "trpr"
        case 0x74737479: return self.textStyleInfo // "tsty"
        case 0x74687520: return self.Thursday // "thu\0x20"
        case 0x54494646: return self.TIFFPicture // "TIFF"
        case 0x6563746f: return self.toColumn // "ecto"
        case 0x74746f6f: return self.toHeader // "ttoo"
        case 0x74746f63: return self.toOrCcHeader // "ttoc"
        case 0x74726370: return self.toRecipient // "trcp"
        case 0x74726d62: return self.trashMailbox // "trmb"
        case 0x74756520: return self.Tuesday // "tue\0x20"
        case 0x74797065: return self.typeClass // "type"
        case 0x75747874: return self.UnicodeText // "utxt"
        case 0x6574756e: return self.unknown // "etun"
        case 0x6d627563: return self.unreadCount // "mbuc"
        case 0x75636f6d: return self.unsignedDoubleInteger // "ucom"
        case 0x6d61676e: return self.unsignedInteger // "magn"
        case 0x75736872: return self.unsignedShortInteger // "ushr"
        case 0x75736c61: return self.useAddressCompletion // "usla"
        case 0x75667766: return self.useFixedWidthFont // "ufwf"
        case 0x75736b65: return self.useKeychain // "uske"
        case 0x756e6d65: return self.userName // "unme"
        case 0x75737373: return self.usesSsl // "usss"
        case 0x75743136: return self.UTF16Text // "ut16"
        case 0x75746638: return self.UTF8Text // "utf8"
        case 0x68747663: return self.vcardPath // "htvc"
        case 0x76657273: return self.version // "vers"
        case 0x70766973: return self.visible // "pvis"
        case 0x6d767663: return self.visibleColumns // "mvvc"
        case 0x6d76666d: return self.visibleMessages // "mvfm"
        case 0x69736677: return self.wasForwarded // "isfw"
        case 0x69737263: return self.wasRedirected // "isrc"
        case 0x69737270: return self.wasRepliedTo // "isrp"
        case 0x77656420: return self.Wednesday // "wed\0x20"
        case 0x77686974: return self.whitespace // "whit"
        case 0x6377696e: return self.window // "cwin"
        case 0x63776f72: return self.word // "cwor"
        case 0x70736374: return self.writingCode // "psct"
        case 0x63637965: return self.yellow // "ccye"
        case 0x79657320: return self.yes // "yes\0x20"
        case 0x69737a6d: return self.zoomable // "iszm"
        case 0x707a756d: return self.zoomed // "pzum"
        default: return super.symbol(code: code, type: type, descriptor: descriptor) as! MAISymbol
        }
    }

    // Types/properties
    public static let account = MAISymbol(name: "account", code: 0x6d616374, type: typeType) // "mact"
    public static let accountDirectory = MAISymbol(name: "accountDirectory", code: 0x70617468, type: typeType) // "path"
    public static let accountType = MAISymbol(name: "accountType", code: 0x61747970, type: typeType) // "atyp"
    public static let address = MAISymbol(name: "address", code: 0x72616464, type: typeType) // "radd"
    public static let alias = MAISymbol(name: "alias", code: 0x616c6973, type: typeType) // "alis"
    public static let allConditionsMustBeMet = MAISymbol(name: "allConditionsMustBeMet", code: 0x7261636d, type: typeType) // "racm"
    public static let allHeaders = MAISymbol(name: "allHeaders", code: 0x616c6865, type: typeType) // "alhe"
    public static let alwaysBccMyself = MAISymbol(name: "alwaysBccMyself", code: 0x6162636d, type: typeType) // "abcm"
    public static let alwaysCcMyself = MAISymbol(name: "alwaysCcMyself", code: 0x6163636d, type: typeType) // "accm"
    public static let anything = MAISymbol(name: "anything", code: 0x2a2a2a2a, type: typeType) // "****"
    public static let application = MAISymbol(name: "application", code: 0x63617070, type: typeType) // "capp"
    public static let applicationBundleID = MAISymbol(name: "applicationBundleID", code: 0x62756e64, type: typeType) // "bund"
    public static let applicationSignature = MAISymbol(name: "applicationSignature", code: 0x7369676e, type: typeType) // "sign"
    public static let applicationURL = MAISymbol(name: "applicationURL", code: 0x6170726c, type: typeType) // "aprl"
    public static let applicationVersion = MAISymbol(name: "applicationVersion", code: 0x61707665, type: typeType) // "apve"
    public static let April = MAISymbol(name: "April", code: 0x61707220, type: typeType) // "apr\0x20"
    public static let attachment = MAISymbol(name: "attachment", code: 0x61747473, type: typeType) // "atts"
    public static let attributeRun = MAISymbol(name: "attributeRun", code: 0x63617472, type: typeType) // "catr"
    public static let August = MAISymbol(name: "August", code: 0x61756720, type: typeType) // "aug\0x20"
    public static let authentication = MAISymbol(name: "authentication", code: 0x70617573, type: typeType) // "paus"
    public static let backgroundActivityCount = MAISymbol(name: "backgroundActivityCount", code: 0x62746863, type: typeType) // "bthc"
    public static let backgroundColor = MAISymbol(name: "backgroundColor", code: 0x6d636f6c, type: typeType) // "mcol"
    public static let bccRecipient = MAISymbol(name: "bccRecipient", code: 0x62726370, type: typeType) // "brcp"
    public static let best = MAISymbol(name: "best", code: 0x62657374, type: typeType) // "best"
    public static let bigMessageWarningSize = MAISymbol(name: "bigMessageWarningSize", code: 0x626d7773, type: typeType) // "bmws"
    public static let bookmarkData = MAISymbol(name: "bookmarkData", code: 0x626d726b, type: typeType) // "bmrk"
    public static let boolean = MAISymbol(name: "boolean", code: 0x626f6f6c, type: typeType) // "bool"
    public static let boundingRectangle = MAISymbol(name: "boundingRectangle", code: 0x71647274, type: typeType) // "qdrt"
    public static let bounds = MAISymbol(name: "bounds", code: 0x70626e64, type: typeType) // "pbnd"
    public static let ccRecipient = MAISymbol(name: "ccRecipient", code: 0x63726370, type: typeType) // "crcp"
    public static let character = MAISymbol(name: "character", code: 0x63686120, type: typeType) // "cha\0x20"
    public static let checkSpellingWhileTyping = MAISymbol(name: "checkSpellingWhileTyping", code: 0x63687370, type: typeType) // "chsp"
    public static let chooseSignatureWhenComposing = MAISymbol(name: "chooseSignatureWhenComposing", code: 0x63737763, type: typeType) // "cswc"
    public static let class_ = MAISymbol(name: "class_", code: 0x70636c73, type: typeType) // "pcls"
    public static let closeable = MAISymbol(name: "closeable", code: 0x68636c62, type: typeType) // "hclb"
    public static let collating = MAISymbol(name: "collating", code: 0x6c77636c, type: typeType) // "lwcl"
    public static let color = MAISymbol(name: "color", code: 0x636f6c72, type: typeType) // "colr"
    public static let colorMessage = MAISymbol(name: "colorMessage", code: 0x72636d65, type: typeType) // "rcme"
    public static let colorQuotedText = MAISymbol(name: "colorQuotedText", code: 0x6d636374, type: typeType) // "mcct"
    public static let colorTable = MAISymbol(name: "colorTable", code: 0x636c7274, type: typeType) // "clrt"
    public static let compactMailboxesWhenClosing = MAISymbol(name: "compactMailboxesWhenClosing", code: 0x6377636d, type: typeType) // "cwcm"
    public static let constant = MAISymbol(name: "constant", code: 0x656e756d, type: typeType) // "enum"
    public static let container = MAISymbol(name: "container", code: 0x6d627863, type: typeType) // "mbxc"
    public static let content = MAISymbol(name: "content", code: 0x63746e74, type: typeType) // "ctnt"
    public static let copies = MAISymbol(name: "copies", code: 0x6c776370, type: typeType) // "lwcp"
    public static let copyMessage = MAISymbol(name: "copyMessage", code: 0x72636d62, type: typeType) // "rcmb"
    public static let dashStyle = MAISymbol(name: "dashStyle", code: 0x74646173, type: typeType) // "tdas"
    public static let data = MAISymbol(name: "data", code: 0x74647461, type: typeType) // "tdta"
    public static let date = MAISymbol(name: "date", code: 0x6c647420, type: typeType) // "ldt\0x20"
    public static let dateReceived = MAISymbol(name: "dateReceived", code: 0x72647263, type: typeType) // "rdrc"
    public static let dateSent = MAISymbol(name: "dateSent", code: 0x64726376, type: typeType) // "drcv"
    public static let December = MAISymbol(name: "December", code: 0x64656320, type: typeType) // "dec\0x20"
    public static let decimalStruct = MAISymbol(name: "decimalStruct", code: 0x6465636d, type: typeType) // "decm"
    public static let defaultMessageFormat = MAISymbol(name: "defaultMessageFormat", code: 0x64656d66, type: typeType) // "demf"
    public static let delayedMessageDeletionInterval = MAISymbol(name: "delayedMessageDeletionInterval", code: 0x646d6469, type: typeType) // "dmdi"
    public static let deletedStatus = MAISymbol(name: "deletedStatus", code: 0x6973646c, type: typeType) // "isdl"
    public static let deleteMailOnServer = MAISymbol(name: "deleteMailOnServer", code: 0x646d6f73, type: typeType) // "dmos"
    public static let deleteMessage = MAISymbol(name: "deleteMessage", code: 0x72646d65, type: typeType) // "rdme"
    public static let deleteMessagesWhenMovedFromInbox = MAISymbol(name: "deleteMessagesWhenMovedFromInbox", code: 0x646d776d, type: typeType) // "dmwm"
    public static let deliveryAccount = MAISymbol(name: "deliveryAccount", code: 0x64616374, type: typeType) // "dact"
    public static let document = MAISymbol(name: "document", code: 0x646f6375, type: typeType) // "docu"
    public static let doubleInteger = MAISymbol(name: "doubleInteger", code: 0x636f6d70, type: typeType) // "comp"
    public static let downloaded = MAISymbol(name: "downloaded", code: 0x6174646e, type: typeType) // "atdn"
    public static let downloadHtmlAttachments = MAISymbol(name: "downloadHtmlAttachments", code: 0x64687461, type: typeType) // "dhta"
    public static let draftsMailbox = MAISymbol(name: "draftsMailbox", code: 0x64726d62, type: typeType) // "drmb"
    public static let emailAddresses = MAISymbol(name: "emailAddresses", code: 0x656d6164, type: typeType) // "emad"
    public static let emptyJunkMessagesFrequency = MAISymbol(name: "emptyJunkMessagesFrequency", code: 0x656a6d66, type: typeType) // "ejmf"
    public static let emptyJunkMessagesOnQuit = MAISymbol(name: "emptyJunkMessagesOnQuit", code: 0x656a6d6f, type: typeType) // "ejmo"
    public static let emptySentMessagesFrequency = MAISymbol(name: "emptySentMessagesFrequency", code: 0x65736d66, type: typeType) // "esmf"
    public static let emptySentMessagesOnQuit = MAISymbol(name: "emptySentMessagesOnQuit", code: 0x65736d6f, type: typeType) // "esmo"
    public static let emptyTrashFrequency = MAISymbol(name: "emptyTrashFrequency", code: 0x65747266, type: typeType) // "etrf"
    public static let emptyTrashOnQuit = MAISymbol(name: "emptyTrashOnQuit", code: 0x65746f71, type: typeType) // "etoq"
    public static let enabled = MAISymbol(name: "enabled", code: 0x69736163, type: typeType) // "isac"
    public static let encodedString = MAISymbol(name: "encodedString", code: 0x656e6373, type: typeType) // "encs"
    public static let endingPage = MAISymbol(name: "endingPage", code: 0x6c776c70, type: typeType) // "lwlp"
    public static let EPSPicture = MAISymbol(name: "EPSPicture", code: 0x45505320, type: typeType) // "EPS\0x20"
    public static let errorHandling = MAISymbol(name: "errorHandling", code: 0x6c776568, type: typeType) // "lweh"
    public static let expandGroupAddresses = MAISymbol(name: "expandGroupAddresses", code: 0x65786761, type: typeType) // "exga"
    public static let expression = MAISymbol(name: "expression", code: 0x72657870, type: typeType) // "rexp"
    public static let extendedReal = MAISymbol(name: "extendedReal", code: 0x65787465, type: typeType) // "exte"
    public static let faxNumber = MAISymbol(name: "faxNumber", code: 0x6661786e, type: typeType) // "faxn"
    public static let February = MAISymbol(name: "February", code: 0x66656220, type: typeType) // "feb\0x20"
    public static let fetchesAutomatically = MAISymbol(name: "fetchesAutomatically", code: 0x73616674, type: typeType) // "saft"
    public static let fetchInterval = MAISymbol(name: "fetchInterval", code: 0x61666671, type: typeType) // "affq"
    public static let file = MAISymbol(name: "file", code: 0x66696c65, type: typeType) // "file"
    public static let fileName = MAISymbol(name: "fileName", code: 0x6174666e, type: typeType) // "atfn"
    public static let fileRef = MAISymbol(name: "fileRef", code: 0x66737266, type: typeType) // "fsrf"
    public static let fileSize = MAISymbol(name: "fileSize", code: 0x6174737a, type: typeType) // "atsz"
    public static let fileSpecification = MAISymbol(name: "fileSpecification", code: 0x66737320, type: typeType) // "fss\0x20"
    public static let fileURL = MAISymbol(name: "fileURL", code: 0x6675726c, type: typeType) // "furl"
    public static let fixed = MAISymbol(name: "fixed", code: 0x66697864, type: typeType) // "fixd"
    public static let fixedPoint = MAISymbol(name: "fixedPoint", code: 0x66706e74, type: typeType) // "fpnt"
    public static let fixedRectangle = MAISymbol(name: "fixedRectangle", code: 0x66726374, type: typeType) // "frct"
    public static let fixedWidthFont = MAISymbol(name: "fixedWidthFont", code: 0x6d707466, type: typeType) // "mptf"
    public static let fixedWidthFontSize = MAISymbol(name: "fixedWidthFontSize", code: 0x70746673, type: typeType) // "ptfs"
    public static let flaggedStatus = MAISymbol(name: "flaggedStatus", code: 0x6973666c, type: typeType) // "isfl"
    public static let flagIndex = MAISymbol(name: "flagIndex", code: 0x66696478, type: typeType) // "fidx"
    public static let font = MAISymbol(name: "font", code: 0x666f6e74, type: typeType) // "font"
    public static let forwardMessage = MAISymbol(name: "forwardMessage", code: 0x72666164, type: typeType) // "rfad"
    public static let forwardText = MAISymbol(name: "forwardText", code: 0x72667465, type: typeType) // "rfte"
    public static let frameworkVersion = MAISymbol(name: "frameworkVersion", code: 0x66727665, type: typeType) // "frve"
    public static let Friday = MAISymbol(name: "Friday", code: 0x66726920, type: typeType) // "fri\0x20"
    public static let frontmost = MAISymbol(name: "frontmost", code: 0x70697366, type: typeType) // "pisf"
    public static let fullName = MAISymbol(name: "fullName", code: 0x666c6c6e, type: typeType) // "flln"
    public static let GIFPicture = MAISymbol(name: "GIFPicture", code: 0x47494666, type: typeType) // "GIFf"
    public static let graphicText = MAISymbol(name: "graphicText", code: 0x63677478, type: typeType) // "cgtx"
    public static let header = MAISymbol(name: "header", code: 0x6d686472, type: typeType) // "mhdr"
    public static let headerDetail = MAISymbol(name: "headerDetail", code: 0x6865646c, type: typeType) // "hedl"
    public static let highlightSelectedConversation = MAISymbol(name: "highlightSelectedConversation", code: 0x73686874, type: typeType) // "shht"
    public static let highlightTextUsingColor = MAISymbol(name: "highlightTextUsingColor", code: 0x68747563, type: typeType) // "htuc"
    public static let hostName = MAISymbol(name: "hostName", code: 0x6c647361, type: typeType) // "ldsa"
    public static let hostsToLogActivityOn = MAISymbol(name: "hostsToLogActivityOn", code: 0x6c616f68, type: typeType) // "laoh"
    public static let htmlContent = MAISymbol(name: "htmlContent", code: 0x68746461, type: typeType) // "htda"
    public static let iCloudAccount = MAISymbol(name: "iCloudAccount", code: 0x69746163, type: typeType) // "itac"
    public static let id = MAISymbol(name: "id", code: 0x49442020, type: typeType) // "ID\0x20\0x20"
    public static let imapAccount = MAISymbol(name: "imapAccount", code: 0x69616374, type: typeType) // "iact"
    public static let inbox = MAISymbol(name: "inbox", code: 0x696e6d62, type: typeType) // "inmb"
    public static let includeAllOriginalMessageText = MAISymbol(name: "includeAllOriginalMessageText", code: 0x69616f6f, type: typeType) // "iaoo"
    public static let includeWhenGettingNewMail = MAISymbol(name: "includeWhenGettingNewMail", code: 0x6977676d, type: typeType) // "iwgm"
    public static let index = MAISymbol(name: "index", code: 0x70696478, type: typeType) // "pidx"
    public static let integer = MAISymbol(name: "integer", code: 0x6c6f6e67, type: typeType) // "long"
    public static let internationalText = MAISymbol(name: "internationalText", code: 0x69747874, type: typeType) // "itxt"
    public static let internationalWritingCode = MAISymbol(name: "internationalWritingCode", code: 0x696e746c, type: typeType) // "intl"
    public static let item = MAISymbol(name: "item", code: 0x636f626a, type: typeType) // "cobj"
    public static let January = MAISymbol(name: "January", code: 0x6a616e20, type: typeType) // "jan\0x20"
    public static let JPEGPicture = MAISymbol(name: "JPEGPicture", code: 0x4a504547, type: typeType) // "JPEG"
    public static let July = MAISymbol(name: "July", code: 0x6a756c20, type: typeType) // "jul\0x20"
    public static let June = MAISymbol(name: "June", code: 0x6a756e20, type: typeType) // "jun\0x20"
    public static let junkMailbox = MAISymbol(name: "junkMailbox", code: 0x6a6b6d62, type: typeType) // "jkmb"
    public static let junkMailStatus = MAISymbol(name: "junkMailStatus", code: 0x69736a6b, type: typeType) // "isjk"
    public static let kernelProcessID = MAISymbol(name: "kernelProcessID", code: 0x6b706964, type: typeType) // "kpid"
    public static let largeReal = MAISymbol(name: "largeReal", code: 0x6c64626c, type: typeType) // "ldbl"
    public static let ldapServer = MAISymbol(name: "ldapServer", code: 0x6c647365, type: typeType) // "ldse"
    public static let levelOneQuotingColor = MAISymbol(name: "levelOneQuotingColor", code: 0x6c6f7163, type: typeType) // "loqc"
    public static let levelThreeQuotingColor = MAISymbol(name: "levelThreeQuotingColor", code: 0x6c687163, type: typeType) // "lhqc"
    public static let levelTwoQuotingColor = MAISymbol(name: "levelTwoQuotingColor", code: 0x6c777163, type: typeType) // "lwqc"
    public static let list = MAISymbol(name: "list", code: 0x6c697374, type: typeType) // "list"
    public static let locationReference = MAISymbol(name: "locationReference", code: 0x696e736c, type: typeType) // "insl"
    public static let logAllSocketActivity = MAISymbol(name: "logAllSocketActivity", code: 0x6c616173, type: typeType) // "laas"
    public static let longFixed = MAISymbol(name: "longFixed", code: 0x6c667864, type: typeType) // "lfxd"
    public static let longFixedPoint = MAISymbol(name: "longFixedPoint", code: 0x6c667074, type: typeType) // "lfpt"
    public static let longFixedRectangle = MAISymbol(name: "longFixedRectangle", code: 0x6c667263, type: typeType) // "lfrc"
    public static let longPoint = MAISymbol(name: "longPoint", code: 0x6c706e74, type: typeType) // "lpnt"
    public static let longRectangle = MAISymbol(name: "longRectangle", code: 0x6c726374, type: typeType) // "lrct"
    public static let machine = MAISymbol(name: "machine", code: 0x6d616368, type: typeType) // "mach"
    public static let machineLocation = MAISymbol(name: "machineLocation", code: 0x6d4c6f63, type: typeType) // "mLoc"
    public static let machPort = MAISymbol(name: "machPort", code: 0x706f7274, type: typeType) // "port"
    public static let mailAttachment = MAISymbol(name: "mailAttachment", code: 0x61747463, type: typeType) // "attc"
    public static let mailbox = MAISymbol(name: "mailbox", code: 0x6d627870, type: typeType) // "mbxp"
    public static let mailboxListVisible = MAISymbol(name: "mailboxListVisible", code: 0x6d6c7368, type: typeType) // "mlsh"
    public static let March = MAISymbol(name: "March", code: 0x6d617220, type: typeType) // "mar\0x20"
    public static let markFlagged = MAISymbol(name: "markFlagged", code: 0x726d666c, type: typeType) // "rmfl"
    public static let markFlagIndex = MAISymbol(name: "markFlagIndex", code: 0x7266636c, type: typeType) // "rfcl"
    public static let markRead = MAISymbol(name: "markRead", code: 0x726d7265, type: typeType) // "rmre"
    public static let May = MAISymbol(name: "May", code: 0x6d617920, type: typeType) // "may\0x20"
    public static let memoryStatistics = MAISymbol(name: "memoryStatistics", code: 0x6d656d73, type: typeType) // "mems"
    public static let message = MAISymbol(name: "message", code: 0x6d737367, type: typeType) // "mssg"
    public static let messageCaching = MAISymbol(name: "messageCaching", code: 0x6d736763, type: typeType) // "msgc"
    public static let messageFont = MAISymbol(name: "messageFont", code: 0x6d6d666e, type: typeType) // "mmfn"
    public static let messageFontSize = MAISymbol(name: "messageFontSize", code: 0x6d6d6673, type: typeType) // "mmfs"
    public static let messageId = MAISymbol(name: "messageId", code: 0x6d656964, type: typeType) // "meid"
    public static let messageListFont = MAISymbol(name: "messageListFont", code: 0x6d6d6c66, type: typeType) // "mmlf"
    public static let messageListFontSize = MAISymbol(name: "messageListFontSize", code: 0x6d6c6673, type: typeType) // "mlfs"
    public static let messageSignature = MAISymbol(name: "messageSignature", code: 0x746e7267, type: typeType) // "tnrg"
    public static let messageSize = MAISymbol(name: "messageSize", code: 0x6d737a65, type: typeType) // "msze"
    public static let messageViewer = MAISymbol(name: "messageViewer", code: 0x6d767772, type: typeType) // "mvwr"
    public static let MIMEType = MAISymbol(name: "MIMEType", code: 0x61747470, type: typeType) // "attp"
    public static let miniaturizable = MAISymbol(name: "miniaturizable", code: 0x69736d6e, type: typeType) // "ismn"
    public static let miniaturized = MAISymbol(name: "miniaturized", code: 0x706d6e64, type: typeType) // "pmnd"
    public static let modified = MAISymbol(name: "modified", code: 0x696d6f64, type: typeType) // "imod"
    public static let Monday = MAISymbol(name: "Monday", code: 0x6d6f6e20, type: typeType) // "mon\0x20"
    public static let moveDeletedMessagesToTrash = MAISymbol(name: "moveDeletedMessagesToTrash", code: 0x736d646d, type: typeType) // "smdm"
    public static let moveMessage = MAISymbol(name: "moveMessage", code: 0x72746d65, type: typeType) // "rtme"
    public static let name = MAISymbol(name: "name", code: 0x706e616d, type: typeType) // "pnam"
    public static let newMailSound = MAISymbol(name: "newMailSound", code: 0x6d6e6d73, type: typeType) // "mnms"
    public static let November = MAISymbol(name: "November", code: 0x6e6f7620, type: typeType) // "nov\0x20"
    public static let null = MAISymbol(name: "null", code: 0x6e756c6c, type: typeType) // "null"
    public static let October = MAISymbol(name: "October", code: 0x6f637420, type: typeType) // "oct\0x20"
    public static let OLDComposeMessage = MAISymbol(name: "OLDComposeMessage", code: 0x62636b65, type: typeType) // "bcke"
    public static let OLDMessageEditor = MAISymbol(name: "OLDMessageEditor", code: 0x6d656474, type: typeType) // "medt"
    public static let outbox = MAISymbol(name: "outbox", code: 0x6f756d62, type: typeType) // "oumb"
    public static let outgoingMessage = MAISymbol(name: "outgoingMessage", code: 0x62636b65, type: typeType) // "bcke"
    public static let pagesAcross = MAISymbol(name: "pagesAcross", code: 0x6c776c61, type: typeType) // "lwla"
    public static let pagesDown = MAISymbol(name: "pagesDown", code: 0x6c776c64, type: typeType) // "lwld"
    public static let paragraph = MAISymbol(name: "paragraph", code: 0x63706172, type: typeType) // "cpar"
    public static let PICTPicture = MAISymbol(name: "PICTPicture", code: 0x50494354, type: typeType) // "PICT"
    public static let pixelMapRecord = MAISymbol(name: "pixelMapRecord", code: 0x74706d6d, type: typeType) // "tpmm"
    public static let playSound = MAISymbol(name: "playSound", code: 0x7270736f, type: typeType) // "rpso"
    public static let point = MAISymbol(name: "point", code: 0x51447074, type: typeType) // "QDpt"
    public static let popAccount = MAISymbol(name: "popAccount", code: 0x70616374, type: typeType) // "pact"
    public static let port = MAISymbol(name: "port", code: 0x706f7274, type: typeType) // "port"
    public static let portsToLogActivityOn = MAISymbol(name: "portsToLogActivityOn", code: 0x6c616f70, type: typeType) // "laop"
    public static let previewPaneIsVisible = MAISymbol(name: "previewPaneIsVisible", code: 0x6d767076, type: typeType) // "mvpv"
    public static let primaryEmail = MAISymbol(name: "primaryEmail", code: 0x75656d6c, type: typeType) // "ueml"
    public static let printSettings = MAISymbol(name: "printSettings", code: 0x70736574, type: typeType) // "pset"
    public static let processSerialNumber = MAISymbol(name: "processSerialNumber", code: 0x70736e20, type: typeType) // "psn\0x20"
    public static let properties = MAISymbol(name: "properties", code: 0x70414c4c, type: typeType) // "pALL"
    public static let property_ = MAISymbol(name: "property_", code: 0x70726f70, type: typeType) // "prop"
    public static let qualifier = MAISymbol(name: "qualifier", code: 0x72717561, type: typeType) // "rqua"
    public static let quoteOriginalMessage = MAISymbol(name: "quoteOriginalMessage", code: 0x696e6f6d, type: typeType) // "inom"
    public static let readStatus = MAISymbol(name: "readStatus", code: 0x69737264, type: typeType) // "isrd"
    public static let real = MAISymbol(name: "real", code: 0x646f7562, type: typeType) // "doub"
    public static let recipient = MAISymbol(name: "recipient", code: 0x72637074, type: typeType) // "rcpt"
    public static let record = MAISymbol(name: "record", code: 0x7265636f, type: typeType) // "reco"
    public static let redirectMessage = MAISymbol(name: "redirectMessage", code: 0x72726164, type: typeType) // "rrad"
    public static let reference = MAISymbol(name: "reference", code: 0x6f626a20, type: typeType) // "obj\0x20"
    public static let replyText = MAISymbol(name: "replyText", code: 0x72727465, type: typeType) // "rrte"
    public static let replyTo = MAISymbol(name: "replyTo", code: 0x7270746f, type: typeType) // "rpto"
    public static let requestedPrintTime = MAISymbol(name: "requestedPrintTime", code: 0x6c777174, type: typeType) // "lwqt"
    public static let resizable = MAISymbol(name: "resizable", code: 0x7072737a, type: typeType) // "prsz"
    public static let RGB16Color = MAISymbol(name: "RGB16Color", code: 0x74723136, type: typeType) // "tr16"
    public static let RGB96Color = MAISymbol(name: "RGB96Color", code: 0x74723936, type: typeType) // "tr96"
    public static let RGBColor = MAISymbol(name: "RGBColor", code: 0x63524742, type: typeType) // "cRGB"
    public static let richText = MAISymbol(name: "richText", code: 0x63747874, type: typeType) // "ctxt"
    public static let rotation = MAISymbol(name: "rotation", code: 0x74726f74, type: typeType) // "trot"
    public static let rule = MAISymbol(name: "rule", code: 0x72756c65, type: typeType) // "rule"
    public static let ruleCondition = MAISymbol(name: "ruleCondition", code: 0x72756372, type: typeType) // "rucr"
    public static let ruleType = MAISymbol(name: "ruleType", code: 0x72747970, type: typeType) // "rtyp"
    public static let runScript = MAISymbol(name: "runScript", code: 0x72726173, type: typeType) // "rras"
    public static let sameReplyFormat = MAISymbol(name: "sameReplyFormat", code: 0x72697366, type: typeType) // "risf"
    public static let Saturday = MAISymbol(name: "Saturday", code: 0x73617420, type: typeType) // "sat\0x20"
    public static let scope = MAISymbol(name: "scope", code: 0x6c647363, type: typeType) // "ldsc"
    public static let script = MAISymbol(name: "script", code: 0x73637074, type: typeType) // "scpt"
    public static let searchBase = MAISymbol(name: "searchBase", code: 0x6c647362, type: typeType) // "ldsb"
    public static let selectedMailboxes = MAISymbol(name: "selectedMailboxes", code: 0x6d736278, type: typeType) // "msbx"
    public static let selectedMessages = MAISymbol(name: "selectedMessages", code: 0x736d6773, type: typeType) // "smgs"
    public static let selectedSignature = MAISymbol(name: "selectedSignature", code: 0x73657369, type: typeType) // "sesi"
    public static let selection = MAISymbol(name: "selection", code: 0x736c6374, type: typeType) // "slct"
    public static let sender = MAISymbol(name: "sender", code: 0x736e6472, type: typeType) // "sndr"
    public static let sentMailbox = MAISymbol(name: "sentMailbox", code: 0x73746d62, type: typeType) // "stmb"
    public static let September = MAISymbol(name: "September", code: 0x73657020, type: typeType) // "sep\0x20"
    public static let serverName = MAISymbol(name: "serverName", code: 0x686f7374, type: typeType) // "host"
    public static let shortInteger = MAISymbol(name: "shortInteger", code: 0x73686f72, type: typeType) // "shor"
    public static let shouldCopyMessage = MAISymbol(name: "shouldCopyMessage", code: 0x7273636d, type: typeType) // "rscm"
    public static let shouldMoveMessage = MAISymbol(name: "shouldMoveMessage", code: 0x7273746d, type: typeType) // "rstm"
    public static let shouldPlayOtherMailSounds = MAISymbol(name: "shouldPlayOtherMailSounds", code: 0x706f6d73, type: typeType) // "poms"
    public static let signature = MAISymbol(name: "signature", code: 0x73697475, type: typeType) // "situ"
    public static let size = MAISymbol(name: "size", code: 0x7074737a, type: typeType) // "ptsz"
    public static let smallReal = MAISymbol(name: "smallReal", code: 0x73696e67, type: typeType) // "sing"
    public static let smtpServer = MAISymbol(name: "smtpServer", code: 0x64616374, type: typeType) // "dact"
    public static let sortColumn = MAISymbol(name: "sortColumn", code: 0x6d767363, type: typeType) // "mvsc"
    public static let sortedAscending = MAISymbol(name: "sortedAscending", code: 0x6d767372, type: typeType) // "mvsr"
    public static let source = MAISymbol(name: "source", code: 0x7261736f, type: typeType) // "raso"
    public static let startingPage = MAISymbol(name: "startingPage", code: 0x6c776670, type: typeType) // "lwfp"
    public static let stopEvaluatingRules = MAISymbol(name: "stopEvaluatingRules", code: 0x72736572, type: typeType) // "rser"
    public static let storeDeletedMessagesOnServer = MAISymbol(name: "storeDeletedMessagesOnServer", code: 0x73746f73, type: typeType) // "stos"
    public static let storeDraftsOnServer = MAISymbol(name: "storeDraftsOnServer", code: 0x73646f73, type: typeType) // "sdos"
    public static let storeJunkMailOnServer = MAISymbol(name: "storeJunkMailOnServer", code: 0x736a6f73, type: typeType) // "sjos"
    public static let storeSentMessagesOnServer = MAISymbol(name: "storeSentMessagesOnServer", code: 0x73736f73, type: typeType) // "ssos"
    public static let string = MAISymbol(name: "string", code: 0x54455854, type: typeType) // "TEXT"
    public static let styledClipboardText = MAISymbol(name: "styledClipboardText", code: 0x7374796c, type: typeType) // "styl"
    public static let styledText = MAISymbol(name: "styledText", code: 0x53545854, type: typeType) // "STXT"
    public static let subject = MAISymbol(name: "subject", code: 0x7375626a, type: typeType) // "subj"
    public static let Sunday = MAISymbol(name: "Sunday", code: 0x73756e20, type: typeType) // "sun\0x20"
    public static let targetPrinter = MAISymbol(name: "targetPrinter", code: 0x74727072, type: typeType) // "trpr"
    public static let textStyleInfo = MAISymbol(name: "textStyleInfo", code: 0x74737479, type: typeType) // "tsty"
    public static let Thursday = MAISymbol(name: "Thursday", code: 0x74687520, type: typeType) // "thu\0x20"
    public static let TIFFPicture = MAISymbol(name: "TIFFPicture", code: 0x54494646, type: typeType) // "TIFF"
    public static let toRecipient = MAISymbol(name: "toRecipient", code: 0x74726370, type: typeType) // "trcp"
    public static let trashMailbox = MAISymbol(name: "trashMailbox", code: 0x74726d62, type: typeType) // "trmb"
    public static let Tuesday = MAISymbol(name: "Tuesday", code: 0x74756520, type: typeType) // "tue\0x20"
    public static let typeClass = MAISymbol(name: "typeClass", code: 0x74797065, type: typeType) // "type"
    public static let UnicodeText = MAISymbol(name: "UnicodeText", code: 0x75747874, type: typeType) // "utxt"
    public static let unreadCount = MAISymbol(name: "unreadCount", code: 0x6d627563, type: typeType) // "mbuc"
    public static let unsignedDoubleInteger = MAISymbol(name: "unsignedDoubleInteger", code: 0x75636f6d, type: typeType) // "ucom"
    public static let unsignedInteger = MAISymbol(name: "unsignedInteger", code: 0x6d61676e, type: typeType) // "magn"
    public static let unsignedShortInteger = MAISymbol(name: "unsignedShortInteger", code: 0x75736872, type: typeType) // "ushr"
    public static let useAddressCompletion = MAISymbol(name: "useAddressCompletion", code: 0x75736c61, type: typeType) // "usla"
    public static let useFixedWidthFont = MAISymbol(name: "useFixedWidthFont", code: 0x75667766, type: typeType) // "ufwf"
    public static let useKeychain = MAISymbol(name: "useKeychain", code: 0x75736b65, type: typeType) // "uske"
    public static let userName = MAISymbol(name: "userName", code: 0x756e6d65, type: typeType) // "unme"
    public static let usesSsl = MAISymbol(name: "usesSsl", code: 0x75737373, type: typeType) // "usss"
    public static let UTF16Text = MAISymbol(name: "UTF16Text", code: 0x75743136, type: typeType) // "ut16"
    public static let UTF8Text = MAISymbol(name: "UTF8Text", code: 0x75746638, type: typeType) // "utf8"
    public static let vcardPath = MAISymbol(name: "vcardPath", code: 0x68747663, type: typeType) // "htvc"
    public static let version = MAISymbol(name: "version", code: 0x76657273, type: typeType) // "vers"
    public static let visible = MAISymbol(name: "visible", code: 0x70766973, type: typeType) // "pvis"
    public static let visibleColumns = MAISymbol(name: "visibleColumns", code: 0x6d767663, type: typeType) // "mvvc"
    public static let visibleMessages = MAISymbol(name: "visibleMessages", code: 0x6d76666d, type: typeType) // "mvfm"
    public static let wasForwarded = MAISymbol(name: "wasForwarded", code: 0x69736677, type: typeType) // "isfw"
    public static let wasRedirected = MAISymbol(name: "wasRedirected", code: 0x69737263, type: typeType) // "isrc"
    public static let wasRepliedTo = MAISymbol(name: "wasRepliedTo", code: 0x69737270, type: typeType) // "isrp"
    public static let Wednesday = MAISymbol(name: "Wednesday", code: 0x77656420, type: typeType) // "wed\0x20"
    public static let window = MAISymbol(name: "window", code: 0x6377696e, type: typeType) // "cwin"
    public static let word = MAISymbol(name: "word", code: 0x63776f72, type: typeType) // "cwor"
    public static let writingCode = MAISymbol(name: "writingCode", code: 0x70736374, type: typeType) // "psct"
    public static let zoomable = MAISymbol(name: "zoomable", code: 0x69737a6d, type: typeType) // "iszm"
    public static let zoomed = MAISymbol(name: "zoomed", code: 0x707a756d, type: typeType) // "pzum"

    // Enumerators
    public static let all_ = MAISymbol(name: "all_", code: 0x6864616c, type: typeEnumerated) // "hdal"
    public static let allMessagesAndTheirAttachments = MAISymbol(name: "allMessagesAndTheirAttachments", code: 0x7839616c, type: typeEnumerated) // "x9al"
    public static let allMessagesButOmitAttachments = MAISymbol(name: "allMessagesButOmitAttachments", code: 0x7839626f, type: typeEnumerated) // "x9bo"
    public static let anyRecipient = MAISymbol(name: "anyRecipient", code: 0x74616e72, type: typeEnumerated) // "tanr"
    public static let apop = MAISymbol(name: "apop", code: 0x6161706f, type: typeEnumerated) // "aapo"
    public static let AppleToken = MAISymbol(name: "AppleToken", code: 0x61746f6b, type: typeEnumerated) // "atok"
    public static let ask = MAISymbol(name: "ask", code: 0x61736b20, type: typeEnumerated) // "ask\0x20"
    public static let attachmentsColumn = MAISymbol(name: "attachmentsColumn", code: 0x65636174, type: typeEnumerated) // "ecat"
    public static let attachmentType = MAISymbol(name: "attachmentType", code: 0x74617474, type: typeEnumerated) // "tatt"
    public static let base = MAISymbol(name: "base", code: 0x6c736261, type: typeEnumerated) // "lsba"
    public static let beginsWithValue = MAISymbol(name: "beginsWithValue", code: 0x72716277, type: typeEnumerated) // "rqbw"
    public static let blue = MAISymbol(name: "blue", code: 0x6363626c, type: typeEnumerated) // "ccbl"
    public static let case_ = MAISymbol(name: "case_", code: 0x63617365, type: typeEnumerated) // "case"
    public static let ccHeader = MAISymbol(name: "ccHeader", code: 0x74636363, type: typeEnumerated) // "tccc"
    public static let custom = MAISymbol(name: "custom", code: 0x68646375, type: typeEnumerated) // "hdcu"
    public static let dateLastSavedColumn = MAISymbol(name: "dateLastSavedColumn", code: 0x65636c73, type: typeEnumerated) // "ecls"
    public static let dateReceivedColumn = MAISymbol(name: "dateReceivedColumn", code: 0x65636472, type: typeEnumerated) // "ecdr"
    public static let dateSentColumn = MAISymbol(name: "dateSentColumn", code: 0x65636473, type: typeEnumerated) // "ecds"
    public static let default_ = MAISymbol(name: "default_", code: 0x68646465, type: typeEnumerated) // "hdde"
    public static let detailed = MAISymbol(name: "detailed", code: 0x6c776474, type: typeEnumerated) // "lwdt"
    public static let diacriticals = MAISymbol(name: "diacriticals", code: 0x64696163, type: typeEnumerated) // "diac"
    public static let doesContainValue = MAISymbol(name: "doesContainValue", code: 0x7271636f, type: typeEnumerated) // "rqco"
    public static let doesNotContainValue = MAISymbol(name: "doesNotContainValue", code: 0x7271646e, type: typeEnumerated) // "rqdn"
    public static let doNotKeepCopiesOfAnyMessages = MAISymbol(name: "doNotKeepCopiesOfAnyMessages", code: 0x78396e6f, type: typeEnumerated) // "x9no"
    public static let endsWithValue = MAISymbol(name: "endsWithValue", code: 0x72716577, type: typeEnumerated) // "rqew"
    public static let equalToValue = MAISymbol(name: "equalToValue", code: 0x72716965, type: typeEnumerated) // "rqie"
    public static let expansion = MAISymbol(name: "expansion", code: 0x65787061, type: typeEnumerated) // "expa"
    public static let external = MAISymbol(name: "external", code: 0x61657874, type: typeEnumerated) // "aext"
    public static let flagsColumn = MAISymbol(name: "flagsColumn", code: 0x6563666c, type: typeEnumerated) // "ecfl"
    public static let fromColumn = MAISymbol(name: "fromColumn", code: 0x65636672, type: typeEnumerated) // "ecfr"
    public static let fromHeader = MAISymbol(name: "fromHeader", code: 0x7466726f, type: typeEnumerated) // "tfro"
    public static let gray = MAISymbol(name: "gray", code: 0x63636779, type: typeEnumerated) // "ccgy"
    public static let greaterThanValue = MAISymbol(name: "greaterThanValue", code: 0x72716774, type: typeEnumerated) // "rqgt"
    public static let green = MAISymbol(name: "green", code: 0x63636772, type: typeEnumerated) // "ccgr"
    public static let headerKey = MAISymbol(name: "headerKey", code: 0x7468646b, type: typeEnumerated) // "thdk"
    public static let hyphens = MAISymbol(name: "hyphens", code: 0x68797068, type: typeEnumerated) // "hyph"
    public static let iCloud = MAISymbol(name: "iCloud", code: 0x65746974, type: typeEnumerated) // "etit"
    public static let imap = MAISymbol(name: "imap", code: 0x6574696d, type: typeEnumerated) // "etim"
    public static let kerberos5 = MAISymbol(name: "kerberos5", code: 0x61786b35, type: typeEnumerated) // "axk5"
    public static let lessThanValue = MAISymbol(name: "lessThanValue", code: 0x72716c74, type: typeEnumerated) // "rqlt"
    public static let mailboxColumn = MAISymbol(name: "mailboxColumn", code: 0x65636d62, type: typeEnumerated) // "ecmb"
    public static let matchesEveryMessage = MAISymbol(name: "matchesEveryMessage", code: 0x7465766d, type: typeEnumerated) // "tevm"
    public static let md5 = MAISymbol(name: "md5", code: 0x61786d64, type: typeEnumerated) // "axmd"
    public static let messageColor = MAISymbol(name: "messageColor", code: 0x6563636c, type: typeEnumerated) // "eccl"
    public static let messageContent = MAISymbol(name: "messageContent", code: 0x746d6563, type: typeEnumerated) // "tmec"
    public static let messageIsJunkMail = MAISymbol(name: "messageIsJunkMail", code: 0x746d696a, type: typeEnumerated) // "tmij"
    public static let messageStatusColumn = MAISymbol(name: "messageStatusColumn", code: 0x65636d73, type: typeEnumerated) // "ecms"
    public static let nativeFormat = MAISymbol(name: "nativeFormat", code: 0x6974656d, type: typeEnumerated) // "item"
    public static let no = MAISymbol(name: "no", code: 0x6e6f2020, type: typeEnumerated) // "no\0x20\0x20"
    public static let noHeaders = MAISymbol(name: "noHeaders", code: 0x68646e6e, type: typeEnumerated) // "hdnn"
    public static let none = MAISymbol(name: "none", code: 0x63636e6f, type: typeEnumerated) // "ccno"
    public static let ntlm = MAISymbol(name: "ntlm", code: 0x61786e74, type: typeEnumerated) // "axnt"
    public static let numberColumn = MAISymbol(name: "numberColumn", code: 0x65636e6d, type: typeEnumerated) // "ecnm"
    public static let numericStrings = MAISymbol(name: "numericStrings", code: 0x6e756d65, type: typeEnumerated) // "nume"
    public static let oneLevel = MAISymbol(name: "oneLevel", code: 0x6c736f6c, type: typeEnumerated) // "lsol"
    public static let onlyMessagesIHaveRead = MAISymbol(name: "onlyMessagesIHaveRead", code: 0x78397772, type: typeEnumerated) // "x9wr"
    public static let orange = MAISymbol(name: "orange", code: 0x63636f72, type: typeEnumerated) // "ccor"
    public static let other = MAISymbol(name: "other", code: 0x63636f74, type: typeEnumerated) // "ccot"
    public static let password = MAISymbol(name: "password", code: 0x61786374, type: typeEnumerated) // "axct"
    public static let plainFormat = MAISymbol(name: "plainFormat", code: 0x646d7074, type: typeEnumerated) // "dmpt"
    public static let pop = MAISymbol(name: "pop", code: 0x6574706f, type: typeEnumerated) // "etpo"
    public static let punctuation = MAISymbol(name: "punctuation", code: 0x70756e63, type: typeEnumerated) // "punc"
    public static let purple = MAISymbol(name: "purple", code: 0x63637075, type: typeEnumerated) // "ccpu"
    public static let red = MAISymbol(name: "red", code: 0x63637265, type: typeEnumerated) // "ccre"
    public static let richFormat = MAISymbol(name: "richFormat", code: 0x646d7274, type: typeEnumerated) // "dmrt"
    public static let senderIsInMyContacts = MAISymbol(name: "senderIsInMyContacts", code: 0x74736969, type: typeEnumerated) // "tsii"
    public static let senderIsInMyPreviousRecipients = MAISymbol(name: "senderIsInMyPreviousRecipients", code: 0x74736168, type: typeEnumerated) // "tsah"
    public static let senderIsMemberOfGroup = MAISymbol(name: "senderIsMemberOfGroup", code: 0x7473696d, type: typeEnumerated) // "tsim"
    public static let senderIsNotInMyContacts = MAISymbol(name: "senderIsNotInMyContacts", code: 0x7473696e, type: typeEnumerated) // "tsin"
    public static let senderIsNotInMyPreviousRecipients = MAISymbol(name: "senderIsNotInMyPreviousRecipients", code: 0x746e6168, type: typeEnumerated) // "tnah"
    public static let senderIsNotMemberOfGroup = MAISymbol(name: "senderIsNotMemberOfGroup", code: 0x74736967, type: typeEnumerated) // "tsig"
    public static let senderIsVIP = MAISymbol(name: "senderIsVIP", code: 0x74736967, type: typeEnumerated) // "tsig"
    public static let sizeColumn = MAISymbol(name: "sizeColumn", code: 0x6563737a, type: typeEnumerated) // "ecsz"
    public static let smtp = MAISymbol(name: "smtp", code: 0x6574736d, type: typeEnumerated) // "etsm"
    public static let standard = MAISymbol(name: "standard", code: 0x6c777374, type: typeEnumerated) // "lwst"
    public static let subjectColumn = MAISymbol(name: "subjectColumn", code: 0x65637375, type: typeEnumerated) // "ecsu"
    public static let subjectHeader = MAISymbol(name: "subjectHeader", code: 0x74737562, type: typeEnumerated) // "tsub"
    public static let subtree = MAISymbol(name: "subtree", code: 0x6c737374, type: typeEnumerated) // "lsst"
    public static let toColumn = MAISymbol(name: "toColumn", code: 0x6563746f, type: typeEnumerated) // "ecto"
    public static let toHeader = MAISymbol(name: "toHeader", code: 0x74746f6f, type: typeEnumerated) // "ttoo"
    public static let toOrCcHeader = MAISymbol(name: "toOrCcHeader", code: 0x74746f63, type: typeEnumerated) // "ttoc"
    public static let unknown = MAISymbol(name: "unknown", code: 0x6574756e, type: typeEnumerated) // "etun"
    public static let whitespace = MAISymbol(name: "whitespace", code: 0x77686974, type: typeEnumerated) // "whit"
    public static let yellow = MAISymbol(name: "yellow", code: 0x63637965, type: typeEnumerated) // "ccye"
    public static let yes = MAISymbol(name: "yes", code: 0x79657320, type: typeEnumerated) // "yes\0x20"
}

public typealias MAI = MAISymbol // allows symbols to be written as (e.g.) MAI.name instead of MAISymbol.name


/******************************************************************************/
// Specifier extensions; these add command methods and property/elements getters based on Mail.app terminology

public protocol MAICommand: SwiftAutomation.SpecifierProtocol {} // provides AE dispatch methods

// Command->Any will be bound when return type can't be inferred, else Command->T

extension MAICommand {
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
    @discardableResult public func bounce(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "bounce", eventClass: 0x656d616c, eventID: 0x62636d73, // "emal"/"bcms"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func bounce<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "bounce", eventClass: 0x656d616c, eventID: 0x62636d73, // "emal"/"bcms"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func checkForNewMail(_ directParameter: Any = SwiftAutomation.NoParameter,
            for_: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "checkForNewMail", eventClass: 0x656d616c, eventID: 0x63686d61, // "emal"/"chma"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("for_", 0x61636e61, for_), // "acna"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func checkForNewMail<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            for_: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "checkForNewMail", eventClass: 0x656d616c, eventID: 0x63686d61, // "emal"/"chma"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("for_", 0x61636e61, for_), // "acna"
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
    @discardableResult public func extractAddressFrom(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "extractAddressFrom", eventClass: 0x656d616c, eventID: 0x65617561, // "emal"/"eaua"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func extractAddressFrom<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "extractAddressFrom", eventClass: 0x656d616c, eventID: 0x65617561, // "emal"/"eaua"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func extractNameFrom(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "extractNameFrom", eventClass: 0x656d616c, eventID: 0x6561666e, // "emal"/"eafn"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func extractNameFrom<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "extractNameFrom", eventClass: 0x656d616c, eventID: 0x6561666e, // "emal"/"eafn"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func forward(_ directParameter: Any = SwiftAutomation.NoParameter,
            openingWindow: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "forward", eventClass: 0x656d616c, eventID: 0x66776d73, // "emal"/"fwms"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("openingWindow", 0x726f7077, openingWindow), // "ropw"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func forward<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            openingWindow: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "forward", eventClass: 0x656d616c, eventID: 0x66776d73, // "emal"/"fwms"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("openingWindow", 0x726f7077, openingWindow), // "ropw"
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
    @discardableResult public func GetURL(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "GetURL", eventClass: 0x656d616c, eventID: 0x656d7467, // "emal"/"emtg"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func GetURL<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "GetURL", eventClass: 0x656d616c, eventID: 0x656d7467, // "emal"/"emtg"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func importMailMailbox(_ directParameter: Any = SwiftAutomation.NoParameter,
            at: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "importMailMailbox", eventClass: 0x656d616c, eventID: 0x696d6d78, // "emal"/"immx"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("at", 0x6d627074, at), // "mbpt"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func importMailMailbox<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            at: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "importMailMailbox", eventClass: 0x656d616c, eventID: 0x696d6d78, // "emal"/"immx"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("at", 0x6d627074, at), // "mbpt"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    @discardableResult public func mailto(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "mailto", eventClass: 0x656d616c, eventID: 0x656d746f, // "emal"/"emto"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func mailto<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "mailto", eventClass: 0x656d616c, eventID: 0x656d746f, // "emal"/"emto"
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
    @discardableResult public func performMailActionWithMessages(_ directParameter: Any = SwiftAutomation.NoParameter,
            inMailboxes: Any = SwiftAutomation.NoParameter,
            forRule: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "performMailActionWithMessages", eventClass: 0x656d616c, eventID: 0x63706d61, // "emal"/"cpma"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("inMailboxes", 0x706d6278, inMailboxes), // "pmbx"
                    ("forRule", 0x706d6172, forRule), // "pmar"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func performMailActionWithMessages<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            inMailboxes: Any = SwiftAutomation.NoParameter,
            forRule: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "performMailActionWithMessages", eventClass: 0x656d616c, eventID: 0x63706d61, // "emal"/"cpma"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("inMailboxes", 0x706d6278, inMailboxes), // "pmbx"
                    ("forRule", 0x706d6172, forRule), // "pmar"
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
    @discardableResult public func redirect(_ directParameter: Any = SwiftAutomation.NoParameter,
            openingWindow: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "redirect", eventClass: 0x656d616c, eventID: 0x72646d73, // "emal"/"rdms"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("openingWindow", 0x726f7077, openingWindow), // "ropw"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func redirect<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            openingWindow: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "redirect", eventClass: 0x656d616c, eventID: 0x72646d73, // "emal"/"rdms"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("openingWindow", 0x726f7077, openingWindow), // "ropw"
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
    @discardableResult public func reply(_ directParameter: Any = SwiftAutomation.NoParameter,
            openingWindow: Any = SwiftAutomation.NoParameter,
            replyToAll: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "reply", eventClass: 0x656d616c, eventID: 0x72706d73, // "emal"/"rpms"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("openingWindow", 0x726f7077, openingWindow), // "ropw"
                    ("replyToAll", 0x7270616c, replyToAll), // "rpal"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func reply<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            openingWindow: Any = SwiftAutomation.NoParameter,
            replyToAll: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "reply", eventClass: 0x656d616c, eventID: 0x72706d73, // "emal"/"rpms"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("openingWindow", 0x726f7077, openingWindow), // "ropw"
                    ("replyToAll", 0x7270616c, replyToAll), // "rpal"
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
    @discardableResult public func send(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "send", eventClass: 0x656d7367, eventID: 0x73656e64, // "emsg"/"send"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func send<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "send", eventClass: 0x656d7367, eventID: 0x73656e64, // "emsg"/"send"
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
    @discardableResult public func synchronize(_ directParameter: Any = SwiftAutomation.NoParameter,
            with: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "synchronize", eventClass: 0x656d616c, eventID: 0x73796163, // "emal"/"syac"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("with", 0x61636e61, with), // "acna"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func synchronize<T>(_ directParameter: Any = SwiftAutomation.NoParameter,
            with: Any = SwiftAutomation.NoParameter,
            requestedType: SwiftAutomation.Symbol? = nil, waitReply: Bool = true, sendOptions: SwiftAutomation.SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: SwiftAutomation.ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "synchronize", eventClass: 0x656d616c, eventID: 0x73796163, // "emal"/"syac"
                parentSpecifier: (self as! SwiftAutomation.Specifier), directParameter: directParameter, keywordParameters: [
                    ("with", 0x61636e61, with), // "acna"
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
}


public protocol MAIObject: SwiftAutomation.ObjectSpecifierExtension, MAICommand {} // provides vars and methods for constructing specifiers

extension MAIObject {
    
    // Properties
    public var account: MAIItem {return self.property(0x6d616374) as! MAIItem} // "mact"
    public var accountDirectory: MAIItem {return self.property(0x70617468) as! MAIItem} // "path"
    public var accountType: MAIItem {return self.property(0x61747970) as! MAIItem} // "atyp"
    public var address: MAIItem {return self.property(0x72616464) as! MAIItem} // "radd"
    public var allConditionsMustBeMet: MAIItem {return self.property(0x7261636d) as! MAIItem} // "racm"
    public var allHeaders: MAIItem {return self.property(0x616c6865) as! MAIItem} // "alhe"
    public var alwaysBccMyself: MAIItem {return self.property(0x6162636d) as! MAIItem} // "abcm"
    public var alwaysCcMyself: MAIItem {return self.property(0x6163636d) as! MAIItem} // "accm"
    public var applicationVersion: MAIItem {return self.property(0x61707665) as! MAIItem} // "apve"
    public var authentication: MAIItem {return self.property(0x70617573) as! MAIItem} // "paus"
    public var backgroundActivityCount: MAIItem {return self.property(0x62746863) as! MAIItem} // "bthc"
    public var backgroundColor: MAIItem {return self.property(0x6d636f6c) as! MAIItem} // "mcol"
    public var bigMessageWarningSize: MAIItem {return self.property(0x626d7773) as! MAIItem} // "bmws"
    public var bounds: MAIItem {return self.property(0x70626e64) as! MAIItem} // "pbnd"
    public var checkSpellingWhileTyping: MAIItem {return self.property(0x63687370) as! MAIItem} // "chsp"
    public var chooseSignatureWhenComposing: MAIItem {return self.property(0x63737763) as! MAIItem} // "cswc"
    public var class_: MAIItem {return self.property(0x70636c73) as! MAIItem} // "pcls"
    public var closeable: MAIItem {return self.property(0x68636c62) as! MAIItem} // "hclb"
    public var collating: MAIItem {return self.property(0x6c77636c) as! MAIItem} // "lwcl"
    public var color: MAIItem {return self.property(0x636f6c72) as! MAIItem} // "colr"
    public var colorMessage: MAIItem {return self.property(0x72636d65) as! MAIItem} // "rcme"
    public var colorQuotedText: MAIItem {return self.property(0x6d636374) as! MAIItem} // "mcct"
    public var compactMailboxesWhenClosing: MAIItem {return self.property(0x6377636d) as! MAIItem} // "cwcm"
    public var container: MAIItem {return self.property(0x6d627863) as! MAIItem} // "mbxc"
    public var content: MAIItem {return self.property(0x63746e74) as! MAIItem} // "ctnt"
    public var copies: MAIItem {return self.property(0x6c776370) as! MAIItem} // "lwcp"
    public var copyMessage: MAIItem {return self.property(0x72636d62) as! MAIItem} // "rcmb"
    public var dateReceived: MAIItem {return self.property(0x72647263) as! MAIItem} // "rdrc"
    public var dateSent: MAIItem {return self.property(0x64726376) as! MAIItem} // "drcv"
    public var defaultMessageFormat: MAIItem {return self.property(0x64656d66) as! MAIItem} // "demf"
    public var delayedMessageDeletionInterval: MAIItem {return self.property(0x646d6469) as! MAIItem} // "dmdi"
    public var deletedStatus: MAIItem {return self.property(0x6973646c) as! MAIItem} // "isdl"
    public var deleteMailOnServer: MAIItem {return self.property(0x646d6f73) as! MAIItem} // "dmos"
    public var deleteMessage: MAIItem {return self.property(0x72646d65) as! MAIItem} // "rdme"
    public var deleteMessagesWhenMovedFromInbox: MAIItem {return self.property(0x646d776d) as! MAIItem} // "dmwm"
    public var deliveryAccount: MAIItem {return self.property(0x64616374) as! MAIItem} // "dact"
    public var document: MAIItem {return self.property(0x646f6375) as! MAIItem} // "docu"
    public var downloaded: MAIItem {return self.property(0x6174646e) as! MAIItem} // "atdn"
    public var downloadHtmlAttachments: MAIItem {return self.property(0x64687461) as! MAIItem} // "dhta"
    public var draftsMailbox: MAIItem {return self.property(0x64726d62) as! MAIItem} // "drmb"
    public var emailAddresses: MAIItem {return self.property(0x656d6164) as! MAIItem} // "emad"
    public var emptyJunkMessagesFrequency: MAIItem {return self.property(0x656a6d66) as! MAIItem} // "ejmf"
    public var emptyJunkMessagesOnQuit: MAIItem {return self.property(0x656a6d6f) as! MAIItem} // "ejmo"
    public var emptySentMessagesFrequency: MAIItem {return self.property(0x65736d66) as! MAIItem} // "esmf"
    public var emptySentMessagesOnQuit: MAIItem {return self.property(0x65736d6f) as! MAIItem} // "esmo"
    public var emptyTrashFrequency: MAIItem {return self.property(0x65747266) as! MAIItem} // "etrf"
    public var emptyTrashOnQuit: MAIItem {return self.property(0x65746f71) as! MAIItem} // "etoq"
    public var enabled: MAIItem {return self.property(0x69736163) as! MAIItem} // "isac"
    public var endingPage: MAIItem {return self.property(0x6c776c70) as! MAIItem} // "lwlp"
    public var errorHandling: MAIItem {return self.property(0x6c776568) as! MAIItem} // "lweh"
    public var expandGroupAddresses: MAIItem {return self.property(0x65786761) as! MAIItem} // "exga"
    public var expression: MAIItem {return self.property(0x72657870) as! MAIItem} // "rexp"
    public var faxNumber: MAIItem {return self.property(0x6661786e) as! MAIItem} // "faxn"
    public var fetchesAutomatically: MAIItem {return self.property(0x73616674) as! MAIItem} // "saft"
    public var fetchInterval: MAIItem {return self.property(0x61666671) as! MAIItem} // "affq"
    public var file: MAIItem {return self.property(0x66696c65) as! MAIItem} // "file"
    public var fileName: MAIItem {return self.property(0x6174666e) as! MAIItem} // "atfn"
    public var fileSize: MAIItem {return self.property(0x6174737a) as! MAIItem} // "atsz"
    public var fixedWidthFont: MAIItem {return self.property(0x6d707466) as! MAIItem} // "mptf"
    public var fixedWidthFontSize: MAIItem {return self.property(0x70746673) as! MAIItem} // "ptfs"
    public var flaggedStatus: MAIItem {return self.property(0x6973666c) as! MAIItem} // "isfl"
    public var flagIndex: MAIItem {return self.property(0x66696478) as! MAIItem} // "fidx"
    public var font: MAIItem {return self.property(0x666f6e74) as! MAIItem} // "font"
    public var forwardMessage: MAIItem {return self.property(0x72666164) as! MAIItem} // "rfad"
    public var forwardText: MAIItem {return self.property(0x72667465) as! MAIItem} // "rfte"
    public var frameworkVersion: MAIItem {return self.property(0x66727665) as! MAIItem} // "frve"
    public var frontmost: MAIItem {return self.property(0x70697366) as! MAIItem} // "pisf"
    public var fullName: MAIItem {return self.property(0x666c6c6e) as! MAIItem} // "flln"
    public var header: MAIItem {return self.property(0x72686564) as! MAIItem} // "rhed"
    public var headerDetail: MAIItem {return self.property(0x6865646c) as! MAIItem} // "hedl"
    public var highlightSelectedConversation: MAIItem {return self.property(0x73686874) as! MAIItem} // "shht"
    public var highlightTextUsingColor: MAIItem {return self.property(0x68747563) as! MAIItem} // "htuc"
    public var hostName: MAIItem {return self.property(0x6c647361) as! MAIItem} // "ldsa"
    public var hostsToLogActivityOn: MAIItem {return self.property(0x6c616f68) as! MAIItem} // "laoh"
    public var htmlContent: MAIItem {return self.property(0x68746461) as! MAIItem} // "htda"
    public var id: MAIItem {return self.property(0x49442020) as! MAIItem} // "ID\0x20\0x20"
    public var inbox: MAIItem {return self.property(0x696e6d62) as! MAIItem} // "inmb"
    public var includeAllOriginalMessageText: MAIItem {return self.property(0x69616f6f) as! MAIItem} // "iaoo"
    public var includeWhenGettingNewMail: MAIItem {return self.property(0x6977676d) as! MAIItem} // "iwgm"
    public var index: MAIItem {return self.property(0x70696478) as! MAIItem} // "pidx"
    public var junkMailbox: MAIItem {return self.property(0x6a6b6d62) as! MAIItem} // "jkmb"
    public var junkMailStatus: MAIItem {return self.property(0x69736a6b) as! MAIItem} // "isjk"
    public var levelOneQuotingColor: MAIItem {return self.property(0x6c6f7163) as! MAIItem} // "loqc"
    public var levelThreeQuotingColor: MAIItem {return self.property(0x6c687163) as! MAIItem} // "lhqc"
    public var levelTwoQuotingColor: MAIItem {return self.property(0x6c777163) as! MAIItem} // "lwqc"
    public var logAllSocketActivity: MAIItem {return self.property(0x6c616173) as! MAIItem} // "laas"
    public var mailbox: MAIItem {return self.property(0x6d627870) as! MAIItem} // "mbxp"
    public var mailboxListVisible: MAIItem {return self.property(0x6d6c7368) as! MAIItem} // "mlsh"
    public var markFlagged: MAIItem {return self.property(0x726d666c) as! MAIItem} // "rmfl"
    public var markFlagIndex: MAIItem {return self.property(0x7266636c) as! MAIItem} // "rfcl"
    public var markRead: MAIItem {return self.property(0x726d7265) as! MAIItem} // "rmre"
    public var memoryStatistics: MAIItem {return self.property(0x6d656d73) as! MAIItem} // "mems"
    public var messageCaching: MAIItem {return self.property(0x6d736763) as! MAIItem} // "msgc"
    public var messageFont: MAIItem {return self.property(0x6d6d666e) as! MAIItem} // "mmfn"
    public var messageFontSize: MAIItem {return self.property(0x6d6d6673) as! MAIItem} // "mmfs"
    public var messageId: MAIItem {return self.property(0x6d656964) as! MAIItem} // "meid"
    public var messageListFont: MAIItem {return self.property(0x6d6d6c66) as! MAIItem} // "mmlf"
    public var messageListFontSize: MAIItem {return self.property(0x6d6c6673) as! MAIItem} // "mlfs"
    public var messageSignature: MAIItem {return self.property(0x746e7267) as! MAIItem} // "tnrg"
    public var messageSize: MAIItem {return self.property(0x6d737a65) as! MAIItem} // "msze"
    public var MIMEType: MAIItem {return self.property(0x61747470) as! MAIItem} // "attp"
    public var miniaturizable: MAIItem {return self.property(0x69736d6e) as! MAIItem} // "ismn"
    public var miniaturized: MAIItem {return self.property(0x706d6e64) as! MAIItem} // "pmnd"
    public var modified: MAIItem {return self.property(0x696d6f64) as! MAIItem} // "imod"
    public var moveDeletedMessagesToTrash: MAIItem {return self.property(0x736d646d) as! MAIItem} // "smdm"
    public var moveMessage: MAIItem {return self.property(0x72746d65) as! MAIItem} // "rtme"
    public var name: MAIItem {return self.property(0x706e616d) as! MAIItem} // "pnam"
    public var newMailSound: MAIItem {return self.property(0x6d6e6d73) as! MAIItem} // "mnms"
    public var OLDComposeMessage: MAIItem {return self.property(0x62636b65) as! MAIItem} // "bcke"
    public var outbox: MAIItem {return self.property(0x6f756d62) as! MAIItem} // "oumb"
    public var pagesAcross: MAIItem {return self.property(0x6c776c61) as! MAIItem} // "lwla"
    public var pagesDown: MAIItem {return self.property(0x6c776c64) as! MAIItem} // "lwld"
    public var password: MAIItem {return self.property(0x6d616370) as! MAIItem} // "macp"
    public var playSound: MAIItem {return self.property(0x7270736f) as! MAIItem} // "rpso"
    public var port: MAIItem {return self.property(0x706f7274) as! MAIItem} // "port"
    public var portsToLogActivityOn: MAIItem {return self.property(0x6c616f70) as! MAIItem} // "laop"
    public var previewPaneIsVisible: MAIItem {return self.property(0x6d767076) as! MAIItem} // "mvpv"
    public var primaryEmail: MAIItem {return self.property(0x75656d6c) as! MAIItem} // "ueml"
    public var properties: MAIItem {return self.property(0x70414c4c) as! MAIItem} // "pALL"
    public var qualifier: MAIItem {return self.property(0x72717561) as! MAIItem} // "rqua"
    public var quoteOriginalMessage: MAIItem {return self.property(0x696e6f6d) as! MAIItem} // "inom"
    public var readStatus: MAIItem {return self.property(0x69737264) as! MAIItem} // "isrd"
    public var redirectMessage: MAIItem {return self.property(0x72726164) as! MAIItem} // "rrad"
    public var replyText: MAIItem {return self.property(0x72727465) as! MAIItem} // "rrte"
    public var replyTo: MAIItem {return self.property(0x7270746f) as! MAIItem} // "rpto"
    public var requestedPrintTime: MAIItem {return self.property(0x6c777174) as! MAIItem} // "lwqt"
    public var resizable: MAIItem {return self.property(0x7072737a) as! MAIItem} // "prsz"
    public var ruleType: MAIItem {return self.property(0x72747970) as! MAIItem} // "rtyp"
    public var runScript: MAIItem {return self.property(0x72726173) as! MAIItem} // "rras"
    public var sameReplyFormat: MAIItem {return self.property(0x72697366) as! MAIItem} // "risf"
    public var scope: MAIItem {return self.property(0x6c647363) as! MAIItem} // "ldsc"
    public var searchBase: MAIItem {return self.property(0x6c647362) as! MAIItem} // "ldsb"
    public var selectedMailboxes: MAIItem {return self.property(0x6d736278) as! MAIItem} // "msbx"
    public var selectedMessages: MAIItem {return self.property(0x736d6773) as! MAIItem} // "smgs"
    public var selectedSignature: MAIItem {return self.property(0x73657369) as! MAIItem} // "sesi"
    public var selection: MAIItem {return self.property(0x736c6374) as! MAIItem} // "slct"
    public var sender: MAIItem {return self.property(0x736e6472) as! MAIItem} // "sndr"
    public var sentMailbox: MAIItem {return self.property(0x73746d62) as! MAIItem} // "stmb"
    public var serverName: MAIItem {return self.property(0x686f7374) as! MAIItem} // "host"
    public var shouldCopyMessage: MAIItem {return self.property(0x7273636d) as! MAIItem} // "rscm"
    public var shouldMoveMessage: MAIItem {return self.property(0x7273746d) as! MAIItem} // "rstm"
    public var shouldPlayOtherMailSounds: MAIItem {return self.property(0x706f6d73) as! MAIItem} // "poms"
    public var size: MAIItem {return self.property(0x7074737a) as! MAIItem} // "ptsz"
    public var sortColumn: MAIItem {return self.property(0x6d767363) as! MAIItem} // "mvsc"
    public var sortedAscending: MAIItem {return self.property(0x6d767372) as! MAIItem} // "mvsr"
    public var source: MAIItem {return self.property(0x7261736f) as! MAIItem} // "raso"
    public var startingPage: MAIItem {return self.property(0x6c776670) as! MAIItem} // "lwfp"
    public var stopEvaluatingRules: MAIItem {return self.property(0x72736572) as! MAIItem} // "rser"
    public var storeDeletedMessagesOnServer: MAIItem {return self.property(0x73746f73) as! MAIItem} // "stos"
    public var storeDraftsOnServer: MAIItem {return self.property(0x73646f73) as! MAIItem} // "sdos"
    public var storeJunkMailOnServer: MAIItem {return self.property(0x736a6f73) as! MAIItem} // "sjos"
    public var storeSentMessagesOnServer: MAIItem {return self.property(0x73736f73) as! MAIItem} // "ssos"
    public var subject: MAIItem {return self.property(0x7375626a) as! MAIItem} // "subj"
    public var targetPrinter: MAIItem {return self.property(0x74727072) as! MAIItem} // "trpr"
    public var trashMailbox: MAIItem {return self.property(0x74726d62) as! MAIItem} // "trmb"
    public var unreadCount: MAIItem {return self.property(0x6d627563) as! MAIItem} // "mbuc"
    public var useAddressCompletion: MAIItem {return self.property(0x75736c61) as! MAIItem} // "usla"
    public var useFixedWidthFont: MAIItem {return self.property(0x75667766) as! MAIItem} // "ufwf"
    public var useKeychain: MAIItem {return self.property(0x75736b65) as! MAIItem} // "uske"
    public var userName: MAIItem {return self.property(0x756e6d65) as! MAIItem} // "unme"
    public var usesSsl: MAIItem {return self.property(0x75737373) as! MAIItem} // "usss"
    public var vcardPath: MAIItem {return self.property(0x68747663) as! MAIItem} // "htvc"
    public var version: MAIItem {return self.property(0x76657273) as! MAIItem} // "vers"
    public var visible: MAIItem {return self.property(0x70766973) as! MAIItem} // "pvis"
    public var visibleColumns: MAIItem {return self.property(0x6d767663) as! MAIItem} // "mvvc"
    public var visibleMessages: MAIItem {return self.property(0x6d76666d) as! MAIItem} // "mvfm"
    public var wasForwarded: MAIItem {return self.property(0x69736677) as! MAIItem} // "isfw"
    public var wasRedirected: MAIItem {return self.property(0x69737263) as! MAIItem} // "isrc"
    public var wasRepliedTo: MAIItem {return self.property(0x69737270) as! MAIItem} // "isrp"
    public var zoomable: MAIItem {return self.property(0x69737a6d) as! MAIItem} // "iszm"
    public var zoomed: MAIItem {return self.property(0x707a756d) as! MAIItem} // "pzum"

    // Elements
    public var accounts: MAIItems {return self.elements(0x6d616374) as! MAIItems} // "mact"
    public var applications: MAIItems {return self.elements(0x63617070) as! MAIItems} // "capp"
    public var attachments: MAIItems {return self.elements(0x61747473) as! MAIItems} // "atts"
    public var attributeRuns: MAIItems {return self.elements(0x63617472) as! MAIItems} // "catr"
    public var bccRecipients: MAIItems {return self.elements(0x62726370) as! MAIItems} // "brcp"
    public var ccRecipients: MAIItems {return self.elements(0x63726370) as! MAIItems} // "crcp"
    public var characters: MAIItems {return self.elements(0x63686120) as! MAIItems} // "cha\0x20"
    public var containers: MAIItems {return self.elements(0x6d627863) as! MAIItems} // "mbxc"
    public var documents: MAIItems {return self.elements(0x646f6375) as! MAIItems} // "docu"
    public var headers: MAIItems {return self.elements(0x6d686472) as! MAIItems} // "mhdr"
    public var iCloudAccounts: MAIItems {return self.elements(0x69746163) as! MAIItems} // "itac"
    public var imapAccounts: MAIItems {return self.elements(0x69616374) as! MAIItems} // "iact"
    public var items: MAIItems {return self.elements(0x636f626a) as! MAIItems} // "cobj"
    public var ldapServers: MAIItems {return self.elements(0x6c647365) as! MAIItems} // "ldse"
    public var mailAttachments: MAIItems {return self.elements(0x61747463) as! MAIItems} // "attc"
    public var mailboxes: MAIItems {return self.elements(0x6d627870) as! MAIItems} // "mbxp"
    public var messages: MAIItems {return self.elements(0x6d737367) as! MAIItems} // "mssg"
    public var messageViewers: MAIItems {return self.elements(0x6d767772) as! MAIItems} // "mvwr"
    public var OLDMessageEditors: MAIItems {return self.elements(0x6d656474) as! MAIItems} // "medt"
    public var outgoingMessages: MAIItems {return self.elements(0x62636b65) as! MAIItems} // "bcke"
    public var paragraphs: MAIItems {return self.elements(0x63706172) as! MAIItems} // "cpar"
    public var popAccounts: MAIItems {return self.elements(0x70616374) as! MAIItems} // "pact"
    public var recipients: MAIItems {return self.elements(0x72637074) as! MAIItems} // "rcpt"
    public var richText: MAIItems {return self.elements(0x63747874) as! MAIItems} // "ctxt"
    public var rules: MAIItems {return self.elements(0x72756c65) as! MAIItems} // "rule"
    public var ruleConditions: MAIItems {return self.elements(0x72756372) as! MAIItems} // "rucr"
    public var signatures: MAIItems {return self.elements(0x73697475) as! MAIItems} // "situ"
    public var smtpServers: MAIItems {return self.elements(0x64616374) as! MAIItems} // "dact"
    public var toRecipients: MAIItems {return self.elements(0x74726370) as! MAIItems} // "trcp"
    public var windows: MAIItems {return self.elements(0x6377696e) as! MAIItems} // "cwin"
    public var words: MAIItems {return self.elements(0x63776f72) as! MAIItems} // "cwor"
}


/******************************************************************************/
// Specifier subclasses add app-specific extensions

// beginning/end/before/after
public class MAIInsertion: SwiftAutomation.InsertionSpecifier, MAICommand {}


// property/by-index/by-name/by-id/previous/next/first/middle/last/any
public class MAIItem: SwiftAutomation.ObjectSpecifier, MAIObject {
    public typealias InsertionSpecifierType = MAIInsertion
    public typealias ObjectSpecifierType = MAIItem
    public typealias MultipleObjectSpecifierType = MAIItems
}

// by-range/by-test/all
public class MAIItems: MAIItem, SwiftAutomation.MultipleObjectSpecifierExtension {}

// App/Con/Its
public class MAIRoot: SwiftAutomation.RootSpecifier, MAIObject, SwiftAutomation.RootSpecifierExtension {
    public typealias InsertionSpecifierType = MAIInsertion
    public typealias ObjectSpecifierType = MAIItem
    public typealias MultipleObjectSpecifierType = MAIItems
    public override class var untargetedAppData: SwiftAutomation.AppData { return _untargetedAppData }
}

// Application
public class Mail: MAIRoot, SwiftAutomation.Application {
    public convenience init(launchOptions: SwiftAutomation.LaunchOptions = SwiftAutomation.DefaultLaunchOptions, relaunchMode: SwiftAutomation.RelaunchMode = SwiftAutomation.DefaultRelaunchMode) {
        self.init(rootObject: SwiftAutomation.AppRootDesc, appData: Swift.type(of:self).untargetedAppData.targetedCopy(
                  .bundleIdentifier("com.apple.mail", true), launchOptions: launchOptions, relaunchMode: relaunchMode))
    }
}

// App/Con/Its root objects used to construct untargeted specifiers; these can be used to construct specifiers for use in commands, though cannot send commands themselves

public let MAIApp = _untargetedAppData.app as! MAIRoot
public let MAICon = _untargetedAppData.con as! MAIRoot
public let MAIIts = _untargetedAppData.its as! MAIRoot


/******************************************************************************/
// Static types

public typealias MAIRecord = [MAISymbol:Any] // default Swift type for AERecordDescs







