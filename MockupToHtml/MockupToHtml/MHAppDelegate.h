//
//  MHAppDelegate.h
//  MockupToHtml
//
//  Created by Dmitriy Zhukov on 04.12.12.
//  Copyright (c) 2012 Dmitriy Zhukov. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MHAppDelegate : NSObject <NSApplicationDelegate, NSSplitViewDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSSplitView *navSplit;

@end
