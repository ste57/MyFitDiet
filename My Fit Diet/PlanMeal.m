//
//  PlanMeal.m
//  My Fit Diet
//
//  Created by Stephen Sowole on 10/05/2015.
//  Copyright (c) 2015 Stephen Sowole. All rights reserved.
//

#import "PlanMeal.h"

@implementation PlanMeal {
    
    UserObject *user;
    DiaryObject *diary;
}

- (void) getRecommendedFoods:(UserObject*)userObject withDiary:(DiaryObject*)diaryObject {
    
    user = userObject;
    diary = diaryObject;
    
    PFQuery *localDBQuery;
    
    localDBQuery = [PFQuery queryWithClassName:@"Food"];
    
    [[localDBQuery fromLocalDatastore] ignoreACLs];
    
    localDBQuery = [self setQueryIdealValues:localDBQuery];
    
    [localDBQuery setLimit:PLAN_MEAL_DATABASE_FOODS];
    
    [localDBQuery orderByAscending:@"createdAt"];
    
    [localDBQuery orderByDescending:@"calories"];
    
    [localDBQuery whereKey:@"description" notEqualTo:@"recommended"];
    
    [localDBQuery findObjectsInBackgroundWithBlock:^(NSArray *localObjects, NSError *error) {
        
        if (!error) {
            
            PFQuery *onlineIdealDBQuery = [PFQuery queryWithClassName:@"PlanMeal"];
            
            onlineIdealDBQuery = [self setQueryIdealValues:onlineIdealDBQuery];
            
            [onlineIdealDBQuery setLimit:(PLAN_MEAL_ONLINE_FOODS + (PLAN_MEAL_DATABASE_FOODS - localObjects.count))];
            
            [onlineIdealDBQuery orderByDescending:@"protein,totalCarbohydrates,calories"];
            
            [onlineIdealDBQuery findObjectsInBackgroundWithBlock:^(NSArray *onlineObjects, NSError *error) {
                
                if (!error) {
                    
                    PFQuery *onlineOtherDBQuery = [PFQuery queryWithClassName:@"PlanMeal"];
                    
                    [onlineOtherDBQuery whereKey:@"calories" lessThanOrEqualTo:
                     [NSNumber numberWithFloat:(user.userCalories - diary.currentCalories)]];
                    
                    [onlineOtherDBQuery whereKey:@"totalFats" lessThanOrEqualTo:
                     [NSNumber numberWithDouble:(user.userTotalFats - diary.currentTotalFats)]];
                    
                    [onlineOtherDBQuery whereKey:@"saturatedFats" lessThanOrEqualTo:
                     [NSNumber numberWithDouble:(user.userSaturatedFats - diary.currentSaturatedFats)]];
                    
                    [onlineOtherDBQuery whereKey:@"totalCarbohydrates" lessThanOrEqualTo:
                     [NSNumber numberWithDouble:(user.userTotalCarbohydrates - diary.currentTotalCarbohydrates)]];
                    
                    [onlineOtherDBQuery whereKey:@"protein" lessThanOrEqualTo:
                     [NSNumber numberWithDouble:(user.userProtein - diary.currentProtein)]];
                    
                    [onlineOtherDBQuery setLimit:
                     ((PLAN_MEAL_ONLINE_FOODS + PLAN_MEAL_DATABASE_FOODS) - (onlineObjects.count - localObjects.count))];
                    
                    [onlineOtherDBQuery orderByDescending:@"fibre"];
                    
                    [onlineOtherDBQuery findObjectsInBackgroundWithBlock:^(NSArray *onlineOtherObjects, NSError *error) {
                        
                        NSMutableArray *mealArray = [[NSMutableArray alloc] init];
                        
                        NSMutableArray *objectArray = [NSMutableArray arrayWithArray:localObjects];
                        [objectArray addObjectsFromArray:onlineObjects];
                        [objectArray addObjectsFromArray:onlineOtherObjects];
                        
                        for (PFObject *object in objectArray) {
                            
                            PFObject *foodObject = [PFObject objectWithClassName:@"Food"];
                            
                            foodObject[@"name"] = object[@"name"];
                            foodObject[@"calories"] = object[@"calories"];
                            foodObject[@"totalFats"] = object[@"totalFats"];
                            foodObject[@"saturatedFats"] = object[@"saturatedFats"];
                            foodObject[@"totalCarbohydrates"] = object[@"totalCarbohydrates"];
                            foodObject[@"protein"] = object[@"protein"];
                            foodObject[@"servingSize"] = [NSNumber numberWithInt:1];
                            
                            [mealArray addObject:foodObject];
                        }
                        
                        NSSortDescriptor *proteinSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"protein" ascending:YES];
                        NSSortDescriptor *calorieSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"calories" ascending:NO];
                        
                        NSArray *sortDescriptors = [NSArray arrayWithObjects:proteinSortDescriptor, calorieSortDescriptor, nil];
                        
                        NSArray *sortedArray = [mealArray sortedArrayUsingDescriptors:sortDescriptors];
                        
                        [[NSNotificationCenter defaultCenter] postNotificationName:PLAN_MEAL_FOODS_RECIEVED object:sortedArray];
                    }];
                }
            }];
        }
    }];
}

- (PFQuery*) setQueryIdealValues:(PFQuery*)query {
    
    [query whereKey:@"calories" lessThanOrEqualTo:[NSNumber numberWithFloat:(user.userCalories - diary.currentCalories)]];
    
    [query whereKey:@"totalFats" lessThanOrEqualTo:
     [self validateValue:((3.0+17.5)/2.0) against:(user.userTotalFats - diary.currentTotalFats)]];
    
    [query whereKey:@"saturatedFats" lessThanOrEqualTo:
     [self validateValue:((1.5+5.0)/2.0) against:(user.userSaturatedFats - diary.currentSaturatedFats)]];
    
    [query whereKey:@"totalCarbohydrates" lessThanOrEqualTo:
     [self validateValue:((5.0+22.5)/2.0) against:(user.userTotalCarbohydrates - diary.currentTotalCarbohydrates)]];
    
    [query whereKey:@"protein" lessThanOrEqualTo:
     [NSNumber numberWithDouble:(user.userProtein - diary.currentProtein)]];
    
    return query;
}

- (NSNumber*) validateValue:(double)val against:(double)compareVal {
    
    if (compareVal < val) {
        
        val = compareVal;
    }
    
    return [NSNumber numberWithDouble:val];
}

@end
