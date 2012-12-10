//
//  CustomSegue.m
//  VKPlayer
//
//  Created by phantom on 21.11.12.
//  Copyright (c) 2012 kipelovets. All rights reserved.
//

#import "CustomSegue.h"

@implementation CustomSegue
    - (void) perform {
        
        UIViewController *src = (UIViewController *) self.sourceViewController;
        UIViewController *dst = (UIViewController *) self.destinationViewController;
        
        [UIView transitionWithView:src.navigationController.view duration:0.2
                           options:UIViewAnimationOptionTransitionFlipFromLeft
                        animations:^{
                            [src.navigationController pushViewController:dst animated:NO];
                        }
                        completion:NULL];
        
    }
@end
