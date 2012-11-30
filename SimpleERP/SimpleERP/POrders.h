//
//  POrders.h
//  SimpleERP
//
//  Created by Admin on 29.11.12.
//  Copyright (c) 2012 Kabest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface POrders : NSObject {
    NSString *orderNumber;
    NSString *invoiceNumber;
    NSString *providerName;
    NSString *status;
}

@property (copy) NSString *orderNumber;
@property (copy) NSString *invoiceNumber;
@property (copy) NSString *providerName;
@property (copy) NSString *status;

@end
