//
//  AEGlue.swift
//  SwiftAE
//
//  Default glue for controlling any Apple event-aware process using raw four-char codes.
//
//

import Foundation


typealias AESymbol = Symbol // TO DO: define standard types and enums on Symbol class? (would be preferred, but glue generator will need to know exactly what they are and how to override/ignore/deconflict app-defined terms)


// App-specific terms

protocol AECommand: SpecifierProtocol {} // provides AE dispatch methods

extension AECommand {
    // TO DO: add default command methods (run, open, quit, etc) here (these should call appData.sendAppleEvent())
}



protocol AEQuery: ObjectSpecifierExtension, AECommand {} // provides vars and methods for constructing specifiers

extension AEQuery {
    // TO DO: add default (if any) property and elements getters
}


// App-specific Specifier classes

public class AEInsertion: InsertionSpecifier, AECommand {}

public class AEObject: ObjectSpecifier, AEQuery {
    // typealiases used by ObjectSpecifierExtension to return glue-defined types
    public typealias InsertionSpecifierType = AEInsertion
    public typealias ObjectSpecifierType = AEObject
    public typealias ElementsSpecifierType = AEElements
}

public class AEElements: ElementsSpecifier, AEQuery, ElementsSpecifierExtension { // TO DO: use `public class AEElements: AEObject, ElementsSpecifierExtension`?
    public typealias InsertionSpecifierType = AEInsertion
    public typealias ObjectSpecifierType = AEObject
    public typealias ElementsSpecifierType = AEElements
}

public class AERoot: RootSpecifier, AEQuery {
    public typealias InsertionSpecifierType = AEInsertion
    public typealias ObjectSpecifierType = AEObject
    public typealias ElementsSpecifierType = AEElements
}

public class AEApplication: Application, AEQuery {
    public typealias InsertionSpecifierType = AEInsertion
    public typealias ObjectSpecifierType = AEObject
    public typealias ElementsSpecifierType = AEElements
    
    override class var glueTypes: GlueTypes {
        return GlueTypes(insertionSpecifierType: AEInsertion.self,
                         objectSpecifierType: AEObject.self,
                         elementsSpecifierType: AEElements.self,
                         rootSpecifierType: AERoot.self,
                         symbolType: Symbol.self,
                         appRoot: AEApp,
                         conRoot: AECon,
                         itsRoot: AEIts)
    }
}

// standard root objects used to construct untargeted specifiers; these can be used to construct specifiers for use in commands, though cannot send commands themselves
let AEApp = AERoot(rootObject: AppRootDesc, appData: nil)
let AECon = AERoot(rootObject: ConRootDesc, appData: nil)
let AEIts = AERoot(rootObject: ItsRootDesc, appData: nil)



