//
//  NAAppDelegate.h
//  NALevelEditor
//
//  Created by User on 15.11.12.
//  Copyright (c) 2012 naoG. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "cocos2d.h"

@interface NAAppDelegate : NSObject <NSApplicationDelegate>
@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet MacGLView *macView;

@end
