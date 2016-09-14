//
//  SAEEventSniffer.h
//  SwiftAE
//
//

#import <Foundation/Foundation.h>
#import "SAELanguageInstance.h"

@interface SAEEventSniffer : NSObject

@property (readwrite) BOOL sendEvents;

- (BOOL)sniffEvent:(NSAppleEventDescriptor *)desc;

- (void)sniffReply:(NSAppleEventDescriptor *)desc;

@end
