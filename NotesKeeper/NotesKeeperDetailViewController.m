//
//  NotesKeeperDetailViewController.m
//  NotesKeeper
//
//  Created by Stan Buran on 11/20/12.
//  Copyright (c) 2012 apoidea. All rights reserved.
//

#import "NotesKeeperDetailViewController.h"
#import "Common.h"

@interface NotesKeeperDetailViewController()
	@property (atomic) UICalc *calc;
@end
@implementation NotesKeeperDetailViewController
bool isKeyboardPresent;
#pragma mark - Managing the detail item
- (void)viewDidLoad {
    [super viewDidLoad];
    self.barEdit.hidden = true;
	UIImage *image = [UIImage imageNamed: @"NoteBackground.png"];

    UIColor *color = [UIColor colorWithPatternImage:image];
    [self.txtNote setBackgroundColor:color];
	[Common.activeNote loadNoteText];
	_txtNote.text = Common.activeNote.Text;
    _txtNote.editable = false;
	isKeyboardPresent = false;
}
-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.navigationController setToolbarHidden:YES animated:YES];

	_btnEdit.title = Common.activeNote.isLocked ? @"🔐 Edit" : @" Edit ";

	_calc = [[UICalc alloc] init];
	[self.view addSubview: _calc];

    switch(Common.EditMode)
	{
		case ENUM_WRITE:
		    [self.navigationController setNavigationBarHidden:YES animated:YES];
			[_calc setHidden:YES];
			[self btnEdit_Clicked:self];
			break;
		case ENUM_CALC:
		    [self.navigationController setNavigationBarHidden:YES animated:YES];
			[_calc setHidden:NO];
			break;
		default:
			[_calc setHidden:YES];
			break;
	}
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
-(void) viewWillDisappear:(BOOL)animated{
	[super viewWillDisappear:animated];
	[_calc removeFromSuperview];
	_calc = nil;
}
#pragma mark - Send mail
-(IBAction)btnMail_Clicked:(id)sender{
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

-(void) alignControls {
	[Common doEvents];

	bool isPortrait = ([UIDevice currentDevice].orientation == UIDeviceOrientationPortrait || [UIDevice currentDevice].orientation == UIDeviceOrientationUnknown);

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

	if(isKeyboardPresent)
		rect.size.height -= isPortrait ? 216 : 162;
	else if (!_calc.hidden)
	{
		rect.size.height -= isPortrait ? 260 : 162;
		_calc.frame = CGRectMake(0, rect.origin.y + rect.size.height, rect.size.width, _calc.frame.size.height);
		[_calc rearrangeControls: isPortrait];
	}
	_txtNote.frame = rect;
}
#pragma mark - Button actions
-(void) btnEdit_SetCalc:(BOOL) isVisible{

	if(isVisible)
	{
		[_btnAction setTitle:@"Copy"];
		[_btnCalc setTitle: @"Text"];
	}
	else
	{
		_btnAction.title = Common.activeNote.isLocked ? @" 🔒 " : @" 🔓 ";



		[_btnCalc setTitle: @"Calc"]; //Calculator ∑"];
	}

}
-(IBAction)btnAction_Clicked:(id)sender {
}
-(IBAction)btnEdit_Clicked:(id)sender{

	[Common setEditMode:ENUM_WRITE];
    _barEdit.frame = CGRectMake(0, 0, self.navigationController.navigationBar.frame.size.width, self.navigationController.navigationBar.frame.size.height);
    [self.navigationController setNavigationBarHidden:YES animated:YES];

	_barEdit.hidden = false;

	//Show keyboard:
	_txtNote.editable = true;
    [_txtNote becomeFirstResponder];
	isKeyboardPresent = true;

	[self alignControls];
	[self btnEdit_SetCalc:NO];
	[_calc resetData: true];
}
-(IBAction)btnDone_Clicked:(id)sender{

	if(!_calc.hidden)
		[_calc setHidden:YES];

	//hide keyboard:
	[_txtNote resignFirstResponder];
    _txtNote.editable = false;
	isKeyboardPresent = false;
	self.barEdit.hidden = true;
    [self.navigationController setNavigationBarHidden:false animated:YES];
	Common.activeNote.Text = _txtNote.text;
	[Common.activeNote save];
	[Common setEditMode:ENUM_READ];
	[_btnEdit setTitle: Common.activeNote.isLocked ? @"🔐 Edit" : @" Edit " ];
	[self alignControls];

	[self.navigationController popToRootViewControllerAnimated:YES];
}
-(IBAction)btnCalc_Clicked:(id)sender{
	if(_calc.hidden)
	{
		[_calc setHidden:NO];
		_txtNote.editable = false;
		[_txtNote resignFirstResponder];
		isKeyboardPresent = false;
		[Common setEditMode:ENUM_CALC];

		[self btnEdit_SetCalc:YES];
	}
	else
	{
		[_calc setHidden:YES];
		_txtNote.editable = true;
	    [_txtNote becomeFirstResponder];
		isKeyboardPresent = true;
		[Common setEditMode:ENUM_WRITE];
		[self btnEdit_SetCalc:NO];
	}
	[self alignControls];
}
-(IBAction)btnLock_Clicked:(id)sender{
	UIAlertView *achtung = [UIAlertView alloc];
	if(Common.EditMode == ENUM_CALC)
	{
		achtung = [achtung initWithTitle:@"Calculator" message:_calc.txtDisplay.text delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles: @"Copy", @"Insert", nil];
		achtung.tag = 1;
		[achtung show];
	}
	else
	{

		if(Common.activeNote.isLocked)
		{
			achtung = [achtung initWithTitle:@"Unlock note"
									 message:@"Do you want to remove protection?"
									delegate:self
						   cancelButtonTitle:@"No"
						   otherButtonTitles:@"Yes", nil];
			achtung.tag = 2;
			[achtung show];
		}
		else
		{
			achtung = [[UIAlertView alloc] initWithTitle:@"Lock note" message:@"Enter password" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Apply", nil];
			[achtung setAlertViewStyle:UIAlertViewStylePlainTextInput];
			achtung.tag = 3;
			[achtung show];
		}

	}
}
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	switch (alertView.tag) {
		case 1: //Copy calc value
			if(buttonIndex == 1)
				[UIPasteboard generalPasteboard].string = _calc.txtDisplay.text;
			else if(buttonIndex == 2)
			{
				[self btnCalc_Clicked:self];
				[_txtNote insertText:_calc.txtDisplay.text];
			}
			break;
		case 2:
			if(buttonIndex == 1)
				[Common.activeNote setSecret:@""];
			
			_btnAction.title = Common.activeNote.isLocked ? @" 🔒 " : @" 🔓 ";
			break;
		case 3:
			if(buttonIndex == 1)
				[Common.activeNote setSecret:[[alertView textFieldAtIndex:0] text]];

			_btnAction.title = Common.activeNote.isLocked ? @" 🔒 " : @" 🔓 ";
			break;
		default:
			NSLog(@"tag%i.buttonIndex: %i", alertView.tag, buttonIndex);
			break;
	}
}
@end
