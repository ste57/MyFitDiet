//
//  ResultsTableViewController.m
//  StephenSowoleUberChallenge
//
//  Created by Stephen Sowole on 26/03/2015.
//  Copyright (c) 2015 Stephen Sowole. All rights reserved.
//

#import "ResultsTableViewController.h"
#import "Constants.h"

@interface ResultsTableViewController ()

@end

@implementation ResultsTableViewController

@synthesize searchResults;

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return searchResults.count;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithFrame:CGRectZero];
    
    cell.textLabel.text = [searchResults objectAtIndex:indexPath.row];
    
    return cell;
}

- (void) tableView:(UITableView *)table didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //[[NSNotificationCenter defaultCenter] postNotificationName:NS_SEARCH_STRING object:[searchResults objectAtIndex:indexPath.row]];
    
    [self dismissViewControllerAnimated:NO completion:nil];
    
    //[[NSNotificationCenter defaultCenter] postNotificationName:NS_DISMISS_SEARCH_VIEW object:[searchResults objectAtIndex:indexPath.row]];
}

@end
