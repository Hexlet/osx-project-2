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
	objects = (NSMutableArray *)[s3 listObjectsInBucket:_thisName];
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

@end
