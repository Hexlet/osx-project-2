//
//  MasterViewController.m
//  ProximityDating_v.2
//
//  Created by Admin on 12/17/12.
//  Copyright (c) 2012 Admin. All rights reserved.
//

#import "MasterViewController.h"
#import "ProfileDoc.h"
#import "DetailViewController.h"
#import "AppDelegate.h"

@interface MasterViewController () {
    NSMutableArray *_objects;
}
@end

@implementation MasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    _datersProfiles = [ProfileDoc getArrayWithData];
    _fullListOfProfiles = [ProfileDoc getArrayWithData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _datersProfiles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:@"MyBasicCell"];
    ProfileDoc *profile = [self.datersProfiles objectAtIndex:indexPath.row];
    cell.textLabel.text = profile.data.name;
    cell.detailTextLabel.text = profile.data.description;
    cell.imageView.image = profile.thumbImage;
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        ProfileDoc *profile = [self.datersProfiles objectAtIndex:self.tableView.indexPathForSelectedRow.row];
        [[segue destinationViewController] setDetailItem:profile];
    }
}

-(void) viewWillAppear: (BOOL) animated
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.myProfile = appDelegate.profile;
    
    NSPredicate *predicate;


    if (_myProfile.data.lookingForPartner)
    {
        if (_myProfile.data.straight)
        {
            predicate = [NSPredicate predicateWithFormat:@"removedFromShowList == %u AND data.lookingForPartner == %u AND data.straight == %u AND data.isMale != %u",
            FALSE, _myProfile.data.lookingForPartner, _myProfile.data.straight, _myProfile.data.isMale];
        }
        else
        {
            predicate = [NSPredicate predicateWithFormat:@"removedFromShowList == %u AND data.lookingForPartner == %u AND data.straight == %u AND data.isMale == %u",
            FALSE, _myProfile.data.lookingForPartner, _myProfile.data.straight, _myProfile.data.isMale];
        }
    }
    else
    {
            predicate = [NSPredicate predicateWithFormat:@"removedFromShowList == %u AND data.lookingForPartner == %u",
            FALSE, _myProfile.data.lookingForPartner];
    }
    
    NSArray *filteredArray = [self.fullListOfProfiles filteredArrayUsingPredicate:predicate];
    
    [self.datersProfiles removeAllObjects];
    [self.datersProfiles addObjectsFromArray:filteredArray];
    
    [self.tableView reloadData];
    
    
}

@end
