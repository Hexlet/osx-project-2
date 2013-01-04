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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reload) name:@"reloadRequest" object:nil];
}

- (void)reload {
    [bucketsList removeAllObjects];
    [bucketsList addObjectsFromArray:[s3 listBuckets]];
    [bucketsTableView reloadData];
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
  
    NSString *listTitle = @"Buckets";
  
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:listTitle];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:listTitle];
    }
  
    NSMutableString *bucketName = (NSMutableString *)[[bucketsList objectAtIndex:indexPath.row] name];
  
    //Prepare cell lables
    cell.imageView.image = [UIImage imageNamed:@"bucket.png"];
    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_bg.png"]];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.detailTextLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = bucketName;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Objects: %i Location: %@", [[s3 listObjectsInBucket:bucketName] count], [BORegionsHelper getRegionRealName:[[s3 getBucketLocation:bucketName] description]]];
    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BOObjectsViewController *objectsView = [self.storyboard instantiateViewControllerWithIdentifier:@"Objects"];
    objectsView.bucketName = [[bucketsList objectAtIndex:indexPath.row] name];
    [self.navigationController pushViewController:objectsView animated:YES];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark Add New Bucket Method

- (IBAction)addBucket:(id)sender {
   
}

#pragma mark -

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -

- (IBAction)refresh:(id)sender {
    [self reload];
}

- (void)viewDidUnload {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
