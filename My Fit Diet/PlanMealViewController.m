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

@interface PlanMealViewController ()

@end

@implementation PlanMealViewController {
    
    UITableView *planMealTableView;
    NSMutableArray *mealArray;
    DiaryObject *diary;
}

static NSString * const reuseIdentifier = @"DiaryCell";

- (void) viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = MAIN_BACKGROUND_COLOUR;
    
    self.title = @"RECOMMENDED FOOD";
    
    diary = [[DiaryObject alloc] init];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    
    [dateFormat setDateFormat:DIARY_DATE_FORMAT];
    
    [diary changeDate:[dateFormat stringFromDate:[NSDate date]]];
    
    
    [self removeBackButtonText];

    [self createTableView];
    
    [self getMealData];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(returnToMenu)];
    
    self.navigationItem.leftBarButtonItem = doneButton;
}

- (void) getMealData {
    
    PFQuery *query = [PFQuery queryWithClassName:@"PlanMeal"];
    
    //[query whereKey:@"username" equalTo:userObject._id];
    
    [query setLimit:10];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (!error) {
            
            mealArray = [NSMutableArray arrayWithArray:objects];
            
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