//
//  ViewController.h
//  FastReader
//
//  Created by Max Lebedev on 03.12.12.
//  Copyright (c) 2012 mlebedev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
    NSInteger count;
    NSString* book;
    NSMutableArray* words;
    NSTimeInterval speed;
}

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *textField;
@property NSTimer* timer;

- (IBAction)startReading:(id)sender;
- (IBAction)stopReading:(id)sender;
- (IBAction)fasterClick:(id)sender;
@end
