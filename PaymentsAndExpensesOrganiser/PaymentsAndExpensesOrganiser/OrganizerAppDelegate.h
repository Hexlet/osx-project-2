//
//  OrganizerAppDelegate.h
//  PaymentsAndExpensesOrganiser
//
//  Created by Eugene on 11/28/12.
//  Copyright (c) 2012 Victorya. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface OrganizerAppDelegate : NSObject <NSApplicationDelegate>{
    NSMutableArray* payments;
}

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTableView *tableView;

@end
