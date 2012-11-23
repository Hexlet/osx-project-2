//
//  AppDelegate.h
//  TransmissionRemote
//
//  Created by Александр Турченко on 15.11.12.
//  Copyright (c) 2012 TurchenkoAlex. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "OptionsWindowController.h"
#import "Service.h"
#import "ServerStatus.h"

@interface AppDelegate : NSObject <NSApplicationDelegate, NSUserNotificationCenterDelegate> {
    NSNumber *activeRequestInterval;
    NSNumber *unactiveRequestInterval;    
}

@property Service *systemService;
@property (assign) IBOutlet NSWindow *window;
@property OptionsWindowController *optionsWindowController;
@property ServerStatus *serverStatus;

- (IBAction)showOptionsWindow:(id)sender;
- (IBAction)reconnectAction:(id)sender;

@end
