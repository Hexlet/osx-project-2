//
//  panelController.m
//  SimpleTimer
//
//  Created by Maxim on 25.12.12.
//  Copyright (c) 2012 AppleKiller. All rights reserved.
//

#import "panelController.h"
#import "PresetsPanel.h"

@implementation panelController



-(IBAction)showPresets:(id)sender {
    if (!presets) {
        presets = [[PresetsPanel alloc] init];
    }
    [presets showWindow:self];

}

@end
