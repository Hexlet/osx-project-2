//  NotesKeeperDetailViewController.h
//  NotesKeeper
//  Created by Stan Buran on 11/20/12.
//  Copyright (c) 2012 apoidea. All rights reserved.

#import <UIKit/UIKit.h>
@interface NotesKeeperDetailViewController : UIViewController <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *txtNote;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnEdit;
@property (weak, nonatomic) IBOutlet UIToolbar *barEdit;
@property (strong, nonatomic) IBOutlet UIView *mainView;

- (IBAction)btnEdit_Clicked:(id)sender;
- (IBAction)btnDone_Clicked:(id)sender;
- (IBAction)btnMail_Clicked:(id)sender;
- (IBAction)btnLock_Clicked:(id)sender;
- (IBAction)btnCalc_Clicked:(id)sender;

@end
