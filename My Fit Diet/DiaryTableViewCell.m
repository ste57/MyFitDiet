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

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setFrame:(CGRect)frame {
    
    frame.origin.x += CELL_PADDING;
    
    frame.size.width -= 2 * CELL_PADDING;
    
    frame.origin.y += CELL_PADDING;
    
    frame.size.height -= CELL_PADDING;
    
    [super setFrame:frame];
}

@end
