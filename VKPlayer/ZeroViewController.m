//
//  ZeroViewController.m
//  VKPlayer
//
//  Created by phantom on 18.11.12.
//  Copyright (c) 2012 kipelovets. All rights reserved.
//

#import "ZeroViewController.h"
#import "Vkontakte.h"

@interface ZeroViewController ()

@end

@implementation ZeroViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    Vkontakte * vk = [Vkontakte sharedInstance];
    
    if ([vk isAuthorized]) {
        [self gotoMainView];
    } else {
        vk.delegate = self;
        [vk authenticate];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)gotoMainView
{
    [self performSegueWithIdentifier:@"openMain" sender:self];
    //[navCtrl pushViewController:ctrl animated:YES];

}

- (void)vkontakteDidFailedWithError:(NSError *)error
{
    NSLog(@"%@", error);
}

- (void)showVkontakteAuthController:(UIViewController *)controller
{
    [self presentModalViewController:controller animated:YES];
}

- (void)vkontakteAuthControllerDidCancelled
{
    NSLog(@"Cancel");
    [self dismissModalViewControllerAnimated:YES];
}

- (void)vkontakteDidFinishLogin:(Vkontakte *)vkontakte
{
    NSLog(@"Finish");
    [self gotoMainView];
    [self dismissModalViewControllerAnimated:YES];
}

@end
