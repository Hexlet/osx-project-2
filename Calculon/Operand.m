//
//  Operand.m
//  Calculon
//
//  Created by Sachs on 04.12.12.
//  Copyright (c) 2012 SachsHome. All rights reserved.
//

#import "Operand.h"

@implementation Operand {
}

@synthesize ptr;
@synthesize count;
@synthesize order;
@synthesize str;

- (id)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (id)initWithSelector:(SEL)s operandCount:(int)operandCount {
    if (self = [super init]) {
        ptr = s;
        count = operandCount;
    }
    return self;
}

- (id)initWithStr:(NSString *)operStr {
    if (self = [super init]) {
        str = operStr;
        if ([str isEqualToString:@"^"])
            order = 4;
        else if ([str isEqualToString: @"*"] || [str isEqualToString: @"/"])
            order = 3;
        if ([str isEqualToString: @"+"] || [str isEqualToString: @"-"] || [str isEqualToString:@"n"])
            order = 2;
        else if ([str isEqualToString: @")"])
            order = 1;
        else if ([str isEqualToString: @"("])
            order = 0;
    }
    return self;
}

- (NSString *)description {
    return str;
}

@end

