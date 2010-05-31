//
//  ISProperty.h
//  iRubyKaigi
//
//  Created by Katsuyoshi Ito on 10/05/29.
//  Copyright 2010 ITO SOFT DESIGN Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ISProperty : NSObject {

}

@property (assign, readonly) NSUserDefaults *userDefaults;

+ (ISProperty *)sharedProperty;


- (void)setBoolValueForKey:(NSString *)key value:(BOOL)value;
- (BOOL)boolValueForKey:(NSString *)key defaultValue:(BOOL)defaultValue;
- (BOOL)boolValueForKey:(NSString *)key;

- (void)setIntValueForKey:(NSString *)key value:(int)value;
- (int)intValueForKey:(NSString *)key defaultValue:(int)defaultValue;
- (int)intValueForKey:(NSString *)key;

- (void)setStringValue:(NSString *)value forKey:(NSString *)key;
- (NSString *)stringValueForKey:(NSString *)key defaultValue:(NSString *)defaultValue;
- (NSString *)stringValueForKey:(NSString *)key;

@end
