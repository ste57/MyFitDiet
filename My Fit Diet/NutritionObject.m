//
//  NutritionObject.m
//  My Fit Diet
//
//  Created by Stephen Sowole on 21/04/2015.
//  Copyright (c) 2015 Stephen Sowole. All rights reserved.
//

#import "NutritionObject.h"

typedef NS_ENUM(int, weightGoal) {
    
    none = 1,
    light = 2,
    active = 3,
};

@implementation NutritionObject

@synthesize activityLevel;

- (NSArray *) fields {
    
    activityLevel = light;
    
    return @[
             // Nutrition Goals
             @{FXFormFieldKey: @"calories", FXFormFieldTitle: @"Calories (kcal)", FXFormFieldType: @"integer", FXFormFieldHeader: @"NUTRITION GOALS"},
             
             @{FXFormFieldKey: @"totalFats", FXFormFieldType: @"float", FXFormFieldTitle: @"Total Fats (g)"},
             
             @{FXFormFieldKey: @"totalCarbohydrates", FXFormFieldTitle: @"Carbohydrates (g)", FXFormFieldType: @"float"},
             
             @{FXFormFieldKey: @"protein", FXFormFieldTitle: @"Protein (g)", FXFormFieldType: @"float"},
             
             @{FXFormFieldKey: @"saturatedFats", FXFormFieldTitle: @"Saturated Fats (g)", FXFormFieldType: @"float"},
             
             
             // Activity Level
             
             @{FXFormFieldKey: @"activityLevel", FXFormFieldHeader: @"ACTIVITY LEVEL", FXFormFieldTitle: @"Activity Level", FXFormFieldType: @"integer", FXFormFieldOptions: @[@(none), @(light), @(active)],
               
               FXFormFieldValueTransformer: ^(id input) {
                   
                   return @{@(none): @"No Activity",
                            @(light): @"Light Activity",
                            @(active): @"Active"}[input];}},
             ];
}


@end
