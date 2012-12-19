//
//  AppDelegate.m
//  ProximityDating_v.2
//
//  Created by Admin on 12/17/12.
//  Copyright (c) 2012 Admin. All rights reserved.
//

#import "AppDelegate.h"
#import "MyProfileViewController.h"
#import "MasterViewController.h"
#import "LogoViewController.h"
#import "ProfileDoc.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    //UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle: nil];
    
    //MyProfileViewController *myProfileViewController = (MyProfileViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"myProfileViewID"];
    
    //MasterViewController *masterViewController = (MasterViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"mainTabBar"];
    
    //myProfileViewController.myProfile = _profile;
    //masterViewController.myProfile = _profile;
    
    ProfileDoc *profile1 = [[ProfileDoc alloc] init];
    profile1.data.name = @"Potato Bug";
    profile1.data.description = @"Potato Bug short description";
    profile1.data.isMale = TRUE;
    profile1.data.straight = TRUE;
    profile1.data.lookingForPartner = TRUE;
    profile1.thumbImage = [UIImage imageNamed:@"potatoBugThumb.jpg"];
    profile1.fullImage = [UIImage imageNamed:@"potatoBug.jpg"];
    profile1.thumbImageName = @"potatoBugThumb.jpg";
    profile1.fullImageName = @"potatoBug.jpg";
    
    [self saveSettings:profile1];
    
    [self loadSettings];
    
    return YES;
}

-(void)loadSettings{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    _profile = [[ProfileDoc alloc] init];
    
    _profile.data.name = [prefs objectForKey:@"data.name"];
    _profile.data.description = [prefs objectForKey:@"data.description"];
    _profile.data.isMale = [prefs boolForKey:@"data.isMale"];
    _profile.data.straight = [prefs boolForKey:@"data.straight"];
    _profile.data.lookingForPartner = [prefs boolForKey:@"data.lookingForPartner"];
    _profile.thumbImage = [UIImage imageNamed:[prefs objectForKey:@"data.thumbImageName"]];
    _profile.fullImage = [UIImage imageNamed:[prefs objectForKey:@"data.fullImageName"]];
    _profile.thumbImageName = [prefs objectForKey:@"data.thumbImageName"];
    _profile.fullImageName = [prefs objectForKey:@"data.fullImageName"];
}

-(void)saveSettings:(ProfileDoc *)d{
    _profile=d;
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    [prefs synchronize];
    
    [prefs setObject:_profile.data.name forKey:@"data.name"];
    [prefs setObject:_profile.data.description forKey:@"data.description"];
    [prefs setBool:_profile.data.isMale forKey:@"data.isMale"];
    [prefs setBool:_profile.data.straight forKey:@"data.straight"];
    [prefs setBool:_profile.data.lookingForPartner forKey:@"data.lookingForPartner"];
    [prefs setObject:_profile.thumbImageName forKey:@"data.thumbImageName"];
    [prefs setObject:_profile.fullImageName forKey:@"data.fullImageName"];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
