//
//  TLTestWindow.m
//  TrafficLaws
//
//  Created by Igor Smirnov on 21.11.12.
//  Copyright (c) 2012 Igor Smirnov. All rights reserved.
//

#import "TLTestWindow.h"

// объявляем константы в одном месте
NSString * const questionTimeFormatWithHours = @"Время на вопросе: %d.%.2d:%.2d";
NSString * const questionTimeFormat = @"Время на вопросе: %.2d:%.2d";
NSString * const quizzTimeFormatWithHours = @"Общее время: %d.%.2d:%.2d";
NSString * const quizzTimeFormat = @"Общее время: %.2d:%.2d";
NSString * const imageNameMask = @"pdd2011_%lu_%lu.jpg";
NSString * const imageNameNoImage = @"noimage.jpg";
NSString * const imageOk = @"ok.jpg";
NSString * const imageBad = @"bad.jpg";

@implementation TLTestWindow {
    TLQuestionArray * questions;        // список вопросов для теста
    NSTimer * quizzTimer;               // таймер для обновления времени для теста
    NSTimer * questionTimer;            // таймер для обновления времени для вопроса
    NSUInteger currentQuestionIndex;    // индекс текущего вопроса в тесте
    NSDate * quizzStartTime;            // отметка о начале теста
    NSDate * questionStartTime;         // отметка о начале вопроса
}

// геттер для свойства с текущим вопросом
- (TLQuestion *) currentQuestion {
    return [questions questionAtIndex: currentQuestionIndex];
}

// нажали кнопку "закрыть"
- (IBAction)closeButtonClick:(id)sender {
    [NSApp stopModal];
    [self close];
}

// метод показа всплывающего окна
- (void) showPopoverForQuestion: (NSInteger) aIndex withResult: (Boolean) aResult {
    TLQuestion *question = self.currentQuestion;
    
    // установка изображения: галочка или крестик
    NSString * imageFileName = aResult ? imageOk : imageBad;
    imageFileName = [self.utils makeFilePath: imageFileName];
    [self.popoverImage setImage: [[NSImage alloc] initWithContentsOfFile: imageFileName]];
    
    // устанавливаем текст подсказки
    [self.popoverTextField setStringValue: question.notes];

    // выясняем координаты откуда показать окно, чтобы оно соответствовало низу
    // ячейки, которую передали в параметрах
    NSRect rect =  [self.answersMatrix cellFrameAtRow: question.correctVariantIndex column:0];
    
    // показываем окно
    [self.popover showRelativeToRect: rect ofView: self.answersMatrix preferredEdge: NSMaxYEdge];
}

// нажали кнопку "подсказка", открываем всплывающее окно по координатам правильного ответа
- (IBAction)helpButtonClick:(id) aSender {
    [self showPopoverForQuestion: currentQuestionIndex withResult: true];
}

// нажали кнопку "выбрать ответ"
- (IBAction)nextButtonClick:(id)sender {
    // анализируем правильность ответа
    if (self.answersMatrix.selectedRow == self.currentQuestion.correctVariantIndex) {
        [self nextQuestion];
    } else {
        // если неверно, показываем подсказку с верным ответом
        [self showPopoverForQuestion: self.currentQuestion.correctVariantIndex withResult: false];
    }
}

// нажали кнопку "закрыть"
- (IBAction)closePopoverClick:(id)sender {
    [self.popover close];
}

// функция для преобразования указанной даты в строку (интервал)
- (void) convertTime: (NSDate *) date
               hours: (int *) aHours
             minutes: (int *) aMinutes
             seconds: (int *) aSeconds {
    NSTimeInterval diff = -[date timeIntervalSinceNow];
    *aSeconds = ((int) diff) % 60;
    *aMinutes = ((int) diff) / 60 % 60;
    *aHours = ((int) diff) / (60 * 60);
}

// вызывается таймером: обновление времени задания
- (void) updateQuizzTimeTextField {
    int hours, minutes, seconds;
    [self convertTime: quizzStartTime hours: &hours minutes: &minutes seconds: &seconds];
    if (hours > 0) {
        [self.quizzTimeTextField setStringValue: [NSString stringWithFormat: quizzTimeFormatWithHours, hours, minutes, seconds]];
    } else {
        [self.quizzTimeTextField setStringValue: [NSString stringWithFormat: quizzTimeFormat, minutes, seconds]];
    }
}

// вызывается таймером: обновление времени вопроса
- (void) updateQuestionTimeTextField {
    int hours, minutes, seconds;
    [self convertTime: questionStartTime hours: &hours minutes: &minutes seconds: &seconds];
    if (hours > 0) {
        [self.questionTimeTextField setStringValue: [NSString stringWithFormat: questionTimeFormatWithHours, hours, minutes, seconds]];
    } else {
        [self.questionTimeTextField setStringValue: [NSString stringWithFormat: questionTimeFormat, minutes, seconds]];
    }
}

// выбор следующего вопроса в задании
- (void) nextQuestion {
    
    // прибавляем индекс и отсекаем время
    currentQuestionIndex++;
    questionStartTime = [NSDate date];

    // если это последний вопрос - тест окончен
    if (currentQuestionIndex >= questions.count) {
        [self performClose: self];
    }
    
    // меняем тескт вопроса
    TLQuestion *question = self.currentQuestion;
    [self.questionTextField setStringValue: question.text];
    
    // и изображение
    NSString * imageFileName = [NSString stringWithFormat: imageNameMask, question.quizzNumber, question.numberInQuizz ];
    imageFileName = [self.utils makeFilePath: imageFileName];
    NSImage * img = [[NSImage alloc] initByReferencingFile: imageFileName];
    if (img.size.width == 0) {
        img = [[NSImage alloc] initWithContentsOfFile: [self.utils makeFilePath: imageNameNoImage]];
    }
    [self.questionImageView setImage: img];
    
    // меняем список ответов
    // вот тут вопрос. на форуме так и не ответили. матрица с Radio Button
    // при изменении количества строк почему-то изменяет не высоту, а верхнюю
    // координату. поэтому. запоминаем текущие координаты матрицы, меняем,
    // потом восстанавливаем размеры
    NSRect originalFrame = self.answersMatrix.frame;
    
    while (self.answersMatrix.numberOfRows > 1) {
        [self.answersMatrix removeRow: 0];
    }
    for (int i = 0; i < question.variants.count; i++) {
        if (i != 0) {
            [self.answersMatrix addRow];
        }
        NSButtonCell * cell = [self.answersMatrix cellAtRow: i column: 0];
        cell.title = [question.variants variantAtIndex: i];
    }
    [self.utils makeRadioGroupWarppableWithWidth: self.answersMatrix];
    [self.answersMatrix sizeToCells];
    NSRect newFrame = [self.answersMatrix frame];
    CGFloat delta = newFrame.size.height - originalFrame.size.height;
    newFrame.origin.y -= delta;
    [self.answersMatrix setFrame:newFrame];
    
    // обновляем номера билета и вопроса
    [self.quizzNumberTextField setStringValue: [NSString stringWithFormat: @"Билет №%lu", question.quizzNumber]];
    [self.questionNumberTextField setStringValue: [NSString stringWithFormat: @"Вопрос №%lu", question.numberInQuizz]];
    
    // взводим новый таймер времени вопроса
    questionTimer = [NSTimer timerWithTimeInterval: 1.0f
                                            target: self
                                          selector: @selector(updateQuestionTimeTextField)
                                          userInfo: nil
                                           repeats: true];
    [[NSRunLoop mainRunLoop] addTimer: questionTimer
                              forMode: NSModalPanelRunLoopMode];
}

// начать тест с указанным списком вопросов
- (void) startWithQuestionArray: (TLQuestionArray *) aQuestions {
    questions = aQuestions;
    currentQuestionIndex = -1;
    quizzStartTime = [NSDate date];
    
    quizzTimer = [NSTimer timerWithTimeInterval: 1.0f
                                         target: self
                                       selector: @selector(updateQuizzTimeTextField)
                                       userInfo: nil
                                        repeats: true];
    [[NSRunLoop mainRunLoop] addTimer: quizzTimer
                              forMode: NSModalPanelRunLoopMode];
    [self nextQuestion];
}

@end
