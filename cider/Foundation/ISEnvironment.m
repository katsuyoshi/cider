//
//  ISEnvironment.m
//  irPanel
//
//  Created by 伊藤ソフトデザイン on 11/03/19.
//  Copyright 2011 有限会社伊藤ソフトデザイン. All rights reserved.
//

#import "ISEnvironment.h"


@implementation ISEnvironment

@synthesize isIOS3;
@synthesize isIOS4;


+ (ISEnvironment *)sharedEnvironment
{
    static id environment = nil;
    @synchronized(self) {
        if (environment == nil) {
            environment = [self new];
        }
    }
    return environment;
}


- (BOOL)iOS3
{
    return !self.isIOS4;
}

- (BOOL)iOS4
{
    NSDateComponents *components = [[[NSDateComponents alloc] init] autorelease];
    return [components respondsToSelector:@selector(timeZone)];
}


@end
