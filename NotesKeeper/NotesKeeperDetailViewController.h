//  NotesKeeperDetailViewController.h
//  NotesKeeper
//  Created by Stan Buran on 11/20/12.
//  Copyright (c) 2012 apoidea. All rights reserved.

#import <UIKit/UIKit.h>
#import "Note.h"
#import <MessageUI/MessageUI.h>
#import "UICalc.h"

@interface NotesKeeperDetailViewController : UIViewController <UITextViewDelegate,MFMailComposeViewControllerDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *txtNote;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnEdit;
@property (weak, nonatomic) IBOutlet UIToolbar *barEdit;
@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnCalc;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnAction;

- (IBAction)btnEdit_Clicked:(id)sender;
- (IBAction)btnDone_Clicked:(id)sender;
- (IBAction)btnMail_Clicked:(id)sender;
- (IBAction)btnAction_Clicked:(id)sender;
- (IBAction)btnCalc_Clicked:(id)sender;
@end
