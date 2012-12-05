//
//  PitbulCommandProvider.h
//  iPitbul
//
//  Created by Mykhailo Oleksiuk on 12/2/12.
//  Copyright (c) 2012 Mykhailo Oleksiuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PitbulCommand.h"

@interface PitbulCommandProvider : NSObject

+ (NSArray *)availableCommands;
+ (PitbulCommand *)pitbulCommand:(NSString *)commandName;

@end
