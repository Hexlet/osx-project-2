//
//  DataTableViewController.m
//  dR-3
//
//  Created by Victor Mylcin on 01.12.12.
//  Copyright (c) 2012 Victor Mylcin. All rights reserved.
//

#import "DataTableViewController.h"
#import "RData.h"

@implementation DataTableViewController

- (id)init
{
    self = [super init];
    if (self) {
        dataArray = [[NSMutableArray alloc] init];
        summa = [[NSNumber alloc] initWithDouble:0];
        [self addObserver:self forKeyPath:@"summa" options:0 context:@"0"];
    }
    return self;
}

- (void)awakeFromNib
{
    [self observeValueForKeyPath:@"summa" ofObject:self change:nil context:@"!"];    
}

- (IBAction)addRecord:(id)sender {
    [dataArray addObject:[[RData alloc] init]];
    [_dataTableView reloadData];
    [self selectLastRecord];
    [self observeValueForKeyPath:@"summa" ofObject:self change:nil context:@"+"];
}

- (IBAction)delRecord:(id)sender {
    NSInteger row = [_dataTableView selectedRow];
    if (row == -1) return;
    
    [_dataTableView abortEditing];
    
    NSNumber *newSumma = [[NSNumber alloc] initWithDouble:([summa doubleValue] - [[dataArray objectAtIndex:row] money])];
    [self setValue:newSumma forKeyPath:@"summa"];
    
    [dataArray removeObjectAtIndex:row];
    [_dataTableView reloadData];
    if ([_dataTableView selectedRow] == -1) [self selectLastRecord];
}

- (void)selectLastRecord
{
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:([dataArray count] - 1)];
    [_dataTableView selectRowIndexes:indexSet byExtendingSelection:NO];
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return [dataArray count];
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    RData *dataRecord = [dataArray objectAtIndex:row];
    NSString *identifier = [tableColumn identifier];
    id result = [dataRecord valueForKey:identifier];
    return result;
}

- (void)tableView:(NSTableView *)tableView setObjectValue:(id)object forTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    RData *dataRecord = [dataArray objectAtIndex:row];
    NSString *identifier = [tableColumn identifier];
    if ([identifier isEqualToString:@"money"]) {
        NSNumber *newSumma = [[NSNumber alloc] initWithDouble:([summa doubleValue] - [dataRecord money] + [object doubleValue])];
        [self setValue:newSumma forKeyPath:@"summa"];
    }
    [dataRecord setValue:object forKey:identifier];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (_summaLabel) {
        [_summaLabel setStringValue:[summa stringValue]];
    }
}

@end
