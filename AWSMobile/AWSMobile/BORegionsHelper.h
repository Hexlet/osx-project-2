//
//  BORegionsHelper.h
//  AWSMobile
//
//  Created by Oleg Bogatenko on 27.12.12.
//  Copyright (c) 2012 DoZator Home. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BORegionsHelper : NSDictionary

+ (void)allRegions;
+ (NSString *)getRegionRealName:(NSString *)region;
+ (NSString *)getRegionKey:(NSString *)regionName;

@end
