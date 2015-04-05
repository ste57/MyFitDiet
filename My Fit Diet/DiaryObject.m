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

@implementation DiaryObject

@synthesize foodDiary, occasionArray;

- (id) initWithDate:(NSString *)date {
    
    self = [super init];
    
    if (self) {
        
        foodDiary = [[NSMutableDictionary alloc] init];
        
        occasionArray = [[NSMutableArray alloc] init];
        
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
    
    [foodDiary removeAllObjects];
    
    [occasionArray removeAllObjects];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Diary"];
    
    [[query fromLocalDatastore] ignoreACLs];
    
    [query whereKey:@"diaryDate" equalTo:self.diaryDate];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *entryObjects, NSError *error) {
        
        if (!error) {
            
            for (PFObject* object in entryObjects) {
                
                PFRelation *relation = [object relationForKey:@"foodDiary"];
                
                [[relation query] findObjectsInBackgroundWithBlock:^(NSArray *foodObjects, NSError *error) {
                    
                    if (!error) {
                        
                        NSString *occasion = object[@"mealOccasion"];
                        
                        [occasionArray addObject:occasion];
                        
                        [foodDiary setValue:[[NSArray alloc] initWithArray:foodObjects] forKey:occasion];
                        
                        [[NSNotificationCenter defaultCenter] postNotificationName:RELOAD_DIARY_TB object:nil];
                    }
                }];
            }
        }
    }];
}

- (void) addFoodToDiary:(PFObject *)foodObject forOccasion:(NSString *)occasion {
    
    UserObject *user = [[UserObject alloc] init];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    
    [dateFormat setDateFormat:DIARY_DATE_FORMAT];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Diary"];
    
    [[query fromLocalDatastore] ignoreACLs];
    
    [query whereKey:@"userID" equalTo:user._id];
    
    [query whereKey:@"diaryDate" equalTo:self.diaryDate];
    
    [query whereKey:@"mealOccasion" equalTo:occasion];
    
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        
        if (error) {
            
            PFObject *diaryObject = [PFObject objectWithClassName:@"Diary"];
            
            diaryObject[@"userID"] = user._id;
            
            diaryObject[@"diaryDate"] = self.diaryDate;
            
            diaryObject[@"mealOccasion"] = occasion;
            
            diaryObject.ACL = [PFACL ACLWithUser:[PFUser currentUser]];
            
            [diaryObject pinInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                
                [self addFood:foodObject toDiary:diaryObject];
            }];
            
        } else {
            
            [self addFood:foodObject toDiary:object];
        }
    }];
    
}

- (void) addFood:(PFObject*)food toDiary:(PFObject*)diary {
    
    PFRelation *relation = [diary relationForKey:@"foodDiary"];

    [relation addObject:food];
    
    [diary pinInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        [diary saveEventually];
    }];
}

@end
