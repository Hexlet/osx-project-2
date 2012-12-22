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

- (IBAction)clearClick:(NSButton *)sender {
    self.source.stringValue = @"";
}

- (IBAction)applyClick:(NSButton *)sender {
    NSString *pattern = self.pattern.stringValue;
    NSError *error;
    NSRegularExpressionOptions options = [self.options regexOptions];
    NSLog(@"Options: %li", options);
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern
                                                                           options:options
                                                                             error:&error];
    NSString *sourceString = self.source.stringValue;
    NSArray *matches = [regex matchesInString:sourceString
                                      options:0
                                        range:NSMakeRange(0, sourceString.length)];
    for (NSTextCheckingResult *match in matches) {
        NSLog(@"Match: %@", [sourceString substringWithRange:match.range]);
    }
}

@end
