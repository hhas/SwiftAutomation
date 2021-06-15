//
//  main.swift
//  SwiftAutomation
//
//  tests // TO DO: move ad-hoc tests to separate target; replace this with examples of use
//
//  TO DO: how to bring OS permission-to-automate dialogs to front when running this test? (they tend to get hidden behind Xcode, causing target app to block until AE times out)
//
//  TO DO: test `all` selector works correctly (should convert property specifier to all-elements specifier, return all-elements specifier as-is, and report send-time error if called on anything else)
//

import AppKit
import Foundation
import SwiftAutomation
import MacOSGlues


let textedit = TextEdit()


/*
do {
    // simple pack/unpack data test
 
    let c = textedit.appData
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

/*
do {
    // NSNumbers will always pack as Double as the least lossy option
    do {
        let v = try textedit.appData.pack(true)
        print(v, try textedit.appData.unpack(v))
    }
    do {
        let v = try textedit.appData.pack(NSNumber(value: true))
        print(v,try textedit.appData.unpack(v))
    }
    do {
        let v = try textedit.appData.pack(-25)
        print(v, try textedit.appData.unpack(v))
    }
    do {
        let v = try textedit.appData.pack(NSNumber(value: -25))
        print(v,try textedit.appData.unpack(v))
    }
    do {
        let v = try textedit.appData.pack(4.12)
        print(v, try textedit.appData.unpack(v))
    }
    do {
        let v = try textedit.appData.pack(NSNumber(value: 4.12))
        print(v,try textedit.appData.unpack(v))
    }
}
*/


do {
    
    let itunes = ITunes()
    print("// itunes.playerState.get()")
    print("=> \(try itunes.playerState.get())")
    
    print()
    print("// try ITunes().play()")
    try ITunes().play()
    
    print()
    print("// try itunes.currentTrack.name.get()")
    print("Current track:", try itunes.currentTrack.name.get())
    
    
//    print("// Specifier.description: \(TEDApp.documents[1].text)")
//    print("// Specifier.description: \(textedit.documents[1].text)")
    
    
    // send `open` and `get` AEs using raw four-char codes
    //let result = try textedit.sendAppleEvent(coreEventClass, kAEOpenDocuments, [keyDirectObject:NSURL.fileURLWithPath("/Users/has/todos.txt")])
    //print(result)

    print()
    print("get text of every document of app \"TextEdit\"")
    print("// try TextEdit().documents.text.get()")
    print(try TextEdit().documents.text.get())
    
    print()
    print("TEST: make new document with properties {text: \"Hello World!\"}")
    print("// try textedit.make(new: TED.document, withProperties: [TED.text: \"Hello World!\"])")
    let doc: TEDItem = try textedit.make(new: TED.document, withProperties: [TED.text: "Hello World!"])
    print("=> \(doc)")
    
    print()
    print("TEST: get text of doc")
    print("// try doc.text.get()")
    print(try doc.text.get())

    try doc.text.color.set(to: [25186, 48058, 18246]) // green
    print("TEST: get the color of text of doc")
    print("// try doc.text.color.get()")
    // print(try doc.text.color.get())  // WAS: Error -1700: Can't make some data into the expected type
    print(try doc.text.color.get())     // NOW: [25186, 48058, 18246]
    
    
    /*
/*
    
    // get name of document 1
    
    // - using four-char code strings
    let result2 = try textedit.sendAppleEvent("core", "getd", ["----": textedit.elements("docu")[1].property("pnam")])
    print(result2)
    
    // - using glue-defined terminology
    let result3 = try textedit.get(TEDApp.documents[1].name)
    print(result3)
    
    let result3a: Any = try textedit.documents[1].name.get() // convenience syntax for the above
    print(result3a)
    
    
    // get name of document 1 -- this works, returning a string value
    print("\nTEST: TextEdit().documents[1].name.get() as String")
    let result5: String = try textedit.documents[1].name.get()
    print("=> \(result5)")
    
    // get name of every document
    
    print("\nTEST: TextEdit().documents.name.get() as Any")
    let result4b = try textedit.documents.name.get() as Any
    print("=> \(result4b)")
    
    // get name of every document
    print("\nTEST: TextEdit().documents.name.get() as [String]")
    let result4 = try textedit.documents.name.get() as [String] // unpack the `get` command's result as Array of String
    print("=> \(result4)")
    
    // same as above
    let result6: [String] = try textedit.documents.name.get()
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
    
//    try textedit.documents.close(saving: TED.no) // close every document saving no
    
    //struct X {}; try teDoc.text.set(to: X())
    
    //
    try teDoc.close(saving: TED.no)
    
    
    print("\nTEST: get files 1 thru 3 of home")
    let r = try Finder().home.files[1, 3].get() as [FINItem]
    print("=> \(r)")
    
    */
//} catch {
//    print("ERROR: \(error)")
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

print("\(try c.pack(true)) \(formatFourCharCode(try c.pack(true).descriptorType))")
print("\(try c.pack(NSNumber(bool: true))) \(formatFourCharCode(try c.pack(NSNumber(bool: true)).descriptorType))")
print("")
print("PACK AS INTEGER")
print("\(try c.pack(3)) \(formatFourCharCode(try c.pack(3).descriptorType))")
print("\(try c.pack(NSNumber(int: 3))) \(formatFourCharCode(try c.pack(NSNumber(int: 3)).descriptorType))")
print("")
print("PACK AS DOUBLE")
print("\(try c.pack(3.1)) \(formatFourCharCode(try c.pack(3.1).descriptorType))")
print("\(try c.pack(NSNumber(double: 3.1))) \(formatFourCharCode(try c.pack(NSNumber(double: 3.1)).descriptorType))")
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
let result = try finder.sendAppleEvent(coreEventGetData,
    [keyDirectObject:finder.property("home").elements("cobj")])
print("\n\nRESULT1: \(result)")
} catch {
print("\n\nERROR1: \(error)")
}
let f = URL(fileURLWithPath:"/Users/Shared")

do {
let result = try finder.sendAppleEvent(coreEventGetData, [keyDirectObject: AEApp.elements(cObject)[f]])
    print("RAW: \(result)")
} catch {
    print("\n\nERROR: \(error)")
}
do {
let result = try finder.sendAppleEvent(coreEventGetData, [keyDirectObject: AEApp.elements(cFile)[f]]) // Finder will throw error as f is a folder, not a file
    print("RAW: \(result)")
} catch {
    print("\n\nERROR: \(error)")
}
*/

/*
do {
    let result: AESpecifier = try finder.sendAppleEvent(coreEventGetData,
        [keyDirectObject:finder.elements(cFile)[NSURL.fileURLWithPath("/Users/has/entoli - defining pairs.txt")]])
    print("\n\nRESULT1: \(result)")
} catch {
print("\n\nERROR1: \(error)")
}
do {
    let result = try finder.sendAppleEvent(coreEventGetData,
        [keyDirectObject:finder.elements(cFile)[NSURL.fileURLWithPath("/Users/has/entoli - defining pairs.txt")]])
    print("\n\nRESULT2: \(result)")
} catch {
print("\n\nERROR2: \(error)")
}


do {
    let result: AESpecifier = try finder.sendAppleEvent("coregetd",
        ["----":finder.elements(cFile)[NSURL.fileURLWithPath("/Users/has/entoli - defining pairs.txt")]])
    print("\n\nRESULT3: \(result)")
} catch {
print("\n\nERROR3: \(error)")
}
do {
    let result = try finder.sendAppleEvent("coregetd",
        ["----":finder.elements(cFile)[NSURL.fileURLWithPath("/Users/has/entoli - defining pairs.txt")]])
    print("\n\nRESULT4: \(result)")
} catch {
print("\n\nERROR4: \(error)")
}
*/

/*

do {
    let result: AESpecifier! = try finder.sendAppleEvent("coregetd", // Can't unpack value as ImplicitlyUnwrappedOptional<Specifier>
        ["----":finder.elements(cFile)[NSURL.fileURLWithPath("/Users/has/entoli - defining pairs.txt")]])
    print("\n\nRESULT5: \(result)")
} catch {
    print("\n\nERROR5: \(error)")
}


do {
    let result: AESpecifier? = try finder.sendAppleEvent("coregetd", // Can't unpack value as Optional<Specifier>
        ["----":finder.elements(cFile)[NSURL.fileURLWithPath("/Users/has/entoli - defining pairs.txt")]])
    print("\n\nRESULT6: \(result)")
} catch {
    print("\n\nERROR6: \(error)")
}

*/

print()


