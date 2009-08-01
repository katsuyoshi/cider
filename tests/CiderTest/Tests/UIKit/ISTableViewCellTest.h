//
//  ISTableViewCellTest.h
//  CiderTest
//
//  Created by Katsuyoshi Ito on 09/07/29.
//  Copyright 2009 ITO SOFT DESIGN Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UITableViewBasedTest.h"
#import "TableViewControllerForISTableViewCell.h"


@interface ISTableViewCellTest : UITableViewBasedTest {

    // TODO: replace your view controller
    TableViewControllerForISTableViewCell *controller;
    
}

@property (assign, readonly) TableViewControllerForISTableViewCell *controller;

@end
