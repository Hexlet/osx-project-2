//
//  BOAddS3BucketViewController.m
//  AWSMobile
//
//  Created by Oleg Bogatenko on 27.12.12.
//  Copyright (c) 2012 DoZator Home. All rights reserved.
//

#import "BOAddS3BucketViewController.h"

@interface BOAddS3BucketViewController ()

@end

@implementation BOAddS3BucketViewController

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

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)done:(id)sender {
    
}

@end
