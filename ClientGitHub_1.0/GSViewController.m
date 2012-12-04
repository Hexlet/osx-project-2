//
//  GSViewController.m
//  ClientGitHub_1.0
//
//  Created by Администратор on 11/9/12.
//  Copyright (c) 2012 GameStore. All rights reserved.
//

#import "GSViewController.h"
#import "GSAppDelegate.h"

@interface GSViewController ()

@end

@implementation GSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startConnection
{
    GSAppDelegate * appDelegate = (GSAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    NSString *resultValue = nil;
    if (appDelegate.netStatus == NotReachable) {
        resultValue = @"Not Connection";
    } else if (appDelegate.netStatus == ReachableViaWiFi) {
        resultValue = @"Connection ReachableViaWiFi";
    } else if (appDelegate.netStatus == ReachableViaWWAN) {
        resultValue = @"Connection ReachableViaWWAN";
    }
    
    
    
    _resultTest.text = resultValue;
}

@end
