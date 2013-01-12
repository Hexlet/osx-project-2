//
//  AppDelegate.m
//  Calculatte
//
//  Created by Alex Bakoushin on 02.12.12.
//  Copyright (c) 2012 Alex Bakoushin. All rights reserved.
//

#import "AppDelegate.h"
#import "MainWindowController.h"

@implementation AppDelegate

-(void)activateApp{
    [NSApp activateIgnoringOtherApps:YES];
    [mainWindow showWindow:self];
}

-(void)createStatusBar {
    statusBar = [[NSStatusBar systemStatusBar] statusItemWithLength:NSSquareStatusItemLength];
    [statusBar setImage: [NSImage imageNamed:@"coffe_cup_icon.png"]];
    [statusBar setHighlightMode:YES];
    [statusBar setAction:@selector(activateApp)];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {

    [self createStatusBar];
    
    mainWindow = [[MainWindowController alloc] init];
    [mainWindow showWindow:self];
    
    [NSEvent addGlobalMonitorForEventsMatchingMask:NSKeyDownMask handler:^(NSEvent *event){
        
        int character = [[event charactersIgnoringModifiers] characterAtIndex:0];

        if(([event modifierFlags] & NSControlKeyMask) && (character == 48)) { // Ctrl+0
            [NSApp activateIgnoringOtherApps:YES];
            [mainWindow showWindow:self];
        }
    }];
    
}

@end
