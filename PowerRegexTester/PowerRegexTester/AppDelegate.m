//
//  AppDelegate.m
//  PowerRegexTester
//
//  Created by Igor on 18/11/2012.
//  Copyright (c) 2012 Igor Redchuk. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {

}

- (IBAction)applyClick:(NSButton *)sender {
    NSString *pattern = self.pattern.stringValue;
    NSError *error;
    NSRegularExpressionOptions options = [self.options regexOptions];
    NSLog(@"Options: %li", options);
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern
                                                                           options:options
                                                                             error:&error];
    NSString *source = @"example";
    NSArray *matches = [regex matchesInString:source  options:0 range:NSMakeRange(0, source.length)];
    for (NSTextCheckingResult *match in matches) {
        NSLog(@"Match: %@", [source substringWithRange:match.range]);
    }
}

@end
