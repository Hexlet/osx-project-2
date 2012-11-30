//
//  TLQuizzArray.m
//  TrafficLaws
//
//  Created by Igor Smirnov on 17.11.12.
//  Copyright (c) 2012 Igor Smirnov. All rights reserved.
//
// массив билетов
// просто для того, чтобы всякий раз не осуществлять приведение типов, да и код читается лучше

#import "TLQuizzArray.h"

@implementation TLQuizzArray {
    NSMutableArray *quizzes;
}

- (id) init {
    self = [super init];
    if (self) {
        quizzes = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void) addQuizz: (TLQuizz *) aQuizz {
    [quizzes addObject: aQuizz];
}

- (NSInteger) count {
    return quizzes.count;
}

- (TLQuizz *) quizzAtIndex: (NSInteger) aIndex {
    return (TLQuizz *) [quizzes objectAtIndex: aIndex];
}

- (NSUInteger) countByEnumeratingWithState: (NSFastEnumerationState *) aState
                                   objects: (__unsafe_unretained id []) aBuffer
                                     count: (NSUInteger) aLen {
    return [quizzes countByEnumeratingWithState: aState
                                        objects: aBuffer
                                          count: aLen];
}

@end
