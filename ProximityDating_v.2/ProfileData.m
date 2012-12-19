//
//  ProfileData.m
//  ProximityDating_v.2
//
//  Created by Admin on 12/18/12.
//  Copyright (c) 2012 Admin. All rights reserved.
//

#import "ProfileData.h"

@implementation ProfileData

- (id)initWithName:(NSString*)name description:(NSString*)description gender:(Boolean)isMale sexuality:(Boolean)straight lookingForPartner:(Boolean)lookingForPartner
{
    if ((self = [super init])) {
        self.name = name;
        self.description = description;
        self.isMale = isMale;
        self.straight = straight;
        self.lookingForPartner = lookingForPartner;
    }
    return self;
}

@end
