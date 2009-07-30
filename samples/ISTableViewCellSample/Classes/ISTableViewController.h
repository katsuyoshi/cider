//
//  ISTableViewController.h
//  ISTableViewCellSample
//
//  Created by Katsuyoshi Ito on 09/07/30.
//  Copyright 2009 ITO SOFT DESIGN Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ISTableViewController : UITableViewController <UITextFieldDelegate> {

    UITextField *editingTextField;
    
}

@property (retain) UITextField *editingTextField;

@end
