//
//  POrders.m
//  SimpleERP
//
//  Created by Admin on 29.11.12.
//  Copyright (c) 2012 Kabest. All rights reserved.
//

#import "POrders.h"

@implementation POrders

@synthesize orderNumber;
@synthesize invoiceNumber;
@synthesize providerName;
@synthesize status;

-(id) init {
    self = [super init];
    if (self) {
        orderNumber = @"1234";
        invoiceNumber = @"532";
        providerName = @"IBM";
        status = @"Received";
    }
    return self;
}

@end
