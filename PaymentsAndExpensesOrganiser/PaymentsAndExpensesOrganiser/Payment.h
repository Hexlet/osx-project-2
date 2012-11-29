//
//  Payment.h
//  PaymentsAndExpensesOrganiser
//
//  Created by Eugene on 11/29/12.
//  Copyright (c) 2012 Victorya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Payment : NSObject

@property NSString* description;
@property float amount;
@property NSDate* dates;
@property NSDate* dateOfRemaining;
@property NSString* category;

@end
