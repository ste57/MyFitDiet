//
//  DiaryViewController.m
//  My Fit Diet
//
//  Created by Stephen Sowole on 01/04/2015.
//  Copyright (c) 2015 Stephen Sowole. All rights reserved.
//

#import "DiaryViewController.h"
#import "Constants.h"
#import "DiaryTableViewCell.h"
#import "SearchFoodTableViewController.h"
#import "AddFoodToDiaryViewController.h"
#import "AddToFoodForm.h"

@interface DiaryViewController ()

@end

@implementation DiaryViewController {
    
    UITableView *diaryTableView;
    UIView *dateView;
}

@synthesize diary;

static NSString * const reuseIdentifier = @"DiaryCell";

- (void) viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = MAIN_BACKGROUND_COLOUR;
    
    self.title = @"DIARY";
    
    [self removeBackButtonText];
    
    [self addDateView];
    
    [self createTableView];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(returnToMenu)];
    
    self.navigationItem.leftBarButtonItem = doneButton;
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(toggleFoodSearch)];
    
    self.navigationItem.rightBarButtonItem = addButton;
}

- (void) removeBackButtonText {
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backButtonItem];
}

- (void) toggleFoodSearch {
    
    SearchFoodTableViewController *searchFoodTVC = [[SearchFoodTableViewController alloc] init];
    
    searchFoodTVC.diaryDate = diary.diaryDate;
    
    [self.navigationController pushViewController:searchFoodTVC animated:YES];
}

- (void) createTableView {
    
    diaryTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, dateView.frame.size.height, self.view.frame.size.width,
                                                                   self.view.frame.size.height - dateView.frame.size.height) style:UITableViewStylePlain];
    
    diaryTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    diaryTableView.delegate = self;
    
    diaryTableView.dataSource = self;
    
    diaryTableView.backgroundColor = TRACK_COLOUR;
    
    diaryTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    diaryTableView.contentInset = UIEdgeInsetsMake(0, 0, CELL_PADDING, 0);
    
    [self.view addSubview:diaryTableView];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 110.0f;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return diary.foodDiary.count;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSArray *array = [diary.foodDiary objectForKey:[diary.occasionArray objectAtIndex:section]];
    
    return array.count;
}

- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    NSIndexPath *indexPath = [diaryTableView indexPathForSelectedRow];
    
    switch (buttonIndex) {
            
        case 0:
            
            [self viewMoreInfo];
            break;
            
        case 1:
            
            [self removeDiaryEntry];
            break;

        default:
            break;
    }
    
    [diaryTableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void) viewMoreInfo {
    
    NSIndexPath *indexPath = [diaryTableView indexPathForSelectedRow];
    
    NSMutableArray *array = [diary.foodDiary objectForKey:[diary.occasionArray objectAtIndex:indexPath.section]];
    
    AddFoodToDiaryViewController *addToDiaryVC = [AddFoodToDiaryViewController alloc];
    
    PFObject *object = [array objectAtIndex:indexPath.row];
    
    addToDiaryVC.foodPFObject = object;
    
    addToDiaryVC.diaryDate = diary.diaryDate;
    
    AddToFoodForm *add = [[AddToFoodForm alloc] init];
    
    add.foodAlreadyAdded = YES;
    
    add.servingSize = [object[@"servingSize"] floatValue];

    addToDiaryVC.formController.form = add;
    
    [self.navigationController pushViewController:[addToDiaryVC init] animated:YES];
}

- (void) removeDiaryEntry {
    
    // doesnt even get correct thing
    
    NSIndexPath *indexPath = [diaryTableView indexPathForSelectedRow];
    
    NSMutableArray *array = [diary.foodDiary objectForKey:[diary.occasionArray objectAtIndex:indexPath.section]];
    
    PFObject *diaryEntry = [array objectAtIndex:indexPath.row];
    
    [diary removeEntry:diaryEntry :[diary.occasionArray objectAtIndex:indexPath.section]];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                            @"View Info",
                            @"Remove",
                            nil];
    
    [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
}

- (void) tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
       toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    [tableView deselectRowAtIndexPath:sourceIndexPath animated:YES];
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *array = [diary.foodDiary objectForKey:[diary.occasionArray objectAtIndex:indexPath.section]];
    
    FoodObject *foodObject = [[FoodObject alloc] init];
    
    [foodObject convertPFObjectToFoodObject:[array objectAtIndex:indexPath.row]];
    
    
    DiaryTableViewCell *cell = [[DiaryTableViewCell alloc] initWithFrame:CGRectZero];
    
    cell.foodObject = foodObject;
    
    cell.ocassion = [diary.occasionArray objectAtIndex:indexPath.section];
    
    [cell layoutViews];
    
    return cell;
}

- (void) addDateView {
    
    dateView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40.0f)];
    
    dateView.backgroundColor = TRACK_COLOUR;
    
    [self.view addSubview:dateView];
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:dateView.frame];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    label.font = [UIFont fontWithName:@"Lekton04" size:18.0];
    
    label.text = diary.diaryDate;
    
    label.textColor = [UIColor lightGrayColor];
    
    [dateView addSubview:label];
}

- (void) returnToMenu {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

@end
