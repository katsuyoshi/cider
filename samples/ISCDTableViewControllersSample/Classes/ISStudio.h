//
//  ISStudio.h
//  ISCDTableViewControllersSample
//
//  Created by Katsuyoshi Ito on 09/09/08.
//  Copyright 2009 ITO SOFT DESIGN Inc. All rights reserved.
//

#import <CoreData/CoreData.h>

@class ISMovie;

@interface ISStudio :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber * position;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet* movies;

@end


@interface ISStudio (CoreDataGeneratedAccessors)
- (void)addMoviesObject:(ISMovie *)value;
- (void)removeMoviesObject:(ISMovie *)value;
- (void)addMovies:(NSSet *)value;
- (void)removeMovies:(NSSet *)value;

@end

