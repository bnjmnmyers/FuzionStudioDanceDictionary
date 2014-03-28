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
	[self embedYouTube];
	[self populateFields];
	
	_webView.scrollView.scrollEnabled = NO;
	_webView.scrollView.bounces = NO;
}

- (void)embedYouTube
{
	NSString *embedHTML = @"<iframe width=\"1180\" height=\"786\" src=\"http://www.youtube.com/embed/59Ct83OX3I0\" frameborder=\"0\" allowfullscreen></iframe>";
	
	[_webView loadHTMLString:embedHTML baseURL:nil];
	[self.view addSubview:_webView];
}

- (void)populateFields
{
	_tfTerm.text = _currentTerm.term;
	_tfPronunciation.text = [NSString stringWithFormat:@"[%@]", _currentTerm.pronunciation];
	_tfOrigin.text = _currentTerm.origin;
	_tvDefinition.text = _currentTerm.definition;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
