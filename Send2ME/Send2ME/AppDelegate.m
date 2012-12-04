//
//  AppDelegate.m
//  Send2ME
//
//  Created by admin on 11/20/12.
//  Copyright (c) 2012 d1sc0nnect0r. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    statusItem = [[[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength] init];
    [statusItem setMenu:statusMenu];
    [statusItem setTitle:@"Send2ME"];
    [statusItem setHighlightMode:YES];
    
}

- (IBAction)closeapp:(NSMenuItem *)sender {
    [[NSApplication sharedApplication] terminate:nil];
}
@end
