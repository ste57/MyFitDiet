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
#import "DiaryObject.h"

@interface AddFoodToDiaryViewController ()

@end

@implementation AddFoodToDiaryViewController {
    
    UIScrollView *scrollView;
    
    FoodObject *foodObject;
}

@synthesize foodPFObject;

- (void) viewDidLoad {
    
    [super viewDidLoad];

    foodObject = [[FoodObject alloc] init];
    
    [foodObject convertPFObjectToFoodObject:foodPFObject];
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(returnToMenu)];
    
    self.navigationItem.leftBarButtonItem = doneButton;
    
    [self removeBackButtonText];
    
    self.title = [foodObject.name uppercaseString];
    
    [self createFoodInfoView];
}

- (void) removeBackButtonText {
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backButtonItem];
}

- (void) createFoodInfoView {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 150.0)];
    
    view.backgroundColor = [UIColor whiteColor];
    
    self.tableView.tableHeaderView = view;
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

    [foodObject updateFoodObject:foodPFObject];
    
    DiaryObject *diaryObject = [[DiaryObject alloc] init];
    
    diaryObject.diaryDate = self.diaryDate;
    
    [diaryObject addFoodToDiary:foodPFObject forOccasion:occasion];
    
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
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
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) returnToMenu {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

@end
