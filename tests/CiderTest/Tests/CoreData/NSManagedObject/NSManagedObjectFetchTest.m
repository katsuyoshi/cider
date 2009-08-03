//
//  NSManagedObjectFetchTest.m
//  CiderTest
//
//  Created by Katsuyoshi Ito on 09/08/03.
//  Copyright 2009 ITO SOFT DESIGN Inc. All rights reserved.
//

#import "NSManagedObjectFetchTest.h"
#import "NSManagedObjectFetch.h"
#import "CiderCoreData.h"
#import "ISMovie.h"


@implementation NSManagedObjectFetchTest

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [NSManagedObjectContext clearDefaultManagedObjectContextAndDeleteStoreFile];

    if (tmpFilePath) {
        NSFileManager *manager = [NSFileManager defaultManager];
        [manager removeItemAtPath:tmpFilePath error:NULL];
        [tmpFilePath release];
        tmpFilePath = nil;
    }
    
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

- (void)testFetchRequestFull
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title = %d", @"title"];
    NSArray *sortDescriptors = [NSArray arrayWithObject:[[[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES] autorelease]];
    tmpFilePath = [[NSTemporaryDirectory() stringByAppendingFormat:@"abc.sqlite"] retain];
    NSManagedObjectContext *context = [NSManagedObjectContext managedObjectContextWithFile:tmpFilePath];
    
    NSFetchRequest *request = [ISMovie fetchRequestWithPredicate:predicate sortDiscriptors:sortDescriptors managedObjectContext:context];

    ASSERT_EQUAL(predicate, [request predicate]);
    ASSERT_EQUAL(sortDescriptors, [request sortDescriptors]);
}

- (void)testFetchRequestWithoutManagedObjectContext
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title = %d", @"title"];
    NSArray *sortDescriptors = [NSArray arrayWithObject:[[[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES] autorelease]];
    
    NSFetchRequest *request = [ISMovie fetchRequestWithPredicate:predicate sortDiscriptors:sortDescriptors managedObjectContext:nil];

    ASSERT_EQUAL(predicate, [request predicate]);
    ASSERT_EQUAL(sortDescriptors, [request sortDescriptors]);
}

- (void)testFetchedResultControllerFull
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title = %d", @"title"];
    NSArray *sortDescriptors = [NSArray arrayWithObject:[[[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES] autorelease]];
    tmpFilePath = [[NSTemporaryDirectory() stringByAppendingFormat:@"abc.sqlite"] retain];
    NSManagedObjectContext *context = [NSManagedObjectContext managedObjectContextWithFile:tmpFilePath];
    
    NSFetchedResultsController *controller = [ISMovie fetchedResultsControllerWithPredicate:predicate sortDiscriptors:sortDescriptors managedObjectContext:context cashName:@"cash"];

    ASSERT_EQUAL(predicate, [[controller fetchRequest] predicate]);
    ASSERT_EQUAL(sortDescriptors, [[controller fetchRequest]  sortDescriptors]);
}

- (void)testFetchedResultsControllerWithoutManagedObjectContext
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title = %d", @"title"];
    NSArray *sortDescriptors = [NSArray arrayWithObject:[[[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES] autorelease]];
    
    NSFetchedResultsController *controller = [ISMovie fetchedResultsControllerWithPredicate:predicate sortDiscriptors:sortDescriptors managedObjectContext:nil cashName:@"cash"];

    ASSERT_EQUAL(predicate, [[controller fetchRequest]  predicate]);
    ASSERT_EQUAL(sortDescriptors, [[controller fetchRequest]  sortDescriptors]);
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
