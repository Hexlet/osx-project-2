//
//  AppDelegate.m
//  osx-project-2
//
//  Created by macuser1 on 11/20/12.
//  Copyright (c) 2012 Pavel Popchikovsky. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate
{
    NSStatusItem *statusItem;
    
    NSImage *iconOn;
    NSImage *iconOff;
    
    bool on;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [NSTimer
     scheduledTimerWithTimeInterval:0.5
     target:self
     selector:@selector(OnUpdate:)
     userInfo:nil
     repeats:YES];
}

- (void)awakeFromNib
{
    
    NSBundle *bundle = [NSBundle mainBundle];
    
    iconOn  = [[NSImage alloc] initWithContentsOfFile:[bundle pathForResource:@"icon_on"  ofType:@"png"]];
    iconOff = [[NSImage alloc] initWithContentsOfFile:[bundle pathForResource:@"icon_off" ofType:@"png"]];
    
    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    
    [statusItem setMenu:_statusMenu];
    [statusItem setHighlightMode:YES];
    
    on = false;
    [self OnUpdate:nil];

}

- (void)OnUpdate:(NSTimer*)timer
{
    on = !on;
    [statusItem setImage:(on ? iconOn : iconOff)];
}

- (IBAction)OnSettingsMenuItemPressed:(id)sender
{
}

- (IBAction)onQuitMenuItemPressed:(id)sender
{
    exit(0);
}

- (IBAction)onAboutMenuItemPressed:(id)sender
{
}

@end
