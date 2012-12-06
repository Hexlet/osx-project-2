//
//  XMetronomeAppDelegate.h
//  XMetronome
//
//  Created by Mykola Makhin on 12/2/12.
//  Copyright (c) 2012 mvmn. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface XMetronomeAppDelegate : NSObject <NSApplicationDelegate, NSMenuDelegate> {
    NSInteger tempo;
    NSInteger timeSignature;
    NSInteger playNotes;
    
}
@property (weak) IBOutlet NSTextField *tempoInputField;
@property (weak) IBOutlet NSPopUpButton *tempoSelectBox;

@property (assign) IBOutlet NSWindow *window;

@end
