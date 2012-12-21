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
    [profile1.data initWithName:@"Damon" description:@"Damon's short description" gender:TRUE sexuality:TRUE lookingForPartner:TRUE];
    profile1.fullImage = [UIImage imageNamed:@"Damon.jpg"];
    profile1.thumbImage = [ProfileDoc resizeImage:profile1];
    [profile1.data setLatitude:37.331615 longitude:-122.030240];
    
    
    ProfileDoc *profile2 = [[ProfileDoc alloc] init];
    [profile2.data initWithName:@"Amanda" description:@"Amanda's short description" gender:FALSE sexuality:TRUE lookingForPartner:TRUE];
    profile2.fullImage = [UIImage imageNamed:@"Amanda.jpg"];
    profile2.thumbImage = [ProfileDoc resizeImage:profile2];
    [profile2.data setLatitude:37.331426 longitude:-122.030728];
    
    ProfileDoc *profile3 = [[ProfileDoc alloc] init];
    [profile3.data initWithName:@"Liv" description:@"Liv's short description" gender:FALSE sexuality:TRUE lookingForPartner:TRUE];
    profile3.fullImage = [UIImage imageNamed:@"Liv.jpeg"];
    profile3.thumbImage = [ProfileDoc resizeImage:profile3];
    [profile3.data setLatitude:37.331321 longitude:-122.035386];
    
    ProfileDoc *profile4 = [[ProfileDoc alloc] init];
    [profile4.data initWithName:@"Natali" description:@"Natali's short description" gender:FALSE sexuality:TRUE lookingForPartner:TRUE];
    profile4.fullImage = [UIImage imageNamed:@"Natali.jpg"];
    profile4.thumbImage = [ProfileDoc resizeImage:profile4];
    [profile4.data setLatitude:37.331315 longitude:-122.040386];
    
    NSMutableArray *daters = [NSMutableArray arrayWithObjects:profile1, profile2, profile3, profile4, nil];
    
    return daters;
}

+(UIImage *)resizeImage:(ProfileDoc *)profile
{
    float oldWidth = profile.fullImage.size.width;
    float scaleFactor = 44 / oldWidth;
    
    float newHeight = profile.fullImage.size.height * scaleFactor;
    float newWidth = oldWidth * scaleFactor;
    
    // Resize image
    UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight));
    [profile.fullImage drawInRect: CGRectMake(0, 0, newWidth, newHeight)];
    UIImage *thumbImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return thumbImage;
}
@end
