//
//  ZeroViewController.h
//  VKPlayer
//
//  Created by phantom on 18.11.12.
//  Copyright (c) 2012 kipelovets. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Vkontakte.h"

@interface LoginViewController : UIViewController <VkontakteDelegate>
- (void)gotoMainView;
@end
