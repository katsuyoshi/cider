//
//  NSManagedObjectListExtensionTest.m
//  CiderTest
//
//  Created by 伊藤ソフトデザイン on 10/04/18.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "NSManagedObjectListExtensionTest.h"
#import "ISCDListTableViewController.h"
#import "ListTest1.h"
#import "ListTest3.h"



@implementation NSManagedObjectListExtensionTest

- (void)testSortDescriptorsStringForTableViewControllerCaseListTest1
{
    NSString *sortDescriptorsStr = [ListTest1 sortDescriptorsStringForTableViewController:nil];
    ASSERT_EQUAL(@"index", sortDescriptorsStr);
}


// +listAttributeName未設定の場合は
// attributesから引っ張ってくる
- (void)testSortDescriptorsStringForTableViewControllerCaseListTest3
{
    NSString *sortDescriptorsStr = [ListTest3 sortDescriptorsStringForTableViewController:nil];
    ASSERT_EQUAL(@"index", sortDescriptorsStr);
}

@end
