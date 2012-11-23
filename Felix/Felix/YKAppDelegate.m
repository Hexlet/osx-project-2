//
//  YKAppDelegate.m
//  Felix
//
//  Created by Yuri Kirghisov on 23.11.12.
//  Copyright (c) 2012 Yuri Kirghisov. All rights reserved.
//

#import "YKAppDelegate.h"

@implementation YKAppDelegate
@synthesize argOneSlider;
@synthesize argTwoSlider;
@synthesize resultSlider;
@synthesize operationsTableView;
@synthesize argOneTextField;
@synthesize argTwoTextField;
@synthesize resultTextField;

- (void)dealloc
{
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    self.arithmeticOperations = [NSArray arrayWithObjects:OPERATION_ADDITION,
                                                        OPERATION_SUBSTRACTION,
                                                        OPERATION_MULTIPLICATION,
                                                        OPERATION_DIVISION,
                                                        nil];
    [argOneSlider setIntValue: 0];
    [argTwoSlider setIntValue: 0];
    [operationsTableView reloadData];
    [self updateViews];
}

#pragma mark NSTableViewDelegate Methods

- (void)tableViewSelectionDidChange:(NSNotification *)aNotification
{
    if ([aNotification object] == operationsTableView) {
        // Этот метод вызывается когда пользователь меняет операцию
        // Мы просто пересчитываем и перерисовываем наши объекты
        [self updateViews];
    }
}

#pragma mark NSTableViewDataSource Methods

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView
{
    if (aTableView == operationsTableView)
        return (NSInteger)self.arithmeticOperations.count;

    return 0;
}

- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex
{
    if (aTableView == operationsTableView)
        if (rowIndex >= 0 && rowIndex < _arithmeticOperations.count)
            return [self.arithmeticOperations objectAtIndex:rowIndex];
    
    return @"-";
}

#pragma mark Controller Methods

- (IBAction)argOneSliderHasMoved:(id)sender
{
    // Второй ползунок был сдвинут
    // Мы просто пересчитываем и перерисовываем наши объекты

    [self updateViews];
}

- (IBAction)argTwoSliderHasMoved:(id)sender
{
    // Второй ползунок был сдвинут
    // Мы просто пересчитываем и перерисовываем наши объекты

    [self updateViews];
}

- (void)updateViews
{
    // Этот метод обновляет все объекты в окне

    int arg1 = [argOneSlider intValue];
    int arg2 = [argTwoSlider intValue];

    [argOneTextField setIntValue:arg1];
    [argTwoTextField setIntValue:arg2];

    // Изменяем значения в зависимости от операнда (операции)
    NSUInteger selectedRow = [operationsTableView selectedRow];
    if (selectedRow == -1 || selectedRow >= self.arithmeticOperations.count) {
        // Операция не выбрана, т.е. значения на выходе нет
        [resultTextField setStringValue:@"?"];
        [resultTextField setTextColor:[NSColor grayColor]];
    } else {
        [resultTextField setTextColor:[NSColor blackColor]];

        if ([[self.arithmeticOperations objectAtIndex:selectedRow] isEqualTo:OPERATION_ADDITION]) {
            [resultTextField setIntValue: arg1 + arg2];
            [resultSlider setIntValue: arg1 + arg2];
        } else if ([[self.arithmeticOperations objectAtIndex:selectedRow] isEqualTo:OPERATION_SUBSTRACTION]) {
            [resultTextField setIntValue: arg1 - arg2];
            [resultSlider setIntValue: arg1 - arg2];
        } else if ([[self.arithmeticOperations objectAtIndex:selectedRow] isEqualTo:OPERATION_MULTIPLICATION]) {
            [resultTextField setIntValue: arg1 * arg2];
            [resultSlider setIntValue: arg1 * arg2];
        } else if ([[self.arithmeticOperations objectAtIndex:selectedRow] isEqualTo:OPERATION_DIVISION]) {
            if (arg2 == 0) {
                [resultTextField setStringValue: @"DIV 0"];
                [resultTextField setTextColor:[NSColor redColor]];
                [resultSlider setIntValue: 0];
            } else {
                [resultTextField setStringValue: [NSString stringWithFormat:@"%6.5f", 1.0 * arg1 / arg2]];
                [resultSlider setIntValue: arg1 / arg2];
            }
        } else {
            // Незнакомая операция, т.е. значения на выходе нет
            [resultTextField setStringValue:@"?"];
        }
    }
}

@end
