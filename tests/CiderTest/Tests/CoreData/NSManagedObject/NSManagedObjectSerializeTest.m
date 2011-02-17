//
//  NSManagedObjectSerialize.m
//  CiderTest
//
//  Created by Katsuyoshi Ito on 10/07/21.
//  Copyright 2010 ITO SOFT DESIGN Inc. All rights reserved.
//

#import "NSManagedObjectSerializeTest.h"
#import "ISStudio.h"
#import "CiderCoreData.h"
#import "TypeTestEntity.h"


@implementation NSManagedObjectSerializeTest

- (void)setUp
{
    [super setUp];
    
    studio = [[ISStudio create] retain];
    studio.name = @"LUCASFILM";
    studio.position = [NSNumber numberWithInt:1];
    
    ISMovie *movie = nil;
    movie = [ISMovie create];
    movie.title = @"Star Wars IV";
    [studio addMoviesObject:movie];
    [movie setListNumber];
}

- (void)tearDown
{
    [super tearDown];

    [studio release];
    [NSManagedObjectContext clearDefaultManagedObjectContextAndDeleteStoreFile];
}

- (void)dealloc
{
    [super dealloc];
}


#pragma mark -
#pragma mark Helpers


#pragma mark -
#pragma mark Tests

- (void)testShollowDict
{
    NSDictionary *expected = [NSDictionary dictionaryWithObjectsAndKeys:@"LUCASFILM", @"name", [NSNumber numberWithInt:1], @"position", nil ];
    ASSERT_EQUAL(expected, [studio serializableDictionary]);
}

- (void)testDeepDict
{
    NSDictionary *expected = [NSDictionary dictionaryWithObjectsAndKeys:
            @"LUCASFILM", @"name",
            [NSNumber numberWithInt:1], @"position", 
            [NSArray arrayWithObjects:
                [NSDictionary dictionaryWithObjectsAndKeys:@"Star Wars IV", @"title", [NSNumber numberWithInt:1], @"position", nil],
                nil], @"movies",
        nil ];
    
    ASSERT_EQUAL(expected, [studio serializableDictionaryWithShallowInfo:NO]);
}

- (void)testDictByType
{
    TypeTestEntity *eo = [TypeTestEntity create];
    eo.createdAt = [NSDate dateWithYear:2010 month:7 day:21 hour:0 minute:0 second:0];
    eo.boolValue = [NSNumber numberWithBool:YES];
    eo.intValue = [NSNumber numberWithInt:123];
    eo.doubleValue = [NSNumber numberWithDouble:1.23];
    eo.stringValue = @"abcd";
    NSDictionary *expected = [NSDictionary dictionaryWithObjectsAndKeys:
                    [NSNumber numberWithBool:YES], @"boolValue",
                    @"2010/07/21 0:00:00", @"createdAt",
                    [NSNumber numberWithDouble:1.23], @"doubleValue",
                    [NSNumber numberWithInt:123], @"intValue",
                    @"abcd", @"stringValue",
                nil];
                
    ASSERT_EQUAL(expected, [eo serializableDictionary]);
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
