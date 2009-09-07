//
//  NSManagedObjectList.m
//  CiderTest
//
//  Created by Katsuyoshi Ito on 09/08/27.
//  Copyright 2009 ITO SOFT DESIGN Inc. All rights reserved.
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

#import "NSManagedObjectList.h"
#import "ISFetchRequestCondition.h"
#import "NSErrorCoreDataExtension.h"
#import "NSErrorExtension.h"
#import "NSManagedObjectFind.h"
#import "NSSortDescriptorExtension.h"


@implementation NSManagedObject(ISActAsList)

+ (NSString *)listAttributeName
{
    return @"position";
}

+ (NSString *)listScopeName
{
    return nil;
}


#pragma mark -
#pragma mark helper

- (BOOL)listAvailable
{
    NSString *listAttributeName = [[self class] listAttributeName];
    NSString *listScopeName = [[self class] listScopeName];
    NSEntityDescription *entity = [self entity];

    // check attribute
    if ([listAttributeName length] == 0) {
        return NO;
    } else {
        if ([[entity propertiesByName] valueForKey:listAttributeName] == nil) {
            return NO;
        }
    }
    
    // check scope
    if ([listScopeName length]) {
        NSRelationshipDescription *description = [[entity relationshipsByName] valueForKey:listScopeName];
        if ([description isToMany]) {
            return NO;
        }
    }
    
    return YES;
}

- (ISFetchRequestCondition *)conditionForListWithDesc:(BOOL)desc
{
    if ([self listAvailable]) {
      
        ISFetchRequestCondition *condition = [ISFetchRequestCondition fetchRequestCondition];
        condition.managedObjectContext = [self managedObjectContext];
        condition.entityName = [[self entity] name];

        NSString *listScopeName = [[self class] listScopeName];
        if ([listScopeName length]) {
            condition.predicate = [NSPredicate predicateWithFormat:@"%K = %@", listScopeName, [self valueForKey:listScopeName]];
        }

        NSString *listAttributeName = [[self class] listAttributeName];
        condition.sortDescriptors = [NSSortDescriptor sortDescriptorsWithString:[NSString stringWithFormat:@"%@ %@", listAttributeName, desc ? @"desc" : @"asc"]];
        
        return condition;
    
    } else {
        return nil;
    }
}

- (ISFetchRequestCondition *)conditionForList
{
    return [self conditionForListWithDesc:NO];
}



#pragma mark -

- (void)setListNumber
{
    ISFetchRequestCondition *condition = [self conditionForListWithDesc:YES];
    
    if (condition) {

        NSString *listAttributeName = [[self class] listAttributeName];

        // return if value is already seted.
        NSNumber *value = [self valueForKey:listAttributeName];
        if (value && [value intValue]) {
            return;
        }


        NSError *error = nil;
    
        NSManagedObject *maxEo = [NSManagedObject find:condition error:&error];
        if (error) {
            [error showError];
        }
        NSInteger index = 0;
        if (maxEo) {
            NSNumber *indexValue = [maxEo valueForKey:listAttributeName];
            if (indexValue) {
                index = [indexValue intValue];
            }
        }
        [self setValue:[NSNumber numberWithInt:index + 1] forKey:listAttributeName];
    }
}

- (void)rebuildListNumber:(NSArray *)array
{
    [self rebuildListNumber:array fromIndex:1];
}

- (void)rebuildListNumber:(NSArray *)array fromIndex:(NSInteger)index
{
    if ([self listAvailable]) {
        if (array == nil) {
            NSError *error = nil;
            array = [NSManagedObject findAll:[self conditionForList] error:&error];
#ifdef DEBUG
            if (error) {
                [error showError];
            }
#endif
        }
    
        NSString *listAttributeName = [[self class] listAttributeName];
        for(NSManagedObject *object in array) {
            [object setValue:[NSNumber numberWithInt:index++] forKey:listAttributeName];
        }
    }
}


#pragma mark -
#pragma mark moving

- (void)moveTo:(NSManagedObject *)toObject
{
    if ([self listAvailable]) {
        NSString *listAttributeName = [[self class] listAttributeName];
        
        NSInteger from = [[self valueForKey:listAttributeName] intValue];
        NSInteger to = [[toObject valueForKey:listAttributeName] intValue];
        NSInteger minValue = (from < to) ? from : to;
        NSInteger maxValue = (from < to) ? to : from;

        ISFetchRequestCondition *condition = [self conditionForList];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K between {%d, %d}", listAttributeName, minValue, maxValue];
        if (condition.predicate) {
            NSArray *subpredicates = [NSArray arrayWithObjects:condition.predicate, predicate, nil];
            condition.predicate = [NSCompoundPredicate andPredicateWithSubpredicates:subpredicates];
        } else {
            condition.predicate = predicate;
        }
        
        NSError *error = nil;
        NSArray *result = [NSManagedObject findAll:condition error:&error];
#ifdef DEBUG
        if (error) {
            [error showError];
        }
#endif
        
        NSMutableArray *arrangedArray = [result mutableCopy];
        if (from < to) {
            id object = [[[arrangedArray objectAtIndex:0] retain] autorelease];
            [arrangedArray removeObjectAtIndex:0];
            [arrangedArray addObject:object];
        } else {
            id object = [[[arrangedArray lastObject] retain] autorelease];
            [arrangedArray removeLastObject];
            [arrangedArray insertObject:object atIndex:0];
        }
        [self rebuildListNumber:arrangedArray fromIndex:minValue];
    }
}



@end
