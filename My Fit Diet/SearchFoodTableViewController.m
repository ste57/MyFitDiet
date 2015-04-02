//
//  SearchFoodTableViewController.m
//  My Fit Diet
//
//  Created by Stephen Sowole on 01/04/2015.
//  Copyright (c) 2015 Stephen Sowole. All rights reserved.
//

#import "SearchFoodTableViewController.h"
#import "FoodResultsTableViewController.h"
#import "FoodObject.h"
#import "CreateFoodViewController.h"


@interface SearchFoodTableViewController ()

@end

@implementation SearchFoodTableViewController {
    
    UISearchController *searchController;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self removeBackButtonText];
    
    self.title = @"FOOD SEARCH";
    
    [self createSearchView];
}

- (void) removeBackButtonText {
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backButtonItem];
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)theSearchBar {
    
    if (searchController.searchBar.text.length) {
        
        //[self updateSearchHistory:searchController.searchBar.text];
        
        //  [[NSNotificationCenter defaultCenter] postNotificationName:NS_SEARCH_STRING object:searchController.searchBar.text];
        
        //[self dismissViewControllerAnimated:YES completion:nil];
        
        //[self returnToPreviousView];
    }
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) createSearchView {
    
    FoodResultsTableViewController *foodResultsTVC = [[FoodResultsTableViewController alloc] init];
    searchController = [[UISearchController alloc] initWithSearchResultsController:foodResultsTVC];
    searchController.searchResultsUpdater = self;
    [searchController.searchBar sizeToFit];
    
    foodResultsTVC.tableView.delegate = foodResultsTVC;
    searchController.dimsBackgroundDuringPresentation = NO;
    searchController.searchBar.delegate = self;
    
    self.tableView.tableHeaderView = searchController.searchBar;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(createNewFood)];
    
    self.definesPresentationContext = YES;
}

- (void) createNewFood {
    
    //FXFormViewController *createFoodVC = [[FXFormViewController alloc] init];
    
    //createFoodVC.formController.form = [[FoodObject alloc] init];
    
    CreateFoodViewController *createFoodVC = [[CreateFoodViewController alloc] init];
    
    createFoodVC.formController.form = [[FoodObject alloc] init];
    
    [self.navigationController pushViewController:createFoodVC animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    return 10;//searchResults.count;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithFrame:CGRectZero];
    
    return cell;
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchResultsController {
    
    //FoodResultsTableViewController *foodResultsTVC = (FoodResultsTableViewController*) searchResultsController.searchResultsController;
    
    //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF beginswith %@", searchResultsController.searchBar.text];
    
    //resultsTableViewController.searchResults = [searchResults filteredArrayUsingPredicate:predicate];
    
    //[resultsTableViewController.tableView reloadData];
}

- (void) tableView:(UITableView *)table didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //  [[NSNotificationCenter defaultCenter] postNotificationName:NS_SEARCH_STRING object:[searchResults objectAtIndex:indexPath.row]];
    
   // [self updateSearchHistory:[searchResults objectAtIndex:indexPath.row]];
    
   // [self returnToPreviousView];
}

- (void) updateSearchHistory:(NSString*)string {
    
   // [searchResults removeObject:string];
    
   // [searchResults insertObject:string atIndex:0];
    
    // [[NSUserDefaults standardUserDefaults] setObject:searchResults forKey:NS_SEARCH_HISTORY];
    
    //[[NSUserDefaults standardUserDefaults] synchronize];
}

@end
