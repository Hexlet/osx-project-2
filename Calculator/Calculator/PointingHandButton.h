//
//  PointingHandButton.h
//  Calculator
//
//  Created by Alexander Shvets on 04.12.12.
//  Copyright (c) 2012 Alexander Shvets. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface PointingHandButton : NSButton
{
    NSTrackingArea* trackingArea;
}

-(void) buttonDefaultState;

@end
