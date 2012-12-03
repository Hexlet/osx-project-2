//
//  NAAppDelegate.m
//  NALevelEditor
//
//  Created by User on 15.11.12.
//  Copyright (c) 2012 naoG. All rights reserved.
//

#import "NAAppDelegate.h"
#import "HelloWorldLayer.h"

@implementation NAAppDelegate

- (void)dealloc
{
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    CCDirectorMac *director = (CCDirectorMac*) [CCDirector sharedDirector];
	
	[director setDisplayFPS:YES];
	
	[director setOpenGLView:_macView];
    
	// EXPERIMENTAL stuff.
	// 'Effects' don't work correctly when autoscale is turned on.
	// Use kCCDirectorResize_NoScale if you don't want auto-scaling.
	[director setResizeMode:kCCDirectorResize_AutoScale];
	
	// Enable "moving" mouse event. Default no.
	[_window setAcceptsMouseMovedEvents:NO];
	
	
	[director runWithScene:[HelloWorldLayer scene]];
}

@end
