//
//  IImageDownloader.h
//  ImageDownloader
//
//  Created by Vitaly on 29.11.12.
//  Copyright (c) 2012 Vitaly Petrov. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IImageSaver <NSObject>

-(void)downloadImage:(NSString*) path: (NSString*) stringURL;

@end
