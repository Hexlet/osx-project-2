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
#import "CryptorEngine.h"

//#import <CoreLocation/CoreLocation.h>
//#import <CommonCrypto/CommonCryptor.h>

@interface Note()
	@property NSString *secretHash;
@end
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
		_secretHash = @"";
	}
	return self;
}
-(id) initWithPath : (NSString*) path {
	if(self = [super init])
	{
		_filePath = path;
		if((_filePath != nil) && [_filePath length] > 10 && [[NSFileManager defaultManager] fileExistsAtPath:_filePath])
		{
			const char *fPath = [_filePath fileSystemRepresentation];

			//get attribute (Name):
			const char *attrName = [@"Name" UTF8String];

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

			//get attribute (SecretHash):
			const char *attrKey = [@"SecretKey" UTF8String];
			ssize_t bufferLen1 = getxattr(fPath,attrKey,NULL,0,0,0);
			if(bufferLen1 > 0)
			{
				char *buffer1 = malloc(bufferLen1);
				getxattr(fPath, attrKey, buffer1, 255, 0, 0);
				_secretHash = [[NSString alloc] initWithBytes:buffer1 length:bufferLen1 encoding:NSUTF8StringEncoding];
				free(buffer1);
			}
			else
				_secretHash = @"";

			//get Text:
			_Text = @"";

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
-(void) loadNoteText{
	if(_secretHash.length > 0)
	{
		_Text = [self decrypt:[[NSString alloc] initWithData:[NSData dataWithContentsOfFile:_filePath] encoding:NSUTF8StringEncoding]
					  withKey:[self decrypt:_secretHash withKey:@"sib"]];
	}
	else
		_Text = [[NSString alloc] initWithData:[NSData dataWithContentsOfFile:_filePath] encoding:NSUTF8StringEncoding];
}
-(bool) save {
	NSError *error;
	bool allok;

	if(_secretHash.length > 0)
	{
		NSString *txtVal = [self encrypt:_Text withKey:[self decrypt:_secretHash withKey:@"sib"]];
		allok = [txtVal writeToFile:_filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
	}
	else
		allok = [_Text writeToFile:_filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];

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

		if(_secretHash.length > 0)
			_noteName = [NSString stringWithFormat:@"🔒 %@", _noteName];

		const char *fPath = [_filePath fileSystemRepresentation];

		//set attrib: secretKey
		const char *attrKey = [@"SecretKey" UTF8String];
		NSData *encodedString = [_secretHash dataUsingEncoding: NSUTF8StringEncoding];
		setxattr(fPath, attrKey, [encodedString bytes], [encodedString length],0,0);

		//set attrib: Note name
		const char *attrName = [@"Name" UTF8String];
		encodedString = [_noteName dataUsingEncoding: NSUTF8StringEncoding];
		setxattr(fPath, attrName, [encodedString bytes], [encodedString length], 0, 0);

		_changeDate = [NSDate date];
	}
	return allok;
}
-(bool) isLocked{
	return (_secretHash.length > 0);
}
-(void) setSecret: (NSString *) password{

	if(password.length > 0)
		_secretHash = [self encrypt:password withKey:@"sib"];
	else
		_secretHash = @"";
}
-(bool) checkPassword: (NSString *) password{
	return [_secretHash isEqualToString: [self encrypt:password withKey:@"sib"]];
}
-(NSString * ) encrypt: (NSString *) text_to_ecrypt withKey: (NSString *) key{
	return [NSData encryptString:text_to_ecrypt password:key];
}
-(NSString *) decrypt: (NSString *) text_to_decrypt withKey: (NSString *) key{
	return [NSData decryptString:text_to_decrypt password:key];
}
@end
