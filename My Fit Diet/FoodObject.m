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
        
        foodObject = [self setPFObjectValues:foodObject];
        
        [foodObject pinInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            
            [foodObject saveEventually];
        }];
    }
}

- (PFObject*) setPFObjectValues:(PFObject*)object {
    
    object[@"SearchName"] = [name uppercaseString];
    object[@"Name"] = name;
    object[@"Description"] = foodDescription;
    object[@"ServingSize"] = [NSNumber numberWithFloat:servingSize];
    object[@"Calories"] = [NSNumber numberWithInt:calories];
    object[@"TotalFats"] = [NSNumber numberWithFloat:totalFats];
    object[@"SaturatedFats"] = [NSNumber numberWithFloat:saturatedFats];
    object[@"Sodium"] = [NSNumber numberWithFloat:sodium];
    object[@"TotalCarbohydrates"] = [NSNumber numberWithFloat:totalCarbohydrates];
    object[@"Protein"] = [NSNumber numberWithFloat:protein];
    
    object.ACL = [PFACL ACLWithUser:[PFUser currentUser]];
    
    return object;
}

- (void) updateFoodObject:(PFObject *)foodPFObject {
    
    foodPFObject = [self setPFObjectValues:foodPFObject];
    
    [foodPFObject pinInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        [foodPFObject saveEventually];
    }];
}

- (void) convertPFObjectToFoodObject:(PFObject *)foodPFObject {
    
    name = foodPFObject[@"Name"];
    foodDescription = foodPFObject[@"Description"];
    servingSize = [foodPFObject[@"ServingSize"] floatValue];
    calories = [foodPFObject[@"Calories"] intValue];
    totalFats = [foodPFObject[@"TotalFats"] floatValue];
    saturatedFats = [foodPFObject[@"SaturatedFats"] floatValue];
    sodium = [foodPFObject[@"Sodium"] floatValue];
    totalCarbohydrates = [foodPFObject[@"TotalCarbohydrates"] floatValue];
    protein = [foodPFObject[@"Protein"] floatValue];
}

- (void) deleteFoodObject:(PFObject *)foodPFObject {
    
    [foodPFObject deleteEventually];
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
