//
//  CalcGUI.m
//  Calculator
//
//  Created by Alexander Shvets on 03.12.12.
//  Copyright (c) 2012 Alexander Shvets. All rights reserved.
//

#import "CalcGUI.h"
#import "CalcView.h"
#import "NSButton+ButtonTextColor.h"
#import "PointingHandButton.h"
#import "CustomFontLoader.h"
#import "DigitsOnlyFormatter.h"

@implementation CalcGUI

-(id) initWithWindow:(NSWindow *)win
{
    if(self = [super init]){
        window = win;
        calcButtons = [[NSMutableArray alloc] init];
        
        NSLocale* enUsLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        enUsNumberFormatter = [[NSNumberFormatter alloc] init];
        [enUsNumberFormatter setLocale:enUsLocale];
        [enUsNumberFormatter setNumberStyle:NSNumberFormatterScientificStyle];
        
        operation = nil;
        prevOperation = nil;
        total = 0;
        operand = 0;
        memory = 0;
        memoryRestored = NO;
        isTyping = NO;
        
        _self = self;
        
        [self setupWindow];
        [self createMainMenu];
    }
    return self;
}


-(void) createCalculator
{
    //create custom calculator NSView
    NSRect viewSize = {0, 0, 374, WIN_HEIGHT};
    CalcView* calcView = [[CalcView alloc] initWithFrame:viewSize andShadow:YES];
    NSColor* bgColor = [NSColor colorWithPatternImage:[NSImage imageNamed:@"bg-calc.png"]];
    [calcView setColor:bgColor];
    
    [[window contentView] addSubview:calcView];
    
    //create LCD
    [self appendLcdToView:calcView];    
    
    //add buttons
    [self appendButtonsToView:calcView];
    
    //add log
    [self createLog];
}


-(void) setupWindow
{
    [window setTitle:@"HexletCalc"];
    [window setFrame:NSMakeRect(0, 0, WIN_WIDTH_MAX, WIN_HEIGHT+WIN_TITLE_BAR_HEIGHT) display:YES];
    [window center];
    
    CGSize minSize = {WIN_WIDTH_MIN, WIN_HEIGHT+WIN_TITLE_BAR_HEIGHT};
    CGSize maxSize = {WIN_WIDTH_MAX, WIN_HEIGHT+WIN_TITLE_BAR_HEIGHT};
    [window setMinSize:minSize];
    [window setMaxSize:maxSize];
    [window setShowsResizeIndicator:NO];
    [window setDelegate:self];
    
    [window setBackgroundColor:[NSColor colorWithPatternImage:[NSImage imageNamed:@"bg-desk.png"]]];
    [window setMovableByWindowBackground:YES];
}

-(BOOL)windowShouldZoom:(NSWindow *)win toFrame:(NSRect)newFrame
{
    NSRect windowFrame = [win frame];
    
    if([win isZoomed]){
        windowFrame.size = [win minSize];
    } else {
        windowFrame.size = [win maxSize];
    }
    
    [win setFrame:windowFrame display:YES animate:YES];
    return NO;
}


-(void) appendLcdToView:(NSView*) view
{
    [CustomFontLoader loadFont:@"lcddot_tr.ttf"];
    NSFont* lcdFont = [NSFont fontWithName:@"LCDDot-TR" size:77];
    NSFont* lcdFontSmall = [NSFont fontWithName:@"LCDDot-TR" size:28];
    
    NSColor* lcdTextColor = [NSColor colorWithDeviceRed:52/255 green:56/255 blue:43/255 alpha:.8];
    
    //LCD screen
    NSRect viewSize = NSMakeRect(12, 15, 348, 110);
    CalcView* lcdView = [[CalcView alloc] initWithFrame:viewSize andShadow:NO];
    NSColor* bgColor = [NSColor colorWithPatternImage:[NSImage imageNamed:@"bg-lcd.png"]];
    [lcdView setColor:bgColor];
    
    [view addSubview:lcdView];
    
    
    // main LCD string
    lcdMain = [[NSTextField alloc] initWithFrame:NSMakeRect(10, 30, 330, 50)];
    [lcdMain setTextColor:lcdTextColor];
    [lcdMain setBezeled:NO];
    [lcdMain setFocusRingType:NSFocusRingTypeNone];
    [lcdMain setDrawsBackground:NO];
    
    DigitsOnlyFormatter *digitsFormatter = [[DigitsOnlyFormatter alloc] init];
    [lcdMain setFormatter: digitsFormatter];
    
    [lcdMain setFont: lcdFont];
    [lcdMain setAlignment: NSRightTextAlignment];
    [lcdMain setIntValue:0];
    [lcdMain setEditable: NO];

    [lcdView addSubview:lcdMain];

    
    // memory string
    lcdMemory = [[NSTextField alloc] initWithFrame:NSMakeRect(15, 80, 200, 20)];
    [lcdMemory setTextColor:lcdTextColor];
    [lcdMemory setBezeled:NO];
    [lcdMemory setFocusRingType:NSFocusRingTypeNone];
    [lcdMemory setDrawsBackground:NO];
    
    [lcdMemory setFont: lcdFontSmall];
    [lcdMemory setStringValue:@"M"];
    
    [lcdMemory setSelectable: NO];
    [lcdMemory setEditable: NO];
    
    [lcdView addSubview:lcdMemory];
    
    
    // prev result string
    lcdOperand = [[NSTextField alloc] initWithFrame:NSMakeRect(10, 12, 325, 20)];
    [lcdOperand setTextColor:lcdTextColor];
    [lcdOperand setBezeled:NO];
    [lcdOperand setFocusRingType:NSFocusRingTypeNone];
    [lcdOperand setDrawsBackground:NO];
    
    [lcdOperand setFont: lcdFontSmall];
    [lcdOperand setAlignment: NSRightTextAlignment];
    [lcdOperand setStringValue:@""];
    
    [lcdOperand setSelectable: NO];
    [lcdOperand setEditable: NO];
    
    [lcdView addSubview:lcdOperand];
    
}


-(void) updateLcdMain:(NSString*)val
{
    [lcdMain setStringValue:val];
}

-(void) updateLcdOperand:(NSString*)val andOperation:(NSString*)op
{
    if([@"÷" isEqualToString:op]) op = @"/";
    if([@"–" isEqualToString:op]) op = @"-";
    [lcdOperand setStringValue:[NSString stringWithFormat:@"%@ %@", val, op]];
}

-(void) updateLcdMemory:(NSString*)val
{
    [lcdMemory setStringValue:[NSString stringWithFormat:@"M %@", val]];
}



-(void) appendButtonsToView:(NSView*) view
{
    //read layout from XML
    NSString* path = [[NSBundle mainBundle] pathForResource: @"buttons" ofType: @"xml"];
    NSData* data = [NSData dataWithContentsOfFile: path];
    NSXMLParser* parser = [[NSXMLParser alloc] initWithData: data];
    
    [parser setDelegate: self];
    if([parser parse]){
        
        NSArray* btnTypes = [[NSArray alloc] initWithObjects:@"num", @"operation", @"memory", @"reset", @"result", @"del", nil];
        
        NSFont* btnFont = [NSFont fontWithName:@"Calibri" size:24];
        
        //key codes
        UniChar enterKey = 0xd;
        UniChar deleteKey = 0x7f;
        UniChar escapeKey = 0x1b;
        
        NSPoint keyboardOrigin = NSMakePoint(10, 138);
        
        //draw buttons
        for(NSDictionary* btnItem in calcButtons){
            
            float x = [[btnItem valueForKey:@"x"] floatValue];
            float y = [[btnItem valueForKey:@"y"] floatValue];
            float btnX = x * buttonSize.width + (buttonGap.width * x) + keyboardOrigin.x;
            float btnY = y * buttonSize.height + (buttonGap.height * y) + keyboardOrigin.y;
            
            float width = [[btnItem valueForKey:@"width"] floatValue];
            float height = [[btnItem valueForKey:@"height"] floatValue];
            float btnWidth = buttonSize.width * width + (width * buttonGap.width);
            float btnHeight = buttonSize.height * height + (height * buttonGap.height);
                        
            NSButton *button = [[NSButton alloc] initWithFrame:NSMakeRect(btnX, btnY, btnWidth, btnHeight)];
            
            [button setTitle:[btnItem valueForKey:@"label"]];
            [button setButtonType: NSMomentaryPushButton];
            [button setBezelStyle: NSDisclosureBezelStyle];
            
            NSString *type = [btnItem valueForKey:@"type"];
            NSString *bgImage =[NSString stringWithFormat:@"btn-%@.png", type];
            if(width == 2 && [type isEqualTo: @"num"]) bgImage =[NSString stringWithFormat:@"btn-%@-double.png", type];
            [button setImage:[NSImage imageNamed:bgImage]];
            [button setImagePosition: NSImageOverlaps];

            [button setFont: btnFont];
            [button setTextColor:[NSColor whiteColor]];
            
            [button setTag: [btnTypes indexOfObject:type]];
            
            [button setTarget: _self];
            [button setAction: @selector(buttonPress:)];
            
            NSString *key = [btnItem valueForKey:@"key"];
            if([key length] == 1){
                [button setKeyEquivalent:key];
            } else {
                if([key isEqualTo:@"ENTER"]) [button setKeyEquivalent:[NSString stringWithCharacters:&enterKey length:1]];
                if([key isEqualTo:@"DELETE"]) [button setKeyEquivalent:[NSString stringWithCharacters:&deleteKey length:1]];
                if([key isEqualTo:@"ESCAPE"]) [button setKeyEquivalent:[NSString stringWithCharacters:&escapeKey length:1]];
            }
            
            [view addSubview:button];
        
        }
        
    } else {
        NSLog(@"XML parser error: %@", [parser parserError]);
    }
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
    
    if([elementName isEqualToString:@"buttons"]){
        
        buttonSize = NSMakeSize([[attributeDict valueForKey:@"width"] floatValue], [[attributeDict valueForKey:@"height"] floatValue]);
        buttonGap = NSMakeSize([[attributeDict valueForKey:@"gapX"] floatValue], [[attributeDict valueForKey:@"gapY"] floatValue]);
    }
    
    if([elementName isEqualToString:@"button"])
        [calcButtons addObject: [NSDictionary dictionaryWithDictionary:attributeDict]];
    
}


- (void) buttonPress:(id)sender
{
    int btnType = (int)[sender tag];
    NSString* btnVal = [sender title];
    
    if([btnVal isNotEqualTo:@"mrc"] && btnType != BTN_TYPE_OPERATION) memoryRestored = NO;
    
    switch(btnType){
        
        case BTN_TYPE_NUM:
            {
                if(!isTyping) [self updateLcdMain:@"0"];
                
                NSString* currentLcdVal = [lcdMain stringValue];
                if([currentLcdVal length] > 10) return;
                
                if([@"." isEqualToString:btnVal] && [currentLcdVal rangeOfString:@"." options:NSBackwardsSearch].length > 0) return;
                
                isTyping = YES;
                
                NSString* newValue = [currentLcdVal stringByAppendingString:btnVal];
                operand = [self numberFromStringLocalized:newValue];
                
                [self updateLcdMain:newValue];
            }
            break;
            
        case BTN_TYPE_OPERATION:
            {
                
                if([@"√" isEqualToString:btnVal]){
                    total = [self numberFromStringLocalized:[lcdMain stringValue]];
                    [self performOperation:btnVal];
                    return;
                }
                
                if([@"0" isEqualToString:[lcdMain stringValue]] && [@"–" isEqualToString:btnVal]){
                    [lcdMain setStringValue:@"-"];
                    isTyping = YES;
                    return;
                }
                
                prevOperation = operation;
                
                if(!operation){
                    total = [self numberFromStringLocalized:[lcdMain stringValue]];
                    
                    operation = btnVal;
                                        
                } else if(isTyping || memoryRestored){
                    
                    [self performOperation:operation];
                    operation = btnVal;
                
                } else {
                    
                    operation = btnVal;
                    
                }
                [self updateLcdOperand:[lcdMain stringValue] andOperation:btnVal];
                isTyping = NO;
                
                memoryRestored = NO;
            }
            break;
            
        case BTN_TYPE_RESULT:
            {
                
                if(operation){
                    [self performOperation:operation];
                    
                    operation = nil;
                    isTyping = NO;
                }
                
            }
            break;
            
        case BTN_TYPE_RESET:
            {
            
                operand = 0;
                operation = nil;
                total = 0;
                isTyping = NO;
                
                [self updateLcdMain:@"0"];
                [self logInsertSeparator];
                
            }
            break;
            
        case BTN_TYPE_DEL:
            {
                if(isTyping){
                    
                    NSString* lcdVal = [lcdMain stringValue];
                    int lcdValLength = (int)[lcdVal length];
                    
                    if(lcdValLength > 1){
                        
                        lcdVal = [lcdVal substringToIndex:lcdValLength-1];
                        [self updateLcdMain:lcdVal];
                        operand = [self numberFromStringLocalized:lcdVal];
                        
                    } else if(lcdValLength == 1 && [lcdVal isNotEqualTo:@"0"]){
                        
                        [self updateLcdMain:@"0"];
                        operand = 0;
                        
                    }
                }
                
            }
            break;
            
        case BTN_TYPE_MEMORY:
            {
                
                if([@"m+" isEqualToString:btnVal]){
                
                    memory += [self numberFromStringLocalized:[lcdMain stringValue]];
                    
                } else if([@"m-" isEqualToString:btnVal]){
                    
                    memory -= [self numberFromStringLocalized:[lcdMain stringValue]];
                    
                } else if([@"mrc" isEqualToString:btnVal]){
                    
                    operand = memory;
                    isTyping = NO;
                    
                    [self updateLcdMain:[[NSNumber numberWithDouble:memory] stringValue]];
                    
                    if(memoryRestored){
                        memory = 0;
                        memoryRestored = NO;
                    } else {
                        memoryRestored = YES;
                    }
                    
                }
                
                [self updateLcdMemory:[[NSNumber numberWithDouble:memory] stringValue]];
                
            }
            break;
    
    }
    
}


-(void) performOperation:(NSString*)op
{
    
    double lastTotal = total;
    
    [self updateLcdOperand:@"" andOperation:@""];
    
    if([@"+" isEqualToString:op]){
        total += operand;
        
    } else if([@"–" isEqualToString:op]){
        total -= operand;
        
    } else if([@"x" isEqualToString:op]){
        total *= operand;
        
    } else if([@"÷" isEqualToString:op]){
        
        if(operand != 0){
            total /= operand;
        } else {
            [self updateLcdMain:@"Error"];
            
            total = 0;
            operand = 0;
            operation = nil;
            return;
        }
        
    } else if([@"√" isEqualToString:op]){
        total = sqrt(total);
        
        [self updateLcdMain:[NSString stringWithFormat:@"%g", total]];
        [self logInsertString:[NSString stringWithFormat:@"%@%g = %g\r\n", op, lastTotal, total]];
        
        return;
    }

    [self updateLcdMain:[NSString stringWithFormat:@"%g", total]];
    [self logInsertString:[NSString stringWithFormat:@"%g %@ %g = %g\r\n", lastTotal, op, operand, total]];
}


-(double) numberFromStringLocalized:(NSString*)string
{
    NSNumber* tmpNum = [enUsNumberFormatter numberFromString:string];
    if(!tmpNum) NSLog(@"numberFromStringLocalized: incorrect number");
    
    return [tmpNum doubleValue];
}

-(NSString*) stringFromNumberLocalized:(double)number
{
    return [enUsNumberFormatter stringFromNumber:[NSNumber numberWithDouble:number]];
}


-(void) createLog
{
    //log view
    NSRect viewSize = NSMakeRect(391, 5, 250, 524);
    CalcView* logView = [[CalcView alloc] initWithFrame:viewSize andShadow:NO];
    
    [logView setColor:[NSColor clearColor]];
    [logView setBackgroundImage:[NSImage imageNamed:@"bg-log.png"]];
    
    [[window contentView] addSubview:logView];
    
    
    //log textView
    NSScrollView *scrollView = [[NSScrollView alloc] initWithFrame:NSMakeRect(20, 20, 215, 440)];
    [scrollView setHasVerticalScroller:YES];
    [scrollView setBorderType:NSNoBorder];
    [scrollView setDrawsBackground:NO];
    [logView addSubview:scrollView];
    
    NSRect logFrame = NSZeroRect;
    logFrame.size = [NSScrollView contentSizeForFrameSize:[scrollView frame].size hasHorizontalScroller:NO hasVerticalScroller:YES borderType:NSNoBorder];
    
    logFrame.size.width -= 10;
    log = [[NSTextView alloc] initWithFrame:logFrame];
    [log setVerticallyResizable:YES];
    [log setAutoresizingMask:NSViewWidthSizable];
    [log setFocusRingType:NSFocusRingTypeNone];
    [log setDrawsBackground:NO];
    [log setAlignment: NSRightTextAlignment];
    [log setEditable: NO];
    
    [scrollView setDocumentView:log];
    
    
    //reset/save/print buttons
    NSFont* logButtonFont = [NSFont fontWithName:@"Comic Sans MS" size:14];
    
    PointingHandButton *saveBtn = [[PointingHandButton alloc] initWithFrame:NSMakeRect(8, 484, 38, 22)];
    [saveBtn setTitle:@"save"];
    [saveBtn setBordered:NO];
    [saveBtn setFont:logButtonFont];
    [saveBtn buttonDefaultState];
    [[saveBtn cell] setBackgroundColor:[NSColor clearColor]];
    [saveBtn setTarget: _self];
    [saveBtn setAction: @selector(saveLog:)];
    
    [logView addSubview:saveBtn];
    
    
    PointingHandButton *printBtn = [[PointingHandButton alloc] initWithFrame:NSMakeRect(60, 484, 40, 22)];
    [printBtn setTitle:@"print"];
    [printBtn setBordered:NO];
    [printBtn setFont:logButtonFont];
    [printBtn buttonDefaultState];
    [[printBtn cell] setBackgroundColor:[NSColor clearColor]];
    [printBtn setTarget: _self];
    [printBtn setAction: @selector(printLog:)];
    
    [logView addSubview:printBtn];
    
    
    PointingHandButton *clearBtn = [[PointingHandButton alloc] initWithFrame:NSMakeRect(193, 484, 42, 22)];
    [clearBtn setTitle:@"clear"];
    [clearBtn setBordered:NO];
    [clearBtn setFont:logButtonFont];
    [clearBtn buttonDefaultState];
    [[clearBtn cell] setBackgroundColor:[NSColor clearColor]];
    [clearBtn setTarget: _self];
    [clearBtn setAction: @selector(clearLog:)];
    
    [logView addSubview:clearBtn];
    
}


-(void) logInsertString:(NSString*)string
{
    NSDictionary *attributes = [[NSDictionary alloc] initWithObjectsAndKeys:
                                [NSFont fontWithName:@"Comic Sans MS" size:14], NSFontAttributeName,
                                [NSColor colorWithDeviceRed:.1 green:.2 blue:.45 alpha:1], NSForegroundColorAttributeName, nil];
    NSAttributedString *logRecord = [[NSAttributedString alloc] initWithString:string attributes: attributes];
    
    [[log textStorage] appendAttributedString:logRecord];
    [self updateScrollView];
}

-(void) logInsertSeparator
{
    NSDictionary *attributes = [[NSDictionary alloc] initWithObjectsAndKeys:
                                [NSFont fontWithName:@"Comic Sans MS" size:14], NSFontAttributeName,
                                [NSColor redColor], NSForegroundColorAttributeName, nil];
    NSAttributedString *logRecord = [[NSAttributedString alloc] initWithString:@"------------------\r\n" attributes: attributes];
    
    [[log textStorage] appendAttributedString:logRecord];
    [self updateScrollView];
}

- (void) clearLog:(id)sender
{
    [log setString:@""];
    [self updateScrollView];
}

-(void) updateScrollView
{
    NSPoint newScrollOrigin = NSMakePoint(0.0, [log bounds].size.height);
    [[log superview] scrollPoint:newScrollOrigin];
}

- (void) saveLog:(id)sender
{
    
    NSString* textToSave =[log string];
    
    if([textToSave isEqualToString:@""]){
        NSAlert *alert = [[NSAlert alloc] init];
        [alert setAlertStyle: NSWarningAlertStyle];
        [alert setMessageText:@"Nothing to save."];
        [alert runModal];
        
        return;
    }
    
    NSString* currentDate = [[NSDate  date] descriptionWithCalendarFormat:@"%Y-%m-%d_%H-%M-%S" timeZone:nil locale:[[NSUserDefaults standardUserDefaults] dictionaryRepresentation]];
    
    NSSavePanel * savePanel = [NSSavePanel savePanel];
    [savePanel setAllowedFileTypes:[NSArray arrayWithObject:@"txt"]];
    [savePanel setNameFieldStringValue:[NSString stringWithFormat:@"calc_log_%@.txt", currentDate]];
    
    [savePanel beginSheetModalForWindow:window completionHandler:^(NSInteger result){
        if(result == NSFileHandlingPanelOKButton){
            
            [savePanel orderOut:self];
            NSLog(@"Got URL: %@", [savePanel URL]);
            
            NSURL *urlToWrite = [savePanel URL];
            NSError *error;
            
            [textToSave writeToURL:urlToWrite atomically:YES encoding:NSUTF8StringEncoding error:&error];
            
            if(error){
                NSLog(@"Write error: %@", error);
            } else {
                NSLog(@"Write OK");
            }
        }
    }];
    
}

- (void)printLog:(id)sender
{
    NSString* textToPrint =[log string];
    if([textToPrint isEqualToString:@""]){
        NSAlert *alert = [[NSAlert alloc] init];
        [alert setAlertStyle: NSWarningAlertStyle];
        [alert setMessageText:@"Nothing to print."];
        [alert runModal];
        
        return;
    }
    
    [log print:nil];
}


- (void)createMainMenu {
    NSMenu* mainMenu = [NSApp mainMenu];
    NSMenu *newMenu;
    NSMenuItem *newMenuItem;
    
    //menu Log
    newMenuItem = [[NSMenuItem allocWithZone:[NSMenu menuZone]] initWithTitle:@"Log"
                                                                   action:NULL keyEquivalent:@""];
    newMenu = [[NSMenu allocWithZone:[NSMenu menuZone]] initWithTitle:@"Log"];
    [newMenuItem setSubmenu:newMenu];
    [mainMenu insertItem:newMenuItem atIndex:1];
    
    //item Log / Save log
    newMenuItem = [[NSMenuItem allocWithZone:[NSMenu menuZone]] initWithTitle:@"Save to file"
                                                                   action:@selector(menuAction:) keyEquivalent:@"s"];
    [newMenuItem setTag:MENU_ITEM_SAVE_LOG];
    [newMenuItem setTarget:_self];
    [newMenuItem setEnabled:YES];
    [newMenu addItem:newMenuItem];
    
    //item Log / Print log
    newMenuItem = [[NSMenuItem allocWithZone:[NSMenu menuZone]] initWithTitle:@"Print"
                                                                   action:@selector(menuAction:) keyEquivalent:@"p"];
    [newMenuItem setTag:MENU_ITEM_PRINT_LOG];
    [newMenuItem setTarget:_self];
    [newMenuItem setEnabled:YES];
    [newMenu addItem:newMenuItem];
    
    //separator
    [newMenu addItem:[NSMenuItem separatorItem]];
    
    //item Log / Clear log
    newMenuItem = [[NSMenuItem allocWithZone:[NSMenu menuZone]] initWithTitle:@"Clear"
                                                                   action:@selector(menuAction:) keyEquivalent:@"x"];
    [newMenuItem setTag:MENU_ITEM_CLEAR_LOG];
    [newMenuItem setTarget:_self];
    [newMenuItem setEnabled:YES];
    [newMenu addItem:newMenuItem];
    
    
    //menu View
    newMenuItem = [[NSMenuItem allocWithZone:[NSMenu menuZone]] initWithTitle:@"View"
                                                                   action:NULL keyEquivalent:@""];
    newMenu = [[NSMenu allocWithZone:[NSMenu menuZone]] initWithTitle:@"View"];
    [newMenuItem setSubmenu:newMenu];
    [mainMenu insertItem:newMenuItem atIndex:2];
    
    //item View / Toggle log
    newMenuItem = [[NSMenuItem allocWithZone:[NSMenu menuZone]] initWithTitle:@"Toggle log"
                                                                   action:@selector(menuAction:) keyEquivalent:@"l"];
    [newMenuItem setTag:MENU_ITEM_TOGGLE_LOG];
    [newMenuItem setTarget:_self];
    [newMenuItem setEnabled:YES];
    [newMenu addItem:newMenuItem];
    
}

-(void) menuAction:(id)sender
{
    NSLog(@"menu act");
    
    switch ([sender tag]) {
        case MENU_ITEM_SAVE_LOG:
            {
                [self saveLog:nil];
            }
            break;
            
        case MENU_ITEM_PRINT_LOG:
            {
                [self printLog:nil];
            }
            break;
            
        case MENU_ITEM_CLEAR_LOG:
            {
                [self clearLog:nil];
            }
            break;
            
        case MENU_ITEM_TOGGLE_LOG:
            {
                [window zoom:self];
            }
            break;
                 
        default:
            break;
    }
}

- (BOOL)validateMenuItem:(NSMenuItem *)item {
    
    switch ([item tag]) {
        case MENU_ITEM_SAVE_LOG:
            {
                if([[log string] length] == 0) return NO;
            }
            break;
            
        case MENU_ITEM_PRINT_LOG:
            {
                if([[log string] length] == 0) return NO;
            }
            break;
            
        case MENU_ITEM_CLEAR_LOG:
            {
                if([[log string] length] == 0) return NO;
            }
            break;
            
        default:
            break;
    }
    
    return  YES;
    
}


@end
