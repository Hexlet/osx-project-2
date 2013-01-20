//
//  Common.h
//  NotesKeeper
//
//  Created by Stan Buran on 11/22/12.
//  Copyright (c) 2012 apoidea. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "Note.h"
#define CELLID_CONST @"NotesKeeperCellIdentifier"

@interface Common : NSObject

typedef enum {ENUM_READ = 0,ENUM_WRITE,ENUM_CALC,ENUM_RATE} EnumEditMode;

+ (EnumEditMode) EditMode;
+ (void) setEditMode : (EnumEditMode) value;
+ (void) doEvents;
+ (void) wl: (NSString *) comment;
+ (void) wlCGRect: (NSString *) comment frame : (CGRect) value;
+ (void) mbox: (NSString *) messageText : (NSString *) caption;
+ (Note*) activeNote;
+ (void) setActiveNoteAsNew;
+ (void) setActiveNoteByPath : (NSString*) fullPath;
+ (void) setActiveNoteByNote : (Note *) note;
@end
