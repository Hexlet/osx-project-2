//
//  TLQuestion.h
//  TrafficLaws
//
//  Created by Igor Smirnov on 16.11.12.
//  Copyright (c) 2012 Igor Smirnov. All rights reserved.
//
// класс вопроса с вариантами ответов

#import <Foundation/Foundation.h>
#import "TLQuestionVariants.h"

@interface TLQuestion : NSObject

@property (readonly) NSInteger numberInQuizz;       // номер вопроса в билете
@property (readonly) NSInteger quizzNumber;         // номер билета

@property (copy) NSString *text;                    // текст вопроса
@property (strong) TLQuestionVariants *variants;    // варианты ответа
@property (copy) NSString *notes;                   // описание правильного варианта ответа
@property (assign) NSUInteger correctVariantIndex;  // индекс правильного варианта

// конструктор
- (TLQuestion *) initWithQuizzNumber: (NSInteger) aQuizzNumber
                   andQuestionNumber: (NSInteger) aNumberInQuizz;

@end
