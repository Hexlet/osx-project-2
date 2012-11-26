//
//  Note.m
//  NotesKeeper
//
//  Created by Stan Buran on 26/11/12.
//  Copyright (c) 2012 apoidea. All rights reserved.
//

#import "Note.h"

@implementation Note

-(id) init
{
	self = [super init];
	
	if(self)
	{
		CFUUIDRef uuid = CFUUIDCreate(NULL);
		CFStringRef uuidString = CFUUIDCreateString(NULL,uuid);
		CFRelease(uuid);
				
		_filePath = [NSString stringWithFormat: @"%@/%@.noteskeeper", [Note getDocPath], (NSString *) CFBridgingRelease(uuidString)];		
	}
	return self;
}

+(NSString *) getDocPath
{
	return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES)[0];
}
@end
