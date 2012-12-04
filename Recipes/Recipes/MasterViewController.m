//
//  MasterViewController.m
//  Recipes
//
//  Created by Sergey on 01.12.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "RecipesConstants.h"
#import "AddRecipesViewController.h"

@implementation MasterViewController

@synthesize addButton;
@synthesize detailViewController = _detailViewController;
@synthesize addRecipesViewController = _addRecipesViewController;
@synthesize drinks = drinks_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Список рецептов", @"Список рецептов");
    }
    return self;
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
    NSString *path = [[NSBundle mainBundle] pathForResource: @"RecipesDirections" ofType:@"plist"];
    	// Do any additional setup after loading the view, typically from a nib.
    //drinks_  = [[NSMutableArray alloc] initWithObjects:@"Firecracker", @"Lemon Drop", @"Mojito", nil];    
    drinks_ = [[NSMutableArray alloc] initWithContentsOfFile:path];
    self.navigationItem.rightBarButtonItem = self.addButton;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(DidEnterBackgroundApp:) name:UIApplicationDidEnterBackgroundNotification object:nil];    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
} 
    

- (void)viewDidUnload
{
    [self setAddButton:nil];
    [super viewDidUnload];
    [[NSNotificationCenter defaultCenter] removeObserver:self];    
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
    [self.tableView reloadData];

}

- (void) DidEnterBackgroundApp:(NSNotification *) notif {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"RecipesDirections" ofType: @"plist"];
    [self.drinks writeToFile:path atomically:YES]; //этот код создает проблемы на реальном устройстве
    NSLog(@"Save RecipesDirections !");
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

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
 //   return [self.drinks count];
//    NSLog(@"Количество строк %@",[self.drinks count]);
    return [self.drinks count];
//    return  1;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = [[self.drinks objectAtIndex:indexPath.row] objectForKey:NAME_KEY];
    }
    cell.textLabel.text = [[self.drinks objectAtIndex:indexPath.row] objectForKey:NAME_KEY];
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.drinks removeObjectAtIndex:indexPath.row];        
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.editing) {
        if (!self.addRecipesViewController) {
            self.addRecipesViewController = [[AddRecipesViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
        }
        self.addRecipesViewController.drink = [self.drinks objectAtIndex:indexPath.row];
        self.addRecipesViewController.drinkArray = self.drinks;
        UINavigationController *editingNavCon = [[UINavigationController alloc] initWithRootViewController:self.addRecipesViewController];
              
        [self.navigationController presentModalViewController:editingNavCon animated:YES];        
    }
    else {        
        if (!self.detailViewController) {
            self.detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
        }
        self.detailViewController.drink = [self.drinks objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:self.detailViewController animated:YES];
    }    
}

- (IBAction)addButtonPressed:(id)sender {
    NSLog(@"Add button pressed !");
    AddRecipesViewController *addViewController = [[AddRecipesViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    addViewController.drinkArray = self.drinks;
    UINavigationController *addNavController = [[UINavigationController alloc] initWithRootViewController:addViewController];
    [self presentModalViewController:addNavController animated:YES];
    
}

#pragma mark - Save and Cancel
- (IBAction)edit:(id)sender {
    NSLog(@"Edit pressed !");
    editRecipes_ = YES;
}
@end


