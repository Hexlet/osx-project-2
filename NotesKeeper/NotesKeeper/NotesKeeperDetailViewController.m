//
//  NotesKeeperDetailViewController.m
//  NotesKeeper
//
//  Created by Stan Buran on 11/20/12.
//  Copyright (c) 2012 apoidea. All rights reserved.
//

#import "NotesKeeperDetailViewController.h"
#include "Common.h"

@interface NotesKeeperDetailViewController ()
{
    //CGRect kbrdRect;
}
@end
@implementation NotesKeeperDetailViewController


#pragma mark - Managing the detail item

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    
    UIImage *image = [UIImage imageNamed: @"NoteBackground.png"];
    UIColor *color = [UIColor colorWithPatternImage:image];
    [self.txtNote setBackgroundColor:color];
    _txtNote.editable = false;

}
-(void) keyboardWasShown: (NSNotification *) notification
{
    CGSize kbrdSize = [[[notification userInfo] objectForKey: UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    CGRect frame = _txtNote.frame;
    frame.size.height -= kbrdSize.height;
    _txtNote.frame = frame;
    [_txtNote setNeedsDisplay];    
}


-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.navigationController setToolbarHidden:YES animated:YES];
    
    switch(Common.EditMode)
	{
		case ENUM_READ:
			break;
		case ENUM_WRITE:
			//[_btnEdit performSelector: @selector(btnEdit_Clicked)];
			[self btnEdit_Clicked:nil];
			break;
		case ENUM_CALC:
			break;
		case ENUM_RATE:
			break;
		default:
			break;
	}

}
-(void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    
    if(_barEdit.superview)
    {

        CGRect frame = CGRectMake(0, 0, self.navigationController.navigationBar.frame.size.width, self.navigationController.navigationBar.frame.size.height);
        [_barEdit setFrame:frame];
        
        [Common doEvents];
        
        frame = _mainView.frame;
        frame.size.height -= _barEdit.frame.size.height;
        frame.origin.y = _barEdit.frame.size.height;
        _txtNote.frame = frame;
       [Common wl: @"checkpoint0"];
    }
    else
    {
        _txtNote.frame = _mainView.frame;
        [Common wl: @"checkpoint1"];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//*********************************************************************************************************************************************************************************************************************
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [Common wl:@"Checkpoint #Begin edit"];
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    [Common wl:@"Checkpoint #End edit"];
}

#pragma mark - Button actions
- (IBAction) btnEdit_Clicked:(id)sender
{
	[Common setEditMode:ENUM_WRITE];
    [self.navigationController setNavigationBarHidden:YES animated:false];
    
    _barEdit.frame = CGRectMake(0, 0, self.navigationController.navigationBar.frame.size.width, self.navigationController.navigationBar.frame.size.height);
    //CGRectMake(0,0,_barEdit.frame.size.width, _barEdit.frame.size.height);
    [self.mainView addSubview: _barEdit];

    [Common doEvents];
   
    CGRect frame = _mainView.frame;
    frame.size.height -= frame.origin.y = _barEdit.frame.size.height;
    _txtNote.frame = frame;
    
    _txtNote.editable = true;
    [_txtNote becomeFirstResponder];

}
- (IBAction)btnDone_Clicked:(id)sender
{
	[Common setEditMode:ENUM_READ];
    [self.barEdit removeFromSuperview];
    [self.navigationController setNavigationBarHidden:false animated:NO];
    
    _txtNote.editable = false;
}

- (IBAction)btnMail_Clicked:(id)sender
{
    [Common mbox:@"Under construction" : @"Send mail"];
}

- (IBAction)btnLock_Clicked:(id)sender
{
    [Common mbox:@"Under construction" : @"Lock note"];
}

- (IBAction)btnCalc_Clicked:(id)sender
{
    [Common mbox:@"Under construction" : @"Show calculator"];
}


@end
