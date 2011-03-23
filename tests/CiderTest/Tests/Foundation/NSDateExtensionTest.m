//
//  NSDateExtensionTest.m
//  CiderTest
//
//  Created by Katsuyoshi Ito on 11/03/23.
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
