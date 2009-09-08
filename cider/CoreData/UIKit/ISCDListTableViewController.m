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


@implementation ISCDListTableViewController

@synthesize entity = _entity;
@synthesize entityName = _entityName;
@synthesize fetchedResultsController = _fetchedResultsController;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize editingObject = _editingObject;
@synthesize displayKey = _displayKey;

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if (self = [super initWithStyle:style]) {
    }
    return self;
}
*/

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.allowsSelectionDuringEditing = YES;

    if (self.hasEditButtonItem) {
        self.navigationItem.rightBarButtonItem = self.editButtonItem;
    }

    [self reloadData];
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
    return NO;
}

- (NSIndexPath *)arrangedIndexPathFor:(NSIndexPath *)indexPath
{
    if (self.editing) {
        if (self.newCellRowStyle == ISListTableViewNewCellRowStyleFirst) {
            if (indexPath.row != 0) {
                indexPath = [NSIndexPath indexPathForRow:indexPath.row - 1 inSection:indexPath.section];
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
    return self.editing ? count + 1 : count;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    ISTableViewCell *cell = (ISTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[ISTableViewCell alloc] initWithStyle:ISTableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.editingAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    
    if (self.editing) {
        if ([self isNewCellAtIndexPath:indexPath]) {
            NSArray *array = [NSArray arrayWithObjects:@"New", self.entityName, nil];
            NSString *title = NSLocalizedString([array componentsJoinedByString:@" "], nil);
            cell.textLabel.text = title;
            return cell;
        } else {
            indexPath = [self arrangedIndexPathFor:indexPath];
        }
    }

    NSManagedObject *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = [object valueForKey:self.displayKey];
	
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



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ISCDDetailedTableViewController *controller = [[[ISCDDetailedTableViewController alloc] initWithStyle:UITableViewStyleGrouped] autorelease];

    controller.editingMode = self.editing;

    if ([self isNewCellAtIndexPath:indexPath]) {
        [controller createWithEntityName:self.entityName];
    } else {
        self.editingObject = [self.fetchedResultsController objectAtIndexPath:[self arrangedIndexPathFor:indexPath]];
        controller.detailedObject = self.editingObject;
        
    }
    
    [self.navigationController pushViewController:controller animated:YES];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


- (void)dealloc {
    [_editingObject release];
    [_entityName release];
    [_entity release];
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
            NSString *key = [class listAttributeName];
            condition.sortDescriptors = [NSSortDescriptor sortDescriptorsWithString:key];
        }
        _fetchedResultsController = [condition.fetchedResultsController retain];
    }
    return _fetchedResultsController;
}

- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext == nil) {
        _managedObjectContext = [[NSManagedObjectContext defaultManagedObjectContext] newManagedObjectContext];
    }
    return _managedObjectContext;
}


#pragma mark -
#pragma mark for customization

- (BOOL)hasEditButtonItem
{
    return YES;
}

- (ISListTableViewNewCellRowStyle)newCellRowStyle
{
    return ISListTableViewNewCellRowStyleFirst;
}

- (UITableViewRowAnimation)editingRowAnimation
{
    return UITableViewRowAnimationTop;
}



#pragma mark -

- (void)reloadData
{
    if (self.editingObject) {
        [self.managedObjectContext refreshObject:self.editingObject mergeChanges:YES];
        self.editingObject = nil;
    }
    
    NSError *error = nil;
    [self.fetchedResultsController performFetch:&error];
#ifdef DEBUG
    if (error) {
        [error showError];
    }
#endif
    [self.tableView reloadData];
}

- (void)save
{
    NSError *error = nil;
    [self.managedObjectContext save:&error];
    if (error) {
#ifdef DEBUG
        [error showError];
#endif
    }
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

    } else {
        
        int count = [self countInSection:0];
        
        if (self.newCellRowStyle == ISListTableViewNewCellRowStyleFirst) {
            [removeIndexPaths addObject:[NSIndexPath indexPathForRow:0 inSection:0]];
        } else {
            [removeIndexPaths addObject:[NSIndexPath indexPathForRow:count inSection:0]];
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


@end

