//
//  NotesKeeperAppDelegate.h
//  NotesKeeper
//
//  Created by Stan Buran on 11/20/12.
//  Copyright (c) 2012 apoidea. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotesKeeperAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
