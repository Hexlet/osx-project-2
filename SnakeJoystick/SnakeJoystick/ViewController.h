//
//  ViewController.h
//  SnakeJoystick
//
//  Created by mac205-2 on 02.12.12.
//  Copyright (c) 2012 zhorkov023. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property UITextField* activeField;

@property (weak, nonatomic) IBOutlet UITextField *textFieldIP;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPort;

@end
