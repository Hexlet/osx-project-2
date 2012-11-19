//
//  AppDelegate.h
//  WordCards
//
//  Created by alex on 19/11/2012.
//  Copyright (c) 2012 alex. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSComboBox *theme;
@property (weak) IBOutlet NSTextField *period;

@end
