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

@synthesize _id, email, gender, first_name, currentWeight, goalWeight, age, height;

- (id) init {
    
    self = [super init];
    
    if (self) {
        
        UserObject *userObject = [self loadCustomObjectWithKey:USER_OBJECT];
        
        if (userObject) {
            
            _id = userObject._id;
            email = userObject.email;
            first_name = userObject.first_name;
            gender = userObject.gender;
            
            currentWeight = userObject.currentWeight;
            goalWeight = userObject.goalWeight;
            age = userObject.age;
            height = userObject.height;
        }
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    
    [encoder encodeObject:_id forKey:@"_id"];
    [encoder encodeObject:email forKey:@"email"];
    [encoder encodeObject:first_name forKey:@"first_name"];
    [encoder encodeObject:gender forKey:@"gender"];
    
    [encoder encodeFloat:currentWeight forKey:@"currentWeight"];
    [encoder encodeFloat:goalWeight forKey:@"goalWeight"];
    [encoder encodeInt:age forKey:@"age"];
    [encoder encodeFloat:height forKey:@"height"];
}

- (id) initWithCoder:(NSCoder *)decoder {
    
    self = [super init];
    
    if (self) {
        
        _id = [decoder decodeObjectForKey:@"_id"];
        email = [decoder decodeObjectForKey:@"email"];
        first_name = [decoder decodeObjectForKey:@"subcategory"];
        gender = [decoder decodeObjectForKey:@"gender"];
        
        currentWeight = [decoder decodeFloatForKey:@"currentWeight"];
        goalWeight = [decoder decodeFloatForKey:@"goalWeight"];
        age = [decoder decodeIntForKey:@"age"];
        height = [decoder decodeFloatForKey:@"height"];
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
