//
//  Setup.m
//  Спички1
//
//  Created by Максім Демідовіч on 25.12.12.
//  Copyright (c) 2012 ira. All rights reserved.
//

#import "Setup.h"

@implementation Setup
static Setup *instance =nil;
+(Setup *)getInstance
{
    @synchronized(self)
    {
        if(instance==nil)
        {
            
            instance= [Setup new];
            instance.MatchesCount = 3;
            instance.ShortMatchesCount = 1;
        }
    }
    return instance;
}
@end
