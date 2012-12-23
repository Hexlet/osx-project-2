//
//  timerModel.m
//  SimpleTimer
//
//  Created by Maxim on 23.12.12.
//  Copyright (c) 2012 AppleKiller. All rights reserved.
//

#import "timerModel.h"

@implementation timerModel




-(timerModel *) init {
    self=[super init];
    if (self) {
        _minutesLeft=[NSNumber numberWithInt:0];
        _hoursLeft=[NSNumber numberWithInt:0];
        _secondsLeft =[NSNumber numberWithInt:0];
        isArmed = [NSNumber numberWithBool:false];
    }
    return self;
}

-(void) arm{
    // Validate triplet state
    
    // Set timer triggering date
    NSTimeInterval secondsToArm = [self triplet2interval];
    triggerDate=[[NSDate alloc] initWithTimeIntervalSinceNow:secondsToArm  ];
   
    // Create timer to update triplet every second
    timerObject = [NSTimer scheduledTimerWithTimeInterval: 1.0
        target:self
        selector:@selector(timerTick:)
        userInfo:nil
        repeats:YES
    ];
    if (!timerObject) return;
    
    // Insert timer in the run loop (already done by sheduleTimerWith...
    
    // Set internal armed state to true
    isArmed=[NSNumber numberWithBool:true];
}

-(void)disarm{
    [self invalidateTimer];
    isArmed=NO;
}

-(NSTimeInterval)triplet2interval{

    return (NSTimeInterval)[_secondsLeft longValue]+ [_minutesLeft longValue]* 60 + [_hoursLeft longValue] * 3600;
    
}

-(void) timerTick: (NSTimer *) nsTimerObject {
    // Return unless timer was armed in some place in code
    if (!isArmed) return;
    
    // See how many time left till timer triggering
    NSTimeInterval secondsTillTrigger = [triggerDate timeIntervalSinceNow ];
    
    // If already triggered:
    if (secondsTillTrigger <= 0) {
        // Send message to play sound
        NSLog(@"Trigger timer");
        NSBeep();
    
        // Disarm timer
        [self disarm];
    }
    
    // update triplet from secondsLeft in any cases
    [self updateTripletFromInterval:secondsTillTrigger];
    
    
}

-(void)updateTripletFromInterval: (NSTimeInterval )interval {
    [self setValue: [NSNumber numberWithInt: (int)interval / 3600] forKey:@"hoursLeft"];
     [self setValue: [NSNumber numberWithInt: (interval - [_hoursLeft intValue] ) /60 ] forKey:@"minutesLeft"];
    [self setValue: [NSNumber numberWithInt: (int)ceil(interval) % 60] forKey: @"secondsLeft"] ;
}

-(void) invalidateTimer {
    if (timerObject) {
        [timerObject invalidate];
    }
}

-(void) dealloc {
    [self invalidateTimer];
}

@end
