//
//  NSDateFormatterPatches.h
//  tandr
//
//  Created by Katsuyoshi Ito on 11/02/02.
//  Copyright 2011 ITO SOFT DESIGN Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSDateFormatter(ISPatch)

+ (NSDateFormatter *)dateFormatterWithCurrentLocale;

@end
