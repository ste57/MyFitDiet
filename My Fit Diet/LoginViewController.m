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
#import "KAProgressLabel.h"

@implementation LoginViewController {
    
    CGSize win;
    UserObject *userObject;
    
    // Progress Bars
    KAProgressLabel *firstProgressLabel, *secondProgressLabel, *thirdProgressLabel;
    
    double firstProgress, secondProgress, thirdProgress;
}

- (void) viewDidLoad {
    
    [super viewDidLoad];
    
    win = self.view.frame.size;
    
    userObject = [[UserObject alloc] init];
    
    self.view.backgroundColor = MAIN_BACKGROUND_COLOUR;
    
    firstProgress = (double)((arc4random() % 100) / 100.0);
    secondProgress = (double)((arc4random() % 100) / 100.0);
    thirdProgress = (double)((arc4random() % 100) / 100.0);
    
    [self createDisplay];
    
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
            
            navigationController.viewControllers = [NSArray arrayWithObjects:menuStatsCollectionViewController, nil];
            
            [self presentViewController:navigationController animated:YES completion:nil];
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
            userObject.weeklyGoalRate = [object[@"weeklyGoalRate"] floatValue];
            
            userObject.userCalories = [object[@"userCalories"] intValue];
            userObject.userProtein = [object[@"userProtein"] floatValue];
            userObject.userSaturatedFats = [object[@"userSaturatedFats"] floatValue];
            userObject.userTotalCarbohydrates = [object[@"userTotalCarbohydrates"] floatValue];
            userObject.userTotalFats = [object[@"userTotalFats"] floatValue];
            
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
    
    [query includeKey:@"foodObject"];
    
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
        
        if (![PFUser currentUser]) {
            
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

- (void) createDisplay {
    
    [self createTitleLabel];
    
    [self createProgressBars];
}

- (void) animateFirstProgressBar {
    
    firstProgressLabel.progress = 0;
    
    UIColor *color = firstProgressLabel.trackColor;
    
    firstProgressLabel.trackColor = firstProgressLabel.progressColor;
    
    firstProgressLabel.progressColor = color;
    
    [firstProgressLabel setProgress:1 timing:TPPropertyAnimationTimingLinear duration:14.0f delay:0.0];
    
    [NSTimer scheduledTimerWithTimeInterval: 14.0f target: self
                                   selector: @selector(animateFirstProgressBar) userInfo: nil repeats: NO];
}

- (void) animateSecondProgressBar {
    
    secondProgressLabel.progress = 0;
    
    UIColor *color = secondProgressLabel.trackColor;
    
    secondProgressLabel.trackColor = secondProgressLabel.progressColor;
    
    secondProgressLabel.progressColor = color;
    
    [secondProgressLabel setProgress:1 timing:TPPropertyAnimationTimingLinear duration:12.0f delay:0.0];
    
    [NSTimer scheduledTimerWithTimeInterval: 12.0f target: self
                                   selector: @selector(animateSecondProgressBar) userInfo: nil repeats: NO];
}

- (void) animateThirdProgressBar {
    
    thirdProgressLabel.progress = 0;
    
    UIColor *color = thirdProgressLabel.trackColor;
    
    thirdProgressLabel.trackColor = thirdProgressLabel.progressColor;
    
    thirdProgressLabel.progressColor = color;
    
    [thirdProgressLabel setProgress:1 timing:TPPropertyAnimationTimingLinear duration:10.0f delay:0.0];
    
    [NSTimer scheduledTimerWithTimeInterval: 10.0f target: self
                                   selector: @selector(animateThirdProgressBar) userInfo: nil repeats: NO];
}

- (void) createProgressBars {
    
    double value;
    
    firstProgressLabel = [[KAProgressLabel alloc] initWithFrame:CGRectMake(0, 0, win.width/1.4, win.width/1.4)];
    
    firstProgressLabel.trackWidth = 30.0f;
    
    firstProgressLabel.progressWidth = 30.0f;
    
    firstProgressLabel.trackColor = KCAL_BAR_COLOUR;
    
    firstProgressLabel.progressColor = [UIColor colorWithRed:0.72 green:0.93 blue:0.72 alpha:1.0];//TRACK_COLOUR;
    
    firstProgressLabel.fillColor = TRACK_COLOUR;
    
    firstProgressLabel.center = CGPointMake(self.view.center.x, self.view.frame.size.height/2.05);
    
    firstProgressLabel.progress = firstProgress;
    
    value = 14.0 - (14.0 * firstProgress);
    
    [firstProgressLabel setProgress:1 timing:TPPropertyAnimationTimingLinear duration:value delay:0.0];

    [NSTimer scheduledTimerWithTimeInterval:value target: self
                                   selector: @selector(animateFirstProgressBar) userInfo: nil repeats: NO];
    
    [self.view addSubview:firstProgressLabel];
    
    // SECOND LABEL
    
    secondProgressLabel = [[KAProgressLabel alloc] initWithFrame:
                           CGRectMake(0, 0, firstProgressLabel.frame.size.width * 0.6, firstProgressLabel.frame.size.width * 0.6)];
    
    secondProgressLabel.trackWidth = firstProgressLabel.frame.size.width * 0.3;
    
    secondProgressLabel.progressWidth = 30.0f;
    
    secondProgressLabel.trackColor = S_FATS_COLOUR;
    
    secondProgressLabel.progressColor = [UIColor colorWithRed:0.72 green:0.85 blue:0.93 alpha:1.0];
    
    secondProgressLabel.center = CGPointMake(self.view.center.x, self.view.frame.size.height/2.05);
    
    secondProgressLabel.progress = secondProgress;
    
    value = 12.0 - (12.0 * firstProgress);
    
    [secondProgressLabel setProgress:1 timing:TPPropertyAnimationTimingLinear duration:value delay:0.0];
    
    [NSTimer scheduledTimerWithTimeInterval:value target: self
                                   selector: @selector(animateSecondProgressBar) userInfo: nil repeats: NO];

    
    [self.view addSubview:secondProgressLabel];
    
    // THIRD LABEL
    
    thirdProgressLabel = [[KAProgressLabel alloc] initWithFrame:
                           CGRectMake(0, 0, firstProgressLabel.frame.size.width * 0.2, firstProgressLabel.frame.size.width * 0.2)];
    
    thirdProgressLabel.trackWidth = firstProgressLabel.frame.size.width * 0.1;
    
    thirdProgressLabel.progressWidth = firstProgressLabel.frame.size.width * 0.1;
    
    thirdProgressLabel.trackColor = EXCEEDED_LIMIT_COLOUR;
    
    thirdProgressLabel.progressColor = [UIColor colorWithRed:0.93 green:0.81 blue:0.81 alpha:1.0];//TRACK_COLOUR;
    
    thirdProgressLabel.center = CGPointMake(self.view.center.x, self.view.frame.size.height/2.05);
    
    thirdProgressLabel.progress = thirdProgress;
    
    value = 10.0 - (10.0 * firstProgress);
    
    [thirdProgressLabel setProgress:1 timing:TPPropertyAnimationTimingLinear duration:value delay:0.0];
    
    [NSTimer scheduledTimerWithTimeInterval:value target: self
                                   selector: @selector(animateThirdProgressBar) userInfo: nil repeats: NO];
    
    [self.view addSubview:thirdProgressLabel];
}

- (void) createTitleLabel {
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, win.width, 100.0)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.center = CGPointMake(win.width/2, win.height/7);
    titleLabel.text = @"MY FIT DIET";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont fontWithName:@"lekton04" size:28.0];
    [self.view addSubview:titleLabel];
}

- (void) didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

@end
