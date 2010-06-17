//
//  ISCDListTableViewController.h
//  CiderTest
//
//  Created by Katsuyoshi Ito on 09/09/07.
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


/** For newCellRowStyle property. */
typedef enum {
    /** In editing mode, an adding cell will be appeared at first row. */
    ISListTableViewNewCellRowStyleFirst,
    /** In editing mode, an adding cell will be appeared at last row. */
    ISListTableViewNewCellRowStyleLast
} ISListTableViewNewCellRowStyle;

/** For addingStyle property. */
typedef enum {
    /** No needs adding */
    ISListTableViewAddingStyleNone,
    /* Adding by a tableview cell */
    ISListTableViewAddingStyleCell,
    /* Adding by a toobar button. */
    ISListTableViewAddingStyleToolBarButton,    // FIXME: now not implemented
} ISListTableViewAddingStyle;


@class ISCDDetailedTableViewController;

@interface ISCDListTableViewController : UITableViewController <NSFetchedResultsControllerDelegate> {

    NSEntityDescription *_entity;
    NSString *_entityName;

    NSString *_displayKey;

    NSManagedObject *_masterObject;



    NSFetchedResultsController *_fetchedResultsController;
    NSManagedObjectContext *_managedObjectContext;
    
    BOOL _hasEditButtonItem;
    BOOL _hasDetailView;
    UITableViewRowAnimation _editingRowAnimation;

    ISListTableViewNewCellRowStyle _newCellRowStyle;
    ISListTableViewAddingStyle _addingStyle;
    
    NSString *_detailedTableViewControllerClassName;
    
    NSPredicate *_predicate;
    NSArray *_sortDescriptors;
    
    NSString *_sectionNameKeyPath;
}


@property (retain, readonly) NSFetchedResultsController *fetchedResultsController;
@property (retain) NSManagedObjectContext *managedObjectContext;

@property (retain) NSPredicate *predicate;
@property (retain) NSArray *sortDescriptors;

@property (retain) NSString *sectionNameKeyPath;


#pragma mark -
#pragma mark - for table view customizing

/** If YES, the edit botton will be appeared on navigation bar. */
@property (assign) BOOL hasEditButtonItem;

/** If YES, it can move to the deatail view when touch a cell. */
@property (assign) BOOL hasDetailView;

/**
 * When you select addingStyle ISListTableViewAddingStyleCellspecify,
 * it specify the position of adding cell.
 */
@property (assign) ISListTableViewNewCellRowStyle newCellRowStyle;

/** specify the way to add a new cell. */ 
@property (assign) ISListTableViewAddingStyle addingStyle;

/** The amination style for insert or remove cell */
@property (assign) UITableViewRowAnimation editingRowAnimation;


#pragma mark -
#pragma mark for detailed table view

/**
 * By default, detail table view is managed byISCDDetaildTabieViewController.
 * If you have own table view controller, set that class name.
 */
@property (retain)  NSString *detailedTableViewControllerClassName;


#pragma mark -
#pragma mark data management

/** managed entity */
@property (retain) NSEntityDescription *entity;
/** managed entity's name */
@property (retain) NSString *entityName;

/**
 * master object of master detail model
 */
@property (retain) NSManagedObject *masterObject;

/** The value of this attribute will be dispayed on table view cell. */
@property (retain) NSString *displayKey;

/**
 * Set entity and attribute that you want to display if needs.
 * It's called in viewDidLoad.
 */
- (void)setUpEntityAndAttributeIfNeeds;
   
- (void)reloadData;
- (void)save;
- (void)cancel;


#pragma mark -
#pragma mark convenience methods for subclass

- (NSInteger)countInSection:(NSInteger)section;
- (NSIndexPath *)arrangedIndexPathFor:(NSIndexPath *)indexPath;
- (BOOL)isNewCellAtIndexPath:(NSIndexPath *)indexPath;
- (ISCDDetailedTableViewController *)createDetailedTableViewController;
- (UITableViewCell *)createCellWithIdentifier:(NSString *)cellIdentifier;

@end


@interface NSManagedObject(ISCDListTableViewController)
+ (NSArray *)sortDescriptorsForTableViewController:(UITableViewController *)controller;
+ (NSString *)sortDescriptorsStringForTableViewController:(UITableViewController *)controller;
@end
