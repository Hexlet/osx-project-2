//
//  AppDelegate.m
//  Calculatte
//
//  Created by Alex Bakoushin on 02.12.12.
//  Copyright (c) 2012 Alex Bakoushin. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

-(void)activateApp{
    [NSApp activateIgnoringOtherApps:YES];
    [_window makeKeyAndOrderFront:self];
}

-(void)createStatusBar {
    statusBar = [[NSStatusBar systemStatusBar] statusItemWithLength:NSSquareStatusItemLength];
    [statusBar setImage: [NSImage imageNamed:@"coffe_cup_icon.png"]];
    [statusBar setHighlightMode:YES];
    [statusBar setAction:@selector(activateApp)];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    history = [[NSMutableArray alloc]init];
    eval = [DDMathEvaluator sharedMathEvaluator];

    [self createStatusBar];
    
    [NSEvent addGlobalMonitorForEventsMatchingMask:NSKeyDownMask handler:^(NSEvent *event){
        
        int character = [[event charactersIgnoringModifiers] characterAtIndex:0];

        if(([event modifierFlags] & NSControlKeyMask) && (character == 48)) { // Ctrl+0
            [NSApp activateIgnoringOtherApps:YES];
            [_window makeKeyAndOrderFront:self];
        }
    }];
    
}

- (void)evaluateExpression {

    NSString *expression = [_textField stringValue];
    
    // Remove whitaspace before and after
    expression = [expression stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if ([expression isEqualToString: lastExpression]) {
        NSArray *expressionParts = [expression componentsSeparatedByString:@"="];
        NSString *lastPart = [[expressionParts objectAtIndex:[expressionParts count] - 1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        evaluatedExpression = [lastPart mutableCopy];
        
    }
    else {
        
        evaluatedExpression = [expression mutableCopy];
        
        NSString *result;
        @try {
            result = [[eval evaluateString:expression withSubstitutions:nil] stringValue];
        }
        @catch (NSException *exception) {
            result = @"ERROR";
        }
        
        [evaluatedExpression appendString:@" = "];
        [evaluatedExpression appendString:result];
    }
    
    [_textField setStringValue:evaluatedExpression];
    [history insertObject:evaluatedExpression atIndex:0];
    [_tableView reloadData];
    
    lastExpression = evaluatedExpression;
    
}

- (IBAction)calculateIt:(id)sender {
    [self evaluateExpression];
}

- (void)controlTextDidEndEditing:(NSNotification *) notification {
    [self evaluateExpression];
}

-(NSInteger) numberOfRowsInTableView:(NSTableView*) tableView {
    return (NSInteger) [history count];
}

-(id) tableView:(NSTableView*) tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    NSString *expression = [history objectAtIndex:row];
    return expression;
}

@end
