//
//  DataRequest.m
//  StockViewer
//
//  Created by Tolya on 25.11.12.
//  Copyright (c) 2012 Home. All rights reserved.
//

#import "DataRequest.h"
#import "Bar.h"

NSString * const RequestFailedExceptionName = @"RequestFailed";
NSString * const CsvRequestUrlFormat        = @"http://finance.google.com/finance/historical?q=%@:%@&startdate=%@&enddate=%@&output=csv";
NSString * const HtmlRequestUrlFormat       = @"http://www.google.com/finance/historical?q=%@:%@&startdate=%@&enddate=%@";
NSString * const ResponseColumnSeparator    = @",";
NSInteger const ResponseColumnsCount        = 6;

@interface DataRequest () {
    NSDateFormatter *_dateFormatter;
}

- (void)validate;
- (NSArray *)barsParsedFromResponse:(NSString *)aResponse;
- (Bar *)barParsedFromResponseLine:(NSString *)aResponseLine;

@end


@implementation DataRequest

- (id)init
{
    if (self = [super init]) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.dateFormat = @"d-MM-yy";
        _dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en-US"];
        _dateFormatter.calendar = [NSCalendar currentCalendar];
        _dateFormatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    }
    
    return self;
}

- (void)resetToDefaults
{
    const NSTimeInterval secondsInMonth = 30 * 24 * 60 * 60;
    
    self.symbol = @"GOOG";
    self.exchange = @"NASDAQ";
    self.startDate = [NSDate dateWithTimeIntervalSinceNow:-secondsInMonth];
    self.endDate = [NSDate date];
}

- (void)validate
{
    self.symbol = [self.symbol stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (self.symbol.length == 0) {
        @throw [NSException exceptionWithName:RequestFailedExceptionName
                                       reason:@"Symbol is not specified."
                                     userInfo:nil];
    }
    
    self.exchange = [self.exchange stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (self.exchange.length == 0) {
        @throw [NSException exceptionWithName:RequestFailedExceptionName
                                       reason:@"Exchange is not specified."
                                     userInfo:nil];
    }
    
    if ([self.startDate compare:self.endDate] == NSOrderedDescending) {
        @throw [NSException exceptionWithName:RequestFailedExceptionName
                                       reason:@"Start date cannot be greater than end date."
                                     userInfo:nil];
    }
}

- (NSURL *)csvRequestUrl
{
    [self validate];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"MM.dd.yyyy";
    
    NSString *startDateString = [formatter stringFromDate:self.startDate];
    NSString *endDateString = [formatter stringFromDate:self.endDate];
    NSString *url = [NSString stringWithFormat:CsvRequestUrlFormat, self.exchange, self.symbol, startDateString, endDateString];
    
    return [NSURL URLWithString:url];
}

- (NSURL *)htmlRequestUrl
{
    [self validate];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"MM.dd.yyyy";
    
    NSString *startDateString = [formatter stringFromDate:self.startDate];
    NSString *endDateString = [formatter stringFromDate:self.endDate];
    NSString *url = [NSString stringWithFormat:HtmlRequestUrlFormat, self.exchange, self.symbol, startDateString, endDateString];
    
    return [NSURL URLWithString:url];
}

- (NSArray *)barsParsedFromResponse:(NSString *)aResponse
{
    NSMutableArray *bars = nil;
    
    NSArray *rows = [aResponse componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    NSUInteger rowsCount = [rows count];
    if (rowsCount > 0) {
        bars = [[NSMutableArray alloc] initWithCapacity:rowsCount - 1];

        for (NSUInteger rowIndex = 1; rowIndex < rowsCount; rowIndex++) {
            NSString *line = [[rows objectAtIndex:rowIndex] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            if ([line length] > 0) {
                Bar *bar = [self barParsedFromResponseLine:line];
                [bars addObject:bar];
            }
        }
    }
    
    return bars;
}

- (Bar *)barParsedFromResponseLine:(NSString *)aResponseLine
{
    NSArray *columns = [aResponseLine componentsSeparatedByString:ResponseColumnSeparator];
    if ([columns count] != ResponseColumnsCount) {
        NSString *message = [NSString stringWithFormat:@"Unable to parse '%@'. Expected %ld columns but got %ld.", aResponseLine, ResponseColumnsCount, [columns count]];
        @throw [NSException exceptionWithName:RequestFailedExceptionName
                                       reason:message
                                     userInfo:nil];
    }
    
    Bar *bar = [[Bar alloc] init];
    bar.date = [_dateFormatter dateFromString:[columns objectAtIndex:0]];
    bar.open = [[columns objectAtIndex:1] floatValue];
    bar.high = [[columns objectAtIndex:2] floatValue];
    bar.low = [[columns objectAtIndex:3] floatValue];
    bar.close = [[columns objectAtIndex:4] floatValue];
    bar.volume = [[columns objectAtIndex:5] longLongValue];
    
    return bar;
}

- (NSArray *)send
{
    NSError *error;
    NSString *response = [NSString stringWithContentsOfURL:[self csvRequestUrl]
                                                  encoding:NSASCIIStringEncoding
                                                     error:&error];
    if (error) {
        @throw [NSException exceptionWithName:RequestFailedExceptionName
                                       reason:[error localizedFailureReason]
                                     userInfo:nil];
    }
    
    return [self barsParsedFromResponse:response];
}

@end
