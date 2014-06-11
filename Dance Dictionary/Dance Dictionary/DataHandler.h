//
//  DataHandler.h
//  Dance Dictionary
//
//  Created by Benjamin Myers on 6/10/14.
//  Copyright (c) 2014 AppGuys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataHandler : NSObject

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSFetchRequest *fetchRequest;
@property (strong, nonatomic) NSEntityDescription *entity;
@property (strong, nonatomic) NSSortDescriptor *sort;
@property (strong, nonatomic) NSArray *sortDescriptors;
@property (strong, nonatomic) NSArray *fetchedObjects;

- (void)getTerms;
- (NSFetchedResultsController *)loadTerms;


@end
