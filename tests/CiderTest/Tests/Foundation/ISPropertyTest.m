//
//  ISPropertyTest.m
//  CiderTest
//
//  Created by Katsuyoshi Ito on 10/06/17.
//  Copyright 2010 ITO SOFT DESIGN Inc. All rights reserved.
//

#import "ISPropertyTest.h"



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

- (void)testArrayDefaultValue
{
    ASSERT_EQUAL([NSArray array], [property arrayForKey:@"abc"]);
}

- (void)testArray
{
    NSArray *array = [NSArray arrayWithObjects:@"abc", @"def", @"ghi", nil];
    
    [property setArray:array forKey:@"abc"];
    ASSERT_EQUAL(array, [property arrayForKey:@"abc"]);
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
