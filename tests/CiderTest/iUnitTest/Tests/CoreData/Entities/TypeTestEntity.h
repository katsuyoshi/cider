//
//  DateTest.h
//  CiderTest
//
//  Created by Katsuyoshi Ito on 10/07/21.
//  Copyright 2010 ITO SOFT DESIGN Inc. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface TypeTestEntity :  NSManagedObject  
{
}

@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSNumber * boolValue;
@property (nonatomic, retain) NSNumber * doubleValue;
@property (nonatomic, retain) NSNumber * intValue;
@property (nonatomic, retain) NSString * stringValue;

@end



