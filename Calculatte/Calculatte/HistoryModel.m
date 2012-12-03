//
//  HistoryModel.m
//  Calculatte
//
//  Created by Alex Bakoushin on 03.12.12.
//  Copyright (c) 2012 Alex Bakoushin. All rights reserved.
//

#import "HistoryModel.h"

@implementation HistoryModel

-(id) init {
    if (self = [super init]) {
        _expression = [[NSString alloc] init];
        _date = [[NSDate alloc] init];
    }
    return self;
}
@end
