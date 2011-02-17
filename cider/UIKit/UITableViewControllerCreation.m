//
//  UITableViewControllerCreation.m
//  iKomachi
//
//  Created by Katsuyoshi Ito on 11/02/15.
//  Copyright 2011 ITO SOFT DESIGN Inc. All rights reserved.
//

#import "UITableViewControllerCreation.h"


@implementation UITableViewController(ISCreation)

+ (id)tableViewController
{
    return [[[self alloc] initWithStyle:UITableViewStylePlain] autorelease];
}

+ (id)groupedTableViewController
{
    return [[[self alloc] initWithStyle:UITableViewStyleGrouped] autorelease];
}

@end
