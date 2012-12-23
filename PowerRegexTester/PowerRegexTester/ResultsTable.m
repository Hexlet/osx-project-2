//
//  ResultsTableViewController.m
//  PowerRegexTester
//
//  Created by Igor on 12/22/12.
//  Copyright (c) 2012 Igor Redchuk. All rights reserved.
//

#import "ResultsTable.h"

@implementation ResultsTable
{
    NSString *sourceString;
    NSArray *rangesOfMatches;
}

- (void) setSourceString:(NSString *)string
      andRangesOfMatches:(NSArray *)matches
{
    sourceString = [string copy];
    rangesOfMatches = [matches copy];
}

#pragma mark == NSTableViewDataSource implementation ==
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return rangesOfMatches.count;
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    return [self sourceSubstringForMatchWithIndex:row];
}

- (NSString *)sourceSubstringForMatchWithIndex:(NSInteger)index {
    NSArray *match = rangesOfMatches[index];
    NSRange range = ((NSValue *)match[0]).rangeValue;
    return [sourceString substringWithRange:range];
}

@end
