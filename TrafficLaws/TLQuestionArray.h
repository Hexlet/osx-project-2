//
//  TLQuestionArray.h
//  TrafficLaws
//
//  Created by Igor Smirnov on 16.11.12.
//  Copyright (c) 2012 Igor Smirnov. All rights reserved.
//
// массив вопросов
// просто для того, чтобы всякий раз не осуществлять приведение типов, да и код читается лучше

#import <Foundation/Foundation.h>
#import "TLQuestion.h"

@interface TLQuestionArray : NSObject <NSFastEnumeration>

@property (readonly) NSInteger count;

- (void) addQuestion: (TLQuestion *) aQuestion;
- (TLQuestion *) questionAtIndex: (NSUInteger) idx;
- (Boolean) haveTheQuestion: (TLQuestion *) aQuestion;

@end
