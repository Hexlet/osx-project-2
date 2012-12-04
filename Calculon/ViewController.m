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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    calc = [[polishBrain alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pressed:(UIButton *)sender {
    NSString *s = sender.titleLabel.text;
    NSLog(@"pressed: %@", s);
    
    NSArray *postFixString = [calc RPNFromInfixString:_display.text];
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
    
    _display.text = [NSString stringWithFormat:@"%lf", [calc result]];
}

- (IBAction)buttonPressed:(UIButton *)sender {
    NSString *s = sender.titleLabel.text;
    NSLog(@"pressed: %@", s);
    _display.text = [_display.text stringByAppendingString:s];
}
@end
