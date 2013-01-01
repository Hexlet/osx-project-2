//
//  AppDelegate.m
//  SimpleTimer
//
//  Created by Maxim on 23.12.12.
//  Copyright (c) 2012 AppleKiller. All rights reserved.
//

#import "AppDelegate.h"


@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    
    //[timer assignValueFromIntegerTriplet:0 :0 :11];
    //[timer arm];
    //[timer armWithIntegerHours:0 andMinutes:1 andSeconds:11];
    
}

-(AppDelegate *) init {
    self=[super init];
    if (self) {
        timer   = [[timerModel alloc] init];
        presets = [[PresetsPanel alloc] initWithWindowNibName:@"Presets" owner:self];
        
    }
    return self;
}

-(IBAction)resetTimer:(id)sender {
    [timer disarm];
}

-(IBAction)showPresetsWindow:(id)sender {
    [presets showWindow:self];
}

-(IBAction)arm5minutes:(id)sender{
    [timer armWithIntegerHours: 0 andMinutes:5 andSeconds :0];
}

@end
