//
//  ISCDDetailedTableViewController.h
//  CiderTest
//
//  Created by Katsuyoshi Ito on 09/09/08.
//  Copyright 2009 ITO SOFT DESIGN Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


@interface ISCDDetailedTableViewController : UITableViewController<UITextFieldDelegate> {

    NSManagedObject *_detailedObject;
    NSManagedObjectContext *_managedObjectContext;
    
    NSArray *_displayAttributes;
    
    BOOL _editingMode;
    
    NSMutableDictionary *_textFieldDict;
    NSMutableDictionary *_indexPathDict;
    
    UITextField *_editingTextField;
}


@property (retain) NSManagedObject *detailedObject;
@property (retain) NSManagedObjectContext *managedObjectContext;

@property (retain) NSArray *displayAttributes;

@property BOOL editingMode;

- (void)createWithEntityName:(NSString *)entityName;


- (void)cancelAction:(id)sender;
- (void)saveAction:(id)sender;

@end
