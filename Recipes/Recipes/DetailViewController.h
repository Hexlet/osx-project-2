//
//  DetailViewController.h
//  Recipes
//
//  Created by Sergey on 01.12.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecipesConstants.h"

@interface DetailViewController : UIViewController {
    NSString *nameTextField_;
    NSString *ingredientsTextView_;
    NSString *diewctionsTextView_;
    NSDictionary *drink_;
    UIScrollView *scrollView_;
}

@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (strong, nonatomic) IBOutlet UITextField *nameTextFiels;
@property (strong, nonatomic) IBOutlet UITextView *ingredientsTextView;
@property (strong, nonatomic) IBOutlet UITextView *directionsTextView;
@property (nonatomic, retain) NSDictionary *drink;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;


@end
