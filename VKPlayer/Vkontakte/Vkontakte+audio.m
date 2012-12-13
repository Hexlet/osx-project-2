//
//  Vkontakte+audio.m
//  VKPlayer
//
//  Created by phantom on 09.12.12.
//  Copyright (c) 2012 kipelovets. All rights reserved.
//

#import "Vkontakte+audio.h"

@implementation Vkontakte (audio)

- (void)runMethod:(NSString*)method withParameters:(NSDictionary*)params withBlock:(void (^) (id))block {
    
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"https://api.vk.com/method/%@?", method, nil];
    
    for (NSString * key in params) {
        [requestString appendFormat:@"%@=%@&", key, [params objectForKey:key]];
    }
    
    [requestString appendFormat:@"access_token=%@", accessToken];
    
    NSLog(@"%@", requestString);
    
	NSURL *url = [NSURL URLWithString:requestString];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
	
	NSData *response = [NSURLConnection sendSynchronousRequest:request
											 returningResponse:nil
														 error:nil];
    
    NSString *responseString = [[NSString alloc] initWithData:response
                                                     encoding:NSUTF8StringEncoding];
//    NSLog(@"%@", responseString);
    
    NSError* error;
    NSDictionary* parsedDictionary = [NSJSONSerialization
                                      JSONObjectWithData:response
                                      options:kNilOptions
                                      error:&error];
    
    id responseObject = [parsedDictionary objectForKey:@"response"];
        
    if (responseObject)
    {
        block(responseObject);
    }
    else
    {
        NSDictionary *errorDict = [parsedDictionary objectForKey:@"error"];
        
        if ([self.delegate respondsToSelector:@selector(vkontakteDidFailedWithError:)])
        {
            NSError *error = [NSError errorWithDomain:@"http://api.vk.com/method"
                                                 code:[[errorDict objectForKey:@"error_code"] intValue]
                                             userInfo:errorDict];
            
            if (error.code == 5)
            {
                [self logout];
            }
            
            [self.delegate vkontakteDidFailedWithError:error];
        }
    }
    
}

- (void)getAudioForUser:(NSString *)uid {
    NSDictionary * params = nil;
    if (uid) {
        params = [NSDictionary dictionaryWithObject:uid forKey:@"uid"];
    }
    [self runMethod:@"audio.get" withParameters:params withBlock:^(id response) {
        if ([[self.delegate class] conformsToProtocol:@protocol(VkontakteAudioDelegate)]) {
            id <VkontakteAudioDelegate> del = (id<VkontakteAudioDelegate>)self.delegate;
            
            [del vkontakteDidFinishGettingAudio:(NSArray*)response forUser:uid];
        }
    }];
}
@end
