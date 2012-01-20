//
//  ISFetchRequestConditionTest.m
//  CiderTest
//
//  Created by Katsuyoshi Ito on 09/09/07.
//  Copyright 2009 ITO SOFT DESIGN Inc. All rights reserved.
//

#import "ISFetchRequestConditionTest.h"
#import "ISFetchRequestCondition.h"
#import "CiderCoreData.h"


@implementation ISFetchRequestConditionTest

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

- (void)testEntityName
{
    ISFetchRequestCondition *condition = [ISFetchRequestCondition fetchRequestCondition];
    condition.entity = [NSEntityDescription entityForName:@"ISMovie" inManagedObjectContext:[NSManagedObjectContext defaultManagedObjectContext]];
    
    ASSERT_EQUAL(@"ISMovie", condition.entityName);
}

- (void)testEntity
{
    ISFetchRequestCondition *condition = [ISFetchRequestCondition fetchRequestCondition];
    condition.managedObjectContext = [NSManagedObjectContext defaultManagedObjectContext];
    condition.entityName = @"ISMovie";

    ASSERT_NOT_NIL(condition.entity);
    ASSERT_EQUAL(@"ISMovie", condition.entity.name);
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
