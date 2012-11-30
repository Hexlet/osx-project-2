//
//  DataRequest.h
//  StockViewer
//
//  Created by Tolya on 25.11.12.
//  Copyright (c) 2012 Home. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const RequestFailedExceptionName;

@interface DataRequest : NSObject

@property (nonatomic, readwrite, copy) NSString *symbol;
@property (nonatomic, readwrite, copy) NSString *exchange;
@property (nonatomic, readwrite, copy) NSDate *startDate;
@property (nonatomic, readwrite, copy) NSDate *endDate;

- (void)resetToDefaults;

- (NSURL *)csvRequestUrl;
- (NSURL *)htmlRequestUrl;
- (NSArray *)send;

@end
