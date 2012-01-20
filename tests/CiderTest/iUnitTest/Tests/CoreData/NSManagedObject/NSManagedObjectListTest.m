//
//  NSManagedObjectListTest.m
//  CiderTest
//
//  Created by Katsuyoshi Ito on 09/08/27.
//  Copyright 2009 ITO SOFT DESIGN Inc. All rights reserved.
//

#import "NSManagedObjectListTest.h"
#import "CiderCoreData.h"
#import "ISStudio.h"
#import "ISMovie.h"
#import "ListTest1.h"
#import "ListTest2.h"


@implementation NSManagedObjectListTest

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

- (void)testListWithoutScope
{
    ISStudio *studio;
    
    studio = [ISStudio create];
    studio.name = @"LUCASFILM";
    [[NSManagedObjectContext defaultManagedObjectContext] save:NULL];
    ASSERT_EQUAL([NSNumber numberWithInt:1], studio.position);

    studio = [ISStudio create];
    studio.name = @"PIXAR";
    [[NSManagedObjectContext defaultManagedObjectContext] save:NULL];
    ASSERT_EQUAL([NSNumber numberWithInt:2], studio.position);

}


- (void)testListWithScope
{
    ISStudio *lucasfilm;
    ISStudio *pixar;
    ISMovie *movie;

    // prepare studios
    lucasfilm = [ISStudio create];
    lucasfilm.name = @"LUCASFILM";
    pixar = [ISStudio create];
    pixar.name = @"PIXAR";
    [[NSManagedObjectContext defaultManagedObjectContext] save:NULL];



    // 
    movie = [ISMovie create];
    movie.title = @"Star Wars IV";
    [lucasfilm addMoviesObject:movie];
    [[NSManagedObjectContext defaultManagedObjectContext] save:NULL];
    ASSERT_EQUAL([NSNumber numberWithInt:1], movie.position);
    
    movie = [ISMovie create];
    movie.title = @"Star Wars V";
    [lucasfilm addMoviesObject:movie];
    [[NSManagedObjectContext defaultManagedObjectContext] save:NULL];
    ASSERT_EQUAL([NSNumber numberWithInt:2], movie.position);
    
    movie = [ISMovie create];
    movie.title = @"Star Wars VI";
    [lucasfilm addMoviesObject:movie];
    [[NSManagedObjectContext defaultManagedObjectContext] save:NULL];
    ASSERT_EQUAL([NSNumber numberWithInt:3], movie.position);

    // 
    movie = [ISMovie create];
    movie.title = @"Toy Story";
    [pixar addMoviesObject:movie];
    [[NSManagedObjectContext defaultManagedObjectContext] save:NULL];
    ASSERT_EQUAL([NSNumber numberWithInt:1], movie.position);
    
    movie = [ISMovie create];
    movie.title = @"Toy Story 2";
    [pixar addMoviesObject:movie];
    [[NSManagedObjectContext defaultManagedObjectContext] save:NULL];
    ASSERT_EQUAL([NSNumber numberWithInt:2], movie.position);
    
}

- (void)testListWithBunchOfObject
{
    ISStudio *studio;

    // prepare studios
    studio = [ISStudio create];
    studio.name = @"LUCASFILM";
    [[NSManagedObjectContext defaultManagedObjectContext] save:NULL];

    movie1 = [ISMovie create];
    movie1.title = @"Star Wars IV";
    [studio addMoviesObject:movie1];
    [movie1 setListNumber];
    
    movie2 = [ISMovie create];
    movie2.title = @"Star Wars V";
    [studio addMoviesObject:movie2];
    [movie2 setListNumber];
    
    movie3 = [ISMovie create];
    movie3.title = @"Star Wars VI";
    [studio addMoviesObject:movie3];
    [movie3 setListNumber];
    [movie3 setListNumber];
    
    
    ASSERT_EQUAL([NSNumber numberWithInt:1], movie1.position);
    ASSERT_EQUAL([NSNumber numberWithInt:2], movie2.position);
    ASSERT_EQUAL([NSNumber numberWithInt:3], movie3.position);

    [[NSManagedObjectContext defaultManagedObjectContext] save:NULL];

    ASSERT_EQUAL([NSNumber numberWithInt:1], movie1.position);
    ASSERT_EQUAL([NSNumber numberWithInt:2], movie2.position);
    ASSERT_EQUAL([NSNumber numberWithInt:3], movie3.position);
}


- (void)testListWithoutScopeAndSpecifiedAttribute
{
    ListTest1 *list;
    
    list = [ListTest1 create];
    [[NSManagedObjectContext defaultManagedObjectContext] save:NULL];
    ASSERT_EQUAL([NSNumber numberWithInt:1], list.index);

    list = [ListTest1 create];
    [[NSManagedObjectContext defaultManagedObjectContext] save:NULL];
    ASSERT_EQUAL([NSNumber numberWithInt:2], list.index);
}

- (void)testListWithoutScopeAndNoAttribute
{
    [ListTest2 create];
    [[NSManagedObjectContext defaultManagedObjectContext] save:NULL];
}


- (void)testRebuildListNumber
{
    ISStudio *studio;

    // prepare studios
    studio = [ISStudio create];
    studio.name = @"LUCASFILM";
    [[NSManagedObjectContext defaultManagedObjectContext] save:NULL];

    movie1 = [ISMovie create];
    movie1.title = @"Star Wars IV";
    [studio addMoviesObject:movie1];
    
    movie2 = [ISMovie create];
    movie2.title = @"Star Wars V";
    [studio addMoviesObject:movie2];
    
    movie3 = [ISMovie create];
    movie3.title = @"Star Wars VI";
    [studio addMoviesObject:movie3];

    [movie1 rebuildListNumber:[NSArray arrayWithObjects:movie1, movie2, movie3, nil]];
    
    
    ASSERT_EQUAL([NSNumber numberWithInt:1], movie1.position);
    ASSERT_EQUAL([NSNumber numberWithInt:2], movie2.position);
    ASSERT_EQUAL([NSNumber numberWithInt:3], movie3.position);
}

- (void)testRebuildListNumberWithIndex
{
    ISStudio *studio;

    // prepare studios
    studio = [ISStudio create];
    studio.name = @"LUCASFILM";
    [[NSManagedObjectContext defaultManagedObjectContext] save:NULL];

    movie1 = [ISMovie create];
    movie1.title = @"Star Wars IV";
    [studio addMoviesObject:movie1];
    
    movie2 = [ISMovie create];
    movie2.title = @"Star Wars V";
    [studio addMoviesObject:movie2];
    
    movie3 = [ISMovie create];
    movie3.title = @"Star Wars VI";
    [studio addMoviesObject:movie3];

    [movie1 rebuildListNumber:[NSArray arrayWithObjects:movie1, movie2, movie3, nil] fromIndex:10];
    
    
    ASSERT_EQUAL([NSNumber numberWithInt:10], movie1.position);
    ASSERT_EQUAL([NSNumber numberWithInt:11], movie2.position);
    ASSERT_EQUAL([NSNumber numberWithInt:12], movie3.position);
}

- (void)testRebuildListNumberRewrite
{
    ISStudio *studio;

    // prepare studios
    studio = [ISStudio create];
    studio.name = @"LUCASFILM";
    [[NSManagedObjectContext defaultManagedObjectContext] save:NULL];

    movie1 = [ISMovie create];
    movie1.title = @"Star Wars IV";
    movie1.position = [NSNumber numberWithInt:10];
    [studio addMoviesObject:movie1];
    
    movie2 = [ISMovie create];
    movie2.title = @"Star Wars V";
    movie2.position = [NSNumber numberWithInt:13];
    [studio addMoviesObject:movie2];
    
    movie3 = [ISMovie create];
    movie3.title = @"Star Wars VI";
    movie3.position = [NSNumber numberWithInt:20];
    [studio addMoviesObject:movie3];

    [movie1 rebuildListNumber:[NSArray arrayWithObjects:movie1, movie2, movie3, nil]];
    
    
    ASSERT_EQUAL([NSNumber numberWithInt:1], movie1.position);
    ASSERT_EQUAL([NSNumber numberWithInt:2], movie2.position);
    ASSERT_EQUAL([NSNumber numberWithInt:3], movie3.position);
}

- (void)testRebuildListNumberWithNoObjects
{
    ISStudio *studio;

    // prepare studios
    studio = [ISStudio create];
    studio.name = @"LUCASFILM";
    [[NSManagedObjectContext defaultManagedObjectContext] save:NULL];

    movie1 = [ISMovie create];
    movie1.title = @"Star Wars IV";
    movie1.position = [NSNumber numberWithInt:10];
    [studio addMoviesObject:movie1];
    
    movie2 = [ISMovie create];
    movie2.title = @"Star Wars V";
    movie2.position = [NSNumber numberWithInt:13];
    [studio addMoviesObject:movie2];
    
    movie3 = [ISMovie create];
    movie3.title = @"Star Wars VI";
    movie3.position = [NSNumber numberWithInt:20];
    [studio addMoviesObject:movie3];

    [movie1 rebuildListNumber:nil];
    
    NSArray *result = [[NSArray arrayWithObjects:movie1, movie2, movie3, nil] valueForKey:@"position"];
    result = [result sortedArrayUsingSelector:@selector(compare:)];
    
    NSArray *expected = [NSArray arrayWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:2], [NSNumber numberWithInt:3], nil];
    ASSERT_EQUAL(expected, result);
}


- (void)prepareDataForMoveTo
{
    ISStudio *studio;

    // prepare studios
    studio = [ISStudio create];
    studio.name = @"LUCASFILM";
    [[NSManagedObjectContext defaultManagedObjectContext] save:NULL];

    movie1 = [ISMovie create];
    movie1.title = @"Star Wars IV";
    movie1.position = [NSNumber numberWithInt:1];
    [studio addMoviesObject:movie1];
    
    movie2 = [ISMovie create];
    movie2.title = @"Star Wars V";
    movie2.position = [NSNumber numberWithInt:2];
    [studio addMoviesObject:movie2];
    
    movie3 = [ISMovie create];
    movie3.title = @"Star Wars VI";
    movie3.position = [NSNumber numberWithInt:3];
    [studio addMoviesObject:movie3];
}

- (void)testMove1To1
{
    [self prepareDataForMoveTo];

    [movie1 moveTo:movie1];
    
    ASSERT_EQUAL([NSNumber numberWithInt:1], movie1.position);
    ASSERT_EQUAL([NSNumber numberWithInt:2], movie2.position);
    ASSERT_EQUAL([NSNumber numberWithInt:3], movie3.position);
}

- (void)testMove1To2
{
    [self prepareDataForMoveTo];

    [movie1 moveTo:movie2];
    
    ASSERT_EQUAL([NSNumber numberWithInt:2], movie1.position);
    ASSERT_EQUAL([NSNumber numberWithInt:1], movie2.position);
    ASSERT_EQUAL([NSNumber numberWithInt:3], movie3.position);
}

- (void)testMove1To3
{
    [self prepareDataForMoveTo];

    [movie1 moveTo:movie3];
    
    ASSERT_EQUAL([NSNumber numberWithInt:3], movie1.position);
    ASSERT_EQUAL([NSNumber numberWithInt:1], movie2.position);
    ASSERT_EQUAL([NSNumber numberWithInt:2], movie3.position);
}

- (void)testMove2To1
{
    [self prepareDataForMoveTo];

    [movie2 moveTo:movie1];
    
    ASSERT_EQUAL([NSNumber numberWithInt:2], movie1.position);
    ASSERT_EQUAL([NSNumber numberWithInt:1], movie2.position);
    ASSERT_EQUAL([NSNumber numberWithInt:3], movie3.position);
}

- (void)testMove2To2
{
    [self prepareDataForMoveTo];

    [movie2 moveTo:movie2];
    
    ASSERT_EQUAL([NSNumber numberWithInt:1], movie1.position);
    ASSERT_EQUAL([NSNumber numberWithInt:2], movie2.position);
    ASSERT_EQUAL([NSNumber numberWithInt:3], movie3.position);
}

- (void)testMove2To3
{
    [self prepareDataForMoveTo];

    [movie2 moveTo:movie3];
    
    ASSERT_EQUAL([NSNumber numberWithInt:1], movie1.position);
    ASSERT_EQUAL([NSNumber numberWithInt:3], movie2.position);
    ASSERT_EQUAL([NSNumber numberWithInt:2], movie3.position);
}

- (void)testMove3To1
{
    [self prepareDataForMoveTo];

    [movie3 moveTo:movie1];
    
    ASSERT_EQUAL([NSNumber numberWithInt:2], movie1.position);
    ASSERT_EQUAL([NSNumber numberWithInt:3], movie2.position);
    ASSERT_EQUAL([NSNumber numberWithInt:1], movie3.position);
}

- (void)testMove3To2
{
    [self prepareDataForMoveTo];

    [movie3 moveTo:movie2];
    
    ASSERT_EQUAL([NSNumber numberWithInt:1], movie1.position);
    ASSERT_EQUAL([NSNumber numberWithInt:3], movie2.position);
    ASSERT_EQUAL([NSNumber numberWithInt:2], movie3.position);
}

- (void)testMove3To3
{
    [self prepareDataForMoveTo];

    [movie3 moveTo:movie3];
    
    ASSERT_EQUAL([NSNumber numberWithInt:1], movie1.position);
    ASSERT_EQUAL([NSNumber numberWithInt:2], movie2.position);
    ASSERT_EQUAL([NSNumber numberWithInt:3], movie3.position);
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
