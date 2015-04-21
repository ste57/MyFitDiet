//
//  PlanMealViewController.m
//  My Fit Diet
//
//  Created by Stephen Sowole on 21/04/2015.
//  Copyright (c) 2015 Stephen Sowole. All rights reserved.
//

#import "PlanMealViewController.h"
#import "Constants.h"
#import "DiaryTableViewCell.h"
#import "DiaryObject.h"
#import "AddFoodToDiaryViewController.h"
#import "AddToFoodForm.h"
#import "UserObject.h"

@interface PlanMealViewController ()

@end

@implementation PlanMealViewController {
    
    UITableView *planMealTableView;
    NSMutableArray *mealArray;
    DiaryObject *diary;
    UserObject *user;
}

static NSString * const reuseIdentifier = @"DiaryCell";

- (void) viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = MAIN_BACKGROUND_COLOUR;
    
    self.title = @"RECOMMENDED FOOD";
    
    mealArray = [[NSMutableArray alloc] init];
    
    user = [[UserObject alloc] init];
    
    
    diary = [[DiaryObject alloc] init];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    
    [dateFormat setDateFormat:DIARY_DATE_FORMAT];
    
    [diary changeDate:[dateFormat stringFromDate:[NSDate date]]];
    
    
    [self removeBackButtonText];
    
    [self createTableView];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(returnToMenu)];
    
    self.navigationItem.leftBarButtonItem = doneButton;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getMealData) name:DIARY_RELOAD_STATS object:nil];
}

- (void) getMealData {

    PFQuery *query = [PFQuery queryWithClassName:@"PlanMeal"];
    
    [query whereKey:@"calories" lessThan:[NSNumber numberWithInt:(user.userCalories - diary.currentCalories)]];
    [query whereKey:@"totalFats" lessThan:[NSNumber numberWithFloat:(user.userTotalFats - diary.currentTotalFats)]];
    [query whereKey:@"saturatedFats" lessThan:[NSNumber numberWithFloat:(user.userSaturatedFats - diary.currentSaturatedFats)]];
    [query whereKey:@"totalCarbohydrates" lessThan:[NSNumber numberWithFloat:(user.userTotalCarbohydrates - diary.currentTotalCarbohydrates)]];
    [query whereKey:@"protein" lessThan:[NSNumber numberWithFloat:(user.userProtein - diary.currentProtein)]];
    
    [query orderByDescending:@"calories"];
    
    [query setLimit:10];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (!error) {
            
            for (PFObject *object in objects) {
                
                PFObject *foodObject = [PFObject objectWithClassName:@"Food"];
                
                foodObject[@"name"] = object[@"name"];
                foodObject[@"calories"] = object[@"calories"];
                foodObject[@"totalFats"] = object[@"totalFats"];
                foodObject[@"saturatedFats"] = object[@"saturatedFats"];
                foodObject[@"totalCarbohydrates"] = object[@"totalCarbohydrates"];
                foodObject[@"protein"] = object[@"protein"];
                
                [mealArray addObject:foodObject];
            }
            
            [planMealTableView reloadData];
        }
    }];
}

- (void) createTableView {
    
    planMealTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,
                                                                      self.view.frame.size.height) style:UITableViewStylePlain];
    
    planMealTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    planMealTableView.delegate = self;
    
    planMealTableView.dataSource = self;
    
    planMealTableView.backgroundColor = TRACK_COLOUR;
    
    planMealTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    planMealTableView.contentInset = UIEdgeInsetsMake(0, 0, CELL_PADDING, 0);
    
    [self.view addSubview:planMealTableView];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 110.0f;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return mealArray.count;
}

- (void) returnToMenu {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void) removeBackButtonText {
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backButtonItem];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AddFoodToDiaryViewController *addToDiaryVC = [AddFoodToDiaryViewController alloc];
    
    addToDiaryVC.foodPFObject = [mealArray objectAtIndex:indexPath.row];
    
    addToDiaryVC.diaryDate = diary.diaryDate;
    
    AddToFoodForm *add = [[AddToFoodForm alloc] init];
    
    add.foodAlreadyAdded = NO;
    
    addToDiaryVC.formController.form = add;
    
    [self.navigationController pushViewController:[addToDiaryVC init] animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void) tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
       toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    [tableView deselectRowAtIndexPath:sourceIndexPath animated:YES];
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FoodObject *foodObject = [[FoodObject alloc] init];
    
    [foodObject convertPFObjectToFoodObject:[mealArray objectAtIndex:indexPath.row]];
    
    DiaryTableViewCell *cell = [[DiaryTableViewCell alloc] initWithFrame:CGRectZero];
    
    cell.foodObject = foodObject;
    
    [cell layoutViews];
    
    return cell;
}

- (void) didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

@end