//
//  ISTableViewController.m
//  ISTableViewCellSample
//
//  Created by Katsuyoshi Ito on 09/07/30.
//  Copyright 2009 ITO SOFT DESIGN Inc. All rights reserved.
//

#import "ISTableViewController.h"
#import "ISTableViewCell.h"


@implementation ISTableViewController

@synthesize editingTextField;

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if (self = [super initWithStyle:style]) {
    }
    return self;
}
*/

/*
- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
*/

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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8;
}


/*
// Customize the height of table view cells.
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}
*/

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static ISTableViewCellStyle styles[] = { ISTableViewCellStyleDefault,  ISTableViewCellStyleValue1, ISTableViewCellStyleValue2, ISTableViewCellStyleSubtitle, ISTableViewCellEditingStyleDefault, ISTableViewCellEditingStyleValue1, ISTableViewCellEditingStyleValue2, ISTableViewCellEditingStyleSubtitle};

    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell:%d", indexPath.row];
    
    ISTableViewCell *cell = (ISTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[ISTableViewCell alloc] initWithStyle:styles[indexPath.row] reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Set up the cell...
    if (cell.textLabel) {
        cell.textLabel.text = @"Text Label";
    }
    if (cell.detailTextLabel) {
        cell.detailTextLabel.text = @"Detail Text Label";
    }
    if (indexPath.row >= 4) {
        if (cell.textField) {
            cell.textField.text = @"Text Field";
            cell.textField.delegate = self;
        }
        if (cell.detailTextField) {
            cell.detailTextField.text = @"Detail Text Field";
            cell.detailTextField.delegate = self;
        }
    }
	
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
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
    [editingTextField release];
    [super dealloc];
}


#pragma mark -
#pragma mark UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.editingTextField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.editingTextField = nil;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.editingTextField resignFirstResponder];
    return YES;
}


@end

