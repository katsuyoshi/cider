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
    
    NSFetchRequest *request = [NSManagedObject fetchRequestWithEntity:@"ISMovie" predicate:predicate sortDiscriptors:sortDescriptors managedObjectContext:context];

    ASSERT_EQUAL(@"ISMovie", request.entity.name);
    ASSERT_EQUAL(predicate, request.predicate);
    ASSERT_EQUAL(sortDescriptors, request.sortDescriptors);
}

- (void)testFetchRequestFullWithCondition
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title = %d", @"title"];
    NSArray *sortDescriptors = [NSArray arrayWithObject:[[[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES] autorelease]];
    tmpFilePath = [[NSTemporaryDirectory() stringByAppendingFormat:@"abc.sqlite"] retain];
    NSManagedObjectContext *context = [NSManagedObjectContext managedObjectContextWithFile:tmpFilePath];
    
    ISFetchRequestCondition *condition = [ISFetchRequestCondition fetchRequestCondition];
    condition.entityName = @"ISMovie";
    condition.predicate = predicate;
    condition.sortDiscriptors = sortDescriptors;
    condition.managedObjectContext = context;
    
    NSFetchRequest *request = [ISMovie fetchRequestWithCondition:condition];

    ASSERT_EQUAL(@"ISMovie", request.entity.name);
    ASSERT_EQUAL(predicate, request.predicate);
    ASSERT_EQUAL(sortDescriptors, request.sortDescriptors);
}

- (void)testFetchRequestWithoutManagedObjectContext
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title = %d", @"title"];
    NSArray *sortDescriptors = [NSArray arrayWithObject:[[[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES] autorelease]];
    
    NSFetchRequest *request = [ISMovie fetchRequestWithPredicate:predicate sortDiscriptors:sortDescriptors managedObjectContext:nil];

    ASSERT_EQUAL(@"ISMovie", request.entity.name);
    ASSERT_EQUAL(predicate, request.predicate);
    ASSERT_EQUAL(sortDescriptors, request.sortDescriptors);
}

- (void)testFetchedResultControllerFull
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title = %d", @"title"];
    NSArray *sortDescriptors = [NSArray arrayWithObject:[[[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES] autorelease]];
    tmpFilePath = [[NSTemporaryDirectory() stringByAppendingFormat:@"abc.sqlite"] retain];
    NSManagedObjectContext *context = [NSManagedObjectContext managedObjectContextWithFile:tmpFilePath];
    
    NSFetchedResultsController *controller = [NSManagedObject fetchedResultsControllerWithEntity:@"ISMovie" predicate:predicate sortDiscriptors:sortDescriptors managedObjectContext:context sectionNameKeyPath:nil cacheName:@"cash"];

    ASSERT_EQUAL(@"ISMovie", controller.fetchRequest.entity.name);
    ASSERT_EQUAL(predicate, controller.fetchRequest.predicate);
    ASSERT_EQUAL(sortDescriptors, controller.fetchRequest.sortDescriptors);
}

- (void)testFetchedResultControllerFullWithCondition
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title = %d", @"title"];
    NSArray *sortDescriptors = [NSArray arrayWithObject:[[[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES] autorelease]];
    tmpFilePath = [[NSTemporaryDirectory() stringByAppendingFormat:@"abc.sqlite"] retain];
    NSManagedObjectContext *context = [NSManagedObjectContext managedObjectContextWithFile:tmpFilePath];
    
    ISFetchRequestCondition *condition = [ISFetchRequestCondition fetchRequestCondition];
    condition.predicate = predicate;
    condition.sortDiscriptors = sortDescriptors;
    condition.managedObjectContext = context;
    condition.sectionNameKeyPath = @"nameKey";
    condition.cacheName = @"cache";
        
    NSFetchedResultsController *controller = [ISMovie fetchedResultsControllerWithCondition:condition];

    ASSERT_EQUAL(@"ISMovie", controller.fetchRequest.entity.name);
    ASSERT_EQUAL(predicate, controller.fetchRequest.predicate);
    ASSERT_EQUAL(sortDescriptors, controller.fetchRequest.sortDescriptors);
    ASSERT_EQUAL(@"nameKey", controller.sectionNameKeyPath);
    ASSERT_EQUAL(@"cache", controller.cacheName);
}


- (void)testFetchedResultsControllerWithoutManagedObjectContext
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title = %d", @"title"];
    NSArray *sortDescriptors = [NSArray arrayWithObject:[[[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES] autorelease]];
    
    NSFetchedResultsController *controller = [ISMovie fetchedResultsControllerWithPredicate:predicate sortDiscriptors:sortDescriptors managedObjectContext:nil sectionNameKeyPath:nil cacheName:@"cash"];

    ASSERT_EQUAL(@"ISMovie", controller.fetchRequest.entity.name);
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
