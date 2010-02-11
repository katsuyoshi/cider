//
//  NSDateExtension.m
//  tandr
//
//  Created by Katsuyoshi Ito on 10/02/01.
//  Copyright 2010 ITO SOFT DESIGN Inc. All rights reserved.
//

#import "NSDateExtension.h"


@implementation NSDate(ISExtension)

+ (NSDate *)dateWithYear:(int)year month:(int)month day:(int)day hour:(int)hour minute:(int)minute second:(int)second
{
    NSDateComponents *components = [[[NSDateComponents alloc] init] autorelease];
    [components setYear:year];
    [components setMonth:month];
    [components setDay:day];
    [components setHour:hour];
    [components setMinute:minute];
    [components setSecond:second];
    NSCalendar *gregorian = [self gregorianCalendar];
    return [gregorian dateFromComponents:components];
}

+ (NSCalendar *)gregorianCalendar
{
    return [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
}

- (NSCalendar *)gregorianCalendar
{
    return [[self class] gregorianCalendar];
}

- (int)year
{
    NSCalendar *gregorian = [self gregorianCalendar];
    NSDateComponents *components = [gregorian components:NSYearCalendarUnit fromDate:self];
    return [components year];
}

- (int)month
{
    NSCalendar *gregorian = [self gregorianCalendar];
    NSDateComponents *components = [gregorian components:NSMonthCalendarUnit fromDate:self];
    return [components month];
}

- (int)day
{
    NSCalendar *gregorian = [self gregorianCalendar];
    NSDateComponents *components = [gregorian components:NSDayCalendarUnit fromDate:self];
    return [components day];
}

- (int)hour
{
    NSCalendar *gregorian = [self gregorianCalendar];
    NSDateComponents *components = [gregorian components:NSHourCalendarUnit fromDate:self];
    return [components hour];
}

- (int)minute
{
    NSCalendar *gregorian = [self gregorianCalendar];
    NSDateComponents *components = [gregorian components:NSMinuteCalendarUnit fromDate:self];
    return [components minute];
}

- (int)second
{
    NSCalendar *gregorian = [self gregorianCalendar];
    NSDateComponents *components = [gregorian components:NSSecondCalendarUnit fromDate:self];
    return [components second];
}



- (NSDate *)beginningOfDay
{
    return [NSDate dateWithYear:[self year] month:[self month] day:[self day] hour:0 minute:0 second:0];
}

@end
