//
//  PointingHandButton.m
//  Calculator
//
//  Created by Alexander Shvets on 04.12.12.
//  Copyright (c) 2012 Alexander Shvets. All rights reserved.
//

#import "PointingHandButton.h"
#import "NSButton+ButtonTextColor.h"

@implementation PointingHandButton

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
    
}

- (void)resetCursorRects
{
    [super resetCursorRects];
    [self addCursorRect:[self bounds] cursor: [NSCursor pointingHandCursor]];
}

- (void)updateTrackingAreas
{
	[super updateTrackingAreas];
	
	if(trackingArea) [self removeTrackingArea:trackingArea];
	
	NSTrackingAreaOptions options = NSTrackingInVisibleRect | NSTrackingMouseEnteredAndExited | NSTrackingActiveInKeyWindow;
	trackingArea = [[NSTrackingArea alloc] initWithRect:NSZeroRect options:options owner:self userInfo:nil];
	[self addTrackingArea:trackingArea];
}


- (void)mouseEntered:(NSEvent *)event {
    [self setTextColor:[NSColor colorWithDeviceRed:0 green:0 blue:0 alpha:1]];
}

- (void)mouseExited:(NSEvent *)event
{
    [self buttonDefaultState];
}

- (void) buttonDefaultState
{
    [self setTextColor:[NSColor colorWithDeviceRed:0 green:0 blue:0 alpha:.7]];
}

@end
