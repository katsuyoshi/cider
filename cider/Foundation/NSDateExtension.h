//
//  NSDateExtension.h
//  tandr
//
//  Created by Katsuyoshi Ito on 10/02/01.
//  Copyright 2010 ITO SOFT DESIGN Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSDate(ISExtension)
+ (NSDate *)dateWithYear:(int)year month:(int)month day:(int)day hour:(int)hour minute:(int)minute second:(int)second;

+ (NSCalendar *)gregorianCalendar;

- (NSCalendar *)gregorianCalendar;

- (int)year;
- (int)month;
- (int)hour;
- (int)day;
- (int)minute;
- (int)second;


- (NSDate *)beginningOfDay;


@end

