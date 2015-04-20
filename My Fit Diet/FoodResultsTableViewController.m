//
//  FoodResultsTableViewController.m
//  My Fit Diet
//
//  Created by Stephen Sowole on 01/04/2015.
//  Copyright (c) 2015 Stephen Sowole. All rights reserved.
//

#import "FoodResultsTableViewController.h"
#import <Parse/Parse.h>
#import "FoodObject.h"
#import "AddFoodToDiaryViewController.h"
#import "Constants.h"

@interface FoodResultsTableViewController ()

@end

@implementation FoodResultsTableViewController

@synthesize searchResults;

- (void) viewDidLoad {
    
    [super viewDidLoad];
}

- (void) didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return searchResults.count;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithFrame:CGRectZero];
    
    PFObject *object = [searchResults objectAtIndex:(indexPath.row)];
    
    cell.textLabel.text = object[@"name"];
    
    cell.textLabel.font = [UIFont fontWithName:MAIN_FONT size:23.0f];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:DISPLAY_FOOD_DETAILS object:[searchResults objectAtIndex:(indexPath.row)]];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
