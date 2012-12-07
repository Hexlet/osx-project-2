//
//  LogToFile.m
//  ImageDownloader
//
//  Created by Vitaly on 01.12.12.
//  Copyright (c) 2012 Vitaly Petrov. All rights reserved.
//

#import "LogToFile.h"

@implementation LogToFile

- (BOOL)redirectNSLog:(NSString *)toPath {
    // Create log file
    [@"" writeToFile:[NSString stringWithFormat:@"%@%@", toPath, @"NSLog.txt"] atomically:YES encoding:NSUTF8StringEncoding error:nil];
    id fileHandle = [NSFileHandle fileHandleForWritingAtPath:[NSString stringWithFormat:@"%@%@", toPath, @"NSLog.txt"]];
    if (!fileHandle)
        return NSLog(@"Opening log failed"), NO;
    
    // Redirect stderr
    int err = dup2([fileHandle fileDescriptor], STDERR_FILENO);
    if (!err)
        return NSLog(@"Couldn't redirect stderr"), NO;
    
    return YES;
}

@end
