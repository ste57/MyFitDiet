//
//  UserProfileViewController.m
//  My Fit Diet
//
//  Created by Stephen Sowole on 03/04/2015.
//  Copyright (c) 2015 Stephen Sowole. All rights reserved.
//

#import "UserProfileViewController.h"

@interface UserProfileViewController ()

@end

@implementation UserProfileViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"USER PROFILE";
    
    [self removeBackButtonText];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(createProfile)];
    
    self.navigationItem.rightBarButtonItem = addButton;
}

- (void) removeBackButtonText {
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backButtonItem];
}

- (void) createProfile {
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

@end
