//
//  ResultsItem.m
//  PowerRegexTester
//
//  Created by Igor on 12/23/12.
//  Copyright (c) 2012 Igor Redchuk. All rights reserved.
//

#import "ResultsItem.h"

@interface ResultsItem()

@property NSString *string;
@property NSRange rangeInSource;
@property NSUInteger groupLevel;

@end

@implementation ResultsItem

-(id) initWithString:(NSString *)string
       rangeInSource:(NSRange)range
          groupLevel:(NSUInteger)level
{
    if (self = [super init]) {
        self.string = string;
        self.rangeInSource = range;
        self.groupLevel = level;
    }
    return self;
}

+(NSArray *)resultsItemsFromMatchesWithGroups:(NSArray *)matchesWithGroups
                              andSourceString:(NSString *)sourceString
{
    NSMutableArray *items = [NSMutableArray array];
    for (NSArray *match in matchesWithGroups) {
        if (match.count == 0) { continue; }
        for (int index = 0; index < match.count; index++) {
            NSRange range = ((NSValue *)match[index]).rangeValue;
            ResultsItem *item = [[ResultsItem alloc]initWithString:[sourceString substringWithRange:range]
                                                     rangeInSource:range
                                                        groupLevel:(index == 0 ? 0 : 1)];
            [items addObject:item];
        }
    }
    return items;
}

-(id) copyWithZone:(NSZone *)zone {
    ResultsItem *copy = [[ResultsItem allocWithZone:zone]initWithString:self.string rangeInSource:self.rangeInSource groupLevel:self.groupLevel];
    return copy;
}

-(NSString *)description {
    return self.string;
}

@end
