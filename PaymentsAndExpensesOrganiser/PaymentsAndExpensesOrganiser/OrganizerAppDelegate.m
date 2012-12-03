//
//  OrganizerAppDelegate.m
//  PaymentsAndExpensesOrganiser
//
//  Created by Eugene on 11/28/12.
//  Copyright (c) 2012 Victorya. All rights reserved.
//

#import "OrganizerAppDelegate.h"

@implementation OrganizerAppDelegate

@synthesize payments = _payments;
@synthesize nearestEvents = _nearestEvents;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    self.payments = [[NSMutableArray alloc]init];
    self.nearestEvents = [[NSMutableArray alloc]init];
}

@end
