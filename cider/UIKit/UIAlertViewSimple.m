//
//  UIAlertViewSimple.m
//  tandr
//
//  Created by Katsuyoshi Ito on 11/03/05.
//  Copyright 2011 ITO SOFT DESIGN Inc. All rights reserved.
//

#import "UIAlertViewSimple.h"


@implementation UIAlertView(ISSimple)

+ (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message
{
    UIAlertView *alertView = [[[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"OK", nil), nil] autorelease];
    [alertView show];
}

+ (void)showErrorAlertViewWithMessage:(NSString *)message
{
    [self showAlertViewWithTitle:NSLocalizedStringFromTable(@"Error", @"cider", nil) message:message];
}

@end
