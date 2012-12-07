//
//  ImageFinder.m
//  ImageDownloader
//
//  Created by Vitaly on 29.11.12.
//  Copyright (c) 2012 Vitaly Petrov. All rights reserved.
//

#import "ImageFinder.h"

@implementation ImageFinder

-(NSArray*)openURL:(NSString*) url {
    NSURL *urlRequest = [NSURL URLWithString:url];
    NSStringEncoding encoding;
    NSError *err = nil;
    NSString *html = [NSString stringWithContentsOfURL:urlRequest usedEncoding:&encoding error:&err];
    NSMutableArray *resultArr = [[NSMutableArray alloc]init];
    
    if(!err) {
        return [self getAllImages:resultArr :html];
    } else {
        NSLog(@"Error open %@ try to open in CP1251", err);
        html = [NSString stringWithContentsOfURL:urlRequest encoding:NSWindowsCP1251StringEncoding error:&err];
        return [self getAllImages:resultArr :html];
    }
    return nil;
}

-(NSArray*) getAllImages:(NSMutableArray*) resultArr:(NSString*) html {
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression
                                  regularExpressionWithPattern:@"(http:[A-Za-z0-9_\\./\\(\\)]*\\.[jpg|jpeg|png|gif]{3,4})"
                                  options:NSRegularExpressionCaseInsensitive
                                  error:&error];
    
    NSArray* arr= [regex matchesInString:html options:0 range:NSMakeRange(0, [html length])];
    for (NSTextCheckingResult *image in arr) {
        NSString *imageHTML = [html substringWithRange:image.range];
        [resultArr addObject: imageHTML];
    }
    return resultArr;
}

@end
