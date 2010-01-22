//
//  ISDateTimeInputViewController.h
//  CiderTest
//
//  Created by Katsuyoshi Ito on 10/01/18.
//  Copyright 2010 ITO SOFT DESIGN Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


@interface ISDateTimeInputViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {

    NSManagedObject *detailedObject;
    NSString *attributeKey;
    
    NSDateFormatter *formatter;
    
    IBOutlet UIDatePicker *datePicker;
}

@property (retain) NSManagedObject *detailedObject;
@property (retain) NSString *attributeKey;

+ (ISDateTimeInputViewController *)dateTimeInputViewController;

- (void)doneAction:(id)sender;

@end
