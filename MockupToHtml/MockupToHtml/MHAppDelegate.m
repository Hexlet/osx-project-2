//
//  MHAppDelegate.m
//  MockupToHtml
//
//  Created by Dmitriy Zhukov on 04.12.12.
//  Copyright (c) 2012 Dmitriy Zhukov. All rights reserved.
//

#import "MHAppDelegate.h"

@implementation MHAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    [self.navSplit setDelegate:self];
}

- (CGFloat)splitView:(NSSplitView *)splitView constrainMaxCoordinate:(CGFloat)proposedMax ofSubviewAt:(NSInteger)dividerIndex {
    return 400.0f;
}

- (CGFloat)splitView:(NSSplitView *)splitView constrainMinCoordinate:(CGFloat)proposedMinimumPosition ofSubviewAt:(NSInteger)dividerIndex {
    return 256.0f;
}

@end
