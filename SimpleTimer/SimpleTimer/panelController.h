//
//  panelController.h
//  SimpleTimer
//
//  Created by Maxim on 25.12.12.
//  Copyright (c) 2012 AppleKiller. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PresetsPanel;

@interface panelController : NSObject {
    PresetsPanel * presets;
}

-(IBAction) showPresets: (id) sender;

@end
