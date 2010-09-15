//
//  UITableViewControllerCreation.h
//  tandr
//
//  Created by Katsuyoshi Ito on 10/09/13.
//  Copyright 2010 ITO SOFT DESIGN Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UITableViewController(ISCreation)

+ (UINavigationController *)navigationController;
+ (UINavigationController *)navigationControllerWithGroupdTableViewController;

+ (id)tableViewController;
+ (id)groupedTableViewController;

@end
