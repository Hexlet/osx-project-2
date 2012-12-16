//
//  AppDelegate.h
//  Calculatte
//
//  Created by Alex Bakoushin on 02.12.12.
//  Copyright (c) 2012 Alex Bakoushin. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate> {
    NSMutableArray *history;
}

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTextField *textField;
@property (weak) IBOutlet NSTableView *tableView;

- (IBAction)calculateIt:(id)sender;
@end
