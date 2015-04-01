//
//  OptionsView.m
//  My Fit Diet
//
//  Created by Stephen Sowole on 01/04/2015.
//  Copyright (c) 2015 Stephen Sowole. All rights reserved.
//

#import "OptionsView.h"
#import "Constants.h"

@implementation OptionsView

- (id) initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createOptionsView];
        
        [self createButtons];
    }
    
    return self;
}

- (void) createOptionsView {
    
    self.backgroundColor = MAIN_BACKGROUND_COLOUR;
    
    self.layer.anchorPoint = CGPointMake(0.5, 1.0);
    
    self.layer.borderColor = [[UIColor colorWithRed:70.0f/255.0f green:74.0f/255.0f blue:80.0f/255.0f alpha:1.0] CGColor];
    
    self.layer.borderWidth = 1.0f;
}

- (void) createButtons {
    
    
}

@end
