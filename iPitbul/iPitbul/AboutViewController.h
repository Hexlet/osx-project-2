//
//  FlipsideViewController.h
//  iPitbul
//
//  Created by Mykhailo Oleksiuk on 11/21/12.
//  Copyright (c) 2012 Mykhailo Oleksiuk. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AboutViewController;

@protocol AboutViewControllerDelegate
- (void)aboutViewControllerDidFinish:(AboutViewController *)controller;
@end

@interface AboutViewController : UIViewController

@property (weak, nonatomic) id <AboutViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end
