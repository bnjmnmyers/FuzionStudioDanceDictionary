//
//  DD_BalletTermsTableViewController.m
//  Dance Dictionary
//
//  Created by Benjamin Myers on 3/3/14.
//  Copyright (c) 2014 AppGuys. All rights reserved.
//

#import "DD_BalletTermsTableViewController.h"
#import "DD_DefinitionViewController.h"
#import "Term.h"
#import "DataHandler.h"

@interface DD_BalletTermsTableViewController ()
{
    DataHandler *dataHandler;
}
@end

@implementation NSString (FetchedGroupByString)
- (NSString *)stringGroupByFirstInitial {
    if (!self.length || self.length == 1)
        return self;
    return [self substringToIndex:1];
}
@end

@implementation DD_BalletTermsTableViewController
{
    
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	id delegate = [[UIApplication sharedApplication]delegate];
	self.managedObjectContext = [delegate managedObjectContext];
	
    dataHandler = [[DataHandler alloc] init];
    
	NSError *error = nil;
	if (![[dataHandler loadTerms]performFetch:&error]) {
		NSLog(@"An error has occurred: %@", error);
		abort();
	}
    _filteredFetchedObjects = [NSMutableArray arrayWithCapacity:[_fetchedObjects count]];
	
	[self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return [[dataHandler.fetchedResultsController sections]count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [[[dataHandler.fetchedResultsController sections] objectAtIndex:section] numberOfObjects];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    FS_DressCodeCell *cell = (FS_DressCodeCell *)[tableView dequeueReusableCellWithIdentifier:[_dressCodeCell reuseIdentifier]];
//    
//    if (cell == nil) {
//		[[NSBundle mainBundle] loadNibNamed:@"DressCodeCell" owner:self options:nil];
//        cell = _dressCodeCell;
//        _dressCodeCell = nil;
//	}
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if ( cell == nil ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    Term *term = nil;
	
	term = [dataHandler.fetchedResultsController objectAtIndexPath:indexPath];
	cell.textLabel.text = term.term;
    
    // Configure the cell...
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	UIView *tempView = [[UIView alloc]initWithFrame:CGRectMake(0,200,320,244)];
	//tempView.backgroundColor=[UIColor clearColor];
	
	UILabel *tempLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0,320,32)];
	//tempLabel.backgroundColor = [UIColor colorWithRed:(112/255.0) green:(18/255.0) blue:(17/255.0) alpha:1.0];
    tempLabel.backgroundColor = [UIColor darkGrayColor];
	//tempLabel.shadowColor = [UIColor blackColor];
	//tempLabel.shadowOffset = CGSizeMake(0,2);
	tempLabel.textColor = [UIColor whiteColor]; //here you can change the text color of header.
	//tempLabel.font = [UIFont fontWithName:@"Helvetica" size:fontSizeForHeaders];
	//tempLabel.font = [UIFont boldSystemFontOfSize:fontSizeForHeaders];
	
	NSString *sectionTitle;
	sectionTitle = [[[dataHandler.fetchedResultsController sections]objectAtIndex:section]name];
	
	tempLabel.text = [NSString stringWithFormat:@"  %@", sectionTitle];
	
	[tempView addSubview:tempLabel];
	
	//[tempLabel release];
	return tempView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (tableView == self.searchDisplayController.searchResultsTableView) {
		[self performSegueWithIdentifier:@"segueFromBalletTermToDefinition" sender:nil];
    }
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if ([searchText length] == 0) {
        dataHandler.fetchedResultsController = nil;
    }
    else {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"term contains[cd] %@", searchText];
        [[dataHandler.fetchedResultsController fetchRequest] setPredicate:predicate];
    }
	
    NSError *error;
    if (![[dataHandler loadTerms] performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
	
    [[self tableView] reloadData];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"segueFromBalletTermToDefinition"]) {
		DD_DefinitionViewController *dvc = [segue destinationViewController];
		Term *selectedTerm = nil;
		if ([self.searchDisplayController isActive])
		{
            _indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
		} else {
            _indexPath = [self.tableView indexPathForSelectedRow];
        }
        selectedTerm = [dataHandler.fetchedResultsController objectAtIndexPath:_indexPath];
		dvc.currentTerm = selectedTerm;
		
	}}


@end
