//
//  DetailViewController.m
//  ProximityDating_v.2
//
//  Created by Admin on 12/17/12.
//  Copyright (c) 2012 Admin. All rights reserved.
//

#import "DetailViewController.h"
#import "ProfileDoc.h"
#import "ProfileData.h"
#import "AppDelegate.h"

@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem)
    {
        self.title = ((ProfileDoc*)self.detailItem).data.name;
        self.descriptionField.text = ((ProfileDoc*)self.detailItem).data.description;
        self.profileImageField.image = ((ProfileDoc*)self.detailItem).fullImage;
        [self getDistanceAndDiretion];
    }
}

-(void)getDistanceAndDiretion
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.myProfile = appDelegate.profile;
    
    CLLocation *pinLocation = ((ProfileDoc*)self.detailItem).data.location;
    CLLocation *userLocation = _myProfile.data.location;
    CLLocationDistance distance = [pinLocation distanceFromLocation:userLocation];
    
    float userLon = userLocation.coordinate.longitude;
    float userLat = userLocation.coordinate.latitude;
    float poiLon = pinLocation.coordinate.longitude;
    float poiLat = pinLocation.coordinate.latitude;
    
    float a = poiLon - userLon;
    float b = poiLat - userLat;
    float alpha = 180.0 * atan2(a, b) / M_PI;
    if (alpha < 0.0)
        alpha += 360.0;
    else if (alpha > 360.0)
        alpha -= 360.0;
    
    NSString *direction;
    
    if (alpha > 337.5 || alpha <= 22.5)
        direction = @"N";
    else if (alpha > 22.5 || alpha <= 67.5)
        direction = @"NE";
    else if (alpha > 67.5 || alpha <= 112.5)
        direction = @"E";
    else if (alpha > 112.5 || alpha <= 157.5)
        direction = @"SE";
    else if (alpha > 157.5 || alpha <= 202.5)
        direction = @"S";
    else if (alpha > 202.5 || alpha <= 247.5)
        direction = @"SW";
    else if (alpha > 247.5 || alpha <= 292.5)
        direction = @"W";
    else if (alpha > 292.5 || alpha <= 337.5)
        direction = @"NW";
    
    self.distanceField.text = [NSString stringWithFormat:@"Distance: %4.0fm %@", distance, direction];
    
    NSDate *currentTime = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"hh:mm:ss MM/dd/yyyy"];
    NSString *resultTime = [dateFormatter stringFromDate: currentTime];
    
    self.lastCoordinatesReceivedDataField.text = [NSString stringWithFormat:@"on %@", resultTime];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    
    [NSTimer scheduledTimerWithTimeInterval:2.0
                                     target:self
                                   selector:@selector(getDistanceAndDiretion)
                                   userInfo:nil
                                    repeats:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)removeFromListTapped:(id)sender
{
    ((ProfileDoc*)_detailItem).removedFromShowList = true;
}
@end
