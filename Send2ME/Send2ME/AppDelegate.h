//
//  AppDelegate.h
//  Send2ME
//
//  Created by admin on 11/20/12.
//  Copyright (c) 2012 d1sc0nnect0r. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>{
    IBOutlet NSMenu *statusMenu;
    NSStatusItem *statusItem;
}

@property (assign) IBOutlet NSWindow *window;
- (IBAction)closeapp:(NSMenuItem *)sender;


@end
