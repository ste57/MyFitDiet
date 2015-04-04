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
}

- (void) removeBackButtonText {
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backButtonItem];
}

- (void) toggleFoodSearch {
    
    [self.navigationController pushViewController:[SearchFoodTableViewController alloc] animated:YES];
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

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
    return 2;//0;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void) tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    [tableView deselectRowAtIndexPath:sourceIndexPath animated:YES];
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DiaryTableViewCell *cell = [[DiaryTableViewCell alloc] initWithFrame:CGRectZero];
    
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

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
