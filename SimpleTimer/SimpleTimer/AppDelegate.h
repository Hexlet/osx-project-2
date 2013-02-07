//
//  AppDelegate.h
//  SimpleTimer
//
//  Created by Maxim on 23.12.12.
//  Copyright (c) 2012 AppleKiller. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "timerModel.h"


@interface AppDelegate : NSObject <NSApplicationDelegate>{
    timerModel * timer;
    NSWindowController * presets;
    NSWindowController * manualSetController;
    
    
}

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSWindow *manualSetPanel;
@property (assign) IBOutlet NSWindow *presetPanel;


@property (assign) IBOutlet NSTextField * manualHours;
@property (assign) IBOutlet NSTextField * manualMinutes;

-(IBAction)resetTimer:(id)sender;
-(IBAction)showPresetsWindow:(id)sender;
-(IBAction)showManualSetWindow:(id)sender;
-(IBAction)armTimer:(id)sender;
-(IBAction)manualArmTimer:(id)sender;

-(void)reportInvalidInputWithLocaleKey: (NSString * )message;

@end
