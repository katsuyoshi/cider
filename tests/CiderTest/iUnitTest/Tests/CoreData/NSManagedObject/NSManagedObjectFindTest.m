//
//  NSManagedObjectFindTest.m
//  CiderTest
//
//  Created by Katsuyoshi Ito on 09/08/06.
//  Copyright 2009 ITO SOFT DESIGN Inc. All rights reserved.
//

#import "NSManagedObjectFindTest.h"
#import "ISMovie.h"


@implementation NSManagedObjectFindTest

- (void)setUp
{
    [super setUp];
    [[ISMovie create] setTitle:@"Star Wars IV"];
    [[ISMovie create] setTitle:@"Star Wars VI"];
    [[ISMovie create] setTitle:@"Star Wars V"];
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

- (void)findAllWithPredicateSortDescriptors
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title BEGINSWITH %@", @"Star Wars"];
    NSArray *sortDescriptors = [NSSortDescriptor sortDescriptorsWithString:@"title"];
    NSError *error = nil;
    NSArray *result = [ISMovie findAllWithPredicate:predicate sortDescriptors:sortDescriptors error:&error];
    
    ASSERT_NIL(error);
    ASSERT_EQUAL_INT(3, [result count]);
    ASSERT_EQUAL(@"Star Wars IV", [[result objectAtIndex:0] title]);
    ASSERT_EQUAL(@"Star Wars V", [[result objectAtIndex:1] title]);
    ASSERT_EQUAL(@"Star Wars VI", [[result objectAtIndex:2] title]);
}

- (void)testFindWithPredicateSortDescriptors
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title = %@", @"Star Wars IV"];
    NSArray *sortDescriptors = [NSSortDescriptor sortDescriptorsWithString:@"title"];
    NSError *error = nil;
    ISMovie *movie = [ISMovie findWithPredicate:predicate sortDescriptors:sortDescriptors error:&error];
    
    ASSERT_NIL(error);
    ASSERT_NOT_NIL(movie);
    ASSERT_EQUAL(@"Star Wars IV", movie.title);
}


- (void)testFindAllWithNil
{
    NSError *error = nil;
    NSArray *result = [ISMovie findAll:nil error:&error];
    
    ASSERT_NIL(error);
    ASSERT_EQUAL_INT(3, [result count]);
}

- (void)testFindWithNil
{
    NSError *error = nil;
    ISMovie *movie = [ISMovie find:nil error:&error];
    
    ASSERT_NIL(error);
    ASSERT_NOT_NIL(movie);
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
