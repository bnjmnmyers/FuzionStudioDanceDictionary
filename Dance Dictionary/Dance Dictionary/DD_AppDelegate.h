//
//  DD_AppDelegate.h
//  Dance Dictionary
//
//  Created by Benjamin Myers on 3/2/14.
//  Copyright (c) 2014 AppGuys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DD_AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
