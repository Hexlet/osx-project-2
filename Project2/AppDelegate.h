//
//  AppDelegate.h
//  Project2
//
//  Created by Роман Евсеев on 04.12.12.
//  Copyright (c) 2012 Роман Евсеев. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTextField *textField;

- (IBAction)getBORCitate:(id)sender;
@end
