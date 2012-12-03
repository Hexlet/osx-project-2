//
//  RData.m
//  dR-3
//
//  Created by Victor Mylcin on 01.12.12.
//  Copyright (c) 2012 Victor Mylcin. All rights reserved.
//

#import "RData.h"

@implementation RData

- (id)init
{
    self = [super init];
    if (self) {
        _dateOfData = [NSDate date];
        _comment = @"comment";
        _money = 0;
    }
    return self;
}

@end
