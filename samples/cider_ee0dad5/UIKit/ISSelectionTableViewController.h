//
//  ISSelectionTableViewController.h
//  tandr
//
//  Created by Katsuyoshi Ito on 10/02/01.
//  Copyright 2010 ITO SOFT DESIGN Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ISSelectionTableViewController : UITableViewController {

    NSArray *itemList;
    
    id object;
    NSString *key;
}

+ (ISSelectionTableViewController *)selectionTableViewController;

@property (retain) NSArray *itemList;
@property (retain) id object;
@property (retain) NSString *key;

@end
