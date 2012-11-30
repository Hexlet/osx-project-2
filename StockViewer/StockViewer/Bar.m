//
//  Bar.m
//  StockViewer
//
//  Created by Tolya on 25.11.12.
//  Copyright (c) 2012 Home. All rights reserved.
//

#import "Bar.h"

@implementation Bar

- (id)init
{
    return [self initWithDate:nil
                         open:0.0
                         high:0.0
                          low:0.0
                        close:0.0
                       volume:0];
}

- (id)initWithDate:(NSDate *)aDate
              open:(float)anOpen
              high:(float)aHigh
               low:(float)aLow
             close:(float)aClose
            volume:(unsigned long)aVolume
{
    if (self = [super init]) {
        _date = [aDate copy];
        _open = anOpen;
        _high = aHigh;
        _low = aLow;
        _close = aClose;
        _volume = aVolume;
    }
    
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    Bar *newBar = [[[self class] allocWithZone:zone] initWithDate:self.date
                                                             open:self.open
                                                             high:self.high
                                                              low:self.low
                                                            close:self.close
                                                           volume:self.volume];
    
    return newBar;
}

@end
