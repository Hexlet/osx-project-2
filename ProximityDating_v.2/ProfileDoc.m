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
    [profile1.data initWithName:@"Potato Bug" description:@"Potato Bug short description" gender:FALSE sexuality:TRUE lookingForPartner:TRUE];
    profile1.thumbImage = [UIImage imageNamed:@"potatoBugThumb.jpg"];
    profile1.fullImage = [UIImage imageNamed:@"potatoBug.jpg"];
    [profile1.data setLatitude:37.331615 longitude:-122.030240];
    
    
    ProfileDoc *profile2 = [[ProfileDoc alloc] init];
    [profile2.data initWithName:@"House Centipede" description:@"House Centipede short description" gender:FALSE sexuality:TRUE lookingForPartner:TRUE];
    profile2.thumbImage = [UIImage imageNamed:@"centipedeThumb.jpg"];
    profile2.fullImage = [UIImage imageNamed:@"centipede.jpg"];
    [profile2.data setLatitude:37.331426 longitude:-122.030728];
    
    ProfileDoc *profile3 = [[ProfileDoc alloc] init];
    [profile3.data initWithName:@"Wolf Spider" description:@"Wolf Spider short description" gender:FALSE sexuality:TRUE lookingForPartner:TRUE];
    profile3.thumbImage = [UIImage imageNamed:@"wolfSpiderThumb.jpg"];
    profile3.fullImage = [UIImage imageNamed:@"wolfSpider.jpg"];
    [profile3.data setLatitude:37.331321 longitude:-122.035386];
    
    ProfileDoc *profile4 = [[ProfileDoc alloc] init];
    [profile4.data initWithName:@"Lady Bug" description:@"Lady Bug short description" gender:FALSE sexuality:TRUE lookingForPartner:TRUE];
    profile4.thumbImage = [UIImage imageNamed:@"ladybugThumb.jpg"];
    profile4.fullImage = [UIImage imageNamed:@"ladybug.jpg"];
    [profile4.data setLatitude:37.331315 longitude:-122.040386];
    
    NSMutableArray *daters = [NSMutableArray arrayWithObjects:profile1, profile2, profile3, profile4, nil];
    
    return daters;
}

@end
