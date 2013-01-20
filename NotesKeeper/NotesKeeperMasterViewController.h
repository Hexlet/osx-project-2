/*//
//  NotesKeeperMasterViewController.h
//  NotesKeeper
//
//  Created by Stan Buran on 11/20/12.
//  Copyright (c) 2012 apoidea. All rights reserved.
//*/
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface NotesKeeperMasterViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnExchange;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnAdd;

- (IBAction)btnOptions_Clicked:(id)sender;
@end
