//
//  ISCDDetailedTableViewController.h
//  CiderTest
//
//  Created by Katsuyoshi Ito on 09/09/08.
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
    
    BOOL canceling;
    BOOL pushingToNextViewController;
}


@property (retain) NSManagedObject *detailedObject;
@property (retain) NSManagedObjectContext *managedObjectContext;

@property (retain) NSArray *displayAttributes;

@property BOOL editingMode;

- (void)createWithEntityName:(NSString *)entityName;


- (void)cancelAction:(id)sender;
- (void)saveAction:(id)sender;

#pragma mark -
#pragma mark for sub class

- (void)registTextField:(UITextField *)textField indexPath:(NSIndexPath *)indexPath;
- (UITextField *)textFieldForIndexPath:(NSIndexPath *)indexPath;
- (NSIndexPath *)indexPathForTextField:(UITextField *)textField;


@end
