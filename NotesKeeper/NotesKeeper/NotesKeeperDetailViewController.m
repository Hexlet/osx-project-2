//
//  NotesKeeperDetailViewController.m
//  NotesKeeper
//
//  Created by Stan Buran on 11/20/12.
//  Copyright (c) 2012 apoidea. All rights reserved.
//

#import "NotesKeeperDetailViewController.h"
#include "Common.h"

@implementation NotesKeeperDetailViewController
bool isKeyboardPresent;

#pragma mark - Managing the detail item
- (void)viewDidLoad {
    [super viewDidLoad];

    self.barEdit.hidden = true;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    UIImage *image = [UIImage imageNamed: @"NoteBackground.png"];
    UIColor *color = [UIColor colorWithPatternImage:image];
    [self.txtNote setBackgroundColor:color];
	_txtNote.text = Common.activeNote.Text;
    _txtNote.editable = false;
	isKeyboardPresent = false;
}
-(void) keyboardWasShown: (NSNotification *) notification {
	//CGSize kbSize = [[[notification userInfo] objectForKey: UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
	isKeyboardPresent = true;
	[self alignControls];
}
-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.navigationController setToolbarHidden:YES animated:NO];
    
    switch(Common.EditMode)
	{
		case ENUM_READ:
			break;
		case ENUM_WRITE:
			[self btnEdit_Clicked:nil];
			break;
		case ENUM_CALC:
			break;
		case ENUM_RATE:
			break;
		default:
			break;
	}
	[Common doEvents];
	[self alignControls];
}
-(void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
	[self alignControls];
}
-(void) didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) alignControls {
	[Common doEvents];
	bool isPortrait = ([UIDevice currentDevice].orientation != UIInterfaceOrientationLandscapeLeft && [UIDevice currentDevice].orientation != UIInterfaceOrientationLandscapeRight);

	CGRect rect = _txtNote.frame;

	if(_barEdit.hidden)
	{
		rect = self.view.frame;
	}
	else
	{
		rect.size.height = self.view.frame.size.height - _barEdit.frame.size.height;
		rect.origin.y = _barEdit.frame.size.height;
	}

	if(isPortrait)
	{
		if(isKeyboardPresent)
			rect.size.height -= 216;
	}
	else
	{
		if(isKeyboardPresent)
			rect.size.height -= 162;

	}


	_txtNote.frame = rect;


}
/*
#pragma mark -
- (void)textViewDidBeginEditing:(UITextView *)textView{
	
    [Common wl:@"Checkpoint #Begin edit"];
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    [Common wl:@"Checkpoint #End edit"];
}
*/
#pragma mark - Button actions
- (IBAction)btnEdit_Clicked:(id)sender{
	[Common setEditMode:ENUM_WRITE];
    [self.navigationController setNavigationBarHidden:YES animated:false];
    _barEdit.frame = CGRectMake(0, 0, self.navigationController.navigationBar.frame.size.width, self.navigationController.navigationBar.frame.size.height);

	//[self.mainView addSubview: _barEdit];
	_barEdit.hidden = false;

	_txtNote.editable = true;
    [_txtNote becomeFirstResponder];
}
- (IBAction)btnDone_Clicked:(id)sender{
    _txtNote.editable = false;
	Common.activeNote.Text = _txtNote.text;
	[Common.activeNote save];
	[Common setEditMode:ENUM_READ];

    //[self.barEdit removeFromSuperview];

	self.barEdit.hidden = true;
    [self.navigationController setNavigationBarHidden:false animated:NO];
	isKeyboardPresent = false;
	[self alignControls];
}
- (IBAction)btnLock_Clicked:(id)sender{
    [Common mbox:@"Under construction" : @"Lock note"];
}
- (IBAction)btnCalc_Clicked:(id)sender{
	[Common wlCGRect:@"txtNote.frame" frame:_txtNote.frame];
}

#pragma mark - Send mail
- (IBAction)btnMail_Clicked:(id)sender{
    MFMailComposeViewController *mView = [[MFMailComposeViewController alloc] init];
	mView.mailComposeDelegate = self;
	[mView setSubject: [NSString stringWithFormat:@"NotesKeeper - %@", Common.activeNote.noteName]];
	[mView setMessageBody: _txtNote.text isHTML:NO];
	[self presentViewController:mView animated:true completion:nil];
}
-(void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{

	if(result == MFMailComposeResultSent)
		[Common mbox:@"successfully sent":@"Mail"];

	[self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark -
//****************************************************************************
@end
