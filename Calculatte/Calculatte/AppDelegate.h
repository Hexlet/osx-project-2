//
//  AppDelegate.h
//  Calculatte
//
//  Created by Alex Bakoushin on 02.12.12.
//  Copyright (c) 2012 Alex Bakoushin. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class MainWindowController;

@interface AppDelegate : NSObject <NSApplicationDelegate> {
    NSStatusItem *statusBar;
    MainWindowController *mainWindow;
}

@end
