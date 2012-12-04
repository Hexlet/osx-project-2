//
//  DetailViewController.m
//  Recipes
//
//  Created by Sergey on 01.12.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController

@synthesize detailItem = _detailItem;
@synthesize detailDescriptionLabel = _detailDescriptionLabel;
@synthesize directionsTextView;
@synthesize nameTextFiels;
@synthesize ingredientsTextView;
@synthesize drink = drink_;
@synthesize scrollView = scrollView_;

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

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    self.scrollView.contentSize = self.view.frame.size;
//    myTextField.userInteractionEnabled = FALSE; 
    self.nameTextFiels.userInteractionEnabled = FALSE;
    self.ingredientsTextView.userInteractionEnabled = FALSE;
    self.directionsTextView.userInteractionEnabled = FALSE;
}

- (void)viewDidUnload
{
    [self setNameTextFiels:nil];
    [self setIngredientsTextView:nil];
    [self setDirectionsTextView:nil];
    [self setScrollView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.nameTextFiels.text = [self.drink objectForKey:NAME_KEY];
    self.ingredientsTextView.text = [self.drink objectForKey:INGREDIENTS_KEY];
    self.directionsTextView.text = [self.drink objectForKey:DIRECTIONS_KEY];    
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Рецепт", @"Рецепт");
    }
    return self;
}
							
@end
