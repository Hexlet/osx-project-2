//
//  AppDelegate.h
//  Supersonic
//
//  Created by sashkam on 18.11.12.
//  Copyright (c) 2012 Verveyko Alexander. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSButton *controlPlay;
- (IBAction)doPlay:(id)sender;

@end
