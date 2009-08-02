//
//  NSManagedObjectCreationTest.m
//  CiderTest
//
//  Created by Katsuyoshi Ito on 09/08/03.
//  Copyright 2009 ITO SOFT DESIGN Inc. All rights reserved.
//

#import "NSManagedObjectCreationTest.h"
#import "CiderCoreData.h"
#import "ISStudio.h"
#import "ISMovie.h"


@implementation NSManagedObjectCreationTest

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


#pragma mark class methos

- (void)testCreateWithEntityName
{
    NSManagedObjectContext *context = [NSManagedObjectContext defaultManagedObjectContext];
    NSManagedObject *eo = [NSManagedObject createWithEntityName:@"ISStudio"];
    
    ASSERT_EQUAL(context, eo.managedObjectContext);
    ASSERT_EQUAL(@"ISStudio", eo.entity.name);

    eo = [NSManagedObject createWithEntityName:@"ISMovie"];
    ASSERT_EQUAL(context, eo.managedObjectContext);
    ASSERT_EQUAL(@"ISMovie", eo.entity.name);
}

- (void)testCreateWithEntityNameInManagedObjectContext
{
    NSManagedObjectContext *context = [NSManagedObjectContext managedObjectContextWithFile:[NSTemporaryDirectory() stringByAppendingPathComponent:@"abc.sqlite"]];
    
    NSManagedObject *eo = [NSManagedObject createWithEntityName:@"ISStudio" inManagedObjectContext:context];
    ASSERT_EQUAL(context, eo.managedObjectContext);
    ASSERT_NOT_EQUAL([NSManagedObjectContext defaultManagedObjectContext], eo.managedObjectContext);
    ASSERT_EQUAL(@"ISStudio", eo.entity.name);
}

- (void)testCreate
{
    NSManagedObjectContext *context = [NSManagedObjectContext defaultManagedObjectContext];
    ISStudio *eo = [ISStudio create];
    
    ASSERT_EQUAL(context, eo.managedObjectContext);
    ASSERT_EQUAL(@"ISStudio", eo.entity.name);
}


#pragma mark instance methos

- (void)testCreateWithEntityName2
{
    NSManagedObjectContext *context = [NSManagedObjectContext defaultManagedObjectContext];
    ISStudio *studio = [NSManagedObject createWithEntityName:@"ISStudio"];
    
    ISMovie *movie = [studio createWithEntityName:@"ISMovie"];
    
    ASSERT_EQUAL(context, movie.managedObjectContext);
    ASSERT_EQUAL(@"ISMovie", movie.entity.name);
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
