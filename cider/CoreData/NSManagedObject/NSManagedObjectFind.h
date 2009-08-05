//
//  NSManagedObjectFind.h
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

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "ISFetchRequestCondition.h"


@interface NSManagedObject(ISFind)

#pragma mark -
#pragma mark Primitive methods

/**
 * Find objects by spcified condition.
 * Primitive method.
*/
+ (NSArray *)findAllWithCondition:(ISFetchRequestCondition *)condition error:(NSError **)error;

/**
 * Find an object by spcified condition.
 * Primitive method.
*/
+ (id)findWithCondition:(ISFetchRequestCondition *)condition error:(NSError **)error;

/** Alias of findAllWithCondition:error: */
+ (NSArray *)findAll:(ISFetchRequestCondition *)condition error:(NSError **)error;

/** Alias of findWithCondition:error: */
+ (id)find:(ISFetchRequestCondition *)condition error:(NSError **)error;

#pragma mark -
#pragma mark for NSManagedObject

#pragma mark findAll

/** Find objects. */
+ (NSArray *)findAllWithEntity:(NSString *)entityName predicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors managedObjectContext:(NSManagedObjectContext *)managedObjectContext error:(NSError **)error;

#pragma mark find

/** Find an object. */
+ (id)findWithEntity:(NSString *)entityName predicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors managedObjectContext:(NSManagedObjectContext *)managedObjectContext error:(NSError **)error;

#pragma mark -
#pragma mark for custom class

#pragma mark findAll

/** Find objects. */
+ (NSArray *)findAllWithPredicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors managedObjectContext:(NSManagedObjectContext *)managedObjectContext error:(NSError **)error;

/** Find objects. */
+ (NSArray *)findAllWithPredicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors error:(NSError **)error;

/** Find objects. */
+ (NSArray *)findAllWithPredicate:(NSPredicate *)predicate error:(NSError **)error;

/** Find objects. */
+ (NSArray *)findAllWithSortDiscriptors:(NSArray *)sortDescriptors error:(NSError **)error;

#pragma mark find

/** Find an object. */
+ (id)findWithPredicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors managedObjectContext:(NSManagedObjectContext *)managedObjectContext error:(NSError **)error;

/** Find an object. */
+ (id)findWithPredicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors error:(NSError **)error;

/** Find an object. */
+ (id)findWithPredicate:(NSPredicate *)predicate error:(NSError **)error;

/** Find an object. */
+ (id)findWithSortDiscriptors:(NSArray *)sortDescriptors error:(NSError **)error;

@end
