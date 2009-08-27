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

    ISMovie *movie1 = [ISMovie create];
    movie1.title = @"Star Wars IV";
    [studio addMoviesObject:movie1];
    [movie1 setListNumber];
    
    ISMovie *movie2 = [ISMovie create];
    movie2.title = @"Star Wars V";
    [studio addMoviesObject:movie2];
    [movie2 setListNumber];
    
    ISMovie *movie3 = [ISMovie create];
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


#pragma mark -
#pragma mark Option

// Uncomment it, if you want to test this class except other passed test classes.
//#define TESTS_ALWAYS
#ifdef TESTS_ALWAYS
- (void)testThisClassAlways { ASSERT_FAIL(@"fail always"); }
+ (BOOL)forceTestsAnyway { return YES; }
#endif

@end
