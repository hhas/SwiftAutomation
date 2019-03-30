//
//  AEConstants.swift
//  SwiftAutomation
//
//

import Carbon


/******************************************************************************/
// extra constant definitions

// valid OSTypes should always be non-zero, so use 0 rather than nil to indicate omitted OSType, avoiding need for Optional<> boxing/unboxing
let noOSType: OSType = 0 

// kAEInheritedProperties isn't defined in OpenScripting.h for some reason
let kAEInheritedProperties: OSType = 0x6340235e // 'c@#^'

// AEM doesn't define codes for '!=' or 'in' operators in test clauses, so define pseudo-codes to represent these
let kAENotEquals: OSType       = 0x00000001 // packs as kAEEquals + kAENOT
let kAEIsIn: OSType            = 0x00000002 // packs as kAEContains with operands reversed


/******************************************************************************/
// prepacked seld constants

// insertion locations
let kAEBeginningDesc           = AEDesc(enumCode: kAEBeginning)
let kAEEndDesc                 = AEDesc(enumCode: kAEEnd)
let kAEBeforeDesc              = AEDesc(enumCode: kAEBefore)
let kAEAfterDesc               = AEDesc(enumCode: kAEAfter)
// absolute positions
let kAEFirstDesc               = AEDesc(type: typeAbsoluteOrdinal, code: OSType(kAEFirst))
let kAEMiddleDesc              = AEDesc(type: typeAbsoluteOrdinal, code: OSType(kAEMiddle))
let kAELastDesc                = AEDesc(type: typeAbsoluteOrdinal, code: OSType(kAELast))
let kAEAnyDesc                 = AEDesc(type: typeAbsoluteOrdinal, code: OSType(kAEAny))
let kAEAllDesc                 = AEDesc(type: typeAbsoluteOrdinal, code: OSType(kAEAll))
// relative positions
let kAEPreviousDesc            = AEDesc(enumCode: OSType(kAEPrevious))
let kAENextDesc                = AEDesc(enumCode: OSType(kAENext))

