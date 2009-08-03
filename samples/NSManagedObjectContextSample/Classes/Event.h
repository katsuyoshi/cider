//
//  Event.h
//  NSManagedObjectContextSample
//
//  Created by Katsuyoshi Ito on 09/08/04.
//  Copyright 2009 ITO SOFT DESIGN Inc. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface Event :  NSManagedObject  
{
}

@property (nonatomic, retain) NSDate * timeStamp;

@end



