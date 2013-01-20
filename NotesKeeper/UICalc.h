//
//  UICalc.h
//  NotesKeeper
//
//  Created by Stan Buran on 07/01/13.
//  Copyright (c) 2013 apoidea. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICalc : UIView
	@property UITextField *txtDisplay;
	-(void) resetData: (BOOL) resetText;
	-(void) rearrangeControls : (BOOL) isPortrait;
@end
