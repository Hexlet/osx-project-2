//
//  AppDelegate.h
//  myCar
//
//  Created by Alex Altabaev on 01.12.12.
//  Copyright (c) 2012 Alex Altabaev. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTextField *milage;
@property (weak) IBOutlet NSButton *changeMilageButton;
@property (weak) IBOutlet NSButton *saveMilageButton;

- (IBAction)changeMilage:(id)sender;
- (IBAction)saveMilage:(id)sender;

@end
