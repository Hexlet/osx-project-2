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
        [self assignValueFromIntegerTriplet:0 :0 :0];
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
    isArmed=NO;
    [self invalidateTimer];
    timerObject=NULL;
    [self assignValueFromIntegerTriplet:0 :0 :0];
}

-(NSTimeInterval)triplet2interval{

    return (NSTimeInterval)[_secondsLeft integerValue]+ [_minutesLeft integerValue]* 60 + [_hoursLeft integerValue] * 3600;
    
}

-(void) timerTick: (NSTimer *) nsTimerObject {
    
    // Return unless timer was armed in some place in code
    if (!isArmed) return;
    
    // See how many time left till timer triggering
    NSTimeInterval secondsTillTrigger = [triggerDate timeIntervalSinceNow ];
    
    // If already triggered:
    if (secondsTillTrigger <= 0) {
        // Send message to play sound
        // Maybe i should became NSSound delegate and free resources as it finishes playing
        NSSound *ring = [[NSSound alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"3" ofType:@"mp3"] byReference:NO];
        [ring play];
    
        // Disarm timer
        [self disarm];
    }
    
    // update triplet from secondsLeft in any cases
    [self updateTripletFromInterval:secondsTillTrigger];
    
    
}

-(void)updateTripletFromInterval: (NSTimeInterval )interval {
    int hours   =    (int)interval   / 3600;
    int minutes =  ( (int)interval   / 60 ) % 60;
    int seconds =    (int)ceil(interval)   % 60;
    
    [self assignValueFromIntegerTriplet:hours :minutes: seconds];
	
}

-(void) invalidateTimer {
    if (timerObject) {
        [timerObject invalidate];
    }
}

-(void) dealloc {
    [self invalidateTimer];
}

-(void) assignValueFromIntegerTriplet:(int)hours :(int)minutes :(int)seconds {
    NSString * secondsString = [[NSString alloc] initWithFormat: @"%.2d",seconds];
    NSString * minutesString = [[NSString alloc] initWithFormat: @"%.2d",minutes];
    NSString * hoursString = [[NSString alloc] initWithFormat: @"%.3d",hours];
    
    [self setValue : secondsString forKey: @"secondsLeft"];
    [self setValue : minutesString forKey: @"minutesLeft"];
    [self setValue : hoursString   forKey: @"hoursLeft"];
}

-(void)armWithIntegerHours:(int)hours andMinutes:(int)minutes andSeconds :(int)seconds {
    [self disarm];
    [self assignValueFromIntegerTriplet:hours : minutes : seconds];
    [self arm ];
}


@end
