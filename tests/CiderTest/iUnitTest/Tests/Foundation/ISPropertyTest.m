//
//  ISPropertyTest.m
//  CiderTest
//
//  Created by Katsuyoshi Ito on 10/06/17.
//  Copyright 2010 ITO SOFT DESIGN Inc. All rights reserved.
//

#import "ISPropertyTest.h"
#import "CiderCoreData.h"



@implementation ISPropertyTest

#pragma mark -
#pragma mark Helpers

#define  USER_DEFAULTS_FILE_NAME    @"Preferences/com.yourcompany.CiderTest.plist"

// iUnitTestの設定も消えちゃうので使用しない
- (void)removeUserDefaultFile
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults synchronize];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    NSString *path = [basePath stringByAppendingPathComponent:USER_DEFAULTS_FILE_NAME];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    [manager removeItemAtPath:path error:NULL];
}


#pragma mark -
#pragma mark setUp/tearDown

- (void)setUp
{
    [super setUp];
    
    property = [ISProperty new];
}

- (void)tearDown
{
    [super tearDown];
    [property setArray:nil forKey:@"abc"];
    [property release];
}

- (void)dealloc
{
    [super dealloc];
}


#pragma mark -
#pragma mark Tests

#pragma mark array

- (void)testArrayDefaultValue
{
    ASSERT_EQUAL([NSArray array], [property arrayForKey:@"abc"]);
}

- (void)testArrayDefaultValue2
{
    NSArray *array = [NSArray arrayWithObject:@"123"];
    ASSERT_EQUAL(array, [property arrayForKey:@"abc" defaultValue:array]);
}

- (void)testArray
{
    NSArray *array = [NSArray arrayWithObjects:@"abc", @"def", @"ghi", nil];
    
    [property setArray:array forKey:@"abc"];
    ASSERT_EQUAL(array, [property arrayForKey:@"abc"]);
}

#pragma mark string

- (void)testStringDefaultValue
{
    ASSERT_NIL([property stringValueForKey:@"abc"]);
}

- (void)testStringDefaultValue2
{
    NSString *string = @"123";
    ASSERT_EQUAL(string, [property stringValueForKey:@"abc" defaultValue:string]);
}

- (void)testString
{
    NSDate *date = [NSDate dateWithYear:2010 month:8 day:7 hour:11 minute:00 second:00];
    
    [property setDate:date forKey:@"abc"];
    ASSERT_EQUAL(date, [property arrayForKey:@"abc"]);
}


#pragma mark Date

- (void)testDateDefaultValue
{
    ASSERT_NIL([property dateForKey:@"abc"]);
}

- (void)testDateDefaultValue2
{
    NSDate *date = [NSDate dateWithYear:2010 month:8 day:7 hour:11 minute:00 second:00];
    ASSERT_EQUAL(date, [property dateForKey:@"abc" defaultValue:date]);
}

- (void)testDate
{
    NSDate *date = [NSDate dateWithYear:2010 month:8 day:7 hour:11 minute:00 second:00];
    
    [property setDate:date forKey:@"abc"];
    ASSERT_EQUAL(date, [property dateForKey:@"abc"]);
}



#pragma mark int

- (void)testIntDefaultValue
{
    ASSERT_EQUAL_INT(0, [property intValueForKey:@"abc"]);
}

- (void)tsetIntDefaultValue2
{
    ASSERT_EQUAL_INT(321, [property intValueForKey:@"abc" defaultValue:321]);
}

- (void)testIntValue
{
    [property setIntValue:123 forKey:@"abc"];
    ASSERT_EQUAL_INT(123, [property intValueForKey:@"abc"]);
}

#pragma mark float

- (void)testFloatDefaultValue
{
    ASSERT_EQUAL_FLOAT(0.0f, [property floatValueForKey:@"abc"]);
}

- (void)tsetFloatDefaultValue2
{
    ASSERT_EQUAL_FLOAT(3.21, [property floatValueForKey:@"abc" defaultValue:3.21]);
}

- (void)testFloatValue
{
    [property setFloatValue:1.23 forKey:@"abc"];
    ASSERT_EQUAL_FLOAT(1.23, [property floatValueForKey:@"abc"]);
}

#pragma mark double

- (void)testDoubleDefaultValue
{
    ASSERT_EQUAL_DOUBLE(0, [property doubleValueForKey:@"abc"]);
}

- (void)tsetDoubleDefaultValue2
{
    ASSERT_EQUAL_DOUBLE(3.21, [property doubleValueForKey:@"abc" defaultValue:3.21]);
}

- (void)testDoubletValue
{
    [property setDoubleValue:1.23 forKey:@"abc"];
    ASSERT_EQUAL_DOUBLE(1.23, [property doubleValueForKey:@"abc"]);
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
