//
//  DataTableViewController.h
//  dR-3
//
//  Created by Victor Mylcin on 01.12.12.
//  Copyright (c) 2012 Victor Mylcin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataTableViewController : NSObject <NSTableViewDataSource>
{
    NSMutableArray *dataArray;
    NSNumber *summa;
}

@property (weak) IBOutlet NSTableView *dataTableView;

@property (weak) IBOutlet NSTextField *summaLabel;

- (IBAction)addRecord:(id)sender;

- (IBAction)delRecord:(id)sender;

@end
