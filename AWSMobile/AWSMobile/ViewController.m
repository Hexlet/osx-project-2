//
//  ViewController.m
//  AWSMobile
//
//  Created by Oleg Bogatenko on 19.12.12.
//  Copyright (c) 2012 DoZator Home. All rights reserved.
//

#import "ViewController.h"


@implementation ViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [UIView animateWithDuration:1.0 delay:0.2 options:0 animations:^{
        CGRect frame = self.logoImageView.frame;
        frame.origin.y = 15.0;
        self.logoImageView.frame = frame;
    }
                     completion:^(BOOL competed){
                         [self performSegueWithIdentifier:@"splash" sender:self];
                     }];
}

@end

@implementation SplashSegue

- (void)perform {
    [[self sourceViewController] presentModalViewController:[self destinationViewController] animated:NO];
}

@end

