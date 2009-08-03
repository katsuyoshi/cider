//
//  NSManagedObjectFetchController.m
//  CiderTest
//
//  Created by Katsuyoshi Ito on 09/08/03.
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

#import "NSManagedObjectFetch.h"
#import "NSManagedObjectContextDefaultContext.h"


@implementation NSManagedObject(ISFetchController)

#pragma mark -
#pragma mark fetch request

+ (NSFetchRequest *)fetchRequestWithCondition:(ISFetchRequestCondition *)condition
{
    return [self fetchRequestWithPredicate:condition.predicate sortDiscriptors:condition.sortDiscriptors managedObjectContext:condition.managedObjectContext];
}

+ (NSFetchRequest *)fetchRequestWithPredicate:(NSPredicate *)predicate sortDiscriptors:(NSArray *)sortDiscriptors managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    if (managedObjectContext == nil) {
        managedObjectContext = [NSManagedObjectContext defaultManagedObjectContext];
    }

    NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass(self) inManagedObjectContext:managedObjectContext];
	NSFetchRequest *fetchRequest = [[NSFetchRequest new] autorelease];
	[fetchRequest setFetchBatchSize:20];
   	[fetchRequest setEntity:entity];
    [fetchRequest setPredicate:predicate];
    [fetchRequest setSortDescriptors:sortDiscriptors];

    return fetchRequest;
}

+ (NSFetchRequest *)fetchRequestWithPredicate:(NSPredicate *)predicate sortDiscriptors:(NSArray *)sortDiscriptors
{
    return [self fetchRequestWithPredicate:predicate sortDiscriptors:sortDiscriptors managedObjectContext:nil];
}

+ (NSFetchRequest *)fetchRequestWithPredicate:(NSPredicate *)predicate
{
    return [self fetchRequestWithPredicate:predicate sortDiscriptors:nil managedObjectContext:nil];
}

+ (NSFetchRequest *)fetchRequestWithSortDiscriptors:(NSArray *)sortDiscriptors
{
    return [self fetchRequestWithPredicate:nil sortDiscriptors:sortDiscriptors managedObjectContext:nil];
}

+ (NSFetchRequest *)fetchRequest
{
    return [self fetchRequestWithPredicate:nil sortDiscriptors:nil managedObjectContext:nil];
}


#pragma mark -
#pragma mark fetch result controller

+ (NSFetchedResultsController *)fetchedResultsControllerWithCondition:(ISFetchRequestCondition *)condition
{
    return [self fetchedResultsControllerWithPredicate:condition.predicate sortDiscriptors:condition.sortDiscriptors managedObjectContext:condition.managedObjectContext sectionNameKeyPath:condition.sectionNameKeyPath cacheName:condition.cacheName];
}

+ (NSFetchedResultsController *)fetchedResultsControllerWithPredicate:(NSPredicate *)predicate sortDiscriptors:(NSArray *)sortDiscriptors managedObjectContext:(NSManagedObjectContext *)managedObjectContext sectionNameKeyPath:(NSString *)sectionNameKeyPath cacheName:(NSString *)cacheName
{
    if (managedObjectContext == nil) {
        managedObjectContext = [NSManagedObjectContext defaultManagedObjectContext];
    }

    NSFetchRequest *request = [self fetchRequestWithPredicate:predicate sortDiscriptors:sortDiscriptors managedObjectContext:managedObjectContext];
	NSFetchedResultsController *controller = [[[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:managedObjectContext sectionNameKeyPath:sectionNameKeyPath cacheName:cacheName] autorelease];

    return controller;
}

+ (NSFetchedResultsController *)fetchedResultsControllerWithPredicate:(NSPredicate *)predicate sortDiscriptors:(NSArray *)sortDiscriptors sectionNameKeyPath:(NSString *)sectionNameKeyPath cacheName:(NSString *)cacheName
{
    return [self fetchedResultsControllerWithPredicate:predicate sortDiscriptors:sortDiscriptors managedObjectContext:nil sectionNameKeyPath:sectionNameKeyPath cacheName:cacheName];
}


+ (NSFetchedResultsController *)fetchedResultsControllerWithPredicate:(NSPredicate *)predicate sectionNameKeyPath:(NSString *)sectionNameKeyPath cacheName:(NSString *)cacheName
{
    return [self fetchedResultsControllerWithPredicate:predicate sortDiscriptors:nil managedObjectContext:nil sectionNameKeyPath:sectionNameKeyPath cacheName:cacheName];
}

+ (NSFetchedResultsController *)fetchedResultsControllerWithSortDiscriptors:(NSArray *)sortDiscriptors sectionNameKeyPath:(NSString *)sectionNameKeyPath cacheName:(NSString *)cacheName
{
    return [self fetchedResultsControllerWithPredicate:nil sortDiscriptors:sortDiscriptors managedObjectContext:nil sectionNameKeyPath:sectionNameKeyPath cacheName:cacheName];
}


+ (NSFetchedResultsController *)fetchedResultsControllerWithSectionNameKeyPath:(NSString *)sectionNameKeyPath cacheName:(NSString *)cacheName
{
    return [self fetchedResultsControllerWithPredicate:nil sortDiscriptors:nil managedObjectContext:nil sectionNameKeyPath:sectionNameKeyPath cacheName:cacheName];
}

@end
