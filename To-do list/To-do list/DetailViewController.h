//
//  DetailViewController.h
//  To-do list
//
//  Created by Anton Samoylov on 04.12.12.
//  Copyright (c) 2012 Anton Samoylov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
