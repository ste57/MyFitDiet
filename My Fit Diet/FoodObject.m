//
//  FoodObject.m
//  My Fit Diet
//
//  Created by Stephen Sowole on 01/04/2015.
//  Copyright (c) 2015 Stephen Sowole. All rights reserved.
//

#import "FoodObject.h"
#import <Parse/Parse.h>

@implementation FoodObject

@synthesize name, foodDescription, servingSize, calories, totalFats, saturatedFats, sodium, totalCarbohydrates, protein;

/*PFQuery *query = [PFQuery queryWithClassName:@"Food"];
 [query fromLocalDatastore];
 
 [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
 
 if (!error) {
 
 for (PFObject *object in objects) {
 
 //NSArray *arr = object[MUMBLE_DATA_TAGS];
 NSLog(@"%@\n", object[@"playerName"]);
 }
 }*/

- (void) createFoodObject {
    
    if ([PFUser currentUser]) {
        
        PFObject *foodObject = [PFObject objectWithClassName:@"Food"];
        
        foodObject[@"Name"] = name;
        foodObject[@"Description"] = foodDescription;
        foodObject[@"ServingSize"] = [NSNumber numberWithFloat:servingSize];
        foodObject[@"Calories"] = [NSNumber numberWithInt:calories];
        foodObject[@"TotalFats"] = [NSNumber numberWithFloat:totalFats];
        foodObject[@"SaturatedFats"] = [NSNumber numberWithFloat:saturatedFats];
        foodObject[@"Sodium"] = [NSNumber numberWithFloat:sodium];
        foodObject[@"TotalCarbohydrates"] = [NSNumber numberWithFloat:totalCarbohydrates];
        foodObject[@"Protein"] = [NSNumber numberWithFloat:protein];
        
        [foodObject pinInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            
            [foodObject saveEventually];
            
        }];
    }
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
