//
//  CountToEnabledTransformer.m
//  StockViewer
//
//  Created by Anatoliy Dudarchuk on 30.11.12.
//  Copyright (c) 2012 Home. All rights reserved.
//

#import "CountToEnabledTransformer.h"

@implementation CountToEnabledTransformer

+ (Class)transformedValueClass
{
    return [NSNumber class];
}

+ (BOOL)allowsReverseTransformation
{
    return NO;
}

- (id)transformedValue:(id)value
{
    NSInteger count = [value integerValue];
    BOOL isEnabled = count > 0;
    
    return [NSNumber numberWithBool:isEnabled];
}

@end
