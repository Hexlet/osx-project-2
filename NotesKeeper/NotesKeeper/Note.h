//
//  Note.h
//  NotesKeeper
//
//  Created by Stan Buran on 26/11/12.
//  Copyright (c) 2012 apoidea. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Note : NSObject
@property NSString *filePath;
//@property NSFileHandle  *NoteFile;
//@property NSString *passwordHash;

+(NSString *) getDocPath;
@end
