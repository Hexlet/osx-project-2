//
//  NSButton+ButtonTextColor.m
//  testcalc1
//
//  Created by Alexander Shvets on 27.11.12.
//  Copyright (c) 2012 Alexander Shvets. All rights reserved.
//

#import "NSButton+ButtonTextColor.h"

@implementation NSButton (ButtonTextColor)

- (NSColor *)textColor
{
    NSAttributedString *attrTitle = [self attributedTitle];
    int len = (int)[attrTitle length];
    NSRange range = NSMakeRange(0, MIN(len, 1)); // take color from first char
    NSDictionary *attrs = [attrTitle fontAttributesInRange:range];
    NSColor *textColor = [NSColor controlTextColor];
    if(attrs) textColor = [attrs objectForKey:NSForegroundColorAttributeName];

    return textColor;
}

- (void)setTextColor:(NSColor *)textColor
{
    NSMutableAttributedString *attrTitle = [[NSMutableAttributedString alloc] initWithAttributedString:[self attributedTitle]];
    int len = (int)[attrTitle length];
    NSRange range = NSMakeRange(0, len);
    
    [attrTitle addAttribute:NSForegroundColorAttributeName value:textColor range:range];
    [attrTitle fixAttributesInRange:range];
    [self setAttributedTitle:attrTitle];
}


@end
