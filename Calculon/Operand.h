//
//  Operand.h
//  Calculon
//
//  Created by Sachs on 04.12.12.
//  Copyright (c) 2012 SachsHome. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Operand : NSObject {
}

- (id)initWithSelector:(SEL)s operandCount:(int)operandCount;
- (id)initWithStr:(NSString *)operStr;


@property (readonly) SEL ptr;
@property (readonly) int count;
@property (readonly) int order;
@property (readonly) NSString* str;

@end
