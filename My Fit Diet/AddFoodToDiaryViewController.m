//
//  AddFoodToDiaryViewController.m
//  My Fit Diet
//
//  Created by Stephen Sowole on 04/04/2015.
//  Copyright (c) 2015 Stephen Sowole. All rights reserved.
//

#import "AddFoodToDiaryViewController.h"
#import "Constants.h"
#import "CreateFoodViewController.h"
#import "DiaryViewController.h"
#import "AddToFoodForm.h"
#import "FSClient.h"
#import "FSFood.h"
#import "FSServing.h"

@interface AddFoodToDiaryViewController ()

@end

@implementation AddFoodToDiaryViewController {
    
    UIScrollView *scrollView;
    
    FoodObject *foodObject;
    
    DiaryObject *diaryObject;
    
    NSArray *nutritionLabels, *nutritionInitials;
    
    UILabel *descriptionLabel;
}

@synthesize foodPFObject, diaryDate;

- (void) viewDidLoad {
    
    [super viewDidLoad];
    
    // initialise diary
    
    diaryObject = [[DiaryObject alloc] init];
    
    diaryObject.diaryDate = diaryDate;
    
    // initialise foodObject
    
    foodObject = [[FoodObject alloc] init];
    
    [foodObject convertPFObjectToFoodObject:foodPFObject];
    
    // create view
    
    self.title = @"FOOD DETAILS";
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(returnToMenu)];
    
    self.navigationItem.leftBarButtonItem = doneButton;
    
    [self removeBackButtonText];
    
    [self createFoodInfoView];
    
    [self getFoodNutritionInformation];
}

- (void) getFoodNutritionInformation {
    
    if (foodObject.fatSecretId && !foodObject.foodDescription) {
        
        [[FSClient sharedClient] getFood:foodObject.fatSecretId completion:^(FSFood *food) {
            
            FSServing *serving = [food.servings firstObject];
            
            foodObject.calories = [serving.calories intValue];
            foodObject.foodDescription = food.type;
            foodObject.totalFats = serving.fatValue;
            foodObject.saturatedFats = serving.saturatedFatValue;
            foodObject.sodium = serving.sodiumValue;
            foodObject.totalCarbohydrates = serving.carbohydrateValue;
            foodObject.protein = serving.proteinValue;
            
            if (!foodObject.servingSize) {
                
                foodObject.servingSize = 1;
            }
            
            [self setNutritionLabels];
        }];
        
    } else {
        
        if (!foodObject.foodDescription) {
            
            foodObject.foodDescription = @"recommended";
        }
        
        [self setNutritionLabels];
    }
}

- (void) viewDidAppear:(BOOL)animated {
    
    [self setNutritionLabels];
}

- (void) removeBackButtonText {
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backButtonItem];
}

- (void) createFoodInfoView {
    
    [self addDescriptionTextView];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, NUTRIENT_INFO_STAT_RADIUS*1.75 + descriptionLabel.frame.size.height)];
    
    view.backgroundColor = [UIColor whiteColor];
    
    self.tableView.tableHeaderView = view;
    
    [self.tableView.tableHeaderView addSubview:descriptionLabel];
    
    [self setNutritionArray];
    
    [self addNutritionImages];
}

- (void) addDescriptionTextView {
    
    descriptionLabel = [[UILabel alloc] init];
    
    descriptionLabel.textAlignment = NSTextAlignmentCenter;
    
    descriptionLabel.textColor = [UIColor colorWithWhite:0.3 alpha:1.0];
    
    descriptionLabel.font = [UIFont fontWithName:@"Primer" size:18.0f];
    
    descriptionLabel.center = CGPointMake(self.view.frame.size.width/2, 5);
    
    descriptionLabel.layer.anchorPoint = CGPointMake(0.5, 0);
    
    descriptionLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    descriptionLabel.clipsToBounds = YES;
    
    descriptionLabel.numberOfLines = 0;
    
    [self setDescriptionText];
}

- (void) setNutritionArray {
    
    nutritionInitials = [NSArray arrayWithObjects:@"Kcal", @"crb(g)", @"s.f(g)", @"fat(g)", @"prt(g)", nil];
    
    nutritionLabels = [NSArray arrayWithObjects:
                       
                       [[UILabel alloc] initWithFrame:CGRectMake(0, 0, NUTRIENT_INFO_STAT_RADIUS, NUTRIENT_INFO_STAT_RADIUS*1.5)],
                       [[UILabel alloc] initWithFrame:CGRectMake(0, 0, NUTRIENT_INFO_STAT_RADIUS, NUTRIENT_INFO_STAT_RADIUS*1.5)],
                       [[UILabel alloc] initWithFrame:CGRectMake(0, 0, NUTRIENT_INFO_STAT_RADIUS, NUTRIENT_INFO_STAT_RADIUS*1.5)],
                       [[UILabel alloc] initWithFrame:CGRectMake(0, 0, NUTRIENT_INFO_STAT_RADIUS, NUTRIENT_INFO_STAT_RADIUS*1.5)],
                       [[UILabel alloc] initWithFrame:CGRectMake(0, 0, NUTRIENT_INFO_STAT_RADIUS, NUTRIENT_INFO_STAT_RADIUS*1.5)],
                       
                       nil];
}

- (void) addNutritionImages {
    
    UIView *circle;
    
    NSArray *startColors = [NSArray arrayWithObjects:
                            KCAL_BAR_COLOUR, CARBS_COLOUR, S_FATS_COLOUR, FATS_COLOUR,
                            [UIColor colorWithRed:0.84 green:0.83 blue:0.42 alpha:1.0],
                            nil];
    
    float separationValue = NUTRIENT_INFO_STAT_RADIUS * 5;
    separationValue = self.view.frame.size.width - separationValue;
    separationValue /= 6;
    
    float xVal = separationValue;
    xVal += (NUTRIENT_INFO_STAT_RADIUS/2);
    
    
    for (int i = 0; i < nutritionLabels.count; i++) {
        
        circle = [[UIView alloc] initWithFrame:CGRectMake(0, 0, NUTRIENT_INFO_STAT_RADIUS, NUTRIENT_INFO_STAT_RADIUS*1.5)];
        
        circle.layer.cornerRadius = NUTRIENT_INFO_STAT_RADIUS/2;
        
        circle.layer.anchorPoint = CGPointMake(0.5, 0);
        
        circle.center = CGPointMake(xVal, self.tableView.tableHeaderView.frame.size.height - NUTRIENT_INFO_STAT_RADIUS*1.75);
        
        circle.backgroundColor = [startColors objectAtIndex:i];
        
        [self.tableView.tableHeaderView addSubview:circle];
        
        
        UILabel *label = [nutritionLabels objectAtIndex:i];
        
        label.textColor = [UIColor whiteColor];
        
        label.textAlignment = NSTextAlignmentCenter;
        
        label.numberOfLines = 3;
        
        label.font = [UIFont fontWithName:@"lekton04" size:13.5];
        
        [circle addSubview:label];
        
        
        xVal += (NUTRIENT_INFO_STAT_RADIUS + separationValue);
    }
}

- (void) setNutritionLabels {
    
    FoodObject *foodObj = self.formController.form;
    
    NSArray *nutritionArray = [NSArray arrayWithObjects:
                               
                               [NSNumber numberWithInt:foodObject.calories * foodObj.servingSize],
                               [NSNumber numberWithFloat:foodObject.totalCarbohydrates * foodObj.servingSize],
                               [NSNumber numberWithFloat:foodObject.saturatedFats * foodObj.servingSize],
                               [NSNumber numberWithFloat:foodObject.totalFats * foodObj.servingSize],
                               [NSNumber numberWithFloat:foodObject.protein * foodObj.servingSize],
                               
                               nil];
    
    for (int i = 0; i < nutritionLabels.count; i++) {
        
        UILabel *label = [nutritionLabels objectAtIndex:i];
        
        label.text = [[NSString stringWithFormat:@"%@\n\n%@", [nutritionArray objectAtIndex:i], [nutritionInitials objectAtIndex:i]]uppercaseString];
    }
    
    [self setDescriptionText];
}

- (void) setDescriptionText {
    
    NSString *text;
    
    if (![foodObject.foodDescription isEqual:@""]) {
        
        text = [NSString stringWithFormat:@"%@\n\n%@", foodObject.name, foodObject.foodDescription];
        
    } else {
        
        text = [NSString stringWithFormat:@"%@", foodObject.name];
    }
    
    
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:
                                          text attributes:
                                          @{ NSFontAttributeName: descriptionLabel.font}];
    
    CGRect rect = [attributedText boundingRectWithSize:(CGSize){self.view.frame.size.width - 30, CGFLOAT_MAX}
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    CGSize size = rect.size;
    
    descriptionLabel.frame = CGRectMake(15, 0, self.view.frame.size.width - 30, size.height + 40);
    
    descriptionLabel.text = text;
}

- (void) addToBreakfast {
    
    [self addFoodToDiary:BREAKFAST];
}

- (void) addToLunch {
    
    [self addFoodToDiary:LUNCH];
}

- (void) addToDinner {
    
    [self addFoodToDiary:DINNER];
}

- (void) addToSnacks {
    
    [self addFoodToDiary:SNACK];
}

- (void) addFoodToDiary:(NSString*)occasion {
    
    AddToFoodForm *form = self.formController.form;
    
    [foodObject updateFoodObject:foodPFObject];
    
    [diaryObject addFoodToDiary:foodPFObject servingSize:form.servingSize forOccasion:occasion];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void) editFoodObject {
    
    CreateFoodViewController *createFoodVC = [[CreateFoodViewController alloc] init];
    
    createFoodVC.formController.form = foodObject;
    
    createFoodVC.foodPFObject = foodPFObject;
    
    createFoodVC.title = @"Edit Food";
    
    [self.navigationController pushViewController:createFoodVC animated:YES];
}

- (void) deleteFoodObject {
    
    [foodObject deleteFoodObject:foodPFObject];
    
    [diaryObject removeAllEntries:foodPFObject];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) returnToMenu {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

@end
