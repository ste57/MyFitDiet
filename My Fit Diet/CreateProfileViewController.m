//
//  CreateProfileViewController.m
//  My Fit Diet
//
//  Created by Stephen Sowole on 03/04/2015.
//  Copyright (c) 2015 Stephen Sowole. All rights reserved.
//

#import "CreateProfileViewController.h"

@interface CreateProfileViewController ()

@end

@implementation CreateProfileViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"CREATE PROFILE";
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(createProfile)];
    
    self.navigationItem.rightBarButtonItem = addButton;
}

- (void) createProfile {
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

@end
