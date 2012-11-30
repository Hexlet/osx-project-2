//
//  AppDelegate.h
//  StockViewer
//
//  Created by Tolya on 25.11.12.
//  Copyright (c) 2012 Home. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class DataRequest;

@interface AppDelegate : NSObject <NSApplicationDelegate, NSTableViewDataSource>

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet DataRequest *request;
@property (weak) IBOutlet NSTableView *barsTable;
@property (weak) IBOutlet NSArrayController *barsController;
@property (weak) IBOutlet NSComboBox *symbolsComboBox;
@property (weak) IBOutlet NSComboBox *exchangesComboBox;
@property (weak) IBOutlet NSArrayController *recentSymbolsArrayController;
@property (weak) IBOutlet NSArrayController *recentExchangesArrayController;

- (IBAction)loadData:(id)sender;
- (IBAction)viewInBrowser:(id)sender;
- (IBAction)csvExport:(id)sender;

@end
