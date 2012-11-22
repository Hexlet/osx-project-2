//
//  AppDelegate.h
//  turbo_button
//
//  Created by ssein on 22.11.12.
//  Copyright (c) 2012 ssein. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate> {
    NSStatusItem *statusItem;
    IBOutlet NSMenu *theMenu;
}

@property (assign) IBOutlet NSWindow *window;

@end
