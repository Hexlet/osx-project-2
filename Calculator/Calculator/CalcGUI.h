//
//  CalcGUI.h
//  Calculator
//
//  Created by Alexander Shvets on 03.12.12.
//  Copyright (c) 2012 Alexander Shvets. All rights reserved.
//

#define BTN_TYPE_NUM 0
#define BTN_TYPE_OPERATION 1
#define BTN_TYPE_MEMORY 2
#define BTN_TYPE_RESET 3
#define BTN_TYPE_RESULT 4
#define BTN_TYPE_DEL 5

#define MENU_ITEM_SAVE_LOG 1000
#define MENU_ITEM_PRINT_LOG 1001
#define MENU_ITEM_CLEAR_LOG 1002
#define MENU_ITEM_TOGGLE_LOG 1003

#define WIN_TITLE_BAR_HEIGHT 20
#define WIN_HEIGHT 530
#define WIN_WIDTH_MIN 374
#define WIN_WIDTH_MAX 650


#import <Foundation/Foundation.h>

@interface CalcGUI : NSObject <NSXMLParserDelegate, NSWindowDelegate>
{
    CalcGUI* _self;
    
    NSWindow* window;
    NSNumberFormatter* enUsNumberFormatter;
    
    NSTextField* lcdMain;
    NSTextField* lcdMemory;
    NSTextField* lcdOperand;
    
    NSTextView* log;
    
    NSMutableArray* calcButtons;
    NSSize buttonSize;
    NSSize buttonGap;
    
    double total;
    double operand;
    NSString* operation;
    NSString* prevOperation;
    BOOL isTyping;
    
    double memory;
    BOOL memoryRestored;
}


-(id) initWithWindow:(NSWindow*)win;
-(void) setupWindow;

-(void) createCalculator;

-(void) appendLcdToView:(NSView*)view;
-(void) updateLcdMain:(NSString*)val;
-(void) updateLcdOperand:(NSString*)val andOperation:(NSString*)op;
-(void) updateLcdMemory:(NSString*)val;

-(void) appendButtonsToView:(NSView*)view;
-(void) buttonPress:(id)sender;
-(void) performOperation:(NSString*)op;

-(void) createLog;
-(void) logInsertString:(NSString*)string;
-(void) logInsertSeparator;
-(void) updateScrollView;
-(void) clearLog:(id)sender;
-(void) saveLog:(id)sender;
-(void) printLog:(id)sender;

-(double) numberFromStringLocalized:(NSString*)string;
-(NSString*) stringFromNumberLocalized:(double)number;

-(void) createMainMenu;
-(void) menuAction:(id)sender;

@end
