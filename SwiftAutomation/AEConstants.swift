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
// prepacked constants

let typePropertyDesc           = NSAppleEventDescriptor(typeCode: typeProperty)
// selector forms
let formPropertyDesc           = NSAppleEventDescriptor(enumCode: OSType(formPropertyID)) // specifier.NAME or specifier.property(CODE)
let formUserPropertyDesc       = NSAppleEventDescriptor(enumCode: OSType(formUserPropertyID)) // specifier.userProperty(NAME)
let formAbsolutePositionDesc   = NSAppleEventDescriptor(enumCode: OSType(formAbsolutePosition)) // specifier[IDX] or specifier.first/middle/last/any
let formNameDesc               = NSAppleEventDescriptor(enumCode: OSType(formName)) // specifier[NAME] or specifier.named(NAME)
let formUniqueIDDesc           = NSAppleEventDescriptor(enumCode: OSType(formUniqueID)) // specifier.ID(UID)
let formRelativePositionDesc   = NSAppleEventDescriptor(enumCode: OSType(formRelativePosition)) // specifier.before/after(SYMBOL)
let formRangeDesc              = NSAppleEventDescriptor(enumCode: OSType(formRange)) // specifier[FROM,TO]
let formTestDesc               = NSAppleEventDescriptor(enumCode: OSType(formTest)) // specifier[TEST]
// insertion locations
let kAEBeginningDesc           = NSAppleEventDescriptor(enumCode: kAEBeginning)
let kAEEndDesc                 = NSAppleEventDescriptor(enumCode: kAEEnd)
let kAEBeforeDesc              = NSAppleEventDescriptor(enumCode: kAEBefore)
let kAEAfterDesc               = NSAppleEventDescriptor(enumCode: kAEAfter)
// absolute positions
let kAEFirstDesc               = NSAppleEventDescriptor(type: typeAbsoluteOrdinal, code: OSType(kAEFirst))
let kAEMiddleDesc              = NSAppleEventDescriptor(type: typeAbsoluteOrdinal, code: OSType(kAEMiddle))
let kAELastDesc                = NSAppleEventDescriptor(type: typeAbsoluteOrdinal, code: OSType(kAELast))
let kAEAnyDesc                 = NSAppleEventDescriptor(type: typeAbsoluteOrdinal, code: OSType(kAEAny))
let kAEAllDesc                 = NSAppleEventDescriptor(type: typeAbsoluteOrdinal, code: OSType(kAEAll))
// relative positions
let kAEPreviousDesc            = NSAppleEventDescriptor(enumCode: OSType(kAEPrevious))
let kAENextDesc                = NSAppleEventDescriptor(enumCode: OSType(kAENext))


// comparison tests
let kAELessThanDesc            = NSAppleEventDescriptor(enumCode: kAELessThan)
let kAELessThanEqualsDesc      = NSAppleEventDescriptor(enumCode: kAELessThanEquals)
let kAEEqualsDesc              = NSAppleEventDescriptor(enumCode: kAEEquals)
let kAENotEqualsDesc           = NSAppleEventDescriptor(enumCode: kAENotEquals) // pack as !(op1==op2)
let kAEGreaterThanDesc         = NSAppleEventDescriptor(enumCode: kAEGreaterThan)
let kAEGreaterThanEqualsDesc   = NSAppleEventDescriptor(enumCode: kAEGreaterThanEquals)
// containment tests
let kAEBeginsWithDesc          = NSAppleEventDescriptor(enumCode: kAEBeginsWith)
let kAEEndsWithDesc            = NSAppleEventDescriptor(enumCode: kAEEndsWith)
let kAEContainsDesc            = NSAppleEventDescriptor(enumCode: kAEContains)
let kAEIsInDesc                = NSAppleEventDescriptor(enumCode: kAEIsIn) // pack d as op2.contains(op1)
// logic tests
let kAEANDDesc                 = NSAppleEventDescriptor(enumCode: OSType(kAEAND))
let kAEORDesc                  = NSAppleEventDescriptor(enumCode: OSType(kAEOR))
let kAENOTDesc                 = NSAppleEventDescriptor(enumCode: OSType(kAENOT))

