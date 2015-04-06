//
//  MenuStatsCollectionViewCell.h
//  My Fit Diet
//
//  Created by Stephen Sowole on 31/03/2015.
//  Copyright (c) 2015 Stephen Sowole. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiaryObject.h"


@interface MenuStatsCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) DiaryObject *diary;

- (void) createLayout;

@end
