//
//  RootViewController.h
//  NSManagedObjectContextSample
//
//  Created by Katsuyoshi Ito on 09/08/02.
//  Copyright ITO SOFT DESIGN Inc 2009. All rights reserved.
//

@interface RootViewController : UITableViewController <NSFetchedResultsControllerDelegate> {
	NSFetchedResultsController *fetchedResultsController;
	NSManagedObjectContext *managedObjectContext;
}

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end
