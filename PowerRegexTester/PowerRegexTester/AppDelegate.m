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

- (IBAction)loadClick:(NSButton *)sender {
    NSURL *url = [NSURL URLWithString:self.url.stringValue];
    if (!url) { return; }
    
    NSProgressIndicator *indicator = [[NSProgressIndicator alloc] init];
    [indicator startAnimation:self];
    NSError *error;
    NSString *urlContents = [NSString stringWithContentsOfURL:url
                                                     encoding:NSASCIIStringEncoding
                                                        error:&error];
    [indicator stopAnimation:self];
    if (error) {
        [self.class handleError:error];
        return;
    }
    self.source.stringValue = urlContents;
}

- (IBAction)applyClick:(NSButton *)sender {
    NSString *pattern = self.pattern.stringValue;
    NSError *error;
    NSRegularExpressionOptions options = [self.options regexOptions];
    NSLog(@"Options: %li", options);
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern
                                                                           options:options
                                                                             error:&error];
    if (error) {
        [self.class handleError:error];
        return;
    }
    
    NSString *sourceString = self.source.stringValue;
    NSArray *matches = [regex matchesInString:sourceString
                                      options:0
                                        range:NSMakeRange(0, sourceString.length)];
    for (NSTextCheckingResult *match in matches) {
        NSLog(@"Match: %@", [sourceString substringWithRange:match.range]);
    }
}

+ (void) handleError:(NSError *)error {
    NSLog(@"ERROR: %@", error.description);
}

@end
