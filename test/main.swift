//
//  main.swift
//  SwiftAutomation
//
//  tests // TO DO: move ad-hoc tests to separate target; replace this with examples of use
//
//  TO DO: test `all` selector works correctly (should convert property specifier to all-elements specifier, return all-elements specifier as-is, and report send-time error if called on anything else)
//

import AppKit
import Foundation
import SwiftAutomation


let te = TextEdit()

/*
do {
    // simple pack/unpack data test
 
    let c = te.appData
    do {
        let seq = [1, 2, 3]
        let desc = try c.pack(seq)
        print(try c.unpack(desc, returnType: [String].self))
    }
    /*
    do {
        let seq = [AE.id:0, AE.point:4, AE.version:9]
        let desc = try c.pack(seq)
        print(try c.unpack(desc, returnType: [Symbol:Int].self))
    }*/
    
} catch {print("ERROR: \(error)")}

print("\n\n")
*/

do {
    do {
        let v = try te.appData.pack(true)
        print(v, try te.appData.unpack(v))
    }
    do {
        let v = try te.appData.pack(NSNumber(value: true))
        print(v,try te.appData.unpack(v))
    }
    do {
        let v = try te.appData.pack(-25)
        print(v, try te.appData.unpack(v))
    }
    do {
        let v = try te.appData.pack(NSNumber(value: -25))
        print(v,try te.appData.unpack(v))
    }
    do {
        let v = try te.appData.pack(4.12)
        print(v, try te.appData.unpack(v))
    }
    do {
        let v = try te.appData.pack(NSNumber(value: 4.12))
        print(v,try te.appData.unpack(v))
    }
    
    
    let itunes = ITunes()
    let state: ITU = try itunes.playerState.get()
    print("itunes.playerState.get() -> \(state)")
//    try ITunes().play()
    
    
//    print("// Specifier.description: \(TEDApp.documents[1].text)")
//    print("// Specifier.description: \(te.documents[1].text)")
    
    
    // send `open` and `get` AEs using raw four-char codes
    //let result = try te.sendAppleEvent(kCoreEventClass, kAEOpenDocuments, [keyDirectObject:NSURL.fileURLWithPath("/Users/has/todos.txt")])
    //print(result)

    
    print("TEST: make new document with properties {text: \"Hello World!\"}")
    let teDoc: TEDItem = try te.make(new: TED.document, withProperties: [TED.text: "Hello World!"])
    print("=> \(teDoc)")
    print("TEST: get text of teDoc")
    print(try teDoc.text.get())

    /*
/*
    
    // get name of document 1
    
    // - using four-char code strings
    let result2 = try te.sendAppleEvent("core", "getd", ["----": te.elements("docu")[1].property("pnam")])
    print(result2)
    
    // - using glue-defined terminology
    let result3 = try te.get(TEDApp.documents[1].name)
    print(result3)
    
    let result3a: Any = try te.documents[1].name.get() // convenience syntax for the above
    print(result3a)
    
    
    // get name of document 1 -- this works, returning a string value
    print("\nTEST: TextEdit().documents[1].name.get() as String")
    let result5: String = try te.documents[1].name.get()
    print("=> \(result5)")
    
    // get name of every document
    
    print("\nTEST: TextEdit().documents.name.get() as Any")
    let result4b = try te.documents.name.get() as Any
    print("=> \(result4b)")
    
    // get name of every document
    print("\nTEST: TextEdit().documents.name.get() as [String]")
    let result4 = try te.documents.name.get() as [String] // unpack the `get` command's result as Array of String
    print("=> \(result4)")
    
    // same as above
    let result6: [String] = try te.documents.name.get()
    print("=> \(result6)")
    
    
    // get every file of folder "Documents" of home whose name extension is "txt" and modification date > date "01:30 Jan 1, 2001 UTC"
    let date = Date(timeIntervalSinceReferenceDate:5400) // 1:30am on 1 Jan 2001 (UTC)
    print("\nTEST: Finder().home.folders[\"Documents\"].files[FINIts.nameExtension == \"txt\" && FINIts.modificationDate > DATE].name.get()")
    let q = Finder().home.folders["Documents"].files[FINIts.nameExtension == "txt" && FINIts.modificationDate > date].name
    print("// \(q)")
    let result4a = try q.get()
    print("=> \(result4a)")
    */
    
    print("\nTEST: Finder().home.folders[\"Documents\"].files[FINIts.nameExtension == \"txt\"].properties.get()")
    let result4c = try Finder().home.folders["Documents"].files[FINIts.nameExtension == "txt"].properties.get() as [[FINSymbol:Any]]
    print("=> \(result4c)")
    
    print("\nTEST: duplicate file 1 of home to desktop with replacing")
    let myresult = try Finder().duplicate(Finder().home.files[1], to:Finder().desktop, replacing:true)
    print("=> \(myresult)")
    
     
    print("\nTEST: TextEdit().documents.properties.get() as [TEDDocumentRecord]")
    let result4d = try TextEdit().documents.properties.get() as [TEDDocumentRecord]
    print("=> \(result4d)")
    
    print("\nTEST: TextEdit().documents[1].properties.get() as TEDDocumentRecord")
    let result4e = try TextEdit().documents[1].properties.get() as TEDDocumentRecord
    print("=> \(result4e)")
    
//    try te.documents.close(saving: TED.no) // close every document saving no
    
    //struct X {}; try teDoc.text.set(to: X())
    
    //
    try teDoc.close(saving: TED.no)
    
    
    print("\nTEST: get files 1 thru 3 of home")
    let r = try Finder().home.files[1, 3].get() as [FINItem]
    print("=> \(r)")
    
    */
} catch {
    print("ERROR: \(error)")
}



/*


// test Swift<->AE type conversions
let c = AEApplication.currentApplication().appData

//let lst = try c.pack([1,2,3])
//print(try c.unpack(lst))

do {
    /*
//print(try c.pack("hello"))
print("PACK AS BOOLEAN")

print("\(try c.pack(true)) \(formatFourCharCodeString(try c.pack(true).descriptorType))")
print("\(try c.pack(NSNumber(bool: true))) \(formatFourCharCodeString(try c.pack(NSNumber(bool: true)).descriptorType))")
print("")
print("PACK AS INTEGER")
print("\(try c.pack(3)) \(formatFourCharCodeString(try c.pack(3).descriptorType))")
print("\(try c.pack(NSNumber(int: 3))) \(formatFourCharCodeString(try c.pack(NSNumber(int: 3)).descriptorType))")
print("")
print("PACK AS DOUBLE")
print("\(try c.pack(3.1)) \(formatFourCharCodeString(try c.pack(3.1).descriptorType))")
print("\(try c.pack(NSNumber(double: 3.1))) \(formatFourCharCodeString(try c.pack(NSNumber(double: 3.1)).descriptorType))")
*/
    
    do {
        let seq = [1, 2, 3]
        let desc = try c.pack(seq)
        print(try c.unpack(desc, returnType: [Int].self))
    }
    do {
        let seq = [AE.id:0, AE.point:4, AE.version:9]
        let desc = try c.pack(seq)
        print(try c.unpack(desc, returnType: [AESymbol:Int].self))
    }
    
} catch {print("ERROR: \(error)")}
    

//NSLog("%08X", try c.pack(true).descriptorType) // 0x626F6F6C = typeBoolean

//print(c)


*/


 

/*
let finder = AEApplication(name: "Finder")


do {
let result = try finder.sendAppleEvent(kAECoreSuite, kAEGetData,
    [keyDirectObject:finder.property("home").elements("cobj")])
print("\n\nRESULT1: \(result)")
} catch {
print("\n\nERROR1: \(error)")
}
let f = URL(fileURLWithPath:"/Users/Shared")

do {
let result = try finder.sendAppleEvent(kAECoreSuite, kAEGetData, [keyDirectObject: AEApp.elements(cObject)[f]])
    print("RAW: \(result)")
} catch {
    print("\n\nERROR: \(error)")
}
do {
let result = try finder.sendAppleEvent(kAECoreSuite, kAEGetData, [keyDirectObject: AEApp.elements(cFile)[f]]) // Finder will throw error as f is a folder, not a file
    print("RAW: \(result)")
} catch {
    print("\n\nERROR: \(error)")
}
*/

/*
do {
    let result: AESpecifier = try finder.sendAppleEvent(kAECoreSuite, kAEGetData,
        [keyDirectObject:finder.elements(cFile)[NSURL.fileURLWithPath("/Users/has/entoli - defining pairs.txt")]])
    print("\n\nRESULT1: \(result)")
} catch {
print("\n\nERROR1: \(error)")
}
do {
    let result = try finder.sendAppleEvent(kAECoreSuite, kAEGetData,
        [keyDirectObject:finder.elements(cFile)[NSURL.fileURLWithPath("/Users/has/entoli - defining pairs.txt")]])
    print("\n\nRESULT2: \(result)")
} catch {
print("\n\nERROR2: \(error)")
}


do {
    let result: AESpecifier = try finder.sendAppleEvent("core", "getd",
        ["----":finder.elements(cFile)[NSURL.fileURLWithPath("/Users/has/entoli - defining pairs.txt")]])
    print("\n\nRESULT3: \(result)")
} catch {
print("\n\nERROR3: \(error)")
}
do {
    let result = try finder.sendAppleEvent("core", "getd",
        ["----":finder.elements(cFile)[NSURL.fileURLWithPath("/Users/has/entoli - defining pairs.txt")]])
    print("\n\nRESULT4: \(result)")
} catch {
print("\n\nERROR4: \(error)")
}
*/

/*

do {
    let result: AESpecifier! = try finder.sendAppleEvent("core", "getd", // Can't unpack value as ImplicitlyUnwrappedOptional<Specifier>
        ["----":finder.elements(cFile)[NSURL.fileURLWithPath("/Users/has/entoli - defining pairs.txt")]])
    print("\n\nRESULT5: \(result)")
} catch {
    print("\n\nERROR5: \(error)")
}


do {
    let result: AESpecifier? = try finder.sendAppleEvent("core", "getd", // Can't unpack value as Optional<Specifier>
        ["----":finder.elements(cFile)[NSURL.fileURLWithPath("/Users/has/entoli - defining pairs.txt")]])
    print("\n\nRESULT6: \(result)")
} catch {
    print("\n\nERROR6: \(error)")
}

*/

print()


