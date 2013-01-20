//
//  NSDataEncryption.h
//  Test
//
//  Created by Stan Buran on 20/1/13.
//  Copyright (c) 2013 Stanislav Burankov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Cryptor)

+ (NSString*) encryptString:(NSString*)text password:(NSString*)password;
+ (NSString*) decryptString:(NSString*)text password:(NSString*)password;

@end