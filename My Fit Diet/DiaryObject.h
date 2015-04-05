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

@property (strong, nonatomic) NSString *diaryDate;
@property (strong, nonatomic) NSMutableDictionary *foodDiary;
@property (strong, nonatomic) NSMutableArray *occasionArray;

- (void) addFoodToDiary:(PFObject*)foodObject forOccasion:(NSString*)occasion;

- (id) initWithDate:(NSString*)date;

- (void) changeDate:(NSString*)date;

@end
