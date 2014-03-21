//
//  DD_MainViewController.m
//  Dance Dictionary
//
//  Created by Benjamin Myers on 3/3/14.
//  Copyright (c) 2014 AppGuys. All rights reserved.
//

#import "DD_MainViewController.h"
#import "Reachability.h"
#import "Term.h"

@interface DD_MainViewController ()
{
    Reachability *internetReachable;
}
@end

@implementation DD_MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
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
    
    _isConnected = TRUE;
    [self checkOnlineConnection];
    
    if (_isConnected == TRUE) {
        [self getTerms];
	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getTerms {
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
}

- (void)clearEntity:(NSString *)entity
{
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

- (void)checkOnlineConnection {
    
    internetReachable = [Reachability reachabilityWithHostname:@"www.google.com"];
    
    // Internet is not reachable
    // NOTE - change "reachableBlock" to "unreachableBlock"
    
    internetReachable.unreachableBlock = ^(Reachability*reach)
    {
		_isConnected = FALSE;
    };
	
	internetReachable.reachableBlock = ^(Reachability*reach)
    {
		_isConnected = TRUE;
    };
    
    [internetReachable startNotifier];
    
}

@end
