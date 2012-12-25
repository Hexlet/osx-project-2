//
//  timerModel.h
//  SimpleTimer
//
//  Created by Maxim on 23.12.12.
//  Copyright (c) 2012 AppleKiller. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface timerModel : NSObject {
    NSDate * triggerDate;
    NSNumber * isArmed;
    NSTimer  * timerObject;
}

@property NSNumber * hoursLeft;
@property NSNumber * minutesLeft;
@property NSNumber * secondsLeft;


-(timerModel *) init;

-(void)assignValueFromIntegerTriplet: (int) hours: (int)minutes: (int) seconds  ;
-(void)arm;
-(void)disarm;

@end
