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
             // Food Description
             @{FXFormFieldKey: @"name", FXFormFieldTitle: @"Name", FXFormFieldType: @"text", FXFormFieldHeader: @"FOOD DESCRIPTION"},
             
             @{FXFormFieldKey: @"foodDescription", FXFormFieldType: @"longtext", FXFormFieldPlaceholder: @"Optional", FXFormFieldTitle: @"Description"},
             
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
