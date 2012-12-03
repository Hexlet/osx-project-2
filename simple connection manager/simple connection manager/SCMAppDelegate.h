//
//  SCMAppDelegate.h
//  simple connection manager
//
//  Created by Alexander Kazanskiy on 02.12.12.
//  Copyright (c) 2012 sysadmin.su. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SCMLeftPanelViewController.h"
#import "SCMRightPanelViewController.h"

@interface SCMAppDelegate : NSObject <NSApplicationDelegate>
@property (weak) IBOutlet NSView *LeftPanel;
@property (weak) IBOutlet NSView *RightPanel;

@property (assign) IBOutlet NSWindow *window;

@end
