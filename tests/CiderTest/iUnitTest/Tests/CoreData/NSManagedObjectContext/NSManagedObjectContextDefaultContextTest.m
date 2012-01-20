//
//  NSManagedObjectContextDefaultContextTest.m
//  CiderTest
//
//  Created by Katsuyoshi Ito on 09/08/02.
//  Copyright 2009 ITO SOFT DESIGN Inc. All rights reserved.
//

#import "NSManagedObjectContextDefaultContextTest.h"
#import "CiderCoreData.h"


@implementation NSManagedObjectContextDefaultContextTest

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [NSManagedObjectContext clearDefaultManagedObjectContextAndDeleteStoreFile];
    [NSManagedObjectContext clearDefaultStoreUrlAndFile];
    
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

- (NSString *)defaultStoreFile
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return [basePath stringByAppendingPathComponent:@"cider.sqlite"];
}

#pragma mark -
#pragma mark Tests

- (void)testDefaultStoreFile
{
    ASSERT_EQUAL([self defaultStoreFile], [NSManagedObjectContext defaultStoreFile]);
}

- (void)testSetDefaultStoreFile
{
    NSString *filePath = [NSTemporaryDirectory() stringByAppendingString:@"abc.sqlite"];
    [NSManagedObjectContext setDefaultStoreFile:filePath];
    ASSERT_EQUAL(filePath, [NSManagedObjectContext defaultStoreFile]);
    // defaultStoreURL is same.
    ASSERT_EQUAL(filePath, [[NSManagedObjectContext defaultStoreURL] path]);
}

- (void)testDefaultStoreURL
{
    ASSERT_EQUAL([self defaultStoreFile], [[NSManagedObjectContext defaultStoreURL] path]);
    ASSERT_EQUAL([self defaultStoreFile], [NSManagedObjectContext defaultStoreFile]);
}

- (void)testSetDefaultStoreURLWithFileURL
{
    NSString *filePath = [NSTemporaryDirectory() stringByAppendingString:@"abc.sqlite"];
    [NSManagedObjectContext setDefaultStoreURL:[NSURL fileURLWithPath:filePath]];
    ASSERT_EQUAL(filePath, [[NSManagedObjectContext defaultStoreURL] path]);
    // defaultStoreURL is same.
    ASSERT_EQUAL(filePath, [NSManagedObjectContext defaultStoreFile]);
}

- (void)testSetDefaultStoreURLWithURL
{
    NSURL *url = [NSURL URLWithString:@"http://www.itosoft.com"];
    [NSManagedObjectContext setDefaultStoreURL:url];
    ASSERT_EQUAL(url, [NSManagedObjectContext defaultStoreURL]);
    // defaultStoreURL is nil.
    ASSERT_NIL([NSManagedObjectContext defaultStoreFile]);
}

- (void)testManagedObjectContextWithFile
{
    tmpFilePath = [[NSTemporaryDirectory() stringByAppendingPathComponent:@"abc.sqlite"] retain];
    NSManagedObjectContext *context = [NSManagedObjectContext managedObjectContextWithFile:tmpFilePath];
    
    ASSERT_NOT_NIL(context);
    ASSERT_NOT_NIL([context persistentStoreCoordinator]);
    ASSERT_NOT_NIL([[context persistentStoreCoordinator] managedObjectModel]);
    
    ASSERT_EQUAL_INT(1, [[[context persistentStoreCoordinator] persistentStores] count]);

    NSPersistentStore *store = [[[context persistentStoreCoordinator] persistentStores] lastObject];
    ASSERT_EQUAL(tmpFilePath, [[store URL] path]);
}

- (void)testDefaultManagedObjectContext
{
    NSManagedObjectContext *context = [NSManagedObjectContext defaultManagedObjectContext];
    
    NSPersistentStore *store = [[[context persistentStoreCoordinator] persistentStores] lastObject];
    ASSERT_EQUAL([self defaultStoreFile], [[store URL] path]);
}

- (void)testSetDefaultManagedObjectContext
{
    tmpFilePath = [[NSTemporaryDirectory() stringByAppendingPathComponent:@"abc.sqlite"] retain];
    NSManagedObjectContext *context = [NSManagedObjectContext managedObjectContextWithFile:tmpFilePath];

    [NSManagedObjectContext setDefaultManagedObjectContext:context];
    ASSERT_EQUAL(context, [NSManagedObjectContext defaultManagedObjectContext]);

    NSPersistentStore *store = [[[context persistentStoreCoordinator] persistentStores] lastObject];
    ASSERT_EQUAL(tmpFilePath, [[store URL] path]);
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
