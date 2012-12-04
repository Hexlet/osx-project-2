//
//  polishBrain.m
//  Calculon
//
//  Created by Sachs on 04.12.12.
//  Copyright (c) 2012 SachsHome. All rights reserved.
//

#import "polishBrain.h"
#import "Operand.h"

#define STR_FROM_CSTR(s)        [NSString stringWithUTF8String:c];
#define SQR(x)                  ((x)*(x))

#define ERR_CLOSE_BRACKET       (1<<0)
#define ERR_OPEN_BRACKET        (1<<1)
#define ERR_DIV_NULL            (1<<2)
#define ERR_OPERANDS            (1<<3)
#define ERR_IMAGINARY_NUMBER    (1<<4)

#define OP_COUNT    5

@implementation polishBrain {
    NSDecimalNumber *op[OP_COUNT];
}

@synthesize error;

- (id)init {
    if (self = [super init]) {
        NSLog(@"calc init");
        operandSet = [[NSSet alloc] initWithObjects:@"+", @"-", @"n", @"*", @"/", @"^", nil];
        digitSet = [[NSSet alloc] initWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @".", nil];
        bracketSet = [[NSSet alloc] initWithObjects:@"(", @")", nil];
        
        opDict = [[NSMutableDictionary alloc] initWithCapacity:20];
        
        [opDict setObject:[[Operand alloc] initWithSelector:@selector(add) operandCount:2] forKey:@"+"];
        [opDict setObject:[[Operand alloc] initWithSelector:@selector(sub) operandCount:2] forKey:@"-"];
        [opDict setObject:[[Operand alloc] initWithSelector:@selector(neg) operandCount:1] forKey:@"n"];
        [opDict setObject:[[Operand alloc] initWithSelector:@selector(mul) operandCount:2] forKey:@"*"];
        [opDict setObject:[[Operand alloc] initWithSelector:@selector(div) operandCount:2] forKey:@"/"];
        [opDict setObject:[[Operand alloc] initWithSelector:@selector(pow) operandCount:2] forKey:@"^"];
        [opDict setObject:[[Operand alloc] initWithSelector:@selector(sq) operandCount:1] forKey:@"sqr"];
        [opDict setObject:[[Operand alloc] initWithSelector:@selector(sqRoot) operandCount:1] forKey:@"sqrt"];
        [opDict setObject:[[Operand alloc] initWithSelector:@selector(exp) operandCount:1] forKey:@"exp"];
        
        stack = [[NSMutableArray alloc] initWithCapacity:30];
        
        error = 0;
    }
    return self;
}

- (void)reset {
    [stack removeAllObjects];
    error = 0;
}

- (NSArray *)RPNFromInfixString:(NSString *)str {
    
    NSMutableString *s = [NSMutableString stringWithFormat:@"_%@_", str];
    NSMutableArray *rpnArray = [[NSMutableArray alloc] initWithCapacity:20];
    NSMutableArray *operatorStack = [[NSMutableArray alloc] init];
    NSMutableString *part = [NSMutableString stringWithFormat:@""];
    
    BOOL isSign = YES;
    
    for (int i = 0; i < s.length; i++) {
        
        NSString *token = [s substringWithRange:NSMakeRange(i, 1)];
        if ([token isEqualToString:@"-"] && isSign)
            token = @"n";
        
        if ([digitSet containsObject:token]) {
            isSign = NO;
            [part appendString:token];
            NSLog(@"appended %@ (%@)", token, part);
        } else {
            
            if (part.length) {
                [rpnArray addObject:[NSDecimalNumber decimalNumberWithString:part]];
                NSLog(@"added operand: %@", part);
                [part setString:@""];
            }
            
            if ([operandSet containsObject:token]) {
                //isSign = NO;
                Operand *newOp = [[Operand alloc] initWithStr:token];
                while ([operatorStack count]) {
                    Operand *lastOp = [operatorStack lastObject];
                    if (lastOp.order >= newOp.order) {
                        [rpnArray addObject:[NSString stringWithString:lastOp.str]];
                        NSLog(@"added operator %@", lastOp.str);
                        [operatorStack removeLastObject];
                    }
                    else
                        break;
                }
                [operatorStack addObject:newOp];
            } else if ([token isEqualToString: @"("]) {
                isSign = YES;
                [operatorStack addObject:[[Operand alloc] initWithStr:token]];
            } else if ([token isEqualToString: @")"]) {
                isSign = NO;
                BOOL isOpenBracketFound = NO;
                while (operatorStack.count && isOpenBracketFound == NO) {
                    Operand *lastOp = [operatorStack lastObject];
                    [operatorStack removeLastObject];
                    if (![lastOp.str isEqualToString: @"("]) {
                        [rpnArray addObject:lastOp.str];
                        NSLog(@"added operand %@", lastOp.str);
                    }
                    else
                        isOpenBracketFound = YES;
                }
                
                if (!isOpenBracketFound)
                    error |= ERR_OPEN_BRACKET;
                
            } else if ([token isEqualToString: @"_"]) {
                BOOL isStartFound = NO;
                while ([operatorStack count] && isStartFound == NO) {
                    Operand *lastOp = [operatorStack lastObject];
                    [operatorStack removeLastObject];
                    
                    if ([lastOp.str isEqualToString:@"("])
                        error |= ERR_OPEN_BRACKET;
                    
                    if (![lastOp.str isEqualToString:@"("] && ![lastOp.str isEqualToString:@")"]) {
                        [rpnArray addObject:[NSString stringWithString:lastOp.str]];
                        NSLog(@"added operand_ %@", lastOp.str);
                    }
                }
            }
            
        }
    }
    
    if (error)
        [rpnArray removeAllObjects];
    
    return rpnArray;
}

- (void)popOperands:(int)count {
    while (count--) {
        op[count] = [stack lastObject];
        [stack removeLastObject];
    }
}

- (void)addOperand:(double)f {
    [stack addObject:[[NSDecimalNumber alloc] initWithDouble:f]];
}

-(void)operationWithCString:(const char *)c {
    NSString *opKey = STR_FROM_CSTR(c);
    [self operationWithOpKey:opKey];
}

- (void)operationWithOpKey:(NSString *)opKey {
    
    Operand *operand = [opDict objectForKey:opKey];
    if (operand) {
        if (stack.count >= operand.count) {
            [self popOperands:operand.count];
            [stack addObject:[self performSelector:operand.ptr]];
        } else {
            error |= ERR_OPERANDS;
            NSLog(@"error: not enough operands for %@", opKey);
        }
    }
}

// operators

- (NSDecimalNumber *)add {
    return [op[0] decimalNumberByAdding:op[1]];
}

- (NSDecimalNumber *)sub {
    return [op[0] decimalNumberBySubtracting:op[1]];
}

- (NSDecimalNumber *)neg {
    return [[NSDecimalNumber decimalNumberWithString:@"0.0"] decimalNumberBySubtracting:op[0]];
}

- (NSDecimalNumber *)mul {
    return [op[0] decimalNumberByMultiplyingBy:op[1]];
}

- (NSDecimalNumber *)div {
    if (fabs(op[1].doubleValue) > 0.0)
        return [op[0] decimalNumberByDividingBy:op[1]];
    else {
        error |= ERR_DIV_NULL;
        return [[NSDecimalNumber alloc] initWithDouble:0.0];
    }
}

- (NSDecimalNumber *)pow {
    NSDecimalNumber *res;
    if (op[0].doubleValue >= 0.0)
        res = [[NSDecimalNumber alloc] initWithDouble:pow(op[0].doubleValue, op[1].doubleValue)];
    else {
        res = [[NSDecimalNumber alloc] initWithDouble:-pow(-op[0].doubleValue, op[1].doubleValue)];
        error |= ERR_IMAGINARY_NUMBER;
    }
    
    return res;
}

- (NSDecimalNumber *)exp {
    return [[NSDecimalNumber alloc] initWithDouble:exp(op[0].doubleValue)];
}

- (NSDecimalNumber *)sq {
    return [[NSDecimalNumber alloc] initWithDouble:SQR(op[0].doubleValue)];
}

- (NSDecimalNumber *)sqRoot {
    NSDecimalNumber *res;
    if (op[0].doubleValue >= 0.0)
        res = [[NSDecimalNumber alloc] initWithDouble:sqrt(op[0].doubleValue)];
    else
        res = [[NSDecimalNumber alloc] initWithDouble:0.0];
    
    return res;
}

- (NSString *)description {
    NSString *s =[NSString stringWithFormat:@"%@", stack];
    if (error)
        s = [s stringByAppendingFormat:@" error: 0x%.4X", error];
    
    return s;
}

- (double)result {
    double res = [stack.lastObject doubleValue];
    if (error) {
        if (error & ERR_DIV_NULL)
            res = INFINITY;
        else
            res = 0.0;
    }
    
    return res;
}

@end
