//
//  AppDelegate.h
//  Calculatte
//
//  Created by Alex Bakoushin on 02.12.12.
//  Copyright (c) 2012 Alex Bakoushin. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "AppController.h"
#import "HistoryModel.h"

@interface AppDelegate : NSObject <NSApplicationDelegate, NSTextFieldDelegate, NSTableViewDataSource, NSTableViewDelegate> {
    NSMutableArray *_tableContents;
}

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTextField *textField;

- (IBAction)calculateIt:(id)sender;
@end
