//
//  DD_DefinitionViewController.h
//  Dance Dictionary
//
//  Created by Benjamin Myers on 3/22/14.
//  Copyright (c) 2014 AppGuys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Term.h"

@interface DD_DefinitionViewController : UIViewController <UIWebViewDelegate, UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *webView;

@property (strong, nonatomic) Term *currentTerm;

@property (strong, nonatomic) IBOutlet UILabel *tfTerm;
@property (strong, nonatomic) IBOutlet UILabel *tfPronunciation;
@property (strong, nonatomic) IBOutlet UILabel *tfOrigin;
@property (strong, nonatomic) IBOutlet UITextView *tvDefinition;

@end
