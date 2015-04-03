//
//  UserObject.h
//  My Fit Diet
//
//  Created by Stephen Sowole on 02/04/2015.
//  Copyright (c) 2015 Stephen Sowole. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FXForms.h"

@interface UserObject : NSObject <FXForm>

// Data Collected From Facebook
@property (strong, nonatomic) NSString *_id;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *gender;
@property (strong, nonatomic) NSString *email;

// Data Collected From My Fit Diet
@property (strong, nonatomic) NSDate *dateOfBirth;

@property float height;
@property float currentWeight;
@property float goalWeight;

@property bool userSetGainWeight;
@property float weeklyGoalRate;


- (void) syncUserObject;

@end
