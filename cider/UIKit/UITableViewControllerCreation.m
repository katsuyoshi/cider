//
//  UITableViewControllerCreation.m
//  tandr
//
//  Created by Katsuyoshi Ito on 10/09/13.
//  Copyright 2010 ITO SOFT DESIGN Inc. All rights reserved.
//

#import "UITableViewControllerCreation.h"


@implementation UITableViewController(ISCreation)

+ (UINavigationController *)navigationController
{
    return [[[UINavigationController alloc] initWithRootViewController:[self tableViewController]] autorelease];
}

+ (UINavigationController *)navigationControllerWithGroupdTableViewController
{
    return [[[UINavigationController alloc] initWithRootViewController:[self groupedTableViewController]] autorelease];
}

+ (id)tableViewController
{
    return [[[self alloc] initWithStyle:UITableViewStylePlain] autorelease];
}

+ (id)groupedTableViewController
{
    return [[[self alloc] initWithStyle:UITableViewStyleGrouped] autorelease];
}


@end
