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
#import "UserObject.h"

@implementation MenuStatsCollectionViewCell {
    
    UserObject *user;
    float xVal, separationValue;
    KAProgressLabel *kCalProgressLabel, *carbsProgressLabel, *sFatsProgressLabel, *fatsProgressLabel, *proteinProgressLabel;
}

@synthesize diary;

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
    
    float value = (float) (diary.currentCalories / user.userCalories);
    
    kCalProgressLabel = [[KAProgressLabel alloc] initWithFrame:CGRectMake(0, 0, KCAL_BAR_RADIUS, KCAL_BAR_RADIUS)];
    
    kCalProgressLabel.trackColor = TRACK_COLOUR;
    
    if (value <= 1.0) {
    
        kCalProgressLabel.progressColor = KCAL_BAR_COLOUR;
        
    } else {
        
        kCalProgressLabel.progressColor = EXCEEDED_LIMIT_COLOUR;
    }
    
    kCalProgressLabel.trackWidth = KCAL_TRACK_WIDTH;
    
    kCalProgressLabel.progressWidth = KCAL_TRACK_WIDTH;
    
    kCalProgressLabel.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/3.5);
    
    [self animateBar:kCalProgressLabel withProgress:value :diary.previousCalories];
    
    [self addKcalProgressLabels];
    
    diary.previousCalories = value;
}

- (void) addKcalProgressLabels {

    UILabel *label;
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, KCAL_BAR_RADIUS, KCAL_BAR_RADIUS)];
    
    label.center = CGPointMake(kCalProgressLabel.frame.size.width/2, kCalProgressLabel.frame.size.height/2.25);
    
    label.textAlignment = NSTextAlignmentCenter;
    
    label.textColor = kCalProgressLabel.progressColor;
    
    label.alpha = 0;
    
    label.text = [NSString stringWithFormat:@"%i", (int)(user.userCalories - diary.currentCalories)];
    
    label.font = [UIFont fontWithName:@"Lekton04" size:56.0];
    
    [kCalProgressLabel addSubview:label];

    [self animateLabel:label];
    
    
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, KCAL_BAR_RADIUS, KCAL_BAR_RADIUS)];
    
    label.center = CGPointMake(kCalProgressLabel.frame.size.width/2, kCalProgressLabel.frame.size.height/1.5);
    
    label.textAlignment = NSTextAlignmentCenter;
    
    label.textColor = kCalProgressLabel.progressColor;
    
    label.text = @"KCAL LEFT";
    
    label.font = [UIFont fontWithName:@"Primer" size:18.0];
    
    [kCalProgressLabel addSubview:label];
    
    [self animateLabel:label];
    
    
    [self addSubview:kCalProgressLabel];
}

- (void) createNutrientProgressLabels:(KAProgressLabel*)parentLabel :(float)value :(NSString*)setLabel {
    
    UILabel *label;
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, FOOD_NUTRIENTS_PROGRESS_BAR_RADIUS, FOOD_NUTRIENTS_PROGRESS_BAR_RADIUS)];
    
    label.center = CGPointMake(parentLabel.frame.size.width/1.9, parentLabel.frame.size.height/1.9);
    
    label.textColor = parentLabel.progressColor;
    
    label.text = [NSString stringWithFormat:@"%i%@", (int)(value*100), @"%"];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    label.font = [UIFont fontWithName:@"Lekton04" size:16.0];
    
    [parentLabel addSubview:label];
    
    [self animateLabel:label];
    
    
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, FOOD_NUTRIENTS_PROGRESS_BAR_RADIUS, FOOD_NUTRIENTS_PROGRESS_BAR_RADIUS)];
    
    label.center = CGPointMake(parentLabel.frame.size.width/2, (parentLabel.frame.size.height*1.38));
    
    label.textAlignment = NSTextAlignmentCenter;
    
    label.textColor = parentLabel.progressColor;
    
    label.text = setLabel;
    
    label.font = [UIFont fontWithName:@"Lekton04" size:14.0];
    
    [parentLabel addSubview:label];
    
    [self animateLabel:label];
    
    [self addSubview:parentLabel];
}

- (void) animateLabel:(UILabel*)label {
    
    label.alpha = 0;
    
    [UIView animateWithDuration:STATS_ANIMATE_TIME delay:STATS_DELAY_ANIMATION_TIME options:UIViewAnimationOptionCurveEaseIn
                     animations:^{ label.alpha = 1;}
                     completion:nil];
}

- (void) createCarbsProgressLabel {
    
    float value = (float) (diary.currentTotalCarbohydrates / user.userTotalCarbohydrates);
    
    carbsProgressLabel = [[KAProgressLabel alloc] initWithFrame:CGRectMake(0, 0, FOOD_NUTRIENTS_PROGRESS_BAR_RADIUS, FOOD_NUTRIENTS_PROGRESS_BAR_RADIUS)];
    
    carbsProgressLabel.trackColor = TRACK_COLOUR;
    
     if (value <= 1.0) {
    
         carbsProgressLabel.progressColor = CARBS_COLOUR;
         
     } else {
         
         carbsProgressLabel.progressColor = EXCEEDED_LIMIT_COLOUR;
     }
    
    carbsProgressLabel.trackWidth = FOOD_NUTRIENTS_TRACK_WIDTH;
    
    carbsProgressLabel.progressWidth = FOOD_NUTRIENTS_TRACK_WIDTH;
    
    carbsProgressLabel.center = CGPointMake(xVal, self.frame.size.height/FOOD_NUTRIENTS_HEIGHT_DIVIDE);
    
    [self animateBar:carbsProgressLabel withProgress:value :diary.previousTotalCarbohydrates];
    
    [self createNutrientProgressLabels:carbsProgressLabel :value :@"CARBS"];
    
    diary.previousTotalCarbohydrates = value;
}

- (void) createSaturatedFatsProgressLabel {
    
    float value = (float) (diary.currentSaturatedFats / user.userSaturatedFats);
    
    sFatsProgressLabel = [[KAProgressLabel alloc] initWithFrame:CGRectMake(0, 0, FOOD_NUTRIENTS_PROGRESS_BAR_RADIUS, FOOD_NUTRIENTS_PROGRESS_BAR_RADIUS)];
    
    sFatsProgressLabel.trackColor = TRACK_COLOUR;
    
    if (value <= 1.0) {
    
        sFatsProgressLabel.progressColor = S_FATS_COLOUR;
        
    } else {
        
        sFatsProgressLabel.progressColor = EXCEEDED_LIMIT_COLOUR;
    }
    
    sFatsProgressLabel.trackWidth = FOOD_NUTRIENTS_TRACK_WIDTH;
    
    sFatsProgressLabel.progressWidth = FOOD_NUTRIENTS_TRACK_WIDTH;
    
    sFatsProgressLabel.center = CGPointMake(xVal, self.frame.size.height/FOOD_NUTRIENTS_HEIGHT_DIVIDE);
    
    [self animateBar:sFatsProgressLabel withProgress:value :diary.previousSaturatedFats];
    
    [self createNutrientProgressLabels:sFatsProgressLabel :value :@"S.FATS"];
    
    diary.previousSaturatedFats = value;
}

- (void) createFatsProgressLabel {
    
    float value = (float) (diary.currentTotalFats / user.userTotalFats);
    
    fatsProgressLabel = [[KAProgressLabel alloc] initWithFrame:CGRectMake(0, 0, FOOD_NUTRIENTS_PROGRESS_BAR_RADIUS, FOOD_NUTRIENTS_PROGRESS_BAR_RADIUS)];
    
    fatsProgressLabel.trackColor = TRACK_COLOUR;
    
    if (value <= 1.0) {
    
    fatsProgressLabel.progressColor = FATS_COLOUR;
        
    } else {
        
        fatsProgressLabel.progressColor = EXCEEDED_LIMIT_COLOUR;
    }
    
    fatsProgressLabel.trackWidth = FOOD_NUTRIENTS_TRACK_WIDTH;
    
    fatsProgressLabel.progressWidth = FOOD_NUTRIENTS_TRACK_WIDTH;
    
    fatsProgressLabel.center = CGPointMake(xVal, self.frame.size.height/FOOD_NUTRIENTS_HEIGHT_DIVIDE);
    
    [self animateBar:fatsProgressLabel withProgress:value :diary.previousTotalFats];
    
    [self createNutrientProgressLabels:fatsProgressLabel :value :@"FATS"];
    
    diary.previousTotalFats = value;
}

- (void) createProteinProgressLabel {
    
    float value = (float) (diary.currentProtein / user.userProtein);
    
    proteinProgressLabel = [[KAProgressLabel alloc] initWithFrame:CGRectMake(0, 0, FOOD_NUTRIENTS_PROGRESS_BAR_RADIUS, FOOD_NUTRIENTS_PROGRESS_BAR_RADIUS)];
    
    proteinProgressLabel.trackColor = TRACK_COLOUR;
    
    if (value <= 1.0) {
    
        proteinProgressLabel.progressColor = PROTEIN_COLOUR;
        
    } else {
        
        proteinProgressLabel.progressColor = EXCEEDED_LIMIT_COLOUR;
    }
    
    proteinProgressLabel.trackWidth = FOOD_NUTRIENTS_TRACK_WIDTH;
    
    proteinProgressLabel.progressWidth = FOOD_NUTRIENTS_TRACK_WIDTH;
    
    proteinProgressLabel.center = CGPointMake(xVal, self.frame.size.height/FOOD_NUTRIENTS_HEIGHT_DIVIDE);
    
    [self animateBar:proteinProgressLabel withProgress:value :diary.previousProtein];
    
    [self createNutrientProgressLabels:proteinProgressLabel :value :@"PROTEIN"];
    
    diary.previousProtein = value;
}

- (void) animateBar:(KAProgressLabel*)label withProgress:(float)progress :(float)previousProgress {
    
    label.progress = previousProgress;

    [label setProgress:progress timing:TPPropertyAnimationTimingEaseOut duration:STATS_ANIMATE_TIME delay:STATS_DELAY_ANIMATION_TIME];
}

@end
