//
//  main.swift
//  SwiftAE
//
//  tests
//
//
//

import Foundation


do {
    let te = TextEdit()
    
    // send `open` and `get` AEs using raw four-char codes
    let result = try te.sendAppleEvent(kCoreEventClass, kAEOpenDocuments, [keyDirectObject:NSURL.fileURLWithPath("/Users/has/todos.txt")])
    print(result)

    let result2 = try te.sendAppleEvent("core", "getd", ["----": te.elements("docu")[1].property("pnam")])
    print(result2)
    
    // send `get` AEs using glue-defined terminology
    let result3 = try te.get(TEDApp.documents[1].name)
    print(result3)
    
    let result4: Any = try te.documents[1].name.get() // convenience syntax for the above
    print(result4)
    
//    let result5: String = try te.documents[1].name.get() // unpack get command's result as String; note: generic versions of commands are currently disabled as they don't yet work correctly
//    print(result5)
    
//    let result6: [String] = try te.documents.name.get() // unpack get command's result as [String]; note: same as above (AppData currently can't unpack collections correctly due to crappy generics)
//    print(result6)

} catch {
    print(error)
}








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


