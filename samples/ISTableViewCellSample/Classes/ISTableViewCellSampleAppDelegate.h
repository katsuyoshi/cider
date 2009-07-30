//
//  ISTableViewCellSampleAppDelegate.h
//  ISTableViewCellSample
//
//  Created by Katsuyoshi Ito on 09/07/30.
//  Copyright ITO SOFT DESIGN Inc 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ISTableViewCellSampleAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    UIWindow *window;
    UITabBarController *tabBarController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@end
