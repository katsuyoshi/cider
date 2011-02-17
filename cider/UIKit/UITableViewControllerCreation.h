//
//  UITableViewControllerCreation.h
//  iKomachi
//
//  Created by Katsuyoshi Ito on 11/02/15.
//  Copyright 2011 ITO SOFT DESIGN Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


@interface UITableViewController(ISCreation)

+ (UINavigationController *)navigationController;
+ (UINavigationController *)navigationControllerWithGroupdTableViewController;
+ (id)tableViewController;
+ (id)groupedTableViewController;

@end
