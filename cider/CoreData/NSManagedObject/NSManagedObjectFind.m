//
//  NSManagedObjectFind.m
//  CiderTest
//
//  Created by Katsuyoshi Ito on 09/08/05.
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

#import "NSManagedObjectFind.h"
#import "NSManagedObjectFetch.h"
#import "NSManagedObjectContextDefaultContext.h"


@implementation NSManagedObject(ISFind)

#pragma mark -
#pragma mark primitive methods

+ (ISFetchRequestCondition *)_normalizedCondition:(ISFetchRequestCondition *)condition
{
    if (condition == nil) {
        condition = [ISFetchRequestCondition fetchRequestCondition];
    }
    if (condition.managedObjectContext == nil) {
        condition.managedObjectContext = [NSManagedObjectContext defaultManagedObjectContext];
    }
    if (condition.entityName == nil) {
        condition.entityName = NSStringFromClass(self);
    }
    return condition;
}

+ (NSArray *)findAllWithCondition:(ISFetchRequestCondition *)condition error:(NSError **)error
{
    condition = [self _normalizedCondition:condition];
    
    NSFetchRequest *request = condition.fetchRequst;
    return [condition.managedObjectContext executeFetchRequest:request error:error];
}

+ (id)findWithCondition:(ISFetchRequestCondition *)condition error:(NSError **)error
{
    condition = [self _normalizedCondition:condition];

    NSFetchRequest *request = condition.fetchRequst;
    request.fetchLimit = 1;
    NSArray *result = [condition.managedObjectContext executeFetchRequest:request error:error];
    if ([result count]) {
        return [result lastObject];
    } else {
        return nil;
    }
}

+ (NSArray *)findAll:(ISFetchRequestCondition *)condition error:(NSError **)error
{
    return [self findAllWithCondition:condition error:error];
}

+ (id)find:(ISFetchRequestCondition *)condition error:(NSError **)error
{
    return [self findWithCondition:condition error:error];
}


#pragma mark -
#pragma mark for NSManagedObject

#pragma mark findAll

+ (NSArray *)findAllWithEntity:(NSString *)entityName predicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors managedObjectContext:(NSManagedObjectContext *)managedObjectContext error:(NSError **)error
{
    ISFetchRequestCondition *condition = [ISFetchRequestCondition fetchRequestCondition];
    condition.entityName = entityName;
    condition.predicate = predicate;
    condition.sortDescriptors = sortDescriptors;
    condition.managedObjectContext = managedObjectContext;
    return [self findAllWithCondition:condition error:error];
}

#pragma mark find

+ (id)findWithEntity:(NSString *)entityName predicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors managedObjectContext:(NSManagedObjectContext *)managedObjectContext error:(NSError **)error
{
    ISFetchRequestCondition *condition = [ISFetchRequestCondition fetchRequestCondition];
    condition.entityName = entityName;
    condition.predicate = predicate;
    condition.sortDescriptors = sortDescriptors;
    condition.managedObjectContext = managedObjectContext;
    return [self findWithCondition:condition error:error];
}

#pragma mark -
#pragma mark for custom class

#pragma mark findAll

+ (NSArray *)findAllWithPredicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors managedObjectContext:(NSManagedObjectContext *)managedObjectContext error:(NSError **)error
{
    return [self findAllWithEntity:nil predicate:predicate sortDescriptors:sortDescriptors managedObjectContext:managedObjectContext error:error];
}

+ (NSArray *)findAllWithPredicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors error:(NSError **)error
{
    return [self findAllWithEntity:nil predicate:predicate sortDescriptors:sortDescriptors managedObjectContext:nil error:error];
}

+ (NSArray *)findAllWithPredicate:(NSPredicate *)predicate error:(NSError **)error
{
    return [self findAllWithEntity:nil predicate:predicate sortDescriptors:nil managedObjectContext:nil error:error];
}

+ (NSArray *)findAllWithSortDiscriptors:(NSArray *)sortDescriptors error:(NSError **)error
{
    return [self findAllWithEntity:nil predicate:nil sortDescriptors:sortDescriptors managedObjectContext:nil error:error];
}

#pragma mark find

+ (id)findWithPredicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors managedObjectContext:(NSManagedObjectContext *)managedObjectContext error:(NSError **)error
{
    return [self findWithEntity:nil predicate:predicate sortDescriptors:sortDescriptors managedObjectContext:managedObjectContext error:error];
}

+ (id)findWithPredicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors error:(NSError **)error
{
    return [self findWithEntity:nil predicate:predicate sortDescriptors:sortDescriptors managedObjectContext:nil error:error];
}

+ (id)findWithPredicate:(NSPredicate *)predicate error:(NSError **)error
{
    return [self findWithEntity:nil predicate:predicate sortDescriptors:nil managedObjectContext:nil error:error];
}

+ (id)findWithSortDiscriptors:(NSArray *)sortDescriptors error:(NSError **)error
{
    return [self findWithEntity:nil predicate:nil sortDescriptors:sortDescriptors managedObjectContext:nil error:error];
}

@end
