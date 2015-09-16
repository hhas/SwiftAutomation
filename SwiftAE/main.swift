//
//  main.swift
//  SwiftAE
//
//  tests
//
//
//

import Foundation

/*
let p = SDEFParser()
do {
    try p.parse(try GetSDEF(NSURL(fileURLWithPath: "/Applications/TextEdit.app")))
    print(p.types)
    print(p.enumerators)
    print(p.properties)
    print(p.elements)
    print(p.commands)
} catch {
    print(error)
}
*/


do {
    let p = try AEApplication(name:"TextEdit").parseAETE()
    print(p.types)
    print(p.enumerators)
    print(p.properties)
    print(p.elements)
    print(p.commands)
} catch {
    print(error)
}

/*

do {
    
    let te = TextEdit(name:"TextEdit")


//print(TEDApp.documents[1].text)
//print(te.documents[1].text)

    // send `open` and `get` AEs using raw four-char codes
    //let result = try te.sendAppleEvent(kCoreEventClass, kAEOpenDocuments, [keyDirectObject:NSURL.fileURLWithPath("/Users/has/todos.txt")])
    //print(result)

    //*
    
    let result1 = try te.make(new: TED.document, withProperties: [TED.text: "Hello World!"])
        
    print(result1) // TO DO: resulting specifier shows a 'TEDApp' root but needs to show 'TextEdit()' root; see TODO in SpecifierFormatter
    
    print(try (result1 as! TEDObject).text.get())

    
    // get name of document 1
    
    // - using four-char code strings
    let result2 = try te.sendAppleEvent("core", "getd", ["----": te.elements("docu")[1].property("pnam")])
    print(result2)
    
    // - using glue-defined terminology
    let result3 = try te.get(TEDApp.documents[1].name)
    print(result3)
    
    let result3a: Any = try te.documents[1].name.get() // convenience syntax for the above
    print(result3a)
    
    // get name of every document (note: currently this example is only good for demo purposes: the `get` method result's dynamicType is Array<String>, but its static type is Any, and  Swift can't cast Any to Array<...> without falling over, so this result can't be used for anything useful; this is another reason why generic versions of commands are needed, but getting those to work right is a whole 'nother problem again...)
    
    let result4 = try te.documents.name.get() 
    print(result4)
    //*/
    
    // get every file of folder "Documents" of home whose name extension is "txt"
    
    let q = Finder().home.folders["Documents"].files[FINIts.nameExtension == "txt"].name
    print(q)
    print(try q.get())


//    try te.documents.close(saving: TED.no) // close every document saving no

    
//    let result5: String = try te.documents[1].name.get() // unpack get command's result as String; note: generic versions of commands are currently disabled as they don't yet work correctly
//    print(result5)
    
//    let result6: [String] = try te.documents.name.get() // unpack get command's result as [String]; note: same as above (AppData currently can't unpack collections correctly due to crappy generics)
//    print(result6)

} catch {
    print(error)
}

//*/






/*
// test Swift<->AE type conversions
let c = AEApplication.currentApplication().appData!

//let lst = try c.pack([1,2,3])
//print(try c.unpack(lst))

print(try c.pack("hello"))
print(try c.pack(3))
print(try c.pack(true))

NSLog("%08X", try c.pack(true).descriptorType) // 0x626F6F6C = typeBoolean

print(c)
*/




/*

let finder = AEApplication(name: "Finder")


/*
do {
let result = try finder.sendAppleEvent(kAECoreSuite, kAEGetData,
    [keyDirectObject:finder.property("home").elements("cobj")])
print("\n\nRESULT1: \(result)")
} catch {
print("\n\nERROR1: \(error)")
}
*/

let result = try finder.appData!.sendAppleEvent("open", eventClass: kAECoreSuite, eventID: kAEGetData,
                                        parentSpecifier: finder,
                                        directParameter: finder.elements(cFile)[NSURL.fileURLWithPath("/Users/has/entoli - defining pairs.txt")],
                                        keywordParameters: [],
                                        requestedType: nil,
                                        waitReply: true,
                                        sendOptions: nil,
                                        withTimeout: nil,
                                        considering: nil,
                                        asType: Any.self)
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

*/*/*/*/
