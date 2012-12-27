//
//  BOAddS3BucketViewController.m
//  AWSMobile
//
//  Created by Oleg Bogatenko on 27.12.12.
//  Copyright (c) 2012 DoZator Home. All rights reserved.
//

#import "BOAddS3BucketViewController.h"

static AmazonS3Client *s3 = nil;

@implementation BOAddS3BucketViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark Connection Method

- (AmazonS3Client *)connection {
    
    @try {
        AmazonS3Client *s3 = [[AmazonS3Client alloc] initWithAccessKey:[[NSUserDefaults standardUserDefaults] stringForKey:@"akey"]  withSecretKey:[[NSUserDefaults standardUserDefaults] stringForKey:@"skey"]];
        return s3;
    }
    @catch (AmazonClientException *exception) {
        UIAlertView *erralert = [[UIAlertView alloc] initWithTitle:@"AWS Exception" message:[exception message] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [erralert show];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    s3 = [self connection];
    pickerRegions = [BORegionsHelper getAllRegions];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)done:(id)sender {
    @try {
        if (newBucketName.text != @"") {
            S3Region *newBucketRegion = [S3Region regionWithString:[BORegionsHelper getRegionKey:[pickerRegions objectAtIndex:[selectRegionPicker selectedRowInComponent:0]]]];
            [s3 createBucket:[[S3CreateBucketRequest alloc] initWithName:newBucketName.text andRegion:newBucketRegion]];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
    @catch (AmazonClientException *exception) {
        UIAlertView *erralert = [[UIAlertView alloc] initWithTitle:@"Can't create bucket!" message:[exception message] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [erralert show];
    }

}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1; //We need only one component
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [pickerRegions count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [pickerRegions objectAtIndex:row];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
