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
}

@property (weak, nonatomic) IBOutlet UITextField *display;
- (IBAction)pressed:(UIButton *)sender;
- (IBAction)buttonPressed:(UIButton *)sender;

@end
