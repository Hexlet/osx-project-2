//
//  AppDelegate.h
//  Calculator
//
//  Created by Alexander Shvets on 03.12.12.
//  Copyright (c) 2012 Alexander Shvets. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSBox *placeholder;

@end
