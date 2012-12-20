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

@interface MyProfileViewController : UIViewController <UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong) ProfileDoc *myProfile;
@property (weak, nonatomic) IBOutlet UIImageView *myProfileImageField;
@property (weak, nonatomic) IBOutlet UITextView *myProfileDescriptionField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *myProfileGenderSelector;
@property (weak, nonatomic) IBOutlet UISegmentedControl *myProfileOrientationSelector;
@property (weak, nonatomic) IBOutlet UISegmentedControl *mySerachPreferenceSelector;


@property (strong, nonatomic) UIImagePickerController * picker;

- (IBAction)removeKeys:(id)sender;

- (IBAction)setMyGeographicPosition:(id)sender;
- (IBAction)changeProfilePictureTapped:(id)sender;
- (IBAction)descriptionFieldTextChanged:(id)sender;

- (IBAction)genderChanged:(id)sender;
- (IBAction)orientationChanged:(id)sender;
- (IBAction)lookingForChanged:(id)sender;


@end
