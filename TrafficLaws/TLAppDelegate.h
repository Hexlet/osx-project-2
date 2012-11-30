//
//  TLAppDelegate.h
//  TrafficLaws
//
//  Created by Igor Smirnov on 14.11.12.
//  Copyright (c) 2012 Igor Smirnov. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "TLTestWindow.h"
#import "TLTest.h"

@interface TLAppDelegate : NSObject <NSApplicationDelegate, NSWindowDelegate>

// приложение
@property (weak) IBOutlet NSApplication *application;

// основное окно
@property (assign) IBOutlet NSWindow *window;

// интерактивность
@property (weak) IBOutlet NSPopUpButton * typeList;      // вид опроса
@property (weak) IBOutlet NSPopUpButton * questionList;  // список отобранных вопросов

@property (weak) IBOutlet TLTest * test;    // собственно, объект со всеми заданиями
@property (weak) IBOutlet TLUtils * utils;  // объект с дополнительными функциями (не касающиеся конкретно этого проекта)

// изменили вид теста
- (IBAction)typeChanged:(NSPopUpButton *)sender;

// начало теста
- (IBAction)startButtonPressed:(id)sender;

// ссылка на окно с вопросом теста
@property (unsafe_unretained) IBOutlet TLTestWindow *testWindow;

@end
