//
//  AppDelegate.h
//  SimpleTimer
//
//  Created by Maxim on 23.12.12.
//  Copyright (c) 2012 AppleKiller. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "timerModel.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>{
    timerModel * timer;
}

@property (assign) IBOutlet NSWindow *window;

@end
