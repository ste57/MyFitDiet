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
    
    [self createProfileButton];
    
    [self createPlanMealButton];
    
    [self createDiaryButton];
}

- (void) baseButton:(float)xPosition :(NSString*)buttonImg :(SEL)selector {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    button.frame = CGRectMake(0, 0, OPTIONS_BUTTON_WIDTH*2, OPTIONS_BUTTON_WIDTH*2);
    
    button.center = CGPointMake(xPosition, OPTIONS_BUTTON_HEIGHT);
    
    [button setImage:[UIImage imageNamed:buttonImg] forState:UIControlStateNormal];
    
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:button];
}

- (void) createProfileButton {
    
    [self baseButton:(self.frame.size.width/OPTIONS_BUTTONS_SEPERATION_VALUE) :@"ProfileImg" :@selector(accessProfile)];
}


- (void) createPlanMealButton {
    
    [self baseButton:(self.frame.size.width/2) :@"ProfileImg" :@selector(planMeal)];
}

- (void) createDiaryButton {
    
    [self baseButton:((self.frame.size.width/OPTIONS_BUTTONS_SEPERATION_VALUE)*
                      (OPTIONS_BUTTONS_SEPERATION_VALUE-1)) :@"ProfileImg" :@selector(accessDiary)];
}

- (void) accessDiary {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:DIARY_BUTTON_NOTIFICATION object:nil];
}

- (void) planMeal {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:PLAN_MEAL_BUTTON_NOTIFICATION object:nil];
}

- (void) accessProfile {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:PROFILE_BUTTON_NOTIFICATION object:nil];
}

@end
