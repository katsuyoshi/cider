//
//  NSFetchedResultsControllerSortedObjectTest.m
//  CiderTest
//
//  Created by Katsuyoshi Ito on 09/08/12.
//  Copyright 2009 ITO SOFT DESIGN Inc. All rights reserved.
//

#import "NSFetchedResultsControllerSortedObjectTest.h"
#import "CiderCoreData.h"
#import "ISMovie.h"


@implementation NSFetchedResultsControllerSortedObjectTest

- (void)setUp
{
    [super setUp];
    [[ISMovie create] setTitle:@"Star Wars IV"];
    [[ISMovie create] setTitle:@"Star Wars VI"];
    [[ISMovie create] setTitle:@"Star Wars V"];
}

- (NSNumber *)didSetUp
{
    return [super didSetUp];
}

- (void)tearDown
{
    [fetechedResultController release];
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

- (void)testArrangedObjects
{
    ISFetchRequestCondition *condition = [ISFetchRequestCondition fetchRequestCondition];
    condition.sortDescriptors = [NSSortDescriptor sortDescriptorsWithString:@"title"];
    fetechedResultController = [[ISMovie fetchedResultsControllerWithCondition:condition] retain];
    [fetechedResultController performFetch:NULL];

    NSArray *arrangedObjects = [fetechedResultController arrangedObjects];
    ASSERT_NOT_SAME(fetechedResultController.fetchedObjects, arrangedObjects);
    ASSERT_EQUAL_INT(3, [arrangedObjects count]);
    ASSERT_EQUAL(@"Star Wars IV", [[arrangedObjects objectAtIndex:0] title]);
    ASSERT_EQUAL(@"Star Wars V", [[arrangedObjects objectAtIndex:1] title]);
    ASSERT_EQUAL(@"Star Wars VI", [[arrangedObjects objectAtIndex:2] title]);
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
