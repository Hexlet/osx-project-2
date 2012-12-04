//
//  ViewController.m
//  FastReader
//
//  Created by Max Lebedev on 03.12.12.
//  Copyright (c) 2012 mlebedev. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (id)init
{
    self = [super init];
    if (self) {
        count = 0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // импортируем книгу
    words = [[NSMutableArray alloc]init];
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"Book" ofType:@"txt"];
    if (filePath) {
        NSError *error;
        book = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
        [book enumerateSubstringsInRange:NSMakeRange(0, [book length]) options:NSStringEnumerationByWords usingBlock:^(NSString* word, NSRange wordRange, NSRange enclosingRange, BOOL* stop){
            [words addObject:word];
        }];
        speed = 0.5f;
    }
    
    [_textView setText:book];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)nextWord {
    if (count==[words count] && [_timer isValid]) {
        [_timer invalidate];
        count = 0;
        return;
    }
    [_textField setText:[NSString stringWithFormat:@"%@", [words objectAtIndex:count]]];
    count++;
}

- (void) startTimer {
    _timer = [NSTimer scheduledTimerWithTimeInterval:speed target:self selector:@selector(nextWord) userInfo:nil repeats:YES];
}

-(void) stopTimer {
    if ([_timer isValid]) {
        [_timer invalidate];
    }
}

- (IBAction)startReading:(id)sender {
    if (![_timer isValid]) {
        [self startTimer];
    }
}

- (IBAction)stopReading:(id)sender {
    [self stopTimer];
}

- (IBAction)fasterClick:(id)sender {
    if (speed > 0.02f) {
        speed = speed - 0.02f;
    }
    [self stopTimer];
    [self startTimer];
}
@end
