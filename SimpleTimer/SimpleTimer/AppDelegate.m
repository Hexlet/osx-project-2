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
    
    [timer assignValueFromIntegerTriplet:0 :1 :11];
    [timer arm];

}

-(AppDelegate *) init {
    self=[super init];
    if (self) {
        timer = [[timerModel alloc] init];
        
    }
    return self;
}

-(IBAction)resetTimer:(id)sender {
    [timer disarm];
}

@end
