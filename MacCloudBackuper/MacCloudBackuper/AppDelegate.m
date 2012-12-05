//
//  AppDelegate.m
//  MacCloudBackuper
//
//  Created by Maxim Zhukov on 04.12.12.
//  Copyright (c) 2012 Maxim Zhukov. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate
@synthesize statusBar = _statusBar;

- (void) awakeFromNib {
    self.statusBar = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    
    self.statusBar.title = @"G";
    
    //можно заодно и картинку установить
    //self.statusBar.image =
    
    self.statusBar.menu = self.statusMenu;
    self.statusBar.highlightMode = YES;
}

- (IBAction)swithSyncMode:(id)sender {
    NSLog(@"swithSyncMode");
}

- (IBAction)about:(id)sender {
    NSLog(@"about");
}

- (IBAction)sendBugReport:(id)sender {
    NSLog(@"sendBugReport");
}

- (IBAction)perferenceWindow:(id)sender {
    NSLog(@"perferenceWindow");
}
@end
