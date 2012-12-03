//
//  AppDelegate.m
//  turbo_button
//
//  Created by ssein on 22.11.12.
//  Copyright (c) 2012 ssein. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    [self activateStatusMenu];
}

- (void)activateStatusMenu
{
    NSStatusBar *bar = [NSStatusBar systemStatusBar];
    
    statusItem = [bar statusItemWithLength:NSVariableStatusItemLength];
    
    [statusItem setTitle: NSLocalizedString(@"☉",@"")];
    [statusItem setHighlightMode:YES];
    [statusItem setEnabled:YES];
    [statusItem setMenu:theMenu];
}


-(IBAction)updateTimerIcon: (id)sender {
    NSLog(@"Click!");
}
@end
