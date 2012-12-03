//
//  Payment.m
//  PaymentsAndExpensesOrganiser
//
//  Created by Eugene on 11/29/12.
//  Copyright (c) 2012 Victorya. All rights reserved.
//

#import "Payment.h"

@implementation Payment

- (id)init{
    if (self = [super init]) {
        _description = @"Enter description of payment/expense";
       
        _amount = 0;
        //todo dates
        
        NSDateFormatter *format = [[NSDateFormatter alloc]init];
        [format setDateStyle: NSDateFormatterShortStyle];
        NSString *stringDate = @"01/01/12";
        _fromDate = [format dateFromString: stringDate];
        _toDate = [format dateFromString: stringDate];
       
        _category = @"Define category";
    }
    return self;
}

@end
