//
//  DiaryObject.m
//  My Fit Diet
//
//  Created by Stephen Sowole on 04/04/2015.
//  Copyright (c) 2015 Stephen Sowole. All rights reserved.
//

#import "DiaryObject.h"
#import "UserObject.h"
#import "Constants.h"

@implementation DiaryObject {
    
    UserObject *user;
}

@synthesize foodDiary, diaryDate, occasionArray;
@synthesize currentCalories, currentProtein, currentSaturatedFats, currentTotalCarbohydrates, currentTotalFats;
@synthesize previousCalories, previousTotalFats, previousProtein, previousSaturatedFats, previousTotalCarbohydrates;

- (void) initialiseObjects {
    
    user = [[UserObject alloc] init];
    
    foodDiary = [[NSMutableDictionary alloc] init];
    
    occasionArray = [[NSMutableArray alloc] init];
}

- (id) init {
    
    self = [super init];
    
    if (self) {
        
        [self initialiseObjects];
    }
    
    return self;
}

- (id) initWithDate:(NSString *)date {
    
    self = [super init];
    
    if (self) {
        
        diaryDate = date;
        
        [self initialiseObjects];
        
        [self getDataForDate:diaryDate];
    }
    
    return self;
}

- (void) changeDate:(NSString *)date {
    
    diaryDate = date;
    
    [self getDataForDate:diaryDate];
}

- (void) getDataForDate:(NSString*)date {
    
    [self resetNutrientValues];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Diary"];
    
    [[query fromLocalDatastore] ignoreACLs];
    
    [query includeKey:@"foodObject"];
    
    [query whereKey:@"diaryDate" equalTo:diaryDate];
    
    [query selectKeys:@[@"foodObject",@"mealOccasion"]];
    
    [query orderByAscending:@"mealOccasion,updatedAt"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (!error) {
            
            for (PFObject *object in objects) {
                
                if (object[@"foodObject"]) {
                    
                    NSString *occasion = object[@"mealOccasion"];
                    
                    [self initialiseFoodDiaryArray:occasion];
                    
                    
                    float servingSize = [object[@"servingSize"] floatValue];
                    
                    PFObject *foodObject = object[@"foodObject"];
                    
                    NSMutableArray *array = [foodDiary objectForKey:occasion];
                    
                    [array addObject:foodObject];
                    
                    foodObject[@"servingSize"] = [NSNumber numberWithFloat:servingSize];
                    
                    [self addToNutrientTotals:foodObject servingSize:servingSize];
                }
            }
            
            [[NSNotificationCenter defaultCenter] postNotificationName:DIARY_RELOAD_STATS object:nil];
        }
    }];
}

- (void) resetPreviousValues {
    
    previousCalories = 0;
    previousTotalFats = 0;
    previousSaturatedFats = 0;
    previousTotalCarbohydrates = 0;
    previousProtein = 0;
}

- (void) removeEntry:(PFObject *)object :(NSString*)occasion {
    
    PFQuery *query = [PFQuery queryWithClassName:@"Diary"];
    
    [[query fromLocalDatastore] ignoreACLs];
    
    [query includeKey:@"foodObject"];
    
    [query whereKey:@"foodObject" equalTo:object];
    
    [query whereKey:@"mealOccasion" equalTo:occasion];
    
    [query whereKey:@"servingSize" equalTo:object[@"servingSize"]];
    
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        
        if (!error) {

            [object unpinInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                
                [object deleteEventually];
            }];
        }
    }];
}

- (void) removeAllEntries:(PFObject *)object {
    
    PFQuery *query = [PFQuery queryWithClassName:@"Diary"];
    
    [[query fromLocalDatastore] ignoreACLs];
    
    [query includeKey:@"foodObject"];
    
    [query whereKey:@"foodObject" equalTo:object];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (!error) {
            
            for (PFObject *object in objects) {
                
                [object unpinInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    
                    [object deleteEventually];
                }];
            }
        }
    }];
}

- (void) addToNutrientTotals:(PFObject*)foodObject servingSize:(float)servingSize {
    
    currentCalories += [foodObject[@"calories"] floatValue] * servingSize;
    currentProtein += [foodObject[@"protein"] floatValue] * servingSize;
    currentSaturatedFats += [foodObject[@"saturatedFats"] floatValue] * servingSize;
    currentTotalCarbohydrates += [foodObject[@"totalCarbohydrates"] floatValue] * servingSize;
    currentTotalFats += [foodObject[@"totalFats"] floatValue] * servingSize;
}

- (void) initialiseFoodDiaryArray:(NSString*)occasion {
    
    if (![foodDiary objectForKey:occasion]) {
        
        [foodDiary setObject:[[NSMutableArray alloc] init] forKey:occasion];
        [occasionArray addObject:occasion];
    }
}

- (void) resetNutrientValues {
    
    [foodDiary removeAllObjects];
    [occasionArray removeAllObjects];
    
    currentCalories = 0;
    currentProtein = 0;
    currentSaturatedFats = 0;
    currentTotalCarbohydrates = 0;
    currentTotalFats = 0;
}

- (void) addFoodToDiary:(PFObject *)foodPFObject servingSize:(float)servingSize forOccasion:(NSString *)occasion {
    
    PFObject *diaryObject = [PFObject objectWithClassName:@"Diary"];
    
    
    diaryObject[@"userID"] = user._id;
    
    diaryObject[@"diaryDate"] = self.diaryDate;
    
    diaryObject[@"mealOccasion"] = occasion;
    
    diaryObject[@"foodObject"] = foodPFObject;
    
    diaryObject[@"servingSize"] = [NSNumber numberWithFloat:servingSize];
    
    
    diaryObject.ACL = [PFACL ACLWithUser:[PFUser currentUser]];
    
    
    [diaryObject pinInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        [diaryObject saveEventually];
    }];
    
    NSMutableArray *array = [foodDiary objectForKey:occasion];
    
    [array addObject:foodPFObject];
}

@end
