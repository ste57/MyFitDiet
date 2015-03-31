//
//  MenuStatsCollectionViewCell.m
//  My Fit Diet
//
//  Created by Stephen Sowole on 31/03/2015.
//  Copyright (c) 2015 Stephen Sowole. All rights reserved.
//

#import "MenuStatsCollectionViewCell.h"

@implementation MenuStatsCollectionViewCell

- (void) createLayout {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200.0, 200.0)];
    view.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    view.backgroundColor = [UIColor blueColor];
    [self addSubview:view];
}

@end
