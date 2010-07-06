//
//  ISProperty.m
//  iRubyKaigi
//
//  Created by Katsuyoshi Ito on 10/05/29.
//  Copyright 2010 ITO SOFT DESIGN Inc. All rights reserved.
//

/* 

  Copyright 2010 ITO SOFT DESIGN Inc. All rights reserved.

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

#import "ISProperty.h"


@implementation ISProperty

+ (ISProperty *)sharedProperty
{
    id property = nil;
    if (property == nil) {
        property = [self new];
    }
    return property;
}

- (NSUserDefaults *)userDefaults
{
    return [NSUserDefaults standardUserDefaults];
}

#pragma mark -
#pragma mark BOOL

- (void)setBoolValueForKey:(NSString *)key value:(BOOL)value
{
    [self.userDefaults setBool:value forKey:key];
}

- (BOOL)boolValueForKey:(NSString *)key defaultValue:(BOOL)defaultValue
{
    id object = [self.userDefaults objectForKey:key];
    if (object) {
        return [self.userDefaults boolForKey:key];
    } else {
        return defaultValue;
    }
}

- (BOOL)boolValueForKey:(NSString *)key
{
    return [self boolValueForKey:key defaultValue:NO];
}



#pragma mark -
#pragma mark int

- (void)setIntValueForKey:(NSString *)key value:(int)value
{
    [self.userDefaults setInteger:value forKey:key];
}

- (int)intValueForKey:(NSString *)key defaultValue:(int)defaultValue
{
    id object = [self.userDefaults objectForKey:key];
    if (object) {
        return [self.userDefaults integerForKey:key];
    } else {
        return defaultValue;
    }
}

- (int)intValueForKey:(NSString *)key
{
    return [self intValueForKey:key defaultValue:NO];
}



#pragma mark -
#pragma mark String

- (void)setStringValue:(NSString *)value forKey:(NSString *)key
{
    [self.userDefaults setObject:value forKey:key];
}

- (NSString *)stringValueForKey:(NSString *)key defaultValue:(NSString *)defaultValue
{
    id object = [self.userDefaults objectForKey:key];
    if (object) {
        return object;
    } else {
        return defaultValue;
    }
}

- (NSString *)stringValueForKey:(NSString *)key
{
    return [self stringValueForKey:key defaultValue:nil];
}


#pragma mark -
#pragma mark Array

- (void)setArray:(NSArray *)array forKey:(NSString *)key
{
    [self.userDefaults setObject:array forKey:key];
}

- (NSArray *)arrayForKey:(NSString *)key defaultValue:(NSArray *)defaultValue
{
    id object = [self.userDefaults objectForKey:key];
    if (object) {
        return object;
    } else {
        return defaultValue;
    }
}

- (NSArray *)arrayForKey:(NSString *)key
{
    return [self arrayForKey:key defaultValue:[NSArray array]];
}


@end
