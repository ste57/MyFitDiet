//
//  PlanMeal.h
//  My Fit Diet
//
//  Created by Stephen Sowole on 10/05/2015.
//  Copyright (c) 2015 Stephen Sowole. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "UserObject.h"
#import "DiaryObject.h"
#import "Constants.h"

@interface PlanMeal : NSObject

- (void) getRecommendedFoods:(UserObject*)userObject withDiary:(DiaryObject*)diaryObject;

@end
