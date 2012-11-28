//
//  ECAppDelegate.m
//  Extension checker
//
//  Created by swante on 11/15/12.
//  Copyright (c) 2012 SergeyPershenkov. All rights reserved.
//

#import "ECAppDelegate.h"

@implementation ECAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
  _isChecking = NO;
  _extensions = [[NSMutableDictionary alloc] init];
}

- (void)countFilesByPath
{
  BOOL isDirectory;
  NSString *subPath;
  NSFileManager *fManager = [NSFileManager defaultManager];
  NSDirectoryEnumerator *dirEnum = [fManager enumeratorAtPath:[_currentPathLabel stringValue]];
  NSString *extension;

  unsigned checkedFilesCount = 0;
  
  [_extensions removeAllObjects];
  
  _isChecking = YES;
  [_checkPathButton setTitle:@"Stop"];
  [_selectPathButton setEnabled:NO];
  [_subfoldersBox setEnabled:NO];
  [_caseSensitiveBox setEnabled:NO];
  
  // Looking all subfolders
  while((subPath = [dirEnum nextObject]) != nil && _isChecking)
  {    
    if([_subfoldersBox state] == NSOffState) [dirEnum skipDescendants];
    
    // Check path for type: file/directory
    [fManager fileExistsAtPath:[[_currentPathLabel stringValue] stringByAppendingPathComponent:subPath] isDirectory:&isDirectory];
    
    if(!isDirectory)
    {
      extension = ([_caseSensitiveBox state] == NSOnState) ? [subPath pathExtension] : [[subPath pathExtension] lowercaseString];
      
      // In case of new extension
      if([_extensions objectForKey:extension] == nil)
        // Add it to dictionary with counter 1
        [_extensions setValue:[NSNumber numberWithInt:1] forKey:extension];
      // If extension is already in dictionary
      else
        // Increment counter
        [_extensions setValue:[NSNumber numberWithInt:([[_extensions valueForKey:extension] intValue] + 1)] forKey:extension];
      
      ++checkedFilesCount;
      
      [_checkedFilesLabel setStringValue:[NSString stringWithFormat:@"Checked %u files", checkedFilesCount]];
    }
  }
  
  // Sort extensions by their counters
  _sortedExtensions = [_extensions keysSortedByValueUsingComparator:^NSComparisonResult(id obj1, id obj2)
  {
    if([obj1 intValue] > [obj2 intValue])
      return -1;
    else
      return 1;
  }];
  
  [_table reloadData];
  
  NSMutableString *outString = [NSMutableString stringWithFormat:@"Checked %u files:\n\n", checkedFilesCount];
  
  for(NSString *key in _sortedExtensions)
    [outString appendString:[NSString stringWithFormat:@"%7d of type .%@\n", [[_extensions objectForKey:key] intValue], key]];

  [_output setString:outString];
  
  _isChecking = NO;
  [_checkPathButton setTitle:@"Check path"];
  [_selectPathButton setEnabled:YES];
  [_subfoldersBox setEnabled:YES];
  [_caseSensitiveBox setEnabled:YES];
}

- (IBAction)checkPathClicked:(id)sender
{
  if(_isChecking)
    _isChecking = NO;
  else
    [self performSelectorInBackground:@selector(countFilesByPath) withObject:nil];
}

- (IBAction)selectFolderClicked:(id)sender
{
  NSOpenPanel *selectFolderDialog = [NSOpenPanel openPanel];
  
  [selectFolderDialog setCanChooseDirectories:YES];
  [selectFolderDialog setCanChooseFiles:NO];
  [selectFolderDialog setAllowsMultipleSelection:NO];
  
  if([selectFolderDialog runModal] == NSOKButton)
  {
    [_currentPathLabel setStringValue:[[[selectFolderDialog URLs] objectAtIndex:0] path]];
    [_checkPathButton setEnabled:YES];
  }
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
  NSString *title = [[tableColumn headerCell] stringValue];
  
  if([title isEqualToString:@"Type"])
    return [NSString stringWithFormat:@".%@", [_sortedExtensions objectAtIndex:row]];
  else if([title isEqualToString:@"Count"])
    return [_extensions valueForKey:[_sortedExtensions objectAtIndex:row]];
 
  return nil;
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
  return [_extensions count];
}

@end
