//
//  Common.m
//  NotesKeeper
//
//  Created by Stan Buran on 11/22/12.
//  Copyright (c) 2012 apoidea. All rights reserved.
//

#import "Common.h"
//#import <UIKit/UIKit.h>

@implementation Common

static EnumEditMode _editmode = ENUM_READ;
+(EnumEditMode) EditMode{return _editmode;}
+(void) setEditMode : (EnumEditMode) value {_editmode = value;}

+ (void) doEvents
{
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate date]];
}
+ (void) wl: (NSString *) comment
{
    NSLog(@"%@",comment);   
}
+ (void) wlCGRect: (NSString *) comment : (CGRect) value
{
    NSLog
    (
        @"X:%@, Y:%@, Width:%@, Height:%@",
        [NSString stringWithFormat: @"%g", value.origin.x],
        [NSString stringWithFormat: @"%g", value.origin.y],
        [NSString stringWithFormat: @"%g", value.size.width],
        [NSString stringWithFormat: @"%g", value.size.height]
    );
}
+ (void) mbox: (NSString *) messageText : (NSString *) caption
{
    UIAlertView *achtung = [[UIAlertView alloc] initWithTitle:caption message:messageText delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [achtung show];
}
+ (NSString *) encrypt : (NSString *) text : (NSString *) password
{
	return @"under construction";
}
+ (NSString *) decrypt : (NSString *) text : (NSString *) password
{
	return @"under construction";
}
@end
