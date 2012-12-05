//
//  PitbulCommand.m
//  iPitbul
//
//  Created by Mykhailo Oleksiuk on 12/2/12.
//  Copyright (c) 2012 Mykhailo Oleksiuk. All rights reserved.
//

#import "PitbulCommand.h"

@implementation PitbulCommand

- (id)initWithCommand:(NSString *)command andDescription:(NSString *)description {
 
    if (self = [super init]) {
        _command = command;
        _description = description;
    }
    
    return self;
}

@end
