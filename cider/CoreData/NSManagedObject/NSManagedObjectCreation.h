//
//  NSManagedObjectCreation.h
//  CiderTest
//
//  Created by Katsuyoshi Ito on 09/08/02.
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


@interface NSManagedObject(ISManagedObjectCreation)

#pragma mark -
#pragma mark for NSManagedObject

/**
 * Return a new NSManagedObject for the entityName.
 * It is inserted to the default managed object context. 
 * ([NSManagedObjectContext defaultManagedObjectContext])
 * @param entityName The entity name
 * @return A new NSManagedObject for the entityName.
 */
+ (id)createWithEntityName:(NSString *)entityName;

#pragma mark premitive method

/**
 * Return a new NSManagedObject for the entityName.
 * It is inserted to the managedObjectContext. 
 * @param entityName The entity name
 * @param managedObjectContext A new NSManagedObject is insreted to this context.
 * @return A new NSManagedObject for the entityName.
 */
+ (id)createWithEntityName:(NSString *)entityName inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;


#pragma mark -
#pragma mark for CustomClass of NSManagedObject

/**
 * Retuen a new CustomClass's object.
 * You must use this from the CustomeClass of NSManagedObject.
 * Use class name as entity name.
 * It is inserted to the default managed object context. 
 * ([NSManagedObjectContext defaultManagedObjectContext])
 */ 
+ (id)create;

/**
 * Retuen a new CustomClass's object.
 * You must use this from the CustomeClass of NSManagedObject.
 * Use class name as entity name.
 */ 
+ (id)createWithManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;


/**
 * Return a new NSManagedObject for the entityName.
 * It is inserted to the own managedObjectContext. 
 * @param entityName The entity name
 * @return A new NSManagedObject for the entityName.
 */
- (id)createWithEntityName:(NSString *)entityName;


/**
 * Duplicate the object.
 * It's just a scaffold. you should implement by subclass.
 */
- (id)duplicate;

@end
