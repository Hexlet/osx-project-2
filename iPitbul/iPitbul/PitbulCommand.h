//
//  PitbulCommand.h
//  iPitbul
//
//  Created by Mykhailo Oleksiuk on 12/2/12.
//  Copyright (c) 2012 Mykhailo Oleksiuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PitbulCommand : NSObject

@property NSString *command;
@property NSString *description;

- (id)initWithCommand:(NSString*) command andDescription:(NSString*) description;

@end
