//
//  NSDateExtensionTest.m
//  CiderTest
//
//  Created by 伊藤ソフトデザイン on 11/03/23.
//  Copyright 2011 有限会社伊藤ソフトデザイン. All rights reserved.
//

#import "NSDateExtensionTest.h"
#import "Cider.h"


@implementation NSDateExtensionTest

- (void)setUp
{
    [super setUp];
    originalTimeZone = [[NSTimeZone defaultTimeZone] retain];
    [NSTimeZone setDefaultTimeZone:[NSTimeZone timeZoneWithName:@"Tokyo/Asia"]];
}

- (void)tearDown
{
    [NSTimeZone setDefaultTimeZone:originalTimeZone];
    [originalTimeZone release];
    [super tearDown];
}

- (void)dealloc
{
    [super dealloc];
}


#pragma mark -
#pragma mark Helpers


#pragma mark -
#pragma mark Tests

- (void)testDateYearMonthDayHourMinuteSecond
{
    NSDate *date = [NSDate dateWithYear:2011 month:3 day:23 hour:11 minute:12 second:34];
    ASSERT_EQUAL_INT(2011, date.year);
    ASSERT_EQUAL_INT(3, date.month);
    ASSERT_EQUAL_INT(23, date.day);
    ASSERT_EQUAL_INT(11, date.hour);
    ASSERT_EQUAL_INT(12, date.minute);
    ASSERT_EQUAL_INT(34, date.second);
}

- (void)testDateYearMonthDayHourMinuteSecondWithTimeZone
{
    NSTimeZone *timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    NSDate *date = [NSDate dateWithYear:2011 month:3 day:23 hour:2 minute:12 second:34 timeZone:timeZone];
    ASSERT_EQUAL_INT(2011, date.year);
    ASSERT_EQUAL_INT(3, date.month);
    ASSERT_EQUAL_INT(23, date.day);
    ASSERT_EQUAL_INT(11, date.hour);
    ASSERT_EQUAL_INT(12, date.minute);
    ASSERT_EQUAL_INT(34, date.second);
}


#pragma mark -
#pragma mark Option

// Uncomment it, if you want to test this class except other passed test classes.
//#define TESTS_ALWAYS
#ifdef TESTS_ALWAYS
- (void)testThisClassAlways { ASSERT_FAIL(@"fail always"); }
+ (BOOL)forceTestsAnyway { return YES; }
#endif

@end
