//
//  TLQuestionVariants.h
//  TrafficLaws
//
//  Created by Igor Smirnov on 16.11.12.
//  Copyright (c) 2012 Igor Smirnov. All rights reserved.
//
// массив вариантов ответа
// просто для того, чтобы всякий раз не осуществлять приведение типов, да и код читается лучше

#import <Foundation/Foundation.h>

@interface TLQuestionVariants : NSObject <NSFastEnumeration>

@property (readonly) NSInteger count;

- (void) addVariant: (NSString *) aVariant;
- (NSString *) variantAtIndex: (NSInteger) aIndex;

@end
