//
//  AppDelegate.m
//  osx-project-2
//
//  Created by macuser1 on 11/20/12.
//  Copyright (c) 2012 Pavel Popchikovsky. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate {
    NSStatusItem *_statusItem;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

- (void)awakeFromNib {
    _statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [_statusItem setTitle:@"hd_status"];
    [_statusItem setMenu:_statusMenu];
    [_statusItem setHighlightMode:YES];

}

- (IBAction)OnSettingsMenuItemPressed:(id)sender {
}

- (IBAction)onQuitMenuItemPressed:(id)sender {
    exit(0);
}

- (IBAction)onAboutMenuItemPressed:(id)sender {
}

@end
