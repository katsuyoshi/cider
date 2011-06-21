//
//  ISEnvironment.m
//  irPanel
//
//  Created by Katsuyoshi Ito on 11/03/19.
//
//

/* 
 
 Copyright 2009 ITO SOFT DESIGN Inc. All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification,
 are permitted provided that the following conditions are met:
 
 * Redistributions of source code must retain the above copyright notice,
 this list of conditions and the following disclaimer.
 
 * Redistributions in binary form must reproduce the above copyright notice,
 this list of conditions and the following disclaimer in the documentation
 and/or other materials provided with the distribution.
 
 * Neither the name of ITO SOFT DESIGN Inc. nor the names of its
 contributors may be used to endorse or promote products derived from this
 software without specific prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
 ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
 ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 */

#import "ISEnvironment.h"
#import <sys/types.h>
#import <sys/sysctl.h>


@interface ISEnvironment(CiderPrivate)
- (void)checkHardWare;
@end


@implementation ISEnvironment

@synthesize ipod1;
@synthesize ipod2;
@synthesize ipad;
@synthesize iphone;

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


- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)checkHardWare
{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *str = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    size = [str length];
    free(machine);

    UIDevice *device = [UIDevice currentDevice];
    int result;
    
    result = [device.model compare:@"iPod" options:NSCaseInsensitiveSearch range:NSMakeRange(0, 4)];
    ipod = result == NSOrderedSame;

    result = [device.model compare:@"iPad" options:NSCaseInsensitiveSearch range:NSMakeRange(0, 4)];
    ipad = result == NSOrderedSame;

    result = [device.model compare:@"iPhone" options:NSCaseInsensitiveSearch range:NSMakeRange(0, 6)];
    iphone = result == NSOrderedSame;
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

- (NSString *)bundleIdentifier
{
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    return [info valueForKey:(NSString *)kCFBundleIdentifierKey];
}

- (NSString *)bundleVersion
{
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    return [info valueForKey:(NSString *)kCFBundleVersionKey];
}

- (BOOL)isBundleVersionLessThan:(NSString *)version
{
    return [self isVersion:self.bundleVersion lessThan:version];
}

- (BOOL)isVersion:(NSString *)version lessThan:(NSString *)baseVersion
{
    NSArray *bve = [version componentsSeparatedByString:@"."];
    NSArray *ve = [baseVersion componentsSeparatedByString:@"."];
    @try {
        int a = [[ve objectAtIndex:0] intValue];
        int b = [[bve objectAtIndex:0] intValue];
        if (a > b) {
            return YES;
        } else
        if (a == b) {
            a = [[ve objectAtIndex:1] intValue];
            b = [[bve objectAtIndex:1] intValue];
            if (a > b) {
                return YES;
            } else
            if (a == b) {
                a = [[ve objectAtIndex:2] intValue];
                b = [[bve objectAtIndex:2] intValue];
                if (a > b) {
                    return YES;
                }
            }
        }
    } @catch (NSException *e) {}
    return NO;
}


@end
