//
//  AppDelegate.h
//  SimpleTimer
//
//  Created by Maxim on 23.12.12.
//  Copyright (c) 2012 AppleKiller. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "timerModel.h"
#import "PresetsPanel.h"


@interface AppDelegate : NSObject <NSApplicationDelegate>{
    timerModel * timer;
    PresetsPanel * presets;
}

@property (assign) IBOutlet NSWindow *window;

-(IBAction)resetTimer:(id)sender;
-(IBAction)showPresetsWindow:(id)sender;
-(IBAction)arm5minutes:(id)sender;

@end
