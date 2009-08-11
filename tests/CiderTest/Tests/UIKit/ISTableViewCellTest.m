//
//  ISTableViewCellTest.m
//  CiderTest
//
//  Created by Katsuyoshi Ito on 09/07/29.
//  Copyright 2009 ITO SOFT DESIGN Inc. All rights reserved.
//

#import "ISTableViewCellTest.h"
#import "UITableViewControllerTestHelper.h"
#import "ISTableViewCell.h"



@implementation ISTableViewCellTest

@synthesize controller;


- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [controller release];
    controller = nil;
    [super tearDown];
}

- (void)dealloc
{
    [controller release];
    [super dealloc];
}

- (UITableViewController *)tableViewController
{
    // this controller will be tested.
    // TODO: replace your view controller
    controller = [[TableViewControllerForISTableViewCell alloc] initWithStyle:UITableViewStylePlain];
    return controller;
}


#pragma mark -
#pragma mark Helpers


#pragma mark -
#pragma mark Tests

#pragma mark normal style

- (void)testISTableViewCellStyleDefault
{
    ISTableViewCell *cell = (ISTableViewCell *)CELL(0, 0);
    ASSERT_EQUAL_FLOAT(20.0, cell.textLabel.font.pointSize);
}

- (void)testISTableViewCellStyleValue1
{
    ISTableViewCell *cell = (ISTableViewCell *)CELL(1, 0);
    
    ASSERT_EQUAL_FLOAT(20.0, cell.textLabel.font.pointSize);
    ASSERT_EQUAL_FLOAT(20.0, cell.detailTextLabel.font.pointSize);
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


#pragma mark editing style

- (void)testISTableViewCellEditingStyleDefault
{
    UITableViewCell *reference = CELL(0, 0);
    ISTableViewCell *cell = (ISTableViewCell *)CELL(4, 0);
    
    ASSERT_EQUAL_FLOAT(reference.textLabel.font.pointSize, cell.textField.font.pointSize);
    ASSERT_EQUAL(reference.textLabel.font.fontName, cell.textField.font.fontName);
    ASSERT_EQUAL(reference.textLabel.textColor, cell.textField.textColor);
    
    CGRect rect = reference.textLabel.frame;
    rect = CGRectMake(rect.origin.x, (int)((rect.size.height - reference.textLabel.font.pointSize - 4) / 2), rect.size.width, reference.textLabel.font.pointSize + 4);
    ASSERT_EQUAL_RECT(rect, cell.textField.frame);
}

- (void)testISTableViewCellEditingStyleValue1
{
    UITableViewCell *reference = CELL(1, 0);
    ISTableViewCell *cell = (ISTableViewCell *)CELL(5, 0);
    
    ASSERT_EQUAL_FLOAT(reference.textLabel.font.pointSize, cell.textLabel.font.pointSize);
    ASSERT_EQUAL(reference.textLabel.font.fontName, cell.textLabel.font.fontName);
    ASSERT_EQUAL_RECT(reference.textLabel.frame, cell.textLabel.frame);
    ASSERT_EQUAL(reference.textLabel.textColor, cell.textLabel.textColor);
    
    ASSERT_EQUAL_FLOAT(reference.detailTextLabel.font.pointSize, cell.detailTextField.font.pointSize);
    ASSERT_EQUAL(reference.detailTextLabel.font.fontName, cell.detailTextField.font.fontName);
    
    float width = reference.contentView.frame.size.width - CGRectGetMaxX(reference.textLabel.frame) - 10 -5;
    CGRect rect = reference.detailTextLabel.frame;
    rect = CGRectMake(CGRectGetMaxX(reference.textLabel.frame) + 5, (int)((rect.size.height - reference.detailTextLabel.font.pointSize - 4) / 2), width, reference.detailTextLabel.font.pointSize + 4);
    ASSERT_EQUAL_RECT(rect, cell.detailTextField.frame);
    ASSERT_EQUAL(reference.detailTextLabel.textColor, cell.detailTextField.textColor);
    ASSERT_EQUAL_INT(UITextAlignmentRight, cell.detailTextField.textAlignment);
}

- (void)testISTableViewCellEditingStyleValue2
{
    UITableViewCell *reference = CELL(2, 0);
    ISTableViewCell *cell = (ISTableViewCell *)CELL(6, 0);
    
    ASSERT_EQUAL_FLOAT(reference.textLabel.font.pointSize, cell.textLabel.font.pointSize);
    ASSERT_EQUAL(reference.textLabel.font.fontName, cell.textLabel.font.fontName);
    ASSERT_EQUAL_RECT(reference.textLabel.frame, cell.textLabel.frame);
    ASSERT_EQUAL(reference.textLabel.textColor, cell.textLabel.textColor);
    
    ASSERT_EQUAL_FLOAT(reference.detailTextLabel.font.pointSize, cell.detailTextField.font.pointSize);
    ASSERT_EQUAL(reference.detailTextLabel.font.fontName, cell.detailTextField.font.fontName);
    ASSERT_EQUAL_RECT(reference.detailTextLabel.frame, cell.detailTextField.frame);
    ASSERT_EQUAL(reference.detailTextLabel.textColor, cell.detailTextField.textColor);
}

- (void)testISTableViewCellEditingStyleSubtitle
{
    UITableViewCell *reference = CELL(3, 0);
    ISTableViewCell *cell = (ISTableViewCell *)CELL(7, 0);
    
    ASSERT_EQUAL_FLOAT(reference.textLabel.font.pointSize, cell.textLabel.font.pointSize);
    ASSERT_EQUAL(reference.textLabel.font.fontName, cell.textLabel.font.fontName);
    ASSERT_EQUAL_RECT(reference.textLabel.frame, cell.textLabel.frame);
    ASSERT_EQUAL(reference.textLabel.textColor, cell.textLabel.textColor);
    
    ASSERT_EQUAL_FLOAT(reference.detailTextLabel.font.pointSize, cell.detailTextField.font.pointSize);
    ASSERT_EQUAL(reference.detailTextLabel.font.fontName, cell.detailTextField.font.fontName);
    ASSERT_EQUAL_RECT(reference.detailTextLabel.frame, cell.detailTextField.frame);
    ASSERT_EQUAL(reference.detailTextLabel.textColor, cell.detailTextField.textColor);
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
