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
#import "CreateProfileViewController.h"

@implementation LoginViewController {
    
    CGSize win;
    UserObject *user;
}

- (void) viewDidLoad {
    
    [super viewDidLoad];
    
    win = self.view.frame.size;
    
    user = [[UserObject alloc] init];
    
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

- (void) retrieveFacebookUserData {
    
    if ([FBSDKAccessToken currentAccessToken]) {
        
        if (!user._id) {
            
            [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil]
             
             startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                 
                 if (!error) {
                     
                     user._id = [result objectForKey:@"id"];
                     user.name = [result objectForKey:@"first_name"];
                     user.gender = [result objectForKey:@"gender"];
                     user.email = [result objectForKey:@"email"];
                     
                     [user updateObject];
                 }
                 
                 [self userLoggedIn];
             }];
            
        } else {
            
            [self userLoggedIn];
        }
    }
}

- (void) userLoggedIn {
    
    if ([FBSDKAccessToken currentAccessToken]) {
        
        [[UINavigationBar appearance] setTitleTextAttributes: @{NSFontAttributeName:[UIFont fontWithName:MAIN_FONT size:20.0f],
                                                                NSForegroundColorAttributeName:[UIColor whiteColor]}];
        
        UINavigationController *navigationController = [[UINavigationController alloc] init];
        
        navigationController.navigationBar.barTintColor = MAIN_BACKGROUND_COLOUR;
        navigationController.navigationBar.tintColor = [UIColor whiteColor];
        navigationController.navigationBar.barStyle = UIBarStyleBlack;
        navigationController.navigationBar.translucent = NO;
        
        if (!user.currentWeight) {
            
            CreateProfileViewController *createProfileVC = [[CreateProfileViewController alloc] init];
            
            createProfileVC.formController.form = [[UserObject alloc] init];
            
            navigationController.viewControllers = [NSArray arrayWithObject:createProfileVC];
            
        } else {
            
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
            
            layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
            
            MenuStatsCollectionViewController *menuStatsCollectionViewController = [[MenuStatsCollectionViewController alloc] initWithCollectionViewLayout:layout];
            
            navigationController.viewControllers = [NSArray arrayWithObject:menuStatsCollectionViewController];
        }
        
        [self presentViewController:navigationController animated:YES completion:nil];
    }
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
