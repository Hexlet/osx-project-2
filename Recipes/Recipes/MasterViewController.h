//
//  MasterViewController.h
//  Recipes
//
//  Created by Sergey on 01.12.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;
@class AddRecipesViewController;

@interface MasterViewController : UITableViewController {
    NSMutableArray* drinks_;
    BOOL editRecipes_;    
}

@property (strong, nonatomic) DetailViewController *detailViewController;
@property (strong, nonatomic) AddRecipesViewController *addRecipesViewController;

@property (nonatomic, retain) NSMutableArray* drinks;

- (IBAction)addButtonPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *addButton;
- (void) DidEnterBackgroundApp:(NSNotification *) notif;
- (IBAction)edit:(id)sender;

@end
