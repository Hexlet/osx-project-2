//
//  UICalc.m
//  NotesKeeper
//
//  Created by Stan Buran on 07/01/13.
//  Copyright (c) 2013 apoidea. All rights reserved.
//

#import "UICalc.h"

@interface UICalc()


@property int curAction;
@property int prevAction;
@property NSString *priVal;
@property NSString *secVal;
@property NSString *preVal;
@end

@implementation UICalc
-(id) init{
	self = [super init];
	if(self)
		[self initialize];
	return self;
}
-(void) initialize{
	[self setBackgroundColor: [UIColor colorWithPatternImage: [UIImage imageNamed: @"kbPattern01.png"]]];

	//txtDisplay:
	_txtDisplay = [[UITextField alloc] init];
	_txtDisplay.userInteractionEnabled = false;
	[_txtDisplay setBorderStyle:UITextBorderStyleRoundedRect];
	_txtDisplay.adjustsFontSizeToFitWidth = true;
	_txtDisplay.minimumFontSize = 10;
	//_txtDisplay addObserver:self forKeyPath:@selector(txtDisplay_Clicked:) options:NSKeyV context:<#(void *)#>

	[self addSubview:_txtDisplay];
	[self resetData:true];
	//Digits:
	for (int i = 0; i < 19; i++)
	{
		UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		btn.tag = i;

		switch (i)
		{
			case 10:
				[btn setTitle:@"・" forState:UIControlStateNormal];
				break;
			case 11:
				[btn setTitle:@"±" forState:UIControlStateNormal];
				break;
			case 12:
				[btn setTitle:@"C" forState:UIControlStateNormal];
				break;
			case 13:
				[btn setTitle:@"➗" forState:UIControlStateNormal];
				break;
			case 14:
				[btn setTitle:@"✖" forState:UIControlStateNormal];
				break;
			case 15:
				[btn setTitle:@"➖" forState:UIControlStateNormal];
				break;
			case 16:
				[btn setTitle:@"➕" forState:UIControlStateNormal];
				break;
			case 17:
				[btn setTitle:@"🔙" forState:UIControlStateNormal];
				break;
			case 18:
				[btn setTitle:@"=" forState:UIControlStateNormal];
				break;
			default:
				[btn setTitle: [NSString stringWithFormat:@"%i", i] forState:UIControlStateNormal];
				break;
		}

		[btn addTarget:self action:@selector(button_Clicked:) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:btn];
	}
}
-(void) dealloc{
	for (UIButton *btn in [self subviews])
	{
		if([btn isKindOfClass:[UIButton class]])
		   [btn removeTarget:self action:@selector(button_Clicked:) forControlEvents:UIControlEventTouchUpInside];
	}
}
-(void) rearrangeControls : (BOOL) isPortrait{
	self.frame = CGRectMake(0, self.frame.origin.y, self.frame.size.width, (isPortrait ? 260 : 162));

	float *x, *y;
	if(isPortrait)
	{
		x = (float*) malloc(4 * sizeof(float));
		x[0]=10; x[1]=85.3; x[2]=162; x[3]=237.3;

		y = (float*) malloc(6 * sizeof(float));
		y[0]=2; y[1]=48.4; y[2]=89.9; y[3]=131.9; y[4]=174.1; y[5]=216.9;
	}
	else
	{
		x = (float*) malloc(7 * sizeof(float));
		x[0] = 008.0;	x[1] = 078.7;	x[2] = 148.7;	x[3] = 218.7;	x[4] = 288.7;	x[5] = 358.7;	x[6] = 428.7;

		y = (float*) malloc(4 * sizeof(float));
		y[0]=3.8; y[1]=51.6; y[2]=86.2; y[3]=120.9;
	}

	_txtDisplay.frame = isPortrait ? CGRectMake(10,2,299.1,44) : CGRectMake(8,3.8,464.1,44);
	_txtDisplay.font = [_txtDisplay.font fontWithSize:36];
	[_txtDisplay setTextAlignment: NSTextAlignmentRight];
	for (UIButton *btn in [self subviews])
	{
		if(![btn isKindOfClass:[UIButton class]])
			continue;

		CGRect btnFrame = CGRectMake(0, 0, isPortrait ? 72.7 : 66.1, isPortrait ? 38.7 : 32); //ByDef
		switch (btn.tag)
		{
			case 0:
				btnFrame.origin = isPortrait ? CGPointMake(x[1], y[5]) : CGPointMake(x[0], y[3]);
				break;
			case 1:
				btnFrame.origin = isPortrait ? CGPointMake(x[0], y[4]) : CGPointMake(x[1], y[3]);
				break;
			case 2:
				btnFrame.origin = isPortrait ? CGPointMake(x[1], y[4]) : CGPointMake(x[2], y[3]);
				break;
			case 3:
				btnFrame.origin = isPortrait ? CGPointMake(x[2], y[4]) : CGPointMake(x[3], y[3]);
				break;
			case 4:
				btnFrame.origin = isPortrait ? CGPointMake(x[0], y[3]) : CGPointMake(x[1], y[2]);
				break;
			case 5:
				btnFrame.origin = isPortrait ? CGPointMake(x[1], y[3]) : CGPointMake(x[2], y[2]);
				break;
			case 6:
				btnFrame.origin = isPortrait ? CGPointMake(x[2], y[3]) : CGPointMake(x[3], y[2]);
				break;
			case 7:
				btnFrame.origin = isPortrait ? CGPointMake(x[0], y[2]) : CGPointMake(x[1], y[1]);
				break;
			case 8:
				btnFrame.origin = isPortrait ? CGPointMake(x[1], y[2]) : CGPointMake(x[2], y[1]);
				break;
			case 9:
				btnFrame.origin = isPortrait ? CGPointMake(x[2], y[2]) : CGPointMake(x[3], y[1]);
				break;
			case 10:
				btnFrame.origin = isPortrait ? CGPointMake(x[2], y[5]) : CGPointMake(x[0], y[2]);
				break;
			case 11:
				btnFrame.origin = isPortrait ? CGPointMake(x[0], y[5]) : CGPointMake(x[0], y[1]);
				break;
			case 12:
				btnFrame.origin = isPortrait ? CGPointMake(x[0], y[1]) : CGPointMake(x[5], y[1]);
				break;
			case 13:
				btnFrame.origin = isPortrait ? CGPointMake(x[1], y[1]) : CGPointMake(x[5], y[3]);
				break;
			case 14:
				btnFrame.origin = isPortrait ? CGPointMake(x[2], y[1]) : CGPointMake(x[5], y[2]);
				break;
			case 15:
				btnFrame.origin = isPortrait ? CGPointMake(x[3], y[2]) : CGPointMake(x[4], y[3]);
				break;
			case 16:
				btnFrame.origin = isPortrait ? CGPointMake(x[3], y[3]) : CGPointMake(x[4], y[2]);
				break;
			case 17:
				btnFrame.origin = isPortrait ? CGPointMake(x[3], y[1]) : CGPointMake(x[4], y[1]);
				break;
			case 18:
				btnFrame.size = isPortrait ? CGSizeMake(72.7,81.5) : CGSizeMake(42,101.7);
				btnFrame.origin = isPortrait ? CGPointMake(x[3], y[4]) : CGPointMake(x[6], y[1]);
				break;
			default:
				//btnFrame.origin = isPortrait ? CGPointMake(x[], y[]) : CGPointMake(x[], y[]);
				[btn removeFromSuperview];
				continue;
		}
		btn.frame = btnFrame;
	}

	free(x);
	free(y);
}
-(void) button_Clicked: (UIButton *) sender{
	NSString *sVal;
	switch  (sender.tag)
	{
		case 0:
		case 1:
		case 2:
		case 3:
		case 4:
		case 5:
		case 6:
		case 7:
		case 8:
		case 9: //digit
			sVal = [self noActions] ? _priVal : _secVal;
			if(sVal.length == 0)
				sVal = @"0";

			sVal = [sVal stringByAppendingFormat:@"%i", sender.tag];

			if(sVal.length > 1 && [sVal hasPrefix:@"0"] && ![sVal hasPrefix:@"0."])
				sVal = [sVal substringFromIndex:1];
			else if (sVal.length > 2 && [sVal hasPrefix: @"-0"] && ![sVal hasPrefix:@"-0."])
				sVal = [NSString stringWithFormat:@"-%@", [sVal substringFromIndex:2]];

			if([self noActions])
				_priVal =  sVal;
			else
				_secVal = sVal;

			[_txtDisplay setText:sVal];
			break;
		case 10: //dot
			sVal = [self noActions] ? _priVal : _secVal;
			if(sVal.length == 0)
				sVal = @"0";

			if([sVal rangeOfString:@"."].length == 0)
			{
				sVal = [sVal stringByAppendingString:@"."];
				if([self noActions])
					_priVal = sVal;
				else
					_secVal = sVal;
				[_txtDisplay setText:sVal];
			}
			break;
		case 11: //negative
			sVal = [self noActions] ? _priVal : _secVal;

			if(sVal.length == 0)
				sVal = @"0";


			if([sVal hasPrefix:@"-"])
				sVal = [sVal substringFromIndex:1];
			else
				sVal = [NSString stringWithFormat:@"-%@", sVal];

			if([self noActions])
				_priVal = sVal;
			else
				_secVal = sVal;

			_txtDisplay.text = sVal;
			break;
		case 12: //Clear
			[self resetData:true];
			break;
		case 17: //back
			sVal = [self noActions] ? _priVal : _secVal;

			if(sVal.length == 0)
			{
				[self resetData:true];
				return;
			}

			sVal = [sVal substringToIndex:sVal.length -1];

			if(sVal.length == 0 || [sVal isEqualToString:@"-"])
				sVal = @"0";

			if([self noActions])
				_priVal = sVal;
			else
				_secVal = sVal;

			_txtDisplay.text = sVal;
			break;
		case 13:
		case 14:
		case 15:
		case 16:
			if(_curAction < 0)
			{
				_curAction = sender.tag;

				if(_secVal.length > 0)
					[self calculate];
			}
			else
			{
				if(_secVal.length > 0)
					[self calculate];

				_curAction = sender.tag;
			}
			break;
		case 18:
			[self calculate];
		default:
			break;
	}
}
-(bool) noActions{
	return (_curAction < 0 && _prevAction < 0);
}
-(void) resetData: (BOOL) resetText{
	if(resetText)
		_txtDisplay.text = @"0";


	_priVal = @"0";
	_secVal = @"";
	_preVal = @"0";
	_curAction = -1;
	_prevAction = -1;
}
-(void) calculate{
	if([self noActions])
		return;

	double val1 = _priVal.doubleValue;
	double val2;

	int op;
	if(_curAction < 0 || _secVal.length == 0)
	{
		op = _prevAction;
		val2 = _preVal.doubleValue;
	}
	else
	{
		op = _curAction;
		val2 = _secVal.doubleValue;
	}

	if(op < 0)
		return;

	_priVal = [self parse:val1 secValue:val2 Action:op];

	while ([_priVal rangeOfString:@"."].length > 0 && [_priVal hasSuffix:@"0"])
		_priVal = [_priVal substringToIndex: _priVal.length -1];

	if([_priVal hasSuffix:@"."])
		_priVal = [_priVal substringToIndex: _priVal.length -1];

	if(_priVal.length == 0 || [_priVal isEqualToString:@"-"])
		_priVal = @"0";

	[_txtDisplay setText: _priVal];


	if(_curAction > 0 && _secVal.length > 0)
	{
		_prevAction = _curAction;
		_curAction = -1;
		_preVal = [NSString stringWithFormat: @"%f", val2];
		_secVal = @"";
	}
}
-(NSString *) parse: (double) val1 secValue : (double) val2 Action: (int) action{
	NSString *resVal;

	@try {
		switch (action)
		{
			case 13:
				resVal = [NSString stringWithFormat:@"%f", val1/val2 ];
				break;
			case 14:
				resVal = [NSString stringWithFormat:@"%f", val1 * val2];
				break;
			case 15:
				resVal = [NSString stringWithFormat:@"%f", val1 - val2];
				break;
			case 16:
                resVal = [NSString stringWithFormat:@"%f", val1 + val2];
				break;
			default:
				return @"No value";
		}
	}
	@catch (NSException *ex)
	{
		resVal = ex.description;
	}
	return resVal;
}
@end
