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
#import "DataHandler.h"

@interface DD_MainViewController ()
{
    Reachability *internetReachable;
    DataHandler *dataHandler;
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
    
    internetReachable = [[Reachability alloc] init];
    dataHandler = [[DataHandler alloc] init];
    [internetReachable checkConnection];
    if (internetReachable.isConnected) {
        [dataHandler getTerms];
	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
