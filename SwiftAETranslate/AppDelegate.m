//
//  AppDelegate.m
//  SwiftAETranslate
//

#import "AppDelegate.h"


@interface AppDelegate ()
@end


@implementation AppDelegate

@synthesize useSDEF, formatter;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    for (NSTextView *view in @[self.inputView, self.outputView]) {
        [view setAutomaticDashSubstitutionEnabled:NO];
        [view setAutomaticQuoteSubstitutionEnabled:NO];
        [view setAutomaticSpellingCorrectionEnabled:NO];
        [view setAutomaticTextReplacementEnabled:NO];
    }
    [self.inputView.textStorage.mutableString setString: @"tell app \"textedit\" to get documents"];
    languageInstance = [[SAELanguageInstance alloc] initWithLanguage: [OSALanguage languageForName: @"AppleScript"]];
    formatter = [[SAEEventSniffer alloc] init];
    [languageInstance setEventSniffer: formatter];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication {
    return YES;
}

- (IBAction)runAppleScript:(id)sender {
    [self clearView:self.outputView];
    NSString *source = [self.inputView.textStorage.mutableString copy];
    OSAScript *script = [[OSAScript alloc] initWithSource: source fromURL: nil languageInstance: languageInstance usingStorageOptions: 0];
    NSAttributedString *scriptResult = nil;
    NSDictionary *errorInfo = nil;
    NSError *error = nil;
    // note: execute... returns fully qualified objspecs
    if (!([script compileAndReturnError: &errorInfo] && [script executeAndReturnDisplayValue: &scriptResult error: &errorInfo])) {
        error = [NSError errorWithDomain: NSOSStatusErrorDomain code: ([errorInfo[OSAScriptErrorNumber] intValue] ?: 1)
                                userInfo: @{NSLocalizedDescriptionKey: errorInfo[OSAScriptErrorMessage] ?: @"Couldn't compile script."}];
    }
    [self writeToView: self.outputView isReply: YES literalResult: scriptResult.string error: error desc: nil];
}


-(void)logAppleEvent:(NSAppleEventDescriptor *)desc {
    NSError *error = nil;
    NSString *literalResult = [SwiftAEFormatter formatAppleEvent: desc useSDEF: useSDEF];
    [self writeToView: self.logView isReply: NO literalResult: literalResult error: error desc: desc];
}

-(void)logReplyEvent:(NSAppleEventDescriptor *)desc {
    NSError *error = nil;
    NSString *literalResult = [SwiftAEFormatter formatAppleEvent: desc useSDEF: useSDEF];
    [self writeToView: self.logView isReply: YES literalResult: literalResult error: error desc: desc];

}

-(void)writeToView:(NSTextView *)view isReply:(BOOL)isReply literalResult:(NSString *)result
                                        error:(NSError *)error desc:(NSAppleEventDescriptor *)desc {
    if (result) {
        NSColor *color;
        if (isReply) {
            color = NSColor.grayColor;
            if (view == self.logView) result = [NSString stringWithFormat: @"// %@", result];
        } else {
            color = NSColor.blackColor;
        }
        [view.textStorage appendAttributedString:
         [[NSAttributedString alloc] initWithString: result attributes: @{NSForegroundColorAttributeName: color}]];
    } else {
        NSMutableString *errorMessage = [NSMutableString stringWithString: @"ERROR: "];
        if (error) {
            [errorMessage appendFormat: @"(%li) %@", error.code, error.localizedDescription];
        } else {
            [errorMessage appendString: @"No details available."];
        }
        if (desc) [errorMessage appendFormat: @"%@\n", desc.description];
        [view.textStorage appendAttributedString:
         [[NSAttributedString alloc] initWithString: errorMessage attributes: @{NSForegroundColorAttributeName: NSColor.redColor}]];
    }
    [view.textStorage.mutableString appendString: @"\n"];
}

-(IBAction)clearLog:(id)sender {
    [self clearView: self.logView];
}

-(void)clearView:(NSTextView *)view {
    [view.textStorage.mutableString setString: @""];
}


-(IBAction)openHelp:(id)sender {
    NSLog(@"Not implemented.");
//    NSString *frameworkPath = [NSBundle bundleForClass: DynamicAppData.class].bundlePath;
//    NSURL *url = [[NSBundle bundleWithPath: frameworkPath] URLForResource: @"index" withExtension: @"html" subdirectory: @"swift-manual"];
//    [[NSWorkspace sharedWorkspace] openURL: url];
}

@end

