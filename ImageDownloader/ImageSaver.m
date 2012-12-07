//
//  ImageSaver.m
//  ImageDownloader
//
//  Created by Vitaly on 29.11.12.
//  Copyright (c) 2012 Vitaly Petrov. All rights reserved.
//

#import "ImageSaver.h"

@implementation ImageSaver

-(void)downloadImage:(NSString*) path: (NSString*) stringURL {
    NSURL *url = [NSURL URLWithString:stringURL];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    if (urlData) {
        [urlData writeToFile:path atomically:YES];
    }
}

@end
