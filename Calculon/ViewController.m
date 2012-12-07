//
//  ViewController.m
//  Calculon
//
//  Created by Sachs on 04.12.12.
//  Copyright (c) 2012 SachsHome. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize cursorPosition;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    calc = [[polishBrain alloc] init];
    cursorPosition = 0;
    tmpDisplay = [NSMutableString stringWithString:@""];
    [self updateDisplay];
}

-(void)updateDisplay {    
//    UITextRange *range = [_display selectedTextRange];
//    UITextPosition *pos = range.start;

    tmpDisplay = [[tmpDisplay stringByReplacingOccurrencesOfString:@"_" withString:@""] mutableCopy];
    [tmpDisplay insertString:@"_" atIndex:cursorPosition];
    _display.text = tmpDisplay;
}

- (IBAction)clear:(UIButton *)sender {
    [calc reset];
    tmpDisplay = [NSMutableString stringWithString:@""];
    cursorPosition = 0;
    [self updateDisplay];
}

- (IBAction)pressed:(UIButton *)sender {
    NSString *s = sender.titleLabel.text;
    NSLog(@"pressed: %@", s);
    NSArray *postFixString = [calc RPNFromInfixString:[_display.text stringByReplacingOccurrencesOfString:@"_" withString:@""]];
    NSLog(@"postfix stack: %@", postFixString);
    for (id part in postFixString) {
        if ([part isKindOfClass:[NSDecimalNumber class]]) {
            NSLog(@"number: %@", part);
            [calc addOperand:[((NSDecimalNumber *)part) doubleValue]];
        } else {
            NSLog(@"operation: %@", part);
            [calc operationWithOpKey:part];
        }
        NSLog(@"brain: %@", calc);
    }

    printf("result: %.15lf\n", [calc result]);
    if (calc.error)
    printf("error: %.4X", calc.error);
    tmpDisplay = [NSString stringWithString:[[NSNumber numberWithDouble:[calc result]] stringValue]];
    cursorPosition = tmpDisplay.length;
    [self updateDisplay];
}

- (IBAction)buttonPressed:(UIButton *)sender {
    NSString *s = sender.titleLabel.text;
    NSLog(@"pressed: %@", s);
    [tmpDisplay insertString:s atIndex:cursorPosition];
    if (cursorPosition < tmpDisplay.length)
        cursorPosition++;
    [self updateDisplay];
}

- (IBAction)moveCursorLeft:(UIButton *)sender {
    if (cursorPosition > 0)
        cursorPosition--;
    [self updateDisplay];
}

- (IBAction)moveCursorRight:(UIButton *)sender {
    if (cursorPosition < tmpDisplay.length - 1)
        cursorPosition++;
    [self updateDisplay];
}

- (IBAction)backspacePressed:(UIButton *)sender {
    NSLog(@"backspace: %d/%d", cursorPosition, tmpDisplay.length);
    if (cursorPosition > 0) {
        [tmpDisplay replaceCharactersInRange:NSMakeRange(cursorPosition - 1, 1) withString:@""];
        cursorPosition--;
    }
    [self updateDisplay];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
