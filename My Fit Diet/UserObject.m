//
//  UserObject.m
//  My Fit Diet
//
//  Created by Stephen Sowole on 02/04/2015.
//  Copyright (c) 2015 Stephen Sowole. All rights reserved.
//

#import "UserObject.h"
#import "Constants.h"

@implementation UserObject

@synthesize _id, email, gender, name, currentWeight, goalWeight, dateOfBirth, height, losingWeight, goalRate;

- (id) init {
    
    self = [super init];
    
    if (self) {
        
        UserObject *userObject = [self loadCustomObjectWithKey:USER_OBJECT];
        
        if (userObject) {
            
            _id = userObject._id;
            email = userObject.email;
            name = userObject.name;
            gender = userObject.gender;
            
            currentWeight = userObject.currentWeight;
            goalWeight = userObject.goalWeight;
            dateOfBirth = userObject.dateOfBirth;
            height = userObject.height;
            
            losingWeight = userObject.losingWeight;
            goalRate = userObject.goalRate;
        }
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    
    [encoder encodeObject:_id forKey:@"_id"];
    [encoder encodeObject:email forKey:@"email"];
    [encoder encodeObject:name forKey:@"first_name"];
    [encoder encodeObject:gender forKey:@"gender"];
    
    [encoder encodeFloat:currentWeight forKey:@"currentWeight"];
    [encoder encodeFloat:goalWeight forKey:@"goalWeight"];
    [encoder encodeObject:dateOfBirth forKey:@"dateOfBirth"];
    [encoder encodeFloat:height forKey:@"height"];
    
    [encoder encodeBool:losingWeight forKey:@"losingWeight"];
    [encoder encodeFloat:goalRate forKey:@"goalRate"];
}

- (id) initWithCoder:(NSCoder *)decoder {
    
    self = [super init];
    
    if (self) {
        
        _id = [decoder decodeObjectForKey:@"_id"];
        email = [decoder decodeObjectForKey:@"email"];
        name = [decoder decodeObjectForKey:@"first_name"];
        gender = [decoder decodeObjectForKey:@"gender"];
        
        currentWeight = [decoder decodeFloatForKey:@"currentWeight"];
        goalWeight = [decoder decodeFloatForKey:@"goalWeight"];
        dateOfBirth = [decoder decodeObjectForKey:@"dateOfBirth"];
        height = [decoder decodeFloatForKey:@"height"];
        
        losingWeight = [decoder decodeBoolForKey:@"losingWeight"];
        goalRate = [decoder decodeFloatForKey:@"goalRate"];
    }
    
    return self;
}

- (void) updateObject {
    
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:self];
    [[NSUserDefaults standardUserDefaults] setObject:encodedObject forKey:USER_OBJECT];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (UserObject*) loadCustomObjectWithKey:(NSString *)key {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [defaults objectForKey:key];
    UserObject *object = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    
    return object;
}

@end
