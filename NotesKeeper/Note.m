//
//  Note.m
//  NotesKeeper
//
//  Created by Stan Buran on 26/11/12.
//  Copyright (c) 2012 apoidea. All rights reserved.
//

#import <sys/xattr.h>
#import "Note.h"
#import "Common.h"
@implementation Note

-(id) init {
	self = [super init];
	
	if(self)
	{
		CFUUIDRef uuid = CFUUIDCreate(NULL);
		CFStringRef uuidString = CFUUIDCreateString(NULL,uuid);
		CFRelease(uuid);
				
		_filePath = [NSString stringWithFormat: @"%@/%@.noteskeeper", [Note getDocPath], (NSString *) CFBridgingRelease(uuidString)];
		_Text = @"";
		_noteName = @"Noname";
		_changeDate = [NSDate date];
	}
	return self;
}
-(id) initWithPath : (NSString*) path {
	if(self = [super init])
	{
		_filePath = path;
		if((_filePath != nil) && [_filePath length] > 10 && [[NSFileManager defaultManager] fileExistsAtPath:_filePath])
		{
			//get attribute (Name):
			const char *attrName = [@"Name" UTF8String];
			const char *fPath = [_filePath fileSystemRepresentation];
			//int bufferLen = getxattr(fPath,attrName,NULL,0,0,0);
			ssize_t bufferLen = getxattr(fPath,attrName,NULL,0,0,0);
			if(bufferLen > 0)
			{

				char *buffer = malloc(bufferLen);
				getxattr(fPath, attrName, buffer, 255, 0, 0);
				_noteName = [[NSString alloc] initWithBytes:buffer length:bufferLen encoding:NSUTF8StringEncoding];
				free(buffer);

			}
			else
				_noteName = @"Unnamed";
			
			//get Text:
			_Text = [[NSString alloc] initWithData: [NSData dataWithContentsOfFile:_filePath] encoding:NSUTF8StringEncoding];

			//get change date:
			_changeDate = [[[NSFileManager defaultManager] attributesOfItemAtPath:_filePath error:nil] fileModificationDate];

		}
		else
		{
			_noteName = @"Missing";
			_Text = @"";
			_changeDate = [NSDate date];
		}
	}
	return self;
}
+(NSString *) getDocPath{
	return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES)[0];
}
-(bool) save {
	NSError *error;

	//_Text = [_Text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

	bool allok = [_Text writeToFile:_filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];

	if(allok)
	{
		NSRange range = [_Text rangeOfCharacterFromSet:[NSCharacterSet newlineCharacterSet]];
		NSString *sTitle = [_Text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];

		if(range.length > 0)
		sTitle = [sTitle substringToIndex:range.location];

		if (sTitle.length > 25) //12
			_noteName = [sTitle substringToIndex:25];
		else
			_noteName = sTitle;

       
		const char *attrName = [@"Name" UTF8String];
		const char *fPath = [_filePath fileSystemRepresentation];
		NSData *encodedString = [_noteName dataUsingEncoding: NSUTF8StringEncoding];
		setxattr(fPath, attrName, [encodedString bytes], [encodedString length], 0, 0);
		_changeDate = [NSDate date];
	}

	return allok;
}
@end
