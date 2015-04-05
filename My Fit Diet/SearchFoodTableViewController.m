//
//  SearchFoodTableViewController.m
//  My Fit Diet
//
//  Created by Stephen Sowole on 01/04/2015.
//  Copyright (c) 2015 Stephen Sowole. All rights reserved.
//

#import "SearchFoodTableViewController.h"
#import "FoodResultsTableViewController.h"
#import "CreateFoodViewController.h"
#import "FoodObject.h"
#import "AddFoodToDiaryViewController.h"
#import "Constants.h"
#import "AddToFoodForm.h"

@interface SearchFoodTableViewController ()

@end

@implementation SearchFoodTableViewController {
    
    UISearchController *searchController;
    NSArray *foodArray;
}

- (void) viewDidLoad {
    
    [super viewDidLoad];
    
    foodArray = [[NSArray alloc] init];
    
    [self retrieveFoodObjects];
    
    [self removeBackButtonText];
    
    self.title = @"FOOD SEARCH";
    
    [self createSearchView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(displayFoodDetailsNS:) name:DISPLAY_FOOD_DETAILS object:nil];
}

- (void) viewDidAppear:(BOOL)animated {
    
    [self retrieveFoodObjects];
}

- (void) retrieveFoodObjects {
    
    PFQuery *query = [PFQuery queryWithClassName:@"Food"];
    
    [[query fromLocalDatastore] ignoreACLs];
    
    [query orderByDescending:@"updatedAt"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (!error) {
            
            foodArray = objects;
            
            [self.tableView reloadData];
        }
    }];
}

- (void) removeBackButtonText {
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backButtonItem];
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
    
    CreateFoodViewController *createFoodVC = [[CreateFoodViewController alloc] init];
    
    createFoodVC.formController.form = [[FoodObject alloc] init];
    
    [self.navigationController pushViewController:createFoodVC animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return foodArray.count;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithFrame:CGRectZero];
    
    PFObject *object = [foodArray objectAtIndex:(indexPath.row)];
    
    cell.textLabel.text = [NSString stringWithFormat:@"Food: %@     Calories: %@", object[@"name"], object[@"calories"]];
  
    return cell;
}

- (void) updateSearchResultsForSearchController:(UISearchController *)searchResultsController {

    FoodResultsTableViewController *foodResultsTVC = (FoodResultsTableViewController*) searchResultsController.searchResultsController;

    PFQuery *query = [PFQuery queryWithClassName:@"Food"];
    
    [[query fromLocalDatastore] ignoreACLs];
    
    [query setLimit:100];
    
    [query whereKey:@"searchName" containsString:[searchResultsController.searchBar.text uppercaseString]];

    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
    
        if (!error) {
         
            foodResultsTVC.searchResults = objects;
            
            [foodResultsTVC.tableView reloadData];
        }
    }];
}

- (void) tableView:(UITableView *)table didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [self displayFoodDetails:[foodArray objectAtIndex:(indexPath.row)]];
}

- (void) displayFoodDetailsNS:(NSNotification*) notification {
    
    [self displayFoodDetails:[notification object]];
}

- (void) displayFoodDetails:(PFObject*)object {
    
    AddFoodToDiaryViewController *addToDiaryVC = [AddFoodToDiaryViewController alloc];
    
    addToDiaryVC.foodPFObject = object;
    
    addToDiaryVC.diaryDate = self.diaryDate;
    
    addToDiaryVC.formController.form = [AddToFoodForm alloc];
    
    [self.navigationController pushViewController:[addToDiaryVC init] animated:YES];
}

@end
