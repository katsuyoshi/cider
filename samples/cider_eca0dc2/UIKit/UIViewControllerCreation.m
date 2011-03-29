//
//  UIViewControllerCreation.m
//  tandr
//
//  Created by Katsuyoshi Ito on 10/09/13.
//  Copyright 2010 ITO SOFT DESIGN Inc. All rights reserved.
//

#import "UIViewControllerCreation.h"


@implementation UIViewController(ISCreation)

+ (UINavigationController *)navigationController
{
    return [[[UINavigationController alloc] initWithRootViewController:[self viewController]] autorelease];
}

+ (id)viewController
{
    return [[self new] autorelease];
}


@end
