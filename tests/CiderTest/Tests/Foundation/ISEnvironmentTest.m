//
//  ISEnvironmentTest.m
//  CiderTest
//
//  Created by 伊藤ソフトデザイン on 11/03/29.
//  Copyright 2011 有限会社伊藤ソフトデザイン. All rights reserved.
//

#import "ISEnvironmentTest.h"
#import "ISEnvironment.h"



@implementation ISEnvironmentTest

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
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

- (void)testBundleIdentifier
{
    ASSERT_EQUAL(@"com.yourcompany.CiderTest", [ISEnvironment sharedEnvironment].bundleIdentifier);
}

- (void)testBundleVersion
{
    ASSERT_EQUAL(@"1.0", [ISEnvironment sharedEnvironment].bundleVersion);
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
