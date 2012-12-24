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
@property NSString *Text;
@property NSString *noteName;

-(UITableViewCell*) getTableViewCell;
+(NSString *) getDocPath;
-(id) initWithPath : (NSString*) path;
-(bool) save;

@end
