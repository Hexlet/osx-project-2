//
//  ExchangeViewController.m
//  NotesKeeper
//
//  Created by Stan Buran on 11/21/12.
//  Copyright (c) 2012 apoidea. All rights reserved.
//

#import "ExchangeViewController.h"
#include "Common.h"
@interface ExchangeViewController ()

@end

@implementation ExchangeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}
-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.navigationController setToolbarHidden:YES animated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnReload:(id)sender
{
    [Common mbox:@"Under construction": @"Reload"];
}
@end
