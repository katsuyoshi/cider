//
//  NSManagedObjectContextCreationTest.m
//  CiderTest
//
//  Created by Katsuyoshi Ito on 09/08/03.
//  Copyright 2009 ITO SOFT DESIGN Inc. All rights reserved.
//

#import "NSManagedObjectContextCreationTest.h"
#import "CiderCoreData.h"
#import "ISStudio.h"


@implementation NSManagedObjectContextCreationTest

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [NSManagedObjectContext clearDefaultManagedObjectContextAndDeleteStoreFile];
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

- (void)testCreateWithEntityName
{
    NSManagedObjectContext *context = [NSManagedObjectContext defaultManagedObjectContext];
    ISStudio *studio = [context createWithEntityName:@"ISStudio"];
    
    ASSERT_EQUAL(context, studio.managedObjectContext);
    ASSERT_EQUAL(@"ISStudio", studio.entity.name);
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
