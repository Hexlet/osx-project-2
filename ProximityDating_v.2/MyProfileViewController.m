//
//  MyProfileViewController.m
//  ProximityDating_v.2
//
//  Created by Admin on 12/19/12.
//  Copyright (c) 2012 Admin. All rights reserved.
//

#import "MyProfileViewController.h"
#import "AppDelegate.h"

@interface MyProfileViewController ()

@end

@implementation MyProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.myProfile = appDelegate.profile;
    
    [self configureView];
}

- (void)configureView
{
    if (self.myProfile) {
        self.title = ((ProfileDoc*)self.myProfile).data.name;
        self.myProfileImageField.image = ((ProfileDoc*)self.myProfile).fullImage;
        self.myProfileDescriptionField.text = ((ProfileDoc*)self.myProfile).data.description;
        
        if (((ProfileDoc*)self.myProfile).data.isMale)
            self.myProfileGenderSelector.selectedSegmentIndex = 0;
        else
            self.myProfileGenderSelector.selectedSegmentIndex = 1;
        
        if (((ProfileDoc*)self.myProfile).data.straight)
            self.myProfileOrientationSelector.selectedSegmentIndex = 0;
        else
            self.myProfileOrientationSelector.selectedSegmentIndex = 1;
        
        if (((ProfileDoc*)self.myProfile).data.lookingForPartner)
            self.mySerachPreferenceSelector.selectedSegmentIndex = 0;
        else
            self.mySerachPreferenceSelector.selectedSegmentIndex = 1;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)setMyGeographicPosition:(id)sender {
}
@end
