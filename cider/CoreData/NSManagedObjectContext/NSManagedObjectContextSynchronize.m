//
//  NSManagedObjectContextSynchronize.m
//  iKomachi
//
//  Created by Katsuyoshi Ito on 11/03/07.
//  Copyright 2011 ITO SOFT DESIGN Inc. All rights reserved.
//

#import "NSManagedObjectContextSynchronize.h"


@implementation NSManagedObjectContext(ISSynchronize)

- (void)refreshAllObject
{
    for (NSManagedObject *eo in [self registeredObjects]) {
        [self refreshObject:eo mergeChanges:NO];
    }
}

- (void)refreshAllObjectOfEntity:(NSEntityDescription *)entity
{
    for (NSManagedObject *eo in [self registeredObjects]) {
        if ([[eo entity] isEqual:entity]) {
            [self refreshObject:eo mergeChanges:NO];
        }
    }
}

- (void)refreshAllObjectOfEntityName:(NSString *)name
{
    [self refreshAllObjectOfEntity:[NSEntityDescription entityForName:name inManagedObjectContext:self]];
}


@end
