//
//  Term.h
//  Dance Dictionary
//
//  Created by Benjamin Myers on 3/3/14.
//  Copyright (c) 2014 AppGuys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Term : NSManagedObject

@property (nonatomic, retain) NSNumber * termID;
@property (nonatomic, retain) NSString * term;
@property (nonatomic, retain) NSString * definition;
@property (nonatomic, retain) NSString * videoURL;
@property (nonatomic, retain) NSString * origin;
@property (nonatomic, retain) NSString * pronunciation;

@end
