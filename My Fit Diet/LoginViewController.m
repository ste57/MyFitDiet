//
//  LoginViewController.m
//  My Fit Diet
//
//  Created by Stephen Sowole on 30/03/2015.
//  Copyright (c) 2015 Stephen Sowole. All rights reserved.
//

#import "LoginViewController.h"
#import "MenuStatsCollectionViewController.h"
#import "Constants.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "UserObject.h"
#import "UserProfileViewController.h"
#import <Parse/Parse.h>

@implementation LoginViewController {
    
    CGSize win;
    UserObject *userObject;
}

- (void) viewDidLoad {
    
    [super viewDidLoad];
    
    win = self.view.frame.size;
    
    userObject = [[UserObject alloc] init];
    
    self.view.backgroundColor = MAIN_BACKGROUND_COLOUR;
    
    [self createTitleLabel];
    
    [self addFacebookLoginButton];
}

- (void) viewDidAppear:(BOOL)animated {
    
    [self retrieveFacebookUserData];
}

- (UIStatusBarStyle) preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
}

- (void) logUserIntoMyFitDiet {
    
    if ([FBSDKAccessToken currentAccessToken]) {
        
        [[UINavigationBar appearance] setTitleTextAttributes: @{NSFontAttributeName:[UIFont fontWithName:MAIN_FONT size:20.0f],
                                                                NSForegroundColorAttributeName:[UIColor whiteColor]}];
        
        UINavigationController *navigationController = [[UINavigationController alloc] init];
        
        navigationController.navigationBar.barTintColor = MAIN_BACKGROUND_COLOUR;
        navigationController.navigationBar.tintColor = [UIColor whiteColor];
        navigationController.navigationBar.barStyle = UIBarStyleBlack;
        navigationController.navigationBar.translucent = NO;
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        MenuStatsCollectionViewController *menuStatsCollectionViewController = [[MenuStatsCollectionViewController alloc] initWithCollectionViewLayout:layout];
        
        if (!userObject.currentWeight) {
            
            UserProfileViewController *userProfileVC = [[UserProfileViewController alloc] init];
            
            userProfileVC.formController.form = [[UserObject alloc] init];
            
            navigationController.viewControllers = [NSArray arrayWithObjects:menuStatsCollectionViewController, userProfileVC, nil];
            
            [self presentViewController:navigationController animated:YES completion:nil];
            
        } else {
            
            navigationController.viewControllers = [NSArray arrayWithObject:menuStatsCollectionViewController];
            
            [self presentViewController:navigationController animated:NO completion:nil];
        }
    }
}

- (void) retrieveUserData {
    
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
        
        [self logUserIntoMyFitDiet];
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
    
    [query setLimit:300];
    
    [query orderByDescending:@"updatedAt"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (!error) {
            
            [PFObject pinAllInBackground:objects];
        }
    }];
}

- (void) createPFUser {
    
    if (![PFUser currentUser]) {
        
        PFUser *pfUser = [PFUser user];
        
        pfUser.username = userObject._id;
        pfUser.password = userObject._id;
        pfUser.email = userObject.email;
        
        [PFUser logInWithUsernameInBackground:pfUser.username password:pfUser.password block:^(PFUser *userObject, NSError *error) {
            
            if (!error) {
                
                [self retrieveUserData];
                
                [self retrieveFoodData];
                
                [self retrieveDiaryData];
                
            } else {
                
                [pfUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    
                    if (!error) {
                        
                        [self logUserIntoMyFitDiet];
                        
                    } else {
                        
                        [self displayErrorAlert:[error userInfo][@"error"]];
                    }
                }];
            }
        }];
    }
}

- (void) retrieveFacebookUserData {
    
    if ([FBSDKAccessToken currentAccessToken]) {
        
        if (!userObject._id) {
            
            [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil]
             
             startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                 
                 if (!error) {
                     
                     userObject._id = [result objectForKey:@"id"];
                     userObject.name = [[result objectForKey:@"first_name"] capitalizedString];
                     userObject.gender = [[result objectForKey:@"gender"] capitalizedString];
                     userObject.email = [result objectForKey:@"email"];
                     
                     [userObject syncUserObject];
                     
                     [self createPFUser];
                 }
             }];
            
        } else {
            
            [self createPFUser];
            
            [self logUserIntoMyFitDiet];
        }
        
        
        
    }
}

- (void) displayErrorAlert:(NSString*)errorString {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error!"
                                                    message:errorString
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void) loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error {
    
    [self retrieveFacebookUserData];
}

- (void) loginButtonDidLogOut:(FBSDKLoginButton *)loginButton {
    
}

- (void) addFacebookLoginButton {
    
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] initWithFrame:CGRectMake(0, 0, win.width/1.4, win.width/6.4)];
    loginButton.readPermissions = @[@"public_profile", @"email", @"user_friends"];
    loginButton.center = CGPointMake(win.width/2, win.height/1.15);
    loginButton.delegate = self;
    [self.view addSubview:loginButton];
}

- (void) createTitleLabel {
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, win.width, 100.0)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.center = CGPointMake(win.width/2, win.height/7);
    titleLabel.text = @"MY FIT DIET";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont fontWithName:@"Primer" size:28.0];
    [self.view addSubview:titleLabel];
}

- (void) didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

@end
