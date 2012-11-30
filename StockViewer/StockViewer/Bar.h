//
//  Bar.h
//  StockViewer
//
//  Created by Tolya on 25.11.12.
//  Copyright (c) 2012 Home. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Bar : NSObject<NSCopying>

@property (nonatomic, readwrite, retain) NSDate *date;
@property (nonatomic, readwrite, assign) float open;
@property (nonatomic, readwrite, assign) float high;
@property (nonatomic, readwrite, assign) float low;
@property (nonatomic, readwrite, assign) float close;
@property (nonatomic, readwrite, assign) unsigned long volume;

- (id)initWithDate:(NSDate *)aDate
              open:(float)anOpen
              high:(float)aHigh
               low:(float)aLow
             close:(float)aClose
            volume:(unsigned long)aVolume;

@end
