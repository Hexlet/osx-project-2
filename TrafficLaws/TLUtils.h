//
//  TLUtils.h
//  TrafficLaws
//
//  Created by Igor Smirnov on 16.11.12.
//  Copyright (c) 2012 Igor Smirnov. All rights reserved.
//
//  вынесенные из основного проекта дополнительные функции

#import <Foundation/Foundation.h>

@interface TLUtils : NSObject

// хранит путь до приложения
@property (readonly) NSString * bundlePath;

// конвертирует имя файла в путь до него, с учетом местарасположения приложения
- (NSString *) makeFilePath: (NSString *) aFileName;

// слизано у Google Toolbox for Mac:
// изменение размеров ячеек у матрицы для того, чтобы работал word wrap
- (void) makeRadioGroupWarppableWithWidth: (NSMatrix *) aRadioGroup;

@end
