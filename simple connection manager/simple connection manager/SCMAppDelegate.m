//
//  SCMAppDelegate.m
//  simple connection manager
//
//  Created by Alexander Kazanskiy on 02.12.12.
//  Copyright (c) 2012 sysadmin.su. All rights reserved.
//

#import "SCMAppDelegate.h"

@implementation SCMAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    
    SCMLeftPanelViewController * leftPanel = [[SCMLeftPanelViewController alloc] initWithNibName:@"SCMLeftPanelViewController" bundle:nil];
    
    SCMRightPanelViewController * rightPanel = [[SCMRightPanelViewController alloc] initWithNibName:@"SCMRightPanelViewController" bundle:nil];
    

    
    [self.LeftPanel addSubview:leftPanel.view];
    [self.RightPanel addSubview:rightPanel.view];
    
}

@end
