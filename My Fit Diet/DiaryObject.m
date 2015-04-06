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

@synthesize foodDiary, occasionArray;

- (id) init {
    
    self = [super init];
    
    if (self) {
     
        [self initialiseObjects];
    }
    
    return self;
}

- (void) initialiseObjects {
    
    user = [[UserObject alloc] init];
    
    foodDiary = [[NSMutableDictionary alloc] init];
    
    occasionArray = [[NSMutableArray alloc] init];
}

- (id) initWithDate:(NSString *)date {
    
    self = [super init];
    
    if (self) {
        
        self.diaryDate = date;
        
        [self getDataForDate:self.diaryDate];
    }
    
    return self;
}

- (void) changeDate:(NSString *)date {
    
    self.diaryDate = date;
    
    [self getDataForDate:date];
}

- (void) getDataForDate:(NSString*)date {
    
    [self resetNutrientValues];
    
    [foodDiary removeAllObjects];
    
    [occasionArray removeAllObjects];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Diary"];
    
    [[query fromLocalDatastore] ignoreACLs];
    
    [query whereKey:@"diaryDate" equalTo:self.diaryDate];
    
    [query orderByDescending:@"updatedAt"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *entryObjects, NSError *error) {
        
        if (!error) {
            
            for (PFObject* object in entryObjects) {
                
                PFRelation *relation = [object relationForKey:@"foodDiary"];
                
                [[relation query] findObjectsInBackgroundWithBlock:^(NSArray *foodObjects, NSError *error) {
                    
                    if (!error) {
                        
                        [self calculateNutrientTotals:foodObjects];
                        
                        NSString *occasion = object[@"mealOccasion"];
                        
                        [occasionArray addObject:occasion];
                        
                        [foodDiary setValue:[[NSMutableArray alloc] initWithArray:foodObjects] forKey:occasion];

                        [[NSNotificationCenter defaultCenter] postNotificationName:RELOAD_DIARY_TB object:nil];
                    }
                }];
            }
        }
    }];
}

- (void) resetNutrientValues {
    
    user.currentCalories = 0;
    user.currentProtein = 0;
    user.currentSaturatedFats = 0;
    user.currentTotalCarbohydrates = 0;
    user.currentTotalFats = 0;
}

- (void) calculateNutrientTotals:(NSArray*)array {
    
    for (PFObject *object in array) {
        
        user.currentCalories += [object[@"calories"] floatValue];
        user.currentProtein += [object[@"protein"] floatValue];
        user.currentSaturatedFats += [object[@"saturatedFats"] floatValue];
        user.currentTotalCarbohydrates += [object[@"totalCarbohydrates"] floatValue];
        user.currentTotalFats += [object[@"totalFats"] floatValue];
    }
    
    [user syncUserObject];
}

- (void) addFoodToDiary:(PFObject *)foodObject forOccasion:(NSString *)occasion {
    
    PFObject *diaryObject = [PFObject objectWithClassName:@"Diary"];
    
    PFRelation *relation = [diaryObject relationForKey:@"foodObject"];

    diaryObject[@"userID"] = user._id;
    
    diaryObject[@"diaryDate"] = self.diaryDate;
    
    diaryObject[@"mealOccasion"] = occasion;
    
    [relation addObject:foodObject];
    
    
    diaryObject.ACL = [PFACL ACLWithUser:[PFUser currentUser]];
    
    
    [diaryObject pinInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        [diaryObject saveEventually];
    }];
}

/*- (void) addFood:(PFObject*)food toDiary:(PFObject*)diary forOccasion:(NSString*)occasion {
    
    PFRelation *relation = [diary relationForKey:@"foodDiary"];
    
    [relation addObject:food];
    
    [diary unpinInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        [diary pinInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            
            [diary saveEventually];
        }];
        
    }];
}*/

@end
