//
//  AppDelegate.m
//  Project2
//
//  Created by Роман Евсеев on 04.12.12.
//  Copyright (c) 2012 Роман Евсеев. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

- (IBAction)getBORCitate:(id)sender {
    NSError * err;
    NSString * strRegExp = @"<div class=\"text(.*?)</div>";
    NSString * s = [NSString stringWithContentsOfURL:[NSURL URLWithString: @"http://bash.im/random"]
                                            encoding: NSWindowsCP1251StringEncoding
                                               error: &err];
    NSRegularExpression * regExp = [[NSRegularExpression alloc] initWithPattern: strRegExp
                                                                        options: 0
                                                                          error: &err];
    if (regExp==nil) {
        NSLog(@"Error making regexp: %@", err);
    }

    NSTextCheckingResult * res = [regExp firstMatchInString: s
                                                    options: 0
                                                      range: NSMakeRange(0, [s length])];
    NSRange quoteRange = [res rangeAtIndex:0];
    quoteRange.location += 18;
    quoteRange.length -=24;
    
    s = [s substringWithRange:quoteRange];

    s = [s stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
    s = [s stringByReplacingOccurrencesOfString:@"<br />" withString:@"\n"];
    s = [s stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    s = [s stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    s = [s stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];

    [self.textField setStringValue:s];
}

@end
