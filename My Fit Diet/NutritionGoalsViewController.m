//
//  NutritionGoalsViewController.m
//  My Fit Diet
//
//  Created by Stephen Sowole on 21/04/2015.
//  Copyright (c) 2015 Stephen Sowole. All rights reserved.
//

#import "NutritionGoalsViewController.h"
#import "NutritionObject.h"
#import "UserObject.h"

@interface NutritionGoalsViewController ()

@end

@implementation NutritionGoalsViewController {
    
    UserObject *user;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"NUTRITION";
    
    [self removeBackButtonText];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(addNutritionGoals)];
    
    self.navigationItem.rightBarButtonItem = addButton;
    
    user = [[UserObject alloc] init];
    
    if (!user.userCalories) {
        
        [self calculateUserNutrition];
        
    } else {
        
        [self loadUserNutritionValues];
    }
}

- (void) loadUserNutritionValues {
    
    NutritionObject *nutritionObj = self.formController.form;
    
    nutritionObj.calories = user.userCalories;
    nutritionObj.protein = user.userProtein;
    nutritionObj.saturatedFats = user.userSaturatedFats;
    nutritionObj.totalCarbohydrates = user.userTotalCarbohydrates;
    nutritionObj.totalFats = user.userTotalFats;
}

- (void) calculateUserNutrition {
    
    double BMR, caloriesRequired;
    
    NSDateComponents *ageComponents = [[NSCalendar currentCalendar]
                                       components:NSCalendarUnitYear
                                       fromDate:user.dateOfBirth
                                       toDate:[NSDate date]
                                       options:0];
    
    NutritionObject *nutritionObj = self.formController.form;
    
    /*
     
     Men: (10 x weight in kg) + (6.25 x height in cm) - (4.92 x age) + 5
     
     Women: (10 x weight in kg) + (6.25 x height in cm) - (4.92 x age) - 161
     
     **/
    
    if ([user.gender isEqualToString:@"Male"]) {
        
        // convert lb to kg
        BMR += (10.0 * (user.currentWeight * 0.453592));
        BMR += (6.25 * user.height);
        BMR -= (4.92 * [ageComponents year]);
        BMR += 5;
        
    } else if ([user.gender isEqualToString:@"Female"]) {
        
        // convert lb to kg
        BMR += (10.0 * (user.currentWeight * 0.453592));
        BMR += (6.25 * user.height);
        BMR -= (4.92 * [ageComponents year]);
        BMR -= 161;
    }
    
    BMR *= (1 + (0.2 * nutritionObj.activityLevel));
    BMR *= 1.1;
    
    caloriesRequired = (3500 * user.weeklyGoalRate);
    caloriesRequired /= 7;
    
    if (user.currentWeight > user.goalWeight) {
        
        caloriesRequired = BMR - caloriesRequired;
        
    } else if (user.currentWeight < user.goalWeight) {
        
        caloriesRequired = BMR + caloriesRequired;
        
    } else {
        
        caloriesRequired = BMR;
    }
    
    if (caloriesRequired < MINIMUM_USER_CALORIES) {
        
        caloriesRequired = MINIMUM_USER_CALORIES;
    }

    nutritionObj.calories = round(caloriesRequired);
    nutritionObj.protein = round((caloriesRequired * 0.10) / 4.0);
    nutritionObj.totalCarbohydrates = round((caloriesRequired * 0.45) / 4.0);
    nutritionObj.totalFats = round((caloriesRequired * 0.20) / 9.0);
    nutritionObj.saturatedFats = round((caloriesRequired * 0.10) / 9.0);
}

- (void) addNutritionGoals {
    
    NutritionObject *nutritionObj = self.formController.form;
    
    user.userCalories = nutritionObj.calories;
    user.userProtein = nutritionObj.protein;
    user.userSaturatedFats = nutritionObj.saturatedFats;
    user.userTotalCarbohydrates = nutritionObj.totalCarbohydrates;
    user.userTotalFats = nutritionObj.totalFats;
    
    [user syncUserObject];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void) removeBackButtonText {
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backButtonItem];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
