//
//  BOMainViewController.m
//  AWSMobile
//
//  Created by Oleg Bogatenko on 19.12.12.
//  Copyright (c) 2012 DoZator Home. All rights reserved.
//

#import "BOMainViewController.h"


@implementation BOMainViewController

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)awsSignUp:(id)sender {
    NSString *url = [NSString stringWithFormat:@"http://aws.amazon.com"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

@end
