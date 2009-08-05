//
//  ISFetchRequestCondition.m
//  CiderTest
//
//  Created by Katsuyoshi Ito on 09/08/04.
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

#import "ISFetchRequestCondition.h"
#import "NSManagedObjectContextDefaultContext.h"


@implementation ISFetchRequestCondition

@synthesize entityName = _entityName;
@synthesize predicate = _predicate;
@synthesize sortDescriptors = _sortDescriptors;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize sectionNameKeyPath = _sectionNameKeyPath;
@synthesize cacheName = _cacheName;


+ (ISFetchRequestCondition *)fetchRequestCondition
{
    return [[ISFetchRequestCondition new] autorelease];
}

- (void)dealloc
{
    [_entityName release];
    [_predicate release];
    [_sortDescriptors release];
    [_managedObjectContext release];
    [_sectionNameKeyPath release];
    [_cacheName release];
    
    [_fetchRequest release];
    [_fetchedResultsController release];

    [super dealloc];
}


- (NSFetchRequest *)fetchRequst
{
    if (_fetchRequest == nil) {
        if (self.managedObjectContext == nil) {
            self.managedObjectContext = [NSManagedObjectContext defaultManagedObjectContext];
        }

        if (self.entityName == nil) {
            NSString *reason = @"entityName is nil.";
            @throw [NSException exceptionWithName:@"Cider" reason:reason userInfo:[NSDictionary dictionaryWithObject:self forKey:@"self"]];
        }
    
        NSEntityDescription *entity = [NSEntityDescription entityForName:self.entityName inManagedObjectContext:self.managedObjectContext];
        _fetchRequest = [NSFetchRequest new];
        [_fetchRequest setEntity:entity];
        [_fetchRequest setPredicate:self.predicate];
        [_fetchRequest setSortDescriptors:self.sortDescriptors];
    
    }

    return _fetchRequest;
}


- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController == nil) {
        NSFetchRequest *request = self.fetchRequst;
        _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.managedObjectContext sectionNameKeyPath:self.sectionNameKeyPath cacheName:self.cacheName];

    }
    return _fetchedResultsController;
}

@end
