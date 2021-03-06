//
//  SwiftGlueTemplate.swift
//  SwiftAutomation
//
//


let SwiftGlueTemplate = """
//
//  «GLUE_NAME»
//  «APPLICATION_NAME» «APPLICATION_VERSION»
//  «FRAMEWORK_NAME» «FRAMEWORK_VERSION»
//  `«AEGLUE_COMMAND»`
//


import Foundation
import AppleEvents
«IMPORT_SWIFTAE»


/******************************************************************************/
// Create an untargeted AppData instance for use in App, Con, Its roots,
// and in Application initializers to create targeted AppData instances.

private let _specifierFormatter = «SWIFTAE»SpecifierFormatter(
        applicationClassName: "«APPLICATION_CLASS_NAME»",
        classNamePrefix: "«PREFIX»",
        typeNames: [«+TYPE_FORMATTER»
                «CODE»: "«NAME»", // «CODE_STR»«-TYPE_FORMATTER»
        ],
        propertyNames: [«+PROPERTY_FORMATTER»
                «CODE»: "«NAME»", // «CODE_STR»«-PROPERTY_FORMATTER»
        ],
        elementsNames: [«+ELEMENTS_FORMATTER»
                «CODE»: ("«SINGULAR_NAME»", "«PLURAL_NAME»"), // «CODE_STR»«-ELEMENTS_FORMATTER»
        ])

private let _glueClasses = «SWIFTAE»GlueClasses(
                                                insertionSpecifierType: «PREFIX»Insertion.self,
                                                objectSpecifierType: «PREFIX»Item.self,
                                                multiObjectSpecifierType: «PREFIX»Items.self,
                                                rootSpecifierType: «PREFIX»Root.self,
                                                applicationType: «APPLICATION_CLASS_NAME».self,
                                                symbolType: «PREFIX»Symbol.self,
                                                formatter: _specifierFormatter)

private let _untargetedAppData = «SWIFTAE»AppData(glueClasses: _glueClasses)


/******************************************************************************/
// Symbol subclass defines static type/enum/property constants based on «APPLICATION_NAME» terminology

public class «PREFIX»Symbol: «SWIFTAE»Symbol {

    override public var typeAliasName: String {return "«PREFIX»"}

    public override class func symbol(code: OSType, type: OSType = typeType, descriptor: ScalarDescriptor? = nil) -> «PREFIX»Symbol {
        switch (code) {«+SYMBOL_SWITCH»
        case «CODE»: return self.«NAME» // «CODE_STR»«-SYMBOL_SWITCH»
        default: return super.symbol(code: code, type: type, descriptor: descriptor) as! «PREFIX»Symbol
        }
    }

    // Types/properties«+TYPE_SYMBOL»
    public static let «NAME» = «PREFIX»Symbol(name: "«NAME»", code: «CODE», type: typeType) // «CODE_STR»«-TYPE_SYMBOL»

    // Enumerators«+ENUM_SYMBOL»
    public static let «NAME» = «PREFIX»Symbol(name: "«NAME»", code: «CODE», type: typeEnumerated) // «CODE_STR»«-ENUM_SYMBOL»
}

public typealias «PREFIX» = «PREFIX»Symbol // allows symbols to be written as (e.g.) «PREFIX».name instead of «PREFIX»Symbol.name


/******************************************************************************/
// Specifier extensions; these add command methods and property/elements getters based on «APPLICATION_NAME» terminology

public protocol «PREFIX»Command: «SWIFTAE»SpecifierProtocol {} // provides AE dispatch methods

// Command->Any will be bound when return type can't be inferred, else Command->T

extension «PREFIX»Command {«+COMMAND»
    @discardableResult public func «COMMAND_NAME»(_ directParameter: Any = «SWIFTAE»noParameter,«+PARAMETER»
            «NAME»: Any = «SWIFTAE»noParameter,«-PARAMETER»
            requestedType: «SWIFTAE»Symbol? = nil, waitReply: Bool = true, sendOptions: «SWIFTAE»SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: «SWIFTAE»ConsideringOptions? = nil) throws -> Any {
        return try self.appData.sendAppleEvent(name: "«COMMAND_NAME»", event: «EVENT_IDENTIFIER», // «EVENT_IDENTIFIER_STR»
                parentSpecifier: (self as! «SWIFTAE»Specifier), directParameter: directParameter, keywordParameters: [«+PARAMETER»
                    ("«NAME»", «CODE», «NAME»), // «CODE_STR»«-PARAMETER»
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }
    public func «COMMAND_NAME»<T>(_ directParameter: Any = «SWIFTAE»noParameter,«+PARAMETER»
            «NAME»: Any = «SWIFTAE»noParameter,«-PARAMETER»
            requestedType: «SWIFTAE»Symbol? = nil, waitReply: Bool = true, sendOptions: «SWIFTAE»SendOptions? = nil,
            withTimeout: TimeInterval? = nil, considering: «SWIFTAE»ConsideringOptions? = nil) throws -> T {
        return try self.appData.sendAppleEvent(name: "«COMMAND_NAME»", event: «EVENT_IDENTIFIER», // «EVENT_IDENTIFIER_STR»
                parentSpecifier: (self as! «SWIFTAE»Specifier), directParameter: directParameter, keywordParameters: [«+PARAMETER»
                    ("«NAME»", «CODE», «NAME»), // «CODE_STR»«-PARAMETER»
                ], requestedType: requestedType, waitReply: waitReply, sendOptions: sendOptions,
                withTimeout: withTimeout, considering: considering)
    }«-COMMAND»
}


public protocol «PREFIX»Object: «SWIFTAE»ObjectSpecifierExtension, «PREFIX»Command {} // provides vars and methods for constructing specifiers

extension «PREFIX»Object {

    // Properties«+PROPERTY_SPECIFIER»
    public var «NAME»: «PREFIX»Item {return self.property(«CODE») as! «PREFIX»Item} // «CODE_STR»«-PROPERTY_SPECIFIER»

    // Elements«+ELEMENTS_SPECIFIER»
    public var «NAME»: «PREFIX»Items {return self.elements(«CODE») as! «PREFIX»Items} // «CODE_STR»«-ELEMENTS_SPECIFIER»
}


/******************************************************************************/
// Specifier subclasses add app-specific extensions

// beginning/end/before/after
public class «PREFIX»Insertion: «SWIFTAE»InsertionSpecifier, «PREFIX»Command {}


// property/by-index/by-name/by-id/previous/next/first/middle/last/any
public class «PREFIX»Item: «SWIFTAE»ObjectSpecifier, «PREFIX»Object {
    public typealias InsertionSpecifierType = «PREFIX»Insertion
    public typealias ObjectSpecifierType = «PREFIX»Item
    public typealias MultipleObjectSpecifierType = «PREFIX»Items
}

// by-range/by-test/all
public class «PREFIX»Items: «PREFIX»Item, «SWIFTAE»MultipleObjectSpecifierExtension {}

// App/Con/Its
public class «PREFIX»Root: «SWIFTAE»RootSpecifier, «PREFIX»Object, «SWIFTAE»RootSpecifierExtension {
    public typealias InsertionSpecifierType = «PREFIX»Insertion
    public typealias ObjectSpecifierType = «PREFIX»Item
    public typealias MultipleObjectSpecifierType = «PREFIX»Items
    public override class var untargetedAppData: «SWIFTAE»AppData { return _untargetedAppData }
}

// Application
public class «APPLICATION_CLASS_NAME»: «PREFIX»Root, «SWIFTAE»Application {«+DEFAULT_INIT»
    public convenience init(launchOptions: «SWIFTAE»LaunchOptions = «SWIFTAE»defaultLaunchOptions, relaunchMode: «SWIFTAE»RelaunchMode = «SWIFTAE»defaultRelaunchMode) {
        self.init(rootObject: «SWIFTAE»appRootDesc, appData: Swift.type(of:self).untargetedAppData.targetedCopy(
                  .bundleIdentifier("«BUNDLE_IDENTIFIER»", true), launchOptions: launchOptions, relaunchMode: relaunchMode))
    }
«-DEFAULT_INIT»}

// App/Con/Its root objects used to construct untargeted specifiers; these can be used to construct specifiers for use in commands, though cannot send commands themselves

public let «PREFIX»App = _untargetedAppData.app as! «PREFIX»Root
public let «PREFIX»Con = _untargetedAppData.con as! «PREFIX»Root
public let «PREFIX»Its = _untargetedAppData.its as! «PREFIX»Root


/******************************************************************************/
// Static types

public typealias «PREFIX»Record = [«PREFIX»Symbol:Any] // default Swift type for AERecordDescs

«+TYPEALIAS_DEFINITION»
public typealias «ALIAS_NAME» = «TYPE_NAME»«-TYPEALIAS_DEFINITION»

«+ENUM_TYPE_DEFINITION»
public enum «ENUM_TYPE_NAME»: «SWIFTAE»SelfPacking, «SWIFTAE»SelfUnpacking {«+CASE_DEFINITION»
    case «CASE_NAME»(«CASE_TYPE»)«-CASE_DEFINITION»
    «+INIT_DEFINITION»
    public init(_ value: «CASE_TYPE») { self = .«CASE_NAME»(value) }«-INIT_DEFINITION»

    public func SwiftAutomation_packSelf(_ appData: «SWIFTAE»AppData) throws -> Descriptor {
        switch self {«+PACK_CASE»
        case .«CASE_NAME»(let value): return try appData.pack(value as Any)«-PACK_CASE»
        }
    }
    public static func SwiftAutomation_unpackSelf(_ desc: Descriptor, appData: «SWIFTAE»AppData) throws -> «ENUM_TYPE_NAME» {«+UNPACK_CASE»
        do { return .«CASE_NAME»(try appData.unpack(desc) as «CASE_TYPE») } catch {}«-UNPACK_CASE»
        throw «SWIFTAE»UnpackError(appData: appData, desc: desc, type: «ENUM_TYPE_NAME».self,
                          message: "Can't coerce descriptor to Swift type: \\(«ENUM_TYPE_NAME».self)")
    }
    public static func SwiftAutomation_noValue() throws -> «ENUM_TYPE_NAME» { «ENUM_NO_VALUE» }
}
«-ENUM_TYPE_DEFINITION»

«+RECORD_STRUCT_DEFINITION»
public struct «STRUCT_NAME»: «SWIFTAE»SelfPacking, «SWIFTAE»SelfUnpacking {

    public let class_ = «PREFIX»Symbol.«CLASS_NAME»«+RECORD_PROPERTY»
    public var «PROPERTY_NAME»: «PROPERTY_TYPE»«-RECORD_PROPERTY»

    private static func SwiftAutomation_unpackProperty<T>(_ recordDesc: Descriptor,
                                                          appData: «SWIFTAE»AppData, name: String, code: OSType) throws -> T {
        guard let desc = recordDesc.parameter(code) else {
            throw «SWIFTAE»UnpackError(appData: appData, desc: recordDesc, type: self, message: "Can't find '\\(name)' property in record.")
        }
        do {
            return try appData.unpack(desc)
        } catch {
            throw «SWIFTAE»UnpackError(appData: appData, desc: recordDesc, type: self, message: "Can't unpack record's '\\(name)' property: \\(error)")
        }
    }

    public func SwiftAutomation_packSelf(_ appData: «SWIFTAE»AppData) throws -> Descriptor {",
        // TO DO: trap and rethrow any packing errors with more details? (errors are unlikely here unless user has specified a property with an unsupported Swift type)

//        TO DO: UPDATE
//        let desc = AEDesc.record().coerce(to: self.class_.code)!«+PACK_PROPERTY»
//        desc.setParam(try appData.pack(self.«PROPERTY_NAME» as Any), forKeyword: «PROPERTY_CODE»)«-PACK_PROPERTY»
//        return desc

        throw AppleEventError(code: 1, message: "TO DO")
    
    }
    public static func SwiftAutomation_unpackSelf(_ desc: Descriptor, appData: «SWIFTAE»AppData) throws -> «STRUCT_NAME» {",

        throw AppleEventError(code: 1, message: "TO DO")
//        TO DO: see TODOs in AppleEvents
//        if !desc.isRecord {
//           throw «SWIFTAE»UnpackError(appData: appData, desc: desc, type: self, message: "Not a record.")
//        }
// TO DO: what if desc.type != self.class_.code? should the class property's value be changed, or an UnpackError reported? (doing nothing may be problematic as the record won't roundtrip correctly... although roundtripping isn't guaranteed to work anyway if the record doesn't include all of the properties expected by the application (as described in the original dictionary definition))
//        return «STRUCT_NAME»(«+UNPACK_PROPERTY»
//            «PROPERTY_NAME»: try self.SwiftAutomation_unpackProperty(desc, appData: appData, name: "«PROPERTY_NAME»", code: «PROPERTY_CODE»)«-UNPACK_PROPERTY»
//        )
    }
    public static func SwiftAutomation_noValue() throws -> «STRUCT_NAME» { throw AutomationError(code: -1708) }
}«-RECORD_STRUCT_DEFINITION»

"""


