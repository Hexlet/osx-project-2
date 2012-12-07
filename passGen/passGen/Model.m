//
//  Model.m
//  passGen
//
//  Created by padawan on 13.11.12.
//  Copyright (c) 2012 padawan. All rights reserved.
//

#import "Model.h"

@implementation Model
- (id) init {
    self = [super init];
    if(self) {
        lengthPass = [NSNumber numberWithInt:10];
        lowerCase = [NSMutableArray arrayWithObjects:
                     @"a", @"b", @"c", @"d", @"e", @"f", @"g", @"h", @"i", @"g", @"k", @"l", @"m",
                      @"n", @"o", @"p", @"q", @"r", @"s", @"t", @"u", @"v", @"w", @"x", @"y", @"z",
                     nil];
        upperCase = [NSMutableArray arrayWithObjects:
                     @"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"G", @"K", @"L", @"M",
                     @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z",
                     nil];
        numeric = [NSMutableArray arrayWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9",nil];
    }
    return self;
}

-(IBAction)generate:(id)sender {
    NSString *pass;
    pass = [NSString string];
    
//    [enableLowerCase intValue];
//    [passwordField setIntValue:1];
    for (int i=0; i<[lengthPass intValue]; i++) {
        
    }
}

-(IBAction)copyToClipboard:(id)sender {
    
}

@end
