//
//  TLTestWindow.h
//  TrafficLaws
//
//  Created by Igor Smirnov on 21.11.12.
//  Copyright (c) 2012 Igor Smirnov. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "TLTest.h"
#import "TLUtils.h"

// окно с тестированием
@interface TLTestWindow : NSWindow

@property (weak) IBOutlet NSTextField *quizzNumberTextField;    // текстовое поле номера билета
@property (weak) IBOutlet NSTextField *quizzTimeTextField;      // текстовое поле прошедшего времени для задания
@property (weak) IBOutlet NSTextField *questionNumberTextField; // текстовое поле номера вопроса из билета
@property (weak) IBOutlet NSImageView *questionImageView;       // изображение для вопроса
@property (weak) IBOutlet NSTextField *questionTextField;       // текстовое поле текста вопроса
@property (weak) IBOutlet NSTextField *questionTimeTextField;   // текстовое поле прошедшего времени для вопроса

@property (weak) IBOutlet NSMatrix *answersMatrix;              // визуальный элемент со списком ответов на вопрос

@property (weak) IBOutlet NSPopover *popover;                   // объект, показывающий всплывающее окно с подсказкой
@property (weak) IBOutlet NSImageView *popoverImage;            // изображение в подсказке
@property (weak) IBOutlet NSTextField *popoverTextField;        // текст подсказки

@property (weak) IBOutlet TLTest * test;                        // собственно, объект со всеми заданиями
@property (weak) IBOutlet TLUtils * utils;                      // объект с дополнительными функциями (не касающиеся конкретно этого проекта)

@property (readonly) TLQuestion * currentQuestion;              // текущий вопрос

- (IBAction)closeButtonClick:(id)sender;                        // нажали кнопку "закрыть"
- (IBAction)helpButtonClick:(id)sender;                         // нажали кнопку "подсказка"
- (IBAction)nextButtonClick:(id)sender;                         // нажали кнопку "выбрать ответ"
- (IBAction)closePopoverClick:(id)sender;

- (void) startWithQuestionArray: (TLQuestionArray *) questions; // начать тест с указанным списком вопросов
- (void) updateQuizzTimeTextField;                              // вызывается таймером: обновление времени задания
- (void) updateQuestionTimeTextField;                           // вызывается таймером: обновление времени вопроса
@end
