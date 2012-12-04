//
//  AppDelegate.m
//  myCar
//
//  Created by Alex Altabaev on 01.12.12.
//  Copyright (c) 2012 Alex Altabaev. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

- (IBAction)changeMilage:(id)sender {
    [_changeMilageButton setTransparent:YES];
    [_changeMilageButton setEnabled: NO];
    
    [_saveMilageButton setTransparent:NO];
    [_saveMilageButton setEnabled: YES];
    [_saveMilageButton highlight: NO];
    
    [_milage setEditable:YES];
    [_milage selectText:self];
    [[_milage currentEditor] setSelectedRange:NSMakeRange([[_milage stringValue] length], 0)]; //focus cursor at text field
}

- (IBAction)saveMilage:(id)sender {
    [_changeMilageButton setTransparent:NO];
    [_changeMilageButton setEnabled: YES];
    [_changeMilageButton highlight: NO];
    
    [_saveMilageButton setTransparent:YES];
    [_saveMilageButton setEnabled: NO];
    
    [_milage setEditable:NO];
    
    [[self window] makeFirstResponder: nil]; //remove focus from text field
}
@end
