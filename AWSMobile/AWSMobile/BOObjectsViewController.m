//
//  BOObjectsViewController.m
//  AWSMobile
//
//  Created by Oleg Bogatenko on 29.12.12.
//  Copyright (c) 2012 DoZator Home. All rights reserved.
//

#import "BOObjectsViewController.h"

static AmazonS3Client *s3 = nil;

@implementation BOObjectsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    s3 = [self connection];
    objects = [[NSMutableArray alloc] init];
	objects = (NSMutableArray *)[s3 listObjectsInBucket:_bucketName];
}

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
    
    return [objects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellid = @"oCell";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
    }
    
    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_bg.png"]];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = [[objects objectAtIndex:indexPath.row] description];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)upload:(id)sender {
    imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    imageForUpload = [info objectForKey:UIImagePickerControllerOriginalImage];
    @try {
        NSDate *date = [NSDate date];
        NSString *imgName = [NSString stringWithFormat:@"Go_%@.jpg", date];
        S3PutObjectRequest *upl = [[S3PutObjectRequest alloc] initWithKey:imgName inBucket:_bucketName];
        upl.contentType = @"image/jpeg";
        NSData *imageData = UIImageJPEGRepresentation(imageForUpload, 1.0);
        upl.data = imageData;
        [s3 putObject:upl];
    }
    @catch (AmazonClientException *exception) {
        UIAlertView *erralert = [[UIAlertView alloc] initWithTitle:@"AWS Exception" message:[exception message] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [erralert show];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
