//
//  PlanMealViewController.h
//  My Fit Diet
//
//  Created by Stephen Sowole on 21/04/2015.
//  Copyright (c) 2015 Stephen Sowole. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiaryObject.h"

@interface PlanMealViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) DiaryObject *diary;

@end
