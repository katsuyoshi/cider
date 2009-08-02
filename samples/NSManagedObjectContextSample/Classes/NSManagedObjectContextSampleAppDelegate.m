//
//  NSManagedObjectContextSampleAppDelegate.m
//  NSManagedObjectContextSample
//
//  Created by Katsuyoshi Ito on 09/08/02.
//  Copyright ITO SOFT DESIGN Inc 2009. All rights reserved.
//

#import "NSManagedObjectContextSampleAppDelegate.h"
#import "RootViewController.h"
#import "CiderCoreData.h"

@implementation NSManagedObjectContextSampleAppDelegate

@synthesize window;
@synthesize navigationController;


#pragma mark -
#pragma mark Application lifecycle

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    

	RootViewController *rootViewController = (RootViewController *)[navigationController topViewController];
	rootViewController.managedObjectContext = [NSManagedObjectContext defaultManagedObjectContext];
	
	[window addSubview:[navigationController view]];
    [window makeKeyAndVisible];
}

/**
 applicationWillTerminate: saves changes in the application's managed object context before the application terminates.
 */
- (void)applicationWillTerminate:(UIApplication *)application {
	
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = [NSManagedObjectContext defaultManagedObjectContext];
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
			/*
			 Replace this implementation with code to handle the error appropriately.
			 
			 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
			 */
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			abort();
        } 
    }
}



#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	
	[navigationController release];
	[window release];
	[super dealloc];
}


@end

