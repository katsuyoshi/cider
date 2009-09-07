//
//  ISCDListTableViewControllerTest.m
//  CiderTest
//
//  Created by Katsuyoshi Ito on 09/09/07.
//  Copyright 2009 ITO SOFT DESIGN Inc. All rights reserved.
//

#import "ISCDListTableViewControllerTest.h"
#import "CiderCoreData.h"
#import "UITableViewControllerTestHelper.h"
#import "ISStudio.h"


@implementation ISCDListTableViewControllerTest


#pragma mark -
#pragma mark Helpers


#pragma mark -
#pragma mark about your view controller class

- (NSString *)viewControllerName
{
    // TODO: replace your table view controller's name
    return @"ISCDListTableViewController";
}

/*
- (NSString *)viewControllerNibName
{
    // TODO: replace your nib file name.
    return nil;
}
*/

/*
- (UITableViewStyle)tableViewStyle
{
    return UITableViewStyleGrouped;
}
*/

- (BOOL)hasNavigationController
{
    return YES;
}

/*
- (BOOL)hasTabBarController
{
    return YES;
}
*/

#pragma mark -
#pragma mark setUp/tearDown

- (NSNumber *)willSetUp
{
    NSNumber *result = [super willSetUp];
    
    ISStudio *studio;
    studio = [ISStudio create];
    [studio setName:@"LUCASFILM"];
    [studio setListNumber];
    
    studio = [ISStudio create];
    [studio setName:@"PIXAR"];
    [studio setListNumber];
    
    [[NSManagedObjectContext defaultManagedObjectContext] save:NULL];
    
    return result;
}

    
- (void)setUp
{
    [super setUp];
    
    ISCDListTableViewController *controller = (ISCDListTableViewController *)self.tableViewController;
    controller.displayKey = @"name";
    controller.entityName = @"ISStudio";
}

- (void)tearDown
{
    [super tearDown];
}

- (NSNumber *)didTearDown
{
    [NSManagedObjectContext clearDefaultManagedObjectContextAndDeleteStoreFile];
    return [super didTearDown];
}

#pragma mark -
#pragma mark Tests


- (void)testCells
{
    ASSERT_EQUAL_INT(1, NUMBER_OF_SECTIONS());
    ASSERT_EQUAL_INT(2, NUMBER_OF_ROWS_IN_SECTION(0));
    
    ISTableViewCell *cell;
    
    cell = (ISTableViewCell *)CELL(0, 0);
    ASSERT_EQUAL(@"LUCASFILM", cell.textLabel.text);
    ASSERT_EQUAL_INT(UITableViewCellAccessoryDisclosureIndicator, cell.accessoryType);

    cell = (ISTableViewCell *)CELL(1, 0);
    ASSERT_EQUAL(@"PIXAR", cell.textLabel.text);
    ASSERT_EQUAL_INT(UITableViewCellAccessoryDisclosureIndicator, cell.accessoryType);
}

- (void)testEditing
{
    self.tableViewController.editing = YES;
    
    ASSERT_EQUAL_INT(1, NUMBER_OF_SECTIONS());
    ASSERT_EQUAL_INT(3, NUMBER_OF_ROWS_IN_SECTION(0));
    
    ISTableViewCell *cell;
    
    cell = (ISTableViewCell *)CELL(0, 0);
    ASSERT_EQUAL(@"New ISStudio", cell.textLabel.text);
    ASSERT_EQUAL_INT(UITableViewCellEditingStyleInsert, EDITING_STYLE(0, 0));
    ASSERT_EQUAL_INT(UITableViewCellAccessoryDisclosureIndicator, cell.editingAccessoryType);

    cell = (ISTableViewCell *)CELL(1, 0);
    ASSERT_EQUAL(@"LUCASFILM", cell.textLabel.text);
    ASSERT_EQUAL_INT(UITableViewCellEditingStyleDelete, EDITING_STYLE(1, 0));
    ASSERT_EQUAL_INT(UITableViewCellAccessoryDisclosureIndicator, cell.editingAccessoryType);
    
    cell = (ISTableViewCell *)CELL(2, 0);
    ASSERT_EQUAL(@"PIXAR", cell.textLabel.text);
    ASSERT_EQUAL_INT(UITableViewCellEditingStyleDelete, EDITING_STYLE(1, 0));
    ASSERT_EQUAL_INT(UITableViewCellAccessoryDisclosureIndicator, cell.editingAccessoryType);
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
