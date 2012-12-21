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

-(IBAction)removeKeys:(id)sender
{
    [self.myProfileDescriptionField resignFirstResponder];
    
    NSLog(@"removeKeys description");
    self.myProfile.data.description = self.myProfileDescriptionField.text;
}

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

- (void)locationUpdate:(CLLocation *)location
{
    NSLog(@"LATITUDE: %f LONGITUDE: %f", location.coordinate.latitude, location.coordinate.longitude);
    
    [self.myProfile.data setLatitude:location.coordinate.latitude longitude:location.coordinate.longitude];
}

- (void)locationError:(NSError *)error
{
    NSLog(@"%@",[error description]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)setMyGeographicPosition:(id)sender
{
    CLController = [[CoreLocationController alloc] init];
	CLController.delegate = self;
	[CLController.locMgr startUpdatingLocation];
}

- (IBAction)changeProfilePictureTapped:(id)sender
{
    if (self.picker == nil) {
        self.picker = [[UIImagePickerController alloc] init];
        self.picker.delegate = self;
        self.picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        self.picker.allowsEditing = NO;
    }
    [self.navigationController presentViewController:_picker animated:YES completion:nil];
}

- (IBAction)descriptionFieldTextChanged:(id)sender {
    self.myProfile.data.description = self.myProfileDescriptionField.text;
}

- (IBAction)genderChanged:(id)sender
{
    self.myProfile.data.isMale = self.myProfileGenderSelector.selectedSegmentIndex == 0;
}

- (IBAction)orientationChanged:(id)sender
{
    self.myProfile.data.straight = self.myProfileOrientationSelector.selectedSegmentIndex == 0;
}

- (IBAction)lookingForChanged:(id)sender
{
    self.myProfile.data.lookingForPartner = self.mySerachPreferenceSelector.selectedSegmentIndex == 0;
}

#pragma mark UITextFieldDelegate

#pragma mark UIImagePickerControllerDelegate

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *fullImage = (UIImage *) [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [info objectForKey:UIImagePickerControllerReferenceURL];
   
    // Resize image
    UIGraphicsBeginImageContext(CGSizeMake(44, 44));
    [fullImage drawInRect: CGRectMake(0, 0, 44, 44)];
    UIImage *thumbImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    self.myProfile.fullImage = fullImage;
    self.myProfile.thumbImage = thumbImage;
    self.myProfileImageField.image = fullImage;    
}
@end
