//
//  AppDelegate.h
//  MacCloudBackuper
//
//  Created by Maxim Zhukov on 04.12.12.
//  Copyright (c) 2012 Maxim Zhukov. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (strong, nonatomic) IBOutlet NSMenu *statusMenu;
@property (strong, nonatomic) NSStatusItem *statusBar;
@property (strong, nonatomic) IBOutlet NSMenuItem *syncLable;
@property (strong, nonatomic) IBOutlet NSMenuItem *swithSyncMode;

- (IBAction)swithSyncMode:(id)sender;
- (IBAction)about:(id)sender;
- (IBAction)sendBugReport:(id)sender;
- (IBAction)perferenceWindow:(id)sender;

@end
