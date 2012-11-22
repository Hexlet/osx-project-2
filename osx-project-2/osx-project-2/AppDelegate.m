//
//  AppDelegate.m
//  osx-project-2
//
//  Created by macuser1 on 11/20/12.
//  Copyright (c) 2012 Pavel Popchikovsky. All rights reserved.
//

#import "AppDelegate.h"
#import "DiskActivity.h"
#import "DiskActivityRandom.h"
const float ACTIVITY_CHECK_PERIOD = 0.5f;
const float ICON_UPDATE_PERIOD = 0.5f;

@implementation AppDelegate
{
    NSStatusItem *statusItem;
    
    NSImage *iconOn;
    NSImage *iconOff;
        
    DiskActivity *diskActivity;
}

- (void)awakeFromNib
{
    [self loadIcons];
    [self setupStatusItem];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [self startDiskActivity];
    [self startIconUpdateTimer];
}

- (void) startDiskActivity
{
    id<DiskActivityProtocol> activityProtocol = [[DiskActivityRandom alloc] init];
    diskActivity = [[DiskActivity alloc] initWithProtocol:activityProtocol andPeriod:ACTIVITY_CHECK_PERIOD];
}

- (void) startIconUpdateTimer
{
    [NSTimer
     scheduledTimerWithTimeInterval:ICON_UPDATE_PERIOD
     target:self
     selector:@selector(onTimer:)
     userInfo:nil
     repeats:YES];
}

- (void) loadIcons
{
    NSBundle *bundle = [NSBundle mainBundle];
    
    iconOn  = [[NSImage alloc] initWithContentsOfFile:[bundle pathForResource:@"icon_on"  ofType:@"png"]];
    iconOff = [[NSImage alloc] initWithContentsOfFile:[bundle pathForResource:@"icon_off" ofType:@"png"]];
}

- (void) setupStatusItem
{
    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [statusItem setMenu:_statusMenu];
    [statusItem setHighlightMode:YES];
}

- (void)onTimer:(NSTimer*)timer
{
    float activityValue = [[diskActivity getCurrent] floatValue];
    [statusItem setImage:((activityValue > 0) ? iconOn : iconOff)];
}

- (IBAction)onQuitMenuItemPressed:(id)sender
{
    exit(0);
}

@end
