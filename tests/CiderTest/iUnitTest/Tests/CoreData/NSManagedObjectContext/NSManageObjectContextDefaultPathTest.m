//
//  NSManageObjectContextDefaultPathTest.m
//  CiderTest
//
//  Created by Ito Katsuyoshi on 12/01/20.
//  Copyright 2012年 ITO SOFT DESIGN Inc. All rights reserved.
//

#import "NSManageObjectContextDefaultPathTest.h"
#import "CiderCoreData.h"


@implementation NSManageObjectContextDefaultPathTest

#pragma mark -
#pragma mark Helpers

- (void)touchDefaultFile
{
    [@"" writeToFile:[NSManagedObjectContext defaultStoreFileBefore0_3_0WithFileName:nil] atomically:YES encoding:NSUTF8StringEncoding error:NULL];
}

- (void)cleanDefaultFile
{
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *path = [NSManagedObjectContext defaultStoreFileBefore0_3_0WithFileName:nil];
    if ([manager fileExistsAtPath:path]) {
        [manager removeItemAtPath:path error:NULL];
    }
}

- (void)removeApplicationSupportDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    NSFileManager *manager = [NSFileManager defaultManager];
    [manager removeItemAtPath:[paths lastObject] error:NULL];
}

- (NSString *)lastNFileComponentPathOf:(NSString *)path n:(int)n
{
    NSArray *components = [path componentsSeparatedByString:@"/"];
    components = [components subarrayWithRange:NSMakeRange(components.count - n, n)];
    return [components componentsJoinedByString:@"/"];
}


- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [NSManagedObjectContext clearDefaultManagedObjectContextAndDeleteStoreFile];
    [NSManagedObjectContext clearDefaultStoreUrlAndFile];
    [self cleanDefaultFile];
    [self removeApplicationSupportDirectory];
    [NSManagedObjectContext setFileName:nil];
    [super tearDown];
}

- (void)dealloc
{
    [super dealloc];
}

#pragma mark -
#pragma mark Tests

- (void)defaultPathBefore0_3_0ShouldBeDocumentCiderSqlite
{
    NSString *path = [NSManagedObjectContext defaultStoreFileBefore0_3_0WithFileName:nil];

    NSArray *components = [path componentsSeparatedByString:@"/"];
    components = [components subarrayWithRange:NSMakeRange(components.count - 2, 2)];
    path = [components componentsJoinedByString:@"/"];
    ASSERT_EQUAL(@"Documents/cider.sqlite", path);
}

- (void)defaultPathBefore0_3_0WithAbcShouldBeDocumentAbc
{
    NSString *path = [NSManagedObjectContext defaultStoreFileBefore0_3_0WithFileName:@"abc"];
    ASSERT_EQUAL(@"Documents/abc", [self lastNFileComponentPathOf:path n:2]);
}

- (void)defaultPathShouldBeLibraryApplicationSupportCiderSqlite
{
    NSString *path = [NSManagedObjectContext defaultStoreFile];
    ASSERT_EQUAL(@"Library/Application Support/cider.sqlite", [self lastNFileComponentPathOf:path n:3]);
}

- (void)aFileBefore0_3_0ShouldBeMovedTo0_3_0Location
{
    [self touchDefaultFile];
    ASSERT([NSManagedObjectContext transferBefore0_3_0DataIfNeedsWithFileName:nil]);
    NSFileManager *manager = [NSFileManager defaultManager];
    ASSERT([manager fileExistsAtPath:[NSManagedObjectContext defaultStoreFile]]);
}

#pragma mark - change name

- (void)defaultFileNameShouldBeCiderSqlite
{
    ASSERT_EQUAL(@"cider.sqlite", [NSManagedObjectContext fileName]);
}

- (void)defaultPathShouldBeLibraryApplicationSupportAbcWithFileNameAbc
{
    [NSManagedObjectContext setFileName:@"abc"];
    NSString *path = [NSManagedObjectContext defaultStoreFile];
    ASSERT_EQUAL(@"Library/Application Support/abc", [self lastNFileComponentPathOf:path n:3]);
}


#pragma mark - 

- (void)storeFileExistsShouldBeFalseInitialy
{
    ASSERT(![NSManagedObjectContext storeFileExits]);
}

- (void)storeFileExistsShouldBeTrueAfterCreatedContext
{
    [DEFAULT_MANAGED_OBJECT_CONTEXT save:NULL];
    ASSERT([NSManagedObjectContext storeFileExits]);
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
