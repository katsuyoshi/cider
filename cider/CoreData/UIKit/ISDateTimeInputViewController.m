//
//  ISDateTimeInputViewController.m
//  CiderTest
//
//  Created by Katsuyoshi Ito on 10/01/18.
//

/* 

  Copyright 2010 ITO SOFT DESIGN Inc. All rights reserved.

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

#import "ISDateTimeInputViewController.h"
#import "CiderCoreData.h"


@implementation ISDateTimeInputViewController

@synthesize detailedObject;
@synthesize attributeKey;


+ (ISDateTimeInputViewController *)dateTimeInputViewController
{
    return [[[self alloc] initWithNibName:@"ISDateTimeInputViewController" bundle:nil] autorelease];
}



/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

    formatter = (NSDateFormatter *)[[self.detailedObject formatterForAttribute:attributeKey] retain];
    
    if (formatter.dateStyle == NSDateFormatterNoStyle) {
        if (formatter.timeStyle == NSDateFormatterNoStyle) {
            // TODO: error
        } else {
            datePicker.datePickerMode = UIDatePickerModeTime;
        }
    } else {
        if (formatter.timeStyle == NSDateFormatterNoStyle) {
            datePicker.datePickerMode = UIDatePickerModeDate;
        } else {
            datePicker.datePickerMode = UIDatePickerModeDateAndTime;
        }
    }
    id value = [self.detailedObject valueForKey:self.attributeKey];
    if (value) {
        datePicker.date = value;
    }
    
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneAction:)] autorelease];
}

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


- (void)dealloc {
    [formatter release];
    [detailedObject release];
    [attributeKey release];
    [datePicker release];
    [super dealloc];
}


#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *key = self.attributeKey;
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
    
    static NSString *CellIdentifier = @"Cell";

    ISTableViewCell *cell = (ISTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[ISTableViewCell alloc] initWithStyle:ISTableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
        
    id value = [self.detailedObject valueForKey:self.attributeKey];
    if (value) {
        NSString *title = formatter ? [formatter stringForObjectValue:value]  : [value description];
        cell.textLabel.text = title;
    }
	
    return cell;
}


#pragma mark -
#pragma mark actions

- (void)doneAction:(id)sender
{
    [self.detailedObject setValue:datePicker.date forKey:self.attributeKey];
    [self.navigationController popViewControllerAnimated:YES];
}


@end
