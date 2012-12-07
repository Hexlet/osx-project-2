//
//  ImagesController.h
//  ImageDownloader
//
//  Created by Vitaly on 01.12.12.
//  Copyright (c) 2012 Vitaly Petrov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IImageFinder.h"
#import "ImageFinder.h"
#import "IImageSaver.h"
#import "ImageSaver.h"
#import "LogToFile.h"

@interface ImagesController : NSObject

+(void)process:(NSArray *) params;


@end
