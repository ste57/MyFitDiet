//
//  UserObject.h
//  My Fit Diet
//
//  Created by Stephen Sowole on 02/04/2015.
//  Copyright (c) 2015 Stephen Sowole. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserObject : NSObject

// Data Collected From Facebook
@property (strong, nonatomic) NSString *_id;
@property (strong, nonatomic) NSString *first_name;
@property (strong, nonatomic) NSString *gender;
@property (strong, nonatomic) NSString *email;

// Data Collected From My Fit Diet
@property float currentWeight;
@property float goalWeight;
@property int age;
@property float height;

- (void) updateObject;

@end
