//
//  FoodObject.m
//  My Fit Diet
//
//  Created by Stephen Sowole on 01/04/2015.
//  Copyright (c) 2015 Stephen Sowole. All rights reserved.
//

#import "FoodObject.h"

@implementation FoodObject

- (NSArray *) fields {
    
    
    return @[
             @{FXFormFieldKey: @"text", FXFormFieldTitle: @"Name"},
             @{FXFormFieldKey: @"longtext", FXFormFieldTitle: @"Food Description"},
             @{FXFormFieldKey: @"number", FXFormFieldTitle: @"Serving Size (g)"},
             ];
    
    //return @[@"Name", @"FoodDescription", @"ServingSize (g)", @"Calories (kcal)", @"TotalFats (g)", @"SaturatedFats (g)", @"Sodium (g)", @"TotalCarbohydrates (g)", @"Protein (g)"];
}

@end
