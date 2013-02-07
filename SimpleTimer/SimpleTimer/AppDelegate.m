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
        // presets = [[NSWindowController alloc] initWithWindowNibName:@"Presets" owner:self];
        // manualSetController = [[NSWindowController alloc] initWithWindowNibName:@"ManualSet" owner:self];
//        [[manualSetController window] ];
    }
    return self;
}

-(IBAction)resetTimer:(id)sender {
    [timer disarm];
}

-(IBAction)showPresetsWindow:(id)sender {
    presets = [[NSWindowController alloc] initWithWindowNibName:@"Presets" owner:self];
    [presets showWindow:self];
}

-(IBAction)showManualSetWindow:(id)sender {
    manualSetController = [[NSWindowController alloc] initWithWindowNibName:@"ManualSet" owner:self];
    [manualSetController showWindow:self];
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
    [_presetPanel performClose:self];
    
}

-(IBAction)manualArmTimer:(id)sender{

    if ( [[_manualHours stringValue  ] length ] == 0 ) {
        return [self reportInvalidInputWithLocaleKey:@"MSG_HOURS_RANGE"];
    }
    if ( [[_manualMinutes stringValue  ] length ] == 0 ) {
        return [self reportInvalidInputWithLocaleKey:@"MSG_MINUTES_RANGE"];
    }
    long enteredHours = [[_manualHours stringValue] integerValue];
    long enteredMinutes = [[_manualMinutes stringValue] integerValue];
    if (enteredHours < 0 || enteredHours > 999 ) {
        return [self reportInvalidInputWithLocaleKey:@"MSG_HOURS_RANGE"];
    }
    
    if (enteredMinutes < 0 || enteredMinutes > 59) {
        return [self reportInvalidInputWithLocaleKey:@"MSG_MINUTES_RANGE"];
    }
    
    if (enteredHours==0 && enteredMinutes == 0) {
        return [self reportInvalidInputWithLocaleKey:@"MSG_HOURS_MINUTES_ZERO"];
    }
    
    [timer armWithIntegerHours:(int)enteredHours andMinutes:(int)enteredMinutes andSeconds:0];
    [_manualSetPanel performClose:self];
}

-(void)reportInvalidInputWithLocaleKey: (NSString * ) key {
    NSString *alertTitle = NSLocalizedString(@"MSG_INVALID_TIME_TITLE", @"window title" );
    NSString *message = NSLocalizedString(key, nil);
    NSRunAlertPanel( alertTitle  , message, @"Ok", nil, nil);
    
}

@end
