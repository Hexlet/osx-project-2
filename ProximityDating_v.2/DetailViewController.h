//
//  DetailViewController.h
//  ProximityDating_v.2
//
//  Created by Admin on 12/17/12.
//  Copyright (c) 2012 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreLocationController.h"
#import "ProfileDoc.h"

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (strong) ProfileDoc *myProfile;

@property (weak, nonatomic) IBOutlet UIImageView *profileImageField;
@property (weak, nonatomic) IBOutlet UITextView *descriptionField;
@property (weak, nonatomic) IBOutlet UILabel *distanceField;
@property (weak, nonatomic) IBOutlet UILabel *lastCoordinatesReceivedDataField;
- (IBAction)removeFromListTapped:(id)sender;
@end
