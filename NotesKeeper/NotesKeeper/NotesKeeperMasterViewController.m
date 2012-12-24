//
//  NotesKeeperMasterViewController.m
//  NotesKeeper
//
//  Created by Stan Buran on 11/20/12.
//  Copyright (c) 2012 apoidea. All rights reserved.
//

#import "NotesKeeperMasterViewController.h"
#import "NotesKeeperDetailViewController.h"
#import "Common.h"
#import "Note.h"

@interface NotesKeeperMasterViewController ()
    - (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end

@implementation NotesKeeperMasterViewController
NSMutableArray *tSource;

- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)viewDidLoad{
    [super viewDidLoad];

	tSource = [[NSMutableArray alloc] init];
		
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    [self LoadDataCells];

	[_btnAdd setTarget:self];
	[_btnAdd setAction:@selector(btnAdd_Clicked:)];
}

-(void) viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    [self.navigationController setToolbarHidden:NO animated:YES];
        
	if(Common.activeNote != nil)
	{
		if([[NSFileManager defaultManager] fileExistsAtPath:Common.activeNote.filePath])
		{
			if(![tSource containsObject: Common.activeNote.filePath])
			{
				[tSource addObject: Common.activeNote.filePath];
				[self.tableView reloadData];
			}
			//Reload active node:
			NSIndexPath *iPath = [NSIndexPath indexPathForRow:[tSource indexOfObject:Common.activeNote.filePath] inSection:0];
			UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:iPath];
			Note *note = [[Note alloc] initWithPath:Common.activeNote.filePath];
			cell.textLabel.text = note.noteName;

			//[self.tableView reloadData];

			[self.tableView selectRowAtIndexPath:iPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
		}

		Common.activeNote.noteName = nil;
		Common.activeNote = nil;
	}
}
-(void) dealloc{
	[tSource removeAllObjects];
	tSource = nil;

}
-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [tSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CELLID_CONST];

	if(!cell)
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:CELLID_CONST];
    
    Note *note = [[Note alloc] initWithPath:[tSource objectAtIndex:indexPath.row]];
    cell.textLabel.Text = note.noteName;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{return YES;}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete)
	{
		//Delete file:
		[[NSFileManager defaultManager] removeItemAtPath:[tSource objectAtIndex:indexPath.row] error:nil];

		//[self.tableView beginUpdates];

		//Delete object from array:
		[tSource removeObjectAtIndex:indexPath.row];

		//Delete cell:
		[self.tableView deleteRowsAtIndexPaths:  [NSArray arrayWithObject: indexPath] withRowAnimation:UITableViewRowAnimationFade];

		//[self.tableView endUpdates];
		//[self.tableView reloadData];
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    // The table view should not be re-orderable.
    return NO;
}
/*
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        [[segue destinationViewController] LoadData: [tSource objectAtIndex:indexPath.row]];
	}
    
}
*/
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[Common setActiveNote:[tSource objectAtIndex:indexPath.row]];
	[self performSegueWithIdentifier:@"detailsViewcontroller" sender:self];
}

#pragma mark - Fetched results controller

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
    [self.tableView endUpdates];
	[self.tableView reloadData];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    switch(type)
	{
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    UITableView *tableView = self.tableView;
    
    switch(type)
	{
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

-(void) configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"\nChekpoint #NJT980: configureCell\n");
}

#pragma mark - Other methods
-(void) LoadDataCells {
	[tSource removeAllObjects];
	NSString *dir = [Note getDocPath];
	NSArray *filesRaw = [[NSFileManager defaultManager] contentsOfDirectoryAtPath: dir error:nil];
	NSPredicate *filter = [NSPredicate predicateWithFormat:@"self ENDSWITH '.noteskeeper'"];
	NSArray *files = [filesRaw filteredArrayUsingPredicate:filter];

	for(NSString *strVal in files)
	{
		NSString *fPath = [NSString stringWithFormat:@"%@/%@",dir,strVal];

		if(![tSource containsObject:fPath])
			[tSource addObject: fPath];
	}

	[self.tableView reloadData];
}

- (IBAction)btnOptions_Clicked:(id)sender {
    [tSource removeAllObjects];
    [self.tableView reloadData];
    
    
    [self LoadDataCells];
}

-(void) btnAdd_Clicked: (id)sender {
	[Common setActiveNoteAsNew];
	[Common setEditMode: ENUM_WRITE];
	[self performSegueWithIdentifier:@"detailsViewcontroller" sender:self];
}
@end
