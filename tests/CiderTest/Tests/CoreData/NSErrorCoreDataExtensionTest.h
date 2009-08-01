//
//  NSErrorExtensionTest.h
//  CiderTest
//
//  Created by Katsuyoshi Ito on 09/08/01.
//  Copyright 2009 ITO SOFT DESIGN Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IUTTest.h"


@interface NSErrorCoreDataExtensionTest : IUTTest {

    NSError *myDomainError;
    NSError *error;
	NSError *deepError;
    
    UIAlertView *alertView;
}

@end
