//
//  RData.h
//  dR-3
//
//  Created by Victor Mylcin on 01.12.12.
//  Copyright (c) 2012 Victor Mylcin. All rights reserved.
//

// Структура данных записи учёта денег

#import <Foundation/Foundation.h>

@interface RData : NSObject

@property NSDate *dateOfData;
@property NSString *comment;
@property double money;

@end
