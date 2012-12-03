//
//  OrganizerAppDelegate.h
//  PaymentsAndExpensesOrganiser
//
//  Created by Eugene on 11/28/12.
//  Copyright (c) 2012 Victorya. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface OrganizerAppDelegate : NSObject <NSApplicationDelegate>

@property NSMutableArray* payments;
@property NSMutableArray* nearestEvents;

@property (assign) IBOutlet NSWindow *window;

@end
