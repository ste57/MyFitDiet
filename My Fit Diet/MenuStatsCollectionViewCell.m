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
    
    float xVal, separationValue;
}

- (void) createLayout {
    
    [[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
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
    
    KAProgressLabel *progressLabel = [[KAProgressLabel alloc] initWithFrame:CGRectMake(0, 0, KCAL_BAR_RADIUS, KCAL_BAR_RADIUS)];
    
    progressLabel.trackColor = TRACK_COLOUR;
    
    progressLabel.progressColor = KCAL_BAR_COLOUR;
    
    progressLabel.trackWidth = KCAL_TRACK_WIDTH;
    
    progressLabel.progressWidth = KCAL_TRACK_WIDTH;
    
    progressLabel.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/3.5);
    
    [self addSubview:progressLabel];
    
    [self animateBar:progressLabel];
}

- (void) createCarbsProgressLabel {
    
    KAProgressLabel *progressLabel = [[KAProgressLabel alloc] initWithFrame:CGRectMake(0, 0, FOOD_NUTRIENTS_PROGRESS_BAR_RADIUS, FOOD_NUTRIENTS_PROGRESS_BAR_RADIUS)];
    
    progressLabel.trackColor = TRACK_COLOUR;
    
    progressLabel.progressColor = CARBS_COLOUR;
    
    progressLabel.trackWidth = FOOD_NUTRIENTS_TRACK_WIDTH;
    
    progressLabel.progressWidth = FOOD_NUTRIENTS_TRACK_WIDTH;
    
    progressLabel.center = CGPointMake(xVal, self.frame.size.height/FOOD_NUTRIENTS_HEIGHT_DIVIDE);
    
    [self addSubview:progressLabel];
    
    [self animateBar:progressLabel];
}

- (void) createSaturatedFatsProgressLabel {
    
    KAProgressLabel *progressLabel = [[KAProgressLabel alloc] initWithFrame:CGRectMake(0, 0, FOOD_NUTRIENTS_PROGRESS_BAR_RADIUS, FOOD_NUTRIENTS_PROGRESS_BAR_RADIUS)];
    
    progressLabel.trackColor = TRACK_COLOUR;
    
    progressLabel.progressColor = S_FATS_COLOUR;
    
    progressLabel.trackWidth = FOOD_NUTRIENTS_TRACK_WIDTH;
    
    progressLabel.progressWidth = FOOD_NUTRIENTS_TRACK_WIDTH;
    
    progressLabel.center = CGPointMake(xVal, self.frame.size.height/FOOD_NUTRIENTS_HEIGHT_DIVIDE);
    
    [self addSubview:progressLabel];
    
    [self animateBar:progressLabel];
}

- (void) createFatsProgressLabel {
    
    KAProgressLabel *progressLabel = [[KAProgressLabel alloc] initWithFrame:CGRectMake(0, 0, FOOD_NUTRIENTS_PROGRESS_BAR_RADIUS, FOOD_NUTRIENTS_PROGRESS_BAR_RADIUS)];
    
    progressLabel.trackColor = TRACK_COLOUR;
    
    progressLabel.progressColor = FATS_COLOUR;
    
    progressLabel.trackWidth = FOOD_NUTRIENTS_TRACK_WIDTH;
    
    progressLabel.progressWidth = FOOD_NUTRIENTS_TRACK_WIDTH;
    
    progressLabel.center = CGPointMake(xVal, self.frame.size.height/FOOD_NUTRIENTS_HEIGHT_DIVIDE);
    
    [self addSubview:progressLabel];
    
    [self animateBar:progressLabel];
}

- (void) createProteinProgressLabel {
    
    KAProgressLabel *progressLabel = [[KAProgressLabel alloc] initWithFrame:CGRectMake(0, 0, FOOD_NUTRIENTS_PROGRESS_BAR_RADIUS, FOOD_NUTRIENTS_PROGRESS_BAR_RADIUS)];
    
    progressLabel.trackColor = TRACK_COLOUR;
    
    progressLabel.progressColor = PROTEIN_COLOUR;
    
    progressLabel.trackWidth = FOOD_NUTRIENTS_TRACK_WIDTH;
    
    progressLabel.progressWidth = FOOD_NUTRIENTS_TRACK_WIDTH;
    
    progressLabel.center = CGPointMake(xVal, self.frame.size.height/FOOD_NUTRIENTS_HEIGHT_DIVIDE);
    
    [self addSubview:progressLabel];
    
    [self animateBar:progressLabel];
}

- (void) animateBar:(KAProgressLabel*)label {
    
    label.progress = 0;
    
    [label setProgress:0.8 timing:TPPropertyAnimationTimingEaseOut duration:0.8 delay:0.5];
}

@end
