//
//  ProfileData.h
//  ProximityDating_v.2
//
//  Created by Admin on 12/18/12.
//  Copyright (c) 2012 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreLocationController.h"

@interface ProfileData : NSObject

@property (strong) NSString *name;
@property (strong) NSString *description;
@property (assign) Boolean isMale;
@property (assign) Boolean straight;
@property (assign) Boolean lookingForPartner;

@property (strong) CLLocation *location;

- (void)initWithName:(NSString*)name description:(NSString*)description gender:(Boolean)isMale sexuality:(Boolean)straight lookingForPartner:(Boolean)lookingForPartner;
- (void)setLatitude:(double)latitude longitude:(double)longitude;
@end
