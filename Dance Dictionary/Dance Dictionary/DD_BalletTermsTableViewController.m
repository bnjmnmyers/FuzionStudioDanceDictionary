//
//  DD_BalletTermsTableViewController.m
//  Dance Dictionary
//
//  Created by Benjamin Myers on 3/3/14.
//  Copyright (c) 2014 AppGuys. All rights reserved.
//

#import "DD_BalletTermsTableViewController.h"
#import "Term.h"

@interface DD_BalletTermsTableViewController ()

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
    
    [self loadTerms];
    _filteredFetchedObjects = [NSMutableArray arrayWithCapacity:[_fetchedObjects count]];
	
	NSError *error = nil;
	if (![[self loadTerms]performFetch:&error]) {
		NSLog(@"An error has occurred: %@", error);
		abort();
	}
	
	[self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSFetchedResultsController *) loadTerms
{
	if (_fetchedResultsController != nil)
	{
		return _fetchedResultsController;
	}
	
	_fetchRequest = [[NSFetchRequest alloc]init];
	_entity = [NSEntityDescription entityForName:@"Term" inManagedObjectContext:[self managedObjectContext]];
	_sort = [NSSortDescriptor sortDescriptorWithKey:@"term" ascending:YES];
	_sortDescriptors = [[NSArray alloc]initWithObjects:_sort, nil];
	[_fetchRequest setEntity:_entity];
	[_fetchRequest setSortDescriptors:_sortDescriptors];
    
    NSError *error = nil;
    
    _fetchedObjects = [[self managedObjectContext] executeFetchRequest:_fetchRequest error:&error];
	
	_fetchedResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:_fetchRequest managedObjectContext:[self managedObjectContext] sectionNameKeyPath:@"term.stringGroupByFirstInitial" cacheName:nil];
	
	_fetchedResultsController.delegate = self;
	
	return _fetchedResultsController;
	
	[self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	//return [[self.fetchedResultsController sections]count];
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//	id <NSFetchedResultsSectionInfo> secInfo = [[self.fetchedResultsController sections]objectAtIndex:section];
//	return [secInfo numberOfObjects];
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [_filteredFetchedObjects count];
    } else {
        return [_fetchedObjects count];
    }
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
	//Term *term = [self.fetchedResultsController objectAtIndexPath:indexPath];
    Term *term = nil;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        term = [_filteredFetchedObjects objectAtIndex:indexPath.row];
    } else {
        term = [_fetchedObjects objectAtIndex:indexPath.row];
    }
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
	sectionTitle = [[[self.fetchedResultsController sections]objectAtIndex:section]name];
	
	tempLabel.text = [NSString stringWithFormat:@"  %@", sectionTitle];
	
	[tempView addSubview:tempLabel];
	
	//[tempLabel release];
	return tempView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	//[self performSegueWithIdentifier:@"segueToLeotardWebView" sender:nil];
    
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope{
    [self.filteredFetchedObjects removeAllObjects];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.term contains[c] %@", searchText];
    _filteredFetchedObjects = [NSMutableArray arrayWithArray:[_fetchedObjects filteredArrayUsingPredicate:predicate]];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    // Tells the table data source to reload when text changes
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    // Tells the table data source to reload when scope bar selection changes
    [self filterContentForSearchText:self.searchDisplayController.searchBar.text scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
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

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
