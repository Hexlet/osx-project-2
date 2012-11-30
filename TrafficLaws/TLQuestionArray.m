//
//  TLQuestionArray.m
//  TrafficLaws
//
//  Created by Igor Smirnov on 16.11.12.
//  Copyright (c) 2012 Igor Smirnov. All rights reserved.
//
// массив вопросов
// просто для того, чтобы всякий раз не осуществлять приведение типов, да и код читается лучше

#import "TLQuestionArray.h"

@implementation TLQuestionArray {
    NSMutableArray *questions;
}

- (id) init {
    self = [super init];
    if (self) {
        questions = [[NSMutableArray alloc] init];
    }
    return self;
}

- (TLQuestion *) questionAtIndex: (NSUInteger) idx {
    return [questions objectAtIndex: idx];
}

- (void) addQuestion: (TLQuestion *) aQuestion {
    [questions addObject: aQuestion];
}

- (NSInteger) count {
    return questions.count;
}

- (NSUInteger) countByEnumeratingWithState: (NSFastEnumerationState *) aState
                                   objects: (__unsafe_unretained id []) aBuffer
                                     count: (NSUInteger) aLen {
    return [questions countByEnumeratingWithState: aState
                                          objects: aBuffer
                                            count: aLen];
}

- (Boolean) haveTheQuestion: (TLQuestion *) aQuestion {
    for (TLQuestion * question in questions) {
        if ( aQuestion == question )
            return true;
        
    }
    return false;
}


@end
