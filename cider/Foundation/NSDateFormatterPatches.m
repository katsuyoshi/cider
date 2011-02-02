//
//  NSDateFormatterPatches.m
//  tandr
//
//  Created by Katsuyoshi Ito on 11/02/02.
//  Copyright 2011 ITO SOFT DESIGN Inc. All rights reserved.
//

#import "NSDateFormatterPatches.h"


@implementation NSDateFormatter(ISPatch)

+ (NSDateFormatter *)dateFormatterWithCurrentLocale
{
    NSDateFormatter *formatter = [[NSDateFormatter new] autorelease];
    [formatter setLocale:[NSLocale currentLocale]];
    return formatter;
}

@end
