//
//  TLQuestionVariants.m
//  TrafficLaws
//
//  Created by Igor Smirnov on 16.11.12.
//  Copyright (c) 2012 Igor Smirnov. All rights reserved.
//
// массив вариантов ответа
// просто для того, чтобы всякий раз не осуществлять приведение типов, да и код читается лучше

#import "TLQuestionVariants.h"

@implementation TLQuestionVariants {
    NSMutableArray *variants;
}

- (id) init {
    self = [super init];
    if (self) {
        variants = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSString *) variantAtIndex: (NSInteger) aIndex {
    return (NSString *) [variants objectAtIndex: aIndex];
}

- (void) addVariant: (NSString *) aVariant {
    [variants addObject: aVariant];
}

- (NSInteger) count {
    return variants.count;
}

- (NSUInteger) countByEnumeratingWithState: (NSFastEnumerationState *) aState
                                   objects: (__unsafe_unretained id []) aBuffer
                                     count: (NSUInteger) aLen {
    return [variants countByEnumeratingWithState: aState
                                         objects: aBuffer
                                           count: aLen];
}

@end
