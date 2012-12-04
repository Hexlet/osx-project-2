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
    _display.text = s;
}

//NSArray *postFixString = [polishBrain RPNFromInfixString:formula];
//NSLog(@"postfix stack: %@", postFixString);
//for (id part in postFixString) {
//    if ([part isKindOfClass:[NSDecimalNumber class]]) {
//        NSLog(@"number: %@", part);
//        [polishBrain addOperand:[((NSDecimalNumber *)part) doubleValue]];
//    } else {
//        NSLog(@"operation: %@", part);
//        [polishBrain operationWithOpKey:part];
//    }
//    NSLog(@"brain: %@", polishBrain);
//}
//
//printf("result: %.15lf\n", [polishBrain result]);
//if (polishBrain.error)
//printf("error: %.4X", polishBrain.error);

- (IBAction)buttonPressed:(UIButton *)sender {
    NSString *s = sender.titleLabel.text;
    NSLog(@"pressed: %@", s);
    _display.text = [_display.text stringByAppendingString:s];
}
@end
