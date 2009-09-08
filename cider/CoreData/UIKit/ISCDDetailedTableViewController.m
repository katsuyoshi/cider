//
//  ISCDDetailedTableViewController.m
//  CiderTest
//
//  Created by Katsuyoshi Ito on 09/09/08.
//  Copyright 2009 ITO SOFT DESIGN Inc. All rights reserved.
//

#import "ISCDDetailedTableViewController.h"
#import "NSManagedObjectCreation.h"
#import "NSManagedObjectList.h"
#import "NSManagedObjectContextCreation.h"
#import "NSManagedObjectContextDefaultContext.h"
#import "ISCDListTableViewController.h"
#import "ISTableViewCell.h"


@implementation ISCDDetailedTableViewController

@synthesize detailedObject = _detailedObject;
@synthesize displayAttributes = _displayAttributes;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize editingMode = _editingMode;

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

    _textFieldDict = [NSMutableDictionary new];
    _indexPathDict = [NSMutableDictionary new];
    
    if (self.editingMode) {
        UIBarButtonItem *saveBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveAction:)] autorelease];
        UIBarButtonItem *cancelBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelAction:)] autorelease];
    
        self.navigationItem.leftBarButtonItem = cancelBarButtonItem;
        self.navigationItem.rightBarButtonItem = saveBarButtonItem;
    }
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

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
    [self.managedObjectContext rollback];
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
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *key = [self.displayAttributes objectAtIndex:section];
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
    
    NSString *CellIdentifier = self.editingMode ? @"EditingCell" : @"Cell";
    
    ISTableViewCell *cell = (ISTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        if (self.editingMode) {
            cell = [[[ISTableViewCell alloc] initWithStyle:ISTableViewCellEditingStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            if (indexPath.section == 0) {
                [cell.textField performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0];
            }
            cell.textField.delegate = self;
            [self registTextField:cell.textField indexPath:indexPath];
        } else {
            cell = [[[ISTableViewCell alloc] initWithStyle:ISTableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        }
        
    }
    
    NSString *title = [self.detailedObject valueForKey:[self.displayAttributes objectAtIndex:indexPath.section]];
    if (self.editingMode) {
        cell.textField.text = title;
    } else {
        cell.textLabel.text = title;
    }
	
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	// AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
	// [self.navigationController pushViewController:anotherViewController];
	// [anotherViewController release];
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
        NSString *listAttribute = [[_detailedObject class] listAttributeName];
        NSEntityDescription *entity = [_detailedObject entity];
        NSMutableArray *array = [NSMutableArray array];
        for (NSString *key in [entity.attributesByName allKeys]) {
            if (![key isEqualToString:listAttribute]) {
                [array addObject:key];
            }
        }
        _displayAttributes = [array retain];
    }
    return _displayAttributes;
}

- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext == nil) {
        _managedObjectContext = [[NSManagedObjectContext defaultManagedObjectContext] newManagedObjectContext];
    }
    return _managedObjectContext;
}



#pragma mark -

- (void)createWithEntityName:(NSString *)entityName
{
    NSManagedObject *object = [NSManagedObject createWithEntityName:entityName inManagedObjectContext:self.managedObjectContext];
    [object setListNumber];
    
    self.detailedObject = object;
}

#pragma mark -
#pragma mark action


- (void)cancelAction:(id)sender
{
    [self.managedObjectContext rollback];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)saveAction:(id)sender
{
    [_editingTextField resignFirstResponder];

    NSError *error = nil;
    [self.managedObjectContext save:&error];
    if (error) {
#ifdef DEBUG
        [error showError];
#endif
    }
    
    NSArray *controllers = self.navigationController.viewControllers;
    ISCDListTableViewController *parent = [controllers objectAtIndex:[controllers count] - 2];
    [parent reloadData];

    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    _editingTextField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSIndexPath *indexPath = [self indexPathForTextField:textField];
    NSString *key = [self.displayAttributes objectAtIndex:indexPath.section];
    
    [_detailedObject setValue:textField.text forKey:key];
    
    _editingTextField = nil;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


@end

