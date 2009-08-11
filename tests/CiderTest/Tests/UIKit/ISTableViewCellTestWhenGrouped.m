//
//  ISTableViewCellTestWhenGrouped.m
//  CiderTest
//
//  Created by Katsuyoshi Ito on 09/07/30.
//  Copyright 2009 ITO SOFT DESIGN Inc. All rights reserved.
//

#import "ISTableViewCellTestWhenGrouped.h"
#import "UITableViewControllerTestHelper.h"
#import "ISTableViewCell.h"



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

- (void)testISTableViewCellStyleDefault
{
    ISTableViewCell *cell = (ISTableViewCell *)CELL(0, 0);
    ASSERT_EQUAL_FLOAT(17.0, cell.textLabel.font.pointSize);
}

- (void)testISTableViewCellStyleValue1
{
    ISTableViewCell *cell = (ISTableViewCell *)CELL(1, 0);
    
    ASSERT_EQUAL_FLOAT(17.0, cell.textLabel.font.pointSize);
    ASSERT_EQUAL_FLOAT(17.0, cell.detailTextLabel.font.pointSize);
}

- (void)testISTableViewCellStyleValue2
{
    ISTableViewCell *cell = (ISTableViewCell *)CELL(2, 0);
    
    ASSERT_EQUAL_FLOAT(13.0, cell.textLabel.font.pointSize);
    ASSERT_EQUAL_FLOAT(15.0, cell.detailTextLabel.font.pointSize);
}

- (void)testISTableViewCellStyleSubtitle
{
    ISTableViewCell *cell = (ISTableViewCell *)CELL(3, 0);
    
    ASSERT_EQUAL_FLOAT(18.0, cell.textLabel.font.pointSize);
    ASSERT_EQUAL_FLOAT(14.0, cell.detailTextLabel.font.pointSize);
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
