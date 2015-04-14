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
    
    // Options header/label
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 50.0)];
    
    label.center = CGPointMake(self.frame.size.width/2, self.frame.size.height * 0.14);
    
    label.textAlignment = NSTextAlignmentCenter;
    
    label.text = @"OPTIONS";
    
    label.textColor = [UIColor whiteColor];
    
    label.font = [UIFont fontWithName:MAIN_FONT size:20.0];
    
    [self addSubview:label];
}

- (void) createButtons {
    
    [self createProfileButton];
    
    [self createPlanMealButton];
    
    [self createDiaryButton];
}

- (void) baseButton:(float)xPosition :(NSString*)buttonImg :(SEL)selector :(NSString*)setLabel :(UIColor*)color {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.frame = CGRectMake(0, 0, OPTIONS_BUTTON_WIDTH*2, OPTIONS_BUTTON_WIDTH*2);
    
    button.center = CGPointMake(xPosition, OPTIONS_BUTTON_HEIGHT);
    
    [button setImage:[UIImage imageNamed:buttonImg] forState:UIControlStateNormal];
    
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    
    [self createButtonLabel:button :setLabel :color];
    
    [self addSubview:button];
}

- (void) createButtonLabel:(UIButton*)button :(NSString*)setLabel :(UIColor*)color {
    
    UILabel *label;
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100.0, 50.0)];
    
    label.center = CGPointMake(button.frame.size.width/2, button.frame.size.height);
    
    label.textAlignment = NSTextAlignmentCenter;
    
    label.text = setLabel;
    
    label.textColor = color;
    
    label.font = [UIFont fontWithName:@"Lekton04" size:14.0];
    
    [button addSubview:label];
}

- (void) createProfileButton {
    
    [self baseButton:(self.frame.size.width/OPTIONS_BUTTONS_SEPERATION_VALUE) :@"ProfileButtonImg" :@selector(accessProfile) :@"PROFILE"
                    :S_FATS_COLOUR];
}

- (void) createPlanMealButton {
    
    [self baseButton:(self.frame.size.width/2) :@"PlanMealImg" :@selector(planMeal) :@"PLAN MEAL" :EXCEEDED_LIMIT_COLOUR];
}

- (void) createDiaryButton {
    
    [self baseButton:((self.frame.size.width/OPTIONS_BUTTONS_SEPERATION_VALUE)*
                      (OPTIONS_BUTTONS_SEPERATION_VALUE-1)) :@"DiaryImg" :@selector(accessDiary) :@"DIARY"
                    :[UIColor colorWithRed:158.0/255.0 green:192.0/255.0 blue:70.0/255.0 alpha:1.0]];
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
