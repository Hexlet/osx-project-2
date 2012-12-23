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
    
    [timer setValue : [NSNumber numberWithInt:0] forKey: @"secondsLeft"];
    [timer setValue : [NSNumber numberWithInt:10] forKey: @"minutesLeft"];
    //[timer setValue : [NSNumber numberWithInt:1] forKey: @"hoursLeft"];
    
    [timer arm];

}

-(AppDelegate *) init {
    self=[super init];
    if (self) {
        timer = [[timerModel alloc] init];
        
    }
    return self;
}

@end
