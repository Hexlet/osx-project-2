//
//  PitbulCommandProvider.m
//  iPitbul
//
//  Created by Mykhailo Oleksiuk on 12/2/12.
//  Copyright (c) 2012 Mykhailo Oleksiuk. All rights reserved.
//

#import "PitbulCommandProvider.h"

@implementation PitbulCommandProvider

+ (NSArray *)availableCommands {
    static NSArray *commands = nil;
    
    if (commands == nil) {
        commands = [NSArray arrayWithObjects:
                    @"AM", @"DM", @"GM", @"ST", @"PW", @"ID",
                    @"IM", @"GL", @"S1", @"S0", @"SM", nil];
    }
    
    return commands;
}

+ (PitbulCommand *)pitbulCommand:(NSString *)commandName {
    return [[PitbulCommand alloc] initWithCommand:commandName andDescription:NSLocalizedString(commandName, nil)];
}

@end
