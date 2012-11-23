//
//  YKAppDelegate.h
//  Felix
//
//  Created by Yuri Kirghisov on 23.11.12.
//  Copyright (c) 2012 Yuri Kirghisov. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#define OPERATION_ADDITION @"+"
#define OPERATION_SUBSTRACTION @"-"
#define OPERATION_MULTIPLICATION @"*"
#define OPERATION_DIVISION @"/"

@interface YKAppDelegate : NSObject <NSApplicationDelegate, NSTableViewDelegate, NSTableViewDataSource>

@property (retain) NSArray *arithmeticOperations;

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSSlider *argOneSlider;
@property (assign) IBOutlet NSSlider *argTwoSlider;
@property (assign) IBOutlet NSSlider *resultSlider;
@property (assign) IBOutlet NSTableView *operationsTableView;
@property (assign) IBOutlet NSTextField *argOneTextField;
@property (assign) IBOutlet NSTextField *argTwoTextField;
@property (assign) IBOutlet NSTextField *resultTextField;

- (IBAction)argOneSliderHasMoved:(id)sender;
- (IBAction)argTwoSliderHasMoved:(id)sender;

// Этот метод обновляет все объекты в окне
- (void)updateViews;

@end
