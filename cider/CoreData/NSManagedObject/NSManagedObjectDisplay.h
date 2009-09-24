//
//  NSManagedObjectDisplay.h
//  tandr
//
//  Created by Katsuyoshi Ito on 09/09/24.
//  Copyright 2009 ITO SOFT DESIGN Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface NSManagedObject(ISDisplay)

- (NSFormatter *)formatterForAttribute:(NSString *)attributeName;

- (id)convertFromString:(NSString *)value attribute:(NSString *)attributeName;


@end
