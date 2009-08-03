//
//  NSSortDescriptorExtensionTest.m
//  CiderTest
//
//  Created by Katsuyoshi Ito on 09/08/03.
//  Copyright 2009 ITO SOFT DESIGN Inc. All rights reserved.
//

#import "NSSortDescriptorExtensionTest.h"
#import "NSSortDescriptorExtension.h"


@implementation NSSortDescriptorExtensionTest

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
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

- (void)testSortDescriptorsWithString
{
    NSArray *sortDescriptors;
    
    sortDescriptors = [NSSortDescriptor sortDescriptorsWithString:@"title"];
    ASSERT_EQUAL_INT(1, [sortDescriptors count]);
    ASSERT_EQUAL(@"title", [[sortDescriptors objectAtIndex:0] key]);
    ASSERT([[sortDescriptors objectAtIndex:0] ascending]);

    sortDescriptors = [NSSortDescriptor sortDescriptorsWithString:@"title asc"];
    ASSERT_EQUAL_INT(1, [sortDescriptors count]);
    ASSERT_EQUAL(@"title", [[sortDescriptors objectAtIndex:0] key]);
    ASSERT([[sortDescriptors objectAtIndex:0] ascending]);

    sortDescriptors = [NSSortDescriptor sortDescriptorsWithString:@"title desc"];
    ASSERT_EQUAL_INT(1, [sortDescriptors count]);
    ASSERT_EQUAL(@"title", [[sortDescriptors objectAtIndex:0] key]);
    ASSERT(![[sortDescriptors objectAtIndex:0] ascending]);

    sortDescriptors = [NSSortDescriptor sortDescriptorsWithString:@"title, date"];
    ASSERT_EQUAL_INT(2, [sortDescriptors count]);
    ASSERT_EQUAL(@"title", [[sortDescriptors objectAtIndex:0] key]);
    ASSERT([[sortDescriptors objectAtIndex:0] ascending]);
    ASSERT_EQUAL(@"date", [[sortDescriptors objectAtIndex:1] key]);
    ASSERT([[sortDescriptors objectAtIndex:1] ascending]);

    sortDescriptors = [NSSortDescriptor sortDescriptorsWithString:@"title desc, date desc"];
    ASSERT_EQUAL_INT(2, [sortDescriptors count]);
    ASSERT_EQUAL(@"title", [[sortDescriptors objectAtIndex:0] key]);
    ASSERT(![[sortDescriptors objectAtIndex:0] ascending]);
    ASSERT_EQUAL(@"date", [[sortDescriptors objectAtIndex:1] key]);
    ASSERT(![[sortDescriptors objectAtIndex:1] ascending]);
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
