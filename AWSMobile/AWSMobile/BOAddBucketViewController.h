//
//  BOAddBucketViewController.h
//  AWSMobile
//
//  Created by Oleg Bogatenko on 26.12.12.
//  Copyright (c) 2012 DoZator Home. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BOAddBucketViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate> {
  
    IBOutlet UITextField *fieldBucketName;
    NSArray *regions;  
}

- (IBAction)cancel:(id)sender;

@end
