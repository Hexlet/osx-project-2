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
    //[timer armWithIntegerHours:0 andMinutes:2 andSeconds:3];
    
}

-(AppDelegate *) init {
    self=[super init];
    if (self) {
        timer   = [[timerModel alloc] init];
        presets = [[NSWindowController alloc] initWithWindowNibName:@"Presets" owner:self];
        
    }
    return self;
}

-(IBAction)resetTimer:(id)sender {
    [timer disarm];
}

-(IBAction)showPresetsWindow:(id)sender {
    [presets showWindow:self];
}

-(IBAction)armTimer:(id)sender{
    int hours=0,minutes=0,seconds =0;
    switch ( [sender tag] ) {
        case 0:
            minutes = 5;
            break;
        case 1:
            minutes = 10;
            break;
        case 2:
            minutes = 15;
            break;
        case 3:
            minutes = 20;
            break;
        case 4:
            minutes = 30;
            break;
        case 5:
            hours   = 1;
            break;
        case 6:
            hours   = 2;
            break;
        case 7:
            hours   = 3;
            break;
        case 8:
            hours   = 4;
            break;
            
    };

    [timer armWithIntegerHours: hours andMinutes:minutes andSeconds :seconds];

}

@end
