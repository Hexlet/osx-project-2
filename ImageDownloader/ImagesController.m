//
//  ImagesController.m
//  ImageDownloader
//
//  Created by Vitaly on 01.12.12.
//  Copyright (c) 2012 Vitaly Petrov. All rights reserved.
//

#import "ImagesController.h"

@implementation ImagesController

+(void)process:(NSArray *) params{
    NSProgressIndicator *progressBar = (NSProgressIndicator *)[params objectAtIndex:0];
    NSString *fromURL = (NSString *)[params objectAtIndex:1];
    NSString *toPath = (NSString *)[params objectAtIndex:2];
    NSTextField *progressStatus = (NSTextField *)[params objectAtIndex:3];
    
    id <IImageFinder> imageFinder = [[ImageFinder alloc] init];
    id <IImageSaver> imageSaver = [[ImageSaver alloc] init];
    
    LogToFile *log = [[LogToFile alloc] init];
    [log redirectNSLog:toPath];
    
    NSLog(@"Start downloading");
    NSArray *arr = [imageFinder openURL:fromURL];
    
    [progressBar setHidden:NO];
    [progressBar startAnimation:nil];
    [progressBar setMinValue:0];
    [progressBar setMaxValue:[arr count]];
    [progressBar setDoubleValue:0];
    [progressStatus setStringValue:[NSString stringWithFormat:@"0/%li",[arr count]]];
    
    NSInteger i = 0;
    for (NSString *image in arr) {
        NSLog(@"%@", [image stringByReplacingOccurrencesOfString:@"/" withString:@""]);
        NSString* replacedStr = [image stringByReplacingOccurrencesOfString:@"/" withString:@""];
        NSString* path = [NSString stringWithFormat:@"%@%@", toPath, replacedStr];
        [imageSaver downloadImage:path :image];
        i++;
        [progressBar incrementBy:1];
        [progressStatus setStringValue:[NSString stringWithFormat:@"%li/%li",i,[arr count]]];
    }
    
    [progressBar stopAnimation:nil];
    
    NSLog(@"Finish downloading");
}


@end
