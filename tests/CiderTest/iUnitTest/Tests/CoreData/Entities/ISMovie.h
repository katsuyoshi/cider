//
//  ISMovie.h
//  CiderTest
//
//  Created by Katsuyoshi Ito on 09/08/03.
//  Copyright 2009 ITO SOFT DESIGN Inc. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "CiderCoreData.h"


@interface ISMovie :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSManagedObject * studio;
@property (nonatomic, retain) NSNumber * position;

@end



