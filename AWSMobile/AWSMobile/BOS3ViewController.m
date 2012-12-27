//
//  BOS3ViewController.m
//  AWSMobile
//
//  Created by Oleg Bogatenko on 26.12.12.
//  Copyright (c) 2012 DoZator Home. All rights reserved.
//

#import "BOS3ViewController.h"

static AmazonS3Client *s3 = nil;

@implementation BOS3ViewController

- (void)viewDidLoad {
  
    [super viewDidLoad];
  
    s3 = [self connection];
  
    //Load buckets array
    bucketsList = [[NSMutableArray alloc] init];
    [bucketsList addObjectsFromArray:[s3 listBuckets]];
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

#pragma mark Manage Table

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
    return [bucketsList count]; //Return the number of rows in the section
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
    NSString *listTitle = @"All Buckets";
  
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:listTitle];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:listTitle];
    }
  
    NSMutableString *bucketName = (NSMutableString *)[[bucketsList objectAtIndex:indexPath.row] name];
  
    cell.textLabel.text = bucketName;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Bucket region: %@", [self getAwsRegionName:[s3 getBucketLocation:bucketName]]];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
  
    if (editingStyle == UITableViewCellEditingStyleDelete) {
    
        S3Bucket *bucketForDelete = [bucketsList objectAtIndex:indexPath.row];
        [bucketsList removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
        @try {
      
            if ([[s3 listObjectsInBucket:[bucketForDelete name]] count] == 0) {
                [s3 deleteBucketWithName:[bucketForDelete name]];
            } else {
                
                NSArray *objectsForDelete = [s3 listObjectsInBucket:[bucketForDelete name]];
                
                for (int i=0; i<[objectsForDelete count]; i++) {
                    [s3 deleteObjectWithKey:[[objectsForDelete objectAtIndex:i] key] withBucket:[bucketForDelete name]];
                }
                
                [s3 deleteBucketWithName:[bucketForDelete name]];
            }
        }
        @catch (AmazonClientException *exception) {
            UIAlertView *erralert = [[UIAlertView alloc] initWithTitle:@"Delete error!" message:[exception message] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [erralert show];

        }
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -

- (NSString *)getAwsRegionName:(S3Region *)region {
  
  NSString *regionName = [[NSString alloc] init];
  
  if (region.description == @"eu-west-1") {
    regionName = @"Ireland";
  } else if (region.description == @"sa-east-1") {
    regionName = @"Sao Paulo";
  } else if (region.description == @"") {
    regionName = @"USA Standart Location";
  } else if (region.description == @"us-west-1") {
    regionName = @"Northern California";
  } else if (region.description == @"us-west-2") {
    regionName = @"Oregon";
  } else if (region.description == @"ap-northeast-1") {
    regionName = @"Tokyo";
  } else if (region.description == @"ap-southeast-1") {
    regionName = @"Singapore";
  } else if (region.description == @"ap-southeast-2") {
    regionName = @"Sydney";
  } else {
    regionName = @"Unknown Region";
  }
  
  return regionName;
}

#pragma mark Add New Bucket Method

- (IBAction)addBucket:(id)sender {
  
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
