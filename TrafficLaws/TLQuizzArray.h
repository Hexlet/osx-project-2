//
//  TLQuizzArray.h
//  TrafficLaws
//
//  Created by Igor Smirnov on 17.11.12.
//  Copyright (c) 2012 Igor Smirnov. All rights reserved.
//
// массив билетов
// просто для того, чтобы всякий раз не осуществлять приведение типов, да и код читается лучше

#import <Foundation/Foundation.h>
#import "TLQuizz.h"

@interface TLQuizzArray : NSObject <NSFastEnumeration>

@property (readonly) NSInteger count;

- (void) addQuizz: (TLQuizz *) aQuizz;
- (TLQuizz *) quizzAtIndex: (NSInteger) aIndex;

@end
