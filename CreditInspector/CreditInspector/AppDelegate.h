//
//  AppDelegate.h
//  CreditInspector
//
//
//  Copyright (c) 2012 self. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>{
    NSMutableArray *rows;
}

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTableView *tableView;
@property (weak) IBOutlet NSTextField *total;
@property (weak) IBOutlet NSTextField *percent;
@property (weak) IBOutlet NSComboBox *combo;
@property (weak) IBOutlet NSTextField *param;
@property (weak) IBOutlet NSTextField *summary;

- (IBAction)show:(id)sender;

@end
