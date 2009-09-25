//
//  NSManagedObjectContextDefaultContext.m
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

#import "NSManagedObjectContextDefaultContext.h"
#import "NSErrorExtension.h"
#import "NSManagedObjectContextAop.h"


@implementation NSManagedObjectContext(ISDefaultContext)

static NSManagedObjectContext *_defaultContext = nil;
static id _defaultStoreFile = nil;
static id _defaultStoreURL = nil;

+ (NSManagedObjectContext *)defaultManagedObjectContext
{
    if (_defaultContext == nil) {
        [self initializeAop];
        [self setDefaultManagedObjectContext:[self managedObjectContextWithFile:[self defaultStoreFile]]];
    }
    return _defaultContext;
}

+ (void)setDefaultManagedObjectContext:(NSManagedObjectContext *)context
{
    @synchronized(self) {
        [self clearDefaultManagedObjectContext];
        _defaultContext = [context retain];
    }
}

+ (void)clearDefaultManagedObjectContext
{
    @synchronized(self) {
        if (_defaultContext) {
            [_defaultContext rollback];
            [_defaultContext reset];
            [_defaultContext release];
            _defaultContext = nil;
        }
    }
}

+ (void)clearDefaultManagedObjectContextAndDeleteStoreFile
{
    @synchronized(self) {
        [self clearDefaultManagedObjectContext];
        NSFileManager *manager = [NSFileManager defaultManager];
        NSString *filePath = [self defaultStoreFile];
        if ([manager fileExistsAtPath:filePath]) {
            NSError *error = nil;
            if ([manager removeItemAtPath:filePath error:&error] == NO) {
#ifdef DEBUG
                [error showError];
#endif
            }
        }
    }
}


+ (NSURL *)defaultStoreURL
{
    @synchronized(self) {
        if (_defaultStoreURL == nil) {
            NSString *file = [self defaultStoreFile];
            _defaultStoreURL = [[NSURL fileURLWithPath:file] retain];
        }
    }
    return _defaultStoreURL;
}

+ (void)setDefaultStoreURL:(NSURL *)url
{
    @synchronized(self) {
        [self clearDefaultStoreUrlAndFile];
        _defaultStoreURL = [url retain];
        if ([_defaultStoreURL isFileURL]) {
            _defaultStoreFile = [[_defaultStoreURL path] retain];
        } else {
            _defaultStoreFile = [NSNull null];
        }
    }
}

+ (NSString *)defaultStoreFile
{
    id result = nil;
    @synchronized(self) {
        if (_defaultStoreFile == nil) {
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
            _defaultStoreFile = [[basePath stringByAppendingPathComponent:@"cider.sqlite"] retain];
        }
        result = _defaultStoreFile;
    }
    if (result == [NSNull null]) {
        return nil;
    } else {
        return result;
    }
}

+ (void)setDefaultStoreFile:(NSString *)file
{
    @synchronized(self) {
        [self clearDefaultStoreUrlAndFile];
        _defaultStoreFile = [file retain];
    }
}

+ (void)clearDefaultStoreUrlAndFile
{
    @synchronized(self) {
        [_defaultStoreURL release];
        [_defaultStoreFile release];
        _defaultStoreURL = nil;
        _defaultStoreFile = nil;
    }
}


+ (NSManagedObjectContext *)managedObjectContextWithURL:(NSURL *)url
{
    NSManagedObjectModel *managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil]; 
       
	NSError *error = nil;
    NSPersistentStoreCoordinator *coordinator = [[[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel] autorelease];
    if (![coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:&error]) {
#ifdef DEBUG
        [error showError];
#endif
    }
    
    NSManagedObjectContext *managedObjectContext = [[[NSManagedObjectContext alloc] init] autorelease];
    [managedObjectContext setPersistentStoreCoordinator:coordinator];
	
    return managedObjectContext;
}

+ (NSManagedObjectContext *)managedObjectContextWithFile:(NSString *)filePath
{
    return [self managedObjectContextWithURL:[NSURL fileURLWithPath: filePath]];
}

@end
