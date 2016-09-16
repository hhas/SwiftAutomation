//: Playground - noun: a place where people can play

import Cocoa



let itunes = ITunes()
let textedit = TextEdit()
let finder = Finder()

/*
let state: ITU = try itunes.playerState.get()
if state == ITU.playing {
    print(try itunes.currentTrack.name.get())
} else {
    print(state)
}


try Finder().home.files.name.get()

try TextEdit().documents.name.get() as [String]


let doc: TEDItem = try textedit.make(new: TED.document) // TO DO: Swift will execute this and every other line *every single time* the user edits code within this playground, causing multiple documents to be created; because what could *possibly* go wrong just by blindly assuming every single function call the user makes is 100% idempotent and safe? This makes playgrounds largely useless for interactive/tutorial use (ironic since the CLI `swift` command seems to emulate a REPL just fine).

try doc.name.get() as String



print(try finder.home.get(resultType: FIN.alias) as URL)
*/





//try itunes.tracks.any.play()

try textedit.launch()



