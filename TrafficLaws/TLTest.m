//
//  TLTest.m
//  TrafficLaws
//
//  Created by Igor Smirnov on 16.11.12.
//  Copyright (c) 2012 Igor Smirnov. All rights reserved.
//

#import "TLTest.h"
#import "TLQuizz.h"
#import "TLQuestion.h"

@implementation TLTest {
    
    NSMutableString * currentText;      // текущий текст в текущем тэге
    TLQuizz * currentQuizz;             // текущий билет
    TLQuestion * currentQuestion;       // текущий вопрос
    Boolean currentVariantIsValid;      // признак того, что текущий вариант ответа - верный
    TLQuestionArray * testQuestions;    // массив с вопросами, отобранными для теста
}

// конструктор
- (id) init {
    self = [super init];
    if (self) {
        _quizzes = [[TLQuizzArray alloc] init];
    }
    return self;
}

// чтение данных о вопросах
- (void) loadData: (NSData *) aData {
    
    // создаем парсер XML
    NSXMLParser * parser = [[NSXMLParser alloc] initWithData: aData];
    
    // настройки парсера
    [parser setShouldReportNamespacePrefixes: false];
    [parser setShouldResolveExternalEntities: false];
    
    // устанавливаем в качестве делегата себя
    [parser setDelegate: self];
    
    // запускаем парсер
    [parser parse];
}

// метод из протокола NSXMLParserDelegate
// вызывается всякий раз, когда парсер встречает новый Tag
- (void) parser: (NSXMLParser *) parser
didStartElement: (NSString *) elementName
   namespaceURI: (NSString *) namespaceURI
  qualifiedName: (NSString *) qualifiedName
     attributes: (NSDictionary *) attributeDict {

    // новый Tag - новый текст
    currentText = [@"" mutableCopy];
    
    // новый билет
    if ([elementName isEqualToString: @"Quizz"]) {
        currentQuizz = [[TLQuizz alloc] initWithID: [[attributeDict valueForKey: @"ID"] integerValue]];
        return;
    } else
        
    // если у нас уже есть вопрос, который мы начали парсить
    if (currentQuizz) {
            
        // новый вопрос в билете
        if ([elementName isEqualToString: @"Question"]) {
            currentQuestion = [[TLQuestion alloc] initWithQuizzNumber: currentQuizz.ID andQuestionNumber: [[attributeDict valueForKey: @"No"] integerValue]];
            return;
        } else
            
            if (currentQuestion) {
                
                // новый вариант
                if ([elementName isEqualToString: @"Variant"]) {
                    currentVariantIsValid = [[attributeDict valueForKey: @"IsCorrect"] integerValue] != 0;
                }
            }
    }
}

// метод из протокола NSXMLParserDelegate
// вызывается всякий раз, когда парсер встречает /Tag
- (void) parser: (NSXMLParser *)parser
  didEndElement: (NSString *)elementName
   namespaceURI: (NSString *)namespaceURI
  qualifiedName: (NSString *)qName {
    
    if (currentQuizz) {
        
        // окончание обработки билета
        if ([elementName isEqualToString: @"Quizz"]) {
            // просто добавляем его в массив билетов
            [self.quizzes addQuizz: currentQuizz];
            currentQuizz = nil;
            return;
        }
        
        if (currentQuestion) {
            
            // окончание обработки вопроса
            if ([elementName isEqualToString: @"Question"]) {
                
                // добавляем его в список вопросов билета
                [currentQuizz.questions addQuestion: currentQuestion];
                currentQuestion = nil;
                return;
            } else
            
            // текст вопроса
            if ([elementName isEqualToString: @"Text"]) {
                currentQuestion.text = currentText;
                currentText = nil;
                return;
            }

            // вариант ответа
            if ([elementName isEqualToString: @"Variant"]) {
                [currentQuestion.variants addVariant: [currentText copy]];
                // если это правильный вариант, сохраняем его номер
                if (currentVariantIsValid) {
                    currentQuestion.correctVariantIndex = currentQuestion.variants.count - 1;
                    //NSLog(@"%@", currentText);
                }
                return;
            } else
            
            // описание правильного отвера на вопрос
            if ([elementName isEqualToString: @"Notes"]) {
                currentQuestion.notes = currentText;
                return;
            }
        }
    }
}


// метод из протокола NSXMLParserDelegate
// вызывается всякий раз, когда парсер встречает текст внутри Tag
- (void)parser: (NSXMLParser *) parser foundCharacters: (NSString *) string {
    if (string && currentText) {
        [currentText appendString: string];
    }
}

// формирует список вопросов по патаметрам теста
- (TLQuestionArray *) startNewTest: (NSInteger) aTestType andQuizzNo: (NSInteger) aQuizzNo {
    testQuestions = [[TLQuestionArray alloc] init];
    
    switch ( aTestType ) {
        // просто билет
        case ttQuizz: {
            NSUInteger selectedQuizzNo = (aQuizzNo < 0) ? arc4random() % [self.quizzes count] : aQuizzNo;
            
            for ( TLQuestion * question in [self.quizzes quizzAtIndex: selectedQuizzNo].questions ) {
                [testQuestions addQuestion: question];
            }
            break;
        }
        
        // 20 случайных вопросов
        case ttRandomQuestions: {
            int quizzIndex, questionIndex;
            TLQuestion * selectedQuestion;
            TLQuizz * selectedQuizz;
            
            for (int i = 0; i < 20; i++) {
                do {
                    quizzIndex = arc4random() % [self.quizzes count];
                    selectedQuizz = [self.quizzes quizzAtIndex: quizzIndex];
                    questionIndex = arc4random() % selectedQuizz.questions.count;
                    selectedQuestion = [selectedQuizz.questions questionAtIndex: questionIndex];
                    // цикл для исключения 2х одинаковых вопросов
                } while ( [testQuestions haveTheQuestion: selectedQuestion] );
                [testQuestions addQuestion: selectedQuestion];
            }
            break;
        }
    }
    return testQuestions;
}


@end
