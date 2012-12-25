//
//  Setup.h
//  Спички1
//
//  Created by Максім Демідовіч on 25.12.12.
//  Copyright (c) 2012 ira. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Setup : NSObject

@property int MatchesCount;
@property int ShortMatchesCount;

+(Setup*)getInstance; 

@end
