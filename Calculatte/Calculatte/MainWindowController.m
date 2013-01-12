//
//  MainWindowController.m
//  Calculatte
//
//  Created by Alex Bakoushin on 04.01.13.
//  Copyright (c) 2013 Alex Bakoushin. All rights reserved.
//

#import "MainWindowController.h"

@interface MainWindowController ()

@end

@implementation MainWindowController

-(id) init {
    self = [super initWithWindowNibName:@"MainWindowController"];
    if (self) {
        history = [[NSMutableArray alloc]init];
        eval = [DDMathEvaluator sharedMathEvaluator];
    }
    return self;
}

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

- (void)evaluateExpression {
    
    NSString *expression = [_textField stringValue];
    
    // Remove whitaspace before and after expression
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

        [history insertObject:evaluatedExpression atIndex:0];
        [_tableView reloadData];
    
    }
    
    [_textField setStringValue:evaluatedExpression];
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

- (void)tableViewSelectionDidChange:(NSNotification *)aNotification {
    NSString *expression = [history objectAtIndex:[_tableView selectedRow]];
    [_textField setStringValue:expression];
}

-(void)cancelOperation:(id)sender {
    [self close];
}

- (BOOL)control:(NSControl*)control textView:(NSTextView*)textView doCommandBySelector:(SEL)commandSelector
{
    BOOL result = NO;
    
    if (commandSelector == @selector(cancelOperation:))
    {
        [self close];
        result = YES;
    }
    return result;
}

@end
