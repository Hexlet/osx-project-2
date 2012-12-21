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
    NSRegularExpressionOptions options = [self currentOptions];
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

- (NSRegularExpressionOptions) currentOptions {
    NSRegularExpressionOptions options = 0;
    for (NSButtonCell *cell in self.options.cells) {
        if (cell.state != NSOnState) {
            continue;
        }
        if ([cell.identifier isEqualToString:@"CaseInsensitive"]) {
            options |= NSRegularExpressionCaseInsensitive;
        } else if ([cell.identifier isEqualToString:@"DotMatchesLineSeparators"]) {
            options |= NSRegularExpressionDotMatchesLineSeparators;
        } else if ([cell.identifier isEqualToString:@"AnchorsMatchLines"]) {
            options |= NSRegularExpressionAnchorsMatchLines;
        } else if ([cell.identifier isEqualToString:@"IgnoreMetacharacters"]) {
            options |= NSRegularExpressionIgnoreMetacharacters;
        } else if ([cell.identifier isEqualToString:@"UseUnicodeWordBounds"]) {
            options |= NSRegularExpressionUseUnicodeWordBoundaries;
        } else if ([cell.identifier isEqualToString:@"UseUnixLineSeparators"]) {
            options |= NSRegularExpressionUseUnixLineSeparators;
        } else if ([cell.identifier isEqualToString:@"CommentsAndWhitespace"]) {
            options |= NSRegularExpressionAllowCommentsAndWhitespace;
        }
    }
    return options;
}







@end
