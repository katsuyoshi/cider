//
//  ISFetchRequestCondition.h
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

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ISFetchRequestCondition : NSObject {

    NSString *_entityName;
    NSPredicate *_predicate;
    NSArray *_sortDescriptors;
    NSManagedObjectContext *_managedObjectContext;
    NSString *_sectionNameKeyPath;
    NSString *_cacheName;
    
    // output
    NSFetchRequest *_fetchRequest;
    NSFetchedResultsController *_fetchedResultsController;
}

/** An entity name for creation of NSFetchRequest or NSFetchedResultsController. */
@property (retain) NSString *entityName;

/** A predicate for creation of NSFetchRequest or NSFetchedResultsController. */
@property (retain) NSPredicate *predicate;

/** Sort descriptors for creation of NSFetchRequest or NSFetchedResultsController. */
@property (retain) NSArray *sortDescriptors;

/** A managed object context for creation of NSFetchRequest or NSFetchedResultsController. */
@property (retain) NSManagedObjectContext *managedObjectContext;

/** A section name key path for creation of NSFetchRequest or NSFetchedResultsController. */
@property (retain) NSString *sectionNameKeyPath;

/** A cache name for creation of NSFetchRequest or NSFetchedResultsController. */
@property (retain) NSString *cacheName;

/** Return a ISFetchRequestCondition object. */
+ (ISFetchRequestCondition *)fetchRequestCondition;


/**
 * Return a NSFetchRequest object.
 * Note: After calling this first, it does not effect any change of attributes.
 */
@property (assign, readonly) NSFetchRequest *fetchRequst;

/**
 * Return a NSFetchedResultsController object.
 * Note: After calling this first, it does not effect any change of attributes.
 */
@property (assign, readonly) NSFetchedResultsController *fetchedResultsController;


@end
