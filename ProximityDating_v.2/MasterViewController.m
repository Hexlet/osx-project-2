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
    _searchResults = [ProfileDoc getArrayWithData];
    
    [NSTimer scheduledTimerWithTimeInterval:2.0
                                     target:self
                                   selector:@selector(getDistanceAndSortArray)
                                   userInfo:nil
                                    repeats:YES];
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
    if (tableView == self.searchDisplayController.searchResultsTableView)
        return _searchResults.count;
    else
        return _datersProfiles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:@"MyBasicCell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"MyBasicCell"];
    }
    
    ProfileDoc *profile;
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        profile = [self.searchResults objectAtIndex:indexPath.row];
    } else {
        profile = [self.datersProfiles objectAtIndex:indexPath.row];
    }
    
    cell.textLabel.text = profile.data.name;
    cell.imageView.image = profile.thumbImage;
    
    CLLocationDistance distance = [profile.data.location distanceFromLocation:_myProfile.data.location];
    
    if (distance == -1)
        cell.detailTextLabel.text = @"no data";
    else
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%4.0f m.", distance];
    
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
        
        if ([self.searchDisplayController isActive])
        {
            ProfileDoc *profile = [self.searchResults objectAtIndex:self.searchDisplayController.searchResultsTableView.indexPathForSelectedRow.row];
            [[segue destinationViewController] setDetailItem:profile];
            
        } else
        {
            ProfileDoc *profile = [self.datersProfiles objectAtIndex:self.tableView.indexPathForSelectedRow.row];
            [[segue destinationViewController] setDetailItem:profile];
        }
    }
}

-(void) viewWillAppear: (BOOL) animated
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.myProfile = appDelegate.profile;
    
    NSArray *filteredArray = [self getFilteredArray];
    
    [self.datersProfiles removeAllObjects];
    [self.datersProfiles addObjectsFromArray:filteredArray];
    
    [self getDistanceAndSortArray];
    
}

- (NSArray *)getFilteredArray
{
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
    
    return filteredArray;
}


-(void)getDistanceAndSortArray
{
    NSArray *sortedArray1 = [self.datersProfiles  sortedArrayUsingComparator:^NSComparisonResult(ProfileDoc *obj1, ProfileDoc *obj2) {
        CLLocationDistance distance1 = [obj1.data.location distanceFromLocation:_myProfile.data.location];
        CLLocationDistance distance2 = [obj2.data.location distanceFromLocation:_myProfile.data.location];
        
        if (distance1 <= distance2)
            return NSOrderedAscending;
        else
            return NSOrderedDescending;
    }];


    [self.datersProfiles removeAllObjects];
    [self.datersProfiles addObjectsFromArray:sortedArray1];
    
    
    NSArray *sortedArray2 = [self.searchResults  sortedArrayUsingComparator:^NSComparisonResult(ProfileDoc *obj1, ProfileDoc *obj2) {
        CLLocationDistance distance1 = [obj1.data.location distanceFromLocation:_myProfile.data.location];
        CLLocationDistance distance2 = [obj2.data.location distanceFromLocation:_myProfile.data.location];
        
        if (distance1 <= distance2)
            return NSOrderedAscending;
        else
            return NSOrderedDescending;
    }];
    
    
    [self.searchResults removeAllObjects];
    [self.searchResults addObjectsFromArray:sortedArray2];
    
    [self.tableView reloadData];
    [self.searchDisplayController.searchResultsTableView reloadData];
     
}

#pragma mark - Search Table View

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"data.name like[cd] %@",[[@"*" stringByAppendingString:searchText] stringByAppendingString:@"*"]];
    
    NSArray *filteredArray = [self getFilteredArray];
    NSArray *searchFilteredArray = [filteredArray filteredArrayUsingPredicate:predicate];
    
    [self.searchResults removeAllObjects];
    [self.searchResults addObjectsFromArray:searchFilteredArray];
    
    [self.tableView reloadData];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        [self performSegueWithIdentifier: @"showDetail" sender: self];
    }
}

@end
