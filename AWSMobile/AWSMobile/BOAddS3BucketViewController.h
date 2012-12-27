//
//  BOAddS3BucketViewController.h
//  AWSMobile
//
//  Created by Oleg Bogatenko on 27.12.12.
//  Copyright (c) 2012 DoZator Home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AWSiOSSDK/S3/AmazonS3Client.h>
#import "BORegionsHelper.h"

@interface BOAddS3BucketViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate> {
    NSArray *pickerRegions;
    IBOutlet UIPickerView *selectRegionPicker;
    IBOutlet UITextField *newBucketName;
}

- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

@end
