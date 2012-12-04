//
//  MasterViewController.h
//  To-do list
//
//  Created by Anton Samoylov on 04.12.12.
//  Copyright (c) 2012 Anton Samoylov. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;

@end
