//
//  AppDelegate.m
//  Calculator
//
//  Created by Alexander Shvets on 03.12.12.
//  Copyright (c) 2012 Alexander Shvets. All rights reserved.
//

#import "AppDelegate.h"
#import "CalcGUI.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    //remove IB NSBox
    [_placeholder removeFromSuperview];
    
    CalcGUI* gui = [[CalcGUI alloc] initWithWindow:_window];
    [gui createCalculator];
}

- (BOOL) applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender
{
    return YES;
}

@end
