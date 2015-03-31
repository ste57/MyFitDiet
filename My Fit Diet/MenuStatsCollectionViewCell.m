//
//  MenuStatsCollectionViewCell.m
//  My Fit Diet
//
//  Created by Stephen Sowole on 31/03/2015.
//  Copyright (c) 2015 Stephen Sowole. All rights reserved.
//

#import "MenuStatsCollectionViewCell.h"
#import "Constants.h"

@implementation MenuStatsCollectionViewCell

- (void) createLayout {
    
    self.backgroundColor = MAIN_BACKGROUND_COLOUR;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200.0, 200.0)];
    view.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    view.backgroundColor = [UIColor whiteColor];
    [self addSubview:view];
}

@end
