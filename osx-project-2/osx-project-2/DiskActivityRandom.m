//
//  DiskActivityRandom.m
//  osx-project-2
//
//  Created by macuser1 on 11/22/12.
//  Copyright (c) 2012 Pavel Popchikovsky. All rights reserved.
//

#import "DiskActivityRandom.h"

@implementation DiskActivityRandom 

- (NSNumber*)getValue
{
    return [NSNumber numberWithInt:(arc4random_uniform(2))];
}

@end
