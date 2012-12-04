//
//  AppDelegate.m
//  Gurin_Proj_2
//
//  Created by Admin on 12/4/12.
//  Copyright (c) 2012 Admin. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    NSImage *imgLogo = [NSImage imageNamed:@"LoveFoodHeading.jpg"];
    NSImage *imgStar = [NSImage imageNamed:@"star.png"];
    NSImage *imgInterest = [NSImage imageNamed:@"pizza.png"];
    NSImage *imgBook = [NSImage imageNamed:@"Book.png"];
    
    [self.logo setImage:imgLogo];
    
    [self.favor setImage:imgStar];
    [self.favor setImagePosition:NSImageLeft];
    
    [self.catalog setImage:imgBook];
    [self.catalog setImagePosition:NSImageLeft];
    
    [self.interest setImage:imgInterest];
    [self.interest setImagePosition:NSImageLeft];


}

@end
