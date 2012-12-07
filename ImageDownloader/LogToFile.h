//
//  LogToFile.h
//  ImageDownloader
//
//  Created by Vitaly on 01.12.12.
//  Copyright (c) 2012 Vitaly Petrov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LogToFile : NSObject

- (BOOL)redirectNSLog: (NSString *)toPath;

@end
