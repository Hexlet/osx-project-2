//
//  DigitsOnlyFormatter.m
//  Calculator
//
//  Created by Alexander Shvets on 04.12.12.
//  Copyright (c) 2012 Alexander Shvets. All rights reserved.
//

#import "DigitsOnlyFormatter.h"

@implementation DigitsOnlyFormatter

- (BOOL) isPartialStringValid: (NSString **) partialStringPtr
        proposedSelectedRange: (NSRangePointer) proposedSelRangePtr
               originalString: (NSString *) origString
        originalSelectedRange: (NSRange) origSelRange
             errorDescription: (NSString **) error
{
    NSCharacterSet *nonDigits;
    NSRange newStuff;
    NSString *newStuffString;
    
    nonDigits = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789.-"] invertedSet];
        
    newStuff = NSMakeRange(origSelRange.location, proposedSelRangePtr->location - origSelRange.location);
    newStuffString = [*partialStringPtr substringWithRange: newStuff];
    
    if ([newStuffString rangeOfCharacterFromSet: nonDigits options: NSLiteralSearch].location != NSNotFound) {
        *error = @"Input is not an number";
        return (NO);
    } else  {
        *error = nil;
        return (YES);
    }
    
}

@end
