//
//  DiskActivityProtocol.h
//  osx-project-2
//
//  Created by macuser1 on 11/22/12.
//  Copyright (c) 2012 Pavel Popchikovsky. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DiskActivityProtocol <NSObject>

@required

- (NSNumber *)getValue;

@end
