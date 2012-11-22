//
//  DiskActivity.h
//  osx-project-2
//
//  Created by macuser1 on 11/22/12.
//  Copyright (c) 2012 Pavel Popchikovsky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DiskActivityProtocol.h"

@interface DiskActivity : NSObject

- (DiskActivity*)initWithProtocol:(id<DiskActivityProtocol>)activityProtocol andPeriod:(float)period;

- (NSNumber*)getCurrent;

@end
