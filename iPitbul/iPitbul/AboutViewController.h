//
//  FlipsideViewController.h
//  iPitbul
//
//  Created by Mykhailo Oleksiuk on 11/21/12.
//  Copyright (c) 2012 Mykhailo Oleksiuk. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FlipsideViewController;

@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end

@interface FlipsideViewController : UIViewController

@property (weak, nonatomic) id <FlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end
