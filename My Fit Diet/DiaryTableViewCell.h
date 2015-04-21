//
//  DiaryTableViewCell.h
//  My Fit Diet
//
//  Created by Stephen Sowole on 01/04/2015.
//  Copyright (c) 2015 Stephen Sowole. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodObject.h"

@interface DiaryTableViewCell : UITableViewCell

@property (nonatomic, strong) FoodObject *foodObject;
@property (nonatomic, strong) NSString *ocassion;

- (void) layoutViews;

@end
