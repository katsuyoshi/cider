//
//  NSManagedObjectContextAop.m
//  ISCDTableViewControllersSample
//
//  Created by Katsuyoshi Ito on 09/09/08.
//

/* 

  Copyright 2009 ITO SOFT DESIGN Inc. All rights reserved.

  Redistribution and use in source and binary forms, with or without modification,
  are permitted provided that the following conditions are met:
  
      * Redistributions of source code must retain the above copyright notice,
        this list of conditions and the following disclaimer.
 
      * Redistributions in binary form must reproduce the above copyright notice,
        this list of conditions and the following disclaimer in the documentation
        and/or other materials provided with the distribution.
 
      * Neither the name of ITO SOFT DESIGN Inc. nor the names of its
        contributors may be used to endorse or promote products derived from this
        software without specific prior written permission.
 
  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
  ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

*/

#import "NSManagedObjectContextDefaultContext.h"
#import "NSManagedObjectContextAop.h"
#import "NSManagedObjectList.h"
#import "/usr/include/objc/objc-class.h"


@implementation NSManagedObjectContext(ISAop)


static void swap_method(Class class, SEL orgName, SEL newName)
{
    Method orgMethod = class_getInstanceMethod(class, orgName);
    Method newMethod = class_getInstanceMethod(class, newName);
    IMP tmpIMP;
    
    tmpIMP = method_getImplementation(newMethod);
    method_setImplementation(newMethod, method_getImplementation(orgMethod));
    method_setImplementation(orgMethod, tmpIMP);
}

+ (void)initializeAop
{
    static BOOL initialized = NO;
    @synchronized (self) {
        if (initialized == NO) {
            initialized = YES;
            swap_method([self class], @selector(insertObject:), @selector(IS_insertObject:));
            swap_method([self class], @selector(deleteObject:), @selector(IS_deleteObject:));
            swap_method([self class], @selector(save:), @selector(IS_save:));
        }
    }
}

- (void)IS_insertObject:(NSManagedObject *)object
{
    if ([object respondsToSelector:@selector(willInsert)]) {
        [object willInsert];
    }
    [self IS_insertObject:object];
    if ([object respondsToSelector:@selector(didInsert)]) {
        [object didInsert];
    }
}

- (void)IS_deleteObject:(NSManagedObject *)object
{
    if ([object respondsToSelector:@selector(willDelete)]) {
        [object willDelete];
    }
    [self IS_deleteObject:object];
    if ([object respondsToSelector:@selector(didDelete)]) {
        [object didDelete];
    }
}

- (BOOL)IS_save:(NSError **)error
{
    if (is_g_running_migration == NO) {
        for (NSManagedObject *object in [self insertedObjects]) {
            [object setListNumber];
        }
    }
    return [self IS_save:error];
}


@end
