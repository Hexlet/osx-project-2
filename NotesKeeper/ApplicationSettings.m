//
//  ApplicationSettings.m
//  NotesKeeper
//
//  Created by Stan Buran on 23/12/12.
//  Copyright (c) 2012 apoidea. All rights reserved.
//

#import "ApplicationSettings.h"
@interface ApplicationSettings()
@end

@implementation ApplicationSettings

NSString *const RATE_LEFT = @"RATE_LEFT";
NSString *const CURR_LEFT = @"CURR_LEFT";
NSString *const RATE_RIGHT = @"RATE_RIGHT";
NSString *const CURR_RIGHT = @"CURR_RIGHT";
NSString *const USED_COMPONENT = @"USED_COMPONENT";


+(void) initialize {
	NSMutableDictionary *dicDefVals = [NSMutableDictionary dictionary];

	[dicDefVals setObject:@"0" forKey:RATE_LEFT];
	[dicDefVals setObject:@"1" forKey:RATE_RIGHT];
	[dicDefVals setObject:@"USD" forKey:CURR_LEFT];
	[dicDefVals setObject:@"EUR" forKey:CURR_RIGHT];
	[dicDefVals setObject:@"0" forKey:USED_COMPONENT];

	[[NSUserDefaults standardUserDefaults] registerDefaults:dicDefVals];
}

+(void) setRateLeft:(NSString *)value{
	[[NSUserDefaults standardUserDefaults] setObject:value forKey:RATE_LEFT];
}
+(NSString *) getRateLeft{
	return [[NSUserDefaults standardUserDefaults] stringForKey:RATE_LEFT];
}
+(void) setCurrLeft: (NSString *) code{
	[[NSUserDefaults standardUserDefaults] setObject:code forKey:CURR_LEFT];
}
+(NSString *) getCurrCodeLeft{
	return [[NSUserDefaults standardUserDefaults] stringForKey:CURR_LEFT];
}
+(void) setRateRight: (NSString *) value{
	[[NSUserDefaults standardUserDefaults] setObject:value forKey:RATE_RIGHT];
}
+(NSString *) getRateRight{
	return [[NSUserDefaults standardUserDefaults] stringForKey:RATE_RIGHT];
}
+(void) setCurrRight: (NSString *) code{
	[[NSUserDefaults standardUserDefaults] setObject:code forKey:CURR_RIGHT];
}
+(NSString *) getCurrCodeRight{
	return [[NSUserDefaults standardUserDefaults] stringForKey:CURR_RIGHT];
}
+(void) setComponent: (NSInteger) component{
	[[NSUserDefaults standardUserDefaults]  setObject: [NSString stringWithFormat:@"%i", component] forKey:USED_COMPONENT];
}
+(NSInteger) getComponent{
	return [[[NSUserDefaults standardUserDefaults] stringForKey:USED_COMPONENT] intValue];
}

@end
