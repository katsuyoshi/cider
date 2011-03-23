//
//  NSManagedObjectContextSynchronize.h
//  iKomachi
//
//  Created by Katsuyoshi Ito on 11/03/07.
//  Copyright 2011 ITO SOFT DESIGN Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface NSManagedObjectContext(ISSynchronize)

- (void)refreshAllObject;
- (void)refreshAllObjectOfEntity:(NSEntityDescription *)description;
- (void)refreshAllObjectOfEntityName:(NSString *)name;

@end
