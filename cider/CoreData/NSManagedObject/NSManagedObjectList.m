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

- (void)_setListNumber
{
    NSString *listAttributeName = [[self class] listAttributeName];
    NSString *listScopeName = [[self class] listScopeName];
    NSEntityDescription *entity = [self entity];

    // check attribute
    if ([listAttributeName length] == 0) {
        return;
    } else {
        if ([[entity propertiesByName] valueForKey:listAttributeName] == nil) {
            return;
        }
        NSNumber *value = [self valueForKey:listAttributeName];
        if (value && [value intValue]) {
            return;
        }
    }
    
    // check scope
    if ([listScopeName length]) {
        NSRelationshipDescription *description = [[entity relationshipsByName] valueForKey:listScopeName];
        if ([description isToMany]) {
            return;
        }
    }        
    
    
    ISFetchRequestCondition *condition = [ISFetchRequestCondition fetchRequestCondition];
    condition.managedObjectContext = [self managedObjectContext];
    condition.entityName = [[self entity] name];

    if ([listScopeName length]) {
        condition.predicate = [NSPredicate predicateWithFormat:@"%K = %@", listScopeName, [self valueForKey:listScopeName]];
    }
    condition.sortDescriptors = [NSSortDescriptor sortDescriptorsWithString:[NSString stringWithFormat:@"%@ desc", listAttributeName]];
    
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
    [self setPrimitiveValue:[NSNumber numberWithInt:index + 1] forKey:listAttributeName];
}

#pragma mark will save
- (void)willSave
{
    [self _setListNumber];
}


@end
