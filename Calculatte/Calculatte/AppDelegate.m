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
    history = [[NSMutableArray alloc]init];
}

- (IBAction)calculateIt:(id)sender {
    NSString *expression = [_textField stringValue];
    [history insertObject:expression atIndex:0];
    [_tableView reloadData];
//    NSLog(@"%@", expression);
//    NSLog(@"%@", history);
}


- (void)controlTextDidEndEditing:(NSNotification *) notification {
    NSString *expression = [_textField stringValue];
    [history insertObject:expression atIndex:0];
    [_tableView reloadData];
}

-(NSInteger) numberOfRowsInTableView:(NSTableView*) tableView {
    return (NSInteger) [history count];
}

-(id) tableView:(NSTableView*) tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    NSString *expression = [history objectAtIndex:row];
    return expression;
}

@end
