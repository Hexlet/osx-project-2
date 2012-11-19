//
//  AppDelegate.m
//  Supersonic
//
//  Created by sashkam on 18.11.12.
//  Copyright (c) 2012 Verveyko Alexander. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate{
    BOOL isPlaying;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    isPlaying = NO;
}

- (IBAction)doPlay:(id)sender {
    if (isPlaying) {
        isPlaying = NO;
        [_controlPlay setImage:[NSImage imageNamed:@"control_play.png"]];
    } else {
        isPlaying = YES;
        [_controlPlay setImage:[NSImage imageNamed:@"control_pause.png"]];
    }
}
@end
