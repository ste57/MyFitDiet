//
//  FoodResultsTableViewController.m
//  My Fit Diet
//
//  Created by Stephen Sowole on 01/04/2015.
//  Copyright (c) 2015 Stephen Sowole. All rights reserved.
//

#import "FoodResultsTableViewController.h"
#import <Parse/Parse.h>

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
    
    cell.textLabel.text = [NSString stringWithFormat:@"Food: %@     Calories: %@", object[@"Name"], object[@"Calories"]];
    
    return cell;
}

@end
