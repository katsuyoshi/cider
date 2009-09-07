//
//  ISCDTableViewControllersSampleAppDelegate.m
//  ISCDTableViewControllersSample
//
//  Created by Katsuyoshi Ito on 09/09/08.
//  Copyright ITO SOFT DESIGN Inc 2009. All rights reserved.
//

#import "ISCDTableViewControllersSampleAppDelegate.h"
#import "CiderCoreData.h"


@implementation ISCDTableViewControllersSampleAppDelegate

@synthesize window;


#pragma mark -
#pragma mark Application lifecycle

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    

    ISCDListTableViewController *tableViewController = [[[ISCDListTableViewController alloc] initWithStyle:UITableViewStylePlain] autorelease];
    tableViewController.displayKey = @"name";
    tableViewController.entityName = @"ISMovie";
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:tableViewController];
    
	[window addSubview:[navigationController view]];
    [window makeKeyAndVisible];
}

/**
 applicationWillTerminate: saves changes in the application's managed object context before the application terminates.
 */
- (void)applicationWillTerminate:(UIApplication *)application {
	
    NSManagedObjectContext *managedObjectContext = [NSManagedObjectContext defaultManagedObjectContext];
    NSError *error = nil;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			abort();
        } 
    }
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	
	[window release];
	[super dealloc];
}


@end

