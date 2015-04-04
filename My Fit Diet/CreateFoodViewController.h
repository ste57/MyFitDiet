//
//  CreateFoodViewController.h
//  My Fit Diet
//
//  Created by Stephen Sowole on 01/04/2015.
//  Copyright (c) 2015 Stephen Sowole. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FXForms.h"
#import <Parse/Parse.h>

@interface CreateFoodViewController : FXFormViewController

// Optional (for editing purposes)
@property (strong, nonatomic) PFObject *foodPFObject;

@end
