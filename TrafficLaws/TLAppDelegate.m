//
//  TLAppDelegate.m
//  TrafficLaws
//
//  Created by Igor Smirnov on 14.11.12.
//  Copyright (c) 2012 Igor Smirnov. All rights reserved.
//

#import "TLAppDelegate.h"
#import "TLUtils.h"
#import "TLTest.h"

@implementation TLAppDelegate

// метод, вызывающийся после полной загрузки приложения
- (void)applicationDidFinishLaunching: (NSNotification *) aNotification
{
    // читаем базу вопросов и ответов
    NSData * data = [NSData dataWithContentsOfFile: [self.utils makeFilePath: @"quizz.xml"]];
    [self.test loadData: data];
    
    // формируем список видов тестирования
    [self.typeList removeAllItems];
    [self.typeList addItemsWithTitles: @[@"Указанный билет", @"20 случайных вопросов"]];
    
    for (int i = 0; i < self.typeList.itemArray.count; i++) {
        ((NSPopUpButton *) [self.typeList.itemArray objectAtIndex: i]).tag = i;
    }
    
    // формируем список вопросов
    // вначала специальный пункт
    [self.questionList removeAllItems];
    [self.questionList addItemWithTitle: @"Случайный билет"];
    
    // потом все известные вопросы
    for (int i = 1; i <= self.test.quizzes.count; i++) {
        [self.questionList addItemWithTitle: [NSString stringWithFormat: @"Билет №%d", i]];
    }

}

// если пользователь закрывает основное окно, нам нужно закрыть и приложение
- (void) windowWillClose: (NSNotification *) notification {
    [self.application terminate: self];
}

// начало теста
- (IBAction)startButtonPressed:(id)sender {
    
    // формируем список из вопросов
    TLQuestionArray * questions;
    questions = [self.test startNewTest: self.typeList.indexOfSelectedItem
                             andQuizzNo: self.questionList.indexOfSelectedItem - 1];
    
    // открываем окно с тестированием, передавая список вопросов
    [self.testWindow startWithQuestionArray: questions];
    [NSApp runModalForWindow: self.testWindow];
}

// показать пользователю (запрещаем выбор номера билета),
// что выбор билета возможет только при первом виде теста
- (IBAction)typeChanged:(NSPopUpButton *)sender {
    [self.questionList setEnabled: self.typeList.selectedItem.tag == 0];
}

@end
