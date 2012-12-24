//
//  ApplicationSettings.h
//  NotesKeeper
//
//  Created by Stan Buran on 23/12/12.
//  Copyright (c) 2012 apoidea. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
extern NSString *const RATE_LEFT;
extern NSString *const CURR_LEFT;
extern NSString *const RATE_RIGHT;
extern NSString *const CURR_RIGHT;
extern NSString *const USED_COMPONENT;
*/

@interface ApplicationSettings : NSObject

+(void) setRateLeft: (NSString *) value;
+(void) setCurrLeft: (NSString *) code;
+(void) setRateRight: (NSString *) value;
+(void) setCurrRight: (NSString *) code;
+(void) setComponent: (NSInteger) component;

+(NSString *) getRateLeft;
+(NSString *) getCurrCodeLeft;
+(NSString *) getRateRight;
+(NSString *) getCurrCodeRight;
+(NSInteger) getComponent;
@end
