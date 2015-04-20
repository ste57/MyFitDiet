//
//  FoodObject.m
//  My Fit Diet
//
//  Created by Stephen Sowole on 01/04/2015.
//  Copyright (c) 2015 Stephen Sowole. All rights reserved.
//

#import "FoodObject.h"

@implementation FoodObject

@synthesize name, foodDescription, servingSize, calories, totalFats, saturatedFats, sodium, totalCarbohydrates, protein, fatSecretId;

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
    
    object[@"searchName"] = [name uppercaseString];
    object[@"name"] = name;
    object[@"description"] = foodDescription;
    object[@"servingSize"] = [NSNumber numberWithFloat:servingSize];
    object[@"calories"] = [NSNumber numberWithInt:calories];
    object[@"totalFats"] = [NSNumber numberWithFloat:totalFats];
    object[@"saturatedFats"] = [NSNumber numberWithFloat:saturatedFats];
    object[@"sodium"] = [NSNumber numberWithFloat:sodium];
    object[@"totalCarbohydrates"] = [NSNumber numberWithFloat:totalCarbohydrates];
    object[@"protein"] = [NSNumber numberWithFloat:protein];
    object[@"fatSecretID"] = [NSNumber numberWithInteger:fatSecretId];
    
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
    
    name = foodPFObject[@"name"];
    foodDescription = foodPFObject[@"description"];
    servingSize = [foodPFObject[@"servingSize"] floatValue];
    calories = [foodPFObject[@"calories"] intValue];
    totalFats = [foodPFObject[@"totalFats"] floatValue];
    saturatedFats = [foodPFObject[@"saturatedFats"] floatValue];
    sodium = [foodPFObject[@"sodium"] floatValue];
    totalCarbohydrates = [foodPFObject[@"totalCarbohydrates"] floatValue];
    protein = [foodPFObject[@"protein"] floatValue];
    fatSecretId = [foodPFObject[@"fatSecretID"] integerValue];
}

- (void) deleteFoodObject:(PFObject *)foodPFObject {
    
    [foodPFObject unpinInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        [foodPFObject deleteEventually];
    }];
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
