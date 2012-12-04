//
//  GSViewController.h
//  ClientGitHub_1.0
//
//  Created by Администратор on 11/9/12.
//  Copyright (c) 2012 GameStore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GSViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *logoImage;
@property (strong, nonatomic) IBOutlet UIButton *connectButton;
@property (nonatomic, retain) IBOutlet UILabel *resultTest;

- (IBAction)startConnection;

@end
