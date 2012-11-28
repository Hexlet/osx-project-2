//
//  ECAppDelegate.h
//  Extension checker
//
//  Created by swante on 11/15/12.
//  Copyright (c) 2012 SergeyPershenkov. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ECAppDelegate : NSObject <NSApplicationDelegate, NSTableViewDataSource>
{
  BOOL _isChecking;
  NSMutableDictionary *_extensions;
  NSArray *_sortedExtensions;
}

- (void)countFilesByPath;

@property (weak) IBOutlet NSTextField *currentPathLabel;
@property (weak) IBOutlet NSButton *checkPathButton;
@property (weak) IBOutlet NSButton *selectPathButton;
@property (weak) IBOutlet NSButton *subfoldersBox;
@property (weak) IBOutlet NSButton *caseSensitiveBox;
@property (unsafe_unretained) IBOutlet NSTextView *output;
@property (weak) IBOutlet NSTableView *table;
@property (weak) IBOutlet NSTextField *checkedFilesLabel;

- (IBAction)checkPathClicked:(id)sender;
- (IBAction)selectFolderClicked:(id)sender;

@end
