//
//  DiaryTableViewCell.m
//  My Fit Diet
//
//  Created by Stephen Sowole on 01/04/2015.
//  Copyright (c) 2015 Stephen Sowole. All rights reserved.
//

#import "DiaryTableViewCell.h"
#import "Constants.h"

@implementation DiaryTableViewCell

@synthesize foodObject, ocassion;

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
    label.font = [UIFont fontWithName:@"lekton04" size:18.0f];
    [self.contentView addSubview:label];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(15, 40,
                                                      [[UIScreen mainScreen] applicationFrame].size.width - 30 - (2 * CELL_PADDING)
                                                      , 60)];
    label.text = [ocassion uppercaseString];
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont fontWithName:@"Primer" size:15.0f];
    [self.contentView addSubview:label];
    
    if ([ocassion isEqualToString:BREAKFAST]) {
        
        label.textColor = [UIColor colorWithRed:88/255.0f green:156/255.0f blue:28/255.0f alpha:1.0f];
        self.backgroundColor = [UIColor colorWithRed:0.80 green:0.93 blue:0.80 alpha:1.0];
        
    } else if ([ocassion isEqualToString:LUNCH]) {
        
        label.textColor = [UIColor colorWithRed:0.77 green:0.58 blue:0.18 alpha:1.0];
        self.backgroundColor = [UIColor colorWithRed:0.96 green:0.93 blue:0.85 alpha:1.0];
        
    } else if ([ocassion isEqualToString:DINNER]) {
        
        label.textColor = [UIColor colorWithRed:0.27 green:0.29 blue:0.65 alpha:1.0];
        self.backgroundColor = [UIColor colorWithRed:0.85 green:0.92 blue:0.96 alpha:1.0];

    } else if ([ocassion isEqualToString:SNACK]) {
        
        label.textColor = [UIColor colorWithRed:0.91 green:0.31 blue:0.45 alpha:1.0];
        self.backgroundColor = [UIColor colorWithRed:0.96 green:0.86 blue:0.86 alpha:1.0];
    }
    
    
    UIView *kcalView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 72, 22)];
    
    kcalView.layer.cornerRadius = 10;
    
    kcalView.center = CGPointMake([[UIScreen mainScreen] applicationFrame].size.width - 52 - (2 * CELL_PADDING), label.center.y);
                                
    kcalView.backgroundColor = [UIColor whiteColor];
    
    kcalView.layer.borderWidth = 1.0f;
    
    kcalView.layer.borderColor = [label.textColor CGColor];
    
    [self.contentView addSubview:kcalView];
    
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(3, 0, kcalView.frame.size.width - 6, kcalView.frame.size.height)];
    
    label.text = [NSString stringWithFormat:@"%i KCAL", (int)foodObject.servingSize * foodObject.calories];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithRed:0.40 green:0.05 blue:0.05 alpha:1.0];
    label.adjustsFontSizeToFitWidth = YES;
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size:11.0f];
    
    [kcalView addSubview:label];
}

@end
