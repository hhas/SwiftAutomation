//
//  AEGlue.swift
//  SwiftAE
//
//  Default glue for controlling any Apple event-aware process using raw four-char codes only.
//
//

import Foundation


private let specifierFormatter = SpecifierFormatter(applicationClassName: "AEApplication", classNamePrefix: "AE")


public typealias AESymbol = Symbol // TO DO: define standard types and enums on Symbol class? (would be preferred, but glue generator will need to know exactly what they are and how to override/ignore/deconflict app-defined terms)


// App-specific terms

public protocol AECommand: SpecifierProtocol {} // provides AE dispatch methods

extension AECommand {}



public protocol AEQuery: ObjectSpecifierExtension, AECommand {} // provides vars and methods for constructing specifiers

extension AEQuery {}


// App-specific Specifier classes

public class AEInsertion: InsertionSpecifier, AECommand {}

public class AEObject: ObjectSpecifier, AEQuery {
    // typealiases used by ObjectSpecifierExtension to return glue-defined types
    public typealias InsertionSpecifierType = AEInsertion
    public typealias ObjectSpecifierType = AEObject
    public typealias ElementsSpecifierType = AEElements
}

public class AEElements: ElementsSpecifier, AEQuery, ElementsSpecifierExtension { // TO DO: use `public class AEElements: AEObject, ElementsSpecifierExtension`? (i.e. is there any point in keeping ElementsSpecifier base class, now that all its functionality has moved to protocol extension?)
    public typealias InsertionSpecifierType = AEInsertion
    public typealias ObjectSpecifierType = AEObject
    public typealias ElementsSpecifierType = AEElements
}

public class AERoot: RootSpecifier, AEQuery {
    public typealias InsertionSpecifierType = AEInsertion
    public typealias ObjectSpecifierType = AEObject
    public typealias ElementsSpecifierType = AEElements

    override class var glueInfo: GlueInfo {
        return GlueInfo(insertionSpecifierType: AEInsertion.self, objectSpecifierType: AEObject.self,
                        elementsSpecifierType: AEElements.self, symbolType: Symbol.self,
                        appRoot: AEApp, conRoot: AECon, itsRoot: AEIts, formatter: specifierFormatter)
    }
}

// Application class used to construct targeted specifiers and commands

public class AEApplication: Application, AEQuery {
    public typealias InsertionSpecifierType = AEInsertion
    public typealias ObjectSpecifierType = AEObject
    public typealias ElementsSpecifierType = AEElements
    
    override class var glueInfo: GlueInfo { return AERoot.glueInfo }
}

// App/Con/Its root objects used to construct untargeted specifiers; these can be used to construct specifiers for use in commands, though cannot send commands themselves

public let AEApp = AERoot(rootObject: AppRootDesc, appData: nil)
public let AECon = AERoot(rootObject: ConRootDesc, appData: nil)
public let AEIts = AERoot(rootObject: ItsRootDesc, appData: nil)

