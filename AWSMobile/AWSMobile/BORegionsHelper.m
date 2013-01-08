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
    
    regions = @{@"eu-west-1" : @"Ireland",
                @"sa-east-1" : @"Sao Paulo",
                @"us-west-1" : @"Northern California",
                @"us-west-2" : @"Oregon",
                @"ap-northeast-1" : @"Tokyo",
                @"ap-northeast-2" : @"Sydney",
                @"" : @"US Standard"};
}

+ (NSArray *)getAllRegions {
    return @[@"Ireland",
            @"Sao Paulo",
            @"Northern California",
            @"Oregon",
            @"Tokyo",
            @"Sydney"];
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
