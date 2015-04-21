//
//  PlanMealTableViewCell.m
//  My Fit Diet
//
//  Created by Stephen Sowole on 21/04/2015.
//  Copyright (c) 2015 Stephen Sowole. All rights reserved.
//

#import "PlanMealTableViewCell.h"
#import "Constants.h"

@implementation PlanMealTableViewCell

@synthesize foodObject, row;

- (void) awakeFromNib {
    // Initialization code
}

- (void) setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
}

- (void) setFrame:(CGRect)frame {
    
    frame.origin.x += CELL_PADDING;
    
    frame.size.width -= 2 * CELL_PADDING;
    
    frame.origin.y += CELL_PADDING;
    
    frame.size.height -= CELL_PADDING;
    
    [super setFrame:frame];
}

- (void) layoutViews {
    
    UILabel *label;
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0,
                                                      [[UIScreen mainScreen] applicationFrame].size.width - 30 - (2 * CELL_PADDING)
                                                      , 60)];
    label.text = foodObject.name;
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"lekton04" size:15.0f];
    [self.contentView addSubview:label];
    
    [self setRandomBackgroundColor];
    
    UIView *kcalView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 25)];
    
    kcalView.layer.cornerRadius = 10;
    
    kcalView.center = CGPointMake(([[UIScreen mainScreen] applicationFrame].size.width - (2 * CELL_PADDING))/2, 64);
    
    kcalView.backgroundColor = [UIColor whiteColor];
    
    kcalView.layer.borderWidth = 2.0f;
    
    kcalView.layer.borderColor = [[UIColor colorWithRed:0.72 green:0.65 blue:0.76 alpha:1.0] CGColor];
    
    [self.contentView addSubview:kcalView];
    
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(3, 0, kcalView.frame.size.width - 6, kcalView.frame.size.height)];
    
    label.text = [NSString stringWithFormat:@"%i KCAL", (int)foodObject.servingSize * foodObject.calories];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithRed:0.40 green:0.05 blue:0.05 alpha:1.0];
    label.adjustsFontSizeToFitWidth = YES;
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size:13.0f];
    
    [kcalView addSubview:label];
}

- (void) setRandomBackgroundColor {
    
    row = row % 4;
    
    if (row == 0) {
        
        self.backgroundColor = [UIColor colorWithRed:0.80 green:0.93 blue:0.80 alpha:1.0];
        
    } else if (row == 1) {
        
        self.backgroundColor = [UIColor colorWithRed:0.96 green:0.93 blue:0.85 alpha:1.0];
        
    } else if (row == 2) {
        
        self.backgroundColor = [UIColor colorWithRed:0.85 green:0.92 blue:0.96 alpha:1.0];
        
    } else if (row == 3) {
        
        self.backgroundColor = [UIColor colorWithRed:0.96 green:0.86 blue:0.86 alpha:1.0];
    }
}

@end
