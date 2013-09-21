//
//  ISCDDetailedTableViewController.m
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

#import "ISCDDetailedTableViewController.h"
#import "NSManagedObjectCreation.h"
#import "NSManagedObjectList.h"
#import "NSManagedObjectContextCreation.h"
#import "NSManagedObjectContextDefaultContext.h"
#import "ISCDListTableViewController.h"
#import "ISTableViewCell.h"
#import "NSErrorCoreDataExtension.h"
#import "NSManagedObjectDisplay.h"
#import "ISDateTimeInputViewController.h"


@implementation ISCDDetailedTableViewController

@synthesize detailedObject = _detailedObject;
@synthesize displayAttributes = _displayAttributes;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize editingMode = _editingMode;
@synthesize becomeFirstResponderWhenAppeared;

- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if (self = [super initWithStyle:style]) {
        becomeFirstResponderWhenAppeared = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _textFieldDict = [NSMutableDictionary new];
    _indexPathDict = [NSMutableDictionary new];
    
    if (self.editingMode) {
        UIBarButtonItem *saveBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveAction:)] autorelease];
        UIBarButtonItem *cancelBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelAction:)] autorelease];
    
        self.navigationItem.leftBarButtonItem = cancelBarButtonItem;
        self.navigationItem.rightBarButtonItem = saveBarButtonItem;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    pushingToNextViewController = NO;
    [self.tableView reloadData];
}

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (pushingToNextViewController == NO) {
        [self cancelAction:self];
    }
}

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

- (void)registTextField:(UITextField *)textField indexPath:(NSIndexPath *)indexPath
{
    NSString *key = [indexPath description];
    
    // remove a textField if registed (reuse)
    for (NSString *aKey in [_textFieldDict allKeys]) {
        if ([_textFieldDict objectForKey:aKey] == textField) {
            [_textFieldDict removeObjectForKey:aKey];
            [_indexPathDict removeObjectForKey:aKey];
            break;
        }
    }

    [_textFieldDict setValue:textField forKey:key];
    [_indexPathDict setValue:indexPath forKey:key];
}

- (UITextField *)textFieldForIndexPath:(NSIndexPath *)indexPath
{
    NSString *key = [indexPath description];
    return [_textFieldDict valueForKey:key];
}

- (NSIndexPath *)indexPathForTextField:(UITextField *)textField
{
    NSString *key = nil;
    for (NSString *aKey in [_textFieldDict allKeys]) {
        if ([_textFieldDict valueForKey:aKey] == textField) {
            key = aKey;
            break;
        }
    }
    return [_indexPathDict valueForKey:key];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.displayAttributes count];
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *keys = [[self.displayAttributes objectAtIndex:section] componentsSeparatedByString:@"."];
    if ([keys count] == 1) {
        return 1;
    } else {
        id relation = [self.detailedObject valueForKey:[keys objectAtIndex:0]];
        if ([relation isKindOfClass:[NSMutableSet class]]) {
            // to many
            return [relation count];
        } else {
            // to one
            return 1;
        }
    }

    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *key = [[[self.displayAttributes objectAtIndex:section] componentsSeparatedByString:@"."] objectAtIndex:0];
    NSString *title1 = self.detailedObject.entity.name;
    NSString *title2 = [title1 stringByAppendingFormat:@":%@", key];
    
    // first, find 'EntityName:attributeName'
    NSString *title = NSLocalizedString(title2, nil);
    if ([title isEqualToString:title2]) {
    
        // if it does not found, find 'attirbuteName'
        title = NSLocalizedString(key, nil);
        if ([title isEqualToString:key]) {
        
            // if it does not found, use capitalized 'AttributeName'
            title = [title capitalizedString];
        }
    }
    return title;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *keys = [[self.displayAttributes objectAtIndex:indexPath.section] componentsSeparatedByString:@"."];
    NSString *attributeKey = nil;
    NSString *relationKey = nil;
    if ([keys count] == 1) {
        attributeKey = [keys objectAtIndex:0];
    } else {
        relationKey = [keys objectAtIndex:0];
        attributeKey = [keys objectAtIndex:1];
    }
    
    id eo = nil;
    if (relationKey) {
        id relation = [self.detailedObject valueForKey:relationKey];
        if ([relation isKindOfClass:[NSMutableSet class]]) {
            // to many
            eo = [[relation allObjects] objectAtIndex:indexPath.row];
        } else {
            eo = relation;
        }
    } else {
        eo = self.detailedObject;
    }
        
    
    NSFormatter *formatter = [eo formatterForAttribute:attributeKey];
    BOOL needsTextField = ![formatter isKindOfClass:[NSDateFormatter class]] && self.editingMode;

    NSString *cellIdentifier = needsTextField ? @"EditingCell" : @"Cell";

    ISTableViewCell *cell = (ISTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        if (needsTextField) {
            cell = [[[ISTableViewCell alloc] initWithStyle:ISTableViewCellEditingStyleDefault reuseIdentifier:cellIdentifier] autorelease];
            if (indexPath.section == 0 && self.becomeFirstResponderWhenAppeared) {
                [cell.textField performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0];
            }
            cell.textField.delegate = self;
        } else {
            cell = [[[ISTableViewCell alloc] initWithStyle:ISTableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
        }
    }
    
    if (needsTextField) {
        [self registTextField:cell.textField indexPath:indexPath];
    }
    
    if (self.editingMode && !needsTextField) {
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
        
    cell.textField.text = nil;
    cell.textLabel.text = nil;

    id value = [eo valueForKey:attributeKey];
    if (value) {
        NSString *title = formatter ? [formatter stringForObjectValue:value]  : [value description];
        if (self.editingMode && needsTextField) {
            cell.textField.text = title;
        } else {
            cell.textLabel.text = title;
        }
    } else {
        cell.textLabel.text = nil;
    }
	
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.accessoryType == UITableViewCellAccessoryDisclosureIndicator) {
        ISDateTimeInputViewController *controller = [ISDateTimeInputViewController dateTimeInputViewController];
        controller.detailedObject = self.detailedObject;
        controller.attributeKey = [self.displayAttributes objectAtIndex:indexPath.section];

        pushingToNextViewController = YES;
        [self.navigationController pushViewController:controller animated:YES];
    }
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
    [_textFieldDict release];
    [_indexPathDict release];
    [_detailedObject release];
    [_displayAttributes release];
    [_managedObjectContext release];
    [super dealloc];
}


#pragma mark -
#pragma mark property

- (void)setDetailedObject:(NSManagedObject *)object
{
    [_detailedObject release];
    object = [self.managedObjectContext objectWithID:[object objectID]];
    _detailedObject = [object retain];
    
    if (self.title == nil) {
        NSString *title;
        NSString *entityName = self.detailedObject.entity.name;
        if (self.editingMode) {
            title = [NSString stringWithFormat:@"Edit %@", entityName];
        } else {
            title = [NSString stringWithFormat:@"Show %@", entityName];
        }
        title = NSLocalizedString(title, nil);
        self.title = title;
    }
}

- (NSArray *)displayAttributes
{
    if (_displayAttributes == nil) {
		_displayAttributes = [[_detailedObject displayAttributesForTableViewController:self editing:self.editingMode] retain];
    }
    return _displayAttributes;
}

- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext == nil) {
        _managedObjectContext = [[NSManagedObjectContext defaultManagedObjectContext] retain];
    }
    return _managedObjectContext;
}



#pragma mark -

- (void)createWithEntityName:(NSString *)entityName
{
    return [self createWithEntityName:entityName masterObject:nil key:nil];
}

- (void)createWithEntityName:(NSString *)entityName masterObject:(NSManagedObject *)masterObject key:(NSString *)key
{
    Class klass = NSClassFromString(entityName);
    NSManagedObject *object = [klass createWithManagedObjectContext:self.managedObjectContext];
    if (masterObject && key) {
        [object setValue:masterObject forKey:key];
    }
    [object setListNumber];
    
    self.detailedObject = object;
}

#pragma mark -
#pragma mark action


- (void)cancelAction:(id)sender
{
    canceling = YES;
    
    [_editingTextField resignFirstResponder];

    if (self.editingMode) {
        if ([self.managedObjectContext hasChanges]) {
            [self.managedObjectContext rollback];
        }
    }
    if (self.navigationController.topViewController == self) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    canceling = NO;
}

- (void)saveAction:(id)sender
{
    if ([self textFieldShouldReturn:_editingTextField]) {

        NSError *error = nil;
        if ([self.managedObjectContext save:&error]) {
    
            if (self.navigationController.topViewController == self) {
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
        
        if (error) [error showErrorForUserDomains];
        
    }
}

#pragma mark -
#pragma mark UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    _editingTextField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (canceling == NO) {
        
        NSIndexPath *indexPath = [self indexPathForTextField:textField];
        NSString *key = [self.displayAttributes objectAtIndex:indexPath.section];
    
        [_detailedObject setValue:[self.detailedObject convertFromString:textField.text attribute:key] forKey:key];
    
    }
    _editingTextField = nil;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


@end


@implementation NSManagedObject(ISCDDetailedTableViewController)

- (NSArray *)displayAttributesForTableViewController:(UITableViewController *)controller editing:(BOOL)editing
{
	NSString *listAttribute = [[self class] listAttributeName];
	NSEntityDescription *entity = [self entity];
	NSMutableArray *array = [NSMutableArray array];
	for (NSString *key in [entity.attributesByName allKeys]) {
		if (![key isEqualToString:listAttribute]) {
			[array addObject:key];
		}
	}
	return array;
}

@end


