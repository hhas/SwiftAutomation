//
//  SAELanguageInstance.h
//  AppleScriptToSwift
//
//

#import <Foundation/Foundation.h>
#import <OSAKit/OSAKit.h>


@class SAEEventSniffer;



@interface SAELanguageInstance : OSALanguageInstance {
    
    SAEEventSniffer *sniffer;
    
}

- (void)setEventSniffer:(SAEEventSniffer *)sniffer_;

@end
