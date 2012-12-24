/*
//  ExchangeViewController.h
//  NotesKeeper
//
//  Created by Stan Buran on 11/21/12.
//  Copyright (c) 2012 apoidea. All rights reserved.
*/
#import <UIKit/UIKit.h>
#import "XMLReader.h"


@interface ExchangeViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate>
- (IBAction)btnReload:(id)sender;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property (weak, nonatomic) IBOutlet UILabel *lblUpdate;
@property (weak, nonatomic) IBOutlet UILabel *lblRateLeft;
@property (weak, nonatomic) IBOutlet UILabel *lblRateRight;
@property (weak, nonatomic) IBOutlet UITextField *txtRateLeft;
@property (weak, nonatomic) IBOutlet UITextField *txtRateRight;
@property (weak, nonatomic) IBOutlet UIToolbar *keyBar;
- (IBAction)btnDone_Clicked:(id)sender;

@end
