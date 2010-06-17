//
//  ISCDListTableViewController.m
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

#import "ISCDListTableViewController.h"
#import "ISFetchRequestCondition.h"
#import "NSManagedObjectContextCreation.h"
#import "NSManagedObjectContextDefaultContext.h"
#import "NSManagedObjectList.h"
#import "NSSortDescriptorExtension.h"
#import "ISTableViewCell.h"
#import "ISCDDetailedTableViewController.h"
#import "NSFetchedResultsControllerSortedObject.h"
#import "NSErrorCoreDataExtension.h"


@implementation ISCDListTableViewController

@synthesize entity = _entity;
@synthesize entityName = _entityName;
@synthesize masterObject = _masterObject;
@synthesize fetchedResultsController = _fetchedResultsController;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize displayKey = _displayKey;
@synthesize detailedTableViewControllerClassName = _detailedTableViewControllerClassName;
@synthesize addingStyle = _addingStyle;
@synthesize newCellRowStyle = _newCellRowStyle;
@synthesize hasEditButtonItem = _hasEditButtonItem;
@synthesize editingRowAnimation = _editingRowAnimation;
@synthesize hasDetailView = _hasDetailView;
@synthesize predicate = _predicate;
@synthesize sortDescriptors = _sortDescriptors;
@synthesize sectionNameKeyPath = _sectionNameKeyPath;


- (id)initWithStyle:(UITableViewStyle)style {
    if (self = [super initWithStyle:style]) {
        _addingStyle = ISListTableViewAddingStyleCell;
        _newCellRowStyle = ISListTableViewNewCellRowStyleFirst;
        _hasEditButtonItem = YES;
        _editingRowAnimation = UITableViewRowAnimationTop;
        _hasDetailView = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpEntityAndAttributeIfNeeds];
    
    self.tableView.allowsSelectionDuringEditing = YES;

    if (self.hasEditButtonItem) {
        self.navigationItem.rightBarButtonItem = self.editButtonItem;
    }

    [self reloadData];
}

- (void)setUpEntityAndAttributeIfNeeds
{
}

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


#pragma mark Table view methods

- (NSInteger)countInSection:(NSInteger)section
{
    int count = 0;
    NSArray *sections = [self.fetchedResultsController sections];
    if ([sections count]) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [sections objectAtIndex:section];
        count = [sectionInfo numberOfObjects];
    }
    return count;
}

- (BOOL)isNewCellAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.editing) {
        if (self.addingStyle == ISListTableViewAddingStyleCell) {
            if (self.newCellRowStyle == ISListTableViewNewCellRowStyleFirst) {
                if (indexPath.row == 0) {
                    return YES;
                }
            } else {
                int count = [self countInSection:indexPath.section];
                if (indexPath.row == count) {
                    return YES;
                }
            }
        }
        
    }
    return NO;
}

- (NSIndexPath *)arrangedIndexPathFor:(NSIndexPath *)indexPath
{
    if (self.editing) {
        if (self.addingStyle == ISListTableViewAddingStyleCell) {
            if (self.newCellRowStyle == ISListTableViewNewCellRowStyleFirst) {
                if (indexPath.row != 0) {
                    indexPath = [NSIndexPath indexPathForRow:indexPath.row - 1 inSection:indexPath.section];
                }
            }
        }
    }
    return indexPath;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    int count = 0;
    NSArray *sections = [self.fetchedResultsController sections];
    if (sections) {
        count = [sections count];
    }
    return count ? count : 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int count = 0;
    NSArray *sections = [self.fetchedResultsController sections];
    if ([sections count]) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [sections objectAtIndex:section];
        count = [sectionInfo numberOfObjects];
    }
    
    if (self.addingStyle == ISListTableViewAddingStyleCell) {
        return self.editing ? count + 1 : count;
    } else {
        return count;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:section];
    if ([self tableView:tableView numberOfRowsInSection:section]) {
        NSManagedObject *eo = [self.fetchedResultsController objectAtIndexPath:indexPath];
        return [eo valueForKey:self.sectionNameKeyPath];
    } else {
        return nil;
    }
}

- (UITableViewCell *)createCellWithIdentifier:(NSString *)cellIdentifier
{
    return [[[ISTableViewCell alloc] initWithStyle:ISTableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BOOL isNewCell = [self isNewCellAtIndexPath:indexPath];
    NSString *cellIdentifier = isNewCell ? @"NewCell" : @"Cell";
    
    ISTableViewCell *cell = (ISTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = (ISTableViewCell *)[self createCellWithIdentifier:cellIdentifier];
    }
    cell.accessoryType = self.hasDetailView ?  UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;
    cell.editingAccessoryType = cell.accessoryType;
    
    if (self.editing) {
        if (isNewCell) {
            NSArray *array = [NSArray arrayWithObjects:@"New", self.entityName, nil];
            NSString *title = NSLocalizedString([array componentsJoinedByString:@" "], nil);
            cell.textLabel.text = title;
            return cell;
        } else {
            indexPath = [self arrangedIndexPathFor:indexPath];
        }
    }

    NSManagedObject *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
    if (self.displayKey) {
        cell.textLabel.text = [[object valueForKey:self.displayKey] description];
    } else {
        cell.textLabel.text = nil;
    }
    return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.editing) {
        return [self isNewCellAtIndexPath:indexPath] ? UITableViewCellEditingStyleInsert : UITableViewCellEditingStyleDelete;
    } else {
        return UITableViewCellEditingStyleNone;
    }
}


- (ISCDDetailedTableViewController *)createDetailedTableViewController
{
    if (self.detailedTableViewControllerClassName) {
        Class class = NSClassFromString(self.detailedTableViewControllerClassName);
        if (class && [class isSubclassOfClass:[ISCDDetailedTableViewController class]]) {
            return [[[class alloc] initWithStyle:UITableViewStyleGrouped] autorelease];
        }
    }
    return [[[ISCDDetailedTableViewController alloc] initWithStyle:UITableViewStyleGrouped] autorelease];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (self.hasDetailView) {
        ISCDDetailedTableViewController *controller = [self createDetailedTableViewController];

        controller.editingMode = self.editing;

        if ([self isNewCellAtIndexPath:indexPath]) {
            [controller createWithEntityName:self.entityName];
        } else {
            controller.detailedObject = [self.fetchedResultsController objectAtIndexPath:[self arrangedIndexPathFor:indexPath]];
        
        }
    
        [self.navigationController pushViewController:controller animated:YES];
    } else {
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}




/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        NSManagedObject *object = [self.fetchedResultsController objectAtIndexPath:[self arrangedIndexPathFor:indexPath]];
        [self.managedObjectContext deleteObject:object];
        [self save];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    
    NSManagedObject *fromObject = [self.fetchedResultsController objectAtIndexPath:[self arrangedIndexPathFor:fromIndexPath]];
    NSManagedObject *toObject = [self.fetchedResultsController objectAtIndexPath:[self arrangedIndexPathFor:toIndexPath]];
    
    [fromObject moveTo:toObject];
    [self save];

}


// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.addingStyle == ISListTableViewAddingStyleCell) {
        if (self.newCellRowStyle == ISListTableViewNewCellRowStyleFirst) {
            return indexPath.row != 0;
        } else {
            return (indexPath.row < [self countInSection:indexPath.section]);
        }
    }
    return YES;
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
    if (self.addingStyle == ISListTableViewAddingStyleCell) {
        if (self.newCellRowStyle == ISListTableViewNewCellRowStyleFirst) {
            if (proposedDestinationIndexPath.row == 0) {
                return [NSIndexPath indexPathForRow:1 inSection:proposedDestinationIndexPath.section];
            }
        } else {
            int count = [self tableView:tableView numberOfRowsInSection:sourceIndexPath.section];
            if (proposedDestinationIndexPath.row == count - 1) {
                return [NSIndexPath indexPathForRow:count - 2 inSection:proposedDestinationIndexPath.section];
            }
        }
    }
    return proposedDestinationIndexPath;
}


- (void)dealloc {
    [_sectionNameKeyPath release];
    [_predicate release];
    [_sortDescriptors release];
    [_entityName release];
    [_entity release];
    [_masterObject release];
    [_detailedTableViewControllerClassName release];
    [_managedObjectContext release];
    [_displayKey release];
    [_fetchedResultsController release];
    [super dealloc];
}


#pragma mark -
#pragma mark property

- (void)setTitle
{
    if (self.title == nil) {
        NSString *title = [NSString stringWithFormat:@"List %@", self.entityName];
        title = NSLocalizedString(title, nil);
        self.title = title;
    }
}


- (void)setEntity:(NSEntityDescription *)anEntity
{
    [_entity release];
    _entity = [anEntity retain];
    
    [self setTitle];
}

- (void)setEntityName:(NSString *)aName
{
    [_entityName release];
    _entityName = [aName retain];

    [self setTitle];
}

- (NSString *)entityName
{
    if (_entityName == nil) {
        if (self.entity) {
            _entityName = [self.entity name];
        }
    }
    return _entityName;
}

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController == nil) {
        ISFetchRequestCondition *condition = [ISFetchRequestCondition fetchRequestCondition];
        condition.managedObjectContext = self.managedObjectContext;
        condition.entityName = self.entityName;
        NSString *managedObjectClassName = condition.entity.managedObjectClassName;
        
        Class class = NSClassFromString(managedObjectClassName);
        if (class) {
            condition.sortDescriptors = [class sortDescriptorsForTableViewController:self];
        }
        
        if (self.masterObject) {
            NSString *relationName = [class listScopeName];
            if (relationName) {
                condition.predicate = [NSPredicate predicateWithFormat:@"%K = %@", relationName, self.masterObject];
            } else {
                NSLog(@"WARN: %@ listScopeName is nil.", managedObjectClassName);
            }
        }
        
        if (self.predicate) {
            if (condition.predicate) {
                condition.predicate = [NSPredicate predicateWithFormat:@"%@ and %@", condition.predicate, self.predicate];
            } else {
                condition.predicate = self.predicate;
            }
        }
        
        NSMutableArray *array = [NSMutableArray array];
        if (condition.sortDescriptors) {
            [array addObjectsFromArray:condition.sortDescriptors];
        }
        if (self.sortDescriptors) {
            [array addObjectsFromArray:self.sortDescriptors];
        }
        condition.sortDescriptors = array;
        
        condition.sectionNameKeyPath = self.sectionNameKeyPath;
        
        _fetchedResultsController = [condition.fetchedResultsController retain];
        _fetchedResultsController.delegate = self;
    }
    return _fetchedResultsController;
}

- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext == nil) {
        _managedObjectContext = [[NSManagedObjectContext defaultManagedObjectContext] retain];
    }
    return _managedObjectContext;
}



#pragma mark -

- (void)reloadData
{    
    NSError *error = nil;
    [self.fetchedResultsController performFetch:&error];
#ifdef DEBUG
    if (error) [error showErrorForUserDomains];
#endif
    [self.tableView reloadData];
}

- (void)IS_save
{
    NSError *error = nil;
    NSManagedObjectContext *context = self.managedObjectContext;
    @try {
        [context.persistentStoreCoordinator lock];
        [context save:&error];
#ifdef DEBUG
        if (error) [error showErrorForUserDomains];
#endif
    } @finally {
        [context.persistentStoreCoordinator unlock];
    }
}

- (void)save
{
    [self performSelector:@selector(IS_save) withObject:nil afterDelay:0];
}

- (void)cancel
{
    [self.managedObjectContext rollback];
}


#pragma mark -
#pragma mark editing

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    
    NSMutableArray *removeIndexPaths = [NSMutableArray array];
    NSMutableArray *insertIndexPaths = [NSMutableArray array];

    [self.tableView beginUpdates];

    
    if (editing) {
        int count = [self countInSection:0];
        
        if (self.addingStyle == ISListTableViewAddingStyleCell) {
            if (self.newCellRowStyle == ISListTableViewNewCellRowStyleFirst) {
                if (count) {
                    [removeIndexPaths addObject:[NSIndexPath indexPathForRow:0 inSection:0]];
                    [insertIndexPaths addObject:[NSIndexPath indexPathForRow:0 inSection:0]];
                    [insertIndexPaths addObject:[NSIndexPath indexPathForRow:1 inSection:0]];
                } else {
                    [insertIndexPaths addObject:[NSIndexPath indexPathForRow:0 inSection:0]];
                }
            } else {
                [insertIndexPaths addObject:[NSIndexPath indexPathForRow:count inSection:0]];
            }
        }

    } else {
        
        if (self.addingStyle == ISListTableViewAddingStyleCell) {
            int count = [self countInSection:0];
        
            if (self.newCellRowStyle == ISListTableViewNewCellRowStyleFirst) {
                [removeIndexPaths addObject:[NSIndexPath indexPathForRow:0 inSection:0]];
            } else {
                [removeIndexPaths addObject:[NSIndexPath indexPathForRow:count inSection:0]];
            }
        }

        [self save];
    }
    
    if ([removeIndexPaths count]) {
        [self.tableView deleteRowsAtIndexPaths:removeIndexPaths withRowAnimation:[self editingRowAnimation]];
    }
    if ([insertIndexPaths count]) {
        [self.tableView insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:[self editingRowAnimation]];
    }
    
    [self.tableView endUpdates];
}

#pragma mark -
#pragma mark NSFetchedResultsControllerDelegate

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
}

@end


@implementation NSManagedObject(ISCDListTableViewController)

+ (NSArray *)sortDescriptorsForTableViewController:(UITableViewController *)controller
{
	NSString *sortDescriptorsString = [self sortDescriptorsStringForTableViewController:controller];
	return [NSSortDescriptor sortDescriptorsWithString:sortDescriptorsString];
}

+ (NSString *)sortDescriptorsStringForTableViewController:(UITableViewController *)controller
{
    if ([self listAvailable]) {
        return [self listAttributeName];
    } else {
        NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass(self) inManagedObjectContext:[NSManagedObjectContext defaultManagedObjectContext]];
        return [[[entity propertiesByName] allKeys] lastObject];
    }
}


@end
