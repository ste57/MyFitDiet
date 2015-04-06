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
    
    /*[self resetNutrientValues];
     
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
     }];*/
    
    PFQuery *query = [PFQuery queryWithClassName:@"Diary"];
    
    [[query fromLocalDatastore] ignoreACLs];
    
    [query includeKey:@"foodObject"];
    
    [query whereKey:@"diaryDate" equalTo:diaryDate];
    
    [query selectKeys:@[@"foodObject",@"mealOccasion"]];
    
    [query orderByDescending:@"mealOccasion,updatedAt"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (!error) {
            
            for (PFObject *object in objects) {
                
                NSString *occasion = object[@"mealOccasion"];
                
                [self initialiseFoodDiaryArray:occasion];
                
                NSMutableArray *array = [foodDiary objectForKey:occasion];
                
                [array addObject:object[@"foodObject"]];
            }
        }
    }];
}

- (void) initialiseFoodDiaryArray:(NSString*)occasion {
    
    if (![foodDiary objectForKey:occasion]) {
        
        [foodDiary setObject:[[NSMutableArray alloc] init] forKey:occasion];
        [occasionArray addObject:occasion];
    }
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

- (void) addFoodToDiary:(PFObject *)foodPFObject forOccasion:(NSString *)occasion {
    
    PFObject *diaryObject = [PFObject objectWithClassName:@"Diary"];
    
    
    diaryObject[@"userID"] = user._id;
    
    diaryObject[@"diaryDate"] = self.diaryDate;
    
    diaryObject[@"mealOccasion"] = occasion;
    
    diaryObject[@"foodObject"] = foodPFObject;
    
    
    diaryObject.ACL = [PFACL ACLWithUser:[PFUser currentUser]];
    
    
    [diaryObject pinInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        [diaryObject saveEventually];
    }];
    
    NSMutableArray *array = [foodDiary objectForKey:occasion];
    
    [array addObject:foodPFObject];
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
