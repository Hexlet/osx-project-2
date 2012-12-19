//
//  ProfileDoc.h
//  ProximityDating_v.2
//
//  Created by Admin on 12/18/12.
//  Copyright (c) 2012 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProfileData.h"

@interface ProfileDoc : NSObject

@property (strong) ProfileData *data;
@property (strong) UIImage *thumbImage;
@property (strong) UIImage *fullImage;

@property (strong) NSString *thumbImageName;
@property (strong) NSString *fullImageName;

@property (assign) Boolean removedFromShowList;

+(NSMutableArray*)getArrayWithData;

@end
