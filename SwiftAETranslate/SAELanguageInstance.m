//
//  SAELanguageInstance.m
//  SwiftAE
//
//

#import "SAELanguageInstance.h"
#import "SAEEventSniffer.h"




// installs into CI to monitor outgoing AEs
static OSErr SAESendFunction(const AppleEvent *theAppleEvent,
                             AppleEvent *reply,
                             AESendMode sendMode,
                             AESendPriority sendPriority,
                             long timeOutInTicks,
                             AEIdleUPP idleProc,
                             AEFilterUPP filterProc,
                             SRefCon refcon) {
    AEDesc eventCopy;
    OSErr err = AEDuplicateDesc(theAppleEvent, &eventCopy);
    if (err) return err;
    NSAppleEventDescriptor *desc = [[NSAppleEventDescriptor alloc] initWithAEDescNoCopy: &eventCopy];
    BOOL willSend = YES;
    BOOL willSniff = !([desc eventClass] == kASAppleScriptSuite && [desc eventID] == kGetAETE);
    if (willSniff) {
        willSend = [(__bridge SAEEventSniffer *)refcon sniffEvent: desc];
    }
    if (willSend) {
        err = AESendMessage(theAppleEvent, reply, sendMode, timeOutInTicks);
        if (!err && willSniff) {
            AEDesc replyCopy;
            if (!AEDuplicateDesc(reply, &replyCopy)) {
                NSAppleEventDescriptor *replyDesc = [[NSAppleEventDescriptor alloc] initWithAEDescNoCopy: &replyCopy];
                [(__bridge SAEEventSniffer *)refcon sniffReply: replyDesc];
            }
        }
    }
    if (err) return err;
    return err;
}



@implementation SAELanguageInstance

- (void)setEventSniffer:(SAEEventSniffer *)sniffer_ {
    sniffer = sniffer_;
    OSASetSendProc(self.componentInstance, NewOSASendUPP(SAESendFunction), (__bridge SRefCon)sniffer_);
}

@end
