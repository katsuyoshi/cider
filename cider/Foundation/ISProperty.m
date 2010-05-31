//
//  ISProperty.m
//  iRubyKaigi
//
//  Created by Katsuyoshi Ito on 10/05/29.
//  Copyright 2010 ITO SOFT DESIGN Inc. All rights reserved.
//

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


@end
