//
//  MasterViewController.h
//  ProximityDating_v.2
//
//  Created by Admin on 12/17/12.
//  Copyright (c) 2012 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileDoc.h"

@interface MasterViewController : UITableViewController

@property (strong) NSMutableArray *datersProfiles;
@property (strong) NSMutableArray *fullListOfProfiles;
@property (nonatomic, retain) ProfileDoc *myProfile;

@end
