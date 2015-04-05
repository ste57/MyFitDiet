//
//  MenuStatsCollectionViewCell.m
//  My Fit Diet
//
//  Created by Stephen Sowole on 31/03/2015.
//  Copyright (c) 2015 Stephen Sowole. All rights reserved.
//

#import "MenuStatsCollectionViewCell.h"
#import "Constants.h"
#import "KAProgressLabel.h"

@implementation MenuStatsCollectionViewCell {
    
    UserObject *user;
    float xVal, separationValue;
    KAProgressLabel *kCalProgressLabel, *carbsProgressLabel, *sFatsProgressLabel, *fatsProgressLabel, *proteinProgressLabel;
}

- (void) createLayout {
    
    [[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    user = [[UserObject alloc] init];
    
    self.backgroundColor = MAIN_BACKGROUND_COLOUR;
    
    separationValue = FOOD_NUTRIENTS_PROGRESS_BAR_RADIUS * 4;
    separationValue = self.frame.size.width - separationValue;
    separationValue /= 5;
    
    xVal = separationValue;
    xVal += (FOOD_NUTRIENTS_PROGRESS_BAR_RADIUS/2);
    
    [self createKcalProgressLabel];
    
    [self createCarbsProgressLabel];
    
    xVal += (FOOD_NUTRIENTS_PROGRESS_BAR_RADIUS + separationValue);
    
    [self createSaturatedFatsProgressLabel];
    
    xVal += (FOOD_NUTRIENTS_PROGRESS_BAR_RADIUS + separationValue);
    
    [self createFatsProgressLabel];
    
    xVal += (FOOD_NUTRIENTS_PROGRESS_BAR_RADIUS + separationValue);
    
    [self createProteinProgressLabel];
}

- (void) createKcalProgressLabel {
    
    kCalProgressLabel = [[KAProgressLabel alloc] initWithFrame:CGRectMake(0, 0, KCAL_BAR_RADIUS, KCAL_BAR_RADIUS)];
    
    kCalProgressLabel.trackColor = TRACK_COLOUR;
    
    kCalProgressLabel.progressColor = KCAL_BAR_COLOUR;
    
    kCalProgressLabel.trackWidth = KCAL_TRACK_WIDTH;
    
    kCalProgressLabel.progressWidth = KCAL_TRACK_WIDTH;
    
    kCalProgressLabel.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/3.5);
    
    [self addSubview:kCalProgressLabel];
    
    [self animateBar:kCalProgressLabel withProgress:(float)(user.currentCalories/user.userCalories)];
    
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, KCAL_BAR_RADIUS, KCAL_BAR_RADIUS)];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    label.textColor = [UIColor lightGrayColor];
    
    //label.text = @"500";
    
    label.font = [UIFont fontWithName:@"Primer" size:50.0];
    
    [kCalProgressLabel addSubview:label];
}

- (void) createCarbsProgressLabel {
    
    carbsProgressLabel = [[KAProgressLabel alloc] initWithFrame:CGRectMake(0, 0, FOOD_NUTRIENTS_PROGRESS_BAR_RADIUS, FOOD_NUTRIENTS_PROGRESS_BAR_RADIUS)];
    
    carbsProgressLabel.trackColor = TRACK_COLOUR;
    
    carbsProgressLabel.progressColor = CARBS_COLOUR;
    
    carbsProgressLabel.trackWidth = FOOD_NUTRIENTS_TRACK_WIDTH;
    
    carbsProgressLabel.progressWidth = FOOD_NUTRIENTS_TRACK_WIDTH;
    
    carbsProgressLabel.center = CGPointMake(xVal, self.frame.size.height/FOOD_NUTRIENTS_HEIGHT_DIVIDE);
    
    [self addSubview:carbsProgressLabel];
    
    [self animateBar:carbsProgressLabel withProgress:(float)(user.currentTotalCarbohydrates/user.userTotalCarbohydrates)];
}

- (void) createSaturatedFatsProgressLabel {
    
    sFatsProgressLabel = [[KAProgressLabel alloc] initWithFrame:CGRectMake(0, 0, FOOD_NUTRIENTS_PROGRESS_BAR_RADIUS, FOOD_NUTRIENTS_PROGRESS_BAR_RADIUS)];
    
    sFatsProgressLabel.trackColor = TRACK_COLOUR;
    
    sFatsProgressLabel.progressColor = S_FATS_COLOUR;
    
    sFatsProgressLabel.trackWidth = FOOD_NUTRIENTS_TRACK_WIDTH;
    
    sFatsProgressLabel.progressWidth = FOOD_NUTRIENTS_TRACK_WIDTH;
    
    sFatsProgressLabel.center = CGPointMake(xVal, self.frame.size.height/FOOD_NUTRIENTS_HEIGHT_DIVIDE);
    
    [self addSubview:sFatsProgressLabel];
    
    [self animateBar:sFatsProgressLabel withProgress:(float)(user.currentSaturatedFats/user.userSaturatedFats)];
}

- (void) createFatsProgressLabel {
    
    fatsProgressLabel = [[KAProgressLabel alloc] initWithFrame:CGRectMake(0, 0, FOOD_NUTRIENTS_PROGRESS_BAR_RADIUS, FOOD_NUTRIENTS_PROGRESS_BAR_RADIUS)];
    
    fatsProgressLabel.trackColor = TRACK_COLOUR;
    
    fatsProgressLabel.progressColor = FATS_COLOUR;
    
    fatsProgressLabel.trackWidth = FOOD_NUTRIENTS_TRACK_WIDTH;
    
    fatsProgressLabel.progressWidth = FOOD_NUTRIENTS_TRACK_WIDTH;
    
    fatsProgressLabel.center = CGPointMake(xVal, self.frame.size.height/FOOD_NUTRIENTS_HEIGHT_DIVIDE);
    
    [self addSubview:fatsProgressLabel];
    
    [self animateBar:fatsProgressLabel withProgress:(float)(user.currentTotalFats/user.userTotalFats)];
}

- (void) createProteinProgressLabel {
    
    proteinProgressLabel = [[KAProgressLabel alloc] initWithFrame:CGRectMake(0, 0, FOOD_NUTRIENTS_PROGRESS_BAR_RADIUS, FOOD_NUTRIENTS_PROGRESS_BAR_RADIUS)];
    
    proteinProgressLabel.trackColor = TRACK_COLOUR;
    
    proteinProgressLabel.progressColor = PROTEIN_COLOUR;
    
    proteinProgressLabel.trackWidth = FOOD_NUTRIENTS_TRACK_WIDTH;
    
    proteinProgressLabel.progressWidth = FOOD_NUTRIENTS_TRACK_WIDTH;
    
    proteinProgressLabel.center = CGPointMake(xVal, self.frame.size.height/FOOD_NUTRIENTS_HEIGHT_DIVIDE);
    
    [self addSubview:proteinProgressLabel];
    
    [self animateBar:proteinProgressLabel withProgress:(float)(user.currentProtein/user.userProtein)];
}

- (void) animateBar:(KAProgressLabel*)label withProgress:(float)progress {

    label.progress = 0;

    [label setProgress:progress timing:TPPropertyAnimationTimingEaseOut duration:0.8 delay:0.8];
}

@end
