/*
//  ExchangeViewController.m
//  NotesKeeper
//
//  Created by Stan Buran on 11/21/12.
//  Copyright (c) 2012 apoidea. All rights reserved.
*/
#import "ExchangeViewController.h"
#import "Common.h"
#import "CurrencyView.h"
#import "ApplicationSettings.h"

@interface ExchangeViewController ()
@end

@implementation ExchangeViewController
NSMutableArray *currencyCodes;
NSMutableDictionary *dicRates;
NSDictionary *dicCurrDescr;
BOOL isSynchronizing;

#pragma mark - Main view managing methods:
-(void) viewDidLoad {
    [super viewDidLoad];
	_picker.showsSelectionIndicator = YES;
	currencyCodes = [[NSMutableArray alloc]init];
	isSynchronizing = false;
	dicRates = [[NSMutableDictionary alloc] init];

	dicCurrDescr = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"CurrencyDescr" ofType:@"plist"]];

    /*
	_lblUpdate.text = @"";
	_lblRateLeft.text = @"";
	_lblRateRight.text = @"";
	_txtRateRight.text = @"";
	_rateLeft = 0;
	_rateRight = 0;
    */
    
	_keyBar.hidden = true;


	[self loadData];
	[self performSelectorInBackground:@selector(syncData:) withObject: [NSNumber numberWithBool:false]];
}
-(void) viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardDidShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.navigationController setToolbarHidden:YES animated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
	[Common doEvents];
	[self alignControls];

}
-(void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) viewWillDisappear:(BOOL)animated{
	[super viewWillDisappear:animated];
	[[NSNotificationCenter defaultCenter] removeObserver: self name:UIKeyboardDidShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
-(void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
	[super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
	[self alignControls];
}
-(void) alignControls{

	bool isPortrait = ([UIDevice currentDevice].orientation == UIDeviceOrientationPortrait || [UIDevice currentDevice].orientation == UIDeviceOrientationUnknown);

	_lblHeader.hidden = !isPortrait;
	_lblBankname.hidden = !isPortrait;
	_lblColon.hidden = !isPortrait;
	_lblRateLeft.hidden = !isPortrait;
	_lblRateRight.hidden = !isPortrait;

	float fWidth = isPortrait ? 127 : 150;
	float xVal = _txtRateRight.superview.frame.size.width - 20 - fWidth;

	if (isPortrait)
	{
		[_txtRateLeft setFrame:CGRectMake(20, 90, 127, 30)];
		[_txtRateRight setFrame: CGRectMake(xVal, 90, 127, 30)];
		[_lblUpdate setFrame:CGRectMake(0, 129, self.view.frame.size.width, 21)];
		_indicator.frame = CGRectMake(([UIScreen mainScreen].applicationFrame.size.width / 2) - 10, 59, 20, 20);
	}
	else
	{
		float sWidth = (self.view.frame.size.width);
		[_txtRateLeft setFrame: CGRectMake(20, 5, fWidth, 30)];
		[_txtRateRight setFrame: CGRectMake(xVal, 5, fWidth, 30)];
		[_lblUpdate setFrame:CGRectMake((sWidth/2) - 65, 5, 130, 30)];
		_indicator.frame = CGRectMake((sWidth/2) - 10, 30, 20, 20);
	}
}

#pragma mark - User interactions:
-(IBAction)btnReload:(id)sender {
	if(!isSynchronizing) [self performSelectorInBackground:@selector(syncData:) withObject: [NSNumber numberWithBool:true]];
}
-(void) startIndicator{[_indicator startAnimating];}
-(void) stopIndicator{[_indicator stopAnimating];}

#pragma mark - Keyboard events:
-(void) keyboardWillShow: (NSNotification *) notification {
	bool isPortrait = ([UIDevice currentDevice].orientation == UIDeviceOrientationPortrait || [UIDevice currentDevice].orientation == UIDeviceOrientationUnknown);
	_keyBar.hidden = false;

	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.3];
	//[UIView setAnimationCurve: UIViewAnimationOptionTransitionCurlUp];

	CGRect frame = self.keyBar.frame;
	if(isPortrait)
	{
		frame.size.height = 44;
		frame.origin.y = self.view.frame.size.height - 260;
	}
	else
	{
		frame.size.height = 55;
		frame.origin.y = self.view.frame.size.height - 217;
	}


	self.keyBar.frame = frame;

	[UIView commitAnimations];
}
-(void) keyboardWillHide: (NSNotification *) notification {
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.3];

	CGRect frame = self.keyBar.frame;
	frame.origin.y = self.view.frame.size.height;
	self.keyBar.frame = frame;

	[UIView commitAnimations];
	_keyBar.hidden = true;
}
-(IBAction)btnDone_Clicked:(id)sender {

	NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setDecimalSeparator:@"."];
	[formatter setPositiveFormat:([NSString stringWithFormat:@"###0.####"])];
	float fVal;

	if(_txtRateLeft.editing)
	{
		[_txtRateLeft resignFirstResponder];
		if(_txtRateLeft.text.length == 0)
			_txtRateLeft.text = @"0";
		else
			_txtRateLeft.text = [_txtRateLeft.text stringByReplacingOccurrencesOfString:@"," withString:@"."];

		fVal = [_txtRateLeft.text floatValue];
        [ApplicationSettings setRateLeft:[formatter stringFromNumber:[NSNumber numberWithFloat:fVal]]];
        [self calculate: (NSInteger) 1];
		[ApplicationSettings setComponent:1];
	}
	else if(_txtRateRight.editing)
	{
		[_txtRateRight resignFirstResponder];
		if(_txtRateRight.text.length == 0)
			_txtRateRight.text = @"0";
		else
			_txtRateRight.text = [_txtRateRight.text stringByReplacingOccurrencesOfString:@"," withString:@"."];

		fVal = [_txtRateRight.text floatValue];
		[ApplicationSettings setRateRight:[formatter stringFromNumber:[NSNumber numberWithFloat:fVal]]];

		[self calculate: (NSInteger) 0];
		[ApplicationSettings setComponent:0];
	}
}
-(void) textFieldDidBeginEditing:(UITextField *)textField{
	[textField selectAll:self];
}

#pragma mark - pickerView events:
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
	return 2;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
	return currencyCodes.count;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
	return [currencyCodes objectAtIndex:row];
}
-(UIView *) pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{

	NSString *code = [currencyCodes objectAtIndex:row];
	NSString *descr = [dicCurrDescr valueForKey:code];

	CGSize rowSize = [_picker rowSizeForComponent:component];
	//CGRect rect = CGRectMake(0,0, 200, 44);
	CGRect rect = CGRectMake(0,0, rowSize.width, rowSize.height);

	CurrencyView *curCell = [[CurrencyView alloc] initWithCurrency:code Description:descr Frame:rect];
	return curCell;
}
-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{

	NSString *code = [currencyCodes objectAtIndex:row];
	if(component == 0)
    {
		[ApplicationSettings setCurrLeft:code];
        [ApplicationSettings setRateLeft:[dicRates valueForKey:code]];
    }
	else
    {
		[ApplicationSettings setCurrRight:code];
        [ApplicationSettings setRateRight:[dicRates valueForKey:code]];
    }

	[self setCurrency:code forComponent:component];
	[self calculate:component];
	[ApplicationSettings setComponent:component];

}

#pragma mark - Data loading:
-(void) syncData: (NSNumber *) forceBoolNumber{
	bool force = [forceBoolNumber boolValue];

	isSynchronizing = true;
	[self performSelectorOnMainThread:@selector(startIndicator) withObject:nil waitUntilDone:NO];

	NSURL *url = [NSURL URLWithString: @"HTTP://WWW.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml"];
	NSString *dataFilePath = [[NSString alloc] initWithFormat: @"%@/data.xml",[Note getDocPath]];
	bool dataFileExists = [[NSFileManager defaultManager] fileExistsAtPath: dataFilePath];
	NSString *xml;

	if(!force && dataFileExists)
	{
		//check if modification date is today then stop synchronization:
		NSDate *modifDate = [[[NSFileManager defaultManager] attributesOfItemAtPath:dataFilePath error:nil] fileModificationDate];
		NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
		[dateFormat setDateFormat:@"yyyy-MM-dd"];
		NSString *strToday = [dateFormat stringFromDate:[NSDate date]];
		NSString *strModif = [dateFormat stringFromDate:modifDate];

		if([strModif isEqualToString:strToday])
			goto Backdoor;
	}

	//write xml string to file:
	xml = [[NSString alloc] initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
	if(!xml)
		goto Backdoor;

	if(dataFileExists)
		[[NSFileManager defaultManager] removeItemAtPath:dataFilePath error:nil];

	[xml writeToFile:dataFilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
	[self performSelectorOnMainThread:@selector(loadData) withObject:nil waitUntilDone:YES];

Backdoor:
	[self performSelectorOnMainThread:@selector(stopIndicator) withObject:nil waitUntilDone:YES];
	isSynchronizing = false;
}
-(void) loadData{
	[currencyCodes removeAllObjects];
	[dicRates removeAllObjects];
	NSString *sVal = [[NSString alloc] initWithFormat: @"%@/data.xml",[Note getDocPath]];

	if(![[NSFileManager defaultManager] fileExistsAtPath: sVal])
		return;

	sVal = [[NSString alloc] initWithData: [NSData dataWithContentsOfFile:sVal] encoding:NSUTF8StringEncoding];

	NSError *error = [[NSError alloc] init];
	NSDictionary *dic = [XMLReader dictionaryForXMLString:sVal options:XMLReaderOptionsResolveExternalEntities error:&error];

	//get time sample:
	NSString *updDate = [[[[dic objectForKey:@"gesmes:Envelope"] objectForKey:@"Cube"] objectForKey:@"Cube"] objectForKeyedSubscript:@"time"];

	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"yyyy-MM-dd"];
	NSDate *date = [dateFormatter dateFromString:updDate];

	[dateFormatter setDateFormat:@"MMM dd, yyyy"];
	updDate = [dateFormatter stringFromDate:date];

	_lblUpdate.text = [NSString stringWithFormat:@"Last updated: %@",updDate];

	NSArray *vals = [[[[dic objectForKey:@"gesmes:Envelope"] objectForKey:@"Cube"] objectForKey:@"Cube"] objectForKey:@"Cube"];

    [currencyCodes addObject:@"EUR"];
    [dicRates setValue:@"1.0" forKey:@"EUR"];
    
	for (int i = 0; i<vals.count; i++)
	{
		dic = [vals objectAtIndex:i];
		NSString *curr =  [dic objectForKey:@"currency"];
		NSString *rate = [dic objectForKey:@"rate"];
		[currencyCodes addObject:curr];
		[dicRates setValue:rate forKey:curr];
	}
    
	[_picker reloadAllComponents];


	//SET VALUES: *********************************************************************************************************************************************
	NSString *codeL = [ApplicationSettings getCurrCodeLeft];
	NSString *codeR = [ApplicationSettings getCurrCodeRight];

	if(codeL == @"" || codeR == @"")
		return;

	int rowL = [currencyCodes indexOfObject:codeL];
	int rowR = [currencyCodes indexOfObject:codeR];

	if(rowL == NSIntegerMax || rowR == NSIntegerMax)
		return;

    [_picker selectRow:rowL inComponent:0 animated:NO];
    [_picker selectRow:rowR inComponent:1 animated:NO];
    
	[self setCurrency:codeL forComponent:0];
	[self setCurrency:codeR forComponent:1];

	NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setDecimalSeparator:@"."];
	[formatter setPositiveFormat:([NSString stringWithFormat:@"###0.####"])];

	float fVal = [[ApplicationSettings getRateLeft] floatValue];
	_txtRateLeft.text = [formatter stringFromNumber:[NSNumber numberWithFloat:fVal]];
	fVal = [[ApplicationSettings getRateRight] floatValue];
	_txtRateRight.text = [formatter stringFromNumber:[NSNumber numberWithFloat:fVal]];


	[self calculate:[ApplicationSettings getComponent]];
}
-(void) setCurrency: (NSString *) code forComponent: (NSInteger) component{
	if(component == 0)
		_lblRateLeft.text = [dicCurrDescr valueForKey:code];
	else
		_lblRateRight.text = [dicCurrDescr valueForKey:code];
}
-(void) calculate: (NSInteger) component{
   
    float lRate = [[dicRates valueForKey: [currencyCodes objectAtIndex: [_picker selectedRowInComponent:0]]] floatValue];
    float rRate = [[dicRates valueForKey:[currencyCodes objectAtIndex:[_picker selectedRowInComponent:1]]]floatValue];
    float x, y;

	NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setDecimalSeparator:@"."];
	[formatter setPositiveFormat:([NSString stringWithFormat:@"###0.####"])];
    if(component == 0)
    {
        if(rRate > 0)
        {
            x = [_txtRateRight.text floatValue];
            y = x/rRate * lRate;
        }
        else
            y = 0;

		_txtRateLeft.text = [formatter stringFromNumber: [NSNumber numberWithFloat: y]];
		[ApplicationSettings setRateLeft:_txtRateLeft.text];
    }
    else
    {
        if(lRate > 0)
        {
            x = [_txtRateLeft.text floatValue];
            y = x/lRate * rRate;
        }
        else
            y = 0;
        
        _txtRateRight.text = [formatter stringFromNumber: [NSNumber numberWithFloat: y]];
		[ApplicationSettings setRateRight:_txtRateRight.text];
    }
}
@end
