//
//  PlanMealTableViewCell.h
//  My Fit Diet
//
//  Created by Stephen Sowole on 21/04/2015.
//  Copyright (c) 2015 Stephen Sowole. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodObject.h"

@interface PlanMealTableViewCell : UITableViewCell

@property (nonatomic, strong) FoodObject *foodObject;
@property int row;

- (void) layoutViews;

@end
