//
//  NSManagedObjectContextDefaultContext.h
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


/**
 * Purpose:
 * The way to get the NSManagedObjectContext easily.
 */
@interface NSManagedObjectContext(ISDefaultContext)


#pragma mark -
#pragma mark to access default NSManagedObjectContext

/**
 * Returns the default NSManagedObjectContext.
 * Default store file is 'cider.sqlite' in local document file.
 * If you use another store file, use -setDefaultStoreURL: or -setDefaultStoreFile:.
 * @return The defaultNSManagedObjectContext.
 */
+ (NSManagedObjectContext *)defaultManagedObjectContext;

/**
 * Set the default NSManagedObjectContext.
 * @param context The default NSManagedObjectContext.
 */
+ (void)setDefaultManagedObjectContext:(NSManagedObjectContext *)context;


#pragma mark -
#pragma mark for storage

/**
 * Return the default store file's URL.
 * @return The default store file's URL.
 */
+ (NSURL *)defaultStoreURL;

/**
 * Set the default store file's URL.
 * It is necessary to call this before -defaultManagedObjectContext: is called.
 * Or call -clearDefaultManagedObjectContext.
 * @param The default store file's URL.
 */
+ (void)setDefaultStoreURL:(NSURL *)file;

/**
 * Return the default store file path.
 * @return The default store file path.
 */
+ (NSString *)defaultStoreFile;

/**
 * Set the default store file path.
 * It is necessary to call this before -defaultManagedObjectContext: is called.
 * Or call -clearDefaultManagedObjectContext.
 * @param The default store file path.
 */
+ (void)setDefaultStoreFile:(NSString *)file;


#pragma mark -
#pragma mark creation

/**
 * Create NSManagedObjectContext.
 * @param url The store file's URL.
 * @return The NSManagedObjecContext to use.
 */
+ (NSManagedObjectContext *)managedObjectContextWithURL:(NSURL *)url;

/**
 * Create NSManagedObjectContext.
 * @param filePath The store file path.
 * @return The NSManagedObjecContext to use.
 */
+ (NSManagedObjectContext *)managedObjectContextWithFile:(NSString *)filePath;


#pragma mark -
#pragma mark for testing

/**
 * Clear default NSManagedObjectContext.
 */
+ (void)clearDefaultManagedObjectContext;

/**
 * Clear default NSManagedObjectContext.
 * And delete store file if storeUrl is fileUrl.
 */
+ (void)clearDefaultManagedObjectContextAndDeleteStoreFile;

/**
 * Clear default store url and default file.
 */
+ (void)clearDefaultStoreUrlAndFile;



@end
