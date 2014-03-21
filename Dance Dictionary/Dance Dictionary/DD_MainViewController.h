//
//  DD_MainViewController.h
//  Dance Dictionary
//
//  Created by Benjamin Myers on 3/3/14.
//  Copyright (c) 2014 AppGuys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DD_MainViewController : UIViewController

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSFetchRequest *fetchRequest;
@property (strong, nonatomic) NSEntityDescription *entity;
@property (strong, nonatomic) NSSortDescriptor *sort;
@property (strong, nonatomic) NSArray *sortDescriptors;
@property (strong, nonatomic) NSArray *fetchedObjects;

@property (assign, nonatomic) BOOL isConnected;

@end
