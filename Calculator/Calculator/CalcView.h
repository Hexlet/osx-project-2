//
//  CalcView.h
//  Calculator
//
//  Created by Alexander Shvets on 03.12.12.
//  Copyright (c) 2012 Alexander Shvets. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface CalcView : NSView{
    NSColor* bgColor;
    NSImage* bgImage;
    BOOL dropShadow;
}

-(id) initWithFrame:(NSRect)frame andShadow:(BOOL)addShadow;
-(void) setColor:(NSColor*)color;
-(void) setBackgroundImage:(NSImage*)bgImage;

@end
