//
//  GSAppDelegate.h
//  ClientGitHub_1.0
//
//  Created by Администратор on 11/9/12.
//  Copyright (c) 2012 GameStore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"

@class GSViewController;

@interface GSAppDelegate : UIResponder <UIApplicationDelegate>
{
    UINavigationController *nc;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) GSViewController *viewController;

@property (assign, nonatomic) NetworkStatus netStatus;
@property (strong, nonatomic) Reachability  *hostReach;

- (void)updateInterfaceWithReachability: (Reachability*) curReach;

@end
