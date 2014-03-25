//
//  DD_DefinitionViewController.h
//  Dance Dictionary
//
//  Created by Benjamin Myers on 3/22/14.
//  Copyright (c) 2014 AppGuys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DD_DefinitionViewController : UIViewController <UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end
