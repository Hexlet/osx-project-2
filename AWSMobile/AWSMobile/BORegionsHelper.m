//
//  BORegionsHelper.m
//  AWSMobile
//
//  Created by Oleg Bogatenko on 27.12.12.
//  Copyright (c) 2012 DoZator Home. All rights reserved.
//

#import "BORegionsHelper.h"
#import <AWSiOSSDK/S3/AmazonS3Client.h>

static NSDictionary *regions = nil;

@implementation BORegionsHelper

+ (void)allRegions {
    regions = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObjects:@"Ireland",
                                                     @"Sao Paulo",
                                                     @"USA Standart Location",
                                                     @"Northern California",
                                                     @"Oregon",
                                                     @"Tokyo",
                                                     @"Sydney", nil]
                                            forKeys:[NSArray arrayWithObjects:@"eu-west-1",
                                                     @"sa-east-1",
                                                     @"",
                                                     @"us-west-1",
                                                     @"us-west-2",
                                                     @"ap-northeast-1",
                                                     @"ap-southeast-2", nil]];
}

+ (NSString *)getRegionRealName:(NSString *)region {
    [self allRegions];
    return [regions objectForKey:region];
}

+ (NSString *)getRegionKey:(NSString *)regionName {
    [self allRegions];
    return [[regions allKeysForObject:regionName] objectAtIndex:0];
}

@end
