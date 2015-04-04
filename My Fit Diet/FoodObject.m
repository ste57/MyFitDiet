//
//  FoodObject.m
//  My Fit Diet
//
//  Created by Stephen Sowole on 01/04/2015.
//  Copyright (c) 2015 Stephen Sowole. All rights reserved.
//

#import "FoodObject.h"

@implementation FoodObject

@synthesize name, foodDescription, servingSize, calories, totalFats, saturatedFats, sodium, totalCarbohydrates, protein;

- (void) createFoodObject {
    
    if ([PFUser currentUser]) {
        
        PFObject *foodObject = [PFObject objectWithClassName:@"Food"];
        
        foodObject[@"SearchName"] = [name uppercaseString];
        foodObject[@"Name"] = name;
        foodObject[@"Description"] = foodDescription;
        foodObject[@"ServingSize"] = [NSNumber numberWithFloat:servingSize];
        foodObject[@"Calories"] = [NSNumber numberWithInt:calories];
        foodObject[@"TotalFats"] = [NSNumber numberWithFloat:totalFats];
        foodObject[@"SaturatedFats"] = [NSNumber numberWithFloat:saturatedFats];
        foodObject[@"Sodium"] = [NSNumber numberWithFloat:sodium];
        foodObject[@"TotalCarbohydrates"] = [NSNumber numberWithFloat:totalCarbohydrates];
        foodObject[@"Protein"] = [NSNumber numberWithFloat:protein];
        
        foodObject.ACL = [PFACL ACLWithUser:[PFUser currentUser]];
        
        [foodObject pinInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            
            [foodObject saveEventually];
        }];
    }
}

- (void) convertPFObjectToFoodObject:(PFObject *)foodObject {
    
    name = foodObject[@"Name"];
    foodDescription = foodObject[@"Description"];
    servingSize = [foodObject[@"ServingSize"] floatValue];
    calories = [foodObject[@"Calories"] intValue];
    totalFats = [foodObject[@"TotalFats"] floatValue];
    saturatedFats = [foodObject[@"SaturatedFats"] floatValue];
    sodium = [foodObject[@"Sodium"] floatValue];
    totalCarbohydrates = [foodObject[@"TotalCarbohydrates"] floatValue];
    protein = [foodObject[@"Protein"] floatValue];
}

- (NSArray *) fields {
    
    return @[
             // Food Description
             @{FXFormFieldKey: @"name", FXFormFieldTitle: @"Name", FXFormFieldType: @"text", FXFormFieldHeader: @"FOOD DESCRIPTION"},
             
             @{FXFormFieldKey: @"foodDescription", FXFormFieldType: @"longtext", FXFormFieldPlaceholder: @"Optional", FXFormFieldTitle: @"Description", FXFormFieldDefaultValue: @""},
             
             @{FXFormFieldKey: @"servingSize", FXFormFieldTitle: @"Serving Size (g)", FXFormFieldType: @"float", FXFormFieldDefaultValue: @"0"},
             
             
             // Nutrition Information
             @{FXFormFieldKey: @"calories", FXFormFieldTitle: @"Calories (kcal)", FXFormFieldType: @"integer", FXFormFieldDefaultValue: @"0",FXFormFieldHeader: @"NUTRITION INFORMATION"},
             
             @{FXFormFieldKey: @"totalFats", FXFormFieldTitle: @"Total Fats (g)", FXFormFieldType: @"float", FXFormFieldDefaultValue: @"0"},
             
             @{FXFormFieldKey: @"saturatedFats", FXFormFieldTitle: @"Saturated Fats (g)", FXFormFieldType: @"float", FXFormFieldDefaultValue: @"0"},
             
             @{FXFormFieldKey: @"sodium", FXFormFieldTitle: @"Sodium (g)", FXFormFieldType: @"float", FXFormFieldDefaultValue: @"0"},
             
             @{FXFormFieldKey: @"totalCarbohydrates", FXFormFieldTitle: @"Total Carbohydrates (g)", FXFormFieldType: @"float", FXFormFieldDefaultValue: @"0"},
             
             @{FXFormFieldKey: @"protein", FXFormFieldTitle: @"Protein (g)", FXFormFieldType: @"float", FXFormFieldDefaultValue: @"0"},
             ];
}

@end
