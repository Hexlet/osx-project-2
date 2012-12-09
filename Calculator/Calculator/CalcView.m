//
//  CalcView.m
//  Calculator
//
//  Created by Alexander Shvets on 03.12.12.
//  Copyright (c) 2012 Alexander Shvets. All rights reserved.
//

#define SHADOW_SIZE 10

#import "CalcView.h"

@implementation CalcView

- (id)initWithFrame:(NSRect)frame andShadow:(BOOL)addShadow
{
    
    if(addShadow) frame.size.width += SHADOW_SIZE;
    
    if ([super initWithFrame:frame]) {
        
        if(addShadow){
            NSShadow *shadow = [[NSShadow alloc] init];
            [shadow setShadowColor:[NSColor blackColor]];
            [shadow setShadowOffset:NSMakeSize(0,0)];
            [shadow setShadowBlurRadius:SHADOW_SIZE];
            [self setShadow: shadow];
        }
        
        [self setWantsLayer: YES];
        
        dropShadow = addShadow;
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    
    NSRect fillRect = [self bounds];
    if(dropShadow) fillRect.size.width -= SHADOW_SIZE;
    
    [bgColor set];
    NSRectFill(fillRect);
    
    if(bgImage){
        if([self isFlipped]) [bgImage setFlipped:YES];
        [bgImage drawInRect:dirtyRect fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1];
    }

}

- (BOOL) isFlipped
{
    return YES;
}

-(void)setColor:(NSColor *)color
{
    bgColor = color;
}

-(void) setBackgroundImage:(NSImage *)image
{
    bgImage = image;
}


@end
