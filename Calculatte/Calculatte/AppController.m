//
//  AppController.m
//  Calculatte
//
//  Created by Alex Bakoushin on 03.12.12.
//  Copyright (c) 2012 Alex Bakoushin. All rights reserved.
//

#import "AppController.h"

@implementation AppController

-(id) init {
    if (self = [super init]) {
        _historyArray = [[NSMutableArray alloc] init];
    }
    return self;
}


@end
