//
//  AppDelegate.m
//  Calculatte
//
//  Created by Alex Bakoushin on 02.12.12.
//  Copyright (c) 2012 Alex Bakoushin. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [_textField setDelegate:self];
}

- (IBAction)calculateIt:(id)sender {
    NSLog(@"%@", [_textField stringValue]);
}

- (void)controlTextDidEndEditing:(NSNotification *)obj{
    NSLog(@"%@", [_textField stringValue]);
    
    HistoryModel *expression = [[HistoryModel alloc] init];
    
    expression.expression = @"323";
    
    AppController *appController = [[AppController alloc] init];
    
//    appController.historyArray: add
    
}

@end
