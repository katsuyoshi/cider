//
//  NSManagedObjectContextSampleAppDelegate.h
//  NSManagedObjectContextSample
//
//  Created by Katsuyoshi Ito on 09/08/02.
//  Copyright ITO SOFT DESIGN Inc 2009. All rights reserved.
//

@interface NSManagedObjectContextSampleAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end

