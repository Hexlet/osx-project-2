//
//  FlipsideViewController.h
//  iPitbul
//
//  Created by Mykhailo Oleksiuk on 11/21/12.
//  Copyright (c) 2012 Mykhailo Oleksiuk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@class AboutViewController;

@protocol AboutViewControllerDelegate
- (void)aboutViewControllerDidFinish:(AboutViewController *)controller;
@end

@interface AboutViewController : UIViewController<MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *labelVersion;
@property (weak, nonatomic) id <AboutViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;
- (IBAction)rateApplication:(id)sender;
- (IBAction)tellFriends:(id)sender;
- (IBAction)emailSupport:(id)sender;
- (IBAction)donate:(id)sender;

@end
