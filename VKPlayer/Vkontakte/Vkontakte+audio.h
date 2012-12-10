//
//  Vkontakte+audio.h
//  VKPlayer
//
//  Created by phantom on 09.12.12.
//  Copyright (c) 2012 kipelovets. All rights reserved.
//

#import "Vkontakte.h"

@protocol VkontakteAudioDelegate <NSObject>
@required
- (void)vkontakteDidFinishGettingAudio:(NSArray*)audio forUser:(NSString*)userId;

@end

@interface Vkontakte (audio)

- (void)runMethod:(NSString*)method withParameters:(NSDictionary*)params withBlock:(void (^) (id))block;
- (void)getAudioForUser:(NSString *)userId;
@end
