//
//  AddRecipesViewController.m
//  Recipes
//
//  Created by Sergey on 02.12.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AddRecipesViewController.h"
#import "DetailViewController.h"
#import "RecipesConstants.h"

@implementation AddRecipesViewController
@synthesize drinkArray = drinkArray_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save:)];
    self.nameTextFiels.userInteractionEnabled = TRUE;
    self.ingredientsTextView.userInteractionEnabled = TRUE;
    self.directionsTextView.userInteractionEnabled = TRUE;
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Save and Cancel
- (IBAction)save:(id)sender {
    NSLog(@"Save pressed !");
    if (self.drink != nil) {
        [drinkArray_ removeObject:self.drink];
        self.drink = nil;
    }
    
    NSMutableDictionary *newRecipe = [[NSMutableDictionary alloc] init];
    [newRecipe setValue:self.nameTextFiels.text forKey:NAME_KEY];    
    [newRecipe setValue:self.ingredientsTextView.text forKey:INGREDIENTS_KEY];        
    [newRecipe setValue:self.directionsTextView.text forKey:DIRECTIONS_KEY];    
    [drinkArray_ addObject:newRecipe];
    NSSortDescriptor *nameSorter = [[NSSortDescriptor alloc] initWithKey:NAME_KEY ascending:YES selector:@selector(caseInsensitiveCompare:)];
    [drinkArray_ sortUsingDescriptors:[NSArray arrayWithObject:nameSorter]];
    [self dismissModalViewControllerAnimated:YES];    
    
}

- (IBAction)cancel:(id)sender {
    NSLog(@"Cancel pressed !");
    [self dismissModalViewControllerAnimated:YES];    
}

- (void) keyboardDidHide:(NSNotification *) notif {
    if (!KeyboardVisible_) {
        NSLog(@"%@",@"Keyboard already hide. Ignoring notification.");        
        return;
    }
    NSLog(@"%@", @"Изменение размера при скрытии клавиатуры");
    self.scrollView.frame = self.view.bounds;
    KeyboardVisible_ = NO;        
}

- (void) keyboardDidShow:(NSNotification *) notif {    
    if (KeyboardVisible_) {
        NSLog(@"%@",@"Keyboard is alredy visible. Ignoring notification.");        
        return;
    }
    NSLog(@"%@", @"Изменение размера при появлении клавиатуры");
    NSDictionary *info = [notif userInfo];
    NSValue *aValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];    
    CGRect keyboardRect = [aValue CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    CGFloat keyboardTop = keyboardRect.origin.y;        
    CGRect viewFrame = self.view.bounds;
    viewFrame.size.height = keyboardTop - self.view.bounds.origin.y;  
    self.scrollView.frame = viewFrame;
    KeyboardVisible_ = YES;    
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardWillHideNotification object:nil];
    KeyboardVisible_ = NO;    
}

-(void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];       
    [[NSNotificationCenter defaultCenter] removeObserver:self];    
}

@end
