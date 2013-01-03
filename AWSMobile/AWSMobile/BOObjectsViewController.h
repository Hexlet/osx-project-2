//
//  BOObjectsViewController.h
//  AWSMobile
//
//  Created by Oleg Bogatenko on 29.12.12.
//  Copyright (c) 2012 DoZator Home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AWSiOSSDK/S3/AmazonS3Client.h>

@interface BOObjectsViewController : UIViewController<UITableViewDelegate, UITableViewDataSource> {
    NSMutableArray *objects;
}

@property NSString *thisName;

@end
