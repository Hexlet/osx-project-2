//
//  JoinChatViewController.m
//  Chatvdvoem
//
//  Created by Dm on 11/25/12.
//  Copyright (c) 2012 Dm. All rights reserved.
//

#import "JoinChatViewController.h"

@interface JoinChatViewController ()

@end

@implementation JoinChatViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationItem.backBarButtonItem=nil;
    }
    return self;
}

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

@end
