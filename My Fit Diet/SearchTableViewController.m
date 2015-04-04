//
//  SearchTableViewController.m
//  StephenSowoleUberChallenge
//
//  Created by Stephen Sowole on 26/03/2015.
//  Copyright (c) 2015 Stephen Sowole. All rights reserved.
//

#import "SearchTableViewController.h"
#import "ResultsTableViewController.h"
#import "Constants.h"

@interface SearchTableViewController ()

@end

@implementation SearchTableViewController {
    
    UISearchController *searchController;
    NSMutableArray *searchResults;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self retrieveSearchHistory];
    
    [self createSearchView];
    
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(returnToPreviousViewAndUpdateSearchHistory:) name:NS_DISMISS_SEARCH_VIEW object:nil];
}

- (void) retrieveSearchHistory {
    
    //searchResults = [[NSMutableArray alloc] initWithArray:(NSArray *)[[NSUserDefaults standardUserDefaults] objectForKey:NS_SEARCH_HISTORY]];
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)theSearchBar {
    
    if (searchController.searchBar.text.length) {
        
        [self updateSearchHistory:searchController.searchBar.text];
        
      //  [[NSNotificationCenter defaultCenter] postNotificationName:NS_SEARCH_STRING object:searchController.searchBar.text];
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
        [self returnToPreviousView];
    }
}

- (void) createSearchView {
    
    ResultsTableViewController *resultsTableViewController = [[ResultsTableViewController alloc] init];
    searchController = [[UISearchController alloc] initWithSearchResultsController:resultsTableViewController];
    searchController.searchResultsUpdater = self;
    [searchController.searchBar sizeToFit];
    
    resultsTableViewController.tableView.delegate = resultsTableViewController;
    searchController.dimsBackgroundDuringPresentation = NO;
    searchController.searchBar.delegate = self;
    
    self.tableView.tableHeaderView = searchController.searchBar;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(returnToPreviousView)];
    
    self.definesPresentationContext = YES;
}

- (void) returnToPreviousView {
    
    [searchController.searchBar resignFirstResponder];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) returnToPreviousViewAndUpdateSearchHistory:(NSNotification*)notification {
    
    [self updateSearchHistory:[notification object]];
    
    [self returnToPreviousView];
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

- (void) updateSearchResultsForSearchController:(UISearchController *)searchResultsController {

    ResultsTableViewController *resultsTableViewController = (ResultsTableViewController*) searchResultsController.searchResultsController;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF beginswith %@", searchResultsController.searchBar.text];
    
    resultsTableViewController.searchResults = [searchResults filteredArrayUsingPredicate:predicate];
    
    [resultsTableViewController.tableView reloadData];
}

- (void) tableView:(UITableView *)table didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
  //  [[NSNotificationCenter defaultCenter] postNotificationName:NS_SEARCH_STRING object:[searchResults objectAtIndex:indexPath.row]];
    
    [self updateSearchHistory:[searchResults objectAtIndex:indexPath.row]];
    
    [self returnToPreviousView];
}

- (void) updateSearchHistory:(NSString*)string {
    
    [searchResults removeObject:string];
    
    [searchResults insertObject:string atIndex:0];
    
   // [[NSUserDefaults standardUserDefaults] setObject:searchResults forKey:NS_SEARCH_HISTORY];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
