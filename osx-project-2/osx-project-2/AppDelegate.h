//
//  AppDelegate.h
//  osx-project-2
//
//  Created by macuser1 on 11/20/12.
//  Copyright (c) 2012 Pavel Popchikovsky. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (weak) IBOutlet NSMenu *statusMenu;

- (IBAction)OnSettingsMenuItemPressed:(id)sender;
- (IBAction)onQuitMenuItemPressed:(id)sender;
- (IBAction)onAboutMenuItemPressed:(id)sender;

@end
