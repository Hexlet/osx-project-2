//
//  TLQuizz.h
//  TrafficLaws
//
//  Created by Igor Smirnov on 16.11.12.
//  Copyright (c) 2012 Igor Smirnov. All rights reserved.
//
// класс билета с вопросами

#import <Foundation/Foundation.h>
#import "TLQuestionArray.h"

@interface TLQuizz : NSObject

@property (readonly) NSInteger ID;                  // номер билета
@property (readonly) TLQuestionArray *questions;    // перечень вопросов

- (TLQuizz *) initWithID: (NSInteger) aID;

@end
