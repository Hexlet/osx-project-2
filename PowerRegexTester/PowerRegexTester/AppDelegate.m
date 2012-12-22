//
//  AppDelegate.m
//  PowerRegexTester
//
//  Created by Igor on 18/11/2012.
//  Copyright (c) 2012 Igor Redchuk. All rights reserved.
//

#import "AppDelegate.h"
#import "FileDialog.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {

}

- (IBAction)clearClick:(NSButton *)sender {
    self.source.stringValue = @"";
}

- (IBAction)loadClick:(NSButton *)sender {
    NSURL *url = [NSURL URLWithString:self.url.stringValue];
    if (url) {
        [self loadStringFromUrl:url];
    }
}

- (IBAction)fileClick:(NSButton *)sender {
    NSURL *fileUrl = [[[FileDialog alloc] init] openFile];
    if (fileUrl) {
        [self loadStringFromUrl:fileUrl];
        self.url.stringValue = fileUrl.absoluteString;
    }
    
}

- (void) loadStringFromUrl:(NSURL *)url {
    [self.loadProgress setHidden:NO];
    [self.loadProgress startAnimation:self];
    NSError *error;
    NSString *urlContents = [NSString stringWithContentsOfURL:url
                                                     encoding:NSASCIIStringEncoding
                                                        error:&error];
    [self.loadProgress stopAnimation:self];
    [self.loadProgress setHidden:YES];
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
