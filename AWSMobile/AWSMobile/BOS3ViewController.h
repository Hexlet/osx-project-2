//
//  BOS3ViewController.h
//  AWSMobile
//
//  Created by Oleg Bogatenko on 26.12.12.
//  Copyright (c) 2012 DoZator Home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AWSiOSSDK/S3/AmazonS3Client.h>

@interface BOS3ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource> {
  
  NSMutableArray *bucketsList;
  IBOutlet UITableView *bucketsTableView;
  
}

- (IBAction)back:(id)sender;
- (IBAction)addBucket:(id)sender;
- (NSString *)getAwsRegionName:(S3Region *)region;

@end
