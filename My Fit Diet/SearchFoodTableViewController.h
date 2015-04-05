//
//  SearchFoodTableViewController.h
//  My Fit Diet
//
//  Created by Stephen Sowole on 01/04/2015.
//  Copyright (c) 2015 Stephen Sowole. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchFoodTableViewController : UITableViewController <UISearchResultsUpdating, UISearchBarDelegate>

@property (strong, nonatomic) NSString *diaryDate;

@end
