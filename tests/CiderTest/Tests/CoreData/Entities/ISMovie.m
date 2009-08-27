// 
//  ISMovie.m
//  CiderTest
//
//  Created by Katsuyoshi Ito on 09/08/03.
//  Copyright 2009 ITO SOFT DESIGN Inc. All rights reserved.
//

#import "ISMovie.h"


@implementation ISMovie 

@dynamic title;
@dynamic studio;
@dynamic position;

+ (NSString *)listScopeName
{
    return @"studio";
}

@end
