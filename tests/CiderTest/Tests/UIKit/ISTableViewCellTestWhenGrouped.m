//
//  ISTableViewCellTestWhenGrouped.m
//  CiderTest
//
//  Created by Katsuyoshi Ito on 09/07/30.
//  Copyright 2009 ITO SOFT DESIGN Inc. All rights reserved.
//

#import "ISTableViewCellTestWhenGrouped.h"



@implementation ISTableViewCellTestWhenGrouped

+ (BOOL)doesCollectTestsInSuper
{
    return YES;
}

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

- (UITableViewController *)tableViewController
{
    // this controller will be tested.
    // TODO: replace your view controller
    controller = [[TableViewControllerForISTableViewCell alloc] initWithStyle:UITableViewStyleGrouped];
    return controller;
}

#pragma mark -
#pragma mark Tests



#pragma mark -
#pragma mark Option

// Uncomment it, if you want to test this class except other passed test classes.
//#define TESTS_ALWAYS
#ifdef TESTS_ALWAYS
- (void)testThisClassAlways { ASSERT_FAIL(@"fail always"); }
+ (BOOL)forceTestsAnyway { return YES; }
#endif

@end
