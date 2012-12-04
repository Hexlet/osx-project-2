//
//  polishBrain.h
//  Calculon
//
//  Created by Sachs on 04.12.12.
//  Copyright (c) 2012 SachsHome. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface polishBrain : NSObject {
    NSSet *operandSet;
    NSSet *digitSet;
    NSSet *bracketSet;
    NSMutableDictionary *opDict;
    NSMutableArray *stack;
}

- (void)addOperand:(double)f;
- (void)popOperands:(int)count;

- (NSDecimalNumber *)add;
- (NSDecimalNumber *)sub;
- (NSDecimalNumber *)mul;
- (NSDecimalNumber *)div;
- (NSDecimalNumber *)pow;
- (NSDecimalNumber *)exp;
- (NSDecimalNumber *)sq;
- (NSDecimalNumber *)sqRoot;

- (void)reset;
- (void)operationWithCString:(const char *)c;
- (void)operationWithOpKey:(NSString *)opKey;
- (NSArray *)RPNFromInfixString:(NSString *)s;
- (double)result;

@property (readonly) u_int16_t error;
@end
