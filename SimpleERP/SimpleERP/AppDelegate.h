//
//  AppDelegate.h
//  SimpleERP
//
//  Created by Admin on 27.11.12.
//  Copyright (c) 2012 Kabest. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebView.h>

@interface AppDelegate : NSObject <NSApplicationDelegate, NSTableViewDataSource, NSTableViewDelegate> {
    NSArray *leftMenuValues;
    NSArray *leftMenuObjects;
    NSArray *leftMenuSelectable;
    NSMutableArray *pOrders;
}

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTableView *leftMenu;
@property (weak) IBOutlet WebView *webView;
@property (weak) IBOutlet NSTableView *mainTableView;

@property (copy) NSMutableArray *pOrders;

@end
