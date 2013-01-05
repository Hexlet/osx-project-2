//
//  BOObjectDetailViewController.m
//  AWSMobile
//
//  Created by Oleg Bogatenko on 05.01.13.
//  Copyright (c) 2013 DoZator Home. All rights reserved.
//

#import "BOObjectDetailViewController.h"

static AmazonS3Client *s3 = nil;

@implementation BOObjectDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    imageName.text = [_thisImage description];
    lastModified.text = [_thisImage lastModified];
    storageClass.text = [_thisImage storageClass];
    owner.text = [[_thisImage owner] displayName];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSURL*)getURL {
    
    s3 = [self connection];
    
    S3ResponseHeaderOverrides *override = [[S3ResponseHeaderOverrides alloc] init];
    override.contentType = @"image/jpeg";
    
    S3GetPreSignedURLRequest *gpsur = [[S3GetPreSignedURLRequest alloc] init];
    gpsur.key = [_thisImage description];
    gpsur.bucket = _inBucket;
    gpsur.expires = [NSDate dateWithTimeIntervalSinceNow:(NSTimeInterval)3600];
    gpsur.responseHeaderOverrides = override;
    
    NSError *error;
    NSURL *imageUrl = [s3 getPreSignedURL:gpsur error:&error];
    
    return imageUrl;
}

#pragma mark ShowInBrowser Method

- (IBAction)showInBrowser:(id)sender {
    
    @try {
        NSURL *url = [self getURL];
        [[UIApplication sharedApplication] openURL:url];
    }
    @catch (NSException *exception) {
        UIAlertView *erralert = [[UIAlertView alloc] initWithTitle:@"Error open!" message:@"Can't get url for image!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [erralert show];
    }
}

#pragma mark Tweet

- (IBAction)tweet:(id)sender {
    
    NSURL *url = [self getURL];
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        
        SLComposeViewController *mySLComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        [mySLComposerSheet setInitialText:@"This is my new photo!"];
        [mySLComposerSheet addURL:url];
        
        [self presentViewController:mySLComposerSheet animated:YES completion:nil];
    }
}

@end
