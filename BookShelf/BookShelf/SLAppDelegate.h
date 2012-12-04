//
//  SLAppDelegate.h
//  BookShelf
//
//  Created by S.Lebedev on 04.12.12.
//  Copyright (c) 2012 S.Lebedev. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SLAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (IBAction)saveAction:(id)sender;

@end
