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

@interface DiaryViewController ()

@end

@implementation DiaryViewController {
    
    UITableView *diaryTableView;
    UIView *dateView;
}

static NSString * const reuseIdentifier = @"DiaryCell";

@synthesize diaryDate;

@synthesize diary;

- (void) viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = MAIN_BACKGROUND_COLOUR;
    
    self.title = @"DIARY";
    
    [self removeBackButtonText];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(returnToMenu)];
    
    self.navigationItem.leftBarButtonItem = doneButton;
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(toggleFoodSearch)];
    
    self.navigationItem.rightBarButtonItem = addButton;
    
    [self addDateView];
    
    [self createTableView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTableView) name:RELOAD_DIARY_TB object:nil];
}

- (void) reloadTableView {
    
    [diaryTableView reloadData];
}

- (void) removeBackButtonText {
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backButtonItem];
}

- (void) toggleFoodSearch {
    
    SearchFoodTableViewController *searchFoodTVC = [[SearchFoodTableViewController alloc] init];
    
    searchFoodTVC.diaryDate = self.diaryDate;
    
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
    
    return 100.0f;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return diary.foodDiary.count;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSArray *array = [diary.foodDiary objectForKey:[diary.occasionArray objectAtIndex:section]];
    
    return array.count;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void) tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    [tableView deselectRowAtIndexPath:sourceIndexPath animated:YES];
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *array = [diary.foodDiary objectForKey:[diary.occasionArray objectAtIndex:indexPath.section]];
    
    FoodObject *foodObject = [[FoodObject alloc] init];
                              
    [foodObject convertPFObjectToFoodObject:[array objectAtIndex:indexPath.row]];
    
    DiaryTableViewCell *cell = [[DiaryTableViewCell alloc] initWithFrame:CGRectZero];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@      %@", foodObject.name, [diary.occasionArray objectAtIndex:indexPath.section]];
    
    return cell;
}

- (void) addDateView {
    
    dateView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40.0f)];
    
    dateView.backgroundColor = TRACK_COLOUR;
    
    [self.view addSubview:dateView];
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:dateView.frame];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    label.text = self.diaryDate;
    
    label.textColor = [UIColor lightGrayColor];
    
    [dateView addSubview:label];
}

- (void) returnToMenu {

    [self.navigationController popViewControllerAnimated:YES];
}

- (void) didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
