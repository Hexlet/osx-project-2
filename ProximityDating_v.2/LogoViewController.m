//
//  LogoViewController.m
//  ProximityDating_v.2
//
//  Created by Admin on 12/18/12.
//  Copyright (c) 2012 Admin. All rights reserved.
//

#import "LogoViewController.h"

@implementation LogoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self performSelector:@selector(moveToMainTabBar) withObject:nil afterDelay:1.0];
}

-(void)moveToMainTabBar
{
    [self performSegueWithIdentifier:@"toMainTabBar" sender:self];
}

@end
