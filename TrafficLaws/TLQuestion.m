//
//  TLQuestion.m
//  TrafficLaws
//
//  Created by Igor Smirnov on 16.11.12.
//  Copyright (c) 2012 Igor Smirnov. All rights reserved.
//

#import "TLQuestion.h"

@implementation TLQuestion

- (TLQuestion *) initWithQuizzNumber: (NSInteger) aQuizzNumber andQuestionNumber: (NSInteger) aNumberInQuizz {
    self = [self init];
    if (self) {
        _quizzNumber = aQuizzNumber;
        _numberInQuizz = aNumberInQuizz;
        self.variants = [[TLQuestionVariants alloc] init];
    }
    return self;
}

@end
