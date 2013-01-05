//
//  BOObjectDetailViewController.h
//  AWSMobile
//
//  Created by Oleg Bogatenko on 05.01.13.
//  Copyright (c) 2013 DoZator Home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AWSiOSSDK/S3/AmazonS3Client.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>

@interface BOObjectDetailViewController : UIViewController<UINavigationControllerDelegate> {
    IBOutlet UILabel *imageName;
    IBOutlet UILabel *lastModified;
    IBOutlet UILabel *storageClass;
    IBOutlet UILabel *owner;
}

@property S3ObjectSummary *thisImage;
@property NSString *inBucket;

- (IBAction)showInBrowser:(id)sender;
- (IBAction)tweet:(id)sender;

@end
