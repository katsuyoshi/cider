//
//  ISEnvironment.h
//  irPanel
//
//  Created by 伊藤ソフトデザイン on 11/03/19.
//  Copyright 2011 有限会社伊藤ソフトデザイン. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ISEnvironment : NSObject {
    
}

+ (ISEnvironment *)sharedEnvironment;


// OS
@property (getter=iOS3, readonly) BOOL isIOS3;
@property (getter=iOS4, readonly) BOOL isIOS4;


@end
