//
//  AppDelegate.h
//  osx-project-2
//
//  Created by Kirill Gorshkov on 30.11.12.
//  Copyright (c) 2012 Kirill Gorshkov. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate> {
    NSPasteboard *mainPasteboard;
    NSTimer *timer;
    NSInteger copyCount;
    NSMutableArray *pasteboardContainer;
    BOOL pasteboardSemaphore;
}

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSComboBox *comboBox;

- (void)copy;

- (IBAction)pasteNow:(id)sender;

@end
