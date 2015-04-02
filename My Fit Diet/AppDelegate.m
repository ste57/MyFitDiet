//
//  AppDelegate.m
//  My Fit Diet
//
//  Created by Stephen Sowole on 06/03/2015.
//  Copyright (c) 2015 Stephen Sowole. All rights reserved.
//

#import "AppDelegate.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "LoginViewController.h"
#import "MenuStatsCollectionViewController.h"
#import "Constants.h"
#import <Parse/Parse.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [Parse enableLocalDatastore];
    
    // Initialize Parse.
    [Parse setApplicationId:@"vViwhlAhKfXwa4gMEAVkmaw1XKidX9DMKXUbCiIn"
                  clientKey:@"DjLSMcZ4AnYPr92buTfSiOH1yEwt2AIqhG0o3IWD"];
    
    // [Optional] Track statistics around application opens.
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    
    [[UINavigationBar appearance] setTitleTextAttributes: @{NSFontAttributeName:[UIFont fontWithName:MAIN_FONT size:20.0f],
                                                            NSForegroundColorAttributeName:[UIColor whiteColor]}];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    if ([FBSDKAccessToken currentAccessToken]) {
        
        self.window.rootViewController = [LoginViewController alloc];
        
    } else {
    
        UINavigationController *navigationController = [[UINavigationController alloc] init];
        
        navigationController.navigationBar.barTintColor = MAIN_BACKGROUND_COLOUR;
        navigationController.navigationBar.tintColor = [UIColor whiteColor];
        navigationController.navigationBar.barStyle = UIBarStyleBlack;
        navigationController.navigationBar.translucent = NO;
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];

        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        MenuStatsCollectionViewController *menuStatsCollectionViewController = [[MenuStatsCollectionViewController alloc] initWithCollectionViewLayout:layout];
        
        navigationController.viewControllers = [NSArray arrayWithObject:menuStatsCollectionViewController];
        
        self.window.rootViewController = navigationController;
    }
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self.window makeKeyAndVisible];
    
    return [[FBSDKApplicationDelegate sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    return [[FBSDKApplicationDelegate sharedInstance] application:application openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [FBSDKAppEvents activateApp];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
