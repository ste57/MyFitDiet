//
//  UserProfileViewController.m
//  My Fit Diet
//
//  Created by Stephen Sowole on 03/04/2015.
//  Copyright (c) 2015 Stephen Sowole. All rights reserved.
//

#import "UserProfileViewController.h"
#import "UserObject.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <Parse/Parse.h>
#import "LoginViewController.h"
#import "Constants.h"

@interface UserProfileViewController ()

@end

@implementation UserProfileViewController

- (void) viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"USER PROFILE";
    
    [self removeBackButtonText];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(createProfile)];
    
    self.navigationItem.rightBarButtonItem = addButton;
    self.navigationItem.hidesBackButton = YES;
}

- (void) removeBackButtonText {
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backButtonItem];
}

- (void) createProfile {
    
    if ([self validatedFields]) {
        
        UserObject *userObject = self.formController.form;
        
        [userObject syncUserObject];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (BOOL) validatedFields {
    
    UserObject *userObject = self.formController.form;
    
    NSString *field = @"";
    
    if (!userObject.height) {
        
        field = @"height";
        
    } else if (!userObject.currentWeight) {
        
        field = @"current weight";
        
    } else if (!userObject.goalWeight) {
        
        field = @"goal weight";
        
    } else if (!userObject.weeklyGoalRate) {
        
        field = @"weekly goal rate";
    }
    
    
    if ([field isEqualToString:@""]) {
        
        return YES;
    }
    
    [self callAlertView:@"Incomplete Profile" :[NSString stringWithFormat:@"\nPlease ensure the %@ field is not empty.", field]];
    
    return NO;
}

- (void) callAlertView:(NSString*)title :(NSString*)message {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void) didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (void) logUserOut {
    
    [[FBSDKLoginManager alloc] logOut];
    
    [PFUser logOut];
    
    [PFObject unpinAllObjectsInBackground];
    
    [[UserObject alloc] removeUserObject];
    
    [self.navigationController popToRootViewControllerAnimated:NO];
    
    [self presentViewController:[LoginViewController alloc] animated:NO completion:nil];
}

- (void) syncUserData {
    
    [self retrieveUserData];
    [self retrieveFoodData];
    [self retrieveDiaryData];
}

- (void) retrieveUserData {
    
    UserObject *userObject = [[UserObject alloc] init];
    
    PFQuery *query = [PFUser query];
    
    [query whereKey:@"username" equalTo:userObject._id];
    
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        
        if (!error) {
            
            userObject.dateOfBirth = object[@"dateOfBirth"];
            userObject.height = [object[@"height"] floatValue];
            userObject.currentWeight = [object[@"currentWeight"] floatValue];
            userObject.goalWeight = [object[@"goalWeight"] floatValue];
            userObject.userSetGainWeight = ![object[@"isUserLosingWeight"] boolValue];
            userObject.weeklyGoalRate = [object[@"weeklyGoalRate"] floatValue];
            
            [userObject syncUserObject];
        }
    }];
}

- (void) retrieveFoodData {
    
    PFQuery *query = [PFQuery queryWithClassName:@"Food"];
    
    [query setLimit:1000];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (!error) {
            
            [PFObject pinAllInBackground:objects];
        }
    }];
}

- (void) retrieveDiaryData {
    
    PFQuery *query = [PFQuery queryWithClassName:@"Diary"];
    
    [query includeKey:@"foodObject"];
    
    [query setLimit:300];
    
    [query orderByDescending:@"updatedAt"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (!error) {
            
            [PFObject pinAllInBackground:objects];
        }
    }];
}

@end
