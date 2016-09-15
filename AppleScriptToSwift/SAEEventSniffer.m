//
//  SAEEventSniffer.m
//  AppleScriptToSwift
//
//

#import "SAEEventSniffer.h"
#import "AppDelegate.h"

@implementation SAEEventSniffer

@synthesize sendEvents;

// called by SAELanguageInstance

- (BOOL)sniffEvent:(NSAppleEventDescriptor *)desc {
    [(AppDelegate *)(NSApp.delegate) performSelectorOnMainThread: @selector(logAppleEvent:) withObject: desc waitUntilDone: NO];
    return sendEvents;
}

- (void)sniffReply:(NSAppleEventDescriptor *)desc {
    [(AppDelegate *)(NSApp.delegate) performSelectorOnMainThread: @selector(logReplyEvent:) withObject: desc waitUntilDone: NO];
}

@end
