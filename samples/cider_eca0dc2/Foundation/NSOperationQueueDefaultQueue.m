//
//  NSOperationQueueDefaultQueue.m
//  Hikiyama
//
//  Created by Katsuyoshi Ito on 10/08/02.
//  Copyright 2010 ITO SOFT DESIGN Inc. All rights reserved.
//

#import "NSOperationQueueDefaultQueue.h"


@implementation NSOperationQueue(ISDefaultQueue)

+ (NSOperationQueue *)defaultQueue
{
    static id queue = nil;
    @synchronized(self) {
        if (queue == nil) {
            queue = [NSOperationQueue new];
            [queue setMaxConcurrentOperationCount:[[NSProcessInfo processInfo] activeProcessorCount] + 1];
        }
    }
    return queue;
}

@end
