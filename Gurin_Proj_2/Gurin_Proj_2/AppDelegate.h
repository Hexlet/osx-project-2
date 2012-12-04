//
//  AppDelegate.h
//  Gurin_Proj_2
//
//  Created by Admin on 12/4/12.
//  Copyright (c) 2012 Admin. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSImageView *logo;
@property (weak) IBOutlet NSButton *favor;
@property (weak) IBOutlet NSButton *catalog;
@property (weak) IBOutlet NSButton *interest;

@end
