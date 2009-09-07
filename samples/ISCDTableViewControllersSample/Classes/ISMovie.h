//
//  ISMovie.h
//  ISCDTableViewControllersSample
//
//  Created by Katsuyoshi Ito on 09/09/08.
//  Copyright 2009 ITO SOFT DESIGN Inc. All rights reserved.
//

#import <CoreData/CoreData.h>

@class ISStudio;

@interface ISMovie :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber * position;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) ISStudio * studio;

@end



