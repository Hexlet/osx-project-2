//
//  AppDelegate.m
//  BodyTech
//
//  Created by Dmitry Davidov on 02.12.12.
//  Copyright (c) 2012 Dmitry Davidov. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification{}

- (id)init {
    if (self = [super init]) {
        _exercises = [NSMutableArray arrayWithObjects:@"подтягивания", @"отжимания", @"приседания", @"бег",  nil];
    }
    return self;
}

- (IBAction)createExercise:(id)sender {
    [_exerciseArrayController addObject:@"упражнение"];
}

@end
