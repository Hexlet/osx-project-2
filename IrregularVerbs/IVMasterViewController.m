//
//  IVMasterViewController.m
//  IrregularVerbs
//
//  Created by Andrew on 23.08.12.
//  Copyright (c) 2012 AndrewVanyurin. All rights reserved.
//

#import "IVMasterViewController.h"
#import "IVMasterViewControllerCell.h"
#import "IVList.h"
#import "IVDetailViewController.h"

extern IVList * wordList;

@interface IVMasterViewController () {
    NSMutableArray *_objects;  //!!!!!!!!!!!!!!!!!delete this
}
@end

@implementation IVMasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    self.navigationController.title = @"title";//!!!!!!!!!!!!!!!!!!!не выводится название на nav control e
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)insertNewObject:(id)sender
{
//    if (!_objects) {
//        _objects = [[NSMutableArray alloc] init];
//    }
//    [_objects insertObject:[NSDate date] atIndex:0];
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
    return [[wordList listOfVerbs] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IVMasterViewControllerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

    //NSDate *object = [_objects objectAtIndex:indexPath.row];
    
    NSString * object1 = [[[wordList listOfVerbs] objectAtIndex:indexPath.row] objectAtIndex:0];
    cell.firstLabel.text = object1;
    NSString * object2 = [[[wordList listOfVerbs] objectAtIndex:indexPath.row] objectAtIndex:1];
    cell.secondLabel.text = object2;
    NSString * object3 = [[[wordList listOfVerbs] objectAtIndex:indexPath.row] objectAtIndex:2];
    cell.thirdLabel.text = object3;
    NSString * object4 = [[[wordList listOfVerbs] objectAtIndex:indexPath.row] objectAtIndex:3];
    cell.fourthLabel.text = object4;
    id object5 = [[[wordList listOfVerbs] objectAtIndex:indexPath.row] objectAtIndex:4];
    if ([object5 boolValue]){
        [cell.checkSign setTitle:@"V" forState:UIControlStateNormal];
    }
    else{
        [cell.checkSign setTitle:@" " forState:UIControlStateNormal];
    }
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
        //-----------------------!!!!!!!!!!!!!!!!!! edit _object
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
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//        NSDate *object = [_objects objectAtIndex:indexPath.row];
        [[segue destinationViewController] setNumberWordOfList:@(indexPath.row)];
    }
}

@end
