//
//  FlipsideViewController.m
//  iPitbul
//
//  Created by Mykhailo Oleksiuk on 11/21/12.
//  Copyright (c) 2012 Mykhailo Oleksiuk. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSString* currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    
    _labelVersion.text = [_labelVersion.text stringByAppendingString:currentVersion];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate aboutViewControllerDidFinish:self];
}

- (IBAction)rateApplication:(id)sender {
    _labelVersion.text = @"RateApplication";
    NSLog(@"rateApplication");
}

- (IBAction)tellFriends:(id)sender {
    if([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailController = [[MFMailComposeViewController alloc] init];
        mailController.mailComposeDelegate = self;
        
        [mailController setSubject:NSLocalizedString(@"tellFriends.email.subject", nil)];
        [mailController setMessageBody:NSLocalizedString(@"tellFriends.email.body", nil) isHTML:NO];
        
        [self presentViewController:mailController animated:YES completion:nil];
    }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)emailSupport:(id)sender {
    _labelVersion.text = @"EmailSupport";
    NSLog(@"rateApplication");
}

- (IBAction)donate:(id)sender {
    _labelVersion.text = @"Donate";
    NSLog(@"rateApplication");
}


@end
