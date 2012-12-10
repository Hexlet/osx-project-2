//
//  FirstViewController.h
//  VKPlayer
//
//  Created by phantom on 18.11.12.
//  Copyright (c) 2012 kipelovets. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Vkontakte+audio.h"

@interface FirstViewController : UIViewController <VkontakteAudioDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *table;

- (void)vkontakteDidFinishGettingAudio:(NSArray*)audio forUser:(NSString*)userId;

@end
