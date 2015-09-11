//
//  TextEditGlue.swift
// 
//  note: this example glue is manually-constructed and incomplete, and included here for design and testing purposes only; once glue design is finalized, app-specific glue files will be code-generated via CLI tool
//


import Foundation


// Symbol

public class TEDSymbol: Symbol {
    // define app-specific type, enum, and property class getters here
    
    static let name = TEDSymbol(name: "name", code: 0x706e616d, type: typeType) // 'pnam'
    
    // TO DO: add rest of app-specific types, and override symbol() class methods to return predefined instances where available (note: possible problem with implementing standard symbols on Symbol superclass is that they won't use glue's own symbol class - this could cause more confusion than it avoids, in which case it'll be simplest just to define all known symbols, both standard and app-defined, on glue's symbol class each time)
}


// App-specific terms

protocol TEDCommand: SpecifierProtocol {} // provides AE dispatch methods

extension TEDCommand {
    
    // TO DO: add rest of command methods
    
    func get(directParameter: AnyObject = NoParameter,
             waitReply: Bool = true, withTimeout: NSTimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        guard let appData = self.appData else { throw SwiftAEError(code: 1, message: "Generic specifiers can't send Apple events.") }
        return try appData.sendAppleEvent("get", eventClass: 0x636f7265, eventID: 0x67657464,
                           parentSpecifier: (self as! Specifier),
                           directParameter: directParameter,
                           keywordParameters: [],
                           requestedType: nil, // event's `as` parameter, if any // TO DO: how to deal with this? would it be simpler just to include `as` parameter in default(?) `get` command definition (Q. are there any other commands where it might be accepted?); need to check what AS does - if it includes it in any command that has an `as` coercion applied to its result, make `requestedType` a standard arg in all glue-defined commands
                           waitReply: waitReply,
                           sendOptions: nil, // TO DO: as with requestedType, decide if this should be standard arg in all glue-defined commands
                           withTimeout: withTimeout,
                           considering: considering,
                           asType: Any.self)
    }
    
    // TO DO: generic versions of application commands currently aren't usable due to problems getting AppData's generic unpack() methods to behave correctly, which in turn is only an issue because Swift's type introspection support is currently too crappy to control unpacking via type introspection (which wouldd be the simplest, cleanest, and most flexible way to do it)
    /*
    func get<T>(directParameter: AnyObject = NoParameter,
             waitReply: Bool = true, withTimeout: NSTimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        guard let appData = self.appData else { throw SwiftAEError(code: 1, message: "Generic specifiers can't send Apple events.") }
        return try appData.sendAppleEvent("get", eventClass: 0x636f7265, eventID: 0x67657464,
                           parentSpecifier: (self as! Specifier),
                           directParameter: directParameter,
                           keywordParameters: [],
                           requestedType: nil, // event's `as` parameter, if any // TO DO: how to deal with this? would it be simpler just to include `as` parameter in default(?) `get` command definition (Q. are there any other commands where it might be accepted?); need to check what AS does - if it includes it in any command that has an `as` coercion applied to its result, make `requestedType` a standard arg in all glue-defined commands
                           waitReply: waitReply,
                           sendOptions: nil, // TO DO: as with requestedType, decide if this should be standard arg in all glue-defined commands
                           withTimeout: withTimeout,
                           considering: considering,
                           asType: T.self)
    }
    */
    
    func set(directParameter: AnyObject = NoParameter,
             to: AnyObject = NoParameter,
             waitReply: Bool = true, withTimeout: NSTimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> Any {
        guard let appData = self.appData else { throw SwiftAEError(code: 1, message: "Generic specifiers can't send Apple events.") }
        return try appData.sendAppleEvent("set", eventClass: 0x636f7265, eventID: 0x73657464,
                           parentSpecifier: (self as! Specifier),
                           directParameter: directParameter,
                           keywordParameters: [
                               ("to", 0x64617461, to),
                           ],
                           requestedType: nil,
                           waitReply: waitReply,
                           sendOptions: nil,
                           withTimeout: withTimeout,
                           considering: considering,
                           asType: Any.self)
    }

    /*
    func set<T>(directParameter: AnyObject = NoParameter,
             to: AnyObject = NoParameter,
             waitReply: Bool = true, withTimeout: NSTimeInterval? = nil, considering: ConsideringOptions? = nil) throws -> T {
        guard let appData = self.appData else { throw SwiftAEError(code: 1, message: "Generic specifiers can't send Apple events.") }
        return try appData.sendAppleEvent("set", eventClass: 0x636f7265, eventID: 0x73657464,
                           parentSpecifier: (self as! Specifier),
                           directParameter: directParameter,
                           keywordParameters: [
                               ("to", 0x64617461, to),
                           ],
                           requestedType: nil,
                           waitReply: waitReply,
                           sendOptions: nil,
                           withTimeout: withTimeout,
                           considering: considering,
                           asType: T.self)
    }
    */
}



protocol TEDQuery: ObjectSpecifierExtension, TEDCommand {} // provides vars and methods for constructing specifiers

extension TEDQuery {
    
    // Properties
    
    var bounds: TEDObject {return self.property(0x70626e64) as! TEDObject}
    var class_: TEDObject {return self.property(0x70636c73) as! TEDObject}
    var closeable: TEDObject {return self.property(0x68636c62) as! TEDObject}
    var collating: TEDObject {return self.property(0x6c77636c) as! TEDObject}
    var color: TEDObject {return self.property(0x636f6c72) as! TEDObject}
    var copies: TEDObject {return self.property(0x6c776370) as! TEDObject}
    var document: TEDObject {return self.property(0x646f6375) as! TEDObject}
    var endingPage: TEDObject {return self.property(0x6c776c70) as! TEDObject}
    var errorHandling: TEDObject {return self.property(0x6c776568) as! TEDObject}
    var faxNumber: TEDObject {return self.property(0x6661786e) as! TEDObject}
    var fileName: TEDObject {return self.property(0x6174666e) as! TEDObject}
    var floating: TEDObject {return self.property(0x6973666c) as! TEDObject}
    var font: TEDObject {return self.property(0x666f6e74) as! TEDObject}
    var frontmost: TEDObject {return self.property(0x70697366) as! TEDObject}
    var id: TEDObject {return self.property(0x49442020) as! TEDObject}
    var index: TEDObject {return self.property(0x70696478) as! TEDObject}
    var miniaturizable: TEDObject {return self.property(0x69736d6e) as! TEDObject}
    var miniaturized: TEDObject {return self.property(0x706d6e64) as! TEDObject}
    var modal: TEDObject {return self.property(0x706d6f64) as! TEDObject}
    var modified: TEDObject {return self.property(0x696d6f64) as! TEDObject}
    var name: TEDObject {return self.property(0x706e616d) as! TEDObject}
    var pagesAcross: TEDObject {return self.property(0x6c776c61) as! TEDObject}
    var pagesDown: TEDObject {return self.property(0x6c776c64) as! TEDObject}
    var path: TEDObject {return self.property(0x70707468) as! TEDObject}
    var properties: TEDObject {return self.property(0x70414c4c) as! TEDObject}
    var requestedPrintTime: TEDObject {return self.property(0x6c777174) as! TEDObject}
    var resizable: TEDObject {return self.property(0x7072737a) as! TEDObject}
    var size: TEDObject {return self.property(0x7074737a) as! TEDObject}
    var startingPage: TEDObject {return self.property(0x6c776670) as! TEDObject}
    var targetPrinter: TEDObject {return self.property(0x74727072) as! TEDObject}
    var titled: TEDObject {return self.property(0x70746974) as! TEDObject}
    var version_: TEDObject {return self.property(0x76657273) as! TEDObject}
    var visible: TEDObject {return self.property(0x70766973) as! TEDObject}
    var zoomable: TEDObject {return self.property(0x69737a6d) as! TEDObject}
    var zoomed: TEDObject {return self.property(0x707a756d) as! TEDObject}
    
    // Elements
    
    var applications: TEDElements {return self.elements(0x63617070) as! TEDElements}
    var attachment: TEDElements {return self.elements(0x61747473) as! TEDElements}
    var attributeRuns: TEDElements {return self.elements(0x63617472) as! TEDElements}
    var characters: TEDElements {return self.elements(0x63686120) as! TEDElements}
    var colors: TEDElements {return self.elements(0x636f6c72) as! TEDElements}
    var documents: TEDElements {return self.elements(0x646f6375) as! TEDElements}
    var items: TEDElements {return self.elements(0x636f626a) as! TEDElements}
    var paragraphs: TEDElements {return self.elements(0x63706172) as! TEDElements}
    var printSettings: TEDElements {return self.elements(0x70736574) as! TEDElements}
    var text: TEDElements {return self.elements(0x63747874) as! TEDElements}
    var windows: TEDElements {return self.elements(0x6377696e) as! TEDElements}
    var words: TEDElements {return self.elements(0x63776f72) as! TEDElements}

}


// TO DO: how to implement glue-specific hook for SpecifierFormatter? (currently Specifier.description always returns raw four-char code representation; glue-defined property and elements names are not shown)


// App-specific Specifier classes

public class TEDInsertion: InsertionSpecifier, TEDCommand {
}

public class TEDObject: ObjectSpecifier, TEDQuery {
    public typealias InsertionSpecifierType = TEDInsertion
    public typealias ObjectSpecifierType = TEDObject
    public typealias ElementsSpecifierType = TEDElements
}

public class TEDElements: ElementsSpecifier, TEDQuery, ElementsSpecifierExtension {
    public typealias InsertionSpecifierType = TEDInsertion
    public typealias ObjectSpecifierType = TEDObject
    public typealias ElementsSpecifierType = TEDElements
}

public class TEDRoot: RootSpecifier, TEDQuery {
    public typealias InsertionSpecifierType = TEDInsertion
    public typealias ObjectSpecifierType = TEDObject
    public typealias ElementsSpecifierType = TEDElements
}

public class TextEdit: Application, TEDQuery {
    public typealias InsertionSpecifierType = TEDInsertion
    public typealias ObjectSpecifierType = TEDObject
    public typealias ElementsSpecifierType = TEDElements
    
    // default constructor for TextEdit object; this locates app using bundle ID supplied by glue generator
    public convenience init(launchOptions: LaunchOptions = DefaultLaunchOptions, relaunchMode: RelaunchMode = DefaultRelaunchMode) {
        self.init(bundleIdentifier: "com.apple.TextEdit", launchOptions: launchOptions, relaunchMode: relaunchMode)
    }
        
    override class var glueTypes: GlueTypes {
        return GlueTypes(insertionSpecifierType: TEDInsertion.self,
                         objectSpecifierType: TEDObject.self,
                         elementsSpecifierType: TEDElements.self,
                         rootSpecifierType: TEDRoot.self,
                         symbolType: TEDSymbol.self,
                         appRoot: TEDApp,
                         conRoot: TEDCon,
                         itsRoot: TEDIts)
    }
}

// standard root objects used to construct untargeted specifiers; these can be used to construct specifiers for use in commands, though cannot send commands themselves
let TEDApp = TEDRoot(rootObject: AppRootDesc, appData: nil)
let TEDCon = TEDRoot(rootObject: ConRootDesc, appData: nil)
let TEDIts = TEDRoot(rootObject: ItsRootDesc, appData: nil)






