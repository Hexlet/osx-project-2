//
//  ChatViewController.h
//  Chatvdvoem
//
//  Created by Dm on 11/25/12.
//  Copyright (c) 2012 Dm. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "UIInputToolbar.h"
#import "Chatvdvoem.h"
#import "SettingsViewController.h"
#import "UIBubbleTableViewDataSource.h"
#import "ChatViewController.h"

@interface ChatViewController : UIViewController <UIInputToolbarDelegate,UIBubbleTableViewDataSource> {
    UIInputToolbar *inputToolbar;
    NSMutableArray *bubbleData;
@private
    BOOL keyboardIsVisible;
    BOOL dataHasChanged;
    BOOL scrollToLast;
    BOOL connected;
}
//- (IBAction)dismissKeyboard:(id)sender;

- (IBAction)toggleConnection:(UIBarButtonItem *)button;
@property (nonatomic, retain) UIActivityIndicatorView *spinner;
@property (weak, nonatomic) IBOutlet UIBubbleTableView *bubbleTable;
@property (nonatomic, retain) UIInputToolbar *inputToolbar;
@property (nonatomic, retain) UIView *spinnerFrame;
- (void) hide:(UIView *)sender;
@end
