//
//  AppDelegate.h
//  PowerRegexTester
//
//  Created by Igor on 18/11/2012.
//  Copyright (c) 2012 Igor Redchuk. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "OptionsMatrix.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

@property (weak) IBOutlet OptionsMatrix *options;
@property (weak) IBOutlet NSTextField *pattern;
@property (weak) IBOutlet NSTextField *source;

@end
