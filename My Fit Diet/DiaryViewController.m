//
//  DiaryViewController.m
//  My Fit Diet
//
//  Created by Stephen Sowole on 01/04/2015.
//  Copyright (c) 2015 Stephen Sowole. All rights reserved.
//

#import "DiaryViewController.h"
#import "Constants.h"
#import "DiaryTableViewController.h"

@interface DiaryViewController ()

@end

@implementation DiaryViewController

@synthesize diaryDate;

- (void) viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = MAIN_BACKGROUND_COLOUR;
    
    self.title = @"DIARY";
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(returnToMenu)];
    
    self.navigationItem.leftBarButtonItem = doneButton;
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(returnToMenu)];
    
    self.navigationItem.rightBarButtonItem = addButton;
    
    [self addDateView];
    
    [self createTableView];
}

- (void) createTableView {
    
    DiaryTableViewController *tableView = [[DiaryTableViewController alloc] initWithStyle:UITableViewStylePlain];
    
    [self addChildViewController:tableView];
}

- (void) addDateView {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40.0f)];
    
    view.backgroundColor = TRACK_COLOUR;
    
    [self.view addSubview:view];
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:view.frame];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    label.text = self.diaryDate;
    
    label.textColor = [UIColor lightGrayColor];
    
    [view addSubview:label];
}

- (void) returnToMenu {

    [self.navigationController popViewControllerAnimated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
