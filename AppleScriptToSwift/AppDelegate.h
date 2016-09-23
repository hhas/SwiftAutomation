//
//  AppDelegate.h
//  AppleScriptToSwift
//

#import <Cocoa/Cocoa.h>
#import "SAELanguageInstance.h"
#import "SAEEventSniffer.h"
#import "AppleScriptToSwift-Swift.h"


@interface AppDelegate : NSObject <NSApplicationDelegate> {
    SAELanguageInstance *languageInstance;
    SAEEventSniffer *formatter;
}

@property (assign) IBOutlet NSWindow *window;

@property (assign) IBOutlet NSTextView *inputView, *outputView, *logView;

@property (assign) BOOL useSDEF;

@property (readonly) SAEEventSniffer *formatter;

-(IBAction)runAppleScript:(id)sender;

-(void)logAppleEvent:(NSString *)desc;

-(void)logReplyEvent:(NSString *)desc;

-(void)writeToView:(NSTextView *)view isReply:(BOOL)isReply literalResult:(NSString *)result
                                        error:(NSError *)error desc:(NSAppleEventDescriptor *)desc;

-(IBAction)clearLog:(id)sender;

-(IBAction)openHelp:(id)sender;


@end

