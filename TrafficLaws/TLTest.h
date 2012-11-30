//
//  TLTest.h
//  TrafficLaws
//
//  Created by Igor Smirnov on 16.11.12.
//  Copyright (c) 2012 Igor Smirnov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLQuizzArray.h"

const static NSInteger ttQuizz = 0;
const static NSInteger ttRandomQuestions = 1;

// этот класс - реализатор протокола NSXMLParserDelegate
// и да, эго экземпляр будет и делегатом
@interface TLTest : NSObject <NSXMLParserDelegate>

@property (readonly) TLQuizzArray * quizzes;    // массив со всеми вопросами

// чтение данных о вопросах из XML
- (void) loadData: (NSData *) aData;

// возвращает список вопросов взависимости от указанных параметров
// (или из одного билета (конкретного или случайного)
// или 20 случайных вопросов из случайных билетов
- (TLQuestionArray *) startNewTest: (NSInteger) aTestType andQuizzNo: (NSInteger) aQuizzNo;

@end
