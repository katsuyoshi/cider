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
#import "NSErrorCoreDataExtension.h"


@implementation NSManagedObjectContext(ISDefaultContext)

static NSManagedObjectContext *_defaultContext = nil;
static id _defaultStoreFile = nil;
static id _defaultStoreURL = nil;
static NSString *_fileName = nil;

BOOL is_g_running_migration = NO;

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
                [error showErrorForUserDomains];
#endif
            }
        }
    }
}

#pragma mark - default location

+ (void)setFileName:(NSString *)fileName
{
    [_fileName release];
    _fileName = [fileName copy];
}

+ (NSString *)fileName
{
    return [_fileName length] ? _fileName : @"cider.sqlite";
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
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
            NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
            _defaultStoreFile = [[basePath stringByAppendingPathComponent:[self fileName]] retain];
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

+ (BOOL)storeFileExits;
{
    NSFileManager *manager = [NSFileManager defaultManager];
    return [manager fileExistsAtPath:[self defaultStoreFile]];
}


#pragma mark - default location before 0.3.0

+ (BOOL)transferBefore0_3_0DataIfNeedsWithFileName:(NSString *)fileName
{
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *src = [self defaultStoreFileBefore0_3_0WithFileName:fileName];
    if ([manager fileExistsAtPath:src]) {
        NSString *dst = [self defaultStoreFile];
        NSError *error = nil;

        // create a directory if it doesn't exist.
        NSString *dstDir = [dst stringByDeletingLastPathComponent];
        if ([manager fileExistsAtPath:dstDir] == NO) {
            [manager createDirectoryAtPath:dstDir withIntermediateDirectories:YES attributes:nil error:&error];
            if (error) {
#ifdef DEBUG
                [error showErrorForUserDomains];
#endif
                return NO;
            }
        }
        
        // move file
        [manager moveItemAtPath:src toPath:dst error:&error];
        if (error) {
#ifdef DEBUG
            [error showErrorForUserDomains];
            return NO;
#endif
        }
    }
    return YES;
}

+ (NSURL *)defaultStoreURLBefore0_3_0WithFileName:(NSString *)fileName
{
    return [NSURL fileURLWithPath:[self defaultStoreFileBefore0_3_0WithFileName:fileName]];
}

+ (NSString *)defaultStoreFileBefore0_3_0WithFileName:(NSString *)fileName
{
    fileName = fileName ? fileName : [self fileName];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return [[basePath stringByAppendingPathComponent:fileName] retain];
}


#pragma mark - generate managed object context

+ (NSManagedObjectContext *)managedObjectContextWithURL:(NSURL *)url
{
    NSManagedObjectContext *managedObjectContext = nil;
    
    @synchronized(self) {
        is_g_running_migration = YES;
        NSManagedObjectModel *managedObjectModel = nil;

        NSFileManager *manager = [NSFileManager defaultManager];
        NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
        NSString *modelFileName = nil;
        for (NSString *str in [manager contentsOfDirectoryAtPath:bundlePath error:NULL]) {
            if ([[str pathExtension] isEqualToString:@"momd"]) {
                modelFileName = str;
            }
        }
        if (modelFileName) {
            NSURL *url = [NSURL fileURLWithPath:[bundlePath stringByAppendingPathComponent:modelFileName]];
            managedObjectModel = [[[NSManagedObjectModel alloc] initWithContentsOfURL:url] autorelease];
        } else {
            managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil]; 
        }

        // create a directory if it doesn't exist.
        NSString *dir = [[url path] stringByDeletingLastPathComponent];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if ([fileManager fileExistsAtPath:dir] == NO) {
            NSError *error = nil;
            [fileManager createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:NULL];
            if (error) {
#ifdef DEBUG
                [error showErrorForUserDomains];
#endif
            }
        }
        
        NSError *error = nil;
        NSPersistentStoreCoordinator *coordinator = [[[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel] autorelease];
        NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                                 [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];

        if (![coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:options error:&error]) {
#ifdef DEBUG
            [error showErrorForUserDomains];
#endif
        }
    
        managedObjectContext = [[[NSManagedObjectContext alloc] init] autorelease];
        [managedObjectContext setPersistentStoreCoordinator:coordinator];
        is_g_running_migration = NO;
	}
    return managedObjectContext;
}

+ (NSManagedObjectContext *)managedObjectContextWithFile:(NSString *)filePath
{
    return [self managedObjectContextWithURL:[NSURL fileURLWithPath: filePath]];
}

@end
