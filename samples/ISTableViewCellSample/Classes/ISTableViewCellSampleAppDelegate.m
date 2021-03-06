//
//  ISTableViewCellSampleAppDelegate.m
//  ISTableViewCellSample
//
//  Created by Katsuyoshi Ito on 09/07/30.
//  Copyright ITO SOFT DESIGN Inc 2009. All rights reserved.
//

#import "ISTableViewCellSampleAppDelegate.h"


@implementation ISTableViewCellSampleAppDelegate

@synthesize window;
@synthesize tabBarController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {
    
    // Add the tab bar controller's current view as a subview of the window
    [window addSubview:tabBarController.view];
}


/*
// Optional UITabBarControllerDelegate method
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
}
*/

/*
// Optional UITabBarControllerDelegate method
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed {
}
*/


- (void)dealloc {
    [tabBarController release];
    [window release];
    [super dealloc];
}

@end

