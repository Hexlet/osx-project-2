//
//  MyProfileViewController.h
//  ProximityDating_v.2
//
//  Created by Admin on 12/19/12.
//  Copyright (c) 2012 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileDoc.h"
#import "MasterViewController.h"

@interface MyProfileViewController : UIViewController

@property (strong) ProfileDoc *myProfile;
@property (weak, nonatomic) IBOutlet UIImageView *myProfileImageField;
@property (weak, nonatomic) IBOutlet UITextView *myProfileDescriptionField;

- (IBAction)setMyGeographicPosition:(id)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *myProfileGenderSelector;
@property (weak, nonatomic) IBOutlet UISegmentedControl *myProfileOrientationSelector;
@property (weak, nonatomic) IBOutlet UISegmentedControl *mySerachPreferenceSelector;

@end
