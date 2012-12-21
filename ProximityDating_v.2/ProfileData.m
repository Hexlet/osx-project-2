//
//  ProfileData.m
//  ProximityDating_v.2
//
//  Created by Admin on 12/18/12.
//  Copyright (c) 2012 Admin. All rights reserved.
//

#import "ProfileData.h"

@implementation ProfileData

- (void)initWithName:(NSString*)name description:(NSString*)description gender:(Boolean)isMale sexuality:(Boolean)straight lookingForPartner:(Boolean)lookingForPartner
{
        self.name = name;
        self.description = description;
        self.isMale = isMale;
        self.straight = straight;
        self.lookingForPartner = lookingForPartner;
}

- (void)setLatitude:(double)latitude longitude:(double)longitude
{
    self.location = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
}

@end
