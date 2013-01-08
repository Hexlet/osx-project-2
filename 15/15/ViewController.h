//
//  ViewController.h
//  15
//
//  Created by Evgeny Eschenko on 03.12.12.
//  Copyright (c) 2012 Evg33n. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fifteen.h"

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *boardView;
@property(strong,nonatomic) Fifteen *board;

-(IBAction)tileSelected:(UIButton*)sender;
-(IBAction)scrambleTiles:(id)sender;
-(void)arrangeBoardView;
-(void)showCongratulations;

@end
