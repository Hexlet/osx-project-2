//
//  TLQuizz.m
//  TrafficLaws
//
//  Created by Igor Smirnov on 16.11.12.
//  Copyright (c) 2012 Igor Smirnov. All rights reserved.
//

#import "TLQuizz.h"

@implementation TLQuizz

- (TLQuizz *) initWithID: (NSInteger) aID {
    self = [self init];
    if (self) {
        _ID = aID;
        _questions = [[TLQuestionArray alloc] init];
    }
    return self;
}


@end
