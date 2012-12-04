//
//  AddRecipesViewController.h
//  Recipes
//
//  Created by Sergey on 02.12.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"

@interface AddRecipesViewController : DetailViewController {
    BOOL KeyboardVisible_;
    NSMutableArray *drinkArray_;
}

- (IBAction)save:(id)sender;
- (IBAction)cancel:(id)sender;
- (void) keyboardDidShow: (NSNotification *) notif;
- (void) keyboardDidHide: (NSNotification *) notif;
@property (nonatomic, retain) NSMutableArray *drinkArray;


@end


