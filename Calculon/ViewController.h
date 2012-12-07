//
//  ViewController.h
//  Calculon
//
//  Created by Sachs on 04.12.12.
//  Copyright (c) 2012 SachsHome. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "polishBrain.h"

@interface ViewController : UIViewController {
    polishBrain *calc;
    NSMutableString *tmpDisplay;
}

- (void)updateDisplay;

@property int cursorPosition;
@property (weak, nonatomic) IBOutlet UITextField *display;
- (IBAction)clear:(UIButton *)sender;
- (IBAction)pressed:(UIButton *)sender;
- (IBAction)buttonPressed:(UIButton *)sender;
- (IBAction)moveCursorLeft:(UIButton *)sender;
- (IBAction)moveCursorRight:(UIButton *)sender;
- (IBAction)backspacePressed:(UIButton *)sender;

@end
