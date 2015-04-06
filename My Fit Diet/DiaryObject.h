//
//  DiaryObject.h
//  My Fit Diet
//
//  Created by Stephen Sowole on 04/04/2015.
//  Copyright (c) 2015 Stephen Sowole. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FoodObject.h"

@interface DiaryObject : NSObject

@property (strong, nonatomic) NSMutableArray *occasionArray;
@property (strong, nonatomic) NSString *diaryDate;
@property (strong, nonatomic) NSMutableDictionary *foodDiary;

// Used for menu stats
@property float currentCalories;
@property float currentTotalFats;
@property float currentSaturatedFats;
@property float currentTotalCarbohydrates;
@property float currentProtein;

// Used for progress bar
@property float previousCalories;
@property float previousTotalFats;
@property float previousSaturatedFats;
@property float previousTotalCarbohydrates;
@property float previousProtein;

- (void) addFoodToDiary:(PFObject*)foodObject servingSize:(float)servingSize forOccasion:(NSString*)occasion;

- (id) initWithDate:(NSString*)date;

- (void) changeDate:(NSString*)date;

- (void) resetPreviousValues;

- (void) removeEntry:(PFObject*)object :(NSString*)occasion;

- (void) removeAllEntries:(PFObject*)object;

@end
