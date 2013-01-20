//
//  Common.m
//  NotesKeeper
//
//  Created by Stan Buran on 11/22/12.
//  Copyright (c) 2012 apoidea. All rights reserved.
//

#import "Common.h"

static Note *active_note = nil;
static EnumEditMode _editmode = ENUM_READ;

@implementation Common

+(EnumEditMode) EditMode{return _editmode;}
+(void) setEditMode : (EnumEditMode) value {_editmode = value;}

+ (Note*) activeNote{return  active_note;}
+ (void) setActiveNoteAsNew {active_note = [[Note alloc] init];}
+ (void) setActiveNoteByPath : (NSString*) fullPath{
	active_note = [[Note alloc] initWithPath:fullPath];
}
+ (void) setActiveNoteByNote : (Note *) note{
	active_note = note;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
+ (void) doEvents {
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate date]];
}
+ (void) wl: (NSString *) comment{
    NSLog(@"%@",comment);   
}
+ (void) wlCGRect: (NSString *) comment frame: (CGRect) value{
    NSLog
    (
        @"\n%@  X:%@, Y:%@, Width:%@, Height:%@", comment,
        [NSString stringWithFormat: @"%g", value.origin.x],
        [NSString stringWithFormat: @"%g", value.origin.y],
        [NSString stringWithFormat: @"%g", value.size.width],
        [NSString stringWithFormat: @"%g", value.size.height]
    );
}
+ (void) mbox: (NSString *) messageText : (NSString *) caption{
    UIAlertView *achtung = [[UIAlertView alloc] initWithTitle:caption message:messageText delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [achtung show];
}
@end
