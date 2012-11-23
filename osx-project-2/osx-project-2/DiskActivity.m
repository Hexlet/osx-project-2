//
//  DiskActivity.m
//  osx-project-2
//
//  Created by macuser1 on 11/22/12.
//  Copyright (c) 2012 Pavel Popchikovsky. All rights reserved.
//

#import "DiskActivity.h"
#import "DiskActivityProtocol.h"

const float ACTIVITY_GATHER_TIME = 60.0f;

@implementation DiskActivity
{
    id<DiskActivityProtocol> activity;
    NSMutableArray *data;
}

- (DiskActivity*)initWithProtocol:(id<DiskActivityProtocol>)activityProtocol andPeriod:(float)period
{
    self = [super init];
    if(self)
    {
        activity = activityProtocol;
        
        int arraySize = (int)(ACTIVITY_GATHER_TIME / period);
        data = [NSMutableArray arrayWithCapacity:arraySize];
        for(NSNumber* number in data)
            [number setValue:[NSNumber numberWithFloat:0.0f]];
    }
    return self;
}

- (void)update
{
    [data removeLastObject];
    [data insertObject:[activity getValue] atIndex:0];
}

- (NSNumber*)getCurrent
{
    return [data objectAtIndex:0];
}

@end
