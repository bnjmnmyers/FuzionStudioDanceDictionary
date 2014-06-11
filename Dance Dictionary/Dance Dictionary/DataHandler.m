//
//  DataHandler.m
//  Dance Dictionary
//
//  Created by Benjamin Myers on 6/10/14.
//  Copyright (c) 2014 AppGuys. All rights reserved.
//

#import "DataHandler.h"
#import "Term.h"

@implementation DataHandler

- (void)getTerms {
    id delegate = [[UIApplication sharedApplication]delegate];
    self.managedObjectContext = [delegate managedObjectContext];
    
    [self clearEntity:@"Term"];
    
    NSString *urlString = [NSString stringWithFormat:@"http://www.fuzionstudio.net/test/includes/_appJSON.php?getTerms=1"];
	NSURL *url = [NSURL URLWithString:urlString];
	NSData *webData = [NSData dataWithContentsOfURL:url];
	
	NSDictionary *allDataDictionary = [NSJSONSerialization JSONObjectWithData:webData options:kNilOptions error:nil];
	NSDictionary *feed = [allDataDictionary objectForKey:@"feed"];
	NSDictionary *termsDictionary = [feed objectForKey:@"terms"];
    NSLog(@"%@", termsDictionary);
	for (NSDictionary *diction in termsDictionary) {
		Term *newTerm = (Term *)[NSEntityDescription insertNewObjectForEntityForName:@"Term" inManagedObjectContext:_managedObjectContext];
		newTerm.term = NSLocalizedString([diction objectForKey:@"term"], nil);
		newTerm.definition = NSLocalizedString([diction objectForKey:@"definition"], nil);
		newTerm.videoURL = NSLocalizedString([diction objectForKey:@"videoURL"], nil);
		newTerm.origin = NSLocalizedString([diction objectForKey:@"origin"], nil);
		newTerm.pronunciation = NSLocalizedString([diction objectForKey:@"pronunciation"], nil);
		newTerm.termID = [NSNumber numberWithInt:[NSLocalizedString([diction objectForKey:@"id"], nil) intValue]];
	}
    [self.managedObjectContext save:nil];
    
}



- (NSFetchedResultsController *) loadTerms
{
    id delegate = [[UIApplication sharedApplication]delegate];
    self.managedObjectContext = [delegate managedObjectContext];
    
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
	
	return _fetchedResultsController;
}

- (void)clearEntity:(NSString *)entity
{
    id delegate = [[UIApplication sharedApplication]delegate];
    self.managedObjectContext = [delegate managedObjectContext];
    
	_fetchRequest = [[NSFetchRequest alloc]init];
	_entity = [NSEntityDescription entityForName:entity inManagedObjectContext:[self managedObjectContext]];
	
	[_fetchRequest setEntity:_entity];
	
	NSError *error = nil;
	_fetchedObjects = [[self managedObjectContext] executeFetchRequest:_fetchRequest error:&error];
	
	for (NSManagedObject *object in _fetchedObjects) {
		[[self managedObjectContext] deleteObject:object];
	}
	
	NSError *saveError = nil;
	if (![[self managedObjectContext] save:&saveError]) {
		NSLog(@"An error has occurred: %@", saveError);
	}
}

@end
