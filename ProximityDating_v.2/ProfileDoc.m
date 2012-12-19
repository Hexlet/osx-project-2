//
//  ProfileDoc.m
//  ProximityDating_v.2
//
//  Created by Admin on 12/18/12.
//  Copyright (c) 2012 Admin. All rights reserved.
//

#import "ProfileDoc.h"
#import "ProfileData.h"

@implementation ProfileDoc

-(id)init
{
    if (self = [super init])
    {
        self.data = [[ProfileData alloc] init];
        self.removedFromShowList = FALSE;
    }
    return self;
}

+(NSMutableArray*)getArrayWithData
{
    ProfileDoc *profile1 = [[ProfileDoc alloc] init];
    profile1.data.name = @"Potato Bug";
    profile1.data.description = @"Potato Bug short description";
    profile1.data.isMale = TRUE;
    profile1.data.straight = TRUE;
    profile1.data.lookingForPartner = TRUE;
    profile1.thumbImage = [UIImage imageNamed:@"potatoBugThumb.jpg"];
    profile1.fullImage = [UIImage imageNamed:@"potatoBug.jpg"];
    
    ProfileDoc *profile2 = [[ProfileDoc alloc] init];
    profile2.data.name = @"House Centipede";
    profile2.data.description = @"House Centipede short description";
    profile2.data.isMale = FALSE;
    profile2.data.straight = FALSE;
    profile2.data.lookingForPartner = TRUE;
    profile2.thumbImage = [UIImage imageNamed:@"centipedeThumb.jpg"];
    profile2.fullImage = [UIImage imageNamed:@"centipede.jpg"];
    
    ProfileDoc *profile3 = [[ProfileDoc alloc] init];
    profile3.data.name = @"Wolf Spider";
    profile3.data.description = @"Wolf Spider short description";
    profile3.data.isMale = FALSE;
    profile3.data.straight = TRUE;
    profile3.data.lookingForPartner = TRUE;
    profile3.thumbImage = [UIImage imageNamed:@"wolfSpiderThumb.jpg"];
    profile3.fullImage = [UIImage imageNamed:@"wolfSpider.jpg"];
    
    ProfileDoc *profile4 = [[ProfileDoc alloc] init];
    profile4.data.name = @"Lady Bug";
    profile4.data.description = @"Lady Bug short description";
    profile4.data.isMale = TRUE;
    profile4.data.straight = FALSE;
    profile4.data.lookingForPartner = TRUE;
    profile4.thumbImage = [UIImage imageNamed:@"ladybugThumb.jpg"];
    profile4.fullImage = [UIImage imageNamed:@"ladybug.jpg"];
    
    NSMutableArray *daters = [NSMutableArray arrayWithObjects:profile1, profile2, profile3, profile4, nil];
    
    return daters;
}

@end
