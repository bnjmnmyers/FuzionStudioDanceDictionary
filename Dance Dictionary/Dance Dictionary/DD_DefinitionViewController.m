//
//  DD_DefinitionViewController.m
//  Dance Dictionary
//
//  Created by Benjamin Myers on 3/22/14.
//  Copyright (c) 2014 AppGuys. All rights reserved.
//

#import "DD_DefinitionViewController.h"

@interface DD_DefinitionViewController ()

@end

@implementation DD_DefinitionViewController

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
    NSURL *url = [NSURL URLWithString:@"http://www.youtube.com/watch?v=fDXWW5vX-64"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
