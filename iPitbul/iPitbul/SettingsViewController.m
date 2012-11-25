//
//  SettingsViewController.m
//  iPitbul
//
//  Created by Mykhailo Oleksiuk on 11/22/12.
//  Copyright (c) 2012 Mykhailo Oleksiuk. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)save:(id)sender
{
    [self.delegate settingsViewControllerDidFinish:self];
}

- (IBAction)cancel:(id)sender
{
    [self.delegate settingsViewControllerDidFinish:self];
}


@end
