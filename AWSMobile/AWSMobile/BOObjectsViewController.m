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
    [objects addObjectsFromArray:[s3 listObjectsInBucket:_bucketName]];

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

#pragma mark Manage Objects Table

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
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        @try {
            [s3 deleteObjectWithKey:[[objects objectAtIndex:indexPath.row] key] withBucket:_bucketName];
        }
        @catch (AmazonClientException *exception) {
            UIAlertView *erralert = [[UIAlertView alloc] initWithTitle:@"Delete object error!" message:[exception message] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [erralert show];
        }
        
        [objects removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BOObjectDetailViewController *objectDetailView = [self.storyboard instantiateViewControllerWithIdentifier:@"Detail"];
    
    objectDetailView.thisImage = [objects objectAtIndex:indexPath.row];
    objectDetailView.inBucket = _bucketName;
    
    [self.navigationController pushViewController:objectDetailView animated:YES];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Upload Photo Methods

- (IBAction)upload:(id)sender {
    imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    imageForUpload = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    @try {
        //Date
        NSDate *date = [NSDate date];
        NSString *imgName = [NSString stringWithFormat:@"myphoto_%@.jpg", date];
        
        S3PutObjectRequest *uploadRequest = [[S3PutObjectRequest alloc] initWithKey:imgName inBucket:_bucketName];
        uploadRequest.contentType = @"image/jpeg";
        NSData *imageData = UIImageJPEGRepresentation(imageForUpload, 1.0);
        uploadRequest.data = imageData;
        
        [s3 putObject:uploadRequest];
    }
    @catch (AmazonClientException *exception) {
        UIAlertView *erralert = [[UIAlertView alloc] initWithTitle:@"Upload error!" message:[exception message] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [erralert show];
    }
    [self reload];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark Camera

- (IBAction)useCamera:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIImagePickerController *camPicker = [[UIImagePickerController alloc] init];
        camPicker.delegate = self;
        camPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        camPicker.mediaTypes = [NSArray arrayWithObjects:(NSString *) kUTTypeImage, nil];
        camPicker.allowsEditing = NO;
        [self presentViewController:camPicker animated:YES completion:nil];
    
    } else {
        NSLog(@"No camera!");
    }
}

#pragma mark Reload

- (void)reload {
    [objects removeAllObjects];
    [objects addObjectsFromArray:[s3 listObjectsInBucket:_bucketName]];
    [objectsTableView reloadData];
}

@end
