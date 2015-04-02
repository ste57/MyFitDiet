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

@implementation LoginViewController {
    
    CGSize win;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    win = self.view.frame.size;
    
    self.view.backgroundColor = MAIN_BACKGROUND_COLOUR;
    
    [self createTitleLabel];
    
    [self addFacebookLoginButton];
}

- (UIStatusBarStyle) preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
}

- (void) loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error {
    
    if ([FBSDKAccessToken currentAccessToken]) {
    
        UINavigationController *navigationController = [[UINavigationController alloc] init];
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        MenuStatsCollectionViewController *menuStatsCollectionViewController = [[MenuStatsCollectionViewController alloc] initWithCollectionViewLayout:layout];
        
        navigationController.viewControllers = [NSArray arrayWithObject:menuStatsCollectionViewController];
        
        [self presentViewController:navigationController animated:YES completion:nil];
    }
}

- (void) loginButtonDidLogOut:(FBSDKLoginButton *)loginButton {
    
}

- (void) addFacebookLoginButton {
    
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] initWithFrame:CGRectMake(0, 0, 240.0, 50.0)];
    loginButton.center = CGPointMake(win.width/2, win.height/1.3);
    loginButton.delegate = self;
    [self.view addSubview:loginButton];
}

- (void) createTitleLabel {
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, win.width, 100.0)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.center = CGPointMake(win.width/2, win.height/5);
    titleLabel.text = @"MY FIT DIET";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont fontWithName:@"Primer" size:28.0];
    [self.view addSubview:titleLabel];
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
