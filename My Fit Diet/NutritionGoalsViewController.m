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
    
    [self calculateUserNutrition];
}

- (void) calculateUserNutrition {
    
    NutritionObject *nutritionObj = self.formController.form;
    
    nutritionObj.calories = 2000;
    nutritionObj.protein = 50;
    nutritionObj.saturatedFats = 50;
    nutritionObj.totalCarbohydrates = 50;
    nutritionObj.totalFats = 50;
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
