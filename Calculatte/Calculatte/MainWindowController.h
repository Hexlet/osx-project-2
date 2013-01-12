//
//  MainWindowController.h
//  Calculatte
//
//  Created by Alex Bakoushin on 04.01.13.
//  Copyright (c) 2013 Alex Bakoushin. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DDMathParser.h"

@interface MainWindowController : NSWindowController {
    NSMutableString *lastExpression;
    NSMutableString *evaluatedExpression;
    NSStatusItem *statusBar;
    DDMathEvaluator *eval;
    NSMutableArray *history;
}

@property (weak) IBOutlet NSTextField *textField;
@property (weak) IBOutlet NSTableView *tableView;

- (IBAction)calculateIt:(id)sender;

@end
