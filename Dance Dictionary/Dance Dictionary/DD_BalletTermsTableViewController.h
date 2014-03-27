//
//  DD_BalletTermsTableViewController.h
//  Dance Dictionary
//
//  Created by Benjamin Myers on 3/3/14.
//  Copyright (c) 2014 AppGuys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"

@interface DD_BalletTermsTableViewController : UITableViewController <UISearchBarDelegate, UISearchDisplayDelegate>

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSFetchRequest *fetchRequest;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong)NSEntityDescription *entity;
@property (nonatomic, strong) NSSortDescriptor *sort;
@property (nonatomic, strong) NSArray *sortDescriptors;
@property (nonatomic, strong) NSArray *fetchedObjects;
@property (nonatomic, strong) NSMutableArray *filteredFetchedObjects;
@property (nonatomic, strong) NSIndexPath *indexPath;

@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@end
